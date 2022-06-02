from .yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint

class snap2(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/snap2*')
        self.add_source('wbs_arbiter')
        self.version = self.platform.version

    def modify_top(self,top):
        if self.version == 2:
            inst = top.get_instance('snap2_v2_infrastructure', 'snap2_v2_infrastructure_inst')
        else:
            inst = top.get_instance('snap2_infrastructure', 'snap2_infrastructure_inst')
        inst.add_port('sys_clk_buf_n', 'sys_clk_n', parent_port=True, dir='in')
        inst.add_port('sys_clk_buf_p', 'sys_clk_p', parent_port=True, dir='in')
        #inst.add_port('ext_sys_rst_n', 'ext_sys_rst_n', parent_port=True, dir='in')
        inst.add_port('sys_clk0     ', 'sys_clk   ')
        inst.add_port('sys_clk180   ', 'sys_clk180')
        inst.add_port('sys_clk270   ', 'sys_clk270')
        inst.add_port('clk_200      ', 'clk_200   ')
        inst.add_port('clk_250MHz   ', 'clk_250MHz')
        inst.add_port('clk_10MHz    ', 'clk_10MHz')
        inst.add_port('clk_250MHz270', 'clk_250MHz270')
        inst.add_port('sys_rst      ', 'sys_rst   ')
        inst.add_port('pll_lock   ', 'pll_lock')

        top.add_signal('sys_clk90')
        top.assign_signal('sys_clk90', '~sys_clk270')
        top.add_signal('clk_250MHz90')
        top.assign_signal('clk_250MHz90', '~clk_250MHz270')
        top.add_signal('clk_250MHz180')
        top.assign_signal('clk_250MHz180', '~clk_250MHz')

        top.add_signal('clk_200')
        # HACK: these clocks aren't at the phases they claim.
        # I hope you're not using them!
        top.add_signal('clk_20090')
        top.assign_signal('clk_20090', 'clk_200')
        top.add_signal('clk_200180')
        top.assign_signal('clk_200180', '~clk_200')
        top.add_signal('clk_200270')
        top.assign_signal('clk_200270', '~clk_200')

    def gen_children(self):
        children = [YellowBlock.make_block({'tag':'xps:sys_block', 'board_id':'13', 'rev_maj':'1', 'rev_min':'0', 'rev_rcs':'32'}, self.platform)]
        children += [YellowBlock.make_block({'tag':'xps:sysmon'}, self.platform)]
        if self.use_microblaze:
            children.append(YellowBlock.make_block({'tag':'xps:microblaze'}, self.platform))
        else:
            children.append(YellowBlock.make_block({'tag':'xps:spi_wb_bridge'}, self.platform))
        return children

    def gen_constraints(self):
        if self.version == 2:
            config_voltage = '2.5'
            cfgbvs = 'VCCO'
        else:
            config_voltage = '1.8'
            cfgbvs = 'GND'
        return [
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=8.0),
            #PortConstraint('ext_sys_rst_n', 'ext_sys_rst_n'),
            RawConstraint('set_property CONFIG_VOLTAGE %s [current_design]' % config_voltage),
            RawConstraint('set_property CFGBVS %s [current_design]' % cfgbvs),
            RawConstraint('set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes [current_design]'),
            #RawConstraint('set_property BITSTREAM.CONFIG.TIMER_CFG 20000000 [current_design]'),
            RawConstraint('set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]'),
            RawConstraint("set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN Enable [current_design]"),
            ]


    def gen_tcl_cmds(self):
        tcl_cmds = {}

        # Turn on power optimization before place / route.
        # TODO: This may be detrimental to timing, so probably should be an option somewhere.
        tcl_cmds['pre_impl'] = []
        tcl_cmds['pre_impl'] += ['set_property STEPS.POWER_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]']

        # After generating bitstream write PROM file
        # Write both mcs and bin files. The latter are good for remote programming via microblaze. And makes sure the
        # microblaze code makes it into top.bin, and hence top.bof
        tcl_cmds['promgen'] = []
        #tcl_cmds['promgen'] += ['write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.mcs" -force']
        #tcl_cmds['promgen'] += ['write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x%.7x ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top_0x%x.mcs" -force' % (self.usermemaddr, self.usermemaddr)]
        tcl_cmds['promgen'] += ['write_cfgmem  -format bin -size 64 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.bin" -force']
        return tcl_cmds

