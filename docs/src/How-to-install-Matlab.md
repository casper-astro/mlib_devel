# How to install Matlab 

This section explains How To install Matlab R2013b and R2016b.

## How to Install R2013b

1. OS Required/suggested: Ubuntu 14.04 LTS
2. Ubuntu 14.04. Using Nautilius, click on R2013b_UNIX.iso and extract to “Installs/Matlab2013b”.
3. Ubuntu 14.04. Open a terminal < ctrl + alt + T>. You will need to install the JRE (Java Runtime Environment) if you don’t have it. Type `​sudo apt-get install openjdk-7-jre` at the prompt and press enter.
4. Terminal: You will now need to backup file “libstdc++.so.6” and link to file “libstdc++.so.6.0.13”. Type in `​cd ~/Installs/Matlab2013b/bin/glnxa64` and press enter.
5. Terminal: Type `sudo mv libstdc++.so.6 libstdc++.so.6_bu` and enter. The file should now be backed up.
6. Terminal: Type `sudo ln -s libstdc++.so.6.0.13 libstdc++.so.6` and press enter. The file should now be linked.
7. Terminal: set the matlab environment variable to call java 7. Type `​export MATLAB_JAVA=”/usr/lib/jvm/java-7-openjdk-amd64/jre` and press enter. Type `​echo $MATLAB_JAVA` to make sure the new path is set.
8. Terminal: Make sure the java is executable. Type `​cd ~/Installs/Matlab2013b` and press enter. Type `​chmod +x sys/java/jre/glnxa64/jre/bin/java` and press enter.
9. Terminal: You will now need to invoke the installer. Type `​sudo ./install -javadir /usr/lib/jvm/java-7-openjdk-amd64/jre` at the prompt and press enter.
10. The MathWorks Installer GUI should pop up. Select “Install without using the Internet” and select “Next”.
11. You will be requested to sign the “License Agreement” page. Click “Yes” and then click “Next”.
12. You will be requested to fill in the file installation key for your license. The Matlab Administrator should of provided a license and file installation key. If not, make sure you get one from him/her. Type in the file installation key and press “Next”. I choose to install my license file under “~/Matlab”.
13. You will then be requested for the “Installation Type”. Click on the “Typical” radio button and press “Next”.
14. You will then need to specify the installation folder. I choose “/opt/Matlab/R2013b”. Press “Next”. If the folder does not exist then click “Yes” to create it.
15. You will then be required to confirm your installation settings. If happy then press “Install” else press “Back” and then return to this step when happy.
16. You will be informed that your installation may require additional configuration skips. This can be ignored. Click “Next”.
17. You will be informed that the installation is complete. Make sure Activate Matlab is ticked and click “Next”.
18. It is now time to Activate MathWorks Software. A “MathWorks Software Activation” window will pop up. Click on the “Activate manually without the internet” and press “Next”.
19. Click on the “Enter the full path to your license file, including the file name:” and browse to the license file (*.lic) and click “Select”. Then press “Next”. If all goes well then you will receive a message that says “Activation is complete.”. Click “Finish”.
20. Open another terminal and navigate to the “opt” folder and remember to change user and group to your username with the following command: `sudo chown <username>:<username> Matlab -R`
21. Terminal: Navigate to the “home” folder and remember to change user and group to your username with the following command: `sudo chown <username>:<username> .matlab -R`
22. It will be a good idea to create an Matlab R2013b startup script file on your Desktop with the following lines:
```bash
#!/bin/bash
cd /opt/Matlab/R2013b/bin/
./matlab
```
    NB: Make sure the file is executable and that the nautilius documentation
    navigator is set to run the script.

23. Run the script and the Matlab IDE will launch. You can now select the required Matlab m files (*.m) and continue.
24. In order to run Matlab with the Casper tools please look at the CASPER wiki page: https://casper.berkeley.edu/wiki/MSSGE_Setup_with_Xilinx_14.x_and_Matlab_2012b

## How To Install R2016b

1. OS Required/suggested: Ubuntu 14.04 LTS, Ubuntu 16.04 LTS (with tweaks), Red Hat 6.6 (Santiago).
2. Ubuntu 14.04. Using Nautilius, click on “R2016b_glnxa64_dvd1.iso” and extract to “Installs/Matlab2016b”.
3. Ubuntu 14.04. Open a terminal < ctrl + alt + T> and type `cd ~/Installs` and then type `chmod +w Matlab2016b/ -R`. This will give all the files in the Matlab2016b folder write access.
4. Ubuntu 14.04. Using Nautilius, click on “R2016b_glnxa64_dvd2.iso” and extract to “Installs/Matlab2016b”.
5. Open a terminal <ctrl + alt + T> and type `cd ​ ~/Installs/Matlab2016b/`,then `sudo ./install` and enter.
6. The MathWorks Installer GUI should pop up. Select “Use a File Installation Key” and select “Next”.
7. You will be requested to sign the “License Agreement” page. Click “Yes” and then click “Next”.
8. You will be requested to fill in the file installation key for your license. The Matlab Administrator should of provided a license and file installation key. If not, make sure you get one from him. Type in the file installation key and press “Next”. I choose to install my license file under “~/Matlab”.
9. You will then need to specify the installation folder. I choose “/opt/Matlab/R2016b”. Press “Select” and then “Next”.
10. You will then see a “Product Selection” window. Make sure that all products are ticked and select “Next”.
11. You must then decide where you want the symbolic links to your Matlab scripts to be stored. I chose the default location “/usr/local/bin”.
12. You will then be required to confirm your installation settings. If happy then press “Install” else press “Back” and then return to this step when happy.
13. You will be informed that your installation may require additional configuration skips. This can be ignored. Click “Next”.
14. You will be informed that the installation is complete. Make sure Activate Matlab is ticked and click “Next”.
15. It is now time to Activate MathWorks Software. A “MathWorks Software Activation” window will pop up. Click on the “Activate manually without the internet” and press “Next”.
16. Click on the “Enter the full path to your license file, including the file name:” and browse to the license file (*.lic) and click “Select”. Then press “Next”. If all goes well then you will receive a message that says “Activation is complete.”. Click “Finish”.
17. Open another terminal and navigate to the “opt” folder and remember to change user and group to your username with the following command: `​sudo chown <username>:<username> Matlab -R`
18. Terminal: Navigate to the “home” folder and remember to change user and group to your username with the following command: `sudo chown <username>:<username> .matlab -R`
19. It will be a good idea to create an Matlab R2016b startup script file on your Desktop with the following lines:
```bash
#!/bin/bash
cd /opt/Matlab/R2016b/bin/
./matlab
```
NB: Make sure the file is executable and that the nautilius documentation navigator is set to run the script.

20. Run the script and the Matlab IDE will launch. You can now select the required Matlab m files (*.m) and continue.
21. In order to run Matlab with the Casper tools please look at the CASPER read the docs page: https://casper-toolflow.readthedocs.io/en/latest/jasper_documentation.html.
## How To Install R2018a

1. OS Required/suggested: Ubuntu 14.04 LTS/Ubuntu 16.04 LTS.
2. Ubuntu 16.04. Using Nautilius, click on “R2018a_glnxa64_dvd1.iso” and extract to “Installs/Matlab2018a”.
3. Ubuntu 16.04. Open a terminal < ctrl + alt + T> and type `cd ~/Installs` and then type `chmod +w Matlab2018a/ -R`. This will give all the files in the Matlab2018a folder write access.
4. Ubuntu 16.04. Using Nautilius, click on “R2018a_glnxa64_dvd2.iso” and extract to “Installs/Matlab2018a”.
5. Open a terminal <ctrl + alt + T> and type `cd ​ ~/Installs/Matlab2018a/`,then `sudo ./install` and enter.
6. The MathWorks Installer GUI should pop up. Select “Use a File Installation Key” and select “Next”.
7. You will be requested to sign the “License Agreement” page. Click “Yes” and then click “Next”.
8. You will be requested to fill in the file installation key for your license. The Matlab Administrator should of provided a license and file installation key. If not, make sure you get one from him. Type in the file installation key and press “Next”. I choose to install my license file under “~/Matlab”.
9. You will then need to specify the installation folder. I choose “/opt/Matlab/R2018a”. Press “Select” and then “Next”.
10. You will then see a “Product Selection” window. Make sure that all products are ticked and select “Next”.
11. You must then decide where you want the symbolic links to your Matlab scripts to be stored. I chose the default location “/usr/local/bin”.
12. You will then be required to confirm your installation settings. If happy then press “Install” else press “Back” and then return to this step when happy.
13. You will be informed that your installation may require additional configuration skips. This can be ignored. Click “Next”.
14. You will be informed that the installation is complete. Make sure Activate Matlab is ticked and click “Next”.
15. It is now time to Activate MathWorks Software. A “MathWorks Software Activation” window will pop up. Click on the “Activate manually without the internet” and press “Next”.
16. Click on the “Enter the full path to your license file, including the file name:” and browse to the license file (*.lic) and click “Select”. Then press “Next”. If all goes well then you will receive a message that says “Activation is complete.”. Click “Finish”.
17. Open another terminal and navigate to the “opt” folder and remember to change user and group to your username with the following command: `​sudo chown <username>:<username> Matlab -R`
18. Terminal: Navigate to the “home” folder and remember to change user and group to your username with the following command: `sudo chown <username>:<username> .matlab -R`
19. It will be a good idea to create an Matlab R2016b startup script file on your Desktop with the following lines:
```bash
#!/bin/bash
cd /opt/Matlab/R2018a/bin/
./matlab
```
NB: Make sure the file is executable and that the nautilius documentation navigator is set to run the script.

20. Run the script and the Matlab IDE will launch. You can now select the required Matlab m files (*.m) and continue.
21. Install the R2018a update pack: "r2018a-update-6.tar.gz" by unpacking the tar.gz file and following the install instructions "r2018a-updates-install-instructions.pdf" for linux.
22. In order to run Matlab with the Casper tools please look at the CASPER read the docs page: https://casper-toolflow.readthedocs.io/en/latest/jasper_documentation.html.