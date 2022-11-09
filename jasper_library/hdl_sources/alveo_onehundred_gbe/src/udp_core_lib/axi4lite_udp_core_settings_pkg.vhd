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

package axi4lite_udp_core_settings_pkg is 

   --##########################################################################
   --
   -- Register Records
   --
   --##########################################################################
   type t_axi4lite_udp_core_settings_control is record
      fixed_pkt_size: std_logic;
      udp_checksum_zero: std_logic;
      farm_mode: std_logic;
      tuser_dst_prt: std_logic;
      tuser_src_prt: std_logic;
      reset_n: std_logic;
      udp_length: std_logic_vector(15 downto 0);
   end record;

   type t_axi4lite_udp_core_settings_filter_control is record
      broadcast_en: std_logic;
      arp_en: std_logic;
      ping_en: std_logic;
      pass_uns_ethtype: std_logic;
      pass_uns_ipv4: std_logic;
      dst_mac_chk_en: std_logic;
      src_mac_chk_en: std_logic;
      dst_ip_chk_en: std_logic;
      src_ip_chk_en: std_logic;
      dst_port_chk_en: std_logic;
      src_port_chk_en: std_logic;
      packet_count_rst_n: std_logic;
      strip_uns_pro: std_logic;
      strip_uns_eth: std_logic;
      chk_ip_length: std_logic;
   end record;

   type t_axi4lite_udp_core_settings_udp_ports is record
      src_port: std_logic_vector(15 downto 0);
      dst_port: std_logic_vector(15 downto 0);
   end record;

   type t_axi4lite_udp_core_settings_ipv4_header_2 is record
      ip_ttl: std_logic_vector(7 downto 0);
      ip_protocol: std_logic_vector(7 downto 0);
      header_checksum: std_logic_vector(15 downto 0);
   end record;

   type t_axi4lite_udp_core_settings_ipv4_header_1 is record
      ip_count: std_logic_vector(15 downto 0);
      ip_fragment: std_logic_vector(15 downto 0);
   end record;

   type t_axi4lite_udp_core_settings_ipv4_header_0 is record
      ip_ver_hdr_len: std_logic_vector(7 downto 0);
      ip_service: std_logic_vector(7 downto 0);
      ip_packet_length: std_logic_vector(15 downto 0);
   end record;

   type t_axi4lite_udp_core_settings is record
      src_mac_addr_lower: std_logic_vector(31 downto 0);
      src_mac_addr_upper: std_logic_vector(15 downto 0);
      dst_mac_addr_lower: std_logic_vector(31 downto 0);
      dst_mac_addr_upper: std_logic_vector(15 downto 0);
      ethertype: std_logic_vector(15 downto 0);
      ipv4_header_0: t_axi4lite_udp_core_settings_ipv4_header_0;
      ipv4_header_1: t_axi4lite_udp_core_settings_ipv4_header_1;
      ipv4_header_2: t_axi4lite_udp_core_settings_ipv4_header_2;
      dst_ip_addr: std_logic_vector(31 downto 0);
      src_ip_addr: std_logic_vector(31 downto 0);
      udp_ports: t_axi4lite_udp_core_settings_udp_ports;
      udp_length: std_logic_vector(15 downto 0);
      filter_control: t_axi4lite_udp_core_settings_filter_control;
      ifg: std_logic_vector(15 downto 0);
      control: t_axi4lite_udp_core_settings_control;
      udp_count: std_logic_vector(31 downto 0);
      ping_count: std_logic_vector(31 downto 0);
      arp_count: std_logic_vector(31 downto 0);
      uns_etype_count: std_logic_vector(31 downto 0);
      uns_pro_count: std_logic_vector(31 downto 0);
      dropped_mac_count: std_logic_vector(31 downto 0);
      dropped_ip_count: std_logic_vector(31 downto 0);
      dropped_port_count: std_logic_vector(31 downto 0);
      ip_id: std_logic_vector(31 downto 0);
      udp_core_id: std_logic_vector(31 downto 0);
   end record;

   --##########################################################################
   --
   -- Register Decoded Records
   --
   --##########################################################################
   type t_axi4lite_udp_core_settings_control_decoded is record
      fixed_pkt_size: std_logic;
      udp_checksum_zero: std_logic;
      farm_mode: std_logic;
      tuser_dst_prt: std_logic;
      tuser_src_prt: std_logic;
      reset_n: std_logic;
      udp_length: std_logic;
   end record;

   type t_axi4lite_udp_core_settings_filter_control_decoded is record
      broadcast_en: std_logic;
      arp_en: std_logic;
      ping_en: std_logic;
      pass_uns_ethtype: std_logic;
      pass_uns_ipv4: std_logic;
      dst_mac_chk_en: std_logic;
      src_mac_chk_en: std_logic;
      dst_ip_chk_en: std_logic;
      src_ip_chk_en: std_logic;
      dst_port_chk_en: std_logic;
      src_port_chk_en: std_logic;
      packet_count_rst_n: std_logic;
      strip_uns_pro: std_logic;
      strip_uns_eth: std_logic;
      chk_ip_length: std_logic;
   end record;

   type t_axi4lite_udp_core_settings_udp_ports_decoded is record
      src_port: std_logic;
      dst_port: std_logic;
   end record;

   type t_axi4lite_udp_core_settings_ipv4_header_2_decoded is record
      ip_ttl: std_logic;
      ip_protocol: std_logic;
      header_checksum: std_logic;
   end record;

   type t_axi4lite_udp_core_settings_ipv4_header_1_decoded is record
      ip_count: std_logic;
      ip_fragment: std_logic;
   end record;

   type t_axi4lite_udp_core_settings_ipv4_header_0_decoded is record
      ip_ver_hdr_len: std_logic;
      ip_service: std_logic;
      ip_packet_length: std_logic;
   end record;

   type t_axi4lite_udp_core_settings_decoded is record
      src_mac_addr_lower: std_logic;
      src_mac_addr_upper: std_logic;
      dst_mac_addr_lower: std_logic;
      dst_mac_addr_upper: std_logic;
      ethertype: std_logic;
      ipv4_header_0: t_axi4lite_udp_core_settings_ipv4_header_0_decoded;
      ipv4_header_1: t_axi4lite_udp_core_settings_ipv4_header_1_decoded;
      ipv4_header_2: t_axi4lite_udp_core_settings_ipv4_header_2_decoded;
      dst_ip_addr: std_logic;
      src_ip_addr: std_logic;
      udp_ports: t_axi4lite_udp_core_settings_udp_ports_decoded;
      udp_length: std_logic;
      filter_control: t_axi4lite_udp_core_settings_filter_control_decoded;
      ifg: std_logic;
      control: t_axi4lite_udp_core_settings_control_decoded;
      udp_count: std_logic;
      ping_count: std_logic;
      arp_count: std_logic;
      uns_etype_count: std_logic;
      uns_pro_count: std_logic;
      dropped_mac_count: std_logic;
      dropped_ip_count: std_logic;
      dropped_port_count: std_logic;
      ip_id: std_logic;
      udp_core_id: std_logic;
   end record;

   --##########################################################################
   --
   -- Register Descriptors
   --
   --##########################################################################
   type t_access_type is (r,w,rw);
   type t_reset_type is (async_reset,no_reset);
   
   type t_reg_descr is record
      offset: std_logic_vector(31 downto 0);
      bit_hi: natural;
      bit_lo: natural;
      rst_val: std_logic_vector(31 downto 0);
      reset_type: t_reset_type;
      decoder_mask: std_logic_vector(31 downto 0);
      access_type: t_access_type;
   end record;
   
   type t_axi4lite_udp_core_settings_descr is record
      src_mac_addr_lower: t_reg_descr;
      src_mac_addr_upper: t_reg_descr;
      dst_mac_addr_lower: t_reg_descr;
      dst_mac_addr_upper: t_reg_descr;
      ethertype: t_reg_descr;
      ipv4_header_0_ip_ver_hdr_len: t_reg_descr;
      ipv4_header_0_ip_service: t_reg_descr;
      ipv4_header_0_ip_packet_length: t_reg_descr;
      ipv4_header_1_ip_count: t_reg_descr;
      ipv4_header_1_ip_fragment: t_reg_descr;
      ipv4_header_2_ip_ttl: t_reg_descr;
      ipv4_header_2_ip_protocol: t_reg_descr;
      ipv4_header_2_header_checksum: t_reg_descr;
      dst_ip_addr: t_reg_descr;
      src_ip_addr: t_reg_descr;
      udp_ports_src_port: t_reg_descr;
      udp_ports_dst_port: t_reg_descr;
      udp_length: t_reg_descr;
      filter_control_broadcast_en: t_reg_descr;
      filter_control_arp_en: t_reg_descr;
      filter_control_ping_en: t_reg_descr;
      filter_control_pass_uns_ethtype: t_reg_descr;
      filter_control_pass_uns_ipv4: t_reg_descr;
      filter_control_dst_mac_chk_en: t_reg_descr;
      filter_control_src_mac_chk_en: t_reg_descr;
      filter_control_dst_ip_chk_en: t_reg_descr;
      filter_control_src_ip_chk_en: t_reg_descr;
      filter_control_dst_port_chk_en: t_reg_descr;
      filter_control_src_port_chk_en: t_reg_descr;
      filter_control_packet_count_rst_n: t_reg_descr;
      filter_control_strip_uns_pro: t_reg_descr;
      filter_control_strip_uns_eth: t_reg_descr;
      filter_control_chk_ip_length: t_reg_descr;
      ifg: t_reg_descr;
      control_fixed_pkt_size: t_reg_descr;
      control_udp_checksum_zero: t_reg_descr;
      control_farm_mode: t_reg_descr;
      control_tuser_dst_prt: t_reg_descr;
      control_tuser_src_prt: t_reg_descr;
      control_reset_n: t_reg_descr;
      control_udp_length: t_reg_descr;
      udp_count: t_reg_descr;
      ping_count: t_reg_descr;
      arp_count: t_reg_descr;
      uns_etype_count: t_reg_descr;
      uns_pro_count: t_reg_descr;
      dropped_mac_count: t_reg_descr;
      dropped_ip_count: t_reg_descr;
      dropped_port_count: t_reg_descr;
      ip_id: t_reg_descr;
      udp_core_id: t_reg_descr;
   end record;

   
   constant axi4lite_udp_core_settings_descr: t_axi4lite_udp_core_settings_descr := (
      src_mac_addr_lower                 => (X"00000000",31, 0,X"00000201",async_reset,X"0000007c",rw),
      src_mac_addr_upper                 => (X"00000004",15, 0,X"00006200",async_reset,X"0000007c",rw),
      dst_mac_addr_lower                 => (X"0000000c",31, 0,X"0000ff00",async_reset,X"00000078",rw),
      dst_mac_addr_upper                 => (X"00000010",15, 0,X"00006200",async_reset,X"0000007c",rw),
      ethertype                          => (X"00000014",15, 0,X"00000008",async_reset,X"0000007c",rw),
      ipv4_header_0_ip_ver_hdr_len       => (X"00000018", 7, 0,X"00000045",async_reset,X"0000007c",rw),
      ipv4_header_0_ip_service           => (X"00000018",15, 8,X"00000000",async_reset,X"0000007c",rw),
      ipv4_header_0_ip_packet_length     => (X"00000018",31,16,X"0000001c",async_reset,X"0000007c",rw),
      ipv4_header_1_ip_count             => (X"0000001c",15, 0,X"0000db00",async_reset,X"0000007c",rw),
      ipv4_header_1_ip_fragment          => (X"0000001c",31,16,X"00000000",async_reset,X"0000007c",rw),
      ipv4_header_2_ip_ttl               => (X"00000020", 7, 0,X"00000080",async_reset,X"0000007c",rw),
      ipv4_header_2_ip_protocol          => (X"00000020",15, 8,X"00000011",async_reset,X"0000007c",rw),
      ipv4_header_2_header_checksum      => (X"00000020",31,16,X"00000000",async_reset,X"0000007c",rw),
      dst_ip_addr                        => (X"00000024",31, 0,X"c0a80201",async_reset,X"0000007c",rw),
      src_ip_addr                        => (X"00000028",31, 0,X"c0a8020b",async_reset,X"0000007c",rw),
      udp_ports_src_port                 => (X"0000002c",15, 0,X"0000f0d0",async_reset,X"0000007c",rw),
      udp_ports_dst_port                 => (X"0000002c",31,16,X"0000f0d1",async_reset,X"0000007c",rw),
      udp_length                         => (X"00000030",15, 0,X"00000008",async_reset,X"00000078",rw),
      filter_control_broadcast_en        => (X"00000038", 0, 0,X"00000001",async_reset,X"00000078",rw),
      filter_control_arp_en              => (X"00000038", 1, 1,X"00000001",async_reset,X"00000078",rw),
      filter_control_ping_en             => (X"00000038", 2, 2,X"00000001",async_reset,X"00000078",rw),
      filter_control_pass_uns_ethtype    => (X"00000038", 8, 8,X"00000001",async_reset,X"00000078",rw),
      filter_control_pass_uns_ipv4       => (X"00000038", 9, 9,X"00000001",async_reset,X"00000078",rw),
      filter_control_dst_mac_chk_en      => (X"00000038",16,16,X"00000001",async_reset,X"00000078",rw),
      filter_control_src_mac_chk_en      => (X"00000038",17,17,X"00000000",async_reset,X"00000078",rw),
      filter_control_dst_ip_chk_en       => (X"00000038",18,18,X"00000001",async_reset,X"00000078",rw),
      filter_control_src_ip_chk_en       => (X"00000038",19,19,X"00000000",async_reset,X"00000078",rw),
      filter_control_dst_port_chk_en     => (X"00000038",20,20,X"00000000",async_reset,X"00000078",rw),
      filter_control_src_port_chk_en     => (X"00000038",21,21,X"00000000",async_reset,X"00000078",rw),
      filter_control_packet_count_rst_n  => (X"00000038",22,22,X"00000001",async_reset,X"00000078",rw),
      filter_control_strip_uns_pro       => (X"00000038",24,24,X"00000001",async_reset,X"00000078",rw),
      filter_control_strip_uns_eth       => (X"00000038",25,25,X"00000001",async_reset,X"00000078",rw),
      filter_control_chk_ip_length       => (X"00000038",26,26,X"00000001",async_reset,X"00000078",rw),
      ifg                                => (X"00000040",15, 0,X"00000000",async_reset,X"00000078",rw),
      control_fixed_pkt_size             => (X"00000048", 3, 3,X"00000000",async_reset,X"0000007c",rw),
      control_udp_checksum_zero          => (X"00000048", 4, 4,X"00000001",async_reset,X"0000007c",rw),
      control_farm_mode                  => (X"00000048", 5, 5,X"00000000",async_reset,X"0000007c",rw),
      control_tuser_dst_prt              => (X"00000048", 6, 6,X"00000000",async_reset,X"0000007c",rw),
      control_tuser_src_prt              => (X"00000048", 7, 7,X"00000000",async_reset,X"0000007c",rw),
      control_reset_n                    => (X"00000048",15,15,X"00000001",async_reset,X"0000007c",rw),
      control_udp_length                 => (X"00000048",31,16,X"00000008",async_reset,X"0000007c",rw),
      udp_count                          => (X"0000004c",31, 0,X"00000000",   no_reset,X"0000007c",r),
      ping_count                         => (X"00000050",31, 0,X"00000000",   no_reset,X"0000007c",r),
      arp_count                          => (X"00000054",31, 0,X"00000000",   no_reset,X"0000007c",r),
      uns_etype_count                    => (X"00000058",31, 0,X"00000000",   no_reset,X"0000007c",r),
      uns_pro_count                      => (X"0000005c",31, 0,X"00000000",   no_reset,X"0000007c",r),
      dropped_mac_count                  => (X"00000060",31, 0,X"00000000",   no_reset,X"0000007c",r),
      dropped_ip_count                   => (X"00000064",31, 0,X"00000000",   no_reset,X"0000007c",r),
      dropped_port_count                 => (X"00000068",31, 0,X"00000000",   no_reset,X"0000007c",r),
      ip_id                              => (X"0000006c",31, 0,X"00000000",async_reset,X"0000007c",r),
      udp_core_id                        => (X"00000074",31, 0,X"76543210",async_reset,X"00000070",r)
   );

   --##########################################################################
   --
   -- Constants
   --
   --##########################################################################
   constant c_nof_register_blocks: integer := 1;
   constant c_nof_memory_blocks: integer := 0;
   constant c_total_nof_blocks: integer := c_nof_memory_blocks+c_nof_register_blocks;
   
   type t_ipb_udp_core_settings_mosi_arr is array (0 to c_total_nof_blocks-1) of t_ipb_mosi;
   type t_ipb_udp_core_settings_miso_arr is array (0 to c_total_nof_blocks-1) of t_ipb_miso;
   


   --##########################################################################
   --
   -- Functions
   --
   --##########################################################################
   function axi4lite_udp_core_settings_decoder(descr: t_reg_descr; addr: std_logic_vector) return boolean;
   
   function axi4lite_udp_core_settings_full_decoder(addr: std_logic_vector; en: std_logic) return t_axi4lite_udp_core_settings_decoded;
   
   procedure axi4lite_udp_core_settings_reset(signal udp_core_settings: inout t_axi4lite_udp_core_settings);
   procedure axi4lite_udp_core_settings_default_decoded(signal udp_core_settings: inout t_axi4lite_udp_core_settings_decoded);
   procedure axi4lite_udp_core_settings_write_reg(data: std_logic_vector; 
                                          signal udp_core_settings_decoded: in t_axi4lite_udp_core_settings_decoded;
                                          signal udp_core_settings: inout t_axi4lite_udp_core_settings);
   
   function axi4lite_udp_core_settings_read_reg(signal udp_core_settings_decoded: in t_axi4lite_udp_core_settings_decoded;
                                        signal udp_core_settings: t_axi4lite_udp_core_settings) return std_logic_vector;
   
   function axi4lite_udp_core_settings_demux(addr: std_logic_vector) return std_logic_vector;

end package;

package body axi4lite_udp_core_settings_pkg is
   
   function axi4lite_udp_core_settings_decoder(descr: t_reg_descr; addr: std_logic_vector) return boolean is
      variable ret: boolean:=true;
      variable bus_addr_i: std_logic_vector(addr'length-1 downto 0) := addr;
      variable mask_i: std_logic_vector(descr.decoder_mask'length-1 downto 0) := descr.decoder_mask;
      variable reg_addr_i: std_logic_vector(descr.offset'length-1 downto 0) := descr.offset;
   begin
      for n in 0 to bus_addr_i'length-1 loop
         if mask_i(n) = '1' and bus_addr_i(n) /= reg_addr_i(n) then
            ret := false;
         end if;
      end loop;
      return ret;
   end function;
   
   function axi4lite_udp_core_settings_full_decoder(addr: std_logic_vector; en: std_logic) return t_axi4lite_udp_core_settings_decoded is
      variable udp_core_settings_decoded: t_axi4lite_udp_core_settings_decoded;
   begin
   
      udp_core_settings_decoded.src_mac_addr_lower := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.src_mac_addr_lower,addr) = true and en = '1' then
         udp_core_settings_decoded.src_mac_addr_lower := '1';
      end if;
      
      udp_core_settings_decoded.src_mac_addr_upper := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.src_mac_addr_upper,addr) = true and en = '1' then
         udp_core_settings_decoded.src_mac_addr_upper := '1';
      end if;
      
      udp_core_settings_decoded.dst_mac_addr_lower := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.dst_mac_addr_lower,addr) = true and en = '1' then
         udp_core_settings_decoded.dst_mac_addr_lower := '1';
      end if;
      
      udp_core_settings_decoded.dst_mac_addr_upper := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.dst_mac_addr_upper,addr) = true and en = '1' then
         udp_core_settings_decoded.dst_mac_addr_upper := '1';
      end if;
      
      udp_core_settings_decoded.ethertype := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ethertype,addr) = true and en = '1' then
         udp_core_settings_decoded.ethertype := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_0.ip_ver_hdr_len := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_0_ip_ver_hdr_len,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_0.ip_ver_hdr_len := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_0.ip_service := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_0_ip_service,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_0.ip_service := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_0.ip_packet_length := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_0_ip_packet_length,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_0.ip_packet_length := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_1.ip_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_1_ip_count,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_1.ip_count := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_1.ip_fragment := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_1_ip_fragment,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_1.ip_fragment := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_2.ip_ttl := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_2_ip_ttl,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_2.ip_ttl := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_2.ip_protocol := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_2_ip_protocol,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_2.ip_protocol := '1';
      end if;
      
      udp_core_settings_decoded.ipv4_header_2.header_checksum := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ipv4_header_2_header_checksum,addr) = true and en = '1' then
         udp_core_settings_decoded.ipv4_header_2.header_checksum := '1';
      end if;
      
      udp_core_settings_decoded.dst_ip_addr := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.dst_ip_addr,addr) = true and en = '1' then
         udp_core_settings_decoded.dst_ip_addr := '1';
      end if;
      
      udp_core_settings_decoded.src_ip_addr := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.src_ip_addr,addr) = true and en = '1' then
         udp_core_settings_decoded.src_ip_addr := '1';
      end if;
      
      udp_core_settings_decoded.udp_ports.src_port := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.udp_ports_src_port,addr) = true and en = '1' then
         udp_core_settings_decoded.udp_ports.src_port := '1';
      end if;
      
      udp_core_settings_decoded.udp_ports.dst_port := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.udp_ports_dst_port,addr) = true and en = '1' then
         udp_core_settings_decoded.udp_ports.dst_port := '1';
      end if;
      
      udp_core_settings_decoded.udp_length := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.udp_length,addr) = true and en = '1' then
         udp_core_settings_decoded.udp_length := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.broadcast_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_broadcast_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.broadcast_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.arp_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_arp_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.arp_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.ping_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_ping_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.ping_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.pass_uns_ethtype := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_pass_uns_ethtype,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.pass_uns_ethtype := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.pass_uns_ipv4 := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_pass_uns_ipv4,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.pass_uns_ipv4 := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.dst_mac_chk_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_dst_mac_chk_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.dst_mac_chk_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.src_mac_chk_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_src_mac_chk_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.src_mac_chk_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.dst_ip_chk_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_dst_ip_chk_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.dst_ip_chk_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.src_ip_chk_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_src_ip_chk_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.src_ip_chk_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.dst_port_chk_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_dst_port_chk_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.dst_port_chk_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.src_port_chk_en := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_src_port_chk_en,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.src_port_chk_en := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.packet_count_rst_n := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_packet_count_rst_n,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.packet_count_rst_n := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.strip_uns_pro := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_strip_uns_pro,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.strip_uns_pro := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.strip_uns_eth := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_strip_uns_eth,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.strip_uns_eth := '1';
      end if;
      
      udp_core_settings_decoded.filter_control.chk_ip_length := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.filter_control_chk_ip_length,addr) = true and en = '1' then
         udp_core_settings_decoded.filter_control.chk_ip_length := '1';
      end if;
      
      udp_core_settings_decoded.ifg := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ifg,addr) = true and en = '1' then
         udp_core_settings_decoded.ifg := '1';
      end if;
      
      udp_core_settings_decoded.control.fixed_pkt_size := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.control_fixed_pkt_size,addr) = true and en = '1' then
         udp_core_settings_decoded.control.fixed_pkt_size := '1';
      end if;
      
      udp_core_settings_decoded.control.udp_checksum_zero := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.control_udp_checksum_zero,addr) = true and en = '1' then
         udp_core_settings_decoded.control.udp_checksum_zero := '1';
      end if;
      
      udp_core_settings_decoded.control.farm_mode := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.control_farm_mode,addr) = true and en = '1' then
         udp_core_settings_decoded.control.farm_mode := '1';
      end if;
      
      udp_core_settings_decoded.control.tuser_dst_prt := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.control_tuser_dst_prt,addr) = true and en = '1' then
         udp_core_settings_decoded.control.tuser_dst_prt := '1';
      end if;
      
      udp_core_settings_decoded.control.tuser_src_prt := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.control_tuser_src_prt,addr) = true and en = '1' then
         udp_core_settings_decoded.control.tuser_src_prt := '1';
      end if;
      
      udp_core_settings_decoded.control.reset_n := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.control_reset_n,addr) = true and en = '1' then
         udp_core_settings_decoded.control.reset_n := '1';
      end if;
      
      udp_core_settings_decoded.control.udp_length := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.control_udp_length,addr) = true and en = '1' then
         udp_core_settings_decoded.control.udp_length := '1';
      end if;
      
      udp_core_settings_decoded.udp_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.udp_count,addr) = true and en = '1' then
         udp_core_settings_decoded.udp_count := '1';
      end if;
      
      udp_core_settings_decoded.ping_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ping_count,addr) = true and en = '1' then
         udp_core_settings_decoded.ping_count := '1';
      end if;
      
      udp_core_settings_decoded.arp_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.arp_count,addr) = true and en = '1' then
         udp_core_settings_decoded.arp_count := '1';
      end if;
      
      udp_core_settings_decoded.uns_etype_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.uns_etype_count,addr) = true and en = '1' then
         udp_core_settings_decoded.uns_etype_count := '1';
      end if;
      
      udp_core_settings_decoded.uns_pro_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.uns_pro_count,addr) = true and en = '1' then
         udp_core_settings_decoded.uns_pro_count := '1';
      end if;
      
      udp_core_settings_decoded.dropped_mac_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.dropped_mac_count,addr) = true and en = '1' then
         udp_core_settings_decoded.dropped_mac_count := '1';
      end if;
      
      udp_core_settings_decoded.dropped_ip_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.dropped_ip_count,addr) = true and en = '1' then
         udp_core_settings_decoded.dropped_ip_count := '1';
      end if;
      
      udp_core_settings_decoded.dropped_port_count := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.dropped_port_count,addr) = true and en = '1' then
         udp_core_settings_decoded.dropped_port_count := '1';
      end if;
      
      udp_core_settings_decoded.ip_id := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.ip_id,addr) = true and en = '1' then
         udp_core_settings_decoded.ip_id := '1';
      end if;
      
      udp_core_settings_decoded.udp_core_id := '0';
      if axi4lite_udp_core_settings_decoder(axi4lite_udp_core_settings_descr.udp_core_id,addr) = true and en = '1' then
         udp_core_settings_decoded.udp_core_id := '1';
      end if;
      
      
      return udp_core_settings_decoded;
   end function;
     
   procedure axi4lite_udp_core_settings_reset(signal udp_core_settings: inout t_axi4lite_udp_core_settings) is
   begin
      
      udp_core_settings.src_mac_addr_lower <= axi4lite_udp_core_settings_descr.src_mac_addr_lower.rst_val(31 downto 0);
      udp_core_settings.src_mac_addr_upper <= axi4lite_udp_core_settings_descr.src_mac_addr_upper.rst_val(15 downto 0);
      udp_core_settings.dst_mac_addr_lower <= axi4lite_udp_core_settings_descr.dst_mac_addr_lower.rst_val(31 downto 0);
      udp_core_settings.dst_mac_addr_upper <= axi4lite_udp_core_settings_descr.dst_mac_addr_upper.rst_val(15 downto 0);
      udp_core_settings.ethertype <= axi4lite_udp_core_settings_descr.ethertype.rst_val(15 downto 0);
      udp_core_settings.ipv4_header_0.ip_ver_hdr_len <= axi4lite_udp_core_settings_descr.ipv4_header_0_ip_ver_hdr_len.rst_val(7 downto 0);
      udp_core_settings.ipv4_header_0.ip_service <= axi4lite_udp_core_settings_descr.ipv4_header_0_ip_service.rst_val(7 downto 0);
      udp_core_settings.ipv4_header_0.ip_packet_length <= axi4lite_udp_core_settings_descr.ipv4_header_0_ip_packet_length.rst_val(15 downto 0);
      udp_core_settings.ipv4_header_1.ip_count <= axi4lite_udp_core_settings_descr.ipv4_header_1_ip_count.rst_val(15 downto 0);
      udp_core_settings.ipv4_header_1.ip_fragment <= axi4lite_udp_core_settings_descr.ipv4_header_1_ip_fragment.rst_val(15 downto 0);
      udp_core_settings.ipv4_header_2.ip_ttl <= axi4lite_udp_core_settings_descr.ipv4_header_2_ip_ttl.rst_val(7 downto 0);
      udp_core_settings.ipv4_header_2.ip_protocol <= axi4lite_udp_core_settings_descr.ipv4_header_2_ip_protocol.rst_val(7 downto 0);
      udp_core_settings.ipv4_header_2.header_checksum <= axi4lite_udp_core_settings_descr.ipv4_header_2_header_checksum.rst_val(15 downto 0);
      udp_core_settings.dst_ip_addr <= axi4lite_udp_core_settings_descr.dst_ip_addr.rst_val(31 downto 0);
      udp_core_settings.src_ip_addr <= axi4lite_udp_core_settings_descr.src_ip_addr.rst_val(31 downto 0);
      udp_core_settings.udp_ports.src_port <= axi4lite_udp_core_settings_descr.udp_ports_src_port.rst_val(15 downto 0);
      udp_core_settings.udp_ports.dst_port <= axi4lite_udp_core_settings_descr.udp_ports_dst_port.rst_val(15 downto 0);
      udp_core_settings.udp_length <= axi4lite_udp_core_settings_descr.udp_length.rst_val(15 downto 0);
      udp_core_settings.filter_control.broadcast_en <= axi4lite_udp_core_settings_descr.filter_control_broadcast_en.rst_val(0);
      udp_core_settings.filter_control.arp_en <= axi4lite_udp_core_settings_descr.filter_control_arp_en.rst_val(0);
      udp_core_settings.filter_control.ping_en <= axi4lite_udp_core_settings_descr.filter_control_ping_en.rst_val(0);
      udp_core_settings.filter_control.pass_uns_ethtype <= axi4lite_udp_core_settings_descr.filter_control_pass_uns_ethtype.rst_val(0);
      udp_core_settings.filter_control.pass_uns_ipv4 <= axi4lite_udp_core_settings_descr.filter_control_pass_uns_ipv4.rst_val(0);
      udp_core_settings.filter_control.dst_mac_chk_en <= axi4lite_udp_core_settings_descr.filter_control_dst_mac_chk_en.rst_val(0);
      udp_core_settings.filter_control.src_mac_chk_en <= axi4lite_udp_core_settings_descr.filter_control_src_mac_chk_en.rst_val(0);
      udp_core_settings.filter_control.dst_ip_chk_en <= axi4lite_udp_core_settings_descr.filter_control_dst_ip_chk_en.rst_val(0);
      udp_core_settings.filter_control.src_ip_chk_en <= axi4lite_udp_core_settings_descr.filter_control_src_ip_chk_en.rst_val(0);
      udp_core_settings.filter_control.dst_port_chk_en <= axi4lite_udp_core_settings_descr.filter_control_dst_port_chk_en.rst_val(0);
      udp_core_settings.filter_control.src_port_chk_en <= axi4lite_udp_core_settings_descr.filter_control_src_port_chk_en.rst_val(0);
      udp_core_settings.filter_control.packet_count_rst_n <= axi4lite_udp_core_settings_descr.filter_control_packet_count_rst_n.rst_val(0);
      udp_core_settings.filter_control.strip_uns_pro <= axi4lite_udp_core_settings_descr.filter_control_strip_uns_pro.rst_val(0);
      udp_core_settings.filter_control.strip_uns_eth <= axi4lite_udp_core_settings_descr.filter_control_strip_uns_eth.rst_val(0);
      udp_core_settings.filter_control.chk_ip_length <= axi4lite_udp_core_settings_descr.filter_control_chk_ip_length.rst_val(0);
      udp_core_settings.ifg <= axi4lite_udp_core_settings_descr.ifg.rst_val(15 downto 0);
      udp_core_settings.control.fixed_pkt_size <= axi4lite_udp_core_settings_descr.control_fixed_pkt_size.rst_val(0);
      udp_core_settings.control.udp_checksum_zero <= axi4lite_udp_core_settings_descr.control_udp_checksum_zero.rst_val(0);
      udp_core_settings.control.farm_mode <= axi4lite_udp_core_settings_descr.control_farm_mode.rst_val(0);
      udp_core_settings.control.tuser_dst_prt <= axi4lite_udp_core_settings_descr.control_tuser_dst_prt.rst_val(0);
      udp_core_settings.control.tuser_src_prt <= axi4lite_udp_core_settings_descr.control_tuser_src_prt.rst_val(0);
      udp_core_settings.control.reset_n <= axi4lite_udp_core_settings_descr.control_reset_n.rst_val(0);
      udp_core_settings.control.udp_length <= axi4lite_udp_core_settings_descr.control_udp_length.rst_val(15 downto 0);
      udp_core_settings.ip_id <= axi4lite_udp_core_settings_descr.ip_id.rst_val(31 downto 0);
      udp_core_settings.udp_core_id <= axi4lite_udp_core_settings_descr.udp_core_id.rst_val(31 downto 0);

   end procedure;
   
   procedure axi4lite_udp_core_settings_default_decoded(signal udp_core_settings: inout t_axi4lite_udp_core_settings_decoded) is
   begin
      
      udp_core_settings.src_mac_addr_lower <= '0';
      udp_core_settings.src_mac_addr_upper <= '0';
      udp_core_settings.dst_mac_addr_lower <= '0';
      udp_core_settings.dst_mac_addr_upper <= '0';
      udp_core_settings.ethertype <= '0';
      udp_core_settings.ipv4_header_0.ip_ver_hdr_len <= '0';
      udp_core_settings.ipv4_header_0.ip_service <= '0';
      udp_core_settings.ipv4_header_0.ip_packet_length <= '0';
      udp_core_settings.ipv4_header_1.ip_count <= '0';
      udp_core_settings.ipv4_header_1.ip_fragment <= '0';
      udp_core_settings.ipv4_header_2.ip_ttl <= '0';
      udp_core_settings.ipv4_header_2.ip_protocol <= '0';
      udp_core_settings.ipv4_header_2.header_checksum <= '0';
      udp_core_settings.dst_ip_addr <= '0';
      udp_core_settings.src_ip_addr <= '0';
      udp_core_settings.udp_ports.src_port <= '0';
      udp_core_settings.udp_ports.dst_port <= '0';
      udp_core_settings.udp_length <= '0';
      udp_core_settings.filter_control.broadcast_en <= '0';
      udp_core_settings.filter_control.arp_en <= '0';
      udp_core_settings.filter_control.ping_en <= '0';
      udp_core_settings.filter_control.pass_uns_ethtype <= '0';
      udp_core_settings.filter_control.pass_uns_ipv4 <= '0';
      udp_core_settings.filter_control.dst_mac_chk_en <= '0';
      udp_core_settings.filter_control.src_mac_chk_en <= '0';
      udp_core_settings.filter_control.dst_ip_chk_en <= '0';
      udp_core_settings.filter_control.src_ip_chk_en <= '0';
      udp_core_settings.filter_control.dst_port_chk_en <= '0';
      udp_core_settings.filter_control.src_port_chk_en <= '0';
      udp_core_settings.filter_control.packet_count_rst_n <= '0';
      udp_core_settings.filter_control.strip_uns_pro <= '0';
      udp_core_settings.filter_control.strip_uns_eth <= '0';
      udp_core_settings.filter_control.chk_ip_length <= '0';
      udp_core_settings.ifg <= '0';
      udp_core_settings.control.fixed_pkt_size <= '0';
      udp_core_settings.control.udp_checksum_zero <= '0';
      udp_core_settings.control.farm_mode <= '0';
      udp_core_settings.control.tuser_dst_prt <= '0';
      udp_core_settings.control.tuser_src_prt <= '0';
      udp_core_settings.control.reset_n <= '0';
      udp_core_settings.control.udp_length <= '0';
      udp_core_settings.udp_count <= '0';
      udp_core_settings.ping_count <= '0';
      udp_core_settings.arp_count <= '0';
      udp_core_settings.uns_etype_count <= '0';
      udp_core_settings.uns_pro_count <= '0';
      udp_core_settings.dropped_mac_count <= '0';
      udp_core_settings.dropped_ip_count <= '0';
      udp_core_settings.dropped_port_count <= '0';
      udp_core_settings.ip_id <= '0';
      udp_core_settings.udp_core_id <= '0';

   end procedure;

   procedure axi4lite_udp_core_settings_write_reg(data: std_logic_vector; 
                                          signal udp_core_settings_decoded: in t_axi4lite_udp_core_settings_decoded;
                                          signal udp_core_settings: inout t_axi4lite_udp_core_settings) is
   begin
      
      if udp_core_settings_decoded.src_mac_addr_lower = '1' then
         udp_core_settings.src_mac_addr_lower <= data(31 downto 0);
      end if;
      
      if udp_core_settings_decoded.src_mac_addr_upper = '1' then
         udp_core_settings.src_mac_addr_upper <= data(15 downto 0);
      end if;
      
      if udp_core_settings_decoded.dst_mac_addr_lower = '1' then
         udp_core_settings.dst_mac_addr_lower <= data(31 downto 0);
      end if;
      
      if udp_core_settings_decoded.dst_mac_addr_upper = '1' then
         udp_core_settings.dst_mac_addr_upper <= data(15 downto 0);
      end if;
      
      if udp_core_settings_decoded.ethertype = '1' then
         udp_core_settings.ethertype <= data(15 downto 0);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_0.ip_ver_hdr_len = '1' then
         udp_core_settings.ipv4_header_0.ip_ver_hdr_len <= data(7 downto 0);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_0.ip_service = '1' then
         udp_core_settings.ipv4_header_0.ip_service <= data(15 downto 8);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_0.ip_packet_length = '1' then
         udp_core_settings.ipv4_header_0.ip_packet_length <= data(31 downto 16);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_1.ip_count = '1' then
         udp_core_settings.ipv4_header_1.ip_count <= data(15 downto 0);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_1.ip_fragment = '1' then
         udp_core_settings.ipv4_header_1.ip_fragment <= data(31 downto 16);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_2.ip_ttl = '1' then
         udp_core_settings.ipv4_header_2.ip_ttl <= data(7 downto 0);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_2.ip_protocol = '1' then
         udp_core_settings.ipv4_header_2.ip_protocol <= data(15 downto 8);
      end if;
      
      if udp_core_settings_decoded.ipv4_header_2.header_checksum = '1' then
         udp_core_settings.ipv4_header_2.header_checksum <= data(31 downto 16);
      end if;
      
      if udp_core_settings_decoded.dst_ip_addr = '1' then
         udp_core_settings.dst_ip_addr <= data(31 downto 0);
      end if;
      
      if udp_core_settings_decoded.src_ip_addr = '1' then
         udp_core_settings.src_ip_addr <= data(31 downto 0);
      end if;
      
      if udp_core_settings_decoded.udp_ports.src_port = '1' then
         udp_core_settings.udp_ports.src_port <= data(15 downto 0);
      end if;
      
      if udp_core_settings_decoded.udp_ports.dst_port = '1' then
         udp_core_settings.udp_ports.dst_port <= data(31 downto 16);
      end if;
      
      if udp_core_settings_decoded.udp_length = '1' then
         udp_core_settings.udp_length <= data(15 downto 0);
      end if;
      
      if udp_core_settings_decoded.filter_control.broadcast_en = '1' then
         udp_core_settings.filter_control.broadcast_en <= data(0);
      end if;
      
      if udp_core_settings_decoded.filter_control.arp_en = '1' then
         udp_core_settings.filter_control.arp_en <= data(1);
      end if;
      
      if udp_core_settings_decoded.filter_control.ping_en = '1' then
         udp_core_settings.filter_control.ping_en <= data(2);
      end if;
      
      if udp_core_settings_decoded.filter_control.pass_uns_ethtype = '1' then
         udp_core_settings.filter_control.pass_uns_ethtype <= data(8);
      end if;
      
      if udp_core_settings_decoded.filter_control.pass_uns_ipv4 = '1' then
         udp_core_settings.filter_control.pass_uns_ipv4 <= data(9);
      end if;
      
      if udp_core_settings_decoded.filter_control.dst_mac_chk_en = '1' then
         udp_core_settings.filter_control.dst_mac_chk_en <= data(16);
      end if;
      
      if udp_core_settings_decoded.filter_control.src_mac_chk_en = '1' then
         udp_core_settings.filter_control.src_mac_chk_en <= data(17);
      end if;
      
      if udp_core_settings_decoded.filter_control.dst_ip_chk_en = '1' then
         udp_core_settings.filter_control.dst_ip_chk_en <= data(18);
      end if;
      
      if udp_core_settings_decoded.filter_control.src_ip_chk_en = '1' then
         udp_core_settings.filter_control.src_ip_chk_en <= data(19);
      end if;
      
      if udp_core_settings_decoded.filter_control.dst_port_chk_en = '1' then
         udp_core_settings.filter_control.dst_port_chk_en <= data(20);
      end if;
      
      if udp_core_settings_decoded.filter_control.src_port_chk_en = '1' then
         udp_core_settings.filter_control.src_port_chk_en <= data(21);
      end if;
      
      if udp_core_settings_decoded.filter_control.packet_count_rst_n = '1' then
         udp_core_settings.filter_control.packet_count_rst_n <= data(22);
      end if;
      
      if udp_core_settings_decoded.filter_control.strip_uns_pro = '1' then
         udp_core_settings.filter_control.strip_uns_pro <= data(24);
      end if;
      
      if udp_core_settings_decoded.filter_control.strip_uns_eth = '1' then
         udp_core_settings.filter_control.strip_uns_eth <= data(25);
      end if;
      
      if udp_core_settings_decoded.filter_control.chk_ip_length = '1' then
         udp_core_settings.filter_control.chk_ip_length <= data(26);
      end if;
      
      if udp_core_settings_decoded.ifg = '1' then
         udp_core_settings.ifg <= data(15 downto 0);
      end if;
      
      if udp_core_settings_decoded.control.fixed_pkt_size = '1' then
         udp_core_settings.control.fixed_pkt_size <= data(3);
      end if;
      
      if udp_core_settings_decoded.control.udp_checksum_zero = '1' then
         udp_core_settings.control.udp_checksum_zero <= data(4);
      end if;
      
      if udp_core_settings_decoded.control.farm_mode = '1' then
         udp_core_settings.control.farm_mode <= data(5);
      end if;
      
      if udp_core_settings_decoded.control.tuser_dst_prt = '1' then
         udp_core_settings.control.tuser_dst_prt <= data(6);
      end if;
      
      if udp_core_settings_decoded.control.tuser_src_prt = '1' then
         udp_core_settings.control.tuser_src_prt <= data(7);
      end if;
      
      if udp_core_settings_decoded.control.reset_n = '1' then
         udp_core_settings.control.reset_n <= data(15);
      end if;
      
      if udp_core_settings_decoded.control.udp_length = '1' then
         udp_core_settings.control.udp_length <= data(31 downto 16);
      end if;
      

   end procedure;
   
   function axi4lite_udp_core_settings_read_reg(signal udp_core_settings_decoded: in t_axi4lite_udp_core_settings_decoded;
                                        signal udp_core_settings: t_axi4lite_udp_core_settings) return std_logic_vector is
      variable ret: std_logic_vector(31 downto 0);
   begin
      ret := (others=>'0');
      
      if udp_core_settings_decoded.src_mac_addr_lower = '1' then
         ret(31 downto 0) := udp_core_settings.src_mac_addr_lower;
      end if;
      
      if udp_core_settings_decoded.src_mac_addr_upper = '1' then
         ret(15 downto 0) := udp_core_settings.src_mac_addr_upper;
      end if;
      
      if udp_core_settings_decoded.dst_mac_addr_lower = '1' then
         ret(31 downto 0) := udp_core_settings.dst_mac_addr_lower;
      end if;
      
      if udp_core_settings_decoded.dst_mac_addr_upper = '1' then
         ret(15 downto 0) := udp_core_settings.dst_mac_addr_upper;
      end if;
      
      if udp_core_settings_decoded.ethertype = '1' then
         ret(15 downto 0) := udp_core_settings.ethertype;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_0.ip_ver_hdr_len = '1' then
         ret(7 downto 0) := udp_core_settings.ipv4_header_0.ip_ver_hdr_len;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_0.ip_service = '1' then
         ret(15 downto 8) := udp_core_settings.ipv4_header_0.ip_service;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_0.ip_packet_length = '1' then
         ret(31 downto 16) := udp_core_settings.ipv4_header_0.ip_packet_length;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_1.ip_count = '1' then
         ret(15 downto 0) := udp_core_settings.ipv4_header_1.ip_count;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_1.ip_fragment = '1' then
         ret(31 downto 16) := udp_core_settings.ipv4_header_1.ip_fragment;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_2.ip_ttl = '1' then
         ret(7 downto 0) := udp_core_settings.ipv4_header_2.ip_ttl;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_2.ip_protocol = '1' then
         ret(15 downto 8) := udp_core_settings.ipv4_header_2.ip_protocol;
      end if;
      
      if udp_core_settings_decoded.ipv4_header_2.header_checksum = '1' then
         ret(31 downto 16) := udp_core_settings.ipv4_header_2.header_checksum;
      end if;
      
      if udp_core_settings_decoded.dst_ip_addr = '1' then
         ret(31 downto 0) := udp_core_settings.dst_ip_addr;
      end if;
      
      if udp_core_settings_decoded.src_ip_addr = '1' then
         ret(31 downto 0) := udp_core_settings.src_ip_addr;
      end if;
      
      if udp_core_settings_decoded.udp_ports.src_port = '1' then
         ret(15 downto 0) := udp_core_settings.udp_ports.src_port;
      end if;
      
      if udp_core_settings_decoded.udp_ports.dst_port = '1' then
         ret(31 downto 16) := udp_core_settings.udp_ports.dst_port;
      end if;
      
      if udp_core_settings_decoded.udp_length = '1' then
         ret(15 downto 0) := udp_core_settings.udp_length;
      end if;
      
      if udp_core_settings_decoded.filter_control.broadcast_en = '1' then
         ret(0) := udp_core_settings.filter_control.broadcast_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.arp_en = '1' then
         ret(1) := udp_core_settings.filter_control.arp_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.ping_en = '1' then
         ret(2) := udp_core_settings.filter_control.ping_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.pass_uns_ethtype = '1' then
         ret(8) := udp_core_settings.filter_control.pass_uns_ethtype;
      end if;
      
      if udp_core_settings_decoded.filter_control.pass_uns_ipv4 = '1' then
         ret(9) := udp_core_settings.filter_control.pass_uns_ipv4;
      end if;
      
      if udp_core_settings_decoded.filter_control.dst_mac_chk_en = '1' then
         ret(16) := udp_core_settings.filter_control.dst_mac_chk_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.src_mac_chk_en = '1' then
         ret(17) := udp_core_settings.filter_control.src_mac_chk_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.dst_ip_chk_en = '1' then
         ret(18) := udp_core_settings.filter_control.dst_ip_chk_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.src_ip_chk_en = '1' then
         ret(19) := udp_core_settings.filter_control.src_ip_chk_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.dst_port_chk_en = '1' then
         ret(20) := udp_core_settings.filter_control.dst_port_chk_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.src_port_chk_en = '1' then
         ret(21) := udp_core_settings.filter_control.src_port_chk_en;
      end if;
      
      if udp_core_settings_decoded.filter_control.packet_count_rst_n = '1' then
         ret(22) := udp_core_settings.filter_control.packet_count_rst_n;
      end if;
      
      if udp_core_settings_decoded.filter_control.strip_uns_pro = '1' then
         ret(24) := udp_core_settings.filter_control.strip_uns_pro;
      end if;
      
      if udp_core_settings_decoded.filter_control.strip_uns_eth = '1' then
         ret(25) := udp_core_settings.filter_control.strip_uns_eth;
      end if;
      
      if udp_core_settings_decoded.filter_control.chk_ip_length = '1' then
         ret(26) := udp_core_settings.filter_control.chk_ip_length;
      end if;
      
      if udp_core_settings_decoded.ifg = '1' then
         ret(15 downto 0) := udp_core_settings.ifg;
      end if;
      
      if udp_core_settings_decoded.control.fixed_pkt_size = '1' then
         ret(3) := udp_core_settings.control.fixed_pkt_size;
      end if;
      
      if udp_core_settings_decoded.control.udp_checksum_zero = '1' then
         ret(4) := udp_core_settings.control.udp_checksum_zero;
      end if;
      
      if udp_core_settings_decoded.control.farm_mode = '1' then
         ret(5) := udp_core_settings.control.farm_mode;
      end if;
      
      if udp_core_settings_decoded.control.tuser_dst_prt = '1' then
         ret(6) := udp_core_settings.control.tuser_dst_prt;
      end if;
      
      if udp_core_settings_decoded.control.tuser_src_prt = '1' then
         ret(7) := udp_core_settings.control.tuser_src_prt;
      end if;
      
      if udp_core_settings_decoded.control.reset_n = '1' then
         ret(15) := udp_core_settings.control.reset_n;
      end if;
      
      if udp_core_settings_decoded.control.udp_length = '1' then
         ret(31 downto 16) := udp_core_settings.control.udp_length;
      end if;
      
      if udp_core_settings_decoded.udp_count = '1' then
         ret(31 downto 0) := udp_core_settings.udp_count;
      end if;
      
      if udp_core_settings_decoded.ping_count = '1' then
         ret(31 downto 0) := udp_core_settings.ping_count;
      end if;
      
      if udp_core_settings_decoded.arp_count = '1' then
         ret(31 downto 0) := udp_core_settings.arp_count;
      end if;
      
      if udp_core_settings_decoded.uns_etype_count = '1' then
         ret(31 downto 0) := udp_core_settings.uns_etype_count;
      end if;
      
      if udp_core_settings_decoded.uns_pro_count = '1' then
         ret(31 downto 0) := udp_core_settings.uns_pro_count;
      end if;
      
      if udp_core_settings_decoded.dropped_mac_count = '1' then
         ret(31 downto 0) := udp_core_settings.dropped_mac_count;
      end if;
      
      if udp_core_settings_decoded.dropped_ip_count = '1' then
         ret(31 downto 0) := udp_core_settings.dropped_ip_count;
      end if;
      
      if udp_core_settings_decoded.dropped_port_count = '1' then
         ret(31 downto 0) := udp_core_settings.dropped_port_count;
      end if;
      
      if udp_core_settings_decoded.ip_id = '1' then
         ret(31 downto 0) := udp_core_settings.ip_id;
      end if;
      
      if udp_core_settings_decoded.udp_core_id = '1' then
         ret(31 downto 0) := udp_core_settings.udp_core_id;
      end if;
      

      return ret;
   end function;
   
   function axi4lite_udp_core_settings_demux(addr: std_logic_vector) return std_logic_vector is
      variable ret: std_logic_vector(c_total_nof_blocks-1 downto 0);
   begin
      ret := (others=>'0');
      if c_total_nof_blocks = 1 then
         ret := (others=>'1');
      else

  
      end if;
      return ret;
   end function;

end package body;

