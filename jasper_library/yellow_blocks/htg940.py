from .yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint

class htg940(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/htg940_infrastructure.v')
        self.add_source('wbs_arbiter')
        self.provides = ['sys_clk', 'sys_clk90', 'sys_clk180', 'sys_clk270']

    def modify_top(self,top):
        inst = top.get_instance('htg940_infrastructure', 'htg940_infrastructure_inst')
        inst.add_port('sys_clk_buf_n', 'sys_clk_n', parent_port=True, dir='in')
        inst.add_port('sys_clk_buf_p', 'sys_clk_p', parent_port=True, dir='in')
        inst.add_port('sys_clk0     ', 'sys_clk   ')
        inst.add_port('sys_clk180   ', 'sys_clk180')
        inst.add_port('sys_clk270   ', 'sys_clk270')
        inst.add_port('clk_200      ', 'clk_200   ')
        inst.add_port('clk_50       ', 'clk_50    ')
        inst.add_port('sys_rst      ', 'sys_rst   ')
        inst.add_port('idelay_rdy   ', 'idelay_rdy')
        inst.add_port('sys_clk_rst_sync', 'sys_clk_rst_sync')

        top.add_signal('sys_clk90')
        top.assign_signal('sys_clk90', '~sys_clk270')

        # Connect microblaze MAC LSBs to GPIO
        if self.use_microblaze:
            top.add_port('microblaze_mac_gpio', 'gpio', dir='in', width=4)
            top.assign_signal('%s_microblaze_mac_user_data_in[31:4]' % self.name, "28'heeeeeee")
            top.assign_signal('%s_microblaze_mac_user_data_in[3:0]' % self.name, 'microblaze_mac_gpio')

    def gen_children(self):
        children = [YellowBlock.make_block({
                        'tag':'xps:sys_block',
                        'board_id':'12',
                        'rev_maj':'12',
                        'rev_min':'0',
                        'rev_rcs':'32',
                    }, self.platform)]
        if self.use_microblaze:
            children.append(YellowBlock.make_block({
                'tag':'xps:microblaze',
            }, self.platform))
            children.append(YellowBlock.make_block({
                'tag':'xps:sw_reg_sync',
                'fullpath':'%s/microblaze_mac' % self.name,
                'io_dir':'To Processor',
                'name':'microblaze_mac',
            }, self.platform))
        return children

    def gen_constraints(self):
        consts = [
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=3.333), #TODO Is this right for HTG
            RawConstraint("set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN {DIV-2} [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8 [current_design]"), #TODO Is this right for HTG
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.UNUSEDPIN {Pullnone} [current_design]"),
            RawConstraint("set_property CFGBVS GND [ current_design ]"), #TODO Is this right for HTG
            RawConstraint("set_property CONFIG_VOLTAGE 1.8 [ current_design ]"), #TODO Is this right for HTG
            RawConstraint("set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN Enable [current_design]"),
        ]
        if self.use_microblaze:
            iomap = list(range(4))
            consts += [
                PortConstraint('microblaze_mac_gpio', 'gpio', port_index=iomap, iogroup_index=iomap)
            ]
        return consts
    def gen_tcl_cmds(self):
       tcl_cmds = {}
       #TODO is this right for HTG?
       tcl_cmds['promgen'] = ['write_cfgmem  -format mcs -size 128 -interface SPIx8 -loadbit "up 0x0 $bit_file " -checksum -file "$mcs_file" -force']
       return tcl_cmds
