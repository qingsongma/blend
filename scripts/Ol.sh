ref=$1
tst=$2
blend_dir=$3

perl $blend_dir/tools/Ol/Ol.pl -t $tst -r $ref >scores/${tst#*/}.Ol
