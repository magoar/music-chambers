import itertools
from datetime import datetime

from z3 import *


def assign(rooms, musicians_groups, person_count, timeslots_count, number_of_rehearsals):
    raw_attributes: set[str] = set()
    for room in rooms:
        raw_attributes.update(room[1])

    # Begin modelling

    solver = Solver()

    # Declare sorts and constants for:
    # Timeslots (simple)

    AttributeSort = DeclareSort("Attribute")
    AttributeSetSort = SetSort(AttributeSort)

    attribute_consts = {}
    for attribute in raw_attributes:
        new_attribute = Const(attribute, AttributeSort)
        for prev_attribute in attribute_consts.values():
            solver.add(new_attribute != prev_attribute)
        attribute_consts[attribute] = new_attribute


    # Declare people
    PersonDatatype = Datatype("Person")
    for person_index in range(person_count):
        PersonDatatype.declare(f"Person {person_index}")
    PersonSort = PersonDatatype.create()
    people = []
    for person_index in range(person_count):
        new_person = Const(f"Person {person_index}", PersonSort)

        # Define person to be distinct from every other previously defined person
        for prev_person in people:
            solver.add(new_person != prev_person)

        people.append(new_person)

    # Declare rooms
    RoomDatatype = Datatype("Room")
    for room_index in range(len(rooms)):
        RoomDatatype.declare(f"room_{room_index}")
    RoomSort = RoomDatatype.create()
    concert_hall_const = None
    rooms_consts = []

    RoomSize = Function("room_size", RoomSort, IntSort())
    RoomAttributes = Function("room_attributes", RoomSort, AttributeSetSort)
    for idx, room in enumerate(rooms):
        new_room = Const(f"Room {idx}", RoomSort)
        rooms_consts.append(new_room)

        # Add room size
        solver.add(RoomSize(new_room) == room[0])

        solver.add(new_room == RoomSort.__getattribute__(f"room_{idx}"))

        # Add room attributes
        room_attributes = EmptySet(AttributeSort)
        for attribute in room[1]:
            room_attributes = SetAdd(room_attributes, attribute_consts[attribute])
        solver.add(RoomAttributes(new_room) == room_attributes)

        if "ConcertHall" in room[1]:
            concert_hall_const = new_room

    GroupSort = DeclareSort("Group")
    GroupSize = Function("group_size", GroupSort, IntSort())
    GroupMembers = Function("group_members", GroupSort, SetSort(PersonSort))
    GroupAttributes = Function("group_attributes", GroupSort, AttributeSetSort)
    no_group_const = Const("No group", GroupSort)
    solver.add(GroupSize(no_group_const) == 0)
    solver.add(GroupAttributes(no_group_const) == EmptySet(AttributeSort))
    solver.add(GroupMembers(no_group_const) == EmptySet(PersonSort))

    groups_consts = []
    for idx, group in enumerate(musicians_groups):
        new_group = Const(f"Group {idx}", GroupSort)

        # Distinct groups
        for prev_group in groups_consts:
            solver.add(new_group != prev_group)

        groups_consts.append(new_group)

        # Group Size
        solver.add(GroupSize(new_group) == len(group[0]))

        # Add group attributes
        group_attributes = EmptySet(AttributeSort)
        for attribute in group[1]:
            group_attributes = SetAdd(group_attributes, attribute_consts[attribute])
        solver.add(GroupAttributes(new_group) == group_attributes)

        # Add group members
        group_members = EmptySet(PersonSort)
        for member in group[0]:
            group_members = SetAdd(group_members, people[member])
        solver.add(GroupMembers(new_group) == group_members)

    GroupSetSort = SetSort(GroupSort)
    setOfGroups = EmptySet(GroupSort)
    for group in groups_consts:
        setOfGroups = SetAdd(setOfGroups, group)


    # Declare Timeslot
    TimeSlotDatatype = Datatype("Timeslot")
    for timeslot_index in range(timeslots_count):
        TimeSlotDatatype.declare(f"Timeslot {timeslot_index}")
    TimeslotSort = TimeSlotDatatype.create()

    timeslots_consts = []
    for timeslot_index in range(timeslots_count):
        new_timeslot = Const(f"Timeslot {timeslot_index}", TimeslotSort)

        # Define timeslot to be distinct from every other previously defined timeslot
        for prev_timeslot in timeslots_consts:
            solver.add(new_timeslot != prev_timeslot)

        timeslots_consts.append(new_timeslot)


    TimeslotSetSort = SetSort(TimeslotSort)
    set_of_timeslots = EmptySet(TimeslotSort)
    for timeslot in timeslots_consts:
        set_of_timeslots = SetAdd(set_of_timeslots, timeslot)

    Timeslot_room_to_group = Function("Timeslot and Room to Group", TimeslotSort, RoomSort, GroupSort)


    # No group can play in two rooms at the same time
    for room_a, room_b in itertools.combinations(rooms_consts, 2):
        for timeslots_const in timeslots_consts:
            # A group does not play twice at the same time
            solver.add(Implies(
                Timeslot_room_to_group(timeslots_const, room_a) == Timeslot_room_to_group(timeslots_const, room_b),
                Timeslot_room_to_group(timeslots_const, room_a) == no_group_const
            ))

    # Any assigned group must exist or be the NoGroup
    for timeslots_const in timeslots_consts:
        allowed_results_set = SetAdd(setOfGroups, no_group_const)
        for room_const in rooms_consts:
            result = Timeslot_room_to_group(timeslots_const, room_const)
            result_set = SetAdd(EmptySet(GroupSort), result)
            solver.add(SetIntersect(allowed_results_set, result_set) != EmptySet(GroupSort))


    # for time slot t, every group size is smaller than it's room size
    for timeslots_const in timeslots_consts:
        for room_const in rooms_consts:
            result = Timeslot_room_to_group(timeslots_const, room_const)
            solver.add(GroupSize(result) <= RoomSize(room_const))


    # for time slot t, every room has at least all attributes of the assigned group
    for timeslots_const in timeslots_consts:
        for room_const in rooms_consts:
            result = Timeslot_room_to_group(timeslots_const, room_const)
            solver.add(
                SetDifference(GroupAttributes(result), RoomAttributes(room_const)) == EmptySet(AttributeSort)
            )

    # for time slot t, each group should be pairwise distinct
    GroupOverlaps = Function("GroupOverlaps", GroupSort, GroupSort, BoolSort())
    for group_a, group_b in itertools.combinations(groups_consts, 2):
        # Tell Z3 which groups overlap
        solver.add(Implies(
            SetIntersect(GroupMembers(group_a), GroupMembers(group_b)) != EmptySet(PersonSort),
            And(GroupOverlaps(group_a, group_b), GroupOverlaps(group_b, group_a))
        ))

    for room_a, room_b in itertools.combinations(rooms_consts, 2):
        for timeslots_const in timeslots_consts:
            # No two groups playing at the same time have overlap in people
            solver.add(Not(
                GroupOverlaps(
                    Timeslot_room_to_group(timeslots_const, room_a),
                    Timeslot_room_to_group(timeslots_const, room_b)
                )
            ))

    # each group is assigned at least `number of rehearsals` times
    for group_idx, group_const in enumerate(groups_consts):
        time_slots_for_group = []
        # There are `number of rehearsals` pairs of time/place where a group plays
        for session_idx in range(number_of_rehearsals):
            time_slot_placeholder = Const(f"Session {session_idx} for group {group_idx} timeslot", TimeslotSort)
            room_placeholder = Const(f"Session {session_idx} for group {group_idx} room", RoomSort)
            time_slots_for_group.append(time_slot_placeholder)

            solver.add(Timeslot_room_to_group(time_slot_placeholder, room_placeholder) == group_const)

        # And all of these pairs happen at a different time
        for time_slot_a, time_slot_b in itertools.combinations(time_slots_for_group, 2):
            solver.add(time_slot_a != time_slot_b)


    # over all time slots, each group is assigned to the concert hall at least once
    for idx, group_const in enumerate(groups_consts):
        time_slot_placeholder = Const(f"timeslot for main hall group {idx}", TimeslotSort)
        set_of_placeholder = EmptySet(TimeslotSort)
        set_of_placeholder = SetAdd(set_of_placeholder, time_slot_placeholder)
        solver.add(
            Exists(
                time_slot_placeholder,
                And(
                    Timeslot_room_to_group(time_slot_placeholder, concert_hall_const) == group_const,
                    SetIntersect(set_of_placeholder, set_of_timeslots) != EmptySet(TimeslotSort)
                )
            )
        )

        return solver, groups_consts, timeslots_consts, rooms_consts


def extract_assignments(
        solver: Solver,
        group_consts: list,
        timeslots_consts: list,
        rooms_consts: list,
    ):
    main_data_list = []
    model = solver.model()
    for thing in model:
        if thing.name() == "Timeslot and Room to Group":
            for line in model.get_interp(thing).as_list():
                main_data_list.append(line)


    main_data_list = main_data_list[:-1]  # Drop default group

    group_mapping = [model.get_interp(group_const) for group_const in group_consts]
    for item in main_data_list:
        item[2] = group_mapping.index(item[2])

    room_mapping = [model.get_interp(room_const) for room_const in rooms_consts]
    for item in main_data_list:
        item[1] = room_mapping.index(item[1])

    timeslot_mapping = [model.get_interp(timeslot_const) for timeslot_const in timeslots_consts]
    for item in main_data_list:
        item[0] = timeslot_mapping.index(item[0])
    return main_data_list


def solve_and_extract(rooms, musicians_groups, person_count, timeslots_count, number_of_rehearsals):
    solver, group_consts, timeslots_consts, rooms_consts = assign(
        rooms,
        musicians_groups,
        person_count,
        timeslots_count,
        number_of_rehearsals
    )
    if solver.check() == sat:
        return extract_assignments(solver, group_consts, timeslots_consts, rooms_consts)
    else:
        return []


if __name__ == "__main__":
    person_count_example = 20
    timeslots_count_example = 5
    number_of_rehearsals_example = 3

    rooms_example = [
        (20, ["ConcertHall", "Drumkit", "Piano", "Accessible"]),
        (5, ["Piano"]),
        (5, ["Drumkit"]),
        (3, ["Accessible"]),
        (3, ["Piano"]),
        (1, []),
        (2, []),
        (3, []),
        (4, []),
        (5, []),
        (6, []),
        (7, []),
        (8, []),
        (9, []),
    ]


    musicians_groups_example = [
        ((0, 1, 2), ["Accessible"]),
        # ((1, 2, 3), ["Accessible"]),
        # ((2, 3, 4), ["Piano", "Accessible"]),
        ((3, 4, 5), ["Piano"]),
        # ((4, 5, 6), ["Piano"]),
        # ((5, 6, 7), ["Piano"]),
        # ((6, 7, 8), ["Piano"]),
        # ((7, 8, 9), ["Piano"]),
        # ((8, 9, 10), []),
        # ((9, 10, 11), []),
        # ((0, 1, 2, 3, 4), ["Piano", "Accessible"]),
        # ((5, 6, 7, 8, 9), ["Piano"]),
        # ((10, 11, 12, 13, 14, 15), []),
        # ((15, 16, 17, 18, 19), []),
    ]

    solver, group_consts, timeslots_consts, rooms_consts = assign(
        rooms_example,
        musicians_groups_example,
        person_count_example,
        timeslots_count_example,
        number_of_rehearsals_example
    )

    print(datetime.now())
    assert solver.check() == sat
    print(datetime.now())

    model = solver.model()
    for thing in model:
        if thing.name() != "Timeslot and Room to Group":
            print(f"{thing} = {model.get_interp(thing)}")
        else:
            print(f"{thing} =")
            for line in model.get_interp(thing).as_list():
                print(f"{line}")

    print()
    print()
    print()
    assignments = extract_assignments(solver, group_consts, timeslots_consts, rooms_consts)
    print(assignments)
