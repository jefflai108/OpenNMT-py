#!/bin/bash -v

# Translate a test set according to a specified model, and score it with BLEU.

. ./local-settings.sh

echo You are running on machine: `hostname`
echo Here is what free-gpu returned: `free-gpu` 
echo '$CUDA_VISIBLE_DEVICES: ' $CUDA_VISIBLE_DEVICES
echo Here is the output of nvidia-smi: `nvidia-smi`

###############################################################################

stage=$1

BOTH=newstest2013_os2018
OS=os2018
NEWS=newstest2013

if [ $stage -eq 0 ]; then
	# Model: Full Corpus. Test Set: NewsTest2013 + OS.
	model=checkpoint/0/0_step_170000.pt
	testset_abbr='both'
	outfile=checkpoint/0/$BOTH
fi

if [ $stage -eq 1 ]; then
	# Model: Full Corpus. Test Set: NewTest2013.
	model=checkpoint/0/0_step_170000.pt
	testset_abbr='news'
	outfile=checkpoint/0/$NEWS
fi

if [ $stage -eq 2 ]; then
	# Model: Full Corpus. Test Set: OS.
	model=checkpoint/0/0_step_170000.pt
	testset_abbr='os'
	outfile=checkpoint/0/$OS
fi

if [ $stage -eq 3 ]; then
	# Model: Europarl. Test Set: NewsTest2013 + OS.
	model=checkpoint/1/1_step_150000.pt
	testset_abbr='both'
	outfile=checkpoint/1/$BOTH
fi

if [ $stage -eq 4 ]; then
	# Model: Europarl. Test Set: NewsTest2013.
	model=checkpoint/1/1_step_150000.pt
	testset_abbr='news'
	outfile=checkpoint/1/$NEWS
fi

if [ $stage -eq 5 ]; then
	# Model: Europarl. Test Set: OS.
	model=checkpoint/1/1_step_150000.pt
	testset_abbr='os'
	outfile=checkpoint/1/$OS
fi

if [ $stage -eq 6 ]; then
	# Model: OS. Test Set: NewsTest2013 + OS.
	model=checkpoint/2/2_step_130000.pt
	testset_abbr='both'
	outfile=checkpoint/2/$BOTH
fi

if [ $stage -eq 7 ]; then
	# Model: OS. Test Set: NewsTest2013.
	model=checkpoint/2/2_step_130000.pt
	testset_abbr='news'
	outfile=checkpoint/2/$NEWS
fi

if [ $stage -eq 8 ]; then
	# Model: OS. Test Set: OS.
	model=checkpoint/2/2_step_130000.pt
	testset_abbr='os'
	outfile=checkpoint/2/$OS
fi

case "$testset_abbr" in
   "both") 
	   testset=data/test/newstest2013_OS2018.test.bpe.es
	   testgold=data/test/newstest2013_OS2018.test.en
   ;;
   "os") 
	   testset=data/test/OpenSubtitles2018.en-es.shuf.test.bpe.es 
	   testgold=data/test/OpenSubtitles2018.en-es.shuf.test.en
   ;;
   "news") 
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


###############################################################################

# Adapted from Marian v1.5 wmt2017-transfomer example.
# Remove BPE, Detruecase, and Detokenize the translation.
echo 'Moses decoder is: ' $mosesdecoder
cat $outfile.out \
    | sed 's/\@\@ //g' \
    | $mosesdecoder/scripts/recaser/detruecase.perl 2>/dev/null \
    | $mosesdecoder/scripts/tokenizer/detokenizer.perl -l en > $outfile.out.clean

# Get BLEU score.
$mosesdecoder/scripts/generic/multi-bleu-detok.perl $testgold < $outfile.out.clean > $outfile.out.bleu

# Get sentence-by-sentence and overall readability
python get_readability.py --scorer 0 --summary 1 --input $outfile.out.clean --output $outfile.out.fre
python get_readability.py --scorer 1 --summary 1 --input $outfile.out.clean --output $outfile.out.fkg 
python get_readability.py --scorer 2 --summary 1 --input $outfile.out.clean --output $outfile.out.dc 

