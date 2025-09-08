
# (C) 2001-2025 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ----------------------------------------
# Auto-generated simulation script msim_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     soc_system
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "mentor.do", and modify the text as directed.
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# set QSYS_SIMDIR <script generation output directory>
# #
# # Source the generated IP simulation script.
# source $QSYS_SIMDIR/mentor/msim_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
# #
# # Call command to compile the Quartus EDA simulation library.
# dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
# com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #
# vlog <compilation options> <design and testbench files>
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
# set TOP_LEVEL_NAME <simulation top>
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
# elab
# #
# # Run the simulation.
# run -a
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If soc_system is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 24.1 1077 linux 2025.08.14.23:52:16

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "soc_system"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "/home/bgodfrey/Quartus/intelFPGA_lite/24.1std/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VHDL_COMPILE_OPTIONS] { 
  set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VERILOG_COMPILE_OPTIONS] { 
  set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/hps_inst_ROM.hex ./
  file copy -force $QSYS_SIMDIR/submodules/hps_sequencer_mem.hex ./
  file copy -force $QSYS_SIMDIR/submodules/hps_AC_ROM.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*Intel*FPGA*" [ vsim -version ] ] {
  ensure_lib                       ./libraries/altera_ver/           
  vmap       altera_ver            ./libraries/altera_ver/           
  ensure_lib                       ./libraries/lpm_ver/              
  vmap       lpm_ver               ./libraries/lpm_ver/              
  ensure_lib                       ./libraries/sgate_ver/            
  vmap       sgate_ver             ./libraries/sgate_ver/            
  ensure_lib                       ./libraries/altera_mf_ver/        
  vmap       altera_mf_ver         ./libraries/altera_mf_ver/        
  ensure_lib                       ./libraries/altera_lnsim_ver/     
  vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver/     
  ensure_lib                       ./libraries/cyclonev_ver/         
  vmap       cyclonev_ver          ./libraries/cyclonev_ver/         
  ensure_lib                       ./libraries/cyclonev_hssi_ver/    
  vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver/    
  ensure_lib                       ./libraries/cyclonev_pcie_hip_ver/
  vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver/
}
ensure_lib                                          ./libraries/altera_common_sv_packages/               
vmap       altera_common_sv_packages                ./libraries/altera_common_sv_packages/               
ensure_lib                                          ./libraries/error_adapter_0/                         
vmap       error_adapter_0                          ./libraries/error_adapter_0/                         
ensure_lib                                          ./libraries/border/                                  
vmap       border                                   ./libraries/border/                                  
ensure_lib                                          ./libraries/avalon_st_adapter/                       
vmap       avalon_st_adapter                        ./libraries/avalon_st_adapter/                       
ensure_lib                                          ./libraries/rsp_mux/                                 
vmap       rsp_mux                                  ./libraries/rsp_mux/                                 
ensure_lib                                          ./libraries/cmd_mux/                                 
vmap       cmd_mux                                  ./libraries/cmd_mux/                                 
ensure_lib                                          ./libraries/cmd_demux/                               
vmap       cmd_demux                                ./libraries/cmd_demux/                               
ensure_lib                                          ./libraries/router_001/                              
vmap       router_001                               ./libraries/router_001/                              
ensure_lib                                          ./libraries/router/                                  
vmap       router                                   ./libraries/router/                                  
ensure_lib                                          ./libraries/hps_0_f2h_axi_slave_wr_cmd_width_adapter/
vmap       hps_0_f2h_axi_slave_wr_cmd_width_adapter ./libraries/hps_0_f2h_axi_slave_wr_cmd_width_adapter/
ensure_lib                                          ./libraries/rsp_demux/                               
vmap       rsp_demux                                ./libraries/rsp_demux/                               
ensure_lib                                          ./libraries/hps_0_f2h_axi_slave_agent/               
vmap       hps_0_f2h_axi_slave_agent                ./libraries/hps_0_f2h_axi_slave_agent/               
ensure_lib                                          ./libraries/mm_bridge_0_m0_limiter/                  
vmap       mm_bridge_0_m0_limiter                   ./libraries/mm_bridge_0_m0_limiter/                  
ensure_lib                                          ./libraries/router_002/                              
vmap       router_002                               ./libraries/router_002/                              
ensure_lib                                          ./libraries/mm_bridge_0_m0_agent/                    
vmap       mm_bridge_0_m0_agent                     ./libraries/mm_bridge_0_m0_agent/                    
ensure_lib                                          ./libraries/mm_bridge_0_m0_translator/               
vmap       mm_bridge_0_m0_translator                ./libraries/mm_bridge_0_m0_translator/               
ensure_lib                                          ./libraries/mm_bridge_0_s0_burst_adapter/            
vmap       mm_bridge_0_s0_burst_adapter             ./libraries/mm_bridge_0_s0_burst_adapter/            
ensure_lib                                          ./libraries/mm_bridge_0_s0_agent/                    
vmap       mm_bridge_0_s0_agent                     ./libraries/mm_bridge_0_s0_agent/                    
ensure_lib                                          ./libraries/hps_0_h2f_lw_axi_master_agent/           
vmap       hps_0_h2f_lw_axi_master_agent            ./libraries/hps_0_h2f_lw_axi_master_agent/           
ensure_lib                                          ./libraries/mm_bridge_0_s0_translator/               
vmap       mm_bridge_0_s0_translator                ./libraries/mm_bridge_0_s0_translator/               
ensure_lib                                          ./libraries/hps_io/                                  
vmap       hps_io                                   ./libraries/hps_io/                                  
ensure_lib                                          ./libraries/fpga_interfaces/                         
vmap       fpga_interfaces                          ./libraries/fpga_interfaces/                         
ensure_lib                                          ./libraries/p2b_adapter/                             
vmap       p2b_adapter                              ./libraries/p2b_adapter/                             
ensure_lib                                          ./libraries/b2p_adapter/                             
vmap       b2p_adapter                              ./libraries/b2p_adapter/                             
ensure_lib                                          ./libraries/transacto/                               
vmap       transacto                                ./libraries/transacto/                               
ensure_lib                                          ./libraries/p2b/                                     
vmap       p2b                                      ./libraries/p2b/                                     
ensure_lib                                          ./libraries/b2p/                                     
vmap       b2p                                      ./libraries/b2p/                                     
ensure_lib                                          ./libraries/fifo/                                    
vmap       fifo                                     ./libraries/fifo/                                    
ensure_lib                                          ./libraries/timing_adt/                              
vmap       timing_adt                               ./libraries/timing_adt/                              
ensure_lib                                          ./libraries/jtag_phy_embedded_in_jtag_master/        
vmap       jtag_phy_embedded_in_jtag_master         ./libraries/jtag_phy_embedded_in_jtag_master/        
ensure_lib                                          ./libraries/rst_controller/                          
vmap       rst_controller                           ./libraries/rst_controller/                          
ensure_lib                                          ./libraries/irq_mapper_002/                          
vmap       irq_mapper_002                           ./libraries/irq_mapper_002/                          
ensure_lib                                          ./libraries/irq_mapper_001/                          
vmap       irq_mapper_001                           ./libraries/irq_mapper_001/                          
ensure_lib                                          ./libraries/irq_mapper/                              
vmap       irq_mapper                               ./libraries/irq_mapper/                              
ensure_lib                                          ./libraries/mm_interconnect_3/                       
vmap       mm_interconnect_3                        ./libraries/mm_interconnect_3/                       
ensure_lib                                          ./libraries/mm_interconnect_2/                       
vmap       mm_interconnect_2                        ./libraries/mm_interconnect_2/                       
ensure_lib                                          ./libraries/mm_interconnect_1/                       
vmap       mm_interconnect_1                        ./libraries/mm_interconnect_1/                       
ensure_lib                                          ./libraries/mm_interconnect_0/                       
vmap       mm_interconnect_0                        ./libraries/mm_interconnect_0/                       
ensure_lib                                          ./libraries/sysid_qsys/                              
vmap       sysid_qsys                               ./libraries/sysid_qsys/                              
ensure_lib                                          ./libraries/mm_bridge_0/                             
vmap       mm_bridge_0                              ./libraries/mm_bridge_0/                             
ensure_lib                                          ./libraries/led_pio/                                 
vmap       led_pio                                  ./libraries/led_pio/                                 
ensure_lib                                          ./libraries/jtag_uart/                               
vmap       jtag_uart                                ./libraries/jtag_uart/                               
ensure_lib                                          ./libraries/hps_0/                                   
vmap       hps_0                                    ./libraries/hps_0/                                   
ensure_lib                                          ./libraries/f2sdram_only_master/                     
vmap       f2sdram_only_master                      ./libraries/f2sdram_only_master/                     
ensure_lib                                          ./libraries/dipsw_pio/                               
vmap       dipsw_pio                                ./libraries/dipsw_pio/                               
ensure_lib                                          ./libraries/button_pio/                              
vmap       button_pio                               ./libraries/button_pio/                              
ensure_lib                                          ./libraries/ILC/                                     
vmap       ILC                                      ./libraries/ILC/                                     

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*Intel*FPGA*" [ vsim -version ] ] {
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                     -work altera_ver           
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                              -work lpm_ver              
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                 -work sgate_ver            
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                             -work altera_mf_ver        
    eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                         -work altera_lnsim_ver     
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                        -work cyclonev_ver         
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                   -work cyclonev_hssi_ver    
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
    eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"               -work cyclonev_pcie_hip_ver
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                                      -work altera_common_sv_packages               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                               -work altera_common_sv_packages               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                                      -work altera_common_sv_packages               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3_avalon_st_adapter_error_adapter_0.sv"        -L altera_common_sv_packages -work error_adapter_0                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"        -L altera_common_sv_packages -work error_adapter_0                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                            -L altera_common_sv_packages -work border                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                          -L altera_common_sv_packages -work border                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                            -L altera_common_sv_packages -work border                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                            -L altera_common_sv_packages -work border                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_memory.sv"                                 -L altera_common_sv_packages -work border                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_hps_io.sv"                                 -L altera_common_sv_packages -work border                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border.sv"                                        -L altera_common_sv_packages -work border                                  
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3_avalon_st_adapter.v"                                                      -work avalon_st_adapter                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3_rsp_mux.sv"                                  -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3_cmd_mux.sv"                                  -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3_cmd_demux.sv"                                -L altera_common_sv_packages -work cmd_demux                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3_router_001.sv"                               -L altera_common_sv_packages -work router_001                              
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3_router.sv"                                   -L altera_common_sv_packages -work router                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                           -L altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_cmd_width_adapter
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                       -L altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_cmd_width_adapter
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                      -L altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_cmd_width_adapter
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_rsp_mux.sv"                                  -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_rsp_demux.sv"                                -L altera_common_sv_packages -work rsp_demux                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_cmd_mux.sv"                                  -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_cmd_demux.sv"                                -L altera_common_sv_packages -work cmd_demux                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_router_001.sv"                               -L altera_common_sv_packages -work router_001                              
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2_router.sv"                                   -L altera_common_sv_packages -work router                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_axi_slave_ni.sv"                                            -L altera_common_sv_packages -work hps_0_f2h_axi_slave_agent               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                      -L altera_common_sv_packages -work hps_0_f2h_axi_slave_agent               
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                               -work hps_0_f2h_axi_slave_agent               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                       -L altera_common_sv_packages -work hps_0_f2h_axi_slave_agent               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_rsp_mux.sv"                                  -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_rsp_demux.sv"                                -L altera_common_sv_packages -work rsp_demux                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_cmd_mux.sv"                                  -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_cmd_demux.sv"                                -L altera_common_sv_packages -work cmd_demux                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                         -L altera_common_sv_packages -work mm_bridge_0_m0_limiter                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                          -L altera_common_sv_packages -work mm_bridge_0_m0_limiter                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                  -L altera_common_sv_packages -work mm_bridge_0_m0_limiter                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                         -L altera_common_sv_packages -work mm_bridge_0_m0_limiter                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_router_002.sv"                               -L altera_common_sv_packages -work router_002                              
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1_router.sv"                                   -L altera_common_sv_packages -work router                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                            -L altera_common_sv_packages -work mm_bridge_0_m0_agent                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                       -L altera_common_sv_packages -work mm_bridge_0_m0_translator               
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter.v"                                                      -work avalon_st_adapter                       
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_mux.sv"                                  -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work rsp_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_demux.sv"                                -L altera_common_sv_packages -work rsp_demux                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_mux.sv"                                  -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work cmd_mux                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_demux.sv"                                -L altera_common_sv_packages -work cmd_demux                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                           -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                    -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                      -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                       -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                           -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                           -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                        -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                       -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                       -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                         -L altera_common_sv_packages -work mm_bridge_0_s0_burst_adapter            
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_002.sv"                               -L altera_common_sv_packages -work router_002                              
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router.sv"                                   -L altera_common_sv_packages -work router                                  
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                             -L altera_common_sv_packages -work mm_bridge_0_s0_agent                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                      -L altera_common_sv_packages -work mm_bridge_0_s0_agent                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                           -L altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                       -L altera_common_sv_packages -work hps_0_h2f_lw_axi_master_agent           
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                        -L altera_common_sv_packages -work mm_bridge_0_s0_translator               
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io.v"                                                                             -work hps_io                                  
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram.v"                                                                                           -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_mem_if_hhp_qseq_top.v"                                                                          -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_mem_if_sequencer_cpu_cv_sim_cpu_inst_test_bench.v"                                              -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_rsp_mux_001.sv"                               -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_cmd_mux.sv"                                   -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_2.v"                                                                         -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_pll.sv"                                                         -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                            -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_router_003.sv"                                -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                            -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                              -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq_lib/alt_mem_ddrx_buffer.v"                                                                         -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq_lib/alt_mem_ddrx_fifo.v"                                                                           -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq_lib/hmctl_synchronizer.v"                                                                          -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_p0_phy_csr.sv"                                                  -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                      -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_avalon_st_adapter.v"                                                       -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                               -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_acv_hard_addr_cmd_pads.v"                                                                 -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                        -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_mem_if_sequencer_cpu_cv_sim_cpu_inst.v"                                                         -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_reset_sync.v"                                                                             -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_irq_mapper.sv"                                                  -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                            -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_mem_if_sequencer_mem_no_ifdef_params.sv"                           -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_generic_ddio.v"                                                                           -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_router.sv"                                    -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_cmd_demux_001.sv"                             -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_avalon_st_adapter_error_adapter_0.sv"         -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_cmd_mux_001.sv"                               -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                       -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                      -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_reset.v"                                                                                  -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1.v"                                                                         -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/mentor/hps_hmctl.v"                                                                                    -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_acv_hard_memphy.v"                                                                        -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                    -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_mem_if_oct_cyclonev.sv"                                            -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_cmd_demux.sv"                                 -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                           -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_acv_ldc.v"                                                                                -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_mem_if_avalon2apb_bridge.sv"                                       -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                             -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_p0.sv"                                                          -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_mem_if_hps_memory_controller_top.sv"                               -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                       -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                       -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altdq_dqs2_acv_connect_to_hard_phy_cyclonev.sv"                           -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_mem_if_dll_cyclonev.sv"                                            -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                       -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_router_001.sv"                                -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                           -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_mem_if_common_ddr_mem_model_ddr3_mem_if_dm_pins_en_mem_if_dqsn_en.sv" -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_router_002.sv"                                -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_altdqdqs.v"                                                                               -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_mem_if_ddr3_mem_model_top_ddr3_mem_if_dm_pins_en_mem_if_dqsn_en.sv"   -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/hps_sdram_mm_interconnect_1_rsp_mux.sv"                                   -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_clock_pair_generator.v"                                                                   -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                           -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_scc_hhp_wrapper.v"                                                                             -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_avalon_st_pipeline_base.v"                                                              -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_cmd_xbar_demux.v"                                                                              -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_arbitrator.v"                                                                    -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_arb_adder.v"                                                                     -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_slave_translator.v"                                                              -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_burst_uncompressor.v"                                                            -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_scc_reg_file.v"                                                                                -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_traffic_limiter.v"                                                               -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_addr_router_001.v"                                                                             -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq.v"                                                                                             -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_addr_router.v"                                                                                 -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_addr_router_001_default_decode.v"                                                              -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_rsp_xbar_mux.v"                                                                                -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_avalon_mm_bridge.v"                                                                     -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_master_agent.v"                                                                  -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_scc_hhp_phase_decode.v"                                                                        -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_cmd_xbar_mux.v"                                                                                -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_trk_mgr.v"                                                                                     -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_avalon_dc_fifo.v"                                                                       -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_master_translator.v"                                                             -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_avalon_sc_fifo.v"                                                                       -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_hhp_decompress_avl_mm_bridge.v"                                                                -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_mem_if_simple_avalon_mm_bridge.v"                                                       -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_hhp_apb2avalon_bridge.v"                                                                -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_cmd_xbar_demux_001.v"                                                                          -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_id_router_default_decode.v"                                                                    -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_addr_router_default_decode.v"                                                                  -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_reg_file.v"                                                                                    -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_rsp_xbar_demux.v"                                                                              -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_scc_mgr.v"                                                                                     -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_avalon_mm_clock_crossing_bridge.v"                                                      -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_id_router.v"                                                                                   -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/seq/seq_altera_merlin_slave_agent.v"                                                                   -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                        -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_acv_hard_io_pads.v"                                                                       -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                                                      -work fpga_interfaces                         
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/hps_sdram_p0_iss_probe.v"                                                                              -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                            -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                          -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_cold_reset_req.sv"                   -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_debug_reset_req.sv"                  -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_warm_reset_req.sv"                   -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces_f2h_stm_hw_events.sv"                    -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces.sv"                                      -L altera_common_sv_packages -work fpga_interfaces                         
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_f2sdram_only_master_p2b_adapter.sv"                            -L altera_common_sv_packages -work p2b_adapter                             
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_f2sdram_only_master_b2p_adapter.sv"                            -L altera_common_sv_packages -work b2p_adapter                             
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_packets_to_master.v"                                                                     -work transacto                               
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_packets_to_bytes.v"                                                                   -work p2b                                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_bytes_to_packets.v"                                                                   -work b2p                                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                               -work fifo                                    
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_f2sdram_only_master_timing_adt.sv"                             -L altera_common_sv_packages -work timing_adt                              
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_jtag_interface.v"                                                                     -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_jtag_dc_streaming.v"                                                                            -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_jtag_sld_node.v"                                                                                -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_jtag_streaming.v"                                                                               -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                                                      -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                                                       -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                                                      -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_remover.v"                                                                       -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_st_idle_inserter.v"                                                                      -work jtag_phy_embedded_in_jtag_master        
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                       -L altera_common_sv_packages -work jtag_phy_embedded_in_jtag_master        
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                             -work rst_controller                          
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                           -work rst_controller                          
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_irq_mapper_002.sv"                                             -L altera_common_sv_packages -work irq_mapper_002                          
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_irq_mapper_001.sv"                                             -L altera_common_sv_packages -work irq_mapper_001                          
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_irq_mapper.sv"                                                 -L altera_common_sv_packages -work irq_mapper                              
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_3.v"                                                                        -work mm_interconnect_3                       
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_2.v"                                                                        -work mm_interconnect_2                       
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_1.v"                                                                        -work mm_interconnect_1                       
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0.v"                                                                        -work mm_interconnect_0                       
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_sysid_qsys.v"                                                                               -work sysid_qsys                              
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_mm_bridge.v"                                                                             -work mm_bridge_0                             
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_led_pio.v"                                                                                  -work led_pio                                 
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_jtag_uart.sv"                                               -L altera_common_sv_packages -work jtag_uart                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_jtag_uart_log_module.sv"                                    -L altera_common_sv_packages -work jtag_uart                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_jtag_uart_scfifo_r.sv"                                      -L altera_common_sv_packages -work jtag_uart                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_jtag_uart_scfifo_w.sv"                                      -L altera_common_sv_packages -work jtag_uart                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_jtag_uart_sim_scfifo_r.sv"                                  -L altera_common_sv_packages -work jtag_uart                               
  eval  vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_jtag_uart_sim_scfifo_w.sv"                                  -L altera_common_sv_packages -work jtag_uart                               
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_hps_0.v"                                                                                    -work hps_0                                   
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_f2sdram_only_master.v"                                                                      -work f2sdram_only_master                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_dipsw_pio.v"                                                                                -work dipsw_pio                               
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/soc_system_button_pio.v"                                                                               -work button_pio                              
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/interrupt_latency_counter.v"                                                                           -work ILC                                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/irq_detector.v"                                                                                        -work ILC                                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/state_machine_counter.v"                                                                               -work ILC                                     
  eval  vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/soc_system.v"                                                                                                                                                   
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter -L rsp_mux -L cmd_mux -L cmd_demux -L router_001 -L router -L hps_0_f2h_axi_slave_wr_cmd_width_adapter -L rsp_demux -L hps_0_f2h_axi_slave_agent -L mm_bridge_0_m0_limiter -L router_002 -L mm_bridge_0_m0_agent -L mm_bridge_0_m0_translator -L mm_bridge_0_s0_burst_adapter -L mm_bridge_0_s0_agent -L hps_0_h2f_lw_axi_master_agent -L mm_bridge_0_s0_translator -L hps_io -L fpga_interfaces -L p2b_adapter -L b2p_adapter -L transacto -L p2b -L b2p -L fifo -L timing_adt -L jtag_phy_embedded_in_jtag_master -L rst_controller -L irq_mapper_002 -L irq_mapper_001 -L irq_mapper -L mm_interconnect_3 -L mm_interconnect_2 -L mm_interconnect_1 -L mm_interconnect_0 -L sysid_qsys -L mm_bridge_0 -L led_pio -L jtag_uart -L hps_0 -L f2sdram_only_master -L dipsw_pio -L button_pio -L ILC -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -voptargs=+acc option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -voptargs=+acc -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS -L work -L work_lib -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter -L rsp_mux -L cmd_mux -L cmd_demux -L router_001 -L router -L hps_0_f2h_axi_slave_wr_cmd_width_adapter -L rsp_demux -L hps_0_f2h_axi_slave_agent -L mm_bridge_0_m0_limiter -L router_002 -L mm_bridge_0_m0_agent -L mm_bridge_0_m0_translator -L mm_bridge_0_s0_burst_adapter -L mm_bridge_0_s0_agent -L hps_0_h2f_lw_axi_master_agent -L mm_bridge_0_s0_translator -L hps_io -L fpga_interfaces -L p2b_adapter -L b2p_adapter -L transacto -L p2b -L b2p -L fifo -L timing_adt -L jtag_phy_embedded_in_jtag_master -L rst_controller -L irq_mapper_002 -L irq_mapper_001 -L irq_mapper -L mm_interconnect_3 -L mm_interconnect_2 -L mm_interconnect_1 -L mm_interconnect_0 -L sysid_qsys -L mm_bridge_0 -L led_pio -L jtag_uart -L hps_0 -L f2sdram_only_master -L dipsw_pio -L button_pio -L ILC -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -voptargs=+acc
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                                         -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                                           -- Compile device library files"
  echo
  echo "com                                               -- Compile the design files in correct order"
  echo
  echo "elab                                              -- Elaborate top level design"
  echo
  echo "elab_debug                                        -- Elaborate the top level design with -voptargs=+acc option"
  echo
  echo "ld                                                -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                                          -- Compile all the design files and elaborate the top level design with -voptargs=+acc"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                                    -- Top level module name."
  echo "                                                     For most designs, this should be overridden"
  echo "                                                     to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME                              -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                                       -- Platform Designer base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR                               -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS                      -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS                         -- User-defined elaboration options, added to elab/elab_debug aliases."
  echo
  echo "USER_DEFINED_VHDL_COMPILE_OPTIONS                 -- User-defined vhdl compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_VERILOG_COMPILE_OPTIONS              -- User-defined verilog compile options, added to com/dev_com aliases."
}
file_copy
h
