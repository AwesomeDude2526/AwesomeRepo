#!/usr/bin/python3.6

#Use this for Error Handling, Won't crash the program
text = input('Username: ')
try:
   number = int(text)
   print(number)
except:
   print('Invalid Username')

