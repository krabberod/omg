#!/bin/bash

#SBATCH --account=nn9338k
#SBATCH --job-name=TaxGuild
#SBATCH --qos=devel
#SBATCH --time=02:0:0
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G

## Set up job environment:
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module purge

module load R/3.5.1-intel-2018b

R < script_9_FUNGUILD_to_FINAL_OTU_table.R --no-save
