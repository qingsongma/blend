import sys
predir = sys.argv[1]
tst = sys.argv[2]
tstname = tst[5:-4] # rm data/, .sgm

def form_score(inf, outf):
    fout = open(predir + outf, 'w')
    
    for idx, line in enumerate(open(inf, 'rU')):
        score = line.split()[-1]
        fout.write(score + "\n")
     
    fout.close()

if __name__ == '__main__':
    form_score('meteor-ex', tstname + '.METEOR-ex')
    form_score('meteor-st', tstname + '.METEOR-st')
    form_score('meteor-sy', tstname + '.METEOR-sy')
    form_score('meteor-pa', tstname + '.METEOR-pa')
