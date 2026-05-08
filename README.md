# The CASPER Toolflow [![Documentation Status](https://readthedocs.org/projects/casper-toolflow/badge/?version=latest)](https://casper-toolflow.readthedocs.io/en/latest/?badge=latest)


Welcome to the CASPER Toolflow repository, `mlib_devel`!

## What is mlib_devel?

The `mlib_devel` repository contains a set of FPGA DSP libraries and programming tools developed and maintained by the [Collaboration for Astronomical Signal Processing and Electronics Research (CASPER)](http://casper.berkeley.edu/>). Within the collaboration, this collection of software is affectionately referred to as *The Toolflow.*

The CASPER toolflow allows you to generate signal processing designs using MATLAB's graphical programming tool `Simulink`. These designs can be turned into FPGA bitstreams and loaded onto a variety of supported hardware platforms to perform real-time digital signal processing systems. CASPER also provides a Python software library for interacting with running designs: [casperfpga ](https://github.com/casper-astro/casperfpga).

## Using mlib_devel

For more information about installing and using the CASPER Toolflow, see the project's [documentation](https://casper-toolflow.readthedocs.io).

If you want to build the documentation for a particular version of this repository you can do so by following [these instructions](docs/README.md).
This may be useful if, for example, you're trying to do old (ROACH2) versions of tutorials.

## Tutorials

CASPER maintain a set of [tutorials](https://casper-tutorials.readthedocs.io), designed to introduce new users to the toolflow.

## Updating an Existing Toolflow Installation

You can always update your installation of `mlib_devel` by pulling updated code from this repository. If you do this, chances are you'll need to update your Simulink models to match your new `mlib_devel` libraries.

A script is provided to automate this process. With your model open and active, in your MATLAB prompt, run

```matlab
update_casper_blocks(bdroot)
```

This script will resynchronize every CASPER block in your design with its latest library version. Depending on the size of your model, it may take many minutes to complete!
As always, **back up your designs before attempting such a major operation**. And, if you experience problems, please raise Github issues!

## Directory structure

<dl>
  <dt>casper_library</dt>
  <dd>Simulink DSP libraries</dd>
  <dt>xps_library</dt>
  <dd>Simulink libraries for tool-flow supported modules (ADC interfaces, Ethernet cores, etc.)</dd>
  <dt>xps_base</dt>
  <dd>HDL code and Xilinx EDK wrappers used in older (ROACH2 and earlier) versions of the toolflow.</dd>
  <dt>docs</dt>
  <dd><a href="https://casper-toolflow.readthedocs.io">Sphinx documentation</a> for the software in this project.</dd>
  <dt>jasper_library</dt>
  <dd>
    Python and MATLAB scripts required to drive the compilation process. Also platform-dependent configuration information and source-code for IP modules used by the toolflow in the following directories:
  <dl>
    <dt>jasper_library/platforms</dt>
    <dd>YAML files defining the compile parameters and physical constraints of CASPER-supported FPGA platforms.</dd>
    <dt>jasper_library/golden</dt>
    <dd>Golden boot images for FPGA platforms which require them.</dd>
    <dt>jasper_library/hdl_sources</dt>
    <dd>HDL source files for all toolflow-suppled modules (eg. ADC interfaces, Ethernet cores, etc.).</dd>
    <dt>jasper_library/sw</dt>
    <dd>Codebase for embedded software processors used by the toolflow.</dd>
    <dt>jasper_library/yellow_blocks</dt>
    <dd>Python classes for each yellow block in the simulink xps_library.</dd>
    </dl>
  </dd>
</dl>

## Getting Involved
If you are a CASPER collaborator, or you’re just interested in what we’re up to, feel free to join our mailing list by sending a blank email [here.](mailto:casper+subscribe@lists.berkeley.edu)

If would like to get involved in the development of the tools, please join our dev mailing list by sending a blank email [here.](mailto:casper-dev+subscribe@lists.berkeley.edu)

## scilab-m2021a-intel branch

This branch contains experimental support for using the Scilab-based CASPER frontend with Intel/Quartus FPGA targets. It extends the standard CASPER toolflow with a Quartus backend and supporting HDL/software infrastructure needed to build, package, program, and interact with Intel SoC FPGA designs through the usual CASPER runtime interface.

The intent of this branch is to preserve the normal CASPER workflow as much as possible:

1. Create a block-diagram design in the Scilab frontend.
2. Generate the intermediate CASPER design descriptions, including `jasper.json`, `jasper.per`, and DSP wrapper information.
3. Run the Python toolflow to generate HDL, the AXI4-Lite register fabric, memory maps, and the Quartus project script.
4. Compile the design with Quartus.
5. Package the generated Intel programming image into a CASPER `.fpg` file.
6. Program and control the design from Python using `casperfpga` and `KATCP` in the same style as existing CASPER platforms.

For Intel SoC platforms, the generated design uses the HPS lightweight AXI interface, an AXI-to-AXI4-Lite adapter, and the CASPER AXI4-Lite register fabric generated from the design memory map. The final `.fpg` file contains the usual CASPER metadata plus a compressed Quartus-generated `.rbf` payload. On the target system, `tcpborphserver` extracts this payload and programs the FPGA fabric through Linux FPGA Manager.

This branch is under active development. In particular, Intel-specific DSP library support, Scilab block coverage, and board support files may change as the toolflow is generalized. Designs built from this branch should be carefully validated before being used as reference instruments.
