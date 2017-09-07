#!/usr/local/bin/python2.7
import sys
import math
fin = open(sys.argv[1]);
fseg = open(sys.argv[2],'w');
fsys = open(sys.argv[3],'w');
line = fin.readline()
while line:
    line=line.strip()
    p1=line.find('.')
    p2=line.rfind('.')
    year=line[0:p1]
    sysname=line[p1+1:p2]
    lan=line[p2+1:len(line)]
    fintmp = open(line);
    segCnt=0
    sysScore=0
    linetmp = fintmp.readline()
    while linetmp:
        segCnt = segCnt+1
        s1=linetmp.find('>')
        seg = linetmp[6:s1-1]
        score=(10-float(linetmp[s1+1:len(linetmp)-5]))

        sysScore = sysScore+float(score)
        strs="comb\t" +lan+"\t"+year+"\t"+sysname+"\t"+seg+"\t"+str(score)
        fseg.write(strs+"\n")
        linetmp = fintmp.readline()
    fsys.write("comb\t"+lan+"\t"+year+"\t"+sysname+"\t"+str(sysScore/segCnt)+"\n")
    print segCnt
    line = fin.readline()
fin.close()

