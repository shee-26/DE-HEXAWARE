# Variables & Operators
a = 10
b = 5
print(a + b)  # 15
print(a * b)  # 50

# Data Types
x = 10         # int
f = 3.14       # float
s = "text"     # string
b = True       # bool
l = [1, 2, 3]  # list
t = (1, 2)

#  Conditional Statements
x = 10
if x > 5:
    print("Greater than 5")
elif x == 5:
    print("Equal to 5")
else:
    print("Less than 5")

# Loops and Control Structures
for i in range(3):
    print(i)

count = 0
while count < 3:
    print(count)
    count += 1

for i in range(5):
    if i == 2:
        continue
    print(i)

#  Input and Output
name = input("Enter your name: ")
print("Hello", name)

# Lists, Dictionaries, Sets

# Map Function
nums = [1, 2, 3]
squares = list(map(lambda x: x*x, nums))
print(squares)

# String, Number, and Date Functions
s = " Hello World "
print(s.strip().upper())

print(abs(-10))
print(round(3.1415, 2))

import datetime
now = datetime.datetime.now()
print(now.strftime("%Y-%m-%d %H:%M:%S"))

#Python Functions
def greet(name="Guest"):
    print("Welcome,", name)

greet()
greet("Bob")

#Keyword and Special Parameters
def example(pos, /, normal, *, keyword):
    print(pos, normal, keyword)
example(1, normal=2, keyword=3)

#Arbitrary Argument Lists
def show(*args, **kwargs):
    print(args)
    print(kwargs)

show(1, 2, 3, name="Alice")

# Lambda Expressions
add = lambda x, y: x + y
print(add(2, 3))

#OOPs Concepts
class Person:
    def __init__(self, name):
        self.name = name

    def greet(self):
        print("Hello, I am", self.name)

class Student(Person):
    def greet(self):
        print("Hi, I'm student", self.name)

s = Student("John")
s.greet()

# File Handling
with open("file.txt", "w") as f:
    f.write("Hello")
# Exception Handling
try:
    1 / 0
except ZeroDivisionError:
    print("Cannot divide by zero")

# Modules and Packages
import math
print(math.sqrt(16))

# mymodule.py
def add(a, b):
    return a + b

