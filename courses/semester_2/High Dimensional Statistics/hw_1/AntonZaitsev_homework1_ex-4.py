# Exercise 4

import numpy as np # for math operations
import matplotlib.pyplot as plt # for plotting
from scipy.stats import f # F-distribution table

# sample data
data = np.array([10, 20, 21, 25, 29, 30, 31, 40, 45, 50])
Y = np.array([200, 195, 200, 190, 188, 180, 185, 180, 163, 170])

# Part 1 - building regression model and estimating b

## Estimating b

# add a column of ones for the intercept term
X = np.array([[1,x] for x in data])

# calculate coefficients using linear least squares
b = np.linalg.inv(X.T @ X) @ (X.T @ Y)
b_0 = b[0]
b_1 = b[1]

# print the estimated coefficients
print(f"Estimated intercept (b_0): {b_0:.3f}")
print(f"Estimated slope (b_1): {b_1:.3f}")

## Plot results

# generate data points for the fitted line
x_fit = np.array([min(X[:, 1]), max(X[:, 1])])
y_fit = b_0 + b_1 * x_fit

# plot the data and the fitted line
plt.scatter(X[:, 1], Y)  # plot data points
plt.plot(x_fit, y_fit, color='red')  # Plot fitted line
plt.xlabel("Age")
plt.ylabel("Beats per minute under stress")
plt.title("Linear Regression - Age vs. Beats per minute")
plt.show()

# Part 2 - verifying the null hypothesis H_0: b_1 = 0 vs H_1: b_1 != 0 with significance level alpha=0.05
# To test the null hypothesis, i.e. 
#   that there is no linear relationship between the predictor variable and the response variable (b_1=0),
#   we will use the F-test.
# We will compute the F-statistic using the estimated coefficients and the target variable Y,
#   and compare it with the F-critical value from the F-distribution table.
# If our computed F-statistic is greater than the F-critical value,
#   then we will reject the null hypothesis, 
#   meaning we will deduce that there is a significant relationship between age and beats per minute under stress.
# Otherwise, we will accept the null hypothesis.
# To compute the F-statistic, we will use the formula:
# f_stat = msr/mse
# where 
#   msr = rss/MSR_DF - The mean square due to regression
#     rss - Sum of the squared differences between the predicted values and the mean of the dependent variable
#     MSR_DF - Degrees of freedom for regression
#   mse = sse/MSE_DF - The mean square due to error
#     sse - Sum of the squared differences between the observed values and the predicted values of the dependent variable
#     MSE_DF - Degrees of freedom for error

ALPHA = 0.05 # significance level
NUM_OBS = data.shape[0] # number of observations
MSR_DF = 1 # degrees of freedom for regression
MSE_DF = NUM_OBS - 2 # degrees of freedom for residual

# calculate mean of y
y_mean = np.mean(Y)
# calculate predicted values using estimated b
y_pred = b_0 + b_1*X[:, 1]

rss = np.sum((y_pred - y_mean)**2)
sse = np.sum((Y.T - y_pred)**2)
mse = sse/MSE_DF
msr = rss/MSR_DF
f_stat = msr/mse
# get F-distribution critical value from table
f_crit = f.ppf(1 - ALPHA, MSR_DF, MSE_DF)
# decide to reject or accept null hypothesis
print(f"F-statistic: {f_stat:.3f}")
print(f"Critical value: {f_crit:.3f}")
if f_stat > f_crit:
  print("Reject null hypothesis (b1 != 0). There is a significant relationship between age and beats per minute under stress.")
else:
  print("Fail to reject null hypothesis (b1 = 0). There is no sufficient evidence to conclude a relationship between age and beats per minute under stress at the significance level of", ALPHA)
