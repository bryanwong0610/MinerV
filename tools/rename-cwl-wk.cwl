class: Workflow
cwlVersion: v1.0
id: rename_cwl_wk
label: rename.cwl.wk
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs: []
outputs: []
steps:
  - id: renametool
    in: []
    out:
      - id: final
    run: ./renametool.cwl
    label: Renamer
    'sbg:x': -102
    'sbg:y': -44
requirements: []
