class: Workflow
cwlVersion: v1.0
id: _varminer
label: V2.0_Varminer
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: annoPath
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/geneAnno
    'sbg:x': 889.4486083984375
    'sbg:y': 822.868408203125
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
    'sbg:x': -3.187224864959717
    'sbg:y': 533
  - id: splicing_threshold
    type: int?
    'sbg:x': -6.374449729919434
    'sbg:y': 356.42510986328125
  - id: output
    type: string?
    'sbg:x': 0
    'sbg:y': 845.803955078125
  - id: yml
    type: File?
    default:
      class: File
      path: /mnt/datashare/home/wangzesong/test_exomiser.yml
    'sbg:x': 0
    'sbg:y': -95.61674499511719
  - id: version
    type: string?
    default: '2109'
    'sbg:x': -3.187224864959717
    'sbg:y': 198.4295196533203
  - id: hpoIds
    type: 'string[]?'
    'sbg:x': 0
    'sbg:y': 1067.2265625
  - id: dirdata
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/Exomiser/exomiser-data
    'sbg:x': 0
    'sbg:y': 1280.6796875
  - id: outpref
    type: string?
    default: exomiser_result
    'sbg:exposed': true
  - id: maxFreq
    type: float?
    default: 10
    'sbg:exposed': true
  - id: annovar_db
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/annovar_db/humandb
    'sbg:x': 0
    'sbg:y': 1387.3984375
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
    'sbg:x': -88.17475891113281
    'sbg:y': 759.087890625
  - id: function_filter_arg
    type: 'string[]?'
    'sbg:x': 713
    'sbg:y': 1263.26318359375
  - id: maf_cutoff
    type: float?
    'sbg:x': 662.7337646484375
    'sbg:y': 1062.4937744140625
  - id: maf_database
    type: 'string[]?'
    'sbg:x': 621.3421020507812
    'sbg:y': 959.5
  - id: region_filter_arg
    type: 'string[]?'
    'sbg:x': 646.0789184570312
    'sbg:y': 785.26318359375
  - id: db
    type: string?
    default: Final_filterd_variation_res
    'sbg:exposed': true
  - id: db_1
    type: string?
    defualt: Unfilter_Variation_res
    'sbg:exposed': true
outputs:
  - id: filter_res
    outputSource:
      - api_filter_annovar_res_r/filter_res
    type: File?
    'sbg:x': 2024.2801513671875
    'sbg:y': 335.4798889160156
  - id: unfilter_res
    outputSource:
      - api_filter_annovar_res_r/unfilter_res
    type: File?
    'sbg:x': 2076.24169921875
    'sbg:y': -230.1764678955078
  - id: output_1
    outputSource:
      - csvs_to_sqlite_workflow/output
    type: File?
    'sbg:x': 3152.41796875
    'sbg:y': 493.55572509765625
  - id: output_4
    outputSource:
      - csvs_to_sqlite_workflow_1/output
    type: File?
    'sbg:x': 3093.157470703125
    'sbg:y': -370.7204895019531
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
    'sbg:x': 1131.6455078125
    'sbg:y': 157.42105102539062
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
    'sbg:x': 959.609130859375
    'sbg:y': -499.3960266113281
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
    'sbg:x': 1359.13134765625
    'sbg:y': -458.263671875
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
    'sbg:x': 471.7709045410156
    'sbg:y': 485.2414855957031
  - id: bgzip
    in:
      - id: input
        source: new_annovar_function_1/output_vcf
    out:
      - id: gz_vcf
    run: ./bgzip.cwl
    label: bgzip
    'sbg:x': 771.4659423828125
    'sbg:y': 78.60836029052734
  - id: api_filter_annovar_res_r
    in:
      - id: sample_name
        source: output
      - id: maf_cutoff
        source: maf_cutoff
      - id: maf_database
        source:
          - maf_database
      - id: region_filter_arg
        source:
          - region_filter_arg
      - id: function_filter_arg
        source:
          - function_filter_arg
      - id: annovar_res
        source: geneanno/output_1
      - id: exomiser_res
        source: exomiser_res_get/extracted_result
    out:
      - id: filter_res
      - id: unfilter_res
    run: ./api_filter_annovar_res-r.cwl
    label: api_filter_annovar_res.R
    'sbg:x': 1837.708984375
    'sbg:y': 34.962852478027344
  - id: tabix
    in:
      - id: GZ_Sorted_VCF
        source: bgzip/gz_vcf
    out:
      - id: VCF_o_gz
    run: ./tabix.cwl
    label: tabix
    'sbg:x': 765.8343505859375
    'sbg:y': -180.213623046875
  - id: rename_cwl_wk
    in:
      - id: original
        source: api_filter_annovar_res_r/filter_res
      - id: name
        default: Final_filterd_variation_res.csv
    out:
      - id: final
    run: ./rename-cwl-wk.cwl.json.cwl
    label: rename.cwl.wk
    'sbg:x': 2395.013916015625
    'sbg:y': 490.3142395019531
  - id: rename_cwl_wk_1
    in:
      - id: original
        source: api_filter_annovar_res_r/unfilter_res
      - id: name
        default: Unfilter_Variation.csv
    out:
      - id: final
    run: ./rename-cwl-wk.cwl.json.cwl
    label: rename.cwl.wk
    'sbg:x': 2500.139404296875
    'sbg:y': -180.3157958984375
  - id: csvs_to_sqlite_workflow
    in:
      - id: csv
        source: rename_cwl_wk/final
      - id: db
        source: db
    out:
      - id: output
    run: ./csv2sqlite.json
    label: csvs-to-sqlite_workflow
    'sbg:x': 2702.495361328125
    'sbg:y': 484.1114501953125
  - id: csvs_to_sqlite_workflow_1
    in:
      - id: csv
        source: rename_cwl_wk_1/final
      - id: db
        source: db_1
    out:
      - id: output
    run: ./csv2sqlite.json
    label: csvs-to-sqlite_workflow
    'sbg:x': 2748.784912109375
    'sbg:y': -186.53250122070312
requirements:
  - class: SubworkflowFeatureRequirement
