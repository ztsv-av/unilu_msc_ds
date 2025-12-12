import numpy as np
from multiprocessing import Pool

class KNNClassifierParallel:
    def __init__(self, k=3, n_jobs=2):
        self.k = k
        self.n_jobs = n_jobs  # Number of parallel jobs

    def fit(self, X, y):
        self.X_train = X
        self.y_train = y

    def euclidean_distance(self, x1, x2):
        diff = (x1 - x2)
        sqr_diff = diff ** 2
        sqr_diff_sum = np.sum(sqr_diff)
        return np.sqrt(sqr_diff_sum)

    def predict(self, X):
        # Predictions for each input in X are independent of each other
        # Therefore, we can parallelize predictions for each sample in X
        with Pool(self.n_jobs) as pool:
            y_pred = pool.map(self._predict, X)
        return np.array(y_pred)

    def _predict(self, x):
        distances = [self.euclidean_distance(x, x_train) for x_train in self.X_train] # Sequential distance computation
        
        k_indices = np.argsort(distances)[:self.k]
        k_nearest_labels = self.y_train[k_indices]
        most_common = np.bincount(k_nearest_labels).argmax()
        return most_common

