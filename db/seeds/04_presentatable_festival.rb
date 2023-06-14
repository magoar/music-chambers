require 'date'

p "Creating Autumn Sounds Festival (PRESENTATION)"
Festival.create(
  name: "Autumn Sounds",
  user: User.find_by(email: "max@web.de"),
  location: "Montepulciano",
  start_date: Date.parse('10-09-2023'),
  end_date: Date.parse('16-09-2023'),
  slots_per_day: 4,
  rehearsals_per_group: 3
)

p "Create Timeslots for Autumn Sounds"
festival_start_date = Festival.find_by(name: "Autumn Sounds").start_date
year = festival_start_date.year
month = festival_start_date.month
day = festival_start_date.day
Timeslot.create(
  festival: Festival.find_by(name: "Autumn Sounds"),
  start_time: Time.utc(year, month, day, 10, 0, 0),
  end_time: Time.utc(year, month, day, 11, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Autumn Sounds"),
  start_time: Time.utc(year, month, day, 11, 30, 0),
  end_time: Time.utc(year, month, day, 13, 0, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Autumn Sounds"),
  start_time: Time.utc(year, month, day, 15, 0, 0),
  end_time: Time.utc(year, month, day, 16, 30, 0)
)
Timeslot.create(
  festival: Festival.find_by(name: "Autumn Sounds"),
  start_time: Time.utc(year, month, day, 16, 30, 0),
  end_time: Time.utc(year, month, day, 18, 0, 0)
)

p "creating 2 Rooms for Autumn Sounds"
Room.create(
  name: "Sala Händel",
  size: 4,
  festival: Festival.find_by(name: "Autumn Sounds")
)
Room.create(
  name: "Sala Bach",
  size: 8,
  festival: Festival.find_by(name: "Autumn Sounds")
)
Room.create(
  name: "Sala Mozart",
  size: 5,
  festival: Festival.find_by(name: "Autumn Sounds")
)
Room.create(
  name: "Salone",
  size: 6,
  festival: Festival.find_by(name: "Autumn Sounds")
)

p "giving the rooms requirements"
RoomRequirement.create(
  room: Room.find_by(name: "Sala Mozart"),
  requirement: Requirement.find_by(name: "piano")
)
RoomRequirement.create(
  room: Room.find_by(name: "Salone"),
  requirement: Requirement.find_by(name: "piano")
)

p "creating 16 Musicians for Autumn Sounds"
# 4 The VIOLIN
  Musician.create(
    name: "Nia Paucek",
    instrument: "Violin",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Sonny Pagac",
    instrument: "Violin",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Shad Bruen",
    instrument: "Violin",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Rudy Watsica",
    instrument: "Violin",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 3 PIANO
  Musician.create(
    name: "Pierre Runolfsson",
    instrument: "Piano",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Reginald Greenholt",
    instrument: "Piano",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Electa Bartoletti",
    instrument: "Piano",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 2 VIOLA
  Musician.create(
    name: "Lynn Bins",
    instrument: "Viola",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Stevie Swaniawski",
    instrument: "Viola",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 3 CELLO
  Musician.create(
    name: "Kaylin Zulauf",
    instrument: "Cello",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Kevon Marvin",
    instrument: "Cello",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Vallie Monahan",
    instrument: "Cello",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 2 FLUTE
  Musician.create(
    name: "Onie Hoppe",
    instrument: "Flute",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Musician.create(
    name: "Wilhelm Kozey",
    instrument: "Flute",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 1 OBOE
  Musician.create(
    name: "Javon Barrows",
    instrument: "Oboe",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 1 CLARINET
  Musician.create(
    name: "Manuel Batz",
    instrument: "Clarinet",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 1 BASSOON "Fagott"
  Musician.create(
    name: "Addie Nader",
    instrument: "Bassoon",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
# 1 HORN
  Musician.create(
    name: "Destin Wolf",
    instrument: "Horn",
    festival: Festival.find_by(name: "Autumn Sounds")
  )

p "assigning some attributes to the musicians"
MusicianRequirement.create(
  musician: Musician.find_by(name: "Pierre Runolfsson"),
  requirement: Requirement.find_by(name: "piano")
)
MusicianRequirement.create(
  musician: Musician.find_by(name: "Reginald Greenholt"),
  requirement: Requirement.find_by(name: "piano")
)
MusicianRequirement.create(
  musician: Musician.find_by(name: "Electa Bartoletti"),
  requirement: Requirement.find_by(name: "piano")
)

p "making groups for the musicians"
# Mozart Flöte 4tet
  group1 = Group.create(
    name: "Mozart Flöte 4tet",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group1,
    musician: Musician.find_by(name: "Onie Hoppe")
  )
  Member.create(
    group: group1,
    musician: Musician.find_by(name: "Nia Paucek")
  )
  Member.create(
    group: group1,
    musician: Musician.find_by(name: "Lynn Bins")
  )
  Member.create(
    group: group1,
    musician: Musician.find_by(name: "Vallie Monahan")
  )
# Mozart Bläser 5tet
  group2 = Group.create(
    name: "Mozart Bläser 5tet",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group2,
    musician: Musician.find_by(name: "Pierre Runolfsson")
  )
  Member.create(
    group: group2,
    musician: Musician.find_by(name: "Javon Barrows")
  )
  Member.create(
    group: group2,
    musician: Musician.find_by(name: "Manuel Batz")
  )
  Member.create(
    group: group2,
    musician: Musician.find_by(name: "Destin Wolf")
  )
  Member.create(
    group: group2,
    musician: Musician.find_by(name: "Addie Nader")
  )
# Eisler
  group3 = Group.create(
    name: "Eisler",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group3,
    musician: Musician.find_by(name: "Electa Bartoletti")
  )
  Member.create(
    group: group3,
    musician: Musician.find_by(name: "Wilhelm Kozey")
  )
  Member.create(
    group: group3,
    musician: Musician.find_by(name: "Manuel Batz")
  )
  Member.create(
    group: group3,
    musician: Musician.find_by(name: "Sonny Pagac")
  )
  Member.create(
    group: group3,
    musician: Musician.find_by(name: "Lynn Bins")
  )
  Member.create(
    group: group3,
    musician: Musician.find_by(name: "Kevon Marvin")
  )
# Prokofiev Sonate
  group4 = Group.create(
    name: "Prokofiev Sonate",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group4,
    musician: Musician.find_by(name: "Onie Hoppe")
  )
  Member.create(
    group: group4,
    musician: Musician.find_by(name: "Pierre Runolfsson")
  )
# Thuille
  group5 = Group.create(
    name: "Thuille",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group5,
    musician: Musician.find_by(name: "Pierre Runolfsson")
  )
  Member.create(
    group: group5,
    musician: Musician.find_by(name: "Wilhelm Kozey")
  )
  Member.create(
    group: group5,
    musician: Musician.find_by(name: "Javon Barrows")
  )
  Member.create(
    group: group5,
    musician: Musician.find_by(name: "Manuel Batz")
  )
  Member.create(
    group: group5,
    musician: Musician.find_by(name: "Addie Nader")
  )
  Member.create(
    group: group5,
    musician: Musician.find_by(name: "Destin Wolf")
  )
# Dvorak
  group6 = Group.create(
    name: "Dvorak",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group6,
    musician: Musician.find_by(name: "Reginald Greenholt")
  )
  Member.create(
    group: group6,
    musician: Musician.find_by(name: "Shad Bruen")
  )
  Member.create(
    group: group6,
    musician: Musician.find_by(name: "Nia Paucek")
  )
  Member.create(
    group: group6,
    musician: Musician.find_by(name: "Stevie Swaniawski")
  )
  Member.create(
    group: group6,
    musician: Musician.find_by(name: "Kaylin Zulauf")
  )
# Brahms
  group7 = Group.create(
    name: "Brahms",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group7,
    musician: Musician.find_by(name: "Electa Bartoletti")
  )
  Member.create(
    group: group7,
    musician: Musician.find_by(name: "Nia Paucek")
  )
  Member.create(
    group: group7,
    musician: Musician.find_by(name: "Shad Bruen")
  )
  Member.create(
    group: group7,
    musician: Musician.find_by(name: "Lynn Bins")
  )
  Member.create(
    group: group7,
    musician: Musician.find_by(name: "Kevon Marvin")
  )
# Hindemith
  group8 = Group.create(
    name: "Hindemith",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group8,
    musician: Musician.find_by(name: "Wilhelm Kozey")
  )
  Member.create(
    group: group8,
    musician: Musician.find_by(name: "Javon Barrows")
  )
  Member.create(
    group: group8,
    musician: Musician.find_by(name: "Manuel Batz")
  )
  Member.create(
    group: group8,
    musician: Musician.find_by(name: "Destin Wolf")
  )
  Member.create(
    group: group8,
    musician: Musician.find_by(name: "Addie Nader")
  )
# Schumann
  group9 = Group.create(
    name: "Schumann",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group9,
    musician: Musician.find_by(name: "Reginald Greenholt")
  )
  Member.create(
    group: group9,
    musician: Musician.find_by(name: "Sonny Pagac")
  )
  Member.create(
    group: group9,
    musician: Musician.find_by(name: "Stevie Swaniawski")
  )
  Member.create(
    group: group9,
    musician: Musician.find_by(name: "Vallie Monahan")
  )
# Mendelssohn 8tet
  group10 = Group.create(
    name: "Mendelssohn 8tet",
    festival: Festival.find_by(name: "Autumn Sounds")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Rudy Watsica")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Sonny Pagac")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Nia Paucek")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Shad Bruen")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Stevie Swaniawski")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Lynn Bins")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Kevon Marvin")
  )
  Member.create(
    group: group10,
    musician: Musician.find_by(name: "Kaylin Zulauf")
  )
