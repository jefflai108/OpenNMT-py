#!/bin/bash -v

# Randomize Files
## mkfifo onerandom tworandom threerandom
## tee onerandom tworandom threerandom < /dev/urandom > /dev/null &
## p1=$! &
## shuf --random-source=onerandom OpenSubtitles2018.en-es.en > OpenSubtitles2018.en-es.shuf.en &
## p2=$! &
## shuf --random-source=tworandom OpenSubtitles2018.en-es.es > OpenSubtitles2018.en-es.shuf.es &
## p3=$! &
## shuf --random-source=threerandom OpenSubtitles2018.en-es.ids > OpenSubtitles2018.en-es.shuf.ids &
## p4=$! &
## wait $p1 $p2 $p3 $p4 

# Training Data
head -2000000 OpenSubtitles2018.en-es.shuf.en > OpenSubtitles2018.en-es.shuf.train.en &
p5=$! &
head -2000000 OpenSubtitles2018.en-es.shuf.es > OpenSubtitles2018.en-es.shuf.train.es & 
p6=$! &
head -2000000 OpenSubtitles2018.en-es.shuf.ids > OpenSubtitles2018.en-es.shuf.train.ids &
p7=$! &
wait $p5 $p6 $p7 

# Dev Data
tail -n +2000001 OpenSubtitles2018.en-es.shuf.en | head -10000 > OpenSubtitles2018.en-es.shuf.dev.en &
p8=$! &
tail -n +2000001 OpenSubtitles2018.en-es.shuf.es | head -10000 > OpenSubtitles2018.en-es.shuf.dev.es & 
p9=$! &
tail -n +2000001 OpenSubtitles2018.en-es.shuf.ids | head -10000 > OpenSubtitles2018.en-es.shuf.dev.ids &
p10=$! &
wait $p8 $p9 $p10 

# Test Data
tail -n +2010001 OpenSubtitles2018.en-es.shuf.en | head -10000 > OpenSubtitles2018.en-es.shuf.test.en &
p11=$! &
tail -n +2010001 OpenSubtitles2018.en-es.shuf.es | head -10000 > OpenSubtitles2018.en-es.shuf.test.es &
p12=$! &
tail -n +2010001 OpenSubtitles2018.en-es.shuf.ids | head -10000 > OpenSubtitles2018.en-es.shuf.test.ids &
p13=$! &
wait $p11 $p12 $p13

# Extra Data
tail -n +2020001 OpenSubtitles2018.en-es.shuf.en > OpenSubtitles2018.en-es.shuf.extra.en &
p14=$! &
tail -n +2020001 OpenSubtitles2018.en-es.shuf.es > OpenSubtitles2018.en-es.shuf.extra.es &
p15=$! &
tail -n +2020001 OpenSubtitles2018.en-es.shuf.ids > OpenSubtitles2018.en-es.shuf.extra.ids &
p16=$! &
wait $p14 $p15 $p16 

# Move new files into the correct directories
mv OpenSubtitles2018.en-es.shuf.dev.en dev/ 
mv OpenSubtitles2018.en-es.shuf.dev.es dev/
mv OpenSubtitles2018.en-es.shuf.dev.ids dev/
mv OpenSubtitles2018.en-es.shuf.test.en test/
mv OpenSubtitles2018.en-es.shuf.test.es test/
mv OpenSubtitles2018.en-es.shuf.test.ids test/
mv OpenSubtitles2018.en-es.shuf.extra.en extra/
mv OpenSubtitles2018.en-es.shuf.extra.es extra/
mv OpenSubtitles2018.en-es.shuf.extra.ids extra/
