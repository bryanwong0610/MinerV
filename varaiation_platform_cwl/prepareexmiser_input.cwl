class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: prepareexmiser_input
baseCommand:
  - python
  - exomiserInput.py
inputs:
  - id: dirdata
    type: Directory?
    inputBinding:
      position: 1
      prefix: '--dirdata'
  - id: yml
    type: File?
    inputBinding:
      position: 3
      prefix: '--yml'
  - id: hpoIds
    type: 'string[]?'
    inputBinding:
      position: 4
      prefix: '--hpoIds'
      itemSeparator: ','
  - id: genomeAssembly
    type: string?
    inputBinding:
      position: 5
      prefix: '--genomeAssembly'
  - id: outpref
    type: string?
    inputBinding:
      position: 6
      prefix: '--outpref'
  - id: vcf
    type: File?
    inputBinding:
      position: 7
      prefix: '--vcf'
  - id: maxFreq
    type: float?
    inputBinding:
      position: 8
      prefix: '--maxFreq'
  - id: version
    type: string?
    inputBinding:
      position: 9
      prefix: '--version'
  - id: outyaml
    type: string?
    default: "test_analysis_exome.yml"
    inputBinding:
      position: 10
      prefix: '--outyaml'
outputs:
  - id: yamloutput
    type: File?
    outputBinding:
      glob: $(inputs.outyaml)
label: prepareExmiser_input
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/r_packages:v2'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: exomiserInput.py
        entry: 
          $include: ./util/exomiserInput.py
        writable: false
  - class: InlineJavascriptRequirement
