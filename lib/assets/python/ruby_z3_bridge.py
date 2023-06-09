import sys
import json
from datetime import datetime
from z3 import *
from room_assignments import assign, extract_assignments, solve_and_extract

# we get our json argument, e.g.
# testing_data = """{"person_count": 20, "timeslots_count": 48, "number_of_rehearsals": 3, "rooms": [[3, ["piano", "wheelchair"]], [5, ["piano"]], [6, ["piano"]], [5, ["piano"]], [4, ["piano"]], [3, []], [4, []], [8, []], [5, []], [4, ["wheelchair"]]], "musicians_groups": [[[7, 11, 12, 13, 14, 15, 16, 18], []], [[9, 10, 16, 17, 18, 19, 20], []], [[8, 11, 17, 19], []], [[1, 3, 5], ["piano", "wheelchair"]], [[4, 6, 9], []], [[2, 5, 14], ["piano"]], [[3, 4, 7], ["piano", "wheelchair"]], [[8, 15, 20], []], [[10, 12, 13], []], [[1, 2, 6], ["piano", "wheelchair"]]]}"""
json_input = sys.argv[1]

z3_parameters = json.loads(json_input)
# z3_parameters is a Dictionary and has the following keys:
# "rooms"
# "musicians_groups"
# "timeslots_count"
# "person_count"
# "number_of_rehearsals"

rooms = z3_parameters["rooms"]
musicians_groups = z3_parameters["musicians_groups"]
person_count = z3_parameters["person_count"]
timeslots_count = z3_parameters["timeslots_count"]
number_of_rehearsals = z3_parameters["number_of_rehearsals"]

# uncomment for testing if z3_parameters is filled correctly
# print("rooms: ")
# print(rooms)
# print("musicians groups: ")
# print(musicians_groups)
# print("person count: ")
# print(person_count)
# print("number of timeslots: ")
# print(timeslots_count)
# print("number of rehearsals: ")
# print(number_of_rehearsals)

# print("START-TIME:")
# print(datetime.now())
schedule = solve_and_extract(rooms, musicians_groups, person_count, timeslots_count, number_of_rehearsals)
# print("FINISH-TIME:")
# print(datetime.now())

# schedule is a list[tuple(int1, int2, int3), etc...]
# int1 = Timeslot index
# int2 = Room index
# int3 = Group index

python_return_string = json.dumps(schedule)
print(python_return_string)
