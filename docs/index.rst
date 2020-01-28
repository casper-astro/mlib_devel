CASPER Toolflow
=================

Welcome to the documentation for ``mlib_devel``, the CASPER Toolflow!

What is mlib_devel?
^^^^^^^^^^^^^^^^^^^

The ``mlib_devel`` repository contains a set of FPGA DSP libraries and programming tools developed and maintained by the  `Collaboration for Astronomical Signal Processing and Electronics Research (CASPER) <http://casper.berkeley.edu/>`__. Within the collaboration, this collection of software is affectionately referred to as *The Toolflow*.

The CASPER toolflow allows you to generate signal processing designs using MATLAB's graphical programming tool ``Simulink``. These designs can be turned into FPGA bitstreams and loaded onto a variety of supported hardware platforms to perform real-time digital signal processing systems. CASPER also provides a Python software library for interacting with running designs:  `casperfpga <https://github.com/casper-astro/casperfpga>`__.

Using mlib_devel
^^^^^^^^^^^^^^^^

For more information about installing and using the CASPER Toolflow, see the project's `documentation <https://casper-toolflow.readthedocs.io>`__.

CASPER also maintain a set of `tutorials <https://casper-tutorials.readthedocs.io>`__, designed to introduce new users to the toolflow.

Updating an Existing Toolflow Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
You can always update your installation of `mlib_devel` by pulling updated code from this repository. If you do this,      chances are you'll need to update your Simulink models to match your new `mlib_devel` libraries. A script is provided to automate this process. With your model open and active, in your MATLAB prompt, run

.. code-block:: matlab

   update_casper_blocks(bdroot)

This script will resynchronize every CASPER block in your design with its latest library version. Depending on the size of your model, it may take many minutes to complete! As always, back up your designs before attempting such a major operation. And, if you experience problems, please raise Github issues!


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

+-------------+--------------------+----------------+---------------+----------------------------------------------------------------------------+
| Platform    | OS                 | Matlab Version | Xilinx Tools  | mlib_devel                                                                 |
+=============+====================+================+===============+============================================================================+
| ROACH1 or 2 | Ubuntu 12.04/14.04 | R2013b         | ISE 14.7      | `ROACH branch <https://github.com/casper-astro/mlib_devel/tree/roach2>`__  |
+-------------+--------------------+----------------+---------------+----------------------------------------------------------------------------+
| SNAP        | Ubuntu 14.04/16.04 | R2016b         | Vivado 2016.4 | `Master branch <https://github.com/casper-astro/mlib_devel>`__             |
+-------------+--------------------+----------------+---------------+----------------------------------------------------------------------------+
| SKARAB      | Ubuntu 14.04/16.04 | R2016b         | Vivado 2016.2 | `Master branch <https://github.com/casper-astro/mlib_devel>`__             |
+-------------+--------------------+----------------+---------------+----------------------------------------------------------------------------+
| VCU118      | Ubuntu 14.04/16.04 | R2017b         | Vivado 2018.2 | `vcu118 branch <https://github.com/casper-astro/mlib_devel/tree/vcu118>`__ |
+-------------+--------------------+----------------+---------------+----------------------------------------------------------------------------+

1. :doc:`Installing the Toolflow <src/Installing-the-Toolflow>`
2. :doc:`Installing Matlab <src/How-to-install-Matlab>`
3. :doc:`Installing Xilinx Vivado <src/How-to-install-Xilinx-Vivado>` or :doc:`Installing Xilinx ISE (ROACH only) <src/How-to-install-Xilinx-ISE>`
4. :doc:`Configuring the Toolflow <src/Configuring-the-Toolflow>`
5. :doc:`Running the Toolflow <src/Running-the-Toolflow>`

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Setup

    src/Installing-the-Toolflow
    src/How-to-install-Matlab
    src/How-to-install-Xilinx-Vivado
    src/How-to-install-Xilinx-ISE
    src/Configuring-the-Toolflow
    src/Running-the-Toolflow

Documentation
---------------

* `CASPER Tutorials <http://casper-tutorials.readthedocs.io/en/latest/>`__
* :doc:`Block Documentation <blockdocumentation>`
* :doc:`Toolflow Documentation <jasper_documentation>`
* :doc:`Toolflow Sourcecode <src/jasper_library_modules/modules>`
* `casperfpga Sourcecode <https://casper-toolflow.readthedocs.io/projects/casperfpga/en/latest/>`__

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Documentation

    CASPER Tutorials <http://casper-tutorials.readthedocs.io/en/latest/>
    blockdocumentation
    jasper_documentation
    Toolflow Sourcecode <src/jasper_library_modules/modules>
    casperfpga Sourcecode <https://casper-toolflow.readthedocs.io/projects/casperfpga/en/latest/>


Get Involved
--------------
If you are a CASPER collaborator, or you’re just interested in what we’re up to, feel free to join our mailing list by sending a blank email `here. <casper+subscribe@lists.berkeley.edu>`_

If would like to get involved in the development of the tools, please join our dev mailing list by sending a blank email `here. <casper-dev+subscribe@lists.berkeley.edu>`_.
