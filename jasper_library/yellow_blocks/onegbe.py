from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, FalsePathConstraint
from helpers import to_int_list
from yellow_block_typecodes import *

class onegbe(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.name in ['vcu118']:
            return onegbe_vcu118(blk, plat, hdl_root)
        elif plat.name in ['vcu128']:
            return onegbe_vcu128(blk, plat, hdl_root)
        else:
            return onegbe_snap(blk, plat, hdl_root)

    def _instantiate_udp(self, top):
        gbe_udp = top.get_instance(entity='gbe_udp', name=self.fullname)
        gbe_udp.add_parameter('LOCAL_ENABLE',   '%d' % int(self.local_en))
        gbe_udp.add_parameter('LOCAL_MAC',      '48\'d%d' % self.local_mac)
        gbe_udp.add_parameter('LOCAL_IP',       '32\'d%d' % self.local_ip)
        gbe_udp.add_parameter('LOCAL_PORT',     '16\'d%d' % self.local_port)
        gbe_udp.add_parameter('LOCAL_GATEWAY',  '32\'d%d' % self.local_gateway)
        gbe_udp.add_parameter('CPU_PROMISCUOUS', '%d' % int(self.cpu_promiscuous))
        gbe_udp.add_parameter('DIS_CPU_TX',      '%d' % int(self.dis_cpu_tx))
        gbe_udp.add_parameter('DIS_CPU_RX',      '%d' % int(self.dis_cpu_rx))

        # simulink interface
        gbe_udp.add_port('app_clk', 'user_clk', parent_sig=False),

        gbe_udp.add_port('app_tx_data'     , self.fullname+'_app_tx_data'    , width=8)
        gbe_udp.add_port('app_tx_dvld'     , self.fullname+'_app_tx_dvld'    )
        gbe_udp.add_port('app_tx_eof'      , self.fullname+'_app_tx_eof'     )
        gbe_udp.add_port('app_tx_destip'   , self.fullname+'_app_tx_destip'  , width=32)
        gbe_udp.add_port('app_tx_destport' , self.fullname+'_app_tx_destport', width=16)
        gbe_udp.add_port('app_tx_afull'    , self.fullname+'_app_tx_afull'   )
        gbe_udp.add_port('app_tx_overflow' , self.fullname+'_app_tx_overflow')
        gbe_udp.add_port('app_tx_rst'      , self.fullname+'_app_tx_rst'     )
        gbe_udp.add_port('app_rx_data'     , self.fullname+'_app_rx_data'    , width=8)
        gbe_udp.add_port('app_rx_dvld'     , self.fullname+'_app_rx_dvld'    )
        gbe_udp.add_port('app_rx_eof'      , self.fullname+'_app_rx_eof'     )
        gbe_udp.add_port('app_rx_srcip'    , self.fullname+'_app_rx_srcip'   , width=32)
        gbe_udp.add_port('app_rx_srcport'  , self.fullname+'_app_rx_srcport' , width=16)
        gbe_udp.add_port('app_rx_badframe' , self.fullname+'_app_rx_badframe')
        gbe_udp.add_port('app_rx_overrun'  , self.fullname+'_app_rx_overrun' )
        gbe_udp.add_port('app_rx_ack'      , self.fullname+'_app_rx_ack'     )
        gbe_udp.add_port('app_rx_rst'      , self.fullname+'_app_rx_rst'     )
        # simulink debug interface
        gbe_udp.add_port('app_dbg_data'      , self.fullname+'_app_dbg_data' , width=32)
        gbe_udp.add_port('app_dbg_dvld'      , self.fullname+'_app_dbg_dvld' )

        # connections to MAC
        gbe_udp.add_port('mac_tx_clk',  'gbe_userclk2_out')
        gbe_udp.add_port('mac_tx_rst',  self.fullname + '_app_tx_rst')
        gbe_udp.add_port('mac_tx_data', self.fullname + '_mac_tx_data', width=8)
        gbe_udp.add_port('mac_tx_dvld', self.fullname + '_mac_tx_dvld')
        gbe_udp.add_port('mac_tx_ack',  self.fullname + '_mac_tx_ack')

        gbe_udp.add_port('mac_rx_clk',       'gbe_userclk2_out')
        gbe_udp.add_port('mac_rx_rst',       self.fullname + '_app_rx_rst')
        gbe_udp.add_port('mac_rx_data',      self.fullname + '_mac_rx_data', width=8)
        gbe_udp.add_port('mac_rx_dvld',      self.fullname + '_mac_rx_dvld')
        gbe_udp.add_port('mac_rx_goodframe', self.fullname + '_mac_rx_goodframe')
        gbe_udp.add_port('mac_rx_badframe',  self.fullname + '_mac_rx_badframe')
        gbe_udp.add_port('mac_syncacquired', self.fullname + '_mac_syncacquired')

        gbe_udp.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=65536, typecode=self.typecode)

    def _instantiate_mac(self, top):
        gbe_mac = top.get_instance(entity='gig_eth_mac', name=self.fullname+'_mac')
        gbe_mac.add_parameter('MAX_FRAME_SIZE_STANDARD', 1522)
        gbe_mac.add_parameter('MAX_FRAME_SIZE_JUMBO', 9022)
        
        #gbe_mac.add_port('reset', '~'+self.fullname+'_reset_done', parent_sig=False)
        gbe_mac.add_port('reset', 'sys_rst', parent_sig=False)
        
        gbe_mac.add_port('tx_clk', 'gbe_userclk2_out'),
        gbe_mac.add_port('rx_clk', 'gbe_userclk2_out'),
  
        gbe_mac.add_port('conf_tx_en', '1', parent_sig=False),
        gbe_mac.add_port('conf_rx_en', '1', parent_sig=False),
        gbe_mac.add_port('conf_tx_no_gen_crc', '0', parent_sig=False),
        gbe_mac.add_port('conf_rx_no_chk_crc', '0', parent_sig=False),
        gbe_mac.add_port('conf_tx_jumbo_en',   '0', parent_sig=False),
        gbe_mac.add_port('conf_rx_jumbo_en',   '0', parent_sig=False),

        #top.add_signal('data_lb', width=8)
        #top.add_signal('dvld_lb')
  
        gbe_mac.add_port('mac_tx_data', self.fullname+'_mac_tx_data', width=8)
        gbe_mac.add_port('mac_tx_dvld', self.fullname+'_mac_tx_dvld')
        gbe_mac.add_port('mac_tx_ack',  self.fullname+'_mac_tx_ack')
        #gbe_mac.add_port('mac_tx_data', 'data_lb', width=8)
        #gbe_mac.add_port('mac_tx_dvld', 'dvld_lb')
        #gbe_mac.add_port('mac_tx_ack',  '1\'b1')
        gbe_mac.add_port('mac_tx_underrun', '0', parent_sig=False),
  
        gbe_mac.add_port('mac_rx_data',      self.fullname+'_mac_rx_data', width=8)
        gbe_mac.add_port('mac_rx_dvld',      self.fullname+'_mac_rx_dvld')
        #gbe_mac.add_port('mac_rx_data',    'data_lb', width=8)
        #gbe_mac.add_port('mac_rx_dvld',    'dvld_lb')
        gbe_mac.add_port('mac_rx_goodframe', self.fullname+'_mac_rx_goodframe')
        gbe_mac.add_port('mac_rx_badframe',  self.fullname+'_mac_rx_badframe')
  
        gbe_mac.add_port('gmii_tx_data', self.fullname+'_mac_gmii_tx_data', width=8)
        gbe_mac.add_port('gmii_tx_en',   self.fullname+'_mac_gmii_tx_en')
        gbe_mac.add_port('gmii_tx_er',   self.fullname+'_mac_gmii_tx_er')
  
        gbe_mac.add_port('gmii_rx_data', self.fullname+'_mac_gmii_rx_data', width=8)
        gbe_mac.add_port('gmii_rx_dvld', self.fullname+'_mac_gmii_rx_dvld')
        gbe_mac.add_port('gmii_rx_er',   self.fullname+'_mac_gmii_rx_er')
  
        gbe_mac.add_port('gmii_col', '0', parent_sig=False)
        gbe_mac.add_port('gmii_crs', '0', parent_sig=False)

    def modify_top(self,top):
        self._instantiate_udp(top)
        self._instantiate_mac(top)
        self._instantiate_phy(top)

class onegbe_vcu128(onegbe):
        def initialize(self):
            self.typecode = TYPECODE_ETHCORE
            self.add_source('onegbe/*.v')
            #self.add_source('onegbe/*.xci')
            #self.add_source('onegbe/*.coe')
            self.add_source('onegbe/virtexuplus/*.v')
            self.add_source('onegbe/virtexuplus/*.xci')
            self.add_source('onegbe/virtexuplus/*.coe')
    
            self.provides = ['ethernet']
            if (not self.dis_cpu_tx) and (not self.dis_cpu_tx):
                self.provides += ['cpu_ethernet']
        
            self.refclk_freq = 125.0
            
        def modify_top(self,top):
            self._instantiate_udp(top)
            self._instantiate_mac(top)
            self._instantiate_phy(top)
            self._instantiate_mdio(top)
    
        def _instantiate_udp(self, top):
            gbe_udp = top.get_instance(entity='gbe_udp', name=self.fullname)
            gbe_udp.add_parameter('LOCAL_ENABLE',   '%d' % int(self.local_en))
            gbe_udp.add_parameter('LOCAL_MAC',      '48\'d%d' % self.local_mac)
            gbe_udp.add_parameter('LOCAL_IP',       '32\'d%d' % self.local_ip)
            gbe_udp.add_parameter('LOCAL_PORT',     '16\'d%d' % self.local_port)
            gbe_udp.add_parameter('LOCAL_GATEWAY',  '32\'d%d' % self.local_gateway)
            gbe_udp.add_parameter('CPU_PROMISCUOUS', '%d' % int(self.cpu_promiscuous))
            gbe_udp.add_parameter('DIS_CPU_TX',      '%d' % int(self.dis_cpu_tx))
            gbe_udp.add_parameter('DIS_CPU_RX',      '%d' % int(self.dis_cpu_rx))
    
            # simulink interface
            gbe_udp.add_port('app_clk', 'user_clk', parent_sig=False),
    
            gbe_udp.add_port('app_tx_data'     , self.fullname+'_app_tx_data'    , width=8)
            gbe_udp.add_port('app_tx_dvld'     , self.fullname+'_app_tx_dvld'    )
            gbe_udp.add_port('app_tx_eof'      , self.fullname+'_app_tx_eof'     )
            gbe_udp.add_port('app_tx_destip'   , self.fullname+'_app_tx_destip'  , width=32)
            gbe_udp.add_port('app_tx_destport' , self.fullname+'_app_tx_destport', width=16)
            gbe_udp.add_port('app_tx_afull'    , self.fullname+'_app_tx_afull'   )
            gbe_udp.add_port('app_tx_overflow' , self.fullname+'_app_tx_overflow')
            gbe_udp.add_port('app_tx_rst'      , self.fullname+'_app_tx_rst'     )
            gbe_udp.add_port('app_rx_data'     , self.fullname+'_app_rx_data'    , width=8)
            gbe_udp.add_port('app_rx_dvld'     , self.fullname+'_app_rx_dvld'    )
            gbe_udp.add_port('app_rx_eof'      , self.fullname+'_app_rx_eof'     )
            gbe_udp.add_port('app_rx_srcip'    , self.fullname+'_app_rx_srcip'   , width=32)
            gbe_udp.add_port('app_rx_srcport'  , self.fullname+'_app_rx_srcport' , width=16)
            gbe_udp.add_port('app_rx_badframe' , self.fullname+'_app_rx_badframe')
            gbe_udp.add_port('app_rx_overrun'  , self.fullname+'_app_rx_overrun' )
            gbe_udp.add_port('app_rx_ack'      , self.fullname+'_app_rx_ack'     )
            gbe_udp.add_port('app_rx_rst'      , self.fullname+'_app_rx_rst'     )
            # simulink debug interface
            gbe_udp.add_port('app_dbg_data'      , self.fullname+'_app_dbg_data' , width=32)
            gbe_udp.add_port('app_dbg_dvld'      , self.fullname+'_app_dbg_dvld' )
    
            # connections to MAC
            gbe_udp.add_port('mac_tx_clk',  'gbe_userclk2_out')
            gbe_udp.add_port('mac_tx_rst',  'rst_125_out')
            gbe_udp.add_port('mac_tx_data', self.fullname + '_mac_tx_data', width=8)
            gbe_udp.add_port('mac_tx_dvld', self.fullname + '_mac_tx_dvld')
            gbe_udp.add_port('mac_tx_ack',  self.fullname + '_mac_tx_ack')
    
            gbe_udp.add_port('mac_rx_clk',       'gbe_userclk2_out')
            gbe_udp.add_port('mac_rx_rst',       'rst_125_out')
            gbe_udp.add_port('mac_rx_data',      self.fullname + '_mac_rx_data', width=8)
            gbe_udp.add_port('mac_rx_dvld',      self.fullname + '_mac_rx_dvld')
            gbe_udp.add_port('mac_rx_goodframe', self.fullname + '_mac_rx_goodframe')
            gbe_udp.add_port('mac_rx_badframe',  self.fullname + '_mac_rx_badframe')
            gbe_udp.add_port('mac_syncacquired', self.fullname + '_mac_syncacquired')
    
            gbe_udp.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=65536, typecode=self.typecode)
    
        def _instantiate_mac(self, top):
            gbe_mac = top.get_instance(entity='gig_eth_mac', name=self.fullname+'_mac')
            gbe_mac.add_parameter('MAX_FRAME_SIZE_STANDARD', 1522)
            gbe_mac.add_parameter('MAX_FRAME_SIZE_JUMBO', 9022)
            
            gbe_mac.add_port('reset', 'rst_125_out', parent_sig=False)
            
            gbe_mac.add_port('tx_clk', 'gbe_userclk2_out'),
            gbe_mac.add_port('rx_clk', 'gbe_userclk2_out'),
      
            gbe_mac.add_port('conf_tx_en', '1', parent_sig=False),
            gbe_mac.add_port('conf_rx_en', '1', parent_sig=False),
            gbe_mac.add_port('conf_tx_no_gen_crc', '0', parent_sig=False),
            gbe_mac.add_port('conf_rx_no_chk_crc', '0', parent_sig=False),
            gbe_mac.add_port('conf_tx_jumbo_en',   '0', parent_sig=False),
            gbe_mac.add_port('conf_rx_jumbo_en',   '0', parent_sig=False),
      
            gbe_mac.add_port('mac_tx_data', self.fullname+'_mac_tx_data', width=8)
            gbe_mac.add_port('mac_tx_dvld', self.fullname+'_mac_tx_dvld')
            gbe_mac.add_port('mac_tx_ack',  self.fullname+'_mac_tx_ack')
            gbe_mac.add_port('mac_tx_underrun', '0', parent_sig=False),
      
            gbe_mac.add_port('mac_rx_data',      self.fullname+'_mac_rx_data', width=8)
            gbe_mac.add_port('mac_rx_dvld',      self.fullname+'_mac_rx_dvld')
            gbe_mac.add_port('mac_rx_goodframe', self.fullname+'_mac_rx_goodframe')
            gbe_mac.add_port('mac_rx_badframe',  self.fullname+'_mac_rx_badframe')
      
            gbe_mac.add_port('gmii_tx_data', self.fullname+'_mac_gmii_tx_data', width=8)
            gbe_mac.add_port('gmii_tx_en',   self.fullname+'_mac_gmii_tx_en')
            gbe_mac.add_port('gmii_tx_er',   self.fullname+'_mac_gmii_tx_er')
      
            gbe_mac.add_port('gmii_rx_data', self.fullname+'_mac_gmii_rx_data', width=8)
            gbe_mac.add_port('gmii_rx_dvld', self.fullname+'_mac_gmii_rx_dvld')
            gbe_mac.add_port('gmii_rx_er',   self.fullname+'_mac_gmii_rx_er')
      
            gbe_mac.add_port('gmii_col', '0', parent_sig=False)
            gbe_mac.add_port('gmii_crs', '0', parent_sig=False)
            
        def _instantiate_phy(self, top):
            
            gbe_pcs = top.get_instance(entity='gig_ethernet_pcs_pma_sgmii', name=self.fullname+'_pcs_pma')
           
            gbe_pcs.add_port('gtrefclk_p', self.fullname+'_mgt_clk_p', dir='in', parent_port=True)
            gbe_pcs.add_port('gtrefclk_n', self.fullname+'_mgt_clk_n', dir='in', parent_port=True)
            gbe_pcs.add_port('gtrefclk_out', 'gbe_mgt_clk')
            gbe_pcs.add_port('txn', self.fullname+'_tx_n', dir='out', parent_port=True)
            gbe_pcs.add_port('txp', self.fullname+'_tx_p', dir='out', parent_port=True)
            gbe_pcs.add_port('rxn', self.fullname+'_rx_n', dir='in', parent_port=True)
            gbe_pcs.add_port('rxp', self.fullname+'_rx_p', dir='in', parent_port=True)
            gbe_pcs.add_port('independent_clock_bufg', 'clk_200')
            gbe_pcs.add_port('userclk_out',   'gbe_userclk_out')    # first instance only (shared logic lives in first core)
            gbe_pcs.add_port('userclk2_out',  'gbe_userclk2_out')   # first instance only (shared logic lives in first core)
            gbe_pcs.add_port('rxuserclk_out', 'gbe_rxuserclk_out')  # first instance only (shared logic lives in first core)
            gbe_pcs.add_port('rxuserclk2_out','gbe_rxuserclk2_out') # first instance only (shared logic lives in first core)
            gbe_pcs.add_port('resetdone', self.fullname+'_reset_done')
            gbe_pcs.add_port('pma_reset_out', '')
            gbe_pcs.add_port('mmcm_locked_out', 'gbe_mmcm_locked_out')
            gbe_pcs.add_port('sgmii_clk_r', '')
            gbe_pcs.add_port('sgmii_clk_f', '')
            gbe_pcs.add_port('sgmii_clk_en', '')
            gbe_pcs.add_port('gmii_txd',   self.fullname+'_mac_gmii_tx_data', width=8)
            gbe_pcs.add_port('gmii_tx_en', self.fullname+'_mac_gmii_tx_en')
            gbe_pcs.add_port('gmii_tx_er', self.fullname+'_mac_gmii_tx_er')
            gbe_pcs.add_port('gmii_rxd',   self.fullname+'_mac_gmii_rx_data', width=8)
            gbe_pcs.add_port('gmii_rx_dv', self.fullname+'_mac_gmii_rx_dvld')
            gbe_pcs.add_port('gmii_rx_er', self.fullname+'_mac_gmii_rx_er')
            gbe_pcs.add_port('gmii_isolate', '')
            gbe_pcs.add_port('configuration_vector', '5\'b0', parent_sig=False)
            gbe_pcs.add_port('speed_is_10_100', '0', parent_sig=False)
            gbe_pcs.add_port('speed_is_100', '0', parent_sig=False)
            gbe_pcs.add_port('status_vector', '')
            gbe_pcs.add_port('reset', 'sys_rst')
            gbe_pcs.add_port('signal_detect', '1', parent_sig=False)
            gbe_pcs.add_port('an_adv_config_vector', '16\'b1000100000000001', parent_sig=False)
            gbe_pcs.add_port('an_restart_config', '1\'b0', parent_sig=False)
       
        def _instantiate_mdio(self, top):
            gbe_mdio = top.get_instance(entity='mdio_config', name=self.fullname+'_mdio_config_inst')
            gbe_mdio.add_port('sys_clk', 'sys_clk')
            gbe_mdio.add_port('sys_clk_rst_sync', 'sys_clk_rst_sync')
            gbe_mdio.add_port('mdc', 'phy_mdc', dir='out', parent_port=True)
            gbe_mdio.add_port('mdio', 'phy_mdio', dir='inout', parent_port=True)
            gbe_mdio.add_port('done', 'mdio_done')
   
        def gen_constraints(self):
            consts = []
            #consts += [PortConstraint(self.fullname+'_sfp_tx_n', 'mgt_tx_n')]
            #consts += [PortConstraint(self.fullname+'_sfp_rx_p', 'mgt_rx_p')]
            #consts += [PortConstraint(self.fullname+'_sfp_rx_n', 'mgt_rx_n')]
            #consts += [PortConstraint(self.fullname+'_mgt_clk_p', 'eth_clk_125_p')]
            #consts += [PortConstraint(self.fullname+'_mgt_clk_n', 'eth_clk_125_n')]
            #consts += [ClockConstraint(self.fullname+'_mgt_clk_p', name='onegbe_clk', freq=self.refclk_freq)]
                 
            consts += [PortConstraint(self.fullname+'_tx_p', 'gbe_phy_sgmii_in_p')]
            consts += [PortConstraint(self.fullname+'_tx_n', 'gbe_phy_sgmii_in_n')]
            consts += [PortConstraint(self.fullname+'_rx_p', 'gbe_phy_sgmii_out_p')]
            consts += [PortConstraint(self.fullname+'_rx_n', 'gbe_phy_sgmii_out_n')]
            consts += [PortConstraint('phy_rst_n', 'gbe_phy_rst_n')]
            consts += [PortConstraint('phy_pdown_n', 'gbe_phy_power_down_n')]
            consts += [PortConstraint('phy_mdio', 'gbe_phy_mdio')]
            consts += [PortConstraint('phy_mdc', 'gbe_phy_mdc')]
            # consts += [PortConstraint(self.fullname+'_refclk625_p', 'gbe_phy_sgmii_clk_p')]
            #consts += [PortConstraint(self.fullname+'_refclk625_n', 'gbe_phy_sgmii_clk_n')]
            # Clock is defined automatically by the PCS/PMA IP
            #consts += [ClockConstraint(self.fullname+'_refclk625_p', name='onegbe_clk', freq=self.refclk_freq)]
            consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]', '[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname)]
            consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname, '[get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]')]
            consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]', '[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname)]
            consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname, '[get_clocks -of_objects [get_pins vcu128_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]')]
   
            return consts


class onegbe_vcu118(onegbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.add_source('onegbe/*.v')
        #self.add_source('onegbe/*.xci')
        #self.add_source('onegbe/*.coe')
        self.add_source('onegbe/virtexuplus/*.v')
        self.add_source('onegbe/virtexuplus/*.xci')
        self.add_source('onegbe/virtexuplus/*.coe')

        self.provides = ['ethernet']
        if (not self.dis_cpu_tx) and (not self.dis_cpu_tx):
            self.provides += ['cpu_ethernet']

        self.refclk_freq = 625.0

    def modify_top(self,top):
        self._instantiate_udp(top)
        self._instantiate_mac(top)
        self._instantiate_phy(top)
        self._instantiate_mdio(top)

    def _instantiate_udp(self, top):
        gbe_udp = top.get_instance(entity='gbe_udp', name=self.fullname)
        gbe_udp.add_parameter('LOCAL_ENABLE',   '%d' % int(self.local_en))
        gbe_udp.add_parameter('LOCAL_MAC',      '48\'d%d' % self.local_mac)
        gbe_udp.add_parameter('LOCAL_IP',       '32\'d%d' % self.local_ip)
        gbe_udp.add_parameter('LOCAL_PORT',     '16\'d%d' % self.local_port)
        gbe_udp.add_parameter('LOCAL_GATEWAY',  '32\'d%d' % self.local_gateway)
        gbe_udp.add_parameter('CPU_PROMISCUOUS', '%d' % int(self.cpu_promiscuous))
        gbe_udp.add_parameter('DIS_CPU_TX',      '%d' % int(self.dis_cpu_tx))
        gbe_udp.add_parameter('DIS_CPU_RX',      '%d' % int(self.dis_cpu_rx))

        # simulink interface
        gbe_udp.add_port('app_clk', 'user_clk', parent_sig=False),

        gbe_udp.add_port('app_tx_data'     , self.fullname+'_app_tx_data'    , width=8)
        gbe_udp.add_port('app_tx_dvld'     , self.fullname+'_app_tx_dvld'    )
        gbe_udp.add_port('app_tx_eof'      , self.fullname+'_app_tx_eof'     )
        gbe_udp.add_port('app_tx_destip'   , self.fullname+'_app_tx_destip'  , width=32)
        gbe_udp.add_port('app_tx_destport' , self.fullname+'_app_tx_destport', width=16)
        gbe_udp.add_port('app_tx_afull'    , self.fullname+'_app_tx_afull'   )
        gbe_udp.add_port('app_tx_overflow' , self.fullname+'_app_tx_overflow')
        gbe_udp.add_port('app_tx_rst'      , self.fullname+'_app_tx_rst'     )
        gbe_udp.add_port('app_rx_data'     , self.fullname+'_app_rx_data'    , width=8)
        gbe_udp.add_port('app_rx_dvld'     , self.fullname+'_app_rx_dvld'    )
        gbe_udp.add_port('app_rx_eof'      , self.fullname+'_app_rx_eof'     )
        gbe_udp.add_port('app_rx_srcip'    , self.fullname+'_app_rx_srcip'   , width=32)
        gbe_udp.add_port('app_rx_srcport'  , self.fullname+'_app_rx_srcport' , width=16)
        gbe_udp.add_port('app_rx_badframe' , self.fullname+'_app_rx_badframe')
        gbe_udp.add_port('app_rx_overrun'  , self.fullname+'_app_rx_overrun' )
        gbe_udp.add_port('app_rx_ack'      , self.fullname+'_app_rx_ack'     )
        gbe_udp.add_port('app_rx_rst'      , self.fullname+'_app_rx_rst'     )
        # simulink debug interface
        gbe_udp.add_port('app_dbg_data'      , self.fullname+'_app_dbg_data' , width=32)
        gbe_udp.add_port('app_dbg_dvld'      , self.fullname+'_app_dbg_dvld' )

        # connections to MAC
        gbe_udp.add_port('mac_tx_clk',  'gbe_userclk2_out')
        gbe_udp.add_port('mac_tx_rst',  'rst_125_out')
        gbe_udp.add_port('mac_tx_data', self.fullname + '_mac_tx_data', width=8)
        gbe_udp.add_port('mac_tx_dvld', self.fullname + '_mac_tx_dvld')
        gbe_udp.add_port('mac_tx_ack',  self.fullname + '_mac_tx_ack')

        gbe_udp.add_port('mac_rx_clk',       'gbe_userclk2_out')
        gbe_udp.add_port('mac_rx_rst',       'rst_125_out')
        gbe_udp.add_port('mac_rx_data',      self.fullname + '_mac_rx_data', width=8)
        gbe_udp.add_port('mac_rx_dvld',      self.fullname + '_mac_rx_dvld')
        gbe_udp.add_port('mac_rx_goodframe', self.fullname + '_mac_rx_goodframe')
        gbe_udp.add_port('mac_rx_badframe',  self.fullname + '_mac_rx_badframe')
        gbe_udp.add_port('mac_syncacquired', self.fullname + '_mac_syncacquired')

        gbe_udp.add_wb_interface(regname=self.unique_name, mode='rw', nbytes=65536, typecode=self.typecode)

    def _instantiate_mac(self, top):
        gbe_mac = top.get_instance(entity='gig_eth_mac', name=self.fullname+'_mac')
        gbe_mac.add_parameter('MAX_FRAME_SIZE_STANDARD', 1522)
        gbe_mac.add_parameter('MAX_FRAME_SIZE_JUMBO', 9022)
        
        gbe_mac.add_port('reset', 'rst_125_out', parent_sig=False)
        
        gbe_mac.add_port('tx_clk', 'gbe_userclk2_out'),
        gbe_mac.add_port('rx_clk', 'gbe_userclk2_out'),
  
        gbe_mac.add_port('conf_tx_en', '1', parent_sig=False),
        gbe_mac.add_port('conf_rx_en', '1', parent_sig=False),
        gbe_mac.add_port('conf_tx_no_gen_crc', '0', parent_sig=False),
        gbe_mac.add_port('conf_rx_no_chk_crc', '0', parent_sig=False),
        gbe_mac.add_port('conf_tx_jumbo_en',   '0', parent_sig=False),
        gbe_mac.add_port('conf_rx_jumbo_en',   '0', parent_sig=False),
  
        gbe_mac.add_port('mac_tx_data', self.fullname+'_mac_tx_data', width=8)
        gbe_mac.add_port('mac_tx_dvld', self.fullname+'_mac_tx_dvld')
        gbe_mac.add_port('mac_tx_ack',  self.fullname+'_mac_tx_ack')
        gbe_mac.add_port('mac_tx_underrun', '0', parent_sig=False),
  
        gbe_mac.add_port('mac_rx_data',      self.fullname+'_mac_rx_data', width=8)
        gbe_mac.add_port('mac_rx_dvld',      self.fullname+'_mac_rx_dvld')
        gbe_mac.add_port('mac_rx_goodframe', self.fullname+'_mac_rx_goodframe')
        gbe_mac.add_port('mac_rx_badframe',  self.fullname+'_mac_rx_badframe')
  
        gbe_mac.add_port('gmii_tx_data', self.fullname+'_mac_gmii_tx_data', width=8)
        gbe_mac.add_port('gmii_tx_en',   self.fullname+'_mac_gmii_tx_en')
        gbe_mac.add_port('gmii_tx_er',   self.fullname+'_mac_gmii_tx_er')
  
        gbe_mac.add_port('gmii_rx_data', self.fullname+'_mac_gmii_rx_data', width=8)
        gbe_mac.add_port('gmii_rx_dvld', self.fullname+'_mac_gmii_rx_dvld')
        gbe_mac.add_port('gmii_rx_er',   self.fullname+'_mac_gmii_rx_er')
  
        gbe_mac.add_port('gmii_col', '0', parent_sig=False)
        gbe_mac.add_port('gmii_crs', '0', parent_sig=False)

    def _instantiate_phy(self, top):
        gbe_pcs = top.get_instance(entity='gig_ethernet_pcs_pma_sgmii_lvds', name=self.fullname+'_pcs_pma')
        
        gbe_pcs.add_port('refclk625_p', self.fullname+'_refclk625_p', dir='in', parent_port=True)
        gbe_pcs.add_port('refclk625_n', self.fullname+'_refclk625_n', dir='in', parent_port=True)
        gbe_pcs.add_port('clk125_out', 'gbe_userclk2_out')
        gbe_pcs.add_port('clk312_out', '')
        gbe_pcs.add_port('rst_125_out', 'rst_125_out')
        gbe_pcs.add_port('gmii_isolate_0', '')
        gbe_pcs.add_port('an_interrupt_0', '')
        gbe_pcs.add_port('status_vector_0', '')

        gbe_pcs.add_port('txn_0', self.fullname+'_tx_n', dir='out', parent_port=True)
        gbe_pcs.add_port('txp_0', self.fullname+'_tx_p', dir='out', parent_port=True)
        gbe_pcs.add_port('rxn_0', self.fullname+'_rx_n', dir='in',  parent_port=True)
        gbe_pcs.add_port('rxp_0', self.fullname+'_rx_p', dir='in',  parent_port=True)

        gbe_pcs.add_port('sgmii_clk_r_0', '')
        gbe_pcs.add_port('sgmii_clk_f_0', '')
        gbe_pcs.add_port('sgmii_clk_en_0', '')
        gbe_pcs.add_port('gmii_txd_0',   self.fullname+'_mac_gmii_tx_data', width=8)
        gbe_pcs.add_port('gmii_tx_en_0', self.fullname+'_mac_gmii_tx_en')
        gbe_pcs.add_port('gmii_tx_er_0', self.fullname+'_mac_gmii_tx_er')
        gbe_pcs.add_port('gmii_rxd_0',   self.fullname+'_mac_gmii_rx_data', width=8)
        gbe_pcs.add_port('gmii_rx_dv_0', self.fullname+'_mac_gmii_rx_dvld')
        gbe_pcs.add_port('gmii_rx_er_0', self.fullname+'_mac_gmii_rx_er')
        gbe_pcs.add_port('configuration_vector_0', '5\'b10000', parent_sig=False)
        gbe_pcs.add_port('speed_is_10_100_0', '1\'b0', parent_sig=False)
        gbe_pcs.add_port('speed_is_100_0', '1\'b0', parent_sig=False)
        gbe_pcs.add_port('reset', 'sys_rst | ~mdio_done', parent_sig=False) # don't make a signal called "sys_rst | ~mdio_done"!
        gbe_pcs.add_port('signal_detect_0', '1\'b1', parent_sig=False)

        gbe_pcs.add_port('an_adv_config_vector_0', '16\'b1101100000000001', parent_sig=False)
        gbe_pcs.add_port('an_restart_config_0', '1\'b0', parent_sig=False)
        gbe_pcs.add_port('riu_rddata_1', '16\'b0')
        gbe_pcs.add_port('riu_valid_1', '1\'b0')
        gbe_pcs.add_port('riu_prsnt_1', '1\'b0')
        gbe_pcs.add_port('riu_rddata_2', '16\'b0')
        gbe_pcs.add_port('riu_valid_2', '1\'b0')
        gbe_pcs.add_port('riu_prsnt_2', '1\'b0')
        gbe_pcs.add_port('riu_rddata_3', '16\'b0')
        gbe_pcs.add_port('riu_valid_3', '1\'b0')
        gbe_pcs.add_port('riu_prsnt_3', '1\'b0')

        gbe_pcs.add_port('tx_dly_rdy_1', '1\'b1')
        gbe_pcs.add_port('tx_dly_rdy_2', '1\'b1')
        gbe_pcs.add_port('tx_dly_rdy_3', '1\'b1')
        gbe_pcs.add_port('rx_dly_rdy_1', '1\'b1')
        gbe_pcs.add_port('rx_dly_rdy_2', '1\'b1')
        gbe_pcs.add_port('rx_dly_rdy_3', '1\'b1')
        gbe_pcs.add_port('tx_vtc_rdy_1', '1\'b1')
        gbe_pcs.add_port('tx_vtc_rdy_2', '1\'b1')
        gbe_pcs.add_port('tx_vtc_rdy_3', '1\'b1')
        gbe_pcs.add_port('rx_vtc_rdy_1', '1\'b1')
        gbe_pcs.add_port('rx_vtc_rdy_2', '1\'b1')
        gbe_pcs.add_port('rx_vtc_rdy_3', '1\'b1')

        top.add_port('phy_rst_n', dir='out', width=0)
        top.assign_signal('phy_rst_n', '~sys_rst')
        top.add_port('phy_pdown_n', dir='out', width=0)
        top.assign_signal('phy_pdown_n', '1\'b1')

    def _instantiate_mdio(self, top):
        gbe_mdio = top.get_instance(entity='mdio_config', name=self.fullname+'_mdio_config_inst')
        gbe_mdio.add_port('sys_clk', 'sys_clk')
        gbe_mdio.add_port('sys_clk_rst_sync', 'sys_clk_rst_sync')
        gbe_mdio.add_port('mdc', 'phy_mdc', dir='out', parent_port=True)
        gbe_mdio.add_port('mdio', 'phy_mdio', dir='inout', parent_port=True)
        gbe_mdio.add_port('done', 'mdio_done')

    def gen_constraints(self):
        consts = []
        consts += [PortConstraint(self.fullname+'_tx_p', 'gbe_phy_sgmii_in_p')]
        consts += [PortConstraint(self.fullname+'_tx_n', 'gbe_phy_sgmii_in_n')]
        consts += [PortConstraint(self.fullname+'_rx_p', 'gbe_phy_sgmii_out_p')]
        consts += [PortConstraint(self.fullname+'_rx_n', 'gbe_phy_sgmii_out_n')]
        consts += [PortConstraint('phy_rst_n', 'gbe_phy_rst_n')]
        consts += [PortConstraint('phy_pdown_n', 'gbe_phy_power_down_n')]
        consts += [PortConstraint('phy_mdio', 'gbe_phy_mdio')]
        consts += [PortConstraint('phy_mdc', 'gbe_phy_mdc')]
        consts += [PortConstraint(self.fullname+'_refclk625_p', 'gbe_phy_sgmii_clk_p')]
        consts += [PortConstraint(self.fullname+'_refclk625_n', 'gbe_phy_sgmii_clk_n')]
        # Clock is defined automatically by the PCS/PMA IP
        #consts += [ClockConstraint(self.fullname+'_refclk625_p', name='onegbe_clk', freq=self.refclk_freq)]
        consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins vcu118_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]', '[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname)]
        consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname, '[get_clocks -of_objects [get_pins vcu118_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]')]
        consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins vcu118_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]', '[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname)]
        consts += [FalsePathConstraint('[get_clocks -of_objects [get_pins %s_pcs_pma/inst/clock_reset_i/Clk_Rst_I_Plle3_Tx/CLKOUT1]]'%self.fullname, '[get_clocks -of_objects [get_pins vcu118_infrastructure_inst/MMCM_BASE_inst/CLKOUT1]]')]

        return consts

class onegbe_snap(onegbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.add_source('onegbe/*.v')
        self.add_source('onegbe/*.xci')
        self.add_source('onegbe/*.coe')
        self.add_source('onegbe/virtex7/*.v')
        self.add_source('onegbe/virtex7/*.xci')
        self.add_source('onegbe/virtex7/*.coe')

        self.provides = ['ethernet']
        if (not self.dis_cpu_tx) and (not self.dis_cpu_tx):
            self.provides += ['cpu_ethernet']

        if self.platform.name in ['snap2']:
            self.use_lvds = True
        else:
            self.use_lvds = False

        if self.platform.name == 'snap2':
            self.refclk_freq = 625.0
        else:
            self.refclk_freq = 125.0


    def _instantiate_phy(self, top):
        ############ PCS / PMA (Xilinx Core) #############
        if self.use_lvds:
           gbe_pcs = top.get_instance(entity='gig_ethernet_pcs_pma_sgmii_lvds', name=self.fullname+'_pcs_pma')
           
           gbe_pcs.add_port('refclk625_p', self.fullname+'_mgt_clk_p', dir='in', parent_port=True)
           gbe_pcs.add_port('refclk625_n', self.fullname+'_mgt_clk_n', dir='in', parent_port=True)
           gbe_pcs.add_port('clk125_out', 'gbe_userclk2_out')
           gbe_pcs.add_port('clk625_out', '')
           gbe_pcs.add_port('clk312_out', '')
           gbe_pcs.add_port('idelay_rdy_out', '')
           gbe_pcs.add_port('rst_125_out', '')

           gbe_pcs.add_port('txn', self.fullname+'_sfp_tx_n', dir='out', parent_port=True)
           gbe_pcs.add_port('txp', self.fullname+'_sfp_tx_p', dir='out', parent_port=True)
           gbe_pcs.add_port('rxn', self.fullname+'_sfp_rx_n', dir='in', parent_port=True)
           gbe_pcs.add_port('rxp', self.fullname+'_sfp_rx_p', dir='in', parent_port=True)

           gbe_pcs.add_port('mmcm_locked_out', 'gbe_mmcm_locked_out')
           gbe_pcs.add_port('sgmii_clk_r', '')
           gbe_pcs.add_port('sgmii_clk_f', '')
           gbe_pcs.add_port('sgmii_clk_en', '')
           gbe_pcs.add_port('gmii_txd',   self.fullname+'_mac_gmii_tx_data', width=8)
           gbe_pcs.add_port('gmii_tx_en', self.fullname+'_mac_gmii_tx_en')
           gbe_pcs.add_port('gmii_tx_er', self.fullname+'_mac_gmii_tx_er')
           gbe_pcs.add_port('gmii_rxd',   self.fullname+'_mac_gmii_rx_data', width=8)
           gbe_pcs.add_port('gmii_rx_dv', self.fullname+'_mac_gmii_rx_dvld')
           gbe_pcs.add_port('gmii_rx_er', self.fullname+'_mac_gmii_rx_er')
           gbe_pcs.add_port('gmii_isolate', '')
           gbe_pcs.add_port('configuration_vector', '5\'b10000', parent_sig=False)
           gbe_pcs.add_port('speed_is_10_100', '0', parent_sig=False)
           gbe_pcs.add_port('speed_is_100', '0', parent_sig=False)
           gbe_pcs.add_port('status_vector', '')
           gbe_pcs.add_port('reset', 'sys_rst')
           gbe_pcs.add_port('signal_detect', '1', parent_sig=False)

           gbe_pcs.add_port('an_interrupt', '', parent_sig=False)
           gbe_pcs.add_port('an_adv_config_vector', '16\'b1000100000000001', parent_sig=False)
           gbe_pcs.add_port('an_restart_config', '1\'b0', parent_sig=False)

           top.add_port('phy_rst_n', dir='out', width=0)
           top.assign_signal('phy_rst_n', '~sys_rst')

        else:
           gbe_pcs = top.get_instance(entity='gig_ethernet_pcs_pma_sgmii', name=self.fullname+'_pcs_pma')
           
           gbe_pcs.add_port('gtrefclk_p', self.fullname+'_mgt_clk_p', dir='in', parent_port=True)
           gbe_pcs.add_port('gtrefclk_n', self.fullname+'_mgt_clk_n', dir='in', parent_port=True)
           gbe_pcs.add_port('gtrefclk_out', 'gbe_mgt_clk')
           gbe_pcs.add_port('txn', self.fullname+'_sfp_tx_n', dir='out', parent_port=True)
           gbe_pcs.add_port('txp', self.fullname+'_sfp_tx_p', dir='out', parent_port=True)
           gbe_pcs.add_port('rxn', self.fullname+'_sfp_rx_n', dir='in', parent_port=True)
           gbe_pcs.add_port('rxp', self.fullname+'_sfp_rx_p', dir='in', parent_port=True)
           gbe_pcs.add_port('independent_clock_bufg', 'clk_200')
           gbe_pcs.add_port('userclk_out',   'gbe_userclk_out')    # first instance only (shared logic lives in first core)
           gbe_pcs.add_port('userclk2_out',  'gbe_userclk2_out')   # first instance only (shared logic lives in first core)
           gbe_pcs.add_port('rxuserclk_out', 'gbe_rxuserclk_out')  # first instance only (shared logic lives in first core)
           gbe_pcs.add_port('rxuserclk2_out','gbe_rxuserclk2_out') # first instance only (shared logic lives in first core)
           gbe_pcs.add_port('resetdone', self.fullname+'_reset_done')
           gbe_pcs.add_port('pma_reset_out', '')
           gbe_pcs.add_port('mmcm_locked_out', 'gbe_mmcm_locked_out')
           gbe_pcs.add_port('sgmii_clk_r', '')
           gbe_pcs.add_port('sgmii_clk_f', '')
           gbe_pcs.add_port('sgmii_clk_en', '')
           gbe_pcs.add_port('gmii_txd',   self.fullname+'_mac_gmii_tx_data', width=8)
           gbe_pcs.add_port('gmii_tx_en', self.fullname+'_mac_gmii_tx_en')
           gbe_pcs.add_port('gmii_tx_er', self.fullname+'_mac_gmii_tx_er')
           gbe_pcs.add_port('gmii_rxd',   self.fullname+'_mac_gmii_rx_data', width=8)
           gbe_pcs.add_port('gmii_rx_dv', self.fullname+'_mac_gmii_rx_dvld')
           gbe_pcs.add_port('gmii_rx_er', self.fullname+'_mac_gmii_rx_er')
           gbe_pcs.add_port('gmii_isolate', '')
           gbe_pcs.add_port('configuration_vector', '5\'b0', parent_sig=False)
           gbe_pcs.add_port('speed_is_10_100', '0', parent_sig=False)
           gbe_pcs.add_port('speed_is_100', '0', parent_sig=False)
           gbe_pcs.add_port('status_vector', '')
           gbe_pcs.add_port('reset', 'sys_rst')
           gbe_pcs.add_port('signal_detect', '1', parent_sig=False)
           gbe_pcs.add_port('gt0_qplloutclk_out', 'gbe_gt0_qplloutclk_out')
           gbe_pcs.add_port('gt0_qplloutrefclk_out', 'gbe_gt0_qplloutrefclk_out')

           # hard code SFP disable to 0
           top.add_port(self.fullname+'_sfp_disable', dir='out', width=0)
           top.assign_signal(self.fullname+'_sfp_disable', '1\'b0')


    def gen_constraints(self):
        consts = []
        consts += [PortConstraint(self.fullname+'_sfp_tx_p', 'mgt_tx_p')]
        consts += [PortConstraint(self.fullname+'_sfp_tx_n', 'mgt_tx_n')]
        consts += [PortConstraint(self.fullname+'_sfp_rx_p', 'mgt_rx_p')]
        consts += [PortConstraint(self.fullname+'_sfp_rx_n', 'mgt_rx_n')]
        consts += [PortConstraint(self.fullname+'_mgt_clk_p', 'eth_clk_125_p')]
        consts += [PortConstraint(self.fullname+'_mgt_clk_n', 'eth_clk_125_n')]
        consts += [ClockConstraint(self.fullname+'_mgt_clk_p', name='onegbe_clk', freq=self.refclk_freq)]
        if not self.use_lvds:
            consts += [PortConstraint(self.fullname+'_sfp_disable', 'sfp_disable')]
        else:
            consts += [PortConstraint('phy_rst_n', 'phy_rst_n')]
        return consts
