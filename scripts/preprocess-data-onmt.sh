#!/usr/bin/env python

export datadir=/export/c06/kmarc/mt-final/data
SRC=es
TRG=en

# Full corpus training (Europarl + OpenSubtitles)
##python preprocess.py \
##	-train_src $datadir/corpus.bpe.100.$SRC \
##	-train_tgt $datadir/corpus.bpe.100.$TRG \
##	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
##	-valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
##	-save_data $datadir/corpus.100
##
##
### Europarl
##python preprocess.py \
##	-train_src $datadir/europarl-v7.es-en.bpe.100.$SRC \
##	-train_tgt $datadir/europarl-v7.es-en.bpe.100.$TRG \
##	-valid_src $datadir/dev/newstest2012.bpe.100.$SRC \
##	-valid_tgt $datadir/dev/newstest2012.bpe.100.$TRG \
##	-save_data $datadir/europarl.100
##
##
### Open Subtitles
##python preprocess.py \
##	-train_src $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$SRC \
##	-train_tgt $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$TRG \
##	-valid_src $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$SRC \
##	-valid_tgt $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$TRG \
##	-save_data $datadir/OpenSubtitles2018.100
##

###############################################################################
##
## Shuffled Dataset Preprocessing
##

### Full training corpus shuffled (Europarl + OpenSubtitles)
##python preprocess.py \
##	-train_src $datadir/corpus.bpe.100.shuf.$SRC \
##	-train_tgt $datadir/corpus.bpe.100.shuf.$TRG \
##	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
##	-valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
##	-save_data $datadir/corpus.100.shuf
##
### Europarl (shuffled)
##python preprocess.py \
##	-train_src $datadir/europarl-v7.es-en.bpe.100.shuf.$SRC \
##	-train_tgt $datadir/europarl-v7.es-en.bpe.100.shuf.$TRG \
##	-valid_src $datadir/dev/newstest2012.bpe.100.$SRC \
##	-valid_tgt $datadir/dev/newstest2012.bpe.100.$TRG \
##	-save_data $datadir/europarl.100.shuf

###############################################################################
##
## Double Decoder Preprocessing
##

### Separate Europarl (non-shuf) & OpenSubtitles Decoders
##python preprocess_dd.py \
##	-train_src $datadir/europarl-v7.es-en.bpe.100.$SRC \
##        -train_tgt $datadir/europarl-v7.es-en.bpe.100.$TRG \
##	-train_src1 $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$SRC \
##        -train_tgt1 $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$TRG \
##	-valid_src $datadir/dev/newstest2012.bpe.100.$SRC \
##        -valid_tgt $datadir/dev/newstest2012.bpe.100.$TRG \
##	-valid_src1 $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$SRC \
##        -valid_tgt1 $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$TRG \
##	-save_data $datadir/europarl_OS_dd.100

##python preprocess_dd.py \
##	-train_src $datadir/europarl-v7.es-en.bpe.100.shuf.$SRC \
##        -train_tgt $datadir/europarl-v7.es-en.bpe.100.shuf.$TRG \
##	-train_src1 $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$SRC \
##        -train_tgt1 $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$TRG \
##	-valid_src $datadir/dev/newstest2012.bpe.100.$SRC \
##        -valid_tgt $datadir/dev/newstest2012.bpe.100.$TRG \
##	-valid_src1 $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$SRC \
##        -valid_tgt1 $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$TRG \
##	-save_data $datadir/europarl_OS_dd.100.shuf

###############################################################################
##
## Paracrawl Preprocessing
##

python preprocess.py \
	-train_src $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.$SRC \
	-train_tgt $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.$TRG \
	-valid_src $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
	-valid_tgt $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
	-save_data $datadir/paracrawl.100

