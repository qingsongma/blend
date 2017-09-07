#!/usr/local/bin/python2.7 
import sys

dpm_f = sys.argv[1]
preci_f = sys.argv[2]
recall_f = sys.argv[3]
arg = float(sys.argv[4])

score = 0
dpmL, preciL, recallL = [], [], []
for idx, line in enumerate(open(dpm_f, 'rU')):
    dpmL.append(float(line.strip()))

for idx, line in enumerate(open(preci_f, 'rU')):
    preciL.append(float(line.strip()))

for idx, line in enumerate(open(recall_f, 'rU')):
    recallL.append(float(line.strip()))

for i in range(len(dpmL)):
    v1, v2, v3 = dpmL[i], preciL[i], recallL[i]

    if (v2 == 0 or v3 == 0):
        score = 0
    else:
        score = v1 * 1.0 / (arg / v3 + (1.0 - arg) / v2)

    if score < 0:
        score = 0
    print str(score)
