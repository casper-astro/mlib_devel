Square Transposer
==================
| **Block:** Square Transposer (``square_transposer``)
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
Presents a number of parallel inputs serially on the same number of
output lines.

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
-------------
(Out1, Out2, etc.) appear aligned:

+-------+-------+-------+------+------+--------------+-------+-------+-------+-------+--------+
| In1   | d12   | d8    | d4   | d0   | |rightarrow| | d3    | d2    | d1    | d0    | Out1   |
+-------+-------+-------+------+------+--------------+-------+-------+-------+-------+--------+
| In2   | d13   | d9    | d5   | d1   | |rightarrow| | d7    | d6    | d5    | d4    | Out2   |
+-------+-------+-------+------+------+--------------+-------+-------+-------+-------+--------+
| In3   | d14   | d10   | d6   | d2   | |rightarrow| | d11   | d10   | d9    | d8    | Out3   |
+-------+-------+-------+------+------+--------------+-------+-------+-------+-------+--------+
| In4   | d15   | d11   | d7   | d3   | |rightarrow| | d15   | d14   | d13   | d12   | Out4   |
+-------+-------+-------+------+------+--------------+-------+-------+-------+-------+--------+

.. |rightarrow| image:: ../../_static/img/rightarrow.png
   :class: tex