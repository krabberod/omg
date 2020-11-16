# Notes on the Zazzy Pipline by Luis Murgado.
(Tested by AKK mid November 2020)

Initial notes: The pipeline has seven scripts. Some of these can be run interactively on the command line at saga, a few takes more time and should be sent to the slurm queue. The


##Prepare the pipeline:

1) Install the necessary R- packages
  - The packages needed are listed in the scrip R_packages.needed.R
  - I think you need to run this script from within R, since you will be asked about using your own path for packages.

2) Install the necessary programs
```
module purge
module load Anaconda3/2019.03
conda create -n zazzy_metabarcoding_pipeline -c bioconda -c conda-forge cutadapt=2.7 itsx ucsc-fasplit vsearch=2.14.0 --yes
```
The installation packages is not huge, about 350 mb. I recommend that everybody makes their own installation since you then can change versions (if needed) indivdually).

## How to Run the pipeline:
The scipts for the pipleline are in two folders here:
    - /cluster/projects/nn9338k/Luis_metabarding_pipeline/scripts
    - All scripts can be found in *interactive_scripts*.
    - The most time consuming are also prepared as slurm scripts, to be sent to the queueu.
    - /cluster/projects/nn9338k/Luis_metabarding_pipeline/scripts/slurm_scripts.
        - in particular: script 1, 2 and 7.

- See the instructions made by Luis for setting up the


## Running interactively (not neccessary for the slurm-scripts):
If you want to run some of the interactive scripts you need to get ask for some computing resources first. The following command will put you in the queue asking for 8 cpus with 10Gb per cpu for 10 hours. It can be modified if the queue is long and you dont need too much resources:
```
srun --account=nn9338k --mem-per-cpu=10G --time=10:00:00 --cpus-per-task=8 --pty bash -i
```
The interactive session will last as long as you specified queueing time. NB it will also be killed if you close the terminal window

## Loading the programs:
```
module purge
module load Anaconda3/2019.03
conda activate zazzy_metabarcoding_pipeline
```

The script(s) you want to run is copied to the same folder as the fastq-files along with the _batch_files.txt_ (which needs to be set up correctly according to your files).
