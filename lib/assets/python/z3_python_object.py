import json

with open('./test.json', 'r') as f:
  data = json.load(f)

# Output: {'name': 'Bob', 'languages': ['English', 'French']}
print(data)



# This is how the Python Object has to look like in the end
# person_count = 20
# rooms_count = 10
# timeslots_count = 10
# number_of_rehearsals = 3

# rooms = [
#     (20, ["ConcertHall", "Drumkit", "Piano", "Accessible"]),
#     (3, ["Piano"]),
#     (5, ["Piano"]),
#     (5, ["Drumkit"]),
#     (3, ["Accessible"]),
#     (3, []),
#     (3, []),
#     (3, []),
#     (5, []),
#     (3, []),
# ]

# musicians_groups = [
#     ((0, 1, 2), ["Accessible"]),
#     ((1, 2, 3), ["Accessible"]),
#     ((2, 3, 4), ["Piano", "Accessible"]),
#     ((3, 4, 5), ["Piano"]),
#     ((4, 5, 6), ["Piano"]),
#     ((5, 6, 7), ["Piano"]),
#     ((6, 7, 8), ["Piano"]),
#     ((7, 8, 9), ["Piano"]),
#     ((8, 9, 10), []),
#     ((9, 10, 11), []),
#     ((0, 1, 2, 3, 4), ["Piano", "Accessible"]),
#     ((5, 6, 7, 8, 9), ["Piano"]),
#     ((10, 11, 12, 13, 14, 15), []),
#     ((15, 16, 17, 18, 19), []),
# ]
