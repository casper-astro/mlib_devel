Bit Reverser
=============
| **Block:** Bit reverser (``bit_reverse``)
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
Reverses the bit order of the input. Input must be unsigned with binary
point at position 0. Costs nothing in hardware.

Mask Parameters 
-----------------

+----------------+------------+-------------------------------------+
| Parameter      | Variable   | Description                         |
+================+============+=====================================+
| No. of bits.   | n\_bits    | Specifies the width of the input.   |
+----------------+------------+-------------------------------------+

Ports 
------

+--------+-------+--------------+---------------------+
| Port   | Dir   | Data Type    | Description         |
+========+=======+==============+=====================+
| in     | in    | UFix\_x\_0   | The input signal.   |
+--------+-------+--------------+---------------------+
| out    | out   | UFix\_x\_0   | The output.         |
+--------+-------+--------------+---------------------+

Description 
-------------
Reverses the bit order of the input. Input must be unsigned with binary
point at position 0. Costs nothing in hardware.