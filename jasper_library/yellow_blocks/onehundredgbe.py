from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint
from helpers import to_int_list
from yellow_block_typecodes import *

class onehundredgbe(YellowBlock):
    @staticmethod
    def factory(blk, plat, hdl_root=None):
        if plat.name in ['vcu118']:
            return onehundredgbe_vcu118(blk, plat, hdl_root)
        else:
            pass
    """
    Future common methods here.
    """

class onehundredgbe_vcu118(onegbe):
    def initialize(self):
        self.typecode = TYPECODE_ETHCORE
        self.add_source('onehundredgbe/*.v')
        self.add_source('onehundredgbe/*.xci')
        self.add_source('onehundredgbe/*.coe')

        self.provides = ['ethernet']
        if (not self.dis_cpu_tx) and (not self.dis_cpu_tx):
            self.provides += ['cpu_ethernet']

        self.refclk_freq = 625.0

    def modify_top(self, top):
        inst = top.get_instance(entity='cmac_usplus_0_exdes', self.fullname+'cmac_usplus_0_exdes_inst')
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

        inst.add_port('Dest_port', '', width=16)
        inst.add_port('Source_port', '', width=16)
        inst.add_port('Dest_Ip', '', width=32)
        inst.add_port('Data_input', '', width=176)
        inst.add_port('Dest_Mac', '', width=48)
        inst.add_port('Source_Mac', '', width=48)
        inst.add_port('Source_Ip', '', width=32)

    def gen_constraints(self, top):
        consts = []
        consts += [PortConstraint(self.fullname+'_570_p', 'userclk570_p')]
        consts += [ClockConstraint(self.fullname+'_570_p', name='init_clk', freq=322.265625)]
        consts += [PortConstraint(self.fullname+'_gt_ref_clk_p', 'qsfpclk156_p')]
        consts += [ClockConstraint(self.fullname+'_gt_ref_clk_p', name='gt_ref_clk', freq=161.1328125)]
        return consts