-------------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:22 $
-------------------------------------------------------------------------------
-- File       : ten_gig_eth_mac_v8_0_local_link.vhd  
-- Author     : Xilinx Inc.
-------------------------------------------------------------------------------
-- Description: This is the local link level vhdl code for the 
-- Ten Gigabit Etherent MAC. It contains the block level instance and 
-- may contain the Local Link Fifo depending on configuration options 
-- when generated.
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

entity ten_gig_eth_mac_v8_0_local_link is
  port(
    ---------------------------------------------------------------------------
    -- Interface to the host.
    ---------------------------------------------------------------------------
    reset          : in  std_logic                     -- Resets the MAC.
;
    tx_clk0        : in  std_logic;
    tx_clk90       : in  std_logic;
    tx_clk180      : in std_logic;
    tx_clk270      : in std_logic;
    tx_dcm_locked  : in  std_logic;
    tx_ifg_delay   : in   std_logic_vector(7 downto 0); -- Temporary. IFG delay.
    tx_statistics_vector : out std_logic_vector(24 downto 0); -- Statistics information on the last frame.
    tx_statistics_valid  : out std_logic;                     -- High when stats are valid.

    pause_val      : in  std_logic_vector(15 downto 0); -- Indicates the length of the pause that should be transmitted.
    pause_req      : in  std_logic                     -- A '1' indicates that a pause frame should  be sent.
;
    --Local Link signals
    rx_ll_clk         : in  std_logic;
    rx_ll_reset      : in  std_logic;
    rx_ll_data        : out std_logic_vector(63 downto 0);
    rx_ll_rem         : out std_logic_vector(2 downto 0);
    rx_ll_sof_n       : out std_logic;
    rx_ll_eof_n       : out std_logic;
    rx_ll_src_rdy_n   : out std_logic;
    rx_ll_dst_rdy_n   : in  std_logic;

    tx_ll_clk         : in  std_logic;
    tx_ll_reset      : in  std_logic;
    tx_ll_data        : in  std_logic_vector(63 downto 0);
    tx_ll_rem         : in  std_logic_vector(2 downto 0);
    tx_ll_sof_n       : in  std_logic;
    tx_ll_eof_n       : in  std_logic;
    tx_ll_src_rdy_n   : in  std_logic;
    tx_ll_dst_rdy_n   : out std_logic;   

    rx_clk               : out std_logic;                     -- The RX clock from the reconcilliation sublayer.
    rx_dcm_locked        : out std_logic;
    rx_statistics_vector : out std_logic_vector(28 downto 0); -- Statistics info on the last received frame.
    rx_statistics_valid  : out std_logic                      -- High when above stats are valid.
;
    configuration_vector : in std_logic_vector(66 downto 0)
;
    xgmii_txd      : out std_logic_vector(63 downto 0); -- Transmitted data
    xgmii_txc      : out std_logic_vector(7 downto 0)  -- Transmitted control
;
    xgmii_rx_clk   : in  std_logic;                     -- The rx clock from the PHY layer.
    xgmii_rxd      : in  std_logic_vector(63 downto 0); -- Received data
    xgmii_rxc      : in  std_logic_vector(7 downto 0)  -- received control
);
end ten_gig_eth_mac_v8_0_local_link;


architecture wrapper of ten_gig_eth_mac_v8_0_local_link is
  
  -----------------------------------------------------------------------------
  -- Component Declaration for XGMAC (the 10Gb/E MAC core).
  ----------------------------------------------------------------------------- 
    component ten_gig_eth_mac_v8_0_block
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
    tx_clk90       : in  std_logic;
    tx_clk180      : in std_logic;
    tx_clk270      : in std_logic;
    tx_dcm_locked  : in  std_logic;
    xgmii_txd      : out std_logic_vector(63 downto 0); -- Transmitted data
    xgmii_txc      : out std_logic_vector(7 downto 0)  -- Transmitted control
;
    rx_clk0        : out  std_logic;
    rx_dcm_locked  : out  std_logic;
    xgmii_rx_clk   : in  std_logic;
    xgmii_rxd      : in  std_logic_vector(63 downto 0); -- Received data
    xgmii_rxc      : in  std_logic_vector(7 downto 0)  -- received control
  );
  end component;

  -----------------------------------------------------------------------------
  -- Component declaration for the client loopback design.
  -----------------------------------------------------------------------------
  component client_loopback
   port (
      reset                : in  std_logic;  -- asynchronous reset
      tx_data              : out std_logic_vector(63 downto 0);
      tx_data_valid        : out std_logic_vector(7 downto 0);
      tx_underrun          : out std_logic;
      tx_start             : out std_logic;
      tx_ack               : in  std_logic;
      tx_clk               : in  std_logic;
      rx_data              : in  std_logic_vector(63 downto 0);
      rx_data_valid        : in  std_logic_vector(7 downto 0);
      rx_good_frame        : in  std_logic;
      rx_bad_frame         : in  std_logic;
      rx_clk               : in  std_logic;
      overflow             : out std_logic;

      --Local Link signals
      rx_ll_clk         : in  std_logic;
      rx_ll_reset       : in  std_logic;
      rx_ll_data        : out std_logic_vector(63 downto 0);
      rx_ll_rem         : out std_logic_vector(2 downto 0);
      rx_ll_sof_n       : out std_logic;
      rx_ll_eof_n       : out std_logic;
      rx_ll_src_rdy_n   : out std_logic;
      rx_ll_dst_rdy_n   : in  std_logic;

      tx_ll_clk         : in  std_logic;
      tx_ll_reset       : in  std_logic;
      tx_ll_data        : in  std_logic_vector(63 downto 0);
      tx_ll_rem         : in  std_logic_vector(2 downto 0);
      tx_ll_sof_n       : in  std_logic;
      tx_ll_eof_n       : in  std_logic;
      tx_ll_src_rdy_n   : in  std_logic;
      tx_ll_dst_rdy_n   : out std_logic   

      );
  end component;


  signal tx_data       : std_logic_vector(63 downto 0);
  signal tx_data_valid : std_logic_vector(7 downto 0);
  signal tx_underrun   : std_logic;
  signal tx_start      : std_logic;
  signal tx_ack        : std_logic;
  signal rx_data       : std_logic_vector(63 downto 0);
  signal rx_data_valid : std_logic_vector(7 downto 0);
  signal rx_good_frame : std_logic;
  signal rx_bad_frame  : std_logic;
  signal overflow      : std_logic;
  signal rx_clk0 : std_logic;

    attribute keep : string;
    attribute keep of tx_data : signal is "true";
    attribute keep of tx_data_valid : signal is "true";
    attribute keep of tx_start : signal is "true";
    attribute keep of tx_ack : signal is "true";
    attribute keep of tx_underrun : signal is "true";
    attribute keep of rx_data : signal is "true";
    attribute keep of rx_data_valid : signal is "true";
    attribute keep of rx_good_frame : signal is "true";
    attribute keep of rx_bad_frame  : signal is "true";

begin

  ------------------------------
  -- Instantiate the XGMAC core
  ------------------------------
  xgmac_block : ten_gig_eth_mac_v8_0_block
    port map (
      reset                => reset
,
      tx_underrun          => tx_underrun,
      tx_data              => tx_data,
      tx_data_valid        => tx_data_valid,
      tx_start             => tx_start,
      tx_ack               => tx_ack,
      tx_ifg_delay         => tx_ifg_delay,
      tx_statistics_vector => tx_statistics_vector,
      tx_statistics_valid  => tx_statistics_valid,
      pause_val            => pause_val,
      pause_req            => pause_req
,
      rx_data              => rx_data,
      rx_data_valid        => rx_data_valid,
      rx_good_frame        => rx_good_frame,
      rx_bad_frame         => rx_bad_frame,
      rx_statistics_vector => rx_statistics_vector,
      rx_statistics_valid  => rx_statistics_valid
,
      configuration_vector => configuration_vector
,
      tx_clk0       => tx_clk0,
      tX_clk90      => tx_clk90,
      tx_clk180     => tx_clk180,
      tx_clk270     => tx_clk270,
      tx_dcm_locked => tx_dcm_locked,
      xgmii_txd     => xgmii_txd,
      xgmii_txc     => xgmii_txc
,
      rx_clk0       => rx_clk0,
      rx_dcm_locked => rx_dcm_locked,
      xgmii_rx_clk  => xgmii_rx_clk,
      xgmii_rxd     => xgmii_rxd,
      xgmii_rxc     => xgmii_rxc
      );


  -------------------------------------------
  -- Instantiate the example client loopback.
  -------------------------------------------
  local_link_fifo : client_loopback
    port map (
      reset                => reset,
      tx_data              => tx_data,
      tx_data_valid        => tx_data_valid,
      tx_underrun          => tx_underrun,
      tx_start             => tx_start,
      tx_ack               => tx_ack,
      tx_clk               => tx_clk0,
      rx_data              => rx_data,
      rx_data_valid        => rx_data_valid,
      rx_good_frame        => rx_good_frame,
      rx_bad_frame         => rx_bad_frame,
      rx_clk               => rx_clk0,
      overflow             => overflow,

      --Local Link signals
      rx_ll_clk            => rx_ll_clk, 
      rx_ll_reset          => rx_ll_reset,
      rx_ll_data           => rx_ll_data, 
      rx_ll_rem            => rx_ll_rem, 
      rx_ll_sof_n          => rx_ll_sof_n,
      rx_ll_eof_n          => rx_ll_eof_n,
      rx_ll_src_rdy_n      => rx_ll_src_rdy_n,
      rx_ll_dst_rdy_n      => rx_ll_dst_rdy_n,

      tx_ll_clk               => tx_ll_clk,
      tx_ll_reset             => tx_ll_reset,
      tx_ll_data              => tx_ll_data,
      tx_ll_rem               => tx_ll_rem,
      tx_ll_sof_n             => tx_ll_sof_n,
      tx_ll_eof_n             => tx_ll_eof_n,
      tx_ll_src_rdy_n         => tx_ll_src_rdy_n,
      tx_ll_dst_rdy_n         => tx_ll_dst_rdy_n  
);


      rx_clk <= rx_clk0;

end wrapper;


