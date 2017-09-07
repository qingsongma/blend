#---mt-system---
cwd=$(pwd)
cd $cwd/data/da-wmt15
cat cs-en/newstest2015.mt-system.cs-en de-en/newstest2015.mt-system.de-en fi-en/newstest2015.mt-system.fi-en ru-en/newstest2015.mt-system.ru-en >../tmp

cd $cwd/data/da-wmt16
cat ../tmp cs-en/DAseg-newstest2016.mt-system.cs-en de-en/DAseg-newstest2016.mt-system.de-en fi-en/DAseg-newstest2016.mt-system.fi-en ro-en/DAseg-newstest2016.mt-system.ro-en ru-en/DAseg-newstest2016.mt-system.ru-en tr-en/DAseg-newstest2016.mt-system.tr-en > $cwd/../train.mt-system.toen

cd $cwd
rm data/tmp 

#---reference---
cd $cwd/data/da-wmt15
cat cs-en/newstest2015.reference.cs-en de-en/newstest2015.reference.de-en fi-en/newstest2015.reference.fi-en ru-en/newstest2015.reference.ru-en >../tmp

cd $cwd/data/da-wmt16
cat ../tmp cs-en/DAseg-newstest2016.reference.cs-en de-en/DAseg-newstest2016.reference.de-en fi-en/DAseg-newstest2016.reference.fi-en ro-en/DAseg-newstest2016.reference.ro-en ru-en/DAseg-newstest2016.reference.ru-en tr-en/DAseg-newstest2016.reference.tr-en > $cwd/../train.reference.toen

cd $cwd
rm data/tmp 

#---human---
cd $cwd/data/da-wmt15
cat cs-en/newstest2015.human.cs-en de-en/newstest2015.human.de-en fi-en/newstest2015.human.fi-en ru-en/newstest2015.human.ru-en >../tmp

cd $cwd/data/da-wmt16
cat ../tmp cs-en/DAseg-newstest2016.human.cs-en de-en/DAseg-newstest2016.human.de-en fi-en/DAseg-newstest2016.human.fi-en ro-en/DAseg-newstest2016.human.ro-en ru-en/DAseg-newstest2016.human.ru-en tr-en/DAseg-newstest2016.human.tr-en > $cwd/../train.human.toen

cd $cwd
rm data/tmp 

#---src---
cd $cwd/data/da-wmt15
cat cs-en/newstest2015.source.cs-en de-en/newstest2015.source.de-en fi-en/newstest2015.source.fi-en ru-en/newstest2015.source.ru-en >../tmp

cd $cwd/data/da-wmt16
cat ../tmp cs-en/DAseg-newstest2016.source.cs-en de-en/DAseg-newstest2016.source.de-en fi-en/DAseg-newstest2016.source.fi-en ro-en/DAseg-newstest2016.source.ro-en ru-en/DAseg-newstest2016.source.ru-en tr-en/DAseg-newstest2016.source.tr-en > $cwd/../train.source.toen
cd $cwd
rm data/tmp


