#  Simulation Model Generator
#  Xilinx EDK 7.1.2 EDK_H.12.5.1
#  Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.
#
#  File     bfm_system_wave.do (Wed Feb  1 12:54:49 2006)
#
#  Wave Window DO Script File
#
#  Wave Window DO script files setup the ModelSim Wave window
#  display for viewing results of the simulation in a graphic
#  format. Comment or uncomment commands to change the set of
#  signals viewed.
#
echo  "Setting up Wave window display ..."

#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tpath.
#
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}bfm_system" }

#
#  Display top-level ports
#
set binopt {-logic}
set hexopt {-literal -hex}
eval add wave -noupdate -divider {"top-level ports"}
eval add wave -noupdate $binopt $tbpath${ps}sys_reset
eval add wave -noupdate $binopt $tbpath${ps}sys_clk

#
#  Display bus signal ports
#
# do plb_bus_wave.do

#
#  Display processor ports
#
#
#  Display IP and peripheral ports
#
# do synch_bus_wave.do

# do bfm_processor_wave.do

# do bfm_monitor_wave.do

# do plb_ddr2_wave.do


#  Wave window configuration information
#
configure  wave -justifyvalue          right
configure  wave -signalnamewidth       1

TreeUpdate [SetDefaultTree]

#  Wave window setup complete
#
echo  "Wave window display setup done."
