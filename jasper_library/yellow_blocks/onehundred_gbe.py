from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint
from helpers import to_int_list
from .yellow_block_typecodes import *
from os.path import join

class onehundred_gbe(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.name in ['vcu118', 'vcu128'] or plat.conf.get('family', None) in ["ultrascaleplus"]:
            return onehundredgbe_usplus(blk, plat, hdl_root)
        else:
            pass
    """
    Future common methods here.
    """

class onehundredgbe_usplus(onehundred_gbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        kdir = "onehundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl"
        self.add_source('onehundred_gbe/*.v')
        self.add_source(join(kdir, "*.vhd"))
        self.add_source(join(kdir, "*", "*.vhd"))
        self.add_source(join(kdir, "udp", "macinterface", "*.vhd"))
        self.add_source(join(kdir, "udp", "macinterface", "*", "*.vhd"))
        #self.add_source('onehundred_gbe/kutleng/*.vhd')
        #self.add_source('onehundred_gbe/kutleng/arp/*.vhd')
        #self.add_source('onehundred_gbe/kutleng/lbustoaxis/*.vhd')
        #self.add_source('onehundred_gbe/kutleng/macphy/*.vhd')
        #self.add_source('onehundred_gbe/kutleng/ringbuffer/*.vhd')
        #self.add_source('onehundred_gbe/kutleng/udp/*.vhd')
        #self.add_source('onehundred_gbe/kutleng/udp/macinterface/*.vhd')
        #self.add_source('onehundred_gbe/kutleng/udp/macinterface/cpuinterface/*.vhd')
        self.add_source('onehundred_gbe/ip/axis_data_fifo/*.xci')
        self.add_source('onehundred_gbe/ip/axisila/*.xci')
        self.add_source('onehundred_gbe/ip/axispacketbufferfifo/*.xci')
        self.add_source('onehundred_gbe/ip/dest_address_fifo/*.xci')
        self.add_source('onehundred_gbe/ip/EthMACPHY100GQSFP4x/*.xci')

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

        # Hard-code to port 0 for now
        self.port = 0
        # For partial reconfig, it is useful to have statically-named top-level ports
        # which don't depend on model name. Generate a prefix which will probably
        # be unique
        self.portbase = '{blocktype}{port}'.format(blocktype=self.blocktype, port=self.port)

        try:
            ethconf = self.platform.conf["onehundredgbe"]
        except KeyError:
            self.logger.exception("Failed to find `onehundredgbe` configuration in platform's YAML file")
            raise
        
        try:
            self.refclk_freq_str = ethconf["refclk_freq_str"]
        except KeyError:
            self.logger.error("Missing onehundredgbe `refclk_freq_str` parameter in YAML file")
            raise
        self.refclk_freq = float(self.refclk_freq_str)
        try:
            self.cmac_loc = ethconf["cmac_loc"][self.port]
        except KeyError:
            self.logger.error("Missing onehundredgbe `cmac_loc` parameter in YAML file")
            raise
        except IndexError:
            self.logger.error("Missing entry for port %d in onehundredgbe `cmac_loc` parameter" % self.port)
            raise

    def modify_top(self, top):
        inst = top.get_instance(entity='casper100g_noaxi', name=self.fullname+'_inst')
        
        inst.add_port('RefClk100MHz', 'sys_clk')
        inst.add_port('RefClkLocked', '~sys_rst', parent_sig=False)
        inst.add_port('aximm_clk', 'axil_clk')
        inst.add_port('icap_clk', 'axil_clk')
        inst.add_port('axis_reset', "1'b0")#'axil_rst')
        # MGT connections
        inst.add_port('mgt_qsfp_clock_p', self.portbase+'_refclk_p', dir='in', parent_port=True)
        inst.add_port('mgt_qsfp_clock_n', self.portbase+'_refclk_n', dir='in', parent_port=True)

        inst.add_port('qsfp_mgt_rx_p', self.portbase+'_qsfp_mgt_rx_p', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_rx_n', self.portbase+'_qsfp_mgt_rx_n', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_p', self.portbase+'_qsfp_mgt_tx_p', dir='out', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_n', self.portbase+'_qsfp_mgt_tx_n', dir='out', width=4, parent_port=True)
        # QSFP config interface
        inst.add_port('qsfp_modsell_ls', '') #self.portbase+'_qsfp_modsell_ls')
        inst.add_port('qsfp_resetl_ls',  '') #self.portbase+'_qsfp_resetl_ls')
        inst.add_port('qsfp_modprsl_ls', self.portbase+'_qsfp_modprsl_ls', dir='in', parent_port=True)
        inst.add_port('qsfp_intl_ls',    '1\'b1') #self.portbase+'_qsfp_intl_ls')
        inst.add_port('qsfp_lpmode_ls',  '') #self.portbase+'_qsfp_lpmode_ls')

        inst.add_port('user_clk', 'user_clk')

        # Simulink Interfaces
        inst.add_port('gbe_tx_afull',         self.fullname+'_tx_afull')        
        inst.add_port('gbe_tx_overflow',      self.fullname+'_tx_overflow')
        inst.add_port('gbe_rx_data',          self.fullname+'_rx_data',        width=512)
        inst.add_port('gbe_rx_valid',         self.fullname+'_rx_valid',       width=4)
        inst.add_port('gbe_rx_source_ip',     self.fullname+'_rx_source_ip',   width=32)
        inst.add_port('gbe_rx_source_port',   self.fullname+'_rx_source_port', width=16)
        inst.add_port('gbe_rx_dest_ip',       self.fullname+'_rx_dest_ip',     width=32)
        inst.add_port('gbe_rx_dest_port',     self.fullname+'_rx_dest_port',   width=16)
        inst.add_port('gbe_rx_end_of_frame',  self.fullname+'_rx_end_of_frame')
        inst.add_port('gbe_rx_bad_frame',     self.fullname+'_rx_bad_frame')
        inst.add_port('gbe_rx_overrun',       self.fullname+'_rx_overrun')
        inst.add_port('gbe_led_up',           self.fullname+'_led_up')
        inst.add_port('gbe_led_rx',           self.fullname+'_led_rx')
        inst.add_port('gbe_led_tx',           self.fullname+'_led_tx')

        inst.add_port('gbe_rst',              self.fullname+'_rst')
        inst.add_port('gbe_rx_ack',           self.fullname+'_rx_ack')
        inst.add_port('gbe_rx_overrun_ack',   self.fullname+'_rx_overrun_ack')
        inst.add_port('gbe_tx_dest_ip',       self.fullname+'_tx_dest_ip',     width=32)
        inst.add_port('gbe_tx_dest_port',     self.fullname+'_tx_dest_port',   width=16)
        inst.add_port('gbe_tx_data',          self.fullname+'_tx_data',        width=512)
        inst.add_port('gbe_tx_valid',         self.fullname+'_tx_valid',       width=4)
        inst.add_port('gbe_tx_end_of_frame',  self.fullname+'_tx_end_of_frame')

    def gen_constraints(self):
        consts = []
        consts += [PortConstraint(self.portbase+'_refclk_p', 'qsfp_mgt_ref_clk_p', iogroup_index=self.port)]
        consts += [PortConstraint(self.portbase+'_refclk_n', 'qsfp_mgt_ref_clk_n', iogroup_index=self.port)]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_rx_p', 'qsfp_mgt_rx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_rx_n', 'qsfp_mgt_rx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_tx_p', 'qsfp_mgt_tx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.portbase+'_qsfp_mgt_tx_n', 'qsfp_mgt_tx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        #consts += [PortConstraint(self.portbase+'_qsfp_modsell_ls', '', iogroup_index=self.port)]
        #consts += [PortConstraint(self.portbase+'_qsfp_resetl_ls', '', iogroup_index=self.port)]
        consts += [PortConstraint(self.portbase+'_qsfp_modprsl_ls', 'qsfp_modprs', iogroup_index=self.port)]
        #consts += [PortConstraint(self.portbase+'_qsfp_intl_ls', '', iogroup_index=self.port)]
        #consts += [PortConstraint(self.portbase+'_qsfp_lpmode_ls', '', iogroup_index=self.port)]
        self.myclk = ClockConstraint(self.portbase+'_refclk_p', name=self.fullname+'_refclk_p', freq=self.refclk_freq)
        consts += [self.myclk]
        return consts

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        # Override the IP reference clock frequency
        tcl_cmds['pre_synth'] = ['set_property -dict [list CONFIG.GT_REF_CLK_FREQ {%s}] [get_ips EthMACPHY100GQSFP4x]' % self.refclk_freq_str]

        # The LOCs seem to get overriden by the user constraints above, but we need to manually unplace the CMAC blocks
        tcl_cmds['post_synth'] = ['unplace_cell [get_cells -hierarchical -filter { PRIMITIVE_TYPE == ADVANCED.MAC.CMACE4 && NAME =~ "*%s*" }]' % self.fullname]
        tcl_cmds['post_synth'] += ['place_cell [get_cells -hierarchical -filter { PRIMITIVE_TYPE == ADVANCED.MAC.CMACE4 && NAME =~ "*%s*" }] %s' % (self.fullname, self.cmac_loc)]
        # Set the 100G clock to be asynchronous to both the user clock and the AXI clock. Do this after synth so we can get the user clock without knowing what the user is clocking from
        tcl_cmds['post_synth'] += ['set_clock_groups -name async_user_%s -asynchronous -group [get_clocks -include_generated_clocks -of_objects [get_nets user_clk]] -group [get_clocks -include_generated_clocks %s]' % (self.myclk.name, self.myclk.name)]
        tcl_cmds['post_synth'] += ['set_clock_groups -name async_axi_%s -asynchronous -group [get_clocks -include_generated_clocks  axil_clk] -group [get_clocks -include_generated_clocks %s]' % (self.myclk.name, self.myclk.name)]
        return tcl_cmds
