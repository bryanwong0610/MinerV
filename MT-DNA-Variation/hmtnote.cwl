class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: hmtnote
baseCommand:
  - python
  - hmtnote_test.py
inputs:
  - id: vcf_file
    type: File?
    inputBinding:
      position: 0
      prefix: '-i'
      shellQuote: false
  - id: Output_name
    type: string?
    inputBinding:
      position: 1
      prefix: '-s'
outputs:
  - id: annotated_vcf
    type: File?
    outputBinding:
      glob: $(inputs.Output_name)_hmtnote_annotate.vcf
  - id: annotated_csv
    type: File?
    outputBinding:
      glob: $(inputs.Output_name)_hmtnote_annotate.csv
label: hmtnote
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/hmtnote:v1'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: hmtnote_test.py
        entry: >-
          from hmtnote import annotate

          import argparse

          def argument_get():
              parser=argparse.ArgumentParser(prog='Hmtnote_tools',description='A python script for cwl in order to use the hmtnote')
              parser.add_argument('-sample_name','-s',type=str,help='Sample Name')
              parser.add_argument('-input_vcf','-i',type=str,help='Input the unannotated vcf')
              args, _ = parser.parse_known_args()
              args = vars(args)
              print(args) #test
              return args
          args= argument_get()

          output_result=args['sample_name']+'_hmtnote_annotate.vcf'

          annotate(args['input_vcf'],output_result,basic=True,crossref=True,variab=True,predict=True,csv=True,offline=True)
        writable: false
  - class: InlineJavascriptRequirement
