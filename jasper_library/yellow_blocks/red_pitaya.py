from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint


class red_pitaya(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/red_pitaya.v')
        # might have to add block diagram, but it is probably included in the tcl bd tcl script
        pass

    def modify_top(self,top):
        pass

    def gen_children(self):
        return [
             YellowBlock.make_block({'tag': 'xps:sys_block', 'board_id': '3', 'rev_maj': '1', 'rev_min': '0', 'rev_rcs': '0'}, self.platform)
            ]

    def gen_constraints(self):
        return []
        #const_list = [
        #     RawConstraint('set_property CONFIG_MODE BPI16 [current_design]'),
        #     RawConstraint('set_property CONFIG_VOLTAGE %.1f [current_design]' % self.platform.conf['config_voltage']),
        #     RawConstraint('set_property CFGBVS %s [current_design]' % self.platform.conf['cfgbvs']),
        #     RawConstraint('set_property BITSTREAM.STARTUP.STARTUPCLK CCLK [current_design]'),
        #     RawConstraint('set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]'),
        #     RawConstraint('set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]'),
        #     RawConstraint('set_property BITSTREAM.CONFIG.TIMER_CFG 0X00040000 [current_design]')]
        #if self.platform.boot_image == 'golden':
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DISABLE [current_design]'))
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.BPI_SYNC_MODE DISABLE [current_design]'))
        #else:
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-2 [current_design]'))
        #    const_list.append(RawConstraint('set_property BITSTREAM.CONFIG.BPI_SYNC_MODE TYPE1 [current_design]'))

        #return const_list

    def gen_tcl_cmds(self):
       tcl_cmds = {}
       tcl_cmds['pre_synth'] = []
       """
       Add a block design to project with wrapper via its exported tcl script.
       1. Source the tcl script.
       2. Generate the block design via generate_target.
       3. Have vivado make an HDL wrapper around the block design.
       4. Add the wrapper HDL file to project.
       """
       tcl_cmds += ['source {}'.format(self.hdl_path + '/infrastructure/red_pitaya.tcl')]
       tcl_cmds += ['generate_target all [get_files \"./my_proj.srcs/sources_1/bd/base/base.bd\"]']
       tcl_cmds += ['make_wrapper -files [get_files ./myproj.srcs/sources_1/bd/base/base.bd] -top']
       tcl_cmds += ['add_files -norecurse ./myproj.srcs/sources_1/bd/base/hdl/base_wrapper.v']
       tcl_cmds += ['update_compile_order -fileset sources_1']
       return tcl_cmds


