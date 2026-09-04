#!/bin/bash
#SBATCH --job-name STAR_index_paspalum
#SBATCH --time 20:00:00
#SBATCH --nodes 1
##SBATCH --cpus-per-task=8
#SBATCH --ntasks 1
#SBATCH --mem=122G


set -e
module purge; module load bluebear
module load STAR/2.7.2b-GCC-8.3.0

DATABASE=".../paspalum_notatum_genome/P_notatum_genome_ncbi_dataset/ncbi_dataset/data/GCA_036689595.1"
INPUT_DIRECTORY=".../paspalum_inflorescence_rnaseq_trimmed"
OUTPUT_DIRECTORY=".../paspalum_inflorescence_rnaseq_STARalign"

if [ ! -d "${OUTPUT_DIRECTORY}" ]; then
	mkdir -p "${OUTPUT_DIRECTORY}"
fi

## Build Index - DO THIS ONLY ONCE
if [ ! -d "${DATABASE}/STAR_index_scaffold" ]; then
    echo "STAR index not found — making dir and generating index..."
    mkdir -p "${DATABASE}/STAR_index_scaffold"
    STAR \
        --runMode genomeGenerate \
        --runThreadN 8 \
        --genomeDir "${DATABASE}/STAR_index_scaffold" \
        --genomeFastaFiles "${DATABASE}/GCA_036689595.1_IICAR_Pnotatum_1.0_genomic.fna" \
        --sjdbGTFfile "${DATABASE}/genomic.gtf" \
        --sjdbOverhang 149
else
    echo "STAR index already exists — skipping genomeGenerate."
fi




