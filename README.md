# Getting Started
## What is mlib_devel?

`mlib_devel` is a set of DSP libraries and tools maintained by the [Collaboration for Astronomical Signal Processing and Electronics Research (CASPER)](https://casper.berkeley.edu). Within the collaboration, it is affectionately referred to as _The Toolflow._

`mlib_devel` allows you to generate firmware designs which can run on supported Xilinx FPGA hardware platforms. It uses Xilinx ISE/Vivado to perform compiles of designs into FPGA bitcode, and MATLAB Simulink and Xilinx System Generator as a frontend to provide a graphical interface which makes it easy to design DSP pipelines. `mlib_devel` contains a suite of libraries providing common functionality needed by DSP systems used in radio astronomy -- for example: flexible FFTs, FIR filters, correlator modules, etc. Crucially, it also contains blocks providing high-level interfaces to board-level resources, such as memories, high-speed (Ethernet) IO, Analog-to-digital Converters (ADCs), and Digital-to-Analog Converters (DACs). `mlib_devel` is designed to be used with [casperfpga](https://github.com/casper-astro/casperfpga), a software suite which makes it easy to interact with firmware while it is running on an FPGA.


The tools create an ISE/Vivado project which is compiled using a generated TCL script. The output bitstream contains more than just the bitstream and includes major design configuration and a memory map of the devices in the design accessible from software. 

## JASPER mlib_devel directory structure

-**jasper_library/hdl_sources**: HDL source files for all user IP (Ethernet cores, ADC interfaces, etc.)

-**jasper_library/yellow_blocks**: python classes for each yellow block in the simulink xps blockset. These classes contain the python code which tells the tool flow how each yellow block should modify the project's top-level HDL source file and vivado project.

-**jasper_library/platforms**: a yaml file specifying information about a specific hardware platform. Mostly this is used to  map pythonic constraints - i.e., "connect signal my_led to the board's led[4] pin" - to hardware  constraints - i.e. " my_led -> LOC XXX, my_led -> IOSTD XXX". This file also includes source files the platform requires to compile. The source files in jasper_library/hdl_sources/<platform_name>/ are automatically included. jasper_library/hdl_sources/<platform_name>/top.v is used as a starting point for HDL generation.

There's a few matlab scripts in **jasper_library** which turn a simulink diagram into source/configuration files that the rest of the tool flow can understand.

Then there's the entire **mlib_devel/casper_library**, which is all the matlab/simulink files for the casper DSP (Digital Signal Processing) libraries.

Everything in **mlib_devel/xps_base** is obsolete. It contains the pcores, which the old casper tool set utilises. Jasper does not make use of this though.

Then there is the entire **mlib_devel/xps_library**, which contains all the matlab/simulink yellow block files for the casper XPS (Xilinx Platform Studio) libraries.