from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint


class skarab(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure')
        self.add_source('wbs_arbiter')
        pass

    def modify_top(self,top):
        pass

    def gen_children(self):
        return [
            # YellowBlock.make_block({'tag':'xps:sys_block', 'board_id':'12', 'rev_maj':'12', 'rev_min':'0', 'rev_rcs':'32'}, self.platform),
            # YellowBlock.make_block({'tag': 'xps:forty_gbe'}, self.platform)
            ]

    def gen_constraints(self):
        return [
            RawConstraint('set_property CONFIG_VOLTAGE 1.8 [current_design]'),
            RawConstraint('set_property CFGBVS GND [current_design]'),
            #PortConstraint('sys_clk_n', 'sys_clk_n'),
            #PortConstraint('sys_clk_p', 'sys_clk_p'),
            #ClockConstraint('sys_clk_p', period=5.0)
        ]