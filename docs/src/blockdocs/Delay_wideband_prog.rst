Programmable Wideband Delay
============================
| **Block:** Programmable Wideband Delay (``delay_wideband_prog``)
| **Block Author**: Jason Manley, Mekhala Muley
| **Document Author**: Jason Manley, Mekhala Muley

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
A delay block that uses single port BRAM for its storage and has a
run-time programmable delay for simultaneous inputs.

Mask Parameters 
-----------------

+---------------------------------------+-------------------+--------------------------------------------------------------------------------------------------+
| Parameter                             | Variable          | Description                                                                                      |
+=======================================+===================+==================================================================================================+
| Max Delay                             | max\_delay        | The maximum length of delay which can be provided (in sample clock cycles).                      |
+---------------------------------------+-------------------+--------------------------------------------------------------------------------------------------+
| Number of simultaneous inputs (2^?)   | n\_inputs\_bits   | Number of sequential time series inputs (specified in power of 2) required to the delay block.   |
+---------------------------------------+-------------------+--------------------------------------------------------------------------------------------------+
| BRAM Latency                          | bram\_latency     | The latency of the underlying storage BRAM.                                                      |
+---------------------------------------+-------------------+--------------------------------------------------------------------------------------------------+
| Select type of BRAM                   | bram\_type        | Selects the type of BRAM (Single or Dual Port) to be used by the delay module.                   |
+---------------------------------------+-------------------+--------------------------------------------------------------------------------------------------+

Ports 
-------

+-------------+-------+--------------------+-----------------------------------------------------------------------------------+
| Port        | Dir   | Data Type          | Description                                                                       |
+=============+=======+====================+===================================================================================+
| delay       | in    | Unsigned Integer   | The runtime programmable delay value.                                             |
+-------------+-------+--------------------+-----------------------------------------------------------------------------------+
| sync        | in    | Boolean            | Sync pulse to synchronize this delay block with the other blocks in the design.   |
+-------------+-------+--------------------+-----------------------------------------------------------------------------------+
| data\_in    | in    |  ???               | The simultaneous signals to be delayed.                                           |
+-------------+-------+--------------------+-----------------------------------------------------------------------------------+
| sync\_out   | out   | boolean            | Synchronizing output pulse from the delay block.                                  |
+-------------+-------+--------------------+-----------------------------------------------------------------------------------+
| data\_out   | out   | inherited          | The delayed simultaneous outputs.                                                 |
+-------------+-------+--------------------+-----------------------------------------------------------------------------------+

Description 
-------------
A delay block that uses single port BRAM for its storage and has a
run-time programmable delay for sequential time series inputs. The block
incurs a minimum delay as specified at the bottom of the block name. By
default this is added to the user's requested delay.

Maximum delay should be in terms of powers of 2, if not, the block
converts the maximum delay provided by user to the nearest power of 2.

Single port BRAM introduces glitches in the output if the programmable
runtime delay is increased campared to the last entry. The minimum
acceptable BRAM latency (Single and Dual Port) is 1, by default kept at
4.