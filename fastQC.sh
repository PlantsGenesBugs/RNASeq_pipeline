#!/bin/bash
#SBATCH --job-name fastQC_paspalum
#SBATCH --time 100:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --array 1-3


# set environment and load required packages
set -e
module purge; module load bluebear
module load FastQC/0.11.9

# define working directory and run script in that dir
WORKINGDIR=".../paspalum_inflorescence_rnaseq_data/"
cd "$WORKINGDIR"

# define samples
RNASEQ_FILES=(
SRR7347364
SRR7347369
SRR7347375
)

# select sample based on array task id
SAMPLE=${RNASEQ_FILES[$SLURM_ARRAY_TASK_ID-1]}

# run FastQC
fastqc ${SAMPLE}_1.fastq ${SAMPLE}_2.fastq
