Real-sampled Biplex FFT (demuxed by 2)
=======================================
| **Block:** Real-sampled Biplex FFT (with output demuxed by 2)
  (``fft_biplex_real_2x``)
| **Block Author**: Aaron Parsons
| **Block Maintainer**: Andrew Martens
| **Document Author**: Aaron Parsons, Andrew Martens

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
----------
Computes the real-sampled Fast Fourier Transform using the standard
Hermitian conjugation trick to use a complex core to transform a two
real streams. Thus, a biplex core (which can do 2 complex FFTs) can
transform 4 real streams. Twiddle factor, and other logic sharing,
allows multiples of 4 input streams to be processed simultaneously with
minimal resource increases. Only positive frequencies are output
(negative frequencies are the mirror images of their positive
counterparts). Data is output in normal frequency order, meaning that
channel 0 (corresponding to DC) is output first, followed by channel 1,
on up to channel 2\ :sup:`N − 1` − 1. Real inputs 0 and 2 share one
output port (with the data for 0 coming first, then the data for 2),
likewise for inputs 1 and 3, and so on.

Please note that this documentation refers to the latest version of this
block and may not be valid for older versions, please look in the
history for older versions of this documentation.

Mask Parameters 
-----------------

+--------------------+--------------------+--------------------+--------------------+
| Parameter          | Variable           | Description        | Recommended Value  |
+====================+====================+====================+====================+
| Number             | n\_inputs          | The number of      |                    |
| simultaneous       |                    | inputs the FFT is  |                    |
| inputs (4\*?)      |                    | to process as a    |                    |
|                    |                    | multiple of 4.     |                    |
+--------------------+--------------------+--------------------+--------------------+
| Size of FFT: (2^?) | FFTSize            | The number of      |                    |
|                    |                    | channels computed  |                    |
|                    |                    | in the complex FFT |                    |
|                    |                    | core. The number   |                    |
|                    |                    | of channels output |                    |
|                    |                    | for each real      |                    |
|                    |                    | stream is half of  |                    |
|                    |                    | this.              |                    |
+--------------------+--------------------+--------------------+--------------------+
| Input bit width    | input\_bit\_width  | The number of bits | To make optimal    |
|                    |                    | in each real and   | use of BRAMs =>    |
|                    |                    | imaginary sample   | 18                 |
|                    |                    | as they are input  | For low FFT        |
|                    |                    | to the FFT. If bit | noise => 25        |
|                    |                    | growth is not      |                    |
|                    |                    | chosen, each FFT   |                    |
|                    |                    | stage will round   |                    |
|                    |                    | numbers back down  |                    |
|                    |                    | to this number of  |                    |
|                    |                    | bits after         |                    |
|                    |                    | performing a       |                    |
|                    |                    | butterfly          |                    |
|                    |                    | computation. If    |                    |
|                    |                    | bit growth is      |                    |
|                    |                    | chosen, the number |                    |
|                    |                    | of bits will       |                    |
|                    |                    | increase by one    |                    |
|                    |                    | with every FFT     |                    |
|                    |                    | stage up to the    |                    |
|                    |                    | maximum specified. |                    |
+--------------------+--------------------+--------------------+--------------------+
| Input binary point | bin\_pt            | The position of    |                    |
|                    |                    | the binary point   |                    |
|                    |                    | in the input data  |                    |
+--------------------+--------------------+--------------------+--------------------+
| Coefficient Bit    | coeff\_bit\_width  | The number of bits | 18                 |
| Width              |                    | used in the real   |                    |
|                    |                    | and imaginary part |                    |
|                    |                    | of the twiddle     |                    |
|                    |                    | factors at each    |                    |
|                    |                    | stage.             |                    |
+--------------------+--------------------+--------------------+--------------------+
| Asynchronous       | async              | Whether valid data |                    |
| operation          |                    | is input on every  |                    |
|                    |                    | clock cycle or is  |                    |
|                    |                    | flagged via the en |                    |
|                    |                    | input port.        |                    |
+--------------------+--------------------+--------------------+--------------------+
| Quantization       | quantization       | Specifies the      | NOT Truncate.      |
| Behavior           |                    | rounding behaviour |                    |
|                    |                    | used at the end of |                    |
|                    |                    | each twiddle and   |                    |
|                    |                    | butterfly          |                    |
|                    |                    | computation to     |                    |
|                    |                    | return to the      |                    |
|                    |                    | number of bits if  |                    |
|                    |                    | bit growth is not  |                    |
|                    |                    | enabled or to keep |                    |
|                    |                    | the number of bits |                    |
|                    |                    | at the maximum     |                    |
|                    |                    | specified.         |                    |
+--------------------+--------------------+--------------------+--------------------+
| Overflow Behavior  | overflow           | Indicates the      |                    |
|                    |                    | behaviour of the   |                    |
|                    |                    | FFT core when the  |                    |
|                    |                    | value of a sample  |                    |
|                    |                    | exceeds what can   |                    |
|                    |                    | be expressed in    |                    |
|                    |                    | the specified bit  |                    |
|                    |                    | width.             |                    |
+--------------------+--------------------+--------------------+--------------------+
| Add Latency        | add\_latency       | Latency through    | 1                  |
|                    |                    | adders in the FFT. |                    |
+--------------------+--------------------+--------------------+--------------------+
| Mult Latency       | mult\_latency      | Latency through    | 2                  |
|                    |                    | multipliers in the |                    |
|                    |                    | FFT.               |                    |
+--------------------+--------------------+--------------------+--------------------+
| BRAM Latency       | bram\_latency      | Latency through    | 2 For designs      |
|                    |                    | BRAM in the FFT.   | aimed at > 200MHz  |
|                    |                    |                    | => 3               |
+--------------------+--------------------+--------------------+--------------------+
| Convert Latency    | conv\_latency      | Latency through    | 1 For designs      |
|                    |                    | blocks used to     | aimed at > 180Mhz  |
|                    |                    | reduce bit widths  | => 2               |
|                    |                    | after twiddle and  |                    |
|                    |                    | butterfly stages.  |                    |
+--------------------+--------------------+--------------------+--------------------+
| Number bits above  | coeffs\_bit\_limit | Determines the     | 8 (ensures at      |
| which to store     |                    | threshold at which | least 2^8=256 bits |
| stage's            |                    | the twiddle        | out of 18432 bits  |
| coefficients in    |                    | coefficients in a  | of BRAM used)      |
| BRAM (2^? bits)    |                    | stage are stored   |                    |
|                    |                    | in BRAM. Below     |                    |
|                    |                    | this threshold     |                    |
|                    |                    | distributed RAM is |                    |
|                    |                    | used.              |                    |
+--------------------+--------------------+--------------------+--------------------+
| Number bits above  | delays\_bit\_limit | Determines the     | 8 (ensures at      |
| which to implement |                    | threshold at which | least 2^8=256 bits |
| stage's delays in  |                    | data delays in a   | out of 18432 bits  |
| BRAM (2^? bits)    |                    | stage are stored   | of BRAM used)      |
|                    |                    | in BRAM. Below     |                    |
|                    |                    | this threshold     |                    |
|                    |                    | distributed RAM is |                    |
|                    |                    | used.              |                    |
+--------------------+--------------------+--------------------+--------------------+
| BRAM sharing in    | coeff\_sharing     | Real and imaginary |                    |
| coeff storage      |                    | components of      |                    |
|                    |                    | twiddle factors    |                    |
|                    |                    | can be generated   |                    |
|                    |                    | from the same set  |                    |
|                    |                    | of coefficients,   |                    |
|                    |                    | reducing BRAM use  |                    |
|                    |                    | at the cost of     |                    |
|                    |                    | some logic.        |                    |
+--------------------+--------------------+--------------------+--------------------+
| Store a fraction   | coeff\_decimation  | The full set of    |                    |
| of coeff factors   |                    | twiddle factors    |                    |
| where useful       |                    | can be generated   |                    |
|                    |                    | from a smaller     |                    |
|                    |                    | set, reducing BRAM |                    |
|                    |                    | use at the cost of |                    |
|                    |                    | the some logic.    |                    |
+--------------------+--------------------+--------------------+--------------------+
| Maximum fanout     | max\_fanout        | The maximum fanout |                    |
|                    |                    | the twiddle        |                    |
|                    |                    | factors are        |                    |
|                    |                    | allowed to         |                    |
|                    |                    | experience between |                    |
|                    |                    | where they are     |                    |
|                    |                    | generated and when |                    |
|                    |                    | they are           |                    |
|                    |                    | multiplied with    |                    |
|                    |                    | the data stream.   |                    |
|                    |                    | As the             |                    |
|                    |                    | coefficients are   |                    |
|                    |                    | shared, large      |                    |
|                    |                    | fanout can occur   |                    |
|                    |                    | which can affect   |                    |
|                    |                    | maximum timing     |                    |
|                    |                    | achievable.        |                    |
|                    |                    | Decreasing the     |                    |
|                    |                    | maximum fanout     |                    |
|                    |                    | allowed should     |                    |
|                    |                    | increase possible  |                    |
|                    |                    | performance at the |                    |
|                    |                    | expense of some    |                    |
|                    |                    | logic.             |                    |
+--------------------+--------------------+--------------------+--------------------+
| Multiplier         | mult\_spec         | Array of values    | 2 (behavioral HDL) |
| specification      |                    | allowing exact     | for each stage     |
| (0=core,           |                    | specification of   |                    |
| 1=embedded,        |                    | how multipliers    |                    |
| 2=behavioural)     |                    | are implemented at |                    |
| (left=1st stage)   |                    | each stage. A      |                    |
|                    |                    | single value       |                    |
|                    |                    | indicates all      |                    |
|                    |                    | multipliers be     |                    |
|                    |                    | implemented in the |                    |
|                    |                    | same way.          |                    |
+--------------------+--------------------+--------------------+--------------------+
| Bit growth instead | bit\_growth        | Bit growth at      |                    |
| of shifting        |                    | every stage in the |                    |
|                    |                    | FFT can result in  |                    |
|                    |                    | overflows which    |                    |
|                    |                    | affect data        |                    |
|                    |                    | quality. This can  |                    |
|                    |                    | be prevented by    |                    |
|                    |                    | dividing the data  |                    |
|                    |                    | by two on the      |                    |
|                    |                    | output of every    |                    |
|                    |                    | stage, or by       |                    |
|                    |                    | increasing the     |                    |
|                    |                    | number of bits in  |                    |
|                    |                    | the data stream by |                    |
|                    |                    | one bit. Shifting  |                    |
|                    |                    | decreases the      |                    |
|                    |                    | dynamic range and  |                    |
|                    |                    | possible data      |                    |
|                    |                    | quality whereas    |                    |
|                    |                    | bit growth         |                    |
|                    |                    | increases the      |                    |
|                    |                    | resource           |                    |
|                    |                    | requirements.      |                    |
+--------------------+--------------------+--------------------+--------------------+
| Max bits to growth | max\_bits          | The maximum number |                    |
| to                 |                    | of bits to         |                    |
|                    |                    | increase the data  |                    |
|                    |                    | path to when the   |                    |
|                    |                    | bit growth option  |                    |
|                    |                    | is chosen.         |                    |
|                    |                    | Shifting is used   |                    |
|                    |                    | for FFT stages     |                    |
|                    |                    | after this.        |                    |
+--------------------+--------------------+--------------------+--------------------+
| Hardcode shift     | hardcode\_shifts   | When shifting to   |                    |
| schedule           |                    | prevent overflow,  |                    |
|                    |                    | use a fixed        |                    |
|                    |                    | shifting schedule. |                    |
|                    |                    | This uses less     |                    |
|                    |                    | logic and          |                    |
|                    |                    | increases          |                    |
|                    |                    | performance when   |                    |
|                    |                    | compared to using  |                    |
|                    |                    | a dynamic shift    |                    |
|                    |                    | schedule.          |                    |
+--------------------+--------------------+--------------------+--------------------+
| Shift schedule     | shift\_schedule    | When using a fixed |                    |
|                    |                    | shift schedule,    |                    |
|                    |                    | use the shift      |                    |
|                    |                    | schedule           |                    |
|                    |                    | specified. A '1'   |                    |
|                    |                    | at position M in   |                    |
|                    |                    | the array          |                    |
|                    |                    | indicates a shift  |                    |
|                    |                    | for the M'th FFT   |                    |
|                    |                    | stage, a '0'       |                    |
|                    |                    | indicates no       |                    |
|                    |                    | shift.             |                    |
+--------------------+--------------------+--------------------+--------------------+
| DSP48 adders in    | dsp48\_adders      | The butterfly      | on (enabled) to    |
| butterfly          |                    | operation at each  | reduce logic use.  |
|                    |                    | stage consists of  |                    |
|                    |                    | two adders and two |                    |
|                    |                    | subtracters that   |                    |
|                    |                    | can be implemented |                    |
|                    |                    | using DSP48 units  |                    |
|                    |                    | instead of logic.  |                    |
+--------------------+--------------------+--------------------+--------------------+

Ports 
-------

+----------------+----------------+----------------+----------------+----------------+
| Port           | Dir            | Data Type      | Description    | Recommended    |
|                |                |                |                | Use            |
+================+================+================+================+================+
| sync           | in             | Boolean        | sync is used   | Ensure the     |
|                |                |                | to indicate    | sync period    |
|                |                |                | the last data  | complies with  |
|                |                |                | word of a      | the memo       |
|                |                |                | frame of input | describing     |
|                |                |                | data. When the | correct use.   |
|                |                |                | block is in    |                |
|                |                |                | asynchronous   |                |
|                |                |                | operating mode |                |
|                |                |                | an active      |                |
|                |                |                | signal is      |                |
|                |                |                | aligned with   |                |
|                |                |                | en being       |                |
|                |                |                | active. When   |                |
|                |                |                | the block is   |                |
|                |                |                | in synchronous |                |
|                |                |                | operating      |                |
|                |                |                | mode, a an     |                |
|                |                |                | active pulse   |                |
|                |                |                | is aligned     |                |
|                |                |                | with the clock |                |
|                |                |                | cycle before   |                |
|                |                |                | the first      |                |
|                |                |                | valid data of  |                |
|                |                |                | a new input    |                |
|                |                |                | frame.         |                |
+----------------+----------------+----------------+----------------+----------------+
| shift          | in             | Unsigned       | Sets the       |                |
|                |                |                | shifting       |                |
|                |                |                | schedule       |                |
|                |                |                | through the    |                |
|                |                |                | FFT to prevent |                |
|                |                |                | overflow. Bit  |                |
|                |                |                | 0 specifies    |                |
|                |                |                | the behavior   |                |
|                |                |                | of stage 0,    |                |
|                |                |                | bit 1 of stage |                |
|                |                |                | 1, and so on.  |                |
|                |                |                | If a stage is  |                |
|                |                |                | set to shift   |                |
|                |                |                | (with bit =    |                |
|                |                |                | 1), then every |                |
|                |                |                | sample is      |                |
|                |                |                | divided by 2   |                |
|                |                |                | at the output  |                |
|                |                |                | of that stage. |                |
+----------------+----------------+----------------+----------------+----------------+
| pol            | in             | Signed         | The            | Data amplitude |
|                |                | consisting of  | time-domain    | should not     |
|                |                | one (Input Bit | stream(s) to   | exceed 0.5     |
|                |                | Width) width   | be             | (divide data   |
|                |                | signals per    | channelised.   | by 2 pre-FFT)  |
|                |                | input.         |                |                |
+----------------+----------------+----------------+----------------+----------------+
| en             | in             | Boolean        | When           |                |
|                |                |                | asynchronous   |                |
|                |                |                | operation is   |                |
|                |                |                | chosen, this   |                |
|                |                |                | port indicates |                |
|                |                |                | that valid     |                |
|                |                |                | input data is  |                |
|                |                |                | available on   |                |
|                |                |                | all input data |                |
|                |                |                | ports.         |                |
+----------------+----------------+----------------+----------------+----------------+
| sync\_out      | out            | Boolean        | Indicates that |                |
|                |                |                | data out will  |                |
|                |                |                | be valid next  |                |
|                |                |                | clock cycle    |                |
|                |                |                | when in        |                |
|                |                |                | synchronous    |                |
|                |                |                | mode, or when  |                |
|                |                |                | dvalid is next |                |
|                |                |                | active.        |                |
+----------------+----------------+----------------+----------------+----------------+
| pol\_out       | out            | Inherited      | The frequency  |                |
|                |                |                | channels.      |                |
+----------------+----------------+----------------+----------------+----------------+
| of             | out            | Unsigned, one  | Indication of  |                |
|                |                | bit per 4      | internal       |                |
|                |                | inputs         | arithmetic     |                |
|                |                |                | overflow. Not  |                |
|                |                |                | time aligned   |                |
|                |                |                | with data. The |                |
|                |                |                | most           |                |
|                |                |                | significant    |                |
|                |                |                | bit is the     |                |
|                |                |                | flag for       |                |
|                |                |                | pol0\_in,      |                |
|                |                |                | pol1\_in,      |                |
|                |                |                | pol2\_in and   |                |
|                |                |                | pol3\_in etc.  |                |
+----------------+----------------+----------------+----------------+----------------+
| dvalid         | out            | Boolean        | Indicates that |                |
|                |                |                | valid data is  |                |
|                |                |                | available on   |                |
|                |                |                | all output     |                |
|                |                |                | data ports.    |                |
+----------------+----------------+----------------+----------------+----------------+

Description 
-------------
Computes the real-sampled Fast Fourier Transform using the standard
Hermitian conjugation trick to use a complex core to transform a two
real streams. Thus, a biplex core (which can do 2 complex FFTs) can
transform 4 real streams. Twiddle factor, and other logic sharing,
allows multiples of 4 input streams to be processed simultaneously with
minimal resource increases. Only positive frequencies are output
(negative frequencies are the mirror images of their positive
counterparts). Data is output in normal frequency order, meaning that
channel 0 (corresponding to DC) is output first, followed by channel 1,
on up to channel 2\ :sup:`N − 1` − 1. Real inputs 0 and 2 share one
output port (with the data for 0 coming first, then the data for 2),
likewise for inputs 1 and 3, and so on.