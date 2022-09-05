class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: picard
baseCommand:
  - java
  - '-jar'
  - /usr/picard/picard.jar
  - SortVcf
inputs:
  - id: unsort_VCF
    type: File?
    inputBinding:
      position: 0
      prefix: I=
      separate: false
  - id: output_filename
    type: string?
    inputBinding:
      position: 1
      prefix: O=
      separate: false
outputs:
  - id: Sorted_vcf
    type: File?
    outputBinding:
      glob: $(inputs.output_filename)
label: picard
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/picard:2.24.2'
  - class: InlineJavascriptRequirement
