import matplotlib.pyplot as plt
import numpy as np

files = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100]
times = [28286, 38820, 54930, 72204, 91675, 107247, 123272, 142181, 156662, 177564, 184868]

plt.plot(files, times)
plt.show()

coefficients = np.polyfit(files, times, 1)
linear_coefficient = coefficients[0]

print("Linear coefficient:", linear_coefficient)
