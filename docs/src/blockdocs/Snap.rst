Snapshot Capture
=================
| **Block:** Snapshot Capture (``snap``)
| **Block Author**: Aaron Parsons
| **Document Author**: Aaron Parsons, Ben Blackman

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
+--------------------------------------------------------------------------+

Summary 
--------
The snap block provides a packaged solution for capturing data from the
FPGA fabric and making it accessible from the CPU. Snap captures to a 32
bit wide shared BRAM.

Mask Parameters 
----------------

+--------------------------------+------------+-------------------------------------------------------------------------------------------------------------+
| Parameter                      | Variable   | Description                                                                                                 |
+================================+============+=============================================================================================================+
| No. of Samples (2\ :sup:`?`)   | nsamples   | Specifies the depth of the Shared BRAM(s); i.e. the number of 32bit samples which are stored per capture.   |
+--------------------------------+------------+-------------------------------------------------------------------------------------------------------------+

Ports 
------

+--------+-------+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------+
| Port   | Dir   | Data Type         | Description                                                                                                                                  |
+========+=======+===================+==============================================================================================================================================+
| din    | IN    | unsigned\_32\_0   | The data to be captured. Regardless of type, the bit-level representation of these numbers are written as 32bit values to the Shared BRAM.   |
+--------+-------+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------+
| trig   | IN    | boolean           | When high, triggers the beginning of a data capture. Thereafter, every enabled data is written to the shared BRAM until it is full.          |
+--------+-------+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------+
| we     | IN    | boolean           | After a trigger is begun, enables a write to Shared BRAM.                                                                                    |
+--------+-------+-------------------+----------------------------------------------------------------------------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^
Under TinySH/BORPH, this device will have 3 sub-devices: ``ctrl``,
``bram``, and ``addr``. ``ctrl`` is an input register. Bit 0, when
driven from low to high, enables a trigger/data capture to occur. Bit 1,
when high, overrides ``trig`` to trigger instantly. Bit 2, when high,
overrides ``we`` to always write data to bram. ``addr`` is an output
register and records the last address of ``bram`` to which data was
written. ``bram`` is a 32 bit wide Shared BRAM of the depth specified in
``Parameters``.