#!/usr/bin/python3.6

def sayhi():
	print("Hello Amigos!")
	print("How are you?")
sayhi()


def bio(name, age):
        print("Hello " + name + ", you are " + age + " years old")
bio("Python", "25")
bio("Anaconda", "35")


def print_name(name):
       print(f"Name is {name}")
print_name("Pikachu")


def add_two(num):
       return num + 2
result = add_two(2)
print(result)


def add(num1, num2):
       return num1 + num2
result = add(1, 5)
print(result)


def contact_card(name, age, car_model):
       return f"{name} is {age} and drives a {car_model}"
contact_card("Pikachu", 29, "Honda")
'Pikachu is 29 and drives a Honda'
contact_card(age=29, car_model="Civic", name="Pikachu")
'Pikachu is 29 and drives a Civic'
contact_card("Pikachu", car_model="Civic", age="29")
'Pikachu is 29 and drives a Civic'


def can_drive(age, driving_age=16):
       return age >= driving_age
can_drive(16)
True
can_drive(16, driving_age=18)
False

