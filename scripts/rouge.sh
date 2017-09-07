ref=$1
tst=$2
blend_dir=$3
refname=${ref#*/}
tstname=${tst#*/}

tmp=$(pwd)/tmp
config=$tmp/config.txt
len=`cat $ref | wc -l`
Num=${#len}

if [ -f "$config" ];then
    rm "$config"
fi

cd $tmp
split -l 1 ../$ref -d -a $Num $refname
split -l 1 ../$tst -d -a $Num $tstname
cd ..

idx=$[$len-1]
for i in `seq 0 $idx`
    do
        n=`printf "%.${Num}d" $i`
        echo "$tmp/$tstname$n $tmp/$refname$n" >> $config
    done

perl $blend_dir/tools/rouge-1.5.5/ROUGE-1.5.5.pl -e $blend_dir/tools/rouge-1.5.5/data -z SPL -2 -1 -U -r 1000 -n 4 -w 1.2 -c 95 -d -m $config >ROUGE

python $blend_dir/scripts/form-rouge-score.py  $(pwd)/scores/ $tst

rm -r $tmp/* ROUGE

