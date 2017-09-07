# exact:  en es de fr cz ar da nl fi hu it no pt ro ru sv tr
# stm:    en es de fr da nl fi hu it no pt ro ru sv tr
# para:   en es de fr cz ar 
# syn:    en

ref=$1
tst=$2
blend_dir=$3

# exact
java -Dfile.encoding=UTF-8 -XX:-UseGCOverheadLimit -Xmx1024M -jar $blend_dir/tools/meteor-1.4/meteor-1.4.jar $tst $ref -sgml -l en -m "exact" 
mv meteor-seg.scr meteor-ex

# stem
java -Dfile.encoding=UTF-8 -XX:-UseGCOverheadLimit -Xmx1024M -jar $blend_dir/tools/meteor-1.4/meteor-1.4.jar $tst $ref -sgml -l en -m "exact stem"
mv meteor-seg.scr meteor-st

# syn
java -Dfile.encoding=UTF-8 -XX:-UseGCOverheadLimit -Xmx1024M -jar $blend_dir/tools/meteor-1.4/meteor-1.4.jar $tst $ref -sgml -l en -m "exact stem synonym"
mv meteor-seg.scr meteor-sy

# para
java -Dfile.encoding=UTF-8 -XX:-UseGCOverheadLimit -Xmx1024M -jar $blend_dir/tools/meteor-1.4/meteor-1.4.jar $tst $ref -sgml -l en -m "exact stem paraphrase"
mv meteor-seg.scr meteor-pa

# para & cz|ar
#java -Dfile.encoding=UTF-8 -Xms1024M -Xmx1024M -jar ../meteor-1.4.jar ../../data/tst.sgm ../../data/ref.sgm -sgml -l en -m "exact paraphrase"

python $blend_dir/scripts/form-meteor-score.py scores/ $tst

rm meteor-sys.scr meteor-doc.scr meteor-ex meteor-st meteor-sy meteor-pa
