Complex Delay
==============
| **Block:** Complex Delay (``delay_complex``)
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
A delay block that treats its input as complex, splits it into real and
imaginary components, delays each component by a specified amount, and
then re-joins them into a complex output. The underlying storage is
user-selectable (either BRAM or SLR16 elements). The reason for this is
wide (36 bit) delays make adjacent multipliers in multiplier-bram pairs
unusable.

Mask Parameters 
-----------------

+---------------+----------------+---------------------------------------------------------------------------------------------------------+
| Parameter     | Variable       | Description                                                                                             |
+===============+================+=========================================================================================================+
| Delay Depth   | delay\_depth   | The length of the delay.                                                                                |
+---------------+----------------+---------------------------------------------------------------------------------------------------------+
| Bit Width     | n\_bits        | Specifies the width of the real/imaginary components. Width of each component is assumed equal.         |
+---------------+----------------+---------------------------------------------------------------------------------------------------------+
| Use BRAM      | use\_bram      | Set to 1 to implement the delay using BRAM. If 0, the delay will be implemented using SLR16 elements.   |
+---------------+----------------+---------------------------------------------------------------------------------------------------------+

Ports 
-------

+--------+-------+-------------+-------------------------------------+
| Port   | Dir   | Data Type   | Description                         |
+========+=======+=============+=====================================+
| in     | in    |  ???        | The complex signal to be delayed.   |
+--------+-------+-------------+-------------------------------------+
| out    | out   |  ???        | The delayed complex signal.         |
+--------+-------+-------------+-------------------------------------+

Description 
------------
A delay block that treats its input as complex, splits it into real and
imaginary components, delays each component by a specified amount, and
then re-joins them into a complex output. The underlying storage is
user-selectable (either BRAM or SLR16 elements). The reason for this is
wide (36 bit) delays make adjacent multipliers in multiplier-bram pairs
unusable.