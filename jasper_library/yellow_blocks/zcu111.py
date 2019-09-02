from yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint


class zcu111(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/zcu111_infrastructure.v')
        self.add_source('utils/cdc_synchroniser.vhd')
        #self.add_source('zcu111')

        self.provides.append(self.clk_src)
        self.provides.append(self.clk_src+'90')
        self.provides.append(self.clk_src+'180')
        self.provides.append(self.clk_src+'270')
        self.provides.append(self.clk_src+'_rst')

    def modify_top(self,top):
        inst = top.get_instance('zcu111', 'zcu111_inst')
        inst.add_port('axil_clk',   'axil_clk')
        inst.add_port('axil_rst',   'axil_rst')
        inst.add_port('axil_rst_n', 'axil_rst_n')

        inst.add_port('M_AXI_araddr', 'M_AXI_araddr', width=32)
        inst.add_port('M_AXI_arprot', 'M_AXI_arprot', width=3)
        inst.add_port('M_AXI_arready', 'M_AXI_arready')
        inst.add_port('M_AXI_arvalid', 'M_AXI_arvalid')
        inst.add_port('M_AXI_awaddr', 'M_AXI_awaddr', width=32)
        inst.add_port('M_AXI_awprot', 'M_AXI_awprot', width=3)
        inst.add_port('M_AXI_awready', 'M_AXI_awready')
        inst.add_port('M_AXI_awvalid', 'M_AXI_awvalid')
        inst.add_port('M_AXI_bready', 'M_AXI_bready')
        inst.add_port('M_AXI_bresp', 'M_AXI_bresp', width=2)
        inst.add_port('M_AXI_bvalid', 'M_AXI_bvalid')
        inst.add_port('M_AXI_rdata', 'M_AXI_rdata', width=32)
        inst.add_port('M_AXI_rready', 'M_AXI_rready')
        inst.add_port('M_AXI_rresp', 'M_AXI_rresp', width=2)
        inst.add_port('M_AXI_rvalid', 'M_AXI_rvalid')
        inst.add_port('M_AXI_wdata', 'M_AXI_wdata', width=32)
        inst.add_port('M_AXI_wready', 'M_AXI_wready')
        inst.add_port('M_AXI_wstrb', 'M_AXI_wstrb', width=4)
        inst.add_port('M_AXI_wvalid', 'M_AXI_wvalid')
        
        clkparams = clk_factors(100, self.platform.user_clk_rate)

        inst_infr = top.get_instance('zcu111_infrastructure', 'zcu111_infr_inst')
        inst_infr.add_parameter('MULTIPLY', clkparams[0])
        inst_infr.add_parameter('DIVIDE',   clkparams[1])
        inst_infr.add_parameter('DIVCLK',   clkparams[2])
        inst_infr.add_port('clk_100_p',      "clk_100_p", dir='in',  parent_port=True)
        inst_infr.add_port('clk_100_n',      "clk_100_n", dir='in',  parent_port=True)

        inst_infr.add_port('sys_clk      ', 'sys_clk   ')
        inst_infr.add_port('sys_clk90    ', 'sys_clk90 ')
        inst_infr.add_port('sys_clk180   ', 'sys_clk180')
        inst_infr.add_port('sys_clk270   ', 'sys_clk270')

        inst_infr.add_port('sys_clk_rst', 'sys_clk_rst')

    def gen_children(self):
        return [YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform)]
        # return [YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform),
        #         YellowBlock.make_block({'tag': 'xps:AXI4LiteInterconnect', 'name': 'AXI4LiteInterconnect'}, self.platform)]

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('clk_100_p', 'clk_100_p'))
        cons.append(ClockConstraint('clk_100_p','clk_100_p', period=10.0, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=5.0))
        cons.append(ClockGroupConstraint('clk_pl_0', 'clk_100_p', 'asynchronous'))
        cons.append(ClockGroupConstraint('clk_100_p', 'clk_pl_0', 'asynchronous'))



        return cons
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
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/infrastructure/zcu111.tcl')]
        tcl_cmds['pre_synth'] += ['generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/zcu111/zcu111.bd]']        
        tcl_cmds['pre_synth'] += ['make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/zcu111/zcu111.bd] -top']
        tcl_cmds['pre_synth'] += ['add_files -norecurse [get_property directory [current_project]]/myproj.srcs/sources_1/bd/zcu111/hdl/zcu111_wrapper.vhd']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        return tcl_cmds
