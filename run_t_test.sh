#!/bin/bash 

stage=2

if [ $stage -eq 0 ]; then 
	file1='/export/c06/kmarc/mtfinal-omnt/checkpoint/1/newstest2013_os2018.out.dc'
	file2='/export/c06/kmarc/mtfinal-omnt/checkpoint/2/newstest2013_os2018.out.dc'
fi 

if [ $stage -eq 1 ]; then 
# pair t test between checkpoints 2, 3 & 5
declare -a check_dir_1s=("2" "5" "6")
declare -a check_dir_2s=("2" "5" "6")
declare -a datas=("newstest2013" "os2018" "newstest2013_os2018")
declare -a evaluations=("dc" "fre" "fkg")
	for check_dir_1 in "${check_dir_1s[@]}"; do
	for check_dir_2 in "${check_dir_2s[@]}"; do
	for data in "${datas[@]}"; do
	for evaluation in "${evaluations[@]}"; do 
		if [ $check_dir_1 == $check_dir_2 ]; then 
			continue 
		fi
		echo $data $evaluation 'score of checkpoints' $check_dir_1 '&' $check_dir_2
		file1='checkpoint'/$check_dir_1/$data'.out.'$evaluation
		file2='checkpoint'/$check_dir_2/$data'.out.'$evaluation
		python /export/b14/jlai/mt/pair-t-test.py $file1 $file2
	done
	done
	done
	done
fi 

if [ $stage -eq 2 ]; then 
# pair t test within checkpoint 7
declare -a datas=("newstest2013" "os2018" "newstest2013_os2018")
declare -a evaluations=("dc" "fre" "fkg")
	for data in "${datas[@]}"; do
	for evaluation in "${evaluations[@]}"; do 
		echo $data $evaluation 'score of checkpoint 7'
		file1='checkpoint'/7/$data'.complex.out.'$evaluation
		file2='checkpoint'/7/$data'.simple.out.'$evaluation
		python /export/b14/jlai/mt/pair-t-test.py $file1 $file2
	done
	done
fi 
