CASPER Toolflow
=================

Getting Started
----------------
What is mlib_devel?
^^^^^^^^^^^^^^^^^^^^

``mlib_devel`` is a set of DSP libraries and tools maintained by the `Collaboration for Astronomical Signal Processing and Electronics Research (CASPER) <http://casper-dsp.org/>`__. Within the collaboration, it is affectionately referred to as *The Toolflow.*

``mlib_devel`` allows you to generate firmware designs which can run on supported Xilinx FPGA hardware platforms. It uses Xilinx ISE/Vivado to perform compiles of designs into FPGA bitcode, and MATLAB Simulink and Xilinx System Generator as a frontend to provide a graphical interface which makes it easy to design DSP pipelines. ``mlib_devel`` contains a suite of libraries providing common functionality needed by DSP systems used in radio astronomy -- for example: flexible FFTs, FIR filters, correlator modules, etc. Crucially, it also contains blocks providing high-level interfaces to board-level resources, such as memories, high-speed (Ethernet) IO, Analog-to-digital Converters (ADCs), and Digital-to-Analog Converters (DACs). ``mlib_devel`` is designed to be used with `casperfpga <https://github.com/casper-astro/casperfpga>`__, a software suite which makes it easy to interact with firmware while it is running on an FPGA.

The tools create an ISE/Vivado project which is compiled using a generated TCL script. The output bitstream contains more than just the bitstream and includes major design configuration and a memory map of the devices in the design accessible from software. 

JASPER mlib_devel directory structure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **jasper_library/hdl_sources**: HDL source files for all user IP (Ethernet cores, ADC interfaces, etc.)

- **jasper_library/yellow_blocks**: python classes for each yellow block in the simulink xps blockset. These classes contain the python code which tells the tool flow how each yellow block should modify the project's top-level HDL source file and vivado project.

- **jasper_library/platforms**: a yaml file specifying information about a specific hardware platform. Mostly this is used to  map pythonic constraints - i.e., "connect signal my_led to the board's led[4] pin" - to hardware  constraints - i.e. " my_led -> LOC XXX, my_led -> IOSTD XXX". This file also includes source files the platform requires to compile. The source files in jasper_library/hdl_sources/<platform_name>/ are automatically included. jasper_library/hdl_sources/<platform_name>/top.v is used as a starting point for HDL generation.

There's a few matlab scripts in **jasper_library** which turn a simulink diagram into source/configuration files that the rest of the tool flow can understand.

Then there's the entire **mlib_devel/casper_library**, which is all the matlab/simulink files for the casper DSP (Digital Signal Processing) libraries.

Everything in **mlib_devel/xps_base** is obsolete. It contains the pcores, which the old casper tool set utilises. Jasper does not make use of this though.

Then there is the entire **mlib_devel/xps_library**, which contains all the matlab/simulink yellow block files for the casper XPS (Xilinx Platform Studio) libraries.

Setup
------

Depending on the hardware you are designing for you will require a different combination of the tools. The older hardware (ROACHes) use the older Xilinx software (ISE) which forces the use of different tools.

The recommended OS is Ubuntu as it is what the majority of the collaboration are using. This makes it easier for us to support you. If you are so inclined, you could also use Red Hat, but we definitely do not support Windows. You are welcome to try but you will be on your own. You could always run Linux in a VM although this will increase your compile times.

+-------------+--------------------+----------------+---------------+-------------------------------------------------------------------------+
| Platform    | OS                 | Matlab Version | Xilinx Tools  | mlib_devel                                                              |
+=============+====================+================+===============+=========================================================================+
| ROACH1 or 2 | Ubuntu 12.04/14.04 | R2013b         | ISE 14.7      | `ROACH HEAD <https://github.com/casper-astro/mlib_devel/tree/roach2>`__ |
+-------------+--------------------+----------------+---------------+-------------------------------------------------------------------------+
| SNAP        | Ubuntu 14.04/16.04 | R2016b         | Vivado 2016.4 | `Master HEAD <https://github.com/casper-astro/mlib_devel>`__            |
+-------------+--------------------+----------------+---------------+-------------------------------------------------------------------------+
| SKARAB      | Ubuntu 14.04/16.04 | R2016b         | Vivado 2016.2 | `Master HEAD <https://github.com/casper-astro/mlib_devel>`__            |
+-------------+--------------------+----------------+---------------+-------------------------------------------------------------------------+

1. :doc:`Setting up the Toolflow <src/Setting-up-the-Toolflow>`
2. :doc:`Installing Matlab <src/How-to-install-Matlab>`
3. :doc:`Installing Xilinx Vivado <src/How-to-install-Xilinx-Vivado>` or :doc:`Installing Xilinx ISE (ROACH only) <src/How-to-install-Xilinx-ISE>`
4. :doc:`Configuring the Toolflow <src/Configuring-the-Toolflow>`
5. :doc:`Running the Toolflow <src/Running-the-Toolflow>`

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Setup

    src/Setting-up-the-Toolflow
    src/How-to-install-Matlab
    src/How-to-install-Xilinx-Vivado
    src/How-to-install-Xilinx-ISE
    src/Configuring-the-Toolflow
    src/Running-the-Toolflow

Documentation
---------------

* `CASPER Tutorials <http://casper-tutorials.readthedocs.io/en/latest/>`__
* :doc:`Block Documentation <blockdocumentation>`
* :doc:`JASPER Toolflow <src/jasper_library_modules/modules>`

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Documentation

    CASPER Tutorials <http://casper-tutorials.readthedocs.io/en/latest/>
    blockdocumentation
    src/jasper_library_modules/modules