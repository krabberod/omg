#!/bin/bash
################################################
######### METABARCODING PIPELINE IN SAGA #######
################################################
########### BY LUIS MORGADO ####################
############ version 1.0 #######################
################################################
################################################
####### THIS IS THE INSTALATION PART ###########
################################################
### create an environment with #################
### cutadapt, ITSx and fasplit #################
#### just needs to be created one time #########
#### cutadapt is to demultiplex ################
####and ITSx is to select just the ITS region of interest, either in organism (e.g., fungi) or region of gene (e.g., ITS2), and fassplit is to make ITSx to run faster #########

module purge
module load Anaconda3/2019.03
#conda create -n metabarcoding -c bioconda -c conda-forge cutadapt=1.13 itsx ucsc-fasplit --yes
conda create -n zazzy_metabarcoding_pipeline -c bioconda -c conda-forge cutadapt=2.7 itsx ucsc-fasplit vsearch=2.14.0 --yes # new cutadapt version requires different script
conda init bash

#### load the software
conda activate zazzy_metabarcoding_pipeline
conda 
#conda activate metabarcoding
# if it does not work try
#source activate metabarcoding_2
####source activate metabarcoding

### test if it's working
cutadapt --version
ITSx 
faSplit

#### install DADA2 ### just needs to be installed once!
module purge
module load R/3.5.1-intel-2018b
## the following can be done in the same R session 
R < R_packages.needed.R --no-save

echo "Zazzy pipeline is up and running"
echo "the next time you need to run the pipeline type:" 
echo "conda activate zazzy_metbarcoding_pipeline"
