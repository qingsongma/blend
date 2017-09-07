ref=$1
tst=$2
src=$3
blend_dir=$4

perl $blend_dir/tools/mteval-kit/mteval-v13a.pl --metricsMATR  -r $ref -t $tst -s $src -d 2
python $blend_dir/scripts/form-bleunist-score.py scores/ $tst

rm BLEU-doc.scr
rm BLEU-seg.scr
rm BLEU-sys.scr
rm NIST-doc.scr
rm NIST-seg.scr
rm NIST-sys.scr

