from yellow_block import YellowBlock
from verilog import VerilogInstance

class sw_reg(YellowBlock):
    def initialize(self):
        '''
        This function is called by YellowBlocks __init__ method.
        We could override __init__ here, but this seems a little
        bit more user friendly.
        '''
        self.platform_support = 'all'
        self.requirements = ['wb_clk']
        if self.blk['io_dir'] == 'To Processor':
            self.add_source('wb_register_simulink2ppc')
        elif self.blk['io_dir'] == 'From Processor':
            self.add_source('wb_register_ppc2simulink')

    def modify_top(self,top):
        if self.blk['io_dir'] == 'To Processor':
            module = 'wb_register_simulink2ppc'
            inst = VerilogInstance(entity=module, name=self.fullname, comment=self.fullname)
            inst.add_wb_interface(nbytes=4)
            inst.add_port('user_clk','user_clk')
            inst.add_port('user_data_in','%s_user_data_in'%self.fullname, width=32)
            top.add_instance(inst)
        elif self.blk['io_dir'] == 'From Processor':
            module = 'wb_register_ppc2simulink'
            inst = VerilogInstance(entity=module, name=self.fullname, comment=self.fullname)
            inst.add_wb_interface(nbytes=4)
            inst.add_port('user_clk','user_clk')
            inst.add_port('user_data_out','%s_user_data_out'%self.fullname, width=32)
            top.add_instance(inst)
        
