# Variables

- 5000 forecasters.
- 1 node.
- 5 jobs (1000 forecasters for each job).
- 5 cores per job (25 cores total).
- 4 cores for parallelization (20 cores total).

# Files

- `forecasting_jobs.py`: Ensemble forecasting using SLURM jobs and parallelization in each job. Uses 5 jobs, 4 cores each (total 20 cores, but we allocate 25 cores for safety).
- `forecasting_parallel.py`: Ensemble forecasting with parallelization only
- `forecasting_sequential.py`: Ensemble sequential forecasting, slightly modified original script.
- `forecasting_statistics.py`: Used for `forecasting_jobs.py`; aggreates forecasting results from all jobs (stored in separate files) and computes statitics for forecasts: mean, median, standard deviation, 5th percentile, 95th percentile.
- `forecasting_times.py`: Used for `forecasting_jobs.py`; aggregates wall time and CPU time results from different files from all jobs (stored in separate files) and computes statitics for these times: mean and standard deviation,
- `run_forecasting.slurm`: Allocates resources for HPC, creates jobs, assigns forecaster indexes and calls `forecasting_jobs.py` for each job. After all jobs finish, calls `forecasting_statistics.py` and `forecasting_times.py`.

# Results

## Sequential

- Wall Time: 334.89 seconds.
- CPU Time: 334.52 seconds.

## Parallel

- Wall Time: 123.17 seconds.
- Total CPU Time (mean of CPU times per process): 120.23 seconds.

## Jobs & Parallel

- Mean Prediction: 
```
    [[0.10918222 0.6908175 ] 
    [0.2849728  0.9722714 ] 
    [0.5416403  1.4277105 ]
    [0.98153037 2.2264762 ]
    [1.8064601  3.7108335 ]]
```
- Median Prediction: 
```
    [[0.10919091 0.69080937]
    [0.284967   0.97224283]
    [0.5406905  1.427799  ]
    [0.9777038  2.223302  ]
    [1.7947545  3.6983738 ]]
```
- Standard Deviation: 
```
    [[0.00192012 0.00192012]
    [0.01074926 0.01139928]
    [0.0370691  0.04214301]
    [0.09473313 0.12140258]
    [0.21914582 0.310242  ]]
```
- 5th Percentile: 
```
    [[0.10597918 0.6876123 ]
    [0.26744672 0.95375821]
    [0.4830503  1.36030653]
    [0.8344852  2.03451651]
    [1.46746479 3.2281215 ]]
```
- 95th Percentile: 
```
    [[0.11238778 0.69402101]
    [0.30248668 0.99068165]
    [0.60491512 1.49778273]
    [1.14282214 2.42779185]
    [2.18349829 4.23087006]]
```
- Wall Time (jobs): 
  - Mean: 23.76 seconds.
  - Standard Deviation: 0.29 seconds.
- Total CPU Time (mean of CPU times per process and jobs):
  - Mean: 23.72 seconds.
  - Standard Deviation: 0.48 seconds.
