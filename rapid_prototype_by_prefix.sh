#!/bin/bash
for read1 in *_1.fastq.gz
do
  # making more variables here
  prefix=$(basename ${read1} _1.fastq.gz)

  # if read1 is SRR2589044_1.fastq.gz
  # then prefix will be SRR2589044
  # trim command here
  # trimmomatic PE SRR2589044_1.fastq.gz SRR2589044_2.fastq.gz \
  #              SRR2589044_1.trim.fastq.gz SRR2589044_1un.trim.fastq.gz \
  #              SRR2589044_2.trim.fastq.gz SRR2589044_2un.trim.fastq.gz \
  #              SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15
  trimmomatic PE ${prefix}_1.fastq.gz ${prefix}_2.fastq.gz \
                ${prefix}_1.trim.fastq.gz ${prefix}_1un.trim.fastq.gz \
                ${prefix}_2.trim.fastq.gz ${prefix}_2un.trim.fastq.gz \
                SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15


  # bwa command here
  # bwa mem -t 2 \
  # ../ref_genome/ecoli_rel606.fasta \
  # SRR2589044_1.trim.fastq.gz SRR2589044_2.trim.fastq.gz > SRR2589044.sam
  bwa mem -t 2 \
  ../ref_genome/ecoli_rel606.fasta \
  ${prefix}_1.trim.fastq.gz ${prefix}_2.trim.fastq.gz > ${prefix}.sam
done
