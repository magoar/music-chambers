import sys
import json
import z3

input = sys.argv[1]
data = json.load(input)

print(data)



from z3 import *

x = Real('x')
y = Real('y')
s = Solver()
s.add(x + y > 5, x > 1, y > 1)
print(s.check())
print(s.model())
