ref=$1
tst=$2
blend_dir=$3

tstname=${tst#*/}

$blend_dir/tools/beer_2.0/beer -s $tst -r $ref --printSentScores >scores/$tstname.BEER
sed -i '/total BEER.*/d' scores/$tstname.BEER
sed -i 's/sent .*.* score is //g' scores/$tstname.BEER

