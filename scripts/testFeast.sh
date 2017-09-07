#!/bin/sh
tst=$1
metrics=$2
outf=$3

if [ -f "$outf" ];then
    rm "$outf"
fi

tst=$(pwd)/scores/$tst
linenum=`cat ${tst}.BLEU | wc -l`
for i in `seq 1 $linenum`
    do
        idx=1
        featline='0 '
        for m in ${metrics[*]};
            do
                file=$tst.$m
                line=`sed -n ''$i'p' $file`
                featline=$featline' '$idx':'$line
                idx=$(($idx+1))
            done
            echo $featline >>$outf
        i=$(($i+1))
     done
