-------------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:22 $
-------------------------------------------------------------------------------
-- File       : ten_gig_eth_mac_v8_0_example_design.vhd  
-- Author     : Xilinx Inc.
-------------------------------------------------------------------------------
-- Description: This is the example design level vhdl code for the 
-- Ten Gigabit Etherent MAC. It contains the Local Link level instance and 
-- Transmit clock generation.  Dependent on configuration options, it  may 
-- also contain the address swap module for cores with both Transmit and 
-- Receive.
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

entity ten_gig_eth_mac_v8_0_example_design is
  port(
    ---------------------------------------------------------------------------
    -- Interface to the host.
    ---------------------------------------------------------------------------
    reset          : in  std_logic                     -- Resets the MAC.
;
    tx_clk         : out  std_logic;                    -- The transmit clock back to the host.
    tx_ifg_delay   : in   std_logic_vector(7 downto 0); -- Temporary. IFG delay.
    tx_statistics_vector : out std_logic_vector(24 downto 0); -- Statistics information on the last frame.
    tx_statistics_valid  : out std_logic;                     -- High when stats are valid.

    pause_val      : in  std_logic_vector(15 downto 0); -- Indicates the length of the pause that should be transmitted.
    pause_req      : in  std_logic                     -- A '1' indicates that a pause frame should  be sent.
;
    rx_clk               : out std_logic;                     -- The RX clock from the reconcilliation sublayer.
    rx_statistics_vector : out std_logic_vector(28 downto 0); -- Statistics info on the last received frame.
    rx_statistics_valid  : out std_logic                      -- High when above stats are valid.
;
    configuration_vector : in std_logic_vector(66 downto 0)
;
    gtx_clk        : in  std_logic;                     -- The global transmit clock from the outside world.
    xgmii_txd      : out std_logic_vector(63 downto 0); -- Transmitted data
    xgmii_txc      : out std_logic_vector(7 downto 0)  -- Transmitted control
;
    xgmii_rx_clk   : in  std_logic;                     -- The rx clock from the PHY layer.
    xgmii_rxd      : in  std_logic_vector(63 downto 0); -- Received data
    xgmii_rxc      : in  std_logic_vector(7 downto 0)  -- received control
);
end ten_gig_eth_mac_v8_0_example_design;


architecture wrapper of ten_gig_eth_mac_v8_0_example_design is
  
  -----------------------------------------------------------------------------
  -- Component Declaration for Local Link level
  ----------------------------------------------------------------------------- 
    component ten_gig_eth_mac_v8_0_local_link
    port (
    reset          : in  std_logic

;
    tx_ifg_delay   : in   std_logic_vector(7 downto 0);
    tx_statistics_vector : out std_logic_vector(24 downto 0);
    tx_statistics_valid  : out std_logic;
    pause_val      : in  std_logic_vector(15 downto 0);
    pause_req      : in  std_logic
;
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

;
    rx_statistics_vector : out std_logic_vector(28 downto 0);
    rx_statistics_valid  : out std_logic
;
    configuration_vector : in std_logic_vector(66 downto 0)
;
      tx_clk0      : in std_logic;
      tx_clk90     : in std_logic;
      tx_dcm_locked: in std_logic;
      tx_clk180    : in std_logic;
      tx_clk270    : in std_logic;
    xgmii_txd      : out std_logic_vector(63 downto 0); -- Transmitted data
    xgmii_txc      : out std_logic_vector(7 downto 0)  -- Transmitted control
;
    rx_clk        : out std_logic;
    rx_dcm_locked  : out std_logic;
    xgmii_rx_clk   : in  std_logic;
    xgmii_rxd      : in  std_logic_vector(63 downto 0); -- Received data
    xgmii_rxc      : in  std_logic_vector(7 downto 0)  -- received control
  );
  end component;

   component address_swap
    port (
      --Local Link signals
      rx_clk         : in  std_logic;
      reset          : in  std_logic;
      rx_data        : in  std_logic_vector(63 downto 0);
      rx_rem         : in  std_logic_vector(2 downto 0);
      rx_sof_n       : in  std_logic;
      rx_eof_n       : in  std_logic;
      rx_src_rdy_n   : in  std_logic;
      rx_dst_rdy_n   : out std_logic;

      tx_data        : out std_logic_vector(63 downto 0);
      tx_rem         : out std_logic_vector(2 downto 0);
      tx_sof_n       : out std_logic;
      tx_eof_n       : out std_logic;
      tx_src_rdy_n   : out std_logic;
      tx_dst_rdy_n   : in  std_logic   

      );
   end component;
  -----------------------------------------------------------------------------
  -- Internal Signal Declaration for XGMAC (the 10Gb/E MAC core).
  -----------------------------------------------------------------------------  

  signal gtx_clk_dcm        : std_logic;
  signal tx_dcm_clk0        : std_logic;
  signal tx_dcm_clk90       : std_logic;
  signal tx_dcm_clk180      : std_logic;
  signal tx_dcm_clk270      : std_logic;
  signal tx_dcm_locked      : std_logic;
  signal tx_dcm_locked_reg  : std_logic;  -- Registered version (TX_CLK0)

  signal tx_clk0, tx_clk90 : std_logic;  -- transmit clocks on global routing
  signal tx_clk180, tx_clk270 : std_logic;


  signal vcc, gnd : std_logic;
  signal rx_clk_int               : std_logic;
  signal rx_dcm_locked            : std_logic;
  
  signal configuration_vector_core : std_logic_vector(66 downto 0);

  signal  rx_ll_data_int        : std_logic_vector(63 downto 0);
  signal  rx_ll_rem_int         : std_logic_vector(2 downto 0);
  signal  rx_ll_sof_n_int       : std_logic;
  signal  rx_ll_eof_n_int       : std_logic;
  signal  rx_ll_src_rdy_n_int   : std_logic;
  signal  rx_ll_dst_rdy_n_int   : std_logic;
  signal  tx_ll_data_int        : std_logic_vector(63 downto 0);
  signal  tx_ll_rem_int         : std_logic_vector(2 downto 0);
  signal  tx_ll_sof_n_int       : std_logic;
  signal  tx_ll_eof_n_int       : std_logic;
  signal  tx_ll_src_rdy_n_int   : std_logic;
  signal  tx_ll_dst_rdy_n_int   : std_logic;  

begin
  vcc <= '1';
  gnd <= '0';

  ------------------------------
  -- Instantiate the XGMAC core
  ------------------------------
  local_link : ten_gig_eth_mac_v8_0_local_link
    port map (
      reset                => reset

,
      pause_val            => pause_val,
      pause_req            => pause_req,
      tx_ifg_delay         => tx_ifg_delay,
      tx_statistics_vector => tx_statistics_vector,
      tx_statistics_valid  => tx_statistics_valid
,
      --Local Link signals
      rx_ll_clk            =>  rx_clk_int,
      rx_ll_reset          =>  reset,
      rx_ll_data           =>  rx_ll_data_int,
      rx_ll_rem            =>  rx_ll_rem_int,
      rx_ll_sof_n          =>  rx_ll_sof_n_int,
      rx_ll_eof_n          =>  rx_ll_eof_n_int,
      rx_ll_src_rdy_n      =>  rx_ll_src_rdy_n_int,
      rx_ll_dst_rdy_n      =>  rx_ll_dst_rdy_n_int,  

      tx_ll_clk            =>  rx_clk_int,
      tx_ll_reset          =>  reset,
      tx_ll_data           =>  tx_ll_data_int, 
      tx_ll_rem            =>  tx_ll_rem_int,
      tx_ll_sof_n          =>  tx_ll_sof_n_int,
      tx_ll_eof_n          =>  tx_ll_eof_n_int,
      tx_ll_src_rdy_n      =>  tx_ll_src_rdy_n_int,
      tx_ll_dst_rdy_n      =>  tx_ll_dst_rdy_n_int   

,
      rx_statistics_vector => rx_statistics_vector,
      rx_statistics_valid  => rx_statistics_valid
,
      configuration_vector => configuration_vector
,
      tx_clk0       => tx_clk0,
      tx_clk90      => tx_clk90,
      tx_clk180     => tx_clk180,
      tx_clk270     => tx_clk270,
      tx_dcm_locked => tx_dcm_locked,
      xgmii_txd     => xgmii_txd,
      xgmii_txc     => xgmii_txc
,
      rx_clk       => rx_clk_int,
      rx_dcm_locked => rx_dcm_locked,
      xgmii_rx_clk  => xgmii_rx_clk,
      xgmii_rxd     => xgmii_rxd,
      xgmii_rxc     => xgmii_rxc
      );

  addr_swap : address_swap
    port map (      --Local Link signals
      rx_clk            =>  rx_clk_int,
      reset             =>  reset,
      rx_data           =>  rx_ll_data_int,
      rx_rem            =>  rx_ll_rem_int,
      rx_sof_n          =>  rx_ll_sof_n_int,
      rx_eof_n          =>  rx_ll_eof_n_int,
      rx_src_rdy_n      =>  rx_ll_src_rdy_n_int,
      rx_dst_rdy_n      =>  rx_ll_dst_rdy_n_int,  

      tx_data           =>  tx_ll_data_int, 
      tx_rem            =>  tx_ll_rem_int,
      tx_sof_n          =>  tx_ll_sof_n_int,
      tx_eof_n          =>  tx_ll_eof_n_int,
      tx_src_rdy_n      =>  tx_ll_src_rdy_n_int,
      tx_dst_rdy_n      =>  tx_ll_dst_rdy_n_int
   );   




  rx_clk_obuf : OBUF
    port map (
      I => rx_clk_int,
      O => rx_clk); 


  -- Transmit clock management
  gtx_clk_ibufg : IBUFG
    port map (
      I => gtx_clk,
      O => gtx_clk_dcm);

  -- Clock management
  tx_dcm : DCM
    port map (
      CLKIN           => gtx_clk_dcm,
      CLKFB           => tx_clk0,
      RST             => reset,
      DSSEN           => gnd,
      PSINCDEC        => gnd,
      PSEN            => gnd,
      PSCLK           => gnd,
      CLK0            => tx_dcm_clk0,
      CLK90           => tx_dcm_clk90, 
      CLK180          => tx_dcm_clk180,
      CLK270          => tx_dcm_clk270,
      CLK2X           => open,
      CLK2X180        => open, 
      CLKDV           => open, 
      CLKFX           => open, 
      CLKFX180        => open, 
      LOCKED          => tx_dcm_locked,
      STATUS          => open, 
      PSDONE          => open);

  tx_bufg0 : BUFG
    port map (
      I => tx_dcm_clk0,
      O => tx_clk0);

  tx_bufg90 : BUFG
    port map (
      I => tx_dcm_clk90,
      O => tx_clk90);

  tx_bufg180 : BUFG
    port map (
      I => tx_dcm_clk180,
      O => tx_clk180);

  tx_bufg270 : BUFG
    port map (
      I => tx_dcm_clk270,
      O => tx_clk270);

  -- We are explicitly instancing an OBUF for this signal because if we 
  -- make a simple assignement and rely on XST to put the OBUF in, it 
  -- will munge the name of the tx_clk0 net into a new name and the UCF 
  -- clock constraint will no longer attach in ngdbuild.
  tx_clk_obuf : OBUF
    port map (
      I => tx_clk0,
      O => tx_clk);
  


   


end wrapper;


