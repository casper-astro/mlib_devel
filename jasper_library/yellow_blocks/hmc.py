import logging
from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, ClockGroupConstraint, MultiCycleConstraint, \
    OutputDelayConstraint, RawConstraint

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
        hmcc.add_port('HMC_CLK', 'hmc_clk', dir='in')
        hmcc.add_port('HMC_RST', 'hmc_rst', dir='in')
        hmcc.add_port('SDA_OUT', 'mez%s_sda_out' % self.mez, dir='out')
        hmcc.add_port('SCL_OUT', 'mez%s_scl_out' % self.mez, dir='out')
        hmcc.add_port('SDA_IN',  'mez%s_sda_in' % self.mez, dir='in')
        hmcc.add_port('SCL_IN',  'mez%s_scl_in' % self.mez, dir='in')
        hmcc.add_port('INIT_DONE', '%s_init_done' % self.fullname, dir='out')
        hmcc.add_port('MEZZ_ID', 'mez%s_id' % self.mez, dir='out', width=3)
        hmcc.add_port('MEZZ_PRESENT', 'mez%s_present' % self.mez, dir='out')
        hmcc.add_port('POST_OK', '%s_post_ok' % self.fullname, dir='out')

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


        # Simulink ports Link2

        hmcc.add_port('RD_REQ_LINK2', '%s_rd_en_link2' % self.fullname, dir='in')
        hmcc.add_port('WR_REQ_LINK2', '%s_wr_en_link2' % self.fullname, dir='in')
        hmcc.add_port('WR_ADDRESS_LINK2', '%s_wr_address_link2' % self.fullname, dir='in', width=27)
        hmcc.add_port('DATA_IN_LINK2', '%s_data_in_link2' % self.fullname, dir='in', width=256)
        hmcc.add_port('RD_ADDRESS_LINK2', '%s_rd_address_link2' % self.fullname, dir='in', width=27)
        hmcc.add_port('DATA_OUT_LINK2', '%s_data_out_link2' % self.fullname, dir='out', width=256)
        hmcc.add_port('TAG_OUT_LINK2', '%s_rd_tag_out_link2' % self.fullname, dir='out', width=9)
        hmcc.add_port('TAG_IN_LINK2', '%s_rd_tag_in_link2' % self.fullname, dir='in', width=9)
        hmcc.add_port('DATA_VALID_LINK2', '%s_data_valid_link2' % self.fullname, dir='out')
        hmcc.add_port('RD_READY_LINK2', '%s_rd_ready_link2' % self.fullname, dir='out')
        hmcc.add_port('WR_READY_LINK2', '%s_wr_ready_link2' % self.fullname, dir='out')
        hmcc.add_port('RX_CRC_ERR_CNT_LINK2', '%s_rx_crc_err_cnt_link2' % self.fullname, dir='out', width=16)
        hmcc.add_port('ERRSTAT_LINK2', '%s_errstat_link2' % self.fullname, dir='out', width=7)


        # Simulink ports Link3

        hmcc.add_port('RD_REQ_LINK3', '%s_rd_en_link3' % self.fullname, dir='in')
        hmcc.add_port('WR_REQ_LINK3', '%s_wr_en_link3' % self.fullname, dir='in')
        hmcc.add_port('WR_ADDRESS_LINK3', '%s_wr_address_link3' % self.fullname, dir='in', width=27)
        hmcc.add_port('DATA_IN_LINK3', '%s_data_in_link3' % self.fullname, dir='in', width=256)
        hmcc.add_port('RD_ADDRESS_LINK3', '%s_rd_address_link3' % self.fullname, dir='in', width=27)
        hmcc.add_port('DATA_OUT_LINK3', '%s_data_out_link3' % self.fullname, dir='out', width=256)
        hmcc.add_port('TAG_OUT_LINK3', '%s_rd_tag_out_link3' % self.fullname, dir='out', width=9)
        hmcc.add_port('TAG_IN_LINK3', '%s_rd_tag_in_link3' % self.fullname, dir='in', width=9)
        hmcc.add_port('DATA_VALID_LINK3', '%s_data_valid_link3' % self.fullname, dir='out')
        hmcc.add_port('RD_READY_LINK3', '%s_rd_ready_link3' % self.fullname, dir='out')
        hmcc.add_port('WR_READY_LINK3', '%s_wr_ready_link3' % self.fullname, dir='out')
        hmcc.add_port('RX_CRC_ERR_CNT_LINK3', '%s_rx_crc_err_cnt_link3' % self.fullname, dir='out', width=16)
        hmcc.add_port('ERRSTAT_LINK3', '%s_errstat_link3' % self.fullname, dir='out', width=7)


    #----------------------------------------------------------------------------------------------------

        
        # Wishbone memory for status registers / ARP table
        #hmcc.add_wb_interface(self.unique_name, mode='rw', nbytes=0x4000) # as in matlab code

    def initialize(self):

        self.add_source('hmc/src/*.v')
        self.add_source('hmc/src/*.vhd')
        self.add_source('hmc/src/*.ngc')
        self.add_source("hmc/src/hmc_user_axi_fifo/*.xci")
        self.add_source('hmc/open_hmc')
        # This block takes a mezzanine site and should prevent other blocks from using it
        self.exc_requires = ['mezz%d' % self.mez]

    def modify_top(self,top):

        self.instantiate_hmcc(top)
        top.assign_signal('mez%s_init_done' % self.mez, '%s_init_done' % self.fullname)
        top.assign_signal('mez%s_post_ok' % self.mez, '%s_post_ok' % self.fullname)

    def gen_constraints(self):
        cons = []

        cons.append(PortConstraint('MEZZANINE_%s_RESET' % self.mez,'MEZZANINE_%s_RESET' % self.mez))
        cons.append(PortConstraint('MEZZANINE_%s_CLK_SEL' % self.mez, 'MEZZANINE_%s_CLK_SEL' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_0_P' % self.mez, 'MEZ%s_REFCLK_0_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_0_N' % self.mez, 'MEZ%s_REFCLK_0_N' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_1_P' % self.mez, 'MEZ%s_REFCLK_1_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_1_N' % self.mez, 'MEZ%s_REFCLK_1_N' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_2_P' % self.mez, 'MEZ%s_REFCLK_2_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_2_N' % self.mez, 'MEZ%s_REFCLK_2_N' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_3_P' % self.mez, 'MEZ%s_REFCLK_3_P' % self.mez))
        cons.append(PortConstraint('MEZ%s_REFCLK_3_N' % self.mez, 'MEZ%s_REFCLK_3_N' % self.mez))
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

        # GTH Clock Constraints
        #cons.append(RawConstraint('create_clock -period 6.400 -waveform {0.000 3.200} [get_ports MEZ%s_REFCLK_0_P]' % self.mez))
        cons.append(ClockConstraint('MEZ%s_REFCLK_0_P' % self.mez,'MEZ%s_REFCLK_0_P' % self.mez, period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2))
        #cons.append(RawConstraint('create_clock -period 6.400 -waveform {0.000 3.200} [get_ports MEZ%s_REFCLK_1_P]' % self.mez))
        cons.append(ClockConstraint('MEZ%s_REFCLK_1_P' % self.mez,'MEZ%s_REFCLK_1_P' % self.mez, period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2))
        #cons.append(RawConstraint('create_clock -period 6.400 -waveform {0.000 3.200} [get_ports MEZ%s_REFCLK_2_P]' % self.mez))
        cons.append(ClockConstraint('MEZ%s_REFCLK_2_P' % self.mez,'MEZ%s_REFCLK_2_P' % self.mez, period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2))
        #cons.append(RawConstraint('create_clock -period 6.400 -waveform {0.000 3.200} [get_ports MEZ%s_REFCLK_3_P]' % self.mez))
        cons.append(ClockConstraint('MEZ%s_REFCLK_3_P' % self.mez,'MEZ%s_REFCLK_3_P' % self.mez, period=6.4, port_en=True, virtual_en=False, waveform_min=0.0, waveform_max=3.2))


        # *******************************************************************************************************
        # HMC Link2 Timing Constraints
        # *******************************************************************************************************

        # GTH Tx Clock Constraints (This clock is the reference clock for the TX side of all 8 GTHs)
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/TXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/TXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False,  waveform_min=0.0, waveform_max=1.6))

        # GTH Rx Clock Constraints (Rx clock phase is unique for each receiver => generate a constraint for each GTH)
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Rx to Tx clock
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Tx to Rx clock
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))

        #Cut paths between GTH Tx Clock and HMC Static Clock (forty_gbe)
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]','asynchronous'))

        #Cut paths between HMC Static Clock (forty_gbe) and GTH Tx Clock
        cons.append(ClockGroupConstraint(' -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', '-include_generated_clocks %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, 'asynchronous'))

        #Cut paths between HMC and forty_gbe clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, '-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]','asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, '-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]','asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]', '-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between HMC Link 2 and Link 3 clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, '-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between SYS_CLK_MMCM_inst/CLKOUT0 and HMC Link 2 clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', '-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between VIRTUAL_clkout0_1 and HMC Link 2 clocks
        cons.append(ClockGroupConstraint('VIRTUAL_clkout0_1', '-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between VIRTUAL_I and HMC Link 2 clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, 'VIRTUAL_I','asynchronous'))
        cons.append(ClockGroupConstraint('VIRTUAL_I', '-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))


        # *******************************************************************************************************
        # HMC Link3 Timing Constraints
        # *******************************************************************************************************

        # GTH Tx Clock Constraints (This clock is the reference clock for the TX side of all 8 GTHs)
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/TXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/TXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))

        # GTH Rx Clock Constraints (Rx clock phase is unique for each receiver => generate a constraint for each GTH)
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))
        #cons.append(RawConstraint('create_clock -period 3.200 -name '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i -waveform {0.000 1.600} [get_pins '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gthe2_i/RXOUTCLK]'))
        cons.append(ClockConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gthe2_i/RXOUTCLK'% self.fullname,'%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, period=3.2, port_en=False, virtual_en=False, waveform_min=0.0, waveform_max=1.6))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Rx to Tx clock
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i] -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i]'))
        cons.append(ClockGroupConstraint('%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i' % self.fullname, '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname,'asynchronous'))

        # cut paths between GTH Tx Clock and GTH Rx Clocks (async fifo crossing) from Tx to Rx clock
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt1_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt2_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt3_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt4_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt5_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt6_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))
        #cons.append(RawConstraint('set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i] -group [get_clocks '+self.fullname+'/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i]'))
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '%s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt7_hmc_gth_i/gt0_rxoutclk_i' % self.fullname,'asynchronous'))

        #Cut paths between GTH Tx Clock and HMC Static Clock (forty_gbe)
        cons.append(ClockGroupConstraint('-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, '-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]','asynchronous'))

        #Cut paths between HMC Static Clock (forty_gbe) and GTH Tx Clock
        cons.append(ClockGroupConstraint('-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', '-include_generated_clocks %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/gt0_txoutclk_i' % self.fullname, 'asynchronous'))

        #Cut paths between HMC and forty_gbe clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, '-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]','asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', '-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, '-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]','asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT1]', '-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between HMC Link 3 and HMC Link 2 clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, '-of_objects [get_pins %s/hmc_ska_sa_top_link2_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between SYS_CLK_MMCM_inst/CLKOUT0 and HMC Link 3 clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', '-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between VIRTUAL_clkout0_1 and HMC Link 3 clocks
        cons.append(ClockGroupConstraint('VIRTUAL_clkout0_1', '-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))

        #Cut paths between VIRTUAL_I and HMC Link 2 clocks
        cons.append(ClockGroupConstraint('-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname, 'VIRTUAL_I','asynchronous'))
        cons.append(ClockGroupConstraint('VIRTUAL_I', '-of_objects [get_pins %s/hmc_ska_sa_top_link3_inst/hmc_gth_inst/txoutclk_mmcm0_inst/mmcm_adv_inst/CLKOUT0]' % self.fullname,'asynchronous'))


        #Timing Constraints
        #Output Constraints
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', consttype='min', constdelay_ns=1.0, add_delay_en=True, portname='MEZZANINE_%s_RESET' % self.mez))
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', consttype='max', constdelay_ns=2.0, add_delay_en=True, portname='MEZZANINE_%s_RESET' % self.mez))
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='min', constdelay_ns=1.0, add_delay_en=True, portname='MEZZANINE_%s_RESET' % self.mez))
        cons.append(OutputDelayConstraint(clkname='-of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', consttype='max', constdelay_ns=2.0, add_delay_en=True, portname='MEZZANINE_%s_RESET' % self.mez))

        #multi-cycle constraints
        cons.append(MultiCycleConstraint(multicycletype='setup',sourcepath='get_clocks -of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', destpath='get_ports MEZZANINE_%s_RESET' % self.mez, multicycledelay=4))
        cons.append(MultiCycleConstraint(multicycletype='hold',sourcepath='get_clocks -of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', destpath='get_ports MEZZANINE_%s_RESET' % self.mez, multicycledelay=3))
        cons.append(MultiCycleConstraint(multicycletype='setup',sourcepath='get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', destpath='get_ports MEZZANINE_%s_RESET' % self.mez, multicycledelay=4))
        cons.append(MultiCycleConstraint(multicycletype='hold',sourcepath='get_clocks -of_objects [get_pins */SYS_CLK_MMCM_inst/CLKOUT0]', destpath='get_ports MEZZANINE_%s_RESET' % self.mez, multicycledelay=3))

        cons.append(ClockGroupConstraint('VIRTUAL_clkout0_1', '-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]', 'asynchronous'))
        cons.append(ClockGroupConstraint('-of_objects [get_pins */USER_CLK_MMCM_inst/CLKOUT0]' ,'VIRTUAL_clkout0_1', 'asynchronous'))


        #Placement constraints
        #Link 2
        cons.append(RawConstraint('create_pblock MEZ%s_HMC_LINK2' % self.mez))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_HMC_LINK2]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/flit_gen_link2_inst]]'))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_HMC_LINK2]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/flit_gen_user_link2_inst]]'))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_HMC_LINK2]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/hmc_ska_sa_top_link2_inst]]'))
        #Mez 0 Selected
        if self.mez == 0:
          cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_HMC_LINK2] -add {CLOCKREGION_X0Y6:CLOCKREGION_X0Y7}' % self.mez))
        #Mez 1 Selected
        elif self.mez == 1:
          cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_HMC_LINK2] -add {CLOCKREGION_X0Y2:CLOCKREGION_X0Y3}' % self.mez))
        #Mez 2 Selected
        elif self.mez == 2:
          cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_HMC_LINK2] -add {CLOCKREGION_X1Y0:CLOCKREGION_X1Y1}' % self.mez))
        else:
            self.logger.error('Invalid Mezzanine site selected for LINK 2. Placement ignored for LINK2')

        #Link 3
        cons.append(RawConstraint('create_pblock MEZ%s_HMC_LINK3' % self.mez))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_HMC_LINK3]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/flit_gen_link3_inst]]'))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_HMC_LINK3]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/flit_gen_user_link3_inst]]'))
        cons.append(RawConstraint('add_cells_to_pblock [get_pblocks MEZ%s_HMC_LINK3]' % self.mez + ' [get_cells -quiet [list '+self.fullname+'/hmc_ska_sa_top_link3_inst]]'))
        #Mez 0 Selected
        if self.mez == 0:
          cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_HMC_LINK3] -add {CLOCKREGION_X0Y4:CLOCKREGION_X0Y5}' % self.mez))
        #Mez 1 Selected
        elif self.mez == 1:
          cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_HMC_LINK3] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y1}' % self.mez))
        #Mez 2 Selected
        elif self.mez == 2:
          cons.append(RawConstraint('resize_pblock [get_pblocks MEZ%s_HMC_LINK3] -add {CLOCKREGION_X1Y2:CLOCKREGION_X1Y3}' % self.mez))
        else:
            self.logger.error('Invalid Mezzanine site selected for LINK 3. Placement ignored for LINK3')

        return cons
