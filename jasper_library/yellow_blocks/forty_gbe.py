from yellow_block import YellowBlock
from constraints import PortConstraint, ClockConstraint, RawConstraint
from itertools import count

class forty_gbe(YellowBlock):
    #@staticmethod
    #def factory(blk, plat, hdl_root=None):
    #    return forty_gbe_xilinx_v7(blk, plat, hdl_root)

    def instantiate_fgbe(self, top, num=None):
        fgbe = top.get_instance(name=self.fullname, entity='skarab_infr', comment=self.fullname)
        fgbe.add_parameter('FABRIC_MAC', "48'h%x"%self.fab_mac)
        fgbe.add_parameter('FABRIC_IP', "32'h%x"%self.fab_ip)
        fgbe.add_parameter('FABRIC_PORT', self.fab_udp)
        fgbe.add_parameter('FABRIC_GATEWAY', "8'h%x"%self.fab_gate)
        fgbe.add_parameter('FABRIC_ENABLE', int(self.fab_en))
        fgbe.add_parameter('LARGE_PACKETS', int(self.large_frames))
        fgbe.add_parameter('RX_DIST_RAM', int(self.rx_dist_ram))
        fgbe.add_parameter('CPU_RX_ENABLE', int(self.cpu_rx_en))
        fgbe.add_parameter('CPU_TX_ENABLE', int(self.cpu_tx_en))
        fgbe.add_parameter('TTL', self.ttl)

        # PHY CONF interface
        fgbe.add_port('mgt_txpostemphasis', 'mgt_txpostemphasis%d'%(self.port), width=5)
        fgbe.add_port('mgt_txpreemphasis', 'mgt_txpreemphasis%d'%(self.port), width=4)
        fgbe.add_port('mgt_txdiffctrl', 'mgt_txdiffctrl%d'%(self.port), width=4)
        fgbe.add_port('mgt_rxeqmix', 'mgt_rxeqmix%d'%(self.port), width=3)

        # XGMII interface
        if num is None:
            fgbe.add_port('xaui_clk', 'xaui_clk')
        else:
            fgbe.add_port('xaui_clk', 'core_clk_156_%d'%num)
        fgbe.add_port('xaui_reset', 'sys_reset', parent_sig=False)
        fgbe.add_port('xgmii_txd', 'xgmii_txd%d'%self.port, width=64)
        fgbe.add_port('xgmii_txc', 'xgmii_txc%d'%self.port, width=8)
        fgbe.add_port('xgmii_rxd', 'xgmii_rxd%d'%self.port, width=64)
        fgbe.add_port('xgmii_rxc', 'xgmii_rxc%d'%self.port, width=8)

        # XAUI CONF interface
        fgbe.add_port('xaui_status', 'xaui_status%d'%self.port, width=8)

        fgbe.add_port('clk', 'user_clk', parent_port=True, parent_sig=True, dir='in')

        # Simulink ports
        fgbe.add_port('rst', '%s_rst'%self.fullname)
        # tx
        fgbe.add_port('tx_valid       ', '%s_tx_valid'%self.fullname)
        fgbe.add_port('tx_afull       ', '%s_tx_afull'%self.fullname)
        fgbe.add_port('tx_overflow    ', '%s_tx_overflow'%self.fullname)
        fgbe.add_port('tx_end_of_frame', '%s_tx_end_of_frame'%self.fullname)
        fgbe.add_port('tx_data        ', '%s_tx_data'%self.fullname, width=64)
        fgbe.add_port('tx_dest_ip     ', '%s_tx_dest_ip'%self.fullname, width=32)
        fgbe.add_port('tx_dest_port   ', '%s_tx_dest_port'%self.fullname, width=16)
        # rx
        fgbe.add_port('rx_valid', '%s_rx_valid'%self.fullname)
        fgbe.add_port('rx_end_of_frame', '%s_rx_end_of_frame'%self.fullname)
        fgbe.add_port('rx_data',         '%s_rx_data'%self.fullname, width=64)
        fgbe.add_port('rx_source_ip',    '%s_rx_source_ip'%self.fullname, width=32)
        fgbe.add_port('rx_source_port',  '%s_rx_source_port'%self.fullname, width=16)
        fgbe.add_port('rx_bad_frame',    '%s_rx_bad_frame'%self.fullname)
        fgbe.add_port('rx_overrun',      '%s_rx_overrun'%self.fullname)
        fgbe.add_port('rx_overrun_ack',  '%s_rx_overrun_ack'%self.fullname)
        fgbe.add_port('rx_ack', '%s_rx_ack'%self.fullname)

        # Status LEDs
        fgbe.add_port('led_up', '%s_led_up'%self.fullname)
        fgbe.add_port('led_rx', '%s_led_rx'%self.fullname)
        fgbe.add_port('led_tx', '%s_led_tx'%self.fullname)

        # Wishbone memory for status registers / ARP table
        fgbe.add_wb_interface(self.unique_name, mode='rw', nbytes=0x4000) # as in matlab code
        inst = top.get_instance('skarab_infr', 'skarab_infr_inst')
        inst.add_port('sys_clk_buf_n', 'sys_clk_n', parent_port=True, dir='in')
        inst.add_port('sys_clk_buf_p', 'sys_clk_p', parent_port=True, dir='in')
        inst.add_port('FPGA_RESET_N', 'FPGA_RESET_N', parent_port=True, dir='in')
        inst.add_port('FPGA_REFCLK_BUF0_P', 'FPGA_REFCLK_BUF0_P', parent_port=True, dir='in')
        inst.add_port('FPGA_REFCLK_BUF0_N', 'FPGA_REFCLK_BUF0_N', parent_port=True, dir='in')
        inst.add_port('FPGA_REFCLK_BUF1_P', 'FPGA_REFCLK_BUF1_P', parent_port=True, dir='in')
        inst.add_port('FPGA_REFCLK_BUF1_N', 'FPGA_REFCLK_BUF1_N', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('MEZ_REFCLK_0_P', 'MEZ_REFCLK_0_P', parent_port=True, dir='in')
        inst.add_port('MEZ_REFCLK_0_N', 'MEZ_REFCLK_0_N', parent_port=True, dir='in')
        inst.add_port('MEZ_PHY11_LANE_RX_P', 'MEZ_PHY11_LANE_RX_P', parent_port=True, dir='in')
        inst.add_port('MEZ_PHY11_LANE_RX_N', 'MEZ_PHY11_LANE_RX_N', parent_port=True, dir='in')
        inst.add_port('MEZ_PHY11_LANE_TX_P', 'MEZ_PHY11_LANE_TX_P', parent_port=True, dir='in')
        inst.add_port('MEZ_PHY11_LANE_TX_N', 'MEZ_PHY11_LANE_TX_N', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_PRESENT_N', 'MEZZANINE_3_PRESENT_N', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_ENABLE_N', 'MEZZANINE_3_ENABLE_N', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_RESET', 'MEZZANINE_3_RESET', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_FAULT_N', 'MEZZANINE_3_FAULT_N', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_ONE_WIRE', 'MEZZANINE_3_ONE_WIRE', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_ONE_WIRE_STRONG_PULLUP_EN_N', 'MEZZANINE_3_ONE_WIRE_STRONG_PULLUP_EN_N', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_CLK_SEL', 'MEZZANINE_3_CLK_SEL', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_SCL_FPGA', 'MEZZANINE_3_SCL_FPGA', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_SDA_FPGA', 'MEZZANINE_3_SDA_FPGA', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_3_INT_N', 'MEZZANINE_3_INT_N', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_SGMII_TX_P', 'ONE_GBE_SGMII_TX_P', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_SGMII_TX_N', 'ONE_GBE_SGMII_TX_N', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_SGMII_RX_P', 'ONE_GBE_SGMII_RX_P', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_SGMII_RX_N', 'ONE_GBE_SGMII_RX_N', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_MGTREFCLK_P', 'ONE_GBE_MGTREFCLK_P', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_MGTREFCLK_N', 'ONE_GBE_MGTREFCLK_N', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_RESET_N', 'ONE_GBE_RESET_N', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_INT_N', 'ONE_GBE_INT_N', parent_port=True, dir='in')
        inst.add_port('ONE_GBE_LINK', 'ONE_GBE_LINK', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('ONE_WIRE_EEPROM', 'ONE_WIRE_EEPROM', parent_port=True, dir='in')
        inst.add_port('ONE_WIRE_EEPROM_STRONG_PULLUP_EN_N', 'ONE_WIRE_EEPROM_STRONG_PULLUP_EN_N', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('I2C_SCL_FPGA', 'I2C_SCL_FPGA', parent_port=True, dir='in')
        inst.add_port('I2C_SDA_FPGA', 'I2C_SDA_FPGA', parent_port=True, dir='in')
        inst.add_port('I2C_RESET_FPGA', 'I2C_RESET_FPGA', parent_port=True, dir='in')
        inst.add_port('FAN_CONT_RST_N', 'FAN_CONT_RST_N', parent_port=True, dir='in')
        inst.add_port('FAN_CONT_ALERT_N', 'FAN_CONT_ALERT_N', parent_port=True, dir='in')
        inst.add_port('FAN_CONT_FAULT_N', 'FAN_CONT_FAULT_N', parent_port=True, dir='in')
        inst.add_port('MONITOR_ALERT_N', 'MONITOR_ALERT_N', parent_port=True, dir='in')
        inst.add_port('MEZZANINE_COMBINED_FAULT', 'MEZZANINE_COMBINED_FAULT', parent_port=True, dir='in')
        inst.add_port('FPGA_ATX_PSU_KILL', 'FPGA_ATX_PSU_KILL', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('USB_FPGA', 'USB_FPGA', parent_port=True, dir='in')
        inst.add_port('USB_I2C_CTRL', 'USB_I2C_CTRL', parent_port=True, dir='in')
        inst.add_port('USB_UART_RXD', 'USB_UART_RXD', parent_port=True, dir='in')
        inst.add_port('USB_UART_TXD', 'USB_UART_TXD', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('PCIE_RST_N', 'PCIE_RST_N', parent_port=True, dir='in')
        inst.add_port('CPU_PWR_BTN_N', 'CPU_PWR_BTN_N', parent_port=True, dir='in')
        inst.add_port('CPU_PWR_OK', 'CPU_PWR_OK', parent_port=True, dir='in')
        inst.add_port('CPU_SYS_RESET_N', 'CPU_SYS_RESET_N', parent_port=True, dir='in')
        inst.add_port('CPU_SUS_S3_N', 'CPU_SUS_S3_N', parent_port=True, dir='in')
        inst.add_port('CPU_SUS_S4_N', 'CPU_SUS_S4_N', parent_port=True, dir='in')
        inst.add_port('CPU_SUS_S5_N', 'CPU_SUS_S5_N', parent_port=True, dir='in')
        inst.add_port('CPU_SUS_STAT_N', 'CPU_SUS_STAT_N', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('EMCCLK', 'EMCCLK', parent_port=True, dir='in')
        inst.add_port('FPGA_EMCCLK2', 'FPGA_EMCCLK2', parent_port=True, dir='in')
        inst.add_port('FLASH_DQ', 'FLASH_DQ', parent_port=True, dir='in')
        inst.add_port('FLASH_A', 'FLASH_A', parent_port=True, dir='in')
        inst.add_port('FLASH_CS_N', 'FLASH_CS_N', parent_port=True, dir='in')
        inst.add_port('FLASH_OE_N', 'FLASH_OE_N', parent_port=True, dir='in')
        inst.add_port('FLASH_WE_N', 'FLASH_WE_N', parent_port=True, dir='in')
        inst.add_port('FLASH_ADV_N', 'FLASH_ADV_N', parent_port=True, dir='in')
        inst.add_port('FLASH_RS0', 'FLASH_RS0', parent_port=True, dir='in')
        inst.add_port('FLASH_RS1', 'FLASH_RS1', parent_port=True, dir='in')
        inst.add_port('FLASH_WAIT', 'FLASH_WAIT', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('SPARTAN_CLK', 'SPARTAN_CLK', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_0', 'CONFIG_IO_0', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_1', 'CONFIG_IO_1', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_2', 'CONFIG_IO_2', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_3', 'CONFIG_IO_3', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_4', 'CONFIG_IO_4', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_5', 'CONFIG_IO_5', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_6', 'CONFIG_IO_6', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_7', 'CONFIG_IO_7', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_8', 'CONFIG_IO_8', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_9', 'CONFIG_IO_9', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_10', 'CONFIG_IO_10', parent_port=True, dir='in')
        inst.add_port('CONFIG_IO_11', 'CONFIG_IO_11', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('SPI_MISO', 'SPI_MISO', parent_port=True, dir='in')
        inst.add_port('SPI_MOSI', 'SPI_MOSI', parent_port=True, dir='in')
        inst.add_port('SPI_CSB', 'SPI_CSB', parent_port=True, dir='in')
        inst.add_port('SPI_CLK', 'SPI_CLK', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('FPGA_GPIO', 'FPGA_GPIO', parent_port=True, dir='in')
        inst.add_port('DEBUG_UART_TX', 'DEBUG_UART_TX', parent_port=True, dir='in')
        inst.add_port('DEBUG_UART_RX', 'DEBUG_UART_RX', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('AUX_CLK_P', 'AUX_CLK_P', parent_port=True, dir='in')
        inst.add_port('AUX_CLK_N', 'AUX_CLK_N', parent_port=True, dir='in')
        inst.add_port('AUX_SYNCI_P', 'AUX_SYNCI_P', parent_port=True, dir='in')
        inst.add_port('AUX_SYNCI_N', 'AUX_SYNCI_N', parent_port=True, dir='in')
        inst.add_port('AUX_SYNCO_P', 'AUX_SYNCO_P', parent_port=True, dir='in')
        inst.add_port('AUX_SYNCO_N', 'AUX_SYNCO_N', parent_port=True, dir='in')
        inst.add_port('', '', parent_port=True, dir='in')
        inst.add_port('EMCCLK_FIX', 'EMCCLK_FIX', parent_port=True, dir='in')
        fgbe.add_port('foobar', 'foobar', width=32)

#class forty_gbe_xilinx_v7(forty_gbe):
    def initialize(self):
        self.add_source('skarab_infr')

        #roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
        if self.flavour == 'cx4':
            self.port = self.port_r2_cx4 + 4*((self.slot+1)%2) 
        elif self.flavour == 'sfp+':
            self.port = self.port_r2_sfpp + 4*((self.slot+1)%2)

        self.exc_requirements = ['fgbe%d'%self.port]


    def modify_top(self,top):

        self.instantiate_fgbe(top)

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
