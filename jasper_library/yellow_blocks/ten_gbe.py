from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, RawConstraint, ClockGroupConstraint
from itertools import count
from .yellow_block_typecodes import *

class ten_gbe(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.fpga.startswith('xc7k'):
            return tengbaser_xilinx_k7(blk, plat, hdl_root)
        elif plat.fpga.startswith('xc7v'):
            return tengbaser_xilinx_k7(blk, plat, hdl_root, use_gth=plat.name=='mx175')
        elif plat.conf.get('family', '').endswith('plus'):
            return tengbaser_xilinx_usplus(blk, plat, hdl_root)
        elif plat.fpga.startswith('xcvu'):
            return tengbaser_xilinx_k7(blk, plat, hdl_root, use_gth=plat.name=='vcu118')
        elif plat.fpga.startswith('xcku'):
            return tengbaser_xilinx_ku7(blk, plat, hdl_root)
        elif plat.fpga.startswith('xczu'):
            return tengbaser_xilinx_ultrascale(blk, plat, hdl_root)
        else:
            return tengbe_v2_xilinx_v6(blk, plat, hdl_root)

    def instantiate_ktge(self, top, num=None):
        ktge = top.get_instance(name=self.fullname, entity='kat_ten_gb_eth')
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
        if num is None:
            ktge.add_port('xaui_clk', 'xaui_clk')
        else:
            ktge.add_port('xaui_clk', 'core_clk_156_%d'%num)
        ktge.add_port('xaui_reset', 'sys_rst', parent_sig=False)
        ktge.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        ktge.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        ktge.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        ktge.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)

        # XAUI CONF interface
        ktge.add_port('xaui_status', 'xaui_status%d'%self.port, width=8)

        ktge.add_port('clk', 'user_clk', parent_sig=False)

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
        ktge.add_wb_interface(self.unique_name, mode='rw', nbytes=0xF000, typecode=self.typecode) # as in matlab code

class tengbe_v2_xilinx_v6(ten_gbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.add_source('kat_ten_gb_eth')
        self.add_source('sfp_mdio_controller')
        self.add_source('xaui_infrastructure_v6')
        self.add_source('xaui_phy_v6')
        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

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
        xp.add_port('reset', 'sys_rst', parent_sig=False)
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
        cons.append(PortConstraint('xaui_refclk_p', 'xaui_refclk_p', port_index=list(range(3)), iogroup_index=list(range(3))))
        cons.append(PortConstraint('xaui_refclk_n', 'xaui_refclk_n', port_index=list(range(3)), iogroup_index=list(range(3))))

        cons.append(PortConstraint('mgt_gpio', 'mgt_gpio', port_index=list(range(12)), iogroup_index=list(range(12))))

        index = list(range(4*self.port, 4*(self.port + 1)))
        print(index)
        cons.append(PortConstraint('mgt_tx_p', 'mgt_tx_p', port_index=index, iogroup_index=index))
        cons.append(PortConstraint('mgt_tx_n', 'mgt_tx_n', port_index=index, iogroup_index=index))
        cons.append(PortConstraint('mgt_rx_p', 'mgt_rx_p', port_index=index, iogroup_index=index))
        cons.append(PortConstraint('mgt_rx_n', 'mgt_rx_n', port_index=index, iogroup_index=index))

        cons.append(ClockConstraint('xaui_clk', name='xaui_clk', freq=156.25))
        cons.append(ClockConstraint('xaui_infrastructure_inst/xaui_infrastructure_inst/xaui_infrastructure_low_inst/gtx_refclk_bufr<*>', name='xaui_infra_clk', freq=156.25))
        return cons

class tengbaser_xilinx_k7(ten_gbe):
    def __init__(self, blk, plat, hdl_root, use_gth=False):
        self.use_gth = use_gth
        self.invert_sfp_disable = plat.conf.get('invert_sfp_disable', False)
        ten_gbe.__init__(self, blk, plat, hdl_root)
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.exc_requirements = ['tge%d'%self.slot]
        self.add_source('kat_ten_gb_eth/*')
        self.add_source('tengbaser_phy/tengbaser_phy.v')
        self.add_source('tengbaser_phy/ten_gig_pcs_pma_5.xci')
        #self.add_source('tengbaser_phy/ten_gig_pcs_pma_5.xdc')
        self.add_source('tengbaser_infrastructure')

        # the use of multiple platform dependent parameters to
        # describe the port in the simulink block is a bit grim.
        # Why not have a callback change the allowed port number
        # options, rather than turn on and off parameter visibilities
        # for a bunch of parameters describing the same thing...

        ##roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
        #if self.flavour == 'cx4':
        #    self.port = self.port_r2_cx4 + 4*((self.slot+1)%2) 
        #elif self.flavour == 'sfp':
        #    self.port = self.port_r2_sfpp + 4*((self.slot+1)%2)
        self.port = self.port_r1
        self.infrastructure_id = self.port // 4

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

    def gen_children(self):
        """
        The mx175 clocks the gth from a clock which is passed through the FPGA and through
        a jitter cleaner (si5324) back into the GTH clock port. The first ten gig core
        needs to make sure this pass through is instantiated.
        """
        if self.i_am_the_first and (self.name == 'mx175'):
            pt = YellowBlock.make_block({'tag':'xps:clock_passthrough', 'fullpath':'%s/clock_passthrough'%self.name, 'name':'clock_passthrough'}, self.platform)
            return [pt]
        else:
            return []

    def modify_top(self,top):
        # An infrastructure instance is good for 4 SFPs. Assuming the ports are numbered
        # so that instance0 serves ports 0-3, instance1 serves ports 4-7, etc. decide
        # whether to instantiate a new infrastrucure block
        if top.has_instance('tengbaser_infra%d_inst'%self.infrastructure_id):
            pass
        else:
            self.instantiate_infra(top, self.infrastructure_id)
            
        self.instantiate_phy(top, self.infrastructure_id)
        self.instantiate_ktge(top, self.infrastructure_id)

    def instantiate_infra(self, top, num):
        infra = top.get_instance('tengbaser_infrastructure', 'tengbaser_infra%d_inst'%num)
        if self.use_gth:
            infra.add_parameter('USE_GTH', '"TRUE"') #verilog module defaults to false
        infra.add_port('refclk_n', 'ref_clk_n%d'%num, parent_port=True, dir='in')
        infra.add_port('refclk_p', 'ref_clk_p%d'%num, parent_port=True, dir='in')
        infra.add_port('reset', 'sys_rst', parent_sig=False) #no parent sig -- the wire is declared in top.v

        infra.add_port('dclk', 'dclk%d'%num)
        infra.add_port('core_clk156_out', 'core_clk_156_%d'%num)
        infra.add_port('xgmii_rx_clk', 'xgmii_rx_clk%d'%num)

        infra.add_port('qplloutclk_out        ', 'qplloutclk_out%d        '%num)
        infra.add_port('qplloutrefclk_out     ', 'qplloutrefclk_out%d     '%num)
        infra.add_port('qplllock_out          ', 'qplllock_out%d          '%num)
        infra.add_port('areset_clk156_out     ', 'areset_clk156_out%d     '%num)
        infra.add_port('txusrclk_out          ', 'txusrclk_out%d          '%num)
        infra.add_port('txusrclk2_out         ', 'txusrclk2_out%d         '%num)
        infra.add_port('gttxreset_out         ', 'gttxreset_out%d         '%num)
        infra.add_port('gtrxreset_out         ', 'gtrxreset_out%d         '%num)
        infra.add_port('txuserrdy_out         ', 'txuserrdy_out%d         '%num)
        infra.add_port('reset_counter_done_out', 'reset_counter_done_out%d'%num)
        if self.i_am_the_first:
            infra.add_port('txclk322', 'txclk322_%d'%self.port)

    def instantiate_phy(self, top, num):

        phy = top.get_instance('tengbaser_phy', 'tengbaser_phy%d'%self.port)

        phy.add_port('areset', 'sys_rst')

        # sigs from infrastructure
        phy.add_port('dclk', 'dclk%d'%num)
        phy.add_port('clk156', 'core_clk_156_%d'%num)
        phy.add_port('qplloutclk', 'qplloutclk_out%d'%num)
        phy.add_port('qplloutrefclk', 'qplloutrefclk_out%d'%num)
        phy.add_port('qplllock', 'qplllock_out%d'%num)
        phy.add_port('areset_clk156', 'areset_clk156_out%d'%num)
        phy.add_port('txusrclk', 'txusrclk_out%d'%num)
        phy.add_port('txusrclk2', 'txusrclk2_out%d'%num)
        phy.add_port('gttxreset', 'gttxreset_out%d'%num)
        phy.add_port('gtrxreset', 'gtrxreset_out%d'%num)
        phy.add_port('txuserrdy', 'txuserrdy_out%d'%num)
        phy.add_port('reset_counter_done', 'reset_counter_done_out%d'%num)
        phy.add_port('txclk322', 'txclk322_%d'%self.port)

        # top level ports
        phy.add_port('txp', 'mgt_tx_p%d'%self.port, parent_port=True, dir='out')
        phy.add_port('txn', 'mgt_tx_n%d'%self.port, parent_port=True, dir='out')
        phy.add_port('rxp', 'mgt_rx_p%d'%self.port, parent_port=True, dir='in')
        phy.add_port('rxn', 'mgt_rx_n%d'%self.port, parent_port=True, dir='in')
        phy.add_port('signal_detect', 'signal_detect%d'%self.port)
        top.assign_signal('signal_detect%d'%self.port, "1'b1") #snap doesn't wire this to SFP(?)
        phy.add_port('tx_fault', 'tx_fault%d'%self.port)
        top.assign_signal('tx_fault%d'%self.port, "1'b0") #snap doesn't wire this to SFP(?)
        phy.add_port('tx_disable', 'tx_disable%d_int'%self.port)
        top.add_port('tx_disable%d'%self.port, '', dir='out', width=0)
        if self.invert_sfp_disable:
            top.assign_signal('tx_disable%d'%self.port, '~tx_disable%d_int'%self.port)
        else:
            top.assign_signal('tx_disable%d'%self.port, 'tx_disable%d_int'%self.port)

        phy.add_port('resetdone', 'resetdone%d'%self.port)
        phy.add_port('status_vector', '', parent_sig=False)
        # pma_pmd_type: 111=10g-base-SR, 110=-LR 101=-ER
        phy.add_port('pma_pmd_type', "3'b111", parent_sig=False)
        phy.add_port('configuration_vector', "536'b0", parent_sig=False)

        # XGMII signals to MAC
        phy.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        phy.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        phy.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        phy.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)
        phy.add_port('core_status', 'xaui_status%d'%self.port, width=8) #called xaui status for compatibility with kat-tge block

    def gen_constraints(self):
        num = self.infrastructure_id
        cons = []
        cons.append(PortConstraint('ref_clk_p%d'%num, 'eth_clk_p',iogroup_index=num))
        cons.append(PortConstraint('ref_clk_n%d'%num, 'eth_clk_n',iogroup_index=num))
        cons.append(PortConstraint('mgt_tx_p%d'%self.port, 'mgt_tx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_tx_n%d'%self.port, 'mgt_tx_n', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_p%d'%self.port, 'mgt_rx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_n%d'%self.port, 'mgt_rx_n', iogroup_index=self.port))

        cons.append(ClockConstraint('ref_clk_p%d'%num, name='ethclk%d'%num, freq=156.25))


        cons.append(RawConstraint('set_false_path -from [get_pins {tengbaser_infra%d_inst/ten_gig_eth_pcs_pma_core_support_layer_i/ten_gig_eth_pcs_pma_shared_clock_reset_block/reset_pulse_reg[0]/C}] -to [get_pins {tengbaser_infra%d_inst/ten_gig_eth_pcs_pma_core_support_layer_i/ten_gig_eth_pcs_pma_shared_clock_reset_block/gttxreset_txusrclk2_sync_i/sync1_r_reg*/PRE}]' % (num, num)))

        # make the ethernet core clock async relative to whatever the user is using as user_clk
        # Find the clock of *clk_counter* to determine what source user_clk comes from. This is fragile.
        
        if self.platform.name == 'snap':
           cons.append(PortConstraint('tx_disable%d'%self.port, 'sfp_disable', iogroup_index=self.port))
           cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d -asynchronous -group [get_clocks -include_generated_clocks sys_clk_p_CLK] -group [get_clocks -include_generated_clocks ethclk%d]'%(num,num)))
           cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d_usr_clk -asynchronous -group [get_clocks -of_objects [get_cells -hierarchical -filter {name=~*clk_counter*}]] -group [get_clocks -include_generated_clocks ethclk%d]' % (num, num)))
        else:
           cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d -asynchronous -group [get_clocks -include_generated_clocks sys_clk_in_CLK] -group [get_clocks -include_generated_clocks ethclk%d]'%(num,num)))
           cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d_usr_clk -asynchronous -group [get_clocks -of_objects [get_cells -hierarchical -filter {name=~*clk_counter*}]] -group [get_clocks -include_generated_clocks ethclk%d]' % (num, num)))        
        return cons

class tengbaser_xilinx_ku7(ten_gbe):
    def __init__(self, blk, plat, hdl_root, use_gth=False):
        self.use_gth = use_gth
        tengbe.__init__(self, blk, plat, hdl_root)
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.exc_requirements = ['tge%d'%self.slot]
        self.add_source('kat_ten_gb_eth/*')
        self.add_source('tengbaser_phy_v2/tengbaser_phy_v2.v')
        self.add_source('tengbaser_phy_v2/ten_gig_eth_pcs_pma_6.xci')
        #self.add_source('tengbaser_phy/ten_gig_pcs_pma_5.xdc')
        self.add_source('tengbaser_infrastructure_v2')

        # the use of multiple platform dependent parameters to
        # describe the port in the simulink block is a bit grim.
        # Why not have a callback change the allowed port number
        # options, rather than turn on and off parameter visibilities
        # for a bunch of parameters describing the same thing...

        ##roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
        #if self.flavour == 'cx4':
        #    self.port = self.port_r2_cx4 + 4*((self.slot+1)%2) 
        #elif self.flavour == 'sfp':
        #    self.port = self.port_r2_sfpp + 4*((self.slot+1)%2)
        self.port = self.port_r1
        self.infrastructure_id = self.port // 4

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

    def gen_children(self):
        """
        The mx175 clocks the gth from a clock which is passed through the FPGA and through
        a jitter cleaner (si5324) back into the GTH clock port. The first ten gig core
        needs to make sure this pass through is instantiated.
        """
        if self.i_am_the_first and (self.name == 'mx175'):
            pt = YellowBlock.make_block({'tag':'xps:clock_passthrough', 'fullpath':'%s/clock_passthrough'%self.name, 'name':'clock_passthrough'}, self.platform)
            return [pt]
        else:
            return []

    def modify_top(self,top):
        # An infrastructure instance is good for 4 SFPs. Assuming the ports are numbered
        # so that instance0 serves ports 0-3, instance1 serves ports 4-7, etc. decide
        # whether to instantiate a new infrastrucure block
        if top.has_instance('tengbaser_infra%d_inst'%self.infrastructure_id):
            pass
        else:
            self.instantiate_infra(top, self.infrastructure_id)
            
        self.instantiate_phy(top, self.infrastructure_id)
        self.instantiate_ktge(top, self.infrastructure_id)

    def instantiate_infra(self, top, num):
        infra = top.get_instance('tengbaser_infrastructure_v2', 'tengbaser_infra%d_inst'%num)
        if self.use_gth:
            infra.add_parameter('USE_GTH', '"TRUE"') #verilog module defaults to false
        infra.add_port('refclk_n', 'ref_clk_n%d'%num, parent_port=True, dir='in')
        infra.add_port('refclk_p', 'ref_clk_p%d'%num, parent_port=True, dir='in')
        infra.add_port('reset', 'sys_rst', parent_sig=False) #no parent sig -- the wire is declared in top.v

        #infra.add_port('dclk', 'dclk%d'%num)
        infra.add_port('core_clk', 'core_clk%d'%num)
        infra.add_port('core_clk156_out', 'core_clk_156_%d'%num)
        infra.add_port('xgmii_rx_clk', 'xgmii_rx_clk%d'%num)

        infra.add_port('qplloutclk_out        ', 'qplloutclk_out%d        '%num)
        infra.add_port('qplloutrefclk_out     ', 'qplloutrefclk_out%d     '%num)
        infra.add_port('qplllock_out          ', 'qplllock_out%d          '%num)
        infra.add_port('areset_clk156_out     ', 'areset_clk156_out%d     '%num)
        infra.add_port('txusrclk_out          ', 'txusrclk_out%d          '%num)
        infra.add_port('txusrclk2_out         ', 'txusrclk2_out%d         '%num)
        infra.add_port('gttxreset_out         ', 'gttxreset_out%d         '%num)
        infra.add_port('gtrxreset_out         ', 'gtrxreset_out%d         '%num)
        infra.add_port('txuserrdy_out         ', 'txuserrdy_out%d         '%num)
        infra.add_port('reset_counter_done_out', 'reset_counter_done_out%d'%num)
        infra.add_port('txclk322', 'txclk322_%d'%self.port)

    def instantiate_phy(self, top, num):

        phy = top.get_instance('tengbaser_phy_v2', 'tengbaser_phy%d'%self.port)

        phy.add_port('areset', 'sys_rst')

        # sigs from infrastructure
        phy.add_port('dclk', 'sys_clk')
        phy.add_port('clk156', 'core_clk%d'%num)
        phy.add_port('qplloutclk', 'qplloutclk_out%d'%num)
        phy.add_port('qplloutrefclk', 'qplloutrefclk_out%d'%num)
        phy.add_port('qplllock', 'qplllock_out%d'%num)
        phy.add_port('areset_clk156', 'areset_clk156_out%d'%num)
        phy.add_port('txusrclk', 'txusrclk_out%d'%num)
        phy.add_port('txusrclk2', 'txusrclk2_out%d'%num)
        phy.add_port('gttxreset', 'gttxreset_out%d'%num)
        phy.add_port('gtrxreset', 'gtrxreset_out%d'%num)
        phy.add_port('txuserrdy', 'txuserrdy_out%d'%num)
        phy.add_port('reset_counter_done', 'reset_counter_done_out%d'%num)
        phy.add_port('txclk322', 'txclk322_%d'%self.port)

        # top level ports
        phy.add_port('txp', 'mgt_tx_p%d'%self.port, parent_port=True, dir='out')
        phy.add_port('txn', 'mgt_tx_n%d'%self.port, parent_port=True, dir='out')
        phy.add_port('rxp', 'mgt_rx_p%d'%self.port, parent_port=True, dir='in')
        phy.add_port('rxn', 'mgt_rx_n%d'%self.port, parent_port=True, dir='in')
        phy.add_port('signal_detect', 'signal_detect%d'%self.port)
        top.assign_signal('signal_detect%d'%self.port, "1'b1") #snap doesn't wire this to SFP(?)
        phy.add_port('tx_fault', 'tx_fault%d'%self.port)
        top.assign_signal('tx_fault%d'%self.port, "1'b0") #snap doesn't wire this to SFP(?)
        phy.add_port('tx_disable', 'tx_disable%d'%self.port)

        phy.add_port('resetdone', 'resetdone%d'%self.port)
        phy.add_port('status_vector', '', parent_sig=False)
        # pma_pmd_type: 111=10g-base-SR, 110=-LR 101=-ER
        phy.add_port('pma_pmd_type', "3'b111", parent_sig=False)
        phy.add_port('configuration_vector', "536'b0", parent_sig=False)

        # XGMII signals to MAC
        phy.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        phy.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        phy.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        phy.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)
        phy.add_port('core_status', 'xaui_status%d'%self.port, width=8) #called xaui status for compatibility with kat-tge block

    def gen_constraints(self):
        num = self.infrastructure_id
        cons = []
        cons.append(PortConstraint('ref_clk_p%d'%num, 'gth_clk_p',iogroup_index=num))
        cons.append(PortConstraint('ref_clk_n%d'%num, 'gth_clk_n',iogroup_index=num))
        cons.append(PortConstraint('mgt_tx_p%d'%self.port, 'gth_tx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_tx_n%d'%self.port, 'gth_tx_n', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_p%d'%self.port, 'gth_rx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_n%d'%self.port, 'gth_rx_n', iogroup_index=self.port))

        #cons.append(PortConstraint('tx_disable%d'%self.port, 'sfp_disable', iogroup_index=self.port))

        cons.append(ClockConstraint('ref_clk_p%d'%num, name='ethclk%d'%num, freq=156.25))

        cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d -asynchronous -group [get_clocks -include_generated_clocks sys_clk_p_CLK] -group [get_clocks -include_generated_clocks ethclk%d]'%(num,num)))

        cons.append(RawConstraint('set_false_path -from [get_pins {tengbaser_infra%d_inst/ten_gig_eth_pcs_pma_core_support_layer_i/ten_gig_eth_pcs_pma_shared_clock_reset_block/reset_pulse_reg[0]/C}] -to [get_pins {tengbaser_infra%d_inst/ten_gig_eth_pcs_pma_core_support_layer_i/ten_gig_eth_pcs_pma_shared_clock_reset_block/gttxreset_txusrclk2_sync_i/sync1_r_reg*/PRE}]' % (num, num)))

        # make the ethernet core clock async relative to whatever the user is using as user_clk
        # Find the clock of *clk_counter* to determine what source user_clk comes from. This is fragile.
        cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d_usr_clk -asynchronous -group [get_clocks -of_objects [get_cells -hierarchical -filter {name=~*clk_counter*}]] -group [get_clocks -include_generated_clocks ethclk%d]' % (num, num)))



        return cons


class tengbaser_xilinx_usplus(ten_gbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.exc_requirements = ['tge%d'%self.slot]
        self.add_source('kat_ten_gb_eth/*')
        self.add_source('tengbaser_phy/ten_gig_pcs_pma_usplus.xci')

        self.port = 0 # Only allow 1 port of 10g on US+. FIXME
        self.infrastructure_id = self.port // 4

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

    def modify_top(self,top):
        self.instantiate_pcs(top, self.port)
        self.instantiate_ktge(top, self.port)

    def instantiate_pcs(self, top, num):
        inst = top.get_instance('ten_gig_pcs_pma_usplus', 'ten_gig_pcm_pma_inst')
        inst.add_port('gt_refclk_n', 'ref_clk_n%d'%num, parent_port=True, dir='in')
        inst.add_port('gt_refclk_p', 'ref_clk_p%d'%num, parent_port=True, dir='in')
        inst.add_port('gt_txp_out_0', 'mgt_tx_p%d'%self.port, parent_port=True, dir='out')
        inst.add_port('gt_txn_out_0', 'mgt_tx_n%d'%self.port, parent_port=True, dir='out')
        inst.add_port('gt_rxp_in_0', 'mgt_rx_p%d'%self.port, parent_port=True, dir='in')
        inst.add_port('gt_rxn_in_0', 'mgt_rx_n%d'%self.port, parent_port=True, dir='in')
        inst.add_port('tx_mii_d_0', 'xgmii_txd%d'%self.port, width=64)
        inst.add_port('tx_mii_c_0', 'xgmii_txc%d'%self.port, width=8)
        inst.add_port('rx_mii_d_0', 'xgmii_rxd%d'%self.port, width=64)
        inst.add_port('rx_mii_c_0', 'xgmii_rxc%d'%self.port, width=8)
        inst.add_port('tx_mii_clk_0', 'core_clk_156_%d'%num)
        inst.add_port('rx_core_clk_0', 'core_clk_156_%d'%num)


        inst.add_port('ctl_rx_data_pattern_select_0', "1'b0")
        inst.add_port('ctl_rx_prbs31_test_pattern_enable_0', "1'b0")
        inst.add_port('ctl_rx_test_pattern_0', "1'b0")
        inst.add_port('ctl_rx_test_pattern_enable_0', "1'b0")
        inst.add_port('ctl_tx_test_pattern_0', "1'b0")
        inst.add_port('ctl_tx_test_pattern_enable_0', "1'b0")
        inst.add_port('ctl_tx_test_pattern_select_0', "1'b0")
        inst.add_port('ctl_tx_data_pattern_select_0', "1'b0")
        inst.add_port('ctl_tx_test_pattern_seed_a_0', "58'b0")
        inst.add_port('ctl_tx_test_pattern_seed_b_0', "58'b0")
        inst.add_port('ctl_tx_prbs31_test_pattern_enable_0', "1'b0")
        inst.add_port('gt_loopback_in_0', "3'b0")

        inst.add_port('txoutclksel_in_0', "3'b101")
        inst.add_port('rxoutclksel_in_0', "3'b101")
        inst.add_port('gtwiz_reset_tx_datapath_0', "1'b0")
        inst.add_port('gtwiz_reset_rx_datapath_0', "1'b0")
        inst.add_port('sys_reset', 'sys_rst')
        inst.add_port('dclk', 'sys_clk')
        inst.add_port('tx_reset_0', "1'b0")
        inst.add_port('rx_reset_0', "1'b0")
        # Need to connect bit 0 of xaui_status to an active-high "link detected"
        # This is used by the uBlaze to detect change in link state (i.e.,
        # plugging or removing an SFP)
        inst.add_port('stat_rx_status_0', 'stat_rx_status_0_%d'%self.port)
        top.assign_signal('xaui_status%d[0]'%self.port, 'stat_rx_status_0_%d'%self.port)

    def gen_constraints(self):
        num = self.infrastructure_id
        cons = []
        cons.append(PortConstraint('ref_clk_p%d'%num, 'eth_clk_p',iogroup_index=num))
        cons.append(PortConstraint('ref_clk_n%d'%num, 'eth_clk_n',iogroup_index=num))
        cons.append(PortConstraint('mgt_tx_p%d'%self.port, 'mgt_tx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_tx_n%d'%self.port, 'mgt_tx_n', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_p%d'%self.port, 'mgt_rx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_n%d'%self.port, 'mgt_rx_n', iogroup_index=self.port))

        cons.append(ClockConstraint('ref_clk_p%d'%num, name='ethclk%d'%num, freq=156.25))

        # make the ethernet core clock async relative to whatever the user is using as user_clk
        # Find the clock of *clk_counter* to determine what source user_clk comes from. This is fragile.
        
        cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d -asynchronous -group [get_clocks -include_generated_clocks -of_objects [get_nets user_clk]] -group [get_clocks -include_generated_clocks ethclk%d]'%(num,num)))
        cons.append(RawConstraint('set_clock_groups -name asyncclocks_eth%d -asynchronous -group [get_clocks -include_generated_clocks -of_objects [get_nets sys_clk]] -group [get_clocks -include_generated_clocks ethclk%d]'%(num,num)))
        return cons


class tengbaser_xilinx_ultrascale(ten_gbe):
    def __init__(self, blk, plat, hdl_root):
        ten_gbe.__init__(self, blk, plat, hdl_root)
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.exc_requirements = ['tge%d'%self.slot]
        self.add_source('kat_ten_gb_eth/*')
        #self.add_source('tengbaser_phy_ultrascale/tengbaser_phy_ultrascale.v')
        self.add_source('tengbaser_phy_ultrascale/tengbaser_phy_ultrascale.xci')
        self.add_source('tengbaser_infrastructure_ultrascale/*')

        self.port = self.port_r1
        self.infrastructure_id = self.port // 4
        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

    def modify_top(self,top):
        # An infrastructure instance is good for 4 SFPs. Assuming the ports are numbered
        # so that instance0 serves ports 0-3, instance1 serves ports 4-7, etc. decide
        # whether to instantiate a new infrastrucure block
        if top.has_instance('tengbaser_infra%d_inst'%self.infrastructure_id):
            pass
        else:
            self.instantiate_infra(top, self.infrastructure_id)
            
        self.instantiate_phy(top, self.infrastructure_id)
        self.instantiate_ktge(top, self.infrastructure_id)
        self._instantiate_wbToaxi4lite(top,self.infrastructure_id)

    def instantiate_infra(self, top, num):
        infra = top.get_instance('tengbaser_infrastructure_ultrascale', 'tengbaser_infra%d_inst'%num)
        infra.add_port('gt_refclk_n', 'ref_clk_n%d'%num, parent_port=True, dir='in')
        infra.add_port('gt_refclk_p', 'ref_clk_p%d'%num, parent_port=True, dir='in')
        #infra.add_port('qpll0reset','gtwiz_reset_qpll0reset_out'%num)
        infra.add_port('qpll0reset',"1'b0")
        infra.add_port('qpll0lock','gtwiz_reset_qpll0lock_in%d'%num)
        infra.add_port('qpll0outclk','qpll0clk_in%d'%num)
        infra.add_port('qpll0outrefclk','qpll0refclk_in%d'%num)
        #infra.add_port('qpll1reset','gtwiz_reset_qpll1reset_out'%num)
        infra.add_port('qpll1reset',"1'b0")
        infra.add_port('qpll1lock','gtwiz_reset_qpll1lock_in%d'%num)
        infra.add_port('qpll1outclk','qpll1clk_in%d'%num)
        infra.add_port('qpll1outrefclk','qpll1refclk_in%d'%num)
        
    def instantiate_phy(self, top, num):
        phy = top.get_instance('tengbaser_phy_ultrascale', 'tengbaser_phy%d'%self.port)
        #GT_0 signals
        phy.add_port('gt_txp_out_0', 'mgt_tx_p%d'%self.port, parent_port=True, dir='out')
        phy.add_port('gt_txn_out_0', 'mgt_tx_n%d'%self.port, parent_port=True, dir='out')
        phy.add_port('gt_rxp_in_0', 'mgt_rx_p%d'%self.port, parent_port=True, dir='in')
        phy.add_port('gt_rxn_in_0', 'mgt_rx_n%d'%self.port, parent_port=True, dir='in')
        phy.add_port('tx_mii_clk_0','tx_mii_clk%d'%self.port)
        #phy.add_port('rx_core_clk_0','rx_clk_out%d'%self.port)
        phy.add_port('rx_core_clk_0','tx_mii_clk%d'%self.port)
        phy.add_port('rx_clk_out_0','rx_clk_out%d'%self.port)
        phy.add_port('gt_loopback_in_0',"3'b000")
        #RX_0 Signals
        phy.add_port('rx_reset_0','rx_core_reset_out%d'%self.port)
        phy.add_port('rxrecclkout_0','')
        #RX_0 User Interface  Signals
        phy.add_port('rx_mii_d_0','xgmii_rxd%d'%self.port, width=64)
        phy.add_port('rx_mii_c_0','xgmii_rxc%d'%self.port, width=8)
        #RX_0 Control Signals
        phy.add_port('ctl_rx_test_pattern_0',"1'b0")
        phy.add_port('ctl_rx_test_pattern_enable_0',"1'b0")
        phy.add_port('ctl_rx_data_pattern_select_0',"1'b0")
        phy.add_port('ctl_rx_prbs31_test_pattern_enable_0',"1'b0")
        #RX_0 Stats Signals
        phy.add_port('stat_rx_block_lock_0','stat_rx_block_lock%d'%self.port)
        phy.add_port('stat_rx_framing_err_valid_0','')
        phy.add_port('stat_rx_framing_err_0','')
        phy.add_port('stat_rx_hi_ber_0','')
        phy.add_port('stat_rx_valid_ctrl_code_0','')
        phy.add_port('stat_rx_bad_code_0','')
        phy.add_port('stat_rx_bad_code_valid_0','')
        phy.add_port('stat_rx_error_valid_0','')
        phy.add_port('stat_rx_error_0','')
        phy.add_port('stat_rx_fifo_error_0','')
        phy.add_port('stat_rx_local_fault_0','')
        phy.add_port('stat_rx_status_0','')
        #TX_0 Signals
        phy.add_port('tx_reset_0','tx_core_reset_out%d'%self.port)
        #TX_0 User Interface  Signals
        phy.add_port('tx_mii_d_0','xgmii_txd%d'%self.port, width=64)
        phy.add_port('tx_mii_c_0','xgmii_txc%d'%self.port, width=8)
        #TX_0 Control Signals
        phy.add_port('ctl_tx_test_pattern_0',"1'b0")
        phy.add_port('ctl_tx_test_pattern_enable_0',"1'b0")
        phy.add_port('ctl_tx_test_pattern_select_0',"1'b0")
        phy.add_port('ctl_tx_data_pattern_select_0',"1'b0")
        phy.add_port('ctl_tx_test_pattern_seed_a_0',"58'b0")
        phy.add_port('ctl_tx_test_pattern_seed_b_0',"58'b0")
        phy.add_port('ctl_tx_prbs31_test_pattern_enable_0',"1'b0")
        #TX_0 Stats Signals
        phy.add_port('stat_tx_local_fault_0','')
        #power good signal
        phy.add_port('gtpowergood_out_0','')
        #clk sel
        phy.add_port('txoutclksel_in_0',"3'b101")
        phy.add_port('rxoutclksel_in_0',"3'b101")
        #reset signals
        phy.add_port('rx_serdes_reset_0','rx_serdes_reset%d'%self.port)
        phy.add_port('gt_reset_all_in_0','gt_reset_all%d'%self.port)
        #phy.add_port('gt_tx_reset_in_0',"1'b0")
        #phy.add_port('gt_rx_reset_in_0',"1'b0")
        phy.add_port('gt_tx_reset_in_0','sys_rst')
        phy.add_port('gt_rx_reset_in_0','sys_rst')
        phy.add_port('gt_reset_tx_done_out_0','gt_reset_tx_done_out%d'%self.port)
        phy.add_port('gt_reset_rx_done_out_0','gt_reset_rx_done_out%d'%self.port)
        #clk signals
        phy.add_port('qpll0clk_in','qpll0clk_in%d'%num)
        phy.add_port('qpll0refclk_in','qpll0refclk_in%d'%num)
        phy.add_port('qpll1clk_in','qpll1clk_in%d'%num)
        phy.add_port('qpll1refclk_in','qpll1refclk_in%d'%num)
        phy.add_port('gtwiz_reset_qpll0lock_in','gtwiz_reset_qpll0lock_in%d'%num)
        phy.add_port('gtwiz_reset_qpll1lock_in','gtwiz_reset_qpll1lock_in%d'%num)
        #phy.add_port('gtwiz_reset_qpll0reset_out','gtwiz_reset_qpll0reset_out'%num)
        #phy.add_port('gtwiz_reset_qpll1reset_out','gtwiz_reset_qpll1reset_out'%num)
        phy.add_port('gtwiz_reset_qpll0reset_out','')
        phy.add_port('gtwiz_reset_qpll1reset_out','')
        #sys reset
        phy.add_port('sys_reset','sys_rst')
        # TODO likely not user_clk, what should this be?
        phy.add_port('dclk','user_clk')
        
        phy_reset = top.get_instance('tengbaser_phy_ultrascale_reset', 'tengbaser_phy_reset%d'%self.port)
        phy_reset.add_port('gt_txusrclk2','tx_mii_clk%d'%self.port)
        phy_reset.add_port('gt_rxusrclk2','rx_clk_out%d'%self.port)
        phy_reset.add_port('rx_core_clk','rx_clk_out%d'%self.port)
        phy_reset.add_port('gt_tx_reset_in','gt_reset_tx_done_out%d'%self.port)
        phy_reset.add_port('gt_rx_reset_in','gt_reset_rx_done_out%d'%self.port)
        phy_reset.add_port('tx_core_reset_in',"1'b0")
        phy_reset.add_port('rx_core_reset_in',"1'b0")
        phy_reset.add_port('tx_core_reset_out','tx_core_reset_out%d'%self.port)
        phy_reset.add_port('rx_core_reset_out','rx_core_reset_out%d'%self.port)
        phy_reset.add_port('rx_serdes_reset_out','rx_serdes_reset%d'%self.port)
        phy_reset.add_port('usr_tx_reset','')
        phy_reset.add_port('usr_rx_reset','')
        phy_reset.add_port('gtwiz_reset_all','gt_reset_all%d'%self.port)
        phy_reset.add_port('sys_reset','sys_rst')
		
    def instantiate_ktge(self, top, num=None):
        ktge = top.get_instance(name=self.fullname, entity='kat_ten_gb_eth')
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
        if num is None:
            ktge.add_port('xaui_clk', 'xaui_clk')
        else:
            ktge.add_port('xaui_clk', 'tx_mii_clk%d'%self.port)
        ktge.add_port('xaui_reset', 'sys_rst', parent_sig=False)
        ktge.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        ktge.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        ktge.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        ktge.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)

        # XAUI CONF interface
        ktge.add_port('xaui_status', "{7'b0,stat_rx_block_lock%d}"%self.port,parent_sig=False)

        ktge.add_port('clk', 'user_clk', parent_sig=False)

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
        #ktge.add_wb_interface(self.unique_name, mode='rw', nbytes=0xF000, typecode=self.typecode) # as in matlab code
        top.add_axi4lite_interface(regname=self.unique_name, mode='rw', nbytes=0xF000, typecode=self.typecode, axi4lite_mode='raw')
        # add wb ports
        ktge.add_port('wb_clk_i','axil_clk')
        ktge.add_port('wb_rst_i',self.fullname + 'wb_rst')#
        ktge.add_port('wb_stb_i', self.fullname + '_wb_stb')#
        ktge.add_port('wb_cyc_i', self.fullname + '_wb_cyc')#
        ktge.add_port('wb_we_i' , self.fullname + '_wb_we')#
        ktge.add_port('wb_adr_i' , self.fullname + 'wb_adr', width=32)#
        ktge.add_port('wb_dat_i' , self.fullname + 'wb_dat_i', width=32)#
        ktge.add_port('wb_sel_i' , self.fullname + 'wb_sel', width=4)#
        ktge.add_port('wb_dat_o' , self.fullname + 'wb_dat_o', width=32)#
        ktge.add_port('wb_err_o' , self.fullname + 'wb_err')
        ktge.add_port('wb_ack_o' , self.fullname + 'wb_ack')#

    def _instantiate_wbToaxi4lite(self,top,num=None):
        gbe_wb2axi4lite = top.get_instance(entity='axi_slave_wishbone_classic_master', name=self.fullname+'_wb2axi4lite')
        #add parameter
        gbe_wb2axi4lite.add_parameter('C_S_AXI_ID_WIDTH', value=1)
        gbe_wb2axi4lite.add_parameter('C_S_AXI_DATA_WIDTH',value=32)
        gbe_wb2axi4lite.add_parameter('C_S_AXI_ADDR_WIDTH',value=32)
        gbe_wb2axi4lite.add_parameter('C_S_AXI_AWUSER_WIDTH',value=1)
        gbe_wb2axi4lite.add_parameter('C_S_AXI_ARUSER_WIDTH',value=1)
        gbe_wb2axi4lite.add_parameter('C_S_AXI_WUSER_WIDTH',value=1)
        gbe_wb2axi4lite.add_parameter('C_S_AXI_RUSER_WIDTH',value=1)
        gbe_wb2axi4lite.add_parameter('C_S_AXI_BUSER_WIDTH',value=1)
        #wb interface
        gbe_wb2axi4lite.add_port('RST_O',self.fullname + 'wb_rst')
        gbe_wb2axi4lite.add_port('DAT_O',self.fullname + 'wb_dat_i', width=32)
        gbe_wb2axi4lite.add_port('DAT_I',self.fullname + 'wb_dat_o', width=32)
        gbe_wb2axi4lite.add_port('ACK_I',self.fullname + 'wb_ack')
        gbe_wb2axi4lite.add_port('ADR_O',self.fullname + 'wb_adr', width=32)
        gbe_wb2axi4lite.add_port('CYC_O',self.fullname + '_wb_cyc')
        gbe_wb2axi4lite.add_port('SEL_O',self.fullname + 'wb_sel', width=4)
        gbe_wb2axi4lite.add_port('STB_O',self.fullname + '_wb_stb')
        gbe_wb2axi4lite.add_port('WE_O',self.fullname + '_wb_we')
        #axi4lite interface
        gbe_wb2axi4lite.add_port('S_AXI_ACLK','axil_clk')
        gbe_wb2axi4lite.add_port('S_AXI_ARESETN','axil_rst_n')
        gbe_wb2axi4lite.add_port('S_AXI_AWREADY','m_axi4lite_%s_awready' %self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_WREADY','m_axi4lite_%s_wready' %self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_BRESP','m_axi4lite_%s_bresp' %self.unique_name, width=2)
        gbe_wb2axi4lite.add_port('S_AXI_BVALID','m_axi4lite_%s_bvalid'%self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_ARREADY','m_axi4lite_%s_arready'%self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_RRESP','m_axi4lite_%s_rresp'%self.unique_name, width=2)
        gbe_wb2axi4lite.add_port('S_AXI_RDATA','m_axi4lite_%s_rdata'%self.unique_name, width=32)
        gbe_wb2axi4lite.add_port('S_AXI_RVALID','m_axi4lite_%s_rvalid'%self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_AWADDR','m_axi4lite_%s_awaddr'%self.unique_name, width=32)
        gbe_wb2axi4lite.add_port('S_AXI_AWVALID','m_axi4lite_%s_awvalid'%self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_WDATA','m_axi4lite_%s_wdata'%self.unique_name, width=32)
        gbe_wb2axi4lite.add_port('S_AXI_WVALID','m_axi4lite_%s_wvalid'%self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_WSTRB','m_axi4lite_%s_wstrb'%self.unique_name, width=4)
        gbe_wb2axi4lite.add_port('S_AXI_ARADDR','m_axi4lite_%s_araddr'%self.unique_name, width=32)
        gbe_wb2axi4lite.add_port('S_AXI_ARVALID','m_axi4lite_%s_arvalid'%self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_RREADY','m_axi4lite_%s_rready'%self.unique_name)
        gbe_wb2axi4lite.add_port('S_AXI_BREADY', 'm_axi4lite_%s_bready'%self.unique_name)
        #axi4 compatibility
        gbe_wb2axi4lite.add_port('S_AXI_WLAST','1\'b1',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWID','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARID','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWSIZE','3\'b010',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARSIZE','3\'b010',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWLEN','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARLEN','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWBURST','2\'b01',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARBURST','2\'b01',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWLOCK','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARLOCK','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWPROT','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARPROT','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWQOS','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARQOS','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARREGION','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWREGION','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARCACHE','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_AWCACHE','0',parent_sig=False)
        #not used
        gbe_wb2axi4lite.add_port('S_AXI_AWUSER','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_WUSER','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_ARUSER','0',parent_sig=False)
        gbe_wb2axi4lite.add_port('S_AXI_BUSER','')
        gbe_wb2axi4lite.add_port('S_AXI_RUSER','')
        #fixed output, not used
        gbe_wb2axi4lite.add_port('S_AXI_BID','')
        gbe_wb2axi4lite.add_port('S_AXI_RID','')
        #not useful
        gbe_wb2axi4lite.add_port('S_AXI_RLAST','')

    def gen_constraints(self):
        num = self.infrastructure_id
        cons = []
        cons.append(PortConstraint('ref_clk_p%d'%num, 'qsfp_mgt_ref_clk_p',iogroup_index=num))
        cons.append(PortConstraint('ref_clk_n%d'%num, 'qsfp_mgt_ref_clk_n',iogroup_index=num))
        cons.append(PortConstraint('mgt_tx_p%d'%self.port, 'qsfp_mgt_tx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_tx_n%d'%self.port, 'qsfp_mgt_tx_n', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_p%d'%self.port, 'qsfp_mgt_rx_p', iogroup_index=self.port))
        cons.append(PortConstraint('mgt_rx_n%d'%self.port, 'qsfp_mgt_rx_n', iogroup_index=self.port))

        cons.append(ClockConstraint('ref_clk_p%d'%num, name='ref_clk_p%d'%num, freq=156.25))

        # Set the 10G clocks to be asynchronous to both the user clock and the system clock / axi clk
        clkname = 'ref_clk_p%d'%num
        cons.append(ClockGroupConstraint('-include_generated_clocks -of_objects [get_nets sys_clk]',  '-include_generated_clocks %s' % clkname, 'asynchronous'))
        cons.append(ClockGroupConstraint('-include_generated_clocks -of_objects [get_nets user_clk]', '-include_generated_clocks %s' % clkname, 'asynchronous'))
        cons.append(ClockGroupConstraint('-include_generated_clocks -of_objects [get_nets axil_clk]', '-include_generated_clocks %s' % clkname, 'asynchronous'))

        return cons
