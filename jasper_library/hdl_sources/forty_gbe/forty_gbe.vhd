----------------------------------------------------------------------------------
-- Company: Peralex Electronics
-- Engineer: Gavin Teague
--
-- Create Date: 05.09.2014 10:19:29
-- Design Name:
-- Module Name: forty_gbe - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

use work.parameter.all;

entity forty_gbe is
    generic (
    	-- mmcm parameters
        MULTIPLY : REAL    := 6.0;
        DIVIDE   : REAL    := 6.0;
        DIVCLK   : INTEGER := 1;
        -- forty gbe specific parameters
        FABRIC_MAC        : std_logic_vector(47 downto 0);
        FABRIC_IP         : std_logic_vector(31 downto 0);
        FABRIC_PORT       : std_logic_vector(15 downto 0);
        FABRIC_NETMASK    : std_logic_vector(31 downto 0);
        FABRIC_GATEWAY    : std_logic_vector( 7 downto 0);
        FABRIC_ENABLE     : std_logic;
        TTL               : std_logic_vector( 7 downto 0);
        PROMISC_MODE      : integer;
        RX_CRC_CHK_ENABLE : integer := 0);
    port(
        user_clk_o : out std_logic;
        user_rst_o : out std_logic;
        hmc_rst_o  : out std_logic;
        hmc_clk_o  : out std_logic; 

        FPGA_RESET_N       : in std_logic;
        FPGA_REFCLK_BUF0_P : in std_logic;
        FPGA_REFCLK_BUF0_N : in std_logic;
        FPGA_REFCLK_BUF1_P : in std_logic;
        FPGA_REFCLK_BUF1_N : in std_logic;

        -- MEZZANINE GTH SIGNALS
        MEZ3_REFCLK_0_P      : in  std_logic;
        MEZ3_REFCLK_0_N      : in  std_logic;
        MEZ3_PHY11_LANE_RX_P : in  std_logic_vector(3 downto 0);
        MEZ3_PHY11_LANE_RX_N : in  std_logic_vector(3 downto 0);
        MEZ3_PHY11_LANE_TX_P : out std_logic_vector(3 downto 0);
        MEZ3_PHY11_LANE_TX_N : out std_logic_vector(3 downto 0);
        
		-- MEZZANINE 0 SIDEBAND SIGNALS
        MEZZANINE_0_PRESENT_N : in std_logic;
        MEZZANINE_0_ENABLE_N : out std_logic;
        --MEZZANINE_0_RESET : out std_logic;   --this is moved to the top.v now
        MEZZANINE_0_FAULT_N : in std_logic;
        MEZZANINE_0_ONE_WIRE : inout std_logic;
        MEZZANINE_0_ONE_WIRE_STRONG_PULLUP_EN_N : out std_logic;
        --MEZZANINE_0_CLK_SEL : out std_logic; --this is moved to the top.v now
        MEZZANINE_0_SCL_FPGA : inout std_logic;
        MEZZANINE_0_SDA_FPGA : inout std_logic;
        MEZZANINE_0_INT_N : in std_logic;
        
        -- MEZZANINE 1 SIDEBAND SIGNALS
        MEZZANINE_1_PRESENT_N : in std_logic;
        MEZZANINE_1_ENABLE_N : out std_logic;
        --MEZZANINE_1_RESET : out std_logic;   --this is moved to the top.v now
        MEZZANINE_1_FAULT_N : in std_logic;
        MEZZANINE_1_ONE_WIRE : inout std_logic;
        MEZZANINE_1_ONE_WIRE_STRONG_PULLUP_EN_N : out std_logic;
        --MEZZANINE_1_CLK_SEL : out std_logic; --this is moved to the top.v now
        MEZZANINE_1_SCL_FPGA : inout std_logic;
        MEZZANINE_1_SDA_FPGA : inout std_logic;
        MEZZANINE_1_INT_N : in std_logic;

        -- MEZZANINE 2 SIDEBAND SIGNALS
        MEZZANINE_2_PRESENT_N : in std_logic;
        MEZZANINE_2_ENABLE_N : out std_logic;
        --MEZZANINE_2_RESET : out std_logic;
        MEZZANINE_2_FAULT_N : in std_logic;
        MEZZANINE_2_ONE_WIRE : inout std_logic;
        MEZZANINE_2_ONE_WIRE_STRONG_PULLUP_EN_N : out std_logic;
        --MEZZANINE_2_CLK_SEL : out std_logic;
        MEZZANINE_2_SCL_FPGA : inout std_logic;
        MEZZANINE_2_SDA_FPGA : inout std_logic;
        MEZZANINE_2_INT_N : in std_logic;        

        -- MEZZANINE 3 SIDEBAND SIGNALS
        MEZZANINE_3_PRESENT_N : in    std_logic;
        MEZZANINE_3_ENABLE_N  : out   std_logic;
        MEZZANINE_3_RESET     : out   std_logic;
        MEZZANINE_3_FAULT_N   : in    std_logic;
        MEZZANINE_3_ONE_WIRE  : inout std_logic;
        MEZZANINE_3_ONE_WIRE_STRONG_PULLUP_EN_N : out std_logic;
        MEZZANINE_3_CLK_SEL   : out   std_logic;
        MEZZANINE_3_SCL_FPGA  : inout std_logic;
        MEZZANINE_3_SDA_FPGA  : inout std_logic;
        MEZZANINE_3_INT_N     : in    std_logic;
        
        --HMC Mezzanine 0 Signals
        HMC_MEZZ0_SCL_OUT : out std_logic;
        HMC_MEZZ0_SDA_OUT : out std_logic;
        HMC_MEZZ0_SCL_IN : in std_logic;
        HMC_MEZZ0_SDA_IN : in std_logic;
        HMC_MEZZ0_INIT_DONE : in std_logic;
        HMC_MEZZ0_POST_OK : in std_logic;        
        MEZZ0_ID : in std_logic_vector(2 downto 0);
        MEZZ0_PRESENT : in std_logic;

        --HMC Mezzanine 1 Signals
        HMC_MEZZ1_SCL_OUT : out std_logic;
        HMC_MEZZ1_SDA_OUT : out std_logic;
        HMC_MEZZ1_SCL_IN : in std_logic;
        HMC_MEZZ1_SDA_IN : in std_logic;
        HMC_MEZZ1_INIT_DONE : in std_logic;
        HMC_MEZZ1_POST_OK : in std_logic;        
        MEZZ1_ID : in std_logic_vector(2 downto 0);
        MEZZ1_PRESENT : in std_logic;        
        
        --HMC Mezzanine 2 Signals
        HMC_MEZZ2_SCL_OUT : out std_logic;
        HMC_MEZZ2_SDA_OUT : out std_logic;
        HMC_MEZZ2_SCL_IN : in std_logic;
        HMC_MEZZ2_SDA_IN : in std_logic;
        HMC_MEZZ2_INIT_DONE : in std_logic;
        HMC_MEZZ2_POST_OK : in std_logic;                
        MEZZ2_ID : in std_logic_vector(2 downto 0);
        MEZZ2_PRESENT : in std_logic;        
        
        -- 1GBE SIGNALS
        ONE_GBE_SGMII_TX_P  : out std_logic;
        ONE_GBE_SGMII_TX_N  : out std_logic;
        ONE_GBE_SGMII_RX_P  : in  std_logic;
        ONE_GBE_SGMII_RX_N  : in  std_logic;
        ONE_GBE_MGTREFCLK_P : in  std_logic;
        ONE_GBE_MGTREFCLK_N : in  std_logic;

        -- 1GBE SIDEBAND SIGNALS
        ONE_GBE_RESET_N : out std_logic;
        ONE_GBE_INT_N   : in  std_logic;
        ONE_GBE_LINK    : in  std_logic;

        -- MOTHERBOARD ONE WIRE EEPROM
        ONE_WIRE_EEPROM : inout std_logic;
        ONE_WIRE_EEPROM_STRONG_PULLUP_EN_N : out std_logic;

        -- I2C INTERFACE AND MONITORING
        I2C_SCL_FPGA             : inout std_logic;
        I2C_SDA_FPGA             : inout std_logic;
        I2C_RESET_FPGA           : out   std_logic;
        FAN_CONT_RST_N           : out   std_logic;
        FAN_CONT_ALERT_N         : in    std_logic;
        FAN_CONT_FAULT_N         : in    std_logic;
        MONITOR_ALERT_N          : in    std_logic;
        MEZZANINE_COMBINED_FAULT : out   std_logic;
        FPGA_ATX_PSU_KILL        : out   std_logic;

        -- USB INTERFACE
        USB_FPGA     : in  std_logic_vector(3 downto 0);
        USB_I2C_CTRL : in  std_logic;
        USB_UART_RXD : out std_logic;
        USB_UART_TXD : in  std_logic;

        PCIE_RST_N      : in  std_logic;
        CPU_PWR_BTN_N   : out std_logic;
        CPU_PWR_OK      : out std_logic;
        CPU_SYS_RESET_N : out std_logic;
        CPU_SUS_S3_N    : in  std_logic;
        CPU_SUS_S4_N    : in  std_logic;
        CPU_SUS_S5_N    : in  std_logic;
        CPU_SUS_STAT_N  : in  std_logic;

        -- FLASH CONFIGURATION INTERFACE
        EMCCLK       : in    std_logic;
        FPGA_EMCCLK2 : in    std_logic;
        FLASH_DQ     : inout std_logic_vector(15 downto 0);
        FLASH_A      : out   std_logic_vector(28 downto 0);
        FLASH_CS_N   : out   std_logic;
        FLASH_OE_N   : out   std_logic;
        FLASH_WE_N   : out   std_logic;
        FLASH_ADV_N  : out   std_logic;
        FLASH_RS0    : out   std_logic;
        FLASH_RS1    : out   std_logic;
        FLASH_WAIT   : in    std_logic;

        -- SPARTAN CONFIGURATION FPGA INTERFACE
        SPARTAN_CLK :  out std_logic;
        CONFIG_IO_0 :  out std_logic;
        CONFIG_IO_1 :  out std_logic;
        CONFIG_IO_2 :  in  std_logic;
        CONFIG_IO_3 :  out std_logic;
        CONFIG_IO_4 :  out std_logic;
        CONFIG_IO_5 :  in  std_logic;
        CONFIG_IO_6 :  out std_logic;
        CONFIG_IO_7 :  out std_logic;
        CONFIG_IO_8 :  out std_logic;
        CONFIG_IO_9 :  out std_logic;
        CONFIG_IO_10 : out std_logic;
        CONFIG_IO_11 : out std_logic;

        -- SPARTAN INTERNAL SPI FLASH
        SPI_MISO : in  std_logic;
        SPI_MOSI : out std_logic;
        SPI_CSB  : out std_logic;
        SPI_CLK  : out std_logic;

        -- GPIO
        DEBUG_UART_TX : out std_logic;
        DEBUG_UART_RX : in  std_logic;

        -- > Master LEDs that will be output (Front panel LEDs)
        dsp_leds_i     : in std_logic_vector(7 downto 0);
        fpga_leds_o    : out std_logic_vector(7 downto 0);
        
        -- AUX CONNECTIONS
        --AUX_CLK_P   : in  std_logic;
        --AUX_CLK_N   : in  std_logic;
        --AUX_SYNCI_P : in  std_logic;
        --AUX_SYNCI_N : in  std_logic;
        --AUX_SYNCO_P : out std_logic;
        --AUX_SYNCO_N : out std_logic;

        EMCCLK_FIX : out std_logic;
        GND        : out std_logic_vector(15 downto 0);
        
        forty_gbe_rst             : in  std_logic;
        forty_gbe_tx_valid        : in  std_logic_vector(3 downto 0);
        forty_gbe_tx_end_of_frame : in  std_logic;
        forty_gbe_tx_data         : in  std_logic_vector(255 downto 0);
        forty_gbe_tx_dest_ip      : in  std_logic_vector(31 downto 0);
        forty_gbe_tx_dest_port    : in  std_logic_vector(15 downto 0);
        forty_gbe_tx_overflow     : out std_logic;
        forty_gbe_tx_afull        : out std_logic;
        forty_gbe_rx_valid        : out std_logic_vector(3 downto 0);
        forty_gbe_rx_end_of_frame : out std_logic;
        forty_gbe_rx_data         : out std_logic_vector(255 downto 0);
        forty_gbe_rx_source_ip    : out std_logic_vector(31 downto 0);
        forty_gbe_rx_source_port  : out std_logic_vector(15 downto 0);
        forty_gbe_rx_dest_ip      : out std_logic_vector(31 downto 0);
        forty_gbe_rx_dest_port    : out std_logic_vector(15 downto 0);
        forty_gbe_rx_bad_frame    : out std_logic;
        forty_gbe_rx_overrun      : out std_logic;
        forty_gbe_rx_overrun_ack  : in  std_logic;
        forty_gbe_rx_ack          : in  std_logic;

        forty_gbe_led_tx : out std_logic;
        forty_gbe_led_rx : out std_logic;
        forty_gbe_led_up : out std_logic;

        --DSP Wishbone Arbiter Interface
        WB_SLV_CLK_I_top : out std_logic;
        WB_SLV_RST_I_top:  out std_logic;
        WB_SLV_DAT_I_top : out std_logic_vector(31 downto 0);--ST_WB_DATA;
        WB_SLV_DAT_O_top : in  std_logic_vector(31 downto 0);--ST_WB_DATA;
        WB_SLV_ACK_O_top : in  std_logic;
        WB_SLV_ADR_I_top : out std_logic_vector(31 downto 0);--ST_SLAVE_WB_ADDRESS;
        WB_SLV_CYC_I_top : out std_logic;
        WB_SLV_SEL_I_top : out std_logic_vector(3 downto 0);--ST_WB_SEL;
        WB_SLV_STB_I_top : out std_logic;
        WB_SLV_WE_I_top  : out std_logic);

end forty_gbe;

--}} End of automatically maintained section

architecture arch_forty_gbe of forty_gbe is

    constant C_IDLE_TXD : std_logic_vector(255 downto 0):= X"0707070707070707070707070707070707070707070707070707070707070707";
    constant C_IDLE_TXC : std_logic_vector(31 downto 0) := "11111111111111111111111111111111";

    component cont_microblaze_wrapper
    port (
        ACK_I       : in std_logic;
        ADR_O       : out std_logic_vector( 31 downto 0 );
        CYC_O       : out std_logic;
        Clk         : in std_logic;
        DAT_I       : in std_logic_vector( 31 downto 0 );
        DAT_O       : out std_logic_vector( 31 downto 0 );
        RST_O       : out std_logic;
        Reset       : in std_logic;
        SEL_O       : out std_logic_vector( 3 downto 0 );
        STB_O       : out std_logic;
        UART_rxd    : in std_logic;
        UART_txd    : out std_logic;
        WE_O        : out std_logic;
        dcm_locked  : in std_logic);
    end component;
    
    component mezzanine_enable_delay
    port(
        clk : in std_logic;
        rst : in std_logic;
        second_toggle                    : in std_logic;
        mezzanine_enable                 : in std_logic;
        mezzanine_fault_checking_enable  : out std_logic);
    end component;    
    
    component second_gen
    port(
        clk : in std_logic;
        rst : in std_logic;
        second_toggle : out std_logic);
    end component; 
    
    component clock_frequency_measure
    port(
        clk : in std_logic;
        rst : in std_logic;
        second_toggle   : in std_logic;
        measure_freq    : out std_logic_vector(31 downto 0));
    end component;       

    component wishbone_interconnect
    port (
        CLK_I : in std_logic;
        RST_I : in std_logic;
        MST_DAT_O : in std_logic_vector(31 downto 0);
        MST_DAT_I : out std_logic_vector(31 downto 0);
        MST_ACK_I : out std_logic;
        MST_ADR_O : in std_logic_vector((C_WB_MST_ADDRESS_BITS - 1) downto 0);
        MST_CYC_O : in std_logic;
        MST_SEL_O : in std_logic_vector(3 downto 0);
        MST_STB_O : in std_logic;
        MST_WE_O  : in std_logic;
        SLV_DAT_O : in T_SLAVE_WB_DATA;
        SLV_DAT_I : out T_SLAVE_WB_DATA;
        SLV_ACK_O : in std_logic_vector(0 to (C_WB_NUM_SLAVES - 1));
        SLV_ADR_I : out T_SLAVE_WB_ADDRESS;
        SLV_CYC_I : out std_logic_vector(0 to (C_WB_NUM_SLAVES - 1));
        SLV_SEL_I : out T_SLAVE_WB_SEL;
        SLV_STB_I : out std_logic_vector(0 to (C_WB_NUM_SLAVES - 1));
        SLV_WE_I  : out std_logic_vector(0 to (C_WB_NUM_SLAVES - 1)));
    end component;

    component wishbone_register
    port (
        CLK_I : in std_logic;
        RST_I : in std_logic;
        DAT_I : in std_logic_vector(31 downto 0);
        DAT_O : out std_logic_vector(31 downto 0);
        ACK_O : out std_logic;
        ADR_I : in std_logic_vector((C_NUM_REGISTER_ADDRESS_BITS + 1) downto 0);
        CYC_I : in std_logic;
        SEL_I : in std_logic_vector(3 downto 0);
        STB_I : in std_logic;
        WE_I  : in std_logic;
        user_read_regs    : in T_REGISTER_BLOCK;
        user_write_regs   : out T_REGISTER_BLOCK);
    end component;

    component wishbone_flash_sdram_interface
    port (
        CLK_I : in std_logic;
        RST_I : in std_logic;
        DAT_I : in std_logic_vector(31 downto 0);
        DAT_O : out std_logic_vector(31 downto 0);
        ACK_O : out std_logic;
        ADR_I : in std_logic_vector(14 downto 0);
        CYC_I : in std_logic;
        SEL_I : in std_logic_vector(3 downto 0);
        STB_I : in std_logic;
        WE_I  : in std_logic;
        gbe_app_clk             : in std_logic;
        gbe_rx_valid            : in std_logic;
        gbe_rx_end_of_frame     : in std_logic;
        gbe_rx_data             : in std_logic_vector(63 downto 0);
        gbe_rx_source_ip        : in std_logic_vector(31 downto 0);
        gbe_rx_source_port      : in std_logic_vector(15 downto 0);
        gbe_rx_bad_frame        : in std_logic;
        gbe_rx_overrun          : in std_logic;
        gbe_rx_overrun_ack      : out std_logic;
        gbe_rx_ack              : out std_logic;
        --AI Start: Add fortygbe interface for configuration
        fgbe_config_en           : in std_logic;  -- if '1' SDRAM/Flash configuration is done via forty GbE else via 1 GbE
        fgbe_app_clk             : in std_logic;
        fgbe_rx_valid            : in std_logic_vector(3 downto 0);
        fgbe_rx_end_of_frame     : in std_logic;
        fgbe_rx_data             : in std_logic_vector(255 downto 0);
        fgbe_rx_source_ip        : in std_logic_vector(31 downto 0);
        fgbe_rx_source_port      : in std_logic_vector(15 downto 0);
        fgbe_rx_bad_frame        : in std_logic;
        fgbe_rx_overrun          : in std_logic;
        fgbe_rx_overrun_ack      : out std_logic;
        fgbe_rx_ack              : out std_logic;
        --AI End: Add fortygbe interface for configuration         
        fpga_emcclk     : in std_logic;
        fpga_emcclk2    : in std_logic;
        flash_dq_in     : in std_logic_vector(15 downto 0);
        flash_dq_out    : out std_logic_vector(15 downto 0);
        flash_dq_out_en : out std_logic;
        flash_a         : out std_logic_vector(28 downto 0);
        flash_cs_n      : out std_logic;
        flash_oe_n      : out std_logic;
        flash_we_n      : out std_logic;
        flash_adv_n     : out std_logic;
        flash_rs0       : out std_logic;
        flash_rs1       : out std_logic;
        flash_wait      : in std_logic;
        flash_output_enable : out std_logic;
        spartan_clk : out std_logic;
        config_io_0 : out std_logic;
        config_io_1 : out std_logic;
        config_io_2 : in std_logic;
        config_io_3 : out std_logic;
        config_io_4 : out std_logic;
        config_io_5 : in std_logic;
        config_io_6 : out std_logic;
        config_io_7 : out std_logic;
        config_io_8 : out std_logic;
        config_io_9 : out std_logic;
        config_io_10 : out std_logic;
        config_io_11 : out std_logic;
        spi_miso : in std_logic;
        spi_mosi : out std_logic;
        spi_csb  : out std_logic;
        spi_clk  : out std_logic;
        debug_sdram_program_header  : out std_logic_vector(63 downto 0));
    end component;

    component wishbone_one_wire
    generic (
        NUM_ONE_WIRE_INTERFACES : integer);
    port (
        CLK_I : in std_logic;
        RST_I : in std_logic;
        DAT_I : in std_logic_vector(31 downto 0);
        DAT_O : out std_logic_vector(31 downto 0);
        ACK_O : out std_logic;
        ADR_I : in std_logic_vector(2 downto 0);
        CYC_I : in std_logic;
        SEL_I : in std_logic_vector(3 downto 0);
        STB_I : in std_logic;
        WE_I  : in std_logic;
        one_wire_pull_down_enable         : out std_logic_vector((NUM_ONE_WIRE_INTERFACES - 1) downto 0);
        one_wire_in                       : in std_logic_vector((NUM_ONE_WIRE_INTERFACES - 1) downto 0);
        one_wire_strong_pull_up_enable    : out std_logic_vector((NUM_ONE_WIRE_INTERFACES - 1) downto 0));
   end component;

    component wishbone_i2c
    port (
        CLK_I : in std_logic;
        RST_I : in std_logic;
        DAT_I : in std_logic_vector(31 downto 0);
        DAT_O : out std_logic_vector(31 downto 0);
        ACK_O : out std_logic;
        ADR_I : in std_logic_vector(4 downto 0);
        CYC_I : in std_logic;
        SEL_I : in std_logic_vector(3 downto 0);
        STB_I : in std_logic;
        WE_I  : in std_logic;
        scl_pad_i     : in std_logic;
        scl_pad_o     : out std_logic;
        scl_padoen_o  : out std_logic;
        sda_pad_i     : in std_logic;
        sda_pad_o     : out std_logic;
        sda_padoen_o  : out std_logic);
    end component;

    component kat_ten_gb_eth
    generic (
        FABRIC_MAC     : std_logic_vector(47 downto 0);
        FABRIC_IP      : std_logic_vector(31 downto 0);
        FABRIC_PORT    : std_logic_vector(15 downto 0);
        FABRIC_NETMASK : std_logic_vector(31 downto 0);
        FABRIC_GATEWAY : std_logic_vector(7 downto 0);
        FABRIC_ENABLE  : std_logic;
        FABRIC_MC_RECV_IP      : std_logic_vector(31 downto 0);
        FABRIC_MC_RECV_IP_MASK : std_logic_vector(31 downto 0);
        PREEMPHASIS       : std_logic_vector(3 downto 0);
        POSTEMPHASIS      : std_logic_vector(4 downto 0);
        DIFFCTRL          : std_logic_vector(3 downto 0);
        RXEQMIX           : std_logic_vector(2 downto 0);
        CPU_TX_ENABLE     : integer;
        CPU_RX_ENABLE     : integer;
        RX_DIST_RAM       : integer;
        LARGE_PACKETS     : integer;
        TTL               : integer;
        PROMISC_MODE      : integer);
    port (
        clk : in std_logic;
        rst : in std_logic;
        tx_valid            : in std_logic;
        tx_end_of_frame     : in std_logic;
        tx_data             : in std_logic_vector(63 downto 0);
        tx_dest_ip          : in std_logic_vector(31 downto 0);
        tx_dest_port        : in std_logic_vector(15 downto 0);
        tx_overflow         : out std_logic;
        tx_afull            : out std_logic;
        rx_valid            : out std_logic;
        rx_end_of_frame     : out std_logic;
        rx_data             : out std_logic_vector(63 downto 0);
        rx_source_ip        : out std_logic_vector(31 downto 0);
        rx_source_port      : out std_logic_vector(15 downto 0);
        rx_bad_frame        : out std_logic;
        rx_overrun          : out std_logic;
        rx_overrun_ack      : in std_logic;
        rx_ack : in std_logic;
        CLK_I : in std_logic;
        RST_I : in std_logic;
        DAT_I : in std_logic_vector(31 downto 0);
        DAT_O : out std_logic_vector(31 downto 0);
        ACK_O : out std_logic;
        ADR_I : in std_logic_vector(13 downto 0);
        CYC_I : in std_logic;
        SEL_I : in std_logic_vector(3 downto 0);
        STB_I : in std_logic;
        WE_I  : in std_logic;
        led_up : out std_logic;
        led_rx : out std_logic;
        led_tx : out std_logic;
        xaui_clk        : in std_logic;
        xaui_reset      : in std_logic;
        xaui_status     : in std_logic_vector(7 downto 0);
        xgmii_txd       : out std_logic_vector(63 downto 0);
        xgmii_txc       : out std_logic_vector(7 downto 0);
        xgmii_rxd       : in std_logic_vector(63 downto 0);
        xgmii_rxc       : in std_logic_vector(7 downto 0);
        mgt_rxeqmix         : out std_logic_vector(2 downto 0);
        mgt_txpreemphasis   : out std_logic_vector(3 downto 0);
        mgt_txpostemphasis  : out std_logic_vector(4 downto 0);
        mgt_txdiffctrl      : out std_logic_vector(3 downto 0);
        src_ip_address      : out std_logic_vector(31 downto 0);
        src_mac_address     : out std_logic_vector(47 downto 0);
        src_enable          : out std_logic;
        src_port            : out std_logic_vector(15 downto 0);
        src_gateway         : out std_logic_vector(7 downto 0);
        src_local_mc_recv_ip        : out std_logic_vector(31 downto 0);
        src_local_mc_recv_ip_mask   : out std_logic_vector(31 downto 0));
    end component;

    component xaui_to_gmii_translator
    port(
        xaui_clk            : in std_logic;
        xaui_rst            : in std_logic;
        xgmii_txd           : in std_logic_vector(63 downto 0);
        xgmii_txc           : in std_logic_vector(7 downto 0);
        xaui_almost_full    : out std_logic;
        xaui_full           : out std_logic;
        gmii_clk             : in std_logic;
        gmii_clk_en          : in std_logic;  -- GT 04/06/2015 ADD SUPPORT FOR 10/100MBPS OPERATION
        gmii_rst             : in std_logic;
        gmii_txd             : out std_logic_vector(7 downto 0);
        gmii_tx_en           : out std_logic;
        gmii_tx_er           : out std_logic;
        gmii_link_up         : in std_logic);
    end component;

    component gmii_to_xaui_translator
    port(
        gmii_clk        : in std_logic;
        gmii_clk_en     : in std_logic;  -- GT 04/06/2015 ADD SUPPORT FOR 10/100MBPS OPERATION
        gmii_rst        : in std_logic;
        gmii_rxd        : in std_logic_vector(7 downto 0);
        gmii_rx_dv      : in std_logic;
        gmii_rx_er      : in std_logic;
        xaui_clk        : in std_logic;
        xaui_rst        : in std_logic;
        xgmii_rxd       : out std_logic_vector(63 downto 0);
        xgmii_rxc       : out std_logic_vector(7 downto 0));
    end component;

    component gmii_to_sgmii
    port (
        gtrefclk_p           : in  std_logic;
        gtrefclk_n           : in  std_logic;
        gtrefclk_out         : out std_logic;
        txp                  : out std_logic;
        txn                  : out std_logic;
        rxp                  : in std_logic;
        rxn                  : in std_logic;
        resetdone                   : out std_logic;
        userclk_out                 : out std_logic;
        userclk2_out                : out std_logic;
        rxuserclk_out               : out std_logic;
        rxuserclk2_out              : out std_logic;
        pma_reset_out               : out std_logic;
        mmcm_locked_out             : out std_logic;
        independent_clock_bufg      : in std_logic;
        sgmii_clk_r                 : out std_logic;
        sgmii_clk_f                 : out std_logic;
        sgmii_clk_en         : out std_logic;
        gmii_txd             : in std_logic_vector(7 downto 0);
        gmii_tx_en           : in std_logic;
        gmii_tx_er           : in std_logic;
        gmii_rxd             : out std_logic_vector(7 downto 0);
        gmii_rx_dv           : out std_logic;
        gmii_rx_er           : out std_logic;
        gmii_isolate         : out std_logic;
        configuration_vector : in std_logic_vector(4 downto 0);
        an_interrupt         : out std_logic;
        an_adv_config_vector : in std_logic_vector(15 downto 0);
        an_restart_config    : in std_logic;
        speed_is_10_100      : in std_logic;
        speed_is_100         : in std_logic;
        status_vector        : out std_logic_vector(15 downto 0);
        reset                : in std_logic;
        signal_detect        : in std_logic;
        gt0_qplloutclk_out     : out std_logic;
        gt0_qplloutrefclk_out  : out std_logic);
    end component;

    component ska_forty_gb_eth
    generic (
        FABRIC_MAC        : std_logic_vector(47 downto 0);
        FABRIC_IP         : std_logic_vector(31 downto 0);
        FABRIC_PORT       : std_logic_vector(15 downto 0);
        FABRIC_NETMASK    : std_logic_vector(31 downto 0);
        FABRIC_GATEWAY    : std_logic_vector(7 downto 0);
        FABRIC_ENABLE     : std_logic;
        TTL               : std_logic_vector(7 downto 0);
        PROMISC_MODE      : integer;
        RX_CRC_CHK_ENABLE : integer);
    port (
        clk : in std_logic;
        rst : in std_logic;
        tx_valid            : in std_logic_vector(3 downto 0);
        tx_end_of_frame     : in std_logic;
        tx_data             : in std_logic_vector(255 downto 0);
        tx_dest_ip          : in std_logic_vector(31 downto 0);
        tx_dest_port        : in std_logic_vector(15 downto 0);
        tx_overflow         : out std_logic;
        tx_afull            : out std_logic;
        rx_valid            : out std_logic_vector(3 downto 0);
        rx_end_of_frame     : out std_logic;
        rx_data             : out std_logic_vector(255 downto 0);
        rx_source_ip        : out std_logic_vector(31 downto 0);
        rx_source_port      : out std_logic_vector(15 downto 0);
        rx_dest_ip          : out std_logic_vector(31 downto 0);
        rx_dest_port        : out std_logic_vector(15 downto 0);
        rx_bad_frame        : out std_logic;
        rx_overrun          : out std_logic;
        rx_overrun_ack      : in std_logic;
        rx_ack : in std_logic;
        CLK_I : in std_logic;
        RST_I : in std_logic;
        DAT_I : in std_logic_vector(31 downto 0);
        DAT_O : out std_logic_vector(31 downto 0);
        ACK_O : out std_logic;
        ADR_I : in std_logic_vector(13 downto 0);
        CYC_I : in std_logic;
        SEL_I : in std_logic_vector(3 downto 0);
        STB_I : in std_logic;
        WE_I  : in std_logic;
        xlgmii_txclk    : in std_logic;
        xlgmii_txrst    : in std_logic;
        xlgmii_txd      : out std_logic_vector(255 downto 0);
        xlgmii_txc      : out std_logic_vector(31 downto 0);
        xlgmii_txled    : out std_logic_vector(1 downto 0);
        xlgmii_rxclk    : in std_logic;
        xlgmii_rxrst    : in std_logic;
        xlgmii_rxd      : in std_logic_vector(255 downto 0);
        xlgmii_rxc      : in std_logic_vector(31 downto 0);
        xlgmii_rxled    : out std_logic_vector(1 downto 0);
        phy_rx_up       : in std_logic;
        phy_tx_rst      : in std_logic;
        src_ip_address      : out std_logic_vector(31 downto 0);
        src_mac_address     : out std_logic_vector(47 downto 0);
        src_enable          : out std_logic;
        src_port            : out std_logic_vector(15 downto 0);
        src_gateway         : out std_logic_vector(7 downto 0);
        src_local_mc_recv_ip        : out std_logic_vector(31 downto 0);
        src_local_mc_recv_ip_mask   : out std_logic_vector(31 downto 0);
        debug_out : out std_logic_vector(7 downto 0);
        debug_led : out std_logic_vector(7 downto 0));
    end component;

    component IEEE802_3_XL_PHY_top is
        Port(
            SYS_CLK_I            : in  std_logic;
            SYS_CLK_RST_I        : in  std_logic;

            GTREFCLK_PAD_N_I     : in  std_logic;
            GTREFCLK_PAD_P_I     : in  std_logic;

            GTREFCLK_O           : out std_logic;

            TXN_O                : out std_logic_vector(3 downto 0);
            TXP_O                : out std_logic_vector(3 downto 0);
            RXN_I                : in  std_logic_vector(3 downto 0);
            RXP_I                : in  std_logic_vector(3 downto 0);

            SOFT_RESET_I         : in  std_logic;

            LINK_UP_O            : out std_logic;

            -- XLGMII INPUT Interface
            -- Transmitter Interface
            XLGMII_X4_TXC_I      : in  std_logic_vector(31 downto 0);
            XLGMII_X4_TXD_I      : in  std_logic_vector(255 downto 0);

            -- XLGMII Output Interface
            -- Receiver Interface
            XLGMII_X4_RXC_O      : out std_logic_vector(31 downto 0);
            XLGMII_X4_RXD_O      : out std_logic_vector(255 downto 0);

            TEST_PATTERN_EN_I    : in  std_logic;
            TEST_PATTERN_ERROR_O : out std_logic
        );
    end component IEEE802_3_XL_PHY_top;

    component FPGA_DNA_CHECKER is
        Port(
            CLK_I            : in  std_logic;
            RST_I            : in  std_logic;

            FPGA_EMCCLK2_I   : in  std_logic;
            FPGA_DNA_O       : out std_logic_vector(63 downto 0);
            FPGA_DNA_MATCH_O : out std_logic
        );
    end component FPGA_DNA_CHECKER;
    
    -- GT 29/03/2017 ADDED ACCESS TO XADC
    component xadc_measurement
        port (
            daddr_in        : in std_logic_vector(6 downto 0);
            den_in          : in std_logic;
            di_in           : in std_logic_vector(15 downto 0);
            dwe_in          : in std_logic;
            do_out          : out std_logic_vector(15 downto 0);
            drdy_out        : out std_logic;
            dclk_in         : in std_logic;
            reset_in        : in std_logic;
            busy_out        : out std_logic;
            channel_out     : out std_logic_vector(4 downto 0);
            eoc_out         : out std_logic;
            eos_out         : out std_logic;
            ot_out          : out std_logic;
            user_temp_alarm_out : out std_logic;
            alarm_out       : out std_logic;
            vp_in           : in std_logic;
            vn_in           : in std_logic);
    end component;    
       
    component cross_clock_fifo_wb_out_73x16
    port (
        rst             : in std_logic;
        wr_clk          : in std_logic;
        rd_clk          : in std_logic;
        din             : in std_logic_vector(72 downto 0);
        wr_en           : in std_logic;
        rd_en           : in std_logic;
        dout            : out std_logic_vector(72 downto 0);
        full            : out std_logic;
        empty           : out std_logic);
    end component; 
        
   type T_WB_DSP_WR_STATE is (
     WB_DSP_WR_IDLE,
     WB_DSP_WR_STROBE_CHECK,
     WB_DSP_WR_FIFO_WR_EN_1,
     WB_DSP_WR_FIFO_WR_EN_2,
     WB_DSP_WR_FIFO_WR_EN_3,
     WB_DSP_WR_FIFO_WR_EN_4,     
     WB_DSP_WR_FIFO_WR_DIS);   

    component led_manager
    	port (
    		clk 					: in std_logic;
    		rst 					: in std_logic;
    		forty_gbe_link_status 	: in std_logic;
    		dhcp_resolved 			: in std_logic;
    		firmware_version		: in std_logic_vector(3 downto 0);
    		ublaze_toggle_value		: in std_logic;
    		dsp_override_i   		: in std_logic;
    		dsp_leds_i 			    : in std_logic_vector(7 downto 0);
            leds_out                : out std_logic_vector(7 downto 0)
    		);
    end component;

    signal sys_clk : std_logic;
    signal sys_clk_mmcm : std_logic;
    signal sys_rst : std_logic; 
    signal bsp_rst : std_logic;
    signal user_40gbe_rst : std_logic;
    signal gmii_clk : std_logic;
    signal gmii_rst : std_logic;


    signal gmii_reset_done : std_logic;

    signal refclk_0 : std_logic;
    signal refclk_1 : std_logic;
    signal aux_clk : std_logic;
    signal aux_synci : std_logic;
    signal aux_synco : std_logic;

    signal user_clk : std_logic;
    signal user_clk_mmcm : std_logic;
    --signal user_rst : std_logic;

    signal bsp_clk : std_logic;
    signal bsp_clk_mmcm : std_logic;
    
    signal sys_mmcm_locked : std_logic;
    signal user_mmcm_locked : std_logic;

    signal gmii_rst_z : std_logic;
    signal gmii_rst_z2 : std_logic;
    signal gmii_rst_z3 : std_logic;

    --Reset Synchroniser and user reset signals
    attribute ASYNC_REG : string;

    signal sys_fpga_rst : std_logic;
    signal sync_sys_fpga_rst : std_logic;
    attribute ASYNC_REG of sys_fpga_rst: signal is "TRUE";
    attribute ASYNC_REG of sync_sys_fpga_rst: signal is "TRUE";

    signal aux_fpga_rst : std_logic;
    signal sync_aux_fpga_rst : std_logic;
    attribute ASYNC_REG of aux_fpga_rst: signal is "TRUE";
    attribute ASYNC_REG of sync_aux_fpga_rst: signal is "TRUE";

    signal user_fpga_rst : std_logic;
    signal sync_user_fpga_rst : std_logic;
    attribute ASYNC_REG of user_fpga_rst: signal is "TRUE";
    attribute ASYNC_REG of sync_user_fpga_rst: signal is "TRUE";

    signal bsp_fpga_rst : std_logic;
    signal sync_bsp_fpga_rst : std_logic;
    attribute ASYNC_REG of bsp_fpga_rst: signal is "TRUE";
    attribute ASYNC_REG of sync_bsp_fpga_rst: signal is "TRUE";
        
    signal gmii_fpga_rst : std_logic;
    signal sync_gmii_fpga_rst : std_logic;
    attribute ASYNC_REG of gmii_fpga_rst: signal is "TRUE";
    attribute ASYNC_REG of sync_gmii_fpga_rst: signal is "TRUE";

    signal qsfp_fpga_rst : std_logic;
    signal sync_qsfp_fpga_rst : std_logic;
    attribute ASYNC_REG of qsfp_fpga_rst: signal is "TRUE";
    attribute ASYNC_REG of sync_qsfp_fpga_rst: signal is "TRUE";

    signal emcclk_fpga_rst : std_logic;
    signal sync_emcclk_fpga_rst : std_logic;       
    attribute ASYNC_REG of emcclk_fpga_rst: signal is "TRUE";
    attribute ASYNC_REG of sync_emcclk_fpga_rst: signal is "TRUE";
    
    --signal gmii_reset_done_z : std_logic; -- GT 29/03/2017 CHANGE gmii_rst CONDITION
    --signal gmii_reset_done_z2 : std_logic;
    --signal gmii_reset_done_z3 : std_logic; 
    
    signal sgmii_link_up : std_logic;
    signal sgmii_link_up_z : std_logic;
    signal sgmii_link_up_z2 : std_logic;
    signal sgmii_link_up_z3 : std_logic;     
    
    signal enable_40gbe_packet_generation : std_logic_vector(3 downto 0);
    signal enable_40gbe_packet_generation_z1 : std_logic_vector(3 downto 0);
    signal enable_1gbe_packet_generation : std_logic;
    signal enable_1gbe_packet_generation_z1 : std_logic;

    signal brd_user_read_regs : T_REGISTER_BLOCK;
    signal brd_user_write_regs : T_REGISTER_BLOCK;
    --signal brd_user_read_regs_2 : T_REGISTER_BLOCK;
    --signal brd_user_write_regs_2 : T_REGISTER_BLOCK;

    signal WB_MST_ACK_I : std_logic;
    signal WB_MST_ADR_O : std_logic_vector(31 downto 0);
    signal WB_MST_CYC_O : std_logic;
    signal WB_MST_DAT_I : std_logic_vector(31 downto 0);
    signal WB_MST_DAT_O : std_logic_vector(31 downto 0);
    signal WB_MST_RST_O : std_logic;
    signal WB_MST_SEL_O : std_logic_vector(3 downto 0);
    signal WB_MST_STB_O : std_logic;
    signal WB_MST_WE_O : std_logic;

    signal WB_SLV_DAT_O : T_SLAVE_WB_DATA;
    signal WB_SLV_DAT_I : T_SLAVE_WB_DATA;
    signal WB_SLV_ACK_O : std_logic_vector(0 to (C_WB_NUM_SLAVES - 1));
    signal WB_SLV_ADR_I : T_SLAVE_WB_ADDRESS;
    signal WB_SLV_CYC_I : std_logic_vector(0 to (C_WB_NUM_SLAVES - 1));
    signal WB_SLV_SEL_I : T_SLAVE_WB_SEL;
    signal WB_SLV_STB_I : std_logic_vector(0 to (C_WB_NUM_SLAVES - 1));
    signal WB_SLV_WE_I  : std_logic_vector(0 to (C_WB_NUM_SLAVES - 1));

    signal gmii_tx_valid : std_logic;
    signal gmii_tx_end_of_frame : std_logic;
    signal gmii_tx_data : std_logic_vector(63 downto 0);
    signal gmii_tx_dest_ip : std_logic_vector(31 downto 0);
    signal gmii_tx_dest_port : std_logic_vector(15 downto 0);
    signal gmii_tx_overflow : std_logic;
    signal gmii_tx_afull : std_logic;

    signal gmii_rx_valid : std_logic;
    signal gmii_rx_end_of_frame : std_logic;
    signal gmii_rx_data : std_logic_vector(63 downto 0);
    signal gmii_rx_source_ip : std_logic_vector(31 downto 0);
    signal gmii_rx_source_port : std_logic_vector(15 downto 0);
    signal gmii_rx_bad_frame : std_logic;
    signal gmii_rx_overrun : std_logic;
    signal gmii_rx_overrun_ack : std_logic;
    signal gmii_rx_ack : std_logic;

    signal spartan_clk_i : std_logic;
    signal config_io_0_i : std_logic;
    signal config_io_1_i : std_logic;
    signal config_io_2_i : std_logic;
    signal config_io_3_i : std_logic;
    signal config_io_4_i : std_logic;
    signal config_io_5_i : std_logic;
    signal config_io_6_i : std_logic;
    signal config_io_7_i : std_logic;
    signal config_io_8_i : std_logic;
    signal config_io_9_i : std_logic;
    signal config_io_10_i : std_logic;
    signal config_io_11_i : std_logic;
    signal spi_miso_i : std_logic;
    signal spi_mosi_i : std_logic;
    signal spi_csb_i : std_logic;
    signal spi_clk_i : std_logic;

    signal one_wire_pull_down_enable : std_logic_vector(4 downto 0);
    signal one_wire_in : std_logic_vector(4 downto 0);
    signal one_wire_strong_pull_up_enable_i : std_logic_vector(4 downto 0);

    signal flash_dq_out : std_logic_vector(15 downto 0);
    signal flash_dq_out_en : std_logic;
    signal flash_a_i : std_logic_vector(28 downto 0);
    signal flash_output_enable : std_logic;
    signal flash_rs0_i : std_logic;
    signal flash_rs1_i : std_logic;
    signal flash_cs_n_i : std_logic;
    signal flash_oe_n_i : std_logic;
    signal flash_we_n_i : std_logic;
    signal flash_adv_n_i : std_logic;

    signal i2c_scl_pad_i : std_logic_vector(0 to 4);
    signal i2c_scl_pad_o : std_logic_vector(0 to 4);
    signal i2c_scl_padoen_o : std_logic_vector(0 to 4);
    signal i2c_sda_pad_i : std_logic_vector(0 to 4);
    signal i2c_sda_pad_o : std_logic_vector(0 to 4);
    signal i2c_sda_padoen_o : std_logic_vector(0 to 4);

    signal gmii_xaui_status : std_logic_vector(7 downto 0);
    signal gmii_xgmii_txd : std_logic_vector(63 downto 0);
    signal gmii_xgmii_txc : std_logic_vector(7 downto 0);
    signal gmii_xgmii_rxd : std_logic_vector(63 downto 0);
    signal gmii_xgmii_rxc : std_logic_vector(7 downto 0);
    signal gmii_src_ip_address : std_logic_vector(31 downto 0);
    signal gmii_src_mac_address : std_logic_vector(47 downto 0);
    signal gmii_src_enable : std_logic;
    signal gmii_src_port : std_logic_vector(15 downto 0);
    signal gmii_src_gateway : std_logic_vector(7 downto 0);
    signal gmii_src_local_mc_recv_ip : std_logic_vector(31 downto 0);
    signal gmii_src_local_mc_recv_ip_mask : std_logic_vector(31 downto 0);
    signal gmii_xaui_almost_full : std_logic;
    signal gmii_xaui_full : std_logic;

    signal configuration_vector : std_logic_vector(4 downto 0);
    signal an_interrupt : std_logic;
    signal an_adv_config_vector : std_logic_vector(15 downto 0);
    signal an_restart_config : std_logic;
    signal status_vector : std_logic_vector(15 downto 0);

    signal gmii_clk_en : std_logic;
    signal gmii_txd : std_logic_vector(7 downto 0);
    signal gmii_tx_en : std_logic;
    signal gmii_tx_en_z : std_logic;
    signal gmii_tx_er : std_logic;
    signal gmii_rxd : std_logic_vector(7 downto 0);
    signal gmii_rx_dv : std_logic;
    signal gmii_rx_er : std_logic;
    signal gmii_to_sgmii_reset : std_logic;

    signal sfp_reset_delay_low : std_logic_vector(15 downto 0);
    signal sfp_reset_delay_low_over : std_logic;
    signal sfp_reset_delay_high : std_logic_vector(12 downto 0);

    signal gmii_to_sgmii_refclk_p : std_logic;
    signal gmii_to_sgmii_refclk_n : std_logic;
    signal gmii_to_sgmii_txp : std_logic;
    signal gmii_to_sgmii_txn : std_logic;
    signal gmii_to_sgmii_rxp : std_logic;
    signal gmii_to_sgmii_rxn : std_logic;

    signal gmii_rx_valid_flash_sdram_controller : std_logic;
    signal gmii_rx_end_of_frame_flash_sdram_controller : std_logic;
    signal gmii_rx_overrun_ack_flash_sdram_controller : std_logic;
    signal gmii_rx_ack_flash_sdram_controller : std_logic;
    
    --AI start: Add fortygbe config interface 
    signal select_forty_gbe_data_sel : std_logic;
    signal forty_gb_eth_clk : std_logic;
    signal forty_gb_eth_rst : std_logic;
    signal fgbe_config_en : std_logic; 
    signal fgbe_link_status : std_logic;  --status of the 40GbE links for auto-sensing the configuration interface
    signal fgbe_reg_sel : std_logic;      --this is a register that can override the auto-sensing function if need be  
    signal xlgmii_rx_valid_flash_sdram_controller :  T_40GBE_DATA_VALID;
    signal xlgmii_rx_end_of_frame_flash_sdram_controller : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal xlgmii_rx_overrun_ack_flash_sdram_controller : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal xlgmii_rx_ack_flash_sdram_controller : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --AI end: Add fortygbe config interface         

    --signal gmii_rx_valid_ramp_checker : std_logic;
    --signal gmii_rx_end_of_frame_ramp_checker : std_logic;
    signal gmii_rx_overrun_ack_ramp_checker : std_logic;
    signal gmii_rx_ack_ramp_checker : std_logic;
    
    --AI start: Add fortygbe config interface 
    --signal xlgmii_rx_valid_ramp_checker : T_40GBE_DATA_VALID;
    --signal xlgmii_rx_end_of_frame_ramp_checker : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal xlgmii_rx_overrun_ack_ramp_checker : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal xlgmii_rx_ack_ramp_checker : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --AI end: Add fortygbe config interface         

    signal microblaze_uart_rxd : std_logic;
    signal microblaze_uart_txd : std_logic;

    signal mezzanine_0_enable : std_logic;
    signal mezzanine_1_enable : std_logic;
    signal mezzanine_2_enable : std_logic;
    signal mezzanine_3_enable : std_logic;

    signal mezzanine_0_fault_checking_enable : std_logic;
    signal mezzanine_1_fault_checking_enable : std_logic;
    signal mezzanine_2_fault_checking_enable : std_logic;
    signal mezzanine_3_fault_checking_enable : std_logic;

    signal mezzanine_0_fault : std_logic;
    signal mezzanine_1_fault : std_logic;
    signal mezzanine_2_fault : std_logic;
    signal mezzanine_3_fault : std_logic;

    signal host_reset_req : std_logic;
    signal host_reset_req_z : std_logic;
    signal host_reset_count : std_logic_vector(7 downto 0);
    signal host_reset : std_logic;
    signal host_reset_z : std_logic;
    signal host_reset_z2 : std_logic;
    signal host_reset_z3 : std_logic;
    signal host_reset_u : std_logic;
    signal host_reset_u2 : std_logic;
    signal host_reset_u3 : std_logic; 
    signal host_reset_d : std_logic;
    signal host_reset_d2 : std_logic;
    signal host_reset_d3 : std_logic;     

    signal xlgmii_tx_valid        : std_logic_vector(3 downto 0);
    signal xlgmii_tx_end_of_frame : std_logic;
    signal xlgmii_tx_data         : std_logic_vector(255 downto 0);
    signal xlgmii_tx_dest_ip      : std_logic_vector(31 downto 0);
    signal xlgmii_tx_dest_port    : std_logic_vector(15 downto 0);
    signal xlgmii_tx_overflow     : std_logic;
    signal xlgmii_tx_afull        : std_logic;
    signal xlgmii_rx_valid        : std_logic_vector(3 downto 0);
    signal xlgmii_rx_end_of_frame : std_logic;
    signal xlgmii_rx_data         : std_logic_vector(255 downto 0);
    signal xlgmii_rx_source_ip    : std_logic_vector(31 downto 0);
    signal xlgmii_rx_source_port  : std_logic_vector(15 downto 0);
    signal xlgmii_rx_dest_ip      : std_logic_vector(31 downto 0);
    signal xlgmii_rx_dest_port    : std_logic_vector(15 downto 0);
    signal xlgmii_rx_bad_frame    : std_logic;
    signal xlgmii_rx_overrun      : std_logic;
    signal xlgmii_rx_overrun_ack  : std_logic;
    signal xlgmii_rx_ack          : std_logic;

    signal led_rx : std_logic;
    signal led_tx : std_logic;
    signal led_up : std_logic;

    --signal xlgmii_tx_valid : T_40GBE_DATA_VALID;
    --signal xlgmii_tx_end_of_frame : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --signal xlgmii_tx_data : T_40GBE_DATA;
    --signal xlgmii_tx_dest_ip : T_40GBE_IP_ADDRESS;
    --signal xlgmii_tx_dest_port : T_40GBE_PORT_ADDRESS;
    --signal xlgmii_tx_overflow : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --signal xlgmii_tx_afull : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --signal xlgmii_rx_valid : T_40GBE_DATA_VALID;
    --signal xlgmii_rx_end_of_frame : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --signal xlgmii_rx_data : T_40GBE_DATA;
    --signal xlgmii_rx_source_ip : T_40GBE_IP_ADDRESS;
    --signal xlgmii_rx_source_port : T_40GBE_PORT_ADDRESS;
    --signal xlgmii_rx_bad_frame : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --signal xlgmii_rx_overrun : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --signal xlgmii_rx_overrun_ack : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    --signal xlgmii_rx_ack : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));

    signal xlgmii_txd : T_40GBE_XLGMII_DATA;
    signal xlgmii_txc : T_40GBE_XLGMII_CONTROL;
    signal xlgmii_rxd : T_40GBE_XLGMII_DATA;
    signal xlgmii_rxc : T_40GBE_XLGMII_CONTROL;

    signal xlgmii_txled : T_40GBE_LED_CTRL;
    signal xlgmii_rxled : T_40GBE_LED_CTRL;

    signal xlgmii_txd_i : T_40GBE_XLGMII_DATA;
    signal xlgmii_txc_i : T_40GBE_XLGMII_CONTROL;

    signal xlgmii_txd_reg : T_40GBE_XLGMII_DATA;
    signal xlgmii_txc_reg : T_40GBE_XLGMII_CONTROL;
    signal xlgmii_rxd_reg : T_40GBE_XLGMII_DATA;
    signal xlgmii_rxc_reg : T_40GBE_XLGMII_CONTROL;

    signal phy_rx_up : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal xlgmii_src_ip_address : T_40GBE_IP_ADDRESS;
    signal xlgmii_src_mac_address : T_40GBE_MAC_ADDRESS;
    signal xlgmii_src_enable : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal xlgmii_src_port : T_40GBE_PORT_ADDRESS;
    signal xlgmii_src_gateway : T_40GBE_GATEWAY_ADDRESS;
    signal xlgmii_src_local_mc_recv_ip : T_40GBE_IP_ADDRESS;
    signal xlgmii_src_local_mc_recv_ip_mask : T_40GBE_IP_ADDRESS;

    signal phy_rx_up_z1 : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal phy_rx_up_z2 : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));
    signal phy_rx_up_cpu : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));

    signal qsfp_soft_reset : std_logic_vector(0 to (C_NUM_40GBE_MAC - 1));

    signal qsfp_gtrefclk : std_logic;
    signal qsfp_gtrefclk_pb : std_logic;
    
    -- GT 29/03/2017 XADC SIGNALS
    signal xadc_busy_out : std_logic;
    signal xadc_channel_out :  std_logic_vector (4 downto 0);
    signal xadc_eoc_out : std_logic;
    signal xadc_eos_out : std_logic;
    signal xadc_ot_out : std_logic;
    signal xadc_user_temp_alarm_out : std_logic;
    signal xadc_alarm_out : std_logic;
    
    signal xadc_daddr_in : std_logic_vector (6 downto 0);
    signal xadc_den_in : std_logic;
    signal xadc_di_in : std_logic_vector (15 downto 0);
    signal xadc_dwe_in : std_logic;
    signal xadc_do_out : std_logic_vector (15 downto 0);
    signal xadc_drdy_out : std_logic;    
    
    -- GT 11/04/2017 ADD TIMEOUT TO SGMII CORE     
    signal sgmii_timeout_count_low : std_logic_vector(15 downto 0);
    signal sgmii_timeout_count_low_over : std_logic;
    signal sgmii_timeout_count_high : std_logic_vector(10 downto 0);
    signal sgmii_timeout : std_logic;
    signal sgmii_reset_count : std_logic_vector(7 downto 0);
    signal sgmii_timeout_reset : std_logic;

	-- AP: LED Manager
    -- > Will use the following signals:
    --   -> clk => sys_clk and rst => sys_rst
    --   -> forty_gbe_link_status => fgbe_link_status
    --	 -> dhcp_resolved => brd_user_write_regs(C_WR_FRONT_PANEL_STAT_LED_ADDR)(0)
    --	 -> firmware_version => C_VERSION (from parameter.vhd), or brd_user_read_regs(C_RD_VERSION_ADDR)
    --	 -> dsp_override_i and dsp_leds_in
    --	 -> leds_out => FPGA_LEDS(7 downto 0)
    
    signal mezzanine_fault_override : std_logic;

    signal src_packets_sent : std_logic_vector(15 downto 0);
    signal xaui_packets_sent : std_logic_vector(15 downto 0);
    signal gmii_packets_sent : std_logic_vector(15 downto 0);

    signal debug_out : std_logic_vector(7 downto 0);

    signal timer_counter_reset : std_logic;
    signal timer_counter_low : std_logic_vector(15 downto 0);
    signal timer_counter_low_over : std_logic;
    signal timer_counter_high : std_logic_vector(15 downto 0);
    signal timer_counter_low_latched : std_logic_vector(15 downto 0);
    signal timer_counter_high_latched : std_logic_vector(15 downto 0);
    signal timer_counter_stop : std_logic;
    signal timer_counter_stop_z1 : std_logic;
    signal timer_link : std_logic_vector(2 downto 0);

    signal latched_ramp_fault : std_logic_vector(255 downto 0);
    signal latched_desired_data : std_logic_vector(15 downto 0);
    signal latched_rx_valid : std_logic_vector(3 downto 0);
    signal latched_overflow : std_logic;
    signal latched_packet_number : std_logic_vector(15 downto 0);
    signal packet_size : std_logic_vector(15 downto 0);

    signal qsfp_xl_tx_clk_156m25_frequency : std_logic_vector(31 downto 0);
    signal fpga_emcclk2_frequency : std_logic_vector(31 downto 0);

    signal ramp_fault : std_logic;
    signal ramp_fault_reg : std_logic;

    signal tx_start_count_0 : std_logic_vector(15 downto 0);
    signal tx_start_count_1 : std_logic_vector(15 downto 0);
    signal tx_start_count_2 : std_logic_vector(15 downto 0);
    signal tx_start_count_3 : std_logic_vector(15 downto 0);

    signal rx_start_count_0 : std_logic_vector(15 downto 0);
    signal rx_start_count_1 : std_logic_vector(15 downto 0);
    signal rx_start_count_2 : std_logic_vector(15 downto 0);
    signal rx_start_count_3 : std_logic_vector(15 downto 0);

    signal second_toggle : std_logic;
    signal aux_clk_frequency : std_logic_vector(31 downto 0);

    signal ramp_source_destination_ip_address_0 : std_logic_vector(31 downto 0);
    signal ramp_checker_source_ip_address_0 : std_logic_vector(31 downto 0);
    signal ramp_source_destination_ip_address_1 : std_logic_vector(31 downto 0);
    signal ramp_checker_source_ip_address_1 : std_logic_vector(31 downto 0);
    signal ramp_source_destination_ip_address_2 : std_logic_vector(31 downto 0);
    signal ramp_checker_source_ip_address_2 : std_logic_vector(31 downto 0);
    signal ramp_source_destination_ip_address_3 : std_logic_vector(31 downto 0);
    signal ramp_checker_source_ip_address_3 : std_logic_vector(31 downto 0);

    signal payload_words : std_logic_vector(10 downto 0);

    -- GT 04/06/2015 ADD SUPPORT FOR 10/100Mbps
    signal gmii_speed_is_10_100 : std_logic;
    signal gmii_speed_is_100 : std_logic;

    -- MB 08/10/2015 ADDED SUPPORT FOR READING FPGA DNA
    signal fpga_dna : std_logic_vector(63 downto 0);
    
    signal select_one_gbe_data_sel  : std_logic;

    signal sys_clk_mmcm_fb : std_logic;
    signal user_clk_mmcm_fb : std_logic;
    
    --HMC I2C Mezzanine 0 Signals
    signal shmc_mezz0_scl_out : std_logic;
    signal shmc_mezz0_sda_out : std_logic;
    signal shmc_mezz0_scl_in : std_logic;
    signal shmc_mezz0_sda_in : std_logic;

    --HMC I2C Mezzanine 1 Signals
    signal shmc_mezz1_scl_out : std_logic;
    signal shmc_mezz1_sda_out : std_logic;
    signal shmc_mezz1_scl_in : std_logic;
    signal shmc_mezz1_sda_in : std_logic;
    
    --HMC I2C Mezzanine 2 Signals
    signal shmc_mezz2_scl_out : std_logic;
    signal shmc_mezz2_sda_out : std_logic;
    signal shmc_mezz2_scl_in : std_logic;
    signal shmc_mezz2_sda_in : std_logic;
    
    --Wishbone DSP FIFO Signals
    --Output to DSP
    signal wb_cross_clock_out_din : std_logic_vector(72 downto 0);
    signal wb_cross_clock_out_wrreq : std_logic;
    signal wb_cross_clock_out_rdreq : std_logic;
    signal wb_cross_clock_out_dout : std_logic_vector(72 downto 0);
    signal wb_cross_clock_out_full : std_logic;
    signal wb_cross_clock_out_empty : std_logic;
    
    --Input from DSP
    signal wb_data_in : std_logic_vector(31 downto 0);
    signal wb_ack_in : std_logic;
    signal wb_ack_in_z1 : std_logic;
    signal wb_ack_in_z2 : std_logic;
    signal wb_sync_ack_in : std_logic;
    signal wb_sync_data_in : std_logic_vector(31 downto 0);
    
    
    --Wishbone Write State Machine
    signal wb_dsp_wr_state : T_WB_DSP_WR_STATE;
    signal wb_slv_stb_hist_i : std_logic;
    
    --Mezzanine 3 
    signal MEZZ3_ID : std_logic_vector(2 downto 0);
    signal MEZZ3_PRESENT : std_logic;
    
    -- Mark Debug ILA Testing    
--    signal dbg_wb_cross_clock_out_din : std_logic_vector(72 downto 0);
--    signal dbg_wb_cross_clock_out_wrreq : std_logic;
--    signal dbg_wb_cross_clock_out_rdreq : std_logic;
--    signal dbg_wb_cross_clock_out_dout : std_logic_vector(72 downto 0);
--    signal dbg_wb_cross_clock_out_full : std_logic;
--    signal dbg_wb_cross_clock_out_empty : std_logic;
    
--    signal dbg_wb_data_in : std_logic_vector(31 downto 0);
--    signal dbg_wb_ack_in : std_logic;
--    signal dbg_wb_ack_in_z1 : std_logic;
--    signal dbg_wb_ack_in_z2 : std_logic;
--    signal dbg_wb_sync_ack_in : std_logic;
--    signal dbg_wb_sync_data_in : std_logic_vector(31 downto 0);
    
--    signal dbg_wb_dsp_wr_state : T_WB_DSP_WR_STATE;   
--    signal dbg_WB_SLV_ACK_O_top : std_logic;
--    signal dbg_WB_SLV_DAT_O_top : std_logic_vector(31 downto 0);
--    signal dbg_WB_SLV_DAT_O : std_logic_vector(31 downto 0);
--    signal dbg_WB_SLV_ACK_O : std_logic;
--    signal dbg_WB_SLV_SEL_I_top : std_logic_vector(3 downto 0);
--    signal dbg_WB_SLV_STB_I_top : std_logic;
--    signal dbg_WB_SLV_WE_I_top : std_logic;    
    
--    signal dbg_WB_SLV_ADR_I_top : std_logic_vector(31 downto 0);
--    signal dbg_WB_SLV_CYC_I_top : std_logic;
--    signal dbg_WB_SLV_DAT_I : std_logic_vector(31 downto 0);  
--    signal dbg_WB_SLV_ADR_I : std_logic_vector(31 downto 0);  
--    signal dbg_WB_SLV_CYC_I : std_logic;  
--    signal dbg_WB_SLV_SEL_I : std_logic_vector(3 downto 0);  
--    signal dbg_WB_SLV_WE_I : std_logic; 
--    signal dbg_WB_SLV_STB_I : std_logic;
    
    
                                    
    -- Mark Debug ILA Testing
    
--    attribute MARK_DEBUG : string;
--    attribute MARK_DEBUG of dbg_wb_cross_clock_out_din : signal is "TRUE";
--    attribute MARK_DEBUG of dbg_wb_cross_clock_out_wrreq : signal is "TRUE";
--    attribute MARK_DEBUG of dbg_wb_cross_clock_out_rdreq : signal is "TRUE";
--    attribute MARK_DEBUG of dbg_wb_cross_clock_out_dout : signal is "TRUE";
--    attribute MARK_DEBUG of dbg_wb_cross_clock_out_full : signal is "TRUE"; 
--    attribute MARK_DEBUG of dbg_wb_cross_clock_out_empty : signal is "TRUE";    
--    attribute MARK_DEBUG of dbg_wb_data_in : signal is "TRUE";    
--    attribute MARK_DEBUG of dbg_wb_ack_in : signal is "TRUE";    
--    attribute MARK_DEBUG of dbg_wb_ack_in_z1 : signal is "TRUE";    
--    attribute MARK_DEBUG of dbg_wb_ack_in_z2 : signal is "TRUE";    
--    attribute MARK_DEBUG of dbg_wb_sync_ack_in : signal is "TRUE";    
--    attribute MARK_DEBUG of dbg_wb_sync_data_in : signal is "TRUE";    

--    attribute MARK_DEBUG of dbg_wb_dsp_wr_state : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_ACK_O_top : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_DAT_O_top : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_DAT_O : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_ACK_O : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_SEL_I_top : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_STB_I_top : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_WE_I_top : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_ADR_I_top : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_CYC_I_top : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_DAT_I : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_ADR_I : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_CYC_I : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_SEL_I : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_WE_I : signal is "TRUE";   
--    attribute MARK_DEBUG of dbg_WB_SLV_STB_I : signal is "TRUE";   
    
    
begin

    --ILA Assignments
--    dbg_wb_cross_clock_out_din <= wb_cross_clock_out_din;
--    dbg_wb_cross_clock_out_wrreq <= wb_cross_clock_out_wrreq;
--    dbg_wb_cross_clock_out_rdreq <= wb_cross_clock_out_rdreq;
--    dbg_wb_cross_clock_out_dout <= wb_cross_clock_out_dout;
--    dbg_wb_cross_clock_out_full <= wb_cross_clock_out_full;
--    dbg_wb_cross_clock_out_empty <= wb_cross_clock_out_empty;
--    dbg_wb_data_in <= wb_data_in;
--    dbg_wb_ack_in <= wb_ack_in;
--    dbg_wb_ack_in_z1 <= wb_ack_in_z1;
--    dbg_wb_ack_in_z2 <= wb_ack_in_z2;
--    dbg_wb_sync_ack_in <= wb_sync_ack_in;
--    dbg_wb_sync_data_in <= wb_sync_data_in;
--    dbg_wb_dsp_wr_state <= wb_dsp_wr_state;
--    dbg_WB_SLV_ACK_O_top <= WB_SLV_ACK_O_top;
--    dbg_WB_SLV_DAT_O_top <= WB_SLV_DAT_O_top;
--    dbg_WB_SLV_DAT_O <= WB_SLV_DAT_O(14);
--    dbg_WB_SLV_ACK_O <= WB_SLV_ACK_O(14);
--    dbg_WB_SLV_SEL_I_top <= wb_cross_clock_out_dout(4 downto 1);
--    dbg_WB_SLV_STB_I_top <= wb_cross_clock_out_dout(72);
--    dbg_WB_SLV_WE_I_top <= wb_cross_clock_out_dout(0);
--    dbg_WB_SLV_ADR_I_top <= wb_cross_clock_out_dout(37 downto 6);
--    dbg_WB_SLV_CYC_I_top <= wb_cross_clock_out_dout(5);
--    dbg_WB_SLV_DAT_I <= WB_SLV_DAT_I(14);
--    dbg_WB_SLV_ADR_I <= WB_SLV_ADR_I(14);
--    dbg_WB_SLV_CYC_I <= WB_SLV_CYC_I(14);
--    dbg_WB_SLV_SEL_I <= WB_SLV_SEL_I(14);
--    dbg_WB_SLV_WE_I <= WB_SLV_WE_I(14);
--    dbg_WB_SLV_STB_I <= WB_SLV_STB_I(14);

    --Mezzanine 3 ID and Present (this should be part of the 40GbE yellow block, but is part of the BSP for now)
    --Mezzanine ID: "000" = spare, "001" = 40GbE, "010" = HMC, "011" = ADC, rest = spare
    MEZZ3_ID <= "001";
    MEZZ3_PRESENT <= '1';

    EMCCLK_FIX <= EMCCLK;

    xlgmii_tx_valid        <= forty_gbe_tx_valid;
    xlgmii_tx_end_of_frame <= forty_gbe_tx_end_of_frame;
    xlgmii_tx_data         <= forty_gbe_tx_data(63 downto 0) & forty_gbe_tx_data(127 downto 64) & forty_gbe_tx_data(191 downto 128) &  forty_gbe_tx_data(255 downto 192);
    xlgmii_tx_dest_ip      <= forty_gbe_tx_dest_ip;
    xlgmii_tx_dest_port    <= forty_gbe_tx_dest_port;
    --xlgmii_rx_overrun_ack  <= forty_gbe_rx_overrun_ack;
    --xlgmii_rx_ack          <= forty_gbe_rx_ack;
    forty_gbe_led_rx <= xlgmii_rxled(0)(1); -- xlgmii_rxled(0)(1) is activity, xlgmii_rxled(0)(0) is phy rx up
    forty_gbe_led_tx <= xlgmii_txled(0)(1); -- xlgmii_txled(0)(1) is activity, xlgmii_txled(0)(0) is phy tx up
    forty_gbe_led_up <= phy_rx_up(0);

    forty_gbe_tx_overflow     <= xlgmii_tx_overflow;
    forty_gbe_tx_afull        <= xlgmii_tx_afull;
    forty_gbe_rx_valid        <= xlgmii_rx_valid;
    forty_gbe_rx_end_of_frame <= xlgmii_rx_end_of_frame;
    --AI: Rx Data incorrectly mapped and needs to be mapped correctly such that forty_gbe_rx_data[255:0] maps correctly to 40GbE MAC rx data[255:0]
    --forty_gbe_rx_data         <= xlgmii_rx_data;
    forty_gbe_rx_data(255 downto 0) <= xlgmii_rx_data(63 downto 0) & xlgmii_rx_data(127 downto 64) & xlgmii_rx_data(191 downto 128) &  xlgmii_rx_data(255 downto 192);    
    forty_gbe_rx_source_ip    <= xlgmii_rx_source_ip;
    forty_gbe_rx_source_port  <= xlgmii_rx_source_port;
    forty_gbe_rx_dest_ip      <= xlgmii_rx_dest_ip;
    forty_gbe_rx_dest_port    <= xlgmii_rx_dest_port;
    forty_gbe_rx_bad_frame    <= xlgmii_rx_bad_frame;
    forty_gbe_rx_overrun      <= xlgmii_rx_overrun;

    -- These signals are not used but kept in for completeness sake.
    -- They are for the com express, which is not populated on the SKA boards
    CPU_PWR_BTN_N   <= '1';
    CPU_PWR_OK      <= '0';
    CPU_SYS_RESET_N <= '0';

    GND <= (others => '0');
    


---------------------------------------------------------------------------
-- REFCLK CONNECTIONS
---------------------------------------------------------------------------

    refclk_0_ibufgds : IBUFGDS
    generic map (
        DIFF_TERM => TRUE)
    port map (
        I  => FPGA_REFCLK_BUF0_P,
        IB => FPGA_REFCLK_BUF0_N,
        O  => refclk_0);

    refclk_1_ibufgds : IBUFGDS
    generic map (
        DIFF_TERM => TRUE)
    port map (
        I  => FPGA_REFCLK_BUF1_P,
        IB => FPGA_REFCLK_BUF1_N,
        O  => refclk_1);


---------------------------------------------------------------------------
-- system clock mmcm
---------------------------------------------------------------------------

    SYS_CLK_MMCM_inst : MMCME2_BASE
    generic map (
        BANDWIDTH        => "OPTIMIZED", -- Jitter programming (OPTIMIZED, HIGH, LOW)
        CLKFBOUT_MULT_F  => 6.0,         -- Multiply value for all CLKOUT (2.000-64.000).
        CLKFBOUT_PHASE   => 0.0,         -- Phase offset in degrees of CLKFB (-360.000-360.000).
        CLKIN1_PERIOD    => 6.4,         -- 156.25MHz Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
        -- CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
        CLKOUT0_DIVIDE_F => 6.0,         -- Divide amount for CLKOUT0 (1.000-128.000).
        CLKOUT1_DIVIDE   => 24,          -- Divide amount for CLKOUT1 (1.000-128.000).
        DIVCLK_DIVIDE    => 1,           -- Master division value (1-106)
        REF_JITTER1      => 0.0,         -- Reference input jitter in UI (0.000-0.999).
        STARTUP_WAIT     => FALSE        -- Delays DONE until MMCM is locked (FALSE, TRUE)
    )
    port map (
        CLKOUT0   => sys_clk_mmcm,
        CLKOUT1   => bsp_clk_mmcm,
        CLKFBOUT  => sys_clk_mmcm_fb,  -- Feedback clock output
        LOCKED    => sys_mmcm_locked,
        --LOCKED    => user_mmcm_locked,
        CLKIN1    => refclk_0,         -- Main clock input
        PWRDWN    => '0',
        RST       => '0',              -- fpga_reset,
        CLKFBIN   => sys_clk_mmcm_fb   -- Feedback clock input
    );

    sys_clk_BUFG_inst : BUFG
    port map (
        I => sys_clk_mmcm, -- Clock input
        O => sys_clk       -- Clock output
    );
    
    bsp_clk_BUFG_inst : BUFG
    port map (
        I => bsp_clk_mmcm, -- Clock input
        O => bsp_clk       -- Clock output
    );

    USER_CLK_MMCM_inst : MMCME2_BASE
    generic map (
        BANDWIDTH        => "OPTIMIZED", -- Jitter programming (OPTIMIZED, HIGH, LOW)
        CLKFBOUT_MULT_F  => MULTIPLY,    -- Multiply value for all CLKOUT (2.000-64.000).
        CLKFBOUT_PHASE   => 0.0,         -- Phase offset in degrees of CLKFB (-360.000-360.000).
        CLKIN1_PERIOD    => 6.4,         -- 156.25MHz Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
        -- CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
        CLKOUT0_DIVIDE_F => DIVIDE,      -- Divide amount for CLKOUT0 (1.000-128.000).
        DIVCLK_DIVIDE    => DIVCLK,      -- Master division value (1-106)
        REF_JITTER1      => 0.0,         -- Reference input jitter in UI (0.000-0.999).
        STARTUP_WAIT     => FALSE        -- Delays DONE until MMCM is locked (FALSE, TRUE)
    )
    port map (
        CLKOUT0   => user_clk_mmcm,
        CLKFBOUT  => user_clk_mmcm_fb,  -- Feedback clock output
        LOCKED    => user_mmcm_locked,
        CLKIN1    => sys_clk_mmcm,      -- Main clock input
        PWRDWN    => '0',
        RST       => not sys_mmcm_locked,   --fpga_reset,
        CLKFBIN   => user_clk_mmcm_fb   -- Feedback clock input
    );

    user_clk_BUFG_inst : BUFG
    port map (
        I => user_clk_mmcm, -- Clock input
        O => user_clk       -- Clock output
    );

    --user_clk <= sys_clk;

    --sys_clk    <= refclk_0;
    user_clk_o <= user_clk;
    --AI: Sys reset is synchronised with the user clock.
    user_rst_o <= user_fpga_rst;
    hmc_rst_o  <= sys_rst;
    hmc_clk_o  <= sys_clk;
    
---------------------------------------------------------------------------
-- RESETS
---------------------------------------------------------------------------

    pSysResetSynchroniser : process(user_mmcm_locked, FPGA_RESET_N, sys_clk)
    begin
       if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
           sys_fpga_rst <= '1';
           sync_sys_fpga_rst <= '1';
       elsif (rising_edge(sys_clk))then
          if (host_reset = '0') then
            sync_sys_fpga_rst <= '0';
            sys_fpga_rst <= sync_sys_fpga_rst;
          else
            sync_sys_fpga_rst <= '1';
            sys_fpga_rst <= '1';
          end if;  
       end if;
    end process;

    pUserResetSynchroniser : process(user_mmcm_locked, FPGA_RESET_N, user_clk)
    begin
       if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
           user_fpga_rst <= '1';
           sync_user_fpga_rst <= '1';
       elsif (rising_edge(user_clk))then
          if (host_reset_u3 = '0') then
            sync_user_fpga_rst <= '0';
            user_fpga_rst <= sync_user_fpga_rst;
          else
            sync_user_fpga_rst <= '1';
            user_fpga_rst <= '1';
          end if;  
       end if;
    end process;
    
   pBspResetSynchroniser : process(user_mmcm_locked, FPGA_RESET_N, bsp_clk)
    begin
        if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
            bsp_fpga_rst <= '1';
            sync_bsp_fpga_rst <= '1';
        elsif (rising_edge(bsp_clk))then
           if (host_reset_d3 = '0') then
             sync_bsp_fpga_rst <= '0';
             bsp_fpga_rst <= sync_bsp_fpga_rst;
           else
             sync_bsp_fpga_rst <= '1';
             bsp_fpga_rst <= '1';
           end if;  
        end if;
     end process;     
     
    sys_rst  <= sys_fpga_rst;
    --user_rst <= user_fpga_rst;
    bsp_rst <=  bsp_fpga_rst;
 
    pFpgaResetAuxSynchroniser : process(user_mmcm_locked, aux_clk, FPGA_RESET_N)
    begin
        if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
            sync_aux_fpga_rst <= '1';
            aux_fpga_rst <= '1';
        elsif (rising_edge(aux_clk))then
            sync_aux_fpga_rst <= '0';
            aux_fpga_rst <= sync_aux_fpga_rst;
        end if;
    end process; 

    pFpgaResetGmiiSynchroniser : process(user_mmcm_locked, gmii_clk, FPGA_RESET_N)
    begin
        if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
            sync_gmii_fpga_rst <= '1';
            gmii_fpga_rst <= '1';
        elsif (rising_edge(gmii_clk))then
            sync_gmii_fpga_rst <= '0';
            gmii_fpga_rst <= sync_gmii_fpga_rst;
        end if;
    end process;

    pFpgaResetQsfpSynchroniser : process(user_mmcm_locked, qsfp_gtrefclk, FPGA_RESET_N)
    begin
        if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
            sync_qsfp_fpga_rst <= '1';
            qsfp_fpga_rst <= '1';
        elsif (rising_edge(qsfp_gtrefclk))then
            sync_qsfp_fpga_rst <= '0';
            qsfp_fpga_rst <= sync_qsfp_fpga_rst;
        end if;
    end process; 
    
    pFpgaResetEmcclkSynchroniser : process(user_mmcm_locked, FPGA_EMCCLK2, FPGA_RESET_N)
    begin
        if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
            sync_emcclk_fpga_rst <= '1';
            emcclk_fpga_rst <= '1';
        elsif (rising_edge(FPGA_EMCCLK2))then
            sync_emcclk_fpga_rst <= '0';
            emcclk_fpga_rst <= sync_emcclk_fpga_rst;
        end if;
    end process;     

    FAN_CONT_RST_N <= FPGA_RESET_N;

    gen_gmii_rst : process(gmii_fpga_rst, gmii_clk)
    begin
        if (gmii_fpga_rst = '1')then
            gmii_rst <= '1';
            gmii_rst_z <= '1';
            gmii_rst_z2 <= '1';
            gmii_rst_z3 <= '1';
        elsif (rising_edge(gmii_clk))then
            -- GT 29/03/2017 KEEP gmii_rst ASSERTED WHEN SGMII LINK IS DOWN
            --if ((gmii_reset_done_z3 = '1')and(host_reset_z3 = '0'))then
            if ((sgmii_link_up_z3 = '1')and(host_reset_z3 = '0'))then
                gmii_rst_z <= '0';
                gmii_rst_z2 <= gmii_rst_z;
                gmii_rst_z3 <= gmii_rst_z2;
                gmii_rst <= gmii_rst_z3;
            else
                gmii_rst <= '1';
                gmii_rst_z <= '1';
                gmii_rst_z2 <= '1';
                gmii_rst_z3 <= '1';
            end if;
        end if;
    end process;

    gen_host_reset_req_z : process(sys_clk)
    begin
        if (rising_edge(sys_clk))then
            host_reset_req_z <= host_reset_req;
        end if;
    end process;

    gen_host_reset_count : process(user_mmcm_locked, FPGA_RESET_N, sys_clk)
    begin
        if (user_mmcm_locked = '0' or FPGA_RESET_N = '0')then
            host_reset_count <= (others => '1');
        elsif (rising_edge(sys_clk))then
            if ((host_reset_req_z = '0')and(host_reset_req = '1'))then
                host_reset_count <= (others => '0');
            else
                if (host_reset_count /= X"FF")then
                    host_reset_count <= host_reset_count + X"01";
                end if;
            end if;
        end if;
    end process;

    host_reset <= '0' when (host_reset_count = X"FF") else '1';

    --host reset synchronised to the gmii_clk
    gen_host_reset_z : process(gmii_clk)
    begin
        if (rising_edge(gmii_clk))then
            host_reset_z <= host_reset;
            host_reset_z2 <= host_reset_z;
            host_reset_z3 <= host_reset_z2;
        end if;
    end process;

    --host reset synchronised to the user_clk
    gen_host_reset_u : process(user_clk)
    begin
        if (rising_edge(user_clk))then
            host_reset_u <= host_reset;
            host_reset_u2 <= host_reset_u;
            host_reset_u3 <= host_reset_u2;
        end if;
    end process;
    
    --host reset synchronised to the bsp_clk
    gen_host_reset_d : process(bsp_clk)
    begin
        if (rising_edge(bsp_clk))then
            host_reset_d <= host_reset;
            host_reset_d2 <= host_reset_d;
            host_reset_d3 <= host_reset_d2;
        end if;
    end process;    

----------------------------------------------------------------------------
-- REGISTER CONNECTIONS
----------------------------------------------------------------------------

    brd_user_read_regs(C_RD_VERSION_ADDR) <= C_VERSION;

    brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(0) <= gmii_reset_done;


    brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(1) <= not MONITOR_ALERT_N;
    brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(2) <= not FAN_CONT_ALERT_N;
    brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(3) <= not FAN_CONT_FAULT_N;
    brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(4) <= ONE_GBE_LINK;
    brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(5) <= ONE_GBE_INT_N;


    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(6) <= one_gbe_packets_checked;
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(7) <= one_gbe_ramp_fault;
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(8) <= one_gbe_ip_fault;

    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(9) <= xlgmii_packets_checked(0);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(10) <= xlgmii_ramp_fault(0);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(11) <= xlgmii_ip_fault(0);

    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(12) <= xlgmii_packets_checked(1);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(13) <= xlgmii_ramp_fault(1);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(14) <= xlgmii_ip_fault(1);

    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(15) <= xlgmii_packets_checked(2);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(16) <= xlgmii_ramp_fault(2);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(17) <= xlgmii_ip_fault(2);

    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(18) <= xlgmii_packets_checked(3);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(19) <= xlgmii_ramp_fault(3);
    --brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(20) <= xlgmii_ip_fault(3);

    brd_user_read_regs(C_RD_BRD_CTL_STAT_0_ADDR)(31 downto 21) <= (others => '0');
    
    --1GbE data select (1 = 1 GbE data select, 0 = 1 GbE configuration only)
    select_one_gbe_data_sel  <= brd_user_write_regs(C_WR_BRD_CTL_STAT_0_ADDR)(1);
    mezzanine_fault_override <= brd_user_write_regs(C_WR_BRD_CTL_STAT_0_ADDR)(2);
    --enable_1gbe_packet_generation <= brd_user_write_regs(C_WR_BRD_CTL_STAT_0_ADDR)(3);
    --enable_40gbe_packet_generation <= brd_user_write_regs(C_WR_BRD_CTL_STAT_0_ADDR)(7 downto 4);
    timer_link <= brd_user_write_regs(C_WR_BRD_CTL_STAT_0_ADDR)(29 downto 27);
    host_reset_req <= brd_user_write_regs(C_WR_BRD_CTL_STAT_0_ADDR)(30);
    
    FPGA_ATX_PSU_KILL <= (brd_user_write_regs(C_WR_BRD_CTL_STAT_0_ADDR)(31) and brd_user_write_regs(C_WR_BRD_CTL_STAT_1_ADDR)(31));
    

    brd_user_read_regs(C_RD_LOOPBACK_ADDR) <= brd_user_write_regs(C_WR_LOOPBACK_ADDR);

    -- LINK UP STATUS
    -- GT 29/03/2017 INCLUDE 1GBE PHY LINK UP STATUS
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(0) <= '1' when ((status_vector(0) = '1')and(ONE_GBE_LINK = '1')) else '0'; -- 1GB ETH LINK UP
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(1) <= phy_rx_up_cpu(0); -- 40GB ETH 0 LINK UP
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(2) <= phy_rx_up_cpu(1); -- 40GB ETH 1 LINK UP
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(3) <= phy_rx_up_cpu(2); -- 40GB ETH 2 LINK UP
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(4) <= phy_rx_up_cpu(3); -- 40GB ETH 3 LINK UP
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(15 downto 5) <= (others => '0');

    -- LED STATUS
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(17 downto 16) <= xlgmii_txled(0); -- 40GBE ETH 0 TX
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(19 downto 18) <= xlgmii_rxled(0); -- 40GBE ETH 0 RX
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(21 downto 20) <= xlgmii_txled(1); -- 40GBE ETH 1 TX
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(23 downto 22) <= xlgmii_rxled(1); -- 40GBE ETH 1 RX
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(25 downto 24) <= xlgmii_txled(2); -- 40GBE ETH 2 TX
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(27 downto 26) <= xlgmii_rxled(2); -- 40GBE ETH 2 RX
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(29 downto 28) <= xlgmii_txled(3); -- 40GBE ETH 3 TX
    brd_user_read_regs(C_RD_ETH_IF_LINK_UP_ADDR)(31 downto 30) <= xlgmii_rxled(3); -- 40GBE ETH 3 RX


    qsfp_soft_reset(0) <= brd_user_write_regs(C_WR_ETH_IF_CTL_ADDR)(1);
    qsfp_soft_reset(1) <= brd_user_write_regs(C_WR_ETH_IF_CTL_ADDR)(2);
    qsfp_soft_reset(2) <= brd_user_write_regs(C_WR_ETH_IF_CTL_ADDR)(3);
    qsfp_soft_reset(3) <= brd_user_write_regs(C_WR_ETH_IF_CTL_ADDR)(4);

    -- Microblaze Alive Signal
    brd_user_read_regs(C_RD_UBLAZE_ALIVE_ADDR) <= brd_user_write_regs(C_WR_UBLAZE_ALIVE_ADDR);

    -- -- DSP Override signal for Front Panel LEDs
    brd_user_read_regs(C_RD_DSP_OVERRIDE_ADDR) <= brd_user_write_regs(C_WR_DSP_OVERRIDE_ADDR);
    
    --AI start: Add fortygbe config interface
    --fortygbe data select (1 = 40 GbE data select, 0 = 40 GbE configuration only)
    select_forty_gbe_data_sel  <= brd_user_write_regs(C_WR_BRD_CTL_STAT_1_ADDR)(1);
    
    --This is part of the configuration link auto-sensing function. If any of the 40GbE links are up then configuration
    --defaults to the 40GbE interface else it defaults to the 1GbE interface 
    fgbe_link_status <= phy_rx_up_cpu(0) or phy_rx_up_cpu(1) or phy_rx_up_cpu(2) or phy_rx_up_cpu(3);
    --Select whether configuration via forty_gbe interface or via 1GbE interface (0 = 1GbE, 1 = 40GbE)
    --This will override the auto-sensing select function (default is 40GbE)
    --Obviously if there is no 40GbE this will have no effect, as fbe_link_status will be '0' and hence, 1GbE will
    --be selected 
    fgbe_reg_sel <= not(brd_user_write_regs(C_WR_BRD_CTL_STAT_1_ADDR)(2)); --(0 = 1GbE, 1 = 40GbE)
    --Final Selection whether configuration via forty_gbe interface or via 1GbE interface (0 = 1GbE, 1 = 40GbE)
    fgbe_config_en <= fgbe_link_status and fgbe_reg_sel;
    --AI end: Add fortygbe config interface            

    -- MOVE 40GBE LINK UP TO sys_clk CLOCK DOMAIN
    gen_phy_rx_up_cpu : process(sys_clk)
    begin
        if (rising_edge(sys_clk))then
            for a in 0 to (C_NUM_40GBE_MAC - 1) loop
                phy_rx_up_z1(a) <= phy_rx_up(a);
                phy_rx_up_z2(a) <= phy_rx_up_z1(a);
                phy_rx_up_cpu(a) <= phy_rx_up_z2(a);
            end loop;
        end if;
    end process;



    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(0) <= not MEZZANINE_0_PRESENT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(1) <= not MEZZANINE_1_PRESENT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(2) <= not MEZZANINE_2_PRESENT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(3) <= not MEZZANINE_3_PRESENT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(7 downto 4) <= (others => '0');

    mezzanine_0_fault <= (not MEZZANINE_0_FAULT_N) when (mezzanine_0_fault_checking_enable = '1') else '0';
    mezzanine_1_fault <= (not MEZZANINE_1_FAULT_N) when (mezzanine_1_fault_checking_enable = '1') else '0';
    mezzanine_2_fault <= (not MEZZANINE_2_FAULT_N) when (mezzanine_2_fault_checking_enable = '1') else '0';
    mezzanine_3_fault <= (not MEZZANINE_3_FAULT_N) when (mezzanine_3_fault_checking_enable = '1') else '0';

    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(8) <= mezzanine_0_fault;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(9) <= mezzanine_1_fault;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(10) <= mezzanine_2_fault;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(11) <= mezzanine_3_fault;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(15 downto 12) <= (others => '0');

    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(16) <= not MEZZANINE_0_INT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(17) <= not MEZZANINE_1_INT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(18) <= not MEZZANINE_2_INT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(19) <= not MEZZANINE_3_INT_N;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_0_ADDR)(31 downto 20) <= (others => '0');

    mezzanine_0_enable <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(0);
    mezzanine_1_enable <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(1);
    mezzanine_2_enable <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(2);
    mezzanine_3_enable <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(3);
    
    
    --MEZZANINE STATUS 1 REGISTER (MEZZ0)
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(0) <= ((not MEZZANINE_0_PRESENT_N) and MEZZ0_PRESENT);
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(3 downto 1) <= MEZZ0_ID;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(4) <= HMC_MEZZ0_INIT_DONE;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(5) <= HMC_MEZZ0_POST_OK;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(7 downto 6) <= (others => '0');    
    
    --MEZZANINE STATUS 1 REGISTER (MEZZ1)
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(8) <= ((not MEZZANINE_1_PRESENT_N) and MEZZ1_PRESENT);
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(11 downto 9) <= MEZZ1_ID;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(12) <= HMC_MEZZ1_INIT_DONE;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(13) <= HMC_MEZZ1_POST_OK;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(15 downto 14) <= (others => '0');    
    
    --MEZZANINE STATUS 1 REGISTER (MEZZ2)
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(16) <= ((not MEZZANINE_2_PRESENT_N) and MEZZ2_PRESENT);
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(19 downto 17) <= MEZZ2_ID;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(20) <= HMC_MEZZ2_INIT_DONE;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(21) <= HMC_MEZZ2_POST_OK;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(23 downto 22) <= (others => '0');    

    --MEZZANINE STATUS 1 REGISTER (MEZZ3)
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(24) <= ((not MEZZANINE_3_PRESENT_N) and MEZZ3_PRESENT);
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(27 downto 25) <= MEZZ3_ID;
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(28) <= '0';
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(29) <= '0';
    brd_user_read_regs(C_RD_MEZZANINE_STAT_1_ADDR)(31 downto 30) <= (others => '0');  
     
    
    mezzanine_enable_delay_0 : mezzanine_enable_delay
    port map(
        clk => bsp_clk,
        rst => bsp_rst,
        second_toggle                    => second_toggle,
        mezzanine_enable                 => mezzanine_0_enable,
        mezzanine_fault_checking_enable  => mezzanine_0_fault_checking_enable);

    mezzanine_enable_delay_1 : mezzanine_enable_delay
    port map(
        clk => bsp_clk,
        rst => bsp_rst,
        second_toggle                    => second_toggle,
        mezzanine_enable                 => mezzanine_1_enable,
        mezzanine_fault_checking_enable  => mezzanine_1_fault_checking_enable);

    mezzanine_enable_delay_2 : mezzanine_enable_delay
    port map(
        clk => bsp_clk,
        rst => bsp_rst,
        second_toggle                    => second_toggle,
        mezzanine_enable                 => mezzanine_2_enable,
        mezzanine_fault_checking_enable  => mezzanine_2_fault_checking_enable);

    mezzanine_enable_delay_3 : mezzanine_enable_delay
    port map(
        clk => bsp_clk,
        rst => bsp_rst,
        second_toggle                    => second_toggle,
        mezzanine_enable                 => mezzanine_3_enable,
        mezzanine_fault_checking_enable  => mezzanine_3_fault_checking_enable);

    MEZZANINE_0_ENABLE_N <= not mezzanine_0_enable;
    MEZZANINE_1_ENABLE_N <= not mezzanine_1_enable;
    MEZZANINE_2_ENABLE_N <= not mezzanine_2_enable;
    MEZZANINE_3_ENABLE_N <= not mezzanine_3_enable;

    --MEZZANINE_3_ENABLE_N <= not mezzanine_3_enable;
    --MEZZANINE_0_RESET <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(8) or bsp_rst;
    --MEZZANINE_1_RESET <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(9) or bsp_rst;
    --MEZZANINE_2_RESET <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(10) or bsp_rst;    
    MEZZANINE_3_RESET <= brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(11) or bsp_rst;

    MEZZANINE_3_CLK_SEL <= not brd_user_write_regs(C_WR_MEZZANINE_CTL_ADDR)(19); -- DEFAULT '1' = MEZZANINE CLOCK

    --MEZZANINE_COMBINED_FAULT <= mezzanine_fault_override or mezzanine_3_fault;
    
    MEZZANINE_COMBINED_FAULT <= mezzanine_fault_override or mezzanine_0_fault or mezzanine_1_fault or mezzanine_2_fault or mezzanine_3_fault;


    brd_user_read_regs(C_RD_USB_STAT_ADDR)(3 downto 0) <= USB_FPGA;
    brd_user_read_regs(C_RD_USB_STAT_ADDR)(7 downto 4) <= (others => '0');
    brd_user_read_regs(C_RD_USB_STAT_ADDR)(8) <= USB_I2C_CTRL;
    brd_user_read_regs(C_RD_USB_STAT_ADDR)(31 downto 9) <= (others => '0');

    USB_UART_RXD <= microblaze_uart_txd;
    -- USB SERIAL CURRENTLY NOT USED FOR RECEIVING
    --USB_UART_TXD

    --brd_user_read_regs(C_RD_AUX_CLK_FREQ_ADDR) <= aux_clk_frequency;

    brd_user_read_regs(C_RD_MEZZANINE_CLK_FREQ_ADDR) <= qsfp_xl_tx_clk_156m25_frequency;

    brd_user_read_regs(C_RD_CONFIG_CLK_FREQ_ADDR) <= fpga_emcclk2_frequency;

    USR_ACCESSE2_0 : USR_ACCESSE2
    port map (
        CFGCLK      => open,
        DATA        => brd_user_read_regs(C_RD_SOC_VERSION_ADDR),
        DATAVALID   => open);

    brd_user_read_regs(C_RD_FPGA_DNA_LOW_ADDR) <= fpga_dna(31 downto 0);
    brd_user_read_regs(C_RD_FPGA_DNA_HIGH_ADDR) <= fpga_dna(63 downto 32);

---------------------------------------------------------------------------
-- AUX CONNECTIONS
---------------------------------------------------------------------------

    --aux_clk_ibufds : IBUFDS
    --generic map (
    --    DIFF_TERM => TRUE)
    --port map (
    --    O  => aux_clk,
    --    I  => AUX_CLK_P,
    --    IB => AUX_CLK_N);

    --aux_synci_ibufds : IBUFDS
    --generic map (
    --    DIFF_TERM => TRUE)
    --port map (
    --    O  => aux_synci,
    --    I  => AUX_SYNCI_P,
    --    IB => AUX_SYNCI_N);

    --aux_sync_gen_0 : aux_sync_gen
    --port map(
    --    clk => sys_clk,
    --    rst => sys_rst,
    --    aux_sync_out    => aux_synco);

    --aux_synco_obufds : OBUFDS
    --port map (
    --    I  => aux_synco,
    --    O  => AUX_SYNCO_P,
    --    OB => AUX_SYNCO_N);

    --clock_frequency_measure_0 : clock_frequency_measure
    --port map(
    --    clk => aux_clk,
    --    rst => fpga_reset,
    --    second_toggle   => second_toggle,
    --    measure_freq    => aux_clk_frequency);

    

---------------------------------------------------------------------------
-- BLOCK DESIGN WRAPPER
---------------------------------------------------------------------------

    cont_microblaze_wrapper_0 : cont_microblaze_wrapper
    port map(
        ACK_I       => WB_MST_ACK_I,
        ADR_O       => WB_MST_ADR_O,
        CYC_O       => WB_MST_CYC_O,
        Clk         => bsp_clk,
        DAT_I       => WB_MST_DAT_I,
        DAT_O       => WB_MST_DAT_O,
        RST_O       => WB_MST_RST_O,
        Reset       => bsp_rst,
        SEL_O       => WB_MST_SEL_O,
        STB_O       => WB_MST_STB_O,
        UART_rxd    => microblaze_uart_rxd,
        UART_txd    => microblaze_uart_txd,
        WE_O        => WB_MST_WE_O,
        dcm_locked  => user_mmcm_locked);
        


    microblaze_uart_rxd <= DEBUG_UART_RX;
    DEBUG_UART_TX <= microblaze_uart_txd;

----------------------------------------------------------------------------
-- WISHBONE SLAVES
----------------------------------------------------------------------------

    wishbone_interconnect_0 : wishbone_interconnect
    port map(
        CLK_I => bsp_clk,
        RST_I => bsp_rst,
        MST_DAT_O => WB_MST_DAT_O,
        MST_DAT_I => WB_MST_DAT_I,
        MST_ACK_I => WB_MST_ACK_I,
        MST_ADR_O => WB_MST_ADR_O,
        MST_CYC_O => WB_MST_CYC_O,
        MST_SEL_O => WB_MST_SEL_O,
        MST_STB_O => WB_MST_STB_O,
        MST_WE_O  => WB_MST_WE_O,
        SLV_DAT_O => WB_SLV_DAT_O,
        SLV_DAT_I => WB_SLV_DAT_I,
        SLV_ACK_O => WB_SLV_ACK_O,
        SLV_ADR_I => WB_SLV_ADR_I,
        SLV_CYC_I => WB_SLV_CYC_I,
        SLV_SEL_I => WB_SLV_SEL_I,
        SLV_STB_I => WB_SLV_STB_I,
        SLV_WE_I  => WB_SLV_WE_I);

    -- WISHBONE SLAVE 0 - BOARD READ/WRITE REGISTERS 1
    wishbone_register_0 : wishbone_register
    port map(
        CLK_I => bsp_clk,
        RST_I => bsp_rst,
        DAT_I => WB_SLV_DAT_I(0),
        DAT_O => WB_SLV_DAT_O(0),
        ACK_O => WB_SLV_ACK_O(0),
        ADR_I => WB_SLV_ADR_I(0)((C_NUM_REGISTER_ADDRESS_BITS + 1) downto 0),
        CYC_I => WB_SLV_CYC_I(0),
        SEL_I => WB_SLV_SEL_I(0),
        STB_I => WB_SLV_STB_I(0),
        WE_I  => WB_SLV_WE_I(0),
        user_read_regs    => brd_user_read_regs,
        user_write_regs   => brd_user_write_regs);

    -- WISHBONE SLAVE 1 - BOARD READ/WRITE REGISTERS 2
    --wishbone_register_1 : wishbone_register
    --port map(
    --    CLK_I => sys_clk,
    --    RST_I => sys_rst,
    --    DAT_I => WB_SLV_DAT_I(1),
    --    DAT_O => WB_SLV_DAT_O(1),
    --    ACK_O => WB_SLV_ACK_O(1),
    --    ADR_I => WB_SLV_ADR_I(1)((C_NUM_REGISTER_ADDRESS_BITS + 1) downto 0),
    --    CYC_I => WB_SLV_CYC_I(1),
    --    SEL_I => WB_SLV_SEL_I(1),
    --    STB_I => WB_SLV_STB_I(1),
    --    WE_I  => WB_SLV_WE_I(1),
    --    user_read_regs    => brd_user_read_regs_2,
    --    user_write_regs   => brd_user_write_regs_2);

    -- WISHBONE SLAVE 2 - FLASH/SDRAM RECONFIGURATION
    FLASH_A <= flash_a_i(28 downto 0) when (flash_output_enable = '1') else (others => 'Z');

    FLASH_DQ <= flash_dq_out when ((flash_dq_out_en = '1')and(flash_output_enable = '1')) else (others => 'Z');

    wishbone_flash_sdram_interface_0 : wishbone_flash_sdram_interface
    port map(
        CLK_I => bsp_clk,
        RST_I => bsp_rst,
        DAT_I => WB_SLV_DAT_I(2),
        DAT_O => WB_SLV_DAT_O(2),
        ACK_O => WB_SLV_ACK_O(2),
        ADR_I => WB_SLV_ADR_I(2)(14 downto 0),
        CYC_I => WB_SLV_CYC_I(2),
        SEL_I => WB_SLV_SEL_I(2),
        STB_I => WB_SLV_STB_I(2),
        WE_I  => WB_SLV_WE_I(2),
        gbe_app_clk             => sys_clk,
        gbe_rx_valid            => gmii_rx_valid_flash_sdram_controller,
        gbe_rx_end_of_frame     => gmii_rx_end_of_frame_flash_sdram_controller,
        gbe_rx_data             => gmii_rx_data,
        gbe_rx_source_ip        => gmii_rx_source_ip,
        gbe_rx_source_port      => gmii_rx_source_port,
        gbe_rx_bad_frame        => gmii_rx_bad_frame,
        gbe_rx_overrun          => gmii_rx_overrun,
        gbe_rx_overrun_ack      => gmii_rx_overrun_ack_flash_sdram_controller,
        gbe_rx_ack              => gmii_rx_ack_flash_sdram_controller,
        --AI Start: Added fortygbe interface for configuration
        fgbe_config_en          => fgbe_config_en,  -- if '1' SDRAM/Flash configuration is done via forty GbE else via 1 GbE
        fgbe_app_clk            => sys_clk,
        fgbe_rx_valid           => xlgmii_rx_valid_flash_sdram_controller(0), --xlgmii_rx_valid(0),
        fgbe_rx_end_of_frame    => xlgmii_rx_end_of_frame_flash_sdram_controller(0),--xlgmii_rx_end_of_frame(0),
        fgbe_rx_data            => xlgmii_rx_data,
        fgbe_rx_source_ip       => xlgmii_rx_source_ip,
        fgbe_rx_source_port     => xlgmii_rx_source_port,
        fgbe_rx_bad_frame       => xlgmii_rx_bad_frame,
        fgbe_rx_overrun         => xlgmii_rx_overrun,
        fgbe_rx_overrun_ack     => xlgmii_rx_overrun_ack_flash_sdram_controller(0),--xlgmii_rx_overrun_ack(0),
        fgbe_rx_ack             => xlgmii_rx_ack_flash_sdram_controller(0),--xlgmii_rx_ack(0),
        --AI End: Added fortygbe interface for configuration
        fpga_emcclk     => '0',
        fpga_emcclk2    => '0',
        flash_dq_in     => FLASH_DQ,
        flash_dq_out    => flash_dq_out,
        flash_dq_out_en => flash_dq_out_en,
        flash_a         => flash_a_i,
        flash_cs_n      => flash_cs_n_i,
        flash_oe_n      => flash_oe_n_i,
        flash_we_n      => flash_we_n_i,
        flash_adv_n     => flash_adv_n_i,
        flash_rs0       => flash_rs0_i,
        flash_rs1       => flash_rs1_i,
        flash_wait      => '0',
        flash_output_enable => flash_output_enable,
        spartan_clk => spartan_clk_i,
        config_io_0 => config_io_0_i,
        config_io_1 => config_io_1_i,
        config_io_2 => config_io_2_i,
        config_io_3 => config_io_3_i,
        config_io_4 => config_io_4_i,
        config_io_5 => config_io_5_i,
        config_io_6 => config_io_6_i,
        config_io_7 => config_io_7_i,
        config_io_8 => config_io_8_i,
        config_io_9 => config_io_9_i,
        config_io_10 => config_io_10_i,
        config_io_11 => config_io_11_i,
        spi_miso => spi_miso_i,
        spi_mosi => spi_mosi_i,
        spi_csb  => spi_csb_i,
        spi_clk  => spi_clk_i,
        debug_sdram_program_header  => open);

        FLASH_RS0 <= flash_rs0_i when (flash_output_enable = '1') else 'Z';
        FLASH_RS1 <= flash_rs1_i when (flash_output_enable = '1') else 'Z';

        FLASH_CS_N <= flash_cs_n_i when (flash_output_enable = '1') else 'Z';
        FLASH_OE_N <= flash_oe_n_i when (flash_output_enable = '1') else 'Z';
        FLASH_WE_N <= flash_we_n_i when (flash_output_enable = '1') else 'Z';
        FLASH_ADV_N <= flash_adv_n_i when (flash_output_enable = '1') else 'Z';

        SPARTAN_CLK <= spartan_clk_i;
        CONFIG_IO_0 <= config_io_0_i;
        CONFIG_IO_1 <= config_io_1_i;
        config_io_2_i <= CONFIG_IO_2;
        CONFIG_IO_3 <= config_io_3_i;
        CONFIG_IO_4 <= config_io_4_i;
        config_io_5_i <= CONFIG_IO_5;
        CONFIG_IO_6 <= config_io_6_i;
        CONFIG_IO_7 <= config_io_7_i;
        CONFIG_IO_8 <= config_io_8_i;
        CONFIG_IO_9 <= config_io_9_i;
        CONFIG_IO_10 <= config_io_10_i;
        CONFIG_IO_11 <= config_io_11_i;

        spi_miso_i <= SPI_MISO;
        SPI_MOSI <= spi_mosi_i;
        SPI_CSB  <= spi_csb_i;
        SPI_CLK  <= spi_clk_i;

    -- WISHBONE SLAVE 3 - ONE WIRE INTERFACES
    wishbone_one_wire_0 : wishbone_one_wire
    generic map(
        NUM_ONE_WIRE_INTERFACES => 5)
    port map(
        CLK_I => bsp_clk,
        RST_I => bsp_rst,
        DAT_I => WB_SLV_DAT_I(3),
        DAT_O => WB_SLV_DAT_O(3),
        ACK_O => WB_SLV_ACK_O(3),
        ADR_I => WB_SLV_ADR_I(3)(2 downto 0),
        CYC_I => WB_SLV_CYC_I(3),
        SEL_I => WB_SLV_SEL_I(3),
        STB_I => WB_SLV_STB_I(3),
        WE_I  => WB_SLV_WE_I(3),
        one_wire_pull_down_enable         => one_wire_pull_down_enable,
        one_wire_in                       => one_wire_in,
        one_wire_strong_pull_up_enable    => one_wire_strong_pull_up_enable_i);

    ONE_WIRE_EEPROM <= '0' when ((one_wire_pull_down_enable(0) = '1')and(one_wire_strong_pull_up_enable_i(0) = '0'))else 'Z';
    one_wire_in(0) <= ONE_WIRE_EEPROM;


    ONE_WIRE_EEPROM_STRONG_PULLUP_EN_N <= not one_wire_strong_pull_up_enable_i(0);

    MEZZANINE_0_ONE_WIRE <= '0' when ((one_wire_pull_down_enable(1) = '1')and(one_wire_strong_pull_up_enable_i(1) = '0')) else 'Z';
    one_wire_in(1) <= MEZZANINE_0_ONE_WIRE;
    MEZZANINE_0_ONE_WIRE_STRONG_PULLUP_EN_N <= not one_wire_strong_pull_up_enable_i(1);

    MEZZANINE_1_ONE_WIRE <= '0' when ((one_wire_pull_down_enable(2) = '1')and(one_wire_strong_pull_up_enable_i(2) = '0')) else 'Z';
    one_wire_in(2) <= MEZZANINE_1_ONE_WIRE;
    MEZZANINE_1_ONE_WIRE_STRONG_PULLUP_EN_N <= not one_wire_strong_pull_up_enable_i(2);

    MEZZANINE_2_ONE_WIRE <= '0' when ((one_wire_pull_down_enable(3) = '1')and(one_wire_strong_pull_up_enable_i(3) = '0')) else 'Z';
    one_wire_in(3) <= MEZZANINE_2_ONE_WIRE;
    MEZZANINE_2_ONE_WIRE_STRONG_PULLUP_EN_N <= not one_wire_strong_pull_up_enable_i(3);

    MEZZANINE_3_ONE_WIRE <= '0' when ((one_wire_pull_down_enable(4) = '1')and(one_wire_strong_pull_up_enable_i(4) = '0')) else 'Z';
    one_wire_in(4) <= MEZZANINE_3_ONE_WIRE;
    MEZZANINE_3_ONE_WIRE_STRONG_PULLUP_EN_N <= not one_wire_strong_pull_up_enable_i(4);

    -- WISHBONE SLAVE 4, 5, 6, 7, 8 - I2C INTERFACES
    generate_I2C_0_to_4 : for a in 0 to 4 generate
        wishbone_i2c_0_to_4 : wishbone_i2c
        port map(
            CLK_I => bsp_clk,
            RST_I => bsp_rst,
            DAT_I => WB_SLV_DAT_I(4 + a),
            DAT_O => WB_SLV_DAT_O(4 + a),
            ACK_O => WB_SLV_ACK_O(4 + a),
            ADR_I => WB_SLV_ADR_I(4 + a)(4 downto 0),
            CYC_I => WB_SLV_CYC_I(4 + a),
            SEL_I => WB_SLV_SEL_I(4 + a),
            STB_I => WB_SLV_STB_I(4 + a),
            WE_I  => WB_SLV_WE_I(4 + a),
            scl_pad_i     => i2c_scl_pad_i(a),
            scl_pad_o     => i2c_scl_pad_o(a),
            scl_padoen_o  => i2c_scl_padoen_o(a),
            sda_pad_i     => i2c_sda_pad_i(a),
            sda_pad_o     => i2c_sda_pad_o(a),
            sda_padoen_o  => i2c_sda_padoen_o(a));
    end generate generate_I2C_0_to_4;



    I2C_RESET_FPGA <= sys_fpga_rst;

    I2C_SCL_FPGA <= i2c_scl_pad_o(0) when (i2c_scl_padoen_o(0) = '0') else 'Z';
    I2C_SDA_FPGA <= i2c_sda_pad_o(0) when (i2c_sda_padoen_o(0) = '0') else 'Z';
    i2c_scl_pad_i(0) <= I2C_SCL_FPGA;
    i2c_sda_pad_i(0) <= I2C_SDA_FPGA;

    --AI Start: Only need one I2C bus for Mezzanine Site 3
    --MEZZANINE_0_SCL_FPGA <= i2c_scl_pad_o(1) when (i2c_scl_padoen_o(1) = '0') else 'Z';
    --MEZZANINE_0_SDA_FPGA <= i2c_sda_pad_o(1) when (i2c_sda_padoen_o(1) = '0') else 'Z';
    --i2c_scl_pad_i(1) <= MEZZANINE_0_SCL_FPGA;
    --i2c_sda_pad_i(1) <= MEZZANINE_0_SDA_FPGA;

    --MEZZANINE_1_SCL_FPGA <= i2c_scl_pad_o(2) when (i2c_scl_padoen_o(2) = '0') else 'Z';
    --MEZZANINE_1_SDA_FPGA <= i2c_sda_pad_o(2) when (i2c_sda_padoen_o(2) = '0') else 'Z';
    --i2c_scl_pad_i(2) <= MEZZANINE_1_SCL_FPGA;
    --i2c_sda_pad_i(2) <= MEZZANINE_1_SDA_FPGA;

    --MEZZANINE_2_SCL_FPGA <= i2c_scl_pad_o(3) when (i2c_scl_padoen_o(3) = '0') else 'Z';
    --MEZZANINE_2_SDA_FPGA <= i2c_sda_pad_o(3) when (i2c_sda_padoen_o(3) = '0') else 'Z';
    --i2c_scl_pad_i(3) <= MEZZANINE_2_SCL_FPGA;
    --i2c_sda_pad_i(3) <= MEZZANINE_2_SDA_FPGA;
    --AI En: Only need one I2C bus for Mezzanine Site 3

    MEZZANINE_3_SCL_FPGA <= i2c_scl_pad_o(4) when (i2c_scl_padoen_o(4) = '0') else 'Z';
    MEZZANINE_3_SDA_FPGA <= i2c_sda_pad_o(4) when (i2c_sda_padoen_o(4) = '0') else 'Z';
    i2c_scl_pad_i(4) <= MEZZANINE_3_SCL_FPGA;
    i2c_sda_pad_i(4) <= MEZZANINE_3_SDA_FPGA;
    
    -- HMC IIC MUX
    MEZZANINE_0_SCL_FPGA <= shmc_mezz0_scl_out when (HMC_MEZZ0_INIT_DONE = '0') else i2c_scl_pad_o(1) when (i2c_scl_padoen_o(1) = '0') else 'Z';
    MEZZANINE_0_SDA_FPGA <= shmc_mezz0_sda_out when (HMC_MEZZ0_INIT_DONE = '0') else i2c_sda_pad_o(1) when (i2c_sda_padoen_o(1) = '0') else 'Z';
    i2c_scl_pad_i(1) <= MEZZANINE_0_SCL_FPGA;
    i2c_sda_pad_i(1) <= MEZZANINE_0_SDA_FPGA;
    shmc_mezz0_scl_in <= MEZZANINE_0_SCL_FPGA;
    shmc_mezz0_sda_in <= MEZZANINE_0_SDA_FPGA; 

    MEZZANINE_1_SCL_FPGA <= shmc_mezz1_scl_out when (HMC_MEZZ1_INIT_DONE = '0') else i2c_scl_pad_o(2) when (i2c_scl_padoen_o(2) = '0') else 'Z';
    MEZZANINE_1_SDA_FPGA <= shmc_mezz1_sda_out when (HMC_MEZZ1_INIT_DONE = '0') else i2c_sda_pad_o(2) when (i2c_sda_padoen_o(2) = '0') else 'Z';
    i2c_scl_pad_i(2) <= MEZZANINE_1_SCL_FPGA;
    i2c_sda_pad_i(2) <= MEZZANINE_1_SDA_FPGA;
    shmc_mezz1_scl_in <= MEZZANINE_1_SCL_FPGA;
    shmc_mezz1_sda_in <= MEZZANINE_1_SDA_FPGA; 

    MEZZANINE_2_SCL_FPGA <= shmc_mezz2_scl_out when (HMC_MEZZ2_INIT_DONE = '0') else  i2c_scl_pad_o(3) when (i2c_scl_padoen_o(3) = '0') else 'Z';
    MEZZANINE_2_SDA_FPGA <= shmc_mezz2_sda_out when (HMC_MEZZ2_INIT_DONE = '0') else  i2c_sda_pad_o(3) when (i2c_sda_padoen_o(3) = '0') else 'Z';
    i2c_scl_pad_i(3) <= MEZZANINE_2_SCL_FPGA;
    i2c_sda_pad_i(3) <= MEZZANINE_2_SDA_FPGA;
    shmc_mezz2_scl_in <= MEZZANINE_2_SCL_FPGA;
    shmc_mezz2_sda_in <= MEZZANINE_2_SDA_FPGA; 
    
    --HMC Mezzanine 0 signal assignments 
    shmc_mezz0_scl_out <= HMC_MEZZ0_SCL_IN;
    shmc_mezz0_sda_out <= HMC_MEZZ0_SDA_IN;
    HMC_MEZZ0_SCL_OUT <= shmc_mezz0_scl_in; 
    HMC_MEZZ0_SDA_OUT <= shmc_mezz0_sda_in; 
      
    --HMC Mezzanine 1 signal assignments
    
    shmc_mezz1_scl_out <= HMC_MEZZ1_SCL_IN;
    shmc_mezz1_sda_out <= HMC_MEZZ1_SDA_IN;
    HMC_MEZZ1_SCL_OUT <= shmc_mezz1_scl_in; 
    HMC_MEZZ1_SDA_OUT <= shmc_mezz1_sda_in;     
    
    --HMC Mezzanine 2 signal assignments
    shmc_mezz2_scl_out <= HMC_MEZZ2_SCL_IN;
    shmc_mezz2_sda_out <= HMC_MEZZ2_SDA_IN;
    HMC_MEZZ2_SCL_OUT <= shmc_mezz2_scl_in; 
    HMC_MEZZ2_SDA_OUT <= shmc_mezz2_sda_in; 

    -- WISHBONE SLAVE 9 - 1GBE MAC
    kat_ten_gb_eth_0 : kat_ten_gb_eth
    generic map(
        FABRIC_MAC     => X"FFFFFFFFFFFF",
        FABRIC_IP      => X"FFFFFFFF",
        FABRIC_PORT    => X"FFFF",
        FABRIC_NETMASK => X"FFFFFF00",
        FABRIC_GATEWAY => X"FF",
        FABRIC_ENABLE  => '0',
        FABRIC_MC_RECV_IP      => X"FFFFFFFF",
        FABRIC_MC_RECV_IP_MASK => X"FFFFFFFF",
        PREEMPHASIS       => "0100",
        POSTEMPHASIS      => "00000",
        DIFFCTRL          => "1010",
        RXEQMIX           => "111",
        CPU_TX_ENABLE     => 1,
        CPU_RX_ENABLE     => 1,
        RX_DIST_RAM       => 0,
        LARGE_PACKETS     => 1,
        TTL               => 1,
        PROMISC_MODE      => 0)
    port map(
        clk => sys_clk,
        rst => sys_rst,
        tx_valid            => gmii_tx_valid,
        tx_end_of_frame     => gmii_tx_end_of_frame,
        tx_data             => gmii_tx_data,
        tx_dest_ip          => gmii_tx_dest_ip,
        tx_dest_port        => gmii_tx_dest_port,
        tx_overflow         => gmii_tx_overflow,
        tx_afull            => gmii_tx_afull,
        rx_valid            => gmii_rx_valid,
        rx_end_of_frame     => gmii_rx_end_of_frame,
        rx_data             => gmii_rx_data,
        rx_source_ip        => gmii_rx_source_ip,
        rx_source_port      => gmii_rx_source_port,
        rx_bad_frame        => gmii_rx_bad_frame,
        rx_overrun          => gmii_rx_overrun,
        rx_overrun_ack      => gmii_rx_overrun_ack,
        rx_ack              => gmii_rx_ack,
        CLK_I => bsp_clk,
        RST_I => bsp_rst,
        DAT_I => WB_SLV_DAT_I(9),
        DAT_O => WB_SLV_DAT_O(9),
        ACK_O => WB_SLV_ACK_O(9),
        ADR_I => WB_SLV_ADR_I(9)(13 downto 0),
        CYC_I => WB_SLV_CYC_I(9),
        SEL_I => WB_SLV_SEL_I(9),
        STB_I => WB_SLV_STB_I(9),
        WE_I  => WB_SLV_WE_I(9),
        --led_up => led_up,
        --led_rx => led_rx,
        --led_tx => led_tx,
        xaui_clk        => sys_clk,
        xaui_reset      => sys_rst,
        xaui_status     => gmii_xaui_status,
        xgmii_txd       => gmii_xgmii_txd,
        xgmii_txc       => gmii_xgmii_txc,
        xgmii_rxd       => gmii_xgmii_rxd,
        xgmii_rxc       => gmii_xgmii_rxc,
        mgt_rxeqmix         => open,
        mgt_txpreemphasis   => open,
        mgt_txpostemphasis  => open,
        mgt_txdiffctrl      => open,
        src_ip_address      => gmii_src_ip_address,
        src_mac_address     => gmii_src_mac_address,
        src_enable          => gmii_src_enable,
        src_port            => gmii_src_port,
        src_gateway         => gmii_src_gateway,
        src_local_mc_recv_ip        => gmii_src_local_mc_recv_ip,
        src_local_mc_recv_ip_mask   => gmii_src_local_mc_recv_ip_mask);

    gen_xaui_packets_sent : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            xaui_packets_sent <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if ((gmii_xgmii_txc = X"01")and(gmii_xgmii_txd(7 downto 0) = X"FB"))then
                xaui_packets_sent <= xaui_packets_sent + X"0001";
            end if;
        end if;
    end process;

    gen_gmii_xaui_status : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            gmii_xaui_status <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (status_vector(0) = '1')then
                gmii_xaui_status <= "11111100";
            else
                gmii_xaui_status <= (others => '0');
            end if;
        end if;
    end process;

    --AI Start: Added fortygbe config interface
    -- MUX BETWEEN FLASH_SDRAM CONTROLLER AND 1GbE Data Streaming
    gmii_rx_valid_flash_sdram_controller <= gmii_rx_valid when (select_one_gbe_data_sel  = '0') else '0';
    gmii_rx_end_of_frame_flash_sdram_controller <= gmii_rx_end_of_frame when (select_one_gbe_data_sel  = '0') else '0';

    --gmii_rx_valid_ramp_checker <= gmii_rx_valid when (select_one_gbe_data_sel  = '1') else '0';
    --gmii_rx_end_of_frame_ramp_checker <= gmii_rx_end_of_frame when (select_one_gbe_data_sel  = '1') else '0';

    gmii_rx_overrun_ack <= gmii_rx_overrun_ack_flash_sdram_controller when (select_one_gbe_data_sel  = '0') else gmii_rx_overrun_ack_ramp_checker;
    gmii_rx_ack <= gmii_rx_ack_flash_sdram_controller when (select_one_gbe_data_sel  = '0') else gmii_rx_ack_ramp_checker;

    -- MUX BETWEEN FLASH_SDRAM CONTROLLER AND 40GbE Data Streaming on link 1 (Eth 0)
    xlgmii_rx_valid_flash_sdram_controller(0) <= xlgmii_rx_valid when (select_forty_gbe_data_sel  = '0') else "0000";
    xlgmii_rx_end_of_frame_flash_sdram_controller(0) <= xlgmii_rx_end_of_frame when (select_forty_gbe_data_sel  = '0') else '0';

    --xlgmii_rx_valid_ramp_checker(0) <= xlgmii_rx_valid when (select_forty_gbe_data_sel  = '1') else "0000";
    --xlgmii_rx_end_of_frame_ramp_checker(0) <= xlgmii_rx_end_of_frame when (select_forty_gbe_data_sel  = '1') else '0';

    --xlgmii_rx_overrun_ack <= xlgmii_rx_overrun_ack_flash_sdram_controller(0) when (select_forty_gbe_data_sel  = '0') else xlgmii_rx_overrun_ack_ramp_checker(0);
    --xlgmii_rx_ack <= xlgmii_rx_ack_flash_sdram_controller(0) when (select_forty_gbe_data_sel  = '0') else xlgmii_rx_ack_ramp_checker(0);
    xlgmii_rx_overrun_ack <= xlgmii_rx_overrun_ack_flash_sdram_controller(0) when (select_forty_gbe_data_sel  = '0') else forty_gbe_rx_overrun_ack;
    xlgmii_rx_ack <= xlgmii_rx_ack_flash_sdram_controller(0) when (select_forty_gbe_data_sel  = '0') else forty_gbe_rx_ack;
    --AI End: Added fortygbe config interface
    
    --AI: Allows 40GbE configuration using the system clock and normal 40GbE data interfacing using the user clock
    --fpga_user_sysclk_bufgmux_ctrl : BUFGMUX_CTRL
    --port map (
    --    I0 => sys_clk,
    --    I1 => user_clk,
    --    S  => select_forty_gbe_data_sel,
    --    O  => forty_gb_eth_clk);  
        
    --AI: Allows 40GbE configuration using the system reset and normal 40GbE data interfacing using the user reset    
    --forty_gb_eth_rst <= sys_rst when (select_forty_gbe_data_sel  = '0') else user_rst; 
    
    --AI: 40GbE Yellow Block Reset  or'd with user_rst
    user_40gbe_rst <= forty_gbe_rst or user_fpga_rst;

    -- WISHBONE SLAVE 10 - 40GBE MAC 0
    ska_forty_gb_eth_0 : ska_forty_gb_eth
    generic map(
        FABRIC_MAC        => FABRIC_MAC,
        FABRIC_IP         => FABRIC_IP,
        FABRIC_PORT       => FABRIC_PORT,
        FABRIC_NETMASK    => FABRIC_NETMASK,
        FABRIC_GATEWAY    => FABRIC_GATEWAY,
        FABRIC_ENABLE     => FABRIC_ENABLE,
        TTL               => TTL,
        PROMISC_MODE      => PROMISC_MODE,
        RX_CRC_CHK_ENABLE => RX_CRC_CHK_ENABLE)
    port map(
        clk => user_clk, --forty_gb_eth_clk,
        rst => user_40gbe_rst,--user_rst, --forty_gb_eth_rst,
        tx_valid            => xlgmii_tx_valid,
        tx_end_of_frame     => xlgmii_tx_end_of_frame,
        tx_data             => xlgmii_tx_data,
        tx_dest_ip          => xlgmii_tx_dest_ip,
        tx_dest_port        => xlgmii_tx_dest_port,
        tx_overflow         => xlgmii_tx_overflow,
        tx_afull            => xlgmii_tx_afull,
        rx_valid            => xlgmii_rx_valid,
        rx_end_of_frame     => xlgmii_rx_end_of_frame,
        rx_data             => xlgmii_rx_data,
        rx_source_ip        => xlgmii_rx_source_ip,
        rx_source_port      => xlgmii_rx_source_port,
        rx_dest_ip          => xlgmii_rx_dest_ip,
        rx_dest_port        => xlgmii_rx_dest_port,
        rx_bad_frame        => xlgmii_rx_bad_frame,
        rx_overrun          => xlgmii_rx_overrun,
        rx_overrun_ack      => xlgmii_rx_overrun_ack,
        rx_ack => xlgmii_rx_ack,
        CLK_I => bsp_clk,
        RST_I => bsp_rst,
        DAT_I => WB_SLV_DAT_I(10),
        DAT_O => WB_SLV_DAT_O(10),
        ACK_O => WB_SLV_ACK_O(10),
        ADR_I => WB_SLV_ADR_I(10)(13 downto 0),
        CYC_I => WB_SLV_CYC_I(10),
        SEL_I => WB_SLV_SEL_I(10),
        STB_I => WB_SLV_STB_I(10),
        WE_I  => WB_SLV_WE_I(10),
        xlgmii_txclk    => sys_clk,
        xlgmii_txrst    => sys_rst,
        xlgmii_txd      => xlgmii_txd(0),
        xlgmii_txc      => xlgmii_txc(0),
        xlgmii_txled    => xlgmii_txled(0),
        xlgmii_rxclk    => sys_clk,
        xlgmii_rxrst    => sys_rst,
        xlgmii_rxd      => xlgmii_rxd(0),
        xlgmii_rxc      => xlgmii_rxc(0),
        xlgmii_rxled    => xlgmii_rxled(0),
        phy_tx_rst      => qsfp_soft_reset(0),
        phy_rx_up       => phy_rx_up(0),
        src_ip_address      => xlgmii_src_ip_address(0),
        src_mac_address     => xlgmii_src_mac_address(0),
        src_enable          => xlgmii_src_enable(0),
        src_port            => xlgmii_src_port(0),
        src_gateway         => xlgmii_src_gateway(0),
        src_local_mc_recv_ip        => xlgmii_src_local_mc_recv_ip(0),
        src_local_mc_recv_ip_mask   => xlgmii_src_local_mc_recv_ip_mask(0),
        debug_out   => debug_out,
        debug_led   => open);

    gen_xlgmii_tx_reg : process(sys_clk)
    begin
        if (rising_edge(sys_clk))then
            xlgmii_txd_reg <= xlgmii_txd;
            xlgmii_txc_reg <= xlgmii_txc;
        end if;
    end process;

    gen_xlgmii_rx_reg : process(sys_clk)
    begin
        if (rising_edge(sys_clk))then
            xlgmii_rxd_reg <= xlgmii_rxd;
            xlgmii_rxc_reg <= xlgmii_rxc;
        end if;
    end process;

    gen_tx_start_count_0 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            tx_start_count_0 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_txc_reg(0)(0) = '1')and(xlgmii_txd_reg(0)(7 downto 0) = X"FB"))or
            ((xlgmii_txc_reg(0)(8) = '1')and(xlgmii_txd_reg(0)(71 downto 64) = X"FB"))or
            ((xlgmii_txc_reg(0)(16) = '1')and(xlgmii_txd_reg(0)(135 downto 128) = X"FB"))or
            ((xlgmii_txc_reg(0)(24) = '1')and(xlgmii_txd_reg(0)(199 downto 192) = X"FB")))then
                tx_start_count_0 <= tx_start_count_0 + X"0001";
            end if;
        end if;
    end process;

    gen_rx_start_count_0 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            rx_start_count_0 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_rxc_reg(0)(0) = '1')and(xlgmii_rxd_reg(0)(7 downto 0) = X"FB"))or
            ((xlgmii_rxc_reg(0)(8) = '1')and(xlgmii_rxd_reg(0)(71 downto 64) = X"FB"))or
            ((xlgmii_rxc_reg(0)(16) = '1')and(xlgmii_rxd_reg(0)(135 downto 128) = X"FB"))or
            ((xlgmii_rxc_reg(0)(24) = '1')and(xlgmii_rxd_reg(0)(199 downto 192) = X"FB")))then
                rx_start_count_0 <= rx_start_count_0 + X"0001";
            end if;
        end if;
    end process;

--AI Start: Single 40GbE Core Needed (Other 3 commented out)
        -- WISHBONE SLAVE 11 - 40GBE MAC 1
--        ska_forty_gb_eth_1 : ska_forty_gb_eth
--        generic map(
--            FABRIC_MAC     => X"FFFFFFFFFFFF",
--            FABRIC_IP      => X"FFFFFFFF",
--            FABRIC_PORT    => X"FFFF",
--            FABRIC_GATEWAY => X"FF",
--            FABRIC_ENABLE  => '0',
--            TTL                 => X"01",
--            PROMISC_MODE        => 0,
--            RX_CRC_CHK_ENABLE   => 1)
--        port map(
--            clk => sys_clk,
--            rst => sys_rst,
--            tx_valid            => xlgmii_tx_valid(1),
--            tx_end_of_frame     => xlgmii_tx_end_of_frame(1),
--            tx_data             => xlgmii_tx_data(1),
--            tx_dest_ip          => xlgmii_tx_dest_ip(1),
--            tx_dest_port        => xlgmii_tx_dest_port(1),
--            tx_overflow         => xlgmii_tx_overflow(1),
--            tx_afull            => xlgmii_tx_afull(1),
--            rx_valid            => xlgmii_rx_valid(1),
--            rx_end_of_frame     => xlgmii_rx_end_of_frame(1),
--            rx_data             => xlgmii_rx_data(1),
--            rx_source_ip        => xlgmii_rx_source_ip(1),
--            rx_source_port      => xlgmii_rx_source_port(1),
--            rx_bad_frame        => xlgmii_rx_bad_frame(1),
--            rx_overrun          => xlgmii_rx_overrun(1),
--            rx_overrun_ack      => xlgmii_rx_overrun_ack(1),
--            rx_ack => xlgmii_rx_ack(1),
--            CLK_I => sys_clk,
--            RST_I => sys_rst,
--            DAT_I => WB_SLV_DAT_I(11),
--            DAT_O => WB_SLV_DAT_O(11),
--            ACK_O => WB_SLV_ACK_O(11),
--            ADR_I => WB_SLV_ADR_I(11)(13 downto 0),
--            CYC_I => WB_SLV_CYC_I(11),
--            SEL_I => WB_SLV_SEL_I(11),
--            STB_I => WB_SLV_STB_I(11),
--            WE_I  => WB_SLV_WE_I(11),
--            xlgmii_txclk    => sys_clk,
--            xlgmii_txrst    => sys_rst,
--            xlgmii_txd      => xlgmii_txd(1),
--            xlgmii_txc      => xlgmii_txc(1),
--            xlgmii_txled    => xlgmii_txled(1),
--            xlgmii_rxclk    => sys_clk,
--            xlgmii_rxrst    => sys_rst,
--            xlgmii_rxd      => xlgmii_rxd(1),
--            xlgmii_rxc      => xlgmii_rxc(1),
--            xlgmii_rxled    => xlgmii_rxled(1),
--            phy_tx_rst      => qsfp_soft_reset(1),
--            phy_rx_up       => phy_rx_up(1),
--            src_ip_address      => xlgmii_src_ip_address(1),
--            src_mac_address     => xlgmii_src_mac_address(1),
--            src_enable          => xlgmii_src_enable(1),
--            src_port            => xlgmii_src_port(1),
--            src_gateway         => xlgmii_src_gateway(1),
--            src_local_mc_recv_ip        => xlgmii_src_local_mc_recv_ip(1),
--            src_local_mc_recv_ip_mask   => xlgmii_src_local_mc_recv_ip_mask(1),
--            debug_out   => open,
--            debug_led   => open);
--AI End: Single 40GbE Core Needed (Other 3 commented out)
    gen_tx_start_count_1 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            tx_start_count_1 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_txc_reg(1)(0) = '1')and(xlgmii_txd_reg(1)(7 downto 0) = X"FB"))or
            ((xlgmii_txc_reg(1)(8) = '1')and(xlgmii_txd_reg(1)(71 downto 64) = X"FB"))or
            ((xlgmii_txc_reg(1)(16) = '1')and(xlgmii_txd_reg(1)(135 downto 128) = X"FB"))or
            ((xlgmii_txc_reg(1)(24) = '1')and(xlgmii_txd_reg(1)(199 downto 192) = X"FB")))then
                tx_start_count_1 <= tx_start_count_1 + X"0001";
            end if;
        end if;
    end process;

    gen_rx_start_count_1 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            rx_start_count_1 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_rxc_reg(1)(0) = '1')and(xlgmii_rxd_reg(1)(7 downto 0) = X"FB"))or
            ((xlgmii_rxc_reg(1)(8) = '1')and(xlgmii_rxd_reg(1)(71 downto 64) = X"FB"))or
            ((xlgmii_rxc_reg(1)(16) = '1')and(xlgmii_rxd_reg(1)(135 downto 128) = X"FB"))or
            ((xlgmii_rxc_reg(1)(24) = '1')and(xlgmii_rxd_reg(1)(199 downto 192) = X"FB")))then
                rx_start_count_1 <= rx_start_count_1 + X"0001";
            end if;
        end if;
    end process;

--AI Start: Single 40GbE Core Needed (Other 3 commented out)
        -- WISHBONE SLAVE 12 - 40GBE MAC 2
--        ska_forty_gb_eth_2 : ska_forty_gb_eth
--        generic map(
--            FABRIC_MAC     => X"FFFFFFFFFFFF",
--            FABRIC_IP      => X"FFFFFFFF",
--            FABRIC_PORT    => X"FFFF",
--            FABRIC_GATEWAY => X"FF",
--            FABRIC_ENABLE  => '0',
--            TTL                 => X"01",
--            PROMISC_MODE        => 0,
--            RX_CRC_CHK_ENABLE   => 1)
--        port map(
--            clk => sys_clk,
--            rst => sys_rst,
--            tx_valid            => xlgmii_tx_valid(2),
--            tx_end_of_frame     => xlgmii_tx_end_of_frame(2),
--            tx_data             => xlgmii_tx_data(2),
--            tx_dest_ip          => xlgmii_tx_dest_ip(2),
--            tx_dest_port        => xlgmii_tx_dest_port(2),
--            tx_overflow         => xlgmii_tx_overflow(2),
--            tx_afull            => xlgmii_tx_afull(2),
--            rx_valid            => xlgmii_rx_valid(2),
--            rx_end_of_frame     => xlgmii_rx_end_of_frame(2),
--            rx_data             => xlgmii_rx_data(2),
--            rx_source_ip        => xlgmii_rx_source_ip(2),
--            rx_source_port      => xlgmii_rx_source_port(2),
--            rx_bad_frame        => xlgmii_rx_bad_frame(2),
--            rx_overrun          => xlgmii_rx_overrun(2),
--            rx_overrun_ack      => xlgmii_rx_overrun_ack(2),
--            rx_ack => xlgmii_rx_ack(2),
--            CLK_I => sys_clk,
--            RST_I => sys_rst,
--            DAT_I => WB_SLV_DAT_I(12),
--            DAT_O => WB_SLV_DAT_O(12),
--            ACK_O => WB_SLV_ACK_O(12),
--            ADR_I => WB_SLV_ADR_I(12)(13 downto 0),
--            CYC_I => WB_SLV_CYC_I(12),
--            SEL_I => WB_SLV_SEL_I(12),
--            STB_I => WB_SLV_STB_I(12),
--            WE_I  => WB_SLV_WE_I(12),
--            xlgmii_txclk    => sys_clk,
--            xlgmii_txrst    => sys_rst,
--            xlgmii_txd      => xlgmii_txd(2),
--            xlgmii_txc      => xlgmii_txc(2),
--            xlgmii_txled    => xlgmii_txled(2),
--            xlgmii_rxclk    => sys_clk,
--            xlgmii_rxrst    => sys_rst,
--            xlgmii_rxd      => xlgmii_rxd(2),
--            xlgmii_rxc      => xlgmii_rxc(2),
--            xlgmii_rxled    => xlgmii_rxled(2),
--            phy_tx_rst      => qsfp_soft_reset(2),
--            phy_rx_up       => phy_rx_up(2),
--            src_ip_address      => xlgmii_src_ip_address(2),
--            src_mac_address     => xlgmii_src_mac_address(2),
--            src_enable          => xlgmii_src_enable(2),
--            src_port            => xlgmii_src_port(2),
--            src_gateway         => xlgmii_src_gateway(2),
--            src_local_mc_recv_ip        => xlgmii_src_local_mc_recv_ip(2),
--            src_local_mc_recv_ip_mask   => xlgmii_src_local_mc_recv_ip_mask(2),
--            debug_out   => open,
--            debug_led   => open);
--AI End: Single 40GbE Core Needed (Other 3 commented out)

    gen_tx_start_count_2 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            tx_start_count_2 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_txc_reg(2)(0) = '1')and(xlgmii_txd_reg(2)(7 downto 0) = X"FB"))or
            ((xlgmii_txc_reg(2)(8) = '1')and(xlgmii_txd_reg(2)(71 downto 64) = X"FB"))or
            ((xlgmii_txc_reg(2)(16) = '1')and(xlgmii_txd_reg(2)(135 downto 128) = X"FB"))or
            ((xlgmii_txc_reg(2)(24) = '1')and(xlgmii_txd_reg(2)(199 downto 192) = X"FB")))then
                tx_start_count_2 <= tx_start_count_2 + X"0001";
            end if;
        end if;
    end process;
    
    gen_rx_start_count_2 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            rx_start_count_2 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_rxc_reg(2)(0) = '1')and(xlgmii_rxd_reg(2)(7 downto 0) = X"FB"))or
            ((xlgmii_rxc_reg(2)(8) = '1')and(xlgmii_rxd_reg(2)(71 downto 64) = X"FB"))or
            ((xlgmii_rxc_reg(2)(16) = '1')and(xlgmii_rxd_reg(2)(135 downto 128) = X"FB"))or
            ((xlgmii_rxc_reg(2)(24) = '1')and(xlgmii_rxd_reg(2)(199 downto 192) = X"FB")))then
                rx_start_count_2 <= rx_start_count_2 + X"0001";
            end if;
        end if;
    end process;
    
--AI Start: Single 40GbE Core Needed (Other 3 commented out)
        -- WISHBONE SLAVE 13 - 40GBE MAC 3
--        ska_forty_gb_eth_3 : ska_forty_gb_eth
--        generic map(
--            FABRIC_MAC     => X"FFFFFFFFFFFF",
--            FABRIC_IP      => X"FFFFFFFF",
--            FABRIC_PORT    => X"FFFF",
--            FABRIC_GATEWAY => X"FF",
--            FABRIC_ENABLE  => '0',
--            TTL                 => X"01",
--            PROMISC_MODE        => 0,
--            RX_CRC_CHK_ENABLE   => 1)
--        port map(
--            clk => sys_clk,
--            rst => sys_rst,
--            tx_valid            => xlgmii_tx_valid(3),
--            tx_end_of_frame     => xlgmii_tx_end_of_frame(3),
--            tx_data             => xlgmii_tx_data(3),
--            tx_dest_ip          => xlgmii_tx_dest_ip(3),
--            tx_dest_port        => xlgmii_tx_dest_port(3),
--            tx_overflow         => xlgmii_tx_overflow(3),
--            tx_afull            => xlgmii_tx_afull(3),
--            rx_valid            => xlgmii_rx_valid(3),
--            rx_end_of_frame     => xlgmii_rx_end_of_frame(3),
--            rx_data             => xlgmii_rx_data(3),
--            rx_source_ip        => xlgmii_rx_source_ip(3),
--            rx_source_port      => xlgmii_rx_source_port(3),
--            rx_bad_frame        => xlgmii_rx_bad_frame(3),
--            rx_overrun          => xlgmii_rx_overrun(3),
--            rx_overrun_ack      => xlgmii_rx_overrun_ack(3),
--            rx_ack => xlgmii_rx_ack(3),
--            CLK_I => sys_clk,
--            RST_I => sys_rst,
--            DAT_I => WB_SLV_DAT_I(13),
--            DAT_O => WB_SLV_DAT_O(13),
--            ACK_O => WB_SLV_ACK_O(13),
--            ADR_I => WB_SLV_ADR_I(13)(13 downto 0),
--            CYC_I => WB_SLV_CYC_I(13),
--            SEL_I => WB_SLV_SEL_I(13),
--            STB_I => WB_SLV_STB_I(13),
--            WE_I  => WB_SLV_WE_I(13),
--            xlgmii_txclk    => sys_clk,
--            xlgmii_txrst    => sys_rst,
--            xlgmii_txd      => xlgmii_txd(3),
--            xlgmii_txc      => xlgmii_txc(3),
--            xlgmii_txled    => xlgmii_txled(3),
--            xlgmii_rxclk    => sys_clk,
--            xlgmii_rxrst    => sys_rst,
--            xlgmii_rxd      => xlgmii_rxd(3),
--            xlgmii_rxc      => xlgmii_rxc(3),
--            xlgmii_rxled    => xlgmii_rxled(3),
--            phy_tx_rst      => qsfp_soft_reset(3),
--            phy_rx_up       => phy_rx_up(3),
--            src_ip_address      => xlgmii_src_ip_address(3),
--            src_mac_address     => xlgmii_src_mac_address(3),
--            src_enable          => xlgmii_src_enable(3),
--            src_port            => xlgmii_src_port(3),
--            src_gateway         => xlgmii_src_gateway(3),
--            src_local_mc_recv_ip        => xlgmii_src_local_mc_recv_ip(3),
--            src_local_mc_recv_ip_mask   => xlgmii_src_local_mc_recv_ip_mask(3),
--            debug_out   => open,
--            debug_led   => open);
--AI End: Single 40GbE Core Needed (Other 3 commented out)

    gen_tx_start_count_3 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            tx_start_count_3 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_txc_reg(3)(0) = '1')and(xlgmii_txd_reg(3)(7 downto 0) = X"FB"))or
            ((xlgmii_txc_reg(3)(8) = '1')and(xlgmii_txd_reg(3)(71 downto 64) = X"FB"))or
            ((xlgmii_txc_reg(3)(16) = '1')and(xlgmii_txd_reg(3)(135 downto 128) = X"FB"))or
            ((xlgmii_txc_reg(3)(24) = '1')and(xlgmii_txd_reg(3)(199 downto 192) = X"FB")))then
                tx_start_count_3 <= tx_start_count_3 + X"0001";
            end if;
        end if;
    end process;

    gen_rx_start_count_3 : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            rx_start_count_3 <= (others => '0');
        elsif (rising_edge(sys_clk))then
            if (((xlgmii_rxc_reg(3)(0) = '1')and(xlgmii_rxd_reg(3)(7 downto 0) = X"FB"))or
            ((xlgmii_rxc_reg(3)(8) = '1')and(xlgmii_rxd_reg(3)(71 downto 64) = X"FB"))or
            ((xlgmii_rxc_reg(3)(16) = '1')and(xlgmii_rxd_reg(3)(135 downto 128) = X"FB"))or
            ((xlgmii_rxc_reg(3)(24) = '1')and(xlgmii_rxd_reg(3)(199 downto 192) = X"FB")))then
                rx_start_count_3 <= rx_start_count_3 + X"0001";
            end if;
        end if;
    end process;

----------------------------------------------------------------------------
-- 1GBE INTERFACE
----------------------------------------------------------------------------

   -- GT 11/04/2017 ADDED A TIMEOUT TO SGMII CORE IF LINK DOESN'T COME UP
    gen_sgmii_timeout_count_low : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            sgmii_timeout_count_low <= (others => '0');
            sgmii_timeout_count_low_over <= '0';
        elsif (rising_edge(sys_clk))then
            sgmii_timeout_count_low_over <= '0';

            if ((gmii_reset_done = '1')and(sgmii_link_up = '1'))then
                sgmii_timeout_count_low <= (others => '0');
            else
                if (sgmii_timeout_count_low = X"FFFF")then           
                    sgmii_timeout_count_low_over <= '1';
                    sgmii_timeout_count_low <= (others => '0');
                else
                    sgmii_timeout_count_low <= sgmii_timeout_count_low + X"0001";
                end if;
            end if;    
        end if;
    end process;

    gen_sgmii_timeout_count_high : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            sgmii_timeout_count_high <= (others => '0');
            sgmii_timeout <= '0';
        elsif (rising_edge(sys_clk))then
            sgmii_timeout <= '0';

            if ((gmii_reset_done = '1')and(sgmii_link_up = '1'))then
                sgmii_timeout_count_high <= (others => '0');
            else
                if (sgmii_timeout_count_low_over = '1')then
                    if (sgmii_timeout_count_high = "11111111111")then           
                        sgmii_timeout <= '1';
                        sgmii_timeout_count_high <= (others => '0');
                    else
                        sgmii_timeout_count_high <= sgmii_timeout_count_high + "00000000001";
                    end if;
                end if;
            end if;    
        end if;
    end process;

    gen_sgmii_reset_count : process(sys_rst, sys_clk)
    begin
        if (sys_rst = '1')then
            sgmii_reset_count <= X"FF";
        elsif (rising_edge(sys_clk))then
            if (sgmii_timeout = '1')then   
                sgmii_reset_count <= (others => '0');
            else
                if (sgmii_reset_count /= X"FF")then
                    sgmii_reset_count <= sgmii_reset_count + X"01";
                end if;
            end if;
        end if;
    end process;

    sgmii_timeout_reset <= '0' when (sgmii_reset_count = X"FF") else '1';

    gmii_to_sgmii_reset <= sys_fpga_rst or sgmii_timeout_reset;

    gmii_to_sgmii_0 : gmii_to_sgmii
    port map(
        gtrefclk_p           => gmii_to_sgmii_refclk_p,
        gtrefclk_n           => gmii_to_sgmii_refclk_n,
        gtrefclk_out         => open,
        txp                  => gmii_to_sgmii_txp,
        txn                  => gmii_to_sgmii_txn,
        rxp                  => gmii_to_sgmii_rxp,
        rxn                  => gmii_to_sgmii_rxn,
        resetdone                   => gmii_reset_done,
        userclk_out                 => open,
        userclk2_out                => gmii_clk,
        rxuserclk_out               => open,
        rxuserclk2_out              => open,
        pma_reset_out               => open,
        mmcm_locked_out             => open,
        independent_clock_bufg      => sys_clk,
        sgmii_clk_r                 => open,
        sgmii_clk_f                 => open,
        sgmii_clk_en         => gmii_clk_en,
        gmii_txd             => gmii_txd,
        gmii_tx_en           => gmii_tx_en,
        gmii_tx_er           => gmii_tx_er,
        gmii_rxd             => gmii_rxd,
        gmii_rx_dv           => gmii_rx_dv,
        gmii_rx_er           => gmii_rx_er,
        gmii_isolate         => open,
        configuration_vector => configuration_vector,
        an_interrupt         => an_interrupt,
        an_adv_config_vector => an_adv_config_vector,
        an_restart_config    => an_restart_config,
        speed_is_10_100      => gmii_speed_is_10_100, --'0',
        speed_is_100         => gmii_speed_is_100, --'0',
        status_vector        => status_vector,
        reset                => gmii_to_sgmii_reset,
        signal_detect        => '1',
        gt0_qplloutclk_out     => open,
        gt0_qplloutrefclk_out  => open);

    -- GT 04/06/2015 SPEED SELECTION CONTROL
    gen_gmii_speed : process(gmii_fpga_rst, gmii_clk)
    begin
        if (gmii_fpga_rst = '1')then
            gmii_speed_is_10_100 <= '0';
            gmii_speed_is_100 <= '0';
        elsif (rising_edge(gmii_clk))then
            if (status_vector(0) = '1')then
                if (status_vector(11 downto 10) = "10")then
                    -- 1GBE
                    gmii_speed_is_10_100 <= '0';
                    gmii_speed_is_100 <= '0';
                elsif (status_vector(11 downto 10) = "01")then
                    -- 100MBPS
                    gmii_speed_is_10_100 <= '1';
                    gmii_speed_is_100 <= '1';
                else
                    -- 10MBPS
                    gmii_speed_is_10_100 <= '1';
                    gmii_speed_is_100 <= '0';
                end if;
            end if;
        end if;
    end process;


    --SGMII TO GMII
    ONE_GBE_RESET_N <= not sys_fpga_rst;
    
    -- GT 11/04/2017 UPDATED SGMII CORE RESET TO ADD A TIMEOUT gmii_to_sgmii_reset <= fpga_reset;
    
    gmii_to_sgmii_refclk_p <= ONE_GBE_MGTREFCLK_P;
    gmii_to_sgmii_refclk_n <= ONE_GBE_MGTREFCLK_N;
    
    ONE_GBE_SGMII_TX_P <= gmii_to_sgmii_txp;
    ONE_GBE_SGMII_TX_N <= gmii_to_sgmii_txn;
    gmii_to_sgmii_rxp <= ONE_GBE_SGMII_RX_P;
    gmii_to_sgmii_rxn <= ONE_GBE_SGMII_RX_N;

    -- GT 29/03/2017 CHANGE gmii_rst TO STAY IN RESET WHILE SGMII LINK IS DOWN
    --gen_gmii_reset_done_z : process (gmii_clk)
    --begin
    --    if (rising_edge(gmii_clk))then
    --        gmii_reset_done_z <= gmii_reset_done;
    --        gmii_reset_done_z2 <= gmii_reset_done_z;
    --        gmii_reset_done_z3 <= gmii_reset_done_z2;
    --    end if;
    --end process; 
    
    sgmii_link_up <= status_vector(0);
    
    gen_sgmii_link_up_z : process (gmii_clk)
    begin
        if (rising_edge(gmii_clk))then
            sgmii_link_up_z <= sgmii_link_up;
            sgmii_link_up_z2 <= sgmii_link_up_z;
            sgmii_link_up_z3 <= sgmii_link_up_z2;
        end if;
    end process;

    configuration_vector(0) <= '0'; -- BIDIRECTIONAL
    configuration_vector(1) <= '0'; -- NO LOOPBACK
    configuration_vector(2) <= '0'; -- NO LOW POWER MODE
    configuration_vector(3) <= '0'; -- NORMAL OPERATION OF GMII
    configuration_vector(4) <= '1'; -- AN ENABLED

    an_adv_config_vector(0) <= '1'; -- SGMII
    an_adv_config_vector(4 downto 1) <= (others => '0');
    an_adv_config_vector(5) <= '0';
    an_adv_config_vector(6) <= '0';
    an_adv_config_vector(8 downto 7) <= (others => '0');
    an_adv_config_vector(9) <= '0';
    an_adv_config_vector(11 downto 10) <= "10"; -- 1GB/S
    an_adv_config_vector(12) <= '1'; -- FULL DUPLEX
    an_adv_config_vector(13) <= '0';
    an_adv_config_vector(14) <= '1'; -- ACKNOWLEDGE
    an_adv_config_vector(15) <= '1'; -- LINK UP

    an_restart_config <= '0';

    xaui_to_gmii_translator_0 : xaui_to_gmii_translator
    port map(
        xaui_clk            => sys_clk,
        xaui_rst            => sys_rst,
        xgmii_txd           => gmii_xgmii_txd,
        xgmii_txc           => gmii_xgmii_txc,
        xaui_almost_full    => gmii_xaui_almost_full,
        xaui_full           => gmii_xaui_full,
        gmii_clk            => gmii_clk,
        gmii_clk_en         => gmii_clk_en,  -- GT 04/06/2015 ADD SUPPORT FOR 10/100MBPS OPERATION
        gmii_rst            => gmii_rst,
        gmii_txd            => gmii_txd,
        gmii_tx_en          => gmii_tx_en,
        gmii_tx_er          => gmii_tx_er,
        gmii_link_up        => status_vector(0));

    gen_gmii_tx_en_z : process(gmii_clk)
    begin
        if (rising_edge(gmii_clk))then
            gmii_tx_en_z <= gmii_tx_en;
        end if;
    end process;

    gen_gmii_packets_sent : process(gmii_rst, gmii_clk)
    begin
        if (gmii_rst = '1')then
            gmii_packets_sent <= (others => '0');
        elsif (rising_edge(gmii_clk))then
            if ((gmii_tx_en_z = '0')and(gmii_tx_en = '1'))then
                gmii_packets_sent <= gmii_packets_sent + X"0001";
            end if;
        end if;
    end process;

    gmii_to_xaui_translator_0 : gmii_to_xaui_translator
    port map(
        gmii_clk        => gmii_clk,
        gmii_clk_en     => gmii_clk_en,  -- GT 04/06/2015 ADD SUPPORT FOR 10/100MBPS OPERATION
        gmii_rst        => gmii_rst,
        gmii_rxd        => gmii_rxd,
        gmii_rx_dv      => gmii_rx_dv,
        gmii_rx_er      => gmii_rx_er,
        xaui_clk        => sys_clk,
        xaui_rst        => sys_rst,
        xgmii_rxd       => gmii_xgmii_rxd,
        xgmii_rxc       => gmii_xgmii_rxc);

----------------------------------------------------------------------------
-- 40GBE INTERFACE 0
----------------------------------------------------------------------------

    GTREFCLK_buf : BUFG
        port map(
            O => qsfp_gtrefclk,
            I => qsfp_gtrefclk_pb);

    IEEE802_3_XL_PHY_0 : component IEEE802_3_XL_PHY_top
        port map(
            SYS_CLK_I            => sys_clk,
            SYS_CLK_RST_I        => sys_rst,
            GTREFCLK_PAD_N_I     => MEZ3_REFCLK_0_N,
            GTREFCLK_PAD_P_I     => MEZ3_REFCLK_0_P,
            GTREFCLK_O           => qsfp_gtrefclk_pb,
            TXN_O                => MEZ3_PHY11_LANE_TX_N,
            TXP_O                => MEZ3_PHY11_LANE_TX_P,
            RXN_I                => MEZ3_PHY11_LANE_RX_N,
            RXP_I                => MEZ3_PHY11_LANE_RX_P,
            SOFT_RESET_I         => qsfp_soft_reset(0),
            LINK_UP_O            => phy_rx_up(0),
            XLGMII_X4_TXC_I      => xlgmii_txc(0),
            XLGMII_X4_TXD_I      => xlgmii_txd(0),
            XLGMII_X4_RXC_O      => xlgmii_rxc(0),
            XLGMII_X4_RXD_O      => xlgmii_rxd(0),
            TEST_PATTERN_EN_I    => '0',
            TEST_PATTERN_ERROR_O => open
        );
--AI Start: Single 40GbE Core Needed (Other 3 commented out)
--  IEEE802_3_XL_PHY_1 : component IEEE802_3_XL_PHY_top
--      port map(
--          SYS_CLK_I            => sys_clk,
--          SYS_CLK_RST_I        => sys_rst,
--          GTREFCLK_PAD_N_I     => MEZ3_REFCLK_1_N,
--          GTREFCLK_PAD_P_I     => MEZ3_REFCLK_1_P,
--          GTREFCLK_O           => open,
--          TXN_O                => MEZ3_PHY12_LANE_TX_N,
--          TXP_O                => MEZ3_PHY12_LANE_TX_P,
--          RXN_I                => MEZ3_PHY12_LANE_RX_N,
--          RXP_I                => MEZ3_PHY12_LANE_RX_P,
--          SOFT_RESET_I         => qsfp_soft_reset(1),
--          LINK_UP_O            => phy_rx_up(1),
--          XLGMII_X4_TXC_I      => xlgmii_txc(1),
--          XLGMII_X4_TXD_I      => xlgmii_txd(1),
--          XLGMII_X4_RXC_O      => xlgmii_rxc(1),
--          XLGMII_X4_RXD_O      => xlgmii_rxd(1),
--          TEST_PATTERN_EN_I    => '0',
--          TEST_PATTERN_ERROR_O => open
--      );

--  IEEE802_3_XL_PHY_2 : component IEEE802_3_XL_PHY_top
--      port map(
--          SYS_CLK_I            => sys_clk,
--          SYS_CLK_RST_I        => sys_rst,
--          GTREFCLK_PAD_N_I     => MEZ3_REFCLK_2_N,
--          GTREFCLK_PAD_P_I     => MEZ3_REFCLK_2_P,
--          GTREFCLK_O           => open,
--          TXN_O                => MEZ3_PHY21_LANE_TX_N,
--          TXP_O                => MEZ3_PHY21_LANE_TX_P,
--          RXN_I                => MEZ3_PHY21_LANE_RX_N,
--          RXP_I                => MEZ3_PHY21_LANE_RX_P,
--          SOFT_RESET_I         => qsfp_soft_reset(2),
--          LINK_UP_O            => phy_rx_up(2),
--          XLGMII_X4_TXC_I      => xlgmii_txc(2),
--          XLGMII_X4_TXD_I      => xlgmii_txd(2),
--          XLGMII_X4_RXC_O      => xlgmii_rxc(2),
--          XLGMII_X4_RXD_O      => xlgmii_rxd(2),
--          TEST_PATTERN_EN_I    => '0',
--          TEST_PATTERN_ERROR_O => open
--      );

--  IEEE802_3_XL_PHY_3 : component IEEE802_3_XL_PHY_top
--      port map(
--          SYS_CLK_I            => sys_clk,
--          SYS_CLK_RST_I        => sys_rst,
--          GTREFCLK_PAD_N_I     => MEZ3_REFCLK_3_N,
--          GTREFCLK_PAD_P_I     => MEZ3_REFCLK_3_P,
--          GTREFCLK_O           => open,
--          TXN_O                => MEZ3_PHY22_LANE_TX_N,
--          TXP_O                => MEZ3_PHY22_LANE_TX_P,
--          RXN_I                => MEZ3_PHY22_LANE_RX_N,
--          RXP_I                => MEZ3_PHY22_LANE_RX_P,
--          SOFT_RESET_I         => qsfp_soft_reset(3),
--          LINK_UP_O            => phy_rx_up(3),
--          XLGMII_X4_TXC_I      => xlgmii_txc(3),
--          XLGMII_X4_TXD_I      => xlgmii_txd(3),
--          XLGMII_X4_RXC_O      => xlgmii_rxc(3),
--          XLGMII_X4_RXD_O      => xlgmii_rxd(3),
--          TEST_PATTERN_EN_I    => '0',
--          TEST_PATTERN_ERROR_O => open
--      );
--AI End: Single 40GbE Core Needed (Other 3 commented out)

-------------------------------------------------------------------------
-- CREATE SIGNAL THAT TOGGLES ONCE/SECOND
-------------------------------------------------------------------------

    second_gen_0 : second_gen
    port map(
        clk => sys_clk,
        rst => sys_rst,
        second_toggle => second_toggle);

-------------------------------------------------------------------------
-- MEASURE FREQUENCY OF GTH CLOCK
-------------------------------------------------------------------------

    clock_frequency_measure_1 : clock_frequency_measure
    port map(
        clk => qsfp_gtrefclk,
        rst => qsfp_fpga_rst,
        second_toggle   => second_toggle,
        measure_freq    => qsfp_xl_tx_clk_156m25_frequency);

-------------------------------------------------------------------------
-- MEASURE FREQUENCY OF CONFIG CLOCK
-------------------------------------------------------------------------

    clock_frequency_measure_2 : clock_frequency_measure
    port map(
        clk => FPGA_EMCCLK2,
        rst => emcclk_fpga_rst,
        second_toggle   => second_toggle,
        measure_freq    => fpga_emcclk2_frequency);


-------------------------------------------------------------------------
-- ACCESS FPGA DEVICE DNA_PORT VALUE
-------------------------------------------------------------------------

    FPGA_DNA_CHECKER_inst : component FPGA_DNA_CHECKER
        port map(
            CLK_I            => sys_clk,
            RST_I            => sys_rst,
            FPGA_EMCCLK2_I   => fpga_emcclk2,
            FPGA_DNA_O       => fpga_dna,
            FPGA_DNA_MATCH_O => open
        );
        
-------------------------------------------------------------------------
-- XADC MEASUREMENT     
------------------------------------------------------------------------- 
    
    xadc_measurement_0 : xadc_measurement
    port map(
        daddr_in        => xadc_daddr_in,
        den_in          => xadc_den_in,
        di_in           => xadc_di_in,
        dwe_in          => xadc_dwe_in,
        do_out          => xadc_do_out,
        drdy_out        => xadc_drdy_out,
        dclk_in         => sys_clk,
        reset_in        => sys_rst,
        busy_out        => xadc_busy_out,
        channel_out     => xadc_channel_out,
        eoc_out         => xadc_eoc_out,
        eos_out         => xadc_eos_out,
        ot_out          => xadc_ot_out,
        user_temp_alarm_out => xadc_user_temp_alarm_out,
        alarm_out       => xadc_alarm_out,
        vp_in           => '0',
        vn_in           => '0');

    gen_xadc_latched : process(sys_rst, sys_clk)
    begin
        if (bsp_rst = '1')then
            brd_user_read_regs(C_RD_XADC_LATCHED_ADDR) <= (others => '0');
        elsif (rising_edge(bsp_clk))then
            if (xadc_drdy_out = '1')then
                brd_user_read_regs(C_RD_XADC_LATCHED_ADDR) <= X"0000" & xadc_do_out;
            end if;   
        end if;
    end process;

    brd_user_read_regs(C_RD_XADC_STATUS_ADDR)(15 downto 0) <= xadc_do_out;
    brd_user_read_regs(C_RD_XADC_STATUS_ADDR)(16) <= xadc_drdy_out;
    brd_user_read_regs(C_RD_XADC_STATUS_ADDR)(17) <= xadc_ot_out;
    brd_user_read_regs(C_RD_XADC_STATUS_ADDR)(18) <= xadc_user_temp_alarm_out;
    brd_user_read_regs(C_RD_XADC_STATUS_ADDR)(19) <= xadc_alarm_out;
    brd_user_read_regs(C_RD_XADC_STATUS_ADDR)(31 downto 20) <= (others => '0');

    xadc_di_in <= brd_user_write_regs(C_WR_XADC_CONTROL_ADDR)(15 downto 0);
    xadc_daddr_in <= brd_user_write_regs(C_WR_XADC_CONTROL_ADDR)(22 downto 16);
    xadc_den_in <= brd_user_write_regs(C_WR_XADC_CONTROL_ADDR)(23);
    xadc_dwe_in <= brd_user_write_regs(C_WR_XADC_CONTROL_ADDR)(24);		        
        
-------------------------------------------------------------------------
-- Wishbone DSP Registers
-------------------------------------------------------------------------
                
    -- WISHBONE SLAVE 14 - DSP Registers
    WB_SLV_CLK_I_top <= bsp_clk;--sys_clk;
    WB_SLV_RST_I_top <= bsp_rst;--sys_rst;
    WB_SLV_DAT_I_top <= wb_cross_clock_out_dout(69 downto 38);--WB_SLV_DAT_I(14);
    --WB_SLV_DAT_O(14) <= WB_SLV_DAT_O_top;
    --WB_SLV_ACK_O(14) <= WB_SLV_ACK_O_top;
    --Deconcatenate the signals from the FIFO to the wishbone interconnect
    WB_SLV_DAT_O(14) <= wb_sync_data_in;--wb_cross_clock_in_dout(31 downto 0);
    WB_SLV_ACK_O(14) <= wb_sync_ack_in;--wb_cross_clock_in_dout(32);    
    WB_SLV_ADR_I_top <= wb_cross_clock_out_dout(37 downto 6);--WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0);
    WB_SLV_CYC_I_top <= wb_cross_clock_out_dout(5);--WB_SLV_CYC_I(14);
    WB_SLV_SEL_I_top <= wb_cross_clock_out_dout(4 downto 1);--WB_SLV_SEL_I(14);
    WB_SLV_STB_I_top <= wb_cross_clock_out_dout(72);--WB_SLV_STB_I(14);
    WB_SLV_WE_I_top  <= wb_cross_clock_out_dout(0);--WB_SLV_WE_I(14); 
    
    --Wishbone signals to the DSP
    cross_clock_fifo_wb_out_73x16_dsp : cross_clock_fifo_wb_out_73x16
    port map(
        rst             => bsp_rst,
        wr_clk          => bsp_clk,
        rd_clk          => bsp_clk, 
        din             => wb_cross_clock_out_din,
        wr_en           => wb_cross_clock_out_wrreq,
        rd_en           => wb_cross_clock_out_rdreq,
        dout            => wb_cross_clock_out_dout,
        full            => wb_cross_clock_out_full,
        empty           => wb_cross_clock_out_empty);  
     
        
   --WB FIFO Write State Machine (Wishbone to DSP Interface [39.0625MHz to 39.0625MHz)
   --The Strobe, Write Enable and Cyclic signals are asserted for a long duration and
   -- so this state machine ensures that the arbiter will see three clock cycle write asserted 
   --strobes and write enabled and one clock cycle read asserted strobes with write disabled.   
    fifo_wb_write_to_dsp_state_machine : process(bsp_rst, bsp_clk)
    begin
        if (bsp_rst = '1')then
            wb_cross_clock_out_wrreq <= '0';
            wb_dsp_wr_state <= WB_DSP_WR_IDLE;
            wb_cross_clock_out_din <= (others => '0');
            wb_slv_stb_hist_i <= '0';
        elsif (rising_edge(bsp_clk))then
            wb_slv_stb_hist_i <= WB_SLV_STB_I(14);
            case wb_dsp_wr_state is    
                when WB_DSP_WR_IDLE =>
                  wb_dsp_wr_state <= WB_DSP_WR_STROBE_CHECK;
                  wb_cross_clock_out_wrreq <= '0';
                  wb_cross_clock_out_din <= "000" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & '0' & WB_SLV_SEL_I(14) & '0';                                                 
                when WB_DSP_WR_STROBE_CHECK =>
                                    
                  --Check for strobe and write enable (write operation)
                  if (WB_SLV_STB_I(14) = '1' and wb_slv_stb_hist_i = '0' and WB_SLV_WE_I(14) = '1')then
                      wb_dsp_wr_state <= WB_DSP_WR_FIFO_WR_EN_1;
                      wb_cross_clock_out_din <= "100" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & WB_SLV_CYC_I(14) & WB_SLV_SEL_I(14) & '1';   
                      wb_cross_clock_out_wrreq <= '1' and not(wb_cross_clock_out_full);
                  --Check for strobe and write deasserted (read operation)    
                  elsif (WB_SLV_STB_I(14) = '1' and wb_slv_stb_hist_i = '0' and  WB_SLV_WE_I(14) = '0') then
                      wb_dsp_wr_state <= WB_DSP_WR_FIFO_WR_EN_3;
                      wb_cross_clock_out_din <= "100" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & WB_SLV_CYC_I(14) & WB_SLV_SEL_I(14) & '0';   
                      wb_cross_clock_out_wrreq <= '1' and not(wb_cross_clock_out_full);                  
                  else
                      wb_dsp_wr_state <= WB_DSP_WR_STROBE_CHECK;                  
                      wb_cross_clock_out_din <= "000" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & WB_SLV_CYC_I(14) & WB_SLV_SEL_I(14) & '0';
                      wb_cross_clock_out_wrreq <= '0';
                  end if;
                --enable write for two clock cycles to ensure wishbone write is successful  
                when WB_DSP_WR_FIFO_WR_EN_1 =>
                  
                  wb_dsp_wr_state <= WB_DSP_WR_FIFO_WR_EN_2;
                  wb_cross_clock_out_wrreq <= '1' and not(wb_cross_clock_out_full);
                  wb_cross_clock_out_din <= "100" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & WB_SLV_CYC_I(14) & WB_SLV_SEL_I(14) & '1';                           

                --enable write for three clock cycles to ensure wishbone write is successful  
                when WB_DSP_WR_FIFO_WR_EN_2 =>
                  
                  wb_dsp_wr_state <= WB_DSP_WR_FIFO_WR_EN_3;
                  wb_cross_clock_out_wrreq <= '1' and not(wb_cross_clock_out_full);
                  wb_cross_clock_out_din <= "100" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & WB_SLV_CYC_I(14) & WB_SLV_SEL_I(14) & '1';                           

                --write in next cycle to ensure strobe and values have cleared, except cyc signal                
                when WB_DSP_WR_FIFO_WR_EN_3 =>

                  wb_dsp_wr_state <= WB_DSP_WR_FIFO_WR_EN_4;
                  wb_cross_clock_out_wrreq <= '1' and not(wb_cross_clock_out_full);
                  wb_cross_clock_out_din <= "000" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & WB_SLV_CYC_I(14) & WB_SLV_SEL_I(14) & '0';
                --write in next cycle to ensure all strobe and values have cleared, including cyc signal                
                when WB_DSP_WR_FIFO_WR_EN_4 =>
                 
                  wb_dsp_wr_state <= WB_DSP_WR_FIFO_WR_DIS;
                  wb_cross_clock_out_wrreq <= '1' and not(wb_cross_clock_out_full);
                  wb_cross_clock_out_din <= "000" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & '0' & WB_SLV_SEL_I(14) & '0';

                --stop writing and allow slower clock to read out              
                when WB_DSP_WR_FIFO_WR_DIS =>
                  wb_dsp_wr_state <= WB_DSP_WR_STROBE_CHECK;
                  wb_cross_clock_out_wrreq <= '0';
                  wb_cross_clock_out_din <= "000" &  WB_SLV_DAT_I(14) & WB_SLV_ADR_I(14)((C_WB_SLV_ADDRESS_BITS - 1) downto 0) & '0' & WB_SLV_SEL_I(14) & '0';
                  
                when others =>
                  wb_dsp_wr_state <= WB_DSP_WR_IDLE;
            end case;
        end if;
    end process;   
   
    --Start reading out of the wishbone FIFO (wishbone to DSP interface [39.0625MHz to 39.0625MHz]) when FIFO is not empty   
    wb_cross_clock_out_rdreq <= '1' when (wb_cross_clock_out_empty = '0') else '0';
    
    --Wishbone signals from the DSP
    
    --This process only allows valid data to be latched through
    --creates a static bus signal for the synchroniser function below
    read_wb_dsp_data : process(bsp_rst, bsp_clk)
    begin
        if (bsp_rst = '1')then
            wb_data_in <= (others => '0');
            wb_ack_in <= '0';
        elsif (rising_edge(bsp_clk))then
            --if valid data
            if (WB_SLV_ACK_O_top = '1')then
                wb_data_in <= WB_SLV_DAT_O_top;
                wb_ack_in <= '1';
            else
                wb_ack_in <= '0';                
            end if;   
        end if;
    end process; 
    
    -- This function performs clock domain crossing synchronisation
    -- on a static bus signal
    wb_read_synchroniser: process(bsp_rst, bsp_clk, wb_ack_in)
    begin
        if (bsp_rst = '1') then
            wb_ack_in_z1 <= '0';
            wb_ack_in_z2 <= '0';
            wb_sync_data_in <= (others => '0');
            wb_sync_ack_in <= '0';
        elsif (rising_edge(bsp_clk)) then
            wb_ack_in_z2 <= wb_ack_in_z1;
            wb_ack_in_z1 <= wb_ack_in;
            if (wb_ack_in_z2 = '1') then
                wb_sync_data_in <= wb_data_in;
                wb_sync_ack_in <= '1';
            else
                wb_sync_ack_in <= '0';
            end if;
        end if;
    end process;
    
    -------------------------------------------------------------------------
    -- LED Manager Instantiation
    -------------------------------------------------------------------------

    led_manager_0 : led_manager
    port map(
        clk                   => sys_clk,
        rst                   => sys_rst,
        forty_gbe_link_status => phy_rx_up_cpu(0), -- Only using 40GbE_0
        dhcp_resolved         => brd_user_write_regs(C_WR_FRONT_PANEL_STAT_LED_ADDR)(0),
        firmware_version      => C_VERSION(31 downto 28),
        ublaze_toggle_value   => brd_user_read_regs(C_RD_UBLAZE_ALIVE_ADDR)(0),
        dsp_override_i        => brd_user_read_regs(C_RD_DSP_OVERRIDE_ADDR)(0),
        dsp_leds_i            => dsp_leds_i,
        leds_out              => fpga_leds_o
    );

end arch_forty_gbe;
