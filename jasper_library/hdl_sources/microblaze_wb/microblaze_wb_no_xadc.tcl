
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
set scripts_vivado_version 2016.4
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
   create_project project_1 myproj -part xc7k160tffg676-2
}


# CHANGE DESIGN NAME HERE
set design_name cont_microblaze

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
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

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

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

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
  set spi_rtl [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 spi_rtl ]

  # Create ports
  set ACK_I [ create_bd_port -dir I ACK_I ]
  set ADR_O [ create_bd_port -dir O -from 19 -to 0 ADR_O ]
  set CYC_O [ create_bd_port -dir O CYC_O ]
  set Clk [ create_bd_port -dir I -type clk Clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {100000000} \
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
  set dcm_locked [ create_bd_port -dir I dcm_locked ]
  set ext_intr [ create_bd_port -dir I -type intr ext_intr ]

  # Create instance: axi_hwicap_0, and set properties
  set axi_hwicap_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0 ]
  set_property -dict [ list \
CONFIG.C_ICAP_EXTERNAL {0} \
CONFIG.C_INCLUDE_STARTUP {0} \
 ] $axi_hwicap_0

  # Create instance: axi_quad_spi_0, and set properties
  set axi_quad_spi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0 ]
  set_property -dict [ list \
CONFIG.C_SCK_RATIO {2} \
CONFIG.C_NUM_SS_BITS {2} \
CONFIG.C_SHARED_STARTUP {0} \
CONFIG.C_SPI_MEMORY {2} \
CONFIG.C_SPI_MODE {2} \
CONFIG.C_TYPE_OF_AXI4_INTERFACE {0} \
CONFIG.C_USE_STARTUP {1} \
CONFIG.C_USE_STARTUP_INT {1} \
CONFIG.C_XIP_MODE {0} \
 ] $axi_quad_spi_0

  set_property -dict [list CONFIG.C_NUM_SS_BITS {1} CONFIG.C_USE_STARTUP {0} CONFIG.C_USE_STARTUP_INT {0}] [get_bd_cells axi_quad_spi_0]


  # Create instance: axi_slave_wishbone_classic_master_0, and set properties
  set axi_slave_wishbone_classic_master_0 [ create_bd_cell -type ip -vlnv peralex.com:user:axi_slave_wishbone_classic_master:1.0 axi_slave_wishbone_classic_master_0 ]

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
 ] $axi_uartlite_0

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
CONFIG.C_USE_UART {0} \
 ] $mdm_1

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:10.0 microblaze_0 ]
  set_property -dict [ list \
CONFIG.C_DEBUG_ENABLED {1} \
CONFIG.C_D_AXI {1} \
CONFIG.C_D_LMB {1} \
CONFIG.C_I_LMB {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
CONFIG.C_HAS_FAST {1} \
CONFIG.C_PROCESSOR_CLK_FREQ_MHZ {100} \
CONFIG.C_S_AXI_ACLK_FREQ_MHZ {100} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {8} \
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
CONFIG.NUM_PORTS {5} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_quad_spi_0_SPI_0 [get_bd_intf_ports spi_rtl] [get_bd_intf_pins axi_quad_spi_0/SPI_0]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports UART] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins axi_timebase_wdt_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins axi_slave_wishbone_classic_master_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins axi_quad_spi_0/AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M07_AXI [get_bd_intf_pins axi_hwicap_0/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]

  # Create port connections
  connect_bd_net -net ACK_I_1 [get_bd_ports ACK_I] [get_bd_pins axi_slave_wishbone_classic_master_0/ACK_I]
  connect_bd_net -net DAT_I_1 [get_bd_ports DAT_I] [get_bd_pins axi_slave_wishbone_classic_master_0/DAT_I]
  connect_bd_net -net Reset_1 [get_bd_ports Reset] [get_bd_pins rst_Clk_100M/ext_reset_in]
  connect_bd_net -net axi_hwicap_0_ip2intc_irpt [get_bd_pins axi_hwicap_0/ip2intc_irpt] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net axi_quad_spi_0_eos [get_bd_pins axi_hwicap_0/eos_in] [get_bd_pins axi_quad_spi_0/eos]
  connect_bd_net -net axi_quad_spi_0_ip2intc_irpt [get_bd_pins axi_quad_spi_0/ip2intc_irpt] [get_bd_pins xlconcat_0/In2]
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
  connect_bd_net -net dcm_locked_1 [get_bd_ports dcm_locked] [get_bd_pins rst_Clk_100M/dcm_locked]
  connect_bd_net -net ext_intr_1 [get_bd_ports ext_intr] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_Clk_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_ports Clk] [get_bd_pins axi_hwicap_0/icap_clk] [get_bd_pins axi_hwicap_0/s_axi_aclk] [get_bd_pins axi_quad_spi_0/ext_spi_clk] [get_bd_pins axi_quad_spi_0/s_axi_aclk] [get_bd_pins axi_slave_wishbone_classic_master_0/S_AXI_ACLK] [get_bd_pins axi_timebase_wdt_0/s_axi_aclk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_Clk_100M/slowest_sync_clk]
  connect_bd_net -net rst_Clk_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/LMB_Rst] [get_bd_pins rst_Clk_100M/bus_struct_reset]
  connect_bd_net -net rst_Clk_100M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_Clk_100M/interconnect_aresetn]
  connect_bd_net -net rst_Clk_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins rst_Clk_100M/mb_reset]
  connect_bd_net -net rst_Clk_100M_peripheral_aresetn [get_bd_pins axi_hwicap_0/s_axi_aresetn] [get_bd_pins axi_quad_spi_0/s_axi_aresetn] [get_bd_pins axi_slave_wishbone_classic_master_0/S_AXI_ARESETN] [get_bd_pins axi_timebase_wdt_0/s_axi_aresetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_Clk_100M/peripheral_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins xlconcat_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x40200000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_hwicap_0/S_AXI_LITE/Reg] SEG_axi_hwicap_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00100000 -offset 0x44A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_slave_wishbone_classic_master_0/S_AXI/reg0] SEG_axi_slave_wishbone_classic_master_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x41A00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timebase_wdt_0/S_AXI/Reg] SEG_axi_timebase_wdt_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] SEG_axi_timer_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00020000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] SEG_microblaze_0_axi_intc_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port ext_intr -pg 1 -y 1020 -defaultsOSRD
preplace port RST_O -pg 1 -y 1020 -defaultsOSRD
preplace port UART -pg 1 -y 610 -defaultsOSRD
preplace port Clk -pg 1 -y 480 -defaultsOSRD
preplace port WE_O -pg 1 -y 1140 -defaultsOSRD
preplace port STB_O -pg 1 -y 1120 -defaultsOSRD
preplace port CYC_O -pg 1 -y 1080 -defaultsOSRD
preplace port dcm_locked -pg 1 -y 560 -defaultsOSRD
preplace port Reset -pg 1 -y 500 -defaultsOSRD
preplace port ACK_I -pg 1 -y 1090 -defaultsOSRD
preplace port spi_rtl -pg 1 -y 890 -defaultsOSRD
preplace portBus DAT_O -pg 1 -y 1040 -defaultsOSRD
preplace portBus ADR_O -pg 1 -y 1060 -defaultsOSRD
preplace portBus SEL_O -pg 1 -y 1100 -defaultsOSRD
preplace portBus DAT_I -pg 1 -y 1060 -defaultsOSRD
preplace inst axi_timebase_wdt_0 -pg 1 -lvl 4 -y 140 -defaultsOSRD
preplace inst microblaze_0_axi_periph -pg 1 -lvl 3 -y 160 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 5 -y 690 -defaultsOSRD
preplace inst axi_timer_0 -pg 1 -lvl 4 -y 330 -defaultsOSRD
preplace inst microblaze_0_axi_intc -pg 1 -lvl 1 -y 720 -defaultsOSRD
preplace inst mdm_1 -pg 1 -lvl 1 -y 481 -defaultsOSRD
preplace inst rst_Clk_100M -pg 1 -lvl 5 -y 500 -defaultsOSRD
preplace inst microblaze_0 -pg 1 -lvl 2 -y 480 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 4 -y 530 -defaultsOSRD
preplace inst axi_hwicap_0 -pg 1 -lvl 1 -y 940 -defaultsOSRD
preplace inst microblaze_0_local_memory -pg 1 -lvl 3 -y 530 -defaultsOSRD
preplace inst axi_slave_wishbone_classic_master_0 -pg 1 -lvl 4 -y 1140 -defaultsOSRD
preplace inst axi_quad_spi_0 -pg 1 -lvl 4 -y 940 -defaultsOSRD
preplace netloc axi_quad_spi_0_SPI_0 1 4 2 NJ 910 2400J
preplace netloc axi_slave_wishbone_classic_master_0_WE_O 1 4 2 N 1200 2450J
preplace netloc microblaze_0_axi_periph_M04_AXI 1 3 1 1560
preplace netloc rst_Clk_100M_mb_reset 1 0 6 70 560 440 560 970J 420 1600J 440 1960J 390 2400
preplace netloc axi_uartlite_0_interrupt 1 4 1 1960
preplace netloc axi_slave_wishbone_classic_master_0_SEL_O 1 4 2 N 1160 2430J
preplace netloc microblaze_0_Clk 1 0 5 30 -100 440 -100 940 -100 1610 -100 2020J
preplace netloc microblaze_0_interrupt 1 1 1 420
preplace netloc microblaze_0_intc_axi 1 0 4 60J -130 NJ -130 NJ -130 1560
preplace netloc microblaze_0_axi_periph_M03_AXI 1 3 1 1590
preplace netloc dcm_locked_1 1 0 5 10J 610 NJ 610 NJ 610 NJ 610 2010J
preplace netloc microblaze_0_ilmb_1 1 2 1 930
preplace netloc microblaze_0_axi_periph_M05_AXI 1 3 1 1580
preplace netloc microblaze_0_axi_dp 1 2 1 950
preplace netloc axi_slave_wishbone_classic_master_0_DAT_O 1 4 2 N 1100 2400J
preplace netloc xlconcat_0_dout 1 0 6 80J 820 NJ 820 NJ 820 NJ 820 NJ 820 2390
preplace netloc microblaze_0_axi_periph_M01_AXI 1 3 1 1630
preplace netloc axi_slave_wishbone_classic_master_0_CYC_O 1 4 2 N 1140 2420J
preplace netloc axi_slave_wishbone_classic_master_0_ADR_O 1 4 2 N 1120 2410J
preplace netloc axi_quad_spi_0_eos 1 0 5 80 1030 NJ 1030 NJ 1030 NJ 1030 1950
preplace netloc axi_uartlite_0_UART 1 4 2 1990 600 2400J
preplace netloc axi_timebase_wdt_0_wdt_reset 1 4 1 2010
preplace netloc microblaze_0_dlmb_1 1 2 1 960
preplace netloc microblaze_0_axi_periph_M07_AXI 1 0 4 40 -150 NJ -150 NJ -150 1570
preplace netloc microblaze_0_axi_periph_M02_AXI 1 3 1 1640
preplace netloc axi_slave_wishbone_classic_master_0_STB_O 1 4 2 N 1180 2440J
preplace netloc microblaze_0_debug 1 1 1 430
preplace netloc axi_hwicap_0_ip2intc_irpt 1 1 4 430 710 NJ 710 NJ 710 NJ
preplace netloc rst_Clk_100M_peripheral_aresetn 1 0 6 50J -120 NJ -120 970 -120 1620 -120 NJ -120 2420
preplace netloc rst_Clk_100M_interconnect_aresetn 1 2 4 980J 430 NJ 430 1950J 380 2410
preplace netloc rst_Clk_100M_bus_struct_reset 1 2 4 980J 440 1560J 450 1970J 410 2390
preplace netloc mdm_1_debug_sys_rst 1 1 4 430 630 NJ 630 NJ 630 2020J
preplace netloc axi_quad_spi_0_ip2intc_irpt 1 4 1 1980
preplace netloc Reset_1 1 0 5 20J 620 NJ 620 NJ 620 NJ 620 2000J
preplace netloc ACK_I_1 1 0 4 20J 1140 NJ 1140 NJ 1140 NJ
preplace netloc ext_intr_1 1 0 5 10J 830 NJ 830 NJ 830 NJ 830 2010
preplace netloc axi_timer_0_interrupt 1 4 1 1980
preplace netloc axi_slave_wishbone_classic_master_0_RST_O 1 4 2 N 1080 2390J
preplace netloc DAT_I_1 1 0 4 60J 1120 NJ 1120 NJ 1120 NJ
levelinfo -pg 1 -10 310 700 1420 1810 2220 2470 -top -160 -bot 1510
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


