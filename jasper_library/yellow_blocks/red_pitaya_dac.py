import os
from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, ClockGroupConstraint, MultiCycleConstraint, \
    OutputDelayConstraint, RawConstraint, FalsePathConstraint
from helpers import to_int_list

class red_pitaya_dac(YellowBlock):
    """
    Class for the Red Pitaya DAC - handles multiple bit DAC Red Pitaya. There are two versions of the Red Pitaya:

    1) 125-10 - supports 10 bit DAC
    2) 125-14 - supports 14 bit DAC

    The 16 bit version is also coming out soon, so provision has been made for this in the parameter selection, but it
    currently only selects 10 bits.

    The yellow block DAC input expects the input data rate at 125MHz.

    For detailed instructions on the data format of the DAC, please see Analog Devices data sheet AD9767ASTZ. The
    DAC on the 125-14 Red Pitaya version works very similar to this DAC. It is the IDT,
    DAC1401D125 ADC. Both operate in interleaved mode only.
    """
    
    def initialize(self):
        # Set bitwidth of block (this is determined by the 'Data bitwidth' parameter in the Simulink mask)
        # self.bitwidth = int(self.bitwidth)
        # add the source files, which have the same name as the module (this is the verilog module created above)
        self.module = 'red_pitaya_dac'
        self.add_source('red_pitaya_dac/*.v')
        self.add_source('red_pitaya_dac/dac_data_fifo/*.xci')

    def modify_top(self,top):
        
        # get this instance from 'top.v' or create if not instantiated yet
        inst = top.get_instance(entity=self.module, name=self.fullname, comment=self.fullname)

        #Populate Generics with DAC yellow block parameters
        inst.add_parameter('NUM_OF_BITS', self.bits)

        #FPGA port interfaces to DAC firmware module
        inst.add_port('DAC_DATA_OUT', 'DAC_DATA_OUT', parent_port=True, dir='out', width=self.bits)
        inst.add_port('DAC_IQWRT', signal='DAC_IQWRT', parent_port=True, dir='out')
        inst.add_port('DAC_IQSEL', signal='DAC_IQSEL', parent_port=True, dir='out')
        inst.add_port('DAC_IQCLK', signal='DAC_IQCLK', parent_port=True, dir='out')
        inst.add_port('DAC_IQRESET', signal='DAC_IQRESET', parent_port=True, dir='out')

        inst.add_port('ADC_CLK_IN', signal='adc_clk', parent_sig=False, dir='in')
        inst.add_port('DAC_CLK_IN', signal='dac_clk', parent_sig=False,  dir='in')
        inst.add_port('DAC_CLK_P_IN', signal='dac_clk_p', parent_sig=False, dir='in')
        inst.add_port('DAC_RST_IN2', signal='dac_rst', parent_sig=False, dir='in')
        inst.add_port('DSP_CLK_IN', signal='user_clk', parent_sig=False, dir='in')
        inst.add_port('DSP_RST_IN', signal='user_rst', parent_sig=False, dir='in')

        # Simulink interface to/from yellow block to DAC firmware module
        inst.add_port('DAC_RST_IN', signal='%s_dac_reset_in' % self.fullname, dir='in')
        inst.add_port('DAC_DATA_VAL_IN', signal='%s_dac_data_valid_in' % self.fullname, dir='in')
        inst.add_port('DAC0_DATA_I_IN', signal='%s_dac0_data_i_in' % self.fullname, dir='in',width=self.bits)
        inst.add_port('DAC1_DATA_Q_IN', signal='%s_dac1_data_q_in' % self.fullname, dir='in',width=self.bits)


    def gen_constraints(self):
    
        cons = []
        
        # Pin Constraints
        cons.append(PortConstraint('DAC_DATA_OUT', 'DAC_DATA_OUT', port_index=list(range(self.bits)), iogroup_index=list(range(self.bits))))
        cons.append(PortConstraint('DAC_IQWRT', 'DAC_IQWRT'))
        cons.append(PortConstraint('DAC_IQSEL', 'DAC_IQSEL'))
        cons.append(PortConstraint('DAC_IQCLK', 'DAC_IQCLK'))
        cons.append(PortConstraint('DAC_IQRESET', 'DAC_IQRESET'))


        #To do: add timing constraints

        #Clock Group Constraints
        cons.append(ClockGroupConstraint('-of_objects [get_pins red_pitaya_infr_inst/dsp_clk_mmcm_inst/CLKOUT0]', '-of_objects [get_pins red_pitaya_infr_inst/adc_clk_mmcm_inst/CLKOUT1]', 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins red_pitaya_infr_inst/adc_clk_mmcm_inst/CLKOUT1]', '-of_objects [get_pins red_pitaya_infr_inst/dsp_clk_mmcm_inst/CLKOUT0]', 'asynchronous'))
        
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', 'aux_clk_diff_p', 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', 'sync_in_p', 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_0/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_1/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_2/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_3/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))

        #input constraints


        # Output Constraints (setting to false path, so initial value made large)
        #cons.append(OutputDelayConstraint('adc_clk_125_mmcm', consttype='min', constdelay_ns=0, add_delay_en=True, portname='DAC_DATA_OUT[*]'))
        #cons.append(OutputDelayConstraint('adc_clk_125_mmcm', consttype='max', constdelay_ns=100, add_delay_en=True, portname='DAC_DATA_OUT[*]'))
        #cons.append(OutputDelayConstraint('dac_clk_250_mmcm', consttype='min', constdelay_ns=0, add_delay_en=True, portname='DAC_IQWRT'))
        #cons.append(OutputDelayConstraint('dac_clk_250_mmcm', consttype='max', constdelay_ns=100, add_delay_en=True, portname='DAC_IQWRT'))
        #cons.append(OutputDelayConstraint('dac_clk_250_315_mmcm', consttype='min', constdelay_ns=0, add_delay_en=True, portname='DAC_IQCLK'))
        #cons.append(OutputDelayConstraint('dac_clk_250_315_mmcm', consttype='max', constdelay_ns=100, add_delay_en=True, portname='DAC_IQCLK'))
        #cons.append(OutputDelayConstraint('adc_clk_125_mmcm', consttype='min', constdelay_ns=0, add_delay_en=True, portname='DAC_IQRESET'))
        #cons.append(OutputDelayConstraint('adc_clk_125_mmcm', consttype='max', constdelay_ns=100, add_delay_en=True, portname='DAC_IQRESET'))
        #cons.append(OutputDelayConstraint('adc_clk_125_mmcm', consttype='min', constdelay_ns=0, add_delay_en=True, portname='DAC_IQSEL'))
        #cons.append(OutputDelayConstraint('adc_clk_125_mmcm', consttype='max', constdelay_ns=100, add_delay_en=True, portname='DAC_IQSEL'))

        #False Path Constraints
        cons.append(FalsePathConstraint(destpath='[get_ports {DAC_DATA_OUT[*]}]'))
        cons.append(FalsePathConstraint(destpath='[get_ports {DAC_IQWRT}]'))
        cons.append(FalsePathConstraint(destpath='[get_ports {DAC_IQCLK}]'))
        cons.append(FalsePathConstraint(destpath='[get_ports {DAC_IQRESET}]'))
        cons.append(FalsePathConstraint(destpath='[get_ports {DAC_IQSEL}]'))

        #Raw Constraints

        return cons
        
    def gen_tcl_cmds(self):
        tcl_cmds = []

        #tcl_cmds.append('import_files -force -fileset constrs_1 %s/skarab_adc4x3g_14/JESD204B_4LaneRX_7500MHz.xdc'%os.getenv('HDL_ROOT'))
        #tcl_cmds.append('set_property SCOPED_TO_REF JESD204B_4LaneRX_7500MHz [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/skarab_adc4x3g_14/JESD204B_4LaneRX_7500MHz.xdc]')
        #tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/skarab_adc4x3g_14/JESD204B_4LaneRX_7500MHz.xdc]')

        return {'pre_synth': tcl_cmds}

