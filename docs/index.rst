CASPER Toolflow
=================

Welcome to the documentation for ``mlib_devel``, the CASPER Toolflow!

What is mlib_devel?
^^^^^^^^^^^^^^^^^^^

The ``mlib_devel`` repository contains a set of FPGA DSP libraries and programming tools developed and maintained by the  `Collaboration for Astronomical Signal Processing and Electronics Research (CASPER) <http://casper.berkeley.edu/>`__. Within the collaboration, this collection of software is affectionately referred to as *The Toolflow*.

The CASPER toolflow allows you to generate signal processing designs using MATLAB's graphical programming tool ``Simulink``. These designs can be turned into FPGA bitstreams and loaded onto a variety of supported hardware platforms to perform real-time digital signal processing systems. CASPER also provides a Python software library for interacting with running designs:  `casperfpga <https://github.com/casper-astro/casperfpga>`__.


`mlib_devel` directory structure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
`casper_library`
  Simulink DSP libraries
  
`xps_library`
  Simulink libraries for tool-flow supported modules (ADC interfaces, Ethernet cores, etc.)
  
`xps_base`
  HDL code and Xilinx EDK wrappers used in older (ROACH2 and earlier) versions of the toolflow.
  
`docs`
  `Sphinx documentation <https://casper-toolflow.readthedocs.io>`__ for the software in this project.
`jasper_library`
  Python and MATLAB scripts required to drive the compilation process. Also platform-dependent configuration information and source-code for IP modules used by the toolflow in the following directories.
  
  `platforms`
    YAML files defining the compile parameters and physical constraints of CASPER-supported FPGA platforms.
  `golden`
    Golden boot images for FPGA platforms which require them.
  `hdl_sources`
    HDL source files for all toolflow-suppled modules (eg. ADC interfaces, Ethernet cores, etc.).
  `sw`
    Codebase for embedded software processors used by the toolflow
  `yellow_blocks`
    Python classes for each yellow block in the simulink `xps_library`.

Setup
------

The software stack you will require to use the toolflow will depend what hardware you are targetting. Older hardware (ROACH2 and earlier) use the older Xilinx software (ISE) which forces the use of different tools.

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
* :doc:`Toolflow Documentation <src/jasper_library_modules/modules>`

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Documentation

    CASPER Tutorials <http://casper-tutorials.readthedocs.io/en/latest/>
    blockdocumentation
    Toolflow Documentation <src/jasper_library_modules/modules>
