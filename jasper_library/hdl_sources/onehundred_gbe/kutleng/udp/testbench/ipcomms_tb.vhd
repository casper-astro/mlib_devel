--------------------------------------------------------------------------------
-- Legal & Copyright:   (c) 2018 Kutleng Engineering Technologies (Pty) Ltd    - 
--                                                                             -
-- This program is the proprietary software of Kutleng Engineering Technologies-
-- and/or its licensors, and may only be used, duplicated, modified or         -
-- distributed pursuant to the terms and conditions of a separate, written     -
-- license agreement executed between you and Kutleng (an "Authorized License")-
-- Except as set forth in an Authorized License, Kutleng grants no license     -
-- (express or implied), right to use, or waiver of any kind with respect to   -
-- the Software, and Kutleng expressly reserves all rights in and to the       -
-- Software and all intellectual property rights therein.  IF YOU HAVE NO      -
-- AUTHORIZED LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, -
-- AND SHOULD IMMEDIATELY NOTIFY KUTLENG AND DISCONTINUE ALL USE OF THE        -
-- SOFTWARE.                                                                   -
--                                                                             -
-- Except as expressly set forth in the Authorized License,                    -
--                                                                             -
-- 1.     This program, including its structure, sequence and organization,    -
-- constitutes the valuable trade secrets of Kutleng, and you shall use all    -
-- reasonable efforts to protect the confidentiality thereof,and to use this   -
-- information only in connection with South African Radio Astronomy           -
-- Observatory (SARAO) products.                                               -
--                                                                             -
-- 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED     -
-- "AS IS" AND WITH ALL FAULTS AND KUTLENG MAKES NO PROMISES, REPRESENTATIONS  -
-- OR WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH       -
-- RESPECT TO THE SOFTWARE.  KUTLENG SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED-
-- WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A        -
-- PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS, QUIET        -
-- ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE-
-- ENJOYMENT, QUIET POSSESSION USE OR PERFORMANCE OF THE SOFTWARE.             -
--                                                                             -
-- 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL KUTLENG OR -
-- ITS LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT-
-- , OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO  -
-- YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF KUTLENG HAS BEEN       -
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF -
-- THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR ZAR R1, WHICHEVER IS    -
-- GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF       -
-- ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.                                    -
-- --------------------------------------------------------------------------- -
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS                    -
-- PART OF THIS FILE AT ALL TIMES.                                             -
--=============================================================================-
-- Company          : Kutleng Dynamic Electronics Systems (Pty) Ltd            -
-- Engineer         : Benjamin Hector Hlophe                                   -
--                                                                             -
-- Design Name      : CASPER BSP                                               -
-- Module Name      : ipcomms_tb - rtl                                         -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to test the ipcomms module.          -
--                    TODO                                                     -
--                    This also needs hardware test,which have been done using -
--                    a software based UDP/IP client application to supply test-
--                    data of varying length.                                  -
--                                                                             -
-- Dependencies     : ipcomms                                                  -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ipcomms_tb is
end entity ipcomms_tb;

architecture behavorial of ipcomms_tb is
    component ipcomms is
        generic(
            G_DATA_WIDTH      : natural                          := 512;
            G_UDP_SERVER_PORT : natural range 0 to ((2**16) - 1) := 5;
            G_PR_SERVER_PORT  : natural range 0 to ((2**16) - 1) := 5;
            G_EMAC_ADDR       : std_logic_vector(47 downto 0)    := X"000A_3502_4194";
            G_IP_ADDR         : std_logic_vector(31 downto 0)    := X"C0A8_0A0A" --192.168.10.10
        );
        port(
            axis_clk       : in  STD_LOGIC;
            axis_reset     : in  STD_LOGIC;
            --Outputs to AXIS bus MAC side 
            axis_tx_tdata  : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            axis_tx_tvalid : out STD_LOGIC;
            axis_tx_tready : in  STD_LOGIC;
            axis_tx_tkeep  : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
            axis_tx_tlast  : out STD_LOGIC;
            axis_tx_tuser  : out STD_LOGIC;
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata  : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            axis_rx_tvalid : in  STD_LOGIC;
            axis_rx_tuser  : in  STD_LOGIC;
            axis_rx_tkeep  : in  STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
            axis_rx_tlast  : in  STD_LOGIC
        );
    end component ipcomms;

    constant C_DATA_WIDTH      : natural                                           := 512;
    --	constant C_EMAC_ADDR  : std_logic_vector(47 downto 0) := X"00_01_00_01_00_06";
    --	constant C_IP_ADDR    : std_logic_vector(31 downto 0) := X"C0_A8_01_FF"; --192.168.1.255
    constant C_EMAC_ADDR       : std_logic_vector(47 downto 0)                     := X"00_0A_35_02_41_92";
    constant C_IP_ADDR         : std_logic_vector(31 downto 0)                     := X"C0_A8_0A_0A"; --192.168.10.10
    constant C_UDP_SERVER_PORT : natural range 0 to ((2**16) - 1)                  := 10000;
    constant C_PR_SERVER_PORT  : natural range 0 to ((2**16) - 1)                  := 8083;
    signal axis_clk            : STD_LOGIC                                         := '1';
    signal axis_reset          : STD_LOGIC                                         := '1';
    signal axis_tx_tready      : STD_LOGIC                                         := '0';
    signal axis_tx_tdata       : STD_LOGIC_VECTOR(C_DATA_WIDTH - 1 downto 0);
    signal axis_tx_tvalid      : STD_LOGIC;
    signal axis_tx_tkeep       : STD_LOGIC_VECTOR((C_DATA_WIDTH / 8) - 1 downto 0);
    signal axis_tx_tlast       : STD_LOGIC;
    signal axis_tx_tuser       : STD_LOGIC;
    signal axis_rx_tdata       : STD_LOGIC_VECTOR(C_DATA_WIDTH - 1 downto 0)       := (others => '0');
    signal axis_rx_tvalid      : STD_LOGIC                                         := '0';
    signal axis_rx_tuser       : STD_LOGIC                                         := '0';
    signal axis_rx_tkeep       : STD_LOGIC_VECTOR((C_DATA_WIDTH / 8) - 1 downto 0) := (others => '0');
    signal axis_rx_tlast       : STD_LOGIC                                         := '0';
    constant C_CLK_PERIOD      : time                                              := 10 ns;
begin
    axis_clk   <= not axis_clk after C_CLK_PERIOD / 2;
    axis_reset <= '1', '0' after C_CLK_PERIOD * 20;

    UUT_i : ipcomms
        generic map(
            G_DATA_WIDTH      => C_DATA_WIDTH,
            G_UDP_SERVER_PORT => C_UDP_SERVER_PORT,
            G_PR_SERVER_PORT  => C_PR_SERVER_PORT,
            G_EMAC_ADDR       => C_EMAC_ADDR,
            G_IP_ADDR         => C_IP_ADDR
        )
        port map(
            axis_clk       => axis_clk,
            axis_reset     => axis_reset,
            axis_tx_tdata  => axis_tx_tdata,
            axis_tx_tvalid => axis_tx_tvalid,
            axis_tx_tready => axis_tx_tready,
            axis_tx_tkeep  => axis_tx_tkeep,
            axis_tx_tlast  => axis_tx_tlast,
            axis_tx_tuser  => axis_tx_tuser,
            axis_rx_tdata  => axis_rx_tdata,
            axis_rx_tvalid => axis_rx_tvalid,
            axis_rx_tuser  => axis_rx_tuser,
            axis_rx_tkeep  => axis_rx_tkeep,
            axis_rx_tlast  => axis_rx_tlast
        );

    StimProc : process
    begin
        wait for C_CLK_PERIOD * 40;
        axis_tx_tready <= '1';
        --------------------------------------------------------------------------------
        -- Send a 65 byte packet from WireShark
        -- Internet Protocol Version 4, Src: 192.168.1.77, Dst: 192.168.1.255
        -- User Datagram Protocol, Src Port: 54792, Dst Port: 8083
        -- Data (21 bytes)
        -- Data: 52454c4152454c41595f524553504f4e4452454c41
        -- [Length: 21]
        --------------------------------------------------------------------------------
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= X"000000000000000000000000000000000000000000000000000000000000001e000000000000001e000000000000001e00000000000000002e7f777000000000";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000000000000000";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= X"000000000000000000000000000000000000000000000000114000404b90620000450008c6de9c9a114000404b90620000450008c6de9c9a0dec924102350a00";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000000000000000";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"2120212021202120212021202120212021202120212019034e001027ddda0a0aa8c0690aa8c07c14114000404b90620000450008c6de9c9a0dec924102350a00";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= X"00000000000000000000000000000000000000000000000021202120212021202120212021202120212021202120212021202120212021202120212021202120";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000000000000000";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"000000000000001e00000000be05536b212021202120212021202120212021202120212021202120212021202120212021202120212021202120212021202120";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000ffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000_0000_0000_0000_0000_00000000_00000000_0000_00_00_0000_0000_0000_00_00_0000_0000_000000000000_000000000000";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000000000000000";
        wait for C_CLK_PERIOD * 10;
        axis_tx_tready <= '1';
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00414c4552444e4f505345525f59414c4552414c4552_8c2f_1d00_931f_08d6_ff01a8c0_4d01a8c0_c857_11_80_0000_575e_3100_00_45_0008_574022d9bed4_060001000100";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000_0000_0000_0000_0000_00000000_00000000_0000_00_00_0000_0000_0000_00_00_0000_0000_000000000000_000000000000";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000000000000000";
        wait for C_CLK_PERIOD * 10;
        axis_tx_tready <= '1';
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00414c4552444e4f505345525f59414c4552414c4552_8c2f_1d00_931f_08d6_ff01a8c0_4d01a8c0_c857_11_80_0000_575e_3100_00_45_0008_574022d9bed4_060001000100";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"4101144000000000000000000000000000000000_0000_0000_0000_0000_00000000_00000000_0000_00_00_0000_0000_0000_00_00_0000_0000_000000000000_000000000041";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00003333ffff0000000000000000000000000000_0000_0000_0000_0000_00000000_00000000_0000_00_00_0000_0000_0000_00_00_0000_0000_000000000000_000000000041";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"3fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000_0000_0000_0000_0000_00000000_00000000_0000_00_00_0000_0000_0000_00_00_0000_0000_000000000000_000000000000";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000000000000000";

        wait for C_CLK_PERIOD * 40;
        axis_tx_tready <= '1';
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"90fdf0d5000000000000000000000000000000000000_0a0aa8c0_000000000000_960aa8c0_c6de9c9a0dec_0100_04_06_0008_0100_0608_c6de9c9a0dec_ffffffffffff";
        --expectaxis_tx_tdata <= X"00000000000000000000000000000000000000000000_960AA8C0_C6DE9C9A0DEC_0A0AA8C0_924102350A00_0200_04_06_0008_0100_0608_924102350A00C6DE9C9A0DEC";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= (others => '0');
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= (others => '0');
        wait for C_CLK_PERIOD * 10;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"91fdf0d5000000000000000000000000000000000000_0a0aa8c0_000000000000_960aa8c0_c6de9c9a0dec_0100_04_06_0008_0100_0608_c6de9c9a0dec_ffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"92fdf0d5000000000000000000000000000000000000_0a0aa8c0_000000000000_960aa8c0_c6de9c9a0dec_0100_04_06_0008_0100_0608_c6de9c9a0dec_ffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= (others => '0');
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= (others => '0');
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"93fdf0d5000000000000000000000000000000000000_0a0aa8c0_000000000000_960aa8c0_c6de9c9a0dec_0100_04_06_0008_0100_0608_c6de9c9a0dec_ffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= (others => '0');
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= (others => '0');
        wait for C_CLK_PERIOD * 10;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"94fdf0d5000000000000000000000000000000000000_0a0aa8c0_000000000000_960aa8c0_c6de9c9a0dec_0100_04_06_0008_0100_0608_c6de9c9a0dec_ffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"95fdf0d5000000000000000000000000000000000000_0a0aa8c0_000000000000_960aa8c0_c6de9c9a0dec_0100_04_06_0008_0100_0608_c6de9c9a0dec_ffffffffffff";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0fffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '0';
        axis_rx_tdata  <= (others => '0');
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= (others => '0');
        wait for C_CLK_PERIOD;

        wait;
    end process StimProc;

end architecture behavorial;
