#!/bin/bash

SRC=es
TRG=en
datadir=/export/c06/kmarc/mt-final/data

# Full corpus training (Europarl + OpenSubtitles)
python preprocess.py \
	-train_src $datadir/corpus.bpe.100.$SRC \
	-train_tgt $datadir/corpus.bpe.100.$TRG \
	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.100.$SRC \
	-valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.100.$TRG \
	-save_data $datadir/corpus.100

python preprocess.py \
	-train_src $datadir/corpus.bpe.60.$SRC \
	-train_tgt $datadir/corpus.bpe.60.$TRG \
	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.60.$SRC \
	-valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.60.$TRG \
	-save_data $datadir/corpus.60

python preprocess.py \
	-train_src $datadir/corpus.bpe.30.$SRC \
	-train_tgt $datadir/corpus.bpe.30.$TRG \
	-valid_src $datadir/dev/newstest2012_OS2018.dev.bpe.30.$SRC \
	-valid_tgt $datadir/dev/newstest2012_OS2018.dev.bpe.30.$TRG \
	-save_data $datadir/corpus.30

# Europarl
python preprocess.py \
	-train_src $datadir/europarl-v7.es-en.bpe.100.$SRC \
	-train_tgt $datadir/europarl-v7.es-en.bpe.100.$TRG \
	-valid_src $datadir/dev/newstest2012.bpe.100.$SRC \
	-valid_tgt $datadir/dev/newstest2012.bpe.100.$TRG \
	-save_data $datadir/europarl.100

python preprocess.py \
	-train_src $datadir/europarl-v7.es-en.bpe.60.$SRC \
	-train_tgt $datadir/europarl-v7.es-en.bpe.60.$TRG \
	-valid_src $datadir/dev/newstest2012.bpe.60.$SRC \
	-valid_tgt $datadir/dev/newstest2012.bpe.60.$TRG \
	-save_data $datadir/europarl.60

python preprocess.py \
	-train_src $datadir/europarl-v7.es-en.bpe.30.$SRC \
	-train_tgt $datadir/europarl-v7.es-en.bpe.30.$TRG \
	-valid_src $datadir/dev/newstest2012.bpe.30.$SRC \
	-valid_tgt $datadir/dev/newstest2012.bpe.30.$TRG \
	-save_data $datadir/europarl.30

# Open Subtitles
python preprocess.py \
	-train_src $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$SRC \
	-train_tgt $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.100.$TRG \
	-valid_src $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$SRC \
	-valid_tgt $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100.$TRG \
	-save_data $datadir/OpenSubtitles2018.100

python preprocess.py \
	-train_src $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.60.$SRC \
	-train_tgt $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.60.$TRG \
	-valid_src $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.60.$SRC \
	-valid_tgt $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.60.$TRG \
	-save_data $datadir/OpenSubtitles2018.60

python preprocess.py \
	-train_src $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.30.$SRC \
	-train_tgt $datadir/OpenSubtitles2018.en-es.shuf.train.bpe.30.$TRG \
	-valid_src $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.30.$SRC \
	-valid_tgt $datadir/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.30.$TRG \
	-save_data $datadir/OpenSubtitles2018.30