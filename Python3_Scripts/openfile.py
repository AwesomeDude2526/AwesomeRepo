#!/usr/bin/python3.6

test = open("file", "r")
print(test.read())
test.close()

#Read a file
file = open('filename', 'r') #Open file in read mode
f = file.readlines() #Read each line one by one
newlist = []
for line in f:
   newlist.append(line.strip()) #Remove \n from the end of each line
print(newlist)
file.close()

#Write to a file, 'w' will overwrite all text within the file
file = open('filename', 'w')
file.write('Python\n') #Use \n to continue text onto a new line
file.write('This is the second line')
file.close()


