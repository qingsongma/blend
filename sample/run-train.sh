src=$1
ref=$2
tst=$3
judge=$4
slan=$5
tlan=$6

if [ ! -d "data" ];then
    mkdir data
fi

if [ ! -d "scores" ];then
    mkdir scores
fi

if [ ! -d "tmp" ];then
    mkdir tmp
fi

if [ ! -d "blend" ];then
    mkdir blend
fi

trainf=blend/trainFeat.txt

cwd=$(pwd)
dir=$(pwd)/../../blend

# python_path can be change accordingly.
python_path=/leofs/jwb/zw/4.tools/Python-2.7.8/python

metrics=("BLEU" "GTM-1" "GTM-2" "GTM-3" "METEOR-ex" "METEOR-pa" "METEOR-st" "METEOR-sy" 
         "NIST" "Ol" "nPER" "ROUGE-1" "ROUGE-2" "ROUGE-3" "ROUGE-4" "ROUGE-L" "ROUGE-SU*" 
         "ROUGE-S*" "ROUGE-W"
         "nTERbase" "nTERp-A" "nTERp" "nTER" "WER" "nWER"
         "ENTF" "DPMF" "BEER" "cTER")

# Preprocessing
sh $dir/scripts/preprosessing.sh $ref $tst $src $slan $tlan $dir

# Computing incorporated metric scores
echo -e "Starting BLEU...\c"
sh $dir/scripts/bleunist.sh data/$ref.sgm data/$tst.sgm data/$src.sgm $dir >tmpf

echo -e "DONE\nStarting GTM...\c"
sh $dir/scripts/gtm.sh data/$ref.sgm data/$tst.sgm $dir

echo -e "DONE\nStarting METEOR...\c"
sh $dir/scripts/meteor.sh data/$ref.sgm data/$tst.sgm $dir >tmpf

echo -e "DONE\nStarting PER...\c"
sh $dir/scripts/per.sh data/$ref data/$tst $dir

echo -e "DONE\nStarting WER...\c"
sh $dir/scripts/wer.sh data/$ref data/$tst $dir

echo -e "DONE\nStarting Ol...\c"
sh $dir/scripts/Ol.sh data/$ref data/$tst $dir

echo -e "DONE\nStarting TER...\c"
sh $dir/scripts/terp.sh data/$ref.sgm data/$tst.sgm $dir

echo -e "DONE\nStarting ROUGE...\c"
sh $dir/scripts/rouge.sh data/$ref data/$tst $dir

echo -e "DONE\nStarting BEER...\c"
sh $dir/scripts/beer.sh data/$ref data/$tst $dir

echo -e "DONE\nStarting CharcTER...\c"
$dir/scripts/cTer.sh data/$ref data/$tst $dir $python_path

echo -e "DONE\nStarting ENTF...\c"
sh $dir/scripts/entf.sh data/$ref data/$tst $tlan $dir >tmpf

echo -e "DONE\nStarting DPMF...\c"
sh $dir/scripts/dpmf.sh data/$ref data/$tst $tlan $dir >tmpf

# Training
echo -e "DONE\nStarting to generate training file..."
sh $dir/scripts/trainFeat.sh $tst $judge "${metrics[*]}" $trainf
echo -e "DONE\nStarting training..."
sh $dir/scripts/train.sh $trainf $dir

# Remove temporary files 
rm -r tmp tmpf
