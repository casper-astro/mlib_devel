from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint

class zcu216(YellowBlock):
    # TODO: if any of the methods turn out to be very similar (e.g., initialize looks to be that way) we could have that method live in this
    # top class to reduce duplication
    # or perhaps remove this factory method all together and instance based on blk[] contents where need to in the modify top and the
    # gen_tcl_cmds method also calls two different methods based on blk[]
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if True:
          return zcu216_bd(blk, plat, hdl_root)
        else:
          return zcu216_v(blk, plat, hdl_root)

class zcu216_bd(zcu216):
    def initialize(self):
        self.add_source('infrastructure/zcu216_clk_infrastructure.sv')
        #self.add_source('infrastructure/zcu216_infrastructure.v')
        self.add_source('utils/cdc_synchroniser.vhd')
        #self.add_source('zynq/config_mpsoc_zcu216.tcl')

        # TODO: need new provides and figure the extent to provide these, because as the documentation says
        # if these lines aren't here the the toolflow breaks.
        self.provides.append(self.clk_src)
        self.provides.append(self.clk_src+'90')
        self.provides.append(self.clk_src+'180')
        self.provides.append(self.clk_src+'270')
        self.provides.append(self.clk_src+'_rst')

        # TODO: Need to add this? Is it a bug that `axi4lite_interconnect.py` does not make a `requires` call
        self.provides.append('axil_clk')  # zcu216 infrastructure
        self.provides.append('axil_rst_n')  # zcu216 infrastructure

        # for the rfsocs it seems appropriate to use the requires/provides for `sysref` and `pl_sysref` for MTS?
        self.provides.append('pl_sysref') # zcu216 infrastructure provides so rfdc can require
        self.provides.append('clk_adc0')  # rfdc IP provides on the output

    def modify_top(self, top):
        top.assign_signal('axil_clk', 'pl_clk0')            # TODO: need to have these signals come out of the block diagram
        top.assign_signal('axil_rst', 'peripheral_reset')
        top.assign_signal('axil_rst_n', 'peripheral_aresetn')

        clkparams = clk_factors(100, self.platform.user_clk_rate)

        # TODO: clk infrastructure change to accomodate the high-density global clock package pin inputs has worked -- need to decide what to do
        inst_infr = top.get_instance('zcu216_clk_infrastructure', 'zcu216_infr_inst')
        inst_infr.add_parameter('PERIOD', '10.0')
        inst_infr.add_parameter('MULTIPLY', clkparams[0])
        inst_infr.add_parameter('DIVIDE',   clkparams[1])
        inst_infr.add_parameter('DIVCLK',   clkparams[2])
        inst_infr.add_port('pl_clk_p',      "pl_clk_p", dir='in',  parent_port=True)
        inst_infr.add_port('pl_clk_n',      "pl_clk_n", dir='in',  parent_port=True)

        inst_infr.add_port('adc_clk', 'adc_clk')
        inst_infr.add_port('adc_clk90', 'adc_clk90')
        inst_infr.add_port('adc_clk180', 'adc_clk180')
        inst_infr.add_port('adc_clk270', 'adc_clk270')
        inst_infr.add_port('mmcm_locked', 'mmcm_locked', dir='out', parent_port=True)

        # instance block design containing mpsoc, and axi protocol converter for casper mermory map (HPM0), axi gpio for software clk104 config (HPM1) 
        bd_inst = top.get_instance('zcu216_base', 'zcu216_inst')

        bd_inst.add_port('m_axi_awaddr',  'M_AXI_awaddr', width=40)#// output wire [39 : 0] m_axi_awaddr
        bd_inst.add_port('m_axi_awprot',  'M_AXI_awprot', width=3)#// output wire [2 : 0] m_axi_awprot
        bd_inst.add_port('m_axi_awvalid', 'M_AXI_awvalid')#// output wire m_axi_awvalid
        bd_inst.add_port('m_axi_awready', 'M_AXI_awready')#// input wire m_axi_awready
        bd_inst.add_port('m_axi_wdata',   'M_AXI_wdata', width=32)#// output wire [31 : 0] m_axi_wdata
        bd_inst.add_port('m_axi_wstrb',   'M_AXI_wstrb', width=4)#// output wire [3 : 0] m_axi_wstrb
        bd_inst.add_port('m_axi_wvalid',  'M_AXI_wvalid')#// output wire m_axi_wvalid
        bd_inst.add_port('m_axi_wready',  'M_AXI_wready')#// input wire m_axi_wready
        bd_inst.add_port('m_axi_bresp',   'M_AXI_bresp', width=2)#// input wire [1 : 0] m_axi_bresp
        bd_inst.add_port('m_axi_bvalid',  'M_AXI_bvalid')#// input wire m_axi_bvalid
        bd_inst.add_port('m_axi_bready',  'M_AXI_bready')#// output wire m_axi_bready
        bd_inst.add_port('m_axi_araddr',  'M_AXI_araddr', width=40)#// output wire [39 : 0] m_axi_araddr
        bd_inst.add_port('m_axi_arprot',  'M_AXI_arprot', width=3)#// output wire [2 : 0] m_axi_arprot
        bd_inst.add_port('m_axi_arvalid', 'M_AXI_arvalid')#// output wire m_axi_arvalid
        bd_inst.add_port('m_axi_arready', 'M_AXI_arready')#// input wire m_axi_arready
        bd_inst.add_port('m_axi_rdata',   'M_AXI_rdata', width=32)#// input wire [31 : 0] m_axi_rdata
        bd_inst.add_port('m_axi_rresp',   'M_AXI_rresp', width=2)#// input wire [1 : 0] m_axi_rresp
        bd_inst.add_port('m_axi_rvalid',  'M_AXI_rvalid')#// input wire m_axi_rvalid
        bd_inst.add_port('m_axi_rready',  'M_AXI_rready')#// output wire m_axi_rready

        bd_inst.add_port('clk104_spi_mux_sel', 'clk104_spi_mux_sel', width=2, dir='out', parent_port=True)

        bd_inst.add_port('pl_clk0', 'pl_clk0')
        bd_inst.add_port('peripheral_reset', 'peripheral_reset')
        bd_inst.add_port('peripheral_aresetn', 'peripheral_aresetn')

        bd_inst.add_port('mux_led', 'mux_led', width=2, dir='out', parent_port=True)


    def gen_children(self):
        children = []
        children.append(YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform))
        # gonna just put in the zcu216 for now then compartamentalize
        #children.append(YellowBlock.make_block({'tag': 'xps:zynq_usplus'}, self.platform))
        #children.append(YellowBlock.make_block({'tag': 'xps:axi_protocol_converter'}, self.platform))

        return children


    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('pl_clk_p', 'pl_clk_p'))
        cons.append(RawConstraint('set_property -dict { PACKAGE_PIN G10 IOSTANDARD LVCMOS18 } [get_ports { clk104_spi_mux_sel[0] }]'))
        cons.append(RawConstraint('set_property -dict { PACKAGE_PIN H11 IOSTANDARD LVCMOS18 } [get_ports { clk104_spi_mux_sel[1] }]'))
        cons.append(RawConstraint('set_property -dict { PACKAGE_PIN B26 IOSTANDARD LVCMOS12 } [get_ports { mmcm_locked }]'))

        cons.append(RawConstraint('set_property -dict { PACKAGE_PIN AV21 IOSTANDARD LVCMOS12 } [get_ports { mux_led[0] }]'))
        cons.append(RawConstraint('set_property -dict { PACKAGE_PIN AR21 IOSTANDARD LVCMOS12 } [get_ports { mux_led[1] }]'))

        #cons.append(PortConstraint('clk_100_p', 'clk_100_p'))
        #cons.append(ClockConstraint('clk_100_p','clk_100_p', period=10.0, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=5.0))
        #cons.append(ClockGroupConstraint('clk_pl_0', 'clk_100_p', 'asynchronous'))
        #cons.append(ClockGroupConstraint('clk_100_p', 'clk_pl_0', 'asynchronous'))
        return cons


    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        """
        Add a block design to project with wrapper via its exported tcl script.
        1. Source the tcl script.
        2. Generate the block design via generate_target.
        3. Have vivado make an HDL wrapper around the block design.
        4. Add the wrapper HDL file to project.
        """
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/infrastructure/zcu216_base.tcl')]
        tcl_cmds['pre_synth'] += ['generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/zcu216_base/zcu216_base.bd]']
        tcl_cmds['pre_synth'] += ['make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/zcu216_base/zcu216_base.bd] -top']
        tcl_cmds['pre_synth'] += ['add_files -norecurse [get_property directory [current_project]]/myproj.srcs/sources_1/bd/zcu216_base/hdl/zcu216_base_wrapper.vhd']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']

        tcl_cmds['post_synth'] = []
        # TODO: make note of how to use HD bank clocks to drive an MMCM on US+
        #tcl_cmds['post_synth'] += ['set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_100_p]']
        tcl_cmds['post_synth'] += ['set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pl_clk_p]']

        return tcl_cmds


"""

Implement the same functionality without a tcl block design

"""

# TODO: does not have clk104 gpio pins included
class zcu216_v(zcu216):
    def initialize(self):
        self.add_source('infrastructure/zcu216_clk_infrastructure.sv')
        #self.add_source('infrastructure/zcu216_infrastructure.v')
        self.add_source('utils/cdc_synchroniser.vhd')
        #self.add_source('zynq/config_mpsoc_zcu216.tcl')

        # TODO: need new provides and figure the extent to provide these, because as the documentation says
        # if these lines aren't here the the toolflow breaks.
        self.provides.append(self.clk_src)
        self.provides.append(self.clk_src+'90')
        self.provides.append(self.clk_src+'180')
        self.provides.append(self.clk_src+'270')
        self.provides.append(self.clk_src+'_rst')

        # TODO: Need to add this? Is it a bug that `axi4lite_interconnect.py` does not make a `requires` call
        self.provides.append('axil_clk')  # zcu216 infrastructure
        self.provides.append('axil_rst_n')  # zcu216 infrastructure

        # for the rfsocs it seems appropriate to use the requires/provides for `sysref` and `pl_sysref` for MTS?
        self.provides.append('pl_sysref') # zcu216 infrastructure provides so rfdc can require
        self.provides.append('clk_adc0')  # rfdc IP provides on the output

    def modify_top(self, top):
        #inst = top.get_instance('zcu216', 'zcu216_inst') # don't need this anymore

        top.assign_signal('axil_clk', 'pl_clk0')
        top.assign_signal('axil_rst', 'peripheral_reset')
        top.assign_signal('axil_rst_n', 'peripheral_aresetn')
        
        #inst.add_port('axil_clk',   'axil_clk')
        #inst.add_port('axil_rst',   'axil_rst')
        #inst.add_port('axil_rst_n', 'axil_rst_n')

        clkparams = clk_factors(100, self.platform.user_clk_rate)

        # TODO: clk infrastructure change to accomodate the HDGC inputs has worked need to decide what to do
        inst_infr = top.get_instance('zcu216_clk_infrastructure', 'zcu216_infr_inst')
        inst_infr.add_parameter('PERIOD', '10.0')
        inst_infr.add_parameter('MULTIPLY', clkparams[0])
        inst_infr.add_parameter('DIVIDE',   clkparams[1])
        inst_infr.add_parameter('DIVCLK',   clkparams[2])
        inst_infr.add_port('pl_clk_p',      "pl_clk_p", dir='in',  parent_port=True)
        inst_infr.add_port('pl_clk_n',      "pl_clk_n", dir='in',  parent_port=True)

        inst_infr.add_port('adc_clk', 'adc_clk')
        inst_infr.add_port('adc_clk90', 'adc_clk90')
        inst_infr.add_port('adc_clk180', 'adc_clk180')
        inst_infr.add_port('adc_clk270', 'adc_clk270')
        inst_infr.add_port('mmcm_locked', 'mmcm_locked', dir='out', parent_port=True)

        # instantiate mpsoc
        mpsoc_inst = top.get_instance('mpsoc', 'mpsoc_inst')
        # HPM GP0
        mpsoc_inst.add_port('maxihpm0_fpd_aclk', 'pl_clk0') #'maxihpm0_fpd_aclk')# // input wire maxihpm0_fpd_aclk
        mpsoc_inst.add_port('maxigp0_awid',    'maxigp0_awid',     width=16)  # // output wire [15 : 0] maxigp0_awid
        mpsoc_inst.add_port('maxigp0_awaddr',  'maxigp0_awaddr',   width=40)  # // output wire [39 : 0] maxigp0_awaddr
        mpsoc_inst.add_port('maxigp0_awlen',   'maxigp0_awlen',    width=8)   # // output wire [7 : 0] maxigp0_awlen
        mpsoc_inst.add_port('maxigp0_awsize',  'maxigp0_awsize',   width=3)   # // output wire [2 : 0] maxigp0_awsize
        mpsoc_inst.add_port('maxigp0_awburst', 'maxigp0_awburst',  width=2)   # // output wire [1 : 0] maxigp0_awburst
        mpsoc_inst.add_port('maxigp0_awlock',  'maxigp0_awlock')        # // output wire maxigp0_awlock
        mpsoc_inst.add_port('maxigp0_awcache', 'maxigp0_awcache',  width=4)   # // output wire [3 : 0] maxigp0_awcache
        mpsoc_inst.add_port('maxigp0_awprot',  'maxigp0_awprot',   width=3)   # // output wire [2 : 0] maxigp0_awprot
        mpsoc_inst.add_port('maxigp0_awvalid', 'maxigp0_awvalid')      # // output wire maxigp0_awvalid
        mpsoc_inst.add_port('maxigp0_awuser',  'maxigp0_awuser',   width=16)  # // output wire [15 : 0] maxigp0_awuser
        mpsoc_inst.add_port('maxigp0_awready', 'maxigp0_awready')      # // input wire maxigp0_awready
        mpsoc_inst.add_port('maxigp0_wdata',   'maxigp0_wdata',    width=32)  # // output wire [31: 0] maxigp0_wdata
        mpsoc_inst.add_port('maxigp0_wstrb',   'maxigp0_wstrb',    width=16)  # // output wire [15 : 0] maxigp0_wstrb
        mpsoc_inst.add_port('maxigp0_wlast',   'maxigp0_wlast')          # // output wire maxigp0_wlast
        mpsoc_inst.add_port('maxigp0_wvalid',  'maxigp0_wvalid')        # // output wire maxigp0_wvalid
        mpsoc_inst.add_port('maxigp0_wready',  'maxigp0_wready')        # // input wire maxigp0_wready
        mpsoc_inst.add_port('maxigp0_bid',     'maxigp0_bid',     width=16)   # // input wire [15 : 0] maxigp0_bid
        mpsoc_inst.add_port('maxigp0_bresp',   'maxigp0_bresp',   width=2)    # // input wire [1 : 0] maxigp0_bresp
        mpsoc_inst.add_port('maxigp0_bvalid',  'maxigp0_bvalid')       # // input wire maxigp0_bvalid
        mpsoc_inst.add_port('maxigp0_bready',  'maxigp0_bready')       # // output wire maxigp0_bready
        mpsoc_inst.add_port('maxigp0_arid',    'maxigp0_arid',    width=16)   # // output wire [15 : 0] maxigp0_arid
        mpsoc_inst.add_port('maxigp0_araddr',  'maxigp0_araddr',  width=40)   # // output wire [39 : 0] maxigp0_araddr
        mpsoc_inst.add_port('maxigp0_arlen',   'maxigp0_arlen',   width=8)    # // output wire [7 : 0] maxigp0_arlen
        mpsoc_inst.add_port('maxigp0_arsize',  'maxigp0_arsize',  width=3)    # // output wire [2 : 0] maxigp0_arsize
        mpsoc_inst.add_port('maxigp0_arburst', 'maxigp0_arburst', width=2)    # // output wire [1 : 0] maxigp0_arburst
        mpsoc_inst.add_port('maxigp0_arlock',  'maxigp0_arlock')       # // output wire maxigp0_arlock
        mpsoc_inst.add_port('maxigp0_arcache', 'maxigp0_arcache', width=4)    # // output wire [3 : 0] maxigp0_arcache
        mpsoc_inst.add_port('maxigp0_arprot',  'maxigp0_arprot',  width=3)    # // output wire [2 : 0] maxigp0_arprot
        mpsoc_inst.add_port('maxigp0_arvalid', 'maxigp0_arvalid')     # // output wire maxigp0_arvalid
        mpsoc_inst.add_port('maxigp0_aruser',  'maxigp0_aruser',  width=16)   # // output wire [15 : 0] maxigp0_aruser
        mpsoc_inst.add_port('maxigp0_arready', 'maxigp0_arready')     # // input wire maxigp0_arready
        mpsoc_inst.add_port('maxigp0_rid',     'maxigp0_rid',     width=16)   # // input wire [15 : 0] maxigp0_rid
        mpsoc_inst.add_port('maxigp0_rdata',   'maxigp0_rdata',   width=32)   # // input wire [31: 0] maxigp0_rdata
        mpsoc_inst.add_port('maxigp0_rresp',   'maxigp0_rresp',   width=2)    # // input wire [1 : 0] maxigp0_rresp
        mpsoc_inst.add_port('maxigp0_rlast',   'maxigp0_rlast')         # // input wire maxigp0_rlast
        mpsoc_inst.add_port('maxigp0_rvalid',  'maxigp0_rvalid')       # // input wire maxigp0_rvalid
        mpsoc_inst.add_port('maxigp0_rready',  'maxigp0_rready')       # // output wire maxigp0_rready
        mpsoc_inst.add_port('maxigp0_awqos',   'maxigp0_awqos',   width=4)    # // output wire [3 : 0] maxigp0_awqos
        mpsoc_inst.add_port('maxigp0_arqos',   'maxigp0_arqos',   width=4)    # // output wire [3 : 0] maxigp0_arqos

        # HPM GP1 TODO: note this interface is for rfsoc but data width on mpsoc is 128, may need to be changed for rfsoc
        #mpsoc_inst.add_port('maxihpm1_fpd_aclk', 'pl_clk0')#'maxihpm1_fpd_aclk') # // input wire maxihpm1_fpd_aclk
        #mpsoc_inst.add_port('maxigp1_awid',    'maxigp1_awid',    width=16)           # // output wire [15 : 0] maxigp1_awid
        #mpsoc_inst.add_port('maxigp1_awaddr',  'maxigp1_awaddr',  width=40)       # // output wire [39 : 0] maxigp1_awaddr
        #mpsoc_inst.add_port('maxigp1_awlen',   'maxigp1_awlen',   width=8)         # // output wire [7 : 0] maxigp1_awlen
        #mpsoc_inst.add_port('maxigp1_awsize',  'maxigp1_awsize',  width=3)       # // output wire [2 : 0] maxigp1_awsize
        #mpsoc_inst.add_port('maxigp1_awburst', 'maxigp1_awburst', width=2)     # // output wire [1 : 0] maxigp1_awburst
        #mpsoc_inst.add_port('maxigp1_awlock',  'maxigp1_awlock')       # // output wire maxigp1_awlock
        #mpsoc_inst.add_port('maxigp1_awcache', 'maxigp1_awcache', width=4)     # // output wire [3 : 0] maxigp1_awcache
        #mpsoc_inst.add_port('maxigp1_awprot',  'maxigp1_awprot',  width=3)       # // output wire [2 : 0] maxigp1_awprot
        #mpsoc_inst.add_port('maxigp1_awvalid', 'maxigp1_awvalid')     # // output wire maxigp1_awvalid
        #mpsoc_inst.add_port('maxigp1_awuser',  'maxigp1_awuser',  width=16)       # // output wire [15 : 0] maxigp1_awuser
        #mpsoc_inst.add_port('maxigp1_awready', 'maxigp1_awready')     # // input wire maxigp1_awready
        #mpsoc_inst.add_port('maxigp1_wdata',   'maxigp1_wdata',   width=128)         # // output wire [127 : 0] maxigp1_wdata
        #mpsoc_inst.add_port('maxigp1_wstrb',   'maxigp1_wstrb',   width=16)         # // output wire [15 : 0] maxigp1_wstrb
        #mpsoc_inst.add_port('maxigp1_wlast',   'maxigp1_wlast')         # // output wire maxigp1_wlast
        #mpsoc_inst.add_port('maxigp1_wvalid',  'maxigp1_wvalid')       # // output wire maxigp1_wvalid
        #mpsoc_inst.add_port('maxigp1_wready',  'maxigp1_wready')       # // input wire maxigp1_wready
        #mpsoc_inst.add_port('maxigp1_bid',     'maxigp1_bid',     width=16)             # // input wire [15 : 0] maxigp1_bid
        #mpsoc_inst.add_port('maxigp1_bresp',   'maxigp1_bresp',   width=2)         # // input wire [1 : 0] maxigp1_bresp
        #mpsoc_inst.add_port('maxigp1_bvalid',  'maxigp1_bvalid')       # // input wire maxigp1_bvalid
        #mpsoc_inst.add_port('maxigp1_bready',  'maxigp1_bready')       # // output wire maxigp1_bready
        #mpsoc_inst.add_port('maxigp1_arid',    'maxigp1_arid',    width=16)           # // output wire [15 : 0] maxigp1_arid
        #mpsoc_inst.add_port('maxigp1_araddr',  'maxigp1_araddr',  width=40)       # // output wire [39 : 0] maxigp1_araddr
        #mpsoc_inst.add_port('maxigp1_arlen',   'maxigp1_arlen',   width=8)         # // output wire [7 : 0] maxigp1_arlen
        #mpsoc_inst.add_port('maxigp1_arsize',  'maxigp1_arsize',  width=3)       # // output wire [2 : 0] maxigp1_arsize
        #mpsoc_inst.add_port('maxigp1_arburst', 'maxigp1_arburst', width=2)     # // output wire [1 : 0] maxigp1_arburst
        #mpsoc_inst.add_port('maxigp1_arlock',  'maxigp1_arlock')       # // output wire maxigp1_arlock
        #mpsoc_inst.add_port('maxigp1_arcache', 'maxigp1_arcache', width=4)     # // output wire [3 : 0] maxigp1_arcache
        #mpsoc_inst.add_port('maxigp1_arprot',  'maxigp1_arprot',  width=3)       # // output wire [2 : 0] maxigp1_arprot
        #mpsoc_inst.add_port('maxigp1_arvalid', 'maxigp1_arvalid')     # // output wire maxigp1_arvalid
        #mpsoc_inst.add_port('maxigp1_aruser',  'maxigp1_aruser',  width=16)       # // output wire [15 : 0] maxigp1_aruser
        #mpsoc_inst.add_port('maxigp1_arready', 'maxigp1_arready')     # // input wire maxigp1_arready
        #mpsoc_inst.add_port('maxigp1_rid',     'maxigp1_rid',     width=16)             # // input wire [15 : 0] maxigp1_rid
        #mpsoc_inst.add_port('maxigp1_rdata',   'maxigp1_rdata',   width=128)         # // input wire [127 : 0] maxigp1_rdata
        #mpsoc_inst.add_port('maxigp1_rresp',   'maxigp1_rresp',   width=2)         # // input wire [1 : 0] maxigp1_rresp
        #mpsoc_inst.add_port('maxigp1_rlast',   'maxigp1_rlast')         # // input wire maxigp1_rlast
        #mpsoc_inst.add_port('maxigp1_rvalid',  'maxigp1_rvalid')       # // input wire maxigp1_rvalid
        #mpsoc_inst.add_port('maxigp1_rready',  'maxigp1_rready')       # // output wire maxigp1_rready
        #mpsoc_inst.add_port('maxigp1_awqos',   'maxigp1_awqos',   width=4)         # // output wire [3 : 0] maxigp1_awqos
        #mpsoc_inst.add_port('maxigp1_arqos',   'maxigp1_arqos',   width=4)         # // output wire [3 : 0] maxigp1_arqos
        mpsoc_inst.add_port('pl_ps_irq0', "1'b0")               # // input wire [0 : 0] pl_ps_irq0 # TODO: remove IRQ or make note
        mpsoc_inst.add_port('pl_resetn0', 'pl_resetn0')               # // output wire pl_resetn0
        mpsoc_inst.add_port('pl_clk0', 'pl_clk0')                      #  // output wire pl_clk0

        # instantiate axi protocol converter to sys block
        axi_proto_0_inst = top.get_instance('axi_protocol_converter', 'axi_protocol_converter_0_inst')
        axi_proto_0_inst.add_port('aclk',          'pl_clk0', parent_sig=False)#// input wire aclk
        axi_proto_0_inst.add_port('aresetn',       'interconnect_aresetn', parent_sig=False)#// input wire aresetn
        axi_proto_0_inst.add_port('s_axi_awid',    'maxigp0_awid', parent_sig=False)   #// input wire [15 : 0] s_axi_awid   
        axi_proto_0_inst.add_port('s_axi_awaddr',  'maxigp0_awaddr', parent_sig=False) #// input wire [39 : 0] s_axi_awaddr
        axi_proto_0_inst.add_port('s_axi_awlen',   'maxigp0_awlen', parent_sig=False)  #// input wire [7 : 0] s_axi_awlen
        axi_proto_0_inst.add_port('s_axi_awsize',  'maxigp0_awsize', parent_sig=False) #// input wire [2 : 0] s_axi_awsize
        axi_proto_0_inst.add_port('s_axi_awburst', 'maxigp0_awburst', parent_sig=False)#// input wire [1 : 0] s_axi_awburst
        axi_proto_0_inst.add_port('s_axi_awlock',  'maxigp0_awlock', parent_sig=False) #// input wire [0 : 0] s_axi_awlock
        axi_proto_0_inst.add_port('s_axi_awcache', 'maxigp0_awcache', parent_sig=False)#// input wire [3 : 0] s_axi_awcache
        axi_proto_0_inst.add_port('s_axi_awprot',  'maxigp0_awprot', parent_sig=False) #// input wire [2 : 0] s_axi_awprot
        axi_proto_0_inst.add_port('s_axi_awregion',"4'b0000", parent_sig=False)#// input wire [3 : 0] s_axi_awregion #TODO: note, mpsoc did not have a connection
        axi_proto_0_inst.add_port('s_axi_awqos',   'maxigp0_awqos', parent_sig=False)#// input wire [3 : 0] s_axi_awqos
        axi_proto_0_inst.add_port('s_axi_awvalid', 'maxigp0_awvalid', parent_sig=False)#// input wire s_axi_awvalid
        axi_proto_0_inst.add_port('s_axi_awready', 'maxigp0_awready', parent_sig=False)#// output wire s_axi_awready
        axi_proto_0_inst.add_port('s_axi_wdata',   'maxigp0_wdata', parent_sig=False)#// input wire [31 : 0] s_axi_wdata
        axi_proto_0_inst.add_port('s_axi_wstrb',   'maxigp0_wstrb', parent_sig=False)#// input wire [3 : 0] s_axi_wstrb
        axi_proto_0_inst.add_port('s_axi_wlast',   'maxigp0_wlast', parent_sig=False)#// input wire s_axi_wlast
        axi_proto_0_inst.add_port('s_axi_wvalid',  'maxigp0_wvalid', parent_sig=False)#// input wire s_axi_wvalid
        axi_proto_0_inst.add_port('s_axi_wready',  'maxigp0_wready', parent_sig=False)#// output wire s_axi_wready
        axi_proto_0_inst.add_port('s_axi_bid',     'maxigp0_bid', parent_sig=False)#// output wire [15 : 0] s_axi_bid
        axi_proto_0_inst.add_port('s_axi_bresp',   'maxigp0_bresp', parent_sig=False)#// output wire [1 : 0] s_axi_bresp
        axi_proto_0_inst.add_port('s_axi_bvalid',  'maxigp0_bvalid', parent_sig=False)#// output wire s_axi_bvalid
        axi_proto_0_inst.add_port('s_axi_bready',  'maxigp0_bready', parent_sig=False)#// input wire s_axi_bready
        axi_proto_0_inst.add_port('s_axi_arid',    'maxigp0_arid', parent_sig=False)#// input wire [15 : 0] s_axi_arid
        axi_proto_0_inst.add_port('s_axi_araddr',  'maxigp0_araddr', parent_sig=False)#// input wire [39 : 0] s_axi_araddr
        axi_proto_0_inst.add_port('s_axi_arlen',   'maxigp0_arlen', parent_sig=False)#// input wire [7 : 0] s_axi_arlen
        axi_proto_0_inst.add_port('s_axi_arsize',  'maxigp0_arsize', parent_sig=False)#// input wire [2 : 0] s_axi_arsize
        axi_proto_0_inst.add_port('s_axi_arburst', 'maxigp0_arburst', parent_sig=False)#// input wire [1 : 0] s_axi_arburst
        axi_proto_0_inst.add_port('s_axi_arlock',  'maxigp0_arburst', parent_sig=False)#// input wire [0 : 0] s_axi_arlock
        axi_proto_0_inst.add_port('s_axi_arcache', 'maxigp0_arcache', parent_sig=False)#// input wire [3 : 0] s_axi_arcache
        axi_proto_0_inst.add_port('s_axi_arprot',  'maxigp0_arprot',  parent_sig=False)#// input wire [2 : 0] s_axi_arprot
        axi_proto_0_inst.add_port('s_axi_arregion',"4'b0000", parent_sig=False)#// input wire [3 : 0] s_axi_arregion # TODO: note, mpsoc did not have a connection
        axi_proto_0_inst.add_port('s_axi_arqos',   'maxigp0_arqos',   parent_sig=False)#// input wire [3 : 0] s_axi_arqos
        axi_proto_0_inst.add_port('s_axi_arvalid', 'maxigp0_arvalid', parent_sig=False)#// input wire s_axi_arvalid
        axi_proto_0_inst.add_port('s_axi_arready', 'maxigp0_arready', parent_sig=False)#// output wire s_axi_arready
        axi_proto_0_inst.add_port('s_axi_rid',     'maxigp0_rid',     parent_sig=False)#// output wire [15 : 0] s_axi_rid
        axi_proto_0_inst.add_port('s_axi_rdata',   'maxigp0_rdata',   parent_sig=False)#// output wire [31 : 0] s_axi_rdata
        axi_proto_0_inst.add_port('s_axi_rresp',   'maxigp0_rresp',   parent_sig=False)#// output wire [1 : 0] s_axi_rresp
        axi_proto_0_inst.add_port('s_axi_rlast',   'maxigp0_rlast',   parent_sig=False)#// output wire s_axi_rlast
        axi_proto_0_inst.add_port('s_axi_rvalid',  'maxigp0_rvalid',  parent_sig=False)#// output wire s_axi_rvalid
        axi_proto_0_inst.add_port('s_axi_rready',  'maxigp0_rready',  parent_sig=False)#// input wire s_axi_rready

        axi_proto_0_inst.add_port('m_axi_awaddr',  'M_AXI_awaddr', width=40)#// output wire [39 : 0] m_axi_awaddr
        axi_proto_0_inst.add_port('m_axi_awprot',  'M_AXI_awprot', width=3)#// output wire [2 : 0] m_axi_awprot
        axi_proto_0_inst.add_port('m_axi_awvalid', 'M_AXI_awvalid')#// output wire m_axi_awvalid
        axi_proto_0_inst.add_port('m_axi_awready', 'M_AXI_awready')#// input wire m_axi_awready
        axi_proto_0_inst.add_port('m_axi_wdata',   'M_AXI_wdata', width=32)#// output wire [31 : 0] m_axi_wdata
        axi_proto_0_inst.add_port('m_axi_wstrb',   'M_AXI_wstrb', width=4)#// output wire [3 : 0] m_axi_wstrb
        axi_proto_0_inst.add_port('m_axi_wvalid',  'M_AXI_wvalid')#// output wire m_axi_wvalid
        axi_proto_0_inst.add_port('m_axi_wready',  'M_AXI_wready')#// input wire m_axi_wready
        axi_proto_0_inst.add_port('m_axi_bresp',   'M_AXI_bresp', width=2)#// input wire [1 : 0] m_axi_bresp
        axi_proto_0_inst.add_port('m_axi_bvalid',  'M_AXI_bvalid')#// input wire m_axi_bvalid
        axi_proto_0_inst.add_port('m_axi_bready',  'M_AXI_bready')#// output wire m_axi_bready
        axi_proto_0_inst.add_port('m_axi_araddr',  'M_AXI_araddr', width=40)#// output wire [39 : 0] m_axi_araddr
        axi_proto_0_inst.add_port('m_axi_arprot',  'M_AXI_arprot', width=3)#// output wire [2 : 0] m_axi_arprot
        axi_proto_0_inst.add_port('m_axi_arvalid', 'M_AXI_arvalid')#// output wire m_axi_arvalid
        axi_proto_0_inst.add_port('m_axi_arready', 'M_AXI_arready')#// input wire m_axi_arready
        axi_proto_0_inst.add_port('m_axi_rdata',   'M_AXI_rdata', width=32)#// input wire [31 : 0] m_axi_rdata
        axi_proto_0_inst.add_port('m_axi_rresp',   'M_AXI_rresp', width=2)#// input wire [1 : 0] m_axi_rresp
        axi_proto_0_inst.add_port('m_axi_rvalid',  'M_AXI_rvalid')#// input wire m_axi_rvalid
        axi_proto_0_inst.add_port('m_axi_rready',  'M_AXI_rready')#// output wire m_axi_rready

        # instantiate processor reset
        proc_rst_inst = top.get_instance('processor_reset', 'processor_reset_inst')  #// input wire slowest_sync_clk
        proc_rst_inst.add_port('slowest_sync_clk',     'pl_clk0', parent_sig=False) #// input wire ex_reset_in
        proc_rst_inst.add_port('ext_reset_in',         'pl_resetn0', parent_sig=False) #// input wire aux_reset_in
        proc_rst_inst.add_port('aux_reset_in',         "1'b1") #// input wire aux_reset_in
        proc_rst_inst.add_port('mb_debug_sys_rst',     "1'b0") #// input wire mb_debug_sys_rst
        proc_rst_inst.add_port('dcm_locked',           "1'b1") #// input wire dcm_locked # TODO: if an MMCM produces the clk into this block should add the locked signal
        proc_rst_inst.add_port('mb_reset',             'mb_reset') #// output wire mb_reset
        proc_rst_inst.add_port('bus_struct_reset',     'bus_struct_reset') #// output wire [0 : 0] bus_struct_reset
        proc_rst_inst.add_port('peripheral_reset',     'peripheral_reset') #// output wire [0 : 0] peripheral_reset
        proc_rst_inst.add_port('interconnect_aresetn', 'interconnect_aresetn') #// output wire [0 : 0] interconnect_aresetn
        proc_rst_inst.add_port('peripheral_aresetn',   'peripheral_aresetn') #// output wire [0: 0] peripheral_aresetn


    def gen_children(self):
        children = []
        children.append(YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform))
        # gonna just put in the zcu216 for now then compartamentalize
        #children.append(YellowBlock.make_block({'tag': 'xps:zynq_usplus'}, self.platform))
        #children.append(YellowBlock.make_block({'tag': 'xps:axi_protocol_converter'}, self.platform))

        return children


    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('pl_clk_p', 'pl_clk_p'))
        #cons.append(PortConstraint('clk_100_p', 'clk_100_p'))
        #cons.append(ClockConstraint('clk_100_p','clk_100_p', period=10.0, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=5.0))
        #cons.append(ClockGroupConstraint('clk_pl_0', 'clk_100_p', 'asynchronous'))
        #cons.append(ClockGroupConstraint('clk_100_p', 'clk_pl_0', 'asynchronous'))
        return cons


    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['init'] = []

        tcl_cmds['pre_synth'] = []
        # If children were recursively generated added tcl commands then platform dependent mpsoc (and other) configuration could be added here.
        # add the mpsoc
        tcl_cmds['pre_synth'] += ['create_ip -name zynq_ultra_ps_e -vendor xilinx.com -library ip -version * -module_name mpsoc']
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/zynq/config_mpsoc_zcu216.tcl')]
        tcl_cmds['pre_synth'] += ['generate_target all [get_ips mpsoc]']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        # add a protocol converter for use between the mpsoc and sys block/RFDC
        tcl_cmds['pre_synth'] += ['create_ip -name axi_protocol_converter -vendor xilinx.com -library ip -version * -module_name axi_protocol_converter']
        tcl_cmds['pre_synth'] += ['puts "I am an axi protocol converter teapot"']
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.ADDR_WIDTH {40}\\'] # TODO: note, sys block has width 32, but mpsoc set at 40
        tcl_cmds['pre_synth'] += ['CONFIG.ARUSER_WIDTH {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.AWUSER_WIDTH {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.BUSER_WIDTH  {0}\\']
        #tcl_cmds['pre_synth'] += ['CONFIG.CLK.FREQ_HZ  10000000']
        #tcl_cmds['pre_synth'] += ['CONFIG.CLK.INSERT_VIP 0']
        #tcl_cmds['pre_synth'] += ['CONFIG.Component_Name axi_protocol_converter_0']
        tcl_cmds['pre_synth'] += ['CONFIG.DATA_WIDTH {32}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.ID_WIDTH {16}\\'] # TODO: note, default 0 but mpsoc is config at 16
        tcl_cmds['pre_synth'] += ['CONFIG.MI_PROTOCOL {AXI4LITE}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.M_AXI.INSERT_VIP {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.READ_WRITE_MODE  {READ_WRITE}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.RST.INSERT_VIP {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.RUSER_WIDTH  {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.SI_PROTOCOL  {AXI4}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.S_AXI.INSERT_VIP {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.TRANSLATION_MODE {2}\\'] # split incompatible burts into multiple transactions
        tcl_cmds['pre_synth'] += ['CONFIG.WUSER_WIDTH  {0}\\']
        tcl_cmds['pre_synth'] += ['] [get_ips axi_protocol_converter]']
        tcl_cmds['pre_synth'] += ['generate_target all [get_ips axi_protocol_converter]']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        # add processor reset
        tcl_cmds['pre_synth'] += ['create_ip -name proc_sys_reset -vendor xilinx.com -library ip -version * -module_name processor_reset']
        tcl_cmds['pre_synth'] += ['set_property -dict [list CONFIG.C_AUX_RESET_HIGH {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.C_AUX_RST_WIDTH {4}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.C_EXT_RESET_HIGH {0}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.C_EXT_RST_WIDTH {4}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.C_NUM_BUS_RST {1}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.C_NUM_INTERCONNECT_ARESETN {1}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.C_NUM_PERP_ARESETN {1}\\']
        tcl_cmds['pre_synth'] += ['CONFIG.C_NUM_PERP_RST {1}\\']
        tcl_cmds['pre_synth'] += ['] [get_ips processor_reset]']
        tcl_cmds['pre_synth'] += ['generate_target all [get_ips processor_reset]']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']

        tcl_cmds['synth'] = []

        tcl_cmds['post_synth'] = []
        # TODO: make note of how to use HD bank clocks to drive an MMCM on US+
        #tcl_cmds['post_synth'] += ['set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_100_p]']
        tcl_cmds['post_synth'] += ['set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pl_clk_p]']

        return tcl_cmds
