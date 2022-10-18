
################################################################
# This is a generated script based on design: au50_bd
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2021.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source au50_bd_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# device_dna, dsp_send, serial_pipe

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcu50-fsvh2104-2-e
   set_property BOARD_PART xilinx.com:au50:part0:1.2 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name au50_bd

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:cms_subsystem:4.0\
xilinx.com:ip:util_ds_buf:2.2\
xilinx.com:ip:xdma:4.1\
xilinx.com:ip:xpm_cdc_gen:1.0\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:axi_apb_bridge:3.0\
xilinx.com:ip:axi_clock_converter:2.1\
xilinx.com:ip:hbm:1.0\
xilinx.com:ip:rama:1.1\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:ip:axis_dwidth_converter:1.1\
xilinx.com:ip:cmac_usplus:3.1\
xilinx.com:ip:proc_sys_reset:5.0\
user.org:user:udp_core_100g_ip:1.1\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
device_dna\
dsp_send\
serial_pipe\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: hgbe
proc create_hier_cell_hgbe { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hgbe() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi4lite

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gt_ref_clk_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 gt_serial_port_0


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_areset_n
  create_bd_pin -dir I -type clk s_axis_aclk
  create_bd_pin -dir I -type rst sys_rst_n

  # Create instance: axis_clock_converter_0, and set properties
  set axis_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_0 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TID_WIDTH {8} \
   CONFIG.TUSER_WIDTH {32} \
 ] $axis_clock_converter_0

  # Create instance: axis_clock_converter_1, and set properties
  set axis_clock_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_1 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TID_WIDTH {8} \
   CONFIG.TUSER_WIDTH {32} \
 ] $axis_clock_converter_1

  # Create instance: axis_clock_converter_2, and set properties
  set axis_clock_converter_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_2 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TID_WIDTH {8} \
   CONFIG.TUSER_WIDTH {32} \
 ] $axis_clock_converter_2

  # Create instance: axis_clock_converter_3, and set properties
  set axis_clock_converter_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_3 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {1} \
 ] $axis_clock_converter_3

  # Create instance: axis_clock_converter_4, and set properties
  set axis_clock_converter_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_4 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TID_WIDTH {8} \
   CONFIG.TUSER_WIDTH {32} \
 ] $axis_clock_converter_4

  # Create instance: axis_clock_converter_7, and set properties
  set axis_clock_converter_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_7 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TDATA_NUM_BYTES {64} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {32} \
 ] $axis_clock_converter_7

  # Create instance: axis_clock_converter_8, and set properties
  set axis_clock_converter_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_8 ]
  set_property -dict [ list \
   CONFIG.TDATA_NUM_BYTES {64} \
 ] $axis_clock_converter_8

  # Create instance: axis_clock_converter_9, and set properties
  set axis_clock_converter_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_9 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TDATA_NUM_BYTES {64} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
 ] $axis_clock_converter_9

  # Create instance: axis_dwidth_converter_1, and set properties
  set axis_dwidth_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_1 ]
  set_property -dict [ list \
   CONFIG.HAS_MI_TKEEP {1} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M_TDATA_NUM_BYTES {64} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_BITS_PER_BYTE {0} \
 ] $axis_dwidth_converter_1

  # Create instance: axis_dwidth_converter_2, and set properties
  set axis_dwidth_converter_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_2 ]
  set_property -dict [ list \
   CONFIG.HAS_MI_TKEEP {1} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M_TDATA_NUM_BYTES {64} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_BITS_PER_BYTE {0} \
 ] $axis_dwidth_converter_2

  # Create instance: axis_dwidth_converter_4, and set properties
  set axis_dwidth_converter_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_4 ]
  set_property -dict [ list \
   CONFIG.HAS_MI_TKEEP {0} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.S_TDATA_NUM_BYTES {64} \
   CONFIG.TID_WIDTH {8} \
   CONFIG.TUSER_BITS_PER_BYTE {0} \
 ] $axis_dwidth_converter_4

  # Create instance: axis_dwidth_converter_5, and set properties
  set axis_dwidth_converter_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_5 ]
  set_property -dict [ list \
   CONFIG.HAS_MI_TKEEP {0} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.S_TDATA_NUM_BYTES {64} \
   CONFIG.TID_WIDTH {8} \
   CONFIG.TUSER_BITS_PER_BYTE {0} \
 ] $axis_dwidth_converter_5

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {110.107} \
   CONFIG.CLKOUT1_PHASE_ERROR {142.589} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200.0028} \
 ] $clk_wiz_1

  # Create instance: cmac_usplus_0, and set properties
  set cmac_usplus_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:cmac_usplus:3.1 cmac_usplus_0 ]
  set_property -dict [ list \
   CONFIG.CMAC_CAUI4_MODE {1} \
   CONFIG.CMAC_CORE_SELECT {CMACE4_X0Y3} \
   CONFIG.ENABLE_PIPELINE_REG {1} \
   CONFIG.GT_DRP_CLK {62.5} \
   CONFIG.GT_GROUP_SELECT {X0Y28~X0Y31} \
   CONFIG.GT_REF_CLK_FREQ {161.1328125} \
   CONFIG.GT_RX_BUFFER_BYPASS {0} \
   CONFIG.LANE10_GT_LOC {NA} \
   CONFIG.LANE1_GT_LOC {X0Y28} \
   CONFIG.LANE2_GT_LOC {X0Y29} \
   CONFIG.LANE3_GT_LOC {X0Y30} \
   CONFIG.LANE4_GT_LOC {X0Y31} \
   CONFIG.LANE5_GT_LOC {NA} \
   CONFIG.LANE6_GT_LOC {NA} \
   CONFIG.LANE7_GT_LOC {NA} \
   CONFIG.LANE8_GT_LOC {NA} \
   CONFIG.LANE9_GT_LOC {NA} \
   CONFIG.NUM_LANES {4x25} \
   CONFIG.PLL_TYPE {QPLL0} \
   CONFIG.RX_FLOW_CONTROL {0} \
   CONFIG.RX_GT_BUFFER {1} \
   CONFIG.TX_FLOW_CONTROL {0} \
   CONFIG.USER_INTERFACE {AXIS} \
 ] $cmac_usplus_0

  # Create instance: dsp_send_0, and set properties
  set block_name dsp_send
  set block_cell_name dsp_send_0
  if { [catch {set dsp_send_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dsp_send_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: serial_pipe_0, and set properties
  set block_name serial_pipe
  set block_cell_name serial_pipe_0
  if { [catch {set serial_pipe_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $serial_pipe_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: udp_core_100g_ip_1, and set properties
  set udp_core_100g_ip_1 [ create_bd_cell -type ip -vlnv user.org:user:udp_core_100g_ip:1.1 udp_core_100g_ip_1 ]
  set_property -dict [ list \
   CONFIG.G_CORE_FREQ_KHZ {2000028} \
   CONFIG.G_EXT_CLK_FIFOS {true} \
   CONFIG.G_RX_INPUT_PIPE_STAGES {4} \
   CONFIG.G_UDP_CLK_FIFOS {true} \
 ] $udp_core_100g_ip_1

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_1

  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_2 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_2

  # Create instance: util_vector_logic_3, and set properties
  set util_vector_logic_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_3 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_3

  # Create instance: util_vector_logic_4, and set properties
  set util_vector_logic_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_4 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_4

  # Create instance: util_vector_logic_5, and set properties
  set util_vector_logic_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_5 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_5

  # Create instance: util_vector_logic_6, and set properties
  set util_vector_logic_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_6 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_6

  # Create instance: util_vector_logic_7, and set properties
  set util_vector_logic_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_7 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_7

  # Create instance: util_vector_logic_8, and set properties
  set util_vector_logic_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_8 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {and} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_andgate.png} \
 ] $util_vector_logic_8

  # Create instance: util_vector_logic_12, and set properties
  set util_vector_logic_12 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_12 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_12

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_3

  # Create instance: xlconstant_4, and set properties
  set xlconstant_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_4 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {3232236132} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_4

  # Create instance: xlconstant_6, and set properties
  set xlconstant_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_6 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x002040ff0050} \
   CONFIG.CONST_WIDTH {48} \
 ] $xlconstant_6

  # Create instance: xpm_cdc_gen_1, and set properties
  set xpm_cdc_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xpm_cdc_gen:1.0 xpm_cdc_gen_1 ]
  set_property -dict [ list \
   CONFIG.CDC_TYPE {xpm_cdc_async_rst} \
   CONFIG.DEST_SYNC_FF {2} \
   CONFIG.RST_ACTIVE_HIGH {true} \
 ] $xpm_cdc_gen_1

  # Create instance: xpm_cdc_gen_2, and set properties
  set xpm_cdc_gen_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xpm_cdc_gen:1.0 xpm_cdc_gen_2 ]
  set_property -dict [ list \
   CONFIG.CDC_TYPE {xpm_cdc_async_rst} \
   CONFIG.DEST_SYNC_FF {2} \
   CONFIG.RST_ACTIVE_HIGH {true} \
 ] $xpm_cdc_gen_2

  # Create instance: xpm_cdc_gen_3, and set properties
  set xpm_cdc_gen_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xpm_cdc_gen:1.0 xpm_cdc_gen_3 ]
  set_property -dict [ list \
   CONFIG.CDC_TYPE {xpm_cdc_async_rst} \
   CONFIG.DEST_SYNC_FF {2} \
   CONFIG.RST_ACTIVE_HIGH {true} \
 ] $xpm_cdc_gen_3

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXIS_0] [get_bd_intf_pins axis_clock_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins axis_clock_converter_7/S_AXIS]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi4lite] [get_bd_intf_pins udp_core_100g_ip_1/axi4lite]
  connect_bd_intf_net -intf_net axis_clock_converter_1_M_AXIS [get_bd_intf_pins axis_clock_converter_1/M_AXIS] [get_bd_intf_pins axis_dwidth_converter_4/S_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_2_M_AXIS [get_bd_intf_pins axis_clock_converter_2/M_AXIS] [get_bd_intf_pins axis_dwidth_converter_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_3_M_AXIS [get_bd_intf_pins axis_clock_converter_3/M_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/rx_axis_s]
  connect_bd_intf_net -intf_net axis_clock_converter_4_M_AXIS [get_bd_intf_pins axis_clock_converter_4/M_AXIS] [get_bd_intf_pins cmac_usplus_0/axis_tx]
  connect_bd_intf_net -intf_net axis_clock_converter_7_M_AXIS [get_bd_intf_pins axis_clock_converter_7/M_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/udp_axis_s]
  connect_bd_intf_net -intf_net axis_clock_converter_8_M_AXIS [get_bd_intf_pins axis_clock_converter_8/M_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/ipv4_axis_s]
  connect_bd_intf_net -intf_net axis_clock_converter_9_M_AXIS [get_bd_intf_pins axis_clock_converter_9/M_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/eth_axis_s]
  connect_bd_intf_net -intf_net axis_dwidth_converter_1_M_AXIS [get_bd_intf_pins axis_clock_converter_8/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_2_M_AXIS [get_bd_intf_pins axis_clock_converter_9/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_4_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_dwidth_converter_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_5_M_AXIS [get_bd_intf_pins M_AXIS1] [get_bd_intf_pins axis_dwidth_converter_5/M_AXIS]
  connect_bd_intf_net -intf_net cmac_usplus_0_axis_rx [get_bd_intf_pins axis_clock_converter_3/S_AXIS] [get_bd_intf_pins cmac_usplus_0/axis_rx]
  connect_bd_intf_net -intf_net cmac_usplus_1_gt_serial_port [get_bd_intf_pins gt_serial_port_0] [get_bd_intf_pins cmac_usplus_0/gt_serial_port]
  connect_bd_intf_net -intf_net gt_ref_clk_0_1 [get_bd_intf_pins gt_ref_clk_0] [get_bd_intf_pins cmac_usplus_0/gt_ref_clk]
  connect_bd_intf_net -intf_net udp_core_100g_ip_1_eth_axis_m [get_bd_intf_pins axis_clock_converter_2/S_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/eth_axis_m]
  connect_bd_intf_net -intf_net udp_core_100g_ip_1_ipv4_axis_m [get_bd_intf_pins axis_clock_converter_1/S_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/ipv4_axis_m]
  connect_bd_intf_net -intf_net udp_core_100g_ip_1_tx_axis_m [get_bd_intf_pins axis_clock_converter_4/S_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/tx_axis_m]
  connect_bd_intf_net -intf_net udp_core_100g_ip_1_udp_axis_m [get_bd_intf_pins axis_clock_converter_0/S_AXIS] [get_bd_intf_pins udp_core_100g_ip_1/udp_axis_m]
  connect_bd_intf_net -intf_net xdma_0_M_AXIS_H2C_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins axis_dwidth_converter_1/S_AXIS]
  connect_bd_intf_net -intf_net xdma_0_M_AXIS_H2C_2 [get_bd_intf_pins S_AXIS1] [get_bd_intf_pins axis_dwidth_converter_2/S_AXIS]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins cmac_usplus_0/stat_rx_aligned] [get_bd_pins dsp_send_0/stat_rx_aligned] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net Net1 [get_bd_pins udp_core_100g_ip_1/rx_axis_s_rst] [get_bd_pins udp_core_100g_ip_1/tx_axis_m_rst] [get_bd_pins xpm_cdc_gen_3/dest_arst]
  connect_bd_net -net Net2 [get_bd_pins serial_pipe_0/en] [get_bd_pins serial_pipe_0/rst_s_n] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net axi4lite_aclk_0_1 [get_bd_pins s_axi_aclk] [get_bd_pins axis_clock_converter_1/m_axis_aclk] [get_bd_pins axis_clock_converter_2/m_axis_aclk] [get_bd_pins axis_clock_converter_8/s_axis_aclk] [get_bd_pins axis_clock_converter_9/s_axis_aclk] [get_bd_pins axis_dwidth_converter_1/aclk] [get_bd_pins axis_dwidth_converter_2/aclk] [get_bd_pins axis_dwidth_converter_4/aclk] [get_bd_pins axis_dwidth_converter_5/aclk] [get_bd_pins cmac_usplus_0/drp_clk] [get_bd_pins cmac_usplus_0/init_clk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins udp_core_100g_ip_1/axi4lite_aclk]
  connect_bd_net -net axi4lite_aresetn_0_1 [get_bd_pins s_axi_areset_n] [get_bd_pins axis_clock_converter_1/m_axis_aresetn] [get_bd_pins axis_clock_converter_2/m_axis_aresetn] [get_bd_pins axis_clock_converter_8/s_axis_aresetn] [get_bd_pins axis_clock_converter_9/s_axis_aresetn] [get_bd_pins axis_dwidth_converter_1/aresetn] [get_bd_pins axis_dwidth_converter_2/aresetn] [get_bd_pins axis_dwidth_converter_4/aresetn] [get_bd_pins axis_dwidth_converter_5/aresetn] [get_bd_pins udp_core_100g_ip_1/axi4lite_aresetn] [get_bd_pins util_vector_logic_4/Op1] [get_bd_pins util_vector_logic_8/Op2]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_clock_converter_1/s_axis_aclk] [get_bd_pins axis_clock_converter_2/s_axis_aclk] [get_bd_pins axis_clock_converter_3/m_axis_aclk] [get_bd_pins axis_clock_converter_4/s_axis_aclk] [get_bd_pins axis_clock_converter_7/m_axis_aclk] [get_bd_pins axis_clock_converter_8/m_axis_aclk] [get_bd_pins axis_clock_converter_9/m_axis_aclk] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins udp_core_100g_ip_1/eth_axis_m_clk] [get_bd_pins udp_core_100g_ip_1/eth_axis_s_clk] [get_bd_pins udp_core_100g_ip_1/ipv4_axis_m_clk] [get_bd_pins udp_core_100g_ip_1/ipv4_axis_s_clk] [get_bd_pins udp_core_100g_ip_1/rx_axis_s_clk] [get_bd_pins udp_core_100g_ip_1/rx_core_clk] [get_bd_pins udp_core_100g_ip_1/tx_axis_m_clk] [get_bd_pins udp_core_100g_ip_1/tx_core_clk] [get_bd_pins udp_core_100g_ip_1/udp_axis_m_clk] [get_bd_pins udp_core_100g_ip_1/udp_axis_s_clk] [get_bd_pins xpm_cdc_gen_2/dest_clk] [get_bd_pins xpm_cdc_gen_3/dest_clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins sys_rst_n] [get_bd_pins axis_clock_converter_0/m_axis_aresetn] [get_bd_pins axis_clock_converter_7/s_axis_aresetn] [get_bd_pins util_vector_logic_8/Op1]
  connect_bd_net -net cmac_usplus_0_gt_ref_clk_out [get_bd_pins clk_wiz_1/clk_in1] [get_bd_pins cmac_usplus_0/gt_ref_clk_out]
  connect_bd_net -net cmac_usplus_0_gt_txusrclk2 [get_bd_pins axis_clock_converter_3/s_axis_aclk] [get_bd_pins axis_clock_converter_4/m_axis_aclk] [get_bd_pins cmac_usplus_0/gt_txusrclk2] [get_bd_pins cmac_usplus_0/rx_clk] [get_bd_pins dsp_send_0/clk] [get_bd_pins serial_pipe_0/clk] [get_bd_pins xpm_cdc_gen_1/dest_clk]
  connect_bd_net -net cmac_usplus_1_usr_rx_reset1 [get_bd_pins cmac_usplus_0/usr_rx_reset] [get_bd_pins dsp_send_0/usr_rx_xr] [get_bd_pins util_vector_logic_7/Op1]
  connect_bd_net -net cmac_usplus_1_usr_tx_reset [get_bd_pins cmac_usplus_0/usr_tx_reset] [get_bd_pins dsp_send_0/usr_tx_xr] [get_bd_pins util_vector_logic_5/Op1]
  connect_bd_net -net dsp_send_0_core_xeset [get_bd_pins dsp_send_0/core_xeset] [get_bd_pins util_vector_logic_6/Op1]
  connect_bd_net -net dsp_send_0_ctl_rx_exable [get_bd_pins cmac_usplus_0/ctl_rx_enable] [get_bd_pins dsp_send_0/ctl_rx_exable]
  connect_bd_net -net dsp_send_0_ctl_tx_exable [get_bd_pins cmac_usplus_0/ctl_tx_enable] [get_bd_pins dsp_send_0/ctl_tx_exable]
  connect_bd_net -net dsp_send_0_ctl_tx_send_rfi [get_bd_pins cmac_usplus_0/ctl_tx_send_rfi] [get_bd_pins dsp_send_0/ctl_tx_send_rfi]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins util_vector_logic_12/Op2]
  connect_bd_net -net s_axis_aclk_1 [get_bd_pins s_axis_aclk] [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_clock_converter_7/s_axis_aclk]
  connect_bd_net -net serial_pipe_0_serial_out [get_bd_pins serial_pipe_0/serial_out] [get_bd_pins xpm_cdc_gen_3/src_arst]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins serial_pipe_0/serial_in] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_12_Res [get_bd_pins clk_wiz_1/reset] [get_bd_pins cmac_usplus_0/sys_reset] [get_bd_pins util_vector_logic_1/Op1] [get_bd_pins util_vector_logic_12/Res]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins axis_clock_converter_0/s_axis_aresetn] [get_bd_pins axis_clock_converter_1/s_axis_aresetn] [get_bd_pins axis_clock_converter_2/s_axis_aresetn] [get_bd_pins axis_clock_converter_3/m_axis_aresetn] [get_bd_pins axis_clock_converter_4/s_axis_aresetn] [get_bd_pins axis_clock_converter_7/m_axis_aresetn] [get_bd_pins axis_clock_converter_8/m_axis_aresetn] [get_bd_pins axis_clock_converter_9/m_axis_aresetn] [get_bd_pins udp_core_100g_ip_1/eth_axis_m_reset] [get_bd_pins udp_core_100g_ip_1/eth_axis_s_reset] [get_bd_pins udp_core_100g_ip_1/ipv4_axis_m_reset] [get_bd_pins udp_core_100g_ip_1/ipv4_axis_s_reset] [get_bd_pins util_vector_logic_3/Res]
  connect_bd_net -net util_vector_logic_2_Res1 [get_bd_pins util_vector_logic_2/Res] [get_bd_pins xpm_cdc_gen_2/src_arst]
  connect_bd_net -net util_vector_logic_4_Res [get_bd_pins util_vector_logic_12/Op1] [get_bd_pins util_vector_logic_4/Res] [get_bd_pins xpm_cdc_gen_1/src_arst]
  connect_bd_net -net util_vector_logic_5_Res [get_bd_pins axis_clock_converter_4/m_axis_aresetn] [get_bd_pins util_vector_logic_5/Res]
  connect_bd_net -net util_vector_logic_6_Res [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins util_vector_logic_6/Res]
  connect_bd_net -net util_vector_logic_7_Res [get_bd_pins axis_clock_converter_3/s_axis_aresetn] [get_bd_pins util_vector_logic_7/Res]
  connect_bd_net -net util_vector_logic_8_Res [get_bd_pins util_vector_logic_2/Op1] [get_bd_pins util_vector_logic_8/Res]
  connect_bd_net -net xlconstant_3_dout [get_bd_pins udp_core_100g_ip_1/use_ext_addr] [get_bd_pins xlconstant_3/dout]
  connect_bd_net -net xlconstant_4_dout [get_bd_pins udp_core_100g_ip_1/ext_ip_addr] [get_bd_pins xlconstant_4/dout]
  connect_bd_net -net xlconstant_6_dout [get_bd_pins udp_core_100g_ip_1/ext_mac_addr] [get_bd_pins xlconstant_6/dout]
  connect_bd_net -net xpm_cdc_gen_1_dest_arst [get_bd_pins dsp_send_0/xst] [get_bd_pins xpm_cdc_gen_1/dest_arst]
  connect_bd_net -net xpm_cdc_gen_2_dest_arst [get_bd_pins udp_core_100g_ip_1/udp_axis_m_reset] [get_bd_pins udp_core_100g_ip_1/udp_axis_s_reset] [get_bd_pins util_vector_logic_3/Op1] [get_bd_pins xpm_cdc_gen_2/dest_arst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hbm
proc create_hier_cell_hbm { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hbm() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN1_D_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_6

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_7


  # Create pins
  create_bd_pin -dir I -type clk AXI_01_ACLK
  create_bd_pin -dir I -type clk AXI_17_ACLK
  create_bd_pin -dir O -from 6 -to 0 DRAM_0_STAT_TEMP
  create_bd_pin -dir O -from 6 -to 0 DRAM_1_STAT_TEMP
  create_bd_pin -dir O -from 0 -to 0 Res
  create_bd_pin -dir O apb_complete_0_0
  create_bd_pin -dir O apb_complete_1_0
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_areset_n
  create_bd_pin -dir I -type rst sys_rst_n

  # Create instance: axi_apb_bridge_0, and set properties
  set axi_apb_bridge_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_apb_bridge:3.0 axi_apb_bridge_0 ]
  set_property -dict [ list \
   CONFIG.C_APB_NUM_SLAVES {1} \
 ] $axi_apb_bridge_0

  # Create instance: axi_apb_bridge_1, and set properties
  set axi_apb_bridge_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_apb_bridge:3.0 axi_apb_bridge_1 ]
  set_property -dict [ list \
   CONFIG.C_APB_NUM_SLAVES {1} \
 ] $axi_apb_bridge_1

  # Create instance: axi_clock_converter_0, and set properties
  set axi_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_0 ]

  # Create instance: axi_clock_converter_1, and set properties
  set axi_clock_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_1 ]

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {115.831} \
   CONFIG.CLKOUT1_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {100} \
   CONFIG.CLKOUT2_JITTER {115.831} \
   CONFIG.CLKOUT2_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {100} \
   CONFIG.CLKOUT2_REQUESTED_PHASE {0.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {103.224} \
   CONFIG.CLKOUT3_PHASE_ERROR {84.520} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT3_REQUESTED_PHASE {0.000} \
   CONFIG.CLKOUT3_USED {false} \
   CONFIG.CLKOUT4_JITTER {103.224} \
   CONFIG.CLKOUT4_PHASE_ERROR {84.520} \
   CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT4_REQUESTED_PHASE {0.000} \
   CONFIG.CLKOUT4_USED {false} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {hbm_clk} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {12.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {12} \
   CONFIG.MMCM_CLKOUT1_PHASE {0.000} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
   CONFIG.MMCM_CLKOUT2_PHASE {0.000} \
   CONFIG.MMCM_CLKOUT3_DIVIDE {1} \
   CONFIG.MMCM_CLKOUT3_PHASE {0.000} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_LOCKED {true} \
 ] $clk_wiz_1

  # Create instance: hbm_0, and set properties
  set hbm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm:1.0 hbm_0 ]
  set_property -dict [ list \
   CONFIG.HBM_MMCM1_FBOUT_MULT0 {15} \
   CONFIG.HBM_MMCM_FBOUT_MULT0 {15} \
   CONFIG.USER_AXI_INPUT_CLK1_FREQ {240} \
   CONFIG.USER_AXI_INPUT_CLK1_NS {4.167} \
   CONFIG.USER_AXI_INPUT_CLK1_PS {4166} \
   CONFIG.USER_AXI_INPUT_CLK1_XDC {4.167} \
   CONFIG.USER_AXI_INPUT_CLK_FREQ {240} \
   CONFIG.USER_AXI_INPUT_CLK_NS {4.167} \
   CONFIG.USER_AXI_INPUT_CLK_PS {4166} \
   CONFIG.USER_AXI_INPUT_CLK_XDC {4.167} \
   CONFIG.USER_CLK_SEL_LIST0 {AXI_01_ACLK} \
   CONFIG.USER_CLK_SEL_LIST1 {AXI_17_ACLK} \
   CONFIG.USER_DEBUG_EN {FALSE} \
   CONFIG.USER_EXAMPLE_TG {NON_SYNTHESIZABLE} \
   CONFIG.USER_HBM_CP_1 {6} \
   CONFIG.USER_HBM_DENSITY {8GB} \
   CONFIG.USER_HBM_FBDIV_1 {36} \
   CONFIG.USER_HBM_HEX_CP_RES_1 {0x0000A600} \
   CONFIG.USER_HBM_HEX_FBDIV_CLKOUTDIV_1 {0x00000902} \
   CONFIG.USER_HBM_HEX_LOCK_FB_REF_DLY_1 {0x00001f1f} \
   CONFIG.USER_HBM_LOCK_FB_DLY_1 {31} \
   CONFIG.USER_HBM_LOCK_REF_DLY_1 {31} \
   CONFIG.USER_HBM_RES_1 {10} \
   CONFIG.USER_HBM_STACK {2} \
   CONFIG.USER_MC0_EN_SBREF {true} \
   CONFIG.USER_MC0_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC0_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC10_EN_SBREF {true} \
   CONFIG.USER_MC10_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC10_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC11_EN_SBREF {true} \
   CONFIG.USER_MC11_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC11_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC12_EN_SBREF {true} \
   CONFIG.USER_MC12_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC12_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC13_EN_SBREF {true} \
   CONFIG.USER_MC13_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC13_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC14_EN_SBREF {true} \
   CONFIG.USER_MC14_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC14_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC15_EN_SBREF {true} \
   CONFIG.USER_MC15_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC15_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC1_EN_SBREF {true} \
   CONFIG.USER_MC1_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC1_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC2_EN_SBREF {true} \
   CONFIG.USER_MC2_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC2_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC3_EN_SBREF {true} \
   CONFIG.USER_MC3_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC3_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC4_EN_SBREF {true} \
   CONFIG.USER_MC4_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC4_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC5_EN_SBREF {true} \
   CONFIG.USER_MC5_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC5_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC6_EN_SBREF {true} \
   CONFIG.USER_MC6_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC6_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC7_EN_SBREF {true} \
   CONFIG.USER_MC7_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC7_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC8_EN_SBREF {true} \
   CONFIG.USER_MC8_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC8_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC9_EN_SBREF {true} \
   CONFIG.USER_MC9_LOOKAHEAD_SBRF {true} \
   CONFIG.USER_MC9_TRAFFIC_OPTION {User_Defined} \
   CONFIG.USER_MC_ENABLE_00 {TRUE} \
   CONFIG.USER_MC_ENABLE_01 {TRUE} \
   CONFIG.USER_MC_ENABLE_02 {TRUE} \
   CONFIG.USER_MC_ENABLE_03 {TRUE} \
   CONFIG.USER_MC_ENABLE_04 {FALSE} \
   CONFIG.USER_MC_ENABLE_05 {FALSE} \
   CONFIG.USER_MC_ENABLE_06 {FALSE} \
   CONFIG.USER_MC_ENABLE_07 {FALSE} \
   CONFIG.USER_MC_ENABLE_08 {TRUE} \
   CONFIG.USER_MC_ENABLE_09 {TRUE} \
   CONFIG.USER_MC_ENABLE_10 {TRUE} \
   CONFIG.USER_MC_ENABLE_11 {TRUE} \
   CONFIG.USER_MC_ENABLE_12 {FALSE} \
   CONFIG.USER_MC_ENABLE_13 {FALSE} \
   CONFIG.USER_MC_ENABLE_14 {FALSE} \
   CONFIG.USER_MC_ENABLE_15 {FALSE} \
   CONFIG.USER_MC_ENABLE_APB_01 {TRUE} \
   CONFIG.USER_MEMORY_DISPLAY {8192} \
   CONFIG.USER_PHY_ENABLE_08 {TRUE} \
   CONFIG.USER_PHY_ENABLE_09 {TRUE} \
   CONFIG.USER_PHY_ENABLE_10 {TRUE} \
   CONFIG.USER_PHY_ENABLE_11 {TRUE} \
   CONFIG.USER_PHY_ENABLE_12 {TRUE} \
   CONFIG.USER_PHY_ENABLE_13 {TRUE} \
   CONFIG.USER_PHY_ENABLE_14 {TRUE} \
   CONFIG.USER_PHY_ENABLE_15 {TRUE} \
   CONFIG.USER_SAXI_01 {true} \
   CONFIG.USER_SAXI_02 {true} \
   CONFIG.USER_SAXI_03 {true} \
   CONFIG.USER_SAXI_04 {false} \
   CONFIG.USER_SAXI_05 {false} \
   CONFIG.USER_SAXI_06 {false} \
   CONFIG.USER_SAXI_07 {false} \
   CONFIG.USER_SAXI_08 {false} \
   CONFIG.USER_SAXI_09 {false} \
   CONFIG.USER_SAXI_10 {false} \
   CONFIG.USER_SAXI_11 {false} \
   CONFIG.USER_SAXI_12 {false} \
   CONFIG.USER_SAXI_13 {false} \
   CONFIG.USER_SAXI_14 {false} \
   CONFIG.USER_SAXI_15 {false} \
   CONFIG.USER_SAXI_20 {false} \
   CONFIG.USER_SAXI_21 {false} \
   CONFIG.USER_SAXI_22 {false} \
   CONFIG.USER_SAXI_23 {false} \
   CONFIG.USER_SAXI_24 {false} \
   CONFIG.USER_SAXI_25 {false} \
   CONFIG.USER_SAXI_26 {false} \
   CONFIG.USER_SAXI_27 {false} \
   CONFIG.USER_SAXI_28 {false} \
   CONFIG.USER_SAXI_29 {false} \
   CONFIG.USER_SAXI_30 {false} \
   CONFIG.USER_SAXI_31 {false} \
   CONFIG.USER_SWITCH_ENABLE_01 {TRUE} \
   CONFIG.USER_XSDB_INTF_EN {FALSE} \
 ] $hbm_0

  # Create instance: rama_0, and set properties
  set rama_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_0 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_0

  # Create instance: rama_1, and set properties
  set rama_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_1 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_1

  # Create instance: rama_2, and set properties
  set rama_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_2 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_2

  # Create instance: rama_3, and set properties
  set rama_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_3 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_3

  # Create instance: rama_4, and set properties
  set rama_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_4 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_4

  # Create instance: rama_5, and set properties
  set rama_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_5 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_5

  # Create instance: rama_6, and set properties
  set rama_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_6 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_6

  # Create instance: rama_7, and set properties
  set rama_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:rama:1.1 rama_7 ]
  set_property -dict [ list \
   CONFIG.ID_WIDTH {6} \
 ] $rama_7

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins CLK_IN1_D_0] [get_bd_intf_pins clk_wiz_1/CLK_IN1_D]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axi_0] [get_bd_intf_pins rama_0/s_axi]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axi_1] [get_bd_intf_pins rama_1/s_axi]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axi_3] [get_bd_intf_pins rama_3/s_axi]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins s_axi_4] [get_bd_intf_pins rama_4/s_axi]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins s_axi_5] [get_bd_intf_pins rama_5/s_axi]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins s_axi_6] [get_bd_intf_pins rama_6/s_axi]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins s_axi_7] [get_bd_intf_pins rama_7/s_axi]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins s_axi_2] [get_bd_intf_pins rama_2/s_axi]
  connect_bd_intf_net -intf_net axi_apb_bridge_0_APB_M [get_bd_intf_pins axi_apb_bridge_0/APB_M] [get_bd_intf_pins hbm_0/SAPB_0]
  connect_bd_intf_net -intf_net axi_apb_bridge_1_APB_M [get_bd_intf_pins axi_apb_bridge_1/APB_M] [get_bd_intf_pins hbm_0/SAPB_1]
  connect_bd_intf_net -intf_net axi_clock_converter_0_M_AXI [get_bd_intf_pins axi_apb_bridge_0/AXI4_LITE] [get_bd_intf_pins axi_clock_converter_0/M_AXI]
  connect_bd_intf_net -intf_net axi_clock_converter_1_M_AXI [get_bd_intf_pins axi_apb_bridge_1/AXI4_LITE] [get_bd_intf_pins axi_clock_converter_1/M_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M05_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_clock_converter_0/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M06_AXI [get_bd_intf_pins S_AXI1] [get_bd_intf_pins axi_clock_converter_1/S_AXI]
  connect_bd_intf_net -intf_net rama_0_m_axi [get_bd_intf_pins hbm_0/SAXI_00] [get_bd_intf_pins rama_0/m_axi]
  connect_bd_intf_net -intf_net rama_1_m_axi [get_bd_intf_pins hbm_0/SAXI_01] [get_bd_intf_pins rama_1/m_axi]
  connect_bd_intf_net -intf_net rama_2_m_axi [get_bd_intf_pins hbm_0/SAXI_02] [get_bd_intf_pins rama_2/m_axi]
  connect_bd_intf_net -intf_net rama_3_m_axi [get_bd_intf_pins hbm_0/SAXI_03] [get_bd_intf_pins rama_3/m_axi]
  connect_bd_intf_net -intf_net rama_4_m_axi [get_bd_intf_pins hbm_0/SAXI_16] [get_bd_intf_pins rama_4/m_axi]
  connect_bd_intf_net -intf_net rama_5_m_axi [get_bd_intf_pins hbm_0/SAXI_17] [get_bd_intf_pins rama_5/m_axi]
  connect_bd_intf_net -intf_net rama_6_m_axi [get_bd_intf_pins hbm_0/SAXI_18] [get_bd_intf_pins rama_6/m_axi]
  connect_bd_intf_net -intf_net rama_7_m_axi [get_bd_intf_pins hbm_0/SAXI_19] [get_bd_intf_pins rama_7/m_axi]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_out5 [get_bd_pins AXI_01_ACLK] [get_bd_pins hbm_0/AXI_00_ACLK] [get_bd_pins hbm_0/AXI_01_ACLK] [get_bd_pins hbm_0/AXI_02_ACLK] [get_bd_pins hbm_0/AXI_03_ACLK] [get_bd_pins rama_0/axi_aclk] [get_bd_pins rama_1/axi_aclk] [get_bd_pins rama_2/axi_aclk] [get_bd_pins rama_3/axi_aclk]
  connect_bd_net -net clk_wiz_0_clk_out6 [get_bd_pins AXI_17_ACLK] [get_bd_pins hbm_0/AXI_16_ACLK] [get_bd_pins hbm_0/AXI_17_ACLK] [get_bd_pins hbm_0/AXI_18_ACLK] [get_bd_pins hbm_0/AXI_19_ACLK] [get_bd_pins rama_4/axi_aclk] [get_bd_pins rama_5/axi_aclk] [get_bd_pins rama_6/axi_aclk] [get_bd_pins rama_7/axi_aclk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins sys_rst_n] [get_bd_pins hbm_0/AXI_00_ARESET_N] [get_bd_pins hbm_0/AXI_01_ARESET_N] [get_bd_pins hbm_0/AXI_02_ARESET_N] [get_bd_pins hbm_0/AXI_03_ARESET_N] [get_bd_pins hbm_0/AXI_16_ARESET_N] [get_bd_pins hbm_0/AXI_17_ARESET_N] [get_bd_pins hbm_0/AXI_18_ARESET_N] [get_bd_pins hbm_0/AXI_19_ARESET_N] [get_bd_pins rama_0/axi_aresetn] [get_bd_pins rama_1/axi_aresetn] [get_bd_pins rama_2/axi_aresetn] [get_bd_pins rama_3/axi_aresetn] [get_bd_pins rama_4/axi_aresetn] [get_bd_pins rama_5/axi_aresetn] [get_bd_pins rama_6/axi_aresetn] [get_bd_pins rama_7/axi_aresetn]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins axi_apb_bridge_0/s_axi_aclk] [get_bd_pins axi_clock_converter_0/m_axi_aclk] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins hbm_0/APB_0_PCLK] [get_bd_pins hbm_0/HBM_REF_CLK_0]
  connect_bd_net -net clk_wiz_1_clk_out2 [get_bd_pins axi_apb_bridge_1/s_axi_aclk] [get_bd_pins axi_clock_converter_1/m_axi_aclk] [get_bd_pins clk_wiz_1/clk_out2] [get_bd_pins hbm_0/APB_1_PCLK] [get_bd_pins hbm_0/HBM_REF_CLK_1]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins axi_apb_bridge_0/s_axi_aresetn] [get_bd_pins axi_apb_bridge_1/s_axi_aresetn] [get_bd_pins axi_clock_converter_0/m_axi_aresetn] [get_bd_pins axi_clock_converter_1/m_axi_aresetn] [get_bd_pins clk_wiz_1/locked] [get_bd_pins hbm_0/APB_0_PRESET_N] [get_bd_pins hbm_0/APB_1_PRESET_N]
  connect_bd_net -net hbm_0_DRAM_0_STAT_CATTRIP [get_bd_pins hbm_0/DRAM_0_STAT_CATTRIP] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net hbm_0_DRAM_0_STAT_TEMP [get_bd_pins DRAM_0_STAT_TEMP] [get_bd_pins hbm_0/DRAM_0_STAT_TEMP]
  connect_bd_net -net hbm_0_DRAM_1_STAT_CATTRIP [get_bd_pins hbm_0/DRAM_1_STAT_CATTRIP] [get_bd_pins util_vector_logic_0/Op2]
  connect_bd_net -net hbm_0_DRAM_1_STAT_TEMP [get_bd_pins DRAM_1_STAT_TEMP] [get_bd_pins hbm_0/DRAM_1_STAT_TEMP]
  connect_bd_net -net hbm_0_apb_complete_0 [get_bd_pins apb_complete_0_0] [get_bd_pins hbm_0/apb_complete_0]
  connect_bd_net -net hbm_0_apb_complete_1 [get_bd_pins apb_complete_1_0] [get_bd_pins hbm_0/apb_complete_1]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins Res] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins s_axi_aclk] [get_bd_pins axi_clock_converter_0/s_axi_aclk] [get_bd_pins axi_clock_converter_1/s_axi_aclk]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_pins s_axi_areset_n] [get_bd_pins axi_clock_converter_0/s_axi_aresetn] [get_bd_pins axi_clock_converter_1/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: DNA_reg
proc create_hier_cell_DNA_reg { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_DNA_reg() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_areset_n

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_ALL_OUTPUTS_2 {0} \
   CONFIG.C_DOUT_DEFAULT {0xC0FFEE09} \
   CONFIG.C_DOUT_DEFAULT_2 {0x00000000} \
   CONFIG.C_GPIO2_WIDTH {32} \
   CONFIG.C_IS_DUAL {1} \
   CONFIG.C_TRI_DEFAULT {0xDECADE09} \
   CONFIG.GPIO2_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_1

  # Create instance: device_dna_0, and set properties
  set block_name device_dna
  set block_cell_name device_dna_0
  if { [catch {set device_dna_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $device_dna_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_WIDTH {96} \
   CONFIG.DOUT_WIDTH {32} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {63} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {96} \
   CONFIG.DOUT_WIDTH {32} \
 ] $xlslice_1

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_0_M07_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_1/S_AXI]

  # Create port connections
  connect_bd_net -net axi4lite_aclk_0_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_1/s_axi_aclk] [get_bd_pins device_dna_0/clk]
  connect_bd_net -net axi4lite_aresetn_0_1 [get_bd_pins s_axi_areset_n] [get_bd_pins axi_gpio_1/s_axi_aresetn] [get_bd_pins device_dna_0/rst]
  connect_bd_net -net device_dna_0_dna [get_bd_pins device_dna_0/dna] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins axi_gpio_1/gpio_io_i] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins axi_gpio_1/gpio2_io_i] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set M04_AXI_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {62500000} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   ] $M04_AXI_0

  set M_AXIS_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_0 ]

  set S_AXIS_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_0 ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {64} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_0

  set cmc_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 cmc_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $cmc_clk

  set gt_ref_clk_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gt_ref_clk_0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {161132812} \
   ] $gt_ref_clk_0

  set gt_serial_port_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 gt_serial_port_0 ]

  set hbm_cattrip [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 hbm_cattrip ]

  set hbm_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 hbm_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $hbm_clk

  set pci_express_x1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pci_express_x1 ]

  set pcie_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $pcie_refclk

  set s_axi_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_0

  set s_axi_2 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_2 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_2

  set s_axi_3 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_3 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_3

  set s_axi_4 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_4 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_4

  set s_axi_5 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_5 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_5

  set s_axi_6 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_6 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_6

  set s_axi_7 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_7 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_7

  set s_axi_8 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_8 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {33} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {256} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {6} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi_8

  set satellite_uart_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 satellite_uart_0 ]


  # Create ports
  set apb_complete_0_0_0 [ create_bd_port -dir O apb_complete_0_0_0 ]
  set apb_complete_1_0_0 [ create_bd_port -dir O apb_complete_1_0_0 ]
  set pcie_perstn [ create_bd_port -dir I -type rst pcie_perstn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $pcie_perstn
  set s_axi_aclk [ create_bd_port -dir O s_axi_aclk ]
  set s_axi_areset_n [ create_bd_port -dir O s_axi_areset_n ]
  set satellite_gpio_0 [ create_bd_port -dir I -from 1 -to 0 -type intr satellite_gpio_0 ]
  set_property -dict [ list \
   CONFIG.PortWidth {2} \
   CONFIG.SENSITIVITY {EDGE_RISING} \
 ] $satellite_gpio_0
  set sys_clk [ create_bd_port -dir O -type clk sys_clk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S_AXIS_0:M_AXIS_0:s_axi_0:s_axi_3:s_axi_4:s_axi_5:s_axi_6:s_axi_7:s_axi_8:s_axi_2} \
 ] $sys_clk
  set sys_clk90 [ create_bd_port -dir O -type clk sys_clk90 ]
  set sys_clk180 [ create_bd_port -dir O -type clk sys_clk180 ]
  set sys_clk270 [ create_bd_port -dir O -type clk sys_clk270 ]
  set sys_rst_n [ create_bd_port -dir O -type rst sys_rst_n ]

  # Create instance: DNA_reg
  create_hier_cell_DNA_reg [current_bd_instance .] DNA_reg

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0xC0FFEE09} \
   CONFIG.C_DOUT_DEFAULT_2 {0x00000001} \
   CONFIG.C_GPIO2_WIDTH {1} \
   CONFIG.C_IS_DUAL {1} \
   CONFIG.C_TRI_DEFAULT {0xDECADE09} \
   CONFIG.GPIO2_BOARD_INTERFACE {hbm_cattrip} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_0

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0 ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {0} \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {8} \
   CONFIG.S00_HAS_REGSLICE {4} \
 ] $axi_interconnect_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {98.767} \
   CONFIG.CLKOUT1_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {240} \
   CONFIG.CLKOUT2_JITTER {98.767} \
   CONFIG.CLKOUT2_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {240} \
   CONFIG.CLKOUT2_REQUESTED_PHASE {90} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {98.767} \
   CONFIG.CLKOUT3_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {240} \
   CONFIG.CLKOUT3_REQUESTED_PHASE {180} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.CLKOUT4_JITTER {98.767} \
   CONFIG.CLKOUT4_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {240} \
   CONFIG.CLKOUT4_REQUESTED_PHASE {270} \
   CONFIG.CLKOUT4_USED {true} \
   CONFIG.CLKOUT5_JITTER {98.767} \
   CONFIG.CLKOUT5_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {240} \
   CONFIG.CLKOUT5_USED {true} \
   CONFIG.CLKOUT6_JITTER {98.767} \
   CONFIG.CLKOUT6_PHASE_ERROR {87.180} \
   CONFIG.CLKOUT6_REQUESTED_OUT_FREQ {240} \
   CONFIG.CLKOUT6_USED {true} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {cmc_clk} \
   CONFIG.CLK_IN2_BOARD_INTERFACE {Custom} \
   CONFIG.ENABLE_CLOCK_MONITOR {false} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {12.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {10.000} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {5.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {5} \
   CONFIG.MMCM_CLKOUT1_PHASE {90.000} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {5} \
   CONFIG.MMCM_CLKOUT2_PHASE {180.000} \
   CONFIG.MMCM_CLKOUT3_DIVIDE {5} \
   CONFIG.MMCM_CLKOUT3_PHASE {270.000} \
   CONFIG.MMCM_CLKOUT4_DIVIDE {5} \
   CONFIG.MMCM_CLKOUT5_DIVIDE {5} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {6} \
   CONFIG.PRIMITIVE {MMCM} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_INCLK_SWITCHOVER {false} \
   CONFIG.USE_RESET {true} \
 ] $clk_wiz_0

  # Create instance: cms_subsystem_0, and set properties
  set cms_subsystem_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:cms_subsystem:4.0 cms_subsystem_0 ]

  # Create instance: hbm
  create_hier_cell_hbm [current_bd_instance .] hbm

  # Create instance: hgbe
  create_hier_cell_hgbe [current_bd_instance .] hgbe

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
   CONFIG.DIFF_CLK_IN_BOARD_INTERFACE {pcie_refclk} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $util_ds_buf_0

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0 ]
  set_property -dict [ list \
   CONFIG.PCIE_BOARD_INTERFACE {pci_express_x1} \
   CONFIG.PF0_DEVICE_ID_mqdma {9021} \
   CONFIG.PF0_SRIOV_VF_DEVICE_ID {A031} \
   CONFIG.PF1_SRIOV_VF_DEVICE_ID {A131} \
   CONFIG.PF2_DEVICE_ID_mqdma {9221} \
   CONFIG.PF2_SRIOV_VF_DEVICE_ID {A231} \
   CONFIG.PF3_DEVICE_ID_mqdma {9321} \
   CONFIG.PF3_SRIOV_VF_DEVICE_ID {A331} \
   CONFIG.SYS_RST_N_BOARD_INTERFACE {Custom} \
   CONFIG.axi_data_width {64_bit} \
   CONFIG.axilite_master_en {true} \
   CONFIG.axilite_master_scale {Megabytes} \
   CONFIG.axilite_master_size {256} \
   CONFIG.axisten_freq {62.5} \
   CONFIG.copy_pf0 {true} \
   CONFIG.coreclk_freq {250} \
   CONFIG.dma_reset_source_sel {User_Reset} \
   CONFIG.drp_clk_sel {Internal} \
   CONFIG.en_gt_selection {true} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pcie_blk_locn {PCIE4C_X1Y0} \
   CONFIG.pf0_device_id {9021} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_1} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1} \
   CONFIG.pl_link_cap_max_link_speed {5.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X1} \
   CONFIG.plltype {QPLL1} \
   CONFIG.select_quad {GTY_Quad_227} \
   CONFIG.xdma_axi_intf_mm {AXI_Stream} \
   CONFIG.xdma_axilite_slave {false} \
   CONFIG.xdma_rnum_chnl {3} \
   CONFIG.xdma_wnum_chnl {3} \
 ] $xdma_0

  # Create instance: xpm_cdc_gen_0, and set properties
  set xpm_cdc_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xpm_cdc_gen:1.0 xpm_cdc_gen_0 ]
  set_property -dict [ list \
   CONFIG.CDC_TYPE {xpm_cdc_async_rst} \
   CONFIG.DEST_SYNC_FF {2} \
   CONFIG.RST_ACTIVE_HIGH {false} \
 ] $xpm_cdc_gen_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins xdma_0/M_AXI_LITE]
  connect_bd_intf_net -intf_net S_AXIS_0_1 [get_bd_intf_ports S_AXIS_0] [get_bd_intf_pins hgbe/S_AXIS_0]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO2 [get_bd_intf_ports hbm_cattrip] [get_bd_intf_pins axi_gpio_0/GPIO2]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins hgbe/axi4lite]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins cms_subsystem_0/s_axi_ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_ports M04_AXI_0] [get_bd_intf_pins axi_interconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M05_AXI [get_bd_intf_pins axi_interconnect_0/M05_AXI] [get_bd_intf_pins hbm/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M06_AXI [get_bd_intf_pins axi_interconnect_0/M06_AXI] [get_bd_intf_pins hbm/S_AXI1]
  connect_bd_intf_net -intf_net axi_interconnect_0_M07_AXI [get_bd_intf_pins DNA_reg/S_AXI] [get_bd_intf_pins axi_interconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net axis_dwidth_converter_4_M_AXIS [get_bd_intf_pins hgbe/M_AXIS] [get_bd_intf_pins xdma_0/S_AXIS_C2H_1]
  connect_bd_intf_net -intf_net axis_dwidth_converter_5_M_AXIS [get_bd_intf_pins hgbe/M_AXIS1] [get_bd_intf_pins xdma_0/S_AXIS_C2H_2]
  connect_bd_intf_net -intf_net cmac_usplus_1_gt_serial_port [get_bd_intf_ports gt_serial_port_0] [get_bd_intf_pins hgbe/gt_serial_port_0]
  connect_bd_intf_net -intf_net cmc_clk_1 [get_bd_intf_ports cmc_clk] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net cms_subsystem_0_satellite_uart [get_bd_intf_ports satellite_uart_0] [get_bd_intf_pins cms_subsystem_0/satellite_uart]
  connect_bd_intf_net -intf_net gt_ref_clk_0_1 [get_bd_intf_ports gt_ref_clk_0] [get_bd_intf_pins hgbe/gt_ref_clk_0]
  connect_bd_intf_net -intf_net hbm_clk_1 [get_bd_intf_ports hbm_clk] [get_bd_intf_pins hbm/CLK_IN1_D_0]
  connect_bd_intf_net -intf_net hgbe_M_AXIS_0 [get_bd_intf_ports M_AXIS_0] [get_bd_intf_pins hgbe/M_AXIS_0]
  connect_bd_intf_net -intf_net pcie_refclk_1 [get_bd_intf_ports pcie_refclk] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net s_axi_0_1 [get_bd_intf_ports s_axi_0] [get_bd_intf_pins hbm/s_axi_0]
  connect_bd_intf_net -intf_net s_axi_2_1 [get_bd_intf_ports s_axi_2] [get_bd_intf_pins hbm/s_axi_1]
  connect_bd_intf_net -intf_net s_axi_3_1 [get_bd_intf_ports s_axi_3] [get_bd_intf_pins hbm/s_axi_3]
  connect_bd_intf_net -intf_net s_axi_4_1 [get_bd_intf_ports s_axi_4] [get_bd_intf_pins hbm/s_axi_4]
  connect_bd_intf_net -intf_net s_axi_5_1 [get_bd_intf_ports s_axi_5] [get_bd_intf_pins hbm/s_axi_5]
  connect_bd_intf_net -intf_net s_axi_6_1 [get_bd_intf_ports s_axi_6] [get_bd_intf_pins hbm/s_axi_6]
  connect_bd_intf_net -intf_net s_axi_7_1 [get_bd_intf_ports s_axi_7] [get_bd_intf_pins hbm/s_axi_7]
  connect_bd_intf_net -intf_net s_axi_8_1 [get_bd_intf_ports s_axi_8] [get_bd_intf_pins hbm/s_axi_2]
  connect_bd_intf_net -intf_net xdma_0_M_AXIS_H2C_1 [get_bd_intf_pins hgbe/S_AXIS] [get_bd_intf_pins xdma_0/M_AXIS_H2C_1]
  connect_bd_intf_net -intf_net xdma_0_M_AXIS_H2C_2 [get_bd_intf_pins hgbe/S_AXIS1] [get_bd_intf_pins xdma_0/M_AXIS_H2C_2]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_ports pci_express_x1] [get_bd_intf_pins xdma_0/pcie_mgt]

  # Create port connections
  connect_bd_net -net AXI_17_ACLK_1 [get_bd_pins clk_wiz_0/clk_out6] [get_bd_pins hbm/AXI_17_ACLK]
  connect_bd_net -net axi4lite_aclk_0_1 [get_bd_ports s_axi_aclk] [get_bd_pins DNA_reg/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK] [get_bd_pins axi_interconnect_0/M05_ACLK] [get_bd_pins axi_interconnect_0/M06_ACLK] [get_bd_pins axi_interconnect_0/M07_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins cms_subsystem_0/aclk_ctrl] [get_bd_pins hbm/s_axi_aclk] [get_bd_pins hgbe/s_axi_aclk] [get_bd_pins xdma_0/axi_aclk] [get_bd_pins xpm_cdc_gen_0/dest_clk]
  connect_bd_net -net axi4lite_aresetn_0_1 [get_bd_ports s_axi_areset_n] [get_bd_pins DNA_reg/s_axi_areset_n] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M04_ARESETN] [get_bd_pins axi_interconnect_0/M05_ARESETN] [get_bd_pins axi_interconnect_0/M06_ARESETN] [get_bd_pins axi_interconnect_0/M07_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins cms_subsystem_0/aresetn_ctrl] [get_bd_pins hbm/s_axi_areset_n] [get_bd_pins hgbe/s_axi_areset_n] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net axi_intc_0_irq [get_bd_pins axi_intc_0/irq] [get_bd_pins xdma_0/usr_irq_req]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_ports sys_clk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins hgbe/s_axis_aclk]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_ports sys_clk90] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net clk_wiz_0_clk_out4 [get_bd_ports sys_clk180] [get_bd_pins clk_wiz_0/clk_out3]
  connect_bd_net -net clk_wiz_0_clk_out5 [get_bd_ports sys_clk270] [get_bd_pins clk_wiz_0/clk_out4]
  connect_bd_net -net clk_wiz_0_clk_out6 [get_bd_pins clk_wiz_0/clk_out5] [get_bd_pins hbm/AXI_01_ACLK]
  connect_bd_net -net clk_wiz_0_locked [get_bd_ports sys_rst_n] [get_bd_pins clk_wiz_0/locked] [get_bd_pins hbm/sys_rst_n] [get_bd_pins hgbe/sys_rst_n]
  connect_bd_net -net cms_subsystem_0_interrupt_host [get_bd_pins axi_intc_0/intr] [get_bd_pins cms_subsystem_0/interrupt_host]
  connect_bd_net -net hbm_DRAM_0_STAT_TEMP [get_bd_pins cms_subsystem_0/hbm_temp_1] [get_bd_pins hbm/DRAM_0_STAT_TEMP]
  connect_bd_net -net hbm_DRAM_1_STAT_TEMP [get_bd_pins cms_subsystem_0/hbm_temp_2] [get_bd_pins hbm/DRAM_1_STAT_TEMP]
  connect_bd_net -net hbm_Res [get_bd_pins cms_subsystem_0/interrupt_hbm_cattrip] [get_bd_pins hbm/Res]
  connect_bd_net -net hbm_apb_complete_0_0 [get_bd_ports apb_complete_0_0_0] [get_bd_pins hbm/apb_complete_0_0]
  connect_bd_net -net hbm_apb_complete_1_0 [get_bd_ports apb_complete_1_0_0] [get_bd_pins hbm/apb_complete_1_0]
  connect_bd_net -net pcie_perstn_1 [get_bd_ports pcie_perstn] [get_bd_pins xpm_cdc_gen_0/src_arst]
  connect_bd_net -net satellite_gpio_0_1 [get_bd_ports satellite_gpio_0] [get_bd_pins cms_subsystem_0/satellite_gpio]
  connect_bd_net -net util_ds_buf_0_IBUF_DS_ODIV2 [get_bd_pins util_ds_buf_0/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net xpm_cdc_gen_0_dest_arst [get_bd_pins xdma_0/sys_rst_n] [get_bd_pins xpm_cdc_gen_0/dest_arst]

  # Create address segments
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs M04_AXI_0/Reg] -force
  assign_bd_address -offset 0x000A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00060000 -range 0x00010000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs DNA_reg/axi_gpio_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x00090000 -range 0x00010000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_intc_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00040000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs cms_subsystem_0/s_axi_ctrl/Mem0] -force
  assign_bd_address -offset 0x00400000 -range 0x00400000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs hbm/hbm_0/SAPB_0/Reg] -force
  assign_bd_address -offset 0x00800000 -range 0x00400000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs hbm/hbm_0/SAPB_1/Reg] -force
  assign_bd_address -offset 0x00100000 -range 0x00100000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs hgbe/udp_core_100g_ip_1/axi4lite/reg0] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM00] -force
  assign_bd_address -offset 0x00000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM03] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM04] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM05] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM06] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM07] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM16] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM17] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM18] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM19] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM20] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM21] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM22] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_7] [get_bd_addr_segs hbm/hbm_0/SAXI_19/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_6] [get_bd_addr_segs hbm/hbm_0/SAXI_18/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_5] [get_bd_addr_segs hbm/hbm_0/SAXI_17/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_4] [get_bd_addr_segs hbm/hbm_0/SAXI_16/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_3] [get_bd_addr_segs hbm/hbm_0/SAXI_03/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_2] [get_bd_addr_segs hbm/hbm_0/SAXI_01/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_0] [get_bd_addr_segs hbm/hbm_0/SAXI_00/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces s_axi_8] [get_bd_addr_segs hbm/hbm_0/SAXI_02/HBM_MEM23] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


