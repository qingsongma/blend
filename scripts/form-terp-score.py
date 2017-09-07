import sys
predir = sys.argv[1]
tst = sys.argv[2]
tstname = tst[5:-4] # rm data/, .sgm

def form_score(inf, outf):
    fout = open(predir + outf, 'w')
    
    for idx, line in enumerate(open(inf, 'rU')):
        score = line.split()[-2]
        fout.write('-' + score + "\n")
     
    fout.close()

if __name__ == '__main__':
    form_score('TERbase', tstname + '.nTERbase')
    form_score('TER', tstname + '.nTER')
    form_score('TERp', tstname + '.nTERp')
    form_score('TERp-A', tstname + '.nTERp-A')
