Delay in Slices
================
| **Block:** The Delay in Slices Block (``delay_slr``)
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
A delay block that uses slices (SLR16s) for its storage.

Mask Parameters 
-----------------

+----------------+------------+----------------------------+
| Parameter      | Variable   | Description                |
+================+============+============================+
| Delay Length   | DelayLen   | The length of the delay.   |
+----------------+------------+----------------------------+

Ports 
-------

+--------+-------+-------------+-----------------------------+
| Port   | Dir   | Data Type   | Description                 |
+========+=======+=============+=============================+
| in     | in    |  ???        | The signal to be delayed.   |
+--------+-------+-------------+-----------------------------+
| out    | out   |  ???        | The delayed signal.         |
+--------+-------+-------------+-----------------------------+

Description 
-------------
A delay block that uses slices (SLR16s) for its storage.