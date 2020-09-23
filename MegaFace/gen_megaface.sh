python -u gen_megaface.py \
--gpu 0 \
--algo "s1.0-cosface" \
--model '/xuhanzhu/glint-face/IJB/emore/model,0' \
--facescrub-lst '/xuhanzhu/face/megaface_testpack/facescrub_lst' \
--megaface-lst '/xuhanzhu/face/megaface_testpack/megaface_lst' \
--facescrub-root '/xuhanzhu/face/megaface_testpack/facescrub_images' \
--megaface-root '/xuhanzhu/face/megaface_testpack/megaface_images' \
--output '/xuhanzhu/face/megaface_feature_out/1.0'