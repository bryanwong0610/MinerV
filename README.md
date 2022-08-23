# Varminer
## Intro
A workflow to annotate and evaluate the variation pathogenicty of human Exome Sequencing data , Whole Genome Sequencing data, MT-DNA sequencing Data for clinical diagnosis.
## How to use?
 * Firstly to be ensure the Docker already installed on your equipments([Docker](https://www.docker.com) support Linux,Mac,Windows system)
 * Patient's disease features and phenotype should be known, using thoese description word to select the most matching HPO id by [Phenomizer](https://compbio.charite.de/phenomizer/)
 * Prepare a yaml file confugration process requierments.
 * Ability to use the comman line 
## Purpose
There were many nucleotide variation happening in the human genome, but most of thoese variation were beign,but how to find out the . Since the reduction in the cost of NGS, the detection of genetics variant has become more conveniet,and sequencing technology gradually being applied in clinical diagnosis for 
Here is a workflow to annotate the NGS data (now support the [VCF](https://www.internationalgenome.org/wiki/Analysis/vcf4.0/) format) ,and filtering the variant data by filtering rule(which can be set up by user).
## Usage tool :
 * GATK ( if dont have the raw vcf data,constructin......) 
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
### Web (which front-end department colleagues assist in establishing)
![截屏2022-08-22 18 12 44](https://user-images.githubusercontent.com/53446971/185897662-ef26ba97-a929-4e99-a2d9-ba31e3a1234f.png)




