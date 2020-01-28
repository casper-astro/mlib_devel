# Installing the Toolflow

This page explains how to install the CASPER tools and what supporting software is required to run them.

## Getting the right versions

The toolflow is very sensitive to mis-matching software versions. Depending on the hardware you intend to use, you will need different versions of:
1. CASPER's `mlib_devel` libraries
2. Mathworks MATLAB / Simulink
3. Xilinx Vivado / ISE

The current compatibility matric is below:

|  Hardware   |   Operating System  |    Matlab Version  |    Xilinx Version  |    mlib_devel branch / commit   |
|-------------|---------------------|--------------------|--------------------|---------------------------------|
|ROACH1/2     | Ubuntu 14.04        |  2013b             |  ISE 14.7          |  branch: `roach`                |
|SKARAB       | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |
|SNAP         | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |
|Red Pitaya   | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |
|VCU118       | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |
|VCU128       | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |
|ZCU111       | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |
|SNAP2        | Ubuntu 16.04        |  ???               |  ???               |  branch: `master`               |

Other software combinations may work, but these are the tested configurations.
The master branch is usually updated once a year. Between updates, code with newer features can be found in the `casper-astro-soak-test` branch. This branch can usually be used in place of the `master` branch for platforms which support `master`. However, be aware that `casper-astro-soak-test` is likely to be less stable. Please report any bugs you encounter via github's issue tracker.

## Pre-requisites
1. MATLAB

MATLAB installation instructions are available [here](https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Matlab.html), or, contact whoever manages your software installations.
You will need to install both MATLAB and Simulink.

2. Xilinx Vivado / ISE

These are available from [xilinx.com](https://www.xilinx.com) and will require a license. If you are part of an academic institution you may be eligible for free licenses via the [Xilinx University Program](https://www.xilinx.com/support/university.html).
If you need them, install instructions are available:
* [How to install Xilinx ISE](https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Xilinx-ISE.html)
* [How to install Xilinx Vivado](https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Xilinx-Vivado.html)

3. Python

Compiling for _ROACH_ requires Python 2.7 and `pip`. If you don't have these already you can probably install them in Ubuntu environments by opening a terminal and running the command `apt-get install python2.7 python-pip`.

Compiling for _non-ROACH platforms_ requires Python 3 and `pip3`. If you don't have these already you can probably install them in Ubuntu environments by opening a terminal and running the command `apt-get install python3 python3-pip`.

Once you have these installed, you can install the python dependencies of the toolflow by running, in the root directory of your mlib_devel repository:

For _ROACH_: `pip install -r requirements.txt`

For _non-ROACH platforms_: `pip3 install -r requirements.txt`

## Obtaining the Toolflow
Clone the toolflow from the [mlib_devel](https://github.com/casper-astro/mlib_devel) git repository. 

```bash
# Clone the mlib_devel repository. Replace <branch_name> with the branch
# supported by your chosen platform.
# Eg. for roach you should run:
# git clone -b roach2 https://github.com/casper-astro.mlib_devel
git clone -b <branch_name> https://github.com/casper-astro/mlib_devel
```

This could take a while -- the repository is several hundred megabytes. If you want, you can save some time by adding the `--depth=1` flag to the above command. This will only download the current version of the repository, rather than its full git history.

Next, move into the repository you have just created and download any python dependencies you need. *This is only necessary for non-ROACH versions of the toolflow.

```bash
cd mlib_devel
pip install -r requirements.txt
```

You may need to run the `pip install` command as an administrator if you are using the system-maintained python installation. We thoroughly recommend using a [virtual environment](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#installing-virtualenv) to separate the version of python and its libraries the toolflow uses from the rest of your system.

## Configuring the toolflow

You now have all the software you need to start building your designs. However, you'll still need to specify some local configuration details which will depend on how you carried out your installation. See [Configuring the Toolflow](https://casper-toolflow.readthedocs.io/en/latest/src/Configuring-the-Toolflow.html) for more details.
