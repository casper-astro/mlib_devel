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

package axi4lite_udp_core_top_ic_pkg is

   procedure axi4lite_master2slaves(
      constant c_nof_slaves: integer;
      signal wr_addr_ch_slave_hit: in std_logic_vector;
      signal wr_data_ch_slave_hit: in std_logic_vector;
      signal wr_resp_ch_slave_hit: in std_logic_vector;
      signal rd_addr_ch_slave_hit: in std_logic_vector;
      signal rd_data_ch_slave_hit: in std_logic_vector;
      signal axi_i : in t_axi4lite_mosi;
      signal axi_o : out t_axi4lite_mosi_arr 
   );
   
   procedure axi4lite_slaves2master(
      constant c_nof_slaves: integer;
      signal wr_addr_ch_slave_hit: in std_logic_vector;
      signal wr_data_ch_slave_hit: in std_logic_vector;
      signal wr_resp_ch_slave_hit: in std_logic_vector;
      signal rd_addr_ch_slave_hit: in std_logic_vector;
      signal rd_data_ch_slave_hit: in std_logic_vector;
      signal axi_i : in t_axi4lite_miso_arr;
      signal axi_o : out t_axi4lite_miso 
   ); 
	
end package; 

package body axi4lite_udp_core_top_ic_pkg is

   procedure axi4lite_master2slaves(
      constant c_nof_slaves: integer;
      signal wr_addr_ch_slave_hit: in std_logic_vector;
      signal wr_data_ch_slave_hit: in std_logic_vector;
      signal wr_resp_ch_slave_hit: in std_logic_vector;
      signal rd_addr_ch_slave_hit: in std_logic_vector;
      signal rd_data_ch_slave_hit: in std_logic_vector;
      signal axi_i : in t_axi4lite_mosi;
      signal axi_o : out t_axi4lite_mosi_arr 
   ) is
   begin
      for n in 0 to c_nof_slaves-1 loop
         axi_o(n).awaddr   <= axi_i.awaddr;
         axi_o(n).awvalid  <= '0';
         axi_o(n).wdata    <= axi_i.wdata;
         axi_o(n).wstrb    <= (others=>'0');
         axi_o(n).wvalid   <= '0';
         axi_o(n).bready   <= '0';
         axi_o(n).araddr   <= axi_i.araddr;
         axi_o(n).arvalid  <= '0';
         axi_o(n).rready   <= '0';
         if wr_addr_ch_slave_hit(n) = '1' then
            axi_o(n).awvalid  <= axi_i.awvalid;
         end if;
         if wr_data_ch_slave_hit(n) = '1' then
            axi_o(n).wstrb    <= axi_i.wstrb;
            axi_o(n).wvalid   <= axi_i.wvalid;
         end if;
         if wr_resp_ch_slave_hit(n) = '1' then
            axi_o(n).bready   <= axi_i.bready;
         end if;
         if rd_addr_ch_slave_hit(n) = '1' then
            axi_o(n).arvalid  <= axi_i.arvalid;
         end if;
         if rd_data_ch_slave_hit(n) = '1' then
            axi_o(n).rready   <= axi_i.rready;
         end if;
      end loop;
   end procedure;
   
   procedure axi4lite_slaves2master(
      constant c_nof_slaves: integer;
      signal wr_addr_ch_slave_hit: in std_logic_vector;
      signal wr_data_ch_slave_hit: in std_logic_vector;
      signal wr_resp_ch_slave_hit: in std_logic_vector;
      signal rd_addr_ch_slave_hit: in std_logic_vector;
      signal rd_data_ch_slave_hit: in std_logic_vector;
      signal axi_i : in t_axi4lite_miso_arr;
      signal axi_o : out t_axi4lite_miso 
   ) is
   begin
      axi_o.awready  <= '0';
      axi_o.wready   <= '0';
      axi_o.bresp    <= (others=>'0');
      axi_o.bvalid   <= '0';
      axi_o.arready  <= '0';
      axi_o.rdata    <= (others=>'0');
      axi_o.rresp    <= (others=>'0');
      axi_o.rvalid   <= '0';
      for n in 0 to c_nof_slaves-1 loop
         if wr_addr_ch_slave_hit(n) = '1' then
            axi_o.awready  <= axi_i(n).awready;
         end if;
         if wr_data_ch_slave_hit(n) = '1' then
            axi_o.wready  <= axi_i(n).wready;
         end if;
         if wr_resp_ch_slave_hit(n) = '1' then
            axi_o.bvalid  <= axi_i(n).bvalid;
         end if;
         if wr_resp_ch_slave_hit(n) = '1' then
            axi_o.bresp  <= axi_i(n).bresp;
         end if;
         if rd_addr_ch_slave_hit(n) = '1' then
            axi_o.arready  <= axi_i(n).arready;
         end if;
         if rd_data_ch_slave_hit(n) = '1' then
            axi_o.rvalid  <= axi_i(n).rvalid;
         end if;
         if rd_data_ch_slave_hit(n) = '1' then
            axi_o.rdata  <= axi_i(n).rdata;
         end if;
         if rd_data_ch_slave_hit(n) = '1' then
            axi_o.rresp  <= axi_i(n).rresp;
         end if;
      end loop;
   end procedure;

end package body;
