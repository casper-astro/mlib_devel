import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class slice(DSPBlock):
    def initialize(self):
        self.add_source('slice/*')

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'slice'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters
        inst.add_parameter("INPUT_WIDTH", "32'd%d" % int(self.input_width))
        inst.add_parameter("OUTPUT_WIDTH", "32'd%d" % int(self.output_width))
        inst.add_parameter("SLICE_START", "32'd%d" % int(self.slice_start))
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('in', self.fullname+'_in', parent_port=False, width=self.input_width, dir='in')
        inst.add_port('out', self.fullname+'_out', parent_port=False, width=self.output_width, dir='out')

