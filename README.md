# Varminer
## Intro
A workflow to annotate and validate the variation pathogenicty of human Exome Sequencing data , Whole Genome Sequencing data, MT-DNA sequencing Data for clinical diagnosis.
## How to use?
 * Firstly to be ensure the Docker already installed on your equipments([Docker](https://www.docker.com) support Linux,Mac,Windows,system)
## Purpose
To validate the SNP pathogenicity for human 
## Usage tool :
 * GATK ( if dont have the raw vcf data) (do not program yet)
 * Annovar
 * tabix
 * Exomiser
 * hmtnote
 * python
 * R
 * shell
 * cwl
 * ect....
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




