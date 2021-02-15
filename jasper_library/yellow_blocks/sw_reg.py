from .yellow_block import YellowBlock
from .yellow_block_typecodes import *
from memory import Register

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
            if self.platform.mmbus_architecture == 'AXI4-Lite':
                # Inst a module that sits on clock crossing boundary
                module = 'cdc_synchroniser'
                top.add_axi4lite_interface(regname=self.unique_name, mode='r', nbytes=4, default_val=self.init_val, typecode=self.typecode)
                inst = top.get_instance(entity=module, name=self.fullname)
                inst.add_parameter('G_BUS_WIDTH', value=32)
                inst.add_port('IP_CLK',       signal='axil_clk', parent_sig=False)
                inst.add_port('IP_RESET',     signal='axil_rst', parent_sig=False)                
                inst.add_port('IP_BUS_VALID', signal='1\'b01', parent_sig=False)
                inst.add_port('IP_BUS',       signal='%s_user_data_in'%self.fullname, width=32, parent_sig=True)
                inst.add_port('OP_BUS',       signal='%s_in'%self.fullname, width=32, parent_sig=True)
            else:
                module = 'wb_register_simulink2ppc'
                inst = top.get_instance(entity=module, name=self.fullname)
                inst.add_wb_interface(regname=self.unique_name, mode='r', nbytes=4, typecode=self.typecode)
                inst.add_port('user_clk', signal='user_clk', parent_sig=False)
                inst.add_port('user_data_in', signal='%s_user_data_in'%self.fullname, width=32)
        elif self.blk['io_dir'] == 'From Processor':
            if self.platform.mmbus_architecture == 'AXI4-Lite':
                # Inst a module that sits on clock crossing boundary
                module = 'cdc_synchroniser'
                top.add_axi4lite_interface(regname=self.unique_name, mode='rw', nbytes=4, default_val=self.init_val, typecode=self.typecode)
                inst = top.get_instance(entity=module, name=self.fullname)
                inst.add_parameter('G_BUS_WIDTH', value=32)
                inst.add_port('IP_CLK',       signal='user_clk', parent_sig=False)
                inst.add_port('IP_RESET',     signal='user_rst', parent_sig=False)
                inst.add_port('IP_BUS_VALID', signal='%s_out_we'%self.fullname, parent_sig=False)
                inst.add_port('IP_BUS',       signal='%s_out'%self.fullname, width=32, parent_sig=True)
                inst.add_port('OP_BUS',       signal='%s_user_data_out'%self.fullname, width=32, parent_sig=True)
            else:
                module = 'wb_register_ppc2simulink'
                inst = top.get_instance(entity=module, name=self.fullname)
                inst.add_parameter('INIT_VAL', "32'h%x"%self.init_val)
                inst.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=4, typecode=self.typecode)
                inst.add_port('user_clk', signal='user_clk', parent_sig=False)
                inst.add_port('user_data_out', signal='%s_user_data_out'%self.fullname, width=32)
        
