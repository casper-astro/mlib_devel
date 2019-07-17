# Setting up the Toolflow

This page explains how to install the CASPER tools and what supporting software is required to run them.

## Obtaining the Toolflow
* The CASPER toolflow resides in the [mlib_devel](https://github.com/casper-astro/mlib_devel) git repository. You can download a copy of it to your local machine with the command `git clone https://github.com/casper-astro/mlib_devel.git`; this will leave you on the master branch.
* If you wish to select another branch (for example, the `roach2` branch) you can do this by first navigating into the newly-cloned repository (`cd mlib_devel`) and then switching branches with `git checkout -b roach2 origin/roach2`.
* You can always see the local and remote branches are available (i.e. which branches are in the casper-astro github repository) by running `git branch -a` in your local `mlib_devel` folder.
* Using the terminal, type `git status` in the `mlib_devel` folder. This should indicate that the master branch has been selected.

## Getting the right tools for your hardware
The CASPER tools have changed significantly to support Xilinx series 7 (and later) FPGAs. For these boards - i.e. any FPGA platform based on a 7-series, UltraScale, or Ultrascale+ board - you should follow the latest instructions in this guide for the _Vivado-based_ flow. For earlier platforms, which include ROACH1 and ROACH2, you should follow instructions for the _ISE-based_ flow.

## Required 3rd Party Tools

### Operating System
We suggest Ubuntu 16.04 LTS (18.04 has been show not to work), or Red Hat Enterprise 6.7+ or 7.3+. Other operating systems are viable, but not recommended as there won't be many people running the same setup as you and support will be hard to come by! Please see the [Matlab System Requirements](https://www.mathworks.com/support/sysreq.html) and page 11 of the [Vivado Design Suit User Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_2/ug973-vivado-release-notes-install-license.pdf).

### MATLAB
The tools currently support MATLAB 2016b for the SNAP platform and MATLAB 2018a for the SKARAB platform, and the corresponding version of Simulink. You will need to obtain this software and corresponding licenses either direct from MathWorks or from your institution. MATLAB installation instructions [here](https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Matlab.html) or in the navigation pane alongside.

### Xilinx ISE/Vivado
These are available from [xilinx.com](https://www.xilinx.com) and will require a license. If you are part of an academic institution you may be eligible for free licenses via the [Xilinx University Program](https://www.xilinx.com/support/university.html).

As the name suggests, _ISE-based_ flows require Xilinx ISE 14.7 and _Vivado-based_ flows require Xilinx Vivado. Currently we support Vivado version 2016.4 for the SNAP platform and 2018.2 for the SKARAB platform.  Instructions on how to install ISE and Vivado can be found below and in the navigation pane alongside:
* [How to install Xilinx ISE](https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Xilinx-ISE.html)
* [How to install Xilinx Vivado](https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Xilinx-Vivado.html)


### Python
The toolflow requires Python 2.7. If you don't have it already you can install it in Ubuntu environments by opening a terminal <ctrl+alt+T> and running the command `sudo apt-get install python`.

You will also need the [PyYAML](https://pypi.python.org/pypi/PyYAML) package. You can download this and install this directly from source or use a Python package manager, e.g. [pip](https://pypi.python.org/pypi/pip). To install pip, from a terminal, run `sudo apt-get install python-pip`.

Once you have pip installed you can install PyYAML by running the command `sudo pip install pyyaml` in a terminal.
