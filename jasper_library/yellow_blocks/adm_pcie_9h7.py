from .yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint

class adm_pcie_9h7(YellowBlock):
    def __init__(self, blk, platform, hdl_root=None):
        # HACK to crowbar the partial reconf flag into a platform attribute
        YellowBlock.__init__(self, blk, platform, hdl_root=hdl_root)
        try:
            if self.use_pr:
                platform.use_pr = True
        except AttributeError:
            self.use_pr = False

    def initialize(self):
        self.add_source('infrastructure/adm_pcie_9h7_infrastructure.v')
        self.add_source('wbs_arbiter')
        self.provides = ['sys_clk', 'sys_clk90', 'sys_clk180', 'sys_clk270']

    def modify_top(self,top):
        inst = top.get_instance('adm_pcie_9h7_infrastructure', 'adm_pcie_9h7_infrastructure_inst')
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

    def gen_children(self):
        enable_wishbone = 'wishbone' in self.platform.mmbus_architecture
        children = [YellowBlock.make_block({
                        'tag':'xps:sys_block',
                        'board_id':'12',
                        'rev_maj':'12',
                        'rev_min':'0',
                        'rev_rcs':'32',
                    }, self.platform)]
        if self.use_microblaze:
            pass
        else:
            b = YellowBlock.make_block({
                'tag' : 'xps:pci_dma_axilite_master',
                'use_pr' : self.use_pr,
                'template_project' : self.pr_template,
                'enable_wishbone' : enable_wishbone,
                }, self.platform)
            children.append(b)

        return children

    def gen_constraints(self):
        return [
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=3.333),
            RawConstraint("set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN {DIV-2} [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8 [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.UNUSEDPIN {Pullnone} [current_design]"),
            RawConstraint("set_property CFGBVS GND [ current_design ]"),
            RawConstraint("set_property CONFIG_VOLTAGE 1.8 [ current_design ]"),
            RawConstraint("set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN Enable [current_design]"),
        ]
    def gen_tcl_cmds(self):
       tcl_cmds = {}
       tcl_cmds['promgen'] = ['write_cfgmem  -format mcs -size 64 -interface SPIx8 -loadbit "up 0x0 $bit_file " -checksum -file "$mcs_file" -force']
       return tcl_cmds
