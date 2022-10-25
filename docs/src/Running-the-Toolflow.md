# Running the Toolflow

There are a few ways of working with the Vivado-based CASPER toolflow. You can do this initially with the MATLAB GUI to compile the front end and then handle the middleware and backend generation using Python or you can run everything in Python. The former is more for design and debugging and the later stage is for the final tested and working design. This how-to will cover both methods.

## MATLAB/Python method 
There are two ways to use this method. The first is to run the command `jasper_frontend` within MATLAB and run the rest of the flow in a terminal separately. The second is to run the command `jasper` within MATLAB and have everything be done automatically in the MATLAB terminal.

### jasper_frontend:

1. In the terminal, run the following:
    ```bash
    cd /path/to/mlib_devel
    ./startsg startsg.local.xxxx
    ```
    
    This script will source all the relevant MATLAB and Xilinx paths (as specified in your `startsg.local.xxxx` file), run matlab and start Xilinx system generator. Wait until the MATLAB GUI has opened and MATLAB is ready.


2. In the MATLAB command window, type `simulink`. This will start simulink. Wait until the Simulink window has opened. 

3. In the Simulink Library Browser, click on the “open model or library” icon in the tab and select where your desired simulink file is (*.slx). There are some test files under “jasper_library/test_models”. The test model “test_snap.slx” is used for this how-to. Once the file has been selected, click “Open”. The “test_snap” design should open in the Simulink window.

4. Click the simulink design window (“test_snap”) and press `ctrl + D`. 
This will update the simulink model and check for warnings or errors. Make sure there are no errors or warnings. A window should pop up if this is the case.

5. Save the design, and then in the MATLAB command window terminal type `jasper_frontend`.
This will generate the yellow block peripheral file and run the system generator. Wait until the “XSG generation complete. Complete. Run ‘exec_flow.py -m ….” message is displayed in the MATLAB command window. 

6. In the MATLAB Command Window, cut the following text:

    ```
    python ../exec_flow.py -m … --middleware --backend --software ... 
    ``` 

    The matlab generation process is now complete and it is time to switch to Python.
 
7. Open a new terminal <CTRL+ALT+T>, and run the following:
    ```bash
    cd /path/to/mlib_devel
    source startsg startsg.local.xxxx
    ```

8. In the terminal above, paste the “python exec_flow.py….” command that was cut earlier from MATLAB. In the terminal:
    ```bash 
    python exec_flow.py -m … --middleware --backend --software
    ```

    This command will execute the middleware, which calls the yellow block constructors, creates the top.v file and generates the yaml file, which contains all the parameters needed for the backend to compile. The backend reads the yaml file and builds a list of sources, constraints, generates the constraints file and the tcl file. This tcl file is used by Vivado to compile the top.v file and all other relevant source files. This generates a bit and binary file, which is used to configure the FPGA. The software reads the binary file and generates a bof and fpg file. The arguments passed to exec_flow.py will be explained in more detail below when dealing with the Python method.

9. Using the terminal, wait until the design has finished compiling. Vivado compiles should indicate that there are no timing violations. Check the slack times for the setup and hold reports. They should not be negative. If they are then your design is not meeting timing and some changes will need to be made to your design.

10. The output directories are generated where the *.slx file sits. For example, building for `test_snap.slx` results in the following directories being generated under `/path/to/test_snap.slx`:
    * `sysgen/`: contains the system generator files,
    * `outputs/`: contains the bof and fpg files, and
    * `myproj/`: contains the Vivado projects files, source files, synth results and implementation results. The bin and bit files are also stored here. 

### jasper:

1. In the terminal, run the following:
    ```bash
    cd /path/to/mlib_devel
    ./startsg startsg.local.xxxx
    ```
2. Follow steps 2 - 4 as in the section above.

3. In the MATLAB command window terminal type `jasper`. This will run all that was described above without you needing to explictly run `exec_flow.py` yourself. All display output will be routed through the MATLAB command window, and the project and output files will still end up in the same place as above. 

## Python method 

This method allows the user to run the toolflow in a similar way as above, while also allowing for specific synthethis and implementation strategies to be selected for the compile. A breakdown of the `exec_flow` command and the arguments that are passed to it is given below:

* The `exec_flow`, which stands for “execution flow” can either run the whole flow or just parts of the flow depending on the needs of the user.
* The Vivado compile is done using project mode only.
* I have already explained the `--middleware`, `--backend` and `--software` arguments in _step 9_ above. 
* There is also a `--perfile` and `--frontend` argument, which is not needed in the MATLAB/Python method, but is required for the Python method.
* The `--perfile` and `--frontend` arguments run the yellow block peripheral file generation and the system generator compile, respectively. It is identical to running `jasper_frontend` from the command window in MATLAB - see MATLAB/Python method above. 
* Below is a list of the `exec_flow` arguments:
    - `--perfile` - Runs the front end peripheral file generation. If not specified, then it won’t generate the peripheral file.
    - `--frontend` - This compiles the front end IP, which basically runs the system generator. If not specified, then the compile will not be run.
    - `--middleware` - This runs the toolflow middle process. If not specified, then this process will not be run.
    - `--backend` - This runs the backend compilation i.e. Xilinx Vivado. If not specified, then this process will not be run.
    - `--software` - This runs the software compilation - generates a *.bof and *.fpg file. If not specified, then this process will not be run.
    - `--be` - This specifies the type of backend to be run. This is “--be vivado”, but provision has been made for other backends. If this is not specified, then the default is the Vivado backend.
    - `--jobs` - The number of processor cores to run the compile with. If this is not specified, the default is 4. You need to make sure that your processor has at least 4 threads if this is to work.
    - `--threads` - Processor threads to use for compiling - either multi or single. Default: multi e.g. "--threads single" will select single threaded compilation. This will ensure repeatable compile outputs for designs that don't change.
    - `-m` - The absolute path and filename of the *.slx file (Simulink model) to compile. If not specified, the default is “/tools/mlib_devel/jasper_library/test_models/test.slx”. I would suggest always specifying this.
    - `-c` - This is the build directory. The default is the same directory as the *.slx file (Simulink model). I don’t normally specify this.
    - `--synth_strat` - Specify a Synthesis Strategy for your compile. The options are as follows:
      * Flow_AreaOptimized_high
      * Flow_AreaOptimized_medium
      * Flow_AreaMultThresholdDSP
      * Flow_AlternateRoutability
      * FFlow_PerfOptimized_high
      * Flow_PerfThresholdCarry
      * Flow_RuntimeOptimized
    - `--impl_strat` - Specify an Implementation Strategy for your compile. The options are as follows:
      * Performance_Explore
      * Performance_ExplorePostRoutePhysOpt
      * Performance_ExploreWithRemapx
      * Performance_WLBlockPlacement
      * Performance_WLBlockPlacementFanoutOpt
      * Performance_EarlyBlockPlacement
      * Performance_NetDelay_high
      * erformance_NetDelay_low
      * Performance_Retiming
      * Performance_ExtraTimingOpt
      * Performance_RefinePlacement
      * Performance_SpreadSLLs
      * Performance_BalanceSLLs
      * Performance_BalanceSLRs
      * Performance_HighUtilSLRs
      * Congestion_SpreadLogic_high
      * Congestion_SpreadLogic_medium
      * Congestion_SpreadLogic_low
      * Congestion_SSI_SpreadLogic_high
      * Congestion_SSI_SpreadLogic_low 
      * Area_Explore
      * Area_ExploreSequential 
      * Area_ExploreWithRemap
      * Power_DefaultOpt 
      * Power_ExploreArea
      * Flow_RunPhysOpt 
      * Flow_RunPostRoutePhysOpt
      * Flow_RuntimeOptimized 
      * Flow_Quick

### Running the command
	
Some examples of how this command can be used are shown below, but please note that only a small subset of available usage options is shown:

* This will run the whole process, except will not generate a fpg and bof file for programming.
```bash 
python .../exec_flow.py -m /home/<username>/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend --middleware --backend
```

* This will run the whole process. 
```bash
python .../exec_flow.py -m /home/<username>/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend --middleware --backend --software
```

* This will run the front end peripheral file generation and IP compile process using the Vivado system generator. 
```bash
python .../exec_flow.py -m /home/<username>/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend
```

To fully set up the toolflow and run this command, open a new terminal and run the following:
```bash
cd /path/to/mlib_devel
source startsg startsg.local.xxxx
python .../exec_flow.py -m /home/<username>/mlib_devel/jasper_library/test_models/test_snap.slx --perfile --frontend --middleware --backend --software
``` 

Feel free to add or remove arguments as you wish or need. The design should run through the toolflow generation process to completion. Once complete, the Vivado compile should report any errors (e.g. timing issues - the Vivado compile will determine if timing is met or not and display this to the screen. The user will need to monitor the slack time variable to see whether or not timing has been met: if the `worst negative slack` time is negative then timing has not been met, and if the slack time is positive for both setup and hold timing then the design has met the timing requirements).

As with the first method, the output directories are generated where the *.slx file sits. This how-to uses the “test_snap.slx” test model, hence the following directories were generated under `jasper_library/test_models/test_snap/`:

    * `sysgen/`: contains the system generator files,
    * `outputs/`: contains the bof and fpg files, and
    * `myproj/`: contains the Vivado projects files, source files, synthesis results and implementation results. The bin and bit files are also stored here.
