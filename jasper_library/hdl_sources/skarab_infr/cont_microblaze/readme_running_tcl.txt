How to generate a standalone microblaze for development
-------------------------------------------------------

Author: A. Isaacson

The following tcl scripts are utilised in this process

1) cont_microblaze_gen_proj.tcl - Tcl script for re-creating project with only the microblaze, so that changes can be made to the SOC and IP can be regenerated. This script creates a standalone microblaze in a vivado project. It creates the sdk folder and the hardware design file used by the software.
2) cont_microblaze_sw_libs_gen.tcl - Tcl script for creating the microblaze software libraries (microblaze BSP), so that the skarab_microblaze_software repo can be linked to these libraries in order to generate the elf file.

The following steps should be followed:

1) Open Vivado 2019.1 GUI
2) In Tcl Console, change directory until Vivado is in the directory path of the above tcl scripts. NB: Very important, otherwise the Vivado project will not generate correctly.
3) Click on "Tools" and "Run Tcl Script..."
4) Browse to directory where the tcl scripts are and run "cont_microblaze_gen_proj.tcl"
5) The "skarabublazeproj" folder should be created with a standalone microblaze. This is created under "jasper_library/test_models/project_flow/skarabublazeproj". Right click on the cont_microblaze block design and there should be a non-grayed out option to "Generate Output Products..." and "Reset Output Products...". This
   means the microblaze can be edited and regenerated. Feel free to edit the microblaze, make your changes and regenerate the products. 
6) Browse to directory where the tcl scripts are and edit "cont_microblaze_sw_libs_gen.tcl". Change "sdk_lib_path" and "set ::env(PATH)" to your install path directory. The "sdk_lib_path" variable should be set as follows: "<install path>/Xilinx/SDK/2019.1/data/embeddedsw"
   and the "set ::env(PATH)" should be set as follows: "$::env(PATH):/<install path>/Xilinx/SDK/2019.1/gnu/microblaze/lin/bin"
7) Click on "Tools" and "Run Tcl Script..."
8) Browse to directory where the tcl scripts are and run "cont_microblaze_sw_libs_gen.tcl".
9) There will be compile warnings, which is normal - you should see "Finished building libraries" if you scroll up a bit in the Vivado Tcl Console window.
10) Before compiling the software programmable elf file: Remember to point the path to the BSP microblaze libraries and the microblaze headers in Makefile.inc file (located in the skarab_microblaze_software repo) to: 
    LIBDIR="<user git path>/mlib_devel/jasper_library/test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/microblaze_bsp/microblaze_0/lib" and
    INCDIR="<user git path>/mlib_devel/jasper_library/test_models/project_flow/skarabublazeproj/skarabublazeproj.sdk/microblaze_bsp/microblaze_0/include"