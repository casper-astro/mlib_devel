----------------------------------------------------------------------------------
-- Company: Peralex Electronics
-- Engineer: Gavin Teague
-- 
-- Create Date: 05.09.2014 10:19:29
-- Design Name: 
-- Module Name: wishbone_flash_sdram_interface - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Wishbone Classic slave, interface to external flash and SDRAM (via Spartan 3AN)
--
-- Assumes Wishbone clock frequency of 156.25MHz
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.parameter.all;

entity wishbone_flash_sdram_interface is
	port (
		-- WISHBONE CLASSIC SIGNALS
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
		
		-- HIGH BANDWIDTH SDRAM PROGRAMMING INTERFACE
		-- (CONNECTS DIRECTLY TO FABRIC INTERFACE OF 1GBE)
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
		-- HIGH BANDWIDTH SDRAM PROGRAMMING INTERFACE
        -- (CONNECTS DIRECTLY TO FABRIC INTERFACE OF 40GBE)        
        fgbe_config_en           : in std_logic;  -- if '1' SDRAM/Flash configuration is done via forty GbE else via 1 GbE above
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
		
		-- FLASH CONFIGURATION INTERFACE
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
        
        -- SPARTAN CONFIGURATION FPGA INTERFACE
        spartan_clk : out std_logic; -- WRITE DATA SAMPLED ON RISING EGDE OF THIS CLOCK
        config_io_0 : out std_logic; -- CLEAR SDRAM
        config_io_1 : out std_logic; -- WRITE TO SDRAM
        config_io_2 : in std_logic; -- WRITE TO SDRAM STALL
        config_io_3 : out std_logic; -- FINISHED WRITING TO SDRAM
        config_io_4 : out std_logic; -- ABOUT TO BOOT FROM SDRAM
        config_io_5 : in std_logic; -- BOOTING FROM SDRAM
        config_io_6 : out std_logic; -- FINISHED BOOTING FROM SDRAM
        config_io_7 : out std_logic; -- RESET SDRAM READ ADDRESS
        config_io_8 : out std_logic; -- DEBUG SDRAM ASYNC READ MODE
        config_io_9 : out std_logic; -- DEBUG DO ASYNC SDRAM READ
        config_io_10 : out std_logic; -- DEBUG CONTINUITY TEST LOW
        config_io_11 : out std_logic; -- DEBUG CONTINUITY TEST HIGH
        
        -- SPARTAN INTERNAL SPI FLASH
        spi_miso : in std_logic; 
        spi_mosi : out std_logic;
        spi_csb  : out std_logic;
        spi_clk  : out std_logic;
        
        debug_sdram_program_header  : out std_logic_vector(63 downto 0));
end wishbone_flash_sdram_interface;

architecture arch_wishbone_flash_sdram_interface of wishbone_flash_sdram_interface is

    type T_FLASH_STATE is (
    FLASH_IDLE,
    FLASH_WRITE_ACCESS,
    FLASH_WRITE_RECOVER_1,
    FLASH_WRITE_RECOVER_2,
    FLASH_READ_ACCESS,
    FLASH_READ_RECOVER,
    FLASH_GEN_ACK);
    
    type T_SDRAM_READ_STATE is (
    SDRAM_READ_IDLE,
    SDRAM_READ_LOW_0,
    SDRAM_READ_HIGH_0,
    SDRAM_READ_LOW_1,
    SDRAM_READ_HIGH_1,
    SDRAM_READ_ACK);
    
    component common_clock_fifo_32x16
    port (
       clk              : in std_logic;
       rst              : in std_logic;
       din              : in std_logic_vector(31 downto 0);
       wr_en            : in std_logic;
       rd_en            : in std_logic;
       dout             : out std_logic_vector(31 downto 0);
       full             : out std_logic;
       almost_full      : out std_logic;
       empty            : out std_logic);
    end component;    
        
    component cross_clock_fifo_67x16
    port (
        rst             : in std_logic;
        wr_clk          : in std_logic;
        rd_clk          : in std_logic;
        din             : in std_logic_vector(66 downto 0);
        wr_en           : in std_logic;
        rd_en           : in std_logic;
        dout            : out std_logic_vector(66 downto 0);
        full            : out std_logic;
        almost_full     : out std_logic;
        empty           : out std_logic);
    end component;
    
    --AI Start: Add fortygbe interface for configuration    
    component cross_clock_fifo_259x16
    port (
        rst             : in std_logic;
        wr_clk          : in std_logic;
        rd_clk          : in std_logic;
        din             : in std_logic_vector(258 downto 0);
        wr_en           : in std_logic;
        rd_en           : in std_logic;
        dout            : out std_logic_vector(258 downto 0);
        full            : out std_logic;
        almost_full     : out std_logic;
        empty           : out std_logic);
    end component;
    --AI End: Add fortygbe interface for configuration    

    component isp_spi_programmer
	port(
		clk : in std_logic;
		rst : in std_logic;
        isp_address              : in std_logic_vector(22 downto 0);
        isp_num_bytes            : in std_logic_vector(8 downto 0);
        isp_write_data           : in std_logic_vector(7 downto 0);
        isp_write_data_strobe    : in std_logic;
        isp_read_data            : out std_logic_vector(7 downto 0);
        isp_read_data_strobe     : in std_logic;
        isp_command              : in std_logic_vector(2 downto 0);
        isp_start_transaction    : in std_logic;
        isp_transaction_complete : out std_logic;
        spi_clk    : out std_logic;
        spi_csb    : out std_logic;
        spi_mosi   : out std_logic;
        spi_miso   : in std_logic);
    end component;
    
    component icape_controller
    port(
        clk : in std_logic;
        rst : in std_logic;
        icape_write_data           : in std_logic_vector(31 downto 0);
        icape_read_data            : out std_logic_vector(31 downto 0);
        icape_read_nwrite          : in std_logic;
        icape_start_transaction    : in std_logic;
        icape_transaction_complete : out std_logic);
    end component;
           
    constant C_OUTPUT_MODE_REG : std_logic_vector(3 downto 0) := X"0";
    constant C_UPPER_ADDRESS_REG : std_logic_vector(3 downto 0) := X"1";
    constant C_CONFIG_IO_REG : std_logic_vector(3 downto 0) := X"2";
    constant C_GBE_STATISTICS_REG : std_logic_vector(3 downto 0) := X"3"; --for forty GbE and 1GbE
    constant C_ICAPE_DATA_REG : std_logic_vector(3 downto 0) := X"4"; 
    constant C_ICAPE_CTL_REG : std_logic_vector(3 downto 0) := X"5"; 
    constant C_ISP_SPI_ADDRESS_REG : std_logic_vector(3 downto 0) := X"6";
    constant C_ISP_SPI_DATA_CTRL_REG : std_logic_vector(3 downto 0) := X"7";
    constant C_CONTINUITY_TEST_OUTPUT_REG : std_logic_vector(3 downto 0) := X"8";
    constant C_SDRAM_WB_PROGRAM_EN_REG : std_logic_vector(3 downto 0) := X"9";
    constant C_SDRAM_WB_PROGRAM_DATA_WR_REG : std_logic_vector(3 downto 0) := X"A";
    constant C_SDRAM_WB_PROGRAM_CTL_REG : std_logic_vector(3 downto 0) := X"B";
    

    constant C_FLASH_MODE : std_logic_vector(1 downto 0) := "00";
    constant C_SDRAM_PROGRAM_MODE : std_logic_vector(1 downto 0) := "01";
    constant C_SDRAM_READ_MODE : std_logic_vector(1 downto 0) := "10";

    -- VALUES FOR 156.25MHz CLOCK
    constant C_FLASH_WRITE_DELAY : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(7,6));
    constant C_FLASH_WRITE_RECOVER_DELAY : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(9,6));
    constant C_FLASH_READ_DELAY : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(16,6));
    constant C_FLASH_READ_RECOVER_DELAY : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(17,6));

    constant C_SDRAM_READ_DELAY_0 : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(7,6));
    constant C_SDRAM_READ_DELAY_1 : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(15,6));
    constant C_SDRAM_READ_DELAY_2 : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(23,6));
    constant C_SDRAM_READ_DELAY_3 : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(31,6));
    
    constant C_SDRAM_PROGRAM_PACKET_TYPE : std_logic_vector(15 downto 0) := X"0029"; 

    signal addra : std_logic_vector(11 downto 0);
    signal reg_select : std_logic;
    signal reg_select_z1 : std_logic;
    signal reg_select_z2 : std_logic;
    signal mem_select : std_logic;
    signal mem_select_z1 : std_logic;
    
    signal reg_ack : std_logic;
    signal mem_ack : std_logic;
    
    signal gbe_reg_dout : std_logic_vector(31 downto 0);
    --AI Start: Add fortygbe interface for configuration 
    signal fgbe_reg_dout : std_logic_vector(31 downto 0);
    --AI End: Add fortygbe interface for configuration     
    signal mem_dout : std_logic_vector(31 downto 0);
    
    signal current_mode : std_logic_vector(1 downto 0);
    signal clear_sdram : std_logic;
    signal finished_writing_to_sdram : std_logic;
    signal about_to_boot_from_sdram : std_logic;
    signal booting_from_sdram : std_logic;
    signal finished_booting_from_sdram : std_logic;
    signal reset_sdram_read_address : std_logic;
    signal debug_sdram_read_mode : std_logic;
    signal upper_address_bits : std_logic_vector(16 downto 0);
    signal write_to_sdram_stall : std_logic;
    
    signal flash_dq_out_i : std_logic_vector(15 downto 0);
    signal sdram_dq_out : std_logic_vector(15 downto 0);
    signal flash_dq_out_en_i : std_logic;
    signal flash_a_i : std_logic_vector(28 downto 0);
    signal sdram_a : std_logic_vector(28 downto 0);
    signal flash_cs_n_i : std_logic;
    signal sdram_cs_n : std_logic;
    signal flash_oe_n_i : std_logic;
    signal sdram_oe_n : std_logic;
    signal flash_we_n_i : std_logic;
    signal sdram_we_n : std_logic;
    signal flash_adv_n_i : std_logic;
    signal sdram_adv_n : std_logic;
    signal flash_ack : std_logic;
    signal sdram_ack : std_logic;
    signal flash_dout : std_logic_vector(31 downto 0);
    signal sdram_dout : std_logic_vector(31 downto 0);
    
    signal current_flash_state : T_FLASH_STATE;
    signal flash_delay_count : std_logic_vector(5 downto 0);
    signal reset_flash_delay_count : std_logic;
    
    signal config_io_2_z1 : std_logic;
    signal config_io_5_z1 : std_logic;
    signal config_io_2_z2 : std_logic;
    signal config_io_5_z2 : std_logic;
    signal config_io_2_z3 : std_logic;
    signal config_io_5_z3 : std_logic;
    
    signal gbe_rx_bad_frame_count : std_logic_vector(7 downto 0);
    signal gbe_rx_overrun_count : std_logic_vector(7 downto 0);
    signal gbe_rx_frame_count : std_logic_vector(15 downto 0);
    signal gbe_clear_count : std_logic;
    
    --AI Start: Add fortygbe interface for configuration 
    signal fgbe_rx_bad_frame_count : std_logic_vector(7 downto 0);
    signal fgbe_rx_overrun_count : std_logic_vector(7 downto 0);
    signal fgbe_rx_frame_count : std_logic_vector(15 downto 0);
    signal fgbe_clear_count : std_logic;
    --AI End: Add fortygbe interface for configuration 
        
    signal gbe_cross_clock_din : std_logic_vector(66 downto 0);
    signal gbe_cross_clock_wrreq : std_logic;
    signal gbe_cross_clock_rdreq : std_logic;
    signal gbe_cross_clock_rdreq_z1 : std_logic;
    signal gbe_cross_clock_dout : std_logic_vector(66 downto 0);
    signal gbe_cross_clock_almost_full : std_logic;
    signal gbe_cross_clock_empty : std_logic;
    signal gbe_cross_clock_full : std_logic;
    
    --AI Start: Add fortygbe interface for configuration    
    signal fgbe_cross_clock_din : std_logic_vector(258 downto 0);
    signal fgbe_cross_clock_wrreq : std_logic;
    signal fgbe_cross_clock_rdreq : std_logic;
    signal fgbe_cross_clock_rdreq_z1 : std_logic;
    signal fgbe_cross_clock_dout : std_logic_vector(258 downto 0);
    signal fgbe_cross_clock_almost_full : std_logic;
    signal fgbe_cross_clock_empty : std_logic;
    signal fgbe_cross_clock_full : std_logic;
    --AI End: Add fortygbe interface for configuration  
    
    signal wb_comm_clock_din : std_logic_vector(31 downto 0);
    signal wb_comm_clock_wrreq : std_logic;
    signal wb_comm_clock_rdreq : std_logic;
    signal wb_comm_clock_rdreq_z1 : std_logic;   
    signal wb_comm_clock_rdreq_z2 : std_logic;      
    signal wb_comm_clock_rdreq_z3 : std_logic;
    signal wb_comm_clock_rdreq_z4 : std_logic;
    signal wb_comm_clock_rdreq_z5 : std_logic;                  
    signal wb_comm_clock_dout : std_logic_vector(31 downto 0);
    signal wb_comm_clock_almost_full : std_logic;
    signal wb_comm_clock_empty : std_logic;
    signal wb_comm_clock_full : std_logic;

    
    signal spartan_clk_i : std_logic;
    signal spartan_clk_rising_edge_enable : std_logic;
    signal spartan_clk_falling_edge_enable : std_logic;    
    signal gbe_sdram_dq_count : std_logic_vector(2 downto 0); --AI: Provision for 1GbE interface
    --AI Start: Add fortygbe interface for configuration            
    signal fgbe_sdram_dq_count : std_logic_vector(4 downto 0); --AI: Provision for 40GbE interface
    --AI End: Add fortygbe interface for configuration 
    signal wb_sdram_dq_count : std_logic_vector(1 downto 0); --AI: Provision for wishbone configuration interface

    
    signal current_sdram_read_state : T_SDRAM_READ_STATE;
    signal sdram_read_delay_count : std_logic_vector(5 downto 0);
    signal reset_sdram_read_delay_count : std_logic;
    
    signal flash_dq_in_latched : std_logic_vector(15 downto 0);
     
    signal isp_address : std_logic_vector(22 downto 0);
    signal isp_num_bytes : std_logic_vector(8 downto 0);
    signal isp_write_data : std_logic_vector(7 downto 0);
    signal isp_write_data_strobe : std_logic;
    signal isp_read_data : std_logic_vector(7 downto 0);
    signal isp_read_data_strobe : std_logic;
    signal isp_command : std_logic_vector(2 downto 0);
    signal isp_start_transaction : std_logic;
    signal isp_transaction_complete : std_logic;
       
    signal icape_write_data : std_logic_vector(31 downto 0);
    signal icape_read_data : std_logic_vector(31 downto 0);
    signal icape_read_nwrite : std_logic;
    signal icape_start_transaction : std_logic;
    signal icape_transaction_complete : std_logic;
    
    signal sdram_program_header : std_logic;
    signal sdram_program_valid : std_logic;
    signal sdram_program_valid_a : std_logic;
    signal valid_sdram_program_packet : std_logic;
    signal sdram_dq_out_i : std_logic_vector(15 downto 0);
    signal config_io_1_i : std_logic;
    
    signal sequence_number : std_logic_vector(15 downto 0);
    
    signal continuity_test_output : std_logic_vector(31 downto 0);
    signal continuity_test_mode : std_logic;
    signal continuity_test_low : std_logic;
    signal continuity_test_high : std_logic;
    
    signal sdram_wb_program_en : std_logic;
    signal sdram_wb_program_data_wr : std_logic_vector(31 downto 0);
    signal sdram_wb_program_ctl : std_logic_vector(31 downto 0);
    signal sdram_wb_program_rx_valid : std_logic;
    signal sdram_wb_program_rx_valid_z1 : std_logic;
    signal sdram_wb_program_rx_valid_pulse : std_logic;     
    signal sdram_wb_program_ack : std_logic;
    
    --Debug ILA Nets that won't be optimised 
    signal fgbe_rx_eof : std_logic;
    signal gbe_rx_eof : std_logic;
    signal fgbe_rx_bf : std_logic;
    signal gbe_rx_bf : std_logic;
    signal fgbe_rx_or : std_logic;
    signal gbe_rx_or : std_logic;
    signal gbe_data_din : std_logic_vector(63 downto 0);
    signal gbe_data_dout : std_logic_vector(63 downto 0);
    signal fgbe_data_din : std_logic_vector(255 downto 0);
    signal fgbe_data_dout : std_logic_vector(255 downto 0);
    
    --ILA Netlist Insertion for Debug
--    attribute mark_debug : string;
--    attribute mark_debug of gbe_cross_clock_rdreq : signal is "true";
--    attribute mark_debug of fgbe_cross_clock_rdreq : signal is "true";
--    attribute mark_debug of fgbe_cross_clock_almost_full : signal is "true";
--    attribute mark_debug of fgbe_rx_valid : signal is "true";
--    attribute mark_debug of gbe_rx_valid : signal is "true";
--    attribute mark_debug of fgbe_sdram_dq_count : signal is "true";
--    attribute mark_debug of gbe_sdram_dq_count : signal is "true";
--    attribute mark_debug of sdram_dq_out_i : signal is "true";
--    attribute mark_debug of sdram_program_header : signal is "true";
--    attribute mark_debug of config_io_1_i : signal is "true";
--    attribute mark_debug of valid_sdram_program_packet : signal is "true";
--    attribute mark_debug of sequence_number : signal is "true";
--    attribute mark_debug of fgbe_config_en : signal is "true";
--    attribute mark_debug of gbe_cross_clock_full : signal is "true";
--    attribute mark_debug of fgbe_cross_clock_full : signal is "true";
--    attribute mark_debug of gbe_cross_clock_almost_full : signal is "true";
--    attribute mark_debug of gbe_cross_clock_empty : signal is "true";
--    attribute mark_debug of fgbe_cross_clock_empty : signal is "true";
--    attribute mark_debug of gbe_cross_clock_wrreq : signal is "true";
--    attribute mark_debug of fgbe_cross_clock_wrreq : signal is "true";
--    attribute mark_debug of gbe_data_din : signal is "true";
--    attribute mark_debug of gbe_data_dout : signal is "true";
--    attribute mark_debug of fgbe_data_din : signal is "true";
--    attribute mark_debug of fgbe_data_dout : signal is "true";
--    attribute mark_debug of fgbe_rx_eof : signal is "true";
--    attribute mark_debug of fgbe_rx_bf : signal is "true";
--    attribute mark_debug of fgbe_rx_or : signal is "true";
--    attribute mark_debug of gbe_rx_eof : signal is "true";
--    attribute mark_debug of gbe_rx_bf : signal is "true";
--    attribute mark_debug of gbe_rx_or : signal is "true";
    
                
begin

   --Debug Nets for ILA assignments
--   fgbe_rx_eof <= fgbe_cross_clock_dout(256);
--   fgbe_rx_bf <= fgbe_cross_clock_dout(257);
--   fgbe_rx_or <= fgbe_cross_clock_dout(258);
--   gbe_rx_eof <= gbe_cross_clock_dout(64);
--   gbe_rx_bf <= gbe_cross_clock_dout(65);
--   gbe_rx_or <= gbe_cross_clock_dout(66);
--   gbe_data_din(63 downto 0) <= gbe_cross_clock_din(63 downto 0);
--   gbe_data_dout(63 downto 0) <= gbe_cross_clock_dout(63 downto 0);
--   fgbe_data_din(255 downto 0) <= fgbe_cross_clock_din(255 downto 0);
--   fgbe_data_dout(255 downto 0) <= fgbe_cross_clock_dout(255 downto 0);
         
    -- WISHBONE ADDRESS IS BYTE ADDRESSING
    addra <= ADR_I(13 downto 2);
    
    reg_select <= '1' when ((ADR_I(14) = '1')and(CYC_I = '1')and(STB_I = '1')) else '0';
    mem_select <= '1' when ((ADR_I(14) = '0')and(CYC_I = '1')and(STB_I = '1')) else '0';
    
    gen_ACK_O : process(CLK_I)
    begin
        if (rising_edge(CLK_I))then
            if (ADR_I(14) = '1')then
                ACK_O <= reg_ack;
            else
                ACK_O <= mem_ack;
            end if; 
        end if;
    end process;
  
--AI Start: Add fortygbe interface for configuration
--Modified for fortygbe interface     
    gen_DAT_O : process(CLK_I)
    begin
        if (rising_edge(CLK_I))then
            if (ADR_I(14) = '1')then
              --1GbE Configuration Only
              if (fgbe_config_en = '0') then
                 DAT_O <= gbe_reg_dout;
              --40GbE Configuration Only   
              else
                 DAT_O <= fgbe_reg_dout;              
              end if;  
            else
                DAT_O <= mem_dout;
            end if;
        end if;
    end process;
--AI End: Add fortygbe interface for configuration     
    
    
    -- DEFAULT HIGH BECAUSE OF PULL-UP RESISTORS
    flash_rs0 <= 
        continuity_test_output(24) when (continuity_test_mode = '1') else
        flash_a_i(24) when (current_mode = C_FLASH_MODE) else 
        'Z';
    flash_rs1 <= 
        continuity_test_output(25) when (continuity_test_mode = '1')else
        flash_a_i(25) when (current_mode = C_FLASH_MODE) else 
        'Z';
    
    gbe_rx_overrun_ack <= gbe_rx_overrun;
    
-----------------------------------------------------------------------
-- CONFIGURATION REGISTERS
-----------------------------------------------------------------------

    gen_current_regs : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            current_mode <= C_FLASH_MODE;
            flash_output_enable <= '0';
            
            clear_sdram <= '0';
            finished_writing_to_sdram <= '0';
            about_to_boot_from_sdram <= '0';
            finished_booting_from_sdram <= '0';
            reset_sdram_read_address <= '0';
            debug_sdram_read_mode <= '0';
            
            gbe_clear_count <= '0';
            --AI Start: Add fortygbe interface for configuration 
            fgbe_clear_count <= '0';
            --AI End: Add fortygbe interface for configuration 
            

            upper_address_bits <= (others => '0');
            
            isp_address <= (others => '0');
            isp_num_bytes <= (others => '0');
            isp_write_data <= (others => '0');
            isp_write_data_strobe <= '0';
            isp_read_data_strobe <= '0';
            isp_command <= (others => '0');
            isp_start_transaction <= '0';
            
            icape_write_data <= (others => '0');
            icape_read_nwrite <= '0';
            icape_start_transaction <= '0';
            
            continuity_test_output <= (others => '0');
            continuity_test_mode <= '0';
            continuity_test_low <= '0';
            continuity_test_high <= '0';
            
            sdram_wb_program_en <= '0';
            sdram_wb_program_data_wr <= (others => '0');
            sdram_wb_program_ctl <= (others => '0');       
            sdram_wb_program_rx_valid <= '0'; 
            sdram_wb_program_rx_valid_pulse <= '0';
            sdram_wb_program_rx_valid_z1 <= '0';          
            
        elsif (rising_edge(CLK_I))then
            gbe_clear_count <= '0';
            --AI Start: Add fortygbe interface for configuration 
            fgbe_clear_count <= '0';
            --AI End: Add fortygbe interface for configuration 
            sdram_wb_program_rx_valid <= '0';  
            sdram_wb_program_rx_valid_z1 <= sdram_wb_program_rx_valid;
            --generate a write pulse valid for a single CLK_I cycle to ensure data is only written into
            --FIFO once         
            if(sdram_wb_program_rx_valid_z1 = '0' and sdram_wb_program_rx_valid = '1') then
              sdram_wb_program_rx_valid_pulse <= '1'; 
            else
              sdram_wb_program_rx_valid_pulse <= '0';             
            end if;           
            if ((reg_select = '1')and(WE_I = '1'))then
                case addra(3 downto 0) is
                    when C_OUTPUT_MODE_REG =>
                    if (SEL_I(0) = '1')then
                        current_mode <= DAT_I(1 downto 0);
                        flash_output_enable <= DAT_I(2);
                    end if;
                    
                    when C_UPPER_ADDRESS_REG =>
                    if (SEL_I(0) = '1')then
                        upper_address_bits(7 downto 0) <= DAT_I(7 downto 0);
                    end if;
                    if (SEL_I(1) = '1')then
                        upper_address_bits(15 downto 8) <= DAT_I(15 downto 8);
                    end if;
                    if (SEL_I(2) = '1')then
                        upper_address_bits(16) <= DAT_I(16);
                    end if;
                    
                    when C_CONFIG_IO_REG =>
                    if (SEL_I(0) = '1')then
                        clear_sdram <= DAT_I(0);
                        finished_writing_to_sdram <= DAT_I(1);
                        about_to_boot_from_sdram <= DAT_I(2);
                        finished_booting_from_sdram <= DAT_I(3);
                        reset_sdram_read_address <= DAT_I(4);
                        debug_sdram_read_mode <= DAT_I(5);
                    end if;
                    if (SEL_I(1) = '1')then
                        continuity_test_mode <= DAT_I(8);
                        continuity_test_low <= DAT_I(9);
                        continuity_test_high <= DAT_I(10);
                    end if;
                    
                    when C_GBE_STATISTICS_REG =>
                    if (SEL_I(0) = '1')then
                        gbe_clear_count <= DAT_I(0);
                        --AI Start: Add fortygbe interface for configuration
                        fgbe_clear_count <= DAT_I(0);                         
                        --AI End: Add fortygbe interface for configuration 

                    end if;
                    
                    when C_ICAPE_DATA_REG =>
                    if (SEL_I(0) = '1')then
                        icape_write_data(7 downto 0) <= DAT_I(7 downto 0);
                    end if;
                    if (SEL_I(1) = '1')then
                        icape_write_data(15 downto 8) <= DAT_I(15 downto 8);
                    end if;
                    if (SEL_I(2) = '1')then
                        icape_write_data(23 downto 16) <= DAT_I(23 downto 16);
                    end if;
                    if (SEL_I(3) = '1')then
                        icape_write_data(31 downto 24) <= DAT_I(31 downto 24);
                    end if;
                    
                    when C_ICAPE_CTL_REG => 
                    if (SEL_I(0) = '1')then
                        icape_read_nwrite <= DAT_I(0);
                        icape_start_transaction <= DAT_I(1);
                    end if;
                    
                    when C_ISP_SPI_ADDRESS_REG =>
                    if (SEL_I(0) = '1')then
                        isp_address(7 downto 0) <= DAT_I(7 downto 0);
                    end if;
                    if (SEL_I(1) = '1')then
                        isp_address(15 downto 8) <= DAT_I(15 downto 8);
                    end if;
                    if (SEL_I(2) = '1')then
                        isp_address(22 downto 16) <= DAT_I(22 downto 16);
                        isp_num_bytes(0) <= DAT_I(23);
                    end if;
                    -- NOTE DIFFERENT LOCATION OF NUM BYTES                    
                    if (SEL_I(3) = '1')then
                        isp_num_bytes(8 downto 1) <= DAT_I(31 downto 24);
                    end if;
                    
                    when C_ISP_SPI_DATA_CTRL_REG =>
                    if (SEL_I(0) = '1')then
                        isp_write_data <= DAT_I(7 downto 0);
                    end if;
                    if (SEL_I(1) = '1')then
                        isp_write_data_strobe <= DAT_I(8);
                        isp_read_data_strobe <= DAT_I(9);
                        isp_command <= DAT_I(12 downto 10);
                        isp_start_transaction <= DAT_I(13);
                    end if;
                    
                    when C_CONTINUITY_TEST_OUTPUT_REG =>
                    if (SEL_I(0) = '1')then
                        continuity_test_output(7 downto 0) <= DAT_I(7 downto 0);
                    end if;
                    if (SEL_I(1) = '1')then
                        continuity_test_output(15 downto 8) <= DAT_I(15 downto 8);
                    end if;
                    if (SEL_I(2) = '1')then
                        continuity_test_output(23 downto 16) <= DAT_I(23 downto 16);
                    end if;
                    if (SEL_I(3) = '1')then
                        continuity_test_output(31 downto 24) <= DAT_I(31 downto 24);
                    end if;
                    
                    --AI: Add in additional registers for FPGA reconfiguration via the uBlaze and not the fabric
                    when C_SDRAM_WB_PROGRAM_EN_REG =>
                    if (SEL_I(0) = '1') then
                        sdram_wb_program_en <= DAT_I(0);  --write: '1' = enable wishbone SDRAM programming, '0' = disable wishbone SDRAM programming (default)
                    end if;    

                    when C_SDRAM_WB_PROGRAM_DATA_WR_REG =>   --write: SDRAM wishbone write data for programming
                    if (SEL_I(0) = '1')then
                        sdram_wb_program_data_wr(7 downto 0) <= DAT_I(7 downto 0); 
                    end if;
                    if (SEL_I(1) = '1')then
                        sdram_wb_program_data_wr(15 downto 8) <= DAT_I(15 downto 8);
                    end if;
                    if (SEL_I(2) = '1')then
                        sdram_wb_program_data_wr(23 downto 16) <= DAT_I(23 downto 16);
                    end if;
                    if (SEL_I(3) = '1')then
                        sdram_wb_program_data_wr(31 downto 24) <= DAT_I(31 downto 24);
                        sdram_wb_program_rx_valid <= '1';
                        sdram_wb_program_ctl(0) <= '1'; --set acknowledge when data arrives from microblaze
                    end if;
                              
                    when C_SDRAM_WB_PROGRAM_CTL_REG => -- SDRAM wishbone program control bits
                    if (SEL_I(0) = '1')then
                        sdram_wb_program_ctl(0) <= DAT_I(0);  -- write: '0' = clear acknowledge (set by uBlaze)
                        sdram_wb_program_ctl(1) <= DAT_I(1);  -- write: '1' = start SDRAM program indicator (set by uBlaze)
                        sdram_wb_program_ctl(2) <= DAT_I(2);  -- write: '1' = finish SDRAM program indicator (set by uBlaze)
                        sdram_wb_program_ctl(31 downto 3) <= (others => '0');  -- Unused set to zero 
                    end if;
                    
                    when others =>
                     
                end case;
            end if;
        end if;
    end process;

    gbe_reg_dout <=
    ("000000000000000000000000000000" & current_mode) when (addra(3 downto 0) = C_OUTPUT_MODE_REG) else
    ("000000000000000" & upper_address_bits) when (addra(3 downto 0) = C_UPPER_ADDRESS_REG) else
    ("000000000000000000000" & continuity_test_high & continuity_test_low & continuity_test_mode & write_to_sdram_stall & booting_from_sdram & debug_sdram_read_mode & reset_sdram_read_address & finished_booting_from_sdram & about_to_boot_from_sdram & finished_writing_to_sdram & clear_sdram) when (addra(3 downto 0) = C_CONFIG_IO_REG) else
    (gbe_rx_overrun_count & gbe_rx_bad_frame_count & gbe_rx_frame_count) when (addra(3 downto 0) = C_GBE_STATISTICS_REG) else
    (icape_read_data) when (addra(3 downto 0) = C_ICAPE_DATA_REG) else
    ("0000000000000000000000000000000" & icape_transaction_complete) when (addra(3 downto 0) = C_ICAPE_CTL_REG) else
    (isp_num_bytes & isp_address) when (addra(3 downto 0) = C_ISP_SPI_ADDRESS_REG) else
    ("00000000000000000000000" & isp_transaction_complete & isp_read_data) when (addra(3 downto 0) = C_ISP_SPI_DATA_CTRL_REG) else
    ("0000000000000000" & flash_dq_in) when (addra(3 downto 0) = C_CONTINUITY_TEST_OUTPUT_REG) else
    ("0000000000000000000000000000000" & sdram_wb_program_en) when (addra(3 downto 0) = C_SDRAM_WB_PROGRAM_EN_REG) else 
    (sdram_wb_program_data_wr) when (addra(3 downto 0) = C_SDRAM_WB_PROGRAM_DATA_WR_REG) else 
    ("00000000000000000000000000000" & sdram_wb_program_ctl(2) & sdram_wb_program_ctl(1) & sdram_wb_program_ack) when (addra(3 downto 0) = C_SDRAM_WB_PROGRAM_CTL_REG) else   
    (others => '0');
   
    --AI Start: Add fortygbe interface for configuration 
    fgbe_reg_dout <=
    ("000000000000000000000000000000" & current_mode) when (addra(3 downto 0) = C_OUTPUT_MODE_REG) else
    ("000000000000000" & upper_address_bits) when (addra(3 downto 0) = C_UPPER_ADDRESS_REG) else
    ("000000000000000000000" & continuity_test_high & continuity_test_low & continuity_test_mode & write_to_sdram_stall & booting_from_sdram & debug_sdram_read_mode & reset_sdram_read_address & finished_booting_from_sdram & about_to_boot_from_sdram & finished_writing_to_sdram & clear_sdram) when (addra(3 downto 0) = C_CONFIG_IO_REG) else
    (fgbe_rx_overrun_count & fgbe_rx_bad_frame_count & fgbe_rx_frame_count) when (addra(3 downto 0) = C_GBE_STATISTICS_REG) else
    (icape_read_data) when (addra(3 downto 0) = C_ICAPE_DATA_REG) else
    ("0000000000000000000000000000000" & icape_transaction_complete) when (addra(3 downto 0) = C_ICAPE_CTL_REG) else
    (isp_num_bytes & isp_address) when (addra(3 downto 0) = C_ISP_SPI_ADDRESS_REG) else
    ("00000000000000000000000" & isp_transaction_complete & isp_read_data) when (addra(3 downto 0) = C_ISP_SPI_DATA_CTRL_REG) else
    ("0000000000000000" & flash_dq_in) when (addra(3 downto 0) = C_CONTINUITY_TEST_OUTPUT_REG) else
    ("0000000000000000000000000000000" & sdram_wb_program_en) when (addra(3 downto 0) = C_SDRAM_WB_PROGRAM_EN_REG) else  
    (sdram_wb_program_data_wr) when (addra(3 downto 0) = C_SDRAM_WB_PROGRAM_DATA_WR_REG) else 
    ("00000000000000000000000000000" & sdram_wb_program_ctl(2) & sdram_wb_program_ctl(1) & sdram_wb_program_ack) when (addra(3 downto 0) = C_SDRAM_WB_PROGRAM_CTL_REG) else
    (others => '0');
    --AI End: Add fortygbe interface for configuration    

    gen_reg_select_z1 : process(CLK_I)
    begin       
        if (rising_edge(CLK_I))then
            reg_select_z1 <= reg_select;
            reg_select_z2 <= reg_select_z1;
        end if;
    end process;

    gen_reg_ack : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            reg_ack <= '0';
        elsif (rising_edge(CLK_I))then
            if (reg_select_z2 = '0')and(reg_select_z1 = '1')then
                reg_ack <= '1';
            else
                reg_ack <= '0';
            end if;
        end if;
    end process;
    
-----------------------------------------------------------------------
-- SDRAM PROGRAMMING UBLAZE INTERFACE FIFO VIA WISHBONE CLOCK DOMAIN
-----------------------------------------------------------------------
    wb_comm_clock_din <= sdram_wb_program_data_wr when ((sdram_wb_program_rx_valid_pulse = '1') and (wb_comm_clock_almost_full = '0')) else X"00000000";
    wb_comm_clock_wrreq <= '1' when ((sdram_wb_program_rx_valid_pulse = '1') and (wb_comm_clock_almost_full = '0')) else '0'; 
    sdram_wb_program_ack <= '1' when ((sdram_wb_program_ctl(0) = '1') and (wb_comm_clock_almost_full = '0')) else '0';
    
    common_clock_fifo_32x16_0 : common_clock_fifo_32x16
    port map(
        rst             => RST_I,
        clk             => CLK_I,
        din             => wb_comm_clock_din,
        wr_en           => wb_comm_clock_wrreq,
        rd_en           => wb_comm_clock_rdreq,
        dout            => wb_comm_clock_dout,
        full            => wb_comm_clock_full,
        almost_full     => wb_comm_clock_almost_full,
        empty           => wb_comm_clock_empty);
                         
-----------------------------------------------------------------------
-- MOVE 1GBE ETHERNET HIGH BANDWIDTH TO WISHBONE CLOCK DOMAIN
-----------------------------------------------------------------------

    gbe_cross_clock_din(63 downto 0) <= gbe_rx_data;
    gbe_cross_clock_din(64) <= gbe_rx_end_of_frame;
    gbe_cross_clock_din(65) <= gbe_rx_bad_frame;
    gbe_cross_clock_din(66) <= gbe_rx_overrun;
    
    gbe_rx_ack <= '1' when ((gbe_rx_valid = '1')and(gbe_cross_clock_almost_full = '0')) else '0';
    gbe_cross_clock_wrreq <= '1' when ((gbe_rx_valid = '1')and(gbe_cross_clock_almost_full = '0')) else '0';
    
    cross_clock_fifo_67x16_0 : cross_clock_fifo_67x16
    port map(
        rst             => RST_I,
        wr_clk          => gbe_app_clk,
        rd_clk          => CLK_I,
        din             => gbe_cross_clock_din,
        wr_en           => gbe_cross_clock_wrreq,
        rd_en           => gbe_cross_clock_rdreq,
        dout            => gbe_cross_clock_dout,
        full            => gbe_cross_clock_full,
        almost_full     => gbe_cross_clock_almost_full,
        empty           => gbe_cross_clock_empty);

--AI Start: Add fortygbe interface for configuration        
-----------------------------------------------------------------------
-- MOVE 40GBE ETHERNET HIGH BANDWIDTH TO WISHBONE CLOCK DOMAIN
-----------------------------------------------------------------------
   --NB: 64 bit Words need to be swopped around in order for flash SDRAM interface to configure correctly.    
    fgbe_cross_clock_din(255 downto 192) <= fgbe_rx_data(63 downto 0);
    fgbe_cross_clock_din(191 downto 128) <= fgbe_rx_data(127 downto 64);
    fgbe_cross_clock_din(127 downto 64) <= fgbe_rx_data(191 downto 128);
    fgbe_cross_clock_din(63 downto 0) <= fgbe_rx_data(255 downto 192);
      
    fgbe_cross_clock_din(256) <= fgbe_rx_end_of_frame;
    fgbe_cross_clock_din(257) <= fgbe_rx_bad_frame;
    fgbe_cross_clock_din(258) <= fgbe_rx_overrun;
    
    fgbe_rx_ack <= '1' when ((fgbe_rx_valid /= "0000")and(fgbe_cross_clock_almost_full = '0')) else '0';
    fgbe_cross_clock_wrreq <= '1' when ((fgbe_rx_valid /= "0000")and(fgbe_cross_clock_almost_full = '0')) else '0';
    
    cross_clock_fifo_259x16_0 : cross_clock_fifo_259x16
    port map(
        rst             => RST_I,
        wr_clk          => fgbe_app_clk,
        rd_clk          => CLK_I,
        din             => fgbe_cross_clock_din,
        wr_en           => fgbe_cross_clock_wrreq,
        rd_en           => fgbe_cross_clock_rdreq,
        dout            => fgbe_cross_clock_dout,
        full            => fgbe_cross_clock_full,
        almost_full     => fgbe_cross_clock_almost_full,
        empty           => fgbe_cross_clock_empty); 
        
--AI End: Add fortygbe interface for configuration                   

-----------------------------------------------------------------------
-- SDRAM PROGRAM MODE
-----------------------------------------------------------------------

    spartan_clk <= spartan_clk_i;

    -- GENERATE SPARTAN_CLK ALWAYS
    gen_spartan_clk : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            spartan_clk_i <= '0';
        elsif (rising_edge(CLK_I))then
            spartan_clk_i <= not spartan_clk_i;
        end if;
    end process;

    spartan_clk_rising_edge_enable <= not spartan_clk_i;
    spartan_clk_falling_edge_enable <= spartan_clk_i;

    gbe_cross_clock_rdreq <= '1' when
    ((spartan_clk_rising_edge_enable = '1')and
    (gbe_cross_clock_empty = '0')and
    (write_to_sdram_stall = '0')and
    (gbe_sdram_dq_count >= "011")) else '0';
    
--AI Start: Add fortygbe interface for configuration  

    fgbe_cross_clock_rdreq <= '1' when
    ((spartan_clk_rising_edge_enable = '1')and
    (fgbe_cross_clock_empty = '0')and
    (write_to_sdram_stall = '0')and
    (fgbe_sdram_dq_count >= "01111")) else '0';
    
--AI End: Add fortygbe interface for configuration      

    wb_comm_clock_rdreq <= '1' when
    ((spartan_clk_rising_edge_enable = '1')and
    (wb_comm_clock_empty = '0')and
    (write_to_sdram_stall = '0')and
    (wb_sdram_dq_count >= "01")) else '0';    

    gen_gbe_sdram_dq_count : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            gbe_sdram_dq_count <= "111";
        elsif (rising_edge(CLK_I))then
            if (gbe_cross_clock_rdreq = '1')then
                gbe_sdram_dq_count <= "000";
            else
                if ((gbe_sdram_dq_count /= "111")and(spartan_clk_rising_edge_enable = '1'))then
                    gbe_sdram_dq_count <= gbe_sdram_dq_count + "001";
                end if;
            end if;
        end if;
    end process;
    
   --AI Start: Add fortygbe interface for configuration   
   gen_fgbe_sdram_dq_count : process(RST_I, CLK_I)
   begin
       if (RST_I = '1')then
           fgbe_sdram_dq_count <= "11111";
       elsif (rising_edge(CLK_I))then
           if (fgbe_cross_clock_rdreq = '1')then
               fgbe_sdram_dq_count <= "00000";
           else
               if ((fgbe_sdram_dq_count /= "11111")and(spartan_clk_rising_edge_enable = '1'))then
                   fgbe_sdram_dq_count <= fgbe_sdram_dq_count + "00001";
               end if;
           end if;
       end if;
   end process;   
   --AI End: Add fortygbe interface for configuration 
   
    gen_wb_sdram_dq_count : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            wb_sdram_dq_count <= "11";
        elsif (rising_edge(CLK_I))then
            if (wb_comm_clock_rdreq = '1')then
                wb_sdram_dq_count <= "00";
            else
                if ((wb_sdram_dq_count /= "11")and(spartan_clk_rising_edge_enable = '1'))then
                    wb_sdram_dq_count <= wb_sdram_dq_count + "01";
                end if;
            end if;
        end if;
    end process;   
   

    gen_gbe_cross_clock_rdreq_z1 : process(CLK_I)
    begin
        if (rising_edge(CLK_I))then
            gbe_cross_clock_rdreq_z1 <= gbe_cross_clock_rdreq;
        end if;
    end process;

   --AI Start: Add fortygbe interface for configuration       
    gen_fgbe_cross_clock_rdreq_z1 : process(CLK_I)
    begin
        if (rising_edge(CLK_I))then
            fgbe_cross_clock_rdreq_z1 <= fgbe_cross_clock_rdreq;
        end if;
    end process;
   --AI End: Add fortygbe interface for configuration 
   
    gen_wb_comm_clock_rdreq_z1 : process(CLK_I)
    begin
       if (rising_edge(CLK_I))then
           wb_comm_clock_rdreq_z1 <= wb_comm_clock_rdreq;
           wb_comm_clock_rdreq_z2 <= wb_comm_clock_rdreq_z1;
           wb_comm_clock_rdreq_z3 <= wb_comm_clock_rdreq_z2;  
           wb_comm_clock_rdreq_z4 <= wb_comm_clock_rdreq_z3;
           wb_comm_clock_rdreq_z5 <= wb_comm_clock_rdreq_z4;                        
       end if;
    end process;   
    
   --AI Start: Add fortygbe interface for configuration
   --Modified to handle fortygbe interface for configuration as well       

    gen_sdram_dq_out_i : process(RST_I, CLK_I, fgbe_config_en, sdram_wb_program_en, sdram_wb_program_ctl)
    begin
        if (RST_I = '1')then
            sdram_program_header <= '1';
            sdram_program_valid_a <= '0';          
            sdram_dq_out_i <= (others => '0');
            config_io_1_i <= '0';
        elsif (rising_edge(CLK_I))then
            if (spartan_clk_falling_edge_enable = '1')then           
                --Wishbone Configuration Only
                if(sdram_wb_program_en = '1') then
                    sdram_program_header <= '0';
                    --if the SDRAM is starting to be programmed then set the valid to '1'
                    if (sdram_wb_program_ctl(1) = '1' and sdram_wb_program_ctl(2) = '0' ) then
                        sdram_program_valid_a <= '1';
                    --if the SDRAM is finishing the programming the set the valid to '0'    
                    elsif(sdram_wb_program_ctl(1) = '0' and sdram_wb_program_ctl(2) = '1') then
                        sdram_program_valid_a <= '0';
                    end if;
                    if (wb_sdram_dq_count = "00")then    
                        sdram_dq_out_i <= wb_comm_clock_dout(31 downto 16);
                        config_io_1_i <= '1';
                    elsif (wb_sdram_dq_count = "01")then 
                        sdram_dq_out_i <= wb_comm_clock_dout(15 downto 0);
                        config_io_1_i <= '1';
                    else
                        sdram_dq_out_i <= (others => '0');
                        config_io_1_i <= '0';
                    end if;                         
                --1GbE Configuration Only
                elsif(fgbe_config_en = '0') then
                    sdram_program_valid_a <= '0';                 
                    if (gbe_sdram_dq_count = "000")then    
                        config_io_1_i <= not sdram_program_header;
                        sdram_dq_out_i <= gbe_cross_clock_dout(63 downto 48);
                    elsif (gbe_sdram_dq_count = "001")then 
                        sdram_dq_out_i <= gbe_cross_clock_dout(47 downto 32);
                        config_io_1_i <= not sdram_program_header;
                    elsif (gbe_sdram_dq_count = "010")then    
                        sdram_dq_out_i <= gbe_cross_clock_dout(31 downto 16);
                        config_io_1_i <= not sdram_program_header;
                    elsif (gbe_sdram_dq_count = "011")then
                        sdram_dq_out_i <= gbe_cross_clock_dout(15 downto 0);
                        config_io_1_i <= not sdram_program_header;
                                            
                        if (gbe_cross_clock_dout(64) = '1')then
                            -- REACHED END OF PACKET SO ENABLE FOR HEADER AGAIN
                            sdram_program_header <= '1';
                        else
                            sdram_program_header <= '0';
                        end if;
                    else
                        sdram_dq_out_i <= (others => '0');
                        config_io_1_i <= '0';
                    end if; 
                --40GbE Configuration Only
                else
                    sdram_program_valid_a <= '0';                  
                    if (fgbe_sdram_dq_count = "00000")then    
                        config_io_1_i <= not sdram_program_header;
                        sdram_dq_out_i <= fgbe_cross_clock_dout(255 downto 240);
                    elsif (fgbe_sdram_dq_count = "00001")then 
                        sdram_dq_out_i <= fgbe_cross_clock_dout(239 downto 224);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "00010")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(223 downto 208);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "00011")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(207 downto 192);
                        config_io_1_i <= not sdram_program_header;
                        if (fgbe_cross_clock_dout(256) = '1')then
                        -- REACHED END OF PACKET SO ENABLE FOR HEADER AGAIN
                           sdram_program_header <= '1';
                        else
                           sdram_program_header <= '0';
                        end if;                        
                    elsif (fgbe_sdram_dq_count = "00100")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(191 downto 176);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "00101")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(175 downto 160);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "00110")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(159 downto 144);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "00111")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(143 downto 128);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01000")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(127 downto 112);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01001")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(111 downto 96);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01010")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(95 downto 80);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01011")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(79 downto 64);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01100")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(63 downto 48);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01101")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(47 downto 32);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01110")then    
                        sdram_dq_out_i <= fgbe_cross_clock_dout(31 downto 16);
                        config_io_1_i <= not sdram_program_header;
                    elsif (fgbe_sdram_dq_count = "01111")then
                        sdram_dq_out_i <= fgbe_cross_clock_dout(15 downto 0);
                        config_io_1_i <= not sdram_program_header;                                        
                    else
                       sdram_dq_out_i <= (others => '0');
                       config_io_1_i <= '0';
                    end if;                   
                end if;               
            end if;
        end if;
    end process;
   --AI End: Add fortygbe interface for configuration   



    -- FILTER OUTPUT BASED ON PACKET TYPE
    --AI Start: Add fortygbe interface for configuration
    --Modified to handle fortygbe interface for configuration as well      
    gen_valid_sdram_program_packet : process(RST_I, CLK_I, fgbe_config_en)
    begin
        if (RST_I = '1')then
            valid_sdram_program_packet <= '0';   
            debug_sdram_program_header <= (others => '0');
            sequence_number <= (others => '0');
        elsif (rising_edge(CLK_I))then
          --1GbE Configuration Only          
          if (fgbe_config_en = '0') then
            if (sdram_program_header = '1')and(gbe_cross_clock_rdreq_z1 = '1')then
                if (gbe_cross_clock_dout(63 downto 48) = C_SDRAM_PROGRAM_PACKET_TYPE)then
                    -- IF FIRST PACKET THEN JUST GET THE SEQUENCE NUMBER
                    if (gbe_cross_clock_dout(31 downto 16) = X"0001")then
                        sequence_number <= gbe_cross_clock_dout(47 downto 32) + X"0001";
                        valid_sdram_program_packet <= '1';
                    else
                    -- ELSE CHECK THE SEQUENCE NUMBER
                        if (gbe_cross_clock_dout(47 downto 32) = sequence_number)then
                            valid_sdram_program_packet <= '1';
                            sequence_number <= sequence_number + X"0001";
                        else
                            valid_sdram_program_packet <= '0';
                        end if;
                    end if;                     
                    debug_sdram_program_header <= gbe_cross_clock_dout(63 downto 0);
                else
                    valid_sdram_program_packet <= '0';
                    debug_sdram_program_header <= gbe_cross_clock_dout(63 downto 0);
                end if;
            end if;
          --40GbE Configuration Only
          else
            if (sdram_program_header = '1')and(fgbe_cross_clock_rdreq_z1 = '1')then
              if (fgbe_cross_clock_dout(255 downto 240) = C_SDRAM_PROGRAM_PACKET_TYPE)then
                  -- IF FIRST PACKET THEN JUST GET THE SEQUENCE NUMBER
                  if (fgbe_cross_clock_dout(223 downto 208) = X"0001")then
                      sequence_number <= fgbe_cross_clock_dout(239 downto 224) + X"0001";
                      valid_sdram_program_packet <= '1';
                  else
                  -- ELSE CHECK THE SEQUENCE NUMBER
                      if (fgbe_cross_clock_dout(239 downto 224) = sequence_number)then
                          valid_sdram_program_packet <= '1';
                          sequence_number <= sequence_number + X"0001";
                      else
                          valid_sdram_program_packet <= '0';
                      end if;
                  end if;                     
                  debug_sdram_program_header <= fgbe_cross_clock_dout(255 downto 192);
              else
                  valid_sdram_program_packet <= '0';
                  debug_sdram_program_header <= fgbe_cross_clock_dout(255 downto 192);
              end if;
            end if;
          end if;  
        end if;
    end process;
    --AI End: Add fortygbe interface for configuration

    --gate the delayed rd request signal with the sdram program data valid
    sdram_program_valid <= sdram_program_valid_a and (wb_comm_clock_rdreq_z3 or wb_comm_clock_rdreq_z5);


    gen_sdram_dq_out : process(RST_I, CLK_I, valid_sdram_program_packet, sdram_program_valid)
    begin
        if (RST_I = '1')then
            sdram_dq_out <= (others => '0');
            config_io_1 <= '0';
        elsif (rising_edge(CLK_I))then
            if (spartan_clk_falling_edge_enable = '1')then
                  if (valid_sdram_program_packet = '1' or sdram_program_valid = '1')then
                      sdram_dq_out <= sdram_dq_out_i;
                      config_io_1 <= config_io_1_i;
                  else
                      sdram_dq_out <= (others => '0');
                      config_io_1 <= '0';
                  end if;
            end if;
        end if;
    end process;

-----------------------------------------------------------------------
-- 1GBE ETHERNET STATISTICS
-----------------------------------------------------------------------

    gen_gbe_rx_frame_count : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            gbe_rx_frame_count <= (others => '0');
        elsif (rising_edge(CLK_I))then
            if (gbe_clear_count = '1')then    
                gbe_rx_frame_count <= (others => '0');
            else
                if ((gbe_cross_clock_rdreq_z1 = '1')and(gbe_cross_clock_dout(64) = '1')and(valid_sdram_program_packet = '1'))then
                    gbe_rx_frame_count <= gbe_rx_frame_count + X"0001";
                end if;
            end if;
        end if;
    end process;

    gen_gbe_rx_bad_frame_count : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            gbe_rx_bad_frame_count <= (others => '0');
        elsif (rising_edge(CLK_I))then
            if (gbe_clear_count = '1')then    
                gbe_rx_bad_frame_count <= (others => '0');
            else
                if ((gbe_cross_clock_rdreq_z1 = '1')and(gbe_cross_clock_dout(65) = '1'))then
                    gbe_rx_bad_frame_count <= gbe_rx_bad_frame_count + X"01";
                end if;
            end if;
        end if;
    end process;

    gen_gbe_rx_overrun_count : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            gbe_rx_overrun_count <= (others => '0');
        elsif (rising_edge(CLK_I))then
            if (gbe_clear_count = '1')then    
                gbe_rx_overrun_count <= (others => '0');
            else
                if ((gbe_cross_clock_rdreq_z1 = '1')and(gbe_cross_clock_dout(66) = '1'))then
                    gbe_rx_overrun_count <= gbe_rx_overrun_count + X"01";
                end if;
            end if;
        end if;
    end process;
 
--AI Start: Add fortygbe interface for configuration       
-----------------------------------------------------------------------
-- 40GBE ETHERNET STATISTICS
-----------------------------------------------------------------------
   
   gen_fgbe_rx_frame_count : process(RST_I, CLK_I)
   begin
       if (RST_I = '1')then
           fgbe_rx_frame_count <= (others => '0');
       elsif (rising_edge(CLK_I))then
           if (fgbe_clear_count = '1')then    
               fgbe_rx_frame_count <= (others => '0');
           else
               if ((fgbe_cross_clock_rdreq_z1 = '1')and(fgbe_cross_clock_dout(256) = '1')and(valid_sdram_program_packet = '1'))then
                   fgbe_rx_frame_count <= fgbe_rx_frame_count + X"0001";
               end if;
           end if;
       end if;
   end process;

   gen_fgbe_rx_bad_frame_count : process(RST_I, CLK_I)
   begin
       if (RST_I = '1')then
           fgbe_rx_bad_frame_count <= (others => '0');
       elsif (rising_edge(CLK_I))then
           if (fgbe_clear_count = '1')then    
               fgbe_rx_bad_frame_count <= (others => '0');
           else
               if ((fgbe_cross_clock_rdreq_z1 = '1')and(fgbe_cross_clock_dout(257) = '1'))then
                   fgbe_rx_bad_frame_count <= fgbe_rx_bad_frame_count + X"01";
               end if;
           end if;
       end if;
   end process;

   gen_fgbe_rx_overrun_count : process(RST_I, CLK_I)
   begin
       if (RST_I = '1')then
           fgbe_rx_overrun_count <= (others => '0');
       elsif (rising_edge(CLK_I))then
           if (fgbe_clear_count = '1')then    
               fgbe_rx_overrun_count <= (others => '0');
           else
               if ((fgbe_cross_clock_rdreq_z1 = '1')and(fgbe_cross_clock_dout(258) = '1'))then
                   fgbe_rx_overrun_count <= fgbe_rx_overrun_count + X"01";
               end if;
           end if;
       end if;
   end process;

--AI End: Add fortygbe interface for configuration       
    
-----------------------------------------------------------------------
-- CONFIG IO SIDEBAND SIGNALS
-----------------------------------------------------------------------

    -- TRIPPLE REGISTER FEEDBACK SIGNALS
    gen_config_io_z : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            config_io_2_z1 <= '0';
            config_io_5_z1 <= '0';
            config_io_2_z2 <= '0';
            config_io_5_z2 <= '0';
            config_io_2_z3 <= '0';
            config_io_5_z3 <= '0';
        elsif (rising_edge(CLK_I))then
            config_io_2_z1 <= config_io_2;
            config_io_5_z1 <= config_io_5;
            config_io_2_z2 <= config_io_2_z1;
            config_io_5_z2 <= config_io_5_z1;
            config_io_2_z3 <= config_io_2_z2;
            config_io_5_z3 <= config_io_5_z2;
        end if;
    end process;

    booting_from_sdram <= config_io_5_z3;
    write_to_sdram_stall <= config_io_2_z3;

    config_io_0 <= clear_sdram;
    config_io_3 <= finished_writing_to_sdram;
    config_io_4 <= about_to_boot_from_sdram;
    config_io_6 <= finished_booting_from_sdram;
    config_io_7 <= reset_sdram_read_address;
    config_io_8 <= debug_sdram_read_mode;
    config_io_10 <= continuity_test_low;
    config_io_11 <= continuity_test_high;

-----------------------------------------------------------------------
-- MUX FLASH BUS FOR TWO DIFFERENT MODES
-----------------------------------------------------------------------

    flash_dq_out <=
        flash_dq_out_i when (current_mode = C_FLASH_MODE) else
        sdram_dq_out when (current_mode = C_SDRAM_PROGRAM_MODE) else
        (others => '0');
   
    flash_dq_out_en <=
        flash_dq_out_en_i when (current_mode = C_FLASH_MODE) else
        '1' when (current_mode = C_SDRAM_PROGRAM_MODE) else
        '0';
        
    flash_a <=
        continuity_test_output(28 downto 0) when (continuity_test_mode = '1') else
        flash_a_i when (current_mode = C_FLASH_MODE) else
        (others => '0');
   
    flash_cs_n <=
        flash_cs_n_i when (current_mode = C_FLASH_MODE) else
        '1';
    
    flash_oe_n <=
        continuity_test_output(31) when (continuity_test_mode = '1') else
        flash_oe_n_i when (current_mode = C_FLASH_MODE) else
        '1';
           
    flash_we_n <=
        continuity_test_output(29) when (continuity_test_mode = '1') else
        flash_we_n_i when (current_mode = C_FLASH_MODE) else
        '1';

    flash_adv_n <=
        continuity_test_output(30) when (continuity_test_mode = '1') else
        flash_adv_n_i when (current_mode = C_FLASH_MODE) else
        '1';

    mem_dout <=
        flash_dout when (current_mode = C_FLASH_MODE) else
        sdram_dout;

    mem_ack <=
        flash_ack when (current_mode = C_FLASH_MODE) else
        sdram_ack;

-----------------------------------------------------------------------
-- FLASH STATUS MACHINE
-----------------------------------------------------------------------

    gen_mem_select_z1 : process(CLK_I)
    begin
        if (rising_edge(CLK_I))then
            mem_select_z1 <= mem_select;
        end if;
    end process;

    gen_current_flash_state : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            flash_dq_in_latched <= (others => '0');
            current_flash_state <= FLASH_IDLE;
        
        elsif (rising_edge(CLK_I))then
            case current_flash_state is    
                when FLASH_IDLE =>
                current_flash_state <= FLASH_IDLE;
                
                if ((mem_select_z1 = '0')and(mem_select = '1')and(current_mode = C_FLASH_MODE))then
                    if (WE_I = '1')then
                        current_flash_state <= FLASH_WRITE_ACCESS;
                    else
                        current_flash_state <= FLASH_READ_ACCESS;
                    end if;
                end if;
                
                when FLASH_WRITE_ACCESS =>
                current_flash_state <= FLASH_WRITE_ACCESS;
                
                if (flash_delay_count = C_FLASH_WRITE_DELAY)then
                    current_flash_state <= FLASH_WRITE_RECOVER_1;
                end if;
                
                when FLASH_WRITE_RECOVER_1 =>
                current_flash_state <= FLASH_WRITE_RECOVER_2;
    
                when FLASH_WRITE_RECOVER_2 =>
                current_flash_state <= FLASH_WRITE_RECOVER_2;
                
                if (flash_delay_count = C_FLASH_WRITE_RECOVER_DELAY)then
                    current_flash_state <= FLASH_GEN_ACK;
                end if;
                
                when FLASH_READ_ACCESS =>
                current_flash_state <= FLASH_READ_ACCESS;
                
                if (flash_delay_count = C_FLASH_READ_DELAY)then
                    flash_dq_in_latched <= flash_dq_in;
                    current_flash_state <= FLASH_READ_RECOVER;
                end if;
                
                when FLASH_READ_RECOVER =>
                current_flash_state <= FLASH_READ_RECOVER;
                
                if (flash_delay_count = C_FLASH_READ_RECOVER_DELAY)then
                    current_flash_state <= FLASH_GEN_ACK;
                end if;
                
                when FLASH_GEN_ACK =>
                current_flash_state <= FLASH_IDLE;
                
            end case;
        end if;
    end process;

    reset_flash_delay_count <= '1' when 
    ((current_flash_state = FLASH_IDLE)or
    (current_flash_state = FLASH_GEN_ACK))else '0';

    gen_flash_delay_count : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            flash_delay_count <= "000001";
        elsif (rising_edge(CLK_I))then
            if (reset_flash_delay_count = '1')then
                flash_delay_count <= "000001";
            else
                flash_delay_count <= flash_delay_count + "000001";
            end if;
        end if;
    end process;

    flash_ack <= '1' when (current_flash_state = FLASH_GEN_ACK) else '0';
    
    gen_flash_control : process(current_flash_state)
    begin
        case current_flash_state is
            when FLASH_IDLE | FLASH_WRITE_RECOVER_2 | FLASH_READ_RECOVER | FLASH_GEN_ACK =>
            flash_cs_n_i <= '1';
            flash_oe_n_i <= '1';
            flash_we_n_i <= '1';
            flash_adv_n_i <= '1';
            flash_dq_out_en_i <= '0';
        
            when FLASH_WRITE_ACCESS =>
            flash_cs_n_i <= '0';
            flash_oe_n_i <= '1';
            flash_we_n_i <= '0';
            flash_adv_n_i <= '0';
            flash_dq_out_en_i <= '1';
            
            when FLASH_WRITE_RECOVER_1 =>
            flash_cs_n_i <= '1';
            flash_oe_n_i <= '1';
            flash_we_n_i <= '1';
            flash_adv_n_i <= '1';
            flash_dq_out_en_i <= '1';

            when FLASH_READ_ACCESS =>
            flash_cs_n_i <= '0';
            flash_oe_n_i <= '0';
            flash_we_n_i <= '1';
            flash_adv_n_i <= '0';
            flash_dq_out_en_i <= '0';
        
        end case;
    end process;

    flash_dq_out_i <= DAT_I(15 downto 0);
    flash_dout <= (X"0000" & flash_dq_in_latched);
    flash_a_i <= (upper_address_bits & addra);

-----------------------------------------------------------------------
-- SDRAM READ STATE MACHINE
-----------------------------------------------------------------------

    gen_current_sdram_read_state : process(RST_I, CLK_I)
    begin
        if (RST_I = '1')then
            sdram_dout <= (others => '0');
            current_sdram_read_state <= SDRAM_READ_IDLE;
        elsif (rising_edge(CLK_I))then
            case current_sdram_read_state is    
                when SDRAM_READ_IDLE =>
                current_sdram_read_state <= SDRAM_READ_IDLE;
                
                if ((mem_select_z1 = '0')and(mem_select = '1')and(current_mode = C_SDRAM_READ_MODE))then
                    if (WE_I = '1')then
                        -- IF WRITE, ACK IMMEDIATELY BECAUSE SDRAM WRITES NOT DONE THROUGH WISHBONE
                        current_sdram_read_state <= SDRAM_READ_ACK;
                    else
                        current_sdram_read_state <= SDRAM_READ_LOW_0;
                    end if;
                end if;
                
                when SDRAM_READ_LOW_0 =>
                current_sdram_read_state <= SDRAM_READ_LOW_0;
                
                if (sdram_read_delay_count = C_SDRAM_READ_DELAY_0)then
                    -- DATA ALREADY READ OUT, SO CAPTURE HERE BEFORE STARTING NEXT READ
                    sdram_dout(15 downto 0) <= flash_dq_in;
                    current_sdram_read_state <= SDRAM_READ_HIGH_0;
                end if;
                
                when SDRAM_READ_HIGH_0 =>
                current_sdram_read_state <= SDRAM_READ_HIGH_0;
                
                if (sdram_read_delay_count = C_SDRAM_READ_DELAY_1)then
                    --sdram_dout(15 downto 0) <= flash_dq_in;
                    current_sdram_read_state <= SDRAM_READ_LOW_1;
                end if;                
                
                when SDRAM_READ_LOW_1 =>
                current_sdram_read_state <= SDRAM_READ_LOW_1;
                
                if (sdram_read_delay_count = C_SDRAM_READ_DELAY_2)then
                    -- DATA ALREADY READ OUT, SO CAPTURE HERE BEFORE STARTING NEXT READ
                    sdram_dout(31 downto 16) <= flash_dq_in;
                    current_sdram_read_state <= SDRAM_READ_HIGH_1;
                end if;
                
                when SDRAM_READ_HIGH_1 =>
                current_sdram_read_state <= SDRAM_READ_HIGH_1;
                
                if (sdram_read_delay_count = C_SDRAM_READ_DELAY_3)then
                    --sdram_dout(31 downto 16) <= flash_dq_in;
                    current_sdram_read_state <= SDRAM_READ_ACK;
                end if;
                
                when SDRAM_READ_ACK =>
                current_sdram_read_state <= SDRAM_READ_IDLE;
    
            end case;
        end if;
    end process;
    
    config_io_9 <= '1' when
    ((current_sdram_read_state = SDRAM_READ_HIGH_0)or
    (current_sdram_read_state = SDRAM_READ_HIGH_1)) else '0';
    
    sdram_ack <= '1' when (current_sdram_read_state = SDRAM_READ_ACK) else '0';
    
    reset_sdram_read_delay_count <= '1' when 
    ((current_sdram_read_state = SDRAM_READ_IDLE)or
    (current_sdram_read_state = SDRAM_READ_ACK))else '0';
 
     gen_sdram_read_delay_count : process(RST_I, CLK_I)
     begin
         if (RST_I = '1')then
             sdram_read_delay_count <= (others => '0');
         elsif (rising_edge(CLK_I))then
             if (reset_sdram_read_delay_count = '1')then
                 sdram_read_delay_count <= "000001";
             else
                 sdram_read_delay_count <= sdram_read_delay_count + "000001";
             end if;
         end if;
     end process;
    
-----------------------------------------------------------------------
-- SPI MODE - IN SYSTEM PROGRAMMING OF SPARTAN 3 AN
-----------------------------------------------------------------------
 
    isp_spi_programmer_0 : isp_spi_programmer
    port map(
        clk => CLK_I,
        rst => RST_I,
        isp_address              => isp_address,
        isp_num_bytes            => isp_num_bytes,
        isp_write_data           => isp_write_data,
        isp_write_data_strobe    => isp_write_data_strobe,
        isp_read_data            => isp_read_data,
        isp_read_data_strobe     => isp_read_data_strobe,
        isp_command              => isp_command,
        isp_start_transaction    => isp_start_transaction,
        isp_transaction_complete => isp_transaction_complete,
        spi_clk    => spi_clk,
        spi_csb    => spi_csb,
        spi_mosi   => spi_mosi,
        spi_miso   => spi_miso);

-----------------------------------------------------------------------
-- ICAPE2 CONTROLLER
-----------------------------------------------------------------------

    icape_controller_0 : icape_controller
    port map (
        clk => CLK_I,
        rst => RST_I,
        icape_write_data           => icape_write_data,
        icape_read_data            => icape_read_data,
        icape_read_nwrite          => icape_read_nwrite,
        icape_start_transaction    => icape_start_transaction,
        icape_transaction_complete => icape_transaction_complete);
    
end arch_wishbone_flash_sdram_interface;
