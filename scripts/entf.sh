ref_path=$1
tst_path=$2
tlan=$3
blend_dir=$4

cwd=$(pwd)
tst=${tst_path#*/}
ref=${ref_path#*/}

#----------------Meteor Align-------------------
cd $blend_dir/tools/meteor-1.5
java -Xmx2G -jar meteor-*.jar $cwd/$tst_path $cwd/$ref_path -l $tlan -m 'exact stem synonym paraphrase' -norm -f $cwd/tmp/$tst.meteor-self -writeAlignments -vOut > $cwd/tmp/$tst.meteor
cd $cwd

#--------------ent------------------------
$blend_dir/tools/entf/ent -Align $cwd/tmp/$tst.meteor-self-align.out -FunList $blend_dir/tools/entf/english.words -Weight 1 0.6 0.8 0.6 -Params 0.85 0.25 1.0 1.2 >scores/$tst.ENTF
sed -i '$d' scores/$tst.ENTF
