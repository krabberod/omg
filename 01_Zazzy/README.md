# Notes on the Zazzy Pipline by Luis Morgado.
(Tested by AKK mid November 2020)

Initial notes: The pipeline has seven scripts. Some of these can be run interactively on the command line at saga, a few takes more time and should be sent to the slurm queue.


## Prepare the pipeline:

1) Install the necessary R- packages
  - The packages needed are listed here: [R_packages.needed.R](01_Zazzy/install_Zazzy_pipeline/R_packages.needed.R)
  - I think you need to run this script from within R, since you will be asked about using your own path for packages.

2) Install the necessary programs
```
module purge
module load Anaconda3/2019.03
conda create -n zazzy_metabarcoding_pipeline -c bioconda -c conda-forge cutadapt=2.7 itsx ucsc-fasplit vsearch=2.14.0 --yes
```
The conda installation is not huge, about 350 mb. I think it is easiest that everybody makes their own installation since you then can change versions (if needed) individually).   
BUT: DO NOT COPY DATABASE FOLDER!


R dependencies might differ between versions. I had to change the *dada2* installation to version to make it work with R/3.5.1-intel-2018b (which is loaded by default in the scripts by Luis):
```
BiocManager::install("dada2", version = "3.8")
```


## How to Run the pipeline:
The srcipts for the pipleline are in two sub folders of:
    - /cluster/projects/nn9338k/Luis_metabarding_pipeline/scripts
    - All scripts can be found in *interactive_scripts*.
    - The most time consuming are also prepared as slurm scripts, to be sent to the queueu.
    - /cluster/projects/nn9338k/Luis_metabarding_pipeline/scripts/slurm_scripts.
        - in particular script 1, 2 and 7.

- See the instructions made by Luis for setting up the


## Running interactively (not neccessary for the slurm-scripts):
If you want to run some of the interactive scripts you need to get ask for some computing resources first. The following command will put you in the queue asking for 8 cpus with 10Gb per cpu for 10 hours. It can be modified if the queue is long and you dont need too much resources:
```
srun --account=nn9338k --mem-per-cpu=10G --time=10:00:00 --cpus-per-task=8 --pty bash -i
```
The interactive session will last as long as you specified queueing time. NB it will also be killed if you close the terminal window.

### Loading the programs:
```
module purge
module load Anaconda3/2019.03
conda activate zazzy_metabarcoding_pipeline
```
Copy the scripts you want to run to fastq-files along with the _batch_files.txt_ (which needs to be set up correctly according to your project).

NB: The numbering of the scripts are not in agreement. The slurm-script called "slurm_script_2_run_DADA..." corresponds to the interactive "script_3_run_DADA...".

### Script 1
Recommended to send to the slurm queue. The command is simple enough:
```
sbatch slurm_script_1_dem.sh
```
You should now see:
```
Submitted batch job <jobid>
```
You can check the status of the job:
```
scontrol show <jobid>
```
Alternatively, you can check all your current running jobs:
```
squeue -u <your_username>
```
_Runtime on test data: 34 mins._

### Script 2
### Script 3
run dada2 (called scipt 2 in the slurm folder)
Both the _script_3_run_DADA2_v1.12.sh_ and _slurm_script_2_runDADA2_v1.12.sh_ are master scripts that starts R and runs  *script_3_dependency_R_code.R* .  

*NB* check the version of R in script_3_run_DADA2_v1.12.sh or slurm_script_2_runDADA2_v1.12.sh. The version which is loaded deafult is 3.5.2-inte-2018b. Change this to match the version you are using of R, the version for which dada2 is installed.  
```
module purge
module load R/3.5.1-intel-2018b # <- Change this!
R < script_3_dependency_R_code.R --no-save
```

### Script 4
- Copy script_4_parallel_itsx_fungi.sh to the folder with .fas files.
- Alt. ask for interactive resources. This script is quite fast so you can ask for place in the development queue (for short jobs) for example:
```
srun --account=nn9525k --mem-per-cpu=10G --time=0:30:00 --qos=devel --cpus-per-task=4 --pty bash -i
```
- Load the conda enviromnet for the pipleline (if it's not already loaded).
- Run the script (by adding ./ in front of the name of the script)
```
./script_4_parallel_itsx_fungi.sh
```
If you get Permission denied you need to change the permission of the file:
```
chmod +x script_4_parallel_itsx_fungi.sh
```
Read more about permissions here: https://www.pluralsight.com/blog/it-ops/linux-file-permissions

BUG: I got an error form this script.


### Script 5
script_5_VSEARCH_cluster.sh
### Script 6
script_6_LULU.sh
### Script 7
