from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint


class red_pitaya(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/red_pitaya.v')
        self.add_source('red_pitaya')

    def modify_top(self,top):
        inst = top.get_instance('red_pitaya_wrapper', 'red_pitaya_wrapper_inst')
        inst.add_port('sys_clk', 'sys_clk')

        # Need this for each interface exposed... will put in loop later
        inst.add_port('M00_AXI_0_araddr', 'M00_AXI_0_araddr', width=31)
        inst.add_port('M00_AXI_0_arprot', 'M00_AXI_0_arprot', width=3)
        inst.add_port('M00_AXI_0_arready', 'M00_AXI_0_arready')
        inst.add_port('M00_AXI_0_arvalid', 'M00_AXI_0_arvalid')
        inst.add_port('M00_AXI_0_awaddr', 'M00_AXI_0_awaddr', width=31)
        inst.add_port('M00_AXI_0_awprot', 'M00_AXI_0_awprot', width=3)
        inst.add_port('M00_AXI_0_awready', 'M00_AXI_0_awready')
        inst.add_port('M00_AXI_0_awvalid', 'M00_AXI_0_awvalid')
        inst.add_port('M00_AXI_0_bready', 'M00_AXI_0_bready')
        inst.add_port('M00_AXI_0_bresp', 'M00_AXI_0_bresp', width=2)
        inst.add_port('M00_AXI_0_bvalid', 'M00_AXI_0_bvalid')
        inst.add_port('M00_AXI_0_rdata', 'M00_AXI_0_rdata', width=32)
        inst.add_port('M00_AXI_0_rready', 'M00_AXI_0_rready')
        inst.add_port('M00_AXI_0_rresp', 'M00_AXI_0_rresp', width=2)
        inst.add_port('M00_AXI_0_rvalid', 'M00_AXI_0_rvalid')
        inst.add_port('M00_AXI_0_wdata', 'M00_AXI_0_wdata', width=32)
        inst.add_port('M00_AXI_0_wready', 'M00_AXI_0_wready')
        inst.add_port('M00_AXI_0_wstrb', 'M00_AXI_0_wstrb', width=4)
        inst.add_port('M00_AXI_0_wvalid', 'M00_AXI_0_wvalid')

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