------------------------------------------------------------------------------
--
-- BFM simulation Guide
--
------------------------------------------------------------------------------


Requirements
------------------------------------------------------------------------------
- ISE 6.3i or later
- EDK 6.3i or later
- ModelSim 5.8d or later (see Solution Record 19998 for 5.8 issues)
- EDK BFM package installed
- ISE simulation libraries compiled (COMPXLIB)
- EDK simulation libraries compiled (COMPEDKLIB)


BFM Simulation Command Line Flow
------------------------------------------------------------------------------
1. Open any command/shell window, e.g. DOS or Xygwin, and go to this
   bfmsim directory.

2. Open the bfm_sim_cmd.make file, e.g. in DOS edit or Xygwin vi, to edit
   the following two stwitches if no (or incorrect) value is provided:

   ISELIB_OPT = -X <ISE simulation library path>
   EDKLIB_OPT = -E <EDK simulation library path>

   Save and close the make file, no other edits are required.

3. Type command 'make -f bfm_sim_cmd.make sim' (without the single quotes)
   to start BFM simulation.


BFM Simulation XPS Flow
------------------------------------------------------------------------------

1. Open this bfm_system.xmp project in XPS.

2. Click Options -> Project Options ... to open up the Project Options
   dialog and specify the following options:

   - Device and Repository -
     * select the Architecture, Device Size, Package and Grade you desired
       in the Target Device group.
     * no other changes are necessary.

   - Hierarchy and Flow -
     * accept all defaults, no change.

   - HDL and Simulation -
     * select the simulator you desire in the Simulator Compile Script group.
     * specify EDK Library and Xilinx Library paths in the Simulation Libraries
       Path group if they are blank.
     * make sure VHDL is selected in the HDL group.
     * make sure Behavioral is selected in the Simulation Models group.

3. Click Tools -> Generate Simulation HDL files in XPS to generate the BFM
   simulation platform.

4. Click on User Button 1 to start BFM simulation.


Documentation
------------------------------------------------------------------------------
Please refer to the following documents for details of BFM simulation in EDK:
- <EDK_Install>/third_party/doc/OpbToolKit.pdf
- <EDK_Install>/third_party/doc/PlbToolKit.pdf
- <EDK_Install>/doc/bfm_simulation.pdf
- <EDK_Install>/doc/ps_ug.pdf chapter 8 Simulation in EDK


