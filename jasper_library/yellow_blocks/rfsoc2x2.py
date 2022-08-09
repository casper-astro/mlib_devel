from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint


class rfsoc2x2(YellowBlock):
    def initialize(self):
        # TODO need any clocking infrastrucutre block - most likely can repurpose zcu216 but for htg clock pins
        self.add_source('infrastructure/zcu216_clk_infrastructure.sv')
        self.add_source('utils/cdc_synchroniser.vhd')

        self.blkdesign = '{:s}_bd'.format(self.platform.conf['name'])

        self.pl_clk_mhz = self.blk['pl_clk_rate']
        self.T_pl_clk_ns = 1.0/self.pl_clk_mhz*1000

        # TODO: need new provides and figure the extent to provide these, because as the documentation says
        # if these lines aren't here the the toolflow breaks.
        self.provides.append(self.clk_src)
        self.provides.append(self.clk_src+'90')
        self.provides.append(self.clk_src+'180')
        self.provides.append(self.clk_src+'270')
        self.provides.append(self.clk_src+'_rst')

        # TODO: Need to add this? Is it a bug that `axi4lite_interconnect.py` does not make a `requires` call
        self.provides.append('axil_clk')    # from zcu216 block design infrastructure
        self.provides.append('axil_rst_n')  # from zcu216 block desgin infrastructure

        # for the rfsocs it seems appropriate to use the requires/provides for `sysref` and `pl_sysref` for MTS?
        self.provides.append('pl_sysref') # zcu216 infrastructure provides so rfdc can require

    def modify_top(self, top):
        top.assign_signal('axil_clk', 'pl_clk0')
        top.assign_signal('axil_rst', 'peripheral_reset')
        top.assign_signal('axil_rst_n', 'peripheral_aresetn')

        # generate clock parameters to use pl_clk to drive as the user IP clock
        # TODO: will need to make changes when other user ip clk source options provided
        clkparams = clk_factors(self.pl_clk_mhz, self.platform.user_clk_rate, vco_min=800.0, vco_max=1600.0)

        inst_infr = top.get_instance('zcu216_clk_infrastructure', 'zcu216_clk_infr_inst')
        inst_infr.add_parameter('PERIOD', "{:0.3f}".format(self.T_pl_clk_ns))
        inst_infr.add_parameter('MULTIPLY', clkparams[0])
        inst_infr.add_parameter('DIVIDE',   clkparams[1])
        inst_infr.add_parameter('DIVCLK',   clkparams[2])
        inst_infr.add_port('pl_clk_p',      "pl_clk_p", dir='in',  parent_port=True)
        inst_infr.add_port('pl_clk_n',      "pl_clk_n", dir='in',  parent_port=True)

        inst_infr.add_port('adc_clk', 'adc_clk')
        inst_infr.add_port('adc_clk90', 'adc_clk90')
        inst_infr.add_port('adc_clk180', 'adc_clk180')
        inst_infr.add_port('adc_clk270', 'adc_clk270')
        inst_infr.add_port('mmcm_locked', 'mmcm_locked', dir='out')#, parent_sig=True)

        top.add_port('mmcm_locked_gpio', dir='out', width=1)
        top.assign_signal('mmcm_locked_gpio', '~mmcm_locked')

        # instance block design containing mpsoc, and axi protocol converter for casper mermory map (HPM0), axi gpio for software clk104
        # config (HPM1), and RFDC Xilinx IP (HPM1) that the rfdc yellow block will update based on user configuration
        bd_inst = top.get_instance(self.blkdesign, '{:s}_inst'.format(self.blkdesign))

        bd_inst.add_port('m_axi_awaddr',  'M_AXI_awaddr', width=40)
        bd_inst.add_port('m_axi_awprot',  'M_AXI_awprot', width=3)
        bd_inst.add_port('m_axi_awvalid', 'M_AXI_awvalid')
        bd_inst.add_port('m_axi_awready', 'M_AXI_awready')
        bd_inst.add_port('m_axi_wdata',   'M_AXI_wdata', width=32)
        bd_inst.add_port('m_axi_wstrb',   'M_AXI_wstrb', width=4)
        bd_inst.add_port('m_axi_wvalid',  'M_AXI_wvalid')
        bd_inst.add_port('m_axi_wready',  'M_AXI_wready')
        bd_inst.add_port('m_axi_bresp',   'M_AXI_bresp', width=2)
        bd_inst.add_port('m_axi_bvalid',  'M_AXI_bvalid')
        bd_inst.add_port('m_axi_bready',  'M_AXI_bready')
        bd_inst.add_port('m_axi_araddr',  'M_AXI_araddr', width=40)
        bd_inst.add_port('m_axi_arprot',  'M_AXI_arprot', width=3)
        bd_inst.add_port('m_axi_arvalid', 'M_AXI_arvalid')
        bd_inst.add_port('m_axi_arready', 'M_AXI_arready')
        bd_inst.add_port('m_axi_rdata',   'M_AXI_rdata', width=32)
        bd_inst.add_port('m_axi_rresp',   'M_AXI_rresp', width=2)
        bd_inst.add_port('m_axi_rvalid',  'M_AXI_rvalid')
        bd_inst.add_port('m_axi_rready',  'M_AXI_rready')

        bd_inst.add_port('pl_clk0', 'pl_clk0')
        bd_inst.add_port('peripheral_reset', 'peripheral_reset')
        bd_inst.add_port('peripheral_aresetn', 'peripheral_aresetn')


    def gen_children(self):
        children = []
        children.append(YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '165', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform))

        return children


    def gen_constraints(self):
        cons = []

        cons.append(ClockConstraint('pl_clk_p', 'pl_clk_p', period=self.T_pl_clk_ns, port_en=True, virtual_en=False))
        cons.append(PortConstraint('pl_clk_p', 'pl_clk_p'))
        # TODO: tweak this until we have the right reference clocks
        cons.append(ClockGroupConstraint('clk_pl_0', 'pl_clk_mmcm', 'asynchronous'))

        cons.append(RawConstraint('set_property -dict { PACKAGE_PIN AU12 IOSTANDARD LVCMOS18 } [get_ports { mmcm_locked_gpio }]'))
        # TODO: can extend to provide other onboard clocks
        #cons.append(PortConstraint('clk_100_p', 'clk_100_p'))
        #cons.append(ClockConstraint('clk_100_p','clk_100_p', period=10.0, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=5.0))
        #cons.append(ClockGroupConstraint('clk_pl_0', 'clk_100_p', 'asynchronous'))
        #cons.append(ClockGroupConstraint('clk_100_p', 'clk_pl_0', 'asynchronous'))
        return cons


    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['init'] = []
        # source tcl script building out the base block design that other yellow blocks (e.g., rfdc can access and
        # update based on user configuration
        tcl_cmds['init'] += ['source {:s}/infrastructure/{:s}.tcl'.format(self.hdl_root, self.blkdesign)]
        """
        Add a block design to project with wrapper via its exported tcl script.
          - Validate and save board design against all edits children yb made
          - Generate output products for all IP in block design
          - Have vivado make an HDL wrapper around the block design.
          - Add the wrapper HDL file to project.
        """
        tcl_cmds['pre_synth'] = []
        tcl_cmds['pre_synth'] += ['validate_bd_design']
        tcl_cmds['pre_synth'] += ['save_bd_design']
        tcl_cmds['pre_synth'] += ['generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/{:s}/{:s}.bd]'.format(self.blkdesign, self.blkdesign)]
        tcl_cmds['pre_synth'] += ['make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/{:s}/{:s}.bd] -top'.format(self.blkdesign, self.blkdesign)]
        tcl_cmds['pre_synth'] += ['add_files -norecurse [get_property directory [current_project]]/myproj.srcs/sources_1/bd/{:s}/hdl/{:s}_wrapper.vhd'.format(self.blkdesign, self.blkdesign)]
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']

        tcl_cmds['post_synth'] = []
        # TODO: I probably forgot to go through this and delete it, but shouldn't need to set this as `pl_clk_p` (FPGA_REFCLK_OUT) comes in
        # on a GC pin on bank 64 not a HDGC like on the 29dr. Need to delete and verify.
        #tcl_cmds['post_synth'] += ['set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_100_p]']
        #tcl_cmds['post_synth'] += ['set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pl_clk_p]']

        # export hardware design xsa for software
        tcl_cmds['post_bitgen'] = []
        # TODO: $xsa_file comes from the backends class. Could re-write the path here but $xsa_file exists, use it instead.
        # This then begs the question as to if there should be some sort of known tcl variables to check against
        tcl_cmds['post_bitgen'] += ['write_hw_platform -fixed -include_bit -force -file $xsa_file']

        return tcl_cmds


