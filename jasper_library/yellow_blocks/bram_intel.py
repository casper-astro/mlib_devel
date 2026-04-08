from .yellow_block import YellowBlock
from math import log
from .yellow_block_typecodes import *

class bram_intel(YellowBlock):
    def initialize(self):
        self.platform_support = 'all'
        self.data_width = int(self.data_width)
        self.addr_width = int(self.addr_width)
        self.depth = 2 ** self.addr_width
        self.n_registers = int(self.reg_prim_output) + int(self.reg_core_output)

        if self.platform.mmbus_architecture[0] == 'AXI4-Lite':
            self.typecode = TYPECODE_BRAM
            self.requirements = ['axil_clk']
        else:
            self.typecode = TYPECODE_SWREG
            self.requirements = ['wb_clk']
            self.add_source('wb_bram')

    def modify_top(self, top):
        if self.platform.mmbus_architecture[0] == 'AXI4-Lite':
            top.add_axi4lite_interface(
                regname=self.unique_name,
                mode='rw',
                nbytes=self.depth * self.data_width // 8,
                typecode=self.typecode,
                data_width=self.data_width
            )

            top.add_signal(self.unique_name + '_' + self.unique_name + '_addr', width=self.addr_width)
            top.add_signal(self.unique_name + '_' + self.unique_name + '_data_in', width=self.data_width)
            top.add_signal(self.unique_name + '_' + self.unique_name + '_data_out', width=self.data_width)
            top.add_signal(self.unique_name + '_' + self.unique_name + '_we', width=1)

            top.add_signal(self.fullname + '_addr', width=self.addr_width)
            top.add_signal(self.fullname + '_data_in', width=self.data_width)
            top.add_signal(self.fullname + '_data_out', width=self.data_width)
            top.add_signal(self.fullname + '_we', width=1)

            top.assign_signal(self.unique_name + '_' + self.unique_name + '_addr',     self.fullname + '_addr')
            top.assign_signal(self.unique_name + '_' + self.unique_name + '_data_in',  self.fullname + '_data_in')
            top.assign_signal(self.unique_name + '_' + self.unique_name + '_data_out', self.fullname + '_data_out')
            top.assign_signal(self.unique_name + '_' + self.unique_name + '_we',       self.fullname + '_we')

        else:
            module = 'wb_bram'
            inst = top.get_instance(entity=module, name=self.fullname)
            inst.add_wb_interface(
                regname=self.unique_name,
                mode='rw',
                nbytes=self.depth * self.data_width // 8,
                typecode=self.typecode
            )
            inst.add_port('user_clk',  signal='user_clk', parent_sig=False, parent_port=False)
            inst.add_port('user_addr', signal='%s_addr' % self.fullname, width=self.addr_width)
            inst.add_port('user_din',  signal='%s_data_in' % self.fullname, width=self.data_width)
            inst.add_port('user_we',   signal='%s_we' % self.fullname)
            inst.add_port('user_dout', signal='%s_data_out' % self.fullname, width=self.data_width)
            inst.add_parameter('LOG_USER_WIDTH', int(log(self.data_width, 2)))
            inst.add_parameter('USER_ADDR_BITS', self.addr_width)
            inst.add_parameter('N_REGISTERS', self.n_registers)from .yellow_block import YellowBlock
from math import log
from .yellow_block_typecodes import *

class bram_intel(YellowBlock):
    def initialize(self):
        self.platform_support = 'all'
        self.data_width = int(self.data_width)
        self.addr_width = int(self.addr_width)
        self.depth = 2 ** self.addr_width
        self.n_registers = int(self.reg_prim_output) + int(self.reg_core_output)

        if self.platform.mmbus_architecture[0] == 'AXI4-Lite':
            self.typecode = TYPECODE_BRAM
            self.requirements = ['axil_clk']
        else:
            self.typecode = TYPECODE_SWREG
            self.requirements = ['wb_clk']
            self.add_source('wb_bram')

    def modify_top(self, top):
        if self.platform.mmbus_architecture[0] == 'AXI4-Lite':
            top.add_axi4lite_interface(
                regname=self.unique_name,
                mode='rw',
                nbytes=self.depth * self.data_width // 8,
                typecode=self.typecode,
                data_width=self.data_width
            )

            top.add_signal(self.unique_name + '_' + self.unique_name + '_addr', width=self.addr_width)
            top.add_signal(self.unique_name + '_' + self.unique_name + '_data_in', width=self.data_width)
            top.add_signal(self.unique_name + '_' + self.unique_name + '_data_out', width=self.data_width)
            top.add_signal(self.unique_name + '_' + self.unique_name + '_we', width=1)

            top.add_signal(self.fullname + '_addr', width=self.addr_width)
            top.add_signal(self.fullname + '_data_in', width=self.data_width)
            top.add_signal(self.fullname + '_data_out', width=self.data_width)
            top.add_signal(self.fullname + '_we', width=1)

            top.assign_signal(self.unique_name + '_' + self.unique_name + '_addr',     self.fullname + '_addr')
            top.assign_signal(self.unique_name + '_' + self.unique_name + '_data_in',  self.fullname + '_data_in')
            top.assign_signal(self.unique_name + '_' + self.unique_name + '_data_out', self.fullname + '_data_out')
            top.assign_signal(self.unique_name + '_' + self.unique_name + '_we',       self.fullname + '_we')

        else:
            module = 'wb_bram'
            inst = top.get_instance(entity=module, name=self.fullname)
            inst.add_wb_interface(
                regname=self.unique_name,
                mode='rw',
                nbytes=self.depth * self.data_width // 8,
                typecode=self.typecode
            )
            inst.add_port('user_clk',  signal='user_clk', parent_sig=False, parent_port=False)
            inst.add_port('user_addr', signal='%s_addr' % self.fullname, width=self.addr_width)
            inst.add_port('user_din',  signal='%s_data_in' % self.fullname, width=self.data_width)
            inst.add_port('user_we',   signal='%s_we' % self.fullname)
            inst.add_port('user_dout', signal='%s_data_out' % self.fullname, width=self.data_width)
            inst.add_parameter('LOG_USER_WIDTH', int(log(self.data_width, 2)))
            inst.add_parameter('USER_ADDR_BITS', self.addr_width)
            inst.add_parameter('N_REGISTERS', self.n_registers)