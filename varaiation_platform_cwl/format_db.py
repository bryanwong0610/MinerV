import pandas as pd
import numpy as np
import os
from pandas import value_counts

clinvar_test = pd.read_table("/mnt/datashare/annovar_db/human/hg19_clinvar_latest.txt")
CLIN_exmpt=[]
CLIN_exmpt=clinvar_test['CLNSIG'].str.contains('genic')
CLIN_exmpt.value_counts()
clinvar_test['CLIN_exmpt'] = CLIN_exmpt
final_clinvar=clinvar_test[['#Chr','Start','End','Ref','Alt','CLNDISDB','CLNDN','CLNHGVS','CLNSIG','CLIN_exmpt']]
final_clinvar.to_csv('/mnt/datashare/annovar_db/human/hg38_clinvar_exmpt.txt',sep='\t',index=False)



import pandas as pd
import numpy as np
import os
dbsnv42=pd.read_table('/mnt/datashare/annovar_db/humandb/hg19_dbnsfp42a.txt')

chose_db=dbsnv42[['#Chr','Start','End','Ref','Alt','SIFT_pred','SIFT_score','SIFT4G_pred','SIFT4G_score','Polyphen2_HDIV_pred',
'Polyphen2_HDIV_score','Polyphen2_HVAR_pred','Polyphen2_HVAR_score','LRT_pred','LRT_score','MutationTaster_pred','MutationTaster_score',
'MutationAssessor_pred','MutationAssessor_score','FATHMM_pred','FATHMM_score','PROVEAN_pred','PROVEAN_score','VEST4_score','LRT_pred',
'LRT_score','MetaSVM_pred','MetaSVM_score','MetaLR_pred','MetaLR_score','M-CAP_pred','M-CAP_score','ClinPred_pred','ClinPred_score','CADD_phred',
'CADD_raw','GERP++_NR','ClinPred_pred','ClinPred_score','phyloP100way_vertebrate','SiPhy_29way_logOdds']]

finad_db=dbsnv42.to_csv('/mnt/datashare/annovar_db/humandb/hg19_predsoft_v1.txt',sep='\t',index=False)