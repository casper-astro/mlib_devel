DDS
====
| **Block:** DDS (``dds``)
| **Block Author**: Aaron Parsons
| **Document Author**: Ben Blackman

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
---------
Generates sines and cosines of different phases and outputs them in
parallel.

Mask Parameters 
-----------------

+---------------------------------+-------------+-----------------------------------------+
| Parameter                       | Variable    | Description                             |
+=================================+=============+=========================================+
| Frequency Divisions (M)         | freq\_div   | Denominator of the frequency.           |
+---------------------------------+-------------+-----------------------------------------+
| Frequency (? /M \* $2$ \* pi)   | freq        | Numerator of the frequency.             |
+---------------------------------+-------------+-----------------------------------------+
| Parallel LOs                    | num\_lo     | Number of parallel local oscillators.   |
+---------------------------------+-------------+-----------------------------------------+
| Bit Width                       | n\_bits     | Bit width of the outputs.               |
+---------------------------------+-------------+-----------------------------------------+
| Latency                         | latency     | Description                             |
+---------------------------------+-------------+-----------------------------------------+

Ports 
-------

+--------+-------+-------------------------------+------------------------------------------------------------+
| Port   | Dir   | Data Type                     | Description                                                |
+========+=======+===============================+============================================================+
| sinX   | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | Sine output corresponding to the Xth local oscillator.     |
+--------+-------+-------------------------------+------------------------------------------------------------+
| cosX   | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | Cosine output corresponding to the Xth local oscillator.   |
+--------+-------+-------------------------------+------------------------------------------------------------+

Description 
-------------

Usage 
^^^^^^^
There are ``sin`` and ``cos`` outputs each equal to the minimum of
``num_lo`` and ``freq_div``. If ``num_lo`` > = ``freq_div``/``freq``,
then the outputs will be ``lo_const``\ s. Otherwise each output will
oscillate depending on the values of ``freq_div`` and ``freq``. If the
outputs oscillate, then there will be a latency of ``latency`` and
otherwise there will be zero latency.