import os
import json
import numpy as np
import matplotlib
from fnmatch import fnmatch
import matplotlib.pyplot as plt

matplotlib.use('agg')

n_distractors = [10 ** i for i in range(1, 7)]


def load_result_data(folder, probe_name):
    #    n_distractors = generate_n_distractors()
    print('===> Load result data from ', folder)

    all_files = os.listdir(folder)
    #    print 'all_files: ', all_files
    cmc_files = sorted(
        [a for a in all_files if fnmatch(a.lower(), 'cmc*%s*_1.json' % probe_name.lower())])[::-1]
    #    print 'cmc_files: ', cmc_files

    if not cmc_files:
        return None

    cmc_dict = {}
    for i, filename in enumerate(cmc_files):
        with open(os.path.join(folder, filename), 'r') as f:
            cmc_dict[n_distractors[i]] = json.load(f)

    rocs = []

    for i in n_distractors:
        rocs.append(cmc_dict[i]['roc'])

    cmcs = []

    for i in n_distractors:
        for j in range(len(cmc_dict[i]['cmc'][0])):
            cmc_dict[i]['cmc'][0][j] += 1

        cmcs.append(cmc_dict[i]['cmc'])

    rank_1 = [cmc_dict[n]['cmc'][1][0]
              for n in n_distractors]

    return {
        'rocs': rocs,
        'cmcs': cmcs,
        'Rank_1': rank_1,
    }


def generate_plot_colors():
    _colors = ['w', 'b', 'g', 'r', 'c', 'm', 'y', 'k']

    rgb_colors_list = []

    # 9 basic colors
    for it in _colors:
        rgb_colors_list.append(matplotlib.colors.to_rgb(it))

    # add other colors not in the 9 basic colors
    for r in (0, 0.5, 1.0):
        for g in (0, 0.5, 1.0):
            for b in (0, 0.5, 1.0):
                rgb = (r, g, b)
                if rgb not in rgb_colors_list:
                    rgb_colors_list.append(rgb)

    # remove white color
    rgb_colors_list.remove((1.0, 1.0, 1.0))
    print('===> {} colors generated without "white" color'.format(
        len(rgb_colors_list)))

    return rgb_colors_list


colors = generate_plot_colors()

root = '/train/trainset/1'
result = load_result_data('{}/face/megaface_test/result_clean/0.05_results'.format(root), 'facescrub')
result_2 = load_result_data('{}/face/megaface_test/result_clean/0.1_results'.format(root), 'facescrub')
result_3 = load_result_data('{}/face/megaface_test/result_clean/0.4_results'.format(root), 'facescrub')
result_4 = load_result_data('{}/face/megaface_test/result_clean/0.8_results'.format(root), 'facescrub')
result_5 = load_result_data('{}/face/megaface_test/result_clean/1.0_results'.format(root), 'facescrub')
result_6 = load_result_data('{}/face/megaface_test/result_clean/retina1.0_results'.format(root), 'facescrub')

result_list = [result, result_2, result_3, result_4, result_5, result_6]
label_list = ['MS1MV2, S=0.05', 'MS1MV2, S=0.1', 'MS1MV2, S=0.4', \
              'MS1MV2, S=0.8', 'MS1MV2, S=1.0', 'RETINA, S=1.0']

handles = []

for i in range(len(result_list)):
    rocs = result_list[i]['cmcs'][-1]
    A, = plt.semilogx(rocs[0], rocs[1],  c=colors[i], label=label_list[i])
    handles.append(A)


plt.xlim([1, 1e6])
plt.ylim([0.92, 1])
plt.grid(True, which='major', ls='--')
plt.grid(True, which='minor', ls='--')

ax = plt.gca()
ax.set_xlabel('Rank', fontsize=12)
ax.set_ylabel('Identification Rate (%)', fontsize=12)


font1 = {'family': 'Times New Roman',
         'weight': 'normal',
         'size': 10,
         }

legend = plt.legend(handles=handles, prop=font1, loc='lower right')
plt.savefig("megaface_cmcs.pdf")
