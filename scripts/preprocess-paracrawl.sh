#!/bin/bash -v

###############################################################################
### Preprocess Paracrawl Es-En Files
###############################################################################
##cd /home/kmarc/mtfinal-omnt/data
##
#################################################################################
##### Randomize Files.
##
##mkfifo onerandom tworandom
##tee onerandom tworandom < /dev/urandom > /dev/null &
##p1=$! &
##shuf --random-source=onerandom paracrawl-release1.en-es.zipporah0-dedup-clean.en \
##	> paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.en &
##p2=$! &
##shuf --random-source=tworandom paracrawl-release1.en-es.zipporah0-dedup-clean.es \
##	> paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.es &
##p3=$! &
##wait $p1 $p2 $p3
##
##
#################################################################################
##### Split into Training, Dev, Test, and Extra data.
#####
##
### Training Data
##head -15000000 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.en \
##	> paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.en &
##p5=$! &
##head -15000000 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.es \
##	> paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.es & 
##p6=$! &
##wait $p5 $p6
##
### Dev Data
##tail -n +15000001 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.en | \
##	head -3000 > paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.en &
##p8=$! &
##tail -n +15000001 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.es | \
##	head -3000 > paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.es & 
##p9=$! &
##wait $p8 $p9
##
### Test Data
##tail -n +15003001 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.en | \
##	head -3000 > paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.test.en &
##p11=$! &
##tail -n +15003001 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.es | \
##	head -3000 > paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.test.es &
##p12=$! &
##wait $p11 $p12
##
### Extra Data
##tail -n +15006001 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.en \
##	> paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.extra.en &
##p14=$! &
##tail -n +15006001 paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.es \
##	> paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.extra.es &
##p15=$! &
##wait $p14 $p15 
##
### Move new files into the correct directories
##mv paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.en dev/ 
##mv paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.es dev/
##mv paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.test.en test/
##mv paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.test.es test/
##mv paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.extra.en extra/
##mv paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.extra.es extra/ &
##p16=$! &
##wait $p16



###############################################################################
### Preprocess Paracrawl with Moses Scripts & BPE 
###
cd /home/kmarc/mtfinal-omnt
# Amended from the Marian v.1.5 examples: https://github.com/marian-nmt/marian
# marian_v1.5/examples/wmt2017-transformer/scripts/preprocess-data.sh 

# suffix of source language files
SRC=es

# suffix of target language files
TRG=en

# path to moses decoder: https://github.com/moses-smt/mosesdecoder
export mosesdecoder=/home/pkoehn/moses

# path to subword segmentation scripts: https://github.com/rsennrich/subword-nmt
export subword_nmt=/home/pkoehn/statmt/project/subword-nmt

paracrawl=paracrawl-release1.en-es.zipporah0-dedup-clean.shuf

### tokenize
##for prefix in $paracrawl.train dev/$paracrawl.dev test/$paracrawl.test 
##do
##    cat data/$prefix.$SRC \
##        | $mosesdecoder/scripts/tokenizer/normalize-punctuation.perl -l $SRC \
##        | $mosesdecoder/scripts/tokenizer/tokenizer.perl -a -l $SRC > data/$prefix.tok.$SRC
##
##    test -f data/$prefix.$TRG || continue
##
##    cat data/$prefix.$TRG \
##        | $mosesdecoder/scripts/tokenizer/normalize-punctuation.perl -l $TRG \
##        | $mosesdecoder/scripts/tokenizer/tokenizer.perl -a -l $TRG > data/$prefix.tok.$TRG
##done
##
### clean empty and long sentences, and sentences with high source-target ratio (training corpus only)
##mv data/$paracrawl.train.$SRC data/$paracrawl.train.uncleaned.$SRC
##mv data/$paracrawl.train.$TRG data/$paracrawl.train.uncleaned.$TRG
##$mosesdecoder/scripts/training/clean-corpus-n.perl data/$paracrawl.train.uncleaned $SRC $TRG data/$paracrawl.train 1 100
##
### apply truecaser (cleaned training corpus). Use truecaser trained on corpus.tok.{en/es} previously
##for prefix in $paracrawl.train dev/$paracrawl.dev test/$paracrawl.test 
##do
##    $mosesdecoder/scripts/recaser/truecase.perl -model model/tc.$SRC < data/$prefix.tok.$SRC > data/$prefix.tc.$SRC
##    test -f data/$prefix.tok.$TRG || continue
##    $mosesdecoder/scripts/recaser/truecase.perl -model model/tc.$TRG < data/$prefix.tok.$TRG > data/$prefix.tc.$TRG
##done

# apply BPE (previously trained on corpus.tc)
for prefix in $paracrawl.train dev/$paracrawl.dev test/$paracrawl.test 
do
    $subword_nmt/apply_bpe.py -c model/$SRC$TRG.bpe < data/$prefix.tc.$SRC > data/$prefix.bpe.$SRC
    test -f data/$prefix.tc.$TRG || continue
    $subword_nmt/apply_bpe.py -c model/$SRC$TRG.bpe < data/$prefix.tc.$TRG > data/$prefix.bpe.$TRG
done


###############################################################################
## Filter BPE-ed file for max sentence length = 100
##

# Length: 100
# Clean BPE-ed train and dev files
for prefix in $paracrawl.train dev/$paracrawl.dev
do 
	$mosesdecoder/scripts/training/clean-corpus-n.perl data/$prefix.bpe $SRC $TRG data/$prefix.bpe.100 1 100 
done
