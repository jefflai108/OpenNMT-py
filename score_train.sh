#!/bin/bash -v

# Input: bpe-ed corpus
# Output: Estimated readability of the corpus
# Evaluation is performed on a sample from the corpus (Default sample size: 500,000) 

. ./local-settings.sh

echo You are running on machine: `hostname`
echo Here is what free-gpu returned: `free-gpu` 
echo '$CUDA_VISIBLE_DEVICES: ' $CUDA_VISIBLE_DEVICES
echo Here is the output of nvidia-smi: `nvidia-smi`

trainfile=$1
sample_size=500000

# Adapted from Marian v1.5 wmt2017-transfomer example.
# Remove BPE, Detruecase, and Detokenize the translation.
echo 'Moses decoder is: ' $mosesdecoder
cat $trainfile \
    | sed 's/\@\@ //g' \
    | $mosesdecoder/scripts/recaser/detruecase.perl 2>/dev/null \
    | $mosesdecoder/scripts/tokenizer/detokenizer.perl -l en > $trainfile.clean


# Sample from the training set
shuf -n $sample_size $trainfile.clean > $trainfile.clean.sample 


# Get sentence-by-sentence and overall readability of the sample
python get_readability.py --scorer 0 --summary 1 --input $trainfile.clean.sample --output $trainfile.fre
python get_readability.py --scorer 1 --summary 1 --input $trainfile.clean.sample --output $trainfile.fkg 
python get_readability.py --scorer 2 --summary 1 --input $trainfile.clean.sample --output $trainfile.dc 

