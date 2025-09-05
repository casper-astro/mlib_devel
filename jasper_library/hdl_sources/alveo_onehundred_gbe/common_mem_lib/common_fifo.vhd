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
use common_ox_lib.ox_unsigned_functions_pkg.all;
library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

entity common_fifo is
   generic (
      g_fpga_vendor         : string    ;
      g_fpga_family         : string    ;
      g_implementation      : string    :=  "distributed";
      g_dual_clock          : boolean   :=  false;
      g_fwft                : boolean   :=  true;
      g_wr_dat_width        : integer   :=  64;
      g_wr_adr_width        : integer   :=  4;
      g_rd_dat_width        : integer   :=  64;
      g_rd_latency          : positive  :=  1;
      g_nof_sync_stage      : integer   :=  2;
      g_we_control          : boolean   :=  true;
      g_re_control          : boolean   :=  true;
      g_prog_full_val       : positive  :=  1;
      g_prog_empty_val      : positive  :=  1;
      g_wr_sanity_check     : boolean   :=  true;
      g_rd_sanity_check     : boolean   :=  true;
      g_hold_last_read      : boolean   :=  true;
      g_wr_rst_val          : std_logic :=  '1';
      g_rd_rst_val          : std_logic :=  '1';
      g_partition_width     : integer   :=  0
   );
   port(
      wr_clk      : in std_logic;
      rd_clk      : in std_logic;
      wr_rst      : in std_logic;
      rd_rst      : in std_logic;
      
      we          : in std_logic;
      di          : in std_logic_vector(g_wr_dat_width-1 downto 0);
      full        : out std_logic;
      prog_full   : out std_logic;
            
      re          : in std_logic;
      do          : out std_logic_vector(g_rd_dat_width-1 downto 0);
      do_vld      : out std_logic;
      empty       : out std_logic;
      prog_empty  : out std_logic;
      
      casc_wr_adr : out std_logic_vector(g_wr_adr_width-1 downto 0);
      casc_rd_adr : out std_logic_vector(rd_adr_width_calc(g_wr_dat_width,g_wr_adr_width,g_rd_dat_width)-1 downto 0);
      casc_we     : out std_logic;
      casc_re     : out std_logic;
      
      wstatus     : out std_logic_vector(g_wr_adr_width downto 0);
      rstatus     : out std_logic_vector(rd_adr_width_calc(g_wr_dat_width,g_wr_adr_width,g_rd_dat_width) downto 0)
    );
end entity;

architecture common_fifo_a of common_fifo is

   constant c_rd_adr_width: integer := rd_adr_width_calc(g_wr_dat_width,g_wr_adr_width,g_rd_dat_width);
   
   signal ram_rd_en     : std_logic;
   signal ram_wr_en     : std_logic;
   signal ram_wr_adr    : std_logic_vector(g_wr_adr_width-1 downto 0);
   signal ram_rd_adr    : std_logic_vector(c_rd_adr_width-1 downto 0);
   signal ram_wr_dat    : std_logic_vector(g_wr_dat_width-1 downto 0); 
   signal ram_rd_dat    : std_logic_vector(g_rd_dat_width-1 downto 0); 

   signal wptr          : std_logic_vector(g_wr_adr_width downto 0);
   signal wptr_pp       : std_logic_vector(g_wr_adr_width downto 0);
   signal wptr_pp_c     : std_logic_vector(g_wr_adr_width downto 0);
   signal we_controlled : std_logic;
   signal full_c        : std_logic;
   signal full_r        : std_logic;
   signal prog_full_c   : std_logic;
   signal prog_full_r   : std_logic;
   
   signal rptr          : std_logic_vector(c_rd_adr_width downto 0);
   signal rptr_pp       : std_logic_vector(c_rd_adr_width downto 0);
   signal rptr_pp_c     : std_logic_vector(c_rd_adr_width downto 0);
   signal re_controlled : std_logic;
   signal empty_c       : std_logic;
   signal empty_r       : std_logic;
   signal prog_empty_c  : std_logic;
   signal prog_empty_r  : std_logic;
   signal re_shreg      : std_logic_vector(g_rd_latency downto 0);
   
begin
   ----------------------------------------------------------------------------
   -- simple dual-port RAM                                                   --
   ----------------------------------------------------------------------------
   common_ram_sdp_inst: entity common_mem_lib.common_ram_sdp
   generic map(
      g_wr_dat_width    => g_wr_dat_width,
      g_wr_adr_width    => g_wr_adr_width,
      g_rd_dat_width    => g_rd_dat_width,
      g_rd_latency      => g_rd_latency,
      g_fpga_vendor     => g_fpga_vendor,
      g_fpga_family     => g_fpga_family,
      g_implementation  => g_implementation,
      g_partition_width => g_partition_width
   )
   port map(
      wr_clk  => wr_clk,
      rd_clk  => rd_clk,
      rd_en   => ram_rd_en, 
      wr_en   => ram_wr_en, 
      wr_adr  => ram_wr_adr,
      rd_adr  => ram_rd_adr,
      wr_dat  => ram_wr_dat,
      rd_dat  => ram_rd_dat
   );
   ----------------------------------------------------------------------------
   -- flags generation                                                       --
   ----------------------------------------------------------------------------   
   common_fifo_flag_inst: entity common_mem_lib.common_fifo_flag
   generic map (
      g_dual_clock     => g_dual_clock,
      g_nof_sync_stage => g_nof_sync_stage,
      g_wr_width       => g_wr_adr_width+1,
      g_rd_width       => c_rd_adr_width+1,
      g_prog_empty_val => g_prog_empty_val,
      g_prog_full_val  => g_prog_full_val,
      g_wr_rst_val     => g_wr_rst_val,
      g_rd_rst_val     => g_rd_rst_val  
   )
   port map (
      rd_clk       => rd_clk,
      wr_clk       => wr_clk,
      rd_rst       => rd_rst,
      wr_rst       => wr_rst,
      we           => we_controlled,
      wadd         => wptr,
      wadd_pp      => wptr_pp,
      re           => re_controlled,
      radd         => rptr,
      radd_pp      => rptr_pp,
      empty_c      => empty_c,
      full_c       => full_c,
      prog_empty_c => prog_empty_c,
      prog_full_c  => prog_full_c,
      wstatus      => wstatus,
      rstatus      => rstatus
   );
   ----------------------------------------------------------------------------
   -- write pointer, write-side flags register                               --
   ----------------------------------------------------------------------------
   process(wr_clk,wr_rst)
   begin
      if rising_edge(wr_clk) then
         if we_controlled = '1' then
            wptr <= wptr_pp;
            wptr_pp <= wptr_pp_c;
         end if;
         full_r <= full_c;
         prog_full_r <= prog_full_c;
      end if;
      if wr_rst = g_wr_rst_val then
         wptr <= (others=>'0');
         wptr_pp <= (0=>'1',others=>'0');
         full_r <= '0';
         prog_full_r <= '0';
      end if;
   end process;
   ----------------------------------------------------------------------------
   -- read pointer, read-side flags register                                 --
   ----------------------------------------------------------------------------   
   process(rd_clk,rd_rst)
   begin
      if rising_edge(rd_clk) then
         if re_controlled = '1' then
            rptr <= rptr_pp;
            rptr_pp <= rptr_pp_c;
         end if;
         empty_r <= empty_c;
         prog_empty_r <= prog_empty_c;
      end if;
      if rd_rst = g_rd_rst_val then
         rptr <= (others=>'0');
         rptr_pp <= (0=>'1',others=>'0');
         empty_r <= '1';
         prog_empty_r <= '1';
      end if;
   end process;
   ----------------------------------------------------------------------------
   -- read enable shift register for read valid generation                   --
   ----------------------------------------------------------------------------   
   re_pipe_inst: entity common_ox_lib.ox_bit_pipe
   generic map (
      g_rst_active_val => g_rd_rst_val,
      g_nof_stage => g_rd_latency)
   port map (
      clk => rd_clk,
      rst => rd_rst,
      di  => re_controlled,
      do  => re_shreg
   );

   wptr_pp_c <= wptr_pp + 1;
   rptr_pp_c <= rptr_pp + 1;
   
   we_controlled <= we and not full_r  when g_we_control = true else we;
   re_controlled <= re and not empty_r when g_re_control = true else re;
   
   ram_wr_en   <= we_controlled;
   ram_wr_adr  <= ox_resize(wptr,g_wr_adr_width);   
   ram_wr_dat  <= di;

   fwft_f_gen: if g_fwft = false generate
      ram_rd_en  <= re_controlled;-- when g_rd_latency = 1 else re_controlled or re_shreg(1); 
		ram_rd_adr <= ox_resize(rptr,c_rd_adr_width);
      do_vld <= re_shreg(g_rd_latency);
	end generate;
	fwft_t_gen: if g_fwft = true generate 
		ram_rd_en  <= '1';--not(empty_c);
		ram_rd_adr <= ox_resize(rptr_pp,c_rd_adr_width) when re_controlled = '1' and empty_r = '0' else 
                    ox_resize(rptr,c_rd_adr_width);
      do_vld <= re_shreg(g_rd_latency-1);
	end generate;
   
   full <= full_r;
   prog_full <= prog_full_r;
   empty <= empty_r;
   prog_empty <= prog_empty_r;
   
   do <= (others => '0') when (empty_r = '1' and g_hold_last_read = false) else ram_rd_dat;
   
   casc_wr_adr <= ram_wr_adr;  
   casc_rd_adr <= ram_rd_adr;
   casc_we     <= ram_wr_en;
   casc_re     <= ram_rd_en;     
   
   wr_sanity_check_gen: if g_wr_sanity_check = true generate
      process
      begin
         wait until rising_edge(wr_clk);
         assert not (full_r = '1' and we = '1')
         report "common_fifo.vhd | " & common_fifo'path_name & " : write enable asserted while fifo is full!"
         severity warning;
      end process;
   end generate;
      
   rd_sanity_check_gen: if g_rd_sanity_check = true generate   
      process
      begin
         wait until rising_edge(rd_clk);
         assert not (empty_r = '1' and re = '1')
         report "common_fifo.vhd | " & common_fifo'path_name & " : read enable asserted while fifo is empty!"
         severity warning;
      end process;
   end generate;
   
end architecture;
