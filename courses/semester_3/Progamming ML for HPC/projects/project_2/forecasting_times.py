import numpy as np

if __name__ == "__main__":
    print("forecasting_times.py is called!") # for debugging

    # Aggregate wall time and CPU time results from different files
    wall_times = []
    cpu_times = []

    for start_idx in range(0, 5000, 1000):
        end_idx = start_idx + 1000
        time_file_path = f"forecasting_results/time_results_{start_idx}_{end_idx}.txt"
        
        with open(time_file_path, "r") as time_file:
            lines = time_file.readlines()
            wall_time = float(lines[0].split(":")[1].strip().split()[0])
            cpu_time = float(lines[1].split(":")[1].strip().split()[0])
            wall_times.append(wall_time)
            cpu_times.append(cpu_time)
    
# Convert lists to numpy arrays
wall_times = np.array(wall_times)
cpu_times = np.array(cpu_times)

# Compute statistics for wall time
wall_mean = np.mean(wall_times)
wall_std = np.std(wall_times)

# Compute statistics for CPU time
cpu_mean = np.mean(cpu_times)
cpu_std = np.std(cpu_times)

# Print statistics
print(f"Wall Time - Mean: {wall_mean:.2f} seconds, Standard Deviation: {wall_std:.2f} seconds")
print(f"CPU Time - Mean: {cpu_mean:.2f} seconds, Standard Deviation: {cpu_std:.2f} seconds")
