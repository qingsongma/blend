TERp Phrase Table Version 0.1
Matthew Snover (snover@umiacs.umd.edu)
http://www.cs.umd.edu/~snover
2/2/09

This package contains the paraphrase phrasetable used by TERp in the
NIST Metrics MATR 2008 workshop.  This data is distributed under the
license in LICENSE.TXT.

The following files are contained in this distribution:
  * unfiltered_phrasetable.txt : This is the TERp phrase table, a
    plain text file containing paraphrases and their probabilities.

  * LICENSE.TXT : The license under which this data is distributed.

  * README.txt : This readme file.


Each line in the phrase table is formated as follows:

PROBABILITY <p>REF_PHRASE</p> <p>PARAPHRASE</p>

So for example, the following line from the phrase table:
0.575343 <p>13 buildings</p> <p>13 homes</p>
indicates that the phrase "13 buildings" is paraphrased to "13 homes" with probability 0.575343.

The paraphrases used in TERp are extracted using the pivot-based
method (Bannard and Callison-Burch, 2005) with several additional
filtering mechanisms to increase precision.  The corpus used for
extraction was an Arabic-English newswire bitext containing
approximately 1 million sentences.

Citation and description for TER-Plus and this paraphrase phrasetable:

Matthew Snover, Nitin Madnani, Bonnie Dorr, and Richard Schwartz,
"Fluency, Adequacy, or HTER? Exploring Different Human Judgments with
a Tunable MT Metric", Proceedings of the Fourth Workshop on
Statistical Machine Translation at the 12th Meeting of the European
Chapter of the Association for Computational Linguistics (EACL-2009),
Athens, Greece, March, 2009.





