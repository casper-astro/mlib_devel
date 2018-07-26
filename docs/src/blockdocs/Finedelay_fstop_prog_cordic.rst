Programmable Fine Delay w/ Fringe stop, CORDIC
================================================
| **Block:** Programmable fine delay with fringe stop using CORDIC block
  ``(finedelay_fstop_prog_cordic``)
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
--------
This block performs the fine delay correction along with the fringe
stop. This block accepts the simultaneous stream of data from the FFT
module and has a run time programmable fine delay correction along with
the fringe stopping. This block uses CORDIC block which is compatible
with Virtex 5 FPGA. Hence this block can be used for designs on Virtex5
FPGA of ROACH board.

**Note 1:** This block is specifically compatible with the
“fft\_wideband\_real” module. For other FFT modules changes will be
required in this block depending upon the way in which the data is
output from the FFT module.

**Note 2:** This block requires System Generator Version 11.1 to make it compatible with Virtex 5.

**Note 3:** Currently the block is able to correct delay for One clock
or less than one clock. It does not correct delays which are more than
one clock.

Mask Parameters 
----------------

+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+
| Parameter                                                       | Variable              | Description                                                                                                                                          |
+=================================================================+=======================+======================================================================================================================================================+
| Number of simultaneous inputs                                   | n\_input              | Number of simultaneous inputs (in frequency domain) from the FFT module.                                                                             |
+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+
| Number of FFT channels                                          | fft\_len              | Number of channels in the FFT                                                                                                                        |
+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+
| FFT input bitwidth                                              | fft\_bits             | Number of bits in each real and imaginary samples obtained from the FFT module.                                                                      |
+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+
| CORDIC Sine-Cos input bitwidth                                  | theta\_bits           | Input bitwidth required for the CORDIC SineCos block and hence decides the resolution of the phase.                                                  |
+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+
| CORDIC Sine-Cos input binary bitwidth                           | theta\_binary\_bits   | Input binary bitwidth of the CORDIC sine cos block.                                                                                                  |
+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+
| Maximum number of FFT cycles (Rate of change of fringe = 2^?)   | fft\_cycle\_bits      | Number of FFT cycles after which the rate of change of fringe needs to be applied. The number of FFT cycles are specified in terms of powers of 2.   |
+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+
| Sync Period                                                     | sync\_period          | Duration of the sync pulse.                                                                                                                          |
+-----------------------------------------------------------------+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------+

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
the fringe stopping.This block uses CORDIC block which is compatible
with Virtex 5 FPGA. Hence this block can be used for designs on Virtex5
FPGA of ROACH board.

**Note:** This block is specifically compatible with the
“fft\_wideband\_real” module. For other FFT modules changes will be
required in this block depending upon the way in which the data is
output from the FFT module.

**Fine Delay Correction:**

Masking parameters like theta\_bits and theta\_binary\_bits decides the
resolution of the phase required for fine delay and fringe stop.

Resolution = (2^theta\_bits \* 2 \* pi) / 8

For eg. theta\_bits = 20 will generate a CORDIC SineCos block with a
resolution of 0.000437 degrees.

Let bandwidth = 300MHz and no. of FFT channels = fft\_len = 1024 then
the maximum integer value of theta\_fract (i.e. max fine delay = 1 clk
cycle)will be

num = (2^theta\_bits \* pi) / 8

x = (num \* 2)/(fft\_len/2) = 1608

Thus 1/1608th of the clock cycle delay can be compensated with the above
parameters.

**Fringe Stop:**

Masking parameter fft\_cycle\_bits determines the maximum number of FFT
cycles after which the fringe phase will be incremented.

For eg. Let the sync period is of 2^27 clks and number of FFT points be
2^10 then the maximum number of FFT cycles for incrementing the fringe
phase by amount of resolution set for the Sine-Cos LUT = 2^27 / 2^10 =
2^17

It means that minimum rate of incrementing fringe phase by 0.000437
degrees is after 2^17 FFT cycles.