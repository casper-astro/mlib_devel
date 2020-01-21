from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint

class vla_dts(YellowBlock):
    def initialize(self):
        self.add_source('vla_dts/deformatter/*.v')
        self.add_source('vla_dts/*.v')
        self.add_source('vla_dts/*.xci')

        self.requires = []

    def modify_top(self,top):
        module = 'dts_gty_rx'
        inst = VerilogModule(entity=module, name=self.fullname)

        # ports which go to simulink
        inst.add_port('rst',     self.fullname+'_rst')
        inst.add_port('def_out', self.fullname+'_frame_out', width=128)
        inst.add_port('index',   self.fullname+'_index')
        inst.add_port('one_sec', self.fullname+'_one_sec')
        inst.add_port('ten_sec', self.fullname+'_ten_sec')
        inst.add_port('locked',  self.fullname+'_locked')

        # External ports
        inst.add_port('rx_p', self.fullname+'_rx_p', width=12, parent_port=True)
        inst.add_port('rx_n', self.fullname+'_rx_n', width=12, parent_port=True)
        inst.add_port('tx_p', self.fullname+'_tx_p', width=12, parent_port=True)
        inst.add_port('tx_n', self.fullname+'_tx_n', width=12, parent_port=True)
        inst.add_port('mgtrefclk0_p', self.fullname+'_mgtclk0_p', parent_port=True)
        inst.add_port('mgtrefclk0_n', self.fullname+'_mgtclk0_n', parent_port=True)
        inst.add_port('mgtrefclk1_p', self.fullname+'_mgtclk1_p', parent_port=True)
        inst.add_port('mgtrefclk1_n', self.fullname+'_mgtclk1_n', parent_port=True)

        # Internal ports
        inst.add_port('clk100', 'sys_clk')
        inst.add_port('gearbox_slip', self.fullname+'_gearbox_slip', width=12)

        top.add_instance(inst)

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint(self.fullname+'_rx_p',  'gty_rx')
        cons.append(PortConstraint(self.fullname+'_tx_p',  'gty_tx')
        cons.append(PortConstraint(self.fullname+'_mgtclk0_p',  'gty_refclk', iogroup_index=0)
        cons.append(PortConstraint(self.fullname+'_mgtclk1_p',  'gty_refclk', iogroup_index=1)

        # clock constraint with variable period
        cons.append(ClockConstraint(self.fullname+'_mgtclk0_p', name=self.fullname+'_mgtclk0', freq=161.1328125))
        cons.append(ClockConstraint(self.fullname+'_mgtclk1_p', name=self.fullname+'_mgtclk1', freq=161.1328125))

        return cons

        
