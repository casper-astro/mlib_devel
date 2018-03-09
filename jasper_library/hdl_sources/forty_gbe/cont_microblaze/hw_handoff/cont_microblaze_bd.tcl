
################################################################
# This is a generated script based on design: cont_microblaze
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
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source cont_microblaze_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx690tffg1927-2
}


# CHANGE DESIGN NAME HERE
set design_name cont_microblaze

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  set str_bd_folder /home/aisaacson/work/git_work/ska_sa/projects/skarab_bsp_firmware/firmware/FRM123701U1R1/Vivado/BlockDesign
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
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
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -from 0 -to 0 -type rst LMB_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 lmb_bram ]
  set_property -dict [ list \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]
  connect_bd_net -net microblaze_0_LMB_Rst [get_bd_pins LMB_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]

  # Perform GUI Layout
  regenerate_bd_layout -hierarchy [get_bd_cells /microblaze_0_local_memory] -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port LMB_Clk -pg 1 -y 60 -defaultsOSRD
preplace port ILMB -pg 1 -y 190 -defaultsOSRD
preplace port DLMB -pg 1 -y 40 -defaultsOSRD
preplace portBus LMB_Rst -pg 1 -y 80 -defaultsOSRD
preplace inst ilmb_bram_if_cntlr -pg 1 -lvl 2 -y 200 -defaultsOSRD
preplace inst dlmb_bram_if_cntlr -pg 1 -lvl 2 -y 70 -defaultsOSRD
preplace inst lmb_bram -pg 1 -lvl 3 -y 90 -defaultsOSRD
preplace inst ilmb_v10 -pg 1 -lvl 1 -y 210 -defaultsOSRD
preplace inst dlmb_v10 -pg 1 -lvl 1 -y 60 -defaultsOSRD
preplace netloc microblaze_0_dlmb 1 0 1 NJ
preplace netloc microblaze_0_ilmb_bus 1 1 1 -140
preplace netloc microblaze_0_Clk 1 0 2 -360 130 -160
preplace netloc microblaze_0_dlmb_cntlr 1 2 1 80
preplace netloc microblaze_0_LMB_Rst 1 0 2 -370 140 -150
preplace netloc microblaze_0_ilmb 1 0 1 NJ
preplace netloc microblaze_0_ilmb_cntlr 1 2 1 80
preplace netloc microblaze_0_dlmb_bus 1 1 1 -160
levelinfo -pg 1 -390 -260 -30 200 310 -top -10 -bot 280
",
}

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set UART [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 UART ]

  # Create ports
  set ACK_I [ create_bd_port -dir I ACK_I ]
  set ADR_O [ create_bd_port -dir O -from 31 -to 0 ADR_O ]
  set CYC_O [ create_bd_port -dir O CYC_O ]
  set Clk [ create_bd_port -dir I -type clk Clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {39062500} \
 ] $Clk
  set DAT_I [ create_bd_port -dir I -from 31 -to 0 DAT_I ]
  set DAT_O [ create_bd_port -dir O -from 31 -to 0 DAT_O ]
  set RST_O [ create_bd_port -dir O RST_O ]
  set Reset [ create_bd_port -dir I -type rst Reset ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $Reset
  set SEL_O [ create_bd_port -dir O -from 3 -to 0 SEL_O ]
  set STB_O [ create_bd_port -dir O STB_O ]
  set WE_O [ create_bd_port -dir O WE_O ]
  set dcm_locked [ create_bd_port -dir I -type rst dcm_locked ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $dcm_locked

  # Create instance: axi_slave_wishbone_classic_master_0, and set properties
  set axi_slave_wishbone_classic_master_0 [ create_bd_cell -type ip -vlnv peralex.com:user:axi_slave_wishbone_classic_master:1.0 axi_slave_wishbone_classic_master_0 ]
  set_property -dict [ list \
CONFIG.C_S_AXI_ADDR_WIDTH {32} \
 ] $axi_slave_wishbone_classic_master_0

  # Create instance: axi_timebase_wdt_0, and set properties
  set axi_timebase_wdt_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timebase_wdt:3.0 axi_timebase_wdt_0 ]
  set_property -dict [ list \
CONFIG.C_WDT_INTERVAL {29} \
 ] $axi_timebase_wdt_0

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
CONFIG.C_BAUDRATE {115200} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {39062500} \
 ] $axi_uartlite_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_uartlite_0

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
CONFIG.C_USE_UART {0} \
 ] $mdm_1

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:9.6 microblaze_0 ]
  set_property -dict [ list \
CONFIG.C_DEBUG_ENABLED {1} \
CONFIG.C_DIV_ZERO_EXCEPTION {1} \
CONFIG.C_D_AXI {1} \
CONFIG.C_D_LMB {1} \
CONFIG.C_FAULT_TOLERANT {1} \
CONFIG.C_FPU_EXCEPTION {0} \
CONFIG.C_FSL_EXCEPTION {0} \
CONFIG.C_ILL_OPCODE_EXCEPTION {1} \
CONFIG.C_I_LMB {1} \
CONFIG.C_M_AXI_D_BUS_EXCEPTION {1} \
CONFIG.C_M_AXI_I_BUS_EXCEPTION {1} \
CONFIG.C_OPCODE_0x0_ILLEGAL {0} \
CONFIG.C_UNALIGNED_EXCEPTIONS {1} \
CONFIG.C_USE_DIV {1} \
CONFIG.C_USE_STACK_PROTECTION {1} \
CONFIG.G_USE_EXCEPTIONS {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
CONFIG.C_HAS_FAST {1} \
CONFIG.C_PROCESSOR_CLK_FREQ_MHZ {39.0625} \
CONFIG.C_S_AXI_ACLK_FREQ_MHZ {39.0625} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {5} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: rst_Clk_100M, and set properties
  set rst_Clk_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_Clk_100M ]
  set_property -dict [ list \
CONFIG.C_AUX_RESET_HIGH {1} \
CONFIG.C_AUX_RST_WIDTH {1} \
 ] $rst_Clk_100M

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {2} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports UART] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins axi_timebase_wdt_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins axi_slave_wishbone_classic_master_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]

  # Create port connections
  connect_bd_net -net ACK_I_1 [get_bd_ports ACK_I] [get_bd_pins axi_slave_wishbone_classic_master_0/ACK_I]
  connect_bd_net -net DAT_I_1 [get_bd_ports DAT_I] [get_bd_pins axi_slave_wishbone_classic_master_0/DAT_I]
  connect_bd_net -net Reset1_1 [get_bd_ports dcm_locked] [get_bd_pins rst_Clk_100M/dcm_locked]
  connect_bd_net -net Reset_1 [get_bd_ports Reset] [get_bd_pins rst_Clk_100M/ext_reset_in]
  connect_bd_net -net axi_slave_wishbone_classic_master_0_ADR_O [get_bd_ports ADR_O] [get_bd_pins axi_slave_wishbone_classic_master_0/ADR_O]
  connect_bd_net -net axi_slave_wishbone_classic_master_0_CYC_O [get_bd_ports CYC_O] [get_bd_pins axi_slave_wishbone_classic_master_0/CYC_O]
  connect_bd_net -net axi_slave_wishbone_classic_master_0_DAT_O [get_bd_ports DAT_O] [get_bd_pins axi_slave_wishbone_classic_master_0/DAT_O]
  connect_bd_net -net axi_slave_wishbone_classic_master_0_RST_O [get_bd_ports RST_O] [get_bd_pins axi_slave_wishbone_classic_master_0/RST_O]
  connect_bd_net -net axi_slave_wishbone_classic_master_0_SEL_O [get_bd_ports SEL_O] [get_bd_pins axi_slave_wishbone_classic_master_0/SEL_O]
  connect_bd_net -net axi_slave_wishbone_classic_master_0_STB_O [get_bd_ports STB_O] [get_bd_pins axi_slave_wishbone_classic_master_0/STB_O]
  connect_bd_net -net axi_slave_wishbone_classic_master_0_WE_O [get_bd_ports WE_O] [get_bd_pins axi_slave_wishbone_classic_master_0/WE_O]
  connect_bd_net -net axi_timebase_wdt_0_wdt_reset [get_bd_pins axi_timebase_wdt_0/wdt_reset] [get_bd_pins rst_Clk_100M/aux_reset_in]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_Clk_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_ports Clk] [get_bd_pins axi_slave_wishbone_classic_master_0/S_AXI_ACLK] [get_bd_pins axi_timebase_wdt_0/s_axi_aclk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_Clk_100M/slowest_sync_clk]
  connect_bd_net -net rst_Clk_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/LMB_Rst] [get_bd_pins rst_Clk_100M/bus_struct_reset]
  connect_bd_net -net rst_Clk_100M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_Clk_100M/interconnect_aresetn]
  connect_bd_net -net rst_Clk_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins rst_Clk_100M/mb_reset]
  connect_bd_net -net rst_Clk_100M_peripheral_aresetn [get_bd_pins axi_slave_wishbone_classic_master_0/S_AXI_ARESETN] [get_bd_pins axi_timebase_wdt_0/s_axi_aresetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_Clk_100M/peripheral_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins xlconcat_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_slave_wishbone_classic_master_0/S_AXI/reg0] SEG_axi_slave_wishbone_classic_master_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x41A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timebase_wdt_0/S_AXI/Reg] SEG_axi_timebase_wdt_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] SEG_axi_timer_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00040000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00040000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] SEG_microblaze_0_axi_intc_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port RST_O -pg 1 -y 750 -defaultsOSRD
preplace port UART -pg 1 -y 620 -defaultsOSRD
preplace port Clk -pg 1 -y 60 -defaultsOSRD
preplace port WE_O -pg 1 -y 870 -defaultsOSRD
preplace port STB_O -pg 1 -y 850 -defaultsOSRD
preplace port CYC_O -pg 1 -y 810 -defaultsOSRD
preplace port dcm_locked -pg 1 -y 140 -defaultsOSRD
preplace port Reset -pg 1 -y 80 -defaultsOSRD
preplace port ACK_I -pg 1 -y 810 -defaultsOSRD
preplace portBus DAT_O -pg 1 -y 770 -defaultsOSRD
preplace portBus ADR_O -pg 1 -y 790 -defaultsOSRD
preplace portBus SEL_O -pg 1 -y 830 -defaultsOSRD
preplace portBus DAT_I -pg 1 -y 790 -defaultsOSRD
preplace inst axi_timebase_wdt_0 -pg 1 -lvl 5 -y 280 -defaultsOSRD
preplace inst microblaze_0_local_memory|ilmb_v10 -pg 1 -lvl 1 -y 1380 -defaultsOSRD
preplace inst microblaze_0_axi_periph|s00_couplers -pg 1 -lvl 1 -y 502 -defaultsOSRD
preplace inst microblaze_0_axi_periph|m03_couplers -pg 1 -lvl 3 -y 782 -defaultsOSRD
preplace inst microblaze_0_axi_periph|m03_couplers|auto_pc -pg 1 -lvl 1 -y 782 -defaultsOSRD
preplace inst microblaze_0_axi_periph -pg 1 -lvl 4 -y 312 -defaultsOSRD
preplace inst microblaze_0_local_memory|lmb_bram -pg 1 -lvl 3 -y 1260 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 1 -y 530 -defaultsOSRD
preplace inst axi_timer_0 -pg 1 -lvl 5 -y 450 -defaultsOSRD
preplace inst microblaze_0_axi_periph|m04_couplers -pg 1 -lvl 3 -y 952 -defaultsOSRD
preplace inst microblaze_0_local_memory|dlmb_bram_if_cntlr -pg 1 -lvl 2 -y 1250 -defaultsOSRD
preplace inst microblaze_0_axi_intc -pg 1 -lvl 2 -y 290 -defaultsOSRD
preplace inst mdm_1 -pg 1 -lvl 2 -y 70 -defaultsOSRD
preplace inst microblaze_0_axi_periph|m01_couplers -pg 1 -lvl 3 -y 402 -defaultsOSRD
preplace inst rst_Clk_100M -pg 1 -lvl 1 -y 100 -defaultsOSRD
preplace inst microblaze_0 -pg 1 -lvl 3 -y 320 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 5 -y 630 -defaultsOSRD
preplace inst microblaze_0_local_memory|dlmb_v10 -pg 1 -lvl 1 -y 1230 -defaultsOSRD
preplace inst microblaze_0_axi_periph|xbar -pg 1 -lvl 2 -y 532 -defaultsOSRD
preplace inst microblaze_0_local_memory -pg 1 -lvl 4 -y 1220 -defaultsOSRD
preplace inst microblaze_0_axi_periph|m02_couplers -pg 1 -lvl 3 -y 572 -defaultsOSRD
preplace inst microblaze_0_axi_periph|m00_couplers -pg 1 -lvl 3 -y 232 -defaultsOSRD
preplace inst microblaze_0_local_memory|ilmb_bram_if_cntlr -pg 1 -lvl 2 -y 1380 -defaultsOSRD
preplace inst axi_slave_wishbone_classic_master_0 -pg 1 -lvl 5 -y 810 -defaultsOSRD
preplace netloc microblaze_0_axi_periph|m04_couplers_to_microblaze_0_axi_periph 1 3 1 N
preplace netloc microblaze_0_axi_periph|xbar_to_m00_couplers 1 2 1 2360
preplace netloc microblaze_0_axi_periph_M02_AXI 1 4 1 3080
preplace netloc microblaze_0_axi_periph|S00_ACLK_1 1 0 1 N
preplace netloc microblaze_0_local_memory|microblaze_0_dlmb_bus 1 1 1 N
preplace netloc axi_timer_0_interrupt 1 0 6 100 210 NJ 160 NJ 70 NJ 70 NJ 70 4680
preplace netloc microblaze_0_axi_periph|M02_ARESETN_1 1 0 3 NJ 402 NJ 402 2370
preplace netloc microblaze_0_axi_periph|m03_couplers|S_ARESETN_1 1 0 1 N
preplace netloc microblaze_0_axi_periph_M03_AXI 1 4 1 3130
preplace netloc microblaze_0_axi_periph|M00_ARESETN_1 1 0 3 NJ 232 NJ 232 N
preplace netloc microblaze_0_axi_periph_M01_AXI 1 4 1 3100
preplace netloc microblaze_0_axi_periph|s00_couplers_to_xbar 1 1 1 2040
preplace netloc microblaze_0_local_memory|microblaze_0_ilmb 1 0 1 N
preplace netloc microblaze_0_axi_periph|m01_couplers_to_microblaze_0_axi_periph 1 3 1 N
preplace netloc DAT_I_1 1 0 5 NJ 410 NJ 410 NJ 30 NJ 30 3140
preplace netloc microblaze_0_dlmb_1 1 3 1 1300
preplace netloc microblaze_0_intc_axi 1 1 4 530 130 NJ 110 NJ 110 3060
preplace netloc rst_Clk_100M_bus_struct_reset 1 1 3 520 140 NJ 140 NJ
preplace netloc xlconcat_0_dout 1 1 1 530
preplace netloc rst_Clk_100M_mb_reset 1 1 2 510 390 800
preplace netloc microblaze_0_local_memory|microblaze_0_dlmb_cntlr 1 2 1 N
preplace netloc microblaze_0_axi_periph|M02_ACLK_1 1 0 3 NJ 392 NJ 392 2400
preplace netloc microblaze_0_local_memory|microblaze_0_Clk 1 0 2 1820 1300 2040
preplace netloc microblaze_0_axi_periph|m00_couplers_to_microblaze_0_axi_periph 1 3 1 N
preplace netloc microblaze_0_axi_periph|m03_couplers|m03_couplers_to_auto_pc 1 0 1 2580
preplace netloc microblaze_0_axi_periph|xbar_to_m03_couplers 1 2 1 2360
preplace netloc rst_Clk_100M_interconnect_aresetn 1 1 3 NJ 500 NJ 500 1290
preplace netloc microblaze_0_local_memory|microblaze_0_ilmb_bus 1 1 1 2030
preplace netloc microblaze_0_ilmb_1 1 3 1 1270
preplace netloc axi_slave_wishbone_classic_master_0_SEL_O 1 5 1 N
preplace netloc microblaze_0_interrupt 1 2 1 N
preplace netloc mdm_1_debug_sys_rst 1 0 3 110 190 NJ 180 750
preplace netloc microblaze_0_axi_periph|xbar_to_m02_couplers 1 2 1 N
preplace netloc axi_timebase_wdt_0_wdt_reset 1 0 6 110 10 NJ 10 NJ 10 NJ 10 NJ 10 4690
preplace netloc microblaze_0_axi_periph|M01_ACLK_1 1 0 3 NJ 372 NJ 372 2420
preplace netloc axi_uartlite_0_UART 1 5 1 N
preplace netloc axi_slave_wishbone_classic_master_0_DAT_O 1 5 1 N
preplace netloc microblaze_0_axi_periph|xbar_to_m04_couplers 1 2 1 2350
preplace netloc microblaze_0_Clk 1 0 5 70 260 520 400 810 400 1310 80 3090
preplace netloc rst_Clk_100M_peripheral_aresetn 1 1 4 480 150 NJ 150 1330 90 3070
preplace netloc microblaze_0_axi_periph|M01_ARESETN_1 1 0 3 NJ 382 NJ 382 2410
preplace netloc Reset_1 1 0 1 N
preplace netloc microblaze_0_axi_periph|S00_ARESETN_1 1 0 1 N
preplace netloc microblaze_0_axi_periph|M03_ARESETN_1 1 0 3 NJ 752 NJ 752 N
preplace netloc microblaze_0_local_memory|microblaze_0_dlmb 1 0 1 N
preplace netloc microblaze_0_axi_periph|m03_couplers|auto_pc_to_m03_couplers 1 1 1 N
preplace netloc microblaze_0_axi_periph|m03_couplers_to_microblaze_0_axi_periph 1 3 1 N
preplace netloc microblaze_0_local_memory|microblaze_0_ilmb_cntlr 1 2 1 2270
preplace netloc axi_slave_wishbone_classic_master_0_WE_O 1 5 1 N
preplace netloc microblaze_0_debug 1 2 1 800
preplace netloc microblaze_0_axi_periph|M03_ACLK_1 1 0 3 NJ 732 NJ 732 N
preplace netloc microblaze_0_axi_periph|M04_ACLK_1 1 0 3 NJ 892 NJ 892 2340
preplace netloc microblaze_0_axi_dp 1 3 1 1320
preplace netloc ACK_I_1 1 0 5 NJ 200 NJ 190 NJ 60 NJ 60 3110
preplace netloc microblaze_0_axi_periph|xbar_to_m01_couplers 1 2 1 2390
preplace netloc axi_slave_wishbone_classic_master_0_CYC_O 1 5 1 N
preplace netloc Reset1_1 1 0 1 N
preplace netloc axi_uartlite_0_interrupt 1 0 6 110 220 NJ 170 NJ 40 NJ 40 NJ 40 4700
preplace netloc microblaze_0_axi_periph_M04_AXI 1 4 1 3120
preplace netloc microblaze_0_axi_periph|m03_couplers|S_ACLK_1 1 0 1 N
preplace netloc microblaze_0_local_memory|microblaze_0_LMB_Rst 1 0 2 1830 1310 2050
preplace netloc axi_slave_wishbone_classic_master_0_ADR_O 1 5 1 N
preplace netloc axi_slave_wishbone_classic_master_0_STB_O 1 5 1 N
preplace netloc microblaze_0_axi_periph|microblaze_0_axi_periph_ACLK_net 1 0 3 1760 342 2050 412 2380
preplace netloc microblaze_0_axi_periph|microblaze_0_axi_periph_to_s00_couplers 1 0 1 N
preplace netloc microblaze_0_axi_periph|M04_ARESETN_1 1 0 3 NJ 912 NJ 912 2320
preplace netloc axi_slave_wishbone_classic_master_0_RST_O 1 5 1 N
preplace netloc microblaze_0_axi_periph|M00_ACLK_1 1 0 3 NJ 212 NJ 212 N
preplace netloc microblaze_0_axi_periph|m02_couplers_to_microblaze_0_axi_periph 1 3 1 N
preplace netloc microblaze_0_axi_periph|microblaze_0_axi_periph_ARESETN_net 1 0 3 1780 352 2030 422 2330
levelinfo -pg 1 50 280 640 1040 1850 4534 4720 -top 0 -bot 1670
levelinfo -hier microblaze_0_local_memory * 1930 2160 2380 *
levelinfo -hier microblaze_0_axi_periph * 1910 2190 2640 *
levelinfo -hier microblaze_0_axi_periph|m03_couplers * 2720 *
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


