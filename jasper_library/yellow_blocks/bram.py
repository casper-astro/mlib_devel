from yellow_block import YellowBlock
from math import log
from yellow_block_typecodes import *

class bram(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.typecode = TYPECODE_SWREG
        self.platform_support = 'all'
        self.requirements = ['wb_clk']
        self.add_source('wb_bram')
        self.depth = 2**self.addr_width
        self.n_registers = int(self.reg_prim_output) + int(self.reg_core_output)
        # parameters from the simulink block which currently don't do anything
        # self.optimisation

    def modify_top(self,top):
        module = 'wb_bram'
        inst = top.get_instance(entity=module, name=self.fullname, comment=self.fullname)
        inst.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=self.depth*self.data_width/8, typecode=self.typecode) #width is in bits
        inst.add_port('user_clk',  signal='user_clk', parent_sig=False)
        inst.add_port('user_addr', signal='%s_addr'%self.fullname, width=self.addr_width)
        inst.add_port('user_din',  signal='%s_data_in'%self.fullname, width=self.data_width)
        inst.add_port('user_we',   signal='%s_we'%self.fullname)
        inst.add_port('user_dout', signal='%s_data_out'%self.fullname, width=self.data_width)
        inst.add_parameter('LOG_USER_WIDTH', int(log(self.data_width,2)))
        inst.add_parameter('USER_ADDR_BITS', self.addr_width)
        inst.add_parameter('N_REGISTERS', self.n_registers)
        
