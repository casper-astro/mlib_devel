Pulse Extender
===============
| **Block:** Pulse Extender Block (``pulse_ext``)
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
Extends a boolean signal to be high for the specified number of clocks
after the last high input.

Mask Parameters 
----------------

+-------------------+--------------+-------------------------------------------------------------------------------------------+
| Parameter         | Variable     | Description                                                                               |
+===================+==============+===========================================================================================+
| Length of Pulse   | pulse\_len   | Specifies number of clocks after the last high input for which the output is held high.   |
+-------------------+--------------+-------------------------------------------------------------------------------------------+

Ports 
------

+--------+-------+-------------+----------------------------------+
| Port   | Dir   | Data Type   | Description                      |
+========+=======+=============+==================================+
| in     | in    | Boolean     | Input boolean signal.            |
+--------+-------+-------------+----------------------------------+
| out    | out   | Boolean     | Pulse-extended boolean signal.   |
+--------+-------+-------------+----------------------------------+

Description 
------------
Extends a boolean signal to be high for the specified number of clocks
after the last high input. If a new in pulse (input high) occurs, the
counter determining the output pulse length is reset.