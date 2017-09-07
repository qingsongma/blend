#!/bin/sh

ref_path=$1
tst_path=$2
tlan=$3
dir=$4 # blend_dir
tmp='tmp'

cwd=$(pwd)
tmp=$cwd/tmp
tst=${tst_path#*/}
ref=${ref_path#*/}
arg="0.85"

# --tag hyps--
cd $dir/tools/dpmf/tools/stanford-postagger-2013-04-04
python addStartTag.py $cwd/$tst_path >$tst.s
java -mx2000m -classpath stanford-postagger.jar edu.stanford.nlp.tagger.maxent.MaxentTagger -model models/wsj-0-18-bidirectional-nodistsim.tagger -textFile $tst.s > $tst.s.tag
python reback.py $tst.s.tag > $tmp/$tst.s.tag.line
rm $tst.s $tst.s.tag

# --tag ref--
python addStartTag.py $cwd/$ref_path > $ref.s
java -mx2000m -classpath stanford-postagger.jar edu.stanford.nlp.tagger.maxent.MaxentTagger -model models/wsj-0-18-bidirectional-nodistsim.tagger -textFile $ref.s >$ref.s.tag
python reback.py $ref.s.tag >$tmp/$ref.s.tag.line
python rmPOS.py $tmp/$ref.s.tag.line $tmp/$ref.s.tag.line-rmPOS
rm $ref.s $ref.s.tag 

# --model ref--
cd $dir/tools/dpmf/tools/stanford-parser-full-2013-11-12
./lexparser-test.sh $tmp/$ref.s.tag.line-rmPOS >$tmp/$ref.s.tag.line-rmPOS.stfdeptree
cd $cwd/
python $dir/tools/dpmf/scripts/stfdeptree2form.py $tmp/$ref.s.tag.line-rmPOS.stfdeptree >$tmp/$ref.s.tag.line-rmPOS.stfdeptree-form
$dir/tools/dpmf/tools/conlltreeform/modiPOS/a.out $tmp/$ref.s.tag.line-rmPOS.stfdeptree-form $tmp/$ref.s.tag.line >$tmp/$ref.stfdeptree
rm $tmp/$ref.s.tag.line-rmPOS $tmp/$ref.s.tag.line-rmPOS.stfdeptree $tmp/$ref.s.tag.line-rmPOS.stfdeptree-form

#--------model-ref-----------------
# split deptree
mkdir $tmp/ref_sent  $tmp/ref_feat $tmp/ref_model $tmp/reftag.sent
cd $tmp/ref_sent/
ln -s $tmp/$ref.stfdeptree $tmp/ref_sent
split -l 1 -a 4 -d $tmp/$ref.stfdeptree
ls x* >file_ref.sent
while read -r line
    do
    $dir/tools/dpmf/tools/beam_sr_trainer $line 1 >$tmp/ref_feat/$line.feat
    $dir/tools/dpmf/tools/maxent -i 100 -g 1.0 -v -m $tmp/ref_model/$line.model $tmp/ref_feat/$line.feat
done < file_ref.sent
rm -r $tmp/ref_feat

cd $tmp/reftag.sent
ln -s $tmp/$ref.s.tag.line $tmp/reftag.sent
split -l 1 -a 4 -d $ref.s.tag.line
ls x* >file_refsent

ntst=$tmp/$tst.s.tag.line
while read liner<&3 && read hsent<&4 && read rsent<&5
    do
        echo $hsent >temp_hyp
        $dir/tools/dpmf/tools/shift_reduce $tmp/ref_model/$liner.model 50 temp_hyp temp.tree temp.score $tmp/reftag.sent/$rsent 1
        tail -1 temp.score >>$tst.score
    done 3< $tmp/ref_sent/file_ref.sent 4<$ntst 5< $tmp/reftag.sent/file_refsent
mv $tst.score $cwd/DPM

#cd $dir/tools/dpmf/tools/meteor-1.5
cd $dir/tools/meteor-1.5
java -Xmx2g -jar meteor-*.jar $cwd/$tst_path $cwd/$ref_path -l $tlan -m 'exact stem synonym paraphrase' -norm -vOut >$tmp/$tst.meteor-essp
cd $cwd
python $dir/tools/dpmf/scripts/meteorForm-recall.py $tmp/$tst.meteor-essp > RECALL
python $dir/tools/dpmf/scripts/meteorForm-precision.py $tmp/$tst.meteor-essp > PRECI

python $dir/tools/dpmf/scripts/probPreciRecall.py DPM PRECI RECALL $arg >scores/$tst.DPMF
rm DPM PRECI RECALL
rm -r tmp/*
