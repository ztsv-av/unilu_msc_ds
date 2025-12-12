import numpy as np
import multiprocessing
import time

from KNNClassifier import KNNClassifier
from KNNClassifierParallel import KNNClassifierParallel
from KNNClassifierParallelVectorized import KNNClassifierParallelVectorized


def fitPredict(knn):
    # Fit
    knn.fit(X_train, y_train)
    # Generate Predictions
    predictions = knn.predict(X_train[X_test])
    # Calculate the number of equal elements
    print(f"    Correct {np.sum(y_train[X_test] == predictions)}")

def sequential():
    knn = KNNClassifier(k=k)
    # Predict
    fitPredict(knn)

def parallel():
    knn = KNNClassifierParallel(k=k, n_jobs=num_cores)
    # Fit & Predict
    fitPredict(knn)

def parallelVectorized():
    knn = KNNClassifierParallelVectorized(k=k, n_jobs=num_cores)
    # Fit & Predict
    fitPredict(knn)

def measurePerformance(func, runs):
    real_times = []
    cpu_times = []
    for _ in range(runs):
        # Measure real (wall-clock) time
        start_real = time.time()
        # Measure CPU time
        start_cpu = time.process_time()
        # Run the function
        func()
        # Calculate times
        real_times.append(time.time() - start_real)
        cpu_times.append(time.process_time() - start_cpu)
    # Calculate average and standard deviation
    real_time_avg = np.mean(real_times)
    real_time_std = np.std(real_times)
    cpu_time_avg = np.mean(cpu_times)
    cpu_time_std = np.std(cpu_times)
    print(f"    '{func.__name__}' Performance over {runs} runs:")
    print(f"    Real Time - Avg: {real_time_avg:.4f} s, Std: {real_time_std:.4f} s")
    print(f"    CPU Time  - Avg: {cpu_time_avg:.4f} s, Std: {cpu_time_std:.4f} s")
    print("\n")

if __name__ == "__main__":
    # Variables
    #   Data
    rows = 10000
    cols = 50
    test_size = 1000
    np.random.seed(699)
    X_train = np.random.rand(rows*cols).reshape((rows,cols))
    y_train = np.random.randint(2, size=rows)
    X_test = np.random.randint(rows, size=test_size)
    #   KNN
    k = 2
    #   Measurement
    runs = 30  # number of runs
    #   Parallel
    num_cores = multiprocessing.cpu_count() # number of parallel jobs

    # KNN
    #   Sequential
    print("Measuring Sequential Function Performance")
    measurePerformance(sequential, runs)
    #   Parallel
    print("\n\nMeasuring Parallel Functions Performances")
    print(f"Number of CPU cores and n_jobs: {num_cores}")
    print("    Parallel Function Performance")
    measurePerformance(parallel, runs)
    print("    Parallel Vectorized Function Performance")
    measurePerformance(parallelVectorized, runs)
