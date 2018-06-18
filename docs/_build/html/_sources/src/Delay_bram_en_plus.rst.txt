Enabled Delay in BRAM
=======================
| **Block:** The Enabled Delay in BRAM Block (``delay_bram_en_plus``)
| **Block Author**: Aaron Parsons
| **Document Author**: Aaron Parsons

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
+--------------------------------------------------------------------------+

Summary 
---------
A delay block that uses BRAM for its storage and only shifts when
enabled. However, BRAM latency cannot be enabled, so output appears
bram\_latency clocks after an enable.

Mask Parameters 
-----------------

+--------------------------------------------+-----------------+-----------------------------------------------+
| Parameter                                  | Variable        | Description                                   |
+============================================+=================+===============================================+
| Enabled Delays                             | DelayLen        | The length of the delay.                      |
+--------------------------------------------+-----------------+-----------------------------------------------+
| Extra (unenabled) delay for BRAM Latency   | bram\_latency   | The latency of the underlying storage BRAM.   |
+--------------------------------------------+-----------------+-----------------------------------------------+

Ports 
-------

+---------+-------+-------------+---------------------------------------+
| Port    | Dir   | Data Type   | Description                           |
+=========+=======+=============+=======================================+
| in      | in    |  ???        | The signal to be delayed.             |
+---------+-------+-------------+---------------------------------------+
| en      | in    |  ???        | To be asserted when input is valid.   |
+---------+-------+-------------+---------------------------------------+
| out     | out   |  ???        | The delayed signal.                   |
+---------+-------+-------------+---------------------------------------+
| valid   | out   |  ???        | Asserted when output is valid.        |
+---------+-------+-------------+---------------------------------------+

Description 
-------------
A delay block that uses BRAM for its storage and only shifts when
enabled. However, BRAM latency cannot be enabled, so output appears
bram\_latency clocks after an enable.