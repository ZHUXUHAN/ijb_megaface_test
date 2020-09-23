cd /xuhanzhu/face/megaface_test/devkit/experiments

Sample=1.0
ALGO="s${Sample}-cosface"

python -u run_experiment.py \
"/xuhanzhu/face/feature_out_clean/"${Sample}"/megaface" \
"/xuhanzhu/face/feature_out_clean/"${Sample}"/facescrub" \
_${ALGO}.bin \
../../result_clean/${ALGO}/ \
-p ../templatelists/facescrub_features_list.json