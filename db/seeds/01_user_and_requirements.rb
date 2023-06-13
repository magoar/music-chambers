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
Requirement.create(name: "ConcertHall")
p Requirement.last.valid?
