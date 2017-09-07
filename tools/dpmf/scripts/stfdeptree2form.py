#!/usr/local/bin/python2.7
import sys
f = open(sys.argv[1]);
line = f.readline()
while line:
    if(len(line)>1):
        p=line.find('(')
        rela=line[0:p]
        newline=line[p+1:len(line)-2]
        strlist = newline.split(', ')
        p=strlist[1].rfind('-')
        w1=strlist[1][0:p]
        posi1=strlist[1][p+1:len(strlist[1])]
        p=strlist[0].rfind('-')
        w2=strlist[0][0:p]
        posi2=strlist[0][p+1:len(strlist[0])]
        print w1+'\t'+'NN'+'\t'+ posi2 + '\t' + rela
    else:
        print line,
    line = f.readline()
f.close()

