Software Register
==================
| **Block:** Software Register (``software register``)
| **Block Author**: Pierre-Yves Droz
| **Document Author**: Henry Chen

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
Inserts a unidirectional 32-bit register shared between the FPGA design
and the PowerPC bus.

Mask Parameters 
----------------

+---------------------+------------------+---------------------------------------------------------------------------------+
| Parameter           | Variable         | Description                                                                     |
+=====================+==================+=================================================================================+
| I/O direction       | io\_dir          | Chooses whether register writes ``To Processor`` or reads ``From Processor``.   |
+---------------------+------------------+---------------------------------------------------------------------------------+
| Data Type           | arith\_type      | Specifies data type of register.                                                |
+---------------------+------------------+---------------------------------------------------------------------------------+
| Data bitwidth       | bitwidth         | Specifies data bitwidth. Hard-coded at 32 bits.                                 |
+---------------------+------------------+---------------------------------------------------------------------------------+
| Data binary point   | bin\_pt          | Specifies the binary point position of data.                                    |
+---------------------+------------------+---------------------------------------------------------------------------------+
| Sample period       | sample\_period   | Specifies sample period of interface.                                           |
+---------------------+------------------+---------------------------------------------------------------------------------+

Ports 
------

+------------+-------+-------------+------------------------------------------------------------------------+
| Port       | Dir   | Data Type   | Description                                                            |
+============+=======+=============+========================================================================+
| reg\_out   | in    | inherited   | Output from design to processor bus. Only in ``To Processor`` mode.    |
+------------+-------+-------------+------------------------------------------------------------------------+
| sim\_out   | out   | double      | Simulation output of register value. Only in ``To Processor`` mode.    |
+------------+-------+-------------+------------------------------------------------------------------------+
| sim\_in    | in    | double      | Simulation input of register value. Only in ``From Processor`` mode.   |
+------------+-------+-------------+------------------------------------------------------------------------+
| reg\_in    | out   | inherited   | Input from processor bus to design. Only in ``From Processor`` mode.   |
+------------+-------+-------------+------------------------------------------------------------------------+

Description 
------------
A software register is a ``shared`` interface, meaning that it is
attached to both the FPGA fabric of the System Generator design as well
as the PowerPC bus. The registers are unidirectional; the user must
choose at design-time whether the register is in ``To Processor`` mode
(written by the FPGA fabric and read by the PowerPC) or in
``From Processor`` mode (written by the PowerPC and read by the FPGA
fabric).

The bitwidth is fixed at 32 bits, as it is attached to a 32-bit bus, but
the Simulink interpretation of the data type and binary point is
controllable by the user. The data type and binary point parameters
entered into the mask are enforced by the block; the block will cast to
the specified data type and binary point going in both directions.