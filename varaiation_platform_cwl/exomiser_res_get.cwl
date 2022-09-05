class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: exomiser_res_get
baseCommand:
  - python
  - extract.py
inputs:
  - id: exomiser_json_res
    type: File?
    inputBinding:
      position: 0
  - id: exomiser_tsv_res
    type: File?
    inputBinding:
      position: 1
  - id: exomiser_extract_result_name
    type: string?
    inputBinding:
      position: 2
outputs:
  - id: extracted_result
    type: File?
    outputBinding:
      glob: '*.csv'
label: exomiser_res_get
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/r_packages:v2'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: extract.py
        entry: >-
          import json

          import pandas as pd

          import os

          import numpy as np

          import sys


          ##定义inheritance dict

          InheritanceDict =
          {"AUTOSOMAL_DOMINANT":"AD","AUTOSOMAL_RECESSIVE":"AR","X_DOMINANT":"XD","X_RECESSIVE":"XR","MITOCHONDRIAL":"MT","UNKNOWN":"un"}



          #fileJson = "Pfeiffer-hiphive-exome-PASS_ONLY.json"

          #fileTsv = "Pfeiffer-hiphive-exome-PASS_ONLY_AD.variants.tsv"


          fileJson = sys.argv[1]   ##json文件

          fileTsv = sys.argv[2]    ##任意一 *.variants.tsv 文件

          output = sys.argv[3]     ##输出文件名


          ##读取json文件提取基因、遗传模式、相关疾病，打分；

          with open(fileJson, "r") as f:
              data = json.load(f)
              
          geneData =
          pd.DataFrame(data)[["geneSymbol","combinedScore","compatibleInheritanceModes","associatedDiseases"]]


          def inherit(x):
              if len(x) > 0:
                  tmp = []
                  for i in x:
                      tmp.append(InheritanceDict[i])
                  return ";".join(tmp)
              else:
                  return np.nan

          geneData["InheritanceModes"] =
          geneData["compatibleInheritanceModes"].apply(lambda x:inherit(x))


          def diseaseI (x):
              if type(x) == list :
                  if len(x) > 0:
                      tmp = []
                      for i in x:
                          diseaseInfo =  i["diseaseId"] + " " + i["diseaseName"] + "-" + i["inheritanceMode"].lower()
                          tmp.append(diseaseInfo)
                      return ";".join(tmp)
                  else:
                      return np.nan
              else:
                  if pd.isnull(x):
                      return np.nan


          geneData["Diseases"] = geneData["associatedDiseases"].apply(lambda
          x:diseaseI(x))


          geneData = geneData.sort_values(["combinedScore"],ascending=False)


          geneData["exomiserRank"] = range(1,len(geneData)+1)

          geneData.drop(columns =
          ["compatibleInheritanceModes","associatedDiseases"],inplace=True)

          ##获取基因对应的位置信息

          varPosi = pd.read_csv(fileTsv,sep="\t",usecols=
          ["#CHROM","POS","REF","ALT","EXOMISER_GENE"])

          varPosi.rename(columns = {"EXOMISER_GENE":"geneSymbol"},inplace =
          True)



          dataMerge = pd.merge(varPosi,geneData,on = "geneSymbol",how="left")

          dataMerge.to_csv(output,index=False,na_rep=".")
        writable: false
