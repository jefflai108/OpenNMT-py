#!/bin/bash -v

# suffix of source language files
SRC=es

# suffix of target language files
TRG=en

# path to moses decoder: https://github.com/moses-smt/mosesdecoder
export mosesdecoder=/home/pkoehn/moses

### Concat validation sets
##cat data/dev/newstest2012.bpe.$SRC data/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.$SRC > data/dev/newstest2012_OS2018.dev.bpe.$SRC &
##p1=$! &
##cat data/dev/newstest2012.bpe.$TRG data/dev/OpenSubtitles2018.en-es.shuf.dev.bpe.$TRG > data/dev/newstest2012_OS2018.dev.bpe.$TRG &
##p2=$! &
##cat data/test/newstest2013-src.bpe.$SRC data/test/OpenSubtitles2018.en-es.shuf.test.bpe.$SRC > data/test/newstest2013_OS2018.test.bpe.$SRC &
##p3=$! &
##cat data/test/newstest2013-src.bpe.$TRG data/test/OpenSubtitles2018.en-es.shuf.test.bpe.$TRG > data/test/newstest2013_OS2018.test.bpe.$TRG &
##wait $p1 $p2 $p3
##

###############################################################################
###
### (1) Clean BPE-ed train and dev files to length N
### (2) Join cleaned files into a $SRC-$TRG version
###

### Length: 100
##pids=
### Clean BPE-ed train and dev files
##for prefix in corpus.bpe europarl-v7.es-en.bpe OpenSubtitles2018.en-es.shuf.train.bpe \
##	dev/newstest2012.bpe dev/OpenSubtitles2018.en-es.shuf.dev.bpe dev/newstest2012_OS2018.dev.bpe
##do 
##	$mosesdecoder/scripts/training/clean-corpus-n.perl data/$prefix $SRC $TRG data/$prefix.100 1 100 &
##	pids+=" $!" &
##done
##wait $pids
##
### Join train, dev, and test files into combo es-en files
##for prefix in corpus.bpe.100 europarl-v7.es-en.bpe.100 OpenSubtitles2018.en-es.shuf.train.bpe.100 \
##	dev/newstest2012.bpe.100 dev/OpenSubtitles2018.en-es.shuf.dev.bpe.100 dev/newstest2012_OS2018.dev.bpe.100 \
##	test/newstest2013-src.bpe test/OpenSubtitles2018.en-es.shuf.test.bpe test/newstest2013_OS2018.test.bpe
##do
##	paste -d '|' data/$prefix.$SRC data/$prefix.$TRG | sed 's/|/|||/' > data/$prefix.$SRC-$TRG
##done	

### Length 30
##### Preprocess Data to maxlen=30 to improve model speed.
##### Added 15 Nov, processed above data-processing lines commented-out
##pids2=
### Clean BPE-ed train and dev files
##for prefix in corpus.bpe europarl-v7.es-en.bpe OpenSubtitles2018.en-es.shuf.train.bpe \
##       	dev/newstest2012.bpe dev/OpenSubtitles2018.en-es.shuf.dev.bpe dev/newstest2012_OS2018.dev.bpe
##do
##        $mosesdecoder/scripts/training/clean-corpus-n.perl data/$prefix $SRC $TRG data/$prefix.30 1 30 &
##        pids2+=" $!" &
##done
##wait $pids2
##
### Join train, dev, and test files into combo es-en files
##for prefix in corpus.bpe.30 europarl-v7.es-en.bpe.30 OpenSubtitles2018.en-es.shuf.train.bpe.30 \
##	dev/newstest2012.bpe.30 dev/OpenSubtitles2018.en-es.shuf.dev.bpe.30 dev/newstest2012_OS2018.dev.bpe.30 
##do
##        paste -d '|' data/$prefix.$SRC data/$prefix.$TRG | sed 's/|/|||/' > data/$prefix.$SRC-$TRG
##done

### Length 50
##pids3=
### Clean BPE-ed train and dev files
##for prefix in corpus.bpe europarl-v7.es-en.bpe OpenSubtitles2018.en-es.shuf.train.bpe \
##       	dev/newstest2012.bpe dev/OpenSubtitles2018.en-es.shuf.dev.bpe dev/newstest2012_OS2018.dev.bpe
##do
##        $mosesdecoder/scripts/training/clean-corpus-n.perl data/$prefix $SRC $TRG data/$prefix.50 1 50 &
##        pids3+=" $!" &
##done
##wait $pids3
##
### Join train, dev, and test files into combo es-en files
##for prefix in corpus.bpe.50 europarl-v7.es-en.bpe.50 OpenSubtitles2018.en-es.shuf.train.bpe.50 \
##	dev/newstest2012.bpe.50 dev/OpenSubtitles2018.en-es.shuf.dev.bpe.50 dev/newstest2012_OS2018.dev.bpe.50 
##do
##        paste -d '|' data/$prefix.$SRC data/$prefix.$TRG | sed 's/|/|||/' > data/$prefix.$SRC-$TRG
##done

### Length 60
##pid4=
### Clean BPE-ed train and dev files
##for prefix in corpus.bpe europarl-v7.es-en.bpe OpenSubtitles2018.en-es.shuf.train.bpe \
##       	dev/newstest2012.bpe dev/OpenSubtitles2018.en-es.shuf.dev.bpe dev/newstest2012_OS2018.dev.bpe
##do
##        $mosesdecoder/scripts/training/clean-corpus-n.perl data/$prefix $SRC $TRG data/$prefix.60 1 60 &
##        pids4+=" $!" &
##done
##wait $pids4
##
### Join train, dev, and test files into combo es-en files
##for prefix in corpus.bpe.60 europarl-v7.es-en.bpe.60 OpenSubtitles2018.en-es.shuf.train.bpe.60 \
##	dev/newstest2012.bpe.60 dev/OpenSubtitles2018.en-es.shuf.dev.bpe.60 dev/newstest2012_OS2018.dev.bpe.60 
##do
##        paste -d '|' data/$prefix.$SRC data/$prefix.$TRG | sed 's/|/|||/' > data/$prefix.$SRC-$TRG
##done


