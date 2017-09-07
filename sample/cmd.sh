# For training
./run-train.sh train.source.toen train.reference.toen train.mt-system.toen train.human.toen ru en
# 'src=ru' is randomly set, since metrics dont's use source segments actually 

# For testing
./run-test.sh newstest2017-ruen-src.ru newstest2017-ruen-ref.en newstest2017.uedin-nmt.4890.ru-en ru en

