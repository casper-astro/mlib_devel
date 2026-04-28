import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class operation(DSPBlock):
    def initialize(self):
        self.add_source('operation/*')
        if not hasattr(self, 'bit_width'):
            self.bit_width = 1

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'operation'
        inst = top.get_instance(entity=module, name=self.fullname)
        # TODO: add parameters
        inst.add_parameter('OP',  "\"%s\"" %self.op)
        inst.add_parameter('BIT_WIDTH', "32'd%d" % int(self.bit_width))
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('in0', self.fullname+'_in0', parent_port=False, width=self.bit_width, dir='in')
        inst.add_port('in1', self.fullname+'_in1', parent_port=False, width=self.bit_width, dir='in')
        inst.add_port('out', self.fullname+'_out', parent_port=False, width=1, dir='out')
