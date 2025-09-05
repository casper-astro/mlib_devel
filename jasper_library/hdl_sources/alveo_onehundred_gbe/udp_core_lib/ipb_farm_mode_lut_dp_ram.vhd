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
use std.textio.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;
     
entity ipb_farm_mode_lut_dp_ram is
   generic(
      ram_add_width     : integer := 4;
      ram_dat_width     : integer := 32;
      ipb_read          : boolean := true;
      ipb_write         : boolean := true;
      ipb_read_latency  : integer range 1 to 2 := 1;
      user_read_latency : integer range 1 to 2 := 1;
      init_file         : string := "";
      init_file_format  : string := "hex"
   );
   port(
      ipb_clk   : in std_logic; 
      ipb_miso  : out t_ipb_miso;
      ipb_mosi  : in t_ipb_mosi;
      
      user_clk  : in std_logic:='0';
      user_we   : in std_logic:='0';
      user_en   : in std_logic:='0';
      user_add  : in std_logic_vector(ram_add_width-1 downto 0):=(others=>'0');
      user_wdat : in std_logic_vector(ram_dat_width-1 downto 0):=(others=>'0');
      user_rdat : out std_logic_vector(ram_dat_width-1 downto 0)
   );
end entity;     

architecture behav of ipb_farm_mode_lut_dp_ram is 

   type t_ram is array (0 to 2**ram_add_width-1) of std_logic_vector(ram_dat_width-1 downto 0);
   
   function bin2slv(input: string) return std_logic_vector is
      variable input_i: string(1 to input'length):=input;
      variable ret: std_logic_vector(input'length-1 downto 0);
      variable char: character;
   begin
      for n in 0 to input_i'length-1 loop
         char := input_i(input_i'length - n);
         if char = '0' then
            ret(n) := '0'; 
         elsif char = '1' then
            ret(n) := '1'; 
         else
            report ipb_farm_mode_lut_dp_ram'path_name & "Unexpected character '" & input_i(n) & "'"
            severity failure;
         end if;
      end loop;
      return ret;
   end function;
   
   function hex2slv(input: string) return std_logic_vector is
      variable input_i: string(1 to input'length):=input;
      variable slv4: std_logic_vector(3 downto 0);
      variable ret: std_logic_vector(input'length*4-1 downto 0);
      variable char: character;
   begin
      for n in 0 to input_i'length-1 loop
         char := input_i(input_i'length - n);
         case char is
            when '0' => slv4 :=  x"0";
            when '1' => slv4 :=  x"1";
            when '2' => slv4 :=  x"2";
            when '3' => slv4 :=  x"3";
            when '4' => slv4 :=  x"4";
            when '5' => slv4 :=  x"5";
            when '6' => slv4 :=  x"6";
            when '7' => slv4 :=  x"7";
            when '8' => slv4 :=  x"8";
            when '9' => slv4 :=  x"9";
            when 'A' => slv4 :=  x"A";
            when 'B' => slv4 :=  x"B";
            when 'C' => slv4 :=  x"C";
            when 'D' => slv4 :=  x"D";
            when 'E' => slv4 :=  x"E";
            when 'F' => slv4 :=  x"F";
            when 'a' => slv4 :=  x"A";
            when 'b' => slv4 :=  x"B";
            when 'c' => slv4 :=  x"C";
            when 'd' => slv4 :=  x"D";
            when 'e' => slv4 :=  x"E";
            when 'f' => slv4 :=  x"F";
            when others =>
               report ipb_farm_mode_lut_dp_ram'path_name & "Unexpected character '" & input_i(n) & "'"
               severity failure;
         end case;
         ret(4*(n+1)-1 downto 4*n) := slv4; 
      end loop;
      return ret;
   end function;
   
   impure function init_ram_from_file(init_file : in string; init_file_format: string) return t_ram is
      file ramfile: text;
      variable line_good: boolean;
      variable ramfileline: line;
      variable ram_init: t_ram := (others=>(others=>'0'));
      variable bin_str: string(1 to ram_dat_width);
      variable hex_str: string(1 to ram_dat_width/4);
      variable idx: integer;
      variable status: file_open_status;
      variable conv_val: std_logic_vector(ram_dat_width-1 downto 0);
      variable char: character;
   begin
      if init_file = "" then
         return ram_init;
      end if;
      file_open(status,ramfile,init_file);
      if status = open_ok then
         report "Init file " & init_file 
         --pragma translate_off
         & " of instance " & ipb_farm_mode_lut_dp_ram'path_name         --Vivado 2014.2 not supported attribute
         --pragma translate_on
         & " found!"
         severity warning;
         ram_init_loop: for i in t_ram'range loop
            if not endfile(ramfile) then
               
               bin_str := (others=>'0');
               hex_str := (others=>'0');
               readline(ramfile, ramfileline);        
               if init_file_format = "bin" then
                  read(ramfileline,bin_str);
                  conv_val := bin2slv(bin_str);
               else
                  read(ramfileline,hex_str);
                  conv_val := hex2slv(hex_str);
               end if;
               
               ram_init(i) := conv_val(ram_dat_width-1 downto 0);
            else
               report "Init file " & init_file 
               --pragma translate_off
               & " of instance " & ipb_farm_mode_lut_dp_ram'path_name  --Vivado 2014.2 not supported attribute
               --pragma translate_on
               & " doesn't initialize all memory locations!"
               severity warning;
               exit ram_init_loop;
            end if;
         end loop; 
         if not endfile(ramfile) then
            report "Init file " & init_file 
            --pragma translate_off
            & " of instance " & ipb_farm_mode_lut_dp_ram'path_name         --Vivado 2014.2 not supported attribute
            --pragma translate_on
            & " is larger than instantiated memory!"
            severity failure;
         end if;
      else
         report "Init file " & init_file 
         --pragma translate_off
         & " of instance " & ipb_farm_mode_lut_dp_ram'path_name         --Vivado 2014.2 not supported attribute
         --pragma translate_on
         & " not found! BRAM initialized to 0!"
         severity warning;
      end if;
      return ram_init;
   end function;

   type t_dat_arr is array (0 to 1) of std_logic_vector(ram_dat_width-1 downto 0);
   shared variable ram: t_ram := init_ram_from_file(init_file,init_file_format);

   signal ipb_ram_add: std_logic_vector(ram_add_width-1 downto 0);
   signal ipb_ram_dat: t_dat_arr;
   signal ipb_rack_s: std_logic_vector(1 downto 0);
   
   signal user_ram_add: std_logic_vector(ram_add_width-1 downto 0);
   signal user_ram_dat: t_dat_arr;
   
begin

   process(ipb_clk)
   begin
      if rising_edge(ipb_clk) then
         ipb_ram_dat(0) <= ram(to_integer(unsigned(ipb_ram_add)));
         if ipb_mosi.wreq = '1' and ipb_write = true then
            ram(to_integer(unsigned(ipb_ram_add))) := ipb_mosi.wdat;
         end if;
         ipb_ram_dat(1) <= ipb_ram_dat(0); 
         ipb_rack_s(0) <= ipb_mosi.rreq;
         ipb_rack_s(1) <= ipb_rack_s(0);     
      end if;
   end process;
   
   ipb_ram_add <= ipb_mosi.addr(ram_add_width+2-1 downto 0+2);
   ipb_miso.wack <= '1';
   ipb_miso.rack <= ipb_rack_s(ipb_read_latency-1);
   ipb_read_t_gen: if ipb_read = true generate
      ipb_miso.rdat <= ipb_ram_dat(ipb_read_latency-1);
   end generate;
   ipb_read_f_gen: if ipb_read = false generate
      ipb_miso.rdat <= (others=>'-');
   end generate;

   process(user_clk)
   begin
      if rising_edge(user_clk) then
         if user_en = '1' then
            user_ram_dat(0) <= ram(to_integer(unsigned(user_ram_add)));
            if user_we = '1' then
               ram(to_integer(unsigned(user_ram_add))) := user_wdat;
            end if;
         end if;
         user_ram_dat(1) <= user_ram_dat(0);
      end if;
   end process;
   
   user_ram_add <= user_add;
   user_rdat <= user_ram_dat(user_read_latency-1);
   
end architecture;

