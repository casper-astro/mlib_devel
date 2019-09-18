# Configuring the Toolflow

If you have successully installed the toolflow and its dependencies, it is now time to configure the flow to suit your specific environment.
The toolflow needs to know where dependencies like MATLAB and Xilinx tools have been installed. Other site-dependent parameters may also need to be defined.

## The `startsg` script

A startup script -- `startsg` -- is provided as part of the toolflow repository. This script can be used in two ways:

- If _executed_ (i.e. `/path/to/mlib_devel/startsg`): start MATLAB with the correctly defined library paths. 
- If _sourced_ (i.e. `source /path/to/mlib_devel/startsg`): configure software paths without starting MATLAB.

The former method is what you shoud do if you want to start a Simulink design, or open an existing one.

The latter method is useful if you want to run parts of the toolflow outside of MATLAB (eg. `exec_flow.py`) or run Xilinx tools (eg. `vivado`) directly from the command line.

### Specifying local details

The `startsg` script is generic. You should not need to modify it.
The script does not require that the Matlab and Xilinx tools be installed in specific locations, but it does require that you provide it with a few details about your local installation.  This is done by creating a `startsg.local` file that defines a few key variables needed by `startsg`.
Two essential variables are:

- `MATLAB_PATH` - the path to the directory where MATLAB was installed
- `XILINX_PATH` - the path to the directory where Xilinx tools were installed

Optional variables:

- `PLATFORM` - Used by the Xilinx tools to select suitable runtime binaries for your system.  If not specified, it will be defaulted to `lin64`, indicating a 64-bit Linux operating system. This is the only configuration the collaboration tests.
- `XILINXD_LICENCE_FILE` - The path to your Xilinx software license if it exists in a non-standard location.
- `JASPER_BACKEND` - the type of Xilinx tools you want to use to implement your design. Supported options are `vivado` or `ise`. The default is `vivado`, which is correct for all CASPER-supporterd platforms except ROACH1/ROACH2.

Other variables:
Depending on your operating system, and MATLAB / Xilinx quirks, you may need to specify other generic OS variables. For example, with MATLAB 2018a and Ubuntu 16.04, it is necessary to over-ride the default MATLAB libexpat library to a newer version. To do this you can set the `LD_PRELOAD` variable.

Here is a sample `startsg.local` file:

```bash
    export XILINX_PATH=/opt/Xilinx/Vivado/2019.1
    export MATLAB_PATH=/usr/local/MATLAB/R2018a
    export PLATFORM=lin64
    export JASPER_BACKEND=vivado
    # over-ride the MATLAB libexpat version with the OS's one.
    # Using LD_PRELOAD=${LD_PRELOAD}:"..." rather than just LD_PRELOAD="..."
    # ensures that we preserve any other settings already configured
    export LD_PRELOAD=${LD_PRELOAD}:"/usr/lib/x86_64-linux-gnu/libexpat.so"
```

Since this configuration refers to your specific installation environment, in general it shouldn't be commited to the `mlib_devel` repository. In fact, the repository is configured to ignore changes to any files wite names beginning `startsg.`.
If you really want to commit your local configuration file, you can do this, but it's helpful to call it something other than `startsg.local`, (eg. `startsg.local.example` or `startsg.local.my-server-name`) so as not to conflict with other users, all of whom will have similar files with different contents.

### Using `startsg`
By default, executing (or sourcing) the `startsg` script will use variables defined in the configuration file `startsg.local` residing in the same directory as `startsg`.
However, you can uswe a specific configuration by specifying one as an argument to `startsg`.
This can be useful if you want to store configurations for multiple versions of MATLAB / Xilinx tools.

For example:
```bash
    $ ./startsg                       # Uses startsg.local if one exists in the current directory

    $ ./mlib_devel/startsg            # Uses startsg.local if one exists in ./mlib_devel/
  
    $ ./startsg startsg.local.use_vivado_2016  # Uses the startsg.local.use_vivado_16 configuration file
```

### Symlink for convenience

Running `startsg` from the `mlib_devel` directory (where it lives) will start MATLAB with `mlib_devel` as the current directory.
Hopefully you store your models somewhere outside `mlib_devel` (which should contain only the CASPER _libraries_), in which case after running `startsg` you will need to navigate within MATLAB to the directory where your model files live.
To avoid this minor annoyance, you can create a symbolic link to `startsg` in your application directory (i.e.  where your model file lives).  When running `startsg` via this symlink, MATLAB will start up with your application directory as the current directory and also run the optional `casper_startup.m` file if one exists.

To configure such a symlink you should run

```bash
# Go to the directory you store your models in.
# You should place a startsg.local file here.
cd /directory/where/my/models/are
# Create the symbolic link
ln -s /directory/where/mlib_devel/is/startsg startsg
# Run startsg from your model directory
./startsg my.startsg.local
```

This model of operating works particularly well when using [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to store a copy of `mlib_devel` alongside your models. Using submodules in this way ensures that whoever downloads your models can also easily obtain the version of `mlib_devel` they were originally compiled against.

In this case, your directory structure will look something like:

```
my_spectrometer/
├── my_spectrometer.slx
├── startsg.local
├── startsg (symlink -> ./mlib_devel/startsg)
└── mlib_devel (submodule)
    ├── startsg
    ├── casper_library
    ├── ...
    ├── ...
    └── ...
```
