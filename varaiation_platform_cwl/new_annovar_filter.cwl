class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: new_annovar_filter
baseCommand:
  - Rscript
  - Merge_res.R
inputs:
  - id: Input_file
    type: File?
    inputBinding:
      position: 0
  - id: sample_name_in
    type: string?
    inputBinding:
      position: 1
  - id: maf_threshold
    type: float?
    inputBinding:
      position: 2
outputs:
  - id: sample_name
    type: File?
    outputBinding:
      glob: $(inputs.sample_name_in).filterd.txt
label: New_annovar_filter
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/variminer_r4.0:latest'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: Merge_res.R
        entry: >
          #!/usr/bin/Rscript

          #repos='https://mirrors.ustc.edu.cn/CRAN/'

          #Dowload pkg

          #install.packages('readr',repos=repos)

          #install.packages('dplyr',repos=repos)

          #install.packages('stringr',repos=repos)



          #Library

          library(readr)

          library(dplyr)

          library(stringr)


          #arg

          arg <- commandArgs(TRUE)

          input_file <-arg[1]

          sample_name <- arg[2]

          maf_cutoff <- arg[3]

          # Start filtering 

          a <- read_delim(file = input_file , '\t', escape_double = FALSE,
          trim_ws = TRUE )

          max_freq <- apply(a[,c(13,16,19,22,27,29,31,39)],1,max, na.rm = F )

          a$max_maf <- max_freq

          a_exmpt_CLN <- a %>% filter(str_detect(CLNSIG,'genic'))

          a_exmpt_Inter <- a %>% filter(str_detect(InterVar_automated,'genic'))

          a_num <- a[which(a$max_maf!='.'),]

          a_string <- a[which(a$max_maf=='.'),]

          str(a_num$max_maf)

          a$max_maf[which(a_num$max_maf =='1.')]='1'

          a$max_maf[which(a_num$max_maf =='0.')]='0'

          a_num$max_maf <- as.numeric(a_num$max_maf)

          str(a_num$max_maf)


          table(a$Func.refGene)

          filter_rule_region <- c("intergenic","intron","intronic") # 需要考虑

          filter_res_region_num <- filter(a_num,!(Func.refGene %in%
          filter_rule_region ))

          filter_res_region_string <- filter(a_string,!(Func.refGene %in%
          filter_rule_region ))

          filter_rule_function <- c('synonymous SNV')

          filter_res_function_string <-
          filter(filter_res_region_string,!(ExonicFunc.refGene %in%
          filter_rule_function ))

          filter_res_function_num <-
          filter(filter_res_region_num,!(ExonicFunc.refGene %in%
          filter_rule_function ))


          filter_res_MAF_num <-
          filter_res_function_num[which(filter_res_function_num$max_maf <
          maf_cutoff),]

          filter_res_MAF_string <-
          filter_res_function_string[which(filter_res_function_string$max_maf <
          maf_cutoff),]


          filter_res_MAF <-
          rbind(filter_res_MAF_num,filter_res_MAF_string,a_exmpt_CLN,a_exmpt_Inter)

          final_res <-
          cbind(filter_res_MAF[,1:190],filter_res_MAF[,204:218],filter_res_MAF[,191:203])

          write.table(final_res,paste(sample_name,'.filterd.txt',sep=''),row.names
          = F,sep = '\t',quote = F)
        writable: true
  - class: InlineJavascriptRequirement
