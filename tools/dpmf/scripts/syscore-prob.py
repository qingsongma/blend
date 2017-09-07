#!/usr/local/bin/python2.7 
import sys
f = open(sys.argv[1]);
line = f.readline()
line = f.readline()
score=0
cnt=1
while line:
    score = score + float(line)
    line = f.readline()
    cnt = cnt+1
print score,
f.close()
fa = open(sys.argv[1],'a');
score = score/float(3000)
fa.write("sys level t2sts "+str(score))
