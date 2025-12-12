import jax
import jax.numpy as jnp
import numpy as np
import sys
import os
import multiprocessing
import time

# Input data for forecasting
X = jnp.array([[0.1, 0.4], [0.1, 0.5], [0.1, 0.6]])  # input example
y = jnp.array([[0.1, 0.7]])  # expected output
W = jnp.array([[0., 1., 0., 1., 0., 1.], [0., 1., 0, 1., 0., 1.]])  # random neural network parameters
b = jnp.array([0.1])  # random neural network bias
noise_std = 0.1  # the training needs to have different initial conditions for producing different predictions
num_processes = 4

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
grad = jax.grad(forecast_1step_with_loss) # gradients

####################################
# DEFINITION OF THE TRAINING LOOP  #
####################################

def training_loop(grad:callable, num_epochs:int, W:jnp.array, b:jnp.array, X:jnp.array, y:jnp.array)->tuple:
    for i in range(num_epochs):
        delta = grad((W, b), X, y)
        W -= 0.1 * delta[0]
        b -= 0.1 * delta[1]
    return W, b

###########################
# ENSEMBLE OF FORECASTERS #
###########################

# Forecasting function to parallel across multiple processes
def process_forecaster(i):
    key = jax.random.PRNGKey(i)  # `i` random seed
    W_noise = jax.random.normal(key, W.shape) * noise_std
    b_noise = jax.random.normal(key, b.shape) * noise_std

    W_init = W + W_noise
    b_init = b + b_noise

    W_trained, b_trained = training_loop(grad, 20, W_init, b_init, X, y)
    y_predicted = forecast(5, X, W_trained, b_trained)

    return y_predicted

def process_forecaster_with_cpu_time(i):
    # Start CPU time
    start_time = time.process_time()
    # Call process_forecaster
    result = process_forecaster(i)
    # Record CPU time
    end_time = time.process_time()
    cpu_time = end_time - start_time
    # Return both the result and CPU time
    return result, cpu_time

def run_forecasting():
    # Accept start and end indices for the chunk (forecasters indicies)
    start_idx = int(sys.argv[1])
    end_idx = int(sys.argv[2])

    # Start wall time measurement
    wall_start_time = time.time()

    # Measure CPU time of the main process
    cpu_start_time_main = time.process_time()

    # Define pool of processes to run parallel forecasting for each forecaster
    with multiprocessing.Pool(processes=num_processes) as pool:
        results = pool.map(process_forecaster_with_cpu_time, range(start_idx, end_idx))

    # End wall time measurement
    wall_end_time = time.time()
    # End CPU time measurement for the main process
    cpu_end_time_main = time.process_time()

    # Separate results and CPU times
    aggregated_forecasting, cpu_times = zip(*results)
    aggregated_forecasting = np.array(aggregated_forecasting)

    # Calculate total CPU time
    total_cpu_time_children = sum(cpu_times)/num_processes
    total_cpu_time_main = cpu_end_time_main - cpu_start_time_main
    total_cpu_time = total_cpu_time_main + total_cpu_time_children

    # Calculate wall time
    wall_time = wall_end_time - wall_start_time

    # Store results for (start_idx, end_idx) forecasters
    if not os.path.exists("forecasting_results"):
        os.makedirs("forecasting_results")
    np.save(f"forecasting_results/results_{start_idx}_{end_idx}.npy", aggregated_forecasting)

    with open(f"forecasting_results/time_results_{start_idx}_{end_idx}.txt", "w") as time_file:
        time_file.write(f"Wall Time: {wall_time:.2f} seconds\n")
        time_file.write(f"CPU Time: {total_cpu_time:.2f} seconds\n")

if __name__ == "__main__":
    run_forecasting()
