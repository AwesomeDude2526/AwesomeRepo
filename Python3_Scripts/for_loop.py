!/usr/bin/env python3.6


colors = ['blue', 'green', 'red', 'purple']
for color in colors:
print(color)


for color in colors:
   if color == 'blue':
     continue
   elif color == 'red':
     break
print(color)


point = (2.1, 3.2, 7.6)
for value in point:
print(value)


ages = {'pikachu': 59, 'amigo': 40, 'sonia': 21}
for key in ages:
print(key)


for letter in "my_string":
print(letter)


list_of_points = [(1, 2), (2, 3), (3, 4)]
for x, y in list_of_points:
print(f"x: {x}, y: {y}")
x: 1, y: 2
x: 2, y: 3
x: 3, y: 4


for name, age in ages.items():
print(f"Person Named: {name}")
print(f"Age of: {age}")
Person Named: pikachu
Age of: 9
Person Named: amigo
Age of: 10
Person Named: sonia
Age of: 21

