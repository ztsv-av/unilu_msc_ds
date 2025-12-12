# Exercise 4

import numpy as np
import pandas as pd # to create a data table
import matplotlib.pyplot as plt # for plotting

from sklearn.linear_model import LinearRegression # to build a linear regression model and estimate b
from sklearn.linear_model import Lasso # to build a LASSO estimator
from sklearn.linear_model import LassoCV # to find best lambda in the LASSO estimator using cross-validation technique
from sklearn.linear_model import lasso_path # to find the number of nonzero coefficients for the selected values of lambda and corresponding values

# read the data from the .txt file
path_to_data = "data.txt"
data = pd.read_csv(path_to_data, delimiter="\t", index_col=0)

# create x and y variables
x_columns = ["lcavol", "lweight", "age", "lbph", "svi", "lcp", "gleason", "pgg45"]
y_column = "lpsa"
X = data[x_columns]
Y = data[y_column]

# 1. Building the regression model and estimating b

# create a linear regression model
lr_model = LinearRegression()
# fit the model to the data
lr_model.fit(X, Y)
# get the estimated coefficients
lr_b_0 = lr_model.intercept_
lr_coeffs = lr_model.coef_

# print the coefficients
print("PART 1")
print(f"b_0 (Intercept): {lr_b_0}")
print(f"b_j (Coefficients): {lr_coeffs}")

# 2. Computing the Lasso estimator
# LASSO formula: (1 / (2 * n)) * ||y - Xb||^2_2 + alpha * ||b||_1

# create a LASSO model
lasso_model = Lasso(alpha=0.1)
# fit the LASSO model on data
lasso_model.fit(X, Y)
# get the estimated intercept and coefficients
lasso_intercept = lasso_model.intercept_
lasso_coeffs = lasso_model.coef_

# print the intercept and non-zero coefficients for better interpretation
print("\nPART 2")
print(f"Intercept (b_0): {lasso_intercept:.4f}")
print(f"Non-zero Coefficients (b_j):")
for i, name in enumerate(x_columns):
    if lasso_coeffs[i] != 0:
        print(f"    {name}: {lasso_coeffs[i]:.4f}")

# plot the estimated coefficients
plt.figure(figsize=(10, 6))
# linear regression coefficients
plt.bar(np.arange(len(x_columns)) - 0.2, lr_coeffs, width=0.4, color="#165c73", alpha=0.9, label="Linear Regression")
# LASSO coefficients
plt.bar(np.arange(len(x_columns)) + 0.2, lasso_coeffs, width=0.4, color="#e49527", alpha=0.9, label="LASSO")
# add labels, title, and legend
plt.xlabel("Features")
plt.ylabel("Estimated Coefficients")
plt.title("Linear Regression VS LASSO Estimated Coefficients")
plt.xticks(np.arange(len(x_columns)), x_columns, rotation=45)
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()

# 3. Computing lambda_min and lambda_1se
# Here we will use LassoCV from scikit-learn library to the best LASSO estimator, 
#   i.e. the one that has the lowest MSE, via cross-validation technique.
# We will test 100 different lambdas.

# create LassoCV model with 10-fold cross-validation
num_folds = 10
lasso_cv_model = LassoCV(cv=num_folds)
# fit the LassoCV model to the data
lasso_cv_model.fit(X, Y)

# get the array of lambdas
lambda_values = lasso_cv_model.alphas_
# mse values for each lambda
mse_values = lasso_cv_model.mse_path_
# get lambda that gives the lowest MSE
lambda_min_index = np.argmin(np.mean(mse_values, axis=1))
lambda_min = lambda_values[lambda_min_index]

# compute the standard deviation of the MSE values
mse_std = np.std(mse_values, axis=1)
# compute the standard error for each lambda value
mse_se = mse_std / np.sqrt(num_folds)
# get the smallest MSE
min_mse = np.mean(mse_values[lambda_min_index])
# find the indices where MSE is within one standard error of the smallest MSE
indices_within_1se = np.where(np.mean(mse_values, axis=1) <= min_mse + mse_se)[0]
# finally get the maximum lambda at which the MSE is within one standard error of the smallest MSE
lambda_1se_index = indices_within_1se[np.argmax(lambda_values[indices_within_1se])]
lambda_1se = lambda_values[lambda_1se_index]

# print the lambda_min
print("\nPART 3")
print(f"Number of lambdas: {lasso_cv_model.get_params()['n_alphas']}")
print(f"lambda.min: {lambda_min}")
print(f"lambda.1se: {lambda_1se}")

# LassoCV only stores the coefficients for the best alpha
# So we found "lasso_path" function, which computes and stores the entire regularization path 
#   of the Lasso coefficients.
# To make sure that we have the correct coefficients path, we pass in as a parameter lambda_values from the lasso_cv_model
_, lasso_cv_coeffs, _ = lasso_path(X, Y, alphas=lambda_values)
lasso_cv_coeffs = lasso_cv_coeffs.T

# get the coefficients for lambda_min and lambda_1se
coeffs_lambda_min = lasso_cv_coeffs[lambda_min_index]
coeffs_lambda_1se = lasso_cv_coeffs[lambda_1se_index]

# get the number of nonzero coefficients for lambda_min and lambda_1se
# and print the corresponding coefficients
num_nonzero_coeffs_min = np.count_nonzero(coeffs_lambda_min)
num_nonzero_coeffs_1se = np.count_nonzero(coeffs_lambda_1se)

print(f"Number of nonzero coefficients for lambda_min: {num_nonzero_coeffs_min}")
print(f"Number of nonzero coefficients for lambda_1se: {num_nonzero_coeffs_1se}")
print(f"Non-zero Coefficients for lambda_min:")
for i, name in enumerate(x_columns):
    if coeffs_lambda_min[i] != 0:
        print(f"    {name}: {coeffs_lambda_min[i]:.4f}")
print(f"Non-zero Coefficients for lambda_1se:")
for i, name in enumerate(x_columns):
    if coeffs_lambda_1se[i] != 0:
        print(f"    {name}: {coeffs_lambda_1se[i]:.4f}")
