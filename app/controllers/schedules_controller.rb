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
    musicians_groups = @festival.groups.map do |group|
      [group.musicians.map(&:id), group.requirements.map(&:name)]
    end

    # I can probably get rid of these:
    # rooms_count = @festival.rooms.count
    # attributes = Requirement.all.map(&:name)

    schedule_constraints = {
      "rooms" => rooms_array,
      "musicians_groups" => musicians_groups,
      "person_count" => person_count,
      "timeslots_count" => timeslots_count,
      "number_of_rehearsals" => number_of_rehearsals
    }

    argument = JSON.generate(schedule_constraints)
    # Maybe we will need Rails.root to set the correct rootpath on heroku
    python_return = `python3 lib/assets/python/ruby_z3_bridge.py '#{argument}'`
    @connection_test = python_return

    # timestamp = Time.now.to_i
    # filepath = "/lib/assets/python/#{timestamp}#{current_user.id}"
    # filepath = Rails.root.join('lib', 'assets', 'python', 'test.json')
    # File.write(filepath, JSON.generate(schedule_constraints))
    # raise
    # # Call Mr. Python and assign him to a var


    # If var = solved -> Read the p2r that was generated
    # If var = unsolveable -> give user the bad news

    # Read the return and populate the rehearsals

  end
end
