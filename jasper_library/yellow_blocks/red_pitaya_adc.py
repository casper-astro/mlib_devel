import os
from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, ClockGroupConstraint, MultiCycleConstraint, \
    OutputDelayConstraint, InputDelayConstraint, RawConstraint, FalsePathConstraint
from helpers import to_int_list

class red_pitaya_adc(YellowBlock):
    """
    Class for the Red Pitaya ADC - handles multiple bit ADC Red Pitaya. There are two versions of the Red Pitaya:

    1) 125-10 - supports 10 bit ADC
    2) 125-14 - supports 14 bit ADC

    The 16 bit version is also coming out soon, so provision has been made for this in the parameter selection, but it
    currently only selects 10 bits.

    For detailed instructions on the data format of the ADC, please see Analog Devices data sheet AD9608. The
    ADC on the 125-14 Red Pitaya version works very similar to this ADC. It is the Linear Technology,
    125-14 LTC2145CUP-14 ADC.
    """
    
    def initialize(self):
        # Set bitwidth of block (this is determined by the 'Data bitwidth' parameter in the Simulink mask)
        # self.bitwidth = int(self.bitwidth)
        # add the source files, which have the same name as the module (this is the verilog module created above)
        self.module = 'red_pitaya_adc'
        self.add_source('red_pitaya_adc/*.v')
        self.add_source('red_pitaya_adc/adc_data_fifo/*.xci')

    def modify_top(self,top):
        
        # get this instance from 'top.v' or create if not instantiated yet
        inst = top.get_instance(entity=self.module, name=self.fullname, comment=self.fullname)

        #Populate Generics with ADC yellow block parameters
        inst.add_parameter('NUM_OF_BITS', self.bits)

        #FPGA port interfaces to ADC firmware module
        inst.add_port('ADC_DATA_IN1', 'ADC_DATA_IN1', parent_port=True, dir='in', width=self.bits)
        inst.add_port('ADC_DATA_IN2', 'ADC_DATA_IN2', parent_port=True,  dir='in', width=self.bits)
        #ADC Clock duty cycle stabilizer
        inst.add_port('ADC_CLK_STB_OUT', signal='ADC_CLK_STB_OUT', parent_port=True, dir='out')
        #inst.add_port('ADC_LA_CLK', signal='ADC_LA_CLK', parent_port=True, dir='out')


        inst.add_port('DSP_CLK_IN', signal='user_clk', parent_sig=False, dir='in')
        inst.add_port('DSP_RST_IN', signal='user_rst', parent_sig=False, dir='in')
        inst.add_port('ADC_RST_IN2', signal='adc_rst', parent_sig=False, dir='in')
        inst.add_port('ADC_CLK_IN', signal='adc_clk', parent_sig=False, dir='in')


        # Simulink interface to/from yellow block to ADC firmware module
        inst.add_port('ADC_RST_IN', signal='%s_adc_reset_in' % self.fullname, dir='in')
        inst.add_port('ADC_DATA_VAL_OUT', signal='%s_adc_data_val_out' % self.fullname, dir='out')
        inst.add_port('ADC0_DATA_I_OUT', signal='%s_adc0_data_i_out' % self.fullname, dir='out',width=self.bits)
        inst.add_port('ADC1_DATA_Q_OUT', signal='%s_adc1_data_q_out' % self.fullname, dir='out',width=self.bits)


    def gen_constraints(self):
    
        cons = []
        
        # Pin Constraints
        cons.append(PortConstraint('ADC_DATA_IN1', 'ADC_DATA_IN1', port_index=list(range(self.bits)), iogroup_index=list(range(self.bits))))
        cons.append(PortConstraint('ADC_DATA_IN2', 'ADC_DATA_IN2', port_index=list(range(self.bits)), iogroup_index=list(range(self.bits))))
        cons.append(PortConstraint('ADC_CLK_STB_OUT', 'ADC_CLK_STB_OUT'))
        #cons.append(PortConstraint('ADC_LA_CLK', 'ADC_LA_CLK'))

        #To do: add timing constraints

        #Clock Group Constraints
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', 'aux_clk_diff_p', 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', 'sync_in_p', 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_0/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_1/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_2/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))
        #cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s/ADC32RF45_RX_3/ADC_PHY_inst/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, 'asynchronous'))

        #input constraints
        cons.append(InputDelayConstraint(clkname='ADC_CLK_IN_P', consttype='min', constdelay_ns=3.4, add_delay_en=True, portname='ADC_DATA_IN1[*]'))
        cons.append(InputDelayConstraint(clkname='ADC_CLK_IN_P', consttype='max', constdelay_ns=3.4, add_delay_en=True, portname='ADC_DATA_IN1[*]'))
        cons.append(InputDelayConstraint(clkname='ADC_CLK_IN_P', consttype='min', constdelay_ns=3.4, add_delay_en=True, portname='ADC_DATA_IN2[*]'))
        cons.append(InputDelayConstraint(clkname='ADC_CLK_IN_P', consttype='max', constdelay_ns=3.4, add_delay_en=True, portname='ADC_DATA_IN2[*]'))


        # Output Constraints
        #cons.append(OutputDelayConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', consttype='min', constdelay_ns=-3.0, add_delay_en=True, portname='sync_out_p'))
        #cons.append(OutputDelayConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', consttype='max', constdelay_ns=-3.0, add_delay_en=True, portname='sync_out_p'))

        #False Path Constraints
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_0/ADC_RX_PHY_soft_reset_SR_reg[*]/PRE}]' % self.fullname))
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_0/reset_RX_SYNC_SR_reg[*]/PRE}]' % self.fullname))
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_1/ADC_RX_PHY_soft_reset_SR_reg[*]/PRE}]' % self.fullname))
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_1/reset_RX_SYNC_SR_reg[*]/PRE}]' % self.fullname))
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_2/ADC_RX_PHY_soft_reset_SR_reg[*]/PRE}]' % self.fullname))
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_2/reset_RX_SYNC_SR_reg[*]/PRE}]' % self.fullname))
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_3/ADC_RX_PHY_soft_reset_SR_reg[*]/PRE}]' % self.fullname))
        #cons.append(FalsePathConstraint(destpath='[get_pins {%s/ADC32RF45_RX_3/reset_RX_SYNC_SR_reg[*]/PRE}]' % self.fullname))
        
        #Raw Constraints

        return cons
        
    def gen_tcl_cmds(self):
        tcl_cmds = []

        #tcl_cmds.append('import_files -force -fileset constrs_1 %s/skarab_adc4x3g_14/JESD204B_4LaneRX_7500MHz.xdc'%os.getenv('HDL_ROOT'))
        #tcl_cmds.append('set_property SCOPED_TO_REF JESD204B_4LaneRX_7500MHz [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/skarab_adc4x3g_14/JESD204B_4LaneRX_7500MHz.xdc]')
        #tcl_cmds.append('set_property processing_order LATE [get_files [get_property directory [current_project]]/myproj.srcs/constrs_1/imports/skarab_adc4x3g_14/JESD204B_4LaneRX_7500MHz.xdc]')

        return {'pre_synth': tcl_cmds}

