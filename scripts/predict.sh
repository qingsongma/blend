trainFeat=$1
testFeat=$2
blend_dir=$3

$blend_dir/tools/libsvm-3.22/svm-scale -r $trainFeat.range $testFeat > $testFeat.scale
$blend_dir/tools/libsvm-3.22/svm-predict $testFeat.scale ${trainFeat#*/}.scale.model ${testFeat#*/}.blend
