-------------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:22 $
-------------------------------------------------------------------------------
-- File       : ten_gig_eth_mac_v8_0_block.vhd  
-- Author     : Xilinx Inc.
-------------------------------------------------------------------------------
-- Description: This is the block level vhdl code for the 
-- Ten Gigabit Etherent MAC, where the MAC core is instanced. This file also 
-- contains the physical interface instance which is either 32bit XGMII or 
-- 64bit internal.  
-------------------------------------------------------------------------------
-- Copyright (c) 2001-2006 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 2001-2006 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------

library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

entity ten_gig_eth_mac_v8_0_block is
  port(
    reset          : in  std_logic
;
    tx_underrun    : in  std_logic;
    tx_data        : in  std_logic_vector(63 downto 0);
    tx_data_valid  : in  std_logic_vector(7 downto 0); 
    tx_start       : in  std_logic;
    tx_ack         : out std_logic;
    tx_ifg_delay   : in   std_logic_vector(7 downto 0);
    tx_statistics_vector : out std_logic_vector(24 downto 0);
    tx_statistics_valid  : out std_logic;
    pause_val      : in  std_logic_vector(15 downto 0);
    pause_req      : in  std_logic
;
    rx_data        : out std_logic_vector(63 downto 0);
    rx_data_valid  : out std_logic_vector(7 downto 0);
    rx_good_frame  : out std_logic;
    rx_bad_frame   : out std_logic;
    rx_statistics_vector : out std_logic_vector(28 downto 0);
    rx_statistics_valid  : out std_logic
;
    configuration_vector : in std_logic_vector(66 downto 0)

;
    tx_clk0        : in  std_logic;
    tx_clk90       : in  std_logic;
    tx_clk180      : in std_logic;
    tx_clk270      : in std_logic;
    tx_dcm_locked    : in  std_logic;
    xgmii_txd      : out std_logic_vector(63 downto 0); -- Transmitted data
    xgmii_txc      : out std_logic_vector(7 downto 0)  -- Transmitted control
;
    rx_clk0        : out std_logic;
    rx_dcm_locked  : out std_logic;
    xgmii_rx_clk   : in  std_logic;
    xgmii_rxd      : in  std_logic_vector(63 downto 0); -- Received data
    xgmii_rxc      : in  std_logic_vector(7 downto 0)  -- received control
  );
end ten_gig_eth_mac_v8_0_block;


architecture wrapper of ten_gig_eth_mac_v8_0_block is
  
  -----------------------------------------------------------------------------
  -- Component Declaration for XGMAC (the 10Gb/E MAC core).
  ----------------------------------------------------------------------------- 
    component ten_gig_eth_mac_v8_0
    port (
    reset          : in  std_logic
;
    tx_underrun    : in  std_logic;
    tx_data        : in  std_logic_vector(63 downto 0);
    tx_data_valid  : in  std_logic_vector(7 downto 0); 
    tx_start       : in  std_logic;
    tx_ack         : out std_logic;
    tx_ifg_delay   : in   std_logic_vector(7 downto 0);
    tx_statistics_vector : out std_logic_vector(24 downto 0);
    tx_statistics_valid  : out std_logic;
    pause_val      : in  std_logic_vector(15 downto 0);
    pause_req      : in  std_logic
;
    rx_data        : out std_logic_vector(63 downto 0);
    rx_data_valid  : out std_logic_vector(7 downto 0);
    rx_good_frame  : out std_logic;
    rx_bad_frame   : out std_logic;
    rx_statistics_vector : out std_logic_vector(28 downto 0);
    rx_statistics_valid  : out std_logic
;
    configuration_vector : in std_logic_vector(66 downto 0)

;
    tx_clk0        : in  std_logic;
    tx_dcm_lock    : in  std_logic;
    xgmii_txd      : out std_logic_vector(63 downto 0);
    xgmii_txc      : out std_logic_vector(7 downto 0)
;
    rx_clk0        : in  std_logic;
    rx_dcm_lock    : in  std_logic;
    xgmii_rxd      : in  std_logic_vector(63 downto 0); 
    xgmii_rxc      : in  std_logic_vector(7 downto 0)
  );
  end component;

    component physical_if
    port (
    reset          : in std_logic;
    tx_clk0        : in  std_logic;
    tx_clk90       : in  std_logic;
    tx_clk180      : in std_logic;
    tx_clk270      : in std_logic;
    xgmii_txd_core : in std_logic_vector(63 downto 0);
    xgmii_txc_core : in std_logic_vector(7 downto 0);
    xgmii_txd      : out std_logic_vector(63 downto 0);
    xgmii_txc      : out std_logic_vector(7 downto 0)

;
    rx_clk0        : out  std_logic;
    rx_dcm_locked  : out  std_logic;
    xgmii_rx_clk   : in   std_logic;
    xgmii_rxd      : in   std_logic_vector(63 downto 0);
    xgmii_rxc      : in   std_logic_vector(7 downto 0);
    xgmii_rxd_core : out  std_logic_vector(63 downto 0); 
    xgmii_rxc_core : out  std_logic_vector(7 downto 0)
    );
  end component;
  -----------------------------------------------------------------------------
  -- Internal Signal Declaration for XGMAC (the 10Gb/E MAC core).
  -----------------------------------------------------------------------------  
  signal reset_terms_tx      : std_logic;
  signal reset_terms_rx      : std_logic;
  signal xgmii_txc_core : std_logic_vector(7 downto 0);
  signal xgmii_txd_core : std_logic_vector(63 downto 0);
  signal tx_dcm_locked_reg    : std_logic;
  signal rx_clk0_int : std_logic;
  signal rx_dcm_locked_reg    : std_logic;  -- Locked signal from RX DCM
  signal rx_dcm_locked_int    : std_logic;  -- Locked signal from RX DCM

  signal xgmii_rxd_core : std_logic_vector(63 downto 0);
  signal xgmii_rxc_core : std_logic_vector(7 downto 0);

  signal rx_statistics_vector_int : std_logic_vector(28 downto 0);
  signal rx_statistics_valid_int  : std_logic;
  signal tx_statistics_vector_int : std_logic_vector(24 downto 0);
  signal tx_statistics_valid_int  : std_logic;
  
  signal configuration_vector_core : std_logic_vector(66 downto 0);

begin

  ------------------------------
  -- Instantiate the XGMAC core
  ------------------------------
  xgmac_core : ten_gig_eth_mac_v8_0
    port map (
      reset                => reset
,
      tx_underrun          => tx_underrun,
      tx_data              => tx_data,
      tx_data_valid        => tx_data_valid,
      tx_start             => tx_start,
      tx_ack               => tx_ack,
      tx_ifg_delay         => tx_ifg_delay,
      tx_statistics_vector => tx_statistics_vector_int,
      tx_statistics_valid  => tx_statistics_valid_int,
      pause_val            => pause_val,
      pause_req            => pause_req
,
      rx_data              => rx_data,
      rx_data_valid        => rx_data_valid,
      rx_good_frame        => rx_good_frame,
      rx_bad_frame         => rx_bad_frame,
      rx_statistics_vector => rx_statistics_vector_int,
      rx_statistics_valid  => rx_statistics_valid_int
,
      configuration_vector => configuration_vector_core
,
      tx_clk0       => tx_clk0,
      tx_dcm_lock   => tx_dcm_locked_reg,
      xgmii_txd     => xgmii_txd_core,
      xgmii_txc     => xgmii_txc_core
,
      rx_clk0       => rx_clk0_int,
      rx_dcm_lock   => rx_dcm_locked_reg,
      xgmii_rxd     => xgmii_rxd_core,
      xgmii_rxc     => xgmii_rxc_core
      );

  -- Register the dcm_locked signal into the system clock domain
  p_tx_dcm_locked : process (tx_clk0)
  begin
    if tx_clk0'event and tx_clk0 = '1' then
      tx_dcm_locked_reg <= tx_dcm_locked;
    end if;
  end process p_tx_dcm_locked;

  -----------------------------------------------------------------------------
  -- Component Declaration for XGMII Interface
  ----------------------------------------------------------------------------- 

    xgmac_phy_if : physical_if
    port map (
    reset          => reset, 
    tx_clk0        => tx_clk0,
    tx_clk90       => tx_clk90,
    tx_clk180      => tx_clk180,
    tx_clk270      => tx_clk270,
    xgmii_txd_core => xgmii_txd_core,
    xgmii_txc_core => xgmii_txc_core,
    xgmii_txd      => xgmii_txd,
    xgmii_txc      => xgmii_txc

,
    rx_clk0        => rx_clk0_int,
    rx_dcm_locked  => rx_dcm_locked_int,
    xgmii_rx_clk   => xgmii_rx_clk,
    xgmii_rxd      => xgmii_rxd,
    xgmii_rxc      => xgmii_rxc,
    xgmii_rxd_core => xgmii_rxd_core,
    xgmii_rxc_core => xgmii_rxc_core
    );

   rx_clk0 <= rx_clk0_int;
  
  -- Register the dcm_locked signal into the system clock domain
  p_rx_dcm_locked : process (rx_clk0_int)
  begin
    if rx_clk0_int'event and rx_clk0_int = '1' then
      rx_dcm_locked_reg <= rx_dcm_locked_int;
    end if;
  end process p_rx_dcm_locked;

  rx_dcm_locked <= rx_dcm_locked_int;


-------------------------------------------------------------------------------
-- Core reset is handled here. 
-- Core is held in reset for two clock cycles after dcm(s) have
-- have locked up. DCMs going out of lock will also reset the core
-- and keep it there until the DCM has relocked.
-------------------------------------------------------------------------------


  reset_terms_tx <= (not tx_dcm_locked);
  reset_terms_rx <= (not rx_dcm_locked_int);

  -- apply the RX block reset
  configuration_vector_core(52) <= configuration_vector(52) or reset_terms_rx;

  -- Flow control reset 
  -- reset rx side registers if RX DCM goes out of lock, 
  configuration_vector_core(62) <= configuration_vector(62) or reset_terms_rx;
  -- reset tx side registers if tx dcm goes out of lock
  configuration_vector_core(63) <= configuration_vector(63) or reset_terms_tx;

  -- Transmit Block Reset
  configuration_vector_core(59) <= configuration_vector(59) or reset_terms_tx;
  configuration_vector_core(51 downto 0) <= configuration_vector(51 downto 0);
  configuration_vector_core(58 downto 53) <= configuration_vector(58 downto 53);
  configuration_vector_core(61 downto 60) <= configuration_vector(61 downto 60);
  configuration_vector_core(66 downto 64) <= configuration_vector(66 downto 64);


   txstatvectorreg: process (reset, tx_clk0)
      begin
      if reset = '1' then
         tx_statistics_vector      <= (others => '0');
         tx_statistics_valid       <= '0';
      elsif tx_clk0'event and tx_clk0 = '1' then
         tx_statistics_vector      <= tx_statistics_vector_int;
         tx_statistics_valid       <= tx_statistics_valid_int;
      end if;
   end process txstatvectorreg;
   rxstatvectorreg: process (reset, rx_clk0_int)
      begin
      if reset = '1' then
         rx_statistics_vector      <= (others => '0');
         rx_statistics_valid       <= '0';
      elsif rx_clk0_int'event and rx_clk0_int = '1' then
         rx_statistics_vector      <= rx_statistics_vector_int;
         rx_statistics_valid       <= rx_statistics_valid_int;
      end if;
   end process rxstatvectorreg;



end wrapper;


