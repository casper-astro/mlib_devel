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

The software stack you will require to use the toolflow will depend what hardware you are targeting. Older hardware (ROACH2 and earlier) use the older Xilinx software (ISE) which forces the use of different tools.

The current compatibility matrix is below:

(Note that official support for ROACH plaforms is no longer provided, however `this version <https://github.com/casper-astro/mlib_devel/tree/d77999047d2f0dc53e1c1e6e516e6ef3cdd45632/docs>`__ of `mlib_devel` contains all ROACH related documentation and ROACH tutorials can be found `here <https://casper-tutorials.readthedocs.io/en/latest/tutorials/roach/tut_intro.html>`__)

+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|  Hardware      |   Operating System  |    MATLAB Version  |    Xilinx Version  |    mlib_devel branch / commit   |   Python Version  |
+================+=====================+====================+====================+=================================+===================+
|ROACH1/2        | Ubuntu 14.04        |  2013b             |  ISE 14.7          |  branch: `roach`                |   Python 2.7      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|SKARAB          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|SNAP            | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|Red Pitaya      | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|VCU118          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|VCU128          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|ZCU216          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|ZCU208          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|ZCU111          | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|PYNQ RFSoC 2x2  | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|HTG ZRF16-29DR  | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|HTG ZRF16-49DR  | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+
|SNAP2           | Ubuntu 20.04        |  2021a             |  Vivado 2021.1     |  branch: `m2021a`               |   Python 3.8      |
+----------------+---------------------+--------------------+--------------------+---------------------------------+-------------------+

A Note on Operating Systems
"""""""""""""""""""""""""""

The recommended OS is Ubuntu as this is what the majority of the collaboration are using. This makes it easier for us to support you. If you are so inclined, you could also use Red Hat, but we definitely do not support Windows. You are welcome to try but you will be on your own. You could always run Linux in a VM although this will increase your compile times. 

With the exception of ROACH1/2, all CASPER hardware mentioned above has been fully tested using an Ubuntu 18.04 and 20.04 LTS distribution. However, both operating systems require a few tweaks to work properly.

Ubuntu 18.04:

Some common issues encountered in running the tools on 18.04 include missing packages and incompatibilities between the libraries used to build older versions of MATLAB/Vivado and the libraries that come with Ubuntu 18.04. Some tips on fixing these issues:

- If you encounter System Generator socket timeout errors when trying to open a model in Simulink, or are faced with errors about GUI function call recursion when double-clicking Xilinx blocks, installing KDE (``sudo apt install kde-full``) may solve this.
- If you encounter an error along the lines of `"MATLABWindow application failed to launch. Unable to launch the MATLABWindow application"`, this is due to library incompatibilities between 18.04 and MATLAB R2018a and can be solved using `this workaround <https://www.mathworks.com/matlabcentral/answers/397138-why-do-i-get-a-matlabwindow-application-failed-to-launch-error-when-launching-live-editor-app-des>`__.
- For more detailed information on debugging library clashes/missing libraries, `this blog post <https://strath-sdr.github.io/tools/matlab/sysgen/vivado/linux/2021/01/28/sysgen-on-20-04.html>`__ by Craig Ramsay very kindly steps through the debugging process of getting System Generator working on Ubuntu 20.04 and contains information that is equally applicable to debugging on 18.04 (such as using the ``ldd`` command to find missing/incorrect library dependencies, and then installing/excluding the relevant libraries as needed). 
 
Ubuntu 20.04:

For Ubuntu 20.04, there are a few limitations:

- You must install gcc-6.x or alternatively create the links suggested in the installation documentation found `here <https://docs.xilinx.com/r/2021.2-English/ug1483-model-composer-sys-gen-user-guide/Supported-MATLAB-Versions-and-Operating-Systems>`__
- If you find the System Generator gets stuck during initialization or when compiling: There are some toolboxes that can cause this. We recommend only having the required toolboxes installed. See also `this thread <https://support.xilinx.com/s/question/0D52E00006vF6FOSA0/model-composer-v20212-matlab-r2021a-gets-stuck-at-initialization-stage-on-ubuntu-20041?language=en_US>`__, for more information.
- If you find that you cannot simulate without getting gcc errors, you may need to update the Xilinx version of `as` to run the operating system version. This can be done by changing the link at `/tools/Xilinx/Vivado/2021.1/tps/lnx64/binutils-2.26/bin/as` to point to `/usr/bin/as` instead.

Please refer to the setup links below for more information on setting up the toolflow.

Setup Links
"""""""""""

1. :doc:`Installing the Toolflow <src/Installing-the-Toolflow>`
2. :doc:`Installing MATLAB <src/How-to-install-Matlab>`
3. :doc:`Installing Xilinx Vivado <src/How-to-install-Xilinx-Vivado>`
4. :doc:`Installing casperfpga <src/How-to-install-casperfpga>`
5. :doc:`Configuring the Toolflow <src/Configuring-the-Toolflow>`
6. :doc:`Running the Toolflow <src/Running-the-Toolflow>`

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Setup

    src/Installing-the-Toolflow
    src/How-to-install-Matlab
    src/How-to-install-Xilinx-Vivado
    src/How-to-install-casperfpga
    src/Configuring-the-Toolflow
    src/Running-the-Toolflow

Documentation
---------------

* `CASPER Tutorials <http://casper-tutorials.readthedocs.io/en/latest/>`__
* :doc:`AXI Documentation <axi4lite_documentation>`
* :doc:`Block Documentation <blockdocumentation>`
* :doc:`Toolflow Documentation <jasper_documentation>`
* :doc:`Toolflow Sourcecode <src/jasper_library_modules/modules>`
* `casperfpga Sourcecode <https://casper-toolflow.readthedocs.io/projects/casperfpga/en/latest/>`__

..  toctree::
    :hidden:
    :maxdepth: 1
    :caption: Documentation

    CASPER Tutorials <http://casper-tutorials.readthedocs.io/en/latest/>
    axi4lite_documentation
    blockdocumentation
    jasper_documentation
    Toolflow Sourcecode <src/jasper_library_modules/modules>
    casperfpga Sourcecode <https://casper-toolflow.readthedocs.io/projects/casperfpga/en/latest/>


Get Involved
--------------
If you are a CASPER collaborator, or you’re just interested in what we’re up to, feel free to join our mailing list by sending a blank email `here. <casper+subscribe@lists.berkeley.edu>`_

If would like to get involved in the development of the tools, please join our dev mailing list by sending a blank email `here. <casper-dev+subscribe@lists.berkeley.edu>`_.

