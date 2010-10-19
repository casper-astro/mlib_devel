------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:22 $
------------------------------------------------------------------------
------------------------------------------------------------------------
-- Title      : Address swap block
-- Project    : 10 Gigabit Ethernet MAC Core
------------------------------------------------------------------------
-- File       : client_loopback.vhd  
-- Author     : Xilinx Inc.
------------------------------------------------------------------------
-- Description: This is the address swap block for the Ten Gig Mac core.
--              It swaps the Destination and source address for the 
--              frames that pass through.           
------------------------------------------------------------------------
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
use work.XGMAC_FIFO_PACK.all;

------------------------------------------------------------------------
-- The entity declaration for the client side loopback design example.
------------------------------------------------------------------------

entity address_swap is
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
end address_swap;


architecture rtl of address_swap is   


  -- create a synchronous reset in the receiver clock domain
  signal rx_reset                     : std_logic;
  signal rx_reset2                     : std_logic;
  signal rx_reset3                     : std_logic;
  signal rx_reset4                     : std_logic;
  signal rx_reset5                     : std_logic;

  -- two state fifo state machine
  signal data_stored_n                : std_logic;

  -- single register in Local Link data path
  signal rx_data_out_reg              :  std_logic_vector(63 downto 0);
  signal rx_data_out_reg_reg          :  std_logic_vector(31 downto 0);
  signal rx_rem_reg                   :  std_logic_vector(2 downto 0);
  signal rx_sof_n_reg                 :  std_logic;
  signal rx_sof_n_reg_reg             :  std_logic;
  signal rx_eof_n_reg                 :  std_logic;
  
begin

  ----------------------------------------------------------------------
  -- Create synchronous reset signals for use in the Address swapping
  -- logic.  A synchronous reset signal is created in the rx_clk
  -- clock domain.
  ----------------------------------------------------------------------



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

  ----------------------------------------------------------------------
  -- Buffer one and a half words to allow address swap
  ----------------------------------------------------------------------

  p_rx_reg : process (rx_clk, rx_reset)
  begin
    if rx_clk'event and rx_clk = '1' then
      if rx_reset = '1' then
        rx_data_out_reg     <= (others => '0');
        rx_rem_reg          <= (others => '0');
        rx_sof_n_reg        <= '1';
        rx_sof_n_reg_reg    <= '1';
        rx_eof_n_reg        <= '1';
        rx_data_out_reg_reg <= (others => '0');
        data_stored_n       <= '1';
      elsif rx_src_rdy_n = '0' and tx_dst_rdy_n = '0' then
        data_stored_n       <= '0';
        rx_data_out_reg     <= rx_data;
        rx_rem_reg          <= rx_rem;
        rx_sof_n_reg        <= rx_sof_n;
        rx_sof_n_reg_reg    <= rx_sof_n_reg;
        rx_eof_n_reg        <= rx_eof_n;
        rx_data_out_reg_reg <= rx_data_out_reg(47 downto 16);
      elsif data_stored_n = '0' and tx_dst_rdy_n = '0' then
        data_stored_n       <= '1';
      end if;
    end if;
  end process p_rx_reg;


  ----------------------------------------------------------------------
  -- Output to Tx
  ----------------------------------------------------------------------

  -- address swap following new SOF
  p_tx_data : process (rx_sof_n_reg, rx_data_out_reg, rx_data, rx_sof_n_reg_reg)
  begin
    if rx_sof_n_reg = '0' then
      tx_data <= rx_data_out_reg(15 downto 0) & rx_data(31 downto 0) & rx_data_out_reg(63 downto 48);
    elsif rx_sof_n_reg_reg = '0' then
      tx_data <= rx_data_out_reg(63 downto 32) & rx_data_out_reg_reg;
    else
      tx_data <= rx_data_out_reg;
    end if;
  end process p_tx_data;

  tx_rem       <= rx_rem_reg;
  tx_sof_n     <= rx_sof_n_reg or data_stored_n;
  tx_src_rdy_n <= data_stored_n;
  tx_eof_n     <= rx_eof_n_reg or data_stored_n;
  rx_dst_rdy_n <= tx_dst_rdy_n;

end rtl;
