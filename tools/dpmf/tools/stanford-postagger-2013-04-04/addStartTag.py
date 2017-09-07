#!/usr/local/bin/python2.7 
import sys
f = open(sys.argv[1]);
line = f.readline()
while line:
    print '@START',
    print line,
    line = f.readline()

f.close()
