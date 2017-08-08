from yellow_block import YellowBlock
from yellow_block_typecodes import *

class sw_reg(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.typecode = TYPECODE_SWREG
        self.platform_support = 'all'
        self.requirements = ['wb_clk']
        if self.blk['io_dir'] == 'To Processor':
            self.add_source('wb_register_simulink2ppc')
        elif self.blk['io_dir'] == 'From Processor':
            self.add_source('wb_register_ppc2simulink')

    def modify_top(self,top):
        if self.blk['io_dir'] == 'To Processor':
            module = 'wb_register_simulink2ppc'
            inst = top.get_instance(entity=module, name=self.fullname, comment=self.fullname)
            inst.add_wb_interface(regname=self.unique_name, mode='r', nbytes=4, typecode=self.typecode)
            inst.add_port('user_clk', signal='user_clk', parent_sig=False)
            inst.add_port('user_data_in', signal='%s_user_data_in'%self.fullname, width=32)
        elif self.blk['io_dir'] == 'From Processor':
            module = 'wb_register_ppc2simulink'
            inst = top.get_instance(entity=module, name=self.fullname, comment=self.fullname)
            inst.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=4, typecode=self.typecode)
            inst.add_port('user_clk', signal='user_clk', parent_sig=False)
            inst.add_port('user_data_out', signal='%s_user_data_out'%self.fullname, width=32)
        
