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
    rooms_count = @festival.rooms.count
    timeslots_count = (@festival.slots_per_day * ((@festival.end_date - @festival.start_date).to_i + 1))
    number_of_rehearsals = @festival.rehearsals_per_group
    attributes = Requirement.all.map(&:name)
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

    schedule_constraints = {
      "person_count" => person_count,
      "rooms_count" => rooms_count,
      "timeslots_count" => timeslots_count,
      "number_of_rehearsals" => number_of_rehearsals,
      "attributes" => attributes,
      "rooms" => rooms_array,
      "musicians_groups" => musicians_groups
    }

    @connection_test = `python3 /lib/assets/python/z3_python_object.py "test"`

    # timestamp = Time.now.to_i
    # filepath = "/lib/assets/python/#{timestamp}#{current_user.id}"
    # filepath = Rails.root.join('lib', 'assets', 'python', 'test.json')
    # File.write(filepath, JSON.generate(schedule_constraints))
    # raise
    # # Call Mr. Python and assign him to a var
    # scheduling_slots = `python3 lib/assets/python/z3_python_object.py "#{print argument}"`
    # raise
    # p scheduling_slots
    # p scheduling_slots.type

    # If var = solved -> Read the p2r that was generated
    # If var = unsolveable -> give user the bad news

    # Read the p2r.json and populate the rehearsals

    # Delete the json file (also via backticks probably)



    # OUTPUT to Json

    # python_json = { beatles: [
    #   {
    #     first_name: "John",
    #     last_name: "Lennon",
    #     instrument: "Guitar"
    #   },
    #   {
    #     first_name: "Paul",
    #     last_name: "McCartney",
    #     instrument: "Bass Guitar"
    #   },
    #   # etc...
    # ]}
    #
    # serialized_beatles = File.read(filepath)
    # beatles = JSON.parse(serialized_beatles)
  end
end
