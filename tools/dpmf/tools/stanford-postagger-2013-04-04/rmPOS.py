#!/usr/bin/python

import sys
import string

info = '''
'''

def filter(input, output):
    fin = open(input, 'rU')
    fout = open(output, 'w')

    count = 0

    for line in fin:
        newline = ''
        list = line.split(' ')
        for e in range(0,len(list)):
            p = list[e].rfind('/')
            word = list[e][0:p]
            pos = list[e][p+1:len(list[e])]
            newline = newline+word +' '
        newline = newline.strip()
        fout.write(newline+'\n')

        count += 1

        if count % 10000 == 0:
            print count

if __name__ == '__main__':
    print info + '\n'

    if len(sys.argv) < 3:
        print './to_lower.py input_file output_file'
        sys.exit(-1)

    filter(sys.argv[1], sys.argv[2])
