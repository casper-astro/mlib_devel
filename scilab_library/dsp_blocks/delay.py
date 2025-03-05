import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class delay(DSPBlock):
    def initialize(self):
        self.add_source('delay/*')

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'delay'
        inst = top.get_instance(entity=module, name=self.fullname)
        # TODO: add parameters
        inst.add_parameter('D', self.delay_val)
        inst.add_parameter('BITWIDTH', self.bitwidth)
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('din', self.fullname+'_in', parent_port=False, width=self.bitwidth, dir='in')
        inst.add_port('dout', self.fullname+'_out', parent_port=False, width=self.bitwidth, dir='out')

