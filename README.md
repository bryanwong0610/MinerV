# MinerV
## Intro
A workflow to annotate and evaluate the variation pathogenicity of human Exome Sequencing data, Whole Genome Sequencing data, and MT-DNA sequencing data for clinical diagnosis.
## How to use?
 * Firstly ensure the Docker is already installed on your equipment ([Docker](https://www.docker.com) support Linux, Mac, Windows system)
 * Patient's disease features and phenotype should be known, using those description words to select the most matching HPO id by [Phenomizer](https://compbio.charite.de/phenomizer/)
 * Prepare a `YAML` file configuration process requirements.
## Purpose
Since the reduction in the costs of NGS, the detection of genetic variants has become more convenient, and sequencing technology is gradually being applied in clinical diagnosis. Many single nucleotide variations were happening in the human genome, but most of those variations were [benign](https://www.genome.gov/news/news-release/Genomics-daunting-challenge-Identifying-variants-that-matter).
So, it's a great challenge to select the most likely pathogenic variation for doctors and scientists. Therefore many institutions publish their guideline to help researchers better to find out the most pathogenic mutation, such as the [ACMG](https://www.gimjournal.org/article/S1098-3600(21)03031-8/fulltext). And also many databases were released to record the pathogenicity and related phenotype of SNPs.([ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/),[decipher](https://www.deciphergenomics.org/patient/263708/genotype/241078/browser), etc…). Apply those resources, we can easily find out some valuable candidate variation sites to treat the patient's disease by some special target. Here we construct a comprehensive workflow, by using the released tools, to annotate the NGS data (now support the [VCF](https://www.internationalgenome.org/wiki/Analysis/vcf4.0/) format) and filter the variant data (which can be set up by the user), to get the most related variation information for clinical diagnosis.
## This workflow is constructed by :
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
 * etc...
## Pipeline 
  ### WES & WGS data annotation and filter
 
  <img width="1153" alt="截屏2022-09-27 15 22 08" src="https://user-images.githubusercontent.com/53446971/192460466-82c43eb7-ce72-4fda-8fb1-b573772681c2.png">

#### API :
   * HPOid
   * splicing_threshold
   * Sample_name
   * MAF cutoff
   * Ref genome version
   * filter rule :
      * region rule
      * effect rule
      * MAF database

### MT-DNA pipeline:
  #### Single MT-DNA annotation by hmtnote:
  <img width="865" alt="截屏2022-08-24 14 19 30" src="https://user-images.githubusercontent.com/53446971/186345103-509c42c9-c458-4166-9129-c148d7c5e06b.png">
  
  The hmtnote is a python module, so I've already bulid a docker image to use this module to annotate MT-DNA's data.
  ##### API:
  * VCF : raw vcf 
  * Output_name: a prefix of the result
### database generate script base on：
https://github.com/WGLab/doc-ANNOVAR/issues/15
https://github.com/mobidic/update_annovar_db
