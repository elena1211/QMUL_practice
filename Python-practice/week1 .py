#data types
Value = 10 
print("value:", Value, "type:", type(Value))
Value = 3.14
print("value:", Value, "type:", type(Value))
Value = "Hello"
print("value:", Value, "type:", type(Value))
Value = True
print("value:", Value, "type:", type(Value))
Value = [1,2,3]
print("value:", Value, "type:", type(Value))

#if/else
Integer= int(input("Press Enter Integer"))
if Integer == 0:
    print("The number is zero")
elif Integer > 0 and Integer % 2 == 0:
    print("Positive Even Number")
elif Integer > 0 and Integer % 2 != 0:
    print("Positive Odd Number")
elif Integer < 0:
    print("Negative Number")
else:
    print("Invalid Input")

#loops
for i in  range(1,21):
    if i % 3 == 0 and i % 5 == 0:
        print("FizzBuzz")
    elif i % 3 == 0:
        print("Fizz")
    elif i % 5 == 0:
        print("Buzz")
    else:    
        print(i)

#functions

input_weight = float(input("EEnter your weight in kg (e.g., 70):  "))
input_height = float(input("Enter your height in meters (e.g., 1.75): "))
def calculate_bmi(weight, height):
    return weight / (height ** 2)
bmi = calculate_bmi(input_weight, input_height)

def bmi_category(bmi):
    if bmi < 18.5:
        return "Underweight"
    elif bmi < 25:
        return "Normal"
    elif bmi < 30:
        return "Overweight"
    else:
        return "Obese"
category = bmi_category(bmi)
print(f"Your BMI is {bmi} and you are {category}")    

#lists
