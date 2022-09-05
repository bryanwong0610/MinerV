class: Workflow
cwlVersion: v1.0
id: new_annovar_funtion_wf
label: new_annovar_funtion.wf.cwl
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: annovar_db
    type: Directory?
    'sbg:x': -373
    'sbg:y': 230
  - id: output
    type: 'string[]?'
    'sbg:x': -383.39886474609375
    'sbg:y': 14
  - id: vcf_gz
    type: 'File?[]'
    'sbg:x': -719
    'sbg:y': -129
outputs:
  - id: output_txt
    outputSource:
      - new_annovar_function/output_txt
    type: 'File[]?'
    'sbg:x': 154.40328979492188
    'sbg:y': -100.97119140625
steps:
  - id: new_annovar_function
    in:
      - id: raw_vcf
        source: ungz/output
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
    'sbg:x': -144
    'sbg:y': -85
  - id: ungz
    in:
      - id: vcf_gz
        source: vcf_gz
    out:
      - id: output
    run: ./ungz.cwl
    label: ungz
    scatter:
      - vcf_gz
    scatterMethod: dotproduct
    'sbg:x': -534
    'sbg:y': -176
requirements:
  - class: ScatterFeatureRequirement
