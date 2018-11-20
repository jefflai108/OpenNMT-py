#!/bin/bash -v

# Translate a test set according to a specified model, and score it with BLEU.

. ./local-settings.sh

echo You are running on machine: `hostname`
echo Here is what free-gpu returned: `free-gpu` 
echo '$CUDA_VISIBLE_DEVICES: ' $CUDA_VISIBLE_DEVICES
echo Here is the output of nvidia-smi: `nvidia-smi`

###############################################################################

model=$1
testset_abbr=$2
outfile=$3

case "$testset_abbr" in
   "both") 
	   testset=data/test/newstest2013_OS2018.test.bpe.es
	   testgold=data/test/newstest2013_OS2018.test.en
   ;;
   "os") 
	   testset=data/test/OpenSubtitles2018.en-es.shuf.test.bpe.es 
	   testgold=data/test/OpenSubtitles2018.en-es.shuf.test.en
   ;;
   "euro") 
	   testset=data/test/newstest2013-src.bpe.es
	   testgold=data/test/newstest2013-src.en
   ;;
esac



###############################################################################

# Translate Function
python translate.py \
	-model $model \
	-src $testset -output $outfile.out \
	-verbose -gpu 0

sh scripts/validate.en.sh $outfile.out $testgold > $outfile.bleu 


