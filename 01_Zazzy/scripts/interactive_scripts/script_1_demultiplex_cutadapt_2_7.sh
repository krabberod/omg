mkdir DADA2_AS
mkdir DADA2_SS

while read INPUT_R1 INPUT_R2 FASTA_FWD FASTA_REV ; do

CUR_PATH=$(pwd)

# Define binaries, temporary files and output files
CUTADAPT="$(which cutadapt)"
    # Trim tags, forward & reverse primers sense simultaneously # this sets the options at least 26 bp overlap between query and target, no indels and minumum length of 100bp
        ${CUTADAPT} -g file:"${FASTA_FWD}" -G file:"${FASTA_REV}" -O 26 -e 0 --no-indels -m 100 -o {name}_SS_R1.fastq.gz -p {name}_SS_R2.fastq.gz "${INPUT_R1}" "${INPUT_R2}" | tee "${FASTA_FWD}_SS.log" 
    # Trim tags, forward & reverse primers anti-sense simultaneously     # this sets the options at least 26 bp overlap between query and target, no indels and minumum length of 100bp    
        ${CUTADAPT} -g file:"${FASTA_REV}" -G file:"${FASTA_FWD}" -O 26 -e 0 --no-indels -m 100 -o {name}_AS_R1.fastq.gz -p {name}_AS_R2.fastq.gz unknown_SS_R1.fastq.gz unknown_SS_R2.fastq.gz | tee "${FASTA_REV}_AS.log"
    
        mv *_SS*fastq.gz DADA2_SS
        mv *_AS*fastq.gz DADA2_AS
        rm -r DADA2_SS/unknown*
        rm -r DADA2_AS/unknown*
        
done < batch_file.txt

		cat *SS.log > SS_log.txt
		cat *AS.log > AS_log.txt
		mv SS_log.txt DADA2_SS
		mv AS_log.txt DADA2_AS
		rm *.log


