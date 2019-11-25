#!/bin/bash
#SBATCH -J galore_$1                  # Job name
#SBATCH -n 4                          # Use 1 core for the job
#SBATCH -t 08:00:00                   # Runtime in HH:MM:SS
#SBATCH -A cpu-s1-MYALLOC             # allocation to bill to
#SBATCH -p cpu-s1-MYALLOC             # Partition to submit to
#SBATCH --mem=12000                   # Memory per node in MB
#SBATCH -o galore_%A.o                # File to which STDOUT will be written
#SBATCH -e galore_%A.e                # File to which STDERR will be written
#SBATCH --mail-type=ALL               # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=rltillett@unr.edu # Email to which notifications will be sent

# Usage: sbatch [script_worker] left.fq.gz right.fq.gz
# Trim pairs of files with Trim Galore!

# -1 is left read fed to this by the outer script or manually
# -2 is right read fed to this by the outer script or manually


trim_galore --paired \
--retain_unpaired --phred33 \
--cores 4 \
--output_dir ../trimmed_reads \
--length 36 \
--nextseq 5 \
--stringency 1 \
-e 0.1 \
$1 $2

