from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, RawConstraint
from itertools import count

class hmc(YellowBlock): # class hmc inherits from yellowblock.py
    #@staticmethod
    #def factory(blk, plat, hdl_root=None):
    #    return hmc_xilinx_v7(blk, plat , hdl_root)

    def instantiate_hmcc(self, top, num=None):
        
        hmcc = top.get_instance(name=self.fullname, entity='hmc', comment=self.fullname)
        #import IPython
        #IPython.embed()
        hmcc.add_port('USER_CLK', 'sys_clk', dir='in')
        hmcc.add_port('USER_RST', 'sys_rst', dir='in')
        hmcc.add_port('SDA_OUT', 'mez%s_sda_out' % self.mez, dir='out')
        hmcc.add_port('SCL_OUT', 'mez%s_scl_out' % self.mez, dir='out')
        hmcc.add_port('SDA_IN',  'mez%s_sda_in' % self.mez, dir='in')
        hmcc.add_port('SCL_IN',  'mez%s_scl_in' % self.mez, dir='in')
        hmcc.add_port('INIT_DONE', 'mez%s_init_done' % self.mez, dir='out')
        hmcc.add_port('HMC_MEZZ_RESET', 'MEZZANINE_%s_RESET' % self.mez, parent_port=True, dir='out')
        hmcc.add_port('MEZZ_CLK_SEL', 'MEZZANINE_%s_CLK_SEL' % self.mez, parent_port=True, dir='out')
        hmcc.add_port('PHY11_LANE_RX_P', 'MEZ%s_PHY11_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY11_LANE_RX_N', 'MEZ%s_PHY11_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY11_LANE_TX_P', 'MEZ%s_PHY11_LANE_TX_P' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('PHY11_LANE_TX_N', 'MEZ%s_PHY11_LANE_TX_N' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('PHY12_LANE_RX_P', 'MEZ%s_PHY12_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY12_LANE_RX_N', 'MEZ%s_PHY12_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY12_LANE_TX_P', 'MEZ%s_PHY12_LANE_TX_P' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('PHY12_LANE_TX_N', 'MEZ%s_PHY12_LANE_TX_N' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('PHY21_LANE_RX_P', 'MEZ%s_PHY21_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY21_LANE_RX_N', 'MEZ%s_PHY21_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY21_LANE_TX_P', 'MEZ%s_PHY21_LANE_TX_P' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('PHY21_LANE_TX_N', 'MEZ%s_PHY21_LANE_TX_N' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('PHY22_LANE_RX_P', 'MEZ%s_PHY22_LANE_RX_P' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY22_LANE_RX_N', 'MEZ%s_PHY22_LANE_RX_N' % self.mez, parent_port=True, dir='in', width=4)
        hmcc.add_port('PHY22_LANE_TX_P', 'MEZ%s_PHY22_LANE_TX_P' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('PHY22_LANE_TX_N', 'MEZ%s_PHY22_LANE_TX_N' % self.mez, parent_port=True, dir='out', width=4)
        hmcc.add_port('REFCLK_PAD_N_IN_0_LINK2', 'MEZ%s_REFCLK_2_N' % self.mez, parent_port=True,  dir='in')
        hmcc.add_port('REFCLK_PAD_P_IN_0_LINK2', 'MEZ%s_REFCLK_2_P' % self.mez, parent_port=True,  dir='in')
        hmcc.add_port('REFCLK_PAD_N_IN_1_LINK2', 'MEZ%s_REFCLK_3_N' % self.mez, parent_port=True,  dir='in')
        hmcc.add_port('REFCLK_PAD_P_IN_1_LINK2', 'MEZ%s_REFCLK_3_P' % self.mez, parent_port=True,  dir='in')
        hmcc.add_port('REFCLK_PAD_N_IN_0_LINK3', 'MEZ%s_REFCLK_0_N' % self.mez, parent_port=True,  dir='in')
        hmcc.add_port('REFCLK_PAD_P_IN_0_LINK3', 'MEZ%s_REFCLK_0_P' % self.mez, parent_port=True,  dir='in')
        hmcc.add_port('REFCLK_PAD_N_IN_1_LINK3', 'MEZ%s_REFCLK_1_N' % self.mez, parent_port=True,  dir='in')
        hmcc.add_port('REFCLK_PAD_P_IN_1_LINK3', 'MEZ%s_REFCLK_1_P' % self.mez, parent_port=True,  dir='in')


        # Simulink ports

        hmcc.add_port('RD_REQ', '%s_rd_en' % self.fullname, dir='in')
        hmcc.add_port('WR_REQ', '%s_wr_en' % self.fullname, dir='in')
        hmcc.add_port('WR_ADDRESS', '%s_wr_address' % self.fullname, dir='in', width=27)
        hmcc.add_port('DATA_IN', '%s_data_in' % self.fullname, dir='in', width=256)
        hmcc.add_port('RD_ADDRESS', '%s_rd_address' % self.fullname, dir='in', width=27)
        hmcc.add_port('DATA_OUT', '%s_data_out' % self.fullname, dir='out', width=256)
        hmcc.add_port('TAG_OUT', '%s_rd_tag_out' % self.fullname, dir='out', width=9)
        hmcc.add_port('TAG_IN', '%s_rd_tag_in' % self.fullname, dir='in', width=9)
        hmcc.add_port('DATA_VALID', '%s_data_valid' % self.fullname, dir='out')
        hmcc.add_port('POST_OK', '%s_post_ok' % self.fullname, dir='out')
        hmcc.add_port('RD_READY', '%s_rd_ready' % self.fullname, dir='out')
        hmcc.assign_signal('mez%s_init_done' % self.mez, '%s_init_done' % self.name)
        hmcc.add_port('WR_READY', '%s_wr_ready' % self.fullname, dir='out')


    #----------------------------------------------------------------------------------------------------

        
        # Wishbone memory for status registers / ARP table
        #hmcc.add_wb_interface(self.unique_name, mode='rw', nbytes=0x4000) # as in matlab code

    def initialize(self):

        self.add_source('hmc')


    def modify_top(self,top):

        self.instantiate_hmcc(top)

    def gen_constraints(self):
        #import IPython
        #IPython.embed()
        cons = []
        cons.append(PortConstraint('MEZZANINE_%s_RESET' % self.mez,'MEZZANINE_%s_RESET' % self.mez))
        cons.append(PortConstraint('MEZZANINE_%s_CLK_SEL' % self.mez, 'MEZZANINE_%s_CLK_SEL' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_0_P' % self.mez, 'MEZ%s_REFCLK_0_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_1_P' % self.mez, 'MEZ%s_REFCLK_1_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_2_P' % self.mez, 'MEZ%s_REFCLK_2_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_3_P' % self.mez, 'MEZ%s_REFCLK_3_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_PHY11_LANE_TX_P' % self.mez, 'MEZ%s_PHY11_LANE_TX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY11_LANE_TX_N' % self.mez, 'MEZ%s_PHY11_LANE_TX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY12_LANE_TX_P' % self.mez, 'MEZ%s_PHY12_LANE_TX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY12_LANE_TX_N' % self.mez, 'MEZ%s_PHY12_LANE_TX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY21_LANE_TX_P' % self.mez, 'MEZ%s_PHY21_LANE_TX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY21_LANE_TX_N' % self.mez, 'MEZ%s_PHY21_LANE_TX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY22_LANE_TX_P' % self.mez, 'MEZ%s_PHY22_LANE_TX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY22_LANE_TX_N' % self.mez, 'MEZ%s_PHY22_LANE_TX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY11_LANE_RX_P' % self.mez, 'MEZ%s_PHY11_LANE_RX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY11_LANE_RX_N' % self.mez, 'MEZ%s_PHY11_LANE_RX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY12_LANE_RX_P' % self.mez, 'MEZ%s_PHY12_LANE_RX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY12_LANE_RX_N' % self.mez, 'MEZ%s_PHY12_LANE_RX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY21_LANE_RX_P' % self.mez, 'MEZ%s_PHY21_LANE_RX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY21_LANE_RX_N' % self.mez, 'MEZ%s_PHY21_LANE_RX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY22_LANE_RX_P' % self.mez, 'MEZ%s_PHY22_LANE_RX_P' % self.mez, port_index=range(4), iogroup_index=range(4)))
        cons.append(PortConstraint('MEZ%s_PHY22_LANE_RX_N' % self.mez, 'MEZ%s_PHY22_LANE_RX_N' % self.mez, port_index=range(4), iogroup_index=range(4)))


        # *******************************************************************************************************
        # HMC Link2 Timing Constraints
        # *******************************************************************************************************

        # GTH Tx Clock Constraints (This clock is the reference clock for the TX side of all 8 GTHs)
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/TXOUTCLK]'))
        
        # GTH Rx Clock Constraints (Rx clock phase is unique for each receiver => generate a constraint for each GTH)
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gthe2_i/RXOUTCLK]'))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Tx to Rx clock
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i]'))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Rx to Tx clock
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        
        # cut paths between GTH Rx Clocks and sys_clk (GTH RX clock to sysclk)
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_1]'))

        # cut paths between GTH Rx Clocks and sys_clk (sysclk to GTH RX clock)
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_1] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i]'))


        # *******************************************************************************************************
        # HMC Link3 Timing Constraints
        # *******************************************************************************************************

        # GTH Tx Clock Constraints (This clock is the reference clock for the TX side of all 8 GTHs)
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/TXOUTCLK]'))
        
        # GTH Rx Clock Constraints (Rx clock phase is unique for each receiver => generate a constraint for each GTH)
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gthe2_i/RXOUTCLK]'))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Tx to Rx clock
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i]'))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Rx to Tx clock
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))

        # cut paths between GTH Rx Clocks and sys_clk
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks  '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks clkout0_2]'))

        # cut paths between GTH Rx Clocks and sys_clk (sysclk to GTH RX clock)
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks clkout0_2] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i]'))


        cons.append(RawConstraint('set_false_path -from [get_pins {'+self.fullname+'/hmc_ska_sa_top_link?_inst/openhmc_top_inst/tx_link_I/tx_crc_combine_I.scrambler_I/data_rdy_flit_?_???/C}] -to [get_pins {'+self.fullname+'/hmc_ska_sa_top_link?_inst/openhmc_top_inst/tx_link_I/scrambler_gen[?].scrambler_I/run_length_limiter_I/rf_bit_flip/CE}]'))
        cons.append(RawConstraint('set_false_path -from [get_pins {'+self.fullname+'/hmc_ska_sa_top_link?_inst/openhmc_top_inst/tx_link_I/scrambler_gen[?].scrambler_I/lfsr_?/C}] -to [get_pins {'+self.fullname+'/hmc_ska_sa_top_link?_inst/openhmc_top_inst/tx_link_I/scrambler_gen[?].scrambler_I/run_length_limiter_I/rf_bit_flip/CE}]'))
        cons.append(RawConstraint('set_false_path -from [get_pins {'+self.fullname+'/hmc_ska_sa_top_link?_inst/openhmc_top_inst/tx_link_I/scrambler_gen[?].scrambler_I/lfsr_??/C}] -to [get_pins {'+self.fullname+'/hmc_ska_sa_top_link?_inst/openhmc_top_inst/tx_link_I/scrambler_gen[?].scrambler_I/run_length_limiter_I/rf_bit_flip/CE}]'))


        cons.append(RawConstraint('set_false_path -from [get_cells -hierarchical -filter {NAME =~ '+self.fullname+'/hmc_ska_sa_top_link3_inst/openhmc_top_inst/tx_link_I/*}] -to [get_cells -hierarchical -filter {NAME =~ *run_length_limiter_I/rf_bit_flip*}]'))
        return cons
