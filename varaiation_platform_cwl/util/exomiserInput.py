#!coding=utf-8
import pandas as pd
import json
import numpy as np
import os
from optparse import OptionParser
import re
import yaml

###param
parser = OptionParser()
parser.add_option("--dirdata", dest="dirdata", default="/mnt/datashare/reference_genome/Exomiser/exomiser-data",help="exomiser.data-directory")
parser.add_option("--yml",dest="yml", default="/mnt/datashare/reference_genome/Exomiser/exomiser-config/test-analysis-exome.yml", help="test-analysis-exome.yml")
parser.add_option("--hpoIds", dest="hpoIds",  help="input hpoids,comma split")
parser.add_option("--genomeAssembly", dest="genomeAssembly",  help="hg19 or hg38")
parser.add_option("--outpref", dest="outpref",  help="outputPrefix")
parser.add_option("--vcf", dest="vcf",  help="vcf input, tbi requre")
parser.add_option("--maxFreq", dest="maxFreq",  default= 1 , help="maxFreq")
parser.add_option("--analysisMode", dest="analysisMode",  default= "PASS_ONLY" , help="PASS_ONLY ")
parser.add_option("--version", dest="version",  default= "2109" , help="data-version")
parser.add_option("--outyaml", dest="outyaml",   help="file name of output yaml")

#outapp = "application.properties"

(options, args) = parser.parse_args()
for i in options.__dict__:
    exec(i+ " = options."+i)
    
print(vcf)
##yml读取
ymlf = open(yml,'r',encoding='utf-8')
ymlR = ymlf.read()
ymlInfo = yaml.load(ymlR,Loader=yaml.FullLoader)

##对变量值进行替换
###analysis参数值
ymlInfo["analysis"]["genomeAssembly"] = genomeAssembly
ymlInfo["analysis"]["vcf"] = vcf
ymlInfo["analysis"]["hpoIds"]  = list(map(lambda x:x.strip(),hpoIds.split(",")))
ymlInfo["analysis"]["analysisMode"]  = analysisMode

for i in ymlInfo["analysis"]["steps"]:
    if "frequencyFilter" in i.keys():
        i["frequencyFilter"]["maxFrequency"] = maxFreq
        
####outputOptions参数值
ymlInfo["outputOptions"]["outputPrefix"] = outpref

##yaml格式输出
aa = json.dumps(ymlInfo)
bb = yaml.load(aa,Loader=yaml.FullLoader)
file1 = open(outyaml,"w")
yaml.safe_dump(bb,file1,default_flow_style=False)
ymlf.close()

##生成application.properties
# outApp = open(outapp,'w',encoding='utf-8')
# outApp.write("exomiser.data-directory=" + dirdata + "\n")
# outApp.write("remm.version=0.3.1.post1" + "\n")
# outApp.write("cadd.version=1.4" + "\n")
# outApp.write("exomiser."+ genomeAssembly +".data-version=" + str(version)+ "\n")
# outApp.write("exomiser."+ genomeAssembly +".variant-white-list-path="+ str(version) + "_"+ genomeAssembly + "_clinvar_whitelist.tsv.gz" + "\n")
# outApp.write("exomiser.phenotype.data-version=" + str(version)+ "\n")
# outApp.close()

