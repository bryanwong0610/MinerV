class: Workflow
cwlVersion: v1.0
id: rename_cwl_wk
label: rename.cwl.wk
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: original
    type: File
    'sbg:x': -348.53125
    'sbg:y': -168.5
  - id: name
    type: string
    'sbg:exposed': true
outputs:
  - id: final
    outputSource:
      - renametool/final
    type: File
    'sbg:x': 14.46875
    'sbg:y': -226.5
steps:
  - id: renametool
    in:
      - id: name
        source: name
      - id: original
        source: original
    out:
      - id: final
    run:
      class: ExpressionTool
      cwlVersion: v1.0
      doc: >-
        Logically renames a file, but not all workflow engines currently support
        it.  See also staged_rename.cwl
      expression: |
        ${
            var f = inputs.original;
            f.basename = inputs.name;
            return {'final': f};
        }
      inputs:
        name:
          type: string
        original:
          type: File
      label: Renamer
      outputs:
        final:
          type: File
      requirements:
        - class: InlineJavascriptRequirement
    label: Renamer
    'sbg:x': -134
    'sbg:y': -78
requirements: []
