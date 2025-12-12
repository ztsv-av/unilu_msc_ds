import numpy as np
import matplotlib.pyplot as plt

SEED = 1337
N = 1000

# QUESTION 1

# unif = np.random.rand(1000)
# sample = unif**(1/3)
# plt.hist(sample)

# QUESTION 2

def rejection(n, alpha, seed):

    samples = np.zeros(n)
    draws = 0

    c = 3/2*alpha

    for i in range(n):

        uniform = np.random.rand(1)[0]
        x = alpha * np.random.rand(1)[0]

        while uniform > 6*alpha*x*(1-x)/c:
            uniform = np.random.rand(1)[0]
            x = alpha * np.random.rand(1)[0]
            draws += 1
        samples[i] = x

    return samples, draws

samples, draws = rejection(N, 1, SEED)

plt.hist(samples)