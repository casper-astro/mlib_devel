
How to install casperfpga
=========================

This section explains how to install ``casperfpga``\ , a python library used to interact with CASPER hardware. The ``casperfpga`` library currently works fully with Python 3.8.

Once you have cloned the casperfpga repository, ensure that you are on the correct branch (usually **py38** unless you are a contributor) and always pull regularly to make sure you have the latest version of casperfpga.

Installing casperfpga using a virtual environment
-------------------------------------------------


.. raw:: html

   <!---[`casperfpga`](https://pypi.org/project/casperfpga/) is now available on the Python Package Index (PyPI) and can be installed via [`pip`](https://pip.pypa.io/en/stable/). However, should you need to interface with a SNAP board, your installation workflow involves the extra step of installing against `casperfpga's requirements.txt`.--->



.. code-block:: shell

   $ python3.8 -m venv ./cfpga_venv
   $ source ./cfpga_venv/bin/activate
   $ git clone https://github.com/casper-astro/casperfpga
   $ cd casperfpga/
   $ git checkout py38 
   $ pip install -r requirements.txt
   $ pip install .

<!--The distribution on the Python Package Index is, of course, a built-distribution; this contains an already-compiled version of the SKARAB programming utility ``progska``\ , written in ``C``. Operating Systems tested using ``pip install casperfpga`` include:


#. Ubuntu 14.04 LTS
#. Ubuntu 16.04 LTS
#. Ubuntu 18.04 LTS
#. Ubuntu 20.04 LTS
#. Debian 8.x

Unfortunately the success of your installation using ``pip`` depends on the host OS of the installation, and you might need to rebuild the utility using the C-compiler native to your OS. In short follow the more traditional method of installing custom Python packages.

.. code-block:: shell

   # remove current casperfpga install files
   $ cd /usr/local/lib/python2.7/dist-packages
   $ sudo rm -rf casper*

   # clone the repository to your working directory
   $ cd /path/to/working/directory 
   $ git clone https://github.com/casper-astro/casperfpga.git
   $ cd casperfpga
   $ git checkout master
   $ sudo pip install -r requirements.txt
   $ sudo python setup.py install-->

Testing that the installation worked
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To check that casperfpga has been installed correctly open an ipython session and import casperfpga. **To avoid errors, move out of your cloned casperfpga repository directory before doing this test.** ``casperfpga.__version__`` will output the build and githash version of your casperfpga library.

.. code-block:: shell

   $ cd ..
   $ ipython

.. code-block:: python

   In [1]: import casperfpga
   In [2]: casperfpga.__version__

If you receive any errors during this step please feel free to contact anyone on the `CASPER Mailing List <mailto:casper@lists.berkeley.edu>`_\ , or check the `Mailing List Archive <http://www.mail-archive.com/casper@lists.berkeley.edu/>`_ to see if your issue has been resolved already.

Using casperfpga
----------------

The introductory `tutorials <https://casper-toolflow.readthedocs.io/projects/tutorials/en/latest/>`_ for current CASPER hardware serve as a guide to the entire process of:


* Creating an FPGA design in Simulink using the CASPER and Xilinx Blocksets
* Building the design using the toolflow, and lastly
* Reconfiguring your CASPER Hardware with the generated .fpg file using ``casperfpga``

``casperfpga`` is written in python and mainly used to communicate with CASPER Hardware and reconfigure it's firmware. Hence the medium of communication is usually done through an ipython session, as shown below:

.. code-block:: python

   import casperfpga
   fpga = casperfpga.CasperFpga('skarab_host or roach_name')
   fpga.upload_to_ram_and_program('your_file.fpg')

Contributing towards casperfpga
-------------------------------

If you would like to contribute towards this library, fork the casperfpga `repo <https://github.com/casper-astro/casperfpga>`_\ , add your changes to the fork and issue a pull request to the parent repo. 
