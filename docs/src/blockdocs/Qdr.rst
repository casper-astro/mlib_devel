QDR
====
| **Block:** QDR (``qdr``)
| **Block Author**: David George
| **Document Author**: David George

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
|    -  `Issuing Commands <#issuing-commands>`__                           |
|    -  `Bursting <#bursting>`__                                           |
|    -  `Addressing <#addressing>`__                                       |
|    -  `ECC Bits <#ecc-bits>`__                                           |
+--------------------------------------------------------------------------+

Summary 
--------
This block interfaces to the QDR SRAM devices on ROACH boards. Commands
are executed at the rate they are applied, with synchronous and fixed
timing. Data is always presented 10 cycles after a read is issued. Read
and write data ports have 100% duty cycles.

Mask Parameters 
----------------

+--------------------------------+---------------+-----------------------------------------------------------------------------------------------------------------+
| Parameter                      | Variable      | Description                                                                                                     |
+================================+===============+=================================================================================================================+
| QDR Chip                       | which\_qdr    | Selects which physical QDR device to use (Two on ROACH V1).                                                     |
+--------------------------------+---------------+-----------------------------------------------------------------------------------------------------------------+
| Simulation QDR Address Width   | qdr\_awidth   | Specifies the width of the address bus of the simulation model. (Limited to 18)                                 |
+--------------------------------+---------------+-----------------------------------------------------------------------------------------------------------------+
| Use CPU Interface              | use\_cpu      | Specify whether or not to include the QDR CPU interface, the removal of which may improve timing performance.   |
+--------------------------------+---------------+-----------------------------------------------------------------------------------------------------------------+

Ports 
------

+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Port          | Dir   | Data Type   | Description                                                                                                                                                                                 |
+===============+=======+=============+=============================================================================================================================================================================================+
| rd\_en        | in    | boolean     | Asserting this signal issues a read command. See below for details on issuing commands.                                                                                                     |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| wr\_en        | in    | boolean     | Asserting this signal issues a write command. See below for details on issuing commands.                                                                                                    |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| be            | in    | UFix\_4     | Selects bytes for writing (write byte enable). See below for behaviour relating to bursting and ECC bits.                                                                                   |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| address       | in    | UFix\_32    | Signal used as the QDR address. See below for behaviour relating to addressing.                                                                                                             |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| wr\_data      | out   | UFix\_36    | The data to written into the QDR. Bits 35:32 are ECC bits and are cleared when the processor writes to the corresponding byte. See below for behaviour relating to bursting and ECC bits.   |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| data\_valid   | out   | boolean     | An active high signal indicating that the read data is valid.                                                                                                                               |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| ack           | out   | boolean     | A signal indicating that the CPU interface is not accessing the memory.                                                                                                                     |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| phy\_ready    | out   | boolean     | A signal indicating that the QDR PHY has completed calibration, which takes very roughly 100us.                                                                                             |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| cal\_fail     | out   | boolean     | A signal indicating that the PHY calibration has failed.                                                                                                                                    |
+---------------+-------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Description 
------------
This document is a draft and requires verification.

Issuing Commands 
^^^^^^^^^^^^^^^^^
There are two types of commands: reads and writes. They are issued by
the rd\_en and wr\_en signals respectively. The QDR address is presented
on the same cycle that the command is issues. One type of command cannot
be issued in two consecutive cycles. When this happens, the second issue
will be ignored. This is due to QDR supporting bursts to reduce data
rates on the control signals. Further, if a read and write are issued at
the same time the write will be ignored. However, if the previous
command was a valid read, the current read will be ignored and the write
will take preference.

Bursting 
^^^^^^^^^
When issuing reads and writes, data is presented on the respective data
ports for two cycles. When issuing a write command, the ``data_in`` and
``be`` ports must be set for both the issuing cycle and the following
cycle. During a read response, data is issued on the same cycle that the
data\_valid is asserted and on the following cycle.

Addressing 
^^^^^^^^^^^
The address presented when a command is issued addresses a full burst
worth of memory i.e. 72 bits of data.

ECC Bits 
^^^^^^^^^
In hardware the QDR word is composed of four 9 bit components which are
masked by the byte\_enable signal. Each of these component include 8
data bits and a single ECC bit. This clashes with the byte-enable on the
processor, which mask only 8 bits. For this reason the ECC bit gets
cleared when the CPU writes to a byte of QDR memory. With this yellow
block, the QDR data\_in and data\_out ports have the ECC bits on lines
35:32. This allows the four processor bytes to cleanly map to bits 31:0
of the data\_in and data\_out ports. This leads to a side-effect in the
byte-enable behaviour as follows: be[0] masks data\_in bits [7:0] and
[32], be[1] mask data\_in bits[15:8] and [33] etcetera.