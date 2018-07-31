Complex to Real-Imag
======================
| **Block:** Complex to Real-Imag Block (``c_to_ri``)
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
Outputs real and imaginary components of a complex input. Useful for
simplifying interconnects. See also `ri\_to\_c <Ri_to_c.html>`__.

Mask Parameters 
-----------------

+----------------+------------+------------------------------------------------------------------------------------------------------------+
| Parameter      | Variable   | Description                                                                                                |
+================+============+============================================================================================================+
| Bit Width      | n\_bits    | Specifies width of real/imag components. Assumed equal for both components.                                |
+----------------+------------+------------------------------------------------------------------------------------------------------------+
| Binary Point   | bin\_pt    | Specifies the binary point location in the real/imaginary components. Assumed equal for both components.   |
+----------------+------------+------------------------------------------------------------------------------------------------------------+

Ports 
-------

+--------+-------+--------------+-----------------------------------------------------------------+
| Port   | Dir   | Data Type    | Description                                                     |
+========+=======+==============+=================================================================+
| c      | in    | UFix\_x\_0   | Complex input, real in MSB, imaginary in LSB.                   |
+--------+-------+--------------+-----------------------------------------------------------------+
| r      | out   | Fix\_x\_y    | Real signed output, binary point specified by parameter.        |
+--------+-------+--------------+-----------------------------------------------------------------+
| i      | out   | Fix\_x\_y    | Imaginary signed output, binary point specified by parameter.   |
+--------+-------+--------------+-----------------------------------------------------------------+

Description 
-------------
Outputs real and imaginary components of a complex input. Useful for
simplifying interconnects. See also `ri\_to\_c <Ri_to_c.html>`__.