#!/bin/bash
#SBATCH --job-name trim_qc_paspalum
#SBATCH --time 100:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --array 1-3



# Set up environment and load required packages
set -e
module purge; module load bluebear

module load Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4
module load MultiQC


# Set source folder and output folder
READSFOLDER=".../paspalum_inflorescence_rnaseq_data"
OUTPUTFOLDER=".../paspalum_inflorescence_rnaseq_trimmed"

### Run Trimgalore using QC data as guide

## define samples
RNASEQ_FILES=(
SRR7347364
SRR7347369
SRR7347375
)

# select sample based on array task id
SAMPLE=${RNASEQ_FILES[$SLURM_ARRAY_TASK_ID-1]}
 

trim_galore \
	-q 26 \
    --clip_R1 15 \
    --clip_R2 15 \
    --three_prime_clip_R1 3 \
    --three_prime_clip_R2 3 \
	--phred33 \
	--fastqc \
	--illumina \
	--length 20 \
	-o "${OUTPUTFOLDER}" \
	--paired "${READSFOLDER}/${SAMPLE}_1.fastq" "${READSFOLDER}/${SAMPLE}_2.fastq"

 multiqc ${OUTPUTFOLDER} -o ${OUTPUTFOLDER}

