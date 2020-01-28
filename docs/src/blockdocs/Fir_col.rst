FIR Column
===========
| **Block:** FIR Column (``fir_col``)
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
Takes in real and imaginary numbers to be multiplied by the coefficients
and then the filter sums the real and imaginary parts separately. Then
both sums are output as well as a delayed version of the unchanged
inputs.

Mask Parameters 
----------------

+----------------+-----------------+----------------------------------------------------------------------------------------------+
| Parameter      | Variable        | Description                                                                                  |
+================+=================+==============================================================================================+
| Inputs         | n\_inputs       | The number of real inputs and the number of imaginary inputs.                                |
+----------------+-----------------+----------------------------------------------------------------------------------------------+
| Coefficients   | coeff           | A vector of coefficients of this FIR. Should be the same number of coefficients as inputs.   |
+----------------+-----------------+----------------------------------------------------------------------------------------------+
| Add Latency    | add\_latency    | The latency of the internal adders.                                                          |
+----------------+-----------------+----------------------------------------------------------------------------------------------+
| Mult Latency   | mult\_latency   | The latency of the internal multipliers.                                                     |
+----------------+-----------------+----------------------------------------------------------------------------------------------+

Ports 
------

+--------------+-------+-------------+----------------------------------------------------------------------------------+
| Port         | Dir   | Data Type   | Description                                                                      |
+==============+=======+=============+==================================================================================+
| realX        | IN    | Inherited   | This is real input X. Its data type is inherited from the previous block.        |
+--------------+-------+-------------+----------------------------------------------------------------------------------+
| imagX        | IN    | Inherited   | This is imaginary input X. Its data type is inherited from the previous block.   |
+--------------+-------+-------------+----------------------------------------------------------------------------------+
| real\_outX   | OUT   | Inherited   | This output is ``realX`` delayed by 1 cycle.                                     |
+--------------+-------+-------------+----------------------------------------------------------------------------------+
| imag\_outX   | OUT   | Inherited   | This output is ``imagX`` delayed by 1 cycle.                                     |
+--------------+-------+-------------+----------------------------------------------------------------------------------+
| real\_sum    | OUT   | Inherited   | This is the sum of all the ``realX`` \* coefficient X.                           |
+--------------+-------+-------------+----------------------------------------------------------------------------------+
| imag\_sum    | OUT   | Inherited   | This is the sum of all the ``imagX`` \* coefficient X.                           |
+--------------+-------+-------------+----------------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
This block takes in a number of inputs in parallel and outputs a delayed
version of them and also multiplies the inputs by the coefficients. Then
``real_sum`` and ``imag_sum`` are computed and are delayed due to the
latency in the adders which depends both on the ``add_latency`` and the
number of inputs.