#!/bin/bash
# Starting with with read1 is SRR2589044_1.fastq.gz
# trim command here
trimmomatic PE SRR2589044_1.fastq.gz SRR2589044_2.fastq.gz \
             SRR2589044_1.trim.fastq.gz SRR2589044_1un.trim.fastq.gz \
             SRR2589044_2.trim.fastq.gz SRR2589044_2un.trim.fastq.gz \
             SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15
# bwa command here
bwa mem -t 2 \
/ref_genome/ecoli_rel606.fasta \
SRR2589044_1.trim.fastq.gz SRR2589044_2.trim.fastq.gz > SRR2589044.sam
