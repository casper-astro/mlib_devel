------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:22 $
------------------------------------------------------------------------
------------------------------------------------------------------------
-- Title      : Client Side Loopback Design Example
-- Project    : 10 Gigabit Ethernet MAC
------------------------------------------------------------------------
-- File       : client_loopback.vhd  
-- Author     : Xilinx Inc.
------------------------------------------------------------------------
-- Description: This is the Client side loopback design example for the 
--              10 Gigabit Ethernet MAC core.
--           
------------------------------------------------------------------------
-- Copyright (c) 2004-2006 by Xilinx, Inc. All rights reserved.
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
-- of this text at all times. (c) Copyright 2004-2006 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;												       
use work.XGMAC_FIFO_PACK.all;

------------------------------------------------------------------------
-- The entity declaration for the client side loopback design example.
------------------------------------------------------------------------

entity client_loopback is
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
end client_loopback;


architecture rtl of client_loopback is   

  -- Local Link signals
  signal tx_fifo_status               :  std_logic_vector(3 downto 0);
  signal rx_fifo_status               :  std_logic_vector(3 downto 0);
   
  -- create a synchronous reset in the transmitter clock domain
  signal tx_reset                     : std_logic;
  signal tx_reset2                     : std_logic;
  signal tx_reset3                     : std_logic;
  signal tx_reset4                     : std_logic;
  signal tx_reset5                     : std_logic;

  -- create a synchronous reset in the receiver clock domain
  signal rx_reset                     : std_logic;
  signal rx_reset2                     : std_logic;
  signal rx_reset3                     : std_logic;
  signal rx_reset4                     : std_logic;
  signal rx_reset5                     : std_logic;

  -- create a synchronous reset in the transmitter clock domain
  signal tx_ll_sreset                     : std_logic;
  signal tx_ll_sreset2                     : std_logic;
  signal tx_ll_sreset3                     : std_logic;
  signal tx_ll_sreset4                     : std_logic;
  signal tx_ll_sreset5                     : std_logic;

  -- create a synchronous reset in the receiver clock domain
  signal rx_ll_sreset                     : std_logic;
  signal rx_ll_sreset2                     : std_logic;
  signal rx_ll_sreset3                     : std_logic;
  signal rx_ll_sreset4                     : std_logic;
  signal rx_ll_sreset5                     : std_logic;
  
begin

  ----------------------------------------------------------------------
  -- Create synchronous reset signals for use in the Address swapping 
  -- and FIFO modules.  A synchronous reset signal is created in each
  -- clock domain.
  ----------------------------------------------------------------------

  -- Create synchronous reset in the transmitter clock domain.
  gen_tx_reset : process (tx_clk, reset)
  begin
    if reset = '1' then
      tx_reset5     <= '1';
      tx_reset4     <= '1';
      tx_reset3     <= '1';
      tx_reset2     <= '1';
      tx_reset      <= '1';
    elsif tx_clk'event and tx_clk = '1' then
      tx_reset5     <= '0';
      tx_reset4     <= tx_reset5;
      tx_reset3     <= tx_reset4;
      tx_reset2     <= tx_reset3;
      tx_reset      <= tx_reset2;
   end if;
  end process gen_tx_reset;


  -- Create synchronous reset in the receiver clock domain.
  gen_rx_reset : process (rx_clk, reset)
  begin
    if reset = '1' then
      rx_reset5     <= '1';
      rx_reset4     <= '1';
      rx_reset3     <= '1';
      rx_reset2     <= '1';
      rx_reset      <= '1';
    elsif rx_clk'event and rx_clk = '1' then
      rx_reset5     <= '0';
      rx_reset4     <= rx_reset5;
      rx_reset3     <= rx_reset4;
      rx_reset2     <= rx_reset3;
      rx_reset      <= rx_reset2;
   end if;
  end process gen_rx_reset;


  -- Create synchronous reset in the local link transmitter clock domain.
  gen_tx_ll_reset : process (tx_ll_clk, tx_ll_reset)
  begin
    if tx_ll_reset = '1' then
      tx_ll_sreset5     <= '1';
      tx_ll_sreset4     <= '1';
      tx_ll_sreset3     <= '1';
      tx_ll_sreset2     <= '1';
      tx_ll_sreset      <= '1';
    elsif tx_ll_clk'event and tx_ll_clk = '1' then
      tx_ll_sreset5     <= '0';
      tx_ll_sreset4     <= tx_ll_sreset5;
      tx_ll_sreset3     <= tx_ll_sreset4;
      tx_ll_sreset2     <= tx_ll_sreset3;
      tx_ll_sreset      <= tx_ll_sreset2;
   end if;
  end process gen_tx_ll_reset;


  -- Create synchronous reset in the local link receiver clock domain.
  gen_rx_ll_reset : process (rx_ll_clk, rx_ll_reset)
  begin
    if rx_ll_reset = '1' then
      rx_ll_sreset5     <= '1';
      rx_ll_sreset4     <= '1';
      rx_ll_sreset3     <= '1';
      rx_ll_sreset2     <= '1';
      rx_ll_sreset      <= '1';
    elsif rx_ll_clk'event and rx_ll_clk = '1' then
      rx_ll_sreset5     <= '0';
      rx_ll_sreset4     <= rx_ll_sreset5;
      rx_ll_sreset3     <= rx_ll_sreset4;
      rx_ll_sreset2     <= rx_ll_sreset3;
      rx_ll_sreset      <= rx_ll_sreset2;
   end if;
  end process gen_rx_ll_reset;

  -------------------------------------------------------------------------------
  -- Instantiation of the 10 gig ethernet mac fifo
  -------------------------------------------------------------------------------   
  ten_gig_ethernet_mac_fifo : xgmac_fifo
     generic map (
        tx_fifo_size => 512,
        rx_fifo_size => 512)
     port map (
        --Local Link Write Interface
        tx_wr_clk      => tx_ll_clk,
        tx_wr_sreset   => tx_ll_sreset,
        tx_data_in     => tx_ll_data,
        tx_rem         => tx_ll_rem,
        tx_sof_n       => tx_ll_sof_n,
        tx_eof_n       => tx_ll_eof_n,
        tx_src_rdy_n   => tx_ll_src_rdy_n,
        tx_dst_rdy_n   => tx_ll_dst_rdy_n,
        tx_fifo_status => tx_fifo_status,
        tx_fifo_full   => open,
        --Local Link Read Interface
        rx_rd_clk      => rx_ll_clk,
        rx_rd_sreset   => rx_ll_sreset,
        rx_data_out    => rx_ll_data,
        rx_rem         => rx_ll_rem,
        rx_sof_n       => rx_ll_sof_n,
        rx_eof_n       => rx_ll_eof_n,
        rx_src_rdy_n   => rx_ll_src_rdy_n,
        rx_dst_rdy_n   => rx_ll_dst_rdy_n,
        rx_fifo_status => rx_fifo_status,
        rx_fifo_empty  => open,
        --MAC Tx Client Interface
        tx_clk         => tx_clk,
        tx_sreset      => tx_reset,
        tx_ack         => tx_ack,
        tx_data        => tx_data,
        tx_data_valid  => tx_data_valid,
        tx_underrun    => tx_underrun,
        tx_start       => tx_start,
        tx_fifo_empty  => open,
        --MAC Rx Client Interface
        rx_clk         => rx_clk,
        rx_sreset      => rx_reset,
        rx_data        => rx_data,
        rx_data_valid  => rx_data_valid,
        rx_good_frame  => rx_good_frame,
        rx_bad_frame   => rx_bad_frame,
        rx_fifo_full   => open);
 
end rtl;
