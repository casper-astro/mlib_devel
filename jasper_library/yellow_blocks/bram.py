from yellow_block import YellowBlock
from verilog import VerilogInstance
from math import log

class bram(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.platform_support = 'all'
        self.requirements = ['wb_clk']
        self.add_source('wb_bram')
        self.depth = 2**self.addr_width
        self.n_registers = int(self.reg_prim_output) + int(self.reg_core_output)
        # parameters from the simulink block which currently don't do anything
        # self.optimisation

    def modify_top(self,top):
        module = 'wb_bram'
        inst = VerilogInstance(entity=module, name=self.fullname, comment=self.fullname)
        inst.add_wb_interface(nbytes=self.depth*self.data_width/4) #width is in bits
        inst.add_port('user_clk', 'user_clk')
        inst.add_port('user_addr', '%s_addr'%self.fullname)
        inst.add_port('user_din', '%s_din'%self.fullname)
        inst.add_port('user_we', '%s_we'%self.fullname)
        inst.add_port('user_dout','%s_dout'%self.fullname)
        inst.add_parameter('LOG_USER_WIDTH', int(log(self.data_width,2)))
        inst.add_parameter('USER_ADDR_BITS', self.addr_width)
        inst.add_parameter('N_REGISTERS', self.n_registers)
        top.add_instance(inst)
        top.add_signal('%s_din'%self.fullname,  width=self.data_width, comment=self.fullname)
        top.add_signal('%s_addr'%self.fullname, width=self.addr_width, comment=self.fullname)
        top.add_signal('%s_we'%self.fullname,   comment=self.fullname)
        top.add_signal('%s_dout'%self.fullname, width=self.data_width, comment=self.fullname)
        
