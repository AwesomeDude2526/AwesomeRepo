#!/usr/bin/env python3.6

# Tuples work just like lists, but items within tuples cannot be replaced #

my_tuple = (2.0, 3.0)
my_tuple += (4.0,) # Adding 4.0 to the end of the tuple #
print(my_tuple)

x, y, z = my_tuple #Assigning (unpacking) tuple items to x, y, and z #
print(x)
print(y)
print(z)



# Substituting information using tuples #

print("Hello %s %s" % ("John", "Smith"))

