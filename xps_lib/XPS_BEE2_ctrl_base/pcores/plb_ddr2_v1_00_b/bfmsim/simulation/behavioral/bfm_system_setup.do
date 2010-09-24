#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_system_setup.do (Wed Feb  1 12:54:49 2006)
#
#  Simulation Setup DO Script File
#
#  The Simulation Setup DO script file defines macros and
#  commands to load a design and automate the setup of
#  signal displays for viewing.
#
#  Comment or uncomment commands in the DO files below
#  to change the set of signals viewed.
#
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#  Compile and simulation load commands must also change.
#
echo  "Setting up simulation commands ..."

alias c   "do bfm_system.do"
alias s   "vsim -t ps testbench"
alias l   "do bfm_system_list.do"
alias w   "do bfm_system_wave.do"

alias h "
echo **********************************************************************
echo **********************************************************************
echo ***
echo ***   Simulation Setup Macros (bfm_system_setup.do)
echo ***
echo ***   Because EDK did not create the testbench, the compile and load
echo ***   commands need changes to work with the user-generated testbench.
echo ***   For example, edit the testbench name in the vsim command.
echo ***
echo ***   c =>    compile the testbench by running the EDK compile script.
echo ***           Edit the testbench first before running this command.
echo ***           Assumes ISE and EDK libraries were compiled earlier
echo ***           for ModelSim.  (see bfm_system.do)
echo ***
echo ***   s =>    load the testbench for simulation. (ModelSim 'vsim'
echo ***           command with 'testbench') After loading the testbench,
echo ***           set up signal displays (optional) and run the simulation.
echo ***           (ModelSim 'run' command)
echo ***
echo ***   l =>    set up signal list display and launch a list window.
echo ***           ModelSim 'add -list' commands are found in *_list.do
echo ***           scripts. (see bfm_system_list.do)
echo ***
echo ***   w =>    set up signal wave display and launch a waveform window.
echo ***           ModelSim 'add -wave' commands are found in *_wave.do
echo ***           scripts. (see bfm_system_wave.do)
echo ***
echo ***   h =>    print this message
echo ***
echo **********************************************************************
echo **********************************************************************"

h
