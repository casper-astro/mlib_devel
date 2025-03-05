import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class power_cal(DSPBlock):
    def initialize(self):
        self.add_source('power_cal/*')

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'power_cal'
        inst = top.get_instance(entity=module, name=self.fullname)
        # TODO: add parameters
        inst.add_parameter('BIT_WIDTH', self.bitwidth)
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('re', self.fullname+'_re', parent_port=False, width=self.bitwidth, dir='in')
        inst.add_port('im', self.fullname+'_im', parent_port=False, width=self.bitwidth, dir='in')
        inst.add_port('pwr', self.fullname+'_pwr', parent_port=False, width=self.bitwidth, dir='out')

