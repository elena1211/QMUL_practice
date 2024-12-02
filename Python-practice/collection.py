from collections import defaultdict, deque, Counter
# Use Counter to count the number of times each digit occurs and find the digit that occurs most frequently.

def count_numbers():
    numbers = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    count = Counter(numbers)
    print(count)  # Counter({4: 4, 3: 3, 2: 2, 1: 1})
    most_common_number = count.most_common(1)
    print(most_common_number)  # [(4, 4)]
    print(most_common_number[0][0])  # 4

# When you visit a new website, put the current website into the ‘History’ and clear the ‘Future’.
# When you click ‘Backward’, the current website will be put into the ‘Future Record’, and the previous website will be taken out from the ‘History Record’ to visit.
# When you click ‘Forward’, the current website will be put into the ‘History’ and the next website will be taken from the ‘Future Record’ to visit.

history = deque()
future = deque()
current_site = "home"
def visit_website(new_website):
    global current_site
    history.append(current_site)
    current_site = new_website
    future.clear()
def backward():
    global current_site
    if history:
        future.appendleft(current_site)
        current_site = history.pop()
    else:
        print("No more history")
def forward():
    global current_site
    if future:
        history.append(current_site)
        current_site = future.popleft()
    else:
        print("No more future")
def browser_navigation_demo():
    visit_website("site1")
    visit_website("site2")
    backward()
    visit_website("site3")
    backward()
    backward()
    forward()
    print(f"Current site: {current_site}")
    print(f"History: {list(history)}")
    print(f"Future: {list(future)}")

# Use defaultdict to count the number of occurrences of each letter of the alphabet in an article (case insensitive). When you have finished counting, print out the number of occurrences of each letter.
# "The quick brown fox jumps over the lazy dog."

def count_letters():
    word_counts = defaultdict(int)
    sentence = "The quick brown fox jumps over the lazy dog."
    for char in sentence.upper():
        if char.isalpha():
            word_counts[char] += 1
    print(word_counts)

# Use dictionary comprehension to find the numbers that are greater than 50 in a dictionary.

squares = {x: x**2 for x in range(1, 11)}
over_fifty = [key for key, value in squares.items() if value > 50]
print(over_fifty) 

# Create a new dictionary that uses each course as a key and lists all students taking that course.
students_courses = {
    'Alice': ['Math', 'Science'],
    'Bob': ['English', 'History', 'Math'],
    'Charlie': ['Math', 'Art'],
    'David': ['Science', 'History']
}
# course_dict = []
# for student, courses in students_courses.items():
#     for course in courses:
#         if course in course_dict:
#             course_dict[course].append(student)
#         else:
#             course_dict[course] = [student]
# print(course_dict)

course_dict = defaultdict(list)
for student, courses in students_courses.items():
    for course in courses:
        course_dict[course].append(student)
print(dict(course_dict))

# There is a dictionary that contains the names of employees and their salaries. You need to group the employees based on the following criteria:
# If the salary is above 5000, they are in the ‘High’ group.
# If the salary is between 3,000 and 5,000 (both 3,000 and 5,000), they are in the ‘Medium’ group.
# If the salary is below 3000, they are in the ‘Low’ group.
# Print out the employees in each group.

employees = {
    'John': 6000,
    'Alice': 4500,
    'Bob': 2800,
    'Charlie': 5100,
    'David': 3000
}
salary_dict = defaultdict(list)
for name, salary in employees.items():
    if salary < 3000:
        salary_dict['Low'].append(name)
    elif salary < 5000:
        salary_dict['Medium'].append(name)
    else:
        salary_dict['High'].append(name)
print(dict(salary_dict))  

if __name__ == "__main__":
    count_numbers()
    browser_navigation_demo()
    count_letters()