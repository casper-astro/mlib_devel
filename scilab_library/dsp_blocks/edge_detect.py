import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class edge_detect(DSPBlock):
    def initialize(self):
        self.add_source('edge_detect/*')

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'edge_detect'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters
        inst.add_parameter("EDGE", "\"%s\"" % self.edge_type)
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('in', self.fullname+'_in', parent_port=False, width=1, dir='in')
        inst.add_port('out', self.fullname+'_out', parent_port=False, width=1, dir='out')

