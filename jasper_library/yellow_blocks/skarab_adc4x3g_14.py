import os
from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, ClockGroupConstraint, MultiCycleConstraint, \
    OutputDelayConstraint, RawConstraint, FalsePathConstraint, InputDelayConstraint
from helpers import to_int_list

class skarab_adc4x3g_14(YellowBlock):
    """
    Class for SKARAB ADC4x3G-14 mezzanine module.

    For detailed instructions on how to install the mezzanine module into a SKARAB, how to control the mezzanine module
    and how to use the Simulink ports, see the Getting Started Guide, available at:
    https://github.com/ska-sa/skarab_docs/raw/master/adc/PN-SKARAB%20ADC4x3G_14%20GSG.pdf
    """
    
    def initialize(self):
        # Set bitwidth of block (this is determined by the 'Data bitwidth' parameter in the Simulink mask)
        # self.bitwidth = int(self.bitwidth)
        # add the source files, which have the same name as the module (this is the verilog module created above)
        self.module = 'skarab_adc4x3g_14'
        self.add_source('skarab_adc4x3g_14/*.vhd')
        self.add_source('skarab_adc4x3g_14/adc_cdc_fifo/*.xci')
        self.add_source('skarab_adc4x3g_14/chbfifo/*.xci')
        self.add_source('skarab_adc4x3g_14/adc_pll2/*.xci')

    def modify_top(self,top):
    
        # port name to be used for 'dio_buf'
        external_port_name = self.fullname + '_ext'
        
        # get this instance from 'top.v' or create if not instantiated yet
        inst = top.get_instance(entity=self.module, name=self.fullname, comment=self.fullname)
        
        top.assign_signal('mez%s_fault_n' % self.mez, 'MEZZANINE_%s_FAULT_N' % self.mez)
        
        if self.sync_ms == "Master":
            inst.add_parameter('ADC_SYNC_MASTER', 1)
            inst.add_parameter('ADC_SYNC_SLAVE',  0)
        else:
            inst.add_parameter('ADC_SYNC_MASTER', 0)
            inst.add_parameter('ADC_SYNC_SLAVE',  1)
        
        inst.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=0x40)
        
        inst.add_port('FREE_RUN_156M25HZ_CLK_IN', signal='hmc_clk', dir='in')
        inst.add_port('FREE_RUN_156M25HZ_RST_IN', signal='hmc_rst', dir='in')
        
        inst.add_port('ADC_MEZ_REFCLK_0_P',       'MEZ%s_REFCLK_0_P' % self.mez, parent_port=True,  dir='in')
        inst.add_port('ADC_MEZ_REFCLK_0_N',       'MEZ%s_REFCLK_0_N' % self.mez, parent_port=True,  dir='in')
        inst.add_port('ADC_MEZ_PHY11_LANE_RX_P',  'MEZ%s_PHY11_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4)
        inst.add_port('ADC_MEZ_PHY11_LANE_RX_N',  'MEZ%s_PHY11_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)
        inst.add_port('ADC_MEZ_REFCLK_1_P',       'MEZ%s_REFCLK_1_P' % self.mez, parent_port=True,  dir='in')
        inst.add_port('ADC_MEZ_REFCLK_1_N',       'MEZ%s_REFCLK_1_N' % self.mez, parent_port=True,  dir='in')
        inst.add_port('ADC_MEZ_PHY12_LANE_RX_P',  'MEZ%s_PHY12_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4)
        inst.add_port('ADC_MEZ_PHY12_LANE_RX_N',  'MEZ%s_PHY12_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)
        inst.add_port('ADC_MEZ_REFCLK_2_P',       'MEZ%s_REFCLK_2_P' % self.mez, parent_port=True,  dir='in')
        inst.add_port('ADC_MEZ_REFCLK_2_N',       'MEZ%s_REFCLK_2_N' % self.mez, parent_port=True,  dir='in')      
        inst.add_port('ADC_MEZ_PHY21_LANE_RX_P',  'MEZ%s_PHY21_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4)
        inst.add_port('ADC_MEZ_PHY21_LANE_RX_N',  'MEZ%s_PHY21_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)
        inst.add_port('ADC_MEZ_REFCLK_3_P',       'MEZ%s_REFCLK_3_P' % self.mez, parent_port=True,  dir='in')
        inst.add_port('ADC_MEZ_REFCLK_3_N',       'MEZ%s_REFCLK_3_N' % self.mez, parent_port=True,  dir='in')     
        inst.add_port('ADC_MEZ_PHY22_LANE_RX_P',  'MEZ%s_PHY22_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4) 
        inst.add_port('ADC_MEZ_PHY22_LANE_RX_N',  'MEZ%s_PHY22_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)

        inst.add_port('MEZZANINE_RESET',          'MEZZANINE_%s_RESET' % self.mez,   parent_port=True,  dir='out')
        inst.add_port('MEZZANINE_CLK_SEL',        'MEZZANINE_%s_CLK_SEL' % self.mez, parent_port=True,  dir='out')
        inst.add_port('MEZZANINE_FAULT_N',        'mez%s_fault_n' % self.mez,  dir='in')
        
        
        inst.add_port('DSP_CLK_IN',               signal='sys_clk',                  dir='in' ) 
        inst.add_port('DSP_RST_IN',               signal='sys_rst',                  dir='in' )
        inst.add_port('ADC0_DATA_VAL_OUT',        signal='%s_adc0_data_val_out' % self.fullname,           dir='out')
        inst.add_port('ADC0_DATA_OUT',            signal='%s_adc0_data_out' % self.fullname,               dir='out' ,width=128) 
        inst.add_port('ADC1_DATA_VAL_OUT',        signal='%s_adc1_data_val_out' % self.fullname,           dir='out') 
        inst.add_port('ADC1_DATA_OUT',            signal='%s_adc1_data_out' % self.fullname,               dir='out' ,width=128) 
        inst.add_port('ADC2_DATA_VAL_OUT',        signal='%s_adc2_data_val_out' % self.fullname,           dir='out')
        inst.add_port('ADC2_DATA_OUT',            signal='%s_adc2_data_out' % self.fullname,               dir='out' ,width=128) 
        inst.add_port('ADC3_DATA_VAL_OUT',        signal='%s_adc3_data_val_out' % self.fullname,           dir='out')
        inst.add_port('ADC3_DATA_OUT',            signal='%s_adc3_data_out' % self.fullname,               dir='out' ,width=128) 
        #inst.add_port('ADC_SYNC_START_IN',        signal='%s_adc_sync_start_in' % self.fullname,           dir='in' ) 
        #inst.add_port('ADC_SYNC_PART2_START_IN',  signal='%s_adc_sync_part2_start_in' % self.fullname,     dir='in')
        #inst.add_port('ADC_SYNC_PART3_START_IN',  signal='%s_adc_sync_part3_start_in' % self.fullname,     dir='in')

        #inst.add_port('ADC_SYNC_COMPLETE_OUT',    signal='%s_adc_sync_complete_out' % self.fullname,       dir='out')
        #inst.add_port('ADC_SYNC_REQUEST_OUT',     signal='%s_adc_sync_request_out' % self.fullname,        dir='out', width=4)
        #inst.add_port('ADC_TRIGGER_OUT',          signal='%s_adc_trigger_out' % self.fullname,             dir='out')
        #inst.add_port('PLL_SYNC_START_IN',        signal='%s_pll_sync_start_in' % self.fullname,           dir='in' )
        #inst.add_port('PLL_PULSE_GEN_START_IN',   signal='%s_pll_pulse_gen_start_in' % self.fullname,      dir='in' )
        #inst.add_port('PLL_SYNC_COMPLETE_OUT',    signal='%s_pll_sync_complete_out' % self.fullname,       dir='out')
        
        inst.add_port('MEZZ_ID', 'mez%s_id' % self.mez, dir='out', width=3)
        inst.add_port('MEZZ_PRESENT', 'mez%s_present' % self.mez, dir='out')        
        
        #inst.add_port('MEZZANINE_RESET_IN',       signal='%s_mezzanine_reset_in' % self.fullname,          dir='in')
        
        inst.add_port('AUX_CLK_P',                signal='aux_clk_diff_p',             parent_port=True, dir='in' )
        inst.add_port('AUX_CLK_N',                signal='aux_clk_diff_n',             parent_port=True, dir='in' ) 
        inst.add_port('AUX_SYNCI_P',              signal='sync_in_p',                  parent_port=True, dir='in' )
        inst.add_port('AUX_SYNCI_N',              signal='sync_in_n',                  parent_port=True, dir='in' ) 

        if self.sync_ms == "Master":
            inst.add_port('ADC_DATA_CLOCK_OUT',       signal='adc_clk',                    dir='out')
            inst.add_port('ADC_DATA_RESET_OUT',       signal='adc_rst',                    dir='out')
            inst.add_port('AUX_SYNCO_P',              signal='sync_out_p',                 parent_port=True, dir='out')
            inst.add_port('AUX_SYNCO_N',              signal='sync_out_n',                 parent_port=True, dir='out')

        #inst.add_port('ADC0_STATUS_OUT',     signal='%s_adc0_status_out' % self.fullname, dir='out', width=32)
        #inst.add_port('ADC1_STATUS_OUT',     signal='%s_adc1_status_out' % self.fullname, dir='out', width=32)
        #inst.add_port('ADC2_STATUS_OUT',     signal='%s_adc2_status_out' % self.fullname, dir='out', width=32)
        #inst.add_port('ADC3_STATUS_OUT',     signal='%s_adc3_status_out' % self.fullname, dir='out', width=32)

    def gen_constraints(self):
        
        cons = []
        
        # -------------------------------------
        # PATHS
        # -------------------------------------
        # RXOUTCLK: ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK
        # BUF: ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/GT0_RXOUTCLK_BUFG
        
        # -------------------------------------
        # PIN CONSTRAINTS
        # -------------------------------------
        cons.append(PortConstraint('MEZ%s_REFCLK_0_P' % self.mez, 'MEZ%s_REFCLK_0_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_0_N' % self.mez, 'MEZ%s_REFCLK_0_N' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_1_P' % self.mez, 'MEZ%s_REFCLK_1_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_1_N' % self.mez, 'MEZ%s_REFCLK_1_N' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_2_P' % self.mez, 'MEZ%s_REFCLK_2_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_2_N' % self.mez, 'MEZ%s_REFCLK_2_N' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_3_P' % self.mez, 'MEZ%s_REFCLK_3_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_3_N' % self.mez, 'MEZ%s_REFCLK_3_N' % self.mez))
        cons.append(PortConstraint('MEZ%s_PHY11_LANE_RX_P' % self.mez, 'MEZ%s_PHY11_LANE_RX_P' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ%s_PHY11_LANE_RX_N' % self.mez, 'MEZ%s_PHY11_LANE_RX_N' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ%s_PHY12_LANE_RX_P' % self.mez, 'MEZ%s_PHY12_LANE_RX_P' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ%s_PHY12_LANE_RX_N' % self.mez, 'MEZ%s_PHY12_LANE_RX_N' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ%s_PHY21_LANE_RX_P' % self.mez, 'MEZ%s_PHY21_LANE_RX_P' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ%s_PHY21_LANE_RX_N' % self.mez, 'MEZ%s_PHY21_LANE_RX_N' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ%s_PHY22_LANE_RX_P' % self.mez, 'MEZ%s_PHY22_LANE_RX_P' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZ%s_PHY22_LANE_RX_N' % self.mez, 'MEZ%s_PHY22_LANE_RX_N' % self.mez, port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('MEZZANINE_%s_RESET' % self.mez,   'MEZZANINE_%s_RESET' % self.mez))
        cons.append(PortConstraint('MEZZANINE_%s_CLK_SEL' % self.mez, 'MEZZANINE_%s_CLK_SEL' % self.mez))
        cons.append(PortConstraint('aux_clk_diff_p','aux_clk_diff_p')) #AUX_CLK_P : in std_logic;     AU20
        cons.append(PortConstraint('aux_clk_diff_n','aux_clk_diff_n')) #AUX_CLK_N : in std_logic;     AV19
        cons.append(PortConstraint('sync_in_p','sync_in_p'))           #AUX_SYNCI_P : in std_logic;   AT21
        cons.append(PortConstraint('sync_in_n','sync_in_n'))           #AUX_SYNCI_N : in std_logic;   AU21
        cons.append(PortConstraint('sync_out_p','sync_out_p'))         #AUX_SYNCO_P : out std_logic;  AW21
        cons.append(PortConstraint('sync_out_n','sync_out_n'))         #AUX_SYNCO_N : out std_logic); AY21
        
        # -------------------------------------
        # INPUT/OUTPUT DELAY CONSTRAINTS
        # -------------------------------------
        cons.append(InputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='min',  constdelay_ns=1.0, add_delay_en=True, portname='sync_in_p'))
        cons.append(InputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='max',  constdelay_ns=2.0, add_delay_en=True, portname='sync_in_p'))
        cons.append(InputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='min',  constdelay_ns=1.0, add_delay_en=True, portname='aux_clk_diff_p'))
        cons.append(InputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='max',  constdelay_ns=2.0, add_delay_en=True, portname='aux_clk_diff_p'))
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='min', constdelay_ns=-3.0, add_delay_en=True, portname='sync_out_p'))
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='max', constdelay_ns=-3.0, add_delay_en=True, portname='sync_out_p'))
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', consttype='min', constdelay_ns=0.1, add_delay_en=True, portname='MEZZANINE_%s_RESET' % self.mez))
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', consttype='max', constdelay_ns=0.2, add_delay_en=True, portname='MEZZANINE_%s_RESET' % self.mez))
        cons.append(MultiCycleConstraint(multicycletype='setup',sourcepath='get_clocks -of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', destpath='get_ports MEZZANINE_%s_RESET' % self.mez, multicycledelay=2))
        cons.append(MultiCycleConstraint(multicycletype='hold', sourcepath='get_clocks -of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', destpath='get_ports MEZZANINE_%s_RESET' % self.mez, multicycledelay=1))
        
        # -------------------------------------
        # CLOCKS
        # -------------------------------------
        cons.append(ClockConstraint('%s/ADC32RF45_7G5_DEC4_RX_0/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, '%s_ADC32RF45_7G5_DEC4_RX_0_RXOUTCLK' % self.fullname, period=5.333, port_en=False, virtual_en=False,  waveform_min=0.0, waveform_max=2.666))
        cons.append(ClockConstraint('%s/ADC32RF45_7G5_DEC4_RX_1/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, '%s_ADC32RF45_7G5_DEC4_RX_1_RXOUTCLK' % self.fullname, period=5.333, port_en=False, virtual_en=False,  waveform_min=0.0, waveform_max=2.666))
        cons.append(ClockConstraint('%s/ADC32RF45_7G5_DEC4_RX_2/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, '%s_ADC32RF45_7G5_DEC4_RX_2_RXOUTCLK' % self.fullname, period=5.333, port_en=False, virtual_en=False,  waveform_min=0.0, waveform_max=2.666))
        cons.append(ClockConstraint('%s/ADC32RF45_7G5_DEC4_RX_3/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/JESD204B_4LaneRX_7500MHz_init_i/U0/JESD204B_4LaneRX_7500MHz_i/gt0_JESD204B_4LaneRX_7500MHz_i/gthe2_i/RXOUTCLK'% self.fullname, '%s_ADC32RF45_7G5_DEC4_RX_3_RXOUTCLK' % self.fullname, period=5.333, port_en=False, virtual_en=False,  waveform_min=0.0, waveform_max=2.666))
        cons.append(ClockConstraint('MEZ%s_REFCLK_0_P' % self.mez,'MEZ%s_REFCLK_0_P' % self.mez, period=5.333, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=2.666))
        cons.append(ClockConstraint('MEZ%s_REFCLK_1_P' % self.mez,'MEZ%s_REFCLK_1_P' % self.mez, period=5.333, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=2.666))
        cons.append(ClockConstraint('MEZ%s_REFCLK_2_P' % self.mez,'MEZ%s_REFCLK_2_P' % self.mez, period=5.333, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=2.666))
        cons.append(ClockConstraint('MEZ%s_REFCLK_3_P' % self.mez,'MEZ%s_REFCLK_3_P' % self.mez, period=5.333, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=2.666))
        
        # -------------------------------------
        # ASYNCHRONOUS CONSTRAINTS
        # -------------------------------------
        cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s_ADC32RF45_7G5_DEC4_RX_0_RXOUTCLK' % self.fullname, 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s_ADC32RF45_7G5_DEC4_RX_1_RXOUTCLK' % self.fullname, 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s_ADC32RF45_7G5_DEC4_RX_2_RXOUTCLK' % self.fullname, 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '%s_ADC32RF45_7G5_DEC4_RX_3_RXOUTCLK' % self.fullname, 'asynchronous'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_0_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_1_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_2_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_3_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_0_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_1_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_2_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]', destpath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_3_RXOUTCLK]' % self.fullname))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_0_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_1_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_2_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_3_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]]'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_0_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_1_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_2_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]'))
        cons.append(FalsePathConstraint(sourcepath='[get_clocks %s_ADC32RF45_7G5_DEC4_RX_3_RXOUTCLK]' % self.fullname, destpath='[get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]]'))
        if self.sync_ms == "Master":
            cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins %s/adc_pll2_i/U0/mmcm_adv_inst/CLKOUT0]]' % self.fullname))
        
        # -------------------------------------
        # CDC WAIVER
        # -------------------------------------
        cons.append(RawConstraint('create_waiver -type CDC -id CDC-11 -from [get_pins skarab_infr/user_fpga_rst_reg/C] -to [get_pins %s/ADC32RF45_7G5_DEC4_RX_0/tff_adcplllocked/reg_z_reg/D] -user Peralex -description {Confirmed CDC-11 can be ignored in this case}' % self.fullname))
        cons.append(RawConstraint('create_waiver -type CDC -id CDC-11 -from [get_pins skarab_infr/user_fpga_rst_reg/C] -to [get_pins %s/ADC32RF45_7G5_DEC4_RX_1/tff_adcplllocked/reg_z_reg/D] -user Peralex -description {Confirmed CDC-11 can be ignored in this case}' % self.fullname))
        cons.append(RawConstraint('create_waiver -type CDC -id CDC-11 -from [get_pins skarab_infr/user_fpga_rst_reg/C] -to [get_pins %s/ADC32RF45_7G5_DEC4_RX_2/tff_adcplllocked/reg_z_reg/D] -user Peralex -description {Confirmed CDC-11 can be ignored in this case}' % self.fullname))
        cons.append(RawConstraint('create_waiver -type CDC -id CDC-11 -from [get_pins skarab_infr/user_fpga_rst_reg/C] -to [get_pins %s/ADC32RF45_7G5_DEC4_RX_3/tff_adcplllocked/reg_z_reg/D] -user Peralex -description {Confirmed CDC-11 can be ignored in this case}' % self.fullname))
        
        # -------------------------------------
        # PBLOCKS
        # -------------------------------------
        cons.append(RawConstraint('create_pblock MEZ%s_ADC32RF45_7G5_DEC4_RX_0' % self.mez))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_0]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/ADC32RF45_7G5_DEC4_RX_0/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/GT0_RXOUTCLK_BUFG]]'))
        if self.mez == 0:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_0]' % self.mez + ' -add {CLOCKREGION_X0Y4:CLOCKREGION_X0Y4}'))
        elif self.mez == 1:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_0]' % self.mez + ' -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y0}'))
        elif self.mez == 2:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_0]' % self.mez + ' -add {CLOCKREGION_X1Y3:CLOCKREGION_X1Y3}'))
        elif self.mez == 3:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_0]' % self.mez + ' -add {CLOCKREGION_X1Y7:CLOCKREGION_X1Y7}'))
        
        cons.append(RawConstraint('create_pblock MEZ%s_ADC32RF45_7G5_DEC4_RX_1' % self.mez))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_1]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/ADC32RF45_7G5_DEC4_RX_1/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/GT0_RXOUTCLK_BUFG]]'))
        if self.mez == 0:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_1]' % self.mez + ' -add {CLOCKREGION_X0Y5:CLOCKREGION_X0Y5}'))
        elif self.mez == 1:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_1]' % self.mez + ' -add {CLOCKREGION_X0Y1:CLOCKREGION_X0Y1}'))
        elif self.mez == 2:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_1]' % self.mez + ' -add {CLOCKREGION_X1Y2:CLOCKREGION_X1Y2}'))
        elif self.mez == 3:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_1]' % self.mez + ' -add {CLOCKREGION_X1Y6:CLOCKREGION_X1Y6}'))
        
        cons.append(RawConstraint('create_pblock MEZ%s_ADC32RF45_7G5_DEC4_RX_2' % self.mez))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_2]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/ADC32RF45_7G5_DEC4_RX_2/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/GT0_RXOUTCLK_BUFG]]'))
        if self.mez == 0:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_2]' % self.mez + ' -add {CLOCKREGION_X0Y6:CLOCKREGION_X0Y6}'))
        elif self.mez == 1:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_2]' % self.mez + ' -add {CLOCKREGION_X0Y2:CLOCKREGION_X0Y2}'))
        elif self.mez == 2:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_2]' % self.mez + ' -add {CLOCKREGION_X1Y1:CLOCKREGION_X1Y1}'))
        elif self.mez == 3:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_2]' % self.mez + ' -add {CLOCKREGION_X1Y5:CLOCKREGION_X1Y5}'))
        
        cons.append(RawConstraint('create_pblock MEZ%s_ADC32RF45_7G5_DEC4_RX_3' % self.mez))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_3]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/ADC32RF45_7G5_DEC4_RX_3/ADC32RF45_7G5_DEC4_RX_PHY_i/ADC_GT_SUPPPORT_inst/GT0_RXOUTCLK_BUFG]]'))
        if self.mez == 0:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_3]' % self.mez + ' -add {CLOCKREGION_X0Y7:CLOCKREGION_X0Y7}'))
        elif self.mez == 1:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_3]' % self.mez + ' -add {CLOCKREGION_X0Y3:CLOCKREGION_X0Y3}'))
        elif self.mez == 2:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_3]' % self.mez + ' -add {CLOCKREGION_X1Y0:CLOCKREGION_X1Y0}'))
        elif self.mez == 3:
            cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_ADC32RF45_7G5_DEC4_RX_3]' % self.mez + ' -add {CLOCKREGION_X1Y4:CLOCKREGION_X1Y4}'))
        
        return cons

