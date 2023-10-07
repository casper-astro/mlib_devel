from .yellow_block import YellowBlock
from memory import Register
from .yellow_block_typecodes import *

class sys_block(YellowBlock):
    def initialize(self):
        self.typecode = TYPECODE_SYSBLOCK
        self.add_source('sys_block')
        if not hasattr(self, 'scratchpad'): self.scratchpad = 0
        # the internal memory_map
        self.memory_map = [
            Register('board_id',   mode='r',  offset=0, default_val=self.board_id),
            Register('rev',        mode='r',  offset=0x4, default_val=str((int(self.rev_maj) << 16) + int(self.rev_min))),
            Register('rev_rcs',    mode='r',  offset=0xc, default_val=self.rev_rcs),
            Register('scratchpad', mode='rw', offset=0x10, default_val=self.scratchpad),
            Register('clkcounter', mode='r',  offset=0x14),
        ]
    def modify_top(self,top):
        if 'wishbone' not in self.platform.mmbus_architecture:
            inst = top.get_instance('sys_block_counter', 'sys_block_counter_inst')          
            inst.add_parameter('DATA_WIDTH', 32)
            inst.add_port('user_clk', 'user_clk')
            inst.add_port('user_rst', 'user_rst')
            inst.add_port('en', '1')

            inst.add_port('we',  signal='%s_clkcounter_we'%'sys', dir='out', width=1)
            inst.add_port('count_out', signal='%s_clkcounter_cdc'%'sys', dir='out', width=32)
            top.add_axi4lite_interface('sys', mode='r', nbytes=32, memory_map=self.memory_map, typecode=self.typecode)

            inst = top.get_instance(entity='cdc_synchroniser', name='sys_block_counter_cdc_inst')
            inst.add_parameter('G_BUS_WIDTH', value=32)
            inst.add_port('IP_CLK',       signal='axil_clk', parent_sig=False)
            inst.add_port('IP_RESET',     signal='axil_rst', parent_sig=False)                
            inst.add_port('IP_BUS_VALID', signal='1\'b1', parent_sig=False)
            inst.add_port('IP_BUS',       signal='%s_clkcounter_cdc'% 'sys', width=32, parent_sig=True)
            inst.add_port('OP_BUS',       signal='%s_clkcounter_in'% 'sys',  width=32, parent_sig=True)

        else:
            inst = top.get_instance('sys_block', 'sys_block_inst')
            inst.add_parameter('BOARD_ID', self.board_id)
            inst.add_parameter('REV_MAJ', self.rev_maj)
            inst.add_parameter('REV_MIN', self.rev_min)
            inst.add_parameter('REV_RCS', self.rev_rcs)
            inst.add_port('user_clk', 'user_clk', parent_port=False, parent_sig=False)
            inst.add_wb_interface('sys', mode='r', nbytes=32, memory_map=self.memory_map, typecode=self.typecode)
      
