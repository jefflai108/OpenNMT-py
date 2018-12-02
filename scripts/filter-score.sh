#!/bin/bash

# INCOMPLETE

#score_path=/export/c06/cguo/data2/pc.shuf.train.bpe.100.en.clean.dc2
#en_data_path=/export/c06/cguo/data2/pc.shuf.train.bpe.100.en
#es_data_path=/export/c06/cguo/data2/pc.shuf.train.bpe.100.es
#en_simple_path=/export/c06/cguo/data2/pc.shuf.train.bpe.100.simple30.en
#en_complex_path=/export/c06/cguo/data2/pc.shuf.train.bpe.100.complex30.en
#es_simple_path=/export/c06/cguo/data2/pc.shuf.train.bpe.100.simple30.es
#es_complex_path=/export/c06/cguo/data2/pc.shuf.train.bpe.100.complex30.es
#
#lower_bound=7.04
#upper_bound=9.62
#
## Ref for bash file looping https://unix.stackexchange.com/questions/26601/how-to-read-from-two-input-files-using-while-loop
## https://unix.stackexchange.com/questions/190814/read-lines-and-match-against-pattern
#while true
#do
#  read -r f1 <&3 || break
#  read -r f2 <&4 || break
#  read -r score_path <&5 || break
#  if echo "$score_path" < lower_bound; then
#  read -r f2_l <&6 || break
#  if  echo "$f1_l" | grep -q "en" && echo "$f2_l" | grep -q "de"; then 
#	  printf '%s\n' "$f1" >> $f1_o
#	  printf '%s\n' "$f2" >> $f2_o
#  fi
#done 3<$f1 4<$f1_l 5<$f2 6<$f2_l 7<$f1_o 8<$f2_o

