# login
ssh -p 8022 azaitsev@access-iris.uni.lu

# make a local directory to store scripts
mkdir -p ~/project_5

# copy scripts from local machine to iris
scp -P 8022 project_5/* azaitsev@access-iris.uni.lu:~/project_5

# copy from local dir on iris to work dir
cp project_5/* /work/projects/ulhpc-tutorials/PS10-Horovod/azaitsev/

# run scripts
sbatch project_5/launch_slurm_llm_1.sh
sbatch project_5/launch_slurm_llm_2.sh
sbatch project_5/launch_slurm_llm_4.sh
sbatch project_5/launch_slurm_llm_4_16.sh
sbatch project_5/launch_slurm_llm_4_32.sh
sbatch project_5/launch_slurm_llm_4_32_adamw.sh

# check running jobs
squeue -u $USER

# check results: traing runtime and evaluation loss
cat 1_llm.txt | grep 'train_runtime'
cat 1_llm.txt | grep 'eval_loss'
cat 2_llm.txt | grep 'train_runtime'
cat 2_llm.txt | grep 'eval_loss'
cat 4_llm.txt | grep 'train_runtime'
cat 4_llm.txt | grep 'eval_loss'
cat 4_16_llm.txt | grep 'train_runtime'
cat 4_16_llm.txt | grep 'eval_loss'
cat 4_16_vit.txt | grep 'train_runtime'
cat 4_16_vit.txt | grep 'eval_loss'
cat 4_16_vit_adamw.txt | grep 'train_runtime'
cat 4_16_vit_adamw.txt | grep 'eval_loss'
