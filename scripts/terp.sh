ref=$1
tst=$2
blend_dir=$3
terp=$blend_dir/tools/terp.v1

#倒数第二列是结果;再取负值

#-TERbase
java -Dfile.encoder=UTF-8 -jar -Xmx1024M $terp/dist/lib/terp.jar -s -o nist -r $ref -h $tst $terp/data/ter.param >tmpf 
mv tst.seg.scr TERbase

#-TER
java -Dfile.encoder=UTF-8 -jar -Xmx1024M $terp/dist/lib/terp.jar -s -o nist -r $ref -h $tst >tmpf
mv tst.seg.scr TER

#-TERp (for toEnglish)
java -Dfile.encoder=UTF-8 -jar -Xmx1024M $terp/dist/lib/terp.jar -s -o nist -r $ref -h $tst -P $terp/data/phrases.db -d $blend_dir/tools/WordNet-3.0/dict >tmpf
mv tst.seg.scr TERp

#-TERp-A (for toEnglish)
java -Dfile.encoder=UTF-8 -jar -Xmx1024M $terp/dist/lib/terp.jar -s -o nist -r $ref -h $tst -P $terp/data/phrases.db -d $blend_dir/tools/WordNet-3.0/dict $terp/data/terpa.param >tmpf
mv tst.seg.scr TERp-A

python $blend_dir/scripts/form-terp-score.py scores/ $tst

rm TERbase TER TERp TERp-A tst.sys.scr tst.doc.scr tmpf
