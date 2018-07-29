Local Oscillator Constant
==========================
| **Block:** Local Oscillator Constant (``lo_const``)
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
Gives the sine and cosine of a desired constant phase.

Mask Parameters 
----------------

+----------------------+------------+----------------------------------------------------------------+
| Parameter            | Variable   | Description                                                    |
+======================+============+================================================================+
| Output Bitwidth      | n\_bits    | Bitwidth of the outputs.                                       |
+----------------------+------------+----------------------------------------------------------------+
| Phase (0 to 2\*pi)   | phase      | The phase value for which the sine and cosine are evaluated.   |
+----------------------+------------+----------------------------------------------------------------+

Ports 
------

+--------+-------+-------------------------------+----------------------------------------+
| Port   | Dir   | Data Type                     | Description                            |
+========+=======+===============================+========================================+
| sin    | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | The sine of the given phase value.     |
+--------+-------+-------------------------------+----------------------------------------+
| cos    | OUT   | Fix\_(n\_bits)\_(n\_bits-1)   | The cosine of the given phase value.   |
+--------+-------+-------------------------------+----------------------------------------+

Description 
------------
Usage 
^^^^^^
This block gives the sine and cosine of a user-specified, constant phase
value with a user-specified bitwidth.