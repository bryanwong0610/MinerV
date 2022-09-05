class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: merge_exomiser_annovar_res
baseCommand:
  - Rscript
  - merge_result.R
inputs:
  - id: default_col
    type: 'string[]?'
    inputBinding:
      position: 2
      itemSeparator: ' '
  - id: exomiser_res
    type: File?
    inputBinding:
      position: 0
  - id: annovar_res
    type: File?
    inputBinding:
      position: 1
  - id: sample_name
    type: string?
    inputBinding:
      position: 3
outputs:
  - id: result_data
    type: File?
    outputBinding:
      glob: '*Final_variation_result.csv'
label: merge_exomiser_annovar_res
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/variminer_r4.0:latest'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: merge_result.R
        entry: >+

          suppressMessages(library(dplyr))

          suppressMessages(library(stringr))

          suppressMessages(library(readr))


          args <- commandArgs(TRUE)


          exomiser_res <- args[1]

          annovar_res <- args[2]

          default_select_name <- args[3]

          sample_name <- args[4]  


          #prepare file to use

          exomiser_res <- read.csv(exomiser_res)

          annovar_res <- read_delim(annovar_res,'\t',escape_double = FALSE,
          trim_ws = TRUE)

          colnames(exomiser_res)[1:5] <-
          c('Chr','Start','Ref','Alt','Gene_name')

          exomiser_res$Chr <- paste('chr',exomiser_res$Chr,sep = '')

          usd_result <- merge(exomiser_res,annovar_res,by.x =
          c('Chr','Start'),by.y = c('Chr','Otherinfo5'))
            #calculate depth
          Depth <-
          as.data.frame(str_split(usd_result$Otherinfo13,":",n=5,simplify = T))

          colnames(Depth) <-
          c('Genotype','Allele_Depth','Depth','Genotype_Quality','provieds_the_likelihoods_of_the_given_genotypes')

          allele_depth <-
          as.data.frame(str_split(Depth$Allele_Depth,',',n=2,simplify = T))

          Depth <- cbind(Depth,allele_depth)

          Depth$Depth <- as.integer(Depth$Depth)

          Depth$V1 <- as.integer(Depth$V1)

          Depth$WT_ratio <- Depth$V1/Depth$Depth

          Depth$Hom_Het<- 'Hom'

          Depth$Hom_Het[which(Depth$Genotype == '0/1')] = 'Het'

          Depth$Hom_Het[which(Depth$Genotype == '1/2')] = 'Het'

          table(Depth$Hom_Het)


          sub_res_res_1 <- cbind(usd_result,Depth[,c(1:3,8:9)])


          # change intervar result format

          {sub_res_res_1$PVS1 <- paste('PVS1: ',sub_res_res_1$PVS1,sep = '')
            sub_res_res_1$PS1 <- paste('PS1: ',sub_res_res_1$PS1,sep = '')
            sub_res_res_1$PS2 <- paste('PS2: ',sub_res_res_1$PS2,sep = '')
            sub_res_res_1$PS3 <- paste('PS3: ',sub_res_res_1$PS3,sep = '')
            sub_res_res_1$PS4 <- paste('PS4: ',sub_res_res_1$PS4,sep = '')
            sub_res_res_1$PM1 <- paste('PM1: ',sub_res_res_1$PM1,sep = '')
            sub_res_res_1$PM2 <- paste('PM2: ',sub_res_res_1$PM2,sep = '')
            sub_res_res_1$PM3 <- paste('PM3: ',sub_res_res_1$PM3,sep = '')
            sub_res_res_1$PM4 <- paste('PM4: ',sub_res_res_1$PM4,sep = '')
            sub_res_res_1$PM5 <- paste('PM5: ',sub_res_res_1$PM5,sep = '')
            sub_res_res_1$PM6 <- paste('PM6: ',sub_res_res_1$PM6,sep = '')
            sub_res_res_1$PP1 <- paste('PP1: ',sub_res_res_1$PP1,sep = '')
            sub_res_res_1$PP2 <- paste('PP2: ',sub_res_res_1$PP2,sep = '')
            sub_res_res_1$PP3 <- paste('PP3: ',sub_res_res_1$PP3,sep = '')
            sub_res_res_1$PP4 <- paste('PP4: ',sub_res_res_1$PP4,sep = '')
            sub_res_res_1$PP5 <- paste('PP5: ',sub_res_res_1$PP5,sep = '')
            sub_res_res_1$BA1 <- paste('BA1: ',sub_res_res_1$BA1,sep = '')
            sub_res_res_1$BS1 <- paste('BS1: ',sub_res_res_1$BS1,sep = '')
            sub_res_res_1$BS2 <- paste('BS2: ',sub_res_res_1$BS2,sep = '')
            sub_res_res_1$BS3 <- paste('BS3: ',sub_res_res_1$BS3,sep = '')
            sub_res_res_1$BS4 <- paste('BS4: ',sub_res_res_1$BS4,sep = '')
            sub_res_res_1$BP1 <- paste('BP1: ',sub_res_res_1$BP1,sep = '')
            sub_res_res_1$BP2 <- paste('BP2: ',sub_res_res_1$BP2,sep = '')
            sub_res_res_1$BP3 <- paste('BP3: ',sub_res_res_1$BP3,sep = '')
            sub_res_res_1$BP4 <- paste('BP4: ',sub_res_res_1$BP4,sep = '')
            sub_res_res_1$BP5 <- paste('BP5: ',sub_res_res_1$BP5,sep = '')
            sub_res_res_1$BP6 <- paste('BP6: ',sub_res_res_1$BP6,sep = '')
            sub_res_res_1$BP7 <- paste('BP7: ',sub_res_res_1$BP7,sep = '')}
          {sub_res_res_1$InterVar_detail <-
          paste(sub_res_res_1$PVS1,';',sub_res_res_1$PS1,';',sub_res_res_1$PS2,';',sub_res_res_1$PS3,';'
                                                  ,sub_res_res_1$PS4,';',sub_res_res_1$PM1,';',sub_res_res_1$PM2,';',sub_res_res_1$PM3,';'
                                                  ,sub_res_res_1$PM4,
                                                  ';',sub_res_res_1$PM5,';',sub_res_res_1$PM6,';',sub_res_res_1$PP1,';',sub_res_res_1$PP2,';'
                                                  ,sub_res_res_1$PP3,
                                                  ';',sub_res_res_1$PP4,';',sub_res_res_1$PP5,';',sub_res_res_1$BA1,';',sub_res_res_1$BS1,';',
                                                  sub_res_res_1$BS2,';',sub_res_res_1$BS3,';',sub_res_res_1$BS4,';',sub_res_res_1$BP1,';',
                                                  sub_res_res_1$BP2,';',sub_res_res_1$BP3,';',sub_res_res_1$BP4,';',sub_res_res_1$BP5,';',
                                                  sub_res_res_1$BP6,';',sub_res_res_1$BP7,sep = ' ')}
          sub_res_res_1$Variation_detail <-
          paste(sub_res_res_1$Ref.x,'>',sub_res_res_1$Alt.x,sep='')

          colnames(sub_res_res_1)

          colnames(sub_res_res_1)[c(5,15,14,17,18,19)] <-
          c('Exomiser_gene','Gene_name','Variation_region','Variation_function','AAChange','dbSNP')


          #select result col

          default_arguments <- unlist(str_split(default_select_name,' '))

          #custom_arguments <- unlist(str_split(custom_select_name,' '))


          final_res <- sub_res_res_1 %>% select(default_arguments)

          col_nm <- colnames(final_res)

          for (i in col_nm){
              final_res[[i]][which(final_res[[i]]=='.')] = ''
              final_res[["End"]] <- as.integer(final_res[["End"]])
              final_res[[i]] <- as.character(final_res[[i]])
          }

          write.csv(final_res,paste(sample_name,'_Final_variation_result.csv',sep
          = ''),row.names = F)

        writable: false
