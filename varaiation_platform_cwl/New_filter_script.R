setwd('~/Downloads/annovar_cwl_workflow/toolandworkflow-master/analysisWorkflows/tools/varaiation_platform_cwl/')
library('readr')
library('stringr')
library('dplyr')
options(scipen = 200)
#loading file
print("Loading annovar file......")
annoted_dt <- read_delim('annotated.txt','\t', escape_double = FALSE, trim_ws = TRUE)
print("exempting the annovar annotated result by clinvar......")
clinvar_exmpt_data <- annoted_dt[which(annoted_dt$CLIN_exmpt=="True"),]
non_exmpt_data <- annoted_dt[which(annoted_dt$CLIN_exmpt!="True"),]
freq_donated <- c("1000G_ALL","1000G_EAS","ExAC_ALL","ExAC_EAS","ESP6500siv2_ALL","ESP6500siv2_EA","AF","AF_eas") #可放开
print('done ...... 
      peparing to the filter files')
#max_freq <- apply(dt[,freq_donated],1,max,na.rm=F)
clinvar_exmpt_data$max_maf <- apply(clinvar_exmpt_data[,maf_database],1,max,na.rm=F)
non_exmpt_data$max_maf <- apply(non_exmpt_data[,freq_donated],1,max,na.rm=F)

#trans the string type
print('split the num and NA allele freq of the file ......')
clinvar_exmpt_data_string <- clinvar_exmpt_data[which(clinvar_exmpt_data$max_maf == '.'),]
clinvar_exmpt_data_num <- clinvar_exmpt_data[which(clinvar_exmpt_data$max_maf != '.'),]
non_exmpt_data_string <- non_exmpt_data[which(non_exmpt_data$max_maf == '.'),]
non_exmpt_data_num <- non_exmpt_data[which(non_exmpt_data$max_maf != '.'),]
      #change the  "e"  numeric
clinvar_exmpt_data_num$max_maf <- as.numeric(clinvar_exmpt_data_num$max_maf)
non_exmpt_data_num$max_maf <- as.numeric(non_exmpt_data_num$max_maf)

## to filter the non_exmptation data
print("data not exempted preparing to filtering ..... ")
  # non_exmpt data region filter
print("Strat filtering the region")
region_rule <- c("intergenic","intron","intronic","ncRNA_intronic","ncRNA_exonic","ncRNA_exonic;splicing","ncRNA_splicing","ncRNA_UTR5","UTR3","UTR5",'upstream;downstream',' upstream',
                 'UTR3;UTR5','UTR5;UTR3','downstream')#可放开
non_exmpt_data_num_region_filterd <- filter(non_exmpt_data_num,!(Func.refGene %in% region_rule))
non_exmpt_data_string_region_filterd <- filter(non_exmpt_data_string,!(Func.refGene %in% region_rule))
  # non_exmpt data function
  print("Start filtering the function")
function_rule <- c('synonymous SNV')#可放开
non_exmpt_data_num_function_filterd <- filter(non_exmpt_data_num_region_filterd,!(ExonicFunc.refGene %in% function_rule))
non_exmpt_data_string_function_filterd <- filter(non_exmpt_data_string_region_filterd,!(ExonicFunc.refGene %in% function_rule))
  # MAF filtering
#maf_cutoff
non_exmpt_data_num_maf_filterd <- non_exmpt_data_num_function_filterd[which(non_exmpt_data_num_function_filterd$max_maf <= 0.05),]
# generate filterd result
final_res <- rbind(non_exmpt_data_num_maf_filterd,non_exmpt_data_string_function_filterd,clinvar_exmpt_data_num,clinvar_exmpt_data_string)
# foramation  formation result 
 #intervar result
print("Formation intervar result ......")
{final_res$PVS1 <- paste('PVS1: ',final_res$PVS1,sep = '')
  final_res$PS1 <- paste('PS1: ',final_res$PS1,sep = '')
  final_res$PS2 <- paste('PS2: ',final_res$PS2,sep = '')
  final_res$PS3 <- paste('PS3: ',final_res$PS3,sep = '')
  final_res$PS4 <- paste('PS4: ',final_res$PS4,sep = '')
  final_res$PM1 <- paste('PM1: ',final_res$PM1,sep = '')
  final_res$PM2 <- paste('PM2: ',final_res$PM2,sep = '')
  final_res$PM3 <- paste('PM3: ',final_res$PM3,sep = '')
  final_res$PM4 <- paste('PM4: ',final_res$PM4,sep = '')
  final_res$PM5 <- paste('PM5: ',final_res$PM5,sep = '')
  final_res$PM6 <- paste('PM6: ',final_res$PM6,sep = '')
  final_res$PP1 <- paste('PP1: ',final_res$PP1,sep = '')
  final_res$PP2 <- paste('PP2: ',final_res$PP2,sep = '')
  final_res$PP3 <- paste('PP3: ',final_res$PP3,sep = '')
  final_res$PP4 <- paste('PP4: ',final_res$PP4,sep = '')
  final_res$PP5 <- paste('PP5: ',final_res$PP5,sep = '')
  final_res$BA1 <- paste('BA1: ',final_res$BA1,sep = '')
  final_res$BS1 <- paste('BS1: ',final_res$BS1,sep = '')
  final_res$BS2 <- paste('BS2: ',final_res$BS2,sep = '')
  final_res$BS3 <- paste('BS3: ',final_res$BS3,sep = '')
  final_res$BS4 <- paste('BS4: ',final_res$BS4,sep = '')
  final_res$BP1 <- paste('BP1: ',final_res$BP1,sep = '')
  final_res$BP2 <- paste('BP2: ',final_res$BP2,sep = '')
  final_res$BP3 <- paste('BP3: ',final_res$BP3,sep = '')
  final_res$BP4 <- paste('BP4: ',final_res$BP4,sep = '')
  final_res$BP5 <- paste('BP5: ',final_res$BP5,sep = '')
  final_res$BP6 <- paste('BP6: ',final_res$BP6,sep = '')
  final_res$BP7 <- paste('BP7: ',final_res$BP7,sep = '')
  }
{final_res$InterVar_detail <- paste(final_res$PVS1,';',final_res$PS1,';',final_res$PS2,';',final_res$PS3,';'
                                        ,final_res$PS4,';',final_res$PM1,';',final_res$PM2,';',final_res$PM3,';'
                                        ,final_res$PM4,
                                        ';',final_res$PM5,';',final_res$PM6,';',final_res$PP1,';',final_res$PP2,';'
                                        ,final_res$PP3,
                                        ';',final_res$PP4,';',final_res$PP5,';',final_res$BA1,';',final_res$BS1,';',
                                        final_res$BS2,';',final_res$BS3,';',final_res$BS4,';',final_res$BP1,';',
                                        final_res$BP2,';',final_res$BP3,';',final_res$BP4,';',final_res$BP5,';',
                                        final_res$BP6,';',final_res$BP7,sep = ' ')
}
  #Sequencing quality
print("Formation sequencing quality ......")
{Depth <- as.data.frame(str_split(final_res$Otherinfo13,":",n=5,simplify = T))
colnames(Depth) <- c('Genotype','Allele_Depth','Depth','Genotype_Quality','provieds_the_likelihoods_of_the_given_genotypes')
allele_depth <- as.data.frame(str_split(Depth$Allele_Depth,',',n=2,simplify = T))
Depth <- cbind(Depth,allele_depth)
Depth$Depth <- as.integer(Depth$Depth)
Depth$V1 <- as.integer(Depth$V1)
Depth$WT_ratio <- Depth$V1/Depth$Depth
Depth$Hom_Het<- 'Hom'
Depth$Hom_Het[which(Depth$Genotype == '0/1')] = 'Het'
Depth$Hom_Het[which(Depth$Genotype == '1/2')] = 'Het'
table(Depth$Hom_Het)
final_res <- cbind(final_res,Depth)}
  # Variation detail 
print('Formation Variation detail ......')
final_res$Variation_detail <- paste(final_res$Ref,'>',final_res$Alt,sep = '')
  #Generating
print("Generating .......")
select_col <- c("Chr","Start","End","Variation_detail","Gene.refGene","Func.refGene","ExonicFunc.refGene","GeneDetail.refGene",
                "AAChange.refGene","Gene.ensGene","Func.ensGene","ExonicFunc.ensGene","GeneDetail.ensGene","AAChange.ensGene",
                "Genotype","Hom_Het","Depth","Allele_Depth","WT_ratio","CLNDISDB","CLNDN","CLNHGVS","CLNSIG","InterVar_automated","InterVar_detail",
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
                "CADD_phred","CADD_raw","GERP++_NR","phyloP100way_vertebrate","SiPhy_29way_logOdds",
                "Otherinfo1","Otherinfo2","Otherinfo3","Otherinfo4","Otherinfo5",
                "Otherinfo6","Otherinfo7","Otherinfo8")
writeable_res <- final_res %>% select(select_col)
col_nm <- colnames(writeable_res)
for (i in col_nm){
  writeable_res[[i]][which(writeable_res[[i]]=='.')] = ''
  writeable_res[[i]] <- as.character(writeable_res[[i]])
}
write.csv(writeable_res,'Final_variation_filterd.csv',row.names = F)







