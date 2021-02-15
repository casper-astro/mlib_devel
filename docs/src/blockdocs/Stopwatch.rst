Stopwatch
==========
| **Block:** Stopwatch (``stopwatch``)
| **Block Author**: Jason Manley
| **Document Author**: Jason Manley

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
Counts the number of clocks between a start and stop pulse.

Mask Parameters 
----------------
None.

Ports 
------

+--------------+-------+---------------+--------------------------------------------------------+
| Port         | Dir   | Data Type     | Description                                            |
+==============+=======+===============+========================================================+
| start        | in    | boolean       | Start counting                                         |
+--------------+-------+---------------+--------------------------------------------------------+
| stop         | in    | boolean       | Stop counting and hold value until reset received      |
+--------------+-------+---------------+--------------------------------------------------------+
| reset        | in    | boolean       | Reset back to zero.                                    |
+--------------+-------+---------------+--------------------------------------------------------+
| count\_out   | out   | ufix\_32\_0   | Number of clocks elapsed since start pulse received.   |
+--------------+-------+---------------+--------------------------------------------------------+

Description 
------------
This block counts the number of clocks between a start and stop pulse.
This value is held until a reset is received. If another start pulse is
received before the reset, counting resumes from where it left-off. If a
reset is received mid-way through a count (ie before a stop pulse) then
the stopwatch will be reset and await another start pulse before it
restarts counting.