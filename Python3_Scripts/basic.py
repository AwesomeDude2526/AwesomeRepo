#!/usr/bin/env python3.6

print("Hello, Starting to learn Python Scripting")

firstname = "First"
lastname  = "Last"
print("Hello, " + firstname + " " + lastname)

message = f'{firstname} {lastname}, how are you doing?'
print(message)


name = input("Enter your name: ")
print("Hello " + name)



birth_year = input("What is your year of birth? ")
current_age = 2020 - int(birth_year)
print(current_age)


birth_year = int(input("What is your year of birth? "))
current_age = 2020 - birth_year
print(current_age)


name = "Awesome"
print(name)
print(name.replace("Awesome", "Amazing"))
print(name.upper())
print(name.lower())
print("Awesome" in name)
print(len(name))
print(f'{name} {current_age}')


