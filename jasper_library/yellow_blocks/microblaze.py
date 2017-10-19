from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, RawConstraint
from os import environ as env


class microblaze(YellowBlock):
    def initialize(self):
        if self.platform.name == 'snap2':
            self.memfile= 'executable_no_xadc.mem'
            self.blkdiagram = 'microblaze_wb_no_xadc.tcl'
        else:
            self.memfile = 'executable.mem'
            self.blkdiagram = 'microblaze_wb.tcl'

        #self.add_source('microblaze_wb/%s' % self.elf)
        self.ips = [{'path':'%s/axi_wb_bridge/ip_repo' % env['HDL_ROOT'],
                     'name':'axi_slave_wishbone_classic_master',
                     'vendor':'peralex.com',
                     'library':'user',
                     'version':'1.0',
                    }]
        #self.requires = ['cpu_ethernet']

    def _connect_to_tristate_buf(self, top, inst, name):
        """
        Instantiate a tri-state buffer, connected to inst's I,O, and T ports.
        Propagate the IO port to a port in top.
        """
        ioinst = top.get_instance(entity='IOBUF', name=name, comment='Bidirectional buffer placed by microblaze yellow block')
        ioinst.add_port('I',  '%s_o'  % name,  dir='in',    parent_port=False)
        ioinst.add_port('O',  '%s_i'  % name,  dir='out',   parent_port=False)
        ioinst.add_port('IO', '%s' % name,     dir='inout', parent_port=True)
        ioinst.add_port('T',  '%s_t'  % name,  dir='in',    parent_port=False)
        inst.add_port('%s_i' % name, '%s_i' % name)
        inst.add_port('%s_o' % name, '%s_o' % name)
        inst.add_port('%s_t' % name, '%s_t' % name)

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
        ## endian flip for Microblaze compatibility.
        #inst.add_port('DAT_O', '{wbm_dat_o[7:0], wbm_dat_o[15:8], wbm_dat_o[23:16], wbm_dat_o[31:24]}', width=32, parent_sig=False)
        #inst.add_port('DAT_I', '{wbm_dat_i[7:0], wbm_dat_i[15:8], wbm_dat_i[23:16], wbm_dat_i[31:24]}', width=32, parent_sig=False)
        inst.add_port('ACK_I', 'wbm_ack_i')
        inst.add_port('RST_O', 'wbm_rst_o')
        inst.add_port('ext_intr', 'mb_intr') 
        # Add the SPI ports, which get connected through tristate buffers
        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io0')
        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io1')
        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io2')
        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io3')
        #self._connect_to_tristate_buf(top, inst, 'spi_rtl_sck')
        self._connect_to_tristate_buf(top, inst, 'spi_rtl_ss')

        top.assign_signal('wb_clk_i', 'sys_clk')
        top.assign_signal('wb_rst_i', 'sys_rst')

        top.add_signal('mb_intr_v', width=4)
        top.assign_signal('mb_intr', '|mb_intr_v')


 
    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('UART_rxd', 'usb_tx'))
        cons.append(PortConstraint('UART_txd', 'usb_rx')) 
        cons.append(PortConstraint('spi_rtl_io0', 'spi_flash_data', iogroup_index=[0]))
        cons.append(PortConstraint('spi_rtl_io1', 'spi_flash_data', iogroup_index=[1]))
        cons.append(PortConstraint('spi_rtl_io2', 'spi_flash_data', iogroup_index=[2]))
        cons.append(PortConstraint('spi_rtl_io3', 'spi_flash_data', iogroup_index=[3]))
        #cons.append(PortConstraint('spi_rtl_sck', 'spi_flash_clk'))
        cons.append(PortConstraint('spi_rtl_ss' , 'spi_flash_csn'))
        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = ['source %s/microblaze_wb/%s' % (env['HDL_ROOT'], self.blkdiagram)]

        # Concatenate the executable and core_info file (post bitgen so relative paths will work)
        tcl_cmds['post_bitgen'] = ['exec cat %s/microblaze_wb/%s ../core_info.jam.tab.mem > ../executable_core_info.mem' % (env['HDL_ROOT'], self.memfile)]
        # overwrite top.bit with version that includes microblaze code
        # ignorestderr because this command fails even though it appears to work.
        # Flags an awk error: see https://forums.xilinx.com/t5/Installation-and-Licensing/Vivado-2016-4-on-Ubuntu-16-04-LTS-quot-awk-symbol-lookup-error/m-p/747165
        tcl_cmds['post_bitgen'] += ['exec -ignorestderr updatemem -bit ./myproj.runs/impl_1/top.bit -meminfo ./myproj.runs/impl_1/top.mmi -data ../executable_core_info.mem  -proc cont_microblaze_inst/microblaze_0 -out ./myproj.runs/impl_1/top.bit -force']
        return tcl_cmds
