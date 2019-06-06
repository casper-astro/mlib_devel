Polyphase FIR Filter
=====================
| **Block:** Polyphase FIR Filter (frontend for a full PFB)
  (``pfb_fir``)
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
This block, combined with an FFT, implements a Polyphase Filter Bank
which uses longer windows of data to improve the shape of channels
within a spectrum.

Mask Parameters 
----------------

+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Parameter                                      | Variable        | Description                                                                                                                                                                   |
+================================================+=================+===============================================================================================================================================================================+
| Size of PFB: (2\ :sup:`?`)                     | PFBSize         | The number of channels in the PFB (this should also be the size of the FFT which follows).                                                                                    |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Total Number of Taps:                          | TotalTaps       | The number of taps in the PFB FIR filter. Each tap uses 2 real multiplier cores and requires buffering the real and imaginary streams for 2\ :sup:`PFBSize` samples.          |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Windowing Function                             | WindowType      | Which windowing function to use (this allows trading passband ripple for steepness of rolloff, etc).                                                                          |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Number of Simultaneous Inputs: (2\ :sup:`?`)   | n\_inputs       | The number of parallel time samples which are presented to the FFT core each clock. The number of output ports are set to this same value.                                    |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Make Biplex                                    | MakeBiplex      | Double up the inputs to match with a biplex FFT.                                                                                                                              |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Input Bit Width                                | BitWidthIn      | The number of bits in each real and imaginary sample input to the PFB.                                                                                                        |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Output Bit Width                               | BitWidthOut     | The number of bits in each real and imaginary sample output from the PFB. This should match the bit width in the FFT that follows.                                            |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Coefficient Bit Width                          | CoeffBitWidth   | The number of bits in each coefficient. This is usually chosen to match the input bit width.                                                                                  |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Use Distributed Memory for Coefficients        | CoeffDistMem    | Store the FIR coefficients in distributed memory (if = 1). Otherwise, BRAMs are used to hold the coefficients.                                                                |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Add Latency                                    | add\_latency    | Latency through adders in the FFT.                                                                                                                                            |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Mult Latency                                   | mult\_latency   | Latency through multipliers in the FFT.                                                                                                                                       |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| BRAM Latency                                   | bram\_latency   | Latency through BRAM in the FFT.                                                                                                                                              |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Quantization Behavior                          | quantization    | Specifies the rounding behavior used at the end of each butterfly computation to return to the number of bits specified above.                                                |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Bin Width Scaling (normal = 1)                 | fwidth          | PFBs give enhanced control over the width of frequency channels. By adjusting this parameter, you can scale bins to be wider (for values > 1) or narrower (for values < 1).   |
+------------------------------------------------+-----------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Ports 
------

+-------------+-------+-------------+----------------------------------------------------------------------+
| Port        | Dir   | Data Type   | Description                                                          |
+=============+=======+=============+======================================================================+
| sync        | in    | Boolean     | Indicates the next clock cycle contains valid data                   |
+-------------+-------+-------------+----------------------------------------------------------------------+
| pol\_in     | in    | Inherited   | The (complex) time-domain stream(s).                                 |
+-------------+-------+-------------+----------------------------------------------------------------------+
| sync\_out   | out   | Boolean     | Indicates that data out will be valid next clock cycle.              |
+-------------+-------+-------------+----------------------------------------------------------------------+
| pol\_out    | out   | Inherited   | The (complex) PFB FIR output, which is still a time-domain signal.   |
+-------------+-------+-------------+----------------------------------------------------------------------+

Description 
------------
This block, combined with an FFT, implements a Polyphase Filter Bank
which uses longer windows of data to improve the shape of channels
within a spectrum.