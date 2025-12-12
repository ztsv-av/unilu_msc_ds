import time

@profile
def slow_function():
    for i in range(3):
        time.sleep(1)  # Simulate a slow operation

@profile
def calculate_sum(n):
    total = 0
    for i in range(n):
        total += i
    return total

def main():
    slow_function()
    result = calculate_sum(1000000)
    print(f"Sum is: {result}")

if __name__ == "__main__":
    main()
