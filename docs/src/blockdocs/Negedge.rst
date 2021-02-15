Negative Edge Detect
=====================
| **Block:** Negative Edge Detect Block (``negedge``)
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
Outputs true if a boolean input signal is currently false, but was true
during the last clock.

Mask Parameters 
----------------
None.

Ports 
------

+--------+-------+-------------+-------------------------------------------------+
| Port   | Dir   | Data Type   | Description                                     |
+========+=======+=============+=================================================+
| in     | in    | Boolean     | Input boolean signal.                           |
+--------+-------+-------------+-------------------------------------------------+
| out    | out   | Boolean     | Negative-edge detected output boolean signal.   |
+--------+-------+-------------+-------------------------------------------------+

Description 
------------
Outputs true if a boolean input signal is currently false, but was true
during the last clock.