from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint
from helpers import to_int_list
from .yellow_block_typecodes import *

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
        self.add_source('onehundred_gbe/*.v')
        self.add_source('onehundred_gbe/kutleng/*.vhd')
        self.add_source('onehundred_gbe/kutleng/arp/*.vhd')
        self.add_source('onehundred_gbe/kutleng/lbustoaxis/*.vhd')
        self.add_source('onehundred_gbe/kutleng/macphy/*.vhd')
        self.add_source('onehundred_gbe/kutleng/ringbuffer/*.vhd')
        self.add_source('onehundred_gbe/kutleng/udp/*.vhd')
        self.add_source('onehundred_gbe/kutleng/udp/macinterface/*.vhd')
        self.add_source('onehundred_gbe/kutleng/udp/macinterface/cpuinterface/*.vhd')
        self.add_source('onehundred_gbe/ip/*.xci')

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

        self.refclk_freq = 156.25
        # Hard-code to port 0 for now
        self.port = 0

    def modify_top(self, top):
        inst = top.get_instance(entity='casper100g_noaxi', name=self.fullname+'_inst')
        
        inst.add_port('RefClk100MHz', 'sys_clk')
        inst.add_port('RefClkLocked', '~sys_rst', parent_sig=False)
        inst.add_port('aximm_clk', 'axil_clk')
        inst.add_port('icap_clk', 'axil_clk')
        inst.add_port('axis_reset', 'axil_rst')
        # MGT connections
        inst.add_port('mgt_qsfp_clock_p', self.fullname+'_refclk156_p', dir='in', parent_port=True)
        inst.add_port('mgt_qsfp_clock_n', self.fullname+'_refclk156_n', dir='in', parent_port=True)

        inst.add_port('qsfp_mgt_rx_p', self.fullname+'_qsfp_mgt_rx_p', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_rx_n', self.fullname+'_qsfp_mgt_rx_n', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_p', self.fullname+'_qsfp_mgt_tx_p', dir='out', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_n', self.fullname+'_qsfp_mgt_tx_n', dir='out', width=4, parent_port=True)
        # QSFP config interface
        inst.add_port('qsfp_modsell_ls', '') #self.fullname+'_qsfp_modsell_ls')
        inst.add_port('qsfp_resetl_ls',  '') #self.fullname+'_qsfp_resetl_ls')
        inst.add_port('qsfp_modprsl_ls', self.fullname+'_qsfp_modprsl_ls', dir='in', parent_port=True)
        inst.add_port('qsfp_intl_ls',    '1\'b1') #self.fullname+'_qsfp_intl_ls')
        inst.add_port('qsfp_lpmode_ls',  '') #self.fullname+'_qsfp_lpmode_ls')

        inst.add_port('user_clk', 'user_clk')

        # Simulink Interfaces
        inst.add_port('gbe_tx_afull',         self.fullname+'_gbe_tx_afull')        
        inst.add_port('gbe_tx_overflow',      self.fullname+'_gbe_tx_overflow')
        inst.add_port('gbe_rx_data',          self.fullname+'_gbe_rx_data',        width=512)
        inst.add_port('gbe_rx_valid',         self.fullname+'_gbe_rx_valid',       width=4)
        inst.add_port('gbe_rx_source_ip',     self.fullname+'_gbe_rx_source_ip',   width=32)
        inst.add_port('gbe_rx_source_port',   self.fullname+'_gbe_rx_source_port', width=16)
        inst.add_port('gbe_rx_dest_ip',       self.fullname+'_gbe_rx_dest_ip',     width=32)
        inst.add_port('gbe_rx_dest_port',     self.fullname+'_gbe_rx_dest_port',   width=16)
        inst.add_port('gbe_rx_end_of_frame',  self.fullname+'_gbe_rx_end_of_frame')
        inst.add_port('gbe_rx_bad_frame',     self.fullname+'_gbe_rx_bad_frame')
        inst.add_port('gbe_rx_overrun',       self.fullname+'_gbe_rx_overrun')
        inst.add_port('gbe_led_up',           self.fullname+'_gbe_led_up')
        inst.add_port('gbe_led_rx',           self.fullname+'_gbe_led_rx')
        inst.add_port('gbe_led_tx',           self.fullname+'_gbe_led_tx')

        inst.add_port('gbe_rst',              self.fullname+'_gbe_rst')
        inst.add_port('gbe_rx_ack',           self.fullname+'_gbe_rx_ack')
        inst.add_port('gbe_rx_overrun_ack',   self.fullname+'_gbe_rx_overrun_ack')
        inst.add_port('gbe_tx_dest_ip',       self.fullname+'_gbe_tx_dest_ip',     width=32)
        inst.add_port('gbe_tx_dest_port',     self.fullname+'_gbe_tx_dest_port',   width=16)
        inst.add_port('gbe_tx_data',          self.fullname+'_gbe_tx_data',        width=512)
        inst.add_port('gbe_tx_valid',         self.fullname+'_gbe_tx_valid',       width=4)
        inst.add_port('gbe_tx_end_of_frame',  self.fullname+'_gbe_tx_end_of_frame')

    def gen_constraints(self):
        consts = []
        consts += [PortConstraint(self.fullname+'_refclk156_p', 'qsfp_mgt_ref_clk_p', iogroup_index=self.port)]
        consts += [PortConstraint(self.fullname+'_refclk156_n', 'qsfp_mgt_ref_clk_n', iogroup_index=self.port)]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_rx_p', 'qsfp_mgt_rx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_rx_n', 'qsfp_mgt_rx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_tx_p', 'qsfp_mgt_tx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_tx_n', 'qsfp_mgt_tx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        #consts += [PortConstraint(self.fullname+'_qsfp_modsell_ls', '', iogroup_index=self.port)]
        #consts += [PortConstraint(self.fullname+'_qsfp_resetl_ls', '', iogroup_index=self.port)]
        consts += [PortConstraint(self.fullname+'_qsfp_modprsl_ls', 'qsfp_modprs', iogroup_index=self.port)]
        #consts += [PortConstraint(self.fullname+'_qsfp_intl_ls', '', iogroup_index=self.port)]
        #consts += [PortConstraint(self.fullname+'_qsfp_lpmode_ls', '', iogroup_index=self.port)]
        consts += [ClockConstraint(self.fullname+'_refclk156_p', name=self.fullname+'_refclk156_p', freq=self.refclk_freq)]
        return consts

    def gen_tcl_cmds(self):
        tcl_cmds = {}
        # We've let the IP manage where to put transceivers and CMAC cores based on its properties.
        # The LOCs seem to get overriden by the user constraints above, but we need to manually unplace the CMAC blocks
        tcl_cmds['post_synth'] = ['unplace_cell [get_cells -hierarchical -filter { PRIMITIVE_TYPE == ADVANCED.MAC.CMACE4 } ]']
        return tcl_cmds
