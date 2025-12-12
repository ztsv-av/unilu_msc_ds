# QUESTION 4

# Y = a + bX + e, a = 2, b = 3 and 3 follows N(0, sigma^2), sigma^2>=0
# heteroscedasticity - not constant variance

a = 2
b = 3

X <- runif(1000, min = -1, max = 1)

sigma_squared_1 <- 2
sigma_squared_2 <- 2
e_1 <- rnorm(500, mean = 0, sd = sqrt(sigma_squared_1))
e_2 <- rnorm(500, mean = 0, sd = sqrt(sigma_squared_2))

Y_1 = a +b*X
Y_1[1:500] <- Y_1[1:500] + e_1 
Y_1[501:1000] <- Y_1[501:1000] + e_2

plot(
  X, Y_1, 
  main = "Y = 2 + 3X + e(N)",
  xlab = "X",
  ylab = "Y",
  col="purple"
)
abline(a = a, b = b, col = "black")

rate <- 1
e <- rexp(1000, rate = rate)
Y_2 = a +b*X + e

plot(
  X, Y_2, 
  main = "Y = 2 + 3X + e(E)",
  xlab = "X",
  ylab = "Y",
  col="green"
  
)
abline(a = a, b = b, col = "black")

# QUESTION 5
if (!require("fitdistrplus")) install.packages("fitdistrplus")
library(fitdistrplus)

set.seed(123)

rate <- 0.5
X_1 <- rexp(100, rate = rate)
n <- length(X_1)

# H_0: theta (true parameter) = theta_0
# for exponential, MLE for lambda is 1/mean(X)

# Fit the exponential distribution to X_1 using MLE
fit_exp <- fitdist(X_1, "exp", method = "mle")

# Extract the MLE for the rate parameter (lambda)
lambda_mle <- fit_exp$estimate[1]  # Access the first element (lambda)

# Print the MLE
cat("MLE for lambda (rate parameter) of X_1 using fitdistrplus: ", lambda_mle)

lambda_0 = 0.5
fisher = 1/(lambda_mle^2)
cat("Fisher info: ", fisher)
total_fisher = n*fisher
cat("Total Fisher info: ", total_fisher)

t_w = (lambda_mle - lambda_0)^2*total_fisher
cat("Wald statistic for H0: lambda = 0: ", t_w)

df <- 1
p_value <- 1 - pchisq(t_w, df = df, lower.tail = FALSE)
cat("p-value for Wald test: ", p_value)

t_lr = -2*(0-(-n*lambda_mle+lambda_mle*sum(X_1)))
cat("Loglikelihood ration statistic for H0: lambda = 0: ", t_lr)

df <- 1
p_value <- 1 - pchisq(t_lr, df = df, lower.tail = FALSE)
cat("p-value for Likelihood Ratio test: ", p_value)

s_n = (n/lambda_0)-sum(X_1)
fisher_0 = 1/lambda_0
total_fisher_0 = n*fisher_0
t_s = s_n^2/total_fisher

df <- 1
p_value <- 1 - pchisq(t_s, df = df, lower.tail = FALSE)
cat("p-value for Likelihood Ratio test: ", p_value)
