import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class constant(DSPBlock):
    def initialize(self):
        self.add_source('counter/*')

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'counter'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters
        inst.add_parameter("BIT_WIDTH", "32'd%d" % int(self.bit_width))
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('rst', self.fullname+'_rst', parent_port=False, width=1, dir='in')
        inst.add_port('en', self.fullname+'_en', parent_port=False, width=1, dir='in')
        inst.add_port('out', self.fullname+'_out', parent_port=False, width=self.bit_width, dir='out')

