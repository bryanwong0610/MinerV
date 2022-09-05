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
