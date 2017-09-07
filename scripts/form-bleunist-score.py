import sys

predir = sys.argv[1]
tst = sys.argv[2]

inf_bleu = 'BLEU-seg.scr'
inf_nist = 'NIST-seg.scr'

tstname = tst[5:-4] # rm data/ .sgm

fo_bleu = open(predir + tstname + ".BLEU", 'w')
fo_nist = open(predir + tstname + ".NIST", 'w')

for idx, line in enumerate(open(inf_bleu, 'rU')):
    score = line.split()[-1]
    fo_bleu.write(score + "\n")

for idx, line in enumerate(open(inf_nist, 'rU')):
    score = line.split()[-1]
    fo_nist.write(score + "\n")

fo_bleu.close()
fo_nist.close()
