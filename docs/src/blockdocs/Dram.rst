DRAM
======
| **Block:** DRAM (``dram``)
| **Block Author**: Pierre Yves Droz (BEE2), David George(ROACH)
| **Document Author**: Jason Manley, Laura Spitler

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
|    -  `BEE2 Specific Info <#bee2-specific-info>`__                       |
|                                                                          |
|       -  `Addressing <#addressing>`__                                    |
|       -  `Data bus width <#data-bus-width>`__                            |
|                                                                          |
|    -  `ROACH Specific Info <#roach-specific-info>`__                     |
|                                                                          |
|       -  `Interfacing Details <#interfacing-details>`__                  |
|       -  `DRAM CPU interface <#dram-cpu-interface>`__                    |
|       -  `Example models <#example-models>`__                            |
|                                                                          |
|    -  `Performance Tips <#performance-tips>`__                           |
+--------------------------------------------------------------------------+

Summary 
---------
This block interfaces to the BEE2+ROACH's 1GB DDR2 ECC DRAM modules.
Commands that are clocked-in are executed with an unknown delay,
however, execution order is maintained. The underlying controller for
the BEE2 and the ROACH are different and not all features are supported
across both platforms (see below for details).

Mask Parameters 
-----------------

+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Parameter                         | Variable         | Description                                                                                                                                                                                                                                                                           |
+===================================+==================+=======================================================================================================================================================================================================================================================================================+
| DIMM                              | dimm             | Selects which physical DIMM to use (four per user FPGA).                                                                                                                                                                                                                              |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Data Type                         | arith\_type      | Inform Simulink how it should interpret the stored data.                                                                                                                                                                                                                              |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Data binary point                 | bin\_pt          | Inform Simulink how it should interpret the stored data - specifically, the bit position in the word where it should place the binary point.                                                                                                                                          |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Datapath clock rate (MHz)         | ip\_clock        | Clock rate for DRAM. Default: 200MHz (400DDR).                                                                                                                                                                                                                                        |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Sample period                     | sample\_period   | Is significant for clocking the block. Default: 1                                                                                                                                                                                                                                     |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Simulate DRAM using ModelSim      | use\_sim         | Requires the addition of the ModelSim block at the top level of the design. Used to simulate DRAM block only.                                                                                                                                                                         |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Lesser Simulation Address Width   |  ???             | If the ModelSim simulation is disabled a very basic simulation using BRAMs will be performed. This parameter selects the address width to the bram memory and cannot exceed 20 (or so) bits.                                                                                          |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Enable bank management            | bank\_mgt        | *Advise leave off for BEE2.* Allows multiple banks to be open at the same time. *Always enabled on ROACH (setting ignored).*                                                                                                                                                          |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Use wide data bus (288 bits)      | wide\_data       | Burst writes require 288 bits. If not selected, provide a 144 bit bus which needs to be supplied with data in consecutive clock cycles to form the 288 bits. 288 bit bus can make for challenging routing! *Not implemented on ROACH.*                                                |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Use half-burst                    | half\_burst      | Only store 144 bits per burst (wastes half capacity as the second 144 bits are unusable). If enabled, requires at least two clock cycles to store 144 bits. Second clock cycle's data is forfeited. *Not implemented on ROACH.*                                                       |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Use BRAM FIFOs                    | bram\_fifos      | Use blockRAM FIFO's in DRAM controller. This is required only if the application clock rate is less than the dram clock rate to avoid overflows on the read interface. By default distributed RAM will be used which exhibits better timing performance and reduces BRAM resources.   |
| *(ROACH only)*                    |                  |                                                                                                                                                                                                                                                                                       |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Include CPU Interface             | use\_sniffer     | Includes the CPU interface which allows direct DRAM access from software. Including this may introduce timing issues at very high DRAM controller frequencies.                                                                                                                        |
| *(ROACH only)*                    |                  |                                                                                                                                                                                                                                                                                       |
+-----------------------------------+------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Ports 
-------

+--------------------+--------------------+--------------------+--------------------+
| Port               | Dir                | Data Type          | Description        |
+====================+====================+====================+====================+
| rst                | in                 | boolean            | Resets the block   |
|                    |                    |                    | when pulsed high   |
+--------------------+--------------------+--------------------+--------------------+
| address            | in                 | UFix\_32\_0        | A signal which     |
|                    |                    |                    | accepts the        |
|                    |                    |                    | address. See below |
|                    |                    |                    | for details.       |
+--------------------+--------------------+--------------------+--------------------+
| data\_in           | in                 | 144 or 288 bit     | Accepts data to be |
|                    |                    | unsigned           | saved to DRAM.     |
+--------------------+--------------------+--------------------+--------------------+
| wr\_be             | in                 | UFix\_18\_0 or     | Selects bytes for  |
|                    |                    | UFix\_36\_0        | writing (write     |
|                    |                    |                    | byte enable). It   |
|                    |                    |                    | is normally 18     |
|                    |                    |                    | bits wide for a    |
|                    |                    |                    | 144 bit data bus,  |
|                    |                    |                    | but if 288 bit     |
|                    |                    |                    | data bus is        |
|                    |                    |                    | selected, this     |
|                    |                    |                    | becomes a 36 bit   |
|                    |                    |                    | variable.          |
+--------------------+--------------------+--------------------+--------------------+
| RWn                | in                 | boolean            | Selects read or    |
|                    |                    |                    | not-write. ``1``   |
|                    |                    |                    | for read, ``0``    |
|                    |                    |                    | for write.         |
+--------------------+--------------------+--------------------+--------------------+
| cmd\_tag           | in                 | UFix\_32\_0        | Accepts a          |
|                    |                    |                    | user-defined tag   |
|                    |                    |                    | for labelling      |
|                    |                    |                    | entered commands.  |
|                    |                    |                    | *Not implemented   |
|                    |                    |                    | on ROACH.*         |
+--------------------+--------------------+--------------------+--------------------+
| cmd\_valid         | in                 | boolean            | Clocks data into   |
|                    |                    |                    | the command        |
|                    |                    |                    | buffer.            |
+--------------------+--------------------+--------------------+--------------------+
| rd\_ack            | out                | boolean            | Used to            |
|                    |                    |                    | acknowledge that   |
|                    |                    |                    | the last           |
|                    |                    |                    | ``data_out`` value |
|                    |                    |                    | has been read.     |
+--------------------+--------------------+--------------------+--------------------+
| cmd\_ack           | out                | boolean            | Acknowledges that  |
|                    |                    |                    | the last command   |
|                    |                    |                    | was accepted (when |
|                    |                    |                    | buffer is full,    |
|                    |                    |                    | will not accept    |
|                    |                    |                    | additional         |
|                    |                    |                    | commands).         |
|                    |                    |                    | ROACH: Pin HI      |
|                    |                    |                    | unless an attempt  |
|                    |                    |                    | to clock in a      |
|                    |                    |                    | command failed     |
+--------------------+--------------------+--------------------+--------------------+
| data\_out          | out                | UFix\_144\_0       | Outputs data from  |
|                    |                    |                    | DRAM, 144 bits at  |
|                    |                    |                    | a time. Reads are  |
|                    |                    |                    | in groups of 288   |
|                    |                    |                    | bits (ie, 2        |
|                    |                    |                    | clocks).           |
+--------------------+--------------------+--------------------+--------------------+
| rd\_tag            | out                | UFix\_32\_0        | Outputs the        |
|                    |                    |                    | identifier for the |
|                    |                    |                    | data on            |
|                    |                    |                    | ``data_out`` (as   |
|                    |                    |                    | submitted on       |
|                    |                    |                    | ``cmd_tag`` when   |
|                    |                    |                    | the command was    |
|                    |                    |                    | issued). *Not      |
|                    |                    |                    | implemented on     |
|                    |                    |                    | ROACH.*            |
+--------------------+--------------------+--------------------+--------------------+
| rd\_valid          | out                | boolean            | Indicates that the |
|                    |                    |                    | data on            |
|                    |                    |                    | ``data_out`` is    |
|                    |                    |                    | valid.             |
+--------------------+--------------------+--------------------+--------------------+

Description 
--------------
BEE2 Specific Info 
^^^^^^^^^^^^^^^^^^^^
Core details about the BEE2 memory interface can be found at the
(static) BEE2 wiki:

http://bee2.eecs.berkeley.edu/wiki/Bee2Memory.html

Addressing 
~~~~~~~~~~~
The 1GB storage DIMMs have 18 512Mbit chips each. They are arranged as
64Mbit x 8 (bus width) x 9 (chips per side/rank) x 2 (sides/ranks). Two
ranks (sides) per module with the 9 memory ICs connected in parallel,
each holding 8 bits of the data bus width (72 bits). Each IC has four
banks, with 13 bits of row addressing and 10 bits for column addressing.
Normally, each address would hold 64 bits + parity (8 bits), however,
the BEE2 uses the parity space as additional data storage giving a
capacity of 1.125 GB per DIMM module.

From Micron's datasheet on the *MT47H64M8CD-37E* (as used by CASPER in
its Crucial 1GB *CT12872AA53E* modules): The double data rate
architecture is essentially a 4n-prefetch architecture, with an
interface designed to transfer two data words per clock cycle at the I/O
balls. A single read or write access effectively consists of a single
4n-bit-wide, one-clock-cycle data transfer at the internal DRAM core and
four corresponding n-bit-wide, one-half-clock-cycle data transfers at
the I/O balls.

Reads and writes must thus occur four-at-a-time. 4 x 72bits = 288 bits.
Although the mapping of the logical to physical addressing is abstracted
from the user, it is useful to know how the DRAM block's address bus is
derived, as it impacts performance:

+------------+--------------------+
| Addressing | Assignment         |
+============+====================+
| Column     | 12 |rightarrow| 3  |
+------------+--------------------+
| Rank       | 13                 |
+------------+--------------------+
| Row        | 27 |rightarrow| 14 |
+------------+--------------------+
| Bank       | 29 |rightarrow| 28 |
+------------+--------------------+
| not used   | 31 |rightarrow| 30 |
+------------+--------------------+

Address bit assignments

Each group of 8 addresses selects a 144 bit logical location (the lowest
3 bits are ignored). For example, address ``0x00`` through ``0x7`` all
address the same 144 bit location. To address consecutive locations,
increment the address port by eight. There are thus a total of
2\ :sup:`27` possible addresses. The block supports 2GB DIMMs
(UNCONFIRMED) since 14 bits of addressing are reserved for row
selection. The 1GB DIMMs using Micron 512Mb chips, however, only use 13
bits for row selection which results in 2\ :sup:`26` possible address
locations. Care should be taken when addressing the 1GB DIMMS as bit 27
of the address range is not valid. However, bits 28 and 29 are mapped.
Since bit 27 is ignored, it results in overlapping memory spaces.

Data bus width 
~~~~~~~~~~~~~~~~
The BEE2 uses ECC DRAM, however, the parity bits are used for data
storage rather than parity storage. Thus, the data bus is 72 bits wide
instead of the usual 64 bits.

The memory module has a DDR interface requiring two reads or writes per
RAM clock cycle (~200MHz), thus requiring the user to provide 144 bits
per clock cycle. Furthermore, as outlined above, data has to be captured
in batches of 288 bits. This can be done in one of two ways: in two
consecutive blocks of 144 bits, or over a single 288 bit-wide bus. This
is selectable as a mask parameter. If half-burst is selected, only a 144
bit input is required. 288 bits are still written to DRAM, but the
second 144 bits are not specified. Thus, half of the DRAM capacity is
unusable.

ROACH Specific Info 
^^^^^^^^^^^^^^^^^^^^^^
The ROACH DRAM infrastructure currently doesn't support half burst and
wide data modes. Bank management is always enabled. Tag buffers are not
implemented. The DRAM controller clock rate can be one of the following:
150, 200, 266, 300 or 333. If a frequency other than these is provided
the default of 266 will be used. The dram controller has been known to
work at 300MHz.

Interfacing Details 
~~~~~~~~~~~~~~~~~~~~~
To write data into the DRAM, 'RWn' is held low, 'cmd\_valid' is held
high for a minimum of two FPGA clocks, and the 'address' port is held
constant for both clock cycles. For example, to write into addresses
0x00 and 0x01, keep the address at 0x00 for both clocks. To read data
out of the DRAM, hold 'RWn' high, keep the address constant for two FPGA
clock cycles, and toggle the 'cmd\_valid' pin every clock. Note that a
new word will be available on the 'data\_out' pin on every clock cycle.
'rd\_valid' will frame valid output data some indeterminate number of
clock cycles after the read 'cmd\_valid' toggles. 'cmd\_ack' is high
unless an attempt to write a command into the input FIFO failed, at
which point it will go low synchronously with the issuing of the failed
command.

Many ROACHs have been shipped with 1 GB dual rank DIMMs by default. The
current DRAM controller is not able to handle multiple ranks, so when a
dual-rank DIMM is installed on the board, only half the memory is
available. In order to use the full 1 GB, a single rank DIMM is needed,
or in principle a dual rank 2 GB module.

Note that on the ROACH all of the oddities of the DRAM addressing
specified above for the BEE2 version are taken care of for you, so you
can just directly address locations 0 to (2^30 / 16) = 2^26 in the
hardware.

DRAM CPU interface 
~~~~~~~~~~~~~~~~~~~~
If the block mask was set to include the CPU interface, the DRAM can be
accessed by bytes through BORPH through 'dram\_memory'. The width of the
CPU interface is only 128 bits (16 bytes), which results in discrepancy
between hardware and CPU address. After every 64 bits, there are 8 ECC
bits not visible to the CPU. For example bytes 0x00-0x07 in the DRAM are
seen as 0x00-0x07 in the CPU, byte 0x08 in the DRAM is not visible to
the CPU, and byte 0x09 in the DRAM is seen as byte 0x08 in the CPU.

Only 64MB of DRAM can be mapped into the 'dram\_memory' register at any
given time. You can select which 64MB segment is mapped into the
'dram\_memory' register though the first 32-bit word of the
'dram\_controller' register. For example, to access the first 64MB chunk
of DRAM write 0x0 into this register and for the second 0x1.

The DRAM is most easily accessed using the KATCP function "read\_dram".

The second 32-bit word in the 'dram\_controller' register indicates the
DRAM controller ready flag. This value stores will be 0x1 if the
controller is operational. If it is not your DRAM will not operate at
all. Typical problems causing this would include using an unsupported
RDIMM.

| 

Example models 
~~~~~~~~~~~~~~~~

1) David George's million channel ROACH spectrometer ("buf" block):
`rmspec.mdl <../../_static/files/rmspec.mdl>`__

2) Laura Spitler's simple design that reads and writes a counter into
the DRAM: `Dram roach
rwramp.mdl <../../_static/files/Dram_roach_rwramp.mdl>`__

3) Jason Manley's DRAM counter example: `Dram counter test 10
1.gz <../../_static/files/Dram_counter_test_10_1.gz>`__

4) Tim Madden's DRAM streaming output design (April 2015)
https://github.com/argonnexraydetector/RoachFirmPy

Performance Tips 
^^^^^^^^^^^^^^^^^^^
The performance of the DRAM block is dependent on the relative location
of the addressed data and whether or not the mode (read/write) is
changed. For example, consecutive column addresses can be written
without delay, however, changing rows or banks incur delay penalties.
See above for the address bit assignment.

To obtain optimum performance, it is recommended that the least
significant bits be changed first (ie address the memory from
``0x0000000`` through to address ``0x20000000`` on the BEE2). This will
increment column addresses first, followed by rank change, both of which
incur little delay. Changing rows or banks can take twice as long.
Further information can be found in the DRAM module's datasheet (Micron
*MT47H64M8* on the BEE2).

Changing the mode(read/write) results in large delays, so it is
recommended that read and writes be done in bursts into consecutive
addresses. For a fabric clock speed of 200 MHz and DRAM speed of 266
MHz, a burst length of at least 32 words is recommended.

Bank management allows for three banks to be open simultaneously,
reducing the overhead when switching between these banks. This feature
is always enabled on ROACH, but YMMV with the BEE2 controller.

.. |rightarrow| image:: ../../_static/img/rightarrow.png
   :class: tex