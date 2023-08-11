------------------------------------------------------------------------------
--! @file udp_axi4s_pipe.vhd
--! @page udpaxi4spipepage UDP Axi4s Pipe
--!
--! \includedoc esdg_stfc_image.md
--!
--! A pipeline for Axi4s Records used in the UDP Core. the first mode pipelines
--! tready upstream, requiring an extra word register per stage but reducing
--! timing requirements on tready. The second mode ignores tready altogether.
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library axi4_lib;
use axi4_lib.axi4s_pkg.all;

entity udp_axi4s_pipe is
    generic(
        G_STAGES       : integer := 1;      --! Pipeline stages to generate
        G_BACKPRESSURE : boolean := true    --! Whether downstream tready signals can be ignored
    );
    port(
        axi_clk      : in  std_logic;       --! Clk
        axi_rst_n    : in  std_logic;       --! Active Low Synchronous Reset
        axi4s_s_mosi : in  t_axi4s_mosi;    --! Input Axi4s
        axi4s_s_miso : out t_axi4s_miso;    --! Input Backpressure
        axi4s_m_mosi : out t_axi4s_mosi;    --! Output Axi4s
        axi4s_m_miso : in  t_axi4s_miso     --! Output Backpressure
    );
end entity;

architecture rtl of udp_axi4s_pipe is

    signal axi4s_reg_mosi : t_axi4s_mosi_arr(G_STAGES downto 0);
    signal axi4s_reg_miso : t_axi4s_miso_arr(G_STAGES downto 0);

begin
    axi4s_m_mosi      <= axi4s_reg_mosi(0);
    axi4s_reg_miso(0) <= axi4s_m_miso;

    axi4s_reg_mosi(G_STAGES) <= axi4s_s_mosi;
    axi4s_s_miso             <= axi4s_reg_miso(G_STAGES);

    gen_backpressure : if G_BACKPRESSURE generate
        signal axi4s_stored_mosi : t_axi4s_mosi_arr(G_STAGES - 1 downto 0);
        signal stored            : std_logic_vector(G_STAGES - 1 downto 0);
        signal valid_transfer    : std_logic_vector(G_STAGES - 1 downto 0);
    begin

        gen_stages : for i in G_STAGES - 1 downto 0 generate
            valid_transfer(i) <= axi4s_reg_mosi(i + 1).tvalid and axi4s_reg_miso(i + 1).tready;

            process(axi_clk)
            begin
                if rising_edge(axi_clk) then
                    if axi_rst_n = '0' then
                        axi4s_reg_miso(i + 1).tready <= '1';
                        axi4s_reg_mosi(i).tvalid     <= '0';
                        stored(i)                    <= '0';
                    else

                        --Ready Logic (can be reduced to axi4s_reg_miso(i+1).tready <= axi4s_reg_miso(i).tready;)
                        if stored(i) = '0' and axi4s_reg_miso(i).tready = '1' then
                            axi4s_reg_miso(i + 1).tready <= '1';
                        elsif stored(i) = '0' and axi4s_reg_miso(i).tready = '0' then
                            axi4s_reg_miso(i + 1).tready <= '0';
                        elsif stored(i) = '1' and axi4s_reg_miso(i).tready = '0' then
                            axi4s_reg_miso(i + 1).tready <= '0';
                        elsif stored(i) = '1' and axi4s_reg_miso(i).tready = '1' then
                            axi4s_reg_miso(i + 1).tready <= '1';
                        end if;

                        --Data Logic
                        if valid_transfer(i) = '1' and axi4s_reg_miso(i).tready = '1' then
                            -- Normal Operation, move data downstream
                            axi4s_reg_mosi(i) <= axi4s_reg_mosi(i + 1);
                        elsif valid_transfer(i) = '1' and axi4s_reg_miso(i).tready = '0' then
                            -- Downstread tready is deasserted, Upstream needs cycle to respond
                            stored(i)            <= '1';                    --1 Keep Older Data In Normal Reg, No valid transfer this cycle as tready = '0'
                            axi4s_stored_mosi(i) <= axi4s_reg_mosi(i + 1);  --2 Newer Data Goes In Stored Reg
                        elsif stored(i) = '1' and axi4s_reg_miso(i).tready = '1' then
                            -- Downstream tready is Asserted, Empty So Stored Reg
                            stored(i)         <= '0';                       --1 Older data in Normal Reg has a valid tranfer this cycle
                            axi4s_reg_mosi(i) <= axi4s_stored_mosi(i);      --2 Newer data from Stored Reg replaces older data in Normal Reg
                                                                            --3 No upstream data will be lost as its not valid this cycle due to upstream tready = '0'
                        elsif stored(i) = '0' and valid_transfer(i) = '0' and axi4s_reg_miso(i).tready = '1' then
                            --Data read and no new data, deassert valid
                            axi4s_reg_mosi(i).tvalid <= '0';
                        end if;

                    end if;
                end if;
            end process;
        end generate;
    end generate;

    gen_no_backpressure : if not G_BACKPRESSURE generate
    begin
        gen_stages : for i in G_STAGES - 1 downto 0 generate
            process(axi_clk)
            begin
                if rising_edge(axi_clk) then
                    if axi_rst_n = '0' then
                        axi4s_reg_miso(i + 1).tready <= '1';
                        axi4s_reg_mosi(i).tvalid     <= '0';
                    else
                        axi4s_reg_miso(i + 1).tready <= '1';
                        if axi4s_reg_mosi(i + 1).tvalid = '1' then
                            axi4s_reg_mosi(i) <= axi4s_reg_mosi(i + 1);
                        else
                            axi4s_reg_mosi(i).tvalid <= '0';
                        end if;
                    end if;
                end if;
            end process;
        end generate;
    end generate;

end architecture;
