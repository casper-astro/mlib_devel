#-----------------------------------------------------------------
# System Generator version 2018.2 IP Tcl source file.
#
# Copyright(C) 2018 by Xilinx, Inc.  All rights reserved.  This
# text/file contains proprietary, confidential information of Xilinx,
# Inc., is distributed under license from Xilinx, Inc., and may be used,
# copied and/or disclosed only pursuant to the terms of a valid license
# agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
# this text/file solely for design, simulation, implementation and
# creation of design files limited to Xilinx devices or technologies.
# Use with non-Xilinx devices or technologies is expressly prohibited
# and immediately terminates your license unless covered by a separate
# agreement.
#
# Xilinx is providing this design, code, or information "as is" solely
# for use in developing programs and solutions for Xilinx devices.  By
# providing this design, code, or information as one possible
# implementation of this feature, application or standard, Xilinx is
# making no representation that this implementation is free from any
# claims of infringement.  You are responsible for obtaining any rights
# you may require for your implementation.  Xilinx expressly disclaims
# any warranty whatsoever with respect to the adequacy of the
# implementation, including but not limited to warranties of
# merchantability or fitness for a particular purpose.
#
# Xilinx products are not intended for use in life support appliances,
# devices, or systems.  Use in such applications is expressly prohibited.
#
# Any modifications that are made to the source code are done at the user's
# sole risk and will be unsupported.
#
# This copyright and support notice must be retained as part of this
# text at all times.  (c) Copyright 1995-2018 Xilinx, Inc.  All rights
# reserved.
#-----------------------------------------------------------------

set existingipslist [get_ips]
if {[lsearch $existingipslist test_vcu128_c_counter_binary_v12_0_i0] < 0} {
create_ip -name c_counter_binary -version 12.0 -vendor xilinx.com -library ip -module_name test_vcu128_c_counter_binary_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {test_vcu128_c_counter_binary_v12_0_i0}
lappend params_list CONFIG.ainit_value {0}
lappend params_list CONFIG.ce {true}
lappend params_list CONFIG.count_mode {UP}
lappend params_list CONFIG.fb_latency {0}
lappend params_list CONFIG.final_count_value {1}
lappend params_list CONFIG.implementation {Fabric}
lappend params_list CONFIG.increment_value {1}
lappend params_list CONFIG.latency {1}
lappend params_list CONFIG.load {false}
lappend params_list CONFIG.output_width {32}
lappend params_list CONFIG.restrict_count {false}
lappend params_list CONFIG.sclr {false}
lappend params_list CONFIG.sinit {true}
lappend params_list CONFIG.sinit_value {0}
lappend params_list CONFIG.sset {false}
lappend params_list CONFIG.sync_ce_priority {Sync_Overrides_CE}
lappend params_list CONFIG.sync_threshold_output {false}
lappend params_list CONFIG.syncctrlpriority {Reset_Overrides_Set}

set_property -dict $params_list [get_ips test_vcu128_c_counter_binary_v12_0_i0]
}


validate_ip [get_ips]
