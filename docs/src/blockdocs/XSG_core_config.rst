XSG Core Config
================
| **Block:** XSG Core Config (``XSG core config``)
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
The XSG Core Config block is used to configure the System Generator
design for the ``bee_xps`` toolflow. Settings here are used to configure
the Xilinx System Generator block parameters automatically, and control
toolflow script execution. It needs to be at the top level of all
designs being compiled with the ``bee_xps`` toolflow.

Mask Parameters 
----------------

+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| Parameter                            | Variable                | Description                                                               |
+======================================+=========================+===========================================================================+
| Hardware Platform                    | hw\_sys                 | Selects the board/chip to compile for.                                    |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| Include Linux add-on board support   | ibob\_linux             | Includes BORPH-capable Linux for IBOB.                                    |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| User IP Clock source                 | clk\_src                | Selects the clock on which to run the System Generator circuit.           |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| GPIO Clock Pin I/O group             | gpio\_clk\_io\_group    | Selects GPIO type to use as clock input if using user clock on an IBOB.   |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| GPIO Clock Pin bit index             | gpio\_clk\_bit\_index   | Selects GPIO pin to use as clock input if using user clock on an IBOB.    |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| User IP Clock rate (MHz)             | clk\_rate               | Generates timing constraints for the design.                              |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| Sample Period                        | sample\_period          | Sample period for Simulink simulations.                                   |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+
| Synthesis Tool                       | synthesis\_tool         | Selects the tool to use for synthesizing the design's netlist.            |
+--------------------------------------+-------------------------+---------------------------------------------------------------------------+

Ports 
------
None.

Description 
------------
The function of the XSG Core Config block is to set parameters for the
toolflow scripts. It supercedes the use of the Xilinx System Generator
block and has supplemental options for board-level parameters. Although
a System Generator block is still needed in all designs, the XSG Core
Config block automatically changes the System Generator block settings
based on its own parameters.

The settings in the XSG Core Config block are used to determine the
system-level conditions of the SysGen design. It sets which of the
toolflow-supported boards the design is being compiled for, from which
it determines what FPGA to target, as well as clocking options like
clock source and timing constraints. The Sample Period and Synthesis
Tool parameters are included in the block so that all system-level
options available in the System Generator block could be handled by this
single block.