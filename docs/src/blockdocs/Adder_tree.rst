Adder Tree
===========
| **Block:** Adder Tree (``adder_tree``)
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

Sums all inputs using a tree of adds and delays.

Mask Parameters 
----------------

+------------------+-------------+-----------------------------------------------------+
| Parameter        | Variable    | Description                                         |
+==================+=============+=====================================================+
| No. of inputs.   | n\_inputs   | The number of inputs to be summed.                  |
+------------------+-------------+-----------------------------------------------------+
| Add Latency      | latency     | The latency of each stage through the adder tree.   |
+------------------+-------------+-----------------------------------------------------+

Ports 
------

+--------+-------+-------------+--------------------------------------------------------+
| Port   | Dir   | Data Type   | Description                                            |
+========+=======+=============+========================================================+
| sync   | in    | Boolean     | Indicates the next clock cycle containing valid data   |
+--------+-------+-------------+--------------------------------------------------------+
| din    | in    | Inherited   | A number to be summed.                                 |
+--------+-------+-------------+--------------------------------------------------------+

Description 
-------------
Sums all inputs using a tree of adds and delays. Total latency is
*ceil*\ (*log*\ :sub:`2`\ (*n*\ :sub:`i`\ *nputs*)) \* *latency*.