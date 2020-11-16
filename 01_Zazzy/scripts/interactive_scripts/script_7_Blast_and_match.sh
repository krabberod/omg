module purge
module load BLAST+/2.8.1-foss-2018b

blastn -db /cluster/projects/nn9338k/Luis_metabarding_pipeline/databases/curatedPR_database_trimmed.fas -query OTU_centroids2 -evalue 0.0001 -outfmt "6 qseqid sseqid pident qcovs evalue bitscore length mismatch gapopen qstart qend sstart send" -max_target_seqs 1 -num_threads 8 -out blast_hits.txt

module purge
module load R/3.5.1-intel-2018b

R < script_7_matching_blast_with_OTU_table.R --no-save 
