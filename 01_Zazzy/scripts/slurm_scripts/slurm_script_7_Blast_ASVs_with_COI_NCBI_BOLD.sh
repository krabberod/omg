#!/bin/bash

#SBATCH --account=nn9338k 
#SBATCH --job-name=demult
#SBATCH --partition=bigmem
#SBATCH --time=1-12:0:0
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=128G


## Set up job environment:
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error

module purge
module load BLAST+/2.8.1-foss-2018b

blastn -db /cluster/projects/nn9338k/Luis_metabarding_pipeline/databases/COI/NCBI_BOLD_merged/Both_databases/NCBI_BOLD_derep_2.fasta -query DADA2_noChime_raw.otus -evalue 0.0001 -outfmt "6 qseqid sseqid pident qcovs evalue bitscore length mismatch gapopen qstart qend sstart send" -max_target_seqs 1 -num_threads 8 -out blast_hits_ASVs_to_NCBI_BOLD.txt

