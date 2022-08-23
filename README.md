# Varminer
## Intro
A workflow to annotate and evaluate the variation pathogenicity of human Exome Sequencing data , Whole Genome Sequencing data, MT-DNA sequencing Data for clinical diagnosis.
## How to use?
 * Firstly to be ensure the Docker already installed on your equipments([Docker](https://www.docker.com) support Linux,Mac,Windows system)
 * Patient's disease features and phenotype should be known, using those description word to select the most matching HPO id by [Phenomizer](https://compbio.charite.de/phenomizer/)
 * Prepare a yaml file configuration process requirements.
 * Ability to use the command line 
## Purpose
Since the reduction in the costs of NGS, the detection of genetic variants has become more convenient, sequencing technology gradually being applied in clinical diagnosis.There were many nucleotide variation happening in the human genome, but most of those variations were benign[1](https://www.genome.gov/news/news-release/Genomics-daunting-challenge-Identifying-variants-that-matter).
It's a great challenge to select the most likely pathogenic variation for doctors and scientists. Therefore many institutions publish their guideline to help researchers better to find out the most pathogenic mutation ,such as the [ACMG](https://www.gimjournal.org/article/S1098-3600(21)03031-8/fulltext).And also many databases was released to recording the pathogenicity and related phenotype of SNPs.([ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/),[decipher](https://www.deciphergenomics.org/patient/263708/genotype/241078/browser),etc…).Apply those resources,we can easily to find out some valuable candidate variation site to treat the patients disease by some special target. Now by using the released tools to construct a comprehensive workflow to annotate the NGS data (now support the [VCF](https://www.internationalgenome.org/wiki/Analysis/vcf4.0/) format) and filtering the variant data by filtering rule(which can be set up by user),in order to get the most related variation informations for clinical diagnosis.
## This workflow constructed by :
 * annovar
 * tabix
 * exomiser
 * hmtnote
 * python
 * R
 * shell
 * cwl
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








