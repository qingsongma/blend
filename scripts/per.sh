ref=$1
tst=$2
blend_dir=$3

perl $blend_dir/tools/per/PER.pl -s -t $tst -r $ref >PER
sed -i '$d' PER
sed -i 's/LINE .* /-/g' PER
mv PER scores/${tst#*/}.nPER
