
How to install Xilinx Tools
===========================

This section explains how to install Xilinx Vivado and ISE (for the ISE legacy flow).

[Current Vivado flow] How to install 2021.1
-------------------------------------------


#. Required OS: Ubuntu 20.04 LTS
#. Download the Xilinx Vivado installer `here <https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2021-1.html>`_\ , signing in as prompted and selecting the 2021.1 Linux Self Extracting Web Installer option.
#. Run the following to make the newly downloaded file executable:
   .. code-block:: bash

      cd /path/to/Xilinx_Unified_2021.1_0610_2318_Lin64.bin
      chmod +x Xilinx_Unified_2021.1_0610_2318_Lin64.bin

#. Sign into your Xilinx account as prompted.
#. Select *Vivado* on the *Select Product to Install* page.
#. Select *Vivado ML Enterprise* on the *Select Edition to Install* page.
#. On the next page, ensure that all checkboxes for *Design Tools* are selected, that you are installing the devices needed for your work, and that you will acquire/manage a license key post-install.
#. Agree to the licensing agreement and select  your installation paths in the prompts that follow.
#. Click through the rest of the installation, confirm your selections and begin the install.
#. Once the install is complete, you will be asked if you'd like to open the Vivado License Manager to load/manage licenses - do so, go to *Help > Manage License* and input the path to your *Xilinx.lic* license.
#. Click on *View License Status* and ensure that the list of Tools/IP that comes up is valid.
   *[Note: ensure that your license has been generated for Vivado ML edition and Model Composer.]*
#. In order to run the Vivado flow of the CASPER tools, please see `here <https://casper-toolflow.readthedocs.io/en/latest/src/Configuring-the-Toolflow.html>`_.

Optional: Install USB Drivers for JTAG
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

*[Note: this will only be used by toolflow/yellow block developers and is not required for standard use of the toolflow.]*


#. Please see the Vivado 2021.1 installation guide `here <https://docs.xilinx.com/r/2021.1-English/ug973-vivado-release-notes-install-license/Installing-Cable-Drivers>`_ on how to install cable drivers.

[Current Vivado flow] How to install 2023.1
-------------------------------------------

Currently, both RFSoC and Red Pitaya boards have been successfully configured to work with Vivado 2023.1 and Matlab R2022a (see `installing the toolflow <https://casper-toolflow.readthedocs.io/en/latest/src/Installing-the-Toolflow.html#getting-the-right-versions>`_ for more information). Installation of Vivado 2023.1 follows the same steps as Vivado 2021.1 so refer to `the previous section <https://casper-toolflow.readthedocs.io/en/latest/src/How-to-install-Matlab.html#current-vivado-flow-how-to-install-r2021a>`_. Changes in steps are noted below:

Step 2. changes -- The Xilinx Vivado installer is `here <https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2023-1.html>`_. The web installer has a habit of crashing, so you may want to use the Unified Installer even though the amount of space required is much greater (~300 GB).


Step 3. changes -- Assuming that you have downloaded the Unified Installer, then the commands change to:

     .. code-block:: bash

          mkdir $UNZIP_LOC
          tar -xvzf $DOWNLOAD_LOC/Xilinx_Unified_2023.1_0507_1903.tar.gz -C $UNZIP_LOC
          sudo $UNZIP_LOC/Xilinx_Unified_2023.1_0507_1903/xsetup

where *\$UNZIP_LOC* is the path to where you want the install directory to be and *\$DOWNLOAD_LOC* is the location of your downloaded .zip file. Depending on where you install Vivado 2023.1, you may not need elevated permissions. Ignore any popups about installing the newest version of the Vivado design suite.

[ISE legacy flow, ROACH2] How to install Xilinx ISE
---------------------------------------------------


#. Required OS: Ubuntu 14.04 LTS. Xilinx now supports Ubuntu 14.04 LTS. Ubuntu 16.04 LTS can also be used (with tweaks)
#. Click/double click on the\ ``Xilinx_ISE_DS_Lin_14.7_1015_1.tar`` file in the Ubuntu Nautilius document navigator and choose a folder to extract the files to. I use ``home/Installs`` in this document. If you use something different then remember to replace ``Installs`` with your directory name.
#. Ubuntu 14.04. Open a terminal < ctrl + alt + T>. Change directory to the following folder: ``​cd Installs/Xilinx_ISE_DS_Lin_14.7_1015_1``
#. Terminal: Type ``sudo ./xsetup`` and press enter. This application needs to be installed with root privileges otherwise the installation will not install properly. You will be prompted for the sudo password. Enter this and press enter.
#. The ISE 14.7 Installer GUI will pop up. Click “Next” to commence with the installation process.
#. Read the Accept License Agreements (1 of 2) page and when happy tick “I accept...” and “I also accept...” for both tick boxes. Then click “Next”.
#. Read the Accept License Agreements (2 of 2) page and when happy tick “I accept...” for the tick box. Then click “Next”.
#. Select the “ISE Design Suite System Edition” radio button and select “Next”.
#. You will then be required to select which tools you want to install with the ISE Design Suite Edition. I selected “Install Cable Drivers”. The rest of the boxes were ticked, so I have decided to install the complete set of tools available. Press “Next”.
#. Select where you want to install the Vivado tool set. I am using the default ``opt/Xilinx`` folder. I have also ticked the “Import tool preferences from previous version” buttons. This is not necessary though. Press “Next”.
#. A window with the “Installation Summary” will be displayed showing what tools will be installed and where they will be stored on your drive. If you are happy press “Install”, otherwise press “Back” and edit your previous settings.
#. Wait until the Xilinx Software Install window states that the “Install Completed” and select “Finish”.
#. Open another terminal and navigate to the ``opt`` folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> Xilinx -R``
#. Terminal: Navigate to the “home” folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> .Xilinx -R``. NB: This step may not be necessary, but it will not cause an issue if you execute anyway.
#. 
   It will be a good idea to create an ISE 14.7 startup script file on your Desktop with the following lines:

   .. code-block:: bash

        #!/bin/bash
        ./opt/Xilinx/14.7/ISE_DS/settings64.sh
        ise

     NB: Make sure the file is executable and that the nautilius documentation
     navigator is set to run the script.

#. 
   Run the script and the ISE IDE will launch. You can now select the required Xilinx ISE project file (*.xise) and continue.

#. It is now time to install the license for ISE. Create a ``Xilinx`` folder in your home directory using the nautilius documentation navigator:
   ``home/<user name>/Xilinx`` and copy the ISE license file provided by your administrator to this location.
#. Load the license using the Xilinx License Configuration Manager”. Click on “Help” -> “Manage License...”. Click “Load License”. Navigate to the license file (*.lic) in the ``home/<user name>/Xilinx`` folder. Press “Open” and when the license installation was successful then press “OK”.
#. To confirm that the license file was successful, click on “Refresh” and make sure a list of Tools/IP is read back and that the license is still valid. Once this is done then close the “Xilinx License Configuration Manager” by clicking “Close”.
#. 
   To install the USB driver please open up a terminal <ctrl+alt+T> and follow the instructions below:

     **Install the prerequisite**
     On 32-bit: 

   .. code-block:: bash

        sudo apt-get install gitk git-gui libusb-dev build-essential libc6-dev fxload

     On 64-bit: 

   .. code-block:: bash

        sudo apt-get install gitk git-gui libusb-dev build-essential libc6-dev-i386 fxload

     **Download the driver source and install**

   .. code-block:: bash

        cd /opt/Xilinx
        sudo git clone git://git.zerfleddert.de/usb-driver
        cd usb-driver

     On 32 bit: 

   .. code-block:: bash

        sudo make

     On 64 bit: 

   .. code-block:: bash

        sudo make lib32

     **Setup the driver**

   .. code-block:: bash

        ./setup_pcusb /opt/Xilinx/14.7/ISE_DS/ISE/

     Wait until the driver is installed.

#. 
   It may be a good idea to power your PC/lap top down and then up again as the USB drivers may not take affect until this happens. In my case, I plugged a stick drive into the USB and then ejected that and connected the Xilinx Platform Cable USB module. Once this was done then the status LED illuminated and I was able to configure the FPGA via JTAG.

Tweaks for Ubuntu 16.04
^^^^^^^^^^^^^^^^^^^^^^^

The tweaks required to get 14.7 working with Ubuntu 16.04 can vary based on specific versions of libraries that are installed. However, common requirements are:


#. 
   Change the default shell to bash: 

      Change the symbolic link sh -> dash to sh -> bash:

   .. code-block:: bash

         cd /bin/
         sudo rm sh
         sudo ln -s bash sh

#. 
   Edit the Xilinx .settings64 files, in the so that they point to the system libraries first, instead of the Xilinx ones. This will fix a conflict with 'awk'. 

      This requires moving the current LD_LIBRARY_PATH declaration from the end of the line to the start in:

   .. code-block::

         Xilinx/14.7/ISE_DS/common/.settings64.sh
         Xilinx/14.7/ISE_DS/EDK/.settings64.sh
         Xilinx/14.7/ISE_DS/ISE/.settings64.sh

      So

   .. code-block:: bash

         if [ -n "$LD_LIBRARY_PATH" ]; then
               LD_LIBRARY_PATH=${XILINX_EDK}/lib/lin64:${LD_LIBRARY_PATH};export
         LD_LIBRARY_PATH;

      becomes

   .. code-block:: bash

         if [ -n "$LD_LIBRARY_PATH" ]; then
               LD_LIBRARY_PATH=:${LD_LIBRARY_PATH}:${XILINX_EDK}/lib/lin64;export
         LD_LIBRARY_PATH;

#. 
   Once changing the settings files, a default LD_LIBRARY_PATH must be created if it does not already exist. A suggested path that allows 'awk' to be processed correctly is:

   .. code-block:: bash

         LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:/lib/x86_64-linux-gnu:/lib64/:/lib/

      (Some alternative methods for dealing with this can be found on the CASPER mailing list archive)
