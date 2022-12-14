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
