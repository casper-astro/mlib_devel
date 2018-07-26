Gaussian Random Number Generator
=================================
| **Block:** Gaussian Random Number Generator
  (``Gaussian Random Number Generator``)
| **Block Author**: Kaushal D. Buch
| **Document Author**: Kaushal D. Buch

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
This is a low foot-print Gaussian noise source for testing CASPER based
hardware designs during development. It contains a pair of uncorrelated
noise and each noise data is available as four parallel output streams,
which are directly compatible to the iADC outputs.

Ports 
------

+--------------------------------+-------+----------------+---------------------------------------------------------------------------------------------------------------------------------+
| Port                           | Dir   | Data Type      | Description                                                                                                                     |
+================================+=======+================+=================================================================================================================================+
| reset                          | IN    | boolean        | Reset signal to initialize the noise sources. Reset is synchronous active high signal.                                          |
+--------------------------------+-------+----------------+---------------------------------------------------------------------------------------------------------------------------------+
| Noise\_Out11 to Noise\_Out14   | OUT   | 8-bit signed   | Four uncorrelated streams of noise samples.                                                                                     |
+--------------------------------+-------+----------------+---------------------------------------------------------------------------------------------------------------------------------+
| Noise\_Out21 to Noise\_Out24   | OUT   | 8-bit signed   | Four uncorrelated streams of noise samples. These are also uncorrelated with respect to Noise\_Out11 to Noise\_Out14 signals.   |
+--------------------------------+-------+----------------+---------------------------------------------------------------------------------------------------------------------------------+

Description 
-------------
The noise source blocks do not use any specific resources like BRAMs,
multipliers etc. The Kurtosis value of these sources is around 2.9 to
2.93. Both of these sources can be used as individual noise source or
collectively as uncorrelated noise sources. The resource utilization is
around 2 to 3 % for a single noise source on Virtex-5 SX95 FPGA.

Note: The seeds of the individual noise sources can be changed. But the
seeds need to be mutually uncorrelated for a particular source i.e.
considering only one source say Noise Source -1 ,all the fourteen seeds
within that source have to mutually uncorrelated.

Test Results 
--------------
Test was carried out by integrating these uncorrelated sources with a
pocket correlator design running at 600MHz ADC clock and having 1 second
integration time, implemented on ROACH. The results show a flat spectrum
across all the FFT channels and a normalized cross-correlation of about
0.001.