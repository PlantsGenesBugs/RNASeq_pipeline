#!/bin/bash
#SBATCH --job-name split_rnaseq_paspalum
#SBATCH --time 100:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --array 1-2

# set environment and load required packages
set -e
module purge; module load bluebear
module load bear-apps/2021b
module load seqtk/1.3-GCC-11.2.0

# define working directory and run script in that dir
WORKINGDIR=".../paspalum_inflorescence_rnaseq_data/"
cd "$WORKINGDIR"

# list files that will be used; this will tie in with the array spec in the slurm script
RNASEQ_FILES=("SRR7347364.fastq.gz" "SRR7347369.fastq.gz")

# cycle through slurm array by subtracting 1 from array ID; bash uses zero indexing while slurm array starts at 1
FILE=${RNASEQ_FILES[$SLURM_ARRAY_TASK_ID-1]}

BASENAME=$(basename "$FILE" .fastq.gz)

seqtk seq -1 "$FILE" > "${BASENAME}_1.fastq"
seqtk seq -2 "$FILE" > "${BASENAME}_2.fastq"
