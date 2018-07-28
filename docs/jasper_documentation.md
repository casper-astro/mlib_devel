# The CASPER Toolflow

The current Python-based CASPER toolflow (sometimes called *jasper*, to distinguish it from the MATLAB-based flow which supported ROACH2 and earlier platforms) was designed to enable users to quickly and effectively turn high-level DSP designs into FPGA bitcode, without having to worry about low-level implementation details.

While the ultimate goal of the toolflow is to support (or at least not prohibit) a wide range of mechanisms to input DSP designs, and be agnostic about the target FPGA's vendor, in practice the toolflow pipeline is as follows:

- A user specifies a DSP design using MATLAB's graphical programming tool, `Simulink`.
- I/O to/from the DSP pipelines are specified using CASPER's `xps_library` Simulink blocks.
- DSP functionality is specified using CASPER's `casper_library` Simulink blocks.
- A user invokes the CASPER toolflow, which generates a Vivado project, complete with appropriate infrastructure and constraints to support the user's I/O requirements.
- Vivado compiles the toolflow-supplied project into a bitstream.
- The toolflow appends meta-data to this bitstream, describing and run-time, software-accessible, components in the firmware design.
- The bitstream and meta-data are delivered to the user in the form of a `.fpg` file.
- This file is programmed on to a compatible board using the `casperfpga` Python library.
- `casperfpga` provides Python methods for interacting with a running board (configuring registers, etc.)

## Goals of the CASPER Toolflow
The ultimate goal of the tooflow is simple: make FPGA programming easy, so researchers (largely radio astronomers) can quickly develop and deploy instrumentation to meet their scientific requirements.
More concretely, the CASPER toolflow aims to:
- Make complex interfaces (1/10/40/100 Gb Ethernet, SRAM, DRAM, ADCs, DACs, etc.) available as sources and sinks in a DSP design without requiring knowledge of their low-level implementation.
- Facilitate easy porting of designs between FPGA platforms, by abstraction of these underlying interfaces.
- Provide a straight-forward integration with control and monitoring software.

While the *jasper* toolflow described in this documentation is (relatively) new, it builds on CASPER's original MATLAB-based flow, which was designed over a decade ago, and has quietly powered [many scientific instruments over its lifetime.](https://arxiv.org/abs/1611.01826)

## Toolflow Terminology

When discussing the CASPER toolflow, it helps to first define some terminology commonly used in the collaboration.

**Frontend**
: The part of the CASPER software stack used for design-entry. In practice, this means *Simulink*, though there are perpetual aspirations to support other entry methods, particularly non-graphical ones.

**Backend**
: The vendor-specific part of the CASPER software stack used to compile a toolflow-generated project. In practice, this means *Xilinx Vivado*, but could also in principle be *ISE* or *Altera Quartus*.

**Middleware / Toolflow-proper**
: The Python-based part of the CASPER software stack used to turn the design information entered into the *Frontend* into a complete specification for a *Backend* compile.

**Yellow Blocks**
: Interface blocks (ADCs/DACs/Ethernet/Memory) which are used by the *Frontend* to give the user access to a platform's peripherals. Yellow Blocks in the Frontend are supported by Python classes in the toolflow middleware. These classes ultimately determine what source files, constraints, and HDL incantations are required to instantiate a *Yellow Block* in hardware.

**Platform YAML**
: A [YAML](http://yaml.org/) file defining the physical properties of an FPGA hardware platform.

**jasper.per**
: A [YAML](http://yaml.org/) file output by the toolflow *Frontend* which specifies what was designed by the user. In principle, any tool which can generate such a file is a viable toolflow Frontend candidate.

**castro**
: A well-meaning attempt to provide an abstract, well-defined, platform-independent interface between the tooflow *Middleware* and the platform-/vendor-specific *Backend*. This interface is a Python `Castro` object, dumped as a [YAML](http://yaml.org/) file! In practice, developers have subverted the original definitions of the `Castro` class to make it easier to get platform-specific data between stages of the toolflow, and somewhat undermined its purpose. 


## Parts of the Toolflow

There are several components to the toolflow which are key to its functionality. All toolflow related files (except those used by the *Frontend*) are found in the `jasper_library` subdirectory of the [toolflow repository](https://github.com/casper-astro/mlib_devel).

Some documentation of the Pythonic parts of the toolflow can be found in the [auto-generated docs](src/jasper_library_modules/modules.html). Here we focus on giving an overview of the purpose of different parts of the toolflow, as well as providing some (hopefully) instructive examples of their usage.

### Platforms

`jasper_library/platforms/<platform>.yaml` contains YAML files describing the physical properties of a hardware platform. In order for a board to be supported by the CASPER toolflow it must have a Platform YAML file present in this directory. The name of this file should match the name of the compile platform, as understood by the toolflow *Frontend*. For example, the head of the YAML file `snap.yaml` which defines the SNAP platform is shown below.

```yaml
name: snap
manufacturer: Xilinx
fpga: xc7k160tffg676-2
backend_target: vivado
sources: []
constraints: []
provides:
  - sfp0
  - sfp1
  - zdok0
  - HAD1511_0
  - HAD1511_1
  - HAD1511_2
  - lmx2581
pins:
  sys_clk_p:
    loc: E10
    iostd: LVDS_25
  sys_clk_n:
    loc: D10
    iostd: LVDS_25
  led:
    iostd: LVCMOS25
    loc:
      - C13
      - C14
      - D13
      - D14 
      - E12
      - E13
  zdok0:
    iostd: LVCMOS25
    loc:
      - AA23
      - AB24
      - Y25
      - Y26
      - U24
      - U25
      - lots more pins....
```

Required fields are:
COMING SOON!
