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
    secondaryFiles: [.tbi]
    outputBinding:
      glob: "*.vcf.gz"
label: tabix
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/tabix:1.11--hdfd78af_0'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.GZ_Sorted_VCF)
  - class: InlineJavascriptRequirement
