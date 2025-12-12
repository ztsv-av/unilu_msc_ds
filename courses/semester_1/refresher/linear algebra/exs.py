import numpy as np
import matplotlib.pyplot as plt

# Generate x and y
x = np.linspace(0, 5, 15)
y = 1 + x + np.random.random(len(x))
z = y + np.random.random(len(x))
# print("y =", y)

# plt.figure()
# ax = plt.subplot(111, projection='3d')
# ax.scatter(x, y, z, color='b')

# Build matrix A
A = np.vstack([x, y, np.ones(len(x))]).T
b = np.vstack(z)
# print(A)


# Turn y into a column vector
# b = b[:, np.newaxis]
# print("y =",y)


# Compute pseudoinverse via matrix multiplication
pinv = np.dot(np.linalg.inv(np.dot(A.T,A)),A.T)
# print("pinv =", pinv)

alpha = np.dot(pinv,b)
# print("alpha =",alpha)


# Compute pseudoinverse with pinv
pinv = np.linalg.pinv(A)
alpha = np.dot(pinv,b)
# alpha = pinv.dot(y)
print("alpha =",alpha)

ax = plt.figure().add_subplot(projection='3d')
ax.scatter(x, y, z, color='b')

# plot plane
xlim = ax.get_xlim()
ylim = ax.get_ylim()
X,Y = np.meshgrid(np.arange(xlim[0], xlim[1]),
                  np.arange(ylim[0], ylim[1]))
Z = np.zeros(X.shape)
for r in range(X.shape[0]):
    for c in range(X.shape[1]):
        Z[r,c] = alpha[0] * X[r,c] + alpha[1] * Y[r,c] + alpha[2]
ax.plot_wireframe(X,Y,Z, color='k')

ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
ax.view_init(elev=-25., azim=-45, roll=0)
plt.show()

# ------

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns; sns.set()


from sklearn.datasets import load_digits
digits = load_digits()
digits.data.shape


from sklearn.decomposition import PCA


# Define a plotting function
def plot_digits(data):
    fig, axes = plt.subplots(4, 10, figsize=(10, 4),
                             subplot_kw={'xticks':[], 'yticks':[]},
                             gridspec_kw=dict(hspace=0.1, wspace=0.1))
    for i, ax in enumerate(axes.flat):
        ax.imshow(data[i].reshape(8, 8),
                  cmap='binary', interpolation='nearest',
                  clim=(0, 16))
        
        
# Plot the data        
plot_digits(digits.data)


# Add some random noise to the data
np.random.seed(42)
noisy = np.random.normal(digits.data, 4)
plot_digits(noisy)


# Determine how many principal components are needed to describe 50% of the variance
pca = PCA(0.5).fit(noisy)
pca.n_components_


# Plot only the principal components
components = pca.transform(noisy)
filtered = pca.inverse_transform(components)
plot_digits(filtered)

# -----

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns; sns.set()


rng = np.random.RandomState(1)
X = np.dot(rng.rand(2, 2), rng.randn(2, 200)).T
plt.scatter(X[:, 0], X[:, 1], s=10)
plt.axis('equal')


# Import PCA commands
from sklearn.decomposition import PCA


# Apply PCA to the data
pca = PCA(n_components=2)
pca.fit(X)

# Print the principal component vectors and their variance
print(pca.components_)
print(pca.explained_variance_)


def draw_vector(v0, v1, ax=None):
    ax = ax or plt.gca()
    arrowprops=dict(arrowstyle='->',
                    linewidth=3,
                    shrinkA=0, shrinkB=0, color='r')
    ax.annotate('', v1, v0, arrowprops=arrowprops)


# Plot the principal components
plt.figure()

plt.scatter(X[:, 0], X[:, 1], s=10)
for length, vector in zip(pca.explained_variance_, pca.components_):
    v = vector * 3 * np.sqrt(length)
    draw_vector(pca.mean_, pca.mean_ + v)
plt.axis('equal')


# Transform the 2-dimensional data to 1-dimensional data
pca = PCA(n_components=1)
pca.fit(X)
X_pca = pca.transform(X)
print("original shape:   ", X.shape)
print("transformed shape:", X_pca.shape)


# Plot the 1-dimensional data
plt.figure()
plt.scatter(X[:, 0], X[:, 1], s=10)
X_new = pca.inverse_transform(X_pca)
plt.scatter(X_new[:, 0], X_new[:, 1], alpha=0.5, s=10)
plt.axis('equal')
