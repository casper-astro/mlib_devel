from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint

"""
Requires the following pins defined in an appropriate platform.yaml:
dts_gty_rx_p[0:11] (LOC only) # RX transceiver pins, p-side
dts_gty_tx_p[0:11] (LOC only) # TX transceiver pins, p-side
dts_gty_refclk_p[0:1] (LOC only) # MGT refclk for transceiver pins 0-7 (index 0); transceiver pins 8-11 (index 1)
dts_qsfp_modprsl[0:2] (LOC & IOSTD) # ModPrsL signal for the 3 QSFP ports. Pulled low when a QSFP module is present
"""

class vla_dts(YellowBlock):
    def initialize(self):
        self.add_source('vla_dts/deformatter/*.vhd')
        self.add_source('vla_dts/*.v')
        self.add_source('vla_dts/*.xci')

        self.requires = []
        self.provides = ['dts_500_clk', 'dts_500_clk90', 'dts_500_clk180', 'dts_500_clk270']

    def modify_top(self,top):
        module = 'dts_gty_rx'
        inst = top.get_instance(entity=module, name=self.fullname)

        # ports which go to simulink
        inst.add_port('rst',     self.fullname+'_rst')
        inst.add_port('dout',    self.fullname+'_frame_out', width=192)
        inst.add_port('index',   self.fullname+'_index')
        inst.add_port('one_sec', self.fullname+'_one_sec')
        inst.add_port('ten_sec', self.fullname+'_ten_sec')
        inst.add_port('locked',  self.fullname+'_locked')

        # External ports
        inst.add_port('rx_p', self.fullname+'_rx_p', width=12, parent_port=True, dir='in')
        inst.add_port('rx_n', self.fullname+'_rx_n', width=12, parent_port=True, dir='in')
        inst.add_port('tx_p', self.fullname+'_tx_p', width=12, parent_port=True, dir='out')
        inst.add_port('tx_n', self.fullname+'_tx_n', width=12, parent_port=True, dir='out')
        inst.add_port('mgtrefclk0_p', self.fullname+'_mgtclk0_p', parent_port=True, dir='in')
        inst.add_port('mgtrefclk0_n', self.fullname+'_mgtclk0_n', parent_port=True, dir='in')
        inst.add_port('mgtrefclk1_p', self.fullname+'_mgtclk1_p', parent_port=True, dir='in')
        inst.add_port('mgtrefclk1_n', self.fullname+'_mgtclk1_n', parent_port=True, dir='in')
        inst.add_port('qsfp_modprsl', self.fullname+'_modprsl', width=3, parent_port=True, dir='in')

        # Internal ports
        inst.add_port('clk100', 'sys_clk')
        inst.add_port('gearbox_slip', self.fullname+'_gearbox_slip', width=12)
        inst.add_port('clk_500_0', 'dts_500_clk')
        inst.add_port('clk_500_90', 'dts_500_clk90')
        inst.add_port('clk_500_180', 'dts_500_clk180')
        inst.add_port('clk_500_270', 'dts_500_clk270')

    def gen_constraints(self):
        cons = []
        # Transceiver LOC constraints are built into IP. So they are not needed here.
        #cons.append(PortConstraint(self.fullname+'_rx_p', 'dts_gty_rx_p', port_index=range(12), iogroup_index=range(12)))
        #cons.append(PortConstraint(self.fullname+'_tx_p', 'dts_gty_tx_p', port_index=range(12), iogroup_index=range(12)))
        cons.append(PortConstraint(self.fullname+'_mgtclk0_p', 'dts_gty_refclk_p', iogroup_index=0))
        cons.append(PortConstraint(self.fullname+'_mgtclk1_p', 'dts_gty_refclk_p', iogroup_index=1))
        cons.append(PortConstraint(self.fullname+'_modprsl', 'dts_qsfp_modprsl', port_index=range(3), iogroup_index=range(3)))

        # clock constraint with variable period
        clkconst = ClockConstraint(self.fullname+'_mgtclk0_p', name=self.fullname+'_mgtclk0', freq=161.1328125)
        cons.append(clkconst)
        # Make asynchronous to sysclk
        cons.append(RawConstraint('set_clock_groups -name async_sysclk_dts0 -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % clkconst.name))

        clkconst = ClockConstraint(self.fullname+'_mgtclk1_p', name=self.fullname+'_mgtclk1', freq=161.1328125)
        cons.append(clkconst)
        # Make asynchronous to sysclk
        cons.append(RawConstraint('set_clock_groups -name async_sysclk_dts1 -asynchronous -group [get_clocks -include_generated_clocks %s] -group [get_clocks -include_generated_clocks sys_clk0_dcm]' % clkconst.name))

        return cons

        
