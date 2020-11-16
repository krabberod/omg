module purge
module load R/3.6.0-intel-2019a
## the following can be done in the same R session 
R < R_packages.needed.R --no-save
