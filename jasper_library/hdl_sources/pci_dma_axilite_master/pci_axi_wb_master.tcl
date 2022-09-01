
################################################################
# This is a generated script based on design: pci_axi_wb_master
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
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "WARNING" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   #return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source pci_axi_wb_master_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu37p-fsvh2892-2-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name pci_axi_wb_master

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

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
peralex.com:user:axi_slave_wishbone_classic_master:1.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:xdma:4.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



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
  set m_axil [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axil ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {62500000} \
   CONFIG.PROTOCOL {AXI4LITE} \
   ] $m_axil


  # Create ports
  set ACK_I [ create_bd_port -dir I ACK_I ]
  set ADR_O [ create_bd_port -dir O -from 19 -to 0 ADR_O ]
  set CYC_O [ create_bd_port -dir O CYC_O ]
  set DAT_I [ create_bd_port -dir I -from 31 -to 0 DAT_I ]
  set DAT_O [ create_bd_port -dir O -from 31 -to 0 DAT_O ]
  set RST_O [ create_bd_port -dir O RST_O ]
  set SEL_O [ create_bd_port -dir O -from 3 -to 0 SEL_O ]
  set STB_O [ create_bd_port -dir O STB_O ]
  set WE_O [ create_bd_port -dir O WE_O ]
  set axi_aclk [ create_bd_port -dir O -type clk axi_aclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {m_axil} \
   CONFIG.FREQ_HZ {62500000} \
 ] $axi_aclk
  set axi_aresetn [ create_bd_port -dir O -type rst axi_aresetn ]
  set pci_exp_rxn [ create_bd_port -dir I -from 0 -to 0 pci_exp_rxn ]
  set pci_exp_rxp [ create_bd_port -dir I -from 0 -to 0 pci_exp_rxp ]
  set pci_exp_txn [ create_bd_port -dir O -from 0 -to 0 pci_exp_txn ]
  set pci_exp_txp [ create_bd_port -dir O -from 0 -to 0 pci_exp_txp ]
  set sys_clk [ create_bd_port -dir I -type clk sys_clk ]
  set sys_clk_gt [ create_bd_port -dir I -type clk sys_clk_gt ]
  set sys_rst_n [ create_bd_port -dir I -type rst sys_rst_n ]
  set usr_irq_req [ create_bd_port -dir I -from 0 -to 0 usr_irq_req ]

  # Create instance: axi_slave_wishbone_c_0, and set properties
  set axi_slave_wishbone_c_0 [ create_bd_cell -type ip -vlnv peralex.com:user:axi_slave_wishbone_classic_master:1.0 axi_slave_wishbone_c_0 ]

  # Create instance: axi_smc, and set properties
  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $axi_smc

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0 ]
  set_property -dict [ list \
   CONFIG.axi_addr_width {64} \
   CONFIG.axilite_master_en {true} \
   CONFIG.axilite_master_size {8} \
   CONFIG.axist_bypass_en {false} \
   CONFIG.axisten_freq {62.5} \
   CONFIG.cfg_mgmt_if {false} \
   CONFIG.en_gt_selection {false} \
   CONFIG.enable_pcie_debug {False} \
   CONFIG.functional_mode {DMA} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pcie_blk_locn {PCIE4C_X1Y0} \
   CONFIG.pcie_extended_tag {false} \
   CONFIG.pciebar2axibar_axil_master {0x44A00000} \
   CONFIG.pciebar2axibar_axist_bypass {0x0000000000000000} \
   CONFIG.pf0_msi_enabled {false} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_1} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1} \
   CONFIG.select_quad {GTY_Quad_227} \
   CONFIG.xdma_axi_intf_mm {AXI_Stream} \
   CONFIG.xdma_axilite_slave {false} \
 ] $xdma_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins axi_slave_wishbone_c_0/S_AXI] [get_bd_intf_pins axi_smc/M00_AXI]
  connect_bd_intf_net -intf_net axi_smc_M01_AXI [get_bd_intf_ports m_axil] [get_bd_intf_pins axi_smc/M01_AXI]
  connect_bd_intf_net -intf_net xdma_0_M_AXIS_H2C_0 [get_bd_intf_pins xdma_0/M_AXIS_H2C_0] [get_bd_intf_pins xdma_0/S_AXIS_C2H_0]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_LITE [get_bd_intf_pins axi_smc/S00_AXI] [get_bd_intf_pins xdma_0/M_AXI_LITE]

  # Create port connections
  connect_bd_net -net ACK_I_0_1 [get_bd_ports ACK_I] [get_bd_pins axi_slave_wishbone_c_0/ACK_I]
  connect_bd_net -net DAT_I_0_1 [get_bd_ports DAT_I] [get_bd_pins axi_slave_wishbone_c_0/DAT_I]
  connect_bd_net -net axi_slave_wishbone_c_0_ADR_O [get_bd_ports ADR_O] [get_bd_pins axi_slave_wishbone_c_0/ADR_O]
  connect_bd_net -net axi_slave_wishbone_c_0_CYC_O [get_bd_ports CYC_O] [get_bd_pins axi_slave_wishbone_c_0/CYC_O]
  connect_bd_net -net axi_slave_wishbone_c_0_DAT_O [get_bd_ports DAT_O] [get_bd_pins axi_slave_wishbone_c_0/DAT_O]
  connect_bd_net -net axi_slave_wishbone_c_0_RST_O [get_bd_ports RST_O] [get_bd_pins axi_slave_wishbone_c_0/RST_O]
  connect_bd_net -net axi_slave_wishbone_c_0_SEL_O [get_bd_ports SEL_O] [get_bd_pins axi_slave_wishbone_c_0/SEL_O]
  connect_bd_net -net axi_slave_wishbone_c_0_STB_O [get_bd_ports STB_O] [get_bd_pins axi_slave_wishbone_c_0/STB_O]
  connect_bd_net -net axi_slave_wishbone_c_0_WE_O [get_bd_ports WE_O] [get_bd_pins axi_slave_wishbone_c_0/WE_O]
  connect_bd_net -net pci_exp_rxn_0_1 [get_bd_ports pci_exp_rxn] [get_bd_pins xdma_0/pci_exp_rxn]
  connect_bd_net -net pci_exp_rxp_0_1 [get_bd_ports pci_exp_rxp] [get_bd_pins xdma_0/pci_exp_rxp]
  connect_bd_net -net sys_clk_0_1 [get_bd_ports sys_clk] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net sys_clk_gt_0_1 [get_bd_ports sys_clk_gt] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net sys_rst_n_0_1 [get_bd_ports sys_rst_n] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net usr_irq_req_0_1 [get_bd_ports usr_irq_req] [get_bd_pins xdma_0/usr_irq_req]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_ports axi_aclk] [get_bd_pins axi_slave_wishbone_c_0/S_AXI_ACLK] [get_bd_pins axi_smc/aclk] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_ports axi_aresetn] [get_bd_pins axi_slave_wishbone_c_0/S_AXI_ARESETN] [get_bd_pins axi_smc/aresetn] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net xdma_0_pci_exp_txn [get_bd_ports pci_exp_txn] [get_bd_pins xdma_0/pci_exp_txn]
  connect_bd_net -net xdma_0_pci_exp_txp [get_bd_ports pci_exp_txp] [get_bd_pins xdma_0/pci_exp_txp]

  # Create address segments
  create_bd_addr_seg -range 0x00100000 -offset 0x44A00000 [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_slave_wishbone_c_0/S_AXI/reg0] SEG_axi_slave_wishbone_c_0_reg0
  create_bd_addr_seg -range 0x00100000 -offset 0x44B00000 [get_bd_addr_spaces xdma_0/M_AXI_LITE] [get_bd_addr_segs m_axil/Reg] SEG_m_axil_Reg


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


