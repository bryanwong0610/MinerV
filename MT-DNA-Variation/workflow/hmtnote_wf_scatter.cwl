class: Workflow
cwlVersion: v1.0
id: hmtnote_wf_scatter
label: hmtnote_wf_scatter
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: vcf_gz
    type: 'File[]?'
    'sbg:x': -242.39886474609375
    'sbg:y': -193
  - id: Output_name
    type: 'string[]?'
    'sbg:x': -259.39886474609375
    'sbg:y': -18
outputs:
  - id: annotated_vcf
    outputSource:
      - hmtnote_wf/annotated_vcf
    type: 'File[]?'
    'sbg:x': 83.60113525390625
    'sbg:y': -202
  - id: annotated_csv
    outputSource:
      - hmtnote_wf/annotated_csv
    type: 'File[]?'
    'sbg:x': 100.60113525390625
    'sbg:y': 40
steps:
  - id: hmtnote_wf
    in:
      - id: vcf_gz
        source: vcf_gz
      - id: Output_name
        source: Output_name
    out:
      - id: annotated_vcf
      - id: annotated_csv
    run: ./hmtnote_wf.cwl
    label: hmtnote_wf
    scatter:
      - Output_name
      - vcf_gz
    scatterMethod: dotproduct
    'sbg:x': -80
    'sbg:y': -103
requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
