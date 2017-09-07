#!/usr/local/bin/python2.7
import sys
f = open(sys.argv[1]);
#print sys.argv[1]
line = f.readline()
while line:
    if(line.find("Segment ") > -1):
        strlist = line.split('\t')
        pre = strlist[1]
        print pre
    if(line.find("Precision:")>-1):
        pre = line[24:len(line)]
        #print "sys level meteor ",pre,
    line = f.readline()
f.close()

