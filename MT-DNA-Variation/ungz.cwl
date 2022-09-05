class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: ungz
baseCommand:
  - gunzip
  - '-c'
inputs:
  - id: vcf_gz
    type: File?
    inputBinding:
      position: 0
outputs:
  - id: uncomposed
    type: File?
    outputBinding:
      glob: '*.vcf'
label: ungz
arguments:
  - position: 1
    prefix: '>'
    shellQuote: false
    valueFrom: a.vcf
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/tabix:1.11--hdfd78af_0'
