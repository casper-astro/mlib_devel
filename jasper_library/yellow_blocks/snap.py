from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint

class snap(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure')
        self.add_source('wbs_arbiter')
        # 32-bit addressing => second half of 32 MByte memory. See UG470 v1.11 Table 7.2, Note 1
        self.usermemaddr = 0x800000  >> 8 
        self.golden = False

    def modify_top(self,top):
        inst = top.get_instance('snap_infrastructure', 'snap_infrastructure_inst')
        inst.add_port('sys_clk_buf_n', 'sys_clk_n', parent_port=True, dir='in')
        inst.add_port('sys_clk_buf_p', 'sys_clk_p', parent_port=True, dir='in')
        inst.add_port('sys_clk0     ', 'sys_clk   ')
        inst.add_port('sys_clk180   ', 'sys_clk180')
        inst.add_port('sys_clk270   ', 'sys_clk270')
        inst.add_port('clk_200      ', 'clk_200   ')
        inst.add_port('sys_rst      ', 'sys_rst   ')
        inst.add_port('idelay_rdy   ', 'idelay_rdy')

        top.add_signal('sys_clk90')
        top.assign_signal('sys_clk90', '~sys_clk270')

    def gen_children(self):
        children = [YellowBlock.make_block({'tag':'xps:sys_block', 'board_id':'12', 'rev_maj':'12', 'rev_min':'0', 'rev_rcs':'32'}, self.platform)]
        if self.use_microblaze:
            children.append(YellowBlock.make_block({'tag':'xps:microblaze'}, self.platform))
        else:
            children.append(YellowBlock.make_block({'tag':'xps:spi_wb_bridge'}, self.platform))
            # XADC is embedded in the microblaze core, so don't include another one unless we're not microblazin'
            children.append(YellowBlock.make_block({'tag':'xps:xadc'}, self.platform))
        return children

    def gen_constraints(self):
        cons =[
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=5.0),
            RawConstraint('set_property CONFIG_VOLTAGE 2.5 [current_design]'),
            RawConstraint('set_property CFGBVS VCCO [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR Yes [current_design]'),
            RawConstraint('set_property BITSTREAM.CONFIG.TIMER_CFG 2000000 [current_design]'), # about 10 seconds
        ]
        if self.golden:
            #cons += [RawConstraint('set_property BITSTREAM.CONFIG.NEXT_CONFIG_ADDR 0x%.7x [current_design]' % self.usermemaddr),]
            pass
        else:
            cons += [RawConstraint('set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]'),]
        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        # After generating bitstream write PROM file
        # Write both mcs and bin files. The latter are good for remote programming via microblaze. And makes sure the
        # microblaze code makes it into top.bin, and hence top.bof
        tcl_cmds['promgen'] = []
        tcl_cmds['promgen'] += ['write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.mcs" -force']
        tcl_cmds['promgen'] += ['write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x%.7x ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top_0x%x.mcs" -force' % (self.usermemaddr, self.usermemaddr)]
        tcl_cmds['promgen'] += ['write_cfgmem  -format bin -size 32 -interface SPIx4 -loadbit "up 0x0 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.bin" -force']
        return tcl_cmds
