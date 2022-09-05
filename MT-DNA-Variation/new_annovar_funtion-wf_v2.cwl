{
    "class": "Workflow",
    "cwlVersion": "v1.0",
    "id": "new_annovar_funtion_wf",
    "label": "new_annovar_funtion.wf.cwl",
    "$namespaces": {
        "sbg": "https://www.sevenbridges.com/"
    },
    "inputs": [
        {
            "id": "annovar_db",
            "type": "Directory?",
            "sbg:x": -373,
            "sbg:y": 230
        },
        {
            "id": "output",
            "type": "string[]?",
            "sbg:x": -383.39886474609375,
            "sbg:y": 14
        },
        {
            "id": "vcf_gz",
            "type": "File[]?",
            "sbg:x": -719,
            "sbg:y": -129
        }
    ],
    "outputs": [
        {
            "id": "output_txt",
            "outputSource": [
                "new_annovar_function/output_txt"
            ],
            "type": "File[]?",
            "sbg:x": 154.40328979492188,
            "sbg:y": -100.97119140625
        }
    ],
    "steps": [
        {
            "id": "new_annovar_function",
            "in": [
                {
                    "id": "raw_vcf",
                    "source": "ungz/output"
                },
                {
                    "id": "annovar_db",
                    "source": "annovar_db"
                },
                {
                    "id": "ref_version",
                    "default": "hg19"
                },
                {
                    "id": "protocol",
                    "default": "refGene,ensGene,avsnp150,popfreq_all_20150413,gnomad211_exome,clinvar_exmpt,predsoft_v1,rmsk,tfbsConsSites,intervar_20180118,spliceAI_2021_02_03"
                },
                {
                    "id": "operation",
                    "default": "g,g,f,f,f,f,f,r,r,f,f"
                },
                {
                    "id": "NA_string",
                    "default": "."
                },
                {
                    "id": "rm_tmp",
                    "default": true
                },
                {
                    "id": "confirm_vcfinput",
                    "default": true
                },
                {
                    "id": "output",
                    "source": "output"
                },
                {
                    "id": "other_info",
                    "default": true
                }
            ],
            "out": [
                {
                    "id": "output_vcf"
                },
                {
                    "id": "output_txt"
                },
                {
                    "id": "output_avinput"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.0",
                "$namespaces": {
                    "sbg": "https://www.sevenbridges.com/"
                },
                "id": "new_annovar_function",
                "baseCommand": [
                    "table_annovar.pl"
                ],
                "inputs": [
                    {
                        "id": "raw_vcf",
                        "type": "File?",
                        "inputBinding": {
                            "position": 1
                        }
                    },
                    {
                        "default": {
                            "class": "Directory",
                            "path": "/mnt/datashare/annovar_db/humandb"
                        },
                        "id": "annovar_db",
                        "type": "Directory?",
                        "inputBinding": {
                            "position": 2
                        }
                    },
                    {
                        "default": "hg19",
                        "id": "ref_version",
                        "type": "string?",
                        "inputBinding": {
                            "position": 3,
                            "prefix": "-buildver"
                        }
                    },
                    {
                        "default": "refGene,ensGene,avsnp150,popfreq_all_20150413,gnomad211_exome,clinvar_exmpt,predsoft_v1,rmsk,tfbsConsSites,intervar_20180118,spliceAI_2021_02_03",
                        "id": "protocol",
                        "type": "string?",
                        "inputBinding": {
                            "position": 4,
                            "prefix": "-protocol"
                        }
                    },
                    {
                        "default": "g,g,f,f,f,f,f,r,r,f,f",
                        "id": "operation",
                        "type": "string?",
                        "inputBinding": {
                            "position": 5,
                            "prefix": "-operation"
                        }
                    },
                    {
                        "default": ".",
                        "id": "NA_string",
                        "type": "string?",
                        "inputBinding": {
                            "position": 6,
                            "prefix": "-nastring"
                        }
                    },
                    {
                        "id": "splicing_threshold",
                        "type": "int?",
                        "inputBinding": {
                            "position": 7,
                            "prefix": "-intronhgvs"
                        }
                    },
                    {
                        "default": true,
                        "id": "rm_tmp",
                        "type": "boolean?",
                        "inputBinding": {
                            "position": 8,
                            "prefix": "-remove"
                        }
                    },
                    {
                        "default": true,
                        "id": "confirm_vcfinput",
                        "type": "boolean?",
                        "inputBinding": {
                            "position": 9,
                            "prefix": "-vcfinput"
                        }
                    },
                    {
                        "default": "test",
                        "id": "output",
                        "type": "string?",
                        "inputBinding": {
                            "position": 11,
                            "prefix": "-out"
                        }
                    },
                    {
                        "default": true,
                        "id": "other_info",
                        "type": "boolean?",
                        "inputBinding": {
                            "position": 10,
                            "prefix": "-otherinfo"
                        }
                    }
                ],
                "outputs": [
                    {
                        "id": "output_vcf",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "$(inputs.output)*_multianno.vcf"
                        }
                    },
                    {
                        "id": "output_txt",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "$(inputs.output)*_multianno.txt"
                        }
                    },
                    {
                        "id": "output_avinput",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "$(inputs.output).avinput"
                        }
                    }
                ],
                "label": "New_annovar_function",
                "requirements": [
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "harbor.bio-it.cn:5000/library/annovar:latest"
                    },
                    {
                        "class": "InlineJavascriptRequirement"
                    }
                ]
            },
            "label": "New_annovar_function",
            "scatter": [
                "raw_vcf",
                "output"
            ],
            "scatterMethod": "dotproduct",
            "sbg:x": -144,
            "sbg:y": -85
        },
        {
            "id": "ungz",
            "in": [
                {
                    "id": "vcf_gz",
                    "source": "vcf_gz"
                }
            ],
            "out": [
                {
                    "id": "output"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.0",
                "$namespaces": {
                    "sbg": "https://www.sevenbridges.com/"
                },
                "id": "ungz",
                "baseCommand": [
                    "gunzip"
                ],
                "inputs": [
                    {
                        "id": "vcf_gz",
                        "type": "File?",
                        "inputBinding": {
                            "position": 0
                        }
                    }
                ],
                "outputs": [
                    {
                        "id": "output",
                        "type": "File?",
                        "outputBinding": {
                            "glob": "*.vcf"
                        }
                    }
                ],
                "label": "ungz",
                "requirements": [
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "harbor.bio-it.cn:5000/library/tabix:1.11--hdfd78af_0"
                    }
                ]
            },
            "label": "ungz",
            "scatter": [
                "vcf_gz"
            ],
            "scatterMethod": "dotproduct",
            "sbg:x": -534,
            "sbg:y": -176
        }
    ],
    "requirements": [
        {
            "class": "ScatterFeatureRequirement"
        }
    ]
}