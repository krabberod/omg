install.packages("devtools", repos="https://cran.uib.no/")
50 # Norway CRAN mirror
library(devtools)
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("dada2", version = "3.10") ### this is will take quite some time but all the dependencies will be installed (hopefully)
library(dada2)
packageVersion("dada2")
#### install LULU ### just needs to be installed once!
install_github("tobiasgf/lulu")
##### install openxlsx to save some tables from the DADA2 script
install.packages("openxlsx", dependencies=TRUE, repos="https://cran.uib.no/")
library(openxlsx)
