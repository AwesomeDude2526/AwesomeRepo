#!/usr/bin/env python3.6

my_list = [1, 2, 3, 4, 5]
print(my_list)
print(my_list[0]) # To access something from the list, we can use its index, which starts at 0 #
print(my_list[0:4]) # Slicing, will print from index 0 to 3, but not the 4th #
print(my_list[:4]) # Slicing, will print from index 0 to 3, but not the 4th #
print(my_list[-1]) # Slicing, will print in the reverse order #
print(my_list[::2]) # Stepping, will print 1, 3, and 5 #

my_list[0] = "A" # Will replace index 0, so 1 will be replaced with A #
my_list.remove(4) # Will remove number 4 from the list #
my_list.pop() # Will remove the last item on the list #
my_list.append(6) # Will add number 6 to the end of the list #
my_list.insert(0, 'A') # Will add A to index 0 #
my_list += [6] # Will add number 6 to the end of the list #
