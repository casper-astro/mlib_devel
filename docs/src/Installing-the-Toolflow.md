# Installing the Toolflow

This page explains how to install the CASPER tools and what supporting software is required to run them.

## Getting the right versions

The toolflow is very sensitive to mis-matching software versions. The current compatibility matrix of software versions is below:

_(Note that official support for ROACH plaforms is no longer provided, however [this version](https://github.com/casper-astro/mlib_devel/tree/d77999047d2f0dc53e1c1e6e516e6ef3cdd45632/docs) of `mlib_devel` contains all ROACH related documentation and ROACH tutorials can be found [here](https://casper-tutorials.readthedocs.io/en/latest/tutorials/roach/tut_intro.html))_

|  Hardware      |   Operating System  |    Matlab Version  |    Xilinx Version  |    mlib_devel branch / commit   |  Python Version  |
|----------------|---------------------|--------------------|--------------------|---------------------------------|------------------|
|ROACH1/2        | Ubuntu 14.04        |  2013b             |  ISE 14.7          |  branch: `roach2`               |  Python 2.7      |
|SKARAB          | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |  Python 3        |
|SNAP            | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |  Python 3        |
|Red Pitaya      | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |  Python 3        |
|VCU118          | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |  Python 3        |
|VCU128          | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |  Python 3        |
|ZCU111          | Ubuntu 16.04        |  2018a             |  Vivado 2019.1.1   |  branch: `master`               |  Python 3        |
|SNAP2           | Ubuntu 16.04        |  2016b             |  Vivado 2016.4     |  branch: `master`               |  Python 3        |

Other software combinations may work, but these are the tested configurations.
The master branch is usually updated once a year. Between updates, code with newer features can be found in the `casper-astro-soak-test` branch. This branch can usually be used in place of the `master` branch for platforms which support `master`. However, be aware that `casper-astro-soak-test` is likely to be less stable. Please report any bugs you encounter via github's issue tracker.


## Pre-requisites

1. MATLAB

    MATLAB installation instructions are available [here](https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Matlab.html), or, contact whoever manages your software installations.
    You will need to install both MATLAB and Simulink.

2. Xilinx Vivado

    This is available from [xilinx.com](https://www.xilinx.com) and will require a license. If you are part of an academic institution you may be eligible for free licenses via the [Xilinx University Program](https://www.xilinx.com/support/university.html).
    Vivado install instructions are available [here](ttps://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Xilinx-Vivado.html).

3. Python

    Compiling for supported platforms requires Python 3 and `pip3`. If you don't have these already you can probably install them in Ubuntu environments by opening a terminal and running the command `apt-get install python3 python3-pip`.

    We thoroughly recommend using a [virtual environment](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#installing-virtualenv) to separate the version of Python and its libraries the toolflow uses from the rest of your system. 

    To create a Python 3 virtual environment:

    ```bash
    # change directory to where you want the virtual environment to live
    cd /home/user/work
    # install virtualenv using pip3
    sudo pip3 install virtualenv
    # create a Python 3 virtual environment
    virtualenv -p python3 casper_venv
    # to activate the virtual environment:
    source casper_venv/bin/activate
    # to deactivate the virtual environment:
    deactivate
    ```

## Obtaining the Toolflow
Clone the toolflow from the [mlib_devel](https://github.com/casper-astro/mlib_devel) git repository. 

```bash
# Clone the mlib_devel repository. Replace <branch_name> with the branch
# supported by your chosen platform.
# Eg. for master you should run:
# git clone -b master https://github.com/casper-astro.mlib_devel
git clone -b <branch_name> https://github.com/casper-astro/mlib_devel
```

This could take a while -- the repository is several hundred megabytes. If you want, you can save some time by adding the `--depth=1` flag to the above command. This will only download the current version of the repository, rather than its full git history.

Next, move into the `mlib_devel` repository you have just created, activate your virtual environment (if using one) and download any Python dependencies you need by installing the requirements.txt file. The downloaded dependencies will be installed within the virtual environment separate to the rest of your system.

```bash
cd mlib_devel
source /home/user/work/casper_venv/bin/activate
pip3 install -r requirements.txt
```

You may need to run the `pip3 install` command as an administrator if you are using the system-maintained python installation instead of a virtual environment.

## Configuring the toolflow

You now have all the software you need to start building your designs. However, you'll still need to specify some local configuration details which will depend on how you carried out your installation. See [Configuring the Toolflow](https://casper-toolflow.readthedocs.io/en/latest/src/Configuring-the-Toolflow.html) for more details.


