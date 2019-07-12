-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity test_vcu128_stub is
  port (
    test_vcu128_gbe_app_dbg_data : in std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_dbg_dvld : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_badframe : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_data : in std_logic_vector( 8-1 downto 0 );
    test_vcu128_gbe_app_rx_dvld : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_eof : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_overrun : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_srcip : in std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_rx_srcport : in std_logic_vector( 16-1 downto 0 );
    test_vcu128_gbe_app_tx_afull : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_overflow : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_rst_user_data_out : in std_logic_vector( 32-1 downto 0 );
    clk : in std_logic;
    test_vcu128_gbe_app_rx_ack : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_rst : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_data : out std_logic_vector( 8-1 downto 0 );
    test_vcu128_gbe_app_tx_destip : out std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_tx_destport : out std_logic_vector( 16-1 downto 0 );
    test_vcu128_gbe_app_tx_dvld : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_eof : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_rst : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_led_gateway : out std_logic_vector( 1-1 downto 0 )
  );
end test_vcu128_stub;
architecture structural of test_vcu128_stub is 
begin
  sysgen_dut : entity xil_defaultlib.test_vcu128 
  port map (
    test_vcu128_gbe_app_dbg_data => test_vcu128_gbe_app_dbg_data,
    test_vcu128_gbe_app_dbg_dvld => test_vcu128_gbe_app_dbg_dvld,
    test_vcu128_gbe_app_rx_badframe => test_vcu128_gbe_app_rx_badframe,
    test_vcu128_gbe_app_rx_data => test_vcu128_gbe_app_rx_data,
    test_vcu128_gbe_app_rx_dvld => test_vcu128_gbe_app_rx_dvld,
    test_vcu128_gbe_app_rx_eof => test_vcu128_gbe_app_rx_eof,
    test_vcu128_gbe_app_rx_overrun => test_vcu128_gbe_app_rx_overrun,
    test_vcu128_gbe_app_rx_srcip => test_vcu128_gbe_app_rx_srcip,
    test_vcu128_gbe_app_rx_srcport => test_vcu128_gbe_app_rx_srcport,
    test_vcu128_gbe_app_tx_afull => test_vcu128_gbe_app_tx_afull,
    test_vcu128_gbe_app_tx_overflow => test_vcu128_gbe_app_tx_overflow,
    test_vcu128_rst_user_data_out => test_vcu128_rst_user_data_out,
    clk => clk,
    test_vcu128_gbe_app_rx_ack => test_vcu128_gbe_app_rx_ack,
    test_vcu128_gbe_app_rx_rst => test_vcu128_gbe_app_rx_rst,
    test_vcu128_gbe_app_tx_data => test_vcu128_gbe_app_tx_data,
    test_vcu128_gbe_app_tx_destip => test_vcu128_gbe_app_tx_destip,
    test_vcu128_gbe_app_tx_destport => test_vcu128_gbe_app_tx_destport,
    test_vcu128_gbe_app_tx_dvld => test_vcu128_gbe_app_tx_dvld,
    test_vcu128_gbe_app_tx_eof => test_vcu128_gbe_app_tx_eof,
    test_vcu128_gbe_app_tx_rst => test_vcu128_gbe_app_tx_rst,
    test_vcu128_led_gateway => test_vcu128_led_gateway
  );
end structural;
