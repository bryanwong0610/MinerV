class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: api_filter_annovar_res_r
baseCommand:
  - Rscript
  - Filter.R
inputs:
  - id: sample_name
    type: string?
    inputBinding:
      position: 0
      prefix: '--sample_name'
  - id: maf_cutoff
    type: float?
    inputBinding:
      position: 1
      prefix: '--maf_cutoff'
  - id: maf_database
    type: 'string[]?'
    inputBinding:
      position: 2
      prefix: '--maf_database'
      itemSeparator: ' '
  - id: region_filter_arg
    type: 'string[]?'
    inputBinding:
      position: 3
      prefix: '--region_filter'
      itemSeparator: ' '
  - id: function_filter_arg
    type: 'string[]?'
    inputBinding:
      position: 4
      prefix: '--function_filter'
      itemSeparator: ','
  - id: annovar_res
    type: File?
    inputBinding:
      position: 0
      prefix: '--annovar_dt'
  - id: exomiser_res
    type: File?
    inputBinding:
      position: 0
      prefix: '--exomiser_dt'
outputs:
  - id: filter_res
    type: File?
    outputBinding:
      glob: '*_Final_variation_filterd.csv'
  - id: unfilter_res
    type: File?
    outputBinding:
      glob: '*_Variation_unfilterd.csv'
label: api_filter_annovar_res.R
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/variminer_r4.0:latest'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: Filter.R
        entry: >-
          #For cwl

          # prepare env

          repos='https://mirrors.ustc.edu.cn/CRAN/'


          install.packages('argparser',repos = repos)

          options(scipen = 200)

          library('readr')

          library('stringr')

          library('dplyr')

          library('argparser')



          # loading arguments

          get_arg <-function(){
            p <- arg_parser("Annovar Filter analysis")
            p <- add_argument(p,'--annovar_dt',help = 'Annovar annotated file',type = 'character')
            p <- add_argument(p,'--sample_name',help = 'Sample name',type = 'character')
            p <- add_argument(p,'--maf_cutoff',help = 'MAF cutoff',type = 'numeric' )
            p <- add_argument(p,'--maf_database',help = 'filter database',type = 'character',default = '1000G_ALL 1000G_EAS ExAC_ALL ExAC_EAS ESP6500siv2_ALL ESP6500siv2_EA AF AF_eas')
            p <- add_argument(p,'--region_filter',help = 'Variation region filter',type = 'character',default = 'intergenic intron intronic ncRNA_intronic ncRNA_exonic ncRNA_exonic;splicing ncRNA_splicing ncRNA_UTR5 UTR3 UTR5 upstream;downstream  upstream 
                           UTR3;UTR5 UTR5;UTR3 downstream')
            p <- add_argument(p,'--function_filter',help = 'Variation function effect filter',type = 'character',default = 'synonymous SNV')
            p <- add_argument(p,'--exomiser_dt',help = "exomiser filter data", type = 'character')
            args <- parse_args(p)
            return(args)
          }



          args <- get_arg()


          #arg <- commandArgs(TRUE)

          #sample_name <- arg[1]

          #maf_cutoff <- arg[2]

          #maf_database <- arg[3]

          #region_filter_arg <- arg[4]

          #function_filter_arg <- arg[5]

          #annovar_res <- arg[6]


          ## processing split array

          #freqdb_input <- unlist(str_split(args$maf_database,' '))

          #region_input <- unlist(str_split(args$region_filter_arg,' '))

          #function_input <- unlist(str_split(function_filter_arg,' '))

          maf_database <- unlist(str_split(args$maf_database, ' '))

          region_filter <- unlist(str_split(args$region_filter,' '))

          function_filter <- unlist(str_split(args$function_filter,','))

          maf_cutoff <- args$maf_cutoff

          sample_name <- args$sample_name

          exomiser_dt <- args$exomiser_dt

          ##loading file 


          print("Loading file ......")

          annoted_dt <- read_delim(args$annovar_dt,'\t', escape_double = FALSE,
          trim_ws = TRUE)

          exomiser_dt <- read_delim(exomiser_dt,',', escape_double = FALSE,
          trim_ws = TRUE)

          annoted_dt <- merge(exomiser_dt,annoted_dt,by.x =
          c('POS','REF','ALT'),by.y =
          c('Otherinfo5','Otherinfo7','Otherinfo8'),all.x = TRUE)

          # foramation  formation result 

          # intervar result

          print("Formation intervar result ......")

          {annoted_dt$PVS1 <- paste('PVS1: ',annoted_dt$PVS1,sep = '')

          annoted_dt$PS1 <- paste('PS1: ',annoted_dt$PS1,sep = '')

          annoted_dt$PS2 <- paste('PS2: ',annoted_dt$PS2,sep = '')

          annoted_dt$PS3 <- paste('PS3: ',annoted_dt$PS3,sep = '')

          annoted_dt$PS4 <- paste('PS4: ',annoted_dt$PS4,sep = '')

          annoted_dt$PM1 <- paste('PM1: ',annoted_dt$PM1,sep = '')

          annoted_dt$PM2 <- paste('PM2: ',annoted_dt$PM2,sep = '')

          annoted_dt$PM3 <- paste('PM3: ',annoted_dt$PM3,sep = '')

          annoted_dt$PM4 <- paste('PM4: ',annoted_dt$PM4,sep = '')

          annoted_dt$PM5 <- paste('PM5: ',annoted_dt$PM5,sep = '')

          annoted_dt$PM6 <- paste('PM6: ',annoted_dt$PM6,sep = '')

          annoted_dt$PP1 <- paste('PP1: ',annoted_dt$PP1,sep = '')

          annoted_dt$PP2 <- paste('PP2: ',annoted_dt$PP2,sep = '')

          annoted_dt$PP3 <- paste('PP3: ',annoted_dt$PP3,sep = '')

          annoted_dt$PP4 <- paste('PP4: ',annoted_dt$PP4,sep = '')

          annoted_dt$PP5 <- paste('PP5: ',annoted_dt$PP5,sep = '')

          annoted_dt$BA1 <- paste('BA1: ',annoted_dt$BA1,sep = '')

          annoted_dt$BS1 <- paste('BS1: ',annoted_dt$BS1,sep = '')

          annoted_dt$BS2 <- paste('BS2: ',annoted_dt$BS2,sep = '')

          annoted_dt$BS3 <- paste('BS3: ',annoted_dt$BS3,sep = '')

          annoted_dt$BS4 <- paste('BS4: ',annoted_dt$BS4,sep = '')

          annoted_dt$BP1 <- paste('BP1: ',annoted_dt$BP1,sep = '')

          annoted_dt$BP2 <- paste('BP2: ',annoted_dt$BP2,sep = '')

          annoted_dt$BP3 <- paste('BP3: ',annoted_dt$BP3,sep = '')

          annoted_dt$BP4 <- paste('BP4: ',annoted_dt$BP4,sep = '')

          annoted_dt$BP5 <- paste('BP5: ',annoted_dt$BP5,sep = '')

          annoted_dt$BP6 <- paste('BP6: ',annoted_dt$BP6,sep = '')

          annoted_dt$BP7 <- paste('BP7: ',annoted_dt$BP7,sep = '')


          annoted_dt$InterVar_detail <-
          paste(annoted_dt$PVS1,';',annoted_dt$PS1,';',annoted_dt$PS2,';',annoted_dt$PS3,';'
                          ,annoted_dt$PS4,';',annoted_dt$PM1,';',annoted_dt$PM2,';',annoted_dt$PM3,';'
                          ,annoted_dt$PM4,
                          ';',annoted_dt$PM5,';',annoted_dt$PM6,';',annoted_dt$PP1,';',annoted_dt$PP2,';'
                          ,annoted_dt$PP3,
                          ';',annoted_dt$PP4,';',annoted_dt$PP5,';',annoted_dt$BA1,';',annoted_dt$BS1,';',
                          annoted_dt$BS2,';',annoted_dt$BS3,';',annoted_dt$BS4,';',annoted_dt$BP1,';',
                          annoted_dt$BP2,';',annoted_dt$BP3,';',annoted_dt$BP4,';',annoted_dt$BP5,';',
                          annoted_dt$BP6,';',annoted_dt$BP7,sep = ' ')
          }

          #Sequencing quality

          print("Formation sequencing quality ......")

          {Depth <-
          as.data.frame(str_split(annoted_dt$Otherinfo13,":",n=5,simplify = T))

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

          annoted_dt <- cbind(annoted_dt,Depth)

          }

          # Variation detail 

          print('Formation Variation detail ......')

          annoted_dt$Variation_detail <-
          paste(annoted_dt$Ref,'>',annoted_dt$Alt,sep = '')


          print("exempting the annovar annotated result by clinvar
                ......")
          clinvar_exmpt_data <-
          annoted_dt[which(annoted_dt$CLIN_exmpt=="True"),]

          non_exmpt_data <- annoted_dt[which(annoted_dt$CLIN_exmpt!="True"),]

          # confirming the filter rule

          print("Confirming the filter rule 
                ......")
          freq_donated <- c()

          region_rule <- c()

          function_rule <- c()


          freq_donated <-c(freq_donated,maf_database)

          region_rule <- c(region_rule,region_filter)

          function_rule <- c(function_rule,function_filter)


          #max_freq <- apply(dt[,freq_donated],1,max,na.rm=F)

          print('calculating the max_maf from select database
                ......')
          clinvar_exmpt_data$max_maf <-
          apply(clinvar_exmpt_data[,freq_donated],1,max,na.rm=F)

          non_exmpt_data$max_maf <-
          apply(non_exmpt_data[,freq_donated],1,max,na.rm=F)

          annoted_dt <- rbind(clinvar_exmpt_data,non_exmpt_data)

          #trans the string type

          print('split the num and NA allele freq of the file 
                ......')
          clinvar_exmpt_data_string <-
          clinvar_exmpt_data[which(clinvar_exmpt_data$max_maf == '.'),]

          clinvar_exmpt_data_num <-
          clinvar_exmpt_data[which(clinvar_exmpt_data$max_maf != '.'),]

          non_exmpt_data_string <- non_exmpt_data[which(non_exmpt_data$max_maf
          == '.'),]

          non_exmpt_data_num <- non_exmpt_data[which(non_exmpt_data$max_maf !=
          '.'),]


          #change the  "e"  numeric

          clinvar_exmpt_data_num$max_maf <-
          as.numeric(clinvar_exmpt_data_num$max_maf)

          non_exmpt_data_num$max_maf <- as.numeric(non_exmpt_data_num$max_maf)

          print('preparation job all done 
                ......')
          # preparing to filter the file 

          print("start filtering ......")


          # region filter

          print('region .....')

          non_exmpt_data_num_region_filterd <-
          filter(non_exmpt_data_num,!(Func.refGene %in% region_rule))

          non_exmpt_data_string_region_filterd <-
          filter(non_exmpt_data_string,!(Func.refGene %in% region_rule))


          # function filter

          print('function ......')

          non_exmpt_data_num_function_filterd <-
          filter(non_exmpt_data_num_region_filterd,!(ExonicFunc.refGene %in%
          function_rule))

          non_exmpt_data_string_function_filterd <-
          filter(non_exmpt_data_string_region_filterd,!(ExonicFunc.refGene %in%
          function_rule))


          # NAF filter

          print('maf .......')

          non_exmpt_data_num_maf_filterd <-
          non_exmpt_data_num_function_filterd[which(non_exmpt_data_num_function_filterd$max_maf
          <= maf_cutoff),]


          # Generate the final result 

          final_res <-
          rbind(non_exmpt_data_num_maf_filterd,non_exmpt_data_string_function_filterd,clinvar_exmpt_data_num,clinvar_exmpt_data_string)




          #Generating

          print("Generating .......")

          select_col <-
          c("Chr","Start","End","Variation_detail","Gene.refGene","Func.refGene","ExonicFunc.refGene","GeneDetail.refGene",
                          "AAChange.refGene","Gene.ensGene","Func.ensGene","ExonicFunc.ensGene","GeneDetail.ensGene","AAChange.ensGene",
                          "InheritanceModes","exomiserRank","combinedScore","Diseases",
                          "Genotype","Hom_Het","Depth","Allele_Depth","WT_ratio","CLNSIG","CLIN_exmpt","CLNDN","CLNDISDB","CLNHGVS","CLNREVSTAT","InterVar_automated","InterVar_detail",
                          "OMIM_Phenotype","HPO_phenotype",
                          "annotation_summary","annotation_description",
                          "GO_BP","GO_CC","GO_MF","DO_disease","KEGG_pathway","WIKI_pathway","REACTOME_pathway","BIOCARTA_pathway","HALLMARK_pathway",
                          "SpliceAI","Interpro_domain","rmsk","tfbsConsSites",
                          "max_maf",freq_donated,
                          "SIFT_pred","SIFT_score","SIFT4G_pred","SIFT4G_score",
                          "Polyphen2_HDIV_pred","Polyphen2_HDIV_score","Polyphen2_HVAR_pred","Polyphen2_HVAR_score",
                          "LRT_pred","LRT_score","MutationTaster_pred","MutationTaster_score","MutationAssessor_pred","MutationAssessor_score",
                          "FATHMM_pred","FATHMM_score","PROVEAN_pred","PROVEAN_score",
                          "VEST4_score","MetaSVM_pred","MetaSVM_score","MetaLR_pred","MetaLR_score",
                          "M-CAP_pred","M-CAP_score","REVEL_score","ClinPred_pred","ClinPred_score",
                          "CADD_phred","CADD_raw","GERP++_NR","phyloP100way_vertebrate","SiPhy_29way_logOdds")
          print('0')

          writeable_res <- final_res %>% select(select_col) %>%
          arrange(exomiserRank)

          print('1')

          unfilter_res <- annoted_dt %>% select(select_col)

          col_nm <- colnames(writeable_res)

          for (i in col_nm){
            writeable_res[[i]][which(writeable_res[[i]]=='.')] = ''
            writeable_res[[i]] <- as.character(writeable_res[[i]])
          }

          col_name <- colnames(unfilter_res)

          for (i in col_name){
            unfilter_res[[i]][which(unfilter_res[[i]]==".")] = ''
            unfilter_res[[i]] <- as.character(unfilter_res[[i]])
          }

          colname <- gsub('.','_',select_col,fixed = T)

          colnames(unfilter_res) <- colname

          colnames(writeable_res) <- colname

          print('all done, save the final data......')

          write.csv(unfilter_res,paste(sample_name,'_Variation_unfilterd.csv',sep=''),row.names=F)

          write.csv(writeable_res,paste(sample_name,'_Final_variation_filterd.csv',sep
          = ''),row.names = F)
        writable: false
