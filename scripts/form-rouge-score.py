import sys

predir = sys.argv[1]
tst = sys.argv[2]

tstname = tst[5:] # rm data/

inf = 'ROUGE'

predir += tstname
fout1 = open(predir + '.ROUGE-1', 'w')
fout2 = open(predir + '.ROUGE-2', 'w')
fout3 = open(predir + '.ROUGE-3', 'w')
fout4 = open(predir + '.ROUGE-4', 'w')
foutL = open(predir + '.ROUGE-L', 'w')
foutS = open(predir + '.ROUGE-S*', 'w')
foutSU = open(predir + '.ROUGE-SU*', 'w')
foutW = open(predir + '.ROUGE-W', 'w')

for idx, line in enumerate(open(inf, 'rU')):
    score = line.split()[-1][2:]
    if 'X ROUGE-1 Eval' in line:
        fout1.write(score + "\n")
    elif 'X ROUGE-2 Eval' in line:
        fout2.write(score + "\n")
    elif 'X ROUGE-3 Eval' in line:
        fout3.write(score + "\n")
    
    elif 'X ROUGE-4 Eval' in line:
        fout4.write(score + "\n")
    elif 'X ROUGE-L Eval' in line:
        foutL.write(score + "\n")
    elif 'X ROUGE-W-1.2 Eval' in line:
        foutW.write(score + "\n")
    elif 'X ROUGE-S* Eval' in line:
        foutS.write(score + "\n")
    elif 'X ROUGE-SU* Eval' in line:
        foutSU.write(score + "\n")

fout1.close()
fout2.close()
fout3.close()
fout4.close()
foutL.close()
foutS.close()
foutSU.close()
foutW.close()
