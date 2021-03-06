#!/usr/bin/env bash
set -e
set -x

PARTITION=$1
CFG=$2
PRETRAIN=$3
FEAT_LIST=$4
GPUS=${5:-8}
WORK_DIR=$(echo ${CFG%.*} | sed -e "s/configs/work_dirs/g")/

bash tools/srun_extract.sh $PARTITION $CFG $GPUS --pretrained $PRETRAIN

srun -p $PARTITION bash benchmarks/svm_tools/eval_svm_full.sh $WORK_DIR $FEAT_LIST

srun -p $PARTITION bash benchmarks/svm_tools/eval_svm_lowshot.sh $WORK_DIR $FEAT_LIST
