Local Oscillator
=================
| **Block:** Local Oscillator (``lo_osc``)
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
--------
Generates an oscillating sine and cosine.

Mask Parameters 
----------------

+-----------------------+------------------+------------------------------------------+
| Parameter             | Variable         | Description                              |
+=======================+==================+==========================================+
| Output Bitwidth       | n\_bits          | Bitwidth of the outputs.                 |
+-----------------------+------------------+------------------------------------------+
| Counter Step          | counter\_step    | Step size of the internal counter.       |
+-----------------------+------------------+------------------------------------------+
| Counter Start Value   | counter\_start   | Initial value of the internal counter.   |
+-----------------------+------------------+------------------------------------------+
| Counter Bitwidth      | counter\_width   | Bitwidth of the internal counter.        |
+-----------------------+------------------+------------------------------------------+
| Latency               | latency          | The latency of the block.                |
+-----------------------+------------------+------------------------------------------+

Ports 
------

+--------+-------+-------------------------------+---------------------------------------------------------------+
| Port   | Dir   | Data Type                     | Description                                                   |
+========+=======+===============================+===============================================================+
| sin    | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | Sine of the current phase, which is given by the counter.     |
+--------+-------+-------------------------------+---------------------------------------------------------------+
| cos    | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | Cosine of the current phase, which is given by the counter.   |
+--------+-------+-------------------------------+---------------------------------------------------------------+

Description 
-------------
Usage 
^^^^^^
This block generates the sine and cosine of an oscillator with
user-defined spacing (based on ``counter_step`` and ``counter_width``)
and bitwidth.