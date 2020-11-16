#!/bin/bash

#SBATCH --account=nn9338k 
#SBATCH --job-name=demult
#SBATCH --partition=bigmem
#SBATCH --time=2-0:0:0
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=256G


## Set up job environment:
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error

module purge
module load R/3.5.1-intel-2018b
R < script_3_dependency_R_code.R --no-save

