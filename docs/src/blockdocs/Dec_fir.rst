Decimating FIR Filter
======================
| **Block:** Decimating FIR Filter (``dec_fir``)
| **Block Author**: Aaron Parsons
| **Document Author**: Aaron Parsons, Ben Blackman

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
FIR filter which can handle multiple time samples in parallel and
decimates down to 1 time sample. If coefficiencts are symmetric, it will
automatically fold before multiplying.

Mask Parameters 
-----------------

+------------------------------+-----------------+----------------------------------------------------------------------------------------------------------+
| Parameter                    | Variable        | Description                                                                                              |
+==============================+=================+==========================================================================================================+
| Number of Parallel Streams   | n\_inputs       | The number of time samples which arrive in parallel.                                                     |
+------------------------------+-----------------+----------------------------------------------------------------------------------------------------------+
| Coefficients                 | coeff           | The FIR coefficients. If this vector is symmetric, the FIR will automatically fold before multiplying.   |
+------------------------------+-----------------+----------------------------------------------------------------------------------------------------------+
| Bit Width Out                | n\_bits         | The number of bits in each real/imag sample of the complex number that is output.                        |
+------------------------------+-----------------+----------------------------------------------------------------------------------------------------------+
| Quantization Behavior        | quantization    | The quantization behavior used in converting to the output bit width.                                    |
+------------------------------+-----------------+----------------------------------------------------------------------------------------------------------+
| Add Latency                  | add\_latency    | The latency of adders/converters.                                                                        |
+------------------------------+-----------------+----------------------------------------------------------------------------------------------------------+
| Mult Latency                 | mult\_latency   | The latency of multipliers.                                                                              |
+------------------------------+-----------------+----------------------------------------------------------------------------------------------------------+

Ports 
------

+-------------+-------+-------------------------------+----------------------------------------------------------+
| Port        | Dir   | Data Type                     | Description                                              |
+=============+=======+===============================+==========================================================+
| sync\_in    | IN    | boolean                       | Takes an impulse 1 cycle before input is valid.          |
+-------------+-------+-------------------------------+----------------------------------------------------------+
| realX       | IN    | Fix\_(n\_bits)\_(n\_bits-1)   | Real input X                                             |
+-------------+-------+-------------------------------+----------------------------------------------------------+
| inagX       | IN    | Fix\_(n\_bits)\_(n\_bits-1)   | Imaginary input X                                        |
+-------------+-------+-------------------------------+----------------------------------------------------------+
| sync\_out   | OUT   | boolean                       | Will be high the clock cycle before ``dout`` is valid.   |
+-------------+-------+-------------------------------+----------------------------------------------------------+

Description 
-------------
Usage 
^^^^^^^
User specifies the number of parallel streams to be decimated to one
complex number. Inputs are multiplied by the coefficients and added
together to form ``dout``. Bit Width Out specifies the widths of the
real and imaginary components of the complex number to be output (Ex. if
Bit Width Out = 8, then dout will be 16 bits, 8 for the real and
imaginary components).