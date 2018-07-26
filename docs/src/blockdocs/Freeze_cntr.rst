Freeze Counter Block
=====================
| **Block:** Freeze Counter Block (``freeze_cntr``)
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
A freeze counter is an enabled counter which holds its final value
(regardless of enables) until it is reset.

Mask Parameters 
----------------

+------------------------------+---------------+--------------------------------------------------------------------------------------+
| Parameter                    | Variable      | Description                                                                          |
+==============================+===============+======================================================================================+
| Counter Length (2\ :sup:`?`) | CounterBits   | Specifies the number of bits (and the final count output of 2\ :sup:`bits − 1`).     |
+------------------------------+---------------+--------------------------------------------------------------------------------------+

Ports 
-------

+--------+-------+-------------+-----------------------------------------------------------------------------------+
| Port   | Dir   | Data Type   | Description                                                                       |
+========+=======+=============+===================================================================================+
| en     | in    |  ???        | Step the counter by 1 unless addr=2\ :sup:`bits − 1`.                             |
+--------+-------+-------------+-----------------------------------------------------------------------------------+
| rst    | in    |  ???        | Reset counter to 0.                                                               |
+--------+-------+-------------+-----------------------------------------------------------------------------------+
| addr   | out   |  ???        | Current output of the counter.                                                    |
+--------+-------+-------------+-----------------------------------------------------------------------------------+
| we     | out   | Boolean     | Outputs boolean true just before addr is incremented.                             |
+--------+-------+-------------+-----------------------------------------------------------------------------------+
| done   | out   | Boolean     | Outputs boolean true when a final en is asserted and addr=2\ :sup:`bits − 1`.     |
+--------+-------+-------------+-----------------------------------------------------------------------------------+

Description 
-------------
A freeze counter is an enabled counter which holds its final value
(regardless of enables) until it is reset. Thus, a 2\ :sup:`5` freeze
counter will count from 0 to 31 on 31 enables, but will hold 31
thereafter until a reset occurs. This block is useful for writing data
in a single pass to memory without looping.