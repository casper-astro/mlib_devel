from .yellow_block import YellowBlock
from verilog import VerilogModule
from constraints import PortConstraint, ClockConstraint, RawConstraint
from .yellow_block_typecodes import *

from math import ceil, floor
from os import environ as env

class adc_4x16g_asnt(YellowBlock):
    adc_clk_exist = False
    def initialize(self):
        self.provides = ['adc_clk','adc_clk90', 'adc_clk180', 'adc_clk270']
        self.add_source('adc4x16g/ADC4X16G_Channel_Sel.v')
        self.add_source('adc4x16g/data_splitter.v')
        self.add_source('adc4x16g/wb_adc4x16g_controller.v')
        self.add_source('wb_bram')
        #add the adc4x16g IP 
        self.ips = [{'path':'%s/adc4x16g/ip_repo_0' % env['HDL_ROOT'],
                     'name':'adc4x16g_core',
                     'vendor':'xilinx.com',
                     'library':'user',
                     'version':'1.3',
                    }]
        self.typecode = TYPECODE_BRAM

    
    def modify_top(self,top):
        self._instantiate_channel_sel(top)
        self._add_external_ports(top)
        self._add_data_splitter(top)
        module = 'adc4x16g_core'
        inst = top.get_instance(entity=module,name='adc4x16g_adc4x16g_inst%d'%self.channel_sel)
        # channel selection
        inst.add_parameter('CHANNEL_SEL',self.channel_sel)
        # connect ports
        inst.add_port('refclk0_p','refclk%d_p'%self.channel_sel, dir='in', parent_port = True)
        inst.add_port('refclk0_n','refclk%d_n'%self.channel_sel, dir='in', parent_port = True)
        inst.add_port('gty0rxp_in','gty%drxp_in'%self.channel_sel, dir='in', parent_port = True,width=4)
        inst.add_port('gty0rxn_in','gty%drxn_in'%self.channel_sel, dir='in', parent_port = True,width=4)
        # clock signals
        inst.add_port('clk100','user_clk')
        inst.add_port('clk_freerun','mb_clk')
        # the following signals are connected to adc4x16g_config
        # config
        inst.add_port('XOR_ON','XOR_ON%d'%self.channel_sel,parent_sig=False)
        inst.add_port('bit_sel','bit_sel%d'%self.channel_sel,parent_sig=False)
        inst.add_port('rxcdrhold','rxcdrhold%d'%self.channel_sel,parent_sig=False)
        inst.add_port('rxslide','rxslide%d'%self.channel_sel,parent_sig=False)
        inst.add_port('pattern_match_enable','pattern_match_enable%d'%self.channel_sel,parent_sig=False)
        inst.add_port('fifo_reset','fifo_reset%d'%self.channel_sel,parent_sig=False)
        inst.add_port('fifo_read','fifo_read%d'%self.channel_sel,parent_sig=False)
        inst.add_port('gtwiz_reset_all_in','gtwiz_reset_all_in%d'%self.channel_sel,parent_sig=False)
        """
        # gty transceiver reset is very sensitive
        if(self.channel_sel == 0):
            inst.add_port('gtwiz_reset_all_in','adc4x16g_config[16:16]',parent_sig=False)
        elif(self.channel_sel == 1):
            inst.add_port('gtwiz_reset_all_in','adc4x16g_config[28:28]',parent_sig=False)
        elif(self.channel_sel == 2):
            inst.add_port('gtwiz_reset_all_in','adc4x16g_config[29:29]',parent_sig=False)
        elif(self.channel_sel == 3):
            inst.add_port('gtwiz_reset_all_in','adc4x16g_config[30:30]',parent_sig=False)
        """
        # drp_config
        inst.add_port('prbs_error_count_reset','adc4x16g_drp_config[11:11]',parent_sig=False)
        inst.add_port('drp_addr','adc4x16g_drp_config[9:0]',parent_sig=False)
        inst.add_port('drp_reset','adc4x16g_drp_config[12:12]',parent_sig=False)
        inst.add_port('drp_read','adc4x16g_drp_config[10]',parent_sig=False)
        inst.add_port('write_interval','adc4x16g_drp_config[23:16]',parent_sig=False)
        # drp data
        inst.add_port('drp_data','adc4x16g_drp_data%d'%self.channel_sel,parent_sig=False)
        inst.add_port('rxprbslocked','adc4x16g_rxprbslocked%d'%self.channel_sel,parent_sig=False)
        # match_pattern
        inst.add_port('match_pattern','adc4x16g_match_pattern',parent_sig=False)
        # dout fifo
        inst.add_port('data_out','adc4x16g_data_out%d'%self.channel_sel,width=256)
        inst.add_port('fifo_empty','adc4x16g_empty%d'%self.channel_sel)
        inst.add_port('fifo_full','adc4x16g_full%d'%self.channel_sel)
        # test points, no need currently
        inst.add_port('rxprbserr_out','')
        if(adc_4x16g_asnt.adc_clk_exist == False):
            inst.add_port('adc_clk','adc_clk')
            adc_4x16g_asnt.adc_clk_exist = True
        else:
            inst.add_port('adc_clk','')

        # add wb_controller for snap_addr and snap_we
        wbctrl = top.get_instance(entity='wb_adc4x16g_controller', name='wb_adc4x16g_controller%d'%self.channel_sel)
        wbctrl.add_port('user_clk','user_clk',parent_sig=False)
        wbctrl.add_port('rst','sys_rst',parent_sig=False)
        wbctrl.add_port('snap_addr','adc4x16g_snap_addr%d'%self.channel_sel,width=6)
        wbctrl.add_port('snap_we','adc4x16g_snap_we%d'%self.channel_sel)
        # The memory space is only 4 bytes, and only 1 bit is used currently.
        # In case, we will have more registers in the future, the nbytes is set to 2**8.
        wbctrl.add_wb_interface(nbytes=2**8, regname='adc4x16g_controller%d'%self.channel_sel, mode='rw', typecode=TYPECODE_SWREG)

        # add wb_bram for alignment
        wbram = top.get_instance(entity='wb_bram', name='adc4x16g_wb_ram%d'%self.channel_sel)
        wbram.add_parameter('LOG_USER_WIDTH','8')
        wbram.add_parameter('USER_ADDR_BITS','6')
        wbram.add_parameter('N_REGISTERS','2')
        wbram.add_port('user_clk','user_clk', parent_sig=False)
        wbram.add_port('user_addr','adc4x16g_snap_addr%d'%self.channel_sel, parent_sig=False)
        wbram.add_port('user_din','adc4x16g_data_out%d'%self.channel_sel, parent_sig=False)
        wbram.add_port('user_we','adc4x16g_snap_we%d'%self.channel_sel, parent_sig=False)
        wbram.add_port('user_dout','')
        wbram.add_wb_interface(regname='adc4x16g_wb_ram%d'%self.channel_sel, mode='rw', nbytes=4*2**10, typecode=TYPECODE_SWREG)
        
        # These clocks are just to match the requirement of toolflow
        top.add_signal('adc_clk270')
        top.assign_signal('adc_clk270', 'adc_clk') 
        top.add_signal('adc_clk90')
        top.assign_signal('adc_clk90', '~adc_clk270')
        top.add_signal('adc_clk180')
        top.assign_signal('adc_clk180', '~adc_clk')
        """
        for i in range(64):
            high_bit = (i+1) * 4 - 1
            low_bit  = i * 4
            top.assign_signal(self.fullname + '_data_a%d'%i,'adc4x16g_data_out%d['%self.channel_sel + str(high_bit)+ ':'+ str(low_bit) + ']')
        top.assign_signal(self.fullname + '_sync', '~adc4x16g_empty%d'%self.channel_sel)
        """

        #for (devname, base_addr) in self.platform.mmbus_xil_base_address.items():
        #    dev = top.add_xil_axi4lite_interface(devname, mode='rw', nbytes=0xFFFF, typecode=self.typecode)
        #    try:
        #        dev.base_addr = base_addr
        #    except:
        #        pass
        
    def _instantiate_channel_sel(self,top):
        module = 'ADC4X16G_Channel_Sel'
        inst = top.get_instance(entity=module, name='adc4x16g_channel_sel')
        inst.add_port('clk','user_clk',parent_sig=False)
        inst.add_port('rst','sys_rst',parent_sig=False)
        inst.add_port('channel_sel','adc4x16g_config[21:20]',parent_sig=False)
        inst.add_port('drp_data0','adc4x16g_drp_data0',width=16)
        inst.add_port('drp_data1','adc4x16g_drp_data1',width=16)
        inst.add_port('drp_data2','adc4x16g_drp_data2',width=16)
        inst.add_port('drp_data3','adc4x16g_drp_data3',width=16)
        inst.add_port('drp_data','adc4x16g_drp_data[15:0]',parent_sig=False)
        inst.add_port('rxprbslocked0','adc4x16g_rxprbslocked0')
        inst.add_port('rxprbslocked1','adc4x16g_rxprbslocked1')
        inst.add_port('rxprbslocked2','adc4x16g_rxprbslocked2')
        inst.add_port('rxprbslocked3','adc4x16g_rxprbslocked3')
        inst.add_port('rxprbslocked','adc4x16g_drp_data[16:16]',parent_sig=False)
        inst.add_port('rxslide','adc4x16g_config[23:23]',parent_sig=False)
        inst.add_port('rxslide0','rxslide0')
        inst.add_port('rxslide1','rxslide1')
        inst.add_port('rxslide2','rxslide2')
        inst.add_port('rxslide3','rxslide3')
        inst.add_port('XOR_ON','adc4x16g_config[24:24]',parent_sig=False)
        inst.add_port('bit_sel','adc4x16g_config[19:18]',parent_sig=False)
        inst.add_port('gtwiz_reset_all_in','adc4x16g_config[16:16]',parent_sig=False)
        inst.add_port('rxcdrhold','adc4x16g_config[22:22]',parent_sig=False)
        inst.add_port('pattern_match_enable','adc4x16g_config[27:27]',parent_sig=False)
        inst.add_port('fifo_reset','adc4x16g_config[17:17]',parent_sig=False)
        inst.add_port('fifo_read','adc4x16g_config[25:25]',parent_sig=False)
        inst.add_port('XOR_ON0','XOR_ON0')
        inst.add_port('XOR_ON1','XOR_ON1')
        inst.add_port('XOR_ON2','XOR_ON2')
        inst.add_port('XOR_ON3','XOR_ON3')
        inst.add_port('bit_sel0','bit_sel0',width=2)
        inst.add_port('bit_sel1','bit_sel1',width=2)
        inst.add_port('bit_sel2','bit_sel2',width=2)
        inst.add_port('bit_sel3','bit_sel3',width=2)
        inst.add_port('gtwiz_reset_all_in0','gtwiz_reset_all_in0')
        inst.add_port('gtwiz_reset_all_in1','gtwiz_reset_all_in1')
        inst.add_port('gtwiz_reset_all_in2','gtwiz_reset_all_in2')
        inst.add_port('gtwiz_reset_all_in3','gtwiz_reset_all_in3')
        inst.add_port('rxcdrhold0','rxcdrhold0')
        inst.add_port('rxcdrhold1','rxcdrhold1')
        inst.add_port('rxcdrhold2','rxcdrhold2')
        inst.add_port('rxcdrhold3','rxcdrhold3')
        inst.add_port('pattern_match_enable0','pattern_match_enable0')
        inst.add_port('pattern_match_enable1','pattern_match_enable1')
        inst.add_port('pattern_match_enable2','pattern_match_enable2')
        inst.add_port('pattern_match_enable3','pattern_match_enable3')
        inst.add_port('fifo_reset0','fifo_reset0')
        inst.add_port('fifo_reset1','fifo_reset1')
        inst.add_port('fifo_reset2','fifo_reset2')
        inst.add_port('fifo_reset3','fifo_reset3')
        inst.add_port('fifo_read0','fifo_read0')
        inst.add_port('fifo_read1','fifo_read1')
        inst.add_port('fifo_read2','fifo_read2')
        inst.add_port('fifo_read3','fifo_read3')

    def _add_external_ports(self,top):
        # on-board clock configuration
        top.add_port('adc4x16g_mosi',dir='out',width=1)
        top.add_port('adc4x16g_miso',dir='in',width=1)
        top.add_port('adc4x16g_sck',dir='out',width=1)
        top.add_port('adc4x16g_sselb',dir='out',width=4)
        top.add_port('adc4x16g_asnt_ctrl_%d'%self.channel_sel,dir='out',width=4)
        low_bit = str(self.channel_sel*4)
        high_bit = str((self.channel_sel+1)*4 - 1)
        top.assign_signal('adc4x16g_asnt_ctrl_%d'%self.channel_sel,'adc4x16g_config[' + high_bit + ':' + low_bit + ']')
    
    def _add_data_splitter(self,top):
        module = 'data_splitter'
        inst = top.get_instance(entity=module, name='data_splitter_inst%d'%self.channel_sel)
        inst.add_port('data_in', 'adc4x16g_data_out%d'%self.channel_sel,width=256, parent_sig=False)
        for i in range(64):
            inst.add_port('data_out' + str(i), self.fullname + '_data_a%d'%i, width=4)
        inst.add_port('sync_in','~adc4x16g_empty%d'%self.channel_sel,parent_sig=False)
        inst.add_port('sync_out',self.fullname + '_sync')

    def gen_constraints(self):
        cons = []
        # In the yaml file, we have 6 banks, which are bank124, 125, 126, 127, 128, 129
        # The adc board uses bank126, 125, 127, 128 
        bank_sel = [2,1,3,4]
        num = self.channel_sel
        index = bank_sel[num]
        cons.append(PortConstraint('refclk%d_p'%num, 'fmcp_gty_clk_p',iogroup_index=index))
        cons.append(PortConstraint('adc4x16g_asnt_ctrl_%d'%num , 'adc4x16g_asnt_ctrl_%d'%num , port_index=list(range(4)), iogroup_index=list(range(4))))
        cons.append(PortConstraint('gty%drxp_in'%num , 'fmcp_gty_rx_p' , port_index=list(range(4)), iogroup_index=list(range(index*4,index*4+4))))
        cons.append(PortConstraint('adc4x16g_mosi', 'adc4x16g_mosi'))
        cons.append(PortConstraint('adc4x16g_miso', 'adc4x16g_miso'))
        cons.append(PortConstraint('adc4x16g_sck', 'adc4x16g_sck'))
        cons.append(PortConstraint('adc4x16g_sselb', 'adc4x16g_sselb',port_index=list(range(4)),iogroup_index=list(range(4))))
        cons.append(ClockConstraint('refclk%d_p'%num, name='adcclk%d'%num, freq=500))
        cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d -asynchronous -group [get_clocks -include_generated_clocks sys_clk_p_CLK] -group [get_clocks -include_generated_clocks adcclk%d]'%(num,num)))
        cons.append(RawConstraint('set_clock_groups -name asyncclocks_dcm -asynchronous -group [get_clocks -include_generated_clocks sys_clk0_dcm] -group [get_clocks -include_generated_clocks mb_clk_dcm]'))
        cons.append(RawConstraint('set_clock_groups -name async_dcm_two -asynchronous -group [get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]] -group [get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT4]]'))
        #[get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]
        #[get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT4]]

        return cons
        
    def gen_tcl_cmds(self):
        tcl_cmds = {}
        tcl_cmds['pre_synth'] = []
        tcl_cmds['pre_synth'] += ['source {}'.format(self.hdl_root + '/adc4x16g/adc4x16g_core.tcl')]
        return tcl_cmds
    
    
