This repository contains a version of the RNA-seq pipeline as developed during my MSc (Bioinformatics) at the University of Birmingham, under the supervision of Dr. Lindsey Compton. Here, it is applied to an external database (an RNASeq data set relating to grass native to the Brazilian Pampa). The aim was to identify genes that are differentially expressed in a native grass compared to my species of interest, *Eragrostis plana*, which is an invasive species.

### First, get data:
Download RNAseq data from NCBI Sequence Read Archive using SRA Toolkit. Packages: SRA_Toolkit. File: upload_inflorescence_data.sh.
Split paired-end read file into separate forward and reverse read files: Packages: seqtk. File: split_read_file.sh.

## The order in which the pipeline runs is:  

1. Preprocessing: assess quality of reads, trim adaptors/low quality bases, filter out short/low quality reads. Packages: FastQC, Trimgalore. Files: fastQC.sh, trim.sh
2. Alignment to genome: create .gtf file, align RNAseq reads to genome, create .bai file, visualise in IGV (if required!). Packages: STAR. Files: STAR_index_creator.sh, STAR_align.sh.
3. Read counts: count number of reads aligned to each gene. Package: HTSeq. File: HTSeq_quantify_paspalum.sh.
4. Expression analysis: normalise and standardise expression; perform differential gene expression analysis. Package: edgeR (note: I have also used GFOLD to analyse this type of data in the instance where no biological replicates were available). Files: edgeR_analysis_paspalum.Rmd

### Other analyses performed:  
1. The original pipeline includes steps to do gene set enrichment analysis using clusterProfiler and enrichplot.
2. Looking for genes that are essential for competitive advantage in weed (E. plana) that competes with native grass (P. notatum). Packages: BLAST+. File: doblastn.sh.
3. 
