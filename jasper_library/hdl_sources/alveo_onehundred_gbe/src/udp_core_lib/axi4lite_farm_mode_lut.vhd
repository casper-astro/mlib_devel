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
use ieee.numeric_std.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;
library work;
use work.axi4lite_farm_mode_lut_pkg.all;
     
entity axi4lite_farm_mode_lut is
   port(
      axi4lite_aclk : in std_logic;
      axi4lite_aresetn : in std_logic;
      
      axi4lite_mosi : in t_axi4lite_mosi;
      axi4lite_miso : out t_axi4lite_miso;
      
      farm_mode_lut_lower_mac_addr_clk: in std_logic:='0';
      farm_mode_lut_lower_mac_addr_en: in std_logic:='0';
      farm_mode_lut_lower_mac_addr_we: in std_logic:='0';
      farm_mode_lut_lower_mac_addr_add: in std_logic_vector(7 downto 0):=(others=>'0');
      farm_mode_lut_lower_mac_addr_wdat: in std_logic_vector(31 downto 0):=(others=>'0');
      farm_mode_lut_lower_mac_addr_rdat: out std_logic_vector(31 downto 0);
      farm_mode_lut_upper_mac_addr_clk: in std_logic:='0';
      farm_mode_lut_upper_mac_addr_en: in std_logic:='0';
      farm_mode_lut_upper_mac_addr_we: in std_logic:='0';
      farm_mode_lut_upper_mac_addr_add: in std_logic_vector(7 downto 0):=(others=>'0');
      farm_mode_lut_upper_mac_addr_wdat: in std_logic_vector(31 downto 0):=(others=>'0');
      farm_mode_lut_upper_mac_addr_rdat: out std_logic_vector(31 downto 0);
      farm_mode_lut_ip_addr_clk: in std_logic:='0';
      farm_mode_lut_ip_addr_en: in std_logic:='0';
      farm_mode_lut_ip_addr_we: in std_logic:='0';
      farm_mode_lut_ip_addr_add: in std_logic_vector(7 downto 0):=(others=>'0');
      farm_mode_lut_ip_addr_wdat: in std_logic_vector(31 downto 0):=(others=>'0');
      farm_mode_lut_ip_addr_rdat: out std_logic_vector(31 downto 0);
      farm_mode_lut_dst_port_clk: in std_logic:='0';
      farm_mode_lut_dst_port_en: in std_logic:='0';
      farm_mode_lut_dst_port_we: in std_logic:='0';
      farm_mode_lut_dst_port_add: in std_logic_vector(7 downto 0):=(others=>'0');
      farm_mode_lut_dst_port_wdat: in std_logic_vector(31 downto 0):=(others=>'0');
      farm_mode_lut_dst_port_rdat: out std_logic_vector(31 downto 0)
   );
end entity;     

architecture axi4lite_farm_mode_lut_a of axi4lite_farm_mode_lut is 

   signal ipb_mosi : t_ipb_mosi;
   signal ipb_miso : t_ipb_miso;
   
   signal ipb_mosi_arr : t_ipb_farm_mode_lut_mosi_arr;
   signal ipb_miso_arr : t_ipb_farm_mode_lut_miso_arr;
   

begin
   --
   --
   --
   axi4lite_slave_logic_inst: entity axi4_lib.axi4lite_slave_logic
   port map (
      axi4lite_aclk => axi4lite_aclk,
      axi4lite_aresetn => axi4lite_aresetn,
      axi4lite_mosi => axi4lite_mosi,
      axi4lite_miso => axi4lite_miso,
      ipb_mosi => ipb_mosi,
      ipb_miso => ipb_miso
   );
   --
   -- blocks_muxdemux
   --
   axi4lite_farm_mode_lut_muxdemux_inst: entity work.axi4lite_farm_mode_lut_muxdemux
   port map(
      axi4lite_aclk => axi4lite_aclk,
      axi4lite_aresetn => axi4lite_aresetn,
      ipb_mosi => ipb_mosi,
      ipb_miso => ipb_miso,
      ipb_mosi_arr => ipb_mosi_arr,
      ipb_miso_arr => ipb_miso_arr   
   );
   --
   --
   --
   --
   --
   --
   --
   --
   --
   --
   --
   --
   ipb_lower_mac_addr_dp_ram_inst: entity work.ipb_farm_mode_lut_dp_ram
   generic map(
      ram_add_width => 8,
      ram_dat_width => 32,
      ipb_read => true,
      ipb_write => true,
      ipb_read_latency => 1,
      user_read_latency => 1,
      init_file => "",
      init_file_format => "hex"
   )
   port map(
      ipb_clk  => axi4lite_aclk,
      ipb_miso => ipb_miso_arr(c_ipb_farm_mode_lut_mapping.lower_mac_addr),
      ipb_mosi => ipb_mosi_arr(c_ipb_farm_mode_lut_mapping.lower_mac_addr),
      user_clk => farm_mode_lut_lower_mac_addr_clk,
      user_en => farm_mode_lut_lower_mac_addr_en,
      user_we => farm_mode_lut_lower_mac_addr_we,
      user_add => farm_mode_lut_lower_mac_addr_add,
      user_wdat => farm_mode_lut_lower_mac_addr_wdat,
      user_rdat => farm_mode_lut_lower_mac_addr_rdat
   );
   
   ipb_upper_mac_addr_dp_ram_inst: entity work.ipb_farm_mode_lut_dp_ram
   generic map(
      ram_add_width => 8,
      ram_dat_width => 32,
      ipb_read => true,
      ipb_write => true,
      ipb_read_latency => 1,
      user_read_latency => 1,
      init_file => "",
      init_file_format => "hex"
   )
   port map(
      ipb_clk  => axi4lite_aclk,
      ipb_miso => ipb_miso_arr(c_ipb_farm_mode_lut_mapping.upper_mac_addr),
      ipb_mosi => ipb_mosi_arr(c_ipb_farm_mode_lut_mapping.upper_mac_addr),
      user_clk => farm_mode_lut_upper_mac_addr_clk,
      user_en => farm_mode_lut_upper_mac_addr_en,
      user_we => farm_mode_lut_upper_mac_addr_we,
      user_add => farm_mode_lut_upper_mac_addr_add,
      user_wdat => farm_mode_lut_upper_mac_addr_wdat,
      user_rdat => farm_mode_lut_upper_mac_addr_rdat
   );
   
   ipb_ip_addr_dp_ram_inst: entity work.ipb_farm_mode_lut_dp_ram
   generic map(
      ram_add_width => 8,
      ram_dat_width => 32,
      ipb_read => true,
      ipb_write => true,
      ipb_read_latency => 1,
      user_read_latency => 1,
      init_file => "",
      init_file_format => "hex"
   )
   port map(
      ipb_clk  => axi4lite_aclk,
      ipb_miso => ipb_miso_arr(c_ipb_farm_mode_lut_mapping.ip_addr),
      ipb_mosi => ipb_mosi_arr(c_ipb_farm_mode_lut_mapping.ip_addr),
      user_clk => farm_mode_lut_ip_addr_clk,
      user_en => farm_mode_lut_ip_addr_en,
      user_we => farm_mode_lut_ip_addr_we,
      user_add => farm_mode_lut_ip_addr_add,
      user_wdat => farm_mode_lut_ip_addr_wdat,
      user_rdat => farm_mode_lut_ip_addr_rdat
   );
   
   ipb_dst_port_dp_ram_inst: entity work.ipb_farm_mode_lut_dp_ram
   generic map(
      ram_add_width => 8,
      ram_dat_width => 32,
      ipb_read => true,
      ipb_write => true,
      ipb_read_latency => 1,
      user_read_latency => 1,
      init_file => "",
      init_file_format => "hex"
   )
   port map(
      ipb_clk  => axi4lite_aclk,
      ipb_miso => ipb_miso_arr(c_ipb_farm_mode_lut_mapping.dst_port),
      ipb_mosi => ipb_mosi_arr(c_ipb_farm_mode_lut_mapping.dst_port),
      user_clk => farm_mode_lut_dst_port_clk,
      user_en => farm_mode_lut_dst_port_en,
      user_we => farm_mode_lut_dst_port_we,
      user_add => farm_mode_lut_dst_port_add,
      user_wdat => farm_mode_lut_dst_port_wdat,
      user_rdat => farm_mode_lut_dst_port_rdat
   );
   

   
end architecture;

