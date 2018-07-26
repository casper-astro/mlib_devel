Complex 4-bit Multiplier, Embedded Multipliers
================================================
| **Block:** Complex 4-bit Multiplier Implemented in Embedded
  Multipliers (``cmult_4bit_em``)
| **Block Author**: ?
| **Document Author**: ?

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
Perform a complex multiplication (*a* + *bi*)(\ *c* − *di*) = (*ac* −
*bd*) + (*ad* + *bc*)\ *i*. Implements the logic in embedded
multipliers.

Mask Parameters 
----------------

+----------------------+-----------------+-------------------------------------+
| Parameter            | Variable        | Description                         |
+======================+=================+=====================================+
| Multiplier Latency   | mult\_latency   | The latency through a multiplier.   |
+----------------------+-----------------+-------------------------------------+
| dd Latency           | add\_latency    | The latency through an adder.       |
+----------------------+-----------------+-------------------------------------+

Ports 
-------

+--------+-------+-------------+---------------------------------------+
| Port   | Dir   | Data Type   | Description                           |
+========+=======+=============+=======================================+
| a      | in    | Inherited   | The real component of input 1.        |
+--------+-------+-------------+---------------------------------------+
| b      | in    | Inherited   | The imaginary component of input 1.   |
+--------+-------+-------------+---------------------------------------+
| c      | in    | Inherited   | The real component of input 2.        |
+--------+-------+-------------+---------------------------------------+
| d      | in    | Inherited   | The imaginary component of input 2.   |
+--------+-------+-------------+---------------------------------------+
| real   | out   | Inherited   | ac-bd                                 |
+--------+-------+-------------+---------------------------------------+
| imag   | out   | Inherited   | ad+bc                                 |
+--------+-------+-------------+---------------------------------------+

Description 
-------------
Perform a complex multiplication (*a* + *bi*)(\ *c* − *di*) = (*ac* −
*bd*) + (*ad* + *bc*)\ *i*. Implements the logic in embedded
multipliers. Each 4 bit real multiplier is implemented as a lookup table
with 4b+4b=8b of address.