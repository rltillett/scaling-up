#!/bin/bash

## Usage. Kick off a bunch of sbatch jobs to trim pairs of files in a folder
## using Trim Galore (see worker script for TG options).
## This script just reads the current dir, and feeds pairs to the worker via sbatch.

#### Setup

scriptdir=`dirname $0`          # gets the folder where parent and worker scripts both live


#### Main loop


mkdir -p ../trimmed_reads

for read1 in *_R1_001.cor.fq.gz; do

  read2=${read1/_R1_001.cor.fq.gz/_R2_001.cor.fq.gz}  
  sbatch $scriptdir/trimgalore_worker.sh $read1 $read2 &
  sleep 5
done




