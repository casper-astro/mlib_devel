from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint


class rfsoc4x2(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/zcu216_clk_infrastructure.sv')
        self.add_source('utils/cdc_synchroniser.vhd')

        # create reference to block design name
        """
        If I continue to remain uneasy about this approach to integration of a block design consider then the
        thought I had about giving the block design a name in the the platform simulink yb. Either hardcode it there
        as a place holder or allow it to even be text field that the user can chose to select its name.

        wait... because the above not my work. So, i guess the real hangup I have is that that the platform.conf and the xsg platform yellowblock
        have two different origins and scopes. With the platform.conf coming from the yaml and accessible from all instanced yellowblocks.  whereas
        the information from xsg platform yb can only be accessed in this moment here. And so it is a choice about where to put block design
        naming/source information and tradeoffs associated with tat
        """
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

        # TODO? probably needs to add a requires "M_AXI"???

    def modify_top(self, top):
        top.assign_signal('axil_clk', 'pl_sys_clk')
        #top.assign_signal('axil_rst', 'axil_rst')
        top.assign_signal('axil_rst_n', 'axil_arst_n') # TODO RENAME the board design one `axil_arst_n`
        top.assign_signal('sys_clk', 'pl_sys_clk')
        top.assign_signal('sys_rst', '~axil_arst_n')

        # generate clock parameters to use pl_clk to drive as the user IP clock
        # TODO: will need to make changes when other user ip clk source options provided
        clkparams = clk_factors(self.pl_clk_mhz, self.platform.user_clk_rate, vco_min=800.0, vco_max=1600.0)
        print("clkparam", clkparams)
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

        # TODO these were moved to the zynq_usplus design but it is clear that there is a choice
        # to be made about how ports that are to be made external need to be known at the time of modify top
        # and so this makes an argument for the platform file being the one where we wire everything up
        # because we are making the decisions about what is being placed or not

        # this platform will use a Vivado block design, create an instance of the block design wrapper in the top
        #bd_inst = top.get_instance(self.blkdesign, '{:s}_inst'.format(self.blkdesign))

    def modify_bd(self, bd):
      print("***** {:s}, modify block design *****".format(self.name))
      # interesting that nothing ends up here? is that a problem?
      # perhaps, it seems this is where we need wire everything up?

      # there is an argument that the board design should add the external ports (back to wiring everything up)
      # because take the zcu216 where we send the GPIO output two two places (to the spi mux and just some LEDs)
      # this seems like it could be challenging to get the GPIO to programmatically handle this instead of knowing
      # it is just a manual specification when setting up the platform file
      # and to some extent, this might keep all the interface stuff out of the block constructor and can just be a
      # platform-level block design api thing.


    def gen_children(self):
        children = []
        children.append(YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '160', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform))

        """
        intf = {
          # most interfaces will be aware to create type, mode, path
          'type': # aware
          'mode': # aware
          'port_net_name'/'path': # aware
          'dest': # must be specified
          'clk_src': # default to `pl_sys_clk` unless overridden
          'clk_net_name': #aware
          'rst_src': # default to `axil_rstn` unless overriden
          'rst_net_name': # aware
        }
        """
        zynq_blk = {
            'tag'     : 'xps:zynq_usplus',
            'name'    : 'mpsoc',
            'presets' : 'rfsoc4x2_mpsoc',
            'maxi_0'  : {'conf': {'enable': 1, 'data_width': 32},  'intf': {'dest': 'axi_proto_conv/S_AXI'}},
            'maxi_1'  : {'conf': {'enable': 0, 'data_width': 128}, 'intf': {'dest': 'axi_interconnect/S00_AXI'}},
            'maxi_2'  : {'conf': {'enable': 0, 'data_width': 128}, 'intf': {}}
            #'maxi_2'  : {'conf': {'enable': 1, 'data_width': 128}, 'intf': {'dest': 'M_AXI_0'}}
            #'maxi_0'  : {'enable': 1, 'dest_intf': 'axi_proto_conv/S_AXI', 'data_width': 32},
            #'maxi_1'  : {'enable': 1, 'dest_intf': 'axi_interconnect/S00_AXI', 'data_width': 128},
            #'maxi_2'  : {'enable': 1, 'dest_intf': 'M_AXI_0', 'data_width': 128}
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

       ## test adding an AXI GPIO for when adding to the zcu216/208
       # axi_icx_blk = {
       #   'tag'      : 'xps:axi_interconnect',
       #   'name'     : 'axi_icx',
       #   'saxi_intf': [{'dest': 'mpsoc/M_AXI_HPM1_FPD'}],
       #   'maxi_intf': [{'dest': 'gpio/S_AXI'}],
       #   'num_mi'   : 1,
       #   'num_si'   : 1
       # }
       # children.append(YellowBlock.make_block(axi_icx_blk, self.platform))

       # axi_gpio_blk = {
       #   'tag'         : 'xps:axi_gpio',
       #   'name'        : 'gpio',
       #   'saxi_intf'   : {'dest': 'axi_icx/M00_AXI'},
       #   'gpio_intf'   : [{'dest': 'mux_led'}, {'dest': 'clk104_spi_mux_sel'}],
       #   'enable_dual' : 0,
       #   'enable_intr' : 0,
       #   'all_inputs'  : 0,
       #   'all_outputs' : 1,
       #   'gpio_width'  : 2,
       #   'default_val' : 0x00000003,
       #   'tri_default' : 0xffffffff,
       #   'all_inputs2' : 0,
       #   'all_outputs2': 0,
       #   'default_val2': 0x00000000,
       #   'gpio_width2' : 32,
       #   'tri_default2': 0xffffffff
       # }
       # children.append(YellowBlock.make_block(axi_gpio_blk, self.platform))

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
