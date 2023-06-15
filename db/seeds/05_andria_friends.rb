require 'date'

p "creating Andria & Friends festival"
Festival.create(
name: "Andria & Friends",
user: User.find_by(email: "max@web.de"),
location: "Los Angeles",
start_date: Date.parse('01-07-2023'),
end_date: Date.parse('05-07-2023'),
rehearsals_per_group: 4
)

p "Create Timeslots for Andria & Friends"
festival_start_date = Festival.find_by(name: "Andria & Friends").start_date
year = festival_start_date.year
month = festival_start_date.month
day = festival_start_date.day

Timeslot.create(
  festival: Festival.find_by(name: "Andria & Friends"),
  start_time: Time.utc(year, month, day, 11, 30, 0),
  end_time: Time.utc(year, month, day, 13, 0, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Andria & Friends"),
  start_time: Time.utc(year, month, day, 15, 0, 0),
  end_time: Time.utc(year, month, day, 16, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Andria & Friends"),
  start_time: Time.utc(year, month, day, 16, 30, 0),
  end_time: Time.utc(year, month, day, 18,0, 0)
)
p "Last Timeslot valid: #{Timeslot.last.valid?}"

p "creating 4 Rooms for Andria & Friends"
Room.create(
  name: "Pumba",
  size: 4,
  festival: Festival.find_by(name: "Andria & Friends")
)
Room.create(
  name: "Simba",
  size: 6,
  festival: Festival.find_by(name: "Andria & Friends")
)
Room.create(
  name: "Nala",
  size: 5,
  festival: Festival.find_by(name: "Andria & Friends")
)
Room.create(
  name: "Timon",
  size: 3,
  festival: Festival.find_by(name: "Andria & Friends")
)
Room.create(
  name: "Hall",
  size: 8,
  festival: Festival.find_by(name: "Andria & Friends")
)

p "giving the rooms requirements"
RoomRequirement.create(
  room: Room.find_by(name: "Pumba"),
  requirement: Requirement.find_by(name: "piano")
)
RoomRequirement.create(
  room: Room.find_by(name: "Simba"),
  requirement: Requirement.find_by(name: "wheelchair")
)
RoomRequirement.create(
  room: Room.find_by(name: "Nala"),
  requirement: Requirement.find_by(name: "piano")

)
RoomRequirement.create(
  room: Room.find_by(name: "Hall"),
  requirement: Requirement.find_by(name: "piano")
)
p "creating 5 Musicians"
Musician.create(
  name: "Andria",
  instrument: "Violin",
  festival: Festival.find_by(name: "Andria & Friends")
)
Musician.create(
  name: "Anna",
  instrument: "Violin",
  festival: Festival.find_by(name: "Andria & Friends")
)
Musician.create(
  name: "Bob",
  instrument: "Viola",
  festival: Festival.find_by(name: "Andria & Friends")
)
Musician.create(
  name: "Camilo",
  instrument: "Cello",
  festival: Festival.find_by(name: "Andria & Friends")
)
Musician.create(
  name: "Maria",
  instrument: "Piano",
  festival: Festival.find_by(name: "Andria & Friends")
)

p "assigning some attributes to the musicians"
MusicianRequirement.create(
  musician: Musician.find_by(name: "Maria"),
  requirement: Requirement.find_by(name: "Piano")
)


p "making groups for the musicians"
    group1 = Group.create(
      name: "Beethoven Trio",
      festival: Festival.find_by(name: "Andria & Friends")
    )
        Member.create(
          group: group1,
          musician: Musician.find_by(name: "Andria")
        )
        Member.create(
          group: group1,
          musician: Musician.find_by(name: "Camilo")
        )
        Member.create(
          group: group1,
          musician: Musician.find_by(name: "Maria")
        )
    group2 = Group.create(
      name: "Ravel Duo",
      festival: Festival.find_by(name: "Andria & Friends")
    )
        Member.create(
          group: group2,
          musician: Musician.find_by(name: "Anna")
        )
        Member.create(
          group: group2,
          musician: Musician.find_by(name: "Camilo")
        )
    group3 = Group.create(
      name: "Handel Halvorson",
      festival: Festival.find_by(name: "Andria & Friends")
    )
        Member.create(
          group: group3,
          musician: Musician.find_by(name: "Anna")
        )
        Member.create(
          group: group3,
          musician: Musician.find_by(name: "Bob")
        )
    group4 = Group.create(
      name: "Schumann 5tet",
      festival: Festival.find_by(name: "Andria & Friends")
    )
        Member.create(
          group: group4,
          musician: Musician.find_by(name: "Andria")
        )
        Member.create(
          group: group4,
          musician: Musician.find_by(name: "Anna")
        )
        Member.create(
          group: group4,
          musician: Musician.find_by(name: "Bob")
        )
        Member.create(
          group: group4,
          musician: Musician.find_by(name: "Camilo")
        )
        Member.create(
          group: group4,
          musician: Musician.find_by(name: "Maria")
        )
