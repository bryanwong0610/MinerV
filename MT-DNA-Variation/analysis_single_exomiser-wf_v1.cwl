class: Workflow
cwlVersion: v1.0
id: analysis_single_exomiser_wf_v1
label: analysis_single_exomiser.wf_v1
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: version
    type: string?
    default: '2109'
    'sbg:x': -624.5
    'sbg:y': -399.5
  - id: outpref
    type: string?
    default: My_test
    'sbg:x': -719.5
    'sbg:y': -80
  - id: maxFreq
    type: float?
    default: 1
    'sbg:x': -787
    'sbg:y': 69
  - id: hpoIds
    type: 'string[]?'
    'sbg:x': -835.5
    'sbg:y': 228.5
  - id: genomeAssembly
    type: string?
    default: hg19
    'sbg:x': -774.5
    'sbg:y': 364.5
  - id: dirdata
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/Exomiser/exomiser-data
    'sbg:x': -512.5
    'sbg:y': 400
  - id: yml
    type: File?
    default:
      class: File
      path: >-
        /mnt/datashare/reference_genome/Exomiser/exomiser-config/test-analysis-exome_test1.yml
    'sbg:x': -676.2197875976562
    'sbg:y': -286.795654296875
  - id: vcf_gz
    type: File?
    'sbg:x': -1692.2823486328125
    'sbg:y': -286.4469909667969
  - id: exomiser_extract_result_name
    type: string?
    'sbg:x': 341.44921875
    'sbg:y': -0.1463543027639389
outputs:
  - id: extracted_result
    outputSource:
      - exomiser_res_get/extracted_result
    type: File?
    'sbg:x': 875.6481323242188
    'sbg:y': -255.5400390625
steps:
  - id: prepareexmiser_input
    in:
      - id: dirdata
        source: dirdata
      - id: yml
        source: yml
      - id: hpoIds
        source:
          - hpoIds
      - id: genomeAssembly
        source: genomeAssembly
      - id: outpref
        source: outpref
      - id: vcf
        source: tabix/VCF_o_gz
      - id: maxFreq
        source: maxFreq
      - id: version
        source: version
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
        - id: dirdata
          type: Directory?
          inputBinding:
            position: 1
            prefix: '--dirdata'
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

                parser.add_option("--dirdata", dest="dirdata",
                default="/mnt/datashare/reference_genome/Exomiser/exomiser-data",help="exomiser.data-directory")

                parser.add_option("--yml",dest="yml",
                default="/mnt/datashare/reference_genome/Exomiser/exomiser-config/test-analysis-exome.yml",
                help="test-analysis-exome.yml")

                parser.add_option("--hpoIds", dest="hpoIds",  help="input
                hpoids,comma split")

                parser.add_option("--genomeAssembly", dest="genomeAssembly", 
                help="hg19 or hg38")

                parser.add_option("--outpref", dest="outpref", 
                help="outputPrefix")

                parser.add_option("--vcf", dest="vcf",  help="vcf input, tbi
                requre")

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

                # outApp.write("exomiser."+ genomeAssembly +".data-version=" +
                str(version)+ "\n")

                # outApp.write("exomiser."+ genomeAssembly
                +".variant-white-list-path="+ str(version) + "_"+ genomeAssembly
                + "_clinvar_whitelist.tsv.gz" + "\n")

                # outApp.write("exomiser.phenotype.data-version=" +
                str(version)+ "\n")

                # outApp.close()

              writable: false
        - class: InlineJavascriptRequirement
    label: prepareExmiser_input
    'sbg:x': -354.37152099609375
    'sbg:y': -33.061920166015625
  - id: singleexomiser
    in:
      - id: analysis
        source: prepareexmiser_input/yamloutput
      - id: vcf
        source: tabix/VCF_o_gz
      - id: assembly
        source: genomeAssembly
      - id: data
        source: dirdata
      - id: version
        source: version
      - id: outpref
        source: outpref
    out:
      - id: html
      - id: json
      - id: adVCF
      - id: adgene
      - id: arVCF
      - id: argenevar
      - id: xdVCF
      - id: xdgenevar
      - id: xrVCF
      - id: xrgenevar
      - id: mtVCF
      - id: mtgenevar
      - id: adgenec
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
        - id: data
          type: Directory?
          inputBinding:
            position: 4
            prefix: '--exomiser.data-directory='
            separate: false
        - id: version
          type: string?
          inputBinding:
            position: 7
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
        - id: adgene
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*AD.variants.tsv
        - id: arVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*AR.vcf
        - id: argenevar
          type: 'File[]?'
          outputBinding:
            glob: $(inputs.outpref)*AR.*.tsv
        - id: xdVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*XD.vcf
        - id: xdgenevar
          type: 'File[]?'
          outputBinding:
            glob: $(inputs.outpref)*XD.*.tsv
        - id: xrVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*XR.vcf
        - id: xrgenevar
          type: 'File[]?'
          outputBinding:
            glob: $(inputs.outpref)*XR.*.tsv
        - id: mtVCF
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*MT.vcf
        - id: mtgenevar
          type: 'File[]?'
          outputBinding:
            glob: $(inputs.outpref)*MT.*.tsv
        - id: adgenec
          type: File?
          outputBinding:
            glob: $(inputs.outpref)*AD.genes.tsv
      label: singleExomiser
      arguments:
        - position: 8
          prefix: '--exomiser.phenotype.data-version='
          separate: false
          valueFrom: $(inputs.version)
        - position: 10
          prefix: '--exomiser.'
          separate: false
          valueFrom: $(inputs.assembly).data-version=$(inputs.version)
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/exomiser-cli:20220618'
        - class: InitialWorkDirRequirement
          listing:
            - $(inputs.vcf)
        - class: InlineJavascriptRequirement
    label: singleExomiser
    'sbg:x': 124.16836547851562
    'sbg:y': -159.9222869873047
  - id: tabix
    in:
      - id: GZ_Sorted_VCF
        source: bgzip/gz_vcf
    out:
      - id: VCF_o_gz
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: tabix
      baseCommand:
        - tabix
        - '-p'
        - vcf
      inputs:
        - id: GZ_Sorted_VCF
          type: File?
          inputBinding:
            position: 0
      outputs:
        - id: VCF_o_gz
          type: File?
          outputBinding:
            glob: '*.vcf.gz'
          secondaryFiles:
            - .tbi
      label: tabix
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/tabix:1.11--hdfd78af_0'
        - class: InitialWorkDirRequirement
          listing:
            - $(inputs.GZ_Sorted_VCF)
        - class: InlineJavascriptRequirement
    label: tabix
    'sbg:x': -960.7049560546875
    'sbg:y': -258.175537109375
  - id: ungz
    in:
      - id: vcf_gz
        source: vcf_gz
    out:
      - id: uncomposed
    run: ./ungz.cwl
    label: ungz
    'sbg:x': -1560.2764892578125
    'sbg:y': -161.27407836914062
  - id: bgzip
    in:
      - id: input
        source: ungz/uncomposed
    out:
      - id: gz_vcf
    run: ../varaiation_platform_cwl/bgzip.cwl
    label: bgzip
    'sbg:x': -1282.494873046875
    'sbg:y': -169.3849639892578
  - id: exomiser_res_get
    in:
      - id: exomiser_json_res
        source: singleexomiser/json
      - id: exomiser_tsv_res
        source: singleexomiser/adgene
      - id: exomiser_extract_result_name
        source: exomiser_extract_result_name
    out:
      - id: extracted_result
    run: ./exomiser_res_get.cwl
    label: exomiser_res_get
    'sbg:x': 492.57940673828125
    'sbg:y': -170
requirements:
  - class: ScatterFeatureRequirement
