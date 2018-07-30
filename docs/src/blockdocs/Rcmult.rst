RC Multiplier
==============
| **Block:** RC Multiplier (``rcmult``)
| **Block Author**: Aaron Parsons
| **Document Author**: Ben Blackman

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
|                                                                          |
|    -  `Usage <#usage>`__                                                 |
+--------------------------------------------------------------------------+

Summary 
--------
Takes an input and sine and cosine value and gives out both real and
imaginary outputs.

Mask Parameters 
----------------

+-------------+------------+---------------------------------------------------------------+
| Parameter   | Variable   | Description                                                   |
+=============+============+===============================================================+
| Latency     | latency    | The latency of the multipliers and of the ``rcmult`` block.   |
+-------------+------------+---------------------------------------------------------------+

Ports 
------

+--------+-------+-------------+-----------------------------------------------------------------------------+
| Port   | Dir   | Data Type   | Description                                                                 |
+========+=======+=============+=============================================================================+
| d      | IN    | Inherited   | The input to be multiplied by sine and cosine values.                       |
+--------+-------+-------------+-----------------------------------------------------------------------------+
| sin    | IN    | Inherited   | The sine value used to multiply ``d`` and generate the ``imag`` output.     |
+--------+-------+-------------+-----------------------------------------------------------------------------+
| cos    | IN    | Inherited   | The cosine value used to multiply ``d`` and generate the ``real`` output.   |
+--------+-------+-------------+-----------------------------------------------------------------------------+
| real   | OUT   | Inherited   | The result of multiplying ``d`` with ``cos``.                               |
+--------+-------+-------------+-----------------------------------------------------------------------------+
| imag   | OUT   | Inherited   | The result of multiplying ``d`` with ``sin``.                               |
+--------+-------+-------------+-----------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
This ``rcmult`` block takes an input value, ``d``, and computes the real
and imaginary components by multiplying by the ``cos`` and ``sin``,
respectively. The block has a delay of ``latency`` associated with it.