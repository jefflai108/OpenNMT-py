#!/bin/bash
# Adapted from Marian v1.5 wmt2017-transformer example.
mosesdecoder=/home/pkoehn/moses

cat $1 \
    | sed 's/\@\@ //g' \
    | $mosesdecoder/scripts/recaser/detruecase.perl 2>/dev/null \
    | $mosesdecoder/scripts/tokenizer/detokenizer.perl -l en 2>/dev/null \
<<<<<<< HEAD:validate.en.sh
    | $mosesdecoder/scripts/generic/multi-bleu-detok.perl kelly-data/test/newstest2013_OS2018.test.en \
=======
    | $mosesdecoder/scripts/generic/multi-bleu-detok.perl $2 \
>>>>>>> 83d5b3c1e8440f38695801dcd91b8bdc5086a11e:scripts/validate.en.sh
    | sed -r 's/BLEU = ([0-9.]+),.*/\1/'
