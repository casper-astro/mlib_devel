# How to install Xilinx Tools

This section explains how to install Xilinx Vivado and ISE (for the ISE legacy flow).

## [Current Vivado flow] How to install 2021.1

1. Required OS: Ubuntu 2.04 LTS
2. Download the Xilinx Vivado installer [here](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2021-1.html), signing in as prompted and selecting the 2021.1 Linux Self Extracting Web Installer option.
3. Run the following to make the newly downloaded file executable:
```bash
cd /path/to/Xilinx_Unified_2021.1_0610_2318_Lin64.bin
chmod +x Xilinx_Unified_2021.1_0610_2318_Lin64.bin
```
4. Sign into your Xilinx account as prompted.
5. Select *Vivado* on the *Select Product to Install* page.
6. Select *Vivado ML Enterprise* on the *Select Edition to Install* page.
7. On the next page, ensure that all checkboxes for *Design Tools* are selected, that you are installing the devices needed for your work, and that you will acquire/manage a license key post-install.
8. Agree to the licensing agreement and select  your installation paths in the prompts that follow.
9. Click through the rest of the installation, confirm your selections and begin the install.
10. Once the install is complete, you will be asked if you'd like to open the Vivado License Manager to load/manage licenses - do so, go to *Help > Manage License* and input the path to your *Xilinx.lic* license.
11. Click on *View License Status* and ensure that the list of Tools/IP that comes up is valid.
*[Note: ensure that your license has been generated for Vivado ML edition and Model Composer.]*
12. In order to run the Vivado flow of the CASPER tools, please see [here](https://casper-toolflow.readthedocs.io/en/latest/src/Configuring-the-Toolflow.html).
 
### Optional: Install USB Drivers for JTAG

*[Note: this will only be used by toolflow/yellow block developers and is not required for standard use of the toolflow.]*
1. Please see the Vivado 2021.1 installation guide [here](https://docs.xilinx.com/r/2021.1-English/ug973-vivado-release-notes-install-license/Installing-Cable-Drivers) on how to install cable drivers.

## [ISE legacy flow, ROACH2] How to install Xilinx ISE
1. Required OS: Ubuntu 14.04 LTS. Xilinx now supports Ubuntu 14.04 LTS. Ubuntu 16.04 LTS can also be used (with tweaks)
2. Click/double click on the``Xilinx_ISE_DS_Lin_14.7_1015_1.tar`` file in the Ubuntu Nautilius document navigator and choose a folder to extract the files to. I use ``home/Installs`` in this document. If you use something different then remember to replace ``Installs`` with your directory name.
3. Ubuntu 14.04. Open a terminal < ctrl + alt + T>. Change directory to the following folder: ``​cd Installs/Xilinx_ISE_DS_Lin_14.7_1015_1``
4. Terminal: Type ``sudo ./xsetup`` and press enter. This application needs to be installed with root privileges otherwise the installation will not install properly. You will be prompted for the sudo password. Enter this and press enter.
5. The ISE 14.7 Installer GUI will pop up. Click “Next” to commence with the installation process.
6. Read the Accept License Agreements (1 of 2) page and when happy tick “I accept...” and “I also accept...” for both tick boxes. Then click “Next”.
7. Read the Accept License Agreements (2 of 2) page and when happy tick “I accept...” for the tick box. Then click “Next”.
8. Select the “ISE Design Suite System Edition” radio button and select “Next”.
9. You will then be required to select which tools you want to install with the ISE Design Suite Edition. I selected “Install Cable Drivers”. The rest of the boxes were ticked, so I have decided to install the complete set of tools available. Press “Next”.
10. Select where you want to install the Vivado tool set. I am using the default ``opt/Xilinx`` folder. I have also ticked the “Import tool preferences from previous version” buttons. This is not necessary though. Press “Next”.
11. A window with the “Installation Summary” will be displayed showing what tools will be installed and where they will be stored on your drive. If you are happy press “Install”, otherwise press “Back” and edit your previous settings.
12. Wait until the Xilinx Software Install window states that the “Install Completed” and select “Finish”.
13. Open another terminal and navigate to the ``opt`` folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> Xilinx -R``
14. Terminal: Navigate to the “home” folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> .Xilinx -R``. NB: This step may not be necessary, but it will not cause an issue if you execute anyway.
15. It will be a good idea to create an ISE 14.7 startup script file on your Desktop with the following lines:
      ``` bash
      #!/bin/bash
      ./opt/Xilinx/14.7/ISE_DS/settings64.sh
      ise
      ```
      NB: Make sure the file is executable and that the nautilius documentation
      navigator is set to run the script.

16. Run the script and the ISE IDE will launch. You can now select the required Xilinx ISE project file (*.xise) and continue.
17. It is now time to install the license for ISE. Create a ``Xilinx`` folder in your home directory using the nautilius documentation navigator:
``home/<user name>/Xilinx`` and copy the ISE license file provided by your administrator to this location.
18. Load the license using the Xilinx License Configuration Manager”. Click on “Help” -> “Manage License...”. Click “Load License”. Navigate to the license file (*.lic) in the ``home/<user name>/Xilinx`` folder. Press “Open” and when the license installation was successful then press “OK”.
19. To confirm that the license file was successful, click on “Refresh” and make sure a list of Tools/IP is read back and that the license is still valid. Once this is done then close the “Xilinx License Configuration Manager” by clicking “Close”.
20. To install the USB driver please open up a terminal <ctrl+alt+T> and follow the instructions below:

      **Install the prerequisite**
      On 32-bit: 
      ```bash
      sudo apt-get install gitk git-gui libusb-dev build-essential libc6-dev fxload
      ```
      On 64-bit: 
      ```bash
      sudo apt-get install gitk git-gui libusb-dev build-essential libc6-dev-i386 fxload
      ```

      **Download the driver source and install**
      ```bash 
      cd /opt/Xilinx
      sudo git clone git://git.zerfleddert.de/usb-driver
      cd usb-driver
      ```
      On 32 bit: 
      ```bash
      sudo make
      ```
      On 64 bit: 
      ```bash
      sudo make lib32
      ```

      **Setup the driver**

      ```bash
      ./setup_pcusb /opt/Xilinx/14.7/ISE_DS/ISE/
      ```
      Wait until the driver is installed.

21. It may be a good idea to power your PC/lap top down and then up again as the USB drivers may not take affect until this happens. In my case, I plugged a stick drive into the USB and then ejected that and connected the Xilinx Platform Cable USB module. Once this was done then the status LED illuminated and I was able to configure the FPGA via JTAG.

### Tweaks for Ubuntu 16.04

The tweaks required to get 14.7 working with Ubuntu 16.04 can vary based on specific versions of libraries that are installed. However, common requirements are:

1. Change the default shell to bash: 

      Change the symbolic link sh -> dash to sh -> bash:
      ```bash
      cd /bin/
      sudo rm sh
      sudo ln -s bash sh
      ```
2. Edit the Xilinx .settings64 files, in the so that they point to the system libraries first, instead of the Xilinx ones. This will fix a conflict with 'awk'. 

      This requires moving the current LD_LIBRARY_PATH declaration from the end of the line to the start in:
      ```
      Xilinx/14.7/ISE_DS/common/.settings64.sh
      Xilinx/14.7/ISE_DS/EDK/.settings64.sh
      Xilinx/14.7/ISE_DS/ISE/.settings64.sh
      ```
      So
      ```bash
      if [ -n "$LD_LIBRARY_PATH" ]; then
            LD_LIBRARY_PATH=${XILINX_EDK}/lib/lin64:${LD_LIBRARY_PATH};export
      LD_LIBRARY_PATH;
      ```
      becomes

      ```bash
      if [ -n "$LD_LIBRARY_PATH" ]; then
            LD_LIBRARY_PATH=:${LD_LIBRARY_PATH}:${XILINX_EDK}/lib/lin64;export
      LD_LIBRARY_PATH;
      ```
3. Once changing the settings files, a default LD_LIBRARY_PATH must be created if it does not already exist. A suggested path that allows 'awk' to be processed correctly is:
      ```bash
      LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:/lib/x86_64-linux-gnu:/lib64/:/lib/
      ```

      (Some alternative methods for dealing with this can be found on the CASPER mailing list archive)

