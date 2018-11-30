# path to moses decoder: https://github.com/moses-smt/mosesdecoder
export mosesdecoder=/home/pkoehn/moses

# Convert newstest2013 SGM files into raw text
$mosesdecoder/scripts/ems/support/input-from-sgm.perl \
	< data/test/newstest2013-src.en.sgm \
	> data/test/newstest2013-src.en

$mosesdecoder/scripts/ems/support/input-from-sgm.perl \
	< data/test/newstest2013-src.es.sgm \
	> data/test/newstest2013-src.es

