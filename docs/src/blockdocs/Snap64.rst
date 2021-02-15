64 Bit Snapshot
================
| **Block:** 64 Bit Snapshot (``snap64``)
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
---------
The snap block provides a packaged solution for capturing data from the
FPGA fabric and making it accessible from the CPU. Snap64 captures to
2x32 bit wide shared BRAMs to effect a 64 bit capture.

Mask Parameters 
----------------

+--------------------------------+------------+-------------------------------------------------------------------------------------------------------------+
| Parameter                      | Variable   | Description                                                                                                 |
+================================+============+=============================================================================================================+
| No. of Samples (2\ :sup:`?`)   | nsamples   | Specifies the depth of the Shared BRAM(s); i.e. the number of 64bit samples which are stored per capture.   |
+--------------------------------+------------+-------------------------------------------------------------------------------------------------------------+

Ports 
------

+--------+-------+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------+
| Port   | Dir   | Data Type         | Description                                                                                                                                   |
+========+=======+===================+===============================================================================================================================================+
| din    | IN    | unsigned\_64\_0   | The data to be captured. Regardless of type, the bit-level representation of these numbers are written as 64bit values to the Shared BRAMs.   |
+--------+-------+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------+
| trig   | IN    | boolean           | When high, triggers the beginning of a data capture. Thereafter, every enabled data is written to the shared BRAM until it is full.           |
+--------+-------+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------+
| we     | IN    | boolean           | After a trigger is begun, enables a write to Shared BRAM.                                                                                     |
+--------+-------+-------------------+-----------------------------------------------------------------------------------------------------------------------------------------------+

Description 
------------
Usage 
^^^^^^^^
Under TinySH/BORPH, this device will have 3 sub-devices: ``ctrl``,
``bram_msb``, ``bram_lsb``, and ``addr``. ``ctrl`` is an input register.
Bit 0, when driven from low to high, enables a trigger/data capture to
occur. Bit 1, when high, overrides ``trig`` to trigger instantly. Bit 2,
when high, overrides ``we`` to always write data to bram. ``addr`` is an
output register and records the last address of bram to which data was
written. ``bram_msb`` and ``bram_lsb`` are 32 bit wide Shared BRAMs of
the depth specified in ``Parameters``. ``bram_msb`` holds the upper 32
bits of ``din`` while ``bram_lsb`` holds the lower 32 bits of ``din``.