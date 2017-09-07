ref=$1
tst=$2
blend_dir=$3

perl $blend_dir/tools/wer/WER.pl -s -t $tst -r $ref >WER
sed -i '$d' WER
cp WER nWER
sed -i 's/LINE .* /-/g' nWER
sed -i 's/LINE .* //g' WER
mv WER scores/${tst#*/}.WER
mv nWER scores/${tst#*/}.nWER
