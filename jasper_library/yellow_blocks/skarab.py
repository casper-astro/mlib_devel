from .yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint



class skarab(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/')
        self.add_source('wbs_arbiter_skarab/*.v')
        self.add_source('wbs_arbiter/timeout.v')
        pass

    def modify_top(self,top):
        pass

    def gen_children(self):
        return [
             YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '2', 'rev_min': '0', 'rev_rcs': '1'}, self.platform)
             #YellowBlock.make_block({'tag': 'xps:forty_gbe'}, self.platform)
            ]

    def gen_constraints(self):
        const_list = [
             RawConstraint('set_property CONFIG_MODE BPI16 [current_design]'),
             RawConstraint('set_property CONFIG_VOLTAGE %.1f [current_design]' % self.platform.conf['config_voltage']),
             RawConstraint('set_property CFGBVS %s [current_design]' % self.platform.conf['cfgbvs']),
             RawConstraint('set_property BITSTREAM.STARTUP.STARTUPCLK CCLK [current_design]'),
             RawConstraint('set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]'),
             RawConstraint('set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]'),
             RawConstraint('set_property BITSTREAM.CONFIG.TIMER_CFG 0X00040000 [current_design]')]
        if self.platform.boot_image == 'golden':
            const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DISABLE [current_design]'))
            const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.BPI_SYNC_MODE DISABLE [current_design]'))
        else:
            const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-2 [current_design]'))
            const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.BPI_SYNC_MODE TYPE1 [current_design]'))

        return const_list

    def gen_tcl_cmds(self):
        """

        """
        
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        tcl_cmds['pre_impl'] = []

        try:
            # Can't have one without the other!
            if 'default' not in self.synth_strat.lower():
                tcl_cmds['pre_synth'] += ['set_property strategy {} [get_runs synth_1]'.format(self.synth_strat)]
            if 'default' not in self.impl_strat.lower():
                tcl_cmds['pre_impl'] += ['set_property strategy {} [get_runs impl_1]'.format(self.impl_strat)]
        except KeyError:
            tcl_cmds = {}

        return tcl_cmds

