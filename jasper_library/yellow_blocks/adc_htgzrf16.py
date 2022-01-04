from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint
from memory import Register
import re

class adc_htgzrf16(YellowBlock):
    def initialize(self):
        self.provides = ['adc_clk', 'adc_clk90', 'adc_clk180', 'adc_clk270']
        self.add_source('rfdc/rfdc_2048.xci')
        pass

    def make_ip_tcl(self):
        config = {
            'ADC0_PLL_Enable': 'true',
            'ADC1_PLL_Enable': 'true',
            'ADC2_PLL_Enable': 'true',
            'ADC3_PLL_Enable': 'true',
            'ADC0_Refclk_Freq': '256.000',
            'ADC1_Refclk_Freq': '256.000',
            'ADC2_Refclk_Freq': '256.000',
            'ADC3_Refclk_Freq': '256.000',
            'mADC_PLL_Enable': 'true',
            'mADC_Refclk_Freq': '256.000',

            'Converter_Setup': '0',
            'ADC224_En': 'true',
            'ADC225_En': 'true',
            'ADC226_En': 'true',
            'ADC227_En': 'true',
            'ADC0_Enable': '1',
            'ADC0_Outclk_Freq': '256.000',
            'ADC0_Fabric_Freq': '256.000',
            'ADC_Slice00_Enable': 'true',
            'ADC_Dither00': 'false',
            'ADC_Decimation_Mode00': '1',
            'ADC_Mixer_Type00': '1',
            'ADC_Coarse_Mixer_Freq00': '3',
            'ADC_RESERVED_1_00': '0',
            'ADC_Slice01_Enable': 'true',
            'ADC_Dither01': 'false',
            'ADC_Decimation_Mode01': '1',
            'ADC_Mixer_Type01': '1',
            'ADC_Coarse_Mixer_Freq01': '3',
            'ADC_RESERVED_1_01': '0',
            'ADC_OBS01': '0',
            'ADC_Slice02_Enable': 'true',
            'ADC_Dither02': 'false',
            'ADC_Decimation_Mode02': '1',
            'ADC_Mixer_Type02': '1',
            'ADC_Coarse_Mixer_Freq02': '3',
            'ADC_RESERVED_1_02': '0',
            'ADC_OBS02': '0',
            'ADC_Slice03_Enable': 'true',
            'ADC_Dither03': 'false',
            'ADC_Decimation_Mode03': '1',
            'ADC_Mixer_Type03': '1',
            'ADC_Coarse_Mixer_Freq03': '3',
            'ADC_RESERVED_1_03': '0',
            'ADC_OBS03': '0',
            'ADC1_Enable': '1',
            'ADC1_Outclk_Freq': '256.000',
            'ADC1_Fabric_Freq': '256.000',
            'ADC_Slice10_Enable': 'true',
            'ADC_Dither10': 'false',
            'ADC_Decimation_Mode10': '1',
            'ADC_Mixer_Type10': '1',
            'ADC_Coarse_Mixer_Freq10': '3',
            'ADC_RESERVED_1_10': '0',
            'ADC_Slice11_Enable': 'true',
            'ADC_Dither11': 'false',
            'ADC_Decimation_Mode11': '1',
            'ADC_Mixer_Type11': '1',
            'ADC_Coarse_Mixer_Freq11': '3',
            'ADC_RESERVED_1_11': '0',
            'ADC_OBS11': '0',
            'ADC_Slice12_Enable': 'true',
            'ADC_Dither12': 'false',
            'ADC_Decimation_Mode12': '1',
            'ADC_Mixer_Type12': '1',
            'ADC_Coarse_Mixer_Freq12': '3',
            'ADC_RESERVED_1_12': '0',
            'ADC_OBS12': '0',
            'ADC_Slice13_Enable': 'true',
            'ADC_Dither13': 'false',
            'ADC_Decimation_Mode13': '1',
            'ADC_Mixer_Type13': '1',
            'ADC_Coarse_Mixer_Freq13': '3',
            'ADC_RESERVED_1_13': '0',
            'ADC_OBS13': '0',
            'ADC2_Enable': '1',
            'ADC2_Outclk_Freq': '256.000',
            'ADC2_Fabric_Freq': '256.000',
            'ADC_Slice20_Enable': 'true',
            'ADC_Dither20': 'false',
            'ADC_Decimation_Mode20': '1',
            'ADC_Mixer_Type20': '1',
            'ADC_Coarse_Mixer_Freq20': '3',
            'ADC_RESERVED_1_20': '0',
            'ADC_Slice21_Enable': 'true',
            'ADC_Dither21': 'false',
            'ADC_Decimation_Mode21': '1',
            'ADC_Mixer_Type21': '1',
            'ADC_Coarse_Mixer_Freq21': '3',
            'ADC_RESERVED_1_21': '0',
            'ADC_OBS21': '0',
            'ADC_Slice22_Enable': 'true',
            'ADC_Dither22': 'false',
            'ADC_Decimation_Mode22': '1',
            'ADC_Mixer_Type22': '1',
            'ADC_Coarse_Mixer_Freq22': '3',
            'ADC_RESERVED_1_22': '0',
            'ADC_OBS22': '0',
            'ADC_Slice23_Enable': 'true',
            'ADC_Dither23': 'false',
            'ADC_Decimation_Mode23': '1',
            'ADC_Mixer_Type23': '1',
            'ADC_Coarse_Mixer_Freq23': '3',
            'ADC_RESERVED_1_23': '0',
            'ADC_OBS23': '0',
            'ADC3_Enable': '1',
            'ADC3_Outclk_Freq': '256.000',
            'ADC3_Fabric_Freq': '256.000',
            'ADC_Slice30_Enable': 'true',
            'ADC_Dither30': 'false',
            'ADC_Decimation_Mode30': '1',
            'ADC_Mixer_Type30': '1',
            'ADC_Coarse_Mixer_Freq30': '3',
            'ADC_RESERVED_1_30': '0',
            'ADC_Slice31_Enable': 'true',
            'ADC_Dither31': 'false',
            'ADC_Decimation_Mode31': '1',
            'ADC_Mixer_Type31': '1',
            'ADC_Coarse_Mixer_Freq31': '3',
            'ADC_RESERVED_1_31': '0',
            'ADC_OBS31': '0',
            'ADC_Slice32_Enable': 'true',
            'ADC_Dither32': 'false',
            'ADC_Decimation_Mode32': '1',
            'ADC_Mixer_Type32': '1',
            'ADC_Coarse_Mixer_Freq32': '3',
            'ADC_RESERVED_1_32': '0',
            'ADC_OBS32': '0',
            'ADC_Slice33_Enable': 'true',
            'ADC_Dither33': 'false',
            'ADC_Decimation_Mode33': '1',
            'ADC_Mixer_Type33': '1',
            'ADC_Coarse_Mixer_Freq33': '3',
            'ADC_RESERVED_1_33': '0',
            'ADC_OBS33': '0',
            'mADC_Enable': '1',
            'mADC_Outclk_Freq': '256.000',
            'mADC_Fabric_Freq': '256.000',
            'mADC_Slice00_Enable': 'true',
            'mADC_Dither00': 'false',
            'mADC_Decimation_Mode00': '1',
            'mADC_Mixer_Type00': '1',
            'mADC_Coarse_Mixer_Freq00': '3',
            'mADC_RESERVED_1_00': '0',
            'mADC_Slice01_Enable': 'true',
            'mADC_Dither01': 'false',
            'mADC_Decimation_Mode01': '1',
            'mADC_Mixer_Type01': '1',
            'mADC_Coarse_Mixer_Freq01': '3',
            'mADC_RESERVED_1_01': '0',
            'mADC_OBS01': '0',
            'mADC_Slice02_Enable': 'true',
            'mADC_Dither02': 'false',
            'mADC_Decimation_Mode02': '1',
            'mADC_Mixer_Type02': '1',
            'mADC_Coarse_Mixer_Freq02': '3',
            'mADC_RESERVED_1_02': '0',
            'mADC_OBS02': '0',
            'mADC_Slice03_Enable': 'true',
            'mADC_Dither03': 'false',
            'mADC_Decimation_Mode03': '1',
            'mADC_Mixer_Type03': '1',
            'mADC_Coarse_Mixer_Freq03': '3',
            'mADC_RESERVED_1_03': '0',
            'mADC_OBS03': '0',
            'DAC_Mixer_Mode00': '0',
            'DAC_RESERVED_1_00': '0',
            'DAC_Mixer_Mode01': '0',
            'DAC_RESERVED_1_01': '0',
            'DAC_RESERVED_1_02': '0',
            'DAC_Mixer_Mode03': '0',
            'DAC_RESERVED_1_03': '0',
            'DAC_Mixer_Mode10': '0',
            'DAC_RESERVED_1_10': '0',
            'DAC_Mixer_Mode11': '0',
            'DAC_RESERVED_1_11': '0',
            'DAC_RESERVED_1_12': '0',
            'DAC_Mixer_Mode13': '0',
            'DAC_RESERVED_1_13': '0',
            'DAC_Mixer_Mode20': '0',
            'DAC_RESERVED_1_20': '0',
            'DAC_Mixer_Mode21': '0',
            'DAC_RESERVED_1_21': '0',
            'DAC_RESERVED_1_22': '0',
            'DAC_RESERVED_1_23': '0',
            'DAC_Mixer_Mode30': '0',
            'DAC_RESERVED_1_30': '0',
            'DAC_Mixer_Mode31': '0',
            'DAC_RESERVED_1_31': '0',
            'DAC_RESERVED_1_32': '0',
            'DAC_RESERVED_1_33': '0',
            'mDAC_RESERVED_1_00': '0',
            'mDAC_RESERVED_1_01': '0',
            'mDAC_RESERVED_1_02': '0',
            'mDAC_RESERVED_1_03': '0',
        }  


        commands = []
        commands += ['create_ip -name usp_rf_data_converter -vendor xilinx.com -library ip -version 2.4 -module_name rfdc']
        param_str = ' '.join(['CONFIG.%s {%s}' % (k,v) for k,v in config.items()])
        commands += ['set_property -dict [list %s] [get_ips rfdc]' % (param_str)]

        return commands

    def gen_tcl_cmds(self):
        #return {}
        # For some reason the first synth call errors with an "unsupported sample clock" check.
        # This check is wrong, and calling the synth command again seems to work.
        # So, put a synth call of the RFDC core prior to main synth and catch the error with -quiet
        return {'pre_synth': ['generate_target all [get_files rfdc_2048.xci] -quiet']}
        #return {'pre_synth': self.make_ip_tcl()}


    def modify_top(self,top):
        top.add_signal('adc_clk')
        top.add_signal('adc_clk90')
        top.add_signal('adc_clk180')
        top.add_signal('adc_clk270')
        top.assign_signal('adc_clk', 'adc0_clk')
        # instantiate rf data converter ip and add relevant ports
        adc_inst = top.get_instance(entity='rfdc_2048', name='rfdc_inst')

        for t in range(4):
            # Ports to simulink
            for i in range(4):
                portbase = 'm%d%d_axis' % (t,i)
                dport = portbase + '_tdata'
                vport = portbase + '_tvalid'
                rport = portbase + '_tready'
                adc_inst.add_port(dport, self.fullname + '_' + dport, width=128)
                adc_inst.add_port(vport, self.fullname + '_' + vport)
                adc_inst.add_port(rport, self.fullname + '_' + rport)
                # Analog input ports
                adc_inst.add_port('vin%d%d_p'%(t,i), 'rfdc_vin%d%d_p'%(t,i), dir='in', parent_port=True)
                adc_inst.add_port('vin%d%d_n'%(t,i), 'rfdc_vin%d%d_n'%(t,i), dir='in', parent_port=True)
            # Clock outputs
            adc_inst.add_port('clk_adc%d'%t, 'adc%d_clk'%t)
            # Data output clocks
            adc_inst.add_port('m%d_axis_aclk'%t, 'adc_clk')
            adc_inst.add_port('m%d_axis_aresetn'%t, self.fullname + "_rstn")
        # Clock input -- all tiles use the ADC0 reference
        adc_inst.add_port('adc0_clk_p', 'rfdc_adc%d_clk_p'%t, dir='in', parent_port=True)
        adc_inst.add_port('adc0_clk_n', 'rfdc_adc%d_clk_n'%t, dir='in', parent_port=True)

        adc_inst.add_port('sysref_in_p', '1\'b0', dir='in', parent_port=True)
        adc_inst.add_port('sysref_in_n', '1\'b0', dir='in', parent_port=True)

        # RFDC AXI control interface
        adc_inst.add_port('s_axi_aclk', 'axil_clk')
        adc_inst.add_port('s_axi_aresetn', 'axil_rst_n')
        # AXI4-lite slave interface
        adc_inst.add_port('s_axi_awaddr',  'M_AXI_RFDC_awaddr', width=40)
        adc_inst.add_port('s_axi_awvalid', 'M_AXI_RFDC_awvalid')
        adc_inst.add_port('s_axi_awready', 'M_AXI_RFDC_awready')
        adc_inst.add_port('s_axi_wdata',   'M_AXI_RFDC_wdata', width=32)
        adc_inst.add_port('s_axi_wstrb',   'M_AXI_RFDC_wstrb', width=4)
        adc_inst.add_port('s_axi_wvalid',  'M_AXI_RFDC_wvalid')
        adc_inst.add_port('s_axi_wready',  'M_AXI_RFDC_wready')
        adc_inst.add_port('s_axi_bresp',   'M_AXI_RFDC_bresp', width=2)
        adc_inst.add_port('s_axi_bvalid',  'M_AXI_RFDC_bvalid')
        adc_inst.add_port('s_axi_bready',  'M_AXI_RFDC_bready')
        adc_inst.add_port('s_axi_araddr',  'M_AXI_RFDC_araddr', width=40)
        adc_inst.add_port('s_axi_arvalid', 'M_AXI_RFDC_arvalid')
        adc_inst.add_port('s_axi_arready', 'M_AXI_RFDC_arready')
        adc_inst.add_port('s_axi_rdata',   'M_AXI_RFDC_rdata', width=32)
        adc_inst.add_port('s_axi_rresp',   'M_AXI_RFDC_rresp', width=2)
        adc_inst.add_port('s_axi_rvalid',  'M_AXI_RFDC_rvalid')
        adc_inst.add_port('s_axi_rready',  'M_AXI_RFDC_rready')

    def gen_constraints(self):
        cons = []
        cons += [PortConstraint('rfdc_sysref_in_p', 'rfsoc_sysref_p', iogroup_index=0)]
        for t in range(4):
            cons += [PortConstraint('rfdc_adc%d_clk_p'%t, 'rfsoc_refclk_p', iogroup_index=t)]
            for i in range(4):
                cons += [PortConstraint('rfdc_vin%d%d_p'%(t,i), 'rfsoc_vin_p', iogroup_index=4*t+i)]
        return cons
