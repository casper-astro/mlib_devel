Conjugate Complex 4-bit Multiplier, Slices
===========================================
| **Block:** Conjugating Complex 4-bit Multiplier Implemented in Slices
  (``cmult_4bit_sl*``)
| **Block Author**: Aaron Parsons
| **Document Author**: Vinayak Nagpal

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
Perform a conjugating complex multiplication (*a* + *bi*)(\ *c* − *di*)
= (*ac* + *bd*) + (*bc* − *ad*)\ *i*. Implements the logic in Slices.

Mask Parameters 
-----------------

+----------------------+-----------------+-------------------------------------+
| Parameter            | Variable        | Description                         |
+======================+=================+=====================================+
| Multiplier Latency   | mult\_latency   | The latency through a multiplier.   |
+----------------------+-----------------+-------------------------------------+
| Add Latency          | add\_latency    | The latency through an adder.       |
+----------------------+-----------------+-------------------------------------+

Ports 
------

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
| real   | out   | Inherited   | ac+bd                                 |
+--------+-------+-------------+---------------------------------------+
| imag   | out   | Inherited   | -ad+bc                                |
+--------+-------+-------------+---------------------------------------+

Description 
-------------
Perform a conjugating complex multiplication (*a* + *bi*)(\ *c* − *di*)
= (*ac* + *bd*) + (*bc* − *ad*)\ *i*. Implements the logic in Slices.