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
#BMI calculator
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
#sum of numbers
numbers = [1, 2, 3, 4, 5]
total = 0 
for number in numbers: 
    total += number
print(f"Total: {total}")

#lists & loops
numbers = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
squared_numbers = [num ** 2 for num in numbers]
total = 0 #initialize
for number in numbers:
    total += number 
#total = sum(numbers)
max_number = max(numbers)
min_number = min(numbers)
print(f"Original List: {numbers}")
print(f"Total: {total}")
print(f"Max: {max_number}")
print(f"Min: {min_number}")
print(f"Squared_number: {squared_numbers}")

# Dictionaries
# countries = {
#     "France": "Paris",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "India": "New Delhi",
#     "Taiwan": "Taipei"
# }
# input_country = input("Enter a country: ")
# if input_country in countries:
#     for country in countries:
#         if country == input_country:
#             print(f"The capital of {input_country} is {countries[country]}")
# else:
#     print("Country not found")

# input_ask_question = input("Do you want to add a country? (yes/no): ")
# if input_ask_question == "yes":
#     input_country = input("Enter a country: ")
#     input_capital = input("Enter the capital: ")
#     countries[input_country] = input_capital
#     print(countries)

countries = {
    "France": "Paris",
    "Japan": "Tokyo",
    "Germany": "Berlin",
    "India": "New Delhi",
    "Taiwan": "Taipei"
}

while True:
    input_country = input("Enter a country: ")
    if input_country in countries:
        print(f"The capital of {input_country} is {countries[input_country]}")
    else:
        print("Country not found")
    input_ask_question = input("Do you want to add a country? (yes/no): ").lower() 
    if input_ask_question == "yes":
            input_capital = input("Enter the capital: ")
            countries[input_country] = input_capital
            print(countries)
    elif input_ask_question == "no":
        print("No country added")
    
    continue_question = input("Do you want to continue? (yes/no): ").lower()
    if continue_question == "no":
        break
    elif continue_question == "yes":
        continue
    else:
        print("Invalid Input")
        break
    