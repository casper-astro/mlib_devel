# Setting up the toolflow

This page explains how to install the CASPER tools and what supporting software is required to run them.

## Getting the right tools for your hardware
The CASPER tools have changed significantly to support Xilinx series 7 (and later) FPGAs. For these boards -- i.e. any FPGA platform based on a 7-series, UltraScale, or Ultrascale+ board -- you should follow the latest instructions in this guide for the _Vivado-based_ flow.
For earlier platforms, which include ROACH1 and ROACH2, you should follow instructions for the _ISE-based_ flow.

## Required 3rd Party Tools

**Operating System**
We suggest Ubuntu 14.04 LTS, Ubuntu 16.04 LTS (with tweaks to the system) or Red Hat Enterprise 6.6 (Santiago). Other operating systems are viable, but proceed at your own risk!

**MATLAB**
The tools currently support MATLAB 2016b, and the corresponding version of Simulink. You will need to obtain this software, and corresponding licenses either direct from MathWorks or from your institution. For MATLAB install instructions, refer to [How to install Matlab.](How-to-install-Matlab.html)

**Xilinx ISE/Vivado**
For _Vivado-based_ flows, you need to install Xilinx Vivado. Currently we support version 2016.4. These are available from <xilinx.com> and will require a license. If you are part of an academic institution, you may be eligible for free licenses via the [Xilinx University Program](https://www.xilinx.com/support/university.html). For Xilinx ISE or Vivado install instructions, refer to [How to install Xilinx ISE](How-to-install-Xilinx-ISE.html) or [How to install Xilinx Vivado.](How-to-install-Xilinx-Vivado.html)

For _ISE-based_ flows, you need to install Xilinx ISE 14.7. Again, this is available from <xilinx.com>, and academic institutions may be eligible for free licenses via the [Xilinx University Program](https://www.xilinx.com/support/university.html).

**Python**
The toolflow requires Python 2.7. If you don't have it already you can install it in Ubuntu environments by opening a terminal <ctrl +alt + T> and running the command `sudo apt-get install python`.

You'll also need the [PyYAML](https://pypi.python.org/pypi/PyYAML) package. You can download this and install this directly from source, or use a Python package manager, for example, [pip](https://pypi.python.org/pypi/pip). To install pip, from a terminal, run `sudo apt-get install python-pip`.

Once you have pip installed, you can install pyyaml by running the command `sudo pip install pyyaml` in a terminal.

## Obtaining the Toolflow

The CASPER toolflow resides in this repository. You can download a copy of it to your local machine with the command `git clone https://github.com/casper-astro/mlib_devel.git`. This will leave you on the master branch. If you wish to select another branch (for example, the `roach2` branch) you can do this by first going in to the newly-cloned repository (`cd mlib_devel`) and then switching branches with `git checkout -b roach2 origin/roach2`. You can always see what remote branches are available (i.e., which branches are in the casper-astro github repository) by running `git branch -r` in your local "mlib_devel" folder.

Using the terminal, type the following:
`git status` in the "mlib_devel" folder. 
This should indicate that the master branch has been selected.

## Configuring the Toolflow

It is now time to setup the Xilinx, Matlab and work paths to suit your directory setup. This tells the toolflow where you have installed MATLAB and Xilinx tools, so that it can find and run them. The configuration will depend on the options you selected when you installed these tools.
Using the terminal, go to the "mlib_devel" directory and read the `README.startsg` file, which will explain what 'startsg' and 'startsg.local' does and how to set it up. Now copy 'startsg.local.example' to 'startsg.local' and add the correct path to the following parameters in 'startsg.local': `XILINX_PATH` (path to your Xilinx script), `MATLAB_PATH` (path to your Matlab script), `PLATFORM` (this is set to `lin64` for a 64 bit Linux system) and `JASPER_BACKEND` (this is set to `vivado` by default, but can also be `ise`). Remember to save the file. NB: Please do not commit or push these file changes to the git repo, as this file will constantly change from one user to the next. In fact, the repository has been explicitly configured to ignore changes to the `startsg.local` file -- you shouldn't change this behaviour!

## Running the Toolflow

1) There are two ways of working with the [new, Vivado-based] CASPER toolflow. You can do this initially with the MATLAB GUI to compile the front end and then handle the middleware and backend generation using Python or you can run everything in Python. The former stage is more for design and debugging (steps 2-11) and the later stage (steps 12-15) is for the final tested and working design. This How To will cover both methods.

2) **Matlab/Python method:** Using the terminal, type the following under "mlib_devel": 
`./startsg` 
It is currently not possible to compile for Altera or Lattice FPGAs. This script will source all the relevant   Matlab and Xilinx paths, run matlab and start the system generator. Wait until the Matlab GUI has opened and Matlab is ready.

3) **Matlab/Python method:** In the Matlab command window, type the following: 
`simulink`. 
This will start simulink. Wait until the Simulink window has opened.

4) **Matlab/Python method:** In the Simulink Library Browser, click on the “open model or library” icon in the tab and select where your desired simulink file is (*.slx). There are some test files under “jasper_library/test_models”. I use “test_snap.slx” for this How To. Once the file has been selected, click “Open”. The “test_snap” design should open in the Simulink window.

5) **Matlab/Python method:** Click the simulink design window (“test_snap”) and press the following:
“Ctrl + D”. 
This will update the simulink model and check for warnings or errors. Make sure there are no errors or warnings. A window should pop up if this is the case.

6) **Matlab/Python method:** In the Matlab command window terminal, type the following:
`jasper_frontend`. 
This will generate the yellow block peripheral file and run the system generator. Wait until the “XSG generation complete. Complete. Run ‘exec_flow.py -m ….” message is displayed. 

7) **Matlab/Python method:** In the Matlab Command Window, cut the following text from it:
`python ../exec_flow.py -m … --middleware --backend --software ... `. The matlab generation process is now complete and now it is time to switch to Python.
 
8) **Matlab/Python method:** Open a new terminal <CTRL+ALT+T>, and source the following files from the "mlib_devel" directory:
`startsg`
This is an important step, because the Xilinx and Matlab paths will not be specified properly and “exec_flow.py” will fail to run if this is not done.

9) **Matlab/Python method:** Using the terminal, paste the “python exec_flow.py….” command that was cut earlier from Matlab, in the terminal: 
`python exec_flow.py -m … --middleware --backend --software`.
This command will execute the middleware, which calls the yellow block constructors, creates the top.v file and generates the yaml file, which contains all the parameters needed for the backend to compile. The backend reads the yaml file and builds a list of sources, constraints, generates the constraints file and the tcl file. This tcl file is used by Vivado or ISE to compile the top.v file and all other relevant source files. This generates a bit and binary file, which is used to configure the FPGA. The software reads the binary file and generates a bof and fpg file. The arguments passed to exec_flow.py will be explained in more detail below when dealing with the Python method.

10) **Matlab/Python method:** Using the terminal, wait until the design has finished compiling. Vivado compiles should indicate that there are no timing violations. Check the slack times for the setup and hold reports. They should not be negative. If they are then your design is not meeting timing and some changes will need to be made to your design.

11) **Matlab/Python method:** The output directories are generated where the *.slx file sits. In my case, because I was using “test_snap.slx”, the directories were generated under “jasper_library/test_models/test_snap”. The following directories were created under “test_snap” and should be the same as yours: “sysgen” (contains the system generator files), “outputs” (contains the bof and fpg files) and “myproj” (contains the Vivado projects files, source files, synth results and implementation results. The bin and bit files are also stored here). 

    **NB:** Instead of running “jasper_frontend” from the Matlab command window, you can run “jasper”, which will do all the above steps from 6) to now, but all display output will be routed through the Matlab Command window.   

12) **Python method:** Before I explain this method it is important to explain how the “exec_flow” command works and the arguments that are passed to it. The “exec_flow”, which stands for “execution flow” can either run the whole flow or just parts of the flow depending on the needs of the user. The Vivado compile is done using project mode only. I have already explained the `--middleware`, `--backend` and `--software` arguments in step 9) above. There is also a `--perfile` and `--frontend` argument, which is not needed in the Matlab/Python method, but is required for the Python method. The `--perfile` and `--frontend` arguments run the yellow block peripheral file generation and the system generator compile, respectively. It is identical to running “jasper_frontend” from the command window in Matlab - see Matlab/Python method above. Below is a list of the “exec_flow” arguments.
    * `--perfile`. Runs the front end peripheral file generation. If not specified, then it won’t generate the peripheral file.
    * `--frontend`. This compiles the front end IP, which basically runs the system generator. If not specified, then the compile will not be run.
    * `--middleware`. This runs the tool flow middle process. If not specified, then this process will not be run.
    * `--backend`. This runs the backend compilation i.e. Xilinx Vivado or ISE. If not specified, then this process will not be run.
    * `--software`. This runs the software compilation - generates a *.bof and *.fpg file. If not specified, then this process will not be run.
    * `--be`. This specifies the type of backend to be run. This is “--be vivado”, but provision has been made for other backends. If this is not specified, then the d default is the Vivado backend.
    * `--jobs`. The number of processor cores to run the compile with. If this is not specified, the default is 4. You need to make sure that your processor has at least 4 threads if this is to work.
    * `-m`. The absolute path and filename of the *.slx file (Simulink model) to compile. If not specified, the default is “/tools/mlib_devel/jasper_library/test_models/test.slx”. I would suggest always specifying this.
    * `-c`. This is the build directory. The default is the same directory as the *.slx file (Simulink model). I don’t normally specify this.

    Here are some examples of how to run the command:

    This will run the whole process, except will not generate a fpg and bof file for programming.
    ```bash 
    python …/exec_flow.py -m /home/<username>/work/git_work/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend --middleware --backend
    ```

    This will run the whole process. 
    ```bash
    python .../exec_flow.py -m /home/<username>/work/git_work/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend --middleware --backend --software
    ```

    This will run the front end peripheral file generation and IP compile process using the Vivado system generator. 
    ```bash
    python .../exec_flow.py -m /home/<username>/work/git_work/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend
    ```

13) **Python method:** Open a new terminal <CTRL+ALT+T>, and source the following files from the “mlib_devel” directory:
`source startsg startsg.local`
This is an important step, because the Xilinx and Matlab paths will not be specified properly and “exec_flow.py” will fail to run.

14) **Python method:** Using the terminal, run the complete “exec_flow” command:
    ```bash
    python .../exec_flow.py -m /home/<username>/work/git_work/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend --middleware --backend --software
    ``` 
    Feel free to add or remove arguments as you wish or need. The design should run through the whole tool flow generation process and when complete the Vivado compile will of completed without any errors and with a little luck there will be no timing issues. The Vivado compile will determine if timing is met or not and display this to the screen. The user will need to monitor the slack time variable to see whether the compile has met timing or not. If the slack time is negative then timing is not met and if the slack time is positive for both setup and hold timing then the design has met the timing requirements.

15) **Python method:** The output directories are generated where the *.slx file sits. In my case, because I was using “test_snap.slx”, the directories were generated under “jasper_library/test_models/test_snap”. The following directories were created under “test_snap” and should be the same as yours: “sysgen” (contains the system generator files), “outputs” (contains the bof and fpg files) and “myproj” (contains the Vivado projects files, source files, synth results and implementation results. The bin and bit files are also stored here). The Vivado project mode creates synthesis and implementation run folders with a project file under “myproj”.