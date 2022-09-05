class: Workflow
cwlVersion: v1.0
id: exomiser_scatter
label: exomiser_scatter
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: yml
    type: File?
    'sbg:x': -294
    'sbg:y': -269
  - id: vcf_gz
    type: 'File[]?'
    'sbg:x': -274
    'sbg:y': -156
  - id: exomiser_extract_result_name
    type: 'string[]?'
    'sbg:x': -249
    'sbg:y': 106
  - id: dirdata
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/Exomiser/exomiser-data
    'sbg:x': -91.2734375
    'sbg:y': 105
  - id: hpoIds
    type: 'string[]?'
    'sbg:x': -278
    'sbg:y': -44
outputs:
  - id: extracted_result
    outputSource:
      - analysis_single_exomiser_wf_v1/extracted_result
    type: 'File[]?'
    'sbg:x': 206.797119140625
    'sbg:y': -313
steps:
  - id: analysis_single_exomiser_wf_v1
    in:
      - id: version
        default: '2109'
      - id: outpref
        default: my_test
      - id: maxFreq
        default: 10
      - id: hpoIds
        source:
          - hpoIds
      - id: genomeAssembly
        default: hg19
      - id: dirdata
        source: dirdata
      - id: yml
        source: yml
      - id: vcf_gz
        source: vcf_gz
      - id: exomiser_extract_result_name
        source: exomiser_extract_result_name
    out:
      - id: extracted_result
    run: ./analysis_single_exomiser-wf_v1.cwl
    label: analysis_single_exomiser.wf_v1
    scatter:
      - vcf_gz
      - exomiser_extract_result_name
    scatterMethod: dotproduct
    'sbg:x': 17
    'sbg:y': -191
requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
