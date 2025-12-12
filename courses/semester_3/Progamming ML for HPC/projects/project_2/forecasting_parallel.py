import jax # For installation: pip3 install jax, pip3 install jaxlib
import jax.numpy as jnp
import time
import multiprocessing

# Input data for forecasting
X = jnp.array([[0.1, 0.4], [0.1, 0.5], [0.1, 0.6]])  # input example
y = jnp.array([[0.1, 0.7]])  # expected output
W = jnp.array([[0., 1., 0., 1., 0., 1.], [0., 1., 0, 1., 0., 1.]])  # random neural network parameters
b = jnp.array([0.1])  # random neural network bias
num_forecaster = 5000 # number of forecasters
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
# Ensemble of forecasters #
###########################

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
    start_time = time.process_time()
    # Call process_forecaster
    result = process_forecaster(i)
    end_time = time.process_time()
    cpu_time = end_time - start_time
    # Return both the result and CPU time
    return result, cpu_time

def run_forecasting():
    # Start wall time measurement
    wall_start_time = time.time()

    # Measure CPU time of the main process
    cpu_start_time_main = time.process_time()

    # Use multiprocessing to parallelize the forecasting tasks
    with multiprocessing.Pool(processes=num_processes) as pool:
        # Use the modified function that returns CPU time
        results = pool.map(process_forecaster_with_cpu_time, range(num_forecaster))

    # End wall time measurement
    wall_end_time = time.time()
    # End CPU time measurement for the main process
    cpu_end_time_main = time.process_time()

    # Separate results and CPU times
    aggregated_forecasting, cpu_times = zip(*results)

    # Calculate total CPU time
    total_cpu_time_children = sum(cpu_times)/num_processes
    total_cpu_time_main = cpu_end_time_main - cpu_start_time_main
    total_cpu_time = total_cpu_time_main + total_cpu_time_children

    # Calculate wall time
    wall_time = wall_end_time - wall_start_time

    # Print times
    print(f"Wall Time: {wall_time:.2f} seconds")
    print(f"CPU Time (Main Process): {total_cpu_time_main:.2f} seconds")
    print(f"CPU Time (Child Processes): {total_cpu_time_children:.2f} seconds")
    print(f"Total CPU Time: {total_cpu_time:.2f} seconds")

if __name__ == "__main__":
    run_forecasting()
