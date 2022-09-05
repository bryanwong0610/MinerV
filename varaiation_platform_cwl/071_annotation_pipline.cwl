class: Workflow
cwlVersion: v1.0
id: _varminer
label: V12Varminer
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: annoPath
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/geneAnno
    'sbg:x': 192.671875
    'sbg:y': 426.796875
  - id: inputType
    type: string?
    default: file
    'sbg:exposed': true
  - id: annoCol
    type: string?
    default: Gene.refGene
    'sbg:exposed': true
  - id: output_2
    type: string?
    default: annotated.txt
    'sbg:exposed': true
  - id: annoFileList
    type: 'string[]?'
    default:
      - annotation
      - OMIM
      - GO
      - DO
      - HPO
      - KEGG
      - WIKI
      - REACTOME
      - BIOCARTA
      - HALLMARK
      - PID
    'sbg:exposed': true
  - id: geneAlias
    type: string?
    default: 'yes'
    'sbg:exposed': true
  - id: ref_version
    type: string?
    'sbg:x': 0
    'sbg:y': 320.1328125
  - id: splicing_threshold
    type: int?
    'sbg:x': 0
    'sbg:y': 213.421875
  - id: output
    type: string?
    'sbg:x': 0
    'sbg:y': 426.8203125
  - id: Trans_result
    type: string?
    'sbg:exposed': true
  - id: maf_threshold
    type: float?
    'sbg:x': 480.9287109375
    'sbg:y': 366.4296875
  - id: yml
    type: File?
    default:
      class: File
      path: /mnt/datashare/home/wangzesong/test_exomiser.yml
    'sbg:x': 0
    'sbg:y': 0
  - id: version
    type: string?
    default: '2109'
    'sbg:x': 0
    'sbg:y': 106.7109375
  - id: hpoIds
    type: 'string[]?'
    'sbg:x': 0
    'sbg:y': 533.5078125
  - id: dirdata
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/Exomiser/exomiser-data
    'sbg:x': 0
    'sbg:y': 640.1953125
  - id: outpref
    type: string?
    default: exomiser_result
    'sbg:exposed': true
  - id: default_col
    type: 'string[]?'
    default:
      - Gene_name
      - Chr
      - Start
      - End
      - Variation_detail
      - Variation_region
      - Variation_function
      - AAChange
      - dbSNP
      - Genotype
      - Depth
      - Allele_Depth
      - Hom_Het
      - combinedScore
      - InheritanceModes
      - Diseases
      - exomiserRank
      - annotation_summary
      - annotation_designations
      - annotation_description
      - GO_MF
      - GO_BP
      - GO_CC
      - KEGG_pathway
      - REACTOME_pathway
      - WIKI_pathway
      - HPO_phenotype
      - OMIM_Phenotype
      - DO_disease
      - rmsk
      - tfbsConsSites
      - Interpro_domain
      - 1000G_ALL
      - 1000G_EAS
      - ExAC_ALL
      - ExAC_EAS
      - ESP6500siv2_ALL
      - ESP6500siv2_EA
      - AF
      - AF_eas
      - SIFT_pred
      - SIFT_score
      - SIFT4G_pred
      - SIFT4G_score
      - Polyphen2_HVAR_pred
      - Polyphen2_HVAR_score
      - Polyphen2_HDIV_pred
      - Polyphen2_HDIV_score
      - MutationAssessor_pred
      - MutationAssessor_score
      - ClinPred_pred
      - ClinPred_score
      - CADD_phred
      - CADD_raw
      - REVEL_score
      - CLNSIG
      - CLNDN
      - CLNDISDB
      - InterVar_automated
      - InterVar_detail
    'sbg:exposed': true
  - id: maxFreq
    type: float?
    default: 10
    'sbg:exposed': true
  - id: db
    type: string?
    default: Final_filterd_variation_res
    'sbg:exposed': true
  - id: index
    type: string?
    default: >-
      Gene_name,Chr,Start,End,Variation_detail,Variation_region,Variation_function,AAChange,dbSNP,Genotype,Depth,Allele_Depth,Hom_Het,combinedScore,InheritanceModes,Diseases,exomiserRank,annotation_summary,annotation_designations,annotation_description,GO_MF,GO_BP,GO_CC,KEGG_pathway,REACTOME_pathway,WIKI_pathway,HPO_phenotype,OMIM_Phenotype,DO_disease,rmsk,tfbsConsSites,Interpro_domain,1000G_ALL,1000G_EAS,ExAC_ALL,ExAC_EAS,ESP6500siv2_ALL,ESP6500siv2_EA,AF,AF_eas,SIFT_pred,SIFT_score,SIFT4G_pred,SIFT4G_score,Polyphen2_HVAR_pred,Polyphen2_HVAR_score,Polyphen2_HDIV_pred,Polyphen2_HDIV_score,MutationAssessor_pred,MutationAssessor_score,ClinPred_pred,ClinPred_score,CADD_phred,CADD_raw,REVEL_score,CLNSIG,CLNDN,CLNDISDB,InterVar_automated,InterVar_detail
    'sbg:exposed': true
  - id: annovar_db
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/annovar_db/humandb
    'sbg:x': 0
    'sbg:y': 746.8828125
  - id: protocol
    type: string?
    default: >-
      refGene,ensGene,avsnp150,popfreq_all_20150413,gnomad211_exome,clinvar_exmpt,predsoft_v1,rmsk,tfbsConsSites,intervar_20180118,spliceAI_2021_02_03
    'sbg:exposed': true
  - id: operation
    type: string?
    default: 'g,g,f,f,f,f,f,r,r,f,f'
    'sbg:exposed': true
  - id: raw_vcf
    type: File?
    'sbg:x': 145.62820434570312
    'sbg:y': 73.29183959960938
outputs:
  - id: result_data
    outputSource:
      - merge_exomiser_annovar_res/result_data
    type: File?
    'sbg:x': 2736.47021484375
    'sbg:y': 320.109375
  - id: output_1
    outputSource:
      - csvs_to_sqlite_workflow/output
    type: File?
    'sbg:x': 3035.97021484375
    'sbg:y': 373.453125
  - id: output_txt
    outputSource:
      - new_annovar_function_1/output_txt
    type: File?
    'sbg:x': 443.79620361328125
    'sbg:y': 219.5153045654297
  - id: output_3
    outputSource:
      - geneanno/output_1
    type: File?
    'sbg:x': 578.8408203125
    'sbg:y': 662.7019653320312
  - id: sample_name
    outputSource:
      - new_annovar_filter/sample_name
    type: File?
    'sbg:x': 956.31005859375
    'sbg:y': 606.2706909179688
steps:
  - id: geneanno
    in:
      - id: inputType
        source: inputType
      - id: inputFile
        source: new_annovar_function_1/output_txt
      - id: annoCol
        source: annoCol
      - id: annoPath
        source: annoPath
      - id: output
        source: output_2
      - id: annoFileList
        source:
          - annoFileList
      - id: geneAlias
        source: geneAlias
    out:
      - id: output_1
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: geneanno
      baseCommand:
        - python
        - geneAnno.py
        - wqrwr4
      inputs:
        - id: inputType
          type: string?
          inputBinding:
            position: 0
            prefix: '--inputType'
        - id: gene
          type: string?
          inputBinding:
            position: 0
            prefix: '--gene'
        - id: inputFile
          type: File?
          inputBinding:
            position: 0
            prefix: '--inputFile'
        - id: annoCol
          type: string?
          inputBinding:
            position: 0
            prefix: '--annoCol'
        - id: geneMulti
          type: string?
          inputBinding:
            position: 0
            prefix: '--geneMulti'
        - id: annoPath
          type: Directory?
          inputBinding:
            position: 0
            prefix: '--annoPath'
        - id: genesep
          type: string?
          inputBinding:
            position: 0
            prefix: '--genesep'
        - default: out.txt
          id: output
          type: string?
          inputBinding:
            position: 100
            prefix: '--output'
        - id: annoFileList
          type: 'string[]?'
          inputBinding:
            position: 0
            prefix: '--annoFileList'
            itemSeparator: ','
        - id: geneAlias
          type: string?
          inputBinding:
            position: 0
            prefix: '--geneAlias'
      outputs:
        - id: output_1
          type: File?
          outputBinding:
            glob: $(inputs.output)
      label: geneAnno
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/py38_r403:anno'
        - class: InitialWorkDirRequirement
          listing:
            - entryname: geneAnno.py
              entry: "import warnings\r\nwarnings.filterwarnings(\"ignore\")\r\nimport pandas as pd\r\nimport numpy as np\r\nimport sys\r\nimport os\r\n\r\nfrom optparse import OptionParser\r\n\r\nparser = OptionParser()\r\nparser.add_option('--inputType', dest=\"inputType\", default = \"list\", help=\"list or file\")\r\nparser.add_option('--gene', dest=\"gene\", default = \"\", help=\"if inputType list, gene list\")\r\nparser.add_option('--inputFile', dest=\"inputFile\", default = \"\", help=\"if inputType file, gene file\")\r\nparser.add_option('--annoCol', dest=\"annoCol\", default = \"\", help=\"if inputType file, gene col\")\r\nparser.add_option('--geneMulti', dest=\"geneMulti\", default = \" \", help=\"if inputType file, gene multi, yes or no\")\r\nparser.add_option('--genesep', dest=\"genesep\", default = \" \", help=\"if inputType file, if geneMulti yes, gene sep\")\r\nparser.add_option('--annoPath', dest=\"annoPath\", default = \" \", help=\"annoPath\")\r\nparser.add_option('--output', dest=\"output\", default = \" \", help=\"output\")\r\nparser.add_option('--annoFileList', dest=\"annoFileList\", default = \" \", help=\"annoFileList, comma join\")\r\nparser.add_option('--geneAlias', default = \" \", dest=\"geneAlias\", help=\"geneAlias, yes or no\")\r\n(options, args) = parser.parse_args()\r\nfor i in \"inputType,gene,inputFile,annoCol,geneMulti,genesep,annoPath,output,annoFileList,geneAlias\".split(\",\"):\r\n    exec(i+\"=options.\"+i)\r\n\r\n\r\n\r\ndef read_data(inputFile,write = False,writeData = None):\r\n    fileType = inputFile.split(\".\")[-1]\r\n    if fileType == \"xlsx\":\r\n        if write:\r\n            writeData.to_excel(inputFile)\r\n        else:\r\n            transData = pd.read_excel(inputFile,dtype=\"str\")\r\n    else:\r\n        if fileType in [\"txt\",\"tsv\"]:\r\n            sep = \"\\t\"\r\n        else:\r\n            sep=\",\"\r\n        if write:\r\n            writeData.to_csv(inputFile,sep=sep,index = False)\r\n        else:\r\n            transData = pd.read_csv(inputFile,dtype=\"str\",sep=sep)\r\n    if not write:\r\n        return transData\r\n\r\ndef trans_int(x):\r\n    if not pd.isnull(x):\r\n        x = int(x)\r\n    return x\r\ndef trans_str(x):\r\n    if not pd.isnull(x):\r\n        x = str(int(x))\r\n    return x\r\n    \r\nif inputType == \"list\":\r\n    annoCol = \"search\"\r\n    gene = gene.replace(\",\",\"\\n\").replace(\"\\n\",\"\\t\").replace(\" \",\"\\t\").split(\"\\t\")\r\n    transData = pd.DataFrame(gene,columns=[annoCol])\r\n    transData = transData[transData[annoCol] != \"\"]\r\n    transData.index = range(len(transData))\r\nelif inputType == \"file\":\r\n    transData = read_data(inputFile)\r\ngeneTrans = pd.read_csv(os.path.join(annoPath,\"geneTrans.csv.gz\"),dtype=\"str\")\r\nif geneAlias == \"no\":\r\n    geneTrans = geneTrans[geneTrans[\"type\"] != \"synonyms\"]\r\ntransDataGene = transData[[annoCol]]\r\ntransDataGene.columns = [\"up\"]\r\ntransDataGene[\"up\"] = transDataGene[\"up\"].str.upper()\r\nif geneMulti == \"yes\":\r\n    transDataGene[\"order\"] = transDataGene.index\r\n    transDataGene = transDataGene.drop(\"up\", axis=1).join(transDataGene[\"up\"].str.split(genesep, expand=True).stack().reset_index(level=1, drop=True).rename(\"up\"))\r\ntransDataGene = pd.merge(transDataGene,geneTrans[[\"up\",\"id\"]],on=\"up\",how=\"left\")\r\nif geneMulti == \"yes\":\r\n    transDataGene[\"id\"] = transDataGene[\"id\"].apply(trans_int)\r\n    transDataGene = transDataGene.sort_values(by=\"id\").drop_duplicates(subset= [\"order\"]).sort_values(by=\"order\")\r\n    transDataGene[\"id\"] = transDataGene[\"id\"].apply(trans_str)\r\ntransDataGene = transDataGene[[\"id\"]]    \r\nannoFileList = annoFileList.split(\",\")\r\nfor annoFile in annoFileList:\r\n    anno = pd.read_csv(os.path.join(annoPath,\"DB\"+annoFile+\".csv.gz\"),dtype=\"str\")\r\n    for i in anno.columns:\r\n        if i != \"id\":\r\n            print({i:annoFile+\"_\"+i})\r\n            anno.rename(columns={i:annoFile+\"_\"+i},inplace=True)\r\n    transDataGene = pd.merge(transDataGene,anno,on=\"id\",how=\"left\")\r\ntransData = pd.concat([transData,transDataGene.drop(\"id\",axis =1)],axis=1)\r\ntransData.fillna(\".\",inplace=True)\r\n\r\nread_data(output,write = True,writeData = transData)\r\n# import time \r\n# time.sleep(100)"
              writable: false
        - class: InlineJavascriptRequirement
    label: geneAnno
    'sbg:x': 462.05035400390625
    'sbg:y': 536.7146606445312
  - id: txt2vcf
    in:
      - id: txt2vcf_file
        source: new_annovar_filter/sample_name
      - id: Trans_result
        default: Filterd_Transed.vcf
        source: Trans_result
      - id: input_vcf
        source: raw_vcf
    out:
      - id: filter_transed_vcf
    run: ./txt2vcf.cwl
    label: txt2vcf
    'sbg:x': 926.1510620117188
    'sbg:y': 327.6307067871094
  - id: picard
    in:
      - id: unsort_VCF
        source: txt2vcf/filter_transed_vcf
      - id: output_filename
        default: Filterd_Transed_Sorted.vcf
    out:
      - id: Sorted_vcf
    run: ./picard.cwl
    label: picard
    'sbg:x': 1127.2685546875
    'sbg:y': 294.81536865234375
  - id: bgzip
    in:
      - id: input
        source: picard/Sorted_vcf
    out:
      - id: gz_vcf
    run: ./bgzip.cwl
    label: bgzip
    'sbg:x': 1373.2518310546875
    'sbg:y': 167.15821838378906
  - id: tabix
    in:
      - id: GZ_Sorted_VCF
        source: bgzip/gz_vcf
    out:
      - id: VCF_o_gz
    run: ./tabix.cwl
    label: tabix
    'sbg:x': 1571.7896728515625
    'sbg:y': 373.453125
  - id: new_annovar_filter
    in:
      - id: Input_file
        source: geneanno/output_1
      - id: sample_name_in
        source: output
      - id: maf_threshold
        source: maf_threshold
    out:
      - id: sample_name
    run: ./new_annovar_filter.cwl
    label: New_annovar_filter
    'sbg:x': 680
    'sbg:y': 438.2350158691406
  - id: analysis_single_exomiser_wf_v1
    in:
      - id: vcf
        source: tabix/VCF_o_gz
      - id: version
        source: version
      - id: outpref
        source: outpref
      - id: maxFreq
        source: maxFreq
      - id: hpoIds
        source:
          - hpoIds
      - id: genomeAssembly
        source: ref_version
      - id: dirdata
        source: dirdata
      - id: yml
        source: yml
    out:
      - id: xrVCF
      - id: xrgenevar
      - id: xdVCF
      - id: xdgenevar
      - id: mtVCF
      - id: mtgenevar
      - id: json
      - id: html
      - id: arVCF
      - id: argenevar
      - id: adVCF
      - id: adgene
      - id: adgenec
    run: ./analysis_single_exomiser-wf_v1.cwl
    label: analysis_single_exomiser.wf_v1
    'sbg:x': 1667.7889404296875
    'sbg:y': -83.90177917480469
  - id: merge_exomiser_annovar_res
    in:
      - id: default_col
        source:
          - default_col
      - id: exomiser_res
        source: exomiser_res_get/extracted_result
      - id: annovar_res
        source: new_annovar_filter/sample_name
      - id: sample_name
        source: output
    out:
      - id: result_data
    run: ./merge_exomiser_annovar_res.cwl
    label: merge_exomiser_annovar_res
    'sbg:x': 2486.37646484375
    'sbg:y': 359.4296875
  - id: exomiser_res_get
    in:
      - id: exomiser_json_res
        source: analysis_single_exomiser_wf_v1/json
      - id: exomiser_tsv_res
        source: analysis_single_exomiser_wf_v1/adgene
      - id: exomiser_extract_result_name
        default: exomiser_merged_result.csv
    out:
      - id: extracted_result
    run: ./exomiser_res_get.cwl
    label: exomiser_res_get
    'sbg:x': 2200.552978515625
    'sbg:y': 366.4296875
  - id: renametool
    in:
      - id: name
        default: Final_filterd_variation_res.csv
      - id: original
        source: merge_exomiser_annovar_res/result_data
    out:
      - id: final
    run: ./renametool.cwl
    label: Renamer
    'sbg:x': 2736.47021484375
    'sbg:y': 426.796875
  - id: csvs_to_sqlite_workflow
    in:
      - id: csv
        source: renametool/final
      - id: db
        source: db
      - id: index
        source: index
    out:
      - id: output
    run: ./csv2sqlite.json
    label: csvs-to-sqlite_workflow
    'sbg:x': 2889.64208984375
    'sbg:y': 373.453125
  - id: new_annovar_function_1
    in:
      - id: raw_vcf
        source: raw_vcf
      - id: annovar_db
        source: annovar_db
      - id: ref_version
        source: ref_version
      - id: protocol
        source: protocol
      - id: operation
        source: operation
      - id: splicing_threshold
        source: splicing_threshold
      - id: rm_tmp
        default: true
      - id: output
        source: output
      - id: other_info
        default: true
    out:
      - id: output_vcf
      - id: output_txt
      - id: output_avinput
    run: ./new_annovar_function.cwl
    label: New_annovar_function
    'sbg:x': 217.4268798828125
    'sbg:y': 264.2599792480469
requirements:
  - class: SubworkflowFeatureRequirement
