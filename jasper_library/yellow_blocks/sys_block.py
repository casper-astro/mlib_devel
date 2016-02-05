from yellow_block import YellowBlock

class sys_block(YellowBlock):
    def initialize(self):
        self.add_source('sys_block')
    def modify_top(self,top):
        inst = top.get_instance('sys_block', 'sys_block_inst')
        inst.add_parameter('BOARD_ID', self.board_id)
        inst.add_parameter('REV_MAJ', self.rev_maj)
        inst.add_parameter('REV_MIN', self.rev_min)
        inst.add_parameter('REV_RCS', self.rev_rcs)
        inst.add_port('user_clk', 'user_clk')
        inst.add_wb_interface('sys_block', mode='r', nbytes=64)
        
