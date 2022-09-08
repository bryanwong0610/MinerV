class: Workflow
cwlVersion: v1.0
id: analysis_single_exomiser_wf_v2_cwl
label: analysis_single_exomiser-wf_v2.cwl
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: yml
    type: File?
    default:
      class: File
      path: >-
        /mnt/datashare/reference_genome/Exomiser/exomiser-config/test-analysis-exome.yml
    'sbg:x': -366.0521240234375
    'sbg:y': -390.4329833984375
  - id: version
    type: string?
    default: '2109'
    'sbg:x': -253.50904846191406
    'sbg:y': -672.8060302734375
  - id: vcf
    type: File?
    secondaryFiles:
      - .tbi
    'sbg:x': -625
    'sbg:y': -172
  - id: removeMuta
    type: 'string[]?'
    'sbg:x': -464
    'sbg:y': -272
  - id: pathSources
    type: 'string[]?'
    default:
      - POLYPHEN
      - MUTATION_TASTER
      - SIFT
      - REMM
    'sbg:x': -687.1798095703125
    'sbg:y': -68
  - id: maxFreq
    type: float?
    default: 1
    'sbg:x': -516
    'sbg:y': 172
  - id: hpoIds
    type: 'string[]?'
    'sbg:x': -451.43157958984375
    'sbg:y': 60.510433197021484
  - id: genomeAssembly
    type: string?
    'sbg:x': -358.70745849609375
    'sbg:y': 218.50106811523438
  - id: outpref
    type: string?
    default: outputResult
    'sbg:x': -541
    'sbg:y': 19
  - id: outputstring
    type: string?
    default: outputResult_extract.csv
    'sbg:x': 426.509033203125
    'sbg:y': -197.08831787109375
  - id: dataDir
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/Exomiser/exomiser-data
    'sbg:x': -147.5737762451172
    'sbg:y': -248.08370971679688
outputs:
  - id: yamloutput
    outputSource:
      - prepareexmiser_input/yamloutput
    type: File?
    'sbg:x': -38.009559631347656
    'sbg:y': 217.67666625976562
  - id: output
    outputSource:
      - extractexomiserresult_v2/output
    type: File?
    'sbg:x': 565.4581909179688
    'sbg:y': 159.22750854492188
  - id: config
    outputSource:
      - singleexomiser/config
    type: File?
    'sbg:x': 189.42013549804688
    'sbg:y': 269.5890197753906
  - id: html
    outputSource:
      - singleexomiser/html
    type: File?
    'sbg:x': 204.02037048339844
    'sbg:y': 91.1386489868164
  - id: json
    outputSource:
      - singleexomiser/json
    type: File?
    'sbg:x': 214.93096923828125
    'sbg:y': 120.7750473022461
steps:
  - id: prepareexmiser_input
    in:
      - id: yml
        source: yml
      - id: hpoIds
        source:
          - hpoIds
      - id: removeMuta
        source:
          - removeMuta
      - id: genomeAssembly
        source: genomeAssembly
      - id: outpref
        source: outpref
      - id: vcf
        source: vcf
      - id: maxFreq
        default: 1
        source: maxFreq
      - id: version
        default: '2109'
        source: version
      - id: pathSources
        source:
          - pathSources
    out:
      - id: yamloutput
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: prepareexmiser_input
      baseCommand:
        - python
        - exomiserInput.py
      inputs:
        - id: yml
          type: File?
          inputBinding:
            position: 3
            prefix: '--yml'
        - id: hpoIds
          type: 'string[]?'
          inputBinding:
            position: 4
            prefix: '--hpoIds'
            itemSeparator: ','
        - default:
            - SPLICE_REGION_VARIANT
            - SYNONYMOUS_VARIANT
            - CODING_TRANSCRIPT_INTRON_VARIANT
            - NON_CODING_TRANSCRIPT_INTRON_VARIANT
            - UPSTREAM_GENE_VARIANT
            - DOWNSTREAM_GENE_VARIANT
            - INTERGENIC_VARIANT
            - REGULATORY_REGION_VARIANT
          id: removeMuta
          type: 'string[]?'
          inputBinding:
            position: 2
            prefix: '--removeMuta'
            itemSeparator: ','
        - id: genomeAssembly
          type: string?
          inputBinding:
            position: 5
            prefix: '--genomeAssembly'
        - id: outpref
          type: string?
          inputBinding:
            position: 6
            prefix: '--outpref'
        - id: vcf
          type: File?
          inputBinding:
            position: 7
            prefix: '--vcf'
        - id: maxFreq
          type: float?
          inputBinding:
            position: 8
            prefix: '--maxFreq'
        - id: version
          type: string?
          inputBinding:
            position: 9
            prefix: '--version'
        - default: test_analysis_exome.yml
          id: outyaml
          type: string?
          inputBinding:
            position: 10
            prefix: '--outyaml'
        - id: pathSources
          type: 'string[]?'
          inputBinding:
            position: 0
            prefix: '--pathSources'
            itemSeparator: ','
      outputs:
        - id: yamloutput
          type: File?
          outputBinding:
            glob: $(inputs.outyaml)
      label: prepareExmiser_input
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/r_packages:v2'
        - class: InitialWorkDirRequirement
          listing:
            - entryname: exomiserInput.py
              entry: >+
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

                parser.add_option("--yml",dest="yml",
                default="/mnt/datashare/reference_genome/Exomiser/exomiser-config/test-analysis-exome.yml",
                help="test-analysis-exome.yml")

                parser.add_option("--removeMuta", dest="removeMuta", 
                help="variantEffectFilter remove")

                parser.add_option("--hpoIds", dest="hpoIds",  help="input
                hpoids,comma split")

                parser.add_option("--genomeAssembly", dest="genomeAssembly", 
                help="hg19 or hg38")

                parser.add_option("--outpref", dest="outpref", 
                help="outputPrefix")

                parser.add_option("--vcf", dest="vcf",  help="vcf input, tbi
                requre")

                parser.add_option("--pathSources", dest="pathSources",  
                help="pathogenicitySources")

                parser.add_option("--maxFreq", dest="maxFreq",  default= 1 ,
                help="maxFreq")

                parser.add_option("--analysisMode", dest="analysisMode", 
                default= "PASS_ONLY" , help="PASS_ONLY ")

                parser.add_option("--version", dest="version",  default= "2109"
                , help="data-version")

                parser.add_option("--outyaml", dest="outyaml",   help="file name
                of output yaml")


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

                ymlInfo["analysis"]["hpoIds"]  = list(map(lambda
                x:x.strip(),hpoIds.split(",")))

                ymlInfo["analysis"]["analysisMode"]  = analysisMode

                ymlInfo["analysis"]["pathogenicitySources"]  = list(map(lambda
                x:x.strip(),pathSources.split(",")))


                for i in ymlInfo["analysis"]["steps"]:
                    if "frequencyFilter" in i.keys():
                        i["frequencyFilter"]["maxFrequency"] = maxFreq
                    if "variantEffectFilter" in i.keys():
                        i["variantEffectFilter"]["remove"] = list(map(lambda x:x.strip(),removeMuta.split(",")))
                        
                ####outputOptions参数值

                ymlInfo["outputOptions"]["outputPrefix"] = outpref


                ##yaml格式输出

                aa = json.dumps(ymlInfo)

                bb = yaml.load(aa,Loader=yaml.FullLoader)

                file1 = open(outyaml,"w")

                yaml.safe_dump(bb,file1,default_flow_style=False)

                ymlf.close()



              writable: false
        - class: InlineJavascriptRequirement
    label: prepareExmiser_input
    'sbg:x': -247.99563598632812
    'sbg:y': -46.446868896484375
  - id: extractexomiserresult_v2
    in:
      - id: inherentfiles
        source:
          - singleexomiser/adgenevar
          - singleexomiser/argenevar
          - singleexomiser/mtgenevar
          - singleexomiser/xdgenevar
          - singleexomiser/xrgenevar
      - id: jsonIn
        source: singleexomiser/json
      - id: outputstring
        default: outputResult_exomiser.csv
        source: outputstring
    out:
      - id: output
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: extractexomiserresult_v2
      baseCommand:
        - python
        - extractInfo_v2.py
      inputs:
        - id: inherentfiles
          type: 'File[]?'
          inputBinding:
            position: 0
            prefix: '--inherentfiles'
            itemSeparator: ','
        - id: jsonIn
          type: File?
          inputBinding:
            position: 0
            prefix: '--jsonIn'
        - id: outputstring
          type: string?
          inputBinding:
            position: 0
            prefix: '--output'
      outputs:
        - id: output
          type: File?
          outputBinding:
            glob: $(inputs.outputstring)
      label: extractExomiserResult_v2
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/r_packages:v2'
        - class: InitialWorkDirRequirement
          listing:
            - entryname: extractInfo_v2.py
              entry: >+
                import json

                import pandas as pd

                import os

                import numpy as np

                import sys

                from optparse import OptionParser

                import re


                ###解析变量

                parser = OptionParser()

                parser.add_option("--inherentfiles", dest="inherentfiles", 
                help="*_AD/AR/XR/XD/MT.variants.tsv")

                parser.add_option("--jsonIn", dest="jsonIn",  help="*json")

                parser.add_option("--output", dest="output",  help="name of
                output file")


                (options, args) = parser.parse_args()

                for i in options.__dict__:
                    exec(i+ " = options."+i)
                    
                ##定义inheritance dict

                InheritanceDict =
                {"AUTOSOMAL_DOMINANT":"AD","AUTOSOMAL_RECESSIVE":"AR","X_DOMINANT":"XD","X_RECESSIVE":"XR","MITOCHONDRIAL":"MT","UNKNOWN":"un"}

                InheritanceList = ["AD","AR","XD","XR","MT"]

                InheritanceFileDict = {}


                for i in inherentfiles.split(",") :
                    mode = re.sub(".variants.tsv","",i.split("_")[-1]).upper()
                    InheritanceFileDict[mode] = i
                InheritanceScore= list(map(lambda
                x:"EXOMISER_GENE_COMBINED_SCORE(" + x + ")",InheritanceList))


                ###读取json文件，以基因为核心的信息提取

                with open(jsonIn, "r") as f:
                    data = json.load(f)
                    
                df = pd.DataFrame(data)

                df = df.rename(columns={"geneSymbol":"EXOMISER_GENE"})


                ###提取疾病信息

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


                df["Diseases"] = df["associatedDiseases"].apply(lambda
                x:diseaseI(x))



                tmp1 = pd.DataFrame(df["geneIdentifier"].tolist())

                headerlist = tmp1.columns.tolist()

                df[headerlist] = tmp1


                #######提取核心列信息


                headerLists = headerlist +
                ["EXOMISER_GENE","combinedScore","priorityScore","variantScore","Diseases"]

                dfGene = df[headerLists]


                ###提取变异位点

                tiltle1 =
                ["#CHROM","POS","REF","ALT","HGVS","EXOMISER_GENE","EXOMISER_VARIANT_SCORE"]

                tiltle2 =
                ["EXOMISER_GENE_PHENO_SCORE","EXOMISER_GENE_VARIANT_SCORE","EXOMISER_GENE_COMBINED_SCORE"]

                tiltles = tiltle1 + tiltle2

                dataVaraint =
                pd.read_table(InheritanceFileDict["AD"],sep="\t",usecols=tiltle1)


                def readInherent(file,mode):
                    dataInherent1 = pd.read_table(file,sep="\t")
                    mode = mode.upper()
                    dataInherent2 = dataInherent1.loc[dataInherent1["CONTRIBUTING_VARIANT"] == "CONTRIBUTING_VARIANT",tiltles]
                    titleEdit = tiltle1 + list(map(lambda x: x+"("+ mode +")",tiltle2)) 
                    dataInherent2.columns = titleEdit
                    return dataInherent2
                    
                ###提取不同模式下的score值

                for mode in InheritanceList:
                    filein = InheritanceFileDict[mode]
                    dataTmp = readInherent(filein,mode)
                    dataVaraint = pd.merge(dataVaraint,dataTmp,on=tiltle1,how="left")
                dataVaraint["maxScore"] = 
                dataVaraint[InheritanceScore].sum(axis=1,min_count=1)

                dataVaraint["maxScore"] = dataVaraint["maxScore"].fillna(0)


                ####添加gene score值

                dataOut1 =
                pd.merge(dataVaraint,dfGene,on="EXOMISER_GENE",how="left")

                dataOut2 =
                dataOut1.sort_values(["combinedScore","EXOMISER_GENE","maxScore","EXOMISER_VARIANT_SCORE"],ascending=False)

                dataOut2["exomiserRank"] = range(1,len(dataOut2)+1)

                dataOut2.to_csv(output,index=False,na_rep=".")






              writable: false
        - class: InlineJavascriptRequirement
    label: extractExomiserResult_v2
    'sbg:x': 410.17236328125
    'sbg:y': -51.346824645996094
  - id: singleexomiser
    in:
      - id: analysis
        source: prepareexmiser_input/yamloutput
      - id: vcf
        source: vcf
      - id: assembly
        source: genomeAssembly
      - id: dataDir
        source: dataDir
      - id: version
        source: version
      - id: outpref
        source: outpref
    out:
      - id: html
      - id: json
      - id: adVCF
      - id: adgenevar
      - id: arVCF
      - id: argenevar
      - id: xdVCF
      - id: xdgenevar
      - id: xrVCF
      - id: xrgenevar
      - id: mtVCF
      - id: mtgenevar
      - id: config
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: singleexomiser
      baseCommand: []
      inputs:
        - id: analysis
          type: File?
          inputBinding:
            position: 1
            prefix: '--analysis'
        - id: vcf
          type: File?
          inputBinding:
            position: 2
            prefix: '--vcf'
          secondaryFiles:
            - .tbi
        - id: assembly
          type: string?
          inputBinding:
            position: 3
            prefix: '--assembly'
        - id: dataDir
          type: Directory?
        - id: version
          type: string?
        - id: outpref
          type: string?
      outputs:
        - id: html
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*.html
        - id: json
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*.json
        - id: adVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*AD.vcf
        - id: adgenevar
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*AD.variants.tsv
        - id: arVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*AR.vcf
        - id: argenevar
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*AR.variants.tsv
        - id: xdVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*XD.vcf
        - id: xdgenevar
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*XD.variants.tsv
        - id: xrVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*XR.vcf
        - id: xrgenevar
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*XR.variants.tsv
        - id: mtVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*MT.vcf
        - id: mtgenevar
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*MT.variants.tsv
        - id: config
          type: File?
          outputBinding:
            glob: application.properties
      label: singleExomiser
      arguments:
        - position: 7
          prefix: '--spring.config.location='
          separate: false
          valueFrom: application.properties
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/exomiser-cli:20220618'
        - class: InitialWorkDirRequirement
          listing:
            - entryname: application.properties
              entry: >-
                ${ var strings = "exomiser.data-directory=" +
                inputs.dataDir.path +

                "\n";
                    var version = inputs.version;
                    var assemb = inputs.assembly;
                    strings  += "exomiser." + assemb + ".data-version=" + version + "\n";
                    var caddSnp = "exomiser." + assemb + ".cadd-snv-path=" + inputs.dataDir.path + "/cadd/1.4/"+ assemb + "/whole_genome_SNVs.tsv.gz" + "\n"; 
                    strings += caddSnp;
                    var caddIndel = "exomiser." + assemb + ".cadd-in-del-path=" + inputs.dataDir.path + "/cadd/1.4/"+ assemb + "/InDels.tsv.gz" + "\n";
                    strings += caddIndel;
                    var ramm = "exomiser." + assemb + ".remm-path=" +inputs.dataDir.path + "/remm/ReMM.v0.3.1.post1." + assemb + ".tsv.gz" + "\n";
                    strings += ramm;
                    var clinvar = "exomiser." + assemb + ".variant-white-list-path\=" + version +"_" + assemb + "_clinvar_whitelist.tsv.gz" + "\n"; 
                    strings += clinvar;
                    var pheon = "exomiser.phenotype.data-version=" + version + "\n";
                    strings += pheon;
                    return strings;
                }
              writable: false
        - class: InlineJavascriptRequirement
    label: singleExomiser
    'sbg:x': 23.120208740234375
    'sbg:y': -76.54308319091797
requirements:
  - class: MultipleInputFeatureRequirement
