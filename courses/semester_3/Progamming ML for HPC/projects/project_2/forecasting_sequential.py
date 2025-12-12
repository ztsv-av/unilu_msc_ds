import jax # For installation: pip3 install jax, pip3 install jaxlib
import jax.numpy as jnp
import time

X = jnp.array([[0.1, 0.4], [0.1, 0.5], [0.1, 0.6]])  # input example
y = jnp.array([[0.1, 0.7]])  # expected output
W = jnp.array([[0., 1., 0., 1., 0., 1.], [0., 1., 0, 1., 0., 1.]])  # random neural network parameters
b = jnp.array([0.1])  # random neural network bias

################################
# DEFINITION OF THE FORECASTER #
################################

def forecast_1step(X:jnp.array, W:jnp.array, b:jnp.array)->jnp.array:
    # JAX does not support in-place operations like numpy, so use jax.numpy and functional updates.
    # X = X.copy()  # Copy the input data to avoid modifying the original data
    X_flatten = X.flatten()
    y_next = jnp.dot(W, X_flatten) + b
    return y_next

def forecast(horizon:int, X:jnp.array, W:jnp.array, b:jnp.array)->jnp.array:
    result = []

    # Loop over 'horizon' to predict future values
    for t in range(horizon):
        X_flatten = X.flatten()  # Flatten the window for dot product

        # Get the next prediction
        y_next = forecast_1step(X_flatten, W, b)

        # Update X by shifting rows and adding the new prediction in the last row
        X = jnp.roll(X, shift=-1, axis=0)  # Shift rows to the left
        X = X.at[-1].set(y_next)  # Update the last row with the new prediction

        # Append the prediction to results
        result.append(y_next)

    return jnp.array(result)


def forecast_1step_with_loss(params:tuple, X:jnp.array, y:jnp.array)->float:
    W, b = params
    y_next = forecast_1step(X, W, b)
    return jnp.sum((y_next - y) ** 2)

####################################
# DEFINITION OF THE TRAINING LOOP  #
####################################

grad = jax.grad(forecast_1step_with_loss)
def training_loop(grad:callable, num_epochs:int, W:jnp.array, b:jnp.array, X:jnp.array, y:jnp.array)->tuple:
    for i in range(num_epochs):
        delta = grad((W, b), X, y)
        W -= 0.1 * delta[0]
        b -= 0.1 * delta[1]
    return W, b

###########################
# Ensemble of forecasters #
###########################

num_forecaster = 5000
noise_std = 0.1 # the training needs to have different initial conditions for producing different predictions

aggregated_forecasting=[]

# Start time measurement
wall_start_time = time.time()
cpu_start_time = time.process_time()

for i in range(num_forecaster):

    key = jax.random.PRNGKey(i)
    W_noise = jax.random.normal(key, W.shape) * noise_std
    b_noise = jax.random.normal(key, b.shape) * noise_std

    W_init = W + W_noise
    b_init = b + b_noise

    W_trained, b_trained = training_loop(grad, 20, W_init, b_init, X, y)
    y_predicted = forecast(5, X, W_trained, b_trained)

    aggregated_forecasting.append(y_predicted)

# End time measurement
wall_end_time = time.time()
cpu_end_time = time.process_time()
# Calculate and store wall time and CPU time
wall_time = wall_end_time - wall_start_time
cpu_time = cpu_end_time - cpu_start_time
print(f"Wall Time: {wall_time:.2f} seconds\n") # Wall Time: 38.46 seconds
print(f"CPU Time: {cpu_time:.2f} seconds\n") # CPU Time: 37.97 seconds


