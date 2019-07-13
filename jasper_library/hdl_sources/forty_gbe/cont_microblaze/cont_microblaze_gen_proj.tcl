#*****************************************************************************************
# Vivado (TM) v2018.2 (64-bit)
#
# cont_microblaze_gen_proj.tcl: Tcl script for re-creating project with only the microblaze,
#                               so that changes can be made to the SOC and IP can be
#                               regenerated.  
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Set the project name
set _xil_proj_name_ "skarabublazeproj"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "cont_microblaze_gen_proj.tcl"

#Set and make the output directory where all the generated files and reports will be stored
set outputDir $origin_dir/../../../test_models/project_flow/${_xil_proj_name_}
file mkdir $outputDir

#create project
create_project ${_xil_proj_name_} $outputDir -part xc7vx690tffg1927-2 -force

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]


# Set project properties
set obj [current_project]
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $obj

#point to project top level file and wrapper
add_files cont_microblaze.bd
add_files hdl/cont_microblaze_wrapper.vhd

update_compile_order -fileset sources_1

#add IP to IP_REPO path to unlock the microblaze for editing and updates
set_property ip_repo_paths $origin_dir/ipshared/peralex.com [current_project]
update_ip_catalog

#Generate hdf (hardware design file) file for SDK
file mkdir $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk
write_hwdef -force  -file $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/cont_microblaze_wrapper.hdf


