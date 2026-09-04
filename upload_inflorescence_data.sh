#!/bin/bash
#SBATCH --job-name upload_data
#SBATCH --time 100:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1


# set environment and load required packages
set -e
module purge; module load bluebear
module load bear-apps/2023a
module load SRA-Toolkit/3.0.10-gompi-2023a

WORKINGDIR=".../paspalum_inflorescence_rnaseq_data/"
cd "$WORKINGDIR"

fasterq-dump --split-files SRR7347375
