
Installing the Toolflow
=======================

This page explains how to install the CASPER tools and what supporting software is required to run them.

Getting the right versions
--------------------------

The toolflow is very sensitive to mis-matching software versions. The current compatibility matrix of software versions is below:

*(Note that official support for ROACH plaforms is no longer provided, however* `this version <https://github.com/casper-astro/mlib_devel/tree/d77999047d2f0dc53e1c1e6e516e6ef3cdd45632/docs>`_ of ``mlib_devel`` *contains all ROACH related documentation and ROACH tutorials can be found* `here <https://casper-tutorials.readthedocs.io/en/latest/tutorials/roach/tut_intro.html>`_).


.. csv-table:: 
   :file: ../_static/files/hardware-compatibility-matrix.csv
   :widths: 16, 17, 16, 17, 17, 17
   :header-rows: 1

..
  .. list-table::
     :header-rows: 1
     :widths: 16 16 17 17 17 17

     * - Hardware
       - Operating System
       - MATLAB Version
       - Xilinx Version
       - mlib_devel branch / commit
       - Python Version
     * - ROACH1/2
       - Ubuntu 14.04
       - 2013b
       - ISE 14.7
       - branch: ``roach2``
       - Python 2.7
     * - SKARAB
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1
       - branch: ``m2021a``
       - Python 3
     * - SNAP
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1
       - branch: ``m2021a``
       - Python 3
     * - Red Pitaya
       - Ubuntu 20.04
       - 2021a/2022a
       - Vivado 2021.1/2023.1
       - branch: ``m2021a``/``m2022a``
       - Python 3
     * - VCU118
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1
       - branch: ``m2021a``
       - Python 3
     * - VCU128
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1
       - branch: ``m2021a``
       - Python 3
     * - ZCU216
       - Ubuntu 20.04
       - 2021a/2022a
       - Vivado 2021.1/2023.1
       - branch: ``m2021a``/``m2022a``
       - Python 3
     * - ZCU208
       - Ubuntu 20.04
       - 2021a/2022a
       - Vivado 2021.1/2023.1
       - branch: ``m2021a``/``m2022a``
       - Python 3
     * - ZCU111
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1/2023.1
       - branch: ``m2021a``/``m2022a``
       - Python 3
     * - PYNQ RFSoC 2x2
       - Ubuntu 20.04
       - 2021a/2022a
       - Vivado 2021.1/2023.1
       - branch: ``m2021a``/``m2022a``
       - Python 3
    * - PYNQ RFSoC 4x2
       - Ubuntu 20.04
       - 2021a/2022a
       - Vivado 2021.1/2023.1
       - branch: ``m2021a``/``m2022a``
       - Python 3
     * - HTG ZRF16-29DR
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1
       - branch: ``m2021a``
       - Python 3
     * - HTG ZRF16-49DR
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1
       - branch: ``m2021a``
       - Python 3
     * - SNAP2
       - Ubuntu 20.04
       - 2021a
       - Vivado 2021.1
       - branch: ``m2021a``
       - Python 3


Other software combinations may work, but these are the tested configurations. Please see the `Note on Operating Systems <https://casper-toolflow.readthedocs.io/en/latest/index.html#a-note-on-operating-systems>`_ for information on which alternative OS versions *may* work with the tools.

The main toolflow branches are usually updated once a year. Between updates, code with newer features can be found in the respective dev branch (e.g ``m2021a-dev`` branch. However, be aware that ``-dev``  branches are likely to be less stable. Please report any bugs you encounter via github's issue tracker.

Pre-requisites
--------------


#. 
   MATLAB

    MATLAB installation instructions are available `here <https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Matlab.html>`_\ , or, contact whoever manages your software installations.
    You will need to install both MATLAB and Simulink.

#. 
   Xilinx Vivado

    Vivado is available from `xilinx.com <https://www.xilinx.com>`_ and will require a license. You will also need a license for Model Composer, which as of 2021 is now part of a separate product called *Vitis Model Composer*. If you are part of an academic institution you may be eligible for free licenses via the `Xilinx University Program <https://www.xilinx.com/support/university.html>`_.
    Vivado install instructions are available `here <https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Xilinx-Vivado.html>`_.

    Licenses for Vivado/Vitis are backwards-compatible with older versions. For example, a license for *Vivado ML Edition* (2022) should work with *Xilinx tools Vivado Design Suite - HLx Editions* (2016-2020). Note that you may still need a Vitis license (for Model Composer), even if using an older version of Vivado released before Vitis existed!

#. 
   Python

    Compiling for supported platforms requires Python 3 and ``pip3``. If you don't have these already you can probably install them in Ubuntu environments by opening a terminal and running the command ``apt-get install python3 python3-pip``.

    We thoroughly recommend using a `virtual environment <https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#installing-virtualenv>`_ to separate the version of Python and its libraries the toolflow uses from the rest of your system. 

    To create a Python 3 virtual environment:

   .. code-block:: bash

       # install the python3-venv package
       sudo apt install python3-venv
       # change directory to where you want the virtual environment to live
       cd /home/user/work
       # create a Python 3 virtual environment
       python3 -m venv casper_venv
       # to activate the virtual environment:
       source casper_venv/bin/activate
       # to deactivate the virtual environment:
       deactivate

#. 
   casperfpga

    ``casperfpga`` is a python library used to interact and interface with `\ **CASPER** Hardware <https://github.com/casper-astro/casper-hardware>`_. Functionality includes being able to reconfigure firmware, as well as read and write registers across the various communication interfaces.

    You will need to install this library to interface with CASPER hardware. Installation instructions can be found `here <https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-casperfpga.html>`_.

Obtaining the Toolflow
----------------------

Clone the toolflow from the `mlib_devel <https://github.com/casper-astro/mlib_devel>`_ git repository. 

.. code-block:: bash

   # Clone the mlib_devel repository. Replace <branch_name> with the branch
   # supported by your chosen platform.
   # Eg. for m2021a you should run:
   # git clone -b m2021a https://github.com/casper-astro.mlib_devel
   git clone -b <branch_name> https://github.com/casper-astro/mlib_devel

This could take a while -- the repository is several hundred megabytes. If you want, you can save some time by adding the ``--depth=1`` flag to the above command. This will only download the current version of the repository, rather than its full git history.

Next, move into the ``mlib_devel`` repository you have just created, activate your virtual environment (if using one) and download any Python dependencies you need by installing the requirements.txt file. The downloaded dependencies will be installed within the virtual environment separate to the rest of your system.

.. code-block:: bash

   cd mlib_devel
   source /home/user/work/casper_venv/bin/activate
   pip3 install -r requirements.txt

You may need to run the ``pip3 install`` command as an administrator if you are using the system-maintained python installation instead of a virtual environment (a virtual environemnt is *highly* recommended).

**Note: There appears to be an incompability between pip3 v21.3.1 and xml2vhdl (one of the dependencies listing in the requirements file) that results in errors when installing requirements.txt. If you encounter an issue in fetching xml2vhdl when running** ``pip3 install -r requirements.txt``\, **try to install pip3 v18.1 or earlier and use that instead (this is one of those things best done in a virtual environment, so as to not mess around with the system version of Python).**  

Configuring the toolflow
------------------------

You now have all the software you need to start building your designs. However, you'll still need to specify some local configuration details which will depend on how you carried out your installation. See `Configuring the Toolflow <https://casper-toolflow.readthedocs.io/en/latest/src/Configuring-the-Toolflow.html>`_ for more details.
