class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: txt2vcf
baseCommand:
  - perl
  - txt2vcf.pl
inputs:
  - id: txt2vcf_file
    type: File?
    inputBinding:
      position: 1
  - id: Trans_result
    type: string?
    inputBinding:
      position: 2
  - id: input_vcf
    type: File?
    inputBinding:
      position: 0
outputs:
  - id: filter_transed_vcf
    type: File?
    outputBinding:
      glob: $(inputs.Trans_result)
label: txt2vcf
requirements:
  - class: DockerRequirement
    dockerPull: 'harbor.bio-it.cn:5000/library/perl_variminer:latest'
  - class: InitialWorkDirRequirement
    listing:
      - entryname: txt2vcf.pl
        entry: "      \n#!/usr/bin/env perl\nuse warnings;\nuse strict;\nuse Pod::Usage;\nuse Getopt::Long;\nuse File::Basename;\nuse File::Spec;\n\nour $DATE =\t'$Date: 2020-06-08 00:46:07 -0400 (Mon,  8 Jun 2020) $';\nmy $queryfile=$ARGV[0];\nmy $annMuta=$ARGV[1];\nour $outfile=$ARGV[2];\nsub backConvertVCF {\n\tmy ($multiannofile, $vcfin) = @_;\n\topen (MANNO, $multiannofile) or die \"Error: cannot read from multianno file $multiannofile: $!\\n\";\n\tprint STDERR \"NOTICE: Reading from $multiannofile\\n\";\n\t$_ = <MANNO>;\n\ts/[\\r\\n]+$//;\n\ts/Otherinfo1.+/Otherinfo/;\t\t#20191010: now that we chagned \"Otherinfo\" to \"Otherinfo1 Otherinfo2 Otherinfo3\" etc, to keep the program working, we have to do some trick here to only keep the first Otherinfo\n\tmy @name = split (/\\t/, $_);\n\t$name[$#name] =~ m/^Otherinfo/ or die \"Error: the last column in header row should start with 'Otherinfo'\\n\";\n    \n\tmy @nextrecord;\n\tmy (@field, @prefield);\n\tmy ($anno_string, $pre_anno_string);\n\n\topen (OUT, \">$outfile\") or die \"Error: cannot write to output file $outfile\\n\";\n\tprint STDERR \"-----------------------------------------------------------------\\n\";\n\tprint STDERR \"NOTICE: VCF output is written to $outfile \\n\";\n\n\t#open (IN, $vcfin) or die \"Error: cannot read from input VCF file $vcfin: $!\\n\";\n\n\tif ($vcfin =~ m/\\.gz$/) {\t\t#handle vcf.gz file\n\t\topen (IN, \"gunzip -c $vcfin |\") or die \"Error: cannot read from input VCF file $vcfin: $!\\n\";\n\t} else {\n\t\topen (IN, $vcfin) or die \"Error: cannot read from input VCF file $vcfin: $!\\n\";\n\t}\n\n\twhile (<IN>) {\n\t\ts/[\\r\\n]+$//;\n\t\tif (m/^##/) {\n\t\t\tprint OUT $_, \"\\n\";\n\t\t} elsif (m/^#CHROM/) {\n\t\t\tprint OUT qq{##INFO=<ID=ANNOVAR_DATE,Number=1,Type=String,Description=\"Flag the start of ANNOVAR annotation for one alternative allele\">\\n};\n\t\t\tfor my $i (0 .. @name-1) {\n\t\t\t\tif ($name[$i] =~ m/^(Chr|Start|End|Ref|Alt)$/) {\n\t\t\t\t\t1;\t\t\t\t\t#these are annovar input and are not in INFO field when printed out\n\t\t\t\t} elsif ($name[$i] =~ m/^(1000g\\d+|esp\\d+|cg\\d+|popfreq|nci\\d+|ExAC|gnomAD)/) {\n\t\t\t\t\tprint OUT qq{##INFO=<ID=$name[$i],Number=1,Type=Float,Description=\"$name[$i] annotation provided by ANNOVAR\">\\n};\n\t\t\t\t} elsif ($name[$i] =~ m/^Otherinfo/) {\t\t#this is the field that stores VCF information, and will not be in the annotation in INFO field\n\t\t\t\t\t1;\n\t\t\t\t} else {\n\t\t\t\t\tprint OUT qq{##INFO=<ID=$name[$i],Number=.,Type=String,Description=\"$name[$i] annotation provided by ANNOVAR\">\\n};\n\t\t\t\t}\n\t\t\t}\n\t\t\tprint OUT qq{##INFO=<ID=ALLELE_END,Number=0,Type=Flag,Description=\"Flag the end of ANNOVAR annotation for one alternative allele\">\\n};\n\t\t\tprint OUT $_, \"\\n\";\n\t\t\tlast;\n\t\t} elsif (m/^#/) {\n\t\t\tprint OUT $_, \"\\n\";\n\t\t} else {\n\t\t\tlast;\t\t#could be a VCF file without a valid head line\n\t\t}\n\t}\n\tclose (IN);\n\n\twhile (<MANNO>) {\n\t\ts/[\\r\\n]+$//;\n\t\tmy $anno_string;\n\t\t@field = split (/\\t/, $_);\n\n\t\tif ($DATE =~ m/Date: (\\d+\\-\\d+\\-\\d+)/) {\n\t\t\t$anno_string = \";ANNOVAR_DATE=$1\";\n\t\t} else {\n\t\t\t$anno_string = \";ANNOVAR_DATE=UNKNOWN\";\n\t\t}\n\t\tfor my $i (5 .. @name-2) {\t\t#these are all the annotation columns (starting from 6th column to the last one, which is Otherinfo which will not be written)\n\t\t\t$field[$i] =~ s/\\s/_/g;\t\t#convert 'nonsynonymous SNV' to 'nonsynonymous' as space is not allowed in VCF INFO field, yet _ is easier to view for users\n\t\t\t$field[$i] =~ s/;/\\\\x3b/g;\t#; is not allowed in VCF INFO field\n\t\t\t$field[$i] =~ s/=/\\\\x3d/g;\t#= is not allowed in VCF INFO field\n\t\t\t$anno_string .= \";$name[$i]=$field[$i]\";\t#the 8th column in Otherinfo is INFO column (plus the freq, quality, dp column)\n\t\t}\n\t\t$anno_string .= \";ALLELE_END\";\n\n\t\tdefined $field[@name+3] or die \"field not defined for @name\";\n\t\t@prefield and (defined $prefield[$#field] or die \"prefield not defined (@prefield) with field=\" . scalar(@field) . \" and prefield=\" . scalar(@prefield));\n\t\tif (@prefield and join (\"\\t\", @field[@name+3 .. $#field]) eq join (\"\\t\", @prefield[@name+3 .. $#field])) {\t\t#same locus, multiple alternative allele\n\t\t\t$pre_anno_string .= $anno_string;\n\n\t\t} else {\n\t\t\tif (@prefield) {\n\t\t\t\t$prefield[@name+9] .= $pre_anno_string;\t\t#update INFO field\n\t\t\t\tprint OUT join (\"\\t\", @prefield[@name+2 .. $#prefield]), \"\\n\";\n\t\t\t}\n\n\t\t\t@prefield = @field;\n\t\t\t$pre_anno_string = $anno_string;\n\t\t}\n\t}\n\t$prefield[@name+9] .= $pre_anno_string;\n\tprint OUT join (\"\\t\", @prefield[@name+2 .. $#prefield]), \"\\n\";\n}\n\nbackConvertVCF ($annMuta, $queryfile);"
        writable: true
  - class: InlineJavascriptRequirement
