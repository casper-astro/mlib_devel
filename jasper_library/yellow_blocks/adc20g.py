from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint

class adc20g(YellowBlock):
    def initialize(self):
        self.platform_support = 'mx175'
        self.requirements = []
        self.provides = ['adc0_clk', 'adc0_clk90', 'adc0_clk180', 'adc0_clk270']
        self.add_source('adc20g/*.v') #add everything in the hdl_sources/adc20g directory
        self.add_source('adc20g/*.xdc') #add everything in the hdl_sources/adc20g directory
        self.add_source('adc20g/*.xci') #add everything in the hdl_sources/adc20g directory
        self.add_source('adc20g/*.dat') #add everything in the hdl_sources/adc20g directory


    def modify_top(self, top):
        module = 'design_1_wrapper' #name kept from RR
        inst = top.get_instance(entity=module, name=self.fullname, comment='ADC20g monstrous Black Box')
        inst.add_port('FLASH1', signal='FLASH1', parent_port=True, dir='out', width=1)
        inst.add_port('FLASH2', signal='FLASH2', parent_port=True, dir='out', width=1)
        inst.add_port('Q8_CLK1_GTREFCLK_PAD_N_IN', signal='Q8_CLK1_GTREFCLK_PAD_N_IN', parent_port=True, dir='in', width=1)
        inst.add_port('Q8_CLK1_GTREFCLK_PAD_P_IN', signal='Q8_CLK1_GTREFCLK_PAD_P_IN', parent_port=True, dir='in', width=1)
        inst.add_port('RXN_IN', signal='RXN_IN', parent_port=True, dir='in', width=8)
        inst.add_port('RXP_IN', signal='RXP_IN', parent_port=True, dir='in', width=8)
        inst.add_port('TRACK_DATA_OUT', signal='TRACK_DATA_OUT', parent_port=True, dir='out', width=1)
        inst.add_port('TXN_OUT', signal='TXN_OUT', parent_port=True, dir='out', width=8)
        inst.add_port('TXP_OUT', signal='TXP_OUT', parent_port=True, dir='out', width=8)
        inst.add_port('diff_clock_rtl_clk_n', signal='diff_clock_rtl_clk_n', parent_port=True, dir='in', width=1)
        inst.add_port('diff_clock_rtl_clk_p', signal='diff_clock_rtl_clk_p', parent_port=True, dir='in', width=1)
        inst.add_port('gpio_adc_control_tri_o', signal='gpio_adc_control_tri_o', parent_port=True, dir='out', width=6)
        inst.add_port('iic_scl_io', signal='iic_scl_io', parent_port=True, dir='inout', width=1)
        inst.add_port('iic_sda_io', signal='iic_sda_io', parent_port=True, dir='inout', width=1)
        inst.add_port('reset_rtl', signal='reset_rtl', parent_port=True, dir='in', width=1)
        inst.add_port('uart_rxd', signal='uart_rxd', parent_port=True, dir='in', width=1)
        inst.add_port('uart_txd', signal='uart_txd', parent_port=True, dir='out', width=1)

        # add the adc_clk_out port connected to an "adc0_clk" signal. The toolflow will connect this to fab_clk and clock simulink with it
        inst.add_port('adc_clk_out', signal='adc0_clk', width=1)
        top.add_signal('adc0_clk90')
        # create dummy signals for the  other clock phases, but hook them all up to the 0 degree clock
        top.assign_signal('adc0_clk90', 'adc0_clk')
        top.add_signal('adc0_clk180')
        top.assign_signal('adc0_clk180', 'adc0_clk')
        top.add_signal('adc0_clk270')
        top.assign_signal('adc0_clk270', 'adc0_clk')

        inst.add_port('dout', signal=self.fullname+'_dout', width=328)

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('FLASH1', 'led', port_index=[0], iogroup_index=[6]))
        cons.append(PortConstraint('FLASH2', 'led', port_index=[0], iogroup_index=[7]))
        cons.append(PortConstraint('Q8_CLK1_GTREFCLK_PAD_P_IN', 'Q8_CLK1_GTREFCLK_PAD_P_IN', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('Q8_CLK1_GTREFCLK_PAD_P_IN', 'Q8_CLK1_GTREFCLK_PAD_P_IN', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('RXN_IN', 'RXN_IN', port_index=range(8), iogroup_index=range(8)))
        cons.append(PortConstraint('RXP_IN', 'RXP_IN', port_index=range(8), iogroup_index=range(8)))
        cons.append(PortConstraint('TRACK_DATA_OUT', 'TRACK_DATA_OUT', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('TXN_OUT', 'TXN_OUT', port_index=range(8), iogroup_index=range(8)))
        cons.append(PortConstraint('TXP_OUT', 'TXP_OUT', port_index=range(8), iogroup_index=range(8)))
        cons.append(PortConstraint('diff_clock_rtl_clk_n', 'diff_clock_rtl_clk_n', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('diff_clock_rtl_clk_p', 'diff_clock_rtl_clk_p', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('gpio_adc_control_tri_o', 'gpio_adc_control_tri_o', port_index=range(6), iogroup_index=range(6)))
        cons.append(PortConstraint('iic_scl_io', 'iic_scl_io', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('iic_sda_io', 'iic_sda_io', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('reset_rtl', 'reset_rtl', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('uart_rxd', 'uart_rxd', port_index=[0], iogroup_index=[0]))
        cons.append(PortConstraint('uart_txd', 'uart_txd', port_index=[0], iogroup_index=[0]))

        cons.append(ClockConstraint('Q8_CLK1_GTREFCLK_PAD_P_IN', name='Q8_CLK1_GTREFCLK_clk', freq=156.25))
        return cons


