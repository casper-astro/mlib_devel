from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint
from helpers import to_int_list
from .yellow_block_typecodes import *

class onehundred_gbe(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.name in ['vcu118', 'vcu128']:
            return onehundredgbe_vcu118(blk, plat, hdl_root)
        else:
            pass
    """
    Future common methods here.
    """

class onehundredgbe_vcu118(onehundred_gbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.add_source('onehundred_gbe/kutleng/*.xci')
        self.add_source('onehundred_gbe/kutleng/*.vhd')
        self.add_source('onehundred_gbe/kutleng/*.v')
        self.add_source('onehundred_gbe/kutleng/lbustoaxis/*.vhd')
        self.add_source('onehundred_gbe/kutleng/udp/*.vhd')
        self.add_source('onehundred_gbe/kutleng/udp/macinterface.vhd')
        self.add_source('onehundred_gbe/kutleng/macinterface/*.vhd')
        self.add_source('onehundred_gbe/kutleng/arp/*.vhd')
        self.add_source('onehundred_gbe/kutleng/ringbuffer/*.vhd')

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

        self.refclk_freq = 156.25
        # Hard-code to port 0 for now
        self.port = 0

    def modify_top(self, top):
        inst = top.get_instance(entity='qsfp_100g_top', name=self.fullname+'_inst')
        
        inst.add_port('clk_100', 'sys_clk')
        inst.add_port('clk_100_locked', '~sys_rst', parent_sig=False)
        inst.add_port('rst', 'sys_rst')
        inst.add_port('enable', '1\'b1')
        # MGT connections
        inst.add_port('refclk156_p', self.fullname+'_refclk156_p', dir='in', parent_port=True)
        inst.add_port('refclk156_n', self.fullname+'_refclk156_n', dir='in', parent_port=True)

        inst.add_port('qsfp_mgt_rx_p', self.fullname+'_qsfp_mgt_rx_p', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_rx_n', self.fullname+'_qsfp_mgt_rx_n', dir='in', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_p', self.fullname+'_qsfp_mgt_tx_p', dir='out', width=4, parent_port=True)
        inst.add_port('qsfp_mgt_tx_n', self.fullname+'_qsfp_mgt_tx_n', dir='out', width=4, parent_port=True)

    def gen_constraints(self):
        consts = []
        consts += [PortConstraint(self.fullname+'_refclk156_p', 'mgt_ref_clk_p', iogroup_index=self.port)]
        consts += [PortConstraint(self.fullname+'_refclk156_n', 'mgt_ref_clk_p', iogroup_index=self.port)]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_rx_p', 'qsfp_mgt_rx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_rx_n', 'qsfp_mgt_rx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_tx_p', 'qsfp_mgt_tx_p', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [PortConstraint(self.fullname+'_qsfp_mgt_tx_n', 'qsfp_mgt_tx_n', port_index=range(4), iogroup_index=range(4*self.port, 4*(self.port + 1)))]
        consts += [ClockConstraint(self.fullname+'_refclk156_p', name=self.fullname+'_refclk156_p', freq=self.refclk_freq)]
        return consts
