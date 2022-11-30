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
library axi4_lib;
use axi4_lib.axi4s_pkg.all;

entity axi4s_fifo is
    generic (
        g_fpga_vendor             : string  := "xilinx";
        g_fpga_family             : string  := "all";
        g_implementation          : string  := "distributed";
        g_dual_clock              : boolean := true;
        g_wr_adr_width            : integer := 5;
        g_prog_full_val           : positive:= 20;
        g_sanity_check            : boolean := true;
        g_in_endianess_swap       : boolean := false;
        g_out_endianess_swap      : boolean := false;

        g_axi4s_descr             : t_axi4s_descr := (tdata_nof_bytes => 4,
                                                  tid_width       => 32,
                                                  tuser_width     => 32,
                                                  has_tlast       => 1,
                                                  has_tkeep       => 1,
                                                  has_tid         => 0,
                                                  has_tuser       => 0);
        g_in_tdata_nof_bytes      : integer := 2;
        g_out_tdata_nof_bytes     : integer := 4;
        g_bram_partition_width    : integer := 0;
        g_hold_last_read          : boolean := true;
        g_full_packet             : boolean := false;
        g_packet_fifo_wr_adr_width: integer := 4
    );
    port(
        s_axi_clk               : in std_logic;
        s_axi_rst_n             : in std_logic;
               
        m_axi_clk               : in std_logic;
        m_axi_rst_n             : in std_logic;

        axi4s_s_mosi            : in t_axi4s_mosi;
        axi4s_s_miso            : out t_axi4s_miso;

        axi4s_m_mosi            : out t_axi4s_mosi;
        axi4s_m_miso            : in t_axi4s_miso
        );
end entity;

architecture axi4s_fifo_a of axi4s_fifo is

    constant c_axi4s_in_descr           : t_axi4s_descr := (tdata_nof_bytes => g_in_tdata_nof_bytes,
                                                           tid_width       => g_axi4s_descr.tid_width,
                                                           tuser_width     => g_axi4s_descr.tuser_width,
                                                           has_tlast       => g_axi4s_descr.has_tlast,
                                                           has_tkeep       => g_axi4s_descr.has_tkeep,
                                                           has_tid         => g_axi4s_descr.has_tid,
                                                           has_tuser       => g_axi4s_descr.has_tuser);
    constant c_axi4s_out_descr          : t_axi4s_descr := (tdata_nof_bytes => g_out_tdata_nof_bytes,
                                                           tid_width       => g_axi4s_descr.tid_width,
                                                           tuser_width     => g_axi4s_descr.tuser_width,
                                                           has_tlast       => g_axi4s_descr.has_tlast,
                                                           has_tkeep       => g_axi4s_descr.has_tkeep,
                                                           has_tid         => g_axi4s_descr.has_tid,
                                                           has_tuser       => g_axi4s_descr.has_tuser);

    constant c_full_pack_width          : integer := axi4s_mosi_full_slv_pack_length_calc(c_axi4s_in_descr);
    constant c_data_in_pack_width       : integer := axi4s_mosi_data_slv_pack_length_calc(c_axi4s_in_descr);
    constant c_data_out_pack_width      : integer := axi4s_mosi_data_slv_pack_length_calc(c_axi4s_out_descr);
    constant c_ctrl_pack_width          : integer := axi4s_mosi_ctrl_slv_pack_length_calc(c_axi4s_in_descr);

    signal axi4s_s_mosi_swap       : t_axi4s_mosi;
    signal axi4s_m_mosi_swap       : t_axi4s_mosi;

    signal fifo_we          : std_logic;
    signal fifo_full        : std_logic;
    signal fifo_prog_full   : std_logic;
    signal fifo_re          : std_logic;
    signal fifo_empty       : std_logic;

    signal data_di: std_logic_vector(c_data_in_pack_width-1 downto 0);
    signal data_do: std_logic_vector(c_data_out_pack_width-1 downto 0);
    signal ctrl_di: std_logic_vector(ox_max(1,c_ctrl_pack_width)-1 downto 0);
    signal ctrl_do: std_logic_vector(ox_max(1,c_ctrl_pack_width)-1 downto 0);

    signal packet_cnt_fifo_we    : std_logic;
    signal packet_cnt_fifo_re    : std_logic;
    signal packet_cnt_fifo_empty : std_logic;
    signal packet_cnt_fifo_full  : std_logic;
   
begin

    axi4s_s_mosi_swap <= endianess_swap(axi4s_s_mosi,c_axi4s_in_descr,g_in_endianess_swap);

    axi4s_mosi_data_pack_to_slv(axi4s_descr   => c_axi4s_in_descr,
                                axi4s_mosi    => axi4s_s_mosi_swap,
                                axi4s_packed  => data_di); 
                               
    axi4s_mosi_ctrl_pack_to_slv(axi4s_descr   => c_axi4s_in_descr,
                                axi4s_mosi    => axi4s_s_mosi_swap,
                                axi4s_packed  => ctrl_di); 
                               
    axi4s_mosi_data_unpack_to_signals(axi4s_descr   => c_axi4s_out_descr,
                                      axi4s_packed  => data_do,
                                      axi4s_tdata   => axi4s_m_mosi_swap.tdata,
                                      axi4s_tkeep   => axi4s_m_mosi_swap.tkeep);

    axi4s_mosi_ctrl_unpack_to_signals(axi4s_descr   => c_axi4s_out_descr,
                                      axi4s_packed  => ctrl_do,
                                      axi4s_tid     => axi4s_m_mosi_swap.tid,
                                      axi4s_tuser   => axi4s_m_mosi_swap.tuser,
                                      axi4s_tlast   => axi4s_m_mosi_swap.tlast);  

    axi4s_m_mosi_swap.tvalid <= not fifo_empty when g_full_packet = false else not packet_cnt_fifo_empty;
    axi4s_m_mosi <= endianess_swap(axi4s_m_mosi_swap,c_axi4s_out_descr,g_out_endianess_swap);
      
    axi4s_s_miso.tready <=  not fifo_full when g_full_packet = false else not fifo_full or not packet_cnt_fifo_full;
    axi4s_s_miso.prog_full <= fifo_prog_full;                                     

    fifo_we <= axi4s_s_mosi_swap.tvalid;
    fifo_re <= axi4s_m_mosi_swap.tvalid and axi4s_m_miso.tready;
               
    g_full_packet_t: if g_full_packet = true generate
        packet_cnt_fifo_inst: entity common_mem_lib.common_fifo
        generic map (
            g_fpga_vendor    => g_fpga_vendor,
            g_fpga_family    => g_fpga_family,
            g_implementation => g_implementation,
            g_dual_clock     => g_dual_clock,
            g_fwft           => false,
            g_wr_dat_width   => 1,
            g_wr_adr_width   => g_wr_adr_width,
            g_rd_dat_width   => 1,
            g_rd_latency     => 1,
            g_nof_sync_stage => 2,
            g_prog_full_val  => 1,
            g_prog_empty_val => 2,
            g_wr_sanity_check=> g_sanity_check,
            g_rd_sanity_check=> g_sanity_check,
            g_wr_rst_val     => '0',
            g_rd_rst_val     => '0',
            g_partition_width=> 0,
            g_hold_last_read => true
        )
        port map (
            wr_clk     => s_axi_clk,
            rd_clk     => m_axi_clk,
            wr_rst     => s_axi_rst_n,
            rd_rst     => m_axi_rst_n,
            we         => packet_cnt_fifo_we,
            di         => "0",
            full       => packet_cnt_fifo_full,
            prog_full  => open,
            re         => packet_cnt_fifo_re,
            do         => open,
            do_vld     => open,
            empty      => packet_cnt_fifo_empty,
            prog_empty => open,
            casc_we    => open,
            casc_re    => open,
            casc_wr_adr=> open,
            casc_rd_adr=> open,
            wstatus    => open,
            rstatus    => open
        );
        
        packet_cnt_fifo_we <= axi4s_s_mosi.tvalid and axi4s_s_mosi.tlast;
        packet_cnt_fifo_re <= axi4s_m_mosi_swap.tvalid and axi4s_m_mosi_swap.tlast and axi4s_m_miso.tready; 
    end generate;

    same_width_gen: if g_in_tdata_nof_bytes = g_out_tdata_nof_bytes generate      
        signal fifo_di: std_logic_vector(c_ctrl_pack_width+c_data_in_pack_width-1 downto 0);
        signal fifo_do: std_logic_vector(c_ctrl_pack_width+c_data_out_pack_width-1 downto 0);
    begin    
   
        fifo_inst: entity common_mem_lib.common_fifo
        generic map (
            g_fpga_vendor    => g_fpga_vendor,
            g_fpga_family    => g_fpga_family,
            g_implementation => g_implementation,
            g_dual_clock     => g_dual_clock,
            g_fwft           => true,
            g_wr_dat_width   => fifo_di'length,
            g_wr_adr_width   => g_wr_adr_width,
            g_rd_dat_width   => fifo_di'length,
            g_rd_latency     => 1,
            g_nof_sync_stage => 2,
            g_prog_full_val  => g_prog_full_val,
            g_prog_empty_val => 2,
            g_wr_sanity_check=> g_sanity_check,
            g_rd_sanity_check=> g_sanity_check,
            g_wr_rst_val     => '0',
            g_rd_rst_val     => '0',
            g_partition_width=> g_bram_partition_width,
            g_hold_last_read => g_hold_last_read
        )
        port map (
            wr_clk     => s_axi_clk,
            rd_clk     => m_axi_clk,
            wr_rst     => s_axi_rst_n,
            rd_rst     => m_axi_rst_n,
            we         => fifo_we,
            di         => fifo_di,
            full       => fifo_full,
            prog_full  => fifo_prog_full,
            re         => fifo_re,
            do         => fifo_do,
            do_vld     => open,
            empty      => fifo_empty,
            prog_empty => open,
            casc_we    => open,
            casc_re    => open,
            casc_wr_adr=> open,
            casc_rd_adr=> open,
            wstatus    => open,
            rstatus    => open
        );

        ctrl_1_gen: if c_ctrl_pack_width >= 1 generate
            fifo_di <= ctrl_di & data_di;
            data_do <= fifo_do(c_data_out_pack_width-1 downto 0);
            ctrl_do <= fifo_do(c_ctrl_pack_width + c_data_out_pack_width - 1 downto c_data_out_pack_width);
        end generate;
        ctrl_0_gen: if c_ctrl_pack_width < 1 generate
            fifo_di <= data_di;
            data_do <= fifo_do(c_data_out_pack_width-1 downto 0);
        end generate;
        
    end generate;


    slave_data_wider_gen: if g_in_tdata_nof_bytes > g_out_tdata_nof_bytes generate
        constant aspect_ratio: integer := c_data_in_pack_width / c_data_out_pack_width; 
        signal fifo_di: std_logic_vector(c_data_in_pack_width-1 downto 0);
        signal fifo_do: std_logic_vector(c_data_out_pack_width-1 downto 0);
        signal casc_ctrl_we: std_logic;
        signal casc_ctrl_re: std_logic;
        signal casc_ctrl_wr_adr: std_logic_vector(g_wr_adr_width-1 downto 0);
        signal casc_ctrl_rd_adr: std_logic_vector(rd_adr_width_calc(c_data_in_pack_width,g_wr_adr_width,c_data_out_pack_width)-1 downto 0);
        signal casc_ctrl_rd_adr_reg: std_logic_vector(rd_adr_width_calc(c_data_in_pack_width,g_wr_adr_width,c_data_out_pack_width)-1 downto 0);
        signal ctrl_ram_di: std_logic_vector(ox_max(1,c_ctrl_pack_width)-1 downto 0);
        signal ctrl_ram_do: std_logic_vector(ox_max(1,c_ctrl_pack_width)-1 downto 0);
        signal unpacked_tlast: std_logic;
        signal axi4s_mosi_int: t_axi4s_mosi;
    begin
         
        fifo_inst: entity common_mem_lib.common_fifo
        generic map (
            g_fpga_vendor    => g_fpga_vendor,
            g_fpga_family    => g_fpga_family,
            g_implementation => g_implementation,
            g_dual_clock     => g_dual_clock,
            g_fwft           => true,
            g_wr_dat_width   => c_data_in_pack_width,
            g_wr_adr_width   => g_wr_adr_width,
            g_rd_dat_width   => c_data_out_pack_width,
            g_rd_latency     => 1,
            g_nof_sync_stage => 2,
            g_prog_full_val  => g_prog_full_val,
            g_prog_empty_val => 2,
            g_wr_sanity_check=> g_sanity_check,
            g_rd_sanity_check=> g_sanity_check,
            g_wr_rst_val     => '0',
            g_rd_rst_val     => '0',
            g_partition_width=> g_bram_partition_width,
            g_hold_last_read => g_hold_last_read
        )
        port map (
            wr_clk     => s_axi_clk,
            rd_clk     => m_axi_clk,
            wr_rst     => s_axi_rst_n,
            rd_rst     => m_axi_rst_n,
            we         => fifo_we,
            di         => fifo_di,
            full       => fifo_full,
            prog_full  => fifo_prog_full,
            re         => fifo_re,
            do         => fifo_do,
            do_vld     => open,
            empty      => fifo_empty,
            prog_empty => open,
            casc_we    => casc_ctrl_we,
            casc_re    => casc_ctrl_re,
            casc_wr_adr=> casc_ctrl_wr_adr,
            casc_rd_adr=> casc_ctrl_rd_adr,
            wstatus    => open,
            rstatus    => open
        );
        
        ctrl_1_gen: if c_ctrl_pack_width >= 1 generate
            ctrl_ram_sdp_inst: entity common_mem_lib.common_ram_sdp
            generic map (
                g_wr_dat_width   => c_ctrl_pack_width,
                g_wr_adr_width   => g_wr_adr_width,
                g_rd_dat_width   => c_ctrl_pack_width,
                g_rd_latency     => 1,
                g_fpga_vendor    => g_fpga_vendor,
                g_fpga_family    => g_fpga_family,
                g_implementation => g_implementation
            )
            port map (
                wr_clk => s_axi_clk,
                rd_clk => m_axi_clk,
                wr_en  => casc_ctrl_we,
                rd_en  => casc_ctrl_re,
                wr_adr => casc_ctrl_wr_adr,
                rd_adr => casc_ctrl_rd_adr(casc_ctrl_rd_adr'length-1 downto ox_log2(aspect_ratio)),
                wr_dat => ctrl_ram_di,
                rd_dat => ctrl_ram_do
            );
        end generate;
        
        ctrl_0_gen: if c_ctrl_pack_width < 1 generate
            ctrl_ram_do <= (others=>'0');
        end generate;

        fifo_di <= data_di;
        ctrl_ram_di <= ctrl_di;
        
        data_do <= fifo_do;
        
        axi4s_mosi_ctrl_unpack_to_signals(axi4s_descr   => c_axi4s_out_descr,
                                              axi4s_packed  => ctrl_ram_do,
                                              axi4s_tid     => axi4s_mosi_int.tid,
                                              axi4s_tuser   => axi4s_mosi_int.tuser,
                                              axi4s_tlast   => unpacked_tlast); 

        axi4s_mosi_int.tlast <= '1' when unpacked_tlast = '1' and 
                                       casc_ctrl_rd_adr_reg(ox_log2(aspect_ratio)-1 downto 0) = 2**ox_log2(aspect_ratio)-1 else '0';

        axi4s_mosi_ctrl_pack_to_slv(axi4s_descr   => c_axi4s_in_descr,
                                    axi4s_mosi    => axi4s_mosi_int,
                                    axi4s_packed  => ctrl_do);
                                      
        process(m_axi_clk)
        begin
            if rising_edge(m_axi_clk) then
                casc_ctrl_rd_adr_reg <= casc_ctrl_rd_adr;
            end if;
        end process;
      
    end generate;
   
   
    master_data_wider_gen: if g_in_tdata_nof_bytes < g_out_tdata_nof_bytes generate
        constant aspect_ratio: integer := c_data_out_pack_width / c_data_in_pack_width; 
        signal fifo_di: std_logic_vector(c_data_in_pack_width-1 downto 0);
        signal fifo_do: std_logic_vector(c_data_out_pack_width-1 downto 0);
        signal casc_ctrl_we: std_logic;
        signal casc_ctrl_re: std_logic;
        signal casc_ctrl_wr_adr: std_logic_vector(g_wr_adr_width-1 downto 0);
        signal casc_ctrl_rd_adr: std_logic_vector(rd_adr_width_calc(c_data_in_pack_width,g_wr_adr_width,c_data_out_pack_width)-1 downto 0);
        signal ctrl_ram_di: std_logic_vector(ox_max(1,c_ctrl_pack_width)-1 downto 0);
        signal ctrl_ram_do: std_logic_vector(ox_max(1,c_ctrl_pack_width)-1 downto 0);
    begin
         
        fifo_inst: entity common_mem_lib.common_fifo
        generic map (
            g_fpga_vendor    => g_fpga_vendor,
            g_fpga_family    => g_fpga_family,
            g_implementation => g_implementation,
            g_dual_clock     => g_dual_clock,
            g_fwft           => true,
            g_wr_dat_width   => c_data_in_pack_width,
            g_wr_adr_width   => g_wr_adr_width,
            g_rd_dat_width   => c_data_out_pack_width,
            g_rd_latency     => 1,
            g_nof_sync_stage => 2,
            g_prog_full_val  => g_prog_full_val,
            g_prog_empty_val => 2,
            g_wr_sanity_check=> g_sanity_check,
            g_rd_sanity_check=> g_sanity_check,
            g_wr_rst_val     => '0',
            g_rd_rst_val     => '0',
            g_partition_width=> g_bram_partition_width,
            g_hold_last_read => g_hold_last_read
        )
        port map (
            wr_clk     => s_axi_clk,
            rd_clk     => m_axi_clk,
            wr_rst     => s_axi_rst_n,
            rd_rst     => m_axi_rst_n,
            we         => fifo_we,
            di         => fifo_di,
            full       => fifo_full,
            prog_full  => fifo_prog_full,
            re         => fifo_re,
            do         => fifo_do,
            do_vld     => open,
            empty      => fifo_empty,
            prog_empty => open,
            casc_we    => casc_ctrl_we,
            casc_re    => casc_ctrl_re,
            casc_wr_adr=> casc_ctrl_wr_adr,
            casc_rd_adr=> casc_ctrl_rd_adr,
            wstatus    => open,
            rstatus    => open
        );

        ctrl_1_gen: if c_ctrl_pack_width >= 1 generate
            ctrl_ram_sdp_inst: entity common_mem_lib.common_ram_sdp
            generic map (
                g_wr_dat_width   => c_ctrl_pack_width,
                g_wr_adr_width   => casc_ctrl_rd_adr'length,
                g_rd_dat_width   => c_ctrl_pack_width,
                g_rd_latency     => 1,
                g_fpga_vendor    => g_fpga_vendor,
                g_fpga_family    => g_fpga_family,
                g_implementation => g_implementation
            )
            port map (
                wr_clk => s_axi_clk,
                rd_clk => m_axi_clk,
                wr_en  => casc_ctrl_we,
                rd_en  => casc_ctrl_re,
                wr_adr => casc_ctrl_wr_adr(casc_ctrl_wr_adr'length-1 downto ox_log2(aspect_ratio)),
                rd_adr => casc_ctrl_rd_adr,
                wr_dat => ctrl_ram_di,
                rd_dat => ctrl_ram_do
            );
        end generate;
        
        ctrl_0_gen: if c_ctrl_pack_width < 1 generate
            ctrl_ram_do <= (others=>'0');
        end generate;
     
        fifo_di <= data_di; 
        ctrl_ram_di <= ctrl_di;

        data_do <= fifo_do;
        ctrl_do <= ctrl_ram_do;
    end generate;

end architecture;
