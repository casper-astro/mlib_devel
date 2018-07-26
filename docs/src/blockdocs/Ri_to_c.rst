Real-Imag to Complex
=====================
| **Block:** Real-Imag to Complex Block (``ri_to_c``)
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
Concatenates real and imaginary inputs into a complex output. Useful for
simplifying interconnects. See also `c\_to\_ri <C_to_ri.html>`__.

Mask Parameters 
-----------------
None.

Ports 
------

+--------+-------+--------------+-----------------------------------------------------------------+
| Port   | Dir   | Data Type    | Description                                                     |
+========+=======+==============+=================================================================+
| r      | in    | Fix\_x\_y    | Real data                                                       |
+--------+-------+--------------+-----------------------------------------------------------------+
| i      | in    | Fix\_x\_y    | Imaginary signed output, binary point specified by parameter.   |
+--------+-------+--------------+-----------------------------------------------------------------+
| c      | out   | UFix\_x\_0   | Complex input, real in MSB, imaginary in LSB.                   |
+--------+-------+--------------+-----------------------------------------------------------------+

Description 
------------
Conveniently combines real and imaginary components of a number into a
single wire. See also `c\_to\_ri <C_to_ri.html>`__.