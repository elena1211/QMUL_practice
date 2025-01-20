import os 
from datetime import datetime

def write_diary():
    diary_entry = input("Write your diary entry: ")
    timestamp = datetime.now().strftime("%d-%m-%Y %H:%M:%S")
    entry_with_timestamp = f"[{timestamp}] {diary_entry}"

    with open("diary.txt", mode="a", encoding="utf-8") as file:
        file.write(entry_with_timestamp + "\n")
    print("Diary entry saved with timestamp.")

def load_diary():
    if os.path.exists("diary.txt"): 
        with open("diary.txt", mode="r", encoding="utf-8") as file:
            entries = file.readlines() 
            if entries: 
                print("\n=== Your Diary Entries ===")
                for line in entries:
                    print(line.strip()) 
                print("\nDiary loaded successfully.")
            else:
                print("Your diary is empty.")
    else:
        print("No existing diary found. Starting with an empty diary.")


while True:
    print("\n=== Diary ===")
    print("1. Write diary")
    print("2. Load diary")
    print("3. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        write_diary() 
    elif choice == "2":
        load_diary()  
    elif choice == "3":
        print("Goodbye!")  
        break
    else:
        print("Invalid input. Please enter a valid choice.")

