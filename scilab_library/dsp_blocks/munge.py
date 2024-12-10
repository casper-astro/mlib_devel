import sys
from .dsp_block import DSPBlock
from verilog import VerilogModule

class munge(DSPBlock):
    def initialize(self):
        self.add_source('munge/*')
        self.add_source('common_pkg/common_pkg.vhd')

    def modify_top(self,top):
        # let's populate the parent ports first
        self._populate_parent_ports(top)
        # create a verilog module
        module = 'munge'
        inst = top.get_instance(entity=module, name=self.fullname)
        # add parameters
        inst.add_parameter("g_number_of_divisions", self.divisions)
        inst.add_parameter("g_division_size_bits", self.size_bits)
        inst.add_parameter("g_packing_order", "%s"%self.packing_order)
        # add ports
        # we need to check if the port is in parent_ports
        inst.add_port('clk', 'user_clk', dir='in')
        inst.add_port('ce', '1', dir='in')
        inst.add_port('din', self.fullname+'_din', parent_port=False, width=self.total_bits, dir='in')
        inst.add_port('dout', self.fullname+'_dout', parent_port=False, width=self.total_bits, dir='out')

