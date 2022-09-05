
suppressMessages(library(dplyr))
suppressMessages(library(stringr))
suppressMessages(library(readr))

args <- commandArgs(TRUE)

exomiser_res <- args[1]
annovar_res <- args[2]
default_select_name <- arg[3]
if (length(args = 4)) {
  custom_select_name <- arg[4]  
}

#prepare file to use
usd_result <- merge(exomiser_res,annovar_res,by.x = c('Chr','Start'),by.y = c('Chr','Otherinfo5'))
  #calculate depth
Depth <- as.data.frame(str_split(usd_result$Otherinfo13,":",n=5,simplify = T))
colnames(Depth) <- c('Genotype','Allele_Depth','Depth','Genotype_Quality','provieds_the_likelihoods_of_the_given_genotypes')
allele_depth <- as.data.frame(str_split(Depth$Allele_Depth,',',n=2,simplify = T))
Depth <- cbind(Depth,allele_depth)
Depth$Depth <- as.integer(Depth$Depth)
Depth$V1 <- as.integer(Depth$V1)
Depth$WT_ratio <- Depth$V1/Depth$Depth
Depth$`Hom;Het`<- 'Hom'
Depth$`Hom;Het`[which(Depth$Genotype == '0/1')] = 'Het'
Depth$`Hom;Het`[which(Depth$Genotype == '1/2')] = 'Het'
table(Depth$`Hom;Het`)

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
{sub_res_res_1$InterVar_detail <- paste(sub_res_res_1$PVS1,';',sub_res_res_1$PS1,';',sub_res_res_1$PS2,';',sub_res_res_1$PS3,';'
                                        ,sub_res_res_1$PS4,';',sub_res_res_1$PM1,';',sub_res_res_1$PM2,';',sub_res_res_1$PM3,';'
                                        ,sub_res_res_1$PM4,
                                        ';',sub_res_res_1$PM5,';',sub_res_res_1$PM6,';',sub_res_res_1$PP1,';',sub_res_res_1$PP2,';'
                                        ,sub_res_res_1$PP3,
                                        ';',sub_res_res_1$PP4,';',sub_res_res_1$PP5,';',sub_res_res_1$BA1,';',sub_res_res_1$BS1,';',
                                        sub_res_res_1$BS2,';',sub_res_res_1$BS3,';',sub_res_res_1$BS4,';',sub_res_res_1$BP1,';',
                                        sub_res_res_1$BP2,';',sub_res_res_1$BP3,';',sub_res_res_1$BP4,';',sub_res_res_1$BP5,';',
                                        sub_res_res_1$BP6,';',sub_res_res_1$BP7,sep = ' ')}
sub_res_res_1$Variation_detail <- paste(sub_res_res_1$Ref.x,'>',sub_res_res_1$Alt.x,sep='')
colnames(sub_res_res_1)

#select result col
default_arguments <- unlist(str_split(default_select_name,' '))
if (length(args = 4)) {
  custom_arguments <- unlist(str_split(custom_select_name,''))
}
sltd_res <- sub_res_res_1 %>% select(default_arguments,custom_arguments)
colnames(final_res)[c(1,6,7,8,9)] <-c('Gene_name','Variation_region','Variation_function','AAChange','dbSNP') 
{final_res$combinedScore[which(final_res$combinedScore=='.')]=NA
  final_res$`1000G_ALL`[which(final_res$`1000G_ALL`=='.')]=NA
  final_res$`1000G_EAS`[which(final_res$`1000G_EAS`=='.')]=NA
  final_res$ExAC_ALL[which(final_res$ExAC_ALL=='.')]=NA
  final_res$ExAC_EAS[which(final_res$ExAC_EAS=='.')]=NA
  final_res$ESP6500siv2_ALL[which(final_res$ESP6500siv2_ALL=='.')]=NA
  final_res$ESP6500siv2_EA[which(final_res$ESP6500siv2_EA=='.')]=NA
  final_res$AF[which(final_res$AF=='.')]=NA
  final_res$AF_eas[which(final_res$AF_eas=='.')]=NA
  final_res$SIFT_score[which(final_res$SIFT_score=='.')]=NA
  final_res$SIFT4G_score[which(final_res$SIFT4G_score=='.')]=NA
  final_res$Polyphen2_HDIV_score[which(final_res$Polyphen2_HDIV_score=='.')]=NA
  final_res$Polyphen2_HVAR_score[which(final_res$Polyphen2_HVAR_score=='.')]=NA
  final_res$MutationAssessor_score[which(final_res$MutationAssessor_score=='.')]=NA
  final_res$ClinPred_score[which(final_res$ClinPred_score=='.')]=NA
  final_res$CADD_phred[which(final_res$CADD_phred=='.')]=NA
  final_res$CADD_raw[which(final_res$CADD_raw=='.')]=NA
  final_res$REVEL_score[which(final_res$REVEL_score=='.')]=NA
}
write.csv(final_res,'Final_variation_result.csv',row.names = F)

