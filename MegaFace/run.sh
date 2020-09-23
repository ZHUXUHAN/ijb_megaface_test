#!/usr/bin/env bash


Sample=1.0
Method='anxiang_emore_1'
DEVKIT="/train/trainset/1/face/megaface_test/devkit/experiments"
ALGO="s${Sample}-cosface"
Feature_Out_Dir="/train/trainset/1/face/megaface_feature_out/${Method}${Sample}"
Feature_Out_Clean_Dir="/train/trainset/1/face/feature_out_clean/${Method}${Sample}"
Model_Path='/train/trainset/1/glint-face/IJB/'${Method}${Sample}'/model,0'
Megaface_Testpack='/train/trainset/1/face/megaface_testpack'
Out_Clean_Result_Dir='../../result_clean/'${Method}${Sample}'_results/'
Out_Result_Dir='../../result/'${Method}${Sample}'_results/'
GPU_ID=0
### 1.0 0 # 0.1 1 # 0.4 2 # 0.8 3 # 0.05 4 # retina1.0 5 # punishment 6
echo ${ALGO}
echo ${Model_Path}
echo ${Feature_Out_Dir}
echo ${Out_Clean_Result_Dir}

# Gen Feature
echo 'gen feature'
python -u gen_megaface.py \
--gpu ${GPU_ID} \
--algo ${ALGO} \
--model  ${Model_Path} \
--facescrub-lst ${Megaface_Testpack}'/facescrub_lst' \
--megaface-lst ${Megaface_Testpack}'/megaface_lst' \
--facescrub-root ${Megaface_Testpack}'/facescrub_images' \
--megaface-root ${Megaface_Testpack}'/megaface_images' \
--output ${Feature_Out_Dir} \
--batch_size 32

# Remove Noises
#echo 'remove noises'
python -u remove_noises.py \
--algo ${ALGO} \
--facescrub-noises ${Megaface_Testpack}'/facescrub_noises.txt' \
--megaface-noises ${Megaface_Testpack}'/megaface_noises.txt' \
--facescrub-lst ${Megaface_Testpack}'/facescrub_lst' \
--megaface-lst ${Megaface_Testpack}'/megaface_lst' \
--feature-dir-input ${Feature_Out_Dir} \
--feature-dir-out ${Feature_Out_Clean_Dir}


# Get Result From Clean Feature
echo 'get result from clean feature'
cd ${DEVKIT}

python -u run_experiment.py \
${Feature_Out_Clean_Dir}"/megaface" \
${Feature_Out_Clean_Dir}"/facescrub" \
_${ALGO}.bin \
${Out_Clean_Result_Dir} \
-p ../templatelists/facescrub_features_list.json

# Get Result From Feature
#echo 'get result from not clean feature'
#cd ${DEVKIT}

#python -u run_experiment.py \
#${Feature_Out_Dir}"/megaface" \
#${Feature_Out_Dir}"/facescrub" \
#_${ALGO}.bin \
#${Out_Result_Dir} \
#-p ../templatelists/facescrub_features_list.json
