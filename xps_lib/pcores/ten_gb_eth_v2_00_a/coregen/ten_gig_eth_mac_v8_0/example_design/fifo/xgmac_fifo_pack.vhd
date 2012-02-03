------------------------------------------------------------------------
-- $RCSfile: xgmac_fifo_pack.vhd,v $
-- $Revision: 1.1 $ 
-- $Date: 2006/09/06 18:13:23 $
------------------------------------------------------------------------
-- title   : package for the 10 gig ethernet mac fifo reference design
-- project : 10 gig ethernet mac fifo reference design
------------------------------------------------------------------------
-- file    : xgmac_fifo_pack.vhd
-- author  : xilinx inc.
------------------------------------------------------------------------
-- description : this module is the package used by the 10-gigabit
-- ethernet mac fifo interface. 
--
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


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package xgmac_fifo_pack is

   ---------------------------------------------------------------------
   -- purpose: define function to convert fifo word size into an address
   -- width
   -- type   : function
   ---------------------------------------------------------------------
   function log2 (
      value : integer)
      return integer;

   ---------------------------------------------------------------------
   -- purpose: converts from unsigned to std_logic_vector
   -- type   : function
   ---------------------------------------------------------------------
   function unsigned_to_std_logic_vector (
      input_bus : unsigned)
      return std_logic_vector;

   ---------------------------------------------------------------------
   -- purpose: converts from std_logic_vector to unsigned
   -- type   : function
   ---------------------------------------------------------------------
   function std_logic_vector_to_unsigned (
      input_bus : std_logic_vector)
      return unsigned;

   ---------------------------------------------------------------------
   -- purpose : converts gray code to binary code
   -- type    : function
   ---------------------------------------------------------------------
   function gray_to_bin (
      gray : std_logic_vector)
      return std_logic_vector;

   ---------------------------------------------------------------------
   -- purpose : converts binary to gray code (by calling gray_to_bin)
   ---------------------------------------------------------------------
   function bin_to_gray (
      bin : std_logic_vector)
      return std_logic_vector;

   component xgmac_fifo

      generic (
         -- valid tx/rx fifo sizes: 512, 1024, 2048, 4096, 8192, 16384 words.
         tx_fifo_size : integer := 512;
         rx_fifo_size : integer := 512);
      port (
         ---------------------------------------------------------------
         -- client interface
         ---------------------------------------------------------------
         -- tx_wr_clk domain
         -- the transmit client clock.
         tx_wr_clk      : in  std_logic;
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
         ---------------------------------------------------------------
         -- mac transmitter interface
         ---------------------------------------------------------------
         -- mac transmitter clock.
         tx_clk         : in  std_logic;
         tx_sreset      : in  std_logic;
         -- mac transmitter acknowledge.
         tx_ack         : in  std_logic;
         -- indication of valid bytes for tx_data.
         tx_data_valid  : out std_logic_vector(7 downto 0);
         -- data to be written to mac transmitter.
         tx_data        : out std_logic_vector(63 downto 0);
         -- force mac transmitter to scrap current frame.
         tx_underrun    : out std_logic;
         -- initiate transmission
         tx_start       : out std_logic;
         tx_fifo_empty  : out std_logic;
         ---------------------------------------------------------------
         -- mac receiver interface
         ---------------------------------------------------------------
         -- mac receiver clock.               
         rx_clk         : in  std_logic;
         rx_sreset      : in  std_logic;
         -- data from mac receiver. 
         rx_data        : in  std_logic_vector(63 downto 0);
         -- indication of valid bytes for rx_data.          
         rx_data_valid  : in  std_logic_vector(7 downto 0);
         -- the previous mac frame contained no errors.
         rx_good_frame  : in  std_logic;
         -- the previous mac frame contained errors.
         rx_bad_frame   : in  std_logic;
         rx_fifo_full   : out std_logic
         );
   end component;

   component fifo_ram
      generic (
         addr_width : integer);
      port (
         wr_clk    : in  std_logic;
         wr_addr   : in  std_logic_vector(addr_width-1 downto 0);
         data_in   : in  std_logic_vector(63 downto 0);
         ctrl_in   : in  std_logic_vector(3 downto 0);
         wr_allow  : in  std_logic;
         rd_clk    : in  std_logic;
         rd_sreset : in  std_logic;
         rd_addr   : in  std_logic_vector(addr_width-1 downto 0);
         data_out  : out std_logic_vector(63 downto 0);
         ctrl_out  : out std_logic_vector(3 downto 0);
         rd_allow  : in  std_logic);
   end component;

   component xgmac_wrapper
      port (
         ---------------------------------------------------------------
         -- client interface
         ---------------------------------------------------------------
         -- tx_wr_clk domain
         -- the transmit client clock.
         tx_wr_clk      : in  std_logic;
         tx_wr_sreset   : in  std_logic;
         tx_data_in     : in  std_logic_vector(63 downto 0);
         tx_rem         : in  std_logic_vector(2 downto 0);
         tx_sof_n       : in  std_logic;
         tx_eof_n       : in  std_logic;
         tx_src_rdy_n   : in  std_logic;
         tx_dst_rdy_n   : out std_logic;
         tx_fifo_status : out std_logic_vector(3 downto 0);
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
         ---------------------------------------------------------------
         -- mac transmitter interface
         ---------------------------------------------------------------
         -- mac transmitter clock.
         tx_clk         : in  std_logic;
         tx_sreset      : in  std_logic;
         -- mac transmitter acknowledge.
         tx_ack         : in  std_logic;
         -- indication of valid bytes for tx_data.
         tx_data_valid  : out std_logic_vector(7 downto 0);
         -- data to be written to mac transmitter.
         tx_data        : out std_logic_vector(63 downto 0);
         -- force mac transmitter to scrap current frame.
         tx_underrun    : out std_logic;
         -- initiate transmission
         tx_start       : out std_logic;
         ---------------------------------------------------------------
         -- mac receiver interface
         ---------------------------------------------------------------
         -- mac receiver clock.               
         rx_clk         : in  std_logic;
         rx_sreset      : in  std_logic;
         -- data from mac receiver. 
         rx_data        : in  std_logic_vector(63 downto 0);
         -- indication of valid bytes for rx_data.          
         rx_data_valid  : in  std_logic_vector(7 downto 0);
         -- the previous mac frame contained no errors.
         rx_good_frame  : in  std_logic;
         -- the previous mac frame contained errors.
         rx_bad_frame   : in  std_logic
         );
   end component;


   ---------------------------------------------------------------------
   -- purpose:  fifo interface to mac transmitter logic
   -- type   : component
   ---------------------------------------------------------------------
   component transmit_fifo
      generic (
         fifo_size : integer := 512);
      port (
         tx_wr_clk       : in  std_logic;
         tx_wr_sreset    : in  std_logic;
         tx_data_in      : in  std_logic_vector(63 downto 0);
         tx_rem          : in  std_logic_vector(2 downto 0);
         tx_sof_n        : in  std_logic;
         tx_eof_n        : in  std_logic;
         tx_src_rdy_n    : in  std_logic;
         tx_dst_rdy_n    : out std_logic;
         fifo_status     : out std_logic_vector(3 downto 0);
         fifo_full       : out std_logic;
         tx_clk          : in  std_logic;
         tx_sreset       : in  std_logic;
         tx_ack          : in  std_logic;
         tx_data_valid   : out std_logic_vector(7 downto 0);
         tx_data_out     : out std_logic_vector(63 downto 0);
         tx_underrun_out : out std_logic;
         tx_start        : out std_logic;
         fifo_empty      : out std_logic);
   end component;

   component receive_fifo
      generic (
         fifo_size : integer := 512);
      port (
         rx_clk        : in  std_logic;
         rx_sreset     : in  std_logic;
         rx_data       : in  std_logic_vector(63 downto 0);
         rx_data_valid : in  std_logic_vector(7 downto 0);
         good_frame    : in  std_logic;
         bad_frame     : in  std_logic;
         fifo_status   : out std_logic_vector(3 downto 0);
         fifo_full     : out std_logic;
         rx_rd_clk     : in  std_logic;
         rx_rd_sreset  : in  std_logic;
         rx_dst_rdy_n  : in  std_logic;
         rx_data_out   : out std_logic_vector(63 downto 0);
         rx_rem        : out std_logic_vector(2 downto 0);
         rx_sof_n      : out std_logic;
         rx_eof_n      : out std_logic;
         rx_src_rdy_n  : out std_logic;
         fifo_empty    : out std_logic);
   end component;

   component local_link_fifo
      generic (
         fifo_size     : integer := 512;
         transmit_fifo : boolean := true);
      port (
         wr_clk         : in  std_logic;
         wr_sreset      : in  std_logic;
         data_in        : in  std_logic_vector(63 downto 0);
         rem_in         : in  std_logic_vector(2 downto 0);
         sof_in         : in  std_logic;
         eof_in         : in  std_logic;
         src_rdy_in     : in  std_logic;
         dst_rdy_out    : out std_logic;
         good_frame     : in  std_logic;
         bad_frame      : in  std_logic;
         wr_fifo_status : out std_logic_vector(3 downto 0);
         fifo_full      : out std_logic;
         fifo_empty     : out std_logic;
         rd_clk         : in  std_logic;
         rd_sreset      : in  std_logic;
         data_out       : out std_logic_vector(63 downto 0);
         rem_out        : out std_logic_vector(2 downto 0);
         sof_out        : out std_logic;
         eof_out        : out std_logic;
         src_rdy_out    : out std_logic;
         dst_rdy_in     : in  std_logic;
         rd_fifo_status : out std_logic_vector(3 downto 0));         
   end component;

   ---------------------------------------------------------------------
   -- purpose : instances the appropriate block rams for the size of the
   -- fifo.
   -- type    : component
   ---------------------------------------------------------------------
   component data_control_fifo
      generic (
         addr_width : integer);
      port (
         wr_clk    : in  std_logic;
         wr_addr   : in  std_logic_vector(addr_width-1 downto 0);
         data_in   : in  std_logic_vector(63 downto 0);
         ctrl_in   : in  std_logic_vector(4 downto 0);
         wr_allow  : in  std_logic;
         rd_clk    : in  std_logic;
         rd_sreset : in  std_logic;
         rd_addr   : in  std_logic_vector(addr_width-1 downto 0);
         data_out  : out std_logic_vector(63 downto 0);
         ctrl_out  : out std_logic_vector(4 downto 0);
         rd_allow  : in  std_logic);
   end component;

   component sreset_gen
      generic (
         pulse_length : integer);
      port (
         clk    : in  std_logic;
         reset  : in  std_logic;
         sreset : out std_logic);
   end component;

end xgmac_fifo_pack;

package body xgmac_fifo_pack is

   ---------------------------------------------------------------------
   -- purpose: define function to convert fifo word size into an address
   -- width
   -- type   : function
   ---------------------------------------------------------------------
   function log2 (value : integer) return integer is
      variable ret_val : integer;
   begin
      ret_val := 0;

      if value <= 2**ret_val then
         ret_val := 0;
      else
         while 2**ret_val < value loop
            ret_val := ret_val + 1;
         end loop;
      end if;

      return ret_val;
      
   end log2;

   ---------------------------------------------------------------------
   -- purpose: converts from unsigned to std_logic_vector
   -- type   : function
   ---------------------------------------------------------------------
   function unsigned_to_std_logic_vector (
      input_bus : unsigned)
      return std_logic_vector is

      variable temp_vector : std_logic_vector(input_bus'range);

   begin
      for i in input_bus'range loop
         -- bit-by-bit remapping.
         temp_vector(i) := input_bus(i);
      end loop;

      return temp_vector;

   end unsigned_to_std_logic_vector;

   ---------------------------------------------------------------------
   -- purpose: converts from std_logic_vector to unsigned
   -- type   : function
   ---------------------------------------------------------------------
   function std_logic_vector_to_unsigned (
      input_bus : std_logic_vector)
      return unsigned is

      variable temp_vector : unsigned(input_bus'range);

   begin
      for i in input_bus'range loop
         -- bit-by-bit remapping.
         temp_vector(i) := input_bus(i);
      end loop;
      return temp_vector;
   end std_logic_vector_to_unsigned;

   function gray_to_bin (
      gray : std_logic_vector)
      return std_logic_vector is

      variable binary : std_logic_vector(gray'range);
      
   begin

      for i in gray'high downto gray'low loop
         if i = gray'high then
            binary(i) := gray(i);
         else
            binary(i) := binary(i+1) xor gray(i);
         end if;
      end loop;  -- i

      return binary;
      
   end gray_to_bin;

   function bin_to_gray (
      bin : std_logic_vector)
      return std_logic_vector is

      variable gray : std_logic_vector(bin'range);
      
   begin

      for i in bin'range loop
         if i = bin'left then
            gray(i) := bin(i);
         else
            gray(i) := bin(i+1) xor bin(i);
         end if;
      end loop;  -- i

      return gray;

   end bin_to_gray;

end xgmac_fifo_pack;











