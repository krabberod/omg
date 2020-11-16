library(tidyverse)
library(openxlsx)

curated_OTU_table<-read.xlsx("OTU_table_lulu_curated.xlsx")
blast_hits<-read.csv("blast_hits.txt", sep="\t", header = F)
blast_hits2<-blast_hits %>% 
  dplyr::rename(OTUid=V1, taxonomy=V2, pident=V3, qcovs=V4, evalue=V5, bitscore=V6, 
         length=V7, mismatch=V8, gapopen=V9, qstart=V10, qend=V11, sstart=V12, send=V13)
curated_OTU_table_with_tax<-curated_OTU_table %>% 
  left_join(blast_hits2)
write.xlsx(curated_OTU_table_with_tax, "curated_OTU_table_with_taxanomy.xlsx")

