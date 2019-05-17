from yellow_block import YellowBlock
from yellow_block_typecodes import *
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
            if self.platform.conf['interface_architecture'] == 'AXI4-Lite':
                # TODO: change name of AXI interconnect module
                module = 'wb_register_simulink2ppc'
                inst = top.get_instance(entity=module, name=self.fullname)
                # the minimum supported address range for an AXI4-lite interface in Vivado is 4KB
                range = 4096
                inst.add_axi4lite_interface(regname=self.unique_name, mode='r', nbytes=range, typecode=self.typecode)
                # # Only add one interface for all software registers, create a memory map from this register space.
                # if self.i_am_the_first:
                #     inst.add_axi4lite_interface(regname='sw_reg', mode='r', nbytes=range, memory_map=self.memory_map, typecode=self.typecode)
                #     # Add this as the first register in our memory map
                #     self.memory_map += [Register(self.unique_name, nbytes=4, offset=0, mode='r')]
                # else:
                #     # Determine new offset based from last register added
                #     last_offset = self.memory_map[-1].offset
                #     self.memory_map += [Register(self.unique_name, nbytes=4, offset=last_offset+4, mode='r')]
            else:
                module = 'wb_register_simulink2ppc'
                inst = top.get_instance(entity=module, name=self.fullname)
                inst.add_wb_interface(regname=self.unique_name, mode='r', nbytes=4, typecode=self.typecode)
                inst.add_port('user_clk', signal='user_clk', parent_sig=False)
                inst.add_port('user_data_in', signal='%s_user_data_in'%self.fullname, width=32)
        elif self.blk['io_dir'] == 'From Processor':
            if self.platform.conf['interface_architecture'] == 'AXI4-Lite':
                # TODO: add name of AXI interconnect module
                module = 'wb_register_ppc2simulink'
                inst = top.get_instance(entity=module, name=self.fullname)
                # the minimum supported address range for an AXI4-lite interface in Vivado is 4KB
                range = 4096
                inst.add_axi4lite_interface(regname=self.unique_name, mode='rw', nbytes=range, typecode=self.typecode)
                # Only add one interface for all software registers, create a memory map from this register space.
                # if self.i_am_the_first:
                #     # inst.add_axi4lite_interface(regname='sw_reg', mode='rw', nbytes=range, memory_map=self.memory_map, typecode=self.typecode)
                #     # Add this as the first register in our memory map
                #     self.memory_map += [Register(self.unique_name, nbytes=4, offset=0, mode='rw')]
                # else:
                #     # Determine new offset based from last register added
                #     last_offset = self.memory_map[-1].offset
                #     self.memory_map += [Register(self.unique_name, nbytes=4, offset=last_offset+4, mode='rw')]
            else:
                module = 'wb_register_ppc2simulink'
                inst = top.get_instance(entity=module, name=self.fullname)
                inst.add_parameter('INIT_VAL', "32'h%x"%self.init_val)
                inst.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=4, typecode=self.typecode)
                inst.add_port('user_clk', signal='user_clk', parent_sig=False)
                inst.add_port('user_data_out', signal='%s_user_data_out'%self.fullname, width=32)
        
