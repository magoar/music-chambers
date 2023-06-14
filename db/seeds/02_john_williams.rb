require 'date'

p "Creating the John Williams Festival"
Festival.create(
  name: "John Williams revisited",
  user: User.find_by(email: "max@web.de"),
  location: "Berlin",
  start_date: Date.parse('01-12-2023'),
  end_date: Date.parse('06-12-2023'),
  rehearsals_per_group: 3
)
p Festival.last.valid?

p "Create Timeslots for John Williams"
festival_start_date = Festival.find_by(name: "John Williams revisited").start_date
year = festival_start_date.year
month = festival_start_date.month
day = festival_start_date.day
Timeslot.create(
  festival: Festival.find_by(name: "John Williams revisited"),
  start_time: Time.utc(year, month, day, 8, 0, 0),
  end_time: Time.utc(year, month, day, 9, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "John Williams revisited"),
  start_time: Time.utc(year, month, day, 10, 0, 0),
  end_time: Time.utc(year, month, day, 11, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "John Williams revisited"),
  start_time: Time.utc(year, month, day, 13, 0, 0),
  end_time: Time.utc(year, month, day, 14, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "John Williams revisited"),
  start_time: Time.utc(year, month, day, 15, 0, 0),
  end_time: Time.utc(year, month, day, 16, 30, 0)
)
p "Last Timeslot valid: #{Timeslot.last.valid?}"

# Create 10 Rooms for John Williams
p "Creating 10 Rooms"
10.times do
  Room.create(
    name: Faker::Movies::StarWars.unique.planet,
    size: rand(3..8),
    festival: Festival.find_by(name: "John Williams revisited")
  )
end
p Room.last.valid?

# Giving some rooms pianos and wheelchair access
p "Some Rooms have pianos and wheelchair access..."
Room.first(5).each do |n|
  RoomRequirement.create(
    room: n,
    requirement: Requirement.find_by(name: "piano")
  )
end
RoomRequirement.create(
  room: Room.first,
  requirement: Requirement.find_by(name: "wheelchair")
)
RoomRequirement.create(
  room: Room.last,
  requirement: Requirement.find_by(name: "wheelchair")
)
p RoomRequirement.last.valid?


p "Creating 20 Musicians for Festival 1"
Musician.create(
  name: Faker::Movies::StarWars.unique.character,
  instrument: "guitar",
  festival: Festival.find_by(name: "John Williams revisited")
)
2.times do
  Musician.create(
    name: Faker::Movies::StarWars.unique.character,
    instrument: "piano",
    festival: Festival.find_by(name: "John Williams revisited")
  )
end
17.times do
  Musician.create(
    name: Faker::Movies::StarWars.unique.character,
    instrument: Faker::Music.instrument,
    festival: Festival.find_by(name: "John Williams revisited")
  )
end
p Musician.last.valid?


p "Some Musicians need wheelchairs and/or pianos"
musicians_with_needs = Musician.where(instrument: "piano")
musicians_with_needs.each do |n|
  MusicianRequirement.create(
    musician: n,
    requirement: Requirement.find_by(name: "piano")
  )
end
MusicianRequirement.create(
  musician: musicians_with_needs.last,
  requirement: Requirement.find_by(name: "wheelchair")
)
MusicianRequirement.create(
  musician: Musician.find_by(instrument: "guitar"),
  requirement: Requirement.find_by(name: "wheelchair")
)
p MusicianRequirement.last.valid?


p "Creating 10 Groups for Festival 1"
10.times do
  Group.create(
    name: Faker::Music::RockBand.unique.name,
    festival: Festival.find_by(name: "John Williams revisited")
  )
end
p Group.last.valid?


p "Assigning each musician some groups"
2.times do
  Musician.all.each do |n|
    valid_groups = Group.all.reject { |group| group.musicians.include?(n) }
    group_to_assign = valid_groups.first
    valid_groups.each do |g|
      group_to_assign = g if group_to_assign.musicians.count == 8
    end

    valid_groups.shuffle.each do |g|
      group_to_assign = g if g.musicians.count < 3
    end
    group_to_assign = Group.find_by(id: group_to_assign[:id])

    Member.create(
      group: group_to_assign,
      musician: n
    )
  end
end

p "Printing all the Groups  with name and size"
Group.all.each do |n|
  p "name:"
  p n.name
  p "size:"
  p n.musicians.count
end
p Member.last.valid?

p "Printing which members are in each group"
Group.all.each do |n|
  p "The Group #{n.name} has the following members:"
  n.musicians.each do |m|
    p m.name
  end
end

p "Creating Rehearsals for John Williams"
start_date = Festival.find_by(name: "John Williams revisited").start_date
end_date = Festival.find_by(name: "John Williams revisited").end_date
(start_date..end_date).each do |date|
  Festival.find_by(name: "John Williams revisited").timeslots.each do |timeslot|
    Rehearsal.create(
      festival: Festival.find_by(name: "John Williams revisited"),
      room: Festival.find_by(name: "John Williams revisited").rooms.sample,
      group: Festival.find_by(name: "John Williams revisited").groups.sample,
      rehearsal_date: date,
      start_time: timeslot.start_time
    )
  end
end
p "Last Rehearsal valid: #{Rehearsal.last.valid?}"
