################ SCRIPT FUNGUILD to FINAL OTU table
library(tidyverse)
library(openxlsx)

OTU_table_funguild<-read.table("curated_OTU_table_with_tax.guilds.txt",  sep="\t", header = T, fill=F, stringsAsFactors = F, row.names = NULL)
curated_OTU_table<-read.xlsx("OTU_table_lulu_curated.xlsx")
blast_hits<-read.table("blast_hits_with_tax_labels.txt",  sep=" ", header = F, fill=T, stringsAsFactors = F)

OTU_table_funguild_2<-OTU_table_funguild %>% 
  select(OTU_id, Taxon, Taxon.Level, Trophic.Mode, Guild, Growth.Morphology, Trait, Confidence.Ranking, Notes, Citation.Source)

curated_OTU_table_with_tax_and_guild<-curated_OTU_table %>% 
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
  #unite(taxonomy, c("pident","taxonomy"), sep="|") %>% 
  left_join(OTU_table_funguild_2) %>% 
  separate(taxonomy,c("Kingdom", "Phyllum", "Classe", "Order", "Family", "Genus", "Species"), sep=";")

write.xlsx(curated_OTU_table_with_tax_and_guild, "curated_OTU_table_with_tax_and_guild.xlsx")


