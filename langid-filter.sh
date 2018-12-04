#!/bin/bash

# START: Demo Commands
#langid --line < paracrawl-test.en > paracrawl-test.en-langid
#langid --line < paracrawl-test.de > paracrawl-test.de-langid

#f1=./paracrawl-test.en
#f1_l=./paracrawl-test.en-langid
#f1_o=./paracrawl-test.en-filtered
#f2=./paracrawl-test.de
#f2_l=./paracrawl-test.de-langid
#f2_o=./paracrawl-test.de-filtered
# END: Demo Commands

f1=data/paracrawl-release1.en-de.zipporah0-dedup-clean.en 
f1_l=data/paracrawl.en-langid
f1_o=data/paracrawl.en-filtered
f2=data/paracrawl-release1.en-de.zipporah0-dedup-clean.de 
f2_l=data/paracrawl.de-langid
f2_o=data/paracrawl.de-filtered

#langid --line < $f1 > $f1_l
#langid --line < $f2 > $f2_l

# https://unix.stackexchange.com/questions/404822/shell-script-to-create-a-file-if-it-doesnt-exist
touch $f1_o
touch $f2_o

# Ref for bash file looping https://unix.stackexchange.com/questions/26601/how-to-read-from-two-input-files-using-while-loop
# https://unix.stackexchange.com/questions/190814/read-lines-and-match-against-pattern
while true
do
  read -r f1 <&3 || break
  read -r f1_l <&4 || break
  read -r f2 <&5 || break
  read -r f2_l <&6 || break
  if  echo "$f1_l" | grep -q "en" && echo "$f2_l" | grep -q "de"; then 
	  printf '%s\n' "$f1" >> $f1_o
	  printf '%s\n' "$f2" >> $f2_o
  fi
done 3<$f1 4<$f1_l 5<$f2 6<$f2_l 7<$f1_o 8<$f2_o

