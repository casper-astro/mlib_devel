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

# Map in the DDR2 infrastructure, DDR2 controller, and async DDR2
vlib opb_framebuffer_v2_00_a
vlib multiport_ddr2_v2_00_a
vlib async_ddr2_v2_00_a
vlib ddr2_infrastructure_v2_00_a
vlib ddr2_controller_v2_00_a

vmap opb_framebuffer_v2_00_a ../../pcores/opb_framebuffer_v2_00_a
vmap multiport_ddr2_v2_00_a ../../pcores/multiport_ddr2_v2_00_a
vmap async_ddr2_v2_00_a ../../pcores/async_ddr2_v2_00_a
vmap ddr2_infrastructure_v2_00_a ../../pcores/ddr2_infrastructure_v2_00_a
vmap ddr2_controller_v2_00_a ../../pcores/ddr2_controller_v2_00_a

# Compile BFM test modules
do bfm_system.do

# Load BFM test platform
vsim -t 1ps -L xilinxcorelib_ver -L unisims_ver bfm_system

# Load Wave window
do ../../scripts/wave.do

# Load BFL
do ../../scripts/sample.do

# Start system clock and reset system
force -freeze sim:/bfm_system/my_core/my_core/sys_clk_in 1 0, 0 {2.5 ns} -r 5 ns
force -freeze sim:/bfm_system/my_core/my_core/pixel_clk 1 0, 0 {5 ns} -r 10 ns
force -freeze sim:/bfm_system/my_core/my_core/pixel_clk90 1 2.5ns, 0 {7.5ns} -r 10 ns
force -freeze sim:/bfm_system/sys_clk 1 0, 0 {5 ns} -r 10 ns
force -freeze sim:/bfm_system/sys_reset 1
force -freeze sim:/bfm_system/sys_reset 0 100 ns, 1 {200 ns}

# Run test time
run 270 us

# Release ModelSim simulation license
#quit -sim

# Close previous dataset if it exists
#if {[dataset info exists bfm_test]} {dataset close bfm_test}

# Open and view waveform
#dataset open vsim.wlf bfm_test
#do ../../scripts/wave.do
