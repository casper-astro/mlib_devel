Edge Detect
============
| **Block:** The Edge Detect Block (``edge``)
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
Outputs true if a boolean input signal is not equal to its value during
the last clock.

Mask Parameters 
-----------------
None.

Ports 
-------

+--------+-------+-------------+----------------------------------------+
| Port   | Dir   | Data Type   | Description                            |
+========+=======+=============+========================================+
| in     | in    | Boolean     | Input boolean signal.                  |
+--------+-------+-------------+----------------------------------------+
| out    | out   | Boolean     | Edge detected output boolean signal.   |
+--------+-------+-------------+----------------------------------------+

Description 
------------
Outputs true if a boolean input signal is not equal to its value during
the last clock.