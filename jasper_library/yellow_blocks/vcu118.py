from .yellow_block import YellowBlock
from constraints import ClockConstraint, PortConstraint, RawConstraint

class vcu118(YellowBlock):
    def initialize(self):
        self.add_source('infrastructure/vcu118_infrastructure.v')
        provided_clks = ['sys_clk', 'clk_200mhz']
        for clk in provided_clks:
            self.provides += [clk]
            self.provides += [clk+'90']
            self.provides += [clk+'180']
            self.provides += [clk+'270']

    def modify_top(self,top):
        inst = top.get_instance('vcu118_infrastructure', 'vcu118_infrastructure_inst')
        inst.add_port('sys_clk_buf_n', 'sys_clk_n', parent_port=True, dir='in')
        inst.add_port('sys_clk_buf_p', 'sys_clk_p', parent_port=True, dir='in')
        inst.add_port('sys_clk0     ', 'sys_clk    ')
        inst.add_port('sys_clk90    ', 'sys_clk90  ')
        inst.add_port('sys_clk180   ', 'sys_clk180 ')
        inst.add_port('sys_clk270   ', 'sys_clk270 ')
        inst.add_port('clk_200_0    ', 'clk_200mhz   ')
        inst.add_port('clk_200_90   ', 'clk_200mhz90 ')
        inst.add_port('clk_200_180  ', 'clk_200mhz180')
        inst.add_port('clk_200_270  ', 'clk_200mhz270')
        inst.add_port('sys_rst      ', 'sys_rst    ')
        inst.add_port('idelay_rdy   ', 'idelay_rdy ')
        inst.add_port('sys_clk_rst_sync', 'sys_clk_rst_sync')

    def gen_children(self):
        children = [YellowBlock.make_block({'fullpath': self.fullpath,'tag':'xps:sys_block', 'board_id':'12', 'rev_maj':'12', 'rev_min':'0', 'rev_rcs':'32','scratchpad': '0'}, self.platform)]
        # print (self.use_microblaze)
        # print (self.use_jtag_axil_master)
        if self.axi_master == "microblaze":
            # There is currently no AXI version of the microblaze master
            raise RuntimeError("Microblaze AXI Master not supported!")
        elif self.axi_master == "jtag":
            children.append(YellowBlock.make_block({'tag':'xps:jtag_axil_master'}, self.platform))
        elif self.axi_master == "pci":
            children.append(YellowBlock.make_block({'tag':'xps:pci_dma_axilite_master'}, self.platform))
        elif self.axi_master == "spi":
            # There is currently no AXI version of the SPI master
            raise RuntimeError("SPI AXI Master not supported!")
            #children.append(YellowBlock.make_block({'tag':'xps:spi_wb_bridge'}, self.platform))
        else:
            raise RuntimeError("Unknown AXI Master selection!")
        return children

    def gen_constraints(self):
        return [
            PortConstraint('sys_clk_n', 'sys_clk_n'),
            PortConstraint('sys_clk_p', 'sys_clk_p'),
            ClockConstraint('sys_clk_p', period=4.0),
            #Refer to UG1314 page 23 for settings
            RawConstraint("set_property CONFIG_VOLTAGE 1.8 [ current_design ]"),
            RawConstraint("set_property BITSTREAM.CONFIG.CONFIGFALLBACK Enable [ current_design ]"),
            RawConstraint("set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]"),
            RawConstraint("set_property CONFIG_MODE SPIx4 [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN disable [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]"),
            RawConstraint("set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]"),
        ]

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['promgen'] = ['write_cfgmem -force -format mcs -interface spix4 -size 1024  -loadbit "up 0x01002000 ./myproj.runs/impl_1/top.bit " -checksum -file "./myproj.runs/impl_1/top.mcs"']
        return tcl_cmds
