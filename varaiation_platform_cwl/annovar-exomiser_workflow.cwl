class: Workflow
cwlVersion: v1.0
id: annovar_exomiser_workflow
label: Annovar&Exomiser_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: raw_vcf
    type: File?
    'sbg:x': -489.48431396484375
    'sbg:y': -93.69962310791016
  - id: annovar_db
    type: Directory?
    'sbg:x': -496.79986572265625
    'sbg:y': 200.66134643554688
  - id: ref_version
    type: string?
    'sbg:x': -488.3419494628906
    'sbg:y': -238.50001525878906
  - id: splicing_threshold
    type: int?
    'sbg:x': -481.4285583496094
    'sbg:y': -372.8571472167969
  - id: output
    type: string?
    'sbg:x': -490.4285888671875
    'sbg:y': 57.92864990234375
  - id: annoPath
    type: Directory?
    'sbg:x': -131.60443115234375
    'sbg:y': 64.90933227539062
  - id: annoFileList
    type: 'string[]?'
    'sbg:exposed': true
outputs:
  - id: output_vcf
    outputSource:
      - new_annovar_function/output_vcf
    type: File?
    'sbg:x': -246.62950134277344
    'sbg:y': -420
  - id: output_txt
    outputSource:
      - new_annovar_function/output_txt
    type: File?
    'sbg:x': -157.10491943359375
    'sbg:y': -289.9737548828125
  - id: output_avinput
    outputSource:
      - new_annovar_function/output_avinput
    type: File?
    'sbg:x': -139.39183044433594
    'sbg:y': 218.5505828857422
  - id: output_1
    outputSource:
      - geneanno/output_1
    type: File?
    'sbg:x': 7.55300760269165
    'sbg:y': -244
steps:
  - id: new_annovar_function
    in:
      - id: raw_vcf
        source: raw_vcf
      - id: annovar_db
        source: annovar_db
      - id: ref_version
        source: ref_version
      - id: splicing_threshold
        source: splicing_threshold
      - id: output
        source: output
    out:
      - id: output_vcf
      - id: output_txt
      - id: output_avinput
    run: ./new_annovar_function.json
    label: New_annovar_function
    'sbg:x': -254.1428680419922
    'sbg:y': -105.9285659790039
  - id: geneanno
    in:
      - id: inputType
        default: txt
      - id: inputFile
        source: new_annovar_function/output_txt
      - id: annoCol
        default: Gene.refGene
      - id: annoPath
        source: annoPath
      - id: output
        default: change_test.txt
      - id: annoFileList
        default:
          - annotation
          - OMIM
          - GO
          - DO
          - HPO
          - KEGG
          - WIKI
          - REACTOME
          - BIOCARTA
          - HALLMARK
          - PID
        source:
          - annoFileList
      - id: geneAlias
        default: 'yes'
    out:
      - id: output_1
    run: ./geneanno.json
    label: geneAnno
    'sbg:x': -57.662540435791016
    'sbg:y': -102.69349670410156
  - id: new_annovar_filter
    in:
      - id: Input_file
        source: geneanno/output_1
    out: []
    run: ./new_annovar_filter.cwl
    label: New_annovar_filter
    'sbg:x': 134.4597625732422
    'sbg:y': -99.0495376586914
requirements: []
