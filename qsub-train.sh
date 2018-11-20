#!/bin/bash -v

stage=$1

cd /home/kmarc/mtfinal-omnt

qsub -l 'hostname=c*|c09,gpu=1,mem_free=5G,ram_free=5G' -cwd -q g.q \
   -o `pwd`/qsub/train.$stage.`date +"%Y-%m-%d.%H-%M-%S"`.out \
   -e `pwd`/qsub/train.$stage.`date +"%Y-%m-%d.%H-%M-%S"`.err \
  ./train.sh $stage
