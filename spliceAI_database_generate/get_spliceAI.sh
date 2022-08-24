#!/bin/bash

## This data was download from  https://github.com/imgag/megSAP they have already traning the spliceAI result
# /data/download_dbs.sh


## GRCh38
wget https://download.imgag.de/ahsturm1/spliceai_scores_2022_05_24_GRCh38.vcf.gz -O spliceai_scores_2022_05_24_GRCh38.vcf.gz
## GRCh37 
wget https://download.imgag.de/ahsturm1/spliceai_scores_2021_02_03.vcf.gz -O spliceai_scores_2021_02_03.vcf.gz
