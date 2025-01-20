import os

tasks = []

def add_task(new_task):
    if new_task not in tasks:
        tasks.append(new_task)
        print(f"Task '{new_task}' added.")
    else:
        print(f"Task '{new_task}' already exists.")

def insert_task(position, new_task):
    if position < 1 or position > len(tasks) + 1:
        print("Invalid position. Please try again.")
    else:
        if new_task not in tasks:
            tasks.insert(position - 1, new_task)
            print(f"Task '{new_task}' added at position {position}.")
        else:
            print(f"Task '{new_task}' already exists.")

def remove_task(task_number):
    if task_number < 1 or task_number > len(tasks):
        print("Invalid task number.")
    else:
        removed_task = tasks.pop(task_number - 1)
        print(f"Task '{removed_task}' removed.")

def mark_task_done(task_number):
    if task_number < 1 or task_number > len(tasks):
        print("Invalid task number.")
    else:
        completed_task = tasks.pop(task_number - 1)
        print(f"Task '{completed_task}' marked as done.")

def view_tasks():
    if not tasks:
        print("No tasks in the list.")
    else:
        print("\nCurrent tasks:")
        for i, task in enumerate(tasks, start=1):
            print(f"{i}. {task}")

def save_to_file(filename="tasks.txt"):
    with open(filename, mode="w", encoding="utf-8") as file:
        for task in tasks:
            file.write(task + "\n")
    print(f"Tasks saved to {filename}.")

def load_from_file(filename="tasks.txt"):
    if os.path.exists(filename):
        with open(filename, mode="r", encoding="utf-8") as file:
            for line in file:
                task = line.strip()
                if task not in tasks:
                    tasks.append(task)
        print(f"Tasks loaded from {filename}.")
    else:
        print(f"No existing file found ({filename}). Starting with an empty list.")

load_from_file()

while True:
    print("\n=== To-Do List ===")
    print("1. Add task")
    print("2. Insert task")
    print("3. Remove task")
    print("4. Mark task as done")
    print("5. View tasks")
    print("6. Exit")
    
    view_tasks()

    choice = input("Enter your choice: ")

    if choice == "1":
        new_task = input("Enter the new task: ")
        add_task(new_task)

    elif choice == "2":
        try:
            position = int(input("Enter the position to insert the task: "))
            new_task = input("Enter the task: ")
            insert_task(position, new_task)
        except ValueError:
            print("Invalid input. Please enter a valid position.")

    elif choice == "3":
        try:
            task_number = int(input("Enter the task number to remove: "))
            remove_task(task_number)
        except ValueError:
            print("Invalid input. Please enter a valid task number.")

    elif choice == "4":
        try:
            task_number = int(input("Enter the task number to mark as done: "))
            mark_task_done(task_number)
        except ValueError:
            print("Invalid input. Please enter a valid task number.")

    elif choice == "5":
        view_tasks()

    elif choice == "6":
        save = input("Do you want to save tasks before exiting? (yes/no): ").strip().lower()
        if save == "yes":
            save_to_file()
        print("Goodbye!")
        break

    else:
        print("Invalid choice. Please try again.")


