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
module load BLAST+/2.8.1-foss-2018b

blastn -db /cluster/projects/nn9338k/Luis_metabarding_pipeline/databases/UNITE_INSD_2020/unite_insd_2020_derep_sha_short_names.fas -query pipeline_Zazzy.centroids -evalue 0.0001 -outfmt "6 qseqid sseqid pident qcovs evalue bitscore length mismatch gapopen qstart qend sstart send" -max_target_seqs 1 -num_threads 8 -out blast_hits.txt

awk '{ print $2 " " $1 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10 " " $11 " " $12 " " $13}' blast_hits.txt | sort > blast_hits_sorted.txt
join -1 1 -1 1 blast_hits_sorted.txt /cluster/projects/nn9338k/Luis_metabarding_pipeline/databases/UNITE_INSD_2020/sha_labels_matching_tax.txt | cut -f1,1 -d " " --complement > blast_hits_with_tax_labels.txt

module purge
module load R/3.5.1-intel-2018b

R < script_7.2_matching_blast_with_OTU_table_for_funguild.R --no-save 
