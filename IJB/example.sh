#!/usr/bin/env bash

export CUDA_VISIBLE_DEVICES='0,1'
METHOD='combine_2_webface'
root='/train/trainset/1'
IJB='IJBB'
GPU_ID=0
echo ${root}/glint-face/IJB/result/${METHOD}

python -u IJB_11_Batch.py --model-prefix ${root}/glint-face/IJB/${METHOD}/model \
--image-path ${root}/face/IJB_release/${IJB} \
--result-dir ${root}/glint-face/IJB/result/${METHOD} \
--model-epoch 0 --gpu ${GPU_ID} \
--target ${IJB} --job cosface \
--batch-size 256

