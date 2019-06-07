Delay in BRAM
==============
| **Block:** The Delay in BRAM Block (``delay_bram``)
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
A delay block that uses BRAM for its storage.

Mask Parameters 
-----------------

+----------------+-----------------+-----------------------------------------------+
| Parameter      | Variable        | Description                                   |
+================+=================+===============================================+
| Delay Length   | DelayLen        | The length of the delay.                      |
+----------------+-----------------+-----------------------------------------------+
| BRAM Latency   | bram\_latency   | The latency of the underlying storage BRAM.   |
+----------------+-----------------+-----------------------------------------------+

Ports 
------

+--------+-------+-------------+-----------------------------+
| Port   | Dir   | Data Type   | Description                 |
+========+=======+=============+=============================+
| in     | in    |  ???        | The signal to be delayed.   |
+--------+-------+-------------+-----------------------------+
| out    | out   |  ???        | The delayed signal.         |
+--------+-------+-------------+-----------------------------+

Description 
-------------
A delay block that uses BRAM for its storage.