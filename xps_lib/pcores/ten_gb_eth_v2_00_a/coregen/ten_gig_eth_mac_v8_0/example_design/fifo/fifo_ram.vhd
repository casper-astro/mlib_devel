----------------------------------------------------------------------------
-- $RCSfile: fifo_ram.vhd,v $
-- $Revision: 1.1 $
-- $Date: 2006/09/06 18:13:23 $
----------------------------------------------------------------------------
-- Title      : FIFO BRAM
-- Project    : Ten Gigabit Ethernet MAC core
----------------------------------------------------------------------------
-- File       : fifo_ram.vhd
-- Author     : Xilinx, Inc.
----------------------------------------------------------------------------
-- Description: BRAM used by tx and rx FIFOs
-------------------------------------------------------------------------------
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

entity fifo_ram is
   generic (
      addr_width : integer := 9);
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
end fifo_ram;

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

architecture rtl of fifo_ram is

   signal wr_data : std_logic_vector(71 downto 0);
   signal rd_data : std_logic_vector(71 downto 0);

   signal vcc, gnd : std_logic;
   signal gnd_bus  : std_logic_vector(31 downto 0);

   signal rd_allow_int : std_logic;
   
begin

   vcc     <= '1';
   gnd     <= '0';
   gnd_bus <= (others => '0');

   wr_data(63 downto 0)  <= data_in;
   wr_data(67 downto 64) <= ctrl_in;
   wr_data(71 downto 68) <= gnd_bus(3 downto 0);

   data_out <= rd_data(63 downto 0);
   ctrl_out <= rd_data(67 downto 64);

   --Block RAM must be enabled for synchronous reset to work.
   rd_allow_int <= rd_allow or rd_sreset;

------------------------------------------------------------------------
-- From the width of the required fifo, instance BRAMs and connect them
-- appropriately.
------------------------------------------------------------------------   

   --This means a depth of 512, we need two ramb16_s36_s36 block rams
   ram_size1 : if (addr_width = 9) generate
      ram_size11 : for i in 0 to 1 generate
         ram_size111 : ramb16_s36_s36
            port map (
               dia   => wr_data((i*32)+31 downto (i*32)),
               dib   => gnd_bus(31 downto 0),
               dipa  => wr_data((i*4)+67 downto (i*4)+64),
               dipb  => gnd_bus(3 downto 0),
               ena   => vcc,
               enb   => rd_allow_int,
               wea   => wr_allow,
               web   => gnd,
               ssra  => gnd,
               ssrb  => rd_sreset,
               clka  => wr_clk,
               clkb  => rd_clk,
               addra => wr_addr,
               addrb => rd_addr,
               doa   => open,
               dopa  => open,
               dob   => rd_data((i*32)+31 downto (i*32)),
               dopb  => rd_data((i*4)+67 downto (i*4)+64));
      end generate;
   end generate;

   --This means a depth of 1024, we need four ramb16_s18_s18 block rams
   ram_size2 : if (addr_width = 10) generate
      ram_size21 : for i in 0 to 3 generate
         ram_size211 : ramb16_s18_s18
            port map (
               dia   => wr_data((i*16)+15 downto (i*16)),
               dib   => gnd_bus(15 downto 0),
               dipa  => wr_data((i*2)+65 downto (i*2)+64),
               dipb  => gnd_bus(1 downto 0),
               ena   => vcc,
               enb   => rd_allow_int,
               wea   => wr_allow,
               web   => gnd,
               ssra  => gnd,
               ssrb  => rd_sreset,
               clka  => wr_clk,
               clkb  => rd_clk,
               addra => wr_addr,
               addrb => rd_addr,
               doa   => open,
               dopa  => open,
               dob   => rd_data((i*16)+15 downto (i*16)),
               dopb  => rd_data((i*2)+65 downto (i*2)+64));
      end generate;
   end generate;

   --This means a depth of 2048, we need eight ramb16_s9_s9 block rams
   ram_size3 : if (addr_width = 11) generate
      ram_size31 : for i in 0 to 7 generate
         ram_size311 : ramb16_s9_s9
            port map (
               dia   => wr_data((i*8)+7 downto (i*8)),
               dib   => gnd_bus(7 downto 0),
               dipa  => wr_data(i+64 downto i+64),
               dipb  => gnd_bus(0 downto 0),
               ena   => vcc,
               enb   => rd_allow_int,
               wea   => wr_allow,
               web   => gnd,
               ssra  => gnd,
               ssrb  => rd_sreset,
               clka  => wr_clk,
               clkb  => rd_clk,
               addra => wr_addr,
               addrb => rd_addr,
               doa   => open,
               dopa  => open,
               dob   => rd_data((i*8)+7 downto (i*8)),
               dopb  => rd_data(i+64 downto i+64));
      end generate;
   end generate;

   --This means a depth of 4096, we need 18 ramb16_s4_s4 block rams.
   --The reason why we need 18 instead of 16, is that we no longer have
   --a seperate dipa/dopb path for the control bits, so these have to be
   --catered for in the dia/dob data pathway.
   ram_size4 : if (addr_width = 12) generate
      ram_size41 : for i in 0 to 17 generate
         ram_size411 : ramb16_s4_s4
            port map (
               dia   => wr_data((i*4)+3 downto (i*4)),
               dib   => gnd_bus(3 downto 0),
               ena   => vcc,
               enb   => rd_allow_int,
               wea   => wr_allow,
               web   => gnd,
               ssra  => gnd,
               ssrb  => rd_sreset,
               clka  => wr_clk,
               clkb  => rd_clk,
               addra => wr_addr,
               addrb => rd_addr,
               doa   => open,
               dob   => rd_data((i*4)+3 downto (i*4)));
      end generate;      
   end generate;

   --This means a depth of 8192, we need 35 ramb16_s2_s2 block rams.
   --The reason why we need 35 instead of 32, is that we no longer have
   --a seperate dipa/dopb path for the control bits, so these have to be
   --catered for in the dia/dob data pathway.
   ram_size5 : if (addr_width = 13) generate
      ram_size51 : for i in 0 to 34 generate
         ram_size511 : ramb16_s2_s2
            port map (
               dia   => wr_data((i*2)+1 downto (i*2)),
               dib   => gnd_bus(1 downto 0),
               ena   => vcc,
               enb   => rd_allow_int,
               wea   => wr_allow,
               web   => gnd,
               ssra  => gnd,
               ssrb  => rd_sreset,
               clka  => wr_clk,
               clkb  => rd_clk,
               addra => wr_addr,
               addrb => rd_addr,
               doa   => open,
               dob   => rd_data((i*2)+1 downto (i*2)));
      end generate;

      rd_data(71 downto 70) <= "00";
      
   end generate;

   --This means a depth of 16384, we need 69 ramb16_s4_s4 block rams.
   --The reason why we need 69 instead of 64, is that we no longer have
   --a seperate dipa/dopb path for the control bits, so these have to be
   --catered for in the dia/dob data pathway.
   ram_size6 : if (addr_width = 14) generate
      ram_size61 : for i in 0 to 68 generate
         ram_size611 : ramb16_s1_s1
            port map (
               dia   => wr_data(i downto i),
               dib   => gnd_bus(0 downto 0),
               ena   => vcc,
               enb   => rd_allow_int,
               wea   => wr_allow,
               web   => gnd,
               ssra  => gnd,
               ssrb  => rd_sreset,
               clka  => wr_clk,
               clkb  => rd_clk,
               addra => wr_addr,
               addrb => rd_addr,
               doa   => open,
               dob   => rd_data(i downto i));
      end generate;

      rd_data(71 downto 69) <= "000";
      
   end generate;

end rtl;
