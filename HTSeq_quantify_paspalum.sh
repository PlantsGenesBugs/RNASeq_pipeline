#!/bin/bash
#SBATCH --job-name paspalum_count
#SBATCH --time 20:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --mem 122G
#SBATCH --array 1-3

set -e
module purge; module load bluebear
module load bear-apps/2021b
module load HTSeq/0.11.3-foss-2021b

INPUT_DIRECTORY=".../paspalum_inflorescence_rnaseq_STARalign"
OUTPUT_DIRECTORY=".../paspalum_inflorescence_htseq_read_counts"
DATABASE=".../paspalum_notatum_genome/P_notatum_genome_ncbi_dataset/ncbi_dataset/data/GCA_036689595.1"

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

htseq-count \
	-f bam \
	--stranded=no \
	--mode union \
	--nonunique none \
	"${INPUT_DIRECTORY}/${SAMPLE}_Aligned.sortedByCoord.out.bam" \
	"${DATABASE}/genomic.gtf" > "${OUTPUT_DIRECTORY}/${SAMPLE}_count.txt"
