require 'json'

class RehearsalsController < ApplicationController
  def create
    # I already have access to @festival here, so I need to get...

    schedule_constraints = {
      "person_count" => @festival.musicians.count,
      "rooms_count" => @festival.rooms.count,
      "timeslots_count" => (@festival.slots_per_day * ((@festival.end_date - @festival.start_date).to_i + 1)),
      "number_of_rehearsals" => ,
      "rooms" => [

      ],
      "musicians_group" => [

      ]
    }

    # GET the number of Musicians

    # GET the number of Rooms

    # GET the number of timeslots

    # GET the number of rehearsals

    # GET each room with:
    # [SIZE, ["attr1", "attr2"]]

    # GET each group with:
    # [[musician_id, musician_id, musician_id], ["attr1", "attr2"]]

    # OUTPUT to Json
    timestamp = Time.now.to_i
    filepath = "/lib/assets/python/#{timestamp}#{current_user.id}.json"
    python_json = { beatles: [
      {
        first_name: "John",
        last_name: "Lennon",
        instrument: "Guitar"
      },
      {
        first_name: "Paul",
        last_name: "McCartney",
        instrument: "Bass Guitar"
      },
      # etc...
    ]}

    File.open(filepath, "wb") do |file|
      file.write(JSON.generate(python_json))
    end

    # Call Mr. Python and assign him to a var

    # If var = solved -> Read the p2r that was generated
    # If var = unsolveable -> give user the bad news

    # Read the p2r.json and populate the rehearsals



    serialized_beatles = File.read(filepath)

    beatles = JSON.parse(serialized_beatles)

    # Delete the json file (also via backticks probably)

    # Andria does her frontend magic display

  end
end
