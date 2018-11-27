#!/bin/bash
# Adapted from Marian v1.5 wmt2017-transformer example.

mosesdecoder=/home/pkoehn/moses

cat $1 \
    | sed 's/\@\@ //g' \
    | $mosesdecoder/scripts/recaser/detruecase.perl 2>/dev/null \
    | $mosesdecoder/scripts/tokenizer/detokenizer.perl -l de 2>/dev/null \
    | $mosesdecoder/scripts/generic/multi-bleu-detok.perl data/dev/newstest2017.de \
    | sed -r 's/BLEU = ([0-9.]+),.*/\1/'
