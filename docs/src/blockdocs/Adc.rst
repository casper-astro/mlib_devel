ADC
====

| **Block:** ADC (``adc``)
| **Block Author**: Pierre Yves Droz
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
|    -  `Connecting the Hardware <#connecting-the-hardware>`__             |
|    -  `ADC Background Information <#adc-background-information>`__       |
+--------------------------------------------------------------------------+

Summary 
---------

The ADC block converts analog inputs to digital outputs. Every clock
cycle, the inputs are sampled and digitized to 8 bit binary point
numbers in the range of [-1, 1) and are then output by the adc.

Mask Parameters 
-----------------

+------------------------+-------------------+------------------------------------------------------------------------------------+
| Parameter              | Variable          | Description                                                                        |
+========================+===================+====================================================================================+
| ADC board              | adc\_brd          | Select which ADC port to use on the IBOB.                                          |
+------------------------+-------------------+------------------------------------------------------------------------------------+
| ADC clock rate (MHz)   | adc\_clk\_rate    | Sets the clock rate of the ADC, must be at least 4x the IBOB clock rate.           |
+------------------------+-------------------+------------------------------------------------------------------------------------+
| ADC interleave mode    | adc\_interleave   | Check for 1 input, uncheck for 2 inputs.                                           |
+------------------------+-------------------+------------------------------------------------------------------------------------+
| Sample period          | sample\_period    | Sets the period at which the adc outputs samples (ie 2 means every other cycle).   |
+------------------------+-------------------+------------------------------------------------------------------------------------+

Ports 
-------

+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Port               | Dir   | Data Type   | Description                                                                                                                                                                                                                         |
+====================+=======+=============+=====================================================================================================================================================================================================================================+
| sim\_in            | IN    | double      | The analog signal to be digitized if interleave mode is selected. Note: For simulation only.                                                                                                                                        |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sim\_i             | IN    | double      | The first analog signal to be digitized if interleave mode is unselected. Note: For simulation only.                                                                                                                                |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sim\_q             | IN    | double      | The second analog signal to be digitized if interleave mode is unselected. Note: For simulation only.                                                                                                                               |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sim\_sync          | IN    | double      | Takes a pulse to be observed at the output to measure the delay through the block. Note: For simulation only.                                                                                                                       |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sim\_data\_valid   | IN    | double      | A signal that is high when inputs are valid. Note: For simulation only.                                                                                                                                                             |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| oX                 | OUT   | Fix\_8\_7   | A signal that represents sample X+1 (Ex. o0 is the 1st sample, o7 is the 8th sample). Used if interleave mode is on.                                                                                                                |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| iX                 | OUT   | Fix\_8\_7   | A signal that represents sample X+1 (Ex. i0 is the 1st sample, o3 is the 4th sample). Used if interleave mode is off.                                                                                                               |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| qX                 | OUT   | Fix\_8\_7   | A signal that represents sample X+1 (Ex. q0 is the 1st sample, q3 is the 4th sample). Used if interleave mode is off.                                                                                                               |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| outofrangeX        | OUT   | boolean     | A signal that represents when samples are outside the valid range.                                                                                                                                                                  |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| syncX              | OUT   | boolean     | A signal that is high when the sync pulse offset by X if interleave mode is unselected, or 2X if interleave mode is selected is high (Ex. sync2 is the pulse offset by 2 if interleave is off or offset by 4 if interlave is on).   |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| data\_valid        | OUT   | boolean     | A signal that is high when the outputs are valid.                                                                                                                                                                                   |
+--------------------+-------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Description 
-------------
Usage 
^^^^^^^
The ADC block can take 1 or 2 analog input streams. The first input
should be connected to input i and the second to input q if it is being
used. The inputs will then be digitized to ``Fix_8_7`` numbers between
[-1, 1). For a single input, the ``adc`` samples its input 8 times per
IBOB clock cycle and outputs the 8 samples in parallel with o0 being the
first sample and o7 the last sample. For 2 inputs, the ``adc`` samples
both inputs 4 times per IBOB clock cycle and then outputs them in
parallel with i0-i3 corresponding to input i and q0-q3 corresponding to
input q. In addition to having 2 possible inputs, each IBOB can
interface with 2 ``adc``\ s for a total of 4 inputs or 2 8-sample inputs
per IBOB.

Connecting the Hardware 
^^^^^^^^^^^^^^^^^^^^^^^^^
To hook up the ADC board, attach the clock SMA cable to the clk\_i port,
the first input to the I+ port, and the second input to the Q+ port.
Check the hardware on the ADC board near the input pins. There should be
for 4 square chips in a straight line. If there are only 3, the second
input, Q+, may not work. Note that if you chose ``adc0_clk``, make sure
to plug the ADC board in to the adc0 port. The same applies if you chose
``adc1_clk`` to plug the board into adc1 port. If you are using both
ADCs, then you need to plug a clock into both clk\_i inputs and you
should probably run them off of the same signal generator.

ADC Background Information 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The ADC board was designed to mate directly to an IBOB board through
ZDOK connectors for high-speed serial data I/O. Analog data is digitized
using an Atmel AT84AD001B dual 8-bit ADC chip which can digitize two
streams at 1 Gsample/sec or a single stream at 2 Gsample/sec. This board
may be driven with either single-ended or differential inputs.