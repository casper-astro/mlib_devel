from .yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint
from helpers import to_int_list
from .yellow_block_typecodes import *

class onehundred_gbe(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.name in ['vcu118']:
            return onehundredgbe_vcu118(blk, plat, hdl_root)
        else:
            pass
    """
    Future common methods here.
    """

class onehundredgbe_vcu118(onehundred_gbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.add_source('onehundred_gbe/*.v')
        self.add_source('onehundred_gbe/*.xci')
        self.add_source('onehundred_gbe/*.coe')
        self.add_source('onehundred_gbe/ipstatic/hdl/*.v')
        # self.add_source('onehundred_gbe/ipstatic/ipshared/7518/hdl/*.v')
        # self.add_source('onehundred_gbe/ip/cmac_usplus_0/*')
        # self.add_source('onehundred_gbe/ip/cmac_usplus_0_gt/*')

        self.provides = ['ethernet']
        if self.cpu_rx_en and self.cpu_tx_en:
            self.provides += ['cpu_ethernet']

        self.refclk_freq = 625.0

    def modify_top(self, top):
        inst = top.get_instance(entity='cmac_usplus_0_exdes', name=self.fullname+'cmac_usplus_0_exdes_inst')
        inst.add_port('gt_rxp_in', '', width=4)
        inst.add_port('gt_rxn_in', '', width=4)
        inst.add_port('gt_txp_out', '', width=4)
        inst.add_port('gt_txn_out', '', width=4)

        inst.add_port('lbus_tx_rx_restart_in', '')
        inst.add_port('tx_done_led', '')
        inst.add_port('tx_busy_led', '')

        inst.add_port('rx_gt_locked_led', '')
        inst.add_port('rx_aligned_led', '')
        inst.add_port('rx_done_led', '')
        inst.add_port('rx_data_fail_led', '')
        inst.add_port('rx_busy_led', '')

        inst.add_port('sys_reset', '')

        inst.add_port('gt_ref_clk_p', self.fullname+'_gt_ref_clk_p', dir='in', parent_port=True)
        inst.add_port('gt_ref_clk_n', self.fullname+'_gt_ref_clk_n', dir='in', parent_port=True)
        inst.add_port('init_clk_p', self.fullname+'_570_p', dir='in', parent_port=True)
        inst.add_port('init_clk_n', self.fullname+'_570_n', dir='in', parent_port=True)

        inst.add_port('Dest_Ip', self.fullname+'_tx_dest_ip', width=32)
        inst.add_port('Dest_port', self.fullname+'_tx_dest_port', width=16)
        inst.add_port('Source_Ip', self.fullname+'_rx_source_ip', width=32)
        inst.add_port('Source_port', self.fullname+'_rx_source_port', width=16)
        inst.add_port('Data_input', '', width=176)
        inst.add_port('Dest_Mac', '', width=48)
        inst.add_port('Source_Mac', '', width=48)
        

    def gen_constraints(self):
        consts = []
        consts += [PortConstraint(self.fullname+'_570_p', 'userclk570_p')]
        consts += [ClockConstraint(self.fullname+'_570_p', name='init_clk', freq=322.265625)]
        consts += [PortConstraint(self.fullname+'_gt_ref_clk_p', 'qsfpclk156_p')]
        consts += [ClockConstraint(self.fullname+'_gt_ref_clk_p', name='gt_ref_clk', freq=161.1328125)]
        return consts