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
library udp_core_lib;
use udp_core_lib.axi4lite_udp_core_settings_pkg.all;
     
entity axi4lite_udp_core_settings_muxdemux is
   port(
      axi4lite_aclk : in std_logic; 
      axi4lite_aresetn : in std_logic; 
      
      ipb_mosi : in t_ipb_mosi;
      ipb_miso : out t_ipb_miso;
      
      ipb_mosi_arr : out t_ipb_udp_core_settings_mosi_arr;
      ipb_miso_arr : in t_ipb_udp_core_settings_miso_arr
   );
end entity;     

architecture axi4lite_udp_core_settings_muxdemux_a of axi4lite_udp_core_settings_muxdemux is 
   
   constant c_block_start_index: integer := c_nof_register_blocks;
   
   signal ipb_mosi_arr_i   : t_ipb_udp_core_settings_mosi_arr;
   
begin   
   --
   -- only one memory block or registers block, no need to mux/demux
   --
   gen_0: if c_total_nof_blocks = 1 generate
      ipb_mosi_arr_i(0) <= ipb_mosi;
      ipb_miso <= ipb_miso_arr(0);
   end generate;
   --
   -- more than one block
   --
   gen_1: if c_total_nof_blocks > 1 generate      
      --demux process
      demux_p: process(ipb_miso_arr,ipb_mosi_arr_i,ipb_mosi)
         variable hit: std_logic_vector(c_total_nof_blocks-1 downto 0);
      begin
         hit := axi4lite_udp_core_settings_demux(ipb_mosi.addr);
         for n in 0 to c_total_nof_blocks-1 loop
            ipb_mosi_arr_i(n).wreq <= ipb_mosi.wreq and hit(n);
            ipb_mosi_arr_i(n).rreq <= ipb_mosi.rreq and hit(n);
            ipb_mosi_arr_i(n).addr <= ipb_mosi.addr;
            ipb_mosi_arr_i(n).wdat <= ipb_mosi.wdat;
         end loop;
      end process;
      --mux process
      mux_p: process(ipb_miso_arr,ipb_mosi_arr_i)
      begin
         ipb_miso.rack <= '0';
         ipb_miso.wack <= '0';
         ipb_miso.rdat <= (others=>'-');
         for n in 0 to c_total_nof_blocks-1 loop
            if ipb_miso_arr(n).wack = '1' and ipb_mosi_arr_i(n).wreq = '1' then
               ipb_miso.wack <= '1';
            end if;
            if ipb_miso_arr(n).rack = '1' and ipb_mosi_arr_i(n).rreq = '1' then
               ipb_miso.rack <= '1';
               ipb_miso.rdat <= ipb_miso_arr(n).rdat;
            end if;
         end loop;
      end process;
   end generate;   
   
   ipb_mosi_arr <= ipb_mosi_arr_i;
      
end architecture;

