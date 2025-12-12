#!/bin/bash -l
#SBATCH -J ensemble_forecasting # Job name
#SBATCH -N 1 # Number of nodes
#SBATCH --array=0-4  # Create 5 jobs
#SBATCH --ntasks-per-node=1 # Number of tasks per node
#SBATCH -c 5 # Cores assigned to each task (5*5=25 total cores)
#SBATCH --time=0-2:00:00 # Time to execute the script
#SBATCH -p interactive # Partition
#SBATCH --mail-user 0230622623@uni.lu # Mail to send notifications
#SBATCH --mail-type BEGIN,END,FAIL # Type of notifications to send

# Load Python
module load lang/Python
pip install jax jaxlib numpy

# Run the forecaster worker with appropriate indices
start_idx=$((SLURM_ARRAY_TASK_ID * 1000)) # with 5 jobs total of 5000 forecasters
end_idx=$((start_idx + 1000)) # with 5 jobs total of 5000 forecasters
srun python3 forecasting_jobs.py $start_idx $end_idx
# Aggreate results and compute statistics (only run once all jobs have finished)
if [ $SLURM_ARRAY_TASK_ID -eq 4 ]; then
    pip install jax jaxlib numpy
    srun python3 forecasting_statistics.py
    srun python3 forecasting_times.py
fi
