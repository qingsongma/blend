import sys

predir = sys.argv[1]
tst = sys.argv[2]

tmpdir = './tmp/'
tstname = tst[5:-4] # rm data/, .sgm

def form_score(inf, outf):
    fout = open(predir + outf, 'w')
    
    for idx, line in enumerate(open(tmpdir + inf, 'rU')):
        if 'doc "' in line:
            score = line.split()[-1]
            fout.write(score + "\n")

    fout.close()

if __name__ == '__main__':
    form_score('gtm1', tstname + '.GTM-1')
    form_score('gtm2', tstname + '.GTM-2')
    form_score('gtm3', tstname + '.GTM-3')
