class: Workflow
cwlVersion: v1.0
id: vcf2fasta_mt
label: vcf2fasta_MT
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: vcf_gz
    type: File?
    'sbg:x': -447.249267578125
    'sbg:y': -115.00593566894531
  - id: ref_fa
    type: File?
    secondaryFiles:
      - .fai
    'sbg:x': 53.60113525390625
    'sbg:y': -387.99639892578125
  - id: out_fasta
    type: string?
    'sbg:x': -84.78165435791016
    'sbg:y': -276.1625671386719
outputs:
  - id: output
    outputSource:
      - vcf2fasta/output
    type: File?
    'sbg:x': 462.6468505859375
    'sbg:y': -252.9080047607422
steps:
  - id: ungz
    in:
      - id: vcf_gz
        source: vcf_gz
    out:
      - id: uncomposed
    run: ./ungz.cwl
    label: ungz
    'sbg:x': -285
    'sbg:y': -62
  - id: bgzip
    in:
      - id: input
        source: ungz/uncomposed
    out:
      - id: gz_vcf
    run: ../varaiation_platform_cwl/bgzip.cwl
    label: bgzip
    'sbg:x': -78
    'sbg:y': -97
  - id: tabix
    in:
      - id: GZ_Sorted_VCF
        source: bgzip/gz_vcf
    out:
      - id: VCF_o_gz
    run: ../varaiation_platform_cwl/tabix.cwl
    label: tabix
    'sbg:x': 81.12462615966797
    'sbg:y': -105.52225494384766
  - id: vcf2fasta
    in:
      - id: ref_fa
        source: ref_fa
      - id: gz_vcf
        source: tabix/VCF_o_gz
      - id: out_fasta
        source: out_fasta
    out:
      - id: output
    run: ./vcf2fasta.cwl
    label: vcf2fasta
    'sbg:x': 285.7002868652344
    'sbg:y': -123.9792251586914
requirements: []
