python -u remove_noises.py \
--algo "s1.0-cosface" \
--facescrub-noises '/xuhanzhu/face/megaface_test/facescrub_noises.txt' \
--megaface-noises '/xuhanzhu/face/megaface_test/megaface_noises.txt' \
--facescrub-lst '/xuhanzhu/face/megaface_test/facescrub_lst' \
--megaface-lst '/xuhanzhu/face/megaface_test/megaface_lst' \
--feature-dir-input '/xuhanzhu/face/megaface_feature_out/1.0' \
--feature-dir-out '/xuhanzhu/face/feature_out_clean/1.0'