#!/bin/bash
#SBATCH --job-name align_reads_paspalum
#SBATCH --time 20:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task=8
#SBATCH --mem=122G
#SBATCH --array 1-3


set -e
module purge; module load bluebear
module load STAR/2.7.2b-GCC-8.3.0

DATABASE=".../paspalum_notatum_genome/P_notatum_genome_ncbi_dataset/ncbi_dataset/data/GCA_036689595.1"
INPUT_DIRECTORY=".../paspalum_inflorescence_rnaseq_trimmed"
OUTPUT_DIRECTORY=".../paspalum_inflorescence_rnaseq_STARalign"

if [ ! -d "${OUTPUT_DIRECTORY}" ]; then
	mkdir -p "${OUTPUT_DIRECTORY}"
fi

# define samples
RNASEQ_FILES=(
SRR7347364
SRR7347369
SRR7347375
)

# select sample based on array task id
SAMPLE=${RNASEQ_FILES[$SLURM_ARRAY_TASK_ID-1]}

#### Run STAR to align
STAR \
--genomeDir "${DATABASE}/STAR_index_scaffold" \
--readFilesIn "${INPUT_DIRECTORY}/${SAMPLE}_1_val_1.fq" "${INPUT_DIRECTORY}/${SAMPLE}_2_val_2.fq" \
--outFileNamePrefix "${OUTPUT_DIRECTORY}/${SAMPLE}_" \
--runThreadN 8  \
--outSAMunmapped Within \
--alignIntronMax 10000 \
--outSAMtype BAM SortedByCoordinate \
--quantMode TranscriptomeSAM



