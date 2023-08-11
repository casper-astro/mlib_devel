-- This file is part of XML2VHDL
-- Copyright (C) 2015
-- University of Oxford <http://www.ox.ac.uk/>
-- Department of Physics
-- 
-- This program is free software: you can redistribute it and/or modify  
-- it under the terms of the GNU General Public License as published by  
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but 
-- WITHOUT ANY WARRANTY; without even the implied warranty of 
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License 
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

library ieee;
use ieee.std_logic_1164.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;
library work;
use work.axi4lite_udp_core_top_ic_pkg.all;
use work.axi4lite_udp_core_top_mmap_pkg.all;

entity axi4lite_udp_core_top_ic is
   port(
      axi4lite_aclk : in std_logic; 
      axi4lite_aresetn : in std_logic; 
      
      axi4lite_mosi      : in  t_axi4lite_mosi;       -- signals from master to interconnect
      axi4lite_mosi_arr  : out t_axi4lite_mosi_arr;   -- signals from interconnect to slaves
      
      axi4lite_miso_arr  : in  t_axi4lite_miso_arr;   -- signals from slaves to interconnect
      axi4lite_miso      : out t_axi4lite_miso        -- signals from interconnect to master
   );
end entity;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------
architecture behav of axi4lite_udp_core_top_ic is
   
   signal axi4lite_miso_int: t_axi4lite_miso;
   signal addr_sel: std_logic_vector(c_axi4lite_addr_w-1 downto 0);
   signal slave_hit_c: std_logic_vector(c_axi4lite_mmap_nof_slave-1 downto 0);
   signal slave_hit_r: std_logic_vector(c_axi4lite_mmap_nof_slave-1 downto 0);
   type t_fsm is (rdy,wr,rd);
   signal fsm: t_fsm;
  
begin
   
   addr_sel <= axi4lite_mosi.awaddr when axi4lite_mosi.awvalid = '1' else axi4lite_mosi.araddr;
   slave_hit_c <= axi4lite_mmap_decoder(addr_sel);
   
   axi4lite_master2slaves(c_axi4lite_mmap_nof_slave,
                          slave_hit_r,
                          slave_hit_r,
                          slave_hit_r,
                          slave_hit_r,
                          slave_hit_r,
                          axi4lite_mosi,axi4lite_mosi_arr);
   axi4lite_slaves2master(c_axi4lite_mmap_nof_slave,
                          slave_hit_r,
                          slave_hit_r,
                          slave_hit_r,
                          slave_hit_r,
                          slave_hit_r,axi4lite_miso_arr,axi4lite_miso_int);
                          
   process(axi4lite_aclk,axi4lite_aresetn)
   begin
      if rising_edge(axi4lite_aclk) then
         
         case fsm is
            when rdy =>
               if axi4lite_mosi.awvalid = '1' or axi4lite_mosi.arvalid = '1' then
                  slave_hit_r <= slave_hit_c;
               end if;
               if axi4lite_mosi.awvalid = '1' then
                  fsm <= wr;
               elsif axi4lite_mosi.arvalid = '1' then
                  fsm <= rd;
               end if;
            when wr =>
               if axi4lite_mosi.bready = '1' and axi4lite_miso_int.bvalid = '1' then
                  slave_hit_r <= (others=>'0');
                  fsm <= rdy;
               end if;
            when rd =>
               if axi4lite_mosi.rready = '1' and axi4lite_miso_int.rvalid = '1' then
                  slave_hit_r <= (others=>'0');
                  fsm <= rdy;
               end if;
         end case;
          
      end if;
      if axi4lite_aresetn = '0' then
         slave_hit_r <= (others=>'0');
         fsm <= rdy;
      end if;
   end process;
   
   axi4lite_miso <= axi4lite_miso_int;
   
end architecture;
