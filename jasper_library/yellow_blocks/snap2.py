from yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint

class snap2(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure')
        self.add_source('wbs_arbiter')

    def modify_top(self,top):
        inst = top.get_instance('snap2_infrastructure', 'snap2_infrastructure_inst')
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
            #children.append(YellowBlock.make_block({'tag':'xps:xadc'}, self.platform))
        return children

    def gen_constraints(self):
        return [
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=8.0),
            #RawConstraint('set_property CONFIG_VOLTAGE 2.5 [current_design]'),
            #RawConstraint('set_property CFGBVS VCCO [current_design]'),
            #RawConstraint('set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]'),
            #RawConstraint('set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]'),
        ]

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        # After generating bitstream write PROM file
        #tcl_cmds['promgen'] = ['write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit "up 0x00000000 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.mcs"']
        return tcl_cmds
