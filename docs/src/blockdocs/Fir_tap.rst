FIR Tap
========
| **Block:** FIR Tap (``fir_tap``)
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
---------
This block multiplies both inputs by ``factor`` and outputs the result
immediately after the multiply and outputs a delayed copy of the input
by 1 cycle,

Mask Parameters 
----------------

+----------------+------------+------------------------------------------+
| Parameter      | Variable   | Description                              |
+================+============+==========================================+
| Factor         | factor     | The value that multiplies both inputs.   |
+----------------+------------+------------------------------------------+
| Mult latency   | latency    | The latency of the multiplier.           |
+----------------+------------+------------------------------------------+

Ports 
------

+----------+-------+-------------+--------------------------------------------------------------------------------------------------------+
| Port     | Dir   | Data Type   | Description                                                                                            |
+==========+=======+=============+========================================================================================================+
| a        | IN    | Inherited   | The first number to be multiplied by ``factor``. It usually is the real component of an input.         |
+----------+-------+-------------+--------------------------------------------------------------------------------------------------------+
| b        | IN    | Inherited   | The second number to be multiplied by ``factor``. It usually is the imaginary component of an input.   |
+----------+-------+-------------+--------------------------------------------------------------------------------------------------------+
| a\_out   | OUT   | Inherited   | The input ``a`` delayed by 1 cycle.                                                                    |
+----------+-------+-------------+--------------------------------------------------------------------------------------------------------+
| b\_out   | OUT   | Inherited   | The input ``b`` delayed by 1 cycle.                                                                    |
+----------+-------+-------------+--------------------------------------------------------------------------------------------------------+
| real     | OUT   | Inherited   | The result of the multiplication of ``a`` with ``factor``.                                             |
+----------+-------+-------------+--------------------------------------------------------------------------------------------------------+
| imag     | OUT   | Inherited   | The result of the multiplication of ``b`` with ``factor``.                                             |
+----------+-------+-------------+--------------------------------------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
``a_out`` and ``b_out`` are 1 cycle delayed versions of ``a`` and ``b``,
respectively. ``real`` and ``imag`` are the results of ``a`` \*
``factor`` and ``b`` \* ``factor``, respectively. The delay from ``a``
to ``real`` or ``b`` to ``imag`` is equal to ``latency``.