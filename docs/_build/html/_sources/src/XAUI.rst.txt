XAUI
=====
| **Block:** XAUI Transceiver (``XAUI``)
| **Block Author**: Pierre Yves Droz, Henry Chen
| **Document Author**: Jason Manley

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
| -  `Mask Parameters <#mask-Parameters>`__                                |
| -  `Ports <#ports>`__                                                    |
| -  `Description <#description>`__                                        |
|                                                                          |
|    -  `Demux <#demux>`__                                                 |
|    -  `Out of band signals <#out-of-band-signals>`__                     |
+--------------------------------------------------------------------------+

Summary 
--------
XAUI block for sending and receiving point-to-point, streaming data over
the BEE2 and iBOB's CX4 connectors. NOTE: A new version of this block is
in development.

Mask Parameters 
----------------

+----------------------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Parameter            | Variable    | Description                                                                                                                                                                         |
+======================+=============+=====================================================================================================================================================================================+
| Demux                | demux       | Selects the width of the data bus. 1 for 64 bits, 2 for 32 bits.                                                                                                                    |
+----------------------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Port                 | port        | Selects the physical CX4 port on the iBOB or BEE2. The iBOB has two ports; the BEE2 has two for the control FPGA and four for each of the user FPGAs. CORR is not used by CASPER.   |
+----------------------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Pre-emphasis         | pre\_emph   | Selects the pre-emaphasis to use over the physical link. Default: 3 (see Xilinx documentation)                                                                                      |
+----------------------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Differential Swing   | swing       | Selects the size of the differential swing to use in mV. Default: 800 (see Xilinx documentation)                                                                                    |
+----------------------+-------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Ports 
------

+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| Port               | Dir       | Data Type                    | Description                                                                                                            |
+====================+===========+==============================+========================================================================================================================+
| rx\_get            | in        | boolean                      | Used to request the next data word from the RX buffer.                                                                 |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| rx\_reset          | in        | boolean                      | Resets the receive subsystem.                                                                                          |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| tx\_data           | in        | ufix\_64\_0 or ufix\_32\_0   | Accepts the next data word (64 or 32 bits) to be transmitted.                                                          |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| tx\_outofband      | in        | ufix\_8\_0 or ufix\_4\_0     | Accepts the next data word (8 bits if demux=1, 4 bits if demux=2) to be transmitted through the out-of-band channel.   |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| tx\_valid          | out       | boolean                      | Clocks the transmit data into the transceiver. Data is clocked into the buffer while this line is high.                |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| rx\_data           | out       | ufix\_64\_0                  | Outputs the received data stream.                                                                                      |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| rx\_outofband      | out       | ufix\_8\_0 or ufix\_4\_0     | Outputs the out-of-band received data stream.                                                                          |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| rx\_empty          | out       | boolean                      | Indicates that the receive buffer is empty.                                                                            |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| rx\_valid          | out       | boolean                      | Indicates that data has been received.                                                                                 |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| rx\_linkdown       | out       | boolean                      | Indicates that the link is down (eg. faulty cable).                                                                    |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| tx\_full           | out       | boolean                      | Indicates the transmit buffer is full.                                                                                 |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+
| rx\_almost\_full   | boolean   | inherited                    | Indicates the receive buffer is full.                                                                                  |
+--------------------+-----------+------------------------------+------------------------------------------------------------------------------------------------------------------------+

Description 
------------
Demux 
^^^^^^
Perhaps a misnomer, this parameter describes the width of the data bus
rather than a selection of two muxed streams on one channel. At 156MHz
XAUI clock, the maximum transmission speed is 64bits \* 156.25 MHz =
10Gbit/s. For BEE or iBOB designs clocked at rates above 156MHz,
clocking-in 64 bit data on every clock cycle would cause the XAUI
block's FIFO buffers to overflow. The ``demux`` option is provided which
halves the input data bus width to 32 bits and enables data to be
clocked-in on every FPGA clock cycle. Along with the data bus width, the
``out of band`` bus width is also halved to 4 bits.

Out of band signals 
^^^^^^^^^^^^^^^^^^^^
Out of band signals are guaranteed to arrive at the same time as the
data word with which they were sent. Out-of-band data is only
transmitted across the physical link if the input to ``tx_outofband``
changes and is clocked in as valid (``tx_valid``). In other words, if
you keep ``tx_outofband`` constant, no additional bandwidth is consumed
(the in-band signals are transmitted as normal). When data is clocked
into the transmitter, it will appear out the receiver as if the
``tx_outofband`` and ``tx_data`` arrived simultaneously. Care should be
taken to ensure that the data clocked into ``tx_outofband`` and
``tx_data`` does not exceed the XAUI's maximum transmission rate
(approximately 10Gbps for 156.25MHz clock). Each change of
``tx_outofband`` (be it one bit or eight bits) requires 64 bits (a full
word) to transmit. This bus width is 8 bits if ``demux`` is not selected
(set to 1), and 4 bits if it is set to 2.