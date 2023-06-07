require 'date'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a User
p "creating max@web.de pw: 'whatever'"
User.create(
  email: "max@web.de",
  password: "whatever"
)
p User.last.valid?

# Create Requirements
p "Creating Piano and Wheelchair Requirements"
Requirement.create(name: "piano")
Requirement.create(name: "wheelchair")
p Requirement.last.valid?

# Create 2 Festivals
p "Creating 2 Festivals"
Festival.create(
  name: "John Williams revisited",
  user: User.find_by(email: "max@web.de"),
  location: "Berlin",
  start_date: Date.parse('01-12-2023'),
  end_date: Date.parse('12-12-2023'),
  slots_per_day: 4
)
Festival.create(
  name: "Violent Violins 2018",
  user: User.find_by(email: "max@web.de"),
  location: "Venezia",
  start_date: Date.parse('01-12-2018'),
  end_date: Date.parse('12-12-2023'),
  slots_per_day: 3
)
p Festival.last.valid?

# Create 10 Rooms for Festival 1
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

# Create 20 Musicians for Festival 1
p "Creating 20 Musicians"
20.times do
  Musician.create(
    name: Faker::Movies::StarWars.unique.character,
    instrument: "lightsaber",
    festival: Festival.first
  )
end
p Musician.last.valid?

# Adding Needs Piano wheelchair to some Musicians
p "Some Musicians need wheelchairs and/or pianos"
musicians_with_needs = Musician.all.sample(5)
musicians_with_needs.first(4).each do |n|
  MusicianRequirement.create(
    musician: n,
    requirement: Requirement.find_by(name: "piano")
  )
end
musicians_with_needs.last(2).each do |n|
  MusicianRequirement.create(
    musician: n,
    requirement: Requirement.find_by(name: "wheelchair")
  )
end
p MusicianRequirement.all[3].valid?

# Create 10 groups for Festival 1
p "Creating 10 Groups"
10.times do
  Group.create(
    name: Faker::Movies::StarWars.unique.vehicle,
    festival: Festival.find_by(name: "John Williams revisited")
  )
end
p Group.last.valid?

# Populate the groups with Musicians
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
Group.all.each do |n|
  p "name:"
  p n.name
  p "size:"
  p n.musicians.count
end
p Member.last.valid?

Group.all.each do |n|
  p "The Group #{n.name} has the following members:"
  n.musicians.each do |m|
    p m.name
  end
end
