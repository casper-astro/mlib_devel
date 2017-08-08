from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint

class spi_wb_bridge(YellowBlock):
    def initialize(self):
        self.provides.append('wb_master')
        self.add_source('spi_wb_bridge')

    def modify_top(self,top):
        inst = top.get_instance('spi_wb_bridge', 'spi_wb_bridge_inst')
        inst.add_parameter('LITTLE_ENDIAN', 1)
        inst.add_port('wb_clk_i' , 'wb_clk_i')
        inst.add_port('wb_rst_i' , 'wb_rst_i')
        inst.add_port('wbm_cyc_o', 'wbm_cyc_o')
        inst.add_port('wbm_stb_o', 'wbm_stb_o')
        inst.add_port('wbm_we_o ', 'wbm_we_o ')
        inst.add_port('wbm_sel_o', 'wbm_sel_o', width=4)
        inst.add_port('wbm_adr_o', 'wbm_adr_o', width=32)
        inst.add_port('wbm_dat_o', 'wbm_dat_o', width=32)
        inst.add_port('wbm_dat_i', 'wbm_dat_i', width=32)
        inst.add_port('wbm_ack_i', 'wbm_ack_i')
        inst.add_port('wbm_err_i', 'wbm_err_i')
        inst.add_port('cs_n', 'cs_n', parent_port=True, dir='in')
        inst.add_port('sclk', 'sclk', parent_port=True, dir='in')
        inst.add_port('mosi', 'mosi', parent_port=True, dir='in')
        inst.add_port('miso', 'miso', parent_port=True, dir='out')
        inst.add_port('new_cmd_stb', '')

        top.assign_signal('wb_clk_i', 'sys_clk')
        top.assign_signal('wb_rst_i', 'sys_rst')

    def gen_constraints(self):
        return [
            PortConstraint('cs_n', 'cs_n'),
            PortConstraint('sclk', 'sclk'),
            PortConstraint('mosi', 'mosi'),
            PortConstraint('miso', 'miso'),
            ]
