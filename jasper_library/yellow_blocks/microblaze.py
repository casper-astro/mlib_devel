from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, RawConstraint
from os import environ as env


class microblaze(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.fpga.startswith('xcku'):
            return microblaze_ku7(blk, plat, hdl_root)
        elif plat.fpga.startswith('xcvu37p'):
            # this is for vcu128, which is based on virtex ultrascale+ chip
            # we add some new ports for initalize the adc4x16g board, so the tcl script is updated
            return microblaze_vu_plus(blk,plat,hdl_root)
        else:
            return microblaze_k7(blk, plat, hdl_root)

    def initialize(self):
        self.include_spi_ports = True
        if self.platform.name in ['snap2']:
            if self.platform.version == 1:
                self.memfile= 'executable_no_xadc.mem'
                self.blkdiagram = 'microblaze_wb_no_xadc.tcl'
            else:
                self.memfile= 'executable_no_xadc.mem'
                self.blkdiagram = 'microblaze_wb_no_xadc.tcl'
        elif self.platform.name in ['vcu118']:
            self.memfile = 'executable_us_plus.mem'
            self.blkdiagram = 'microblaze_wb_us_plus.tcl'
            self.include_spi_ports = False
        elif self.platform.name in ['vcu128']:
            self.memfile = 'executable_us_plus.mem'
            #self.blkdiagram = 'microblaze_wb_us_plus_hbm.tcl'
            #this is the new tcl, in which we added two axi-gpio and axi-spi modules for adc4x16g initalization
            self.blkdiagram = 'microblaze_wb_us_plus_hbm_vu_plus.tcl'
            self.include_spi_ports = False
        elif self.platform.name == 'casia_k7':
            self.memfile= 'executable_casia_k7.mem'
           # self.memfile = 'executable.mem'
            self.blkdiagram = 'microblaze_wb_casia_k7.tcl'
        elif self.platform.name == 'casia_k7_21cma':
            self.memfile= 'executable_casia_k7.mem'
           # self.memfile = 'executable.mem'
            self.blkdiagram = 'microblaze_wb_casia_k7.tcl'
        elif self.platform.conf.get('family', None) == 'ultrascaleplus':
            self.memfile = 'executable_us_plus.mem'
            self.blkdiagram = 'microblaze_wb_us_plus_hbm.tcl'
            self.include_spi_ports = False
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

        self.bd_inst_name = '{:s}_bd'.format(self.platform.conf['name'])

        #self.requires = ['cpu_ethernet']

class microblaze_k7(microblaze):

    def _connect_to_tristate_buf(self, top, inst, name):
        """
        Instantiate a tri-state buffer, connected to inst's I,O, and T ports.
        Propagate the IO port to a port in top.
        """
        ioinst = top.get_instance(entity='IOBUF', name=name+'_inst', comment='Bidirectional buffer placed by microblaze yellow block')
        ioinst.add_port('I',  '%s_o'  % name,  dir='in',    parent_port=False)
        ioinst.add_port('O',  '%s_i'  % name,  dir='out',   parent_port=False)
        ioinst.add_port('IO', '%s' % name,     dir='inout', parent_port=True)
        ioinst.add_port('T',  '%s_t'  % name,  dir='in',    parent_port=False)
        inst.add_port('%s_i' % name, '%s_i' % name)
        inst.add_port('%s_o' % name, '%s_o' % name)
        inst.add_port('%s_t' % name, '%s_t' % name)

    def modify_top(self,top):
        inst = top.get_instance(entity=self.bd_inst_name, name='%s_inst' % self.bd_inst_name, comment='%s: Microblaze Control and Monitoring subsystem' % self.fullname)
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
        if self.include_spi_ports:
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
        if self.include_spi_ports:
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
        tcl_cmds['post_bitgen'] += ['exec -ignorestderr updatemem -bit ./myproj.runs/impl_1/top.bit -meminfo ./myproj.runs/impl_1/top.mmi -data ../executable_core_info.mem  -proc %s_inst/microblaze_0 -out ./myproj.runs/impl_1/top.bit -force' % self.bd_inst_name]
        return tcl_cmds

class microblaze_ku7(microblaze):

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
        inst = top.get_instance(entity=self.bd_inst_name, name='%s_inst' % self.bd_inst_name, comment='%s: Microblaze Control and Monitoring subsystem' % self.fullname)
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
#        # Add the SPI ports, which get connected through tristate buffers
#        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io0')
#        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io1')
#        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io2')
#        self._connect_to_tristate_buf(top, inst, 'spi_rtl_io3')
#        #self._connect_to_tristate_buf(top, inst, 'spi_rtl_sck')
#        self._connect_to_tristate_buf(top, inst, 'spi_rtl_ss')

        top.assign_signal('wb_clk_i', 'sys_clk')
        top.assign_signal('wb_rst_i', 'sys_rst')

        top.add_signal('mb_intr_v', width=4)
        top.assign_signal('mb_intr', '|mb_intr_v')


 
    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('UART_rxd', 'usb_tx'))
        cons.append(PortConstraint('UART_txd', 'usb_rx')) 
#        cons.append(PortConstraint('spi_rtl_io0', 'spi_flash_data', iogroup_index=[0]))
#        cons.append(PortConstraint('spi_rtl_io1', 'spi_flash_data', iogroup_index=[1]))
#        cons.append(PortConstraint('spi_rtl_io2', 'spi_flash_data', iogroup_index=[2]))
#        cons.append(PortConstraint('spi_rtl_io3', 'spi_flash_data', iogroup_index=[3]))
#        #cons.append(PortConstraint('spi_rtl_sck', 'spi_flash_clk'))
#        cons.append(PortConstraint('spi_rtl_ss' , 'spi_flash_csn'))
        return cons

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = ['source %s/microblaze_wb/%s' % (env['HDL_ROOT'], self.blkdiagram)]

        # Concatenate the executable and core_info file (post bitgen so relative paths will work)
        tcl_cmds['post_bitgen'] = ['exec cat %s/microblaze_wb/%s ../core_info.jam.tab.mem > ../executable_core_info.mem' % (env['HDL_ROOT'], self.memfile)]
        # overwrite top.bit with version that includes microblaze code
        # ignorestderr because this command fails even though it appears to work.
        # Flags an awk error: see https://forums.xilinx.com/t5/Installation-and-Licensing/Vivado-2016-4-on-Ubuntu-16-04-LTS-quot-awk-symbol-lookup-error/m-p/747165
        tcl_cmds['post_bitgen'] += ['exec -ignorestderr updatemem -bit ./myproj.runs/impl_1/top.bit -meminfo ./myproj.runs/impl_1/top.mmi -data ../executable_core_info.mem  -proc %s/microblaze_0 -out ./myproj.runs/impl_1/top.bit -force' % self.bd_inst_name]
        return tcl_cmds
     
class microblaze_vu_plus(microblaze):

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
        inst = top.get_instance(entity=self.bd_inst_name, name='%_inst' % self.bd_inst_name, comment='%s: Microblaze Control and Monitoring subsystem' % self.fullname)
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
        #add signals for adc4x16g initlization
        inst.add_port('ADC4X16G_CONFIG_tri_o','adc4x16g_config',width=32)
        inst.add_port('ADC4X16G_MATCH_PATTERN_tri_o','adc4x16g_match_pattern',width=32)
        inst.add_port('ADC4X16G_DRP_CONFIG_tri_o','adc4x16g_drp_config',width=32)
        inst.add_port('ADC4X16G_DRP_DATA_tri_i','adc4x16g_drp_data',width=32)
        inst.add_port('MOSI','adc4x16g_mosi')
        inst.add_port('MISO','adc4x16g_miso')
        inst.add_port('SCK','adc4x16g_sck')
        inst.add_port('SSELb','adc4x16g_sselb',width=4)
        if self.include_spi_ports:
            # Add the SPI ports, which get connected through tristate buffers
            self._connect_to_tristate_buf(top, inst, 'spi_rtl_io0')
            self._connect_to_tristate_buf(top, inst, 'spi_rtl_io1')
            self._connect_to_tristate_buf(top, inst, 'spi_rtl_io2')
            self._connect_to_tristate_buf(top, inst, 'spi_rtl_io3')
            #self._connect_to_tristate_buf(top, inst, 'spi_rtl_sck')
            self._connect_to_tristate_buf(top, inst, 'spi_rtl_ss')

        #top.assign_signal('wb_clk_i', 'sys_clk')
        top.assign_signal('wb_clk_i', 'mb_clk')
        top.assign_signal('wb_rst_i', 'sys_rst')

        top.add_signal('mb_intr_v', width=4)
        top.assign_signal('mb_intr', '|mb_intr_v')
        
    
    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('UART_rxd', 'usb_tx'))
        cons.append(PortConstraint('UART_txd', 'usb_rx')) 
        if self.include_spi_ports:
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
        tcl_cmds['post_bitgen'] += ['exec -ignorestderr updatemem -bit ./myproj.runs/impl_1/top.bit -meminfo ./myproj.runs/impl_1/top.mmi -data ../executable_core_info.mem  -proc %s/microblaze_0 -out ./myproj.runs/impl_1/top.bit -force' % self.bd_inst_name]
        return tcl_cmds
