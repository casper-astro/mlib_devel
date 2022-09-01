
################################################################
# This is a generated script based on design: adc4x16g_core
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
# source adc4x16g_core_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu37p-fsvh2892-2L-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name adc4x16g_core

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
xilinx.com:user:adc4x16g_core:1.3\
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

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
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

  # Create ports
  set XOR_ON [ create_bd_port -dir I XOR_ON ]
  set adc_clk [ create_bd_port -dir O -type clk adc_clk ]
  set bit_sel [ create_bd_port -dir I -from 1 -to 0 bit_sel ]
  set clk100 [ create_bd_port -dir I clk100 ]
  set clk_freerun [ create_bd_port -dir I clk_freerun ]
  set data_out [ create_bd_port -dir O -from 255 -to 0 data_out ]
  set drp_addr [ create_bd_port -dir I -from 9 -to 0 drp_addr ]
  set drp_data [ create_bd_port -dir O -from 15 -to 0 drp_data ]
  set drp_read [ create_bd_port -dir I drp_read ]
  set drp_reset [ create_bd_port -dir I -type rst drp_reset ]
  set fifo_empty [ create_bd_port -dir O fifo_empty ]
  set fifo_full [ create_bd_port -dir O fifo_full ]
  set fifo_read [ create_bd_port -dir I fifo_read ]
  set fifo_reset [ create_bd_port -dir I -type rst fifo_reset ]
  set gtwiz_reset_all_in [ create_bd_port -dir I gtwiz_reset_all_in ]
  set gty0rxn_in [ create_bd_port -dir I -from 3 -to 0 gty0rxn_in ]
  set gty0rxp_in [ create_bd_port -dir I -from 3 -to 0 gty0rxp_in ]
  set match_pattern [ create_bd_port -dir I -from 31 -to 0 match_pattern ]
  set pattern_match_enable [ create_bd_port -dir I pattern_match_enable ]
  set prbs_error_count_reset [ create_bd_port -dir I -type rst prbs_error_count_reset ]
  set refclk0_n [ create_bd_port -dir I refclk0_n ]
  set refclk0_p [ create_bd_port -dir I refclk0_p ]
  set rxcdrhold [ create_bd_port -dir I rxcdrhold ]
  set rxprbserr_out [ create_bd_port -dir O -from 3 -to 0 rxprbserr_out ]
  set rxprbslocked [ create_bd_port -dir O rxprbslocked ]
  set rxslide [ create_bd_port -dir I rxslide ]
  set write_interval [ create_bd_port -dir I -from 7 -to 0 write_interval ]

  # Create instance: adc4x16g_core_0, and set properties
  set adc4x16g_core_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:adc4x16g_core:1.3 adc4x16g_core_0 ]

  # Create port connections
  connect_bd_net -net XOR_ON_0_1 [get_bd_ports XOR_ON] [get_bd_pins adc4x16g_core_0/XOR_ON]
  connect_bd_net -net adc4x16g_core_0_adc_clk [get_bd_ports adc_clk] [get_bd_pins adc4x16g_core_0/adc_clk]
  connect_bd_net -net adc4x16g_core_0_data_out [get_bd_ports data_out] [get_bd_pins adc4x16g_core_0/data_out]
  connect_bd_net -net adc4x16g_core_0_drp_data [get_bd_ports drp_data] [get_bd_pins adc4x16g_core_0/drp_data]
  connect_bd_net -net adc4x16g_core_0_fifo_empty [get_bd_ports fifo_empty] [get_bd_pins adc4x16g_core_0/fifo_empty]
  connect_bd_net -net adc4x16g_core_0_fifo_full [get_bd_ports fifo_full] [get_bd_pins adc4x16g_core_0/fifo_full]
  connect_bd_net -net adc4x16g_core_0_rxprbserr_out [get_bd_ports rxprbserr_out] [get_bd_pins adc4x16g_core_0/rxprbserr_out]
  connect_bd_net -net adc4x16g_core_0_rxprbslocked [get_bd_ports rxprbslocked] [get_bd_pins adc4x16g_core_0/rxprbslocked]
  connect_bd_net -net bit_sel_0_1 [get_bd_ports bit_sel] [get_bd_pins adc4x16g_core_0/bit_sel]
  connect_bd_net -net clk100_0_1 [get_bd_ports clk100] [get_bd_pins adc4x16g_core_0/clk100]
  connect_bd_net -net clk_freerun_0_1 [get_bd_ports clk_freerun] [get_bd_pins adc4x16g_core_0/clk_freerun]
  connect_bd_net -net drp_addr_0_1 [get_bd_ports drp_addr] [get_bd_pins adc4x16g_core_0/drp_addr]
  connect_bd_net -net drp_read_0_1 [get_bd_ports drp_read] [get_bd_pins adc4x16g_core_0/drp_read]
  connect_bd_net -net drp_reset_0_1 [get_bd_ports drp_reset] [get_bd_pins adc4x16g_core_0/drp_reset]
  connect_bd_net -net fifo_read_0_1 [get_bd_ports fifo_read] [get_bd_pins adc4x16g_core_0/fifo_read]
  connect_bd_net -net fifo_reset_0_1 [get_bd_ports fifo_reset] [get_bd_pins adc4x16g_core_0/fifo_reset]
  connect_bd_net -net gtwiz_reset_all_in_0_1 [get_bd_ports gtwiz_reset_all_in] [get_bd_pins adc4x16g_core_0/gtwiz_reset_all_in]
  connect_bd_net -net gty0rxn_in_0_1 [get_bd_ports gty0rxn_in] [get_bd_pins adc4x16g_core_0/gty0rxn_in]
  connect_bd_net -net gty0rxp_in_0_1 [get_bd_ports gty0rxp_in] [get_bd_pins adc4x16g_core_0/gty0rxp_in]
  connect_bd_net -net match_pattern_0_1 [get_bd_ports match_pattern] [get_bd_pins adc4x16g_core_0/match_pattern]
  connect_bd_net -net pattern_match_enable_0_1 [get_bd_ports pattern_match_enable] [get_bd_pins adc4x16g_core_0/pattern_match_enable]
  connect_bd_net -net prbs_error_count_reset_0_1 [get_bd_ports prbs_error_count_reset] [get_bd_pins adc4x16g_core_0/prbs_error_count_reset]
  connect_bd_net -net refclk0_n_0_1 [get_bd_ports refclk0_n] [get_bd_pins adc4x16g_core_0/refclk0_n]
  connect_bd_net -net refclk0_p_0_1 [get_bd_ports refclk0_p] [get_bd_pins adc4x16g_core_0/refclk0_p]
  connect_bd_net -net rxcdrhold_0_1 [get_bd_ports rxcdrhold] [get_bd_pins adc4x16g_core_0/rxcdrhold]
  connect_bd_net -net rxslide_0_1 [get_bd_ports rxslide] [get_bd_pins adc4x16g_core_0/rxslide]
  connect_bd_net -net write_interval_0_1 [get_bd_ports write_interval] [get_bd_pins adc4x16g_core_0/write_interval]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_gid_msg -ssname BD::TCL -id 2053 -severity "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

