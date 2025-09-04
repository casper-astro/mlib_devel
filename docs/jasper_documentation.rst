
The CASPER Toolflow
===================

The current Python-based CASPER toolflow (sometimes called *jasper*\ , to distinguish it from the MATLAB-based flow which supported ROACH2 and earlier platforms) was designed to enable users to quickly and effectively turn high-level DSP designs into FPGA bitcode, without having to worry about low-level implementation details.

While the ultimate goal of the toolflow is to support (or at least not prohibit) a wide range of mechanisms to input DSP designs, and be agnostic about the target FPGA's vendor, in practice the toolflow pipeline is as follows:


* A user specifies a DSP design using MATLAB's graphical programming tool, ``Simulink``.
* I/O to/from the DSP pipelines are specified using CASPER's ``xps_library`` Simulink blocks.
* DSP functionality is specified using CASPER's ``casper_library`` Simulink blocks.
* A user invokes the CASPER toolflow, which generates a Vivado project, complete with appropriate infrastructure and constraints to support the user's I/O requirements.
* Vivado compiles the toolflow-supplied project into a bitstream.
* The toolflow appends meta-data to this bitstream, describing and run-time, software-accessible, components in the firmware design.
* The bitstream and meta-data are delivered to the user in the form of a ``.fpg`` file.
* This file is programmed on to a compatible board using the ``casperfpga`` Python library.
* ``casperfpga`` provides Python methods for interacting with a running board (configuring registers, etc.)

Goals of the CASPER Toolflow
----------------------------

The ultimate goal of the tooflow is simple: make FPGA programming easy, so researchers (largely radio astronomers) can quickly develop and deploy instrumentation to meet their scientific requirements.
More concretely, the CASPER toolflow aims to:


* Make complex interfaces (1/10/40/100 Gb Ethernet, SRAM, DRAM, ADCs, DACs, etc.) available as sources and sinks in a DSP design without requiring knowledge of their low-level implementation.
* Facilitate easy porting of designs between FPGA platforms, by abstraction of these underlying interfaces.
* Provide a straight-forward integration with control and monitoring software.

While the *jasper* toolflow described in this documentation is (relatively) new, it builds on CASPER's original MATLAB-based flow, which was designed over a decade ago, and has quietly powered `many scientific instruments over its lifetime. <https://arxiv.org/abs/1611.01826>`_

Toolflow Terminology
--------------------

When discussing the CASPER toolflow, it helps to first define some terminology commonly used in the collaboration.

**Frontend**
: The part of the CASPER software stack used for design-entry. In practice, this means *Simulink*\ , though there are perpetual aspirations to support other entry methods, particularly non-graphical ones.

**Backend**
: The vendor-specific part of the CASPER software stack used to compile a toolflow-generated project. In practice, this means *Xilinx Vivado*\ , but could also in principle be *ISE* or *Altera Quartus*.

**Middleware / Toolflow-proper**
: The Python-based part of the CASPER software stack used to turn the design information entered into the *Frontend* into a complete specification for a *Backend* compile.

**Yellow Blocks**
: Interface blocks (ADCs/DACs/Ethernet/Memory) which are used by the *Frontend* to give the user access to a platform's peripherals. Yellow Blocks in the Frontend are supported by Python classes in the toolflow middleware. These classes ultimately determine what source files, constraints, and HDL incantations are required to instantiate a *Yellow Block* in hardware.

**Software Register**
: A *Software Register* is a yellow block encapsulating a 32-bit register in a design which can be accessed at runtime, usually via the ``casperfpga`` FPGA control library. These registers are usually used to feed control signals (MUX switch controls / enable signals / etc.) into a design. 

**Platform YAML**
: A `YAML <http://yaml.org/>`_ file defining the physical properties of an FPGA hardware platform.

**jasper.per**
: A `YAML <http://yaml.org/>`_ file output by the toolflow *Frontend* which specifies what was designed by the user. In principle, any tool which can generate such a file is a viable toolflow Frontend candidate.

**castro**
: A well-meaning attempt to provide an abstract, well-defined, platform-independent interface between the tooflow *Middleware* and the platform-/vendor-specific *Backend*. This interface is a Python ``Castro`` object, dumped as a `YAML <http://yaml.org/>`_ file! In practice, developers have subverted the original definitions of the ``Castro`` class to make it easier to get platform-specific data between stages of the toolflow, and somewhat undermined its purpose. 

Parts of the Toolflow
---------------------

There are several components to the toolflow which are key to its functionality. All toolflow related files (except those used by the *Frontend*\ ) are found in the ``jasper_library`` subdirectory of the `toolflow repository <https://github.com/casper-astro/mlib_devel>`_.

Some documentation of the Pythonic parts of the toolflow can be found in the `auto-generated docs <src/jasper_library_modules/modules.html>`_. Here we focus on giving an overview of the purpose of different parts of the toolflow, as well as providing some (hopefully) instructive examples of their usage.

Peripherals file
^^^^^^^^^^^^^^^^

The ``jasper.per`` peripherals file is output by the toolflow *Frontend*. As an example, a design for the SNAP board, which contains two software registers -- one called ``a``\ , which feeds a value into the DSP pipeline, and one called ``b``\ , which reads a value out of the DSP pipeline -- is shown below:

.. code-block:: yaml

   yellow_blocks:
     snap_tut_intro/SNAP1:
       name: SNAP1
       fullpath: snap_tut_intro/SNAP1
       tag: xps:xsg
       hw_sys: 'SNAP:xc7k160t'
       clk_src: sys_clk
       clk_rate: 100
       use_microblaze: off
       sample_period: 1
       synthesis_tool: XST
     snap_tut_intro/a:
       name: a
       fullpath: snap_tut_intro/a
       tag: xps:sw_reg
       io_dir: From Processor
       io_delay: 0
       sample_period: 1
       names: reg
       bitwidths: 32
       bin_pts: 0
       arith_types: 0
       sim_port: on
       show_format: off
     snap_tut_intro/b:
       name: b
       fullpath: snap_tut_intro/b
       tag: xps:sw_reg
       io_dir: To Processor
       io_delay: 0
       sample_period: 1
       names: reg
       bitwidths: 32
       bin_pts: 0
       arith_types: 0
       sim_port: on
       show_format: off
   user_modules:
     snap_tut_intro:
       clock: clk
       ports:
         - snap_tut_intro_a_user_data_out
         - snap_tut_intro_b_user_data_in
       sources:
         - /foo/snap_tut_intro/sysgen/hdl_netlist/snap_tut_intro.srcs/sources_1/imports/sysgen
         - /foo/snap_tut_intro/sysgen/hdl_netlist/snap_tut_intro.srcs/sources_1/ip/*.coe
         - /foo/snap_tut_intro/sysgen/hdl_netlist/snap_tut_intro.srcs/sources_1/ip/*/*.xci

This YAML structure has two keys.


* ``yellow_blocks`` is a hierarchical dictionary of all yellow blocks in the user's design, along with their parameters. The ``tag`` field of each entry in this dictionary indicates what type of block this is.
  The ``yellow_blocks`` dictionary always contains a block with the tag ``xps:xsg``\ , which is a special yellow block which contains information of the platform the user is targeting.
  In this case, the target is a *SNAP* board.
* ``user_modules`` is a dictionary listing the module(s) in a design which have been compiled by the *Frontend*. For a Simulink design, this is everything in the user's model which is not a yellow block.
  Each module's dictionary should define the name of its clock port, other data ports, and it's source file locations. In the case of a Simulink design, the latter are the outputs of the Xilinx System Generator compiler.

Platforms
^^^^^^^^^

``jasper_library/platforms/<platform>.yaml`` contains YAML files describing the physical properties of a hardware platform. In order for a board to be supported by the CASPER toolflow it must have a Platform YAML file present in this directory. The name of this file should match the name of the compile platform, as understood by the toolflow *Frontend*. For example, the head of the YAML file ``snap.yaml`` which defines the SNAP platform is shown below.

.. code-block:: yaml

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

The required fields in this YAML file are:


* **name**\ : The name of the platform, as understood by the tooflow (i.e. matching the name in the ``hw_sys`` parameter of the yellow block tagged ``xps:xsg``\ ). This should match the name of the file ``<name>.yaml``.
* **manufacturer**\ : A string indicating the platform's FPGA manufacturer. This can be used to make implementation decicions as the toolflow builds a user's design. Currently, only ``Xilinx`` is supported.
* **fpga**\ : The FPGA model the platform uses. This should be a string in the form understood by the FPGA vendor's compile tools. For example, for Xilinx platforms, it should be the appropriate part for a ``create_project ... -part <fpga>`` ``tcl`` command call.
* **backend_target**\ : A string indicating the *Backend* compile tool to use. Currently the only supported target is ``vivado``\ , which corresponds to the `\ ``VivadoBackend`` class <src/jasper_library_modules/toolflow.html#toolflow.VivadoBackend>`_. Once upon a time ``ise`` was also supported, as a proof-of-concept experiment in compiling for pre-7-series Xilinx FPGAs. This probably no longer works.
* **sources**\ : A list defining source files which should be included in compiles for this platform. Ideally this should be an empty list ``[]``\ , since a more toolflow-friendly way of adding files is via the platform-specific MSSGE Yellow block.
* **constraints**\ : A list defining constraints files which should be included in compiles for this platform. Ideally this should be an empty list ``[]``\ , since a more toolflow-friendly way of adding files is via the platform-specific MSSGE Yellow block.
* **provides**\ : A list of strings detailing the capabilities of the board. These are used for loose consistency checks when compiling, as they are matched against ``requires`` strings defined by `\ ``YellowBlock`` instances <src/jasper_library_modules/yellow_blocks.html#yellow_blocks.yellow_block.YellowBlock>`_. For example, a 10Gb Ethernet yellow block might *require* ``sfp0`` - if the platform does not *provide* this, the compile fill fail consistency checks. 
* **pins**\ : The bulk of the platform file contains pin location and iostandard definitions, in a a dictionary of the form ``{<pin name>: {loc: <loc>, iostd: <iostd>}``. Either ``loc`` or ``iostd`` entries may be lists. If they are both lists, their lengths should match. These friendly pin names are used by the toolflow to perform platform-agnostic definitions of external port connections.

The ``VerilogModule`` Class
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The `\ ``VerilogModule`` class <src/jasper_library_modules/verilog.html#verilog.VerilogModule>`_ is a Pythonic encapsulation of a verilog module. It provides simple Python methods to build a module by adding ports, signals, assignment statements, and sub-module instantiations. Code generation methods allow the ``VerilogModule`` to output valid verilog describing itself.

The ``VerilogModule`` class also provides the ability to instantiate sub-modules with `Wishbone <https://opencores.org/howto/wishbone>`_ interfaces, and will quietly manage their address spaces and arbitration.

While relatively simple, the ``VerilogModule`` class is central to the functionality of the toolflow, which is, ultimately, just a code-generator. Adding support for new hardware to the toolflow entails heavy use of the ``VerilogModule`` class by ``YellowBlock`` objects.

Yellow Blocks
^^^^^^^^^^^^^

A yellow block is a *Frontend* module (so-called because in Simulink these modules are, literally, yellow blocks) whose instantiation in a user's design triggers the toolflow to insert some code into the generated code at compile time. A `dedicated tutorial <http://casper-tutorials.readthedocs.io/en/latest/tutorials/snap/tut_gpio_bidir.html>`_ has been written to explain how to add new yellow blocks to the tooflow *Frontend* and *Middleware*.

In the case of the *Frontend*\ , adding a yellow block means putting a new block in the Simulink ``xps_library`` and creating a GUI (or *mask* in Simulink parlance) with which users can set the block's parameters.
For example, for a 10Gb Ethernet yellow block, at a minimum the block mask should allow the user to pick the physical port on their board they with which then want the Ethernet block to be associated.
The mask might also allow parameters to be configured, such as the MAC address of the underlying Ethernet core, or sizes of transmit/receive buffers.

In the case of the *Middleware*\ , adding a yellow block means creating a new `\ ``YellowBlock`` subclass <src/jasper_library_modules/yellow_blocks.html#yellow_blocks.yellow_block.YellowBlock>`_.
This subclass defines how the presence of a yellow block in the *Frontend* impacts the constaints and verilog delivered to the *Backend* compiler.

Current ``YellowBlock`` subclasses can be found in the toolflow repository at ``jasper_library/yellow_blocks`` and alongside the `yellow block tutorial <http://casper-tutorials.readthedocs.io/en/latest/tutorials/snap/tut_gpio_bidir.html>`_ serve as instructive examples.
Unless a block is unusually simple, it probably will implement at least three methods:


* ``initialize()``\ : Configure parameters of the yellow block, such as the source files it requires.
* ``modify_top(top)``\ : Modify the\ ``VerilogModule`` instance, ``top``\ , which describes the top-level of the user's design. Here you can make use of ``VerilogModule`` methods to instantiate sub-modules, and connect them to stuff.
* ``gen_constraints()``\ : Return a list of constraint objects, defining external pin connections, clock rates, or other constraints the toolflow *Backend* knows how to deal with. 

How it all fits together
------------------------

The toolflow is executed via the ``exec_flow.py`` script. A complete compile is invoked with

.. code-block::

   python exec_flow.py --perfile --frontend --middleware --backend --software -m <model_name>

Where the final argument indicates the *Frontend* file (Simulink model) which should be used as the starting point of the compile.
Each of the flags triggers a different stage of the toolflow compile process, and following these stages gives an idea of how the toolflow fits together.

Peripheral file generation / Frontend compile
"""""""""""""""""""""""""""""""""""""""""""""

The ``--perfile`` flag causes the toolflow's *Frontend* to output a toolflow-standard ``jasper.per`` peripherals file, which contains information about all the yellow blocks in the design, and the locations of source files which the *Frontend* is responsible for compiling.
The ``--frontend`` flag causes the frontend to compile any user IP it is responsible for synthesizing.
In the case of the Simulink Frontend, this is essentially a call to *Xilinx System Generator*\ , triggering a compile of all the DSP blocks in the user's Simulink model.

These actions correspond to the toolflow methods:

.. code-block::

   ToolflowFrontend.gen_periph_file()
   ToolflowFrontend.compile_user_ip()

In practice, since these methods ultimately invoke MATLAB calls, while the toolflow can call them via Python methods, usually they are run directly in MATLAB, via the command ``jasper_frontend``. After this stages of the compile, a ``jasper.per`` file has been generated, which serves as the input to future compile stages.
This file contains information about all the yellow blocks in the *Frontend* model, as well as the locations of any synthesized code which needs to be included in the final project.

Middleware Project Building
"""""""""""""""""""""""""""

The ``--middleware`` flag invokes the core toolflow methods which build an FPGA project. These methods are:

.. code-block::

   Toolflow.gen_periph_objs()
   Toolflow.build_top()
   Toolflow.generate_hdl()
   Toolflow.generate_consts()
   Toolflow.write_core_info()
   Toolflow.write_core_jam_info()
   Toolflow.constraints_rule_check()
   Toolflow.dump_castro()

In chronological order:


#. ``gen_periph_objs()`` reads ``jasper.per`` to figure out which yellow blocks are in a user's design. It then constructs the associated ``YellowBlock`` objects, and calls their ``initialize()`` methods.
#. ``build_top()`` creates a ``VerilogModule`` instance to represent the top-level of the user's design in HDL.
#. ``generate_hdl()`` instantiates relevant yellow block code in this top-level module, by calling each ``YellowBlock`` sub-class's ``modify_top`` method. It also instantiates the user's DSP IP (i.e., the blocks compiled by *System Generator*. At the end of this method the fully populated ``VerilogModule`` instance is turned into a verilog source file, and added to the project the toolflow is constructing.
#. ``generate_consts()`` gathers the constraints required by each yellow block via their ``gen_constraints`` methods. Where applicable, symbolic contraints (such as the LOCs) are turned into physical constraints via the pin mappings in the relevant platform's YAML configuration file.
#. ``write_core_info()`` / ``write_core_jam_info()`` collects information about the runtime-accessible registers in the design, and writes them to file(s).
#. ``constraints_rule_check()`` checks for ports in the top-level verilog which are missing associated constraints.
#. ``dump_castro()`` dumps a description of the now complete project specification to disk, as a YAML dump of a ``Castro`` instance.

Backend compiling
"""""""""""""""""

The ``--backend`` flag triggers instantiation of a ``ToolflowBackend`` object (in practice, this will invariably be a ``VivadoBackend``. Two methods are run against this object:

.. code-block::

   ToolflowBackend.import_from_castro()
   ToolflowBackend.compile()

The first of these, ``import_from_castro``\ , reads the output of the toolflow *Middleware*\ , essentially copying attributes of the ``Castro`` objects to internal attributes.
The second, ``compile()``\ , takes the imported pythonic representation of the project and delivers a bitstream. In the ``VivadoBackend`` case, everything in the project is elaborated into a ``tcl`` script, which is then run by Vivado in batch mode.

Software generation
"""""""""""""""""""

When the *Backend* finishes compiling, it will (hopefully!) have generated a viable FPGA bitstream.
All that remains is to append meta data to this bitstream, which will tell the ``casperfpga`` software library what registers are present in the bitstream. This concatenation of bitstream and metadata is generated by

.. code-block::

   ToolflowBackend.mkfpg()

Which delivers a custom-CASPER-format ``.fpg`` file.

Users can load this file onto a CASPER-supported FPGA platform with the ``casperfpga`` library:

.. code-block:: python

   import casperfpga
   myfpga = casperfpga.CasperFpga(<hostname>)
   myfpga.upload_to_ram_and_program(<fpgfile>.fpg)
   # Read and write registers:
   myfpga.registers.reg_a = 0xdeadbeef
   #...etc.

Supporting New Hardware
-----------------------

Here we briefly summarize the steps required to add support for a new hardware platform or peripheral to the toolflow.

Adding a New Platform
^^^^^^^^^^^^^^^^^^^^^

Depending on the level of support required, adding a new hardware platform to the toolflow is actually quite straightforward.

Adding a Platform to the Toolflow Frontend
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First, a *Platform Block* for the new platform needs to be added to the ``xps_library`` Simulink blockset.
This library can be found in the toolflow repository at ``xps_library/xps_library.slx``.
However, to aid version control, this library is automatically generated from the model files in ``xps_library/xps_models``\ , each of which contains one library block.

Platform blocks live in ``xps_library/xps_models/Platforms`` -- it is suggested that new platforms are added by copying one of these models to a new file, whose name reflects the new platform being added.

Once the new model file has been created, open it in Simulink, and modify the mask parameters of the block as appropriate.
Probably, this means removing and clock sources which aren't valid for your platform, and/or hardcoding/parameterizing the allowed clock rates the user may enter.

Your platform yellow block should have an initialization function which looks for a *Xilinx System Generator* block in your design and configures it appropriately.
For example, the SNAP-board initialization function is ``xps_xsg_snap_conf_mask.m``\ , and contains:

.. code-block:: matlab

   if ~strcmp(bdroot, 'xps_library')
       sysgen_blk = find_system(gcs, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','genX');
       if length(sysgen_blk) == 1
           xsg_blk = sysgen_blk{1};
       else
           error('XPS block must be on the same level as the Xilinx SysGen block');
       end

       [hw_sys, hw_subsys] = xps_get_hw_plat(get_param(gcb,'hw_sys'));
       clk_src = get_param(gcb, 'clk_src');
       %clk_src = get_param(gcb, [hw_sys, '_clk_src']);
       syn_tool = get_param(gcb, 'synthesis_tool');

       %set_param(gcb, 'clk_src', clk_src);

       ngc_config.include_clockwrapper = 1;
       ngc_config.include_cf = 0;

       xlsetparam(xsg_blk,'xilinxfamily', 'Kintex7',...
           'part', hw_subsys,...
           'speed', '-2',...
           'testbench', 'off',...
           'package', 'ffg676');

       xlsetparam(xsg_blk,...
           'sysclk_period', num2str(1000/clk_rate),...
           'synthesis_language', 'VHDL');

       if strcmp(syn_tool, 'Leonardo Spectrum')
           xlsetparam(xsg_blk, 'synthesis_tool', 'Spectrum');
       else
           xlsetparam(xsg_blk, 'synthesis_tool', syn_tool)
       end

       xlsetparam(xsg_blk,'clock_loc','d7hack')
   end

You should create your own initialization function in ``xps_library/`` and point your block to use it. At a minimum, it should appropriately set the ``xilinxfamily``\ , ``part``\ , ``speed`` and ``package`` entries of the Xilinx System Generator block via a command similar to:

.. code-block:: matlab

   xlsetparam(xsg_blk,'xilinxfamily', 'Kintex7',...
       'part', hw_subsys,...
       'speed', '-2',...
       'testbench', 'off',...
       'package', 'ffg676');

You may have to manually open a Xilinx System Generator block to figure out what the correct ``xilinxfamily`` specification is for your FPGA.
If you wish, you can place design rule checking (eg. maximum / minimum allowed clock rates) within this initialization function.

Once you have added and saved your new platform block, you can include it in ``xps_library.slx``  by regenerating the library with the MATLAB command ``xps_build_new_library``.

Adding a Platform to the Toolflow Middleware
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The new platform block needs to be backed up with support from the toolflow middleware.

First, a platform YAML file needs to be added to ``jasper_library/platforms/`` meeting the spec explained `earlier <#platforms>`_.

Second, a platform yellow block python class is required.
The class name should match your platform name (lower case), and the class should be stored in the file ``jasper_library/yellow_blocks/<platform>.py``.

The ``YellowBlock`` class for the SNAP board is:

.. code-block:: python

   from yellow_block import YellowBlock
   from constraints import ClockConstraint, PortConstraint, RawConstraint

   class snap(YellowBlock):
       def initialize(self):
           self.add_source('infrastructure')
           self.add_source('wbs_arbiter')
           # 32-bit addressing => second half of 32 MByte memory. See UG470 v1.11 Table 7.2, Note 1
           self.usermemaddr = 0x800000  >> 8 
           self.golden = False

       def modify_top(self,top):
           inst = top.get_instance('snap_infrastructure', 'snap_infrastructure_inst')
           inst.add_port('sys_clk_buf_n', 'sys_clk_n', parent_port=True, dir='in')
           inst.add_port('sys_clk_buf_p', 'sys_clk_p', parent_port=True, dir='in')
           inst.add_port('sys_clk0     ', 'sys_clk   ')
           inst.add_port('sys_clk180   ', 'sys_clk180')
           inst.add_port('sys_clk270   ', 'sys_clk270')
           inst.add_port('clk_200      ', 'clk_200   ')
           inst.add_port('sys_rst      ', 'sys_rst   ')
           inst.add_port('idelay_rdy   ', 'idelay_rdy')

           top.add_signal('sys_clk90')
           top.assign_signal('sys_clk90', '~sys_clk270')

       def gen_children(self):
           children = [YellowBlock.make_block({'tag':'xps:sys_block', 'board_id':'12', 'rev_maj':'12', 'rev_min':'0', 'rev_rcs':'32'}, self.platform)]
           if self.use_microblaze:
               children.append(YellowBlock.make_block({'tag':'xps:microblaze'}, self.platform))
           else:
               children.append(YellowBlock.make_block({'tag':'xps:spi_wb_bridge'}, self.platform))
               # XADC is embedded in the microblaze core, so don't include another one unless we're not microblazin'
               children.append(YellowBlock.make_block({'tag':'xps:xadc'}, self.platform))
           return children

       def gen_constraints(self):
           cons =[
               PortConstraint('sys_clk_n', 'sys_clk_n'),
               PortConstraint('sys_clk_p', 'sys_clk_p'),
               ClockConstraint('sys_clk_p', period=5.0),
               RawConstraint('set_property CONFIG_VOLTAGE 2.5 [current_design]'),
               RawConstraint('set_property CFGBVS VCCO [current_design]'),
               RawConstraint('set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]'),
               RawConstraint('set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]'),
               RawConstraint('set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes [current_design]'),
               RawConstraint('set_property BITSTREAM.CONFIG.TIMER_CFG 2000000 [current_design]'), # about 10 seconds
           ]
           if self.golden:
               #cons += [RawConstraint('set_property BITSTREAM.CONFIG.NEXT_CONFIG_ADDR 0x%.7x [current_design]' % self.usermemaddr),]
               pass
           else:
               cons += [RawConstraint('set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]'),]
           return cons

       def gen_tcl_cmds(self):
           tcl_cmds = {}
           # After generating bitstream write PROM file
           # Write both mcs and bin files. The latter are good for remote programming via microblaze. And makes sure the
           # microblaze code makes it into top.bin, and hence top.bof
           tcl_cmds['promgen'] = []
           tcl_cmds['promgen'] += ['write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.mcs" -force']
           tcl_cmds['promgen'] += ['write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x%.7x ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top_0x%x.mcs" -force' % (self.usermemaddr, self.usermemaddr)]
           tcl_cmds['promgen'] += ['write_cfgmem  -format bin -size 32 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.bin" -force']
           return tcl_cmds

This class instantiates a ``snap_infrastructure`` module in a design's top-level verilog file (via ``modify_top``\ ), and requires the source files ``jasper_library/hdl_sources/wbs_arbiter/*`` and ``jasper_library/hdl_sources/infrastructure/*`` (via ``initialize``\ ).
You'll probably want to make an infrastructure block which is appropriate to your platform -- i.e., takes in an external clock signal, and generates a buffered system clock which other modules in a design can use.

There are a few rules which platform ``YellowBlock`` subclasses must adhere to in order not to break the toolflow:


* They should add the source ``wbs_arbiter`` (this is a silly requirement which should be mitigated)
* They should generate a buffered clock called ``sys_clk``\ , and its 90/180/270 degree counterparts ``sysclk90``\ , ``sysclk180`` and ``sysclk270``.
* ``sys_clk`` should be 100 MHz. (This is not strictly a requirement, but other modules assume ``sys_clk`` is relatively slow, and therefore appropriate for use in high combinatorial-logic paths)

The SNAP block attaches the external ``sys_clk_n`` and ``sys_clk_p`` ports to ports with the same names in the platforms YAML file via the ``PortConstraint`` instances returned by ``gen_constraints``.
It is not necessary for the two arguments of the ``PortConstraint`` to match -- i.e., it is acceptable to connect the top-level port ``sys_clk_n`` to the platform pin designated ``foo_clk`` -- but maintaining some consistency with existing platforms is recommended where possible.

A ``ClockConstraint`` should also be defined in ``gen_constraints``\ , which appropriately sets the rate of the clock being used to derive the 100 MHz system clock.

The SNAP example above also uses a variety of other features which may be useful for new platforms.


* ``RawConstraint`` instances are used to pass bitstream configuration information to the downstream compiler.
* An optional method ``gen_tcl_cmds`` is included, which adds tcl commands directly to the final compilation script. In this case, these commands are used to generate a SNAP-appropriate prom file from the compiled bitstream.
* An optional method ``gen_children`` is used to instantiate other yellow blocks in the design as if the user had placed them in their Simulink model.

Compiling
~~~~~~~~~

With the above changes, you should be able to compile a design for your new platform using the toolflow!

During the development process, it is recommended that you look at the generated ``jasper.per`` and ``top.v`` files to check how definitions in python classes and YAML configuration files are being turned into code. The `Yellow Block tutorial <http://casper-tutorials.readthedocs.io/en/latest/tutorials/snap/tut_gpio_bidir.html>`_ will probably prove helpful in further understanding the machinations of the toolflow.

Of course, you can only use yellow blocks in your design which your platform understands. Some will be automatically supported -- software registers and shared bram blocks have no top-level ports or platform-specific HDL, and so are sompletely supported. Others can be supported by simply ensuring that your platform's YAML configuration file has appropriate entries for all the pins needed by a yellow block. This is the case, for example, with the ``spi_wb_bridge`` block, which allows a design's on-chip wishbone bus to be driven via an external SPI interface.
However, most more complex yellow blocks (Ethernet / Memory interfaces) will require some level of customization to be supported.

Adding a New Peripheral
^^^^^^^^^^^^^^^^^^^^^^^

Adding a new peripheral is well covered in the `Yellow Block tutorial <http://casper-tutorials.readthedocs.io/en/latest/tutorials/snap/tut_gpio_bidir.html>`_
