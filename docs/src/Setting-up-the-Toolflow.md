# Setting up the Toolflow

This page explains how to install the CASPER tools and what supporting software is required to run them.

## Obtaining the Toolflow

The CASPER toolflow resides in this repository. You can download a copy of it to your local machine with the command `git clone https://github.com/casper-astro/mlib_devel.git`. This will leave you on the master branch. If you wish to select another branch (for example, the `roach2` branch) you can do this by first going in to the newly-cloned repository (`cd mlib_devel`) and then switching branches with `git checkout -b roach2 origin/roach2`. You can always see what remote branches are available (i.e., which branches are in the casper-astro github repository) by running `git branch -r` in your local "mlib_devel" folder.

Using the terminal, type the following: `git status` in the "mlib_devel" folder. This should indicate that the master branch has been selected.

## Getting the right tools for your hardware
The CASPER tools have changed significantly to support Xilinx series 7 (and later) FPGAs. For these boards -- i.e. any FPGA platform based on a 7-series, UltraScale, or Ultrascale+ board -- you should follow the latest instructions in this guide for the _Vivado-based_ flow.
For earlier platforms, which include ROACH1 and ROACH2, you should follow instructions for the _ISE-based_ flow.

## Required 3rd Party Tools

**Operating System**
We suggest Ubuntu 14.04 LTS, Ubuntu 16.04 LTS (with tweaks to the system) or Red Hat Enterprise 6.6 (Santiago). Other operating systems are viable, but proceed at your own risk!

**Python**
The toolflow requires Python 2.7. If you don't have it already you can install it in Ubuntu environments by opening a terminal <ctrl +alt + T> and running the command `sudo apt-get install python`.

You'll also need the [PyYAML](https://pypi.python.org/pypi/PyYAML) package. You can download this and install this directly from source, or use a Python package manager, for example, [pip](https://pypi.python.org/pypi/pip). To install pip, from a terminal, run `sudo apt-get install python-pip`.

Once you have pip installed, you can install pyyaml by running the command `sudo pip install pyyaml` in a terminal.

**MATLAB**
The tools currently support MATLAB 2016b, and the corresponding version of Simulink. You will need to obtain this software, and corresponding licenses either direct from MathWorks or from your institution. For MATLAB install instructions, refer to [How to install Matlab.](How-to-install-Matlab.html)

**Xilinx ISE/Vivado**
For _Vivado-based_ flows, you need to install Xilinx Vivado. Currently we support version 2016.4. These are available from <xilinx.com> and will require a license. If you are part of an academic institution, you may be eligible for free licenses via the [Xilinx University Program](https://www.xilinx.com/support/university.html). For Xilinx ISE or Vivado install instructions, refer to [How to install Xilinx ISE](How-to-install-Xilinx-ISE.html) or [How to install Xilinx Vivado.](How-to-install-Xilinx-Vivado.html)

For _ISE-based_ flows, you need to install Xilinx ISE 14.7. Again, this is available from <xilinx.com>, and academic institutions may be eligible for free licenses via the [Xilinx University Program](https://www.xilinx.com/support/university.html).