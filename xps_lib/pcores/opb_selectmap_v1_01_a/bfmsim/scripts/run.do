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

# Compile FIFO
do load_fifo.do

# Compile BFM test modules
do bfm_system.do

# Load BFM test platform
vsim -t 1ns -L xilinxcorelib_ver -L unisims_ver bfm_system

# Load Wave window
do ../../scripts/wave.do

# Load BFL
do ../../scripts/sample.do

# Start system clock and reset system
force -freeze sim:/bfm_system/sys_clk 1 0, 0 {10 ns} -r 20 ns
force -freeze sim:/bfm_system/sys_reset 1
force -freeze sim:/bfm_system/sys_reset 0 100 ns, 1 {200 ns}

# Run test time
run 170 us

# Release ModelSim simulation license
quit -sim

# Close previous dataset if it exists
if {[dataset info exists bfm_test]} {dataset close bfm_test}

# Open and view waveform
dataset open vsim.wlf bfm_test
do ../../scripts/wave.do
