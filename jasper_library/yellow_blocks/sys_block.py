from yellow_block import YellowBlock
from memory import Register
from yellow_block_typecodes import *

class sys_block(YellowBlock):
    def initialize(self):
        self.typecode = TYPECODE_SYSBLOCK
        self.add_source('sys_block')
        # the internal memory_map
        self.memory_map = [
            Register('sys_board_id',   mode='r',  offset=0),
            Register('sys_rev',        mode='r',  offset=0x4),
            Register('sys_rev_rcs',    mode='r',  offset=0xc),
            Register('sys_scratchpad', mode='rw', offset=0x10),
            Register('sys_clkcounter', mode='r',  offset=0x14),
        ]
    def modify_top(self,top):
        inst = top.get_instance('sys_block', 'sys_block_inst')
        inst.add_parameter('BOARD_ID', self.board_id)
        inst.add_parameter('REV_MAJ', self.rev_maj)
        inst.add_parameter('REV_MIN', self.rev_min)
        inst.add_parameter('REV_RCS', self.rev_rcs)
        inst.add_port('user_clk', 'user_clk')
        inst.add_wb_interface('sys_block', mode='r', nbytes=64, memory_map=self.memory_map, typecode=self.typecode)
        
