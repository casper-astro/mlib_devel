Programmable Delay in BRAM
============================
| **Block:** The Programmable Delay in BRAM Block (``delay_bram_prog``)
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
--------
A delay block that uses BRAM for its storage and has a run-time
programmable delay. When delay is changed, some randomly determined
samples will be inserted/dropped from the buffered stream.

Mask Parameters 
----------------

+-------------------------+-----------------+---------------------------------------------------------+
| Parameter               | Variable        | Description                                             |
+=========================+=================+=========================================================+
| Max Delay (2\ :sup:`?`) | MaxDelay        | The maximum length of the delay (i.e. the BRAM Size).   |
+-------------------------+-----------------+---------------------------------------------------------+
| BRAM Latency            | bram\_latency   | The latency of the underlying storage BRAM.             |
+-------------------------+-----------------+---------------------------------------------------------+

Ports 
-------

+---------+-------+-------------+-------------------------------------------+
| Port    | Dir   | Data Type   | Description                               |
+=========+=======+=============+===========================================+
| din     | in    |  ???        | The signal to be delayed.                 |
+---------+-------+-------------+-------------------------------------------+
| delay   | in    |  ???        | The run-time programmable delay length.   |
+---------+-------+-------------+-------------------------------------------+
| dout    | in    |  ???        | The delayed signal.                       |
+---------+-------+-------------+-------------------------------------------+

Description 
------------
A delay block that uses BRAM for its storage and has a run-time
programmable delay. When delay is changed, some randomly determined
samples will be inserted/dropped from the buffered stream.