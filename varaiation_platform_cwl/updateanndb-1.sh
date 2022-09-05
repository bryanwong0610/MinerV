#!/bin/bash

# loading VCF file & get file name
file_name=$(basename $1 .vcf)
echo ${file_name}
col_num=$(cat $1 | grep -v "#" | head -n 1 | awk '{print NF}')
echo ${col_num}
if [ $col_num -gt 8 ]
then
        echo "not a typical vcf,convert to generate new vcf and annovar db"
        cat $1 | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"}' > ${file_name}.tmp
        docker run -v /mnt:/mnt -it -w=$PWD harbor.bio-it.cn:5000/library/annovar:latest convert2annovar.pl -format vcf4 --includeinfo ${file_name}.tmp > ${file_name}.avinput
        cat ${file_name}.avinput | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$13}' | tr ";" "\t" > ${file_name}.vcf.tmp
        cat ${file_name}.avinput | head -n 1 |awk '{print $13}' | tr ";" "\t" | tr "=" "\t" > ${file_name}.info.temp
else
        echo "preparing to generate annovar db"
        #docker run -v /mnt:/mnt -it -w=$PWD harbor.bio-it.cn:5000/library/annovar:latest convert2annovar.pl -format vcf4 --includeinfo $1 > ${file_name}.avinput
        #cat ${file_name}.avinput | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$13}' | tr ";" "\t" > ${file_name}.vcf.tmp
        #cat ${file_name}.avinput | head -n 1 |awk '{print $13}' | tr ";" "\t" | tr "=" "\t" > ${file_name}.info.temp
        info_num=$(cat ${file_name}.info.temp | awk '{print NF}')
        echo $info_num
        
        raw_string="#chr"
        for i in seq(1 $info_num)
        do
            $raw_string="$raw_string '--get-INFO' ${i}"
        done   
fi