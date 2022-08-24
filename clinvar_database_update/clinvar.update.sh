#!/bin/bash

# loading VCF file & get file name
file_name=$(basename $1 .vcf)
echo ${file_name}
echo "preparing to generate annovar db"
docker run -v /mnt:/mnt -it -w=$PWD harbor.bio-it.cn:5000/library/annovar:latest convert2annovar.pl -format vcf4 --includeinfo $1 -outfile ${file_name}.avinput
docker run -it -v /mnt:/mnt -w=$PWD  anaconda3:biostats1.1.1  python clinvar_generate.py
docker run -it -v /mnt:/mnt -w=$PWD  anaconda3:biostats1.1.1  python exmpt_clinvar_generate.py
perl annovar_idx.pl ${file_name}_exmpt.txt 1000 > ${file_name}_exmpt.txt.idx 
## the number is which the dict size 
## the script was provided by @wangshun1121 which publish on https://github.com/WGLab/doc-ANNOVAR/issues/15
rm  ${file_name}.avinput