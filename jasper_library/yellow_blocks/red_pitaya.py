from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint


class red_pitaya(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/red_pitaya.v')
        self.add_source('red_pitaya')

    def modify_top(self,top):
        inst = top.get_instance('red_pitaya_wrapper', 'red_pitaya_wrapper_inst')
        inst.add_port('sys_clk', 'axi_clk')
        inst.add_port('peripheral_areset_n', 'peripheral_areset_n')

        # for i in range(top.n_axi4lite_interfaces):
        for i in range(1):
            inst.add_port('M_%s_AXI_araddr'%i, 'M_%s_AXI_araddr'%i, width=31)
            inst.add_port('M_%s_AXI_arprot'%i, 'M_%s_AXI_arprot'%i, width=3)
            inst.add_port('M_%s_AXI_arready'%i, 'M_%s_AXI_arready'%i)
            inst.add_port('M_%s_AXI_arvalid'%i, 'M_%s_AXI_arvalid'%i)
            inst.add_port('M_%s_AXI_awaddr'%i, 'M_%s_AXI_awaddr'%i, width=31)
            inst.add_port('M_%s_AXI_awprot'%i, 'M_%s_AXI_awprot'%i, width=3)
            inst.add_port('M_%s_AXI_awready'%i, 'M_%s_AXI_awready'%i)
            inst.add_port('M_%s_AXI_awvalid'%i, 'M_%s_AXI_awvalid'%i)
            inst.add_port('M_%s_AXI_bready'%i, 'M_%s_AXI_bready'%i)
            inst.add_port('M_%s_AXI_bresp'%i, 'M_%s_AXI_bresp'%i, width=2)
            inst.add_port('M_%s_AXI_bvalid'%i, 'M_%s_AXI_bvalid'%i)
            inst.add_port('M_%s_AXI_rdata'%i, 'M_%s_AXI_rdata'%i, width=32)
            inst.add_port('M_%s_AXI_rready'%i, 'M_%s_AXI_rready'%i)
            inst.add_port('M_%s_AXI_rresp'%i, 'M_%s_AXI_rresp'%i, width=2)
            inst.add_port('M_%s_AXI_rvalid'%i, 'M_%s_AXI_rvalid'%i)
            inst.add_port('M_%s_AXI_wdata'%i, 'M_%s_AXI_wdata'%i, width=32)
            inst.add_port('M_%s_AXI_wready'%i, 'M_%s_AXI_wready'%i)
            inst.add_port('M_%s_AXI_wstrb'%i, 'M_%s_AXI_wstrb'%i, width=4)
            inst.add_port('M_%s_AXI_wvalid'%i, 'M_%s_AXI_wvalid'%i)

    def gen_children(self):
        return [YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform)]
        # return []

    def gen_constraints(self):
        return []
        #const_list = [
        #     RawConstraint('set_property CONFIG_MODE BPI16 [current_design]'),
        #     RawConstraint('set_property CONFIG_VOLTAGE %.1f [current_design]' % self.platform.conf['config_voltage']),
        #     RawConstraint('set_property CFGBVS %s [current_design]' % self.platform.conf['cfgbvs']),
        #     RawConstraint('set_property BITSTREAM.STARTUP.STARTUPCLK CCLK [current_design]'),
        #     RawConstraint('set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]'),
        #     RawConstraint('set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]'),
        #     RawConstraint('set_property BITSTREAM.CONFIG.TIMER_CFG 0X00040000 [current_design]')]
        #if self.platform.boot_image == 'golden':
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DISABLE [current_design]'))
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.BPI_SYNC_MODE DISABLE [current_design]'))
        #else:
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-2 [current_design]'))
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.BPI_SYNC_MODE TYPE1 [current_design]'))

        #return const_list

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
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/infrastructure/red_pitaya.tcl')]
        tcl_cmds['pre_synth'] += ['generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/red_pitaya/red_pitaya.bd]']        
        tcl_cmds['pre_synth'] += ['make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/red_pitaya/red_pitaya.bd] -top']
        tcl_cmds['pre_synth'] += ['add_files -norecurse [get_property directory [current_project]]/myproj.srcs/sources_1/bd/red_pitaya/hdl/red_pitaya_wrapper.vhd']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        return tcl_cmds