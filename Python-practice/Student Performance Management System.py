student = {
    "1": {"name": "Alice", "grades": [90, 85, 95]},
    "2": {"name": "Bob", "grades": [70, 75, 80]},
    "3": {"name": "Charlie", "grades": [60, 65, 70]},
}
def add_student(student_id, name):
    if student_id in student:
        print("Student already exists")
    else:
        student[student_id] = {"name": name, "grades": []}
        print(f"Student{name}(ID:{student_id}) added")

def remove_student(student_id):
    if student_id in student:
        removed_student = student.pop(student_id)
        print(f"Student {removed_student['name']} (ID: {student_id}) removed.")
    else:
        print("Student does not exist.")

def add_grade(student_id, grade):
    if student_id not in student:
        print(f"Student ID:{student_id} does not exist")
    else :
        student[student_id]["grades"].append(grade)
        print(f"Grade {grade} added for {student[student_id]['name']}")

def update_grade(student_id, grade):
    if student_id not in student:
        print(f"Student ID {student_id} does not exist.")
    elif not student[student_id]["grades"]:
        print(f"Student {student[student_id]['name']} has no grades to update.")
    else:
        student[student_id]["grades"][-1] = grade
        print(f"Grade updated for {student[student_id]['name']}. New grade: {grade}")

def view_student(student_id):
    if student_id in student:
        name = student[student_id]["name"]
        grades = student[student_id]["grades"]
        avg_grade = sum(grades) / len(grades) if grades else 0
        print(f"Name: {name}, Grades: {grades}, Average: {avg_grade:.2f}")
    else:
        print(f"Student ID {student_id} not found.")
        
def view_all_students():
    for student_id in student:
        name = student[student_id]["name"]
        grades = student[student_id]["grades"]
        avg_grade = sum(grades) / len(grades) if grades else 0 
        print(f"ID: {student_id}, Name: {name}, Grades: {grades}, Average: {avg_grade:.2f}")

import csv

def save_students_to_csv(filename="students.csv"):
    with open(filename, mode="w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["ID", "Name", "Grades"])
        for student_id, info in student.items():
            writer.writerow([student_id, info["name"], ",".join(map(str, info["grades"]))])
    print(f"Students data saved to {filename}.")

def load_students_from_csv(filename="students.csv"):
    try:
        with open(filename, mode="r") as file:
            reader = csv.reader(file)
            next(reader)  # Skip the header row
            for row in reader:
                student_id, name, grades = row
                student[student_id] = {"name": name, "grades": list(map(int, grades.split(","))) if grades else []}
        print(f"Students data loaded from {filename}.")
    except FileNotFoundError:
        print(f"No existing data file found. Starting with an empty database.")


while True:
    print("\n=== Student Management System ===")
    print("1. Add Student")
    print("2. Remove Student")
    print("3. Add Grade")
    print("4. Update Grade")
    print("5. View Student")
    print("6. View All Students")
    print("7. Save to CSV")
    print("8. Load from CSV")
    print("9. Exit")


    choice = input("Enter your choice: ")

    if choice == "1":
        student_id = input("Enter student ID: ")
        name = input("Enter student name: ")
        add_student(student_id, name)
    elif choice == "2":
        student_id = input("Enter student ID: ")
        remove_student(student_id)
    elif choice == "3":
        student_id = input("Enter student ID: ")
        grade = float(input("Enter only one grade: "))
        add_grade(student_id, grade)
    elif choice == "4":
        student_id = input("Enter student ID: ")
        grade = float(input("Enter only one grade: "))
        update_grade(student_id, grade)
    elif choice == "5":
        student_id = input("Enter student ID: ")
        view_student(student_id)
    elif choice == "6":
        view_all_students()
    elif choice == "7":
        save_students_to_csv()
    elif choice == "8":
        load_students_from_csv()
    elif choice == "9":
        print("\nThank you for using the Student Management System. Goodbye!")
        break
    else:
        print("Invalid choice. Please try again.")

print("Thank you for using the Student Management System")

