#!/bin/bash
# interproscan on chunks of fasta input
# with a "smart" scheduler which polls current job-count to permit max of N jobs
# ./<this_script.sh>

## Polling job counter options here
interval="1m"
maxjobs=8

## Input dir option
indir=`pwd`

## Set up temp dirs in advance
mkdir -p $indir/chunks/chunk{000..193}/temp

for i in {000..193}
do

  outdir=$indir/ipschunks/chunk$i
  tmpdir=$outdir/temp
  infile=partsof96th_$i.fa

  interproscan.sh -d $outdir \
    -i $infile \
    -f TSV --goterms --iprlookup --pathways -t n \
    --minsize 180 \
    -T $tmpdir &>$outdir/log$i.log &

  sleep 5s

  ## POLLING JOB COUNTER FOLLOWS
  jcount=`jobs | wc -l`
  echo part $i slot $jcount

  while [ $jcount -ge $maxjobs ]
  do
    echo sleeping at $jcount jerbs
    sleep $interval
    jcount=`jobs | wc -l`
  done

done

wait

