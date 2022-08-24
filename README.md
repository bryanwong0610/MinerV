# Varminer
## Intro
A workflow to annotate and evaluate the variation pathogenicity of human Exome Sequencing data , Whole Genome Sequencing data, MT-DNA sequencing Data for clinical diagnosis.
## How to use?
 * Firstly to be ensure the Docker already installed on your equipments([Docker](https://www.docker.com) support Linux,Mac,Windows system)
 * Patient's disease features and phenotype should be known, using those description word to select the most matching HPO id by [Phenomizer](https://compbio.charite.de/phenomizer/)
 * Prepare a yaml file configuration process requirements.
 * Ability to use the command line 
## Purpose
Since the reduction in the costs of NGS, the detection of genetic variants has become more convenient, sequencing technology gradually being applied in clinical diagnosis.There were many nucleotide variation happening in the human genome, but most of those variations were [benign](https://www.genome.gov/news/news-release/Genomics-daunting-challenge-Identifying-variants-that-matter).
So,it's a great challenge to select the most likely pathogenic variation for doctors and scientists. Therefore many institutions publish their guideline to help researchers better to find out the most pathogenic mutation ,such as the [ACMG](https://www.gimjournal.org/article/S1098-3600(21)03031-8/fulltext).And also many databases was released to recording the pathogenicity and related phenotype of SNPs.([ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/),[decipher](https://www.deciphergenomics.org/patient/263708/genotype/241078/browser),etc…).Apply those resources,we can easily to find out some valuable candidate variation site to treat the patients disease by some special target. Here we construct a comprehensive workflow ,by using the released tools ,to annotate the NGS data (now support the [VCF](https://www.internationalgenome.org/wiki/Analysis/vcf4.0/) format) and filtering the variant data (which can be set up by user), in order to get the most related variation informations for clinical diagnosis.
## This workflow constructed by :
 * [annovar](https://annovar.openbioinformatics.org/en/latest/)
 * [tabix](https://www.htslib.org/doc/tabix.html)
 * [exomiser](https://exomiser.monarchinitiative.org/exomiser/#:~:text=The%20Exomiser%20is%20a%20Java%20program%20that%20functionally,KnownGene%20transcript%20definitions%20and%20%20hg19%20genomic%20coordinates.)
 * [hmtnote](https://hmtnote.readthedocs.io/en/latest/index.html)
 * [spliceAI](https://github.com/Illumina/SpliceAI)
 * [interVar](https://github.com/WGLab/InterVar)
 * [R](https://www.r-project.org)
 * [python](https://www.python.org)
 * shell
 * [cwl](https://www.commonwl.org/#:~:text=Common%20Workflow%20Language%20%28CWL%29%20is%20an%20open%20standard,variety%20of%20platforms%20that%20support%20the%20CWL%20standards.)
 * etc....
## Pipeline 
  ### WES & WGS data annotating and filter
  <img width="996" alt="截屏2022-08-22 17 57 50" src="https://user-images.githubusercontent.com/53446971/185894488-ef6bcffb-e008-4b70-9472-86e0bfc6b111.png">
  
### API :
   * HPOid
   * splicing_threshold
   * Sample_name
   * MAF cutoff
   * Ref genome version
   * filter rule :
      * region rule
      * effect rule
      * MAF database








