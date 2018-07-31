Enabled Sync Delay
===================
| **Block:** Enabled Sync Delay (``sync_delay_en``)
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
Delay an infrequent boolean pulse by the specified number of enabled
clocks.

Mask Parameters 
-----------------

+----------------+------------+----------------------------+
| Parameter      | Variable   | Description                |
+================+============+============================+
| Delay Length   | DelayLen   | The length of the delay.   |
+----------------+------------+----------------------------+

Ports 
------

+--------+-------+-------------+--------------------------------------------------------+
| Port   | Dir   | Data Type   | Description                                            |
+========+=======+=============+========================================================+
| in     | in    | boolean     | The boolean signal to be delayed.                      |
+--------+-------+-------------+--------------------------------------------------------+
| en     | in    | boolean     | To be asserted when input is valid.                    |
+--------+-------+-------------+--------------------------------------------------------+
| out    | out   | boolean     | The delayed boolean signal, output 1 clock after en.   |
+--------+-------+-------------+--------------------------------------------------------+

Description 
------------
Delay an infrequent boolean pulse by the specified number of enabled
clocks. If the input pulse repeats before the output pulse is generated,
an internal counter resets and that output pulse is never generated.