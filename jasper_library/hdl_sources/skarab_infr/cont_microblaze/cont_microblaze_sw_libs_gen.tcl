#*****************************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# cont_microblaze_sw_libs_gen.tcl: Tcl script for creating the microblaze software libraries (microblaze BSP),
#                                  so that the skarab_microblaze_software repo can be linked to these libraries
#                                  in order to generate the elf file.
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

#Set path where the SDK drivers, BSP and libraries are stored - normally <install_path>/Xilinx/SDK/2019.1/data/embeddedsw
set sdk_lib_path "/opt/Xilinx/SDK/2019.1/data/embeddedsw"

#Set path to where mb-ar executable is in order to generate software BSP
set ::env(PATH) "$::env(PATH):/opt/Xilinx/SDK/2019.1/gnu/microblaze/lin/bin"

#Software design name
set swdesign "microblaze_sw"

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
set script_file "cont_microblaze_sw_libs_gen.tcl"

#Set and make the output directory where all the generated files and reports will be stored
set outputDir $origin_dir/../../../test_models/project_flow/${_xil_proj_name_}

#Need to load the hardware software interface (hsi) feature in Vivado to get access to all the hsi commands
load_features hsi

#Open the existing hdf (hardware design file) file for SDK
#hsi::open_hw_design $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/cont_microblaze_wrapper.hdf

#Close existing hardware design
#hsi::close_hw_design $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/cont_microblaze_wrapper.hdf

#Set the repo path to the drivers, BSP and libraries in order to generate the software design
hsi::set_repo_path $sdk_lib_path

#Open the existing hdf (hardware design file) file for SDK
hsi::open_hw_design $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/cont_microblaze_wrapper.hdf

#Determine the name of the processor design (should be microblaze_0 in this case)
set proc_name [hsi::get_cells -filter {IP_TYPE==PROCESSOR}]

#create a software design
hsi::create_sw_design $swdesign -proc $proc_name -os standalone

#generate the microblaze software libraries (BSP) in order to link to for elf file generation
hsi::generate_bsp -dir $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/microblaze_bsp

#create hello world application with base linker script
hsi::generate_app -app hello_world -proc $proc_name -os standalone -dir $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/microblaze_app

#close software design
hsi::close_sw_design $swdesign

#Close existing hardware design
#hsi::close_hw_design $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/cont_microblaze_wrapper.hdf

#run microblaze software library (BSP) makefile
exec make -C $origin_dir/../../../test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/microblaze_bsp
