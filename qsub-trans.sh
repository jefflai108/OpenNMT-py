#!/bin/bash -v

model=$1
testset_abbr=$2
outfile=$3

cd /home/kmarc/mtfinal-omnt

qsub -l 'hostname=c*|c09,gpu=1,mem_free=5G,ram_free=5G' -cwd -q g.q \
   -o `pwd`/qsub/trans.`date +"%Y-%m-%d.%H-%M-%S"`.out \
   -e `pwd`/qsub/trans.`date +"%Y-%m-%d.%H-%M-%S"`.err \
  ./translate.sh $model $testset_abbr $outfile
