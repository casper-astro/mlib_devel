Positive Edge Detect
=====================
| **Block:** Positive Edge Detect Block (``posedge``)
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
Outputs true if a boolean input signal is true this clock and was false
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
| out    | out   | Boolean     | Positive-edge detected output boolean signal.   |
+--------+-------+-------------+-------------------------------------------------+

Description 
------------
Outputs true if a boolean input signal is true this clock and was false
during the last clock.