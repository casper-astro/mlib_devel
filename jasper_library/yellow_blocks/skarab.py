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
             YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform)
             #YellowBlock.make_block({'tag': 'xps:forty_gbe'}, self.platform)
            ]

    def gen_constraints(self):
        return [
            RawConstraint('set_property CONFIG_MODE BPI16 [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-2 [current_design]'),
            RawConstraint('set_property CONFIG_VOLTAGE %.1f [current_design]' % self.platform.conf['config_voltage']),
            RawConstraint('set_property CFGBVS %s [current_design]' % self.platform.conf['cfgbvs']),
            RawConstraint('set_property BITSTREAM.CONFIG.BPI_SYNC_MODE TYPE1 [current_design]'),
            RawConstraint('set_property BITSTREAM.STARTUP.STARTUPCLK CCLK [current_design]'),
            RawConstraint('set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.TIMER_CFG 0X00040000 [current_design]')
            #PortConstraint('sys_clk_n', 'sys_clk_n'),
            #PortConstraint('sys_clk_p', 'sys_clk_p'),
            #ClockConstraint('sys_clk_p', period=5.0)
        ]
