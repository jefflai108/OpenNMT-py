#!/bin/bash -v
# Amended from the Marian v.1.5 examples: https://github.com/marian-nmt/marian
# marian_v1.5/examples/wmt2017-transformer/scripts/preprocess-data.sh 

# suffix of source language files
SRC=es

# suffix of target language files
TRG=en

# number of merge operations
bpe_operations=32000

# path to moses decoder: https://github.com/moses-smt/mosesdecoder
export mosesdecoder=/home/pkoehn/moses

# path to subword segmentation scripts: https://github.com/rsennrich/subword-nmt
export subword_nmt=/home/pkoehn/statmt/project/subword-nmt

# tokenize
for prefix in corpus europarl-v7.es-en OpenSubtitles2018.en-es.shuf.train dev/newstest2012 dev/OpenSubtitles2018.en-es.shuf.dev test/newstest2013-src test/OpenSubtitles2018.en-es.shuf.test  
do
    cat data/$prefix.$SRC \
        | $mosesdecoder/scripts/tokenizer/normalize-punctuation.perl -l $SRC \
        | $mosesdecoder/scripts/tokenizer/tokenizer.perl -a -l $SRC > data/$prefix.tok.$SRC

    test -f data/$prefix.$TRG || continue

    cat data/$prefix.$TRG \
        | $mosesdecoder/scripts/tokenizer/normalize-punctuation.perl -l $TRG \
        | $mosesdecoder/scripts/tokenizer/tokenizer.perl -a -l $TRG > data/$prefix.tok.$TRG
done

# clean empty and long sentences, and sentences with high source-target ratio (training corpus only)
mv data/corpus.tok.$SRC data/corpus.tok.uncleaned.$SRC
mv data/corpus.tok.$TRG data/corpus.tok.uncleaned.$TRG
mv data/europarl-v7.es-en.tok.$SRC data/europarl-v7.es-en.tok.uncleaned.$SRC
mv data/europarl-v7.es-en.tok.$TRG data/europarl-v7.es-en.tok.uncleaned.$TRG
mv data/OpenSubtitles2018.en-es.shuf.train.tok.$SRC data/OpenSubtitles2018.en-es.shuf.train.tok.uncleaned.$SRC
mv data/OpenSubtitles2018.en-es.shuf.train.tok.$TRG data/OpenSubtitles2018.en-es.shuf.train.tok.uncleaned.$TRG
$mosesdecoder/scripts/training/clean-corpus-n.perl data/corpus.tok.uncleaned $SRC $TRG data/corpus.tok 1 100
$mosesdecoder/scripts/training/clean-corpus-n.perl data/europarl-v7.es-en.tok.uncleaned $SRC $TRG data/europarl-v7.es-en.tok 1 100
$mosesdecoder/scripts/training/clean-corpus-n.perl data/OpenSubtitles2018.en-es.shuf.train.tok.uncleaned $SRC $TRG data/OpenSubtitles2018.en-es.shuf.train.tok 1 100

# train truecaser
$mosesdecoder/scripts/recaser/train-truecaser.perl -corpus data/corpus.tok.$SRC -model model/tc.$SRC
$mosesdecoder/scripts/recaser/train-truecaser.perl -corpus data/corpus.tok.$TRG -model model/tc.$TRG

# apply truecaser (cleaned training corpus)
for prefix in corpus europarl-v7.es-en OpenSubtitles2018.en-es.shuf.train dev/newstest2012 dev/OpenSubtitles2018.en-es.shuf.dev test/newstest2013-src test/OpenSubtitles2018.en-es.shuf.test  
do
    $mosesdecoder/scripts/recaser/truecase.perl -model model/tc.$SRC < data/$prefix.tok.$SRC > data/$prefix.tc.$SRC
    test -f data/$prefix.tok.$TRG || continue
    $mosesdecoder/scripts/recaser/truecase.perl -model model/tc.$TRG < data/$prefix.tok.$TRG > data/$prefix.tc.$TRG
done

# train BPE
cat data/corpus.tc.$SRC data/corpus.tc.$TRG | $subword_nmt/learn_bpe.py -s $bpe_operations > model/$SRC$TRG.bpe

# apply BPE
for prefix in corpus europarl-v7.es-en OpenSubtitles2018.en-es.shuf.train dev/newstest2012 dev/OpenSubtitles2018.en-es.shuf.dev test/newstest2013-src test/OpenSubtitles2018.en-es.shuf.test  
do
    $subword_nmt/apply_bpe.py -c model/$SRC$TRG.bpe < data/$prefix.tc.$SRC > data/$prefix.bpe.$SRC
    test -f data/$prefix.tc.$TRG || continue
    $subword_nmt/apply_bpe.py -c model/$SRC$TRG.bpe < data/$prefix.tc.$TRG > data/$prefix.bpe.$TRG
done
