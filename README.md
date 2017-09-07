Blend

-------------------------------------------------------------------------------------------------
Blend is a combined machine translation metric that achieves
high correlation with human evaluation both on system and segment
level. 

Blend can be flexible to incorporate any metrics and to be applied
to any language pairs. 

For more details, please see the paper:
"Blend: a Novel Combined MT Metric Based on Direct Assessment 
--- CASICT-DCU submission to WMT17 Metrics Task"

-------------------------------------------------------------------------------------------------
Environment Requirements


1. Linux

2. Python

3. Java

4. Perl

-------------------------------------------------------------------------------------------------
Installation

The installation commands on a Unix terminal are as follows:

1. tar zxvf blend.tar.gz

   Then there will be a directory `Blend`

2. cd /Blend/tools/terp.v1/ 

   Download the compressed paraphrase table (`unfiltered_phrasetable.txt.gz`) from https://github.com/snover/terp/releases to the `pt_en` directory and uncompress it. 

   bin/create_phrasedb pt_en/unfiltered_phrasetable.txt data/phrases.db

3. Download standford parser version Version 3.3.0 from https://nlp.stanford.edu/software/lex-parser.shtml#Download, put it at /Blend/tools/dpmf/tools, and unzip it, and then

   mv /Blend/tools/dpmf/tools/lexparser-test.sh /Blend/tools/dpmf/tools/stanford-parser-full-2013-11-12

-------------------------------------------------------------------------------------------------
File Overview

   /docs - This directory contains the reference of Blend.

   /models/   - This directory contains trained models that can be directly used.

   /README.md - This is the file you are reading.

   /samples/  - This directory contains a sample with the whole training and predicting processes.

   /scripts/  - This directory contains all scripts needed.

   /tools/    - This directory contains all incorporated metrics and other tools needed.

-------------------------------------------------------------------------------------------------
Usage


> ./run-train.sh src_file ref_file mt_file human_DA_file src_lan trg_lan

Train a model that can be used to compute the Blend scores of the test data.

src_lan can be randomly given since metrics actually do not use the source file.

> ./run-test.sh src ref mt src_lan trg_lan

Compute the Blend scores given to the MT file of the test data using the trained model.

Notice: The arrange of files needed to be the same as that of directory `samples`.


-------------------------------------------------------------------------------------------------
Author

Qingsong Ma

maqingsong@ict.ac.cn

Institue of Computing Technology,

University of Chinese Academy Sciences

