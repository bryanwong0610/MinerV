class: Workflow
cwlVersion: v1.0
id: _varminer
label: V3.5.5_Varminer
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: annoPath
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/geneAnno
    'sbg:x': 878.933837890625
    'sbg:y': 463.0203552246094
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
      - GO
      - DO
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
  - id: annovar_db
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/annovar_db/humandb
    'sbg:x': 184.7487335205078
    'sbg:y': 1008.4904174804688
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
    'sbg:x': 1293.08984375
    'sbg:y': -101.16718292236328
  - id: maf_cutoff
    type: float?
    'sbg:x': 1286.7120361328125
    'sbg:y': 61.18577194213867
  - id: maf_database
    type: 'string[]?'
    'sbg:x': 1293.521728515625
    'sbg:y': -188.4303436279297
  - id: region_filter_arg
    type: 'string[]?'
    'sbg:x': 1273.8994140625
    'sbg:y': -24.57585906982422
  - id: db
    type: string?
    default: Final_filterd_variation_res
    'sbg:exposed': true
  - id: db_1
    type: string?
    default: Unfilter_Variation_res
    'sbg:exposed': true
  - id: hpoIds
    type: 'string[]?'
    'sbg:x': 676.5659790039062
    'sbg:y': -386.9226989746094
  - id: yml
    type: File
    default:
      class: File
      path: /mnt/datashare/reference_genome/varminer/test_exomiser.yml
    'sbg:x': 701.4862670898438
    'sbg:y': -689.8491821289062
  - id: dataDir
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/Exomiser/exomiser-data
    'sbg:x': 952.9745483398438
    'sbg:y': -81.20240783691406
  - id: OMIM_db
    type: File?
    default:
      class: File
      path: /mnt/datashare/reference_genome/varminer/OMIM_08_26.csv
    'sbg:x': 1125.3939208984375
    'sbg:y': 578.6857299804688
  - id: HPO_db
    type: File?
    default:
      class: File
      path: /mnt/datashare/reference_genome/varminer/HPO_dt_2022_09_12.csv
    'sbg:x': 1379.6558837890625
    'sbg:y': 499.03741455078125
outputs:
  - id: filter_res
    outputSource:
      - api_filter_annovar_res_r/filter_res
    type: File?
    'sbg:x': 1872.6744384765625
    'sbg:y': 60.1729850769043
  - id: unfilter_res
    outputSource:
      - api_filter_annovar_res_r/unfilter_res
    type: File?
    'sbg:x': 2032.2620849609375
    'sbg:y': -720.910400390625
  - id: output_1
    outputSource:
      - csvs_to_sqlite_workflow/output
    type: File?
    'sbg:x': 3046.706298828125
    'sbg:y': -48.51005172729492
  - id: output_4
    outputSource:
      - csvs_to_sqlite_workflow_1/output
    type: File?
    'sbg:x': 3006.5087890625
    'sbg:y': -245.90394592285156
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
    'sbg:x': 1066
    'sbg:y': 276.1882629394531
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
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: new_annovar_function
      baseCommand:
        - table_annovar.pl
      inputs:
        - id: raw_vcf
          type: File?
          inputBinding:
            position: 1
        - id: annovar_db
          type: Directory?
          inputBinding:
            position: 2
        - id: ref_version
          type: string?
          inputBinding:
            position: 3
            prefix: '-buildver'
        - default: >-
            refGene,avsnp150,popfreq_all_20150413,gnomad211_exome,clinvar_exmpt,dbnsfp42a,rmsk,tfbsConsSites,intervar_20180118
          id: protocol
          type: string?
          inputBinding:
            position: 4
            prefix: '-protocol'
        - default: 'g,f,f,f,f,f,r,r,f'
          id: operation
          type: string?
          inputBinding:
            position: 5
            prefix: '-operation'
        - default: .
          id: NA_string
          type: string?
          inputBinding:
            position: 6
            prefix: '-nastring'
        - id: splicing_threshold
          type: int?
          inputBinding:
            position: 7
            prefix: '-intronhgvs'
        - default: true
          id: rm_tmp
          type: boolean?
          inputBinding:
            position: 8
            prefix: '-remove'
        - default: true
          id: confirm_vcfinput
          type: boolean?
          inputBinding:
            position: 9
            prefix: '-vcfinput'
        - id: output
          type: string?
          inputBinding:
            position: 11
            prefix: '-out'
        - default: true
          id: other_info
          type: boolean?
          inputBinding:
            position: 10
            prefix: '-otherinfo'
      outputs:
        - id: output_vcf
          type: File?
          outputBinding:
            glob: $(inputs.output)*_multianno.vcf
        - id: output_txt
          type: File?
          outputBinding:
            glob: $(inputs.output)*_multianno.txt
        - id: output_avinput
          type: File?
          outputBinding:
            glob: $(inputs.output).avinput
      label: New_annovar_function
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/annovar:latest'
        - class: InlineJavascriptRequirement
    label: New_annovar_function
    'sbg:x': 782.8715209960938
    'sbg:y': 317.8111572265625
  - id: bgzip
    in:
      - id: input
        source: new_annovar_function_1/output_vcf
    out:
      - id: gz_vcf
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: bgzip
      baseCommand:
        - bgzip
      inputs:
        - id: input
          type: File?
          inputBinding:
            position: 0
      outputs:
        - id: gz_vcf
          type: File?
          outputBinding:
            glob: '*.vcf.gz'
      label: bgzip
      requirements:
        - class: DockerRequirement
          dockerPull: 'harbor.bio-it.cn:5000/library/tabix:1.11--hdfd78af_0'
        - class: InitialWorkDirRequirement
          listing:
            - $(inputs.input)
        - class: InlineJavascriptRequirement
    label: bgzip
    'sbg:x': 700.7322387695312
    'sbg:y': -8.201241493225098
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
        source: hpo_omim_anno_cn/Annotated_data
      - id: exomiser_res
        source: analysis_single_exomiser_wf_v2_cwl/output
    out:
      - id: filter_res
      - id: unfilter_res
    run:
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

                annoted_dt <- read_delim(args$annovar_dt,',', escape_double =
                FALSE, trim_ws = TRUE)

                exomiser_dt <- read_delim(exomiser_dt,',', escape_double =
                FALSE, trim_ws = TRUE)

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
                as.data.frame(str_split(annoted_dt$Otherinfo13,":",n=5,simplify
                = T))

                colnames(Depth) <-
                c('Genotype','Allele_Depth','Depth','Genotype_Quality','provieds_the_likelihoods_of_the_given_genotypes')

                allele_depth <-
                as.data.frame(str_split(Depth$Allele_Depth,',',n=2,simplify =
                T))

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

                non_exmpt_data <-
                annoted_dt[which(annoted_dt$CLIN_exmpt!="True"),]

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

                non_exmpt_data_string <-
                non_exmpt_data[which(non_exmpt_data$max_maf == '.'),]

                non_exmpt_data_num <-
                non_exmpt_data[which(non_exmpt_data$max_maf != '.'),]


                #change the  "e"  numeric

                clinvar_exmpt_data_num$max_maf <-
                as.numeric(clinvar_exmpt_data_num$max_maf)

                non_exmpt_data_num$max_maf <-
                as.numeric(non_exmpt_data_num$max_maf)

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
                filter(non_exmpt_data_num_region_filterd,!(ExonicFunc.refGene
                %in% function_rule))

                non_exmpt_data_string_function_filterd <-
                filter(non_exmpt_data_string_region_filterd,!(ExonicFunc.refGene
                %in% function_rule))


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
                # Gene
                                "AAChange.refGene","Gene.ensGene","Func.ensGene","ExonicFunc.ensGene","GeneDetail.ensGene","AAChange.ensGene", # Function
                                "Genotype","Hom_Het","Depth","Allele_Depth","WT_ratio","CLNSIG","CLIN_exmpt","CLNDN","CLNDISDB","CLNHGVS","CLNREVSTAT","InterVar_automated","InterVar_detail", ##  Clinvar
                                "OMIM_en","OMIM_cn","HPO_en","HPO_cn", #OMIM&HPO
                                "max_maf",freq_donated, ## frequency 
                                "annotation_summary","annotation_description",
                                "GO_BP","GO_CC","GO_MF","DO_disease","KEGG_pathway","WIKI_pathway","REACTOME_pathway","BIOCARTA_pathway","HALLMARK_pathway",
                                "SpliceAI","Interpro_domain","rmsk","tfbsConsSites",
                                "HGVS","EXOMISER_VARIANT_SCORE","EXOMISER_GENE_PHENO_SCORE(AD)","EXOMISER_GENE_VARIANT_SCORE(AD)","EXOMISER_GENE_COMBINED_SCORE(AD)", # Exomiser_result
                                "EXOMISER_GENE_PHENO_SCORE(AR)","EXOMISER_GENE_VARIANT_SCORE(AR)","EXOMISER_GENE_COMBINED_SCORE(AR)","EXOMISER_GENE_PHENO_SCORE(XD)","EXOMISER_GENE_VARIANT_SCORE(XD)", #Exomiser_result
                                "EXOMISER_GENE_COMBINED_SCORE(XD)","EXOMISER_GENE_PHENO_SCORE(XR)","EXOMISER_GENE_VARIANT_SCORE(XR)","EXOMISER_GENE_COMBINED_SCORE(XR)","EXOMISER_GENE_PHENO_SCORE(MT)", #Exomiser_result
                                "EXOMISER_GENE_VARIANT_SCORE(MT)","EXOMISER_GENE_COMBINED_SCORE(MT)","geneSymbol","hgncId","hgncSymbol","entrezId","ensemblId","ucscId","combinedScore","priorityScore","variantScore","Diseases","exomiserRank", # Exomiser_result
                                "SIFT_pred","SIFT_score","SIFT4G_pred","SIFT4G_score",
                                "Polyphen2_HDIV_pred","Polyphen2_HDIV_score","Polyphen2_HVAR_pred","Polyphen2_HVAR_score",
                                "LRT_pred","LRT_score","MutationTaster_pred","MutationTaster_score","MutationAssessor_pred","MutationAssessor_score",
                                "FATHMM_pred","FATHMM_score","PROVEAN_pred","PROVEAN_score",
                                "VEST4_score","MetaSVM_pred","MetaSVM_score","MetaLR_pred","MetaLR_score",
                                "M-CAP_pred","M-CAP_score","REVEL_score","ClinPred_pred","ClinPred_score",
                                "CADD_phred","CADD_raw","GERP++_NR","phyloP100way_vertebrate","SiPhy_29way_logOdds")
                print('preparing dt select')

                writeable_res <- final_res %>% select(select_col) %>%
                arrange(exomiserRank)

                print('filtering......')

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

                write.csv(writeable_res,paste(sample_name,'_Final_variation_filterd.csv',sep=
                ''),row.names = F)
              writable: false
    label: api_filter_annovar_res.R
    'sbg:x': 1656.2718505859375
    'sbg:y': -531.18017578125
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
    'sbg:x': 801.2012329101562
    'sbg:y': -148.06192016601562
  - id: rename_cwl_wk
    in:
      - id: original
        source: api_filter_annovar_res_r/filter_res
      - id: name
        default: Final_filterd_variation_res.csv
    out:
      - id: final
    run:
      class: Workflow
      cwlVersion: v1.0
      id: rename_cwl_wk
      label: rename.cwl.wk
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      inputs:
        - id: original
          type: File
          'sbg:x': -348.53125
          'sbg:y': -168.5
        - id: name
          type: string
          'sbg:exposed': true
      outputs:
        - id: final
          outputSource:
            - renametool/final
          type: File
          'sbg:x': 14.46875
          'sbg:y': -226.5
      steps:
        - id: renametool
          in:
            - id: name
              source: name
            - id: original
              source: original
          out:
            - id: final
          run:
            class: ExpressionTool
            cwlVersion: v1.0
            doc: >-
              Logically renames a file, but not all workflow engines currently
              support it.  See also staged_rename.cwl
            expression: |
              ${
                  var f = inputs.original;
                  f.basename = inputs.name;
                  return {'final': f};
              }
            inputs:
              name:
                type: string
              original:
                type: File
            label: Renamer
            outputs:
              final:
                type: File
            requirements:
              - class: InlineJavascriptRequirement
          label: Renamer
          'sbg:x': -134
          'sbg:y': -78
      requirements: []
    label: rename.cwl.wk
    'sbg:x': 2342.353271484375
    'sbg:y': -59.03102493286133
  - id: rename_cwl_wk_1
    in:
      - id: original
        source: api_filter_annovar_res_r/unfilter_res
      - id: name
        default: Unfilter_Variation.csv
    out:
      - id: final
    run:
      class: Workflow
      cwlVersion: v1.0
      id: rename_cwl_wk
      label: rename.cwl.wk
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      inputs:
        - id: original
          type: File
          'sbg:x': -348.53125
          'sbg:y': -168.5
        - id: name
          type: string
          'sbg:exposed': true
      outputs:
        - id: final
          outputSource:
            - renametool/final
          type: File
          'sbg:x': 14.46875
          'sbg:y': -226.5
      steps:
        - id: renametool
          in:
            - id: name
              source: name
            - id: original
              source: original
          out:
            - id: final
          run:
            class: ExpressionTool
            cwlVersion: v1.0
            doc: >-
              Logically renames a file, but not all workflow engines currently
              support it.  See also staged_rename.cwl
            expression: |
              ${
                  var f = inputs.original;
                  f.basename = inputs.name;
                  return {'final': f};
              }
            inputs:
              name:
                type: string
              original:
                type: File
            label: Renamer
            outputs:
              final:
                type: File
            requirements:
              - class: InlineJavascriptRequirement
          label: Renamer
          'sbg:x': -134
          'sbg:y': -78
      requirements: []
    label: rename.cwl.wk
    'sbg:x': 2345.820068359375
    'sbg:y': -176.23951721191406
  - id: csvs_to_sqlite_workflow
    in:
      - id: csv
        source: rename_cwl_wk/final
      - id: db
        source: db
    out:
      - id: output
    run:
      class: Workflow
      cwlVersion: v1.0
      id: csvs_to_sqlite_workflow
      label: csvs-to-sqlite_workflow
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      inputs:
        - id: csv
          type: File
          default:
            class: File
            path: >-
              /mnt/datashare/home/kongxiangya/test/ceshi/csvs-to-sqlite/geneInfo.csv
          'sbg:x': -556.1796875
          'sbg:y': -78.16699981689453
        - id: sep
          type: string?
          default: ','
          'sbg:exposed': true
        - id: shape
          type: string?
          default: ''
          'sbg:exposed': true
        - id: strings
          type: boolean?
          default: false
          'sbg:exposed': true
        - id: db
          type: string?
          default: out.db
          'sbg:exposed': true
        - id: index
          type: string?
          'sbg:exposed': true
      outputs:
        - id: output
          outputSource:
            - csvs_to_sqlite/output
          type: File?
          'sbg:x': -134.17970275878906
          'sbg:y': -80.16699981689453
      steps:
        - id: csvs_to_sqlite
          in:
            - id: csv
              source: csv
            - id: db
              source: db
            - id: sep
              source: sep
            - id: strings
              source: strings
            - id: shape
              source: shape
            - id: index
              source: index
          out:
            - id: output
          run:
            class: CommandLineTool
            cwlVersion: v1.0
            $namespaces:
              sbg: 'https://www.sevenbridges.com/'
            id: csvs_to_sqlite
            baseCommand:
              - csvs-to-sqlite
            inputs:
              - default:
                  class: File
                  path: >-
                    /mnt/datashare/home/kongxiangya/test/ceshi/csvs-to-sqlite/geneInfo.csv
                id: csv
                type: File
                inputBinding:
                  position: 100
              - default: out
                id: db
                type: string?
                inputBinding:
                  position: 101
              - default: ''
                id: table
                type: string?
                inputBinding:
                  position: 102
                  prefix: '-t'
                  valueFrom: $(inputs.db)
              - default: ','
                id: sep
                type: string?
                inputBinding:
                  position: 0
                  prefix: '-s'
              - id: strings
                type: boolean?
                inputBinding:
                  position: 0
                  prefix: '--just-strings'
              - default: ''
                id: shape
                type: string?
                inputBinding:
                  position: 0
                  prefix: '--shape'
              - default: 'GeneID,Symbol'
                id: index
                type: string?
            outputs:
              - id: output
                type: File?
                outputBinding:
                  glob: $(inputs.db)
            label: csvs-to-sqlite
            arguments:
              - position: 1000
                shellQuote: false
                valueFrom: >-
                  ${ if (!inputs.db.endsWith(".db")){ return  `&& mv
                  ${inputs.db}.db ${inputs.db}`; } return "" }
              - position: 900
                shellQuote: false
                valueFrom: |-
                  ${ if (inputs.index !== "")
                      { 
                        let resultStr = ''
                        let strArr=inputs.index.split(",")
                        let i = 0
                        for(i=0;i<strArr.length;i++){
                          resultStr += ` -i ${strArr[i]}`
                          
                         }
                        return  resultStr; 
                      } 
                        return "" 
                      
                  }
            requirements:
              - class: ShellCommandRequirement
              - class: DockerRequirement
                dockerPull: 'harbor.bio-it.cn:5000/library/py38_r403:csvs-to-sqlite-1.3'
              - class: InlineJavascriptRequirement
          label: csvs-to-sqlite
          'sbg:x': -344.40106201171875
          'sbg:y': -80.16669464111328
      requirements: []
      'sbg:reRun': true
    label: csvs-to-sqlite_workflow
    'sbg:x': 2641.832275390625
    'sbg:y': -31.1866455078125
  - id: csvs_to_sqlite_workflow_1
    in:
      - id: csv
        source: rename_cwl_wk_1/final
      - id: db
        source: db_1
    out:
      - id: output
    run:
      class: Workflow
      cwlVersion: v1.0
      id: csvs_to_sqlite_workflow
      label: csvs-to-sqlite_workflow
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      inputs:
        - id: csv
          type: File
          default:
            class: File
            path: >-
              /mnt/datashare/home/kongxiangya/test/ceshi/csvs-to-sqlite/geneInfo.csv
          'sbg:x': -556.1796875
          'sbg:y': -78.16699981689453
        - id: sep
          type: string?
          default: ','
          'sbg:exposed': true
        - id: shape
          type: string?
          default: ''
          'sbg:exposed': true
        - id: strings
          type: boolean?
          default: false
          'sbg:exposed': true
        - id: db
          type: string?
          default: out.db
          'sbg:exposed': true
        - id: index
          type: string?
          'sbg:exposed': true
      outputs:
        - id: output
          outputSource:
            - csvs_to_sqlite/output
          type: File?
          'sbg:x': -134.17970275878906
          'sbg:y': -80.16699981689453
      steps:
        - id: csvs_to_sqlite
          in:
            - id: csv
              source: csv
            - id: db
              source: db
            - id: sep
              source: sep
            - id: strings
              source: strings
            - id: shape
              source: shape
            - id: index
              source: index
          out:
            - id: output
          run:
            class: CommandLineTool
            cwlVersion: v1.0
            $namespaces:
              sbg: 'https://www.sevenbridges.com/'
            id: csvs_to_sqlite
            baseCommand:
              - csvs-to-sqlite
            inputs:
              - default:
                  class: File
                  path: >-
                    /mnt/datashare/home/kongxiangya/test/ceshi/csvs-to-sqlite/geneInfo.csv
                id: csv
                type: File
                inputBinding:
                  position: 100
              - default: out
                id: db
                type: string?
                inputBinding:
                  position: 101
              - default: ''
                id: table
                type: string?
                inputBinding:
                  position: 102
                  prefix: '-t'
                  valueFrom: $(inputs.db)
              - default: ','
                id: sep
                type: string?
                inputBinding:
                  position: 0
                  prefix: '-s'
              - id: strings
                type: boolean?
                inputBinding:
                  position: 0
                  prefix: '--just-strings'
              - default: ''
                id: shape
                type: string?
                inputBinding:
                  position: 0
                  prefix: '--shape'
              - default: 'GeneID,Symbol'
                id: index
                type: string?
            outputs:
              - id: output
                type: File?
                outputBinding:
                  glob: $(inputs.db)
            label: csvs-to-sqlite
            arguments:
              - position: 1000
                shellQuote: false
                valueFrom: >-
                  ${ if (!inputs.db.endsWith(".db")){ return  `&& mv
                  ${inputs.db}.db ${inputs.db}`; } return "" }
              - position: 900
                shellQuote: false
                valueFrom: |-
                  ${ if (inputs.index !== "")
                      { 
                        let resultStr = ''
                        let strArr=inputs.index.split(",")
                        let i = 0
                        for(i=0;i<strArr.length;i++){
                          resultStr += ` -i ${strArr[i]}`
                          
                         }
                        return  resultStr; 
                      } 
                        return "" 
                      
                  }
            requirements:
              - class: ShellCommandRequirement
              - class: DockerRequirement
                dockerPull: 'harbor.bio-it.cn:5000/library/py38_r403:csvs-to-sqlite-1.3'
              - class: InlineJavascriptRequirement
          label: csvs-to-sqlite
          'sbg:x': -344.40106201171875
          'sbg:y': -80.16669464111328
      requirements: []
      'sbg:reRun': true
    label: csvs-to-sqlite_workflow
    'sbg:x': 2642.706298828125
    'sbg:y': -204.80242919921875
  - id: analysis_single_exomiser_wf_v2_cwl
    in:
      - id: yml
        source: yml
      - id: version
        default: '2109'
      - id: vcf
        source: tabix/VCF_o_gz
      - id: removeMuta
        default:
          - SYNONYMOUS_VARIANT
      - id: maxFreq
        default: 10
      - id: hpoIds
        source:
          - hpoIds
      - id: genomeAssembly
        source: ref_version
      - id: dataDir
        source: dataDir
    out:
      - id: yamloutput
      - id: output
      - id: config
      - id: html
      - id: json
    run:
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

                      parser.add_option("--genomeAssembly",
                      dest="genomeAssembly",  help="hg19 or hg38")

                      parser.add_option("--outpref", dest="outpref", 
                      help="outputPrefix")

                      parser.add_option("--vcf", dest="vcf",  help="vcf input,
                      tbi requre")

                      parser.add_option("--pathSources", dest="pathSources",  
                      help="pathogenicitySources")

                      parser.add_option("--maxFreq", dest="maxFreq",  default= 1
                      , help="maxFreq")

                      parser.add_option("--analysisMode", dest="analysisMode", 
                      default= "PASS_ONLY" , help="PASS_ONLY ")

                      parser.add_option("--version", dest="version",  default=
                      "2109" , help="data-version")

                      parser.add_option("--outyaml", dest="outyaml",  
                      help="file name of output yaml")


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

                      ymlInfo["analysis"]["pathogenicitySources"]  =
                      list(map(lambda x:x.strip(),pathSources.split(",")))


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

                      parser.add_option("--inherentfiles",
                      dest="inherentfiles", 
                      help="*_AD/AR/XR/XD/MT.variants.tsv")

                      parser.add_option("--jsonIn", dest="jsonIn", 
                      help="*json")

                      parser.add_option("--output", dest="output",  help="name
                      of output file")


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
                      x:"EXOMISER_GENE_COMBINED_SCORE(" + x +
                      ")",InheritanceList))


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

                      dataVaraint["maxScore"] =
                      dataVaraint["maxScore"].fillna(0)


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
    label: analysis_single_exomiser-wf_v2.cwl
    'sbg:x': 1003.3292236328125
    'sbg:y': -335.1891784667969
  - id: hpo_omim_anno_cn
    in:
      - id: UnAnno_file
        source: geneanno/output_1
      - id: HPO_db
        source: HPO_db
      - id: OMIM_db
        source: OMIM_db
    out:
      - id: Annotated_data
    run: ./hpo_omim_anno_cn.cwl
    label: HPO_OMIM_Anno_cn
    'sbg:x': 1403.4437255859375
    'sbg:y': 134.0059356689453
requirements:
  - class: SubworkflowFeatureRequirement
