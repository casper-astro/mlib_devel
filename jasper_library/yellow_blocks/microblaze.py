from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, RawConstraint
from os import environ as env


class microblaze(YellowBlock):
    def initialize(self):
        self.elf = 'hw0.elf'
        self.add_source('microblaze_wb/%s' % self.elf)
        self.ips = [{'path':'%s/axi_wb_bridge/ip_repo' % env['HDL_ROOT'],
                     'name':'axi_slave_wishbone_classic_master',
                     'vendor':'peralex.com',
                     'library':'user',
                     'version':'1.0',
                    }]
        self.requires = ['cpu_ethernet']

    def modify_top(self,top):
        inst = top.get_instance(entity='cont_microblaze', name='cont_microblaze_inst', comment='%s: Microblaze Control and Monitoring subsystem' % self.fullname)
        inst.add_port('Clk', 'wb_clk_i')
        inst.add_port('Reset', 'wb_rst_i')
        inst.add_port('dcm_locked', '1\'b1')
        inst.add_port('UART_rxd', 'UART_rxd', dir='in', parent_port=True)
        inst.add_port('UART_txd', 'UART_txd', dir='out', parent_port=True)
        inst.add_port('CYC_O', 'wbm_cyc_o')
        inst.add_port('STB_O', 'wbm_stb_o')
        inst.add_port('WE_O ', 'wbm_we_o ')
        inst.add_port('SEL_O', 'wbm_sel_o', width=4)
        inst.add_port('ADR_O', 'wbm_adr_o', width=32)
        inst.add_port('DAT_O', 'wbm_dat_o', width=32)
        inst.add_port('DAT_I', 'wbm_dat_i', width=32)
        inst.add_port('ACK_I', 'wbm_ack_i')
        inst.add_port('RST_O', 'wbm_rst_o')

        top.assign_signal('wb_clk_i', 'sys_clk')
        top.assign_signal('wb_rst_i', 'sys_rst')

 
    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('UART_rxd', 'usb_tx'))
        cons.append(PortConstraint('UART_txd', 'usb_rx')) 
        return cons

    def gen_tcl_cmds(self):
        #tcl_cmds.append('set_property SCOPED_TO_REF %s [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/imports/cont_microblaze/EMB123701U1R1.elf]' % self.fullname)
        #tcl_cmds.append('set_property SCOPED_TO_CELLS %s [get_files [get_property directory [current_project]]/myproj.srcs/sources_1/imports/cont_microblaze/EMB123701U1R1.elf]' % self.fullname)
        tcl_cmds = []
        tcl_cmds += ['source %s/microblaze_wb/microblaze_wb.tcl' % env['HDL_ROOT']]
        tcl_cmds += ['set_property SCOPED_TO_REF cont_microblaze [get_files -all -of_objects [get_fileset sources_1] {%s}]' % self.elf]
        tcl_cmds += ['set_property SCOPED_TO_CELLS { microblaze_0 } [get_files -all -of_objects [get_fileset sources_1] {%s}]' % self.elf]
        return tcl_cmds
