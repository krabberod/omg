################ SCRIPT BLAST to FUNGUILD
library(tidyverse)
library(openxlsx)

curated_OTU_table<-read.xlsx("OTU_table_lulu_curated.xlsx")
blast_hits<-read.table("blast_hits_with_tax_labels.txt",  sep=" ", header = F, fill=T, stringsAsFactors = F)

blast_hits2<-blast_hits %>% 
  dplyr::rename(OTUid=V1,  
                pident=V2, 
                qcovs=V3, 
                evalue=V4, 
                bitscore=V5,
                length=V6,
                mismatch=V7, 
                gapopen=V8, 
                qstart=V9, 
                qend=V10, 
                sstart=V11, 
                send=V12,
                taxonomy=V13) %>% 
  separate(OTUid,c("OTUid"),sep = ";")

curated_OTU_table_with_tax<-curated_OTU_table %>% 
  left_join(blast_hits2) %>%
  separate(taxonomy,c("Accession_nr", "taxonomy","Species_hypothesis"), sep="[|]") %>% 
  mutate(taxonomy= gsub("k__", "", taxonomy),
         taxonomy= gsub("p__", "", taxonomy),
         taxonomy= gsub("c__", "", taxonomy),
         taxonomy= gsub("o__", "", taxonomy),
         taxonomy= gsub("f__", "", taxonomy),
         taxonomy= gsub("g__", "", taxonomy),
         taxonomy= gsub("s__", "", taxonomy)) %>%
  dplyr::rename(OTU_id=OTUid) %>% 
  select(-Accession_nr,
         -Species_hypothesis, 
         -pident, 
         -qcovs, 
         -evalue, 
         -bitscore,
         -length,
         -mismatch, 
         -gapopen, 
         -qstart, 
         -qend, 
         -sstart, 
         -send) %>% 
  mutate(taxonomy= replace_na(taxonomy, "*")) %>% 
  select(-taxonomy,taxonomy)
  
write.table(curated_OTU_table_with_tax, "curated_OTU_table_with_tax.txt", quote = F, sep="\t", eol = "\r", row.names=F)

