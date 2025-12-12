# (1)
n <- 100
a <- sqrt(pi/2)
x <- runif(n, min=-a, max=a)

# (2)
alpha <- 0.05
ecdf_func <- function(data) { 
  Length <- length(data) 
  sorted <- sort(data) 
  
  ecdf <- rep(0, Length) 
  for (i in 1:n) { 
    ecdf[i] <- sum(sorted <= data[i]) / Length 
  } 
  return(ecdf) 
} 
ecdf(x)
ecdf_x <- ecdf_func(x) 
ecdf_normal <- pnorm(x)
d_n <- max(abs(ecdf_x - ecdf_normal))
c_value <- 1.35810/10
if (d_n > c_value) {
  cat("Reject the null hypothesis. The distribution might be normal.\n")
} else {
  cat("Fail to reject the null hypothesis. The distribution is uniform.\n")
}

# (3)
ks_test <- function(n, a, alpha=0.05) {
  x <- runif(n, min=-a, max=a)
  ecdf_x <- ecdf_func(x)
  d_n <- max(abs(ecdf_x - pnorm(x)))
  if (n == 5){
    c_value <- 0.56372
  }
  else if (n == 10){
    c_value <- 0.40925
  }
  else if (n == 50){
    c_value <- 0.18845
  }
  else {
    c_value <- 1.35810/sqrt(n)
  }
  return(ifelse(d_n > c_value, 1, 0))
}
sample_sizes <- c(5, 10, 50, 100, 500)
num_simulations <- 1000
empirical_power <- numeric(length(sample_sizes))
for (i in seq_along(sample_sizes)) {
  n <- sample_sizes[i]
  reject_count <- replicate(num_simulations, ks_test(n, alpha))
  empirical_power[i] <- mean(reject_count)
}
cat("Sample Size\tEmpirical Power\n")
for (i in seq_along(sample_sizes)) {
  cat(sample_sizes[i], "\t\t", empirical_power[i], "\n")
}

# (4)
n=500
x <- runif(n, min=-a, max=a)
likelihood_normal <- function(data) {
  out <- n*log(1/sqrt(2*pi))-1/2*sum(data^2)
  return(out)
}
# Likelihood function for uniform distribution
likelihood_uniform <- function(data, a) {
  out <- n*log(1/(2*a))
  return(out)
}
ratio<- likelihood_normal(x)/likelihood_uniform(x, a)
threshold <- 1
if (ratio < threshold) {
  cat("Reject the null hypothesis. The distribution is uniform.\n")
} else {
  cat("Fail to reject the null hypothesis. The distribution normal.\n")
}

# (5)
lrt_test <- function(n, a, threshold) {
  x <- runif(n, min=-a, max=a)
  l_n <- likelihood_normal(x)
  l_u <- likelihood_uniform(x, a)
  ratio <- l_n/l_u
  return(ifelse(ratio > threshold, 1, 0))
}
sample_sizes <- c(5, 10, 50, 100, 500)
num_simulations <- 1000
empirical_power <- numeric(length(sample_sizes))
for (i in seq_along(sample_sizes)) {
  n <- sample_sizes[i]
  reject_count <- replicate(num_simulations, lrt_test(n, a, 1))
  empirical_power[i] <- mean(reject_count)
}
cat("Sample Size\tEmpirical Power\n")
for (i in seq_along(sample_sizes)) {
  cat(sample_sizes[i], "\t\t", empirical_power[i], "\n")
}

# (6)
empirical_power <- numeric(length(sample_sizes))
for (i in seq_along(sample_sizes)) {
  n <- sample_sizes[i]
  e <- 1/sqrt(n)
  b <- a + e
  reject_count <- replicate(num_simulations, ks_test(n, b, alpha))
  empirical_power[i] <- mean(reject_count)
}
cat("Sample Size\tEmpirical Power\n")
for (i in seq_along(sample_sizes)) {
  cat(sample_sizes[i], "\t\t", empirical_power[i], "\n")
}

empirical_power <- numeric(length(sample_sizes))
for (i in seq_along(sample_sizes)) {
  n <- sample_sizes[i]
  e <- 1/sqrt(n)
  b <- a + e
  reject_count <- replicate(num_simulations, lrt_test(n, b, 1))
  empirical_power[i] <- mean(reject_count)
}
cat("Sample Size\tEmpirical Power\n")
for (i in seq_along(sample_sizes)) {
  cat(sample_sizes[i], "\t\t", empirical_power[i], "\n")
}