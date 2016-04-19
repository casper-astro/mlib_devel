from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint

class skarab(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure')
        pass

    def modify_top(self,top):
        pass
    def gen_children(self):
        return [
            YellowBlock.make_block({'tag':'xps:sys_block', 'board_id':'12', 'rev_maj':'12', 'rev_min':'0', 'rev_rcs':'32'}, self.platform),
            ]
    def gen_constraints(self):
        return [
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=5.0),
        ]
