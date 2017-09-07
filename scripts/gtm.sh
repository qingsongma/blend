ref=$1
tst=$2
blend_dir=$3

java -Dfile.encoding=UTF-8 -Xms1G -Xmx3G -jar $blend_dir/tools/gtm-1.4/gtm.jar +s +d -e 1 $ref $tst >$(pwd)/tmp/gtm1
java -Dfile.encoding=UTF-8 -Xms1G -Xmx3G -jar $blend_dir/tools/gtm-1.4/gtm.jar +s +d -e 2 $ref $tst >$(pwd)/tmp/gtm2
java -Dfile.encoding=UTF-8 -Xms1G -Xmx3G -jar $blend_dir/tools/gtm-1.4/gtm.jar +s +d -e 3 $ref $tst >$(pwd)/tmp/gtm3

python $blend_dir/scripts/form-gtm-score.py scores/ $tst

rm tmp/gtm*

