Correlation Control Block
==========================
| **Block:** Correlation Control Block (``CCB``)
| **Block Author**: Kaushal D. Buch, GMRT, India
| **Document Author**: Kaushal D. Buch, GMRT, India

+--------------------------------------------------------------------------+
| .. raw:: html                                                            |
|                                                                          |
|    <div id="toctitle">                                                   |
|                                                                          |
| .. rubric:: Contents                                                     |
|    :name: contents                                                       |
|                                                                          |
| .. raw:: html                                                            |
|                                                                          |
|    </div>                                                                |
|                                                                          |
| -  `Summary <#summary>`__                                                |
| -  `Ports <#ports>`__                                                    |
| -  `Description <#description>`__                                        |
| -  `Test Results <#test-results>`__                                      |
+--------------------------------------------------------------------------+

Summary 
---------
Correlation control block takes a pair of uncorrelated digital noise
sources in the input and generates a pair of output noise with
correlation. The amount of correlation can be selected from a set of
pre-defined values. This block is an extension to the `Gaussian Random
Number <Gaussian_Random_Number_Gen.html>`__ block in the CASPER library.

Ports 
-------

+--------------------+--------------------+--------------------+---------------------------------------+
| Port               | Dir                | Data Type          | Description                           |
+====================+====================+====================+=======================================+
| noise\_in1 to      | IN                 | 8-bit signed       | Four uncorrelated streams from the    |
| noise\_in4         |                    |                    | output of the Gaussian Random         |
|                    |                    |                    | Number Generator.                     |
+--------------------+--------------------+--------------------+---------------------------------------+
| noise\_in5 to      | IN                 | 8-bit signed       | Four uncorrelated streams from the    |
| noise\_in8         |                    |                    | output of the Gaussian Random         |
|                    |                    |                    | Number Generator.                     |
+--------------------+--------------------+--------------------+---------------------------------------+
| corr\_sel\_in      | IN                 | 3-bit unsigned     | Selection of the amount of correlation|
|                    |                    |                    | coefficient at the output.            |
|                    |                    |                    | ::                                    |
|                    |                    |                    | Selection -                           |
|                    |                    |                    | 0 - uncorrelated (~0%)                |
|                    |                    |                    | 1 - 5% correlation                    |
|                    |                    |                    | 2 - 10% correlation                   |
|                    |                    |                    | 3 - 20% correlation                   |
|                    |                    |                    | 4 - 50% correlation                   |
|                    |                    |                    | 5 - 100% correlation                  |
+--------------------+--------------------+--------------------+---------------------------------------+
| corr\_noise\_out1  | OUT                | 8-bit signed       | Four streams of output digital noise. |
| to                 |                    | (Fix8\_7)          |                                       |
| corr\_noise\_out4  |                    |                    |                                       |
+--------------------+--------------------+--------------------+---------------------------------------+
| corr\_noise\_out5  | OUT                | 8-bit signed       | Four streams of output digital noise. |
| to                 |                    | (Fix8\_7)          |                                       |
| corr\_noise\_out8  |                    |                    |                                       |
+--------------------+--------------------+--------------------+---------------------------------------+

Description 
-------------
Correlation Control Block (CCB) is an extension to the existing library
block called Gaussian Random Number Generator (GRNG). CCB can be used
along with GRNG block to get variable correlation between two input
noise channels.

The correlation control block uses an uncorrelated noise source whose
coupling to the two input channels is varied to control the correlation.
By varying the ratio of the variance of common noise source (Pc) to the
variance of input channels (P1 and P2) we get the correlation
coefficient as Pc / (P+Pc) (Note: We assume that P1 = P2 = P, i.e.
components from input channels have same variance).

Currently, there is a facility to select the following values of
correlation through software register - 0% (uncorrelated), 5%, 10%, 20%,
50% and 100% (correlated).

Test Results 
--------------
The variable correlation digital noise source design was tested with the
GRNG for a 300MHz BW PoCo with 0.89s integration on ROACH.