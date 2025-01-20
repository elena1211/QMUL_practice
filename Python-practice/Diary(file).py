import os 

def write_diary():
    diary_entry = input("Write your diary entry: ")
    with open("diary.txt", mode="a", encoding="utf-8") as file:
        file.write(diary_entry + "\n") 
    print("Diary entry saved to diary.txt.")

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

