#!/bin/bash -v

# Translate a test set according to a specified model, and score it with BLEU.

. ./local-settings.sh

echo You are running on machine: `hostname`
echo Here is what free-gpu returned: `free-gpu` 
echo '$CUDA_VISIBLE_DEVICES: ' $CUDA_VISIBLE_DEVICES
echo Here is the output of nvidia-smi: `nvidia-smi`

###############################################################################

stage=$1

# Test sets
BOTH=newstest2013_os2018
OS=os2018
NEWS=newstest2013
PARA=paracrawl

# Which decoder to use.
dec_num=0

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

if [ $stage -eq 9 ]; then
	# Mode: Double Decoder 0 (Complex). Test Set: NewsTest2013 + OS.
	model=checkpoint/3/3_step_130000.pt
	testset_abbr='both'
	outfile=checkpoint/3/$BOTH.complex
fi

if [ $stage -eq 10 ]; then
	# Model: Double Decoder 0 (Complex). Test Set: NewsTest2013.
	model=checkpoint/3/3_step_130000.pt
	testset_abbr='news'
	outfile=checkpoint/3/$NEWS.complex
fi

if [ $stage -eq 11 ]; then
	# Model: Double Decoder 0 (Complex). Test Set: OS.
	model=checkpoint/3/3_step_130000.pt
	testset_abbr='os'
	outfile=checkpoint/3/$OS.complex
fi

if [ $stage -eq 12 ]; then
	# Model: Double Decoder 1 (Simple). Test Set: NewsTest2013 + OS.
	model=checkpoint/3/3_step_130000.pt
	dec_num=1
	testset_abbr='both'
	outfile=checkpoint/3/$BOTH.simple
fi

if [ $stage -eq 13 ]; then
	# Model: Double Decoder 1 (Simple). Test Set: NewsTest2013.
	model=checkpoint/3/3_step_130000.pt
	dec_num=1
	testset_abbr='news'
	outfile=checkpoint/3/$NEWS.simple
fi

if [ $stage -eq 14 ]; then
	# Model: Double Decoder 1 (Simple). Test Set: OS.
	model=checkpoint/3/3_step_130000.pt
	dec_num=1
	testset_abbr='os'
	outfile=checkpoint/3/$OS.simple
fi

####
# Redo baseline scorings 0-5 to score with model trained on shuffled 
# corpus/Europarl data.

if [ $stage -eq 15 ]; then
	# Model: Full Corpus - Shuffled. Test Set: NewsTest2013 + OS.
	model=checkpoint/5/
	testset_abbr='both'
	outfile=checkpoint/5/$BOTH
fi

if [ $stage -eq 16 ]; then
	# Model: Full Corpus - Shuffled. Test Set: NewTest2013.
	model=checkpoint/5/
	testset_abbr='news'
	outfile=checkpoint/5/$NEWS
fi

if [ $stage -eq 17 ]; then
	# Model: Full Corpus - Shuffled. Test Set: OS.
	model=checkpoint/5/
	testset_abbr='os'
	outfile=checkpoint/5/$OS
fi

if [ $stage -eq 18 ]; then
	# Model: Europarl - Shuffled. Test Set: NewsTest2013 + OS.
	model=checkpoint/6/
	testset_abbr='both'
	outfile=checkpoint/6/$BOTH
fi

if [ $stage -eq 19 ]; then
	# Model: Europarl - Shuffled. Test Set: NewsTest2013.
	model=checkpoint/6/
	testset_abbr='news'
	outfile=checkpoint/6/$NEWS
fi

if [ $stage -eq 20 ]; then
	# Model: Europarl - Shuffled. Test Set: OS.
	model=checkpoint/6/
	testset_abbr='os'
	outfile=checkpoint/6/$OS
fi

####
# Redo scoring of double-decoder trained on Europarl & OS using shuffled
# data

if [ $stage -eq 21 ]; then
	# Mode: Double Decoder 0 (Complex) - Shuf. Test Set: NewsTest2013 + OS.
	model=checkpoint/7/
	testset_abbr='both'
	outfile=checkpoint/7/$BOTH.complex
fi

if [ $stage -eq 22 ]; then
	# Model: Double Decoder 0 (Complex) - Shuf. Test Set: NewsTest2013.
	model=checkpoint/7/
	testset_abbr='news'
	outfile=checkpoint/7/$NEWS.complex
fi

if [ $stage -eq 23 ]; then
	# Model: Double Decoder 0 (Complex) - Shuf. Test Set: OS.
	model=checkpoint/7/
	testset_abbr='os'
	outfile=checkpoint/7/$OS.complex
fi

if [ $stage -eq 24 ]; then
	# Model: Double Decoder 1 (Simple) - Shuf. Test Set: NewsTest2013 + OS.
	model=checkpoint/7/
	dec_num=1
	testset_abbr='both'
	outfile=checkpoint/7/$BOTH.simple
fi

if [ $stage -eq 25 ]; then
	# Model: Double Decoder 1 (Simple) - Shuf. Test Set: NewsTest2013.
	model=checkpoint/7/
	dec_num=1
	testset_abbr='news'
	outfile=checkpoint/7/$NEWS.simple
fi

if [ $stage -eq 26 ]; then
	# Model: Double Decoder 1 (Simple) - Shuf. Test Set: OS.
	model=checkpoint/7/
	dec_num=1
	testset_abbr='os'
	outfile=checkpoint/7/$OS.simple
fi

###
# Baselines - Paracrawl
#

if [ $stage -eq 27 ]; then
	# Model: Paracrawl. Test Set: Paracrawl
	model=checkpoint/8/
	testset_abbr='para'
	outfile=checkpoint/8/$PARA
fi

if [ $stage -eq 28 ]; then
	# Model: Paracrawl. Test Set: NewTest2013.
	model=checkpoint/8/
	testset_abbr='news'
	outfile=checkpoint/8/$NEWS
fi

###
# Double Decoder - Paracrawl
#
if [ $stage -eq 29 ]; then
	# Model: Paracrawl Double Decoder (Split?). Test Set: Paracrawl
	model=checkpoint/9/
	testset_abbr='para'
	outfile=checkpoint/9/$PARA
fi

if [ $stage -eq 30 ]; then
	# Model: Paracrawl Double Decoder (Split?). Test Set: NewTest2013.
	model=checkpoint/9/
	testset_abbr='news'
	outfile=checkpoint/9/$NEWS
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
   "para")
	   testset=data/test/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.test.bpe.es
	   testgold=data/test/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.test.en
esac


###############################################################################

# Translate Function
python translate.py \
	-model $model -dec_num $dec_num \
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

