from .yellow_block import YellowBlock
from constraints import PortConstraint
from helpers import to_int_list
import logging

class gpio_bidir(YellowBlock):
    def initialize(self):
        # Set bitwidth of block
        self.bitwidth = int(self.bitwidth)
        # add the source files, which have the same name as the module
        self.module = 'gpio_bidir'
        self.add_source(self.module)

    def modify_top(self,top):
        external_port_name = self.fullname + '_ext'

        inst = top.get_instance(entity=self.module, name=self.fullname)
        inst.add_port('clk', signal='user_clk', parent_sig=False)
        inst.add_port('dio_buf', signal=external_port_name, dir='inout', width=self.bitwidth, parent_port=True)
        inst.add_port('din_i', signal='%s_din_i'%self.fullname, width=self.bitwidth)
        inst.add_port('dout_o', signal='%s_dout_o'%self.fullname, width=self.bitwidth)
        inst.add_port('in_not_out_i', signal='%s_in_not_out_i'%self.fullname)
        inst.add_parameter('WIDTH', str(self.bitwidth))

    def gen_constraints(self):
        return [PortConstraint(self.fullname+'_ext', self.io_group, port_index=list(range(self.bitwidth)), iogroup_index=to_int_list(self.bit_index))]