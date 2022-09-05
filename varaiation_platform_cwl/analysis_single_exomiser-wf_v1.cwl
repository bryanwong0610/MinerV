class: Workflow
cwlVersion: v1.0
id: analysis_single_exomiser_wf_v1
label: analysis_single_exomiser.wf_v1
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: vcf
    type: File?
    secondaryFiles:
      - .tbi
    'sbg:x': -702.5
    'sbg:y': -191.5
  - id: version
    type: string?
    default: '2109'
    'sbg:x': -624.5
    'sbg:y': -399.5
  - id: outpref
    type: string?
    default: My_test
    'sbg:x': -719.5
    'sbg:y': -80
  - id: maxFreq
    type: float?
    default: 1
    'sbg:x': -787
    'sbg:y': 69
  - id: hpoIds
    type: 'string[]?'
    'sbg:x': -835.5
    'sbg:y': 228.5
  - id: genomeAssembly
    type: string?
    default: hg19
    'sbg:x': -774.5
    'sbg:y': 364.5
  - id: dirdata
    type: Directory?
    default:
      class: Directory
      path: /mnt/datashare/reference_genome/Exomiser/exomiser-data
    'sbg:x': -512.5
    'sbg:y': 400
  - id: yml
    type: File?
    default:
      class: File
      path: >-
        /mnt/datashare/reference_genome/Exomiser/exomiser-config/test-analysis-exome_test1.yml
    'sbg:x': -676.2197875976562
    'sbg:y': -286.795654296875
outputs:
  - id: adgene
    outputSource:
      - singleexomiser/adgene
    type: File?
    'sbg:x': 251.45201110839844
    'sbg:y': 708.077392578125
  - id: extracted_result
    outputSource:
      - exomiser_res_get/extracted_result
    type: File?
    'sbg:x': 1051.0384521484375
    'sbg:y': -31.322595596313477
steps:
  - id: prepareexmiser_input
    in:
      - id: dirdata
        source: dirdata
      - id: yml
        source: yml
      - id: hpoIds
        source:
          - hpoIds
      - id: genomeAssembly
        source: genomeAssembly
      - id: outpref
        source: outpref
      - id: vcf
        source: vcf
      - id: maxFreq
        source: maxFreq
      - id: version
        source: version
    out:
      - id: yamloutput
    run: ./prepareexmiser_input.cwl
    label: prepareExmiser_input
    'sbg:x': -354.37152099609375
    'sbg:y': -33.061920166015625
  - id: singleexomiser
    in:
      - id: analysis
        source: prepareexmiser_input/yamloutput
      - id: vcf
        source: vcf
      - id: assembly
        source: genomeAssembly
      - id: data
        source: dirdata
      - id: version
        source: version
      - id: outpref
        source: outpref
    out:
      - id: html
      - id: json
      - id: adVCF
      - id: adgene
      - id: arVCF
      - id: argenevar
      - id: xdVCF
      - id: xdgenevar
      - id: xrVCF
      - id: xrgenevar
      - id: mtVCF
      - id: mtgenevar
      - id: adgenec
    run: ./singleexomiser.cwl
    label: singleExomiser
    'sbg:x': 124.16836547851562
    'sbg:y': -159.9222869873047
  - id: exomiser_res_get
    in:
      - id: exomiser_json_res
        source: singleexomiser/json
      - id: exomiser_tsv_res
        source: singleexomiser/adgene
      - id: exomiser_extract_result_name
        default: test
    out:
      - id: extracted_result
    run: ./exomiser_res_get.cwl
    label: exomiser_res_get
    'sbg:x': 730.8402709960938
    'sbg:y': 64.56983947753906
requirements: []
