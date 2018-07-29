Barrel Switcher
================
| **Block:** Barrel Switcher (``barrel_switcher``)
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
Maps a number of inputs to a number of outputs by rotating In(N) to
Out(N+M) (where M is specified on the sel input), wrapping around to
Out1 when necessary.

Mask Parameters 
----------------

+--------------------+-------------+------------------------------------------------+
| Parameter          | Variable    | Description                                    |
+====================+=============+================================================+
| Number of inputs   | n\_inputs   | The number of parallel inputs (and outputs).   |
+--------------------+-------------+------------------------------------------------+

Ports 
------

+-------------+-------+-------------+-----------------------------------------------------------+
| Port        | Dir   | Data Type   | Description                                               |
+=============+=======+=============+===========================================================+
| sync        | in    | Boolean     | Indicates the next clock cycle contains valid data        |
+-------------+-------+-------------+-----------------------------------------------------------+
| In          | in    | Inherited   | The stream(s) to be transposed.                           |
+-------------+-------+-------------+-----------------------------------------------------------+
| sync\_out   | out   | Boolean     | Indicates that data out will be valid next clock cycle.   |
+-------------+-------+-------------+-----------------------------------------------------------+
| Out         | out   | Inherited   | The transposed stream(s).                                 |
+-------------+-------+-------------+-----------------------------------------------------------+

Description 
------------
Maps a number of inputs to a number of outputs by rotating In(N) to
Out(N+M) (where M is specified on the sel input), wrapping around to
Out1 when necessary.