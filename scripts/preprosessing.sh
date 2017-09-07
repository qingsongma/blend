ref=$1
tst=$2
src=$3
slan=$4
tlan=$5
blend_dir=$6

dir=$blend_dir/tools/tokenizer
$dir/tokenizer.perl -l $tlan < $tst > data/$tst.tok
python $dir/to_lower.py data/$tst.tok data/$tst.tok.low

$dir/tokenizer.perl -l $tlan < $ref > data/$ref.tok
python $dir/to_lower.py data/$ref.tok data/$ref.tok.low

$dir/tokenizer.perl -l $slan < $src > data/$src.tok
python $dir/to_lower.py data/$src.tok data/$src.tok.low

dir=$blend_dir/scripts
$dir/plain2sgm-new src data/$src.tok.low > data/$src.sgm
$dir/plain2sgm-new ref data/$ref.tok.low > data/$ref.sgm
$dir/plain2sgm-new tst data/$tst.tok.low > data/$tst.sgm

mv data/$src.tok.low data/$src
mv data/$ref.tok.low data/$ref
mv data/$tst.tok.low data/$tst
