SETTING VARIABLES
VSEARCH=$(which vsearch)
SPLITS=40
mkdir uncut_fasta

TMP_FASTA1=$(mktemp)


for FILE in `ls S[0-9][0-9][0-9].fas` ; do

        cat "${FILE}" > uncut_fasta/"${FILE}"

        faSplit sequence "${FILE}" $SPLITS splitted

        for f in `ls splitted*` ; do
                ITSx -i $f --complement F -t F --preserve T -o $f.out &
        done

        wait

        cat splitted*ITS2.fasta >> "${TMP_FASTA1}"

        rm splitted*

        # Dereplicate (vsearch)
        "${VSEARCH}" --derep_fulllength "${TMP_FASTA1}" \
             --sizein \
             --sizeout \
             --fasta_width 0 \
             --minuniquesize 1 \
             --relabel_sha1 \
             --output "${FILE}" > /dev/null

rm "${TMP_FASTA1}"
done 