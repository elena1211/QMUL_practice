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

if __name__ == "__main__":
    count_numbers()
    browser_navigation_demo()
    count_letters()