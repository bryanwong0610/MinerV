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
