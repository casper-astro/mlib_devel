# How to install casperfpga

This section explains how to install `casperfpga`, a python library used to interact with CASPER hardware.

Once you have cloned the casperfpga repository, ensure that you are on the correct branch (usually **master** unless you are a contributor) and always pull regularly to make sure you have the latest version of casperfpga.

## Installing casperfpga

[`casperfpga`](https://pypi.org/project/casperfpga/) is now available on the Python Package Index (PyPI) and can be installed via [`pip`](https://pip.pypa.io/en/stable/). However, should you need to interface with a SNAP board, your installation workflow involves the extra step of installing against `casperfpga's requirements.txt`.

```shell
$ git clone https://github.com/casper-astro/casperfpga
$ cd casperfpga/
$ git checkout master
$ sudo apt-get install python-pip
$ sudo pip install -r requirements.txt
$ sudo pip install casperfpga
```

The distribution on the Python Package Index is, of course, a built-distribution; this contains an already-compiled version of the SKARAB programming utility `progska`, written in `C`. Operating Systems tested using `pip install casperfpga` include:

1. Ubuntu 14.04 LTS
2. Ubuntu 16.04 LTS
3. Ubuntu 18.04 LTS
4. Debian 8.x

Unfortunately the success of your installation using `pip` depends on the host OS of the installation, and you might need to rebuild the utility using the C-compiler native to your OS. In short follow the more traditional method of installing custom Python packages.

```shell
# remove current casperfpga install files
$ cd /usr/local/lib/python2.7/dist-packages
$ sudo rm -rf casper*

# clone the repository to your working directory
$ cd /path/to/working/directory 
$ git clone https://github.com/casper-astro/casperfpga.git
$ cd casperfpga
$ git checkout master
$ sudo pip install -r requirements.txt
$ sudo python setup.py install
```


### Testing that the installation worked

To check that casperfpga has been installed correctly open an ipython session and import casperfpga. To avoid errors, move out of your cloned casperfpga repository directory before doing this test. `casperfpga.__version__` will output the build and githash version of your casperfpga library.

```shell
$ cd ..
$ ipython
```
```python
In [1]: import casperfpga
In [2]: casperfpga.__version__
```

If you receive any errors during this step please feel free to contact anyone on the [CASPER Mailing List](mailto:casper@lists.berkeley.edu), or check the [Mailing List Archive](http://www.mail-archive.com/casper@lists.berkeley.edu/) to see if your issue has been resolved already.

## Using casperfpga

The introductory [tutorials](https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/) for current CASPER hardware serve as a guide to the entire process of:
* Creating an FPGA design in Simulink using the CASPER and Xilinx Blocksets
* Building the design using the toolflow, and lastly
* Reconfiguring your CASPER Hardware with the generated .fpg file using `casperfpga`

`casperfpga` is written in python and mainly used to communicate with CASPER Hardware and reconfigure it's firmware. Hence the medium of communication is usually done through an ipython session, as shown below:

```python
import casperfpga
fpga = casperfpga.CasperFpga('skarab_host or roach_name')
fpga.upload_to_ram_and_program('your_file.fpg')
```

## Contributing towards casperfpga

If you would like to contribute towards this library, fork the casperfpga [repo](https://github.com/casper-astro/casperfpga), add your changes to the fork and issue a pull request to the parent repo. 
