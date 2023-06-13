require 'json'

class SchedulesController < ApplicationController
  layout "workspace"
  def index
    @festival = Festival.find(params[:festival_id])
  end

  def new
    @festival = Festival.find(params[:festival_id])
    # Here all the information that need to go into the json are put together:
    person_count = @festival.musicians.count
    timeslots_count = (@festival.slots_per_day * ((@festival.end_date - @festival.start_date).to_i + 1))
    number_of_rehearsals = @festival.rehearsals_per_group
    # the rooms must be generated as an array of arrays:
    # the first element of each array is the size of the group as an integer
    # the second element is an array of it's requirements as strings
    rooms_array = @festival.rooms.map do |room|
      [room.size, room.requirements.map(&:name)]
    end
    # the groups must be generated as an array of arrays:
    # the first element of each array is an array of the id of each musician
    # the second element of each array is an array of the attributes of each group
    groups = @festival.groups
    musicians = @festival.musicians
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

    argument = JSON.generate(schedule_constraints)
    raise
    # Maybe we will need Rails.root to set the correct rootpath on heroku
    python_return = `python3 lib/assets/python/ruby_z3_bridge.py '#{argument}'`
    @connection_test = python_return

    if python_return == []
      @connection_test = "Sorry there isn't a conflict free schedule :/"
    else
      @connection_test = python_return
    end

    # Ok, so to interpret the return correctly:
    # schedule is a list[tuple(int1, int2, int3), etc...]
    # int1 = Timeslot index
    # int2 = Room index
    # int3 = Group index


  end
end

# the big testthing
# python3 lib/assets/python/ruby_z3_bridge.py "{\"rooms\":[[4,[\"piano\",\"wheelchair\"]],[5,[\"piano\"]],[3,[\"piano\"]],[8,[\"piano\"]],[6,[\"piano\"]],[6,[]],[7,[]],[6,[]],[4,[]],[8,[\"wheelchair\"]]],\"musicians_groups\":[[[4,6,10,11,12,13,14,15],[]],[[0,2,9,12,16,17,18,19],[\"piano\",\"wheelchair\"]],[[1,5,7],[\"piano\"]],[[7,11,15],[]],[[0,6,16],[\"wheelchair\"]],[[3,8,9],[]],[[3,10,18],[]],[[1,4,8],[\"piano\"]],[[2,5,17],[\"piano\",\"wheelchair\"]],[[13,14,19],[]]],\"person_count\":20,\"timeslots_count\":24,\"number_of_rehearsals\":3}"
# the smol testthing
# python3 lib/assets/python/ruby_z3_bridge.py "{\"rooms\":[[3,[\"wheelchair\"]],[3,[\"piano\"]]],\"musicians_groups\":[[[0,1],[\"wheelchair\"]],[[1,3],[\"piano\"]],[[2,3],[\"piano\"]],[[0,2],[\"wheelchair\"]]],\"person_count\":4,\"timeslots_count\":8,\"number_of_rehearsals\":2}"
