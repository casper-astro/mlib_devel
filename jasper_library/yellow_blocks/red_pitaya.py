from .yellow_block import YellowBlock
from clk_factors import clk_factors
from constraints import ClockConstraint, ClockGroupConstraint, PortConstraint, RawConstraint


class red_pitaya(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/red_pitaya.v')
        self.add_source('utils/cdc_synchroniser.vhd')
        self.add_source('red_pitaya')
        self.provides = [
            "adc_clk",
            "dac_clk",
            "sys_clk",
            "sys_clk90",
            "sys_clk180",
            "sysclk_270",
        ]

    def modify_top(self,top):
        inst = top.get_instance('red_pitaya', 'red_pitaya_inst')
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
        
        clk_factors
        clkparams = clk_factors(125, self.platform.user_clk_rate)

        inst_infr = top.get_instance('red_pitaya_infrastructure', 'red_pitaya_infr_inst')
        inst_infr.add_parameter('MULTIPLY', clkparams[0])
        inst_infr.add_parameter('DIVIDE',   clkparams[1])
        inst_infr.add_parameter('DIVCLK',   clkparams[2])
        inst_infr.add_port('adc_clk_in',       "ADC_CLK_IN_P", dir='in',  width=1, parent_port=True)
        inst_infr.add_port('dsp_clk',          "sys_clk",      dir='out', width=1, parent_sig=False)
        inst_infr.add_port('dsp_clk_p90',      "sys_clk90",    dir='out', width=1, parent_sig=False)
        inst_infr.add_port('dsp_clk_p180',     "sys_clk180",   dir='out', width=1, parent_sig=False)
        inst_infr.add_port('dsp_clk_p270',     "sys_clk270",   dir='out', width=1, parent_sig=False)
        inst_infr.add_port('dsp_rst',          "sys_rst",      dir='out', width=1)
        inst_infr.add_port('adc_clk_125',      "adc_clk",      dir='out', width=1)
        inst_infr.add_port('adc_rst',          "adc_rst",      dir='out', width=1)
        inst_infr.add_port('dac_clk_250',      "dac_clk",      dir='out', width=1)
        inst_infr.add_port('dac_clk_250_p315', "dac_clk_p",    dir='out', width=1)
        inst_infr.add_port('dac_rst',          "dac_rst ",     dir='out', width=1)


    def gen_children(self):
        return [YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '4', 'rev_maj': '1', 'rev_min': '0', 'rev_rcs': '1'}, self.platform)]
        # return [YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform),
        #         YellowBlock.make_block({'tag': 'xps:AXI4LiteInterconnect', 'name': 'AXI4LiteInterconnect'}, self.platform)]

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('ADC_CLK_IN_P', 'ADC_CLK_IN_P'))
        cons.append(ClockConstraint('ADC_CLK_IN_P','ADC_CLK_IN_P', period=8.0, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=4.0))
        cons.append(ClockGroupConstraint('-of_objects [get_pins red_pitaya_infr_inst/dsp_clk_mmcm_inst/CLKOUT0]', '-of_objects [get_pins red_pitaya_inst/processing_system7_0/inst/PS7_i/FCLKCLK[0]]', 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins red_pitaya_inst/processing_system7_0/inst/PS7_i/FCLKCLK[0]]', '-of_objects [get_pins red_pitaya_infr_inst/dsp_clk_mmcm_inst/CLKOUT0]', 'asynchronous'))

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
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/infrastructure/red_pitaya.tcl')]
        tcl_cmds['pre_synth'] += ['generate_target all [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/red_pitaya/red_pitaya.bd]']        
        tcl_cmds['pre_synth'] += ['make_wrapper -files [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/bd/red_pitaya/red_pitaya.bd] -top']
        tcl_cmds['pre_synth'] += ['add_files -norecurse [get_property directory [current_project]]/myproj.srcs/sources_1/bd/red_pitaya/hdl/red_pitaya_wrapper.vhd']
        tcl_cmds['pre_synth'] += ['update_compile_order -fileset sources_1']
        return tcl_cmds
