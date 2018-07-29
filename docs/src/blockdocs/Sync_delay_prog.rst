Programmable Sync Delay
========================
| **Block:** Programmable Sync Delay (``sync_delay_prog``)
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
Delay an infrequent boolean pulse by a run-time programmable number of
enabled clocks. If the input pulse repeats before the output pulse is
generated, an internal counter resets and that output pulse is never
generated. When delay is changed, some randomly determined samples will
be inserted/dropped from the buffered stream.

Mask Parameters 
----------------

+---------------------------+------------+------------------------------------+
| Parameter                 | Variable   | Description                        |
+===========================+============+====================================+
| Max Delay (2\ :sup:`?`)   | MaxDelay   | The maximum length of the delay.   |
+---------------------------+------------+------------------------------------+

Ports 
------

+-------------+-------+-------------+-------------------------------------------+
| Port        | Dir   | Data Type   | Description                               |
+=============+=======+=============+===========================================+
| sync        | in    |  ???        | The boolean signal to be delayed.         |
+-------------+-------+-------------+-------------------------------------------+
| delay       | in    |  ???        | The run-time programmable delay length.   |
+-------------+-------+-------------+-------------------------------------------+
| sync\_out   | out   |  ???        | The delayed boolean signal.               |
+-------------+-------+-------------+-------------------------------------------+

Description 
------------
Delay an infrequent boolean pulse by a run-time programmable number of
enabled clocks. If the input pulse repeats before the output pulse is
generated, an internal counter resets and that output pulse is never
generated. When delay is changed, some randomly determined samples will
be inserted/dropped from the buffered stream.