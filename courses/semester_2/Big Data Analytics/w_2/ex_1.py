import matplotlib.pyplot as plt

data = {
    'Task (b) (1)': [13383, 27526, 43486, 56509, 70948, 88000, 104117, 119946, 134888, 150414, 167111],
    'Task (b) (2)': [12354, 26585, 42472, 52574, 70691, 85746, 103137, 117051, 132139, 146930, 156237],
    'Task (b) (3)': [13356, 28747, 48972, 56485, 70758, 87916, 105882, 122838, 136947, 152269, 159152],
    'Task (b) (4)': [13642, 24534, 38462, 51559, 58785, 72717, 87883, 94057, 106147, 121454, 127828]
}

num_files = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100]

plt.figure(figsize=(10, 6))

for b, timings in data.items():
    plt.plot(timings, num_files, label=b)

plt.xlabel('Milliseconds')
plt.ylabel('Number of Files')
plt.title('Task (c): Hadoop MapReduce Execution Time (Average) vs. Number of Files')
plt.legend()
plt.grid(True)
plt.savefig("Problem-1_execution-times.jpg")
plt.show()
