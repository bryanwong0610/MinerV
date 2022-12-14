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
