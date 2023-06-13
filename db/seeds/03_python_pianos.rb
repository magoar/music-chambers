require 'date'

p "creating the testing festival"
Festival.create(
name: "Python Pianos",
user: User.find_by(email: "max@web.de"),
location: "Venezia",
start_date: Date.parse('01-12-2018'),
end_date: Date.parse('02-12-2018'),
slots_per_day: 4,
rehearsals_per_group: 2
)

p "Create Timeslots for Python Picolo"
festival_start_date = Festival.find_by(name: "Python Pianos").start_date
year = festival_start_date.year
month = festival_start_date.month
day = festival_start_date.day
Timeslot.create(
  festival: Festival.find_by(name: "Python Pianos"),
  start_time: Time.utc(year, month, day, 8, 0, 0),
  end_time: Time.utc(year, month, day, 9, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Python Pianos"),
  start_time: Time.utc(year, month, day, 10, 0, 0),
  end_time: Time.utc(year, month, day, 11, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Python Pianos"),
  start_time: Time.utc(year, month, day, 13, 0, 0),
  end_time: Time.utc(year, month, day, 14, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Python Pianos"),
  start_time: Time.utc(year, month, day, 15, 0, 0),
  end_time: Time.utc(year, month, day, 16, 30, 0)
)
p "Last Timeslot valid: #{Timeslot.last.valid?}"

p "creating 2 Rooms for Festival 2"
Room.create(
  name: "Testroom 1",
  size: 3,
  festival: Festival.find_by(name: "Python Pianos")
)
Room.create(
  name: "Testroom 2",
  size: 3,
  festival: Festival.find_by(name: "Python Pianos")
)

p "giving the rooms requirements"
RoomRequirement.create(
  room: Room.find_by(name: "Testroom 1"),
  requirement: Requirement.find_by(name: "wheelchair")
)
RoomRequirement.create(
  room: Room.find_by(name: "Testroom 2"),
  requirement: Requirement.find_by(name: "piano")
)

p "creating 4 Musicians"
Musician.create(
  name: "Jan",
  instrument: "vocals",
  festival: Festival.find_by(name: "Python Pianos")
)
Musician.create(
  name: "Bob",
  instrument: "trumpet",
  festival: Festival.find_by(name: "Python Pianos")
)
Musician.create(
  name: "Andria",
  instrument: "violin",
  festival: Festival.find_by(name: "Python Pianos")
)
Musician.create(
  name: "Mago",
  instrument: "piano",
  festival: Festival.find_by(name: "Python Pianos")
)

p "assigning some attributes to the musicians"
MusicianRequirement.create(
  musician: Musician.find_by(name: "Jan"),
  requirement: Requirement.find_by(name: "wheelchair")
)
MusicianRequirement.create(
  musician: Musician.find_by(name: "Mago"),
  requirement: Requirement.find_by(name: "piano")
)

p "making groups for the musicians"
    group1 = Group.create(
      name: "Bob_Jan",
      festival: Festival.find_by(name: "Python Pianos")
    )
        Member.create(
          group: group1,
          musician: Musician.find_by(name: "Bob")
        )
        Member.create(
          group: group1,
          musician: Musician.find_by(name: "Jan")
        )
    group2 = Group.create(
      name: "Bob_Mago",
      festival: Festival.find_by(name: "Python Pianos")
    )
        Member.create(
          group: group2,
          musician: Musician.find_by(name: "Bob")
        )
        Member.create(
          group: group2,
          musician: Musician.find_by(name: "Mago")
        )
    group3 = Group.create(
      name: "Andria_Mago",
      festival: Festival.find_by(name: "Python Pianos")
    )
        Member.create(
          group: group3,
          musician: Musician.find_by(name: "Andria")
        )
        Member.create(
          group: group3,
          musician: Musician.find_by(name: "Mago")
        )
    group4 = Group.create(
      name: "Andria_Jan",
      festival: Festival.find_by(name: "Python Pianos")
    )
        Member.create(
          group: group4,
          musician: Musician.find_by(name: "Andria")
        )
        Member.create(
          group: group4,
          musician: Musician.find_by(name: "Jan")
        )
