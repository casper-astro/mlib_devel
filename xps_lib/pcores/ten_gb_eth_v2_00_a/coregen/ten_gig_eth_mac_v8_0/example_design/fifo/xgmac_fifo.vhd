-------------------------------------------------------------------------------
-- $RCSfile: xgmac_fifo.vhd,v $
-- $Revision: 1.1 $
-- $Date: 2006/09/06 18:13:23 $
-------------------------------------------------------------------------------
-- Title      : XG MAC Tx/Rx FIFO Wrapper
-- Project    : 10 Gig Ethernet MAC Core
-------------------------------------------------------------------------------
-- File       : xgmac_fifo.vhd
-- Author     : Xilinx Inc.
-------------------------------------------------------------------------------
-- Description:
-- This module is the top level entity for the 10 Gig Ethernet MAC FIFO
-- This top level connects together the lower hierarchial
-- entities which create this design. This is illustrated below.
-------------------------------------------------------------------------------
--
--           .---------------------------------------------.
--           |                                             |
--           |       .----------------------------.        |
--           |       |       TRANSMIT_FIFO        |        |
--  ---------|------>|                            |--------|-------> MAC Tx
--           |       |                            |        |         Interface
--           |       '----------------------------'        |
--           |                                             |
--           |                                             |
--           |                                             |
-- Local     |                                             |
-- Link      |                                             |
-- Interface |                                             |
--           |                                             |
--           |       .----------------------------.        |
--           |       |       RECEIVE_FIFO         |        |
--  <--------|-------|                            |<-------|--------   MAC Rx Interface 
--           |       |                            |        |
--           |       '----------------------------'        |
--           |                                             |
--           |                                             |
--           |                                             |
--           |                                             |
--           |                                             |
--           '---------------------------------------------'
--
-------------------------------------------------------------------------------
-- Functionality:
--
-- 1. TRANSMIT_FIFO accepts 64-bit data from the client and writes
--    this into the Transmitter FIFO. The logic will then extract this from
--    the FIFO and write this data to the MAC Transmitter in 64-bit words.
--
-- 2. RECEIVE_FIFO accepts 64-bit data from the MAC Receiver and
--    writes this into the Receiver FIFO.  The client inferface can then
--    read 64-bit words from this FIFO.
--  
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

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.xgmac_fifo_pack.all;

entity xgmac_fifo is
   generic (
      tx_fifo_size : integer := 512;   -- valid fifo sizes: 512, 1024, 2048, 4096, 8192, 16384 words.
      rx_fifo_size : integer := 512);  -- valid fifo sizes: 512, 1024, 2048, 4096, 8192, 16384 words.
   port (
      ----------------------------------------------------------------
      -- client interface                                           --
      ----------------------------------------------------------------
      -- tx_wr_clk domain
      tx_wr_clk      : in  std_logic;   -- the transmit client clock.
      tx_wr_sreset   : in  std_logic;
      tx_data_in     : in  std_logic_vector(63 downto 0);
      tx_rem         : in  std_logic_vector(2 downto 0);
      tx_sof_n       : in  std_logic;
      tx_eof_n       : in  std_logic;
      tx_src_rdy_n   : in  std_logic;
      tx_dst_rdy_n   : out std_logic;
      tx_fifo_status : out std_logic_vector(3 downto 0);
      tx_fifo_full   : out std_logic;
      --rx_rd_clk domain
      rx_rd_clk      : in  std_logic;
      rx_rd_sreset   : in  std_logic;
      rx_data_out    : out std_logic_vector(63 downto 0);
      rx_rem         : out std_logic_vector(2 downto 0);
      rx_sof_n       : out std_logic;
      rx_eof_n       : out std_logic;
      rx_src_rdy_n   : out std_logic;
      rx_dst_rdy_n   : in  std_logic;
      rx_fifo_status : out std_logic_vector(3 downto 0);
      rx_fifo_empty  : out std_logic;
      ----------------------------------------------------------------
      -- mac transmitter interface                                  --
      ----------------------------------------------------------------
      tx_clk         : in  std_logic;   -- mac transmitter clock.
      tx_sreset      : in  std_logic;
      tx_ack         : in  std_logic;   -- mac transmitter acknowledge.
      tx_data_valid  : out std_logic_vector(7 downto 0);  -- indication of valid bytes for tx_data.
      tx_data        : out std_logic_vector(63 downto 0);  -- data to be written to mac transmitter.
      tx_underrun    : out std_logic;  -- force mac transmitter to scrap current frame.
      tx_start       : out std_logic;  -- initiate transmission
      tx_fifo_empty  : out std_logic;
      ----------------------------------------------------------------
      -- mac receiver interface                                     --
      ----------------------------------------------------------------
      rx_clk         : in  std_logic;  -- mac receiver clock.
      rx_sreset      : in  std_logic;
      rx_data        : in  std_logic_vector(63 downto 0);  -- data from mac receiver. 
      rx_data_valid  : in  std_logic_vector(7 downto 0);   -- indication of valid bytes for rx_data. 
      rx_good_frame  : in  std_logic;  -- the previous mac frame contained no errors.
      rx_bad_frame   : in  std_logic;  -- the previous mac frame contained errors.
      rx_fifo_full   : out std_logic);
end xgmac_fifo;


architecture rtl of xgmac_fifo is

component tx_fifo is
  generic (
    fifo_size     : integer := 512);
  port (
    wr_clk         : in  std_logic;                      
    wr_sreset      : in  std_logic;                      
    data_in        : in  std_logic_vector(63 downto 0);  
    rem_in         : in  std_logic_vector(2 downto 0);   
    sof_in         : in  std_logic;                      
    eof_in         : in  std_logic;                      
    src_rdy_in     : in  std_logic;                      
    dst_rdy_out    : out std_logic;                      
    fifo_full      : out std_logic;                    
    rd_clk         : in  std_logic;                      
    rd_sreset      : in  std_logic;                      
    tx_data        : out std_logic_vector(63 downto 0);  
    tx_data_valid  : out std_logic_vector(7 downto 0);   
    tx_start       : out std_logic;                      
    tx_ack         : in  std_logic);                     
end component;

component rx_fifo is
   generic (
      fifo_size : integer := 512);
   port (
      -- MAC Rx Client I/F (FIFO write domain)
      rx_clk         : in  std_logic;
      rx_sreset      : in  std_logic;
      rx_data        : in  std_logic_vector(63 downto 0);
      rx_data_valid  : in  std_logic_vector(7 downto 0);
      rx_good_frame  : in  std_logic;
      rx_bad_frame   : in  std_logic;

      -- LocalLink I/F (FIFO read domain): 
      -- NOTE: all signals here are active high
      rd_clk         : in  std_logic;
      rd_sreset      : in  std_logic;
      dst_rdy_in     : in  std_logic;
      data_out       : out std_logic_vector(63 downto 0);
      rem_out        : out std_logic_vector(2 downto 0);
      sof_out        : out std_logic;
      eof_out        : out std_logic;
      src_rdy_out    : out std_logic;
      
      -- FIFO Status Signals
      rx_fifo_status : out std_logic_vector(3 downto 0);
      fifo_full      : out std_logic);

end component;


  signal sof_in                       : std_logic;
  signal eof_in                       : std_logic;
  signal src_rdy_in                   : std_logic;
  signal dst_rdy_out                  : std_logic;

  signal sof_out                      : std_logic;
  signal eof_out                      : std_logic;
  signal src_rdy_out                  : std_logic;
  signal dst_rdy_in                   : std_logic;


begin

   --Instance the transmit fifo.
  i_tx_fifo : tx_fifo
    generic map(
      fifo_size => tx_fifo_size
      )
    port map (
      wr_clk         =>  tx_wr_clk,         
      wr_sreset      =>  tx_wr_sreset,
      data_in        =>  tx_data_in,
      rem_in         =>  tx_rem,
      sof_in         =>  sof_in,
      eof_in         =>  eof_in,
      src_rdy_in     =>  src_rdy_in,
      dst_rdy_out    =>  dst_rdy_out,
      fifo_full      =>  tx_fifo_full,
      rd_clk         =>  tx_clk,
      rd_sreset      =>  tx_sreset,
      tx_data        =>  tx_data,
      tx_data_valid  =>  tx_data_valid,
      tx_start       =>  tx_start,
      tx_ack         =>  tx_ack);

    tx_underrun <= '0';
    tx_fifo_empty <= '0';
    tx_fifo_status <= (others => '0');
    sof_in       <= not tx_sof_n;
    eof_in       <= not tx_eof_n;
    src_rdy_in   <= not tx_src_rdy_n;
    tx_dst_rdy_n <= not dst_rdy_out;
    

   --Instance the receive fifo
   rx_fifo_inst : rx_fifo
      generic map (
         fifo_size      => rx_fifo_size)
      port map (
         rx_clk         => rx_clk,
         rx_sreset      => rx_sreset,
         rx_data        => rx_data,
         rx_data_valid  => rx_data_valid,
         rx_good_frame  => rx_good_frame,
         rx_bad_frame   => rx_bad_frame,
         rd_clk         => rx_rd_clk,
         rd_sreset      => rx_rd_sreset,
         dst_rdy_in     => dst_rdy_in,
         data_out       => rx_data_out,
         rem_out        => rx_rem,
         sof_out        => sof_out,
         eof_out        => eof_out,
         src_rdy_out    => src_rdy_out,
         rx_fifo_status => rx_fifo_status,
         fifo_full      => rx_fifo_full);

   -- These status signals for the receiver FIFO are not derived in this 
   -- example
   rx_fifo_empty  <= '0';

   -- Local Link signalling is active low.  These are converted to 
   -- active high signals to make the Rx FIFO code readable
   dst_rdy_in     <= not rx_dst_rdy_n;
   rx_sof_n       <= not sof_out;
   rx_eof_n       <= not eof_out;
   rx_src_rdy_n   <= not src_rdy_out;


end rtl;
