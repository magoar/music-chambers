require 'json'
require 'date'

class SchedulesController < ApplicationController
  layout "workspace"
  def index
    @festival = Festival.find(params[:festival_id])
    @columns = (@festival.start_date..@festival.end_date).to_a
    @columns.prepend("The Times")
    @rows = @festival.timeslots
    colors = ["bg-orange", "bg-red", "bg-green", "bg-darkgreen", "bg-yellow", "bg-pink", "bg-purple", "bg-darkblue", "bg-sky", "bg-lila"]
    group_names = @festival.groups.map(&:name)
    @group_colors = group_names.zip(colors).to_h
    

  end

  def new
    @festival = Festival.find(params[:festival_id])
    schedule_constraints = generate_schedule_constraints(@festival)
    argument = JSON.generate(schedule_constraints)
    # Maybe we will need Rails.root to set the correct rootpath on heroku
    python_return = `python3 lib/assets/python/ruby_z3_bridge.py '#{argument}'`
    schedule_solution = JSON.parse(python_return)

    if schedule_solution == []
      @connection_test = "Sorry, there isn't a conflict free schedule. Try again with less rehearsals"
    else
      @connection_test = schedule_solution.class # For testing
      make_rehearsals_from_solution(schedule_solution, @festival)
      @connection_test = @festival.rehearsals.map do |n|
        [n.id, n.room.id, n.group.id]
      end
    end
    raise
  end
  private

  def generate_schedule_constraints(festival)
    person_count = festival.musicians.count
    timeslots_count = (festival.slots_per_day * ((festival.end_date - festival.start_date).to_i + 1))
    number_of_rehearsals = festival.rehearsals_per_group
    # the rooms must be generated as an array of arrays:
    # the first element of each array is the size of the group as an integer
    # the second element is an array of it's requirements as strings
    rooms_array = festival.rooms.map do |room|
      [room.size, room.requirements.map(&:name)]
    end
    # the groups must be generated as an array of arrays:
    # the first element of each array is an array of the id of each musician
    # the second element of each array is an array of the attributes of each group
    groups = festival.groups
    musicians = festival.musicians
    musicians_groups = groups.map do |group|
      [
        group.musicians.map do |musician|
          musicians.index(musician)
        end,
        group.requirements.map(&:name)
      ]
    end

    schedule_constraints = {
      "rooms" => rooms_array,
      "musicians_groups" => musicians_groups,
      "person_count" => person_count,
      "timeslots_count" => timeslots_count,
      "number_of_rehearsals" => number_of_rehearsals
    }
    return schedule_constraints
  end

  def make_rehearsals_from_solution(solution, festival)
    festival.rehearsals.each(&:destroy)
    # solution is an array[tuple(int0, int1, int2), etc...]
    # int0 = Timeslot index
    # int1 = Room index
    # int2 = Group index
    rooms = festival.rooms
    groups = festival.groups
    date_range = (festival.start_date..festival.end_date).to_a
    solution.each do |tuple|
      new_rehearsal = Rehearsal.new(
        festival_id: festival.id,
        room: rooms[tuple[1]],
        group: groups[tuple[2]],
        rehearsal_date: date_range[tuple[0] / festival.timeslots.count],
        start_time: festival.timeslots[tuple[0] % festival.timeslots.count].start_time
      )
      unless festival.rehearsals.where(group: new_rehearsal.group).count == festival.rehearsals_per_group
        new_rehearsal.save
      end
    end
    # Cleaning up additional slots
  end
end

# the big testthing
# python3 lib/assets/python/ruby_z3_bridge.py "{\"rooms\":[[4,[\"piano\",\"wheelchair\"]],[5,[\"piano\"]],[3,[\"piano\"]],[8,[\"piano\"]],[6,[\"piano\"]],[6,[]],[7,[]],[6,[]],[4,[]],[8,[\"wheelchair\"]]],\"musicians_groups\":[[[4,6,10,11,12,13,14,15],[]],[[0,2,9,12,16,17,18,19],[\"piano\",\"wheelchair\"]],[[1,5,7],[\"piano\"]],[[7,11,15],[]],[[0,6,16],[\"wheelchair\"]],[[3,8,9],[]],[[3,10,18],[]],[[1,4,8],[\"piano\"]],[[2,5,17],[\"piano\",\"wheelchair\"]],[[13,14,19],[]]],\"person_count\":20,\"timeslots_count\":24,\"number_of_rehearsals\":3}"
# the smol testthing
# python3 lib/assets/python/ruby_z3_bridge.py "{\"rooms\":[[3,[\"wheelchair\"]],[3,[\"piano\"]]],\"musicians_groups\":[[[0,1],[\"wheelchair\"]],[[1,3],[\"piano\"]],[[2,3],[\"piano\"]],[[0,2],[\"wheelchair\"]]],\"person_count\":4,\"timeslots_count\":8,\"number_of_rehearsals\":2}"
