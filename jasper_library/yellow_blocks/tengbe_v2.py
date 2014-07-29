from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint

class tengbe_v2(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.fpga.startswith('xc7k'):
            return tengbe_v2_xilinx_k7(blk, plat, hdl_root)
        else:
            return tengbe_v2_xilinx_v6(blk, plat, hdl_root)

    def instantiate_ktge(self, top):
        ktge = top.get_instance(name=self.fullname, entity='kat_ten_gb_eth', comment=self.fullname)
        ktge.add_parameter('FABRIC_MAC', "48'h%x"%self.fab_mac)
        ktge.add_parameter('FABRIC_IP', "32'h%x"%self.fab_ip)
        ktge.add_parameter('FABRIC_PORT', self.fab_udp)
        ktge.add_parameter('FABRIC_GATEWAY', "8'h%x"%self.fab_gate)
        ktge.add_parameter('FABRIC_ENABLE', int(self.fab_en))
        ktge.add_parameter('LARGE_PACKETS', int(self.large_frames))
        ktge.add_parameter('RX_DIST_RAM', int(self.rx_dist_ram))
        ktge.add_parameter('CPU_RX_ENABLE', int(self.cpu_rx_en))
        ktge.add_parameter('CPU_TX_ENABLE', int(self.cpu_tx_en))
        ktge.add_parameter('TTL', self.ttl)

        # PHY CONF interface
        ktge.add_port('mgt_txpostemphasis', 'mgt_txpostemphasis%d'%(self.port), width=5)
        ktge.add_port('mgt_txpreemphasis', 'mgt_txpreemphasis%d'%(self.port), width=4)
        ktge.add_port('mgt_txdiffctrl', 'mgt_txdiffctrl%d'%(self.port), width=4)
        ktge.add_port('mgt_rxeqmix', 'mgt_rxeqmix%d'%(self.port), width=3)

        # XGMII interface
        ktge.add_port('xaui_clk', 'xaui_clk')
        ktge.add_port('xaui_reset', 'sys_reset', parent_sig=False)
        ktge.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        ktge.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        ktge.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        ktge.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)

        # XAUI CONF interface
        ktge.add_port('xaui_status', 'xaui_status%d'%self.port, width=8)

        ktge.add_port('clk', 'user_clk')

        # Simulink ports
        ktge.add_port('rst', '%s_rst'%self.fullname)
        # tx
        ktge.add_port('tx_valid       ', '%s_tx_valid'%self.fullname)
        ktge.add_port('tx_afull       ', '%s_tx_afull'%self.fullname)
        ktge.add_port('tx_overflow    ', '%s_tx_overflow'%self.fullname)
        ktge.add_port('tx_end_of_frame', '%s_tx_end_of_frame'%self.fullname)
        ktge.add_port('tx_data        ', '%s_tx_data'%self.fullname, width=64)
        ktge.add_port('tx_dest_ip     ', '%s_tx_dest_ip'%self.fullname, width=32)
        ktge.add_port('tx_dest_port   ', '%s_tx_dest_port'%self.fullname, width=16)
        # rx
        ktge.add_port('rx_valid', '%s_rx_valid'%self.fullname)
        ktge.add_port('rx_end_of_frame', '%s_rx_end_of_frame'%self.fullname)
        ktge.add_port('rx_data',         '%s_rx_data'%self.fullname, width=64)
        ktge.add_port('rx_source_ip',    '%s_rx_source_ip'%self.fullname, width=32)
        ktge.add_port('rx_source_port',  '%s_rx_source_port'%self.fullname, width=16)
        ktge.add_port('rx_bad_frame',    '%s_rx_bad_frame'%self.fullname)
        ktge.add_port('rx_overrun',      '%s_rx_overrun'%self.fullname)
        ktge.add_port('rx_overrun_ack',  '%s_rx_overrun_ack'%self.fullname)
        ktge.add_port('rx_ack', '%s_rx_ack'%self.fullname)

        # Status LEDs
        ktge.add_port('led_up', '%s_led_up'%self.fullname)
        ktge.add_port('led_rx', '%s_led_rx'%self.fullname)
        ktge.add_port('led_tx', '%s_led_tx'%self.fullname)

        # Wishbone memory for status registers / ARP table
        ktge.add_wb_interface(self.unique_name, mode='rw', nbytes=0x4000) # as in matlab code

class tengbe_v2_xilinx_v6(tengbe_v2):
    def initialize(self):
        self.add_source('kat_ten_gb_eth')
        self.add_source('sfp_mdio_controller')
        self.add_source('xaui_infrastructure_v6')
        self.add_source('xaui_phy_v6')

        #roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
        if self.flavour == 'cx4':
            self.port = self.port_r2_cx4 + 4*((self.slot+1)%2) 
        elif self.flavour == 'sfp+':
            self.port = self.port_r2_sfpp + 4*((self.slot+1)%2)

        self.exc_requirements = ['tge%d'%self.port]

    def modify_top(self,top):
        
        self.instantiate_ktge(top)

        # XAUI infrastructure block
        # Use top.add_new_instance, as this will return an existing instance if one exists.
        xaui = top.get_instance('xaui_infrastructure', 'xaui_infrastructure_inst')
        xaui.add_parameter('ENABLE%d'%self.port, 1)
        xaui.add_parameter('TX_LANE_STEER%d'%self.port, int(self.flavour == 'sfp+'))
        xaui.add_parameter('RX_INVERT%d'%self.port, int(self.flavour == 'cx4'))
        xaui.add_port('xaui_refclk_n', 'xaui_refclk_n', parent_port=True, dir='in', width=3)
        xaui.add_port('xaui_refclk_p', 'xaui_refclk_p', parent_port=True, dir='in', width=3)
        xaui.add_port('xaui_clk', 'xaui_clk')
        xaui.add_port('mgt_rx_p', 'mgt_rx_p', parent_port=True, width=32, dir='in')
        xaui.add_port('mgt_rx_n', 'mgt_rx_n', parent_port=True, width=32, dir='in')
        xaui.add_port('mgt_tx_p', 'mgt_tx_p', parent_port=True, width=32, dir='out')
        xaui.add_port('mgt_tx_n', 'mgt_tx_n', parent_port=True, width=32, dir='out')

        # XAUI_SYS bus
        xaui.add_port('mgt_tx_rst%d        '%self.port, 'mgt_tx_rst%d        '%self.port, width=1)
        xaui.add_port('mgt_rx_rst%d        '%self.port, 'mgt_rx_rst%d        '%self.port, width=1)
        xaui.add_port('mgt_txdata%d        '%self.port, 'mgt_txdata%d        '%self.port, width=64)
        xaui.add_port('mgt_txcharisk%d     '%self.port, 'mgt_txcharisk%d     '%self.port, width=8)
        xaui.add_port('mgt_rxdata%d        '%self.port, 'mgt_rxdata%d        '%self.port, width=64)
        xaui.add_port('mgt_rxcharisk%d     '%self.port, 'mgt_rxcharisk%d     '%self.port, width=8)
        xaui.add_port('mgt_rxcodecomma%d   '%self.port, 'mgt_rxcodecomma%d   '%self.port, width=8)
        xaui.add_port('mgt_rxencommaalign%d'%self.port, 'mgt_rxencommaalign%d'%self.port, width=4)
        xaui.add_port('mgt_rxenchansync%d  '%self.port, 'mgt_rxenchansync%d  '%self.port, width=1)
        xaui.add_port('mgt_rxsyncok%d      '%self.port, 'mgt_rxsyncok%d      '%self.port, width=4)
        xaui.add_port('mgt_rxcodevalid%d   '%self.port, 'mgt_rxcodevalid%d   '%self.port, width=8)
        xaui.add_port('mgt_rxbufferr%d     '%self.port, 'mgt_rxbufferr%d     '%self.port, width=4)
        xaui.add_port('mgt_rxlock%d        '%self.port, 'mgt_rxlock%d        '%self.port, width=4)

        xaui.add_port('mgt_txpostemphasis%d'%(self.port), 'mgt_txpostemphasis%d'%(self.port), width=5)
        xaui.add_port('mgt_txpreemphasis%d '%(self.port), 'mgt_txpreemphasis%d '%(self.port), width=4)
        xaui.add_port('mgt_txdiffctrl%d    '%(self.port), 'mgt_txdiffctrl%d    '%(self.port), width=4)
        xaui.add_port('mgt_rxeqmix%d       '%(self.port), 'mgt_rxeqmix%d       '%(self.port), width=3)

        # MDIO controller for SFP mezzanine card
        if self.flavour == 'sfp+':
            mdio = top.get_instance('sfp_mdio_controller', 'mdio_controller_inst')
            mdio.add_wb_interface('sfp_mdio', mode='rw', nbytes=0x10000)
            mdio.add_wb_interface('sfp_mdio_gpio', mode='rw', nbytes=0x10000, suffix='_gpio')
            mdio.add_port('mgt_gpio', 'mgt_gpio', parent_port=True, width=12, dir='inout')

        #### XAUI PHY
        # XAUI SYS interface
        xp = top.get_instance('xaui_phy', 'xaui_phy_inst%d'%self.port)
        xp.add_port('reset', 'sys_reset', parent_sig=False)
        xp.add_port('xaui_clk', 'xaui_clk')
        xp.add_port('mgt_tx_reset    ', 'mgt_tx_rst%d        '%self.port, width=1)
        xp.add_port('mgt_rx_reset    ', 'mgt_rx_rst%d        '%self.port, width=1)
        xp.add_port('mgt_txdata      ', 'mgt_txdata%d        '%self.port, width=64)
        xp.add_port('mgt_txcharisk   ', 'mgt_txcharisk%d     '%self.port, width=8)
        xp.add_port('mgt_rxdata      ', 'mgt_rxdata%d        '%self.port, width=64)
        xp.add_port('mgt_rxcharisk   ', 'mgt_rxcharisk%d     '%self.port, width=8)
        xp.add_port('mgt_code_comma  ', 'mgt_rxcodecomma%d   '%self.port, width=8)
        xp.add_port('mgt_enable_align', 'mgt_rxencommaalign%d'%self.port, width=4)
        xp.add_port('mgt_en_chan_sync', 'mgt_rxenchansync%d  '%self.port, width=1)
        xp.add_port('mgt_syncok      ', 'mgt_rxsyncok%d      '%self.port, width=4)
        xp.add_port('mgt_code_valid  ', 'mgt_rxcodevalid%d   '%self.port, width=8)
        xp.add_port('mgt_rxbufferr   ', 'mgt_rxbufferr%d     '%self.port, width=4)
        xp.add_port('mgt_rxlock      ', 'mgt_rxlock%d        '%self.port, width=4)

        # XGMII interface
        xp.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        xp.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        xp.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        xp.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)

        # XAUI CONF interface
        xp.add_port('xaui_status', 'xaui_status%d'%self.port, width=8)




    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('xaui_refclk_p', 'xaui_refclk_p', port_index=range(3), iogroup_index=range(3)))
        cons.append(PortConstraint('xaui_refclk_n', 'xaui_refclk_n', port_index=range(3), iogroup_index=range(3)))

        cons.append(PortConstraint('mgt_gpio', 'mgt_gpio', port_index=range(12), iogroup_index=range(12)))

        index = range(4*self.port, 4*(self.port + 1))
        print index
        cons.append(PortConstraint('mgt_tx_p', 'mgt_tx_p', port_index=index, iogroup_index=index))
        cons.append(PortConstraint('mgt_tx_n', 'mgt_tx_n', port_index=index, iogroup_index=index))
        cons.append(PortConstraint('mgt_rx_p', 'mgt_rx_p', port_index=index, iogroup_index=index))
        cons.append(PortConstraint('mgt_rx_n', 'mgt_rx_n', port_index=index, iogroup_index=index))

        cons.append(ClockConstraint('xaui_clk', name='xaui_clk', freq=156.25))
        cons.append(ClockConstraint('xaui_infrastructure_inst/xaui_infrastructure_inst/xaui_infrastructure_low_inst/gtx_refclk_bufr<*>', name='xaui_infra_clk', freq=156.25))
        return cons

class tengbe_v2_xilinx_k7(tengbe_v2):
    def initialize(self):
        self.exc_requirements = ['tge%d'%self.slot]
        self.add_source('kat_ten_gb_eth')
        self.add_source('xaui_phy_k7')
        self.add_source('xaui_infrastructure_k7')

        # the use of multiple platform dependent parameters to
        # describe the port in the simulink block is a bit grim.
        # Why not have a callback change the allowed port number
        # options, rather than turn on and off parameter visibilities
        # for a bunch of parameters describing the same thing...

        #roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
        if self.flavour == 'cx4':
            self.port = self.port_r2_cx4 + 4*((self.slot+1)%2) 
        elif self.flavour == 'sfp':
            self.port = self.port_r2_sfpp + 4*((self.slot+1)%2)

        # Copied from the MATLAB xps code.

        #%values below taken from ug366 transceiver user guide (should match with tengbe_v2_loadfcn)

        post_emph_lookup = [0.18, 0.19, 0.18, 0.18, 0.18, 0.18, 0.18, 0.18, 0.19, 0.2, 0.39, 0.63, 0.82, 1.07, 1.32, 1.6, 1.65, 1.94, 2.21, 2.52, 2.76, 3.08, 3.41, 3.77, 3.97, 4.36, 4.73, 5.16, 5.47, 5.93, 6.38, 6.89] 
        try:
            index = post_emph_lookup.index(self.post_emph_r2)
        except:
            raise Exception('xps_tengbe_v2: %.3f not found in postemph_lookup'%self.post_emph_r2);
        self.post_emph_r2 = index-1

        pre_emph_lookup = [0.15, 0.3, 0.45, 0.61, 0.74, 0.91, 1.07, 1.25, 1.36, 1.55, 1.74, 1.94, 2.11, 2.32, 2.54, 2.77]
        try:
            index = pre_emph_lookup.index(self.pre_emph_r2)
        except:
            raise Exception('xps_tengbe_v2: %.3f not found in preemph_lookup'%self.pre_emph_r2);
        self.preemph_r2 = index-1;

        swing_lookup = [110, 210, 310, 400, 480, 570, 660, 740, 810, 880, 940, 990, 1040, 1080, 1110, 1130]
        try:
            index = swing_lookup.index(self.swing_r2)
        except:
            raise Exception('xps_tengbe_v2: %.3f not found in swing_lookup'%self.swing_r2);
        self.swing_r2 = index-1;

    def modify_top(self,top):
        self.instantiate_ktge(top)

        # XAUI infrastructure block
        # Use top.add_new_instance, as this will return an existing instance if one exists.
        xaui = top.get_instance('xaui_infrastructure', 'xaui_infrastructure_inst')
        xaui.add_port('mgt_ref_clk_n', 'mgt_ref_clk_n', extdir='in')
        xaui.add_port('mgt_ref_clk_p', 'mgt_ref_clk_p', extdir='in')
        xaui.add_port('reset', 'sys_reset', parent_sig=False)
        xaui.add_port('xaui_clk', 'xaui_clk')
        xaui.add_port('stat', 'stat', width=8)
        xaui.add_port('mgt_rx_p%d          '%self.port, 'mgt_rx_p%d          '%self.port, extdir='in')
        xaui.add_port('mgt_rx_n%d          '%self.port, 'mgt_rx_n%d          '%self.port, extdir='in')
        xaui.add_port('mgt_tx_p%d          '%self.port, 'mgt_tx_p%d          '%self.port, extdir='out')
        xaui.add_port('mgt_tx_n%d          '%self.port, 'mgt_tx_n%d          '%self.port, extdir='out')
        xaui.add_port('loss_of_signal_sfp%d'%self.port, 'loss_of_signal_sfp%d'%self.port)
        xaui.add_port('tx_fault_sfp%d      '%self.port, 'tx_fault_sfp%d      '%self.port)
        xaui.add_port('tx_disable_sfp%d    '%self.port, 'tx_disable_sfp%d    '%self.port)
        xaui.add_port('REF_CLK_IN%d        '%self.port, 'REF_CLK_IN%d        '%self.port)
        xaui.add_port('REF_CLK_IN_BUFH%d   '%self.port, 'REF_CLK_IN_BUFH%d   '%self.port)
        xaui.add_port('GT0_QPLLLOCK%d      '%self.port, 'GT0_QPLLLOCK%d      '%self.port)
        xaui.add_port('GT0_QPLLOUTCLK%d    '%self.port, 'GT0_QPLLOUTCLK%d    '%self.port)
        xaui.add_port('GT0_QPLLOUTREFCLK%d '%self.port, 'GT0_QPLLOUTREFCLK%d '%self.port)
        xaui.add_port('clk156_%d           '%self.port, 'clk156_%d           '%self.port)
        xaui.add_port('dclk%d              '%self.port, 'dclk%d              '%self.port)
        xaui.add_port('mmcm_locked%d       '%self.port, 'mmcm_locked%d       '%self.port)
        xaui.add_port('txp%d               '%self.port, 'txp%d               '%self.port)
        xaui.add_port('txn%d               '%self.port, 'txn%d               '%self.port)
        xaui.add_port('rxp%d               '%self.port, 'rxp%d               '%self.port)
        xaui.add_port('rxn%d               '%self.port, 'rxn%d               '%self.port)
        xaui.add_port('signal_detect%d     '%self.port, 'signal_detect%d     '%self.port)
        xaui.add_port('tx_fault%d          '%self.port, 'tx_fault%d          '%self.port)
        xaui.add_port('tx_disable%d        '%self.port, 'tx_disable%d        '%self.port)
        xaui.add_port('xaui_clk_out%d      '%self.port, 'xaui_clk_out%d      '%self.port)
        xaui.add_port('phy_stat%d          '%self.port, 'phy_stat%d          '%self.port, width=8)
        xaui.add_port('mgt_txpostemphasis%d'%(self.port+4), 'mgt_txpostemphasis%d'%(self.port+1), width=5)
        xaui.add_port('mgt_txpreemphasis%d '%(self.port+4), 'mgt_txpreemphasis%d '%(self.port+1), width=4)
        xaui.add_port('mgt_txdiffctrl%d    '%(self.port+4), 'mgt_txdiffctrl%d    '%(self.port+4), width=4)
        xaui.add_port('mgt_rxeqmix%d       '%(self.port+4), 'mgt_rxeqmix%d       '%(self.port+4), width=3)

        xaui_phy = top.get_instance('xaui_phy', 'xaui_phy%d'%self.port)
        xaui_phy.add_port('REF_CLK_IN         ', 'REF_CLK_IN%d        '%self.port)
        xaui_phy.add_port('REF_CLK_IN_BUFH    ', 'REF_CLK_IN_BUFH%d   '%self.port)
        xaui_phy.add_port('GT0_QPLLLOCK       ', 'GT0_QPLLLOCK%d      '%self.port)
        xaui_phy.add_port('GT0_QPLLOUTCLK     ', 'GT0_QPLLOUTCLK%d    '%self.port)
        xaui_phy.add_port('GT0_QPLLOUTREFCLK  ', 'GT0_QPLLOUTREFCLK%d '%self.port)
        xaui_phy.add_port('clk156             ', 'clk156_%d           '%self.port)
        xaui_phy.add_port('dclk               ', 'dclk%d              '%self.port)
        xaui_phy.add_port('mmcm_locked        ', 'mmcm_locked%d       '%self.port)
        xaui_phy.add_port('txp                ', 'txp%d               '%self.port)
        xaui_phy.add_port('txn                ', 'txn%d               '%self.port)
        xaui_phy.add_port('rxp                ', 'rxp%d               '%self.port)
        xaui_phy.add_port('rxn                ', 'rxn%d               '%self.port)
        xaui_phy.add_port('signal_detect      ', 'signal_detect%d     '%self.port)
        xaui_phy.add_port('tx_fault           ', 'tx_fault%d          '%self.port)
        xaui_phy.add_port('tx_disable         ', 'tx_disable%d        '%self.port)
        xaui_phy.add_port('xaui_clk_out       ', 'xaui_clk_out%d      '%self.port)
        xaui_phy.add_port('phy_stat           ', 'phy_stat%d          '%self.port, width=8)

        xaui_phy.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        xaui_phy.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        xaui_phy.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        xaui_phy.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)

        xaui_phy.add_port('xaui_status', 'xaui_status%d'%self.port, width=8)
        xaui_phy.add_port('reset', 'sys_reset', parent_sig=False)
        xaui_phy.add_port('xaui_clk', 'xaui_clk')

    def gen_constraints(self):
        cons = []
        cons.append(PortConstraint('mgt_ref_clk_p', 'eth_clk_p'))
        cons.append(PortConstraint('mgt_ref_clk_n', 'eth_clk_n'))
        cons.append(PortConstraint('mgt_tx_p%d'%self.port, 'mgt_tx_p%d'%self.port))
        cons.append(PortConstraint('mgt_tx_n%d'%self.port, 'mgt_tx_n%d'%self.port))
        cons.append(PortConstraint('mgt_rx_p%d'%self.port, 'mgt_rx_p%d'%self.port))
        cons.append(PortConstraint('mgt_rx_n%d'%self.port, 'mgt_rx_n%d'%self.port))

        cons.append(ClockConstraint('mgt_reg_clk_p', name='ethclk', freq=156.25))
        return cons
        
