FIR Double Column
==================
| **Block:** FIR Double Column (``fir_dbl_col``)
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
-----------------

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

+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Port              | Dir   | Data Type   | Description                                                                                                                                                          |
+===================+=======+=============+======================================================================================================================================================================+
| real              | IN    | Inherited   | This real input is to be multiplied by one of the coefficients.                                                                                                      |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| imag              | IN    | Inherited   | This imaginary input is to be multiplied by one of the coefficients.                                                                                                 |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| real\_back        | IN    | Inherited   | These real inputs correspond to the second half of the input stream. They get added to one of the ``real`` inputs before being multiplied by the coefficient.        |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| imag\_back        | IN    | Inherited   | These imaginary inputs correspond to the second half of the input stream. They get added to one of the ``imag`` inputs before being multiplied by the coefficient.   |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| real\_out         | OUT   | Inherited   | This output is ``real`` delayed by 1 cycle.                                                                                                                          |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| imag\_out         | OUT   | Inherited   | This output is ``imag`` delayed by 1 cycle.                                                                                                                          |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| real\_back\_out   | OUT   | Inherited   | This output is ``real_back`` delayed by 1 cycle.                                                                                                                     |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| imag\_back\_out   | OUT   | Inherited   | This output is ``imag_back`` delayed by 1 cycle.                                                                                                                     |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| real\_sum         | OUT   | Inherited   | This is the sum of all the multiplications between ``real`` and ``real_back`` and their corresponding coefficients.                                                  |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| imag\_sum         | OUT   | Inherited   | This is the sum of all the multiplications between ``imag`` and ``imag_back`` and their corresponding coefficients.                                                  |
+-------------------+-------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
This block takes in a number of inputs in parallel and outputs a delayed
version of them and also multiplies the inputs by the coefficients. Then
``real_sum`` and ``imag_sum`` are computed and are delayed due to the
latency in the adders which depends both on the ``add_latency`` and the
number of inputs. For example, if you choose the number of inputs to be
2, then there will be 2 ``real`` and 2 ``real_back`` input ports along
with 2 ``imag`` and 2 ``imag_back`` input ports. The FIR Double Column
blocks takes advantage of the symmetric filter tap coefficients by
adding the first and last inputs together before multiplying by the
coefficient. This results in a more efficient FIR filter column.