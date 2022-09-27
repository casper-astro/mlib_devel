from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint


class rfsoc4x2(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/zcu216_clk_infrastructure.sv')
        self.add_source('utils/cdc_synchroniser.vhd')

        # create reference to block design name
        self.blkdesign = '{:s}_bd'.format(self.platform.conf['name'])

        self.pl_clk_mhz = self.blk['pl_clk_rate']
        self.T_pl_clk_ns = 1.0/self.pl_clk_mhz*1000

        self.provides.append('adc_clk')
        self.provides.append('adc_clk90')
        self.provides.append('adc_clk180')
        self.provides.append('adc_clk270')
        self.provides.append('adc_clk_rst')

        self.provides.append('sys_clk')
        self.provides.append('sys_rst')

        # TODO: is a bug that `axi4lite_interconnect` does not make a `requires` on `axil_clk`.
        # Looking into this more: the `_drc` check on YB requires/provides is done in `gen_periph_objs` but the `axi4lite_interconnect`
        # is not done until later within `generate_hdl > _instantiate_periphs`, therefore, by-passing any checks done.
        self.provides.append('axil_clk')    # from block design
        self.provides.append('axil_rst_n')  # from block desgin

        # rfsocs use the requires/provides for to check for `sysref` and `pl_sysref` for MTS
        self.provides.append('pl_sysref') # rfsoc platform/infrastructure provides so rfdc can require

        self.requires.append('M_AXI') # axi4lite interface from block design

    def modify_top(self, top):
        top.assign_signal('axil_clk', 'pl_sys_clk')
        #top.assign_signal('axil_rst', 'axil_rst')
        top.assign_signal('axil_rst_n', 'axil_arst_n') # TODO RENAME the board design one `axil_arst_n`
        top.assign_signal('sys_clk', 'pl_sys_clk')
        top.assign_signal('sys_rst', '~axil_arst_n')

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
        inst_infr.add_port('mmcm_locked', 'mmcm_locked', dir='out', parent_port=True)

    def gen_children(self):
        children = []
        children.append(YellowBlock.make_block({'fullpath': self.fullpath, 'tag': 'xps:sys_block', 'board_id': '166', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform))

        # instance block design containing mpsoc, and axi protocol converter for casper
        # mermory map (HPM0)
        zynq_blk = {
            'tag'     : 'xps:zynq_usplus',
            'name'    : 'mpsoc',
            'presets' : 'rfsoc4x2_mpsoc',
            'maxi_0'  : {'conf': {'enable': 1, 'data_width': 32},  'intf': {'dest': 'axi_proto_conv/S_AXI'}},
            'maxi_1'  : {'conf': {'enable': 0, 'data_width': 128}, 'intf': {}},
            'maxi_2'  : {'conf': {'enable': 0, 'data_width': 128}, 'intf': {}}
            #'maxi_2'  : {'conf': {'enable': 1, 'data_width': 128}, 'intf': {'dest': 'M_AXI_0'}}
        }
        children.append(YellowBlock.make_block(zynq_blk, self.platform))

        proto_conv_blk = {
            'tag'             : 'xps:axi_protocol_converter',
            'name'            : 'axi_proto_conv',
            'saxi_intf'       : {'dest': 'mpsoc/M_AXI_HPM0_FPD'},
            'maxi_intf'       : {'dest': 'M_AXI'},
            'aruser_wid'      : 0,
            'awuser_wid'      : 0,
            'buser_wid'       : 0,
            'data_wid'        : 32,
            'id_wid'          : 16,
            'mi_protocol'     : 'AXI4LITE',
            'rw_mode'         : 'READ_WRITE',
            'ruser_wid'       : 0,
            'si_protocol'     : 'AXI4',
            'translation_mode': 2,
            'wuser_wid'       : 0
        }
        children.append(YellowBlock.make_block(proto_conv_blk, self.platform))
        return children


    def gen_constraints(self):
        cons = []
        cons.append(ClockConstraint('pl_clk_p', 'pl_clk_p', period=self.T_pl_clk_ns, port_en=True, virtual_en=False))
        cons.append(PortConstraint('pl_clk_p', 'pl_clk_p'))

        cons.append(ClockGroupConstraint('clk_pl_0', 'pl_clk_mmcm', 'asynchronous'))

        cons.append(RawConstraint('set_property -dict { PACKAGE_PIN AU10 IOSTANDARD LVCMOS18 } [get_ports { mmcm_locked }]'))

        return cons


    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['init'] = []
        tcl_cmds['create_bd'] = []
        tcl_cmds['pre_synth'] = []

        # export hardware design xsa for software
        tcl_cmds['post_bitgen'] = []
        # TODO: $xsa_file comes from the backends class. Could re-write the path here but $xsa_file exists, use it instead.
        # This then begs the question as to if there should be some sort of known tcl variables to check against
        tcl_cmds['post_bitgen'] += ['write_hw_platform -fixed -include_bit -force -file $xsa_file']

        return tcl_cmds
