X64 ADC
=========
| **Block:** x64\_adc (``x64_adc``)
| **Block Author**: Jack Hickish, David George
| **Document Author**: Jack Hickish

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
|    -  `Background <#background>`__                                       |
|    -  `Connecting the ADC <#connecting-the-adc>`__                       |
|                                                                          |
|       -  `Clock Selection <#clock-selection>`__                          |
|       -  `Reset signal <#reset-signal>`__                                |
|       -  `SPI Interface <#spi-interface>`__                              |
|                                                                          |
|    -  `Usage <#usage>`__                                                 |
|                                                                          |
|       -  `ADC Synchronization <#adc-synchronization>`__                  |
|       -  `Data Output <#data-output>`__                                  |
|       -  `Data Input <#data-input>`__                                    |
+--------------------------------------------------------------------------+

Summary 
--------
The x64\_ADC block converts 64 analog inputs to digital outputs. Every
clock cycle, the inputs are sampled and digitized to 12 bit binary point
numbers in the range of [-1, 1).

Mask Parameters 
----------------

+--------------------------+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Parameter                | Variable         | Description                                                                                                                                                |
+==========================+==================+============================================================================================================================================================+
| ADC clock rate (MHz)     | adc\_clk\_rate   | Sets the rate of the ADC sampling clock. The ROACH clock is derived from the ADC clock and should be 4x the clock rate entered here.                       |
+--------------------------+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Include SPI interface?   | spi              | If checked, includes the ports and logic necessary to set the ADC control registers via SPI.                                                               |
+--------------------------+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+
| GPIO bank                | ctrl\_gpio       | The ADC SPI and reset interfaces are not routed through the ZDOK connector. This parameter selects which of the ROACH GPIO banks to use to control them.   |
+--------------------------+------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------+

Ports 
------

+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Port         | Dir   | Data Type     | Description                                                                                                                                                                                    |
+==============+=======+===============+================================================================================================================================================================================================+
| sim[0:15]    | IN    | double        | sim<n> should be connected to analogue channels 4n:4n+3 to be digitized. Note: For simulation only.                                                                                            |
+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sim\_sync    | IN    | double        | Input should be high when channel 4n is present on input sim<n>. Note: For simulation only.                                                                                                    |
+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| adc\_rst     | IN    | Bool          | Active high reset signal, used to reset FIFOs and adc chip.                                                                                                                                    |
+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| sdata        | IN    | UFix\_8\_0    | Data to be written to the ADC registers over SPI. sdata[7:4] represents the register address, sdata[3:0] represents the new value to be written. Present only when SPI interface is enabled.   |
+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| spi\_strb    | IN    | Bool          | SPI write strobe. When a positive edge is detected on this port an SPI write is initiated using the data and address presented on input sdata. Present only when SPI interface is enabled.     |
+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| dout[0:15]   | OUT   | Fix\_12\_11   | Four consecutive values of the signal represent a single time sample from four channels, with dout<n> representing channels 4n:4n+3.                                                           |
+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| chan\_sync   | OUT   | UFix\_8\_0    | A signal which goes high when a sample from channel 4n is present on output dout<n>. The 8 bits of the signal are used to sync the 8 individual ADC chips on the ADC card.                     |
+--------------+-------+---------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Description 
------------
Background 
^^^^^^^^^^^
The x64\_adc block is an interface to the
`64ADCx64-12 <64ADCx64-12.html>`__ board developed by Rick Raffanti.
The board is based around 8 `Texas Instruments
ADS5272 <http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=SBAS324&track=no>`__
chips, each digitizing 8 signals at 12 bits resolution and up to
65MSa/s. The ADCs can be clocked by an on-board 50MHz oscillator, or an
external clock source.

Connecting the ADC
^^^^^^^^^^^^^^^^^^^
The `64ADCx64-12 <64ADCx64-12.html>`__ is a twin Z-DOK card. Only one
can be connected to a ROACH board.

Clock Selection
~~~~~~~~~~~~~~~
The x64\_adc card includes an on-board 50MHz oscillator, but can also be
driven by an external clock.

Header J4 controls selection of the ADC clock source. Leave J4 open to
use the on-board 50MHz oscillator, or jumper J4 to use an external clock
applied across resistor R9 via pins 36 and 38 of header J13.

Reset signal
~~~~~~~~~~~~
The reset pin is located on pin 4 of J13. This signal is active low, and
should be held high for normal operation. The yellow block interface is
configured to drive the ADC reset pin via GPIO<A\|B>\_0, depending on
the block parameter specified by the user. Note that the reset on the
yellow block interface is active HIGH. When the ADC is held in reset,
data output on the yellow block data lines will be the value -1 for all
channels, in Fix\_12\_11 format.

SPI Interface
~~~~~~~~~~~~~
| Various ADC features (including test patterns) can be activated by
  using a `Serial Peripheral
  Interface <http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus>`__
  to set the registers as defined in the `ADS5272 data
  sheet <http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=SBAS324&track=no>`__.
  Physical connections are as follows:
| **ADC pins**

-  SCLK: pin 36, J12
-  SDATA: pin 38, J12
-  nCS: (ADC chip *n*): pin (20 + 2\ *n*), J12

**ROACH pins**

-  SCLK: GPIO<A\|B>\_2
-  SDATA: GPIO<A\|B>\_1
-  nCS: GPIO<A\|B>\_3

Where the GPIO port to use is determined by user-specified mask
parameter. To write SPI registers, the "include SPI interface" option
should be activated in the x64\_adc yellow block parameters. This should
expose the input ports "sdata" and "spi\_strb" to the user. When a
positive edge is detected on spi\_strb, the data on sdata[3:0] is
written to address sdata[7:4]. Currently, due to limited ROACH GPIO and
lack of requirement, only one nCS signal is used by the yellow block.
This can be connected to all ADC nCS pins, to write registers on all
chips simultaneously.

Usage 
^^^^^^
The x64\_adc block can take 64 analog input streams. The inputs are
digitized to ``Fix_12_11`` numbers between [-1, 1).

ADC Synchronization
~~~~~~~~~~~~~~~~~~~
The ADC card uses 8 separate chips, each providing its own clock over
ZDOK to the FPGA. Rather than use all 8 clocks (some of which are not
connected to clock enabled FPGA pins), a single clock is used, and the
software calibration script `File:X64 adc
cal.txt <../../_static/files/X64_ADC/X64_adc_cal.txt>`__ is run to ensure that data from
all ADC chips is properly aligned.

Note: There may be a problem while running this script as is. In case
there is a problem While running the version available in the repository
and throws the following error: unknown'x64\_adc\_ctrl' variable, it can
be fixed by adding the following line to the core\_info.tab in the local
repository
(mlib\_devel/blob/master/xps\_base/XPS\_ROACH\_base/core\_info.tab)

#. IF# strcmp(get(b,'type'),'xps\_x64\_adc')#x64\_adc\_ctrl 3 10000 100

Also, the following line of calibration script which is no longer
supported by the 'corr' package can be removed (it seems this line was
just meant for debugging).

fclk\_sampled = self.bit\_string((val0&0x0fff),12)

Data Output
~~~~~~~~~~~
| The 64 channels digitized by the ADC are presented to the user as 16
  data output signals. Each signal will cycle through four multiplexed
  channels every four clock cycles. For example, in four consecutive
  clock cycles a sample from channels 0,1,2,3 will appear on output
  "dout0". In the following four clock cycles, the next time sample will
  appear. Output dout<n> is responsible for samples from channels
  4\ *n*, 4\ *n*\ +1, 4\ *n*\ +2 and 4\ *n*\ +3. Physically, ADC chip
  *m* is responsible for channels 8\ *m*, 8\ *m*\ +1, ..., 8\ *m*\ +7.
| It is possible to identify the channels presented on each output by
  observing the chan\_sync output, which is high when sample 4\ *n* is
  present on output dout<n>. The 8 bits of chan\_sync give the sync flag
  associated with each of the 8 ADC chips. Proper calibration should
  ensure that all chips are synchronized. In this case, the chan\_sync
  output should output zero, with the value 255 appearing once every
  four clocks.

Data Input
~~~~~~~~~~
Data can be input for simulation using the sim<n> and sim\_sync inputs.
These inputs are passed straight to the dout<n> and chan\_sync outputs,
and should be controlled accordingly, taking into account the data
output details above.