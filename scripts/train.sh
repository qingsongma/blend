trainFeat=$1
blend_dir=$2

$blend_dir/tools/libsvm-3.22/svm-scale -l -1 -u 1 -s $trainFeat.range $trainFeat >$trainFeat.scale
$blend_dir/tools/libsvm-3.22/svm-train -s 3  $trainFeat.scale

