srun --ntasks=1 --mem-per-cpu=64G --time=00:15:00 --qos=devel --account=nn9338k --pty bash -i
python /cluster/projects/nn9338k/Luis_metabarding_pipeline/back_ground_scripts/Guilds_v1.0.py -otu curated_OTU_table_with_tax.txt -db fungi
