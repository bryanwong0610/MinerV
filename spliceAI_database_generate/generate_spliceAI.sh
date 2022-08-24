## This script is to generate the databases for annovar

## cause the spliceAI was a vcf format, so we need to convert this result to a tab-split format txt

## In annovar, the filter-based annotation file contained these colums, which headr is like 
##     #Chr    Start    End    Ref    Alt    <annotation_info_1>    <annotation_info_2>    <etc...>

## so we need to remove the tag info of vcf and extract the info that we need first
## for https://github.com/mobidic/update_annovar_db as reference, we think the first thing to do is 
## handling the problem of left alignment of coordinates in vcf which quite different from annovar itself's algorithm


## get vcf and convert it to avinput 
file_name=$(basename $1 .vcf)
echo ${file_name}
echo "preparing to generate annovar db"
docker run -v /mnt:/mnt -it -w=$PWD harbor.bio-it.cn:5000/library/annovar:latest convert2annovar.pl -format vcf4 --includeinfo $1 -outfile ${file_name}.avinput
cat ${file_name}.avinput | awk '{print $1\t$2\t$3\t$4$5\t$13}' | sed 's/chr//' \
    | sed '1i\#Chr\tStart\tEnd\tRef\tAlt\tSplice_AI' >  ${file_name}.txt
perl annovar_idx.pl ${file_name}.txt 1000 > ${file_name}.txt.idx 
## the number is which the dict size 
## the script was provided by @wangshun1121 which publish on https://github.com/WGLab/doc-ANNOVAR/issues/15
rm {file_name}.avinput