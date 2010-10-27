-------------------------------------------------------------------------------
-- Title      : Top level wrapper
-- Project    : XAUI
-------------------------------------------------------------------------------
-- File       : xaui_v6_2_top.vhd
-------------------------------------------------------------------------------
-- Description: This file contains the top level of the design example delivered
-- with the XAUI core by Core Generator.  It contains all of the clock 
-- management logic required for implementing the core delivered by
-- Core Generator and instances of the transceiver logic necessary for correct 
-- usage of the RocketIO transceivers used to realise the XAUI interface.
-------------------------------------------------------------------------------
-- Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc. , is distributed by
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This 
-- copyright notice must be retained as part of this text 
-- at all times.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity xaui_v6_2_top is
    port (
      reset            : in  std_logic;
      xgmii_txd        : in  std_logic_vector(63 downto 0);
      xgmii_txc        : in  std_logic_vector(7 downto 0);
      xgmii_rxd        : out std_logic_vector(63 downto 0);
      xgmii_rxc        : out std_logic_vector(7 downto 0);
      refclk_p         : in  std_logic;
      refclk_n         : in  std_logic;
      xaui_tx_l0_p     : out std_logic;
      xaui_tx_l0_n     : out std_logic;
      xaui_tx_l1_p     : out std_logic;
      xaui_tx_l1_n     : out std_logic;
      xaui_tx_l2_p     : out std_logic;
      xaui_tx_l2_n     : out std_logic;
      xaui_tx_l3_p     : out std_logic;
      xaui_tx_l3_n     : out std_logic;
      xaui_rx_l0_p     : in  std_logic;
      xaui_rx_l0_n     : in  std_logic;
      xaui_rx_l1_p     : in  std_logic;
      xaui_rx_l1_n     : in  std_logic;
      xaui_rx_l2_p     : in  std_logic;
      xaui_rx_l2_n     : in  std_logic;
      xaui_rx_l3_p     : in  std_logic;
      xaui_rx_l3_n     : in  std_logic;
      signal_detect    : in  std_logic_vector(3 downto 0);
      align_status     : out std_logic;
      sync_status      : out std_logic_vector(3 downto 0); 
      configuration_vector : in  std_logic_vector(6 downto 0);
      status_vector        : out std_logic_vector(7 downto 0)
);
end xaui_v6_2_top;

library unisim;
use unisim.vcomponents.all;

architecture wrapper of xaui_v6_2_top is

----------------------------------------------------------------------------
-- Component Declaration for the XAUI core.
----------------------------------------------------------------------------  

   component xaui_v6_2
      port (
      reset            : in  std_logic;
      xgmii_txd        : in  std_logic_vector(63 downto 0);
      xgmii_txc        : in  std_logic_vector(7 downto 0);
      xgmii_rxd        : out std_logic_vector(63 downto 0);
      xgmii_rxc        : out std_logic_vector(7 downto 0);
      usrclk           : in  std_logic;
      mgt_txdata       : out std_logic_vector(63 downto 0);
      mgt_txcharisk    : out std_logic_vector(7 downto 0);
      mgt_rxdata       : in  std_logic_vector(63 downto 0);
      mgt_rxcharisk    : in  std_logic_vector(7 downto 0);
      mgt_codevalid    : in  std_logic_vector(7 downto 0);
      mgt_codecomma    : in  std_logic_vector(7 downto 0);
      mgt_enable_align : out std_logic_vector(3 downto 0);
      mgt_enchansync   : out std_logic;
      mgt_syncok       : in  std_logic_vector(3 downto 0);
      mgt_loopback     : out std_logic;
      mgt_powerdown    : out std_logic;
      mgt_tx_reset     : in  std_logic_vector(3 downto 0);
      mgt_rx_reset     : in  std_logic_vector(3 downto 0);
      signal_detect    : in  std_logic_vector(3 downto 0);
      align_status     : out std_logic;
      sync_status      : out std_logic_vector(3 downto 0);
      configuration_vector : in  std_logic_vector(6 downto 0);
      status_vector    : out std_logic_vector(7 downto 0));
  end component;

  --------------------------------------------------------------------------
  -- Component declaration for the RocketIO transceiver container
  --------------------------------------------------------------------------
   component transceiver
     generic (
       CHBONDMODE : string);
     port (
       reset        : in  std_logic;
       clk          : in  std_logic;
       brefclk      : in  std_logic;
       brefclk2     : in  std_logic;
       refclksel    : in  std_logic;
       dcm_locked   : in  std_logic;
       txdata       : in  std_logic_vector(15 downto 0);
       txcharisk    : in  std_logic_vector(1 downto 0);
       txp          : out std_logic;
       txn          : out std_logic;
       rxdata       : out std_logic_vector(15 downto 0);
       rxcharisk    : out std_logic_vector(1 downto 0);
       rxp          : in  std_logic;
       rxn          : in  std_logic;
       loopback_ser : in  std_logic;
       powerdown    : in  std_logic;
       chbondi      : in  std_logic_vector(3 downto 0);
       chbondo      : out std_logic_vector(3 downto 0);
       enable_align : in  std_logic;
       syncok       : out std_logic;
       enchansync   : in  std_logic;
       code_valid   : out std_logic_vector(1 downto 0);
       code_comma   : out std_logic_vector(1 downto 0);
       mgt_tx_reset : out std_logic;
       mgt_rx_reset : out std_logic);
   end component;

----------------------------------------------------------------------------
-- Signal declarations.
----------------------------------------------------------------------------
  signal usrclk          : std_logic;
  signal refclk_buf      : std_logic;
  signal mgt_reset_terms : std_logic;
  signal reset_reg     : std_logic;
  signal xgmii_txd_int : std_logic_vector(63 downto 0);
  signal xgmii_txc_int : std_logic_vector(7 downto 0);
  signal xgmii_rxd_int : std_logic_vector(63 downto 0);
  signal xgmii_rxc_int : std_logic_vector(7 downto 0);

  signal reset_terms             : std_logic;  
  signal reset_terms_reg         : std_logic;
  signal refclk_dcm_locked       : std_logic;
  signal usrclk_dcm              : std_logic;


  signal tx_clk0       : std_logic;
  signal tx_clk180     : std_logic;

  signal xgmii_tx_clk_buf : std_logic;  



  signal mgt_txdata       : std_logic_vector(63 downto 0);
  signal mgt_txcharisk    : std_logic_vector(7 downto 0);
  signal mgt_tx_reset     : std_logic_vector(3 downto 0);
  signal mgt_rxdata       : std_logic_vector(63 downto 0);
  signal mgt_rxcharisk    : std_logic_vector(7 downto 0);
  signal mgt_enable_align : std_logic_vector(3 downto 0);
  signal mgt_syncok       : std_logic_vector(3 downto 0);
  signal mgt_enchansync   : std_logic;
  signal mgt_codevalid    : std_logic_vector(7 downto 0);
  signal mgt_codecomma    : std_logic_vector(7 downto 0);
  signal mgt_rx_reset     : std_logic_vector(3 downto 0);
  signal mgt_loopback     : std_logic;
  signal mgt_powerdown    : std_logic;
  signal mgt_chbond       : std_logic_vector(3 downto 0);

  -- Attributes to disable 'X' propagation in asynchronous inputs
  attribute ASYNC_REG : string;
  attribute ASYNC_REG of reset_reg_fd : label is "TRUE";
begin

  xaui_core : xaui_v6_2
    port map (
      reset            => reset_reg,
      xgmii_txd        => xgmii_txd_int,
      xgmii_txc        => xgmii_txc_int,
      xgmii_rxd        => xgmii_rxd_int,
      xgmii_rxc        => xgmii_rxc_int,
      usrclk           => usrclk,
      mgt_txdata       => mgt_txdata,
      mgt_txcharisk    => mgt_txcharisk,
      mgt_rxdata       => mgt_rxdata,
      mgt_rxcharisk    => mgt_rxcharisk,
      mgt_codevalid    => mgt_codevalid,
      mgt_codecomma    => mgt_codecomma,
      mgt_enable_align => mgt_enable_align,
      mgt_enchansync   => mgt_enchansync,
      mgt_syncok       => mgt_syncok,
      mgt_loopback     => mgt_loopback,
      mgt_powerdown    => mgt_powerdown,
      mgt_tx_reset     => mgt_tx_reset,
      mgt_rx_reset     => mgt_rx_reset,
      signal_detect    => signal_detect,
      align_status     => align_status,
      sync_status      => sync_status,
      configuration_vector => configuration_vector,
      status_vector        => status_vector);

   ----------------------------------------------------------------------
   -- Transceiver instances
   mgt_0 : transceiver
     generic map (
       CHBONDMODE => "MASTER")
     port map (
       reset        => MGT_RESET_TERMS,
       clk          => USRCLK,
       brefclk      => REFCLK_BUF,
       brefclk2     => '0',
       refclksel    => '0',
       dcm_locked   => '1',
       txdata       => MGT_TXDATA(15 downto 0),
       txcharisk    => MGT_TXCHARISK(1 downto 0),
       txp          => XAUI_TX_L0_P,
       txn          => XAUI_TX_L0_N,
       rxdata       => MGT_RXDATA(15 downto 0),
       rxcharisk    => MGT_RXCHARISK(1 downto 0),
       rxp          => XAUI_RX_L0_P,
       rxn          => XAUI_RX_L0_N,
       enable_align => MGT_ENABLE_ALIGN(0),
       syncok       => MGT_SYNCOK(0),
       enchansync   => MGT_ENCHANSYNC,
       code_valid   => MGT_CODEVALID(1 downto 0),
       code_comma   => MGT_CODECOMMA(1 downto 0),
       loopback_ser => MGT_LOOPBACK,
       powerdown    => MGT_POWERDOWN,
       chbondi      => "XXXX",
       chbondo      => MGT_CHBOND,
       mgt_tx_reset => MGT_TX_RESET(0),
       mgt_rx_reset => MGT_RX_RESET(0));

   mgt_1 : transceiver
     generic map (
       CHBONDMODE => "SLAVE_1_HOP")
     port map (
       reset        => MGT_RESET_TERMS,
       clk          => USRCLK,
       brefclk      => REFCLK_BUF,
       brefclk2     => '0',
       refclksel    => '0',
       dcm_locked   => '1',
       txdata       => MGT_TXDATA(31 downto 16),
       txcharisk    => MGT_TXCHARISK(3 downto 2),
       txp          => XAUI_TX_L1_P,
       txn          => XAUI_TX_L1_N,
       rxdata       => MGT_RXDATA(31 downto 16),
       rxcharisk    => MGT_RXCHARISK(3 downto 2),
       rxp          => XAUI_RX_L1_P,
       rxn          => XAUI_RX_L1_N,
       enable_align => MGT_ENABLE_ALIGN(1),
       syncok       => MGT_SYNCOK(1),
       enchansync   => '1',
       code_valid   => MGT_CODEVALID(3 downto 2),
       code_comma   => MGT_CODECOMMA(3 downto 2),
       loopback_ser => MGT_LOOPBACK,
       powerdown    => MGT_POWERDOWN,
       chbondi      => MGT_CHBOND,
       chbondo      => open,
       mgt_tx_reset => MGT_TX_RESET(1),
       mgt_rx_reset => MGT_RX_RESET(1));

   mgt_2 : transceiver
     generic map (
       CHBONDMODE => "SLAVE_1_HOP")
     port map (
       reset        => MGT_RESET_TERMS,
       clk          => USRCLK,
       brefclk      => REFCLK_BUF,
       brefclk2     => '0',
       refclksel    => '0',
       dcm_locked   => '1',
       txdata       => MGT_TXDATA(47 downto 32),
       txcharisk    => MGT_TXCHARISK(5 downto 4),
       txp          => XAUI_TX_L2_P,
       txn          => XAUI_TX_L2_N,
       rxdata       => MGT_RXDATA(47 downto 32),
       rxcharisk    => MGT_RXCHARISK(5 downto 4),
       rxp          => XAUI_RX_L2_P,
       rxn          => XAUI_RX_L2_N,
       enable_align => MGT_ENABLE_ALIGN(2),
       syncok       => MGT_SYNCOK(2),
       enchansync   => '1',
       code_valid   => MGT_CODEVALID(5 downto 4),
       code_comma   => MGT_CODECOMMA(5 downto 4),
       loopback_ser => MGT_LOOPBACK,
       powerdown    => MGT_POWERDOWN,
       chbondi      => MGT_CHBOND,
       chbondo      => open,
       mgt_tx_reset => MGT_TX_RESET(2),
       mgt_rx_reset => MGT_RX_RESET(2));

   mgt_3 : transceiver
     generic map (
       CHBONDMODE => "SLAVE_1_HOP")
     port map (
       reset        => MGT_RESET_TERMS,
       clk          => USRCLK,
       brefclk      => REFCLK_BUF,
       brefclk2     => '0',
       refclksel    => '0',
       dcm_locked   => '1',
       txdata       => MGT_TXDATA(63 downto 48),
       txcharisk    => MGT_TXCHARISK(7 downto 6),
       txp          => XAUI_TX_L3_P,
       txn          => XAUI_TX_L3_N,
       rxdata       => MGT_RXDATA(63 downto 48),
       rxcharisk    => MGT_RXCHARISK(7 downto 6),
       rxp          => XAUI_RX_L3_P,
       rxn          => XAUI_RX_L3_N,
       enable_align => MGT_ENABLE_ALIGN(3),
       syncok       => MGT_SYNCOK(3),
       enchansync   => '1',
       code_valid   => MGT_CODEVALID(7 downto 6),
       code_comma   => MGT_CODECOMMA(7 downto 6),
       loopback_ser => MGT_LOOPBACK,
       powerdown    => MGT_POWERDOWN,
       chbondi      => MGT_CHBOND,
       chbondo      => open,
       mgt_tx_reset => MGT_TX_RESET(3),
       mgt_rx_reset => MGT_RX_RESET(3));

  -----------------------------------------------------------------------------
  --Generate clock management logic...     

   usrclk_bufg : BUFG
      port map (
         I => refclk_buf,
         O => usrclk);

   reset_reg_fd : FD
      port map (
         Q => reset_reg,
         C => usrclk,
         D => reset);

   mgt_reset_terms <= reset_reg;


-------------------------------------------------------
-- Add IBUFGDS and define REFCLK_BUS
-------------------------------------------------------

  refclk_ibufgds : IBUFGDS
    port map (
      I  => refclk_p,
      IB => refclk_n,
      O  => refclk_buf);

-------------------------------------------------------
  p_clk_xgmii_to_usrclk : process (usrclk)
  begin
    if usrclk'event and usrclk = '1' then -- rising edge   
      xgmii_txd_int <= xgmii_txd;
      xgmii_txc_int <= xgmii_txc;
    end if;
  end process p_clk_xgmii_to_usrclk;


-------------------------------------------------------
  p_clk_xgmii_to_rx_clk : process (usrclk)
  begin
    if usrclk'event and usrclk = '1' then -- rising edge   
      xgmii_rxd <= xgmii_rxd_int;
      xgmii_rxc <= xgmii_rxc_int;
    end if;
  end process p_clk_xgmii_to_rx_clk;    

 
end wrapper;
