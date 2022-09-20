class: Workflow
cwlVersion: v1.0
id: hmtnote_wf
label: hmtnote_wf
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: vcf_gz
    type: File?
    'sbg:x': -467
    'sbg:y': -150
  - id: Output_name
    type: string?
    'sbg:x': -131
    'sbg:y': 116
outputs:
  - id: annotated_vcf
    outputSource:
      - hmtnote/annotated_vcf
    type: File?
    'sbg:x': 128.60113525390625
    'sbg:y': -138
  - id: annotated_csv
    outputSource:
      - hmtnote/annotated_csv
    type: File?
    'sbg:x': 140.60113525390625
    'sbg:y': 141
steps:
  - id: ungz
    in:
      - id: vcf_gz
        source: analysis_single_exomiser_wf_v1/VCF_o_gz
    out:
      - id: uncomposed
    run: ./ungz.cwl
    label: ungz
    'sbg:x': -91
    'sbg:y': -123
  - id: analysis_single_exomiser_wf_v1
    in:
      - id: vcf_gz
        source: vcf_gz
    out:
      - id: VCF_o_gz
    run: ./vcf_sort.json
    label: sort_vcf
    'sbg:x': -268
    'sbg:y': -67
  - id: hmtnote
    in:
      - id: vcf_file
        source: ungz/uncomposed
      - id: Output_name
        source: Output_name
    out:
      - id: annotated_vcf
      - id: annotated_csv
    run: ./hmtnote.cwl
    label: hmtnote
    'sbg:x': 33
    'sbg:y': 1
requirements:
  - class: SubworkflowFeatureRequirement
