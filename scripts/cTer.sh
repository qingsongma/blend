ref=$1
tst=$2
blend_dir=$3
python_path=$4

tstname=${tst#*/}

$python_path $blend_dir/tools/characTER-master/CharacTER.py -r $ref -o $tst -v >scores/$tstname.cTER

