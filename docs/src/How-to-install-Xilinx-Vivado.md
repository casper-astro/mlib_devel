# How to install Xilinx Vivado

This section explains How To install Vivado 2016.2, 2016.4 and 2018.2.

## How to Install 2016.x

1. OS Required/suggested: Ubuntu 14.04 LTS, Ubuntu 16.04 LTS (with tweaks) and Red Hat 6.6 (Santiago). There was an issue using Ubuntu 12.04 LTS, which caused the DocNav utility to crash.
2. Click/double click on the ``Xilinx_Vivado_SDK_2016.2_0605_1.tar.gz`` file in the Ubuntu Nautilius document navigator and choose a folder to extract the files to. I use “home/Installs`` in this document. If you use something different then remember to replace “Installs” with your directory name.
3. Ubuntu 14.04. Open a terminal < ctrl + alt + T>. Change directory to
the following folder: ``​cd Installs/Xilinx_Vivado_SDK_2016.2_0605_1``
4. Terminal: Type ``sudo ./xsetup`` and press enter. This application needs to be installed with root privileges otherwise the installation will not install properly. You will be prompted for the sudo password. Enter this and press enter.
5. The Vivado Installer GUI will pop up. The GUI might explain that there is a new version available, but ignore that and press “Continue” and then “Next” to commence with the installation process.
6. Read the terms and conditions page and when happy tick “I agree” for all three tick boxes. Then click “Next”.
7. Select the “Vivado HL_System Edition” radio button and select “Next”.
8. You will then be required to select which tools you want to install with the Vivado Design Edition. I selected “Software Development Kit”, “Ultrascale+” and “Zynq UltraScale + MPSoC”. The rest of the boxes were ticked (except Cable Drivers),so I have decided to install the complete set of tools available. Make sure that “DocNav” is ticked if you want access to the documentation that Xilinx has provided. This
is highly recommended, as the documentation is part of the Ultrafast design methodology. Press “Next”.
9. Select where you want to install the Vivado tool set. I am using the default ``opt/Xilinx`` folder. I have also ticked the “Create program group entries” and “create desktop shortcuts” buttons. This is not necessary though. Press “Next”.
10. A window will pop up offering to create the ``opt/Xilinx`` directory if it does not exist. Select “Yes”.
11. A window with the “Installation Summary” will be displayed showing what tools will be installed and where they will be stored on your drive. If you are happy press “Install”, otherwise press “Back” and edit your previous settings.
12. Wait until the Xilinx Software Install window states that the “Installation completed successfully” and select “OK”.
13. Open another terminal and navigate to the `opt/` folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> Xilinx -R``
14. Terminal: Navigate to the ``home`` folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> .Xilinx -R``
15. DocNav will not work unless you follow the steps highlighted in the text file: [set_up_vivado_2015.1_on_ubuntu_14.04](https://drive.google.com/file/d/0B2dCFqGD5y-8amdKbWZBM18yTEE/view?usp=sharing) (Doc Nav section only). Install the i386 architecture and then install the missing libraries. All the commands are highlighted in the attached file.
16. DocNav will now open, but you won’t be able to open the documentation until you have made the following link. Using the terminal type in ``​cd /opt/Xilinx/Vivado/2016.2/ids_lite/ISE/lib/lin64`` and press enter.
17. Using the terminal, type in ``​mv libstdc++.so.6 libstdc++.so.6bu`` and press enter. Now type in ``​ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ./libstdc++.so.6`` and pressenter. The ``libstdc++.so.6`` file will now be properly linked and DocNav should work.
18. It will be a good idea to create a vivado startup script file on your Desktop with the following lines:
    ```bash
    #!/bin/bash
    cd /opt/Xilinx/Vivado/2016.2/bin/
    ./vivado
    ```
    NB: Make sure the file is executable and that the nautilius documentation
    navigator is set to run the script.
19. Run the script and the Vivado IDE will launch. You can now select the required Xilinx Vivado project file (*.xpr) and continue.
20. It is now time to install the license for Vivado. Create a ``Xilinx`` folder in your home directory using the nautilius documentation navigator: ``home/<user name>/Xilinx`` and copy the vivado license file provided by your administrator to this location.
21. Load the license using the Vivado License Manager”. If not already open click on “Help” -> “Manage License...”. Click “Load License” and then click on “Copy License...”. Navigate to the license file (*.lic) in the ``home/<user name>/Xilinx`` folder. Press “Open” and when the license installation was successful then press “OK”.
22. To confirm that the license file was successful, click on “View License Status” and make sure a list of Tools/IP is read back and that the license is still valid. Once this is done then close the “Vivado License Manager” by clicking on the red cross at the top left of the window. You will be prompted if you want to close the “Vivado License Manager”. Click “Yes”.

## Optional: Install USB Drivers for JTAG

The most reliable way to install the JTAG cable drivers is to use the drivers provided with ISE.

A folder containing all the files required has been uploaded in the same folder as this document: [linux_jtag_cable_drivers.tar.gz](https://drive.google.com/file/d/0Byu0Sq2IEDuJdVFMMkNLN2pxYnc/view?usp=sharing). This also includes a useful installation script that prepares the files and places them in the correct directories.

Instructions:
* Extract the contents of the file linux_jtag_cable_drivers.tar.gz 
* Run: ``sudo ./install.sh`` (NB!: Must run as sudo)

It may be a good idea to power your PC/lap top down and then up again as the USB drivers may not take affect until this happens. In my case, I plugged a stick drive into the USB and then ejected that and connected the Xilinx Platform Cable USB module. Once this was done then the status LED illuminated and I was able to configure the FPGA via JTAG.

## How to Install 2018.x

1. OS Required/suggested: Ubuntu 16.04 LTS.
2. Click/double click on the ``Xilinx_Vivado_SDK_2018.2_0614_1954.tar.gz`` file in the Ubuntu Nautilius document navigator and choose a folder to extract the files to. I use “home/Installs`` in this document. If you use something different then remember to replace “Installs” with your directory name.
3. Ubuntu 16.04. Open a terminal < ctrl + alt + T>. Change directory to
the following folder: ``​cd Installs/Xilinx_Vivado_SDK_2018.2_0614_1954``
4. Terminal: Type ``sudo ./xsetup`` and press enter. This application needs to be installed with root privileges otherwise the installation will not install properly. You will be prompted for the sudo password. Enter this and press enter.
5. The Vivado Installer GUI will pop up. The GUI might explain that there is a new version available, but ignore that and press “Continue” and then “Next” to commence with the installation process.
6. Read the terms and conditions page and when happy tick “I agree” for all three tick boxes. Then click “Next”.
7. Select the “Vivado HL_System Edition” radio button and select “Next”.
8. You will then be required to select which tools you want to install with the Vivado Design Edition. I selected “Software Development Kit”, “Ultrascale+” and “Zynq UltraScale+ MPSoC”. The rest of the boxes were ticked (except Cable Drivers), so I have decided to install the complete set of tools available. Make sure that “DocNav” is ticked if you want access to the documentation that Xilinx has provided. This
is highly recommended, as the documentation is part of the Ultrafast design methodology. Press “Next”.
9. Select where you want to install the Vivado toolset. I am using the default ``opt/Xilinx`` folder. I have also ticked the “Create program group entries” and “create desktop shortcuts” buttons. This is not necessary though. Press “Next”.
10. A window will pop up offering to create the ``opt/Xilinx`` directory if it does not exist. Select “Yes”.
11. A window with the “Installation Summary” will be displayed showing what tools will be installed and where they will be stored on your drive. If you are happy press “Install”, otherwise press “Back” and edit your previous settings.
12. Wait until the Xilinx Software Install window states that the “Installation completed successfully” and select “OK”.
13. Open another terminal and navigate to the `opt/` folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> Xilinx -R``
14. Terminal: Navigate to the ``home`` folder and remember to change user and group to your username with the following command: ``​sudo chown <username>:<username> .Xilinx -R``
15. If DocNav does not work, then try follow the steps highlighted in the text file: [set_up_vivado_2015.1_on_ubuntu_14.04](https://drive.google.com/file/d/0B2dCFqGD5y-8amdKbWZBM18yTEE/view?usp=sharing) (Doc Nav section only). Install the i386 architecture and then install the missing libraries. All the commands are highlighted in the attached file.
16. DocNav may open, but it is possible you won’t be able to read the documentation until you have made the following link - first try and read the documentation via DocNav though. Using the terminal type in ``​cd /opt/Xilinx/Vivado/2016.2/ids_lite/ISE/lib/lin64`` and press enter.
17. If you still can't access the documentation via DocNav: Using the terminal, type in ``​mv libstdc++.so.6 libstdc++.so.6bu`` and press enter. Now type in ``​ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ./libstdc++.so.6`` and pressenter. The ``libstdc++.so.6`` file will now be properly linked and DocNav should work.
18. It will be a good idea to create a vivado startup script file on your Desktop with the following lines:
    ```bash
    #!/bin/bash
    cd /opt/Xilinx/Vivado/2018.2/bin/
    ./vivado
    ```
    NB: Make sure the file is executable and that the nautilius documentation
    navigator is set to run the script.
19. Run the script and the Vivado IDE will launch. You can now select the required Xilinx Vivado project file (*.xpr) and continue.
20. It is now time to install the license for Vivado. Create a ``Xilinx`` folder in your home directory using the nautilius documentation navigator: ``home/<user name>/Xilinx`` and copy the vivado license file provided by your administrator to this location.
21. Load the license using the Vivado License Manager”. If not already open click on “Help” -> “Manage License...”. Click “Load License” and then click on “Copy License...”. Navigate to the license file (*.lic) in the ``home/<user name>/Xilinx`` folder. Press “Open” and when the license installation was successful then press “OK”.
22. To confirm that the license file was successful, click on “View License Status” and make sure a list of Tools/IP is read back and that the license is still valid. Once this is done then close the “Vivado License Manager” by clicking on the red cross at the top left of the window. You will be prompted if you want to close the “Vivado License Manager”. Click “Yes”.

## Optional: Install USB Drivers for JTAG

A folder containing all the files required has been uploaded in the same folder as this document: [linux_jtag_cable_drivers.tar.gz](https://drive.google.com/file/d/0Byu0Sq2IEDuJdVFMMkNLN2pxYnc/view?usp=sharing). This also includes a useful installation script that prepares the files and places them in the correct directories.

Instructions:
* Extract the contents of the file linux_jtag_cable_drivers.tar.gz 
* Run: ``sudo ./install.sh`` (NB!: Must run as sudo)

It may be a good idea to power your PC/lap top down and then up again as the USB drivers may not take affect until this happens. In my case, I plugged a stick drive into the USB and then ejected that and connected the Xilinx Platform Cable USB module. Once this was done then the status LED illuminated and I was able to configure the FPGA via JTAG.