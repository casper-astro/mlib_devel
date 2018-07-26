Programmable Fine Delay w/ Fringe stop
=======================================
| **Block:** Programmable fine delay with fringe stop
  (``finedelay_fstop_prog``)
| **Block Author**: Mekhala Muley, GMRT, India.
| **Document Author**: Mekhala Muley, GMRT, India.

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
This block performs the fine delay correction along with the fringe
stop. It accepts the simultaneous stream of data from the FFT module and
has a run time programmable fine delay correction along with the fringe
stopping.

**Note:** This block is specifically compatible with the
“fft\_wideband\_real” module. For other FFT modules changes will be
required in this block depending upon output of the FFT module used in
the design.

Mask Parameters 
----------------

+-----------------------------------------------------------------+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Parameter                                                       | Variable           | Description                                                                                                                                           |
+=================================================================+====================+=======================================================================================================================================================+
| Number of simultaneous inputs                                   | n\_input           | Number of simultaneous inputs (in frequency domain) from the FFT module.                                                                              |
+-----------------------------------------------------------------+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Number of FFT channels                                          | fft\_len           | Number of channels in the FFT                                                                                                                         |
+-----------------------------------------------------------------+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| FFT input bitwidth                                              | fft\_bits          | Number of bits in each real and imaginary samples obtained from the FFT module.                                                                       |
+-----------------------------------------------------------------+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Sine-Cos LUT input bitwidth                                     | theta\_bits        | Address bitwidth required for the SineCos LUT and hence decides the resolution of the phase. Allowable bitwidth for Sine-Cos LUT ranges from 3- 16.   |
+-----------------------------------------------------------------+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Sine-Cos LUT output data width                                  | sine\_cos\_bits    | Data width of the sine cos LUT.                                                                                                                       |
+-----------------------------------------------------------------+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Maximum number of FFT cycles (Rate of change of fringe = 2^?)   | fft\_cycle\_bits   | Number of FFT cycles after which the rate of change of fringe needs to be applied. The number of FFT cycles are specified in terms of powers of 2.    |
+-----------------------------------------------------------------+--------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+

Ports 
------

+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Port            | Dir   | Data Type   | Description                                                                                                                                                                                                                                 |
+=================+=======+=============+=============================================================================================================================================================================================================================================+
| sync            | In    | Boolean     | Indicates the next clock cycle which contains valid data.                                                                                                                                                                                   |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| theta\_fract    | In    | Unsigned    | Sets the integer number required for fine delay correction.The bitwidth is equal to the address width for SineCos LUT. The method of calculating the range of integer required for the fine delay correction is explained in Description.   |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| theta\_fs       | In    | Unsigned    | Sets the integer value equivalent to the initial phase value for fringe stop . The bitwidth is equal to the address width for SineCos LUT. Hence the possible range for initial phase varies from 0 to 2^theta\_bits.                       |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| fft\_fs         | In    | Unsigned    | Sets the number of FFT cycles after which fringe update rate need to be applied.                                                                                                                                                            |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| en\_theta\_fs   | In    | Unsigned    | This is the one bit control signal required to upload the new initial phase required for fringe stop. The new initial phase value gets loaded only at the posedge of this signal.                                                           |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| pol\_in         | In    | Inherited   | The frequency domain stream from the FFT module.                                                                                                                                                                                            |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sync\_out       | Out   | Boolean     | Indicates that data out will be valid next clock cycle.                                                                                                                                                                                     |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| out             | Out   | Inherited   | The fine delay and fringe stop corrected frequency channels.                                                                                                                                                                                |
+-----------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Description 
------------
This block performs the fine delay correction along with the fringe
stop. This block accepts the simultaneous stream of data from the FFT
module and has a run time programmable fine delay correction along with
the fringe stopping.

**Note:** This block is specifically compatible with the
“fft\_wideband\_real” module. For other FFT modules changes will be
required in this block depending upon the way in which the data is
output from the FFT module.

**Fine Delay Correction:**

Masking parameters like *theta\_bits* and *sine\_cos\_bits* decides the
resolution of the phase required for fine delay and fringe stop.

For eg. theta\_bits = 14 will generate a SineCos LUT with a depth of
2^14=16K, hence the resolution is of 0.02197 degrees. Consider the
correlator design with specifications like bandwidth = 300MHz and no. of
FFT channels = fft\_len = 1024, then the maximum integer value of
theta\_fract (i.e. max fine delay = 1 clk cycle)will be x = (2^
theta\_bits)/ (fft\_len/2) = 32

Thus 1/32th of the clock cycle delay can be compensated with the above
parameters.

**Fringe Stop:**

Masking parameter *fft\_cycle\_bits* determines the maximum number of
FFT cycles after which the fringe phase will be incremented.

For eg. Let the sync period is of 2^27 clks and number of FFT points be
2^10 then the maximum number of FFT cycles for incrementing the fringe
phase by amount of resolution set for the Sine-Cos LUT = 2^27 / 2^10 =
2^17

It means that minimum rate of incrementing fringe phase by 0.02197
degrees is after 2^17 FFT cycles.