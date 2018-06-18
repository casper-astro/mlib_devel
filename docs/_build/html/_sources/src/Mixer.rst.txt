Mixer
======
| **Block:** Mixer (``mixer``)
| **Block Author**: Aaron Parsons
| **Document Author**: Aaron Parsons, Ben Blackman

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
| -  `Mask Parameters <#mask-parameters>`__                                |
| -  `Ports <#ports>`__                                                    |
| -  `Description <#description>`__                                        |
|                                                                          |
|    -  `Usage <#usage>`__                                                 |
+--------------------------------------------------------------------------+

Summary 
--------
Digitally mixes an input signal (which can be several samples in
parallel) with an LO of the indicated frequency (which is some fraction
of the native FPGA clock rate).

Mask Parameters 
-----------------

+------------------------------+-----------------+---------------------------------------------------------+
| Parameter                    | Variable        | Description                                             |
+==============================+=================+=========================================================+
| Frequency Divisions          | freq\_div       | The (power of 2) denominator of the mixing frequency.   |
+------------------------------+-----------------+---------------------------------------------------------+
| Mixing Frequency             | freq            | The numerator of the mixing frequency.                  |
+------------------------------+-----------------+---------------------------------------------------------+
| Number of Parallel Streams   | nstreams        | The number of samples that arrive in parallel.          |
+------------------------------+-----------------+---------------------------------------------------------+
| Bit Width                    | n\_bits         | The bitwidth of LO samples.                             |
+------------------------------+-----------------+---------------------------------------------------------+
| BRAM Latency                 | bram\_latency   | The latency of sin/cos lookup table.                    |
+------------------------------+-----------------+---------------------------------------------------------+
| MULT Latency                 | mult\_latency   | The latency of mixing multipliers.                      |
+------------------------------+-----------------+---------------------------------------------------------+

Ports 
------

+-------------+-------+-------------------------------+---------------------------------------------------------------------------+
| Port        | Dir   | Data Type                     | Description                                                               |
+=============+=======+===============================+===========================================================================+
| sync        | IN    | boolean                       | Takes in an impulse the cycle before the ``din``\ s are valid.            |
+-------------+-------+-------------------------------+---------------------------------------------------------------------------+
| dinX        | IN    | Fix\_8\_7                     | Input X to be mixed and output on ``realX`` and ``imagX``.                |
+-------------+-------+-------------------------------+---------------------------------------------------------------------------+
| sync\_out   | OUT   | boolean                       | This signal will be high the cycle before the data coming out is valid.   |
+-------------+-------+-------------------------------+---------------------------------------------------------------------------+
| realX       | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | Real output of mixed ``dinX``.                                            |
+-------------+-------+-------------------------------+---------------------------------------------------------------------------+
| imagX       | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | Imaginary output of mixed ``dinX``.                                       |
+-------------+-------+-------------------------------+---------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
``Mixer`` mixes the incoming data and produces both real and imaginary
outputs.

| *M* = Frequency Divisions
| *F* = Mixing Frequency

M and F must both be integers, and M must be a power of 2. The ratio F/M
should equal the ratio f/r where r is the data rate of the sampled
signal. For example, an F/M of 3/16 would downmix an 800Msps signal with
an LO of 150MHz.