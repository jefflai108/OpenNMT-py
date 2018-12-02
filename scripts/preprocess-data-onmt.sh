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
## Double Decoder Preprocessing
##

##python preprocess_dd.py \
##	-train_src $datadir/corpus.bpe.100.shuf.dc.simple50.$SRC \
##        -train_tgt $datadir/corpus.bpe.100.shuf.dc.simple50.$TRG \
##	-train_src1 $datadir/corpus.bpe.100.shuf.dc.complex50.$SRC \
##        -train_tgt1 $datadir/corpus.bpe.100.shuf.dc.complex50.$TRG \
##	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
##        -valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
##	-valid_src1 $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
##        -valid_tgt1 $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
##	-save_data $datadir/corpus_shuf_dd_50.100

python preprocess_dd.py \
	-train_src $datadir/corpus.bpe.100.shuf.dc.simple40.$SRC \
        -train_tgt $datadir/corpus.bpe.100.shuf.dc.simple40.$TRG \
	-train_src1 $datadir/corpus.bpe.100.shuf.dc.complex40.$SRC \
        -train_tgt1 $datadir/corpus.bpe.100.shuf.dc.complex40.$TRG \
	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
        -valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
	-valid_src1 $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
        -valid_tgt1 $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
	-save_data $datadir/corpus_shuf_dd_40.100

python preprocess_dd.py \
	-train_src $datadir/corpus.bpe.100.shuf.dc.simple30.$SRC \
        -train_tgt $datadir/corpus.bpe.100.shuf.dc.simple30.$TRG \
	-train_src1 $datadir/corpus.bpe.100.shuf.dc.complex30.$SRC \
        -train_tgt1 $datadir/corpus.bpe.100.shuf.dc.complex30.$TRG \
	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
        -valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
	-valid_src1 $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
        -valid_tgt1 $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
	-save_data $datadir/corpus_shuf_dd_30.100

###############################################################################
##
## Paracrawl Preprocessing
##

# Baseline
##python preprocess.py \
##	-train_src $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.$SRC \
##	-train_tgt $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.$TRG \
##	-valid_src $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
##	-valid_tgt $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
##	-save_data $datadir/paracrawl.100

# Double Decoders
# 50-50 Split
##python preprocess_dd.py \
##	-train_src $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.simple50.$SRC \
##        -train_tgt $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.simple50.$TRG \
##	-train_src1 $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.complex50.$SRC \
##        -train_tgt1 $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.complex50.$TRG \
##	-valid_src $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
##        -valid_tgt $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
##	-valid_src1 $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
##        -valid_tgt1 $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
##	-save_data $datadir/paracrawl_dd_50.100
##
### 40-60 Split
##python preprocess_dd.py \
##	-train_src $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.simple40.$SRC \
##        -train_tgt $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.simple40.$TRG \
##	-train_src1 $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.complex40.$SRC \
##        -train_tgt1 $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.complex40.$TRG \
##	-valid_src $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
##        -valid_tgt $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
##	-valid_src1 $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
##        -valid_tgt1 $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
##	-save_data $datadir/paracrawl_dd_40.100
##
### 30-70 Split
##python preprocess_dd.py \
##	-train_src $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.simple30.$SRC \
##        -train_tgt $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.simple30.$TRG \
##	-train_src1 $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.complex30.$SRC \
##        -train_tgt1 $datadir/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.train.bpe.100.complex30.$TRG \
##	-valid_src $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
##        -valid_tgt $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
##	-valid_src1 $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$SRC \
##        -valid_tgt1 $datadir/dev/paracrawl-release1.en-es.zipporah0-dedup-clean.shuf.dev.bpe.100.$TRG \
##	-save_data $datadir/paracrawl_dd_30.100
