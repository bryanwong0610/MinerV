class: Workflow
cwlVersion: v1.0
id: anno_scatter
label: anno_scatter
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: output
    type: 'string[]?'
    'sbg:x': -226
    'sbg:y': -2
  - id: annovar_db
    type: Directory?
    'sbg:x': -230
    'sbg:y': 112
  - id: vcf_gz
    type: 'File[]?'
    'sbg:x': -406.18798828125
    'sbg:y': -230
outputs:
  - id: output_txt
    outputSource:
      - new_annovar_function/output_txt
    type: File[]?
    'sbg:x': 283.5661315917969
    'sbg:y': -149.5
steps:
  - id: new_annovar_function
    in:
      - id: raw_vcf
        source: ungz/uncomposed
      - id: annovar_db
        source: annovar_db
      - id: ref_version
        default: hg19
      - id: protocol
        default: >-
          refGene,ensGene,avsnp150,popfreq_all_20150413,gnomad211_exome,clinvar_exmpt,predsoft_v1,rmsk,tfbsConsSites,intervar_20180118,spliceAI_2021_02_03
      - id: operation
        default: 'g,g,f,f,f,f,f,r,r,f,f'
      - id: NA_string
        default: .
      - id: rm_tmp
        default: true
      - id: confirm_vcfinput
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
    scatter:
      - raw_vcf
      - output
    scatterMethod: dotproduct
    'sbg:x': 104
    'sbg:y': -108
  - id: ungz
    in:
      - id: vcf_gz
        source: vcf_gz
    out:
      - id: uncomposed
    run: ./ungz.cwl
    label: ungz
    scatter:
      - vcf_gz
    scatterMethod: dotproduct
    'sbg:x': -213.18798828125
    'sbg:y': -172
requirements:
  - class: ScatterFeatureRequirement
