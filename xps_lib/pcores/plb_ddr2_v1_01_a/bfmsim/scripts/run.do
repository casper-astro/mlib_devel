##############################################################################
##
## ***************************************************************************
## **                                                                       **
## ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
## **                                                                       **
## ** You may copy and modify these files for your own internal use solely  **
## ** with Xilinx programmable logic devices and Xilinx EDK system or       **
## ** create IP modules solely for Xilinx programmable logic devices and    **
## ** Xilinx EDK system. No rights are granted to distribute any files      **
## ** unless they are distributed in Xilinx programmable logic devices.     **
## **                                                                       **
## ***************************************************************************
##
##############################################################################
## Filename:          /tmp/MyProcessorIPLib/pcores/plb_ddr2_v1_10_a/devl/bfmsim/scripts/run.do
## Description:       ModelSim Run Script - modify with your discretion
## Date:              Tue Jan 31 15:23:16 2006 (by Create and Import Peripheral Wizard)
##############################################################################

# Compile the DDR2 controller
do ../../scripts/load_ddr2.do

# Compile BFM test modules
do bfm_system.do

# Load BFM test platform
vsim -t 1ps -L xilinxcorelib_ver -L unisims_ver bfm_system

# Load Wave window
do ../../scripts/wave.do

# Load BFL
do ../../scripts/sample.do

# Start system clock and reset system
force -freeze sim:/bfm_system/my_core/my_core/ddr_clk 1 0, 0 {2.5 ns} -r 5ns
force -freeze sim:/bfm_system/sys_clk 1 0, 0 {5 ns} -r 10 ns
force -freeze sim:/bfm_system/sys_reset 1
force -freeze sim:/bfm_system/sys_reset 0 100 ns, 1 {200 ns}

# Run test time
run 250 us

# Release ModelSim simulation license
quit -sim

# Close previous dataset if it exists
if {[dataset info exists bfm_test]} {dataset close bfm_test}

# Open and view waveform
dataset open vsim.wlf bfm_test
do ../../scripts/wave.do
