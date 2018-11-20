#!/bin/bash -v

. ./local-settings.sh

echo You are running on machine: `hostname`
echo Here is what free-gpu returned: `free-gpu` 
echo '$CUDA_VISIBLE_DEVICES: ' $CUDA_VISIBLE_DEVICES
echo Here is the output of nvidia-smi: `nvidia-smi`

###############################################################################

stage=$1
STEPS=1000000
REPORT=500

if [ $stage -eq 0 ]; then
	# Baseline - Full Corpus
	DATA=corpus.100
fi

if [ $stage -eq 1 ]; then
	# Baseline - Europarl 
	DATA=europarl.100
fi

if [ $stage -eq 2 ]; then
	# Baseline - OpenSubtitles2018
	DATA=OpenSubtitles2018.100
fi


###############################################################################

# Make Train Directory
mkdir -p checkpoint/$stage

# Train Function
python train.py \
	-data data/$DATA -train_steps $STEPS \
	-save_model checkpoint/$stage/$stage \
	-log_file checkpoint/$stage/train.log -report_every $REPORT \
	-world_size 1 -gpu_ranks 0

