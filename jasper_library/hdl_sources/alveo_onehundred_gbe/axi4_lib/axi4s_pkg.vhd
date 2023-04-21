--<h---------------------------------------------------------------------------
--
-- Copyright (C) 2015
-- University of Oxford <http://www.ox.ac.uk/>
-- Department of Physics
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-----------------------------------------------------------------------------h>
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library common_ox_lib;
use common_ox_lib.ox_functions_pkg.all;

package axi4s_pkg is
   
   constant c_axi4s_max_tdata_nof_bytes: integer := 16*4*2;
   constant c_axi4s_max_tid_width      : integer := 32;
   constant c_axi4s_max_tuser_width    : integer := 32;
   
   type t_axi4s_mosi is record
      tdata       : std_logic_vector(c_axi4s_max_tdata_nof_bytes*8-1 downto 0);
      tid         : std_logic_vector(c_axi4s_max_tid_width-1 downto 0);
      tuser       : std_logic_vector(c_axi4s_max_tuser_width-1 downto 0);
      tkeep       : std_logic_vector(c_axi4s_max_tdata_nof_bytes-1 downto 0);
      tlast       : std_logic;
      tvalid      : std_logic;
   end record;
   
   type t_axi4s_miso is record   
      tready      : std_logic;
      prog_full   : std_logic;
   end record;
   
   type t_axi4s_mosi_arr is array (natural range<>) of t_axi4s_mosi;
   type t_axi4s_miso_arr is array (natural range<>) of t_axi4s_miso;
   
   constant c_axi4s_mosi_default: t_axi4s_mosi := (tdata  => (others=>'0'), 
                                                   tid    => (others=>'0'),  
                                                   tuser  => (others=>'0'),  
                                                   tkeep  => (others=>'0'),  
                                                   tlast  => '0',  
                                                   tvalid => '0');
                                                   
                                                   
   constant c_axi4s_miso_default: t_axi4s_miso := (tready    => '1', 
                                                   prog_full => '0');
                                                   

   type t_axi4s_descr is record
      tdata_nof_bytes : positive;
      tid_width       : positive;
      tuser_width     : positive;
      has_tlast       : integer range 0 to 1;
      has_tkeep       : integer range 0 to 1;
      has_tid         : integer range 0 to 1;
      has_tuser       : integer range 0 to 1;
   end record;
   
   type t_axi4s_descr_arr is array (natural range<>) of t_axi4s_descr;
   
   function endianess_swap(input: t_axi4s_mosi; descr: t_axi4s_descr; enable: boolean) return t_axi4s_mosi;
   
   function data_pack_descr_arr_calc(nof_bytes: integer; has_tkeep: integer) return t_pack_descr_arr;
   
   procedure axi4s_mosi_pack_to_record(tdata              : in std_logic_vector(c_axi4s_max_tdata_nof_bytes*8-1 downto 0);
                                       tid                : in std_logic_vector(c_axi4s_max_tid_width-1 downto 0);
                                       tuser              : in std_logic_vector(c_axi4s_max_tuser_width-1 downto 0);
                                       tkeep              : in std_logic_vector(c_axi4s_max_tdata_nof_bytes-1 downto 0);
                                       tlast              : in std_logic;
                                       tvalid             : in std_logic;
                                       signal axi4s_mosi  : out t_axi4s_mosi);
                            
   procedure axi4s_mosi_unpack_to_signals(signal tdata       : out std_logic_vector(c_axi4s_max_tdata_nof_bytes*8-1 downto 0);
                                          signal tid         : out std_logic_vector(c_axi4s_max_tid_width-1 downto 0);
                                          signal tuser       : out std_logic_vector(c_axi4s_max_tuser_width-1 downto 0);
                                          signal tkeep       : out std_logic_vector(c_axi4s_max_tdata_nof_bytes-1 downto 0);
                                          signal tlast       : out std_logic;
                                          signal tvalid      : out std_logic;
                                          axi4s_mosi         : in t_axi4s_mosi);

   procedure axi4s_miso_pack_to_record(tready             : in std_logic;                              
                                       prog_full          : in std_logic;
                                       signal axi4s_miso  : out t_axi4s_miso);
                             
   procedure axi4s_miso_unpack_to_signals(signal tready    : out std_logic;                              
                                          signal prog_full : out std_logic;
                                          axi4s_miso       : in t_axi4s_miso);
                               
   function axi4s_mosi_full_slv_pack_length_calc(constant axi4s_descr: t_axi4s_descr) return integer;
   function axi4s_mosi_data_slv_pack_length_calc(constant axi4s_descr: t_axi4s_descr) return integer;
   function axi4s_mosi_ctrl_slv_pack_length_calc(constant axi4s_descr: t_axi4s_descr) return integer;
   
   procedure axi4s_mosi_full_pack_to_slv(constant axi4s_descr  : t_axi4s_descr;
                                         axi4s_mosi            : in t_axi4s_mosi;
                                         signal axi4s_packed   : out std_logic_vector);
   procedure axi4s_mosi_data_pack_to_slv(constant axi4s_descr  : t_axi4s_descr;
                                         axi4s_mosi            : in t_axi4s_mosi;
                                         signal axi4s_packed   : out std_logic_vector);
   procedure axi4s_mosi_ctrl_pack_to_slv(constant axi4s_descr  : t_axi4s_descr;
                                         axi4s_mosi            : in t_axi4s_mosi;
                                         signal axi4s_packed   : out std_logic_vector);
   
   procedure axi4s_mosi_full_unpack_to_record(constant axi4s_descr  : t_axi4s_descr;
                                              axi4s_packed          : in std_logic_vector;
                                              signal axi4s_mosi     : out t_axi4s_mosi);
   procedure axi4s_mosi_data_unpack_to_signals(constant axi4s_descr : t_axi4s_descr;
                                               axi4s_packed         : in std_logic_vector;
                                               signal axi4s_tdata   : out std_logic_vector;
                                               signal axi4s_tkeep   : out std_logic_vector);
   procedure axi4s_mosi_ctrl_unpack_to_signals(constant axi4s_descr : t_axi4s_descr;
                                               axi4s_packed         : in std_logic_vector;
                                               signal axi4s_tuser   : out std_logic_vector;
                                               signal axi4s_tid     : out std_logic_vector;
                                               signal axi4s_tlast   : out std_logic);
end package;

package body axi4s_pkg is

   function endianess_swap(input: t_axi4s_mosi; descr: t_axi4s_descr; enable: boolean) return t_axi4s_mosi is
      variable ret: t_axi4s_mosi;
   begin
      ret := input;
      if enable = true then
         for n in 0 to descr.tdata_nof_bytes-1 loop
            ret.tdata(8*(n+1)-1 downto 8*n) := input.tdata(8*((descr.tdata_nof_bytes-1)-n+1)-1 downto 8*((descr.tdata_nof_bytes-1)-n));
         end loop;
      end if;
      return ret;
   end function;

   function data_pack_descr_arr_calc(nof_bytes: integer; has_tkeep: integer) return t_pack_descr_arr is
      variable pack_data_descr_arr: t_pack_descr_arr(0 to 2*nof_bytes-1);
   begin
      for n in 0 to nof_bytes-1 loop
         pack_data_descr_arr(2*n)   := (8,1);
         pack_data_descr_arr(2*n+1) := (1,has_tkeep);
      end loop;
      return pack_data_descr_arr;
   end function;


   procedure axi4s_mosi_pack_to_record(tdata              : in std_logic_vector(c_axi4s_max_tdata_nof_bytes*8-1 downto 0);
                                       tid                : in std_logic_vector(c_axi4s_max_tid_width-1 downto 0);
                                       tuser              : in std_logic_vector(c_axi4s_max_tuser_width-1 downto 0);
                                       tkeep              : in std_logic_vector(c_axi4s_max_tdata_nof_bytes-1 downto 0);
                                       tlast              : in std_logic;
                                       tvalid             : in std_logic;
                                       signal axi4s_mosi  : out t_axi4s_mosi) is
   begin
      axi4s_mosi.tdata  <= tdata;  
      axi4s_mosi.tid    <= tid;   
      axi4s_mosi.tuser  <= tuser; 
      axi4s_mosi.tkeep  <= tkeep; 
      axi4s_mosi.tlast  <= tlast; 
      axi4s_mosi.tvalid <= tvalid;
   end procedure;
                            
   procedure axi4s_mosi_unpack_to_signals(signal tdata  : out std_logic_vector(c_axi4s_max_tdata_nof_bytes*8-1 downto 0);
                                          signal tid    : out std_logic_vector(c_axi4s_max_tid_width-1 downto 0);
                                          signal tuser  : out std_logic_vector(c_axi4s_max_tuser_width-1 downto 0);
                                          signal tkeep  : out std_logic_vector(c_axi4s_max_tdata_nof_bytes-1 downto 0);
                                          signal tlast  : out std_logic;
                                          signal tvalid : out std_logic;
                                          axi4s_mosi    : in t_axi4s_mosi) is
   begin
      tdata  <= ox_resize(axi4s_mosi.tdata, tdata'length);   
      tid    <= ox_resize(axi4s_mosi.tid,   tid'length);     
      tuser  <= ox_resize(axi4s_mosi.tuser, tuser'length);   
      tkeep  <= ox_resize(axi4s_mosi.tkeep, tkeep'length);   
      tlast  <= axi4s_mosi.tlast;   
      tvalid <= axi4s_mosi.tvalid;  
   end procedure;

   procedure axi4s_miso_pack_to_record(tready             : in std_logic;                              
                                       prog_full          : in std_logic;
                                       signal axi4s_miso  : out t_axi4s_miso) is
   begin
      axi4s_miso.tready    <= tready;   
      axi4s_miso.prog_full <= prog_full;
   end procedure;
                             
   procedure axi4s_miso_unpack_to_signals(signal tready    : out std_logic;                              
                                          signal prog_full : out std_logic;
                                          axi4s_miso       : in t_axi4s_miso) is
   begin
      tready    <= axi4s_miso.tready;   
      prog_full <= axi4s_miso.prog_full;
   end procedure;   
   
   function axi4s_mosi_full_slv_pack_length_calc(constant axi4s_descr: t_axi4s_descr) return integer is
      variable ret: integer := 0;
   begin
      ret := axi4s_descr.tdata_nof_bytes*8;
      if axi4s_descr.has_tkeep = 1 then
         ret := ret + axi4s_descr.tdata_nof_bytes;
      end if;
      if axi4s_descr.has_tid = 1 then
         ret := ret + axi4s_descr.tid_width;
      end if;
      if axi4s_descr.has_tuser = 1 then
         ret := ret + axi4s_descr.tuser_width;
      end if;
      if axi4s_descr.has_tlast = 1 then
         ret := ret + axi4s_descr.has_tlast;
      end if;
      return ret;
   end function;
   
   function axi4s_mosi_data_slv_pack_length_calc(constant axi4s_descr: t_axi4s_descr) return integer is 
      variable ret: integer := 0;
   begin
      ret := axi4s_descr.tdata_nof_bytes*8;
      if axi4s_descr.has_tkeep = 1 then
         ret := ret + axi4s_descr.tdata_nof_bytes;
      end if;
      return ret;
   end function;  

   function axi4s_mosi_ctrl_slv_pack_length_calc(constant axi4s_descr: t_axi4s_descr) return integer is
      variable ret: integer := 0;
   begin
      if axi4s_descr.has_tid = 1 then
         ret := ret + axi4s_descr.tid_width;
      end if;
      if axi4s_descr.has_tuser = 1 then
         ret := ret + axi4s_descr.tuser_width;
      end if;
      if axi4s_descr.has_tlast = 1 then
         ret := ret + axi4s_descr.has_tlast;
      end if;
      return ret;
   end function;   
   
   procedure axi4s_mosi_full_pack_to_slv(constant axi4s_descr   : t_axi4s_descr;
                                         axi4s_mosi             : in t_axi4s_mosi;
                                         signal axi4s_packed    : out std_logic_vector) is
      --define pack descriptor array
      constant c_pack_descr_arr: t_pack_descr_arr(0 to 4) := ((axi4s_descr.tdata_nof_bytes*8, 1),                       --tdata
                                                              (axi4s_descr.tdata_nof_bytes  , axi4s_descr.has_tkeep),   --tkeep
                                                              (axi4s_descr.tid_width        , axi4s_descr.has_tid),     --tid
                                                              (axi4s_descr.tuser_width      , axi4s_descr.has_tuser),   --tuser
                                                              (1                            , axi4s_descr.has_tlast)    --tlast
                                                              );
   begin
      axi4s_packed <= ox_pack(axi4s_mosi.tlast &
                              axi4s_mosi.tuser &
                              axi4s_mosi.tid &
                              axi4s_mosi.tkeep &
                              axi4s_mosi.tdata , c_pack_descr_arr);
   end procedure;
   
   
   procedure axi4s_mosi_data_pack_to_slv(constant axi4s_descr  : t_axi4s_descr;
                                         axi4s_mosi            : in t_axi4s_mosi;
                                         signal axi4s_packed   : out std_logic_vector) is
   begin
      for n in 0 to axi4s_descr.tdata_nof_bytes-1 loop
         if axi4s_descr.has_tkeep = 1 then
            axi4s_packed((8+1)*(n+1)-1 downto (8+1)*n) <= axi4s_mosi.tkeep(n) & axi4s_mosi.tdata(8*(n+1)-1 downto 8*n);
         else
            axi4s_packed(8*(n+1)-1 downto 8*n) <= axi4s_mosi.tdata(8*(n+1)-1 downto 8*n);
         end if;
      end loop;
   end procedure;

   procedure axi4s_mosi_ctrl_pack_to_slv(constant axi4s_descr  : t_axi4s_descr;
                                         axi4s_mosi            : in t_axi4s_mosi;
                                         signal axi4s_packed   : out std_logic_vector) is
      -- --define pack descriptor array
      constant c_pack_descr_arr: t_pack_descr_arr(0 to 2) := ((axi4s_descr.tid_width        , axi4s_descr.has_tid),     --tid
                                                              (axi4s_descr.tuser_width      , axi4s_descr.has_tuser),   --tuser
                                                              (1                            , axi4s_descr.has_tlast)    --tlast
                                                              );      
   begin
      axi4s_packed <= ox_pack(axi4s_mosi.tlast &
                              axi4s_mosi.tuser(axi4s_descr.tuser_width-1 downto 0) &
                              axi4s_mosi.tid(axi4s_descr.tid_width-1 downto 0), c_pack_descr_arr);
   end procedure;
   
   procedure axi4s_mosi_full_unpack_to_record(constant axi4s_descr  : t_axi4s_descr;
                                              axi4s_packed          : in std_logic_vector;
                                              signal axi4s_mosi     : out t_axi4s_mosi) is
      constant c_pack_descr_arr: t_pack_descr_arr(0 to 4) := ((axi4s_descr.tdata_nof_bytes*8, 1),                       --tdata
                                                              (axi4s_descr.tdata_nof_bytes  , axi4s_descr.has_tkeep),   --tkeep
                                                              (axi4s_descr.tid_width        , axi4s_descr.has_tid),     --tid
                                                              (axi4s_descr.tuser_width      , axi4s_descr.has_tuser),   --tuser
                                                              (1                            , axi4s_descr.has_tlast)    --tlast
                                                              );
   begin
      axi4s_mosi.tdata <= ox_resize(ox_unpack(axi4s_packed,c_pack_descr_arr,0),c_axi4s_max_tdata_nof_bytes*8);
      axi4s_mosi.tkeep <= ox_resize(ox_unpack(axi4s_packed,c_pack_descr_arr,1),c_axi4s_max_tdata_nof_bytes);
      axi4s_mosi.tid   <= ox_resize(ox_unpack(axi4s_packed,c_pack_descr_arr,2),c_axi4s_max_tid_width);
      axi4s_mosi.tuser <= ox_resize(ox_unpack(axi4s_packed,c_pack_descr_arr,3),c_axi4s_max_tuser_width);
      axi4s_mosi.tlast <= ox_unpack(axi4s_packed,c_pack_descr_arr,4)(0);
   end procedure;
                                              
                                              
   procedure axi4s_mosi_data_unpack_to_signals(constant axi4s_descr : t_axi4s_descr;
                                               axi4s_packed         : in std_logic_vector;
                                               signal axi4s_tdata   : out std_logic_vector;
                                               signal axi4s_tkeep   : out std_logic_vector) is
      constant c_pack_descr_arr: t_pack_descr_arr(0 to 2*axi4s_descr.tdata_nof_bytes-1) := data_pack_descr_arr_calc(axi4s_descr.tdata_nof_bytes,axi4s_descr.has_tkeep);

   begin
      for n in 0 to axi4s_descr.tdata_nof_bytes-1 loop 
         axi4s_tdata(8*(n+1)-1 downto 8*n) <= ox_unpack(axi4s_packed,c_pack_descr_arr,2*n);
         axi4s_tkeep(n) <= ox_unpack(axi4s_packed,c_pack_descr_arr,2*n+1)(0);
      end loop;
   end procedure;
   
   procedure axi4s_mosi_ctrl_unpack_to_signals(constant axi4s_descr : t_axi4s_descr;
                                               axi4s_packed         : in std_logic_vector;
                                               signal axi4s_tuser   : out std_logic_vector;
                                               signal axi4s_tid     : out std_logic_vector;
                                               signal axi4s_tlast   : out std_logic) is
      constant c_pack_descr_arr: t_pack_descr_arr(0 to 2) := ((axi4s_descr.tid_width        , axi4s_descr.has_tid),     --tid
                                                              (axi4s_descr.tuser_width      , axi4s_descr.has_tuser),   --tuser
                                                              (1                            , axi4s_descr.has_tlast)    --tlast
                                                              );
   begin
      axi4s_tid   <= ox_resize(ox_unpack(axi4s_packed,c_pack_descr_arr,0),c_axi4s_max_tid_width);
      axi4s_tuser <= ox_resize(ox_unpack(axi4s_packed,c_pack_descr_arr,1),c_axi4s_max_tuser_width);
      axi4s_tlast <= ox_unpack(axi4s_packed,c_pack_descr_arr,2)(0);
   end procedure;                                

end package body;

