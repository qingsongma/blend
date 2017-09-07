#!/usr/local/bin/python2.7
import sys
f = open(sys.argv[1]);
line = f.readline()
lineAll = ''
while line:
    lineAll = lineAll + line.strip('\n') +" "
    line = f.readline()
f.close()
strlist = lineAll.split('@START')
for v in strlist:
    if(len(v)>1):
        v = v.strip()
        pos = v.find(' ',0)
        newline = v[pos+1:len(v)]
        wordlist = newline.split(' ')
        for word in wordlist:
            wpos = word.rfind('_')
            print word[0:wpos]+'/'+word[wpos+1:len(word)],
        print 
