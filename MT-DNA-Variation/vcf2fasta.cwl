class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: vcf2fasta
baseCommand:
  - cat
inputs:
  - id: ref_fa
    type: File?
    inputBinding:
      position: 0
      shellQuote: false
    secondaryFiles:
      - .fai
  - id: gz_vcf
    type: File?
    inputBinding:
      position: 5
      shellQuote: false
    secondaryFiles:
      - .tbi
  - id: out_fasta
    type: string?
    inputBinding:
      position: 7
      shellQuote: false
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: $(inputs.out_fasta)
label: vcf2fasta
arguments:
  - position: 1
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '|'
  - position: 2
    prefix: bcftools
    shellQuote: false
    valueFrom: 'consensus '
  - position: 6
    prefix: ''
    shellQuote: false
    valueFrom: '>'
  - position: 3
    prefix: '--haplotype'
    shellQuote: false
    valueFrom: LA
  - position: 4
    prefix: '--include'
    shellQuote: false
    valueFrom: '''TYPE="snp"||TYPE="indel"||TYPE="mnp"'''
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/bcftools:1.15.1--h0ea216a_0'
  - class: InlineJavascriptRequirement
