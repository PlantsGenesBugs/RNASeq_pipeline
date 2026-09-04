#!/bin/bash
#SBATCH --job-name paspalum_blastn
#SBATCH --time 1:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task=8

set -e
module purge; module load bluebear
module load bear-apps/2024a/live
module load BLAST+/2.16.0-gompi-2024a

# Define paths
DATABASE=".../paspalum_notatum_genome/P_notatum_genome_ncbi_dataset/ncbi_dataset/data/GCA_036689595.1"
SEARCHDB=".../paspalum_notatum_gene_hits"
NUCS="${DATABASE}/GCA_036689595.1_IICAR_Pnotatum_1.0_genomic.fna"

# Check whether BLAST database already exists (by looking for index file - one of three created when makeblastdb runs)
# if not, create DB
if [ ! -f "${NUCS}.nin" ]; then
    echo "BLAST database not found. Creating..."
    makeblastdb -in "${NUCS}" -dbtype nucl
else
    echo "BLAST database already exists. Skipping makeblastdb."
fi

cd $SEARCHDB

# Define variable QUERY as the first positional argument; therefore to run script: sbatch script.sh epsps.faa means that QUERY="epsps.faa"
QUERY="$1"

# Check that file exists; if not, exit script
if [ ! -f "$QUERY" ]; then
    echo "Error: Query file '$QUERY' not found."
    exit 1
fi

### Run BLAST ###
blastn -query "${QUERY}" \
       -db "${NUCS}" \
       -evalue 1e-20 \
       -outfmt 6 \
       -max_target_seqs 5 \
       -num_threads ${SLURM_CPUS_PER_TASK} > "${SEARCHDB}/$(basename ${QUERY%.*})_hits.tsv"


