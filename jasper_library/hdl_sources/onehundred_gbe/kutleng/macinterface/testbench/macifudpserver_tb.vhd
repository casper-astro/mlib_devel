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
-- Module Name      : macifudpsender_tb - rtl                                  -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to test the macifudpsender module.   -
--                                                                             -
-- Dependencies     : macifudpserver                                           -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity macifudpsender_tb is
end entity macifudpsender_tb;

architecture behavorial of macifudpsender_tb is
    component macifudpserver is
        generic(
            G_SLOT_WIDTH      : natural                          := 4;
            G_UDP_SERVER_PORT : natural range 0 to ((2**16) - 1) := 5;
            -- The address width is log2(2048/(512/8))=5 bits wide
            G_ADDR_WIDTH      : natural                          := 5
        );
        port(
            axis_clk                       : in  STD_LOGIC;
            axis_reset                     : in  STD_LOGIC;
            -- Setup information
            ServerMACAddress               : in  STD_LOGIC_VECTOR(47 downto 0);
            ServerIPAddress                : in  STD_LOGIC_VECTOR(31 downto 0);
            -- Packet Readout in addressed bus format
            RecvRingBufferSlotID           : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            RecvRingBufferSlotClear        : in  STD_LOGIC;
            RecvRingBufferSlotStatus       : out STD_LOGIC;
            RecvRingBufferSlotTypeStatus   : out STD_LOGIC;
            RecvRingBufferSlotsFilled      : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            RecvRingBufferDataRead         : in  STD_LOGIC;
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            RecvRingBufferDataEnable       : out STD_LOGIC_VECTOR(63 downto 0);
            RecvRingBufferDataOut          : out STD_LOGIC_VECTOR(511 downto 0);
            RecvRingBufferAddress          : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            -- Packet Readout in addressed bus format
            SenderRingBufferSlotID         : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            SenderRingBufferSlotClear      : out STD_LOGIC;
            SenderRingBufferSlotStatus     : in  STD_LOGIC;
            SenderRingBufferSlotTypeStatus : in  STD_LOGIC;
            SenderRingBufferSlotsFilled    : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            SenderRingBufferDataRead       : out STD_LOGIC;
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            SenderRingBufferDataEnable     : in  STD_LOGIC_VECTOR(63 downto 0);
            SenderRingBufferDataIn         : in  STD_LOGIC_VECTOR(511 downto 0);
            SenderRingBufferAddress        : out STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            --Inputs from AXIS bus of the MAC side
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority              : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            axis_tx_tdata                  : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tx_tvalid                 : out STD_LOGIC;
            axis_tx_tready                 : in  STD_LOGIC;
            axis_tx_tkeep                  : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tx_tlast                  : out STD_LOGIC;
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata                  : in  STD_LOGIC_VECTOR(511 downto 0);
            axis_rx_tvalid                 : in  STD_LOGIC;
            axis_rx_tuser                  : in  STD_LOGIC;
            axis_rx_tkeep                  : in  STD_LOGIC_VECTOR(63 downto 0);
            axis_rx_tlast                  : in  STD_LOGIC
        );
    end component macifudpserver;

    signal axis_clk                 : STD_LOGIC                      := '1';
    signal axis_reset               : STD_LOGIC                      := '1';
    constant C_SERVER_MAC_ADDRESS   : STD_LOGIC_VECTOR(47 downto 0)  := X"00_01_00_01_00_06";
    constant C_SERVER_IP_ADDRESS    : STD_LOGIC_VECTOR(31 downto 0)  := X"C0_A8_01_FF";
    constant C_SLOT_WIDTH           : natural                        := 4;
    constant C_UDP_SERVER_PORT      : natural                        := 8083;
    constant C_ADDR_WIDTH           : natural                        := 5;
    signal RingBufferSlotID         : STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
    signal RingBufferSlotClear      : STD_LOGIC;
    signal RingBufferSlotStatus     : STD_LOGIC;
    signal RingBufferSlotTypeStatus : STD_LOGIC;
    signal RingBufferSlotsFilled    : STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
    signal RingBufferDataRead       : STD_LOGIC;
    signal RingBufferDataEnable     : STD_LOGIC_VECTOR(63 downto 0);
    signal RingBufferData           : STD_LOGIC_VECTOR(511 downto 0);
    signal RingBufferAddress        : STD_LOGIC_VECTOR(C_ADDR_WIDTH - 1 downto 0);
    --Inputs from AXIS bus 
    signal axis_rx_tdata            : STD_LOGIC_VECTOR(511 downto 0) := (others => '0');
    signal axis_rx_tvalid           : STD_LOGIC                      := '0';
    signal axis_rx_tuser            : STD_LOGIC                      := '0';
    signal axis_rx_tkeep            : STD_LOGIC_VECTOR(63 downto 0)  := (others => '0');
    signal axis_rx_tlast            : STD_LOGIC                      := '0';
    --Outputs to AXIS bus 
    signal axis_tx_tpriority        : STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
    signal axis_tx_tdata            : STD_LOGIC_VECTOR(511 downto 0);
    signal axis_tx_tvalid           : STD_LOGIC;
    signal axis_tx_tready           : STD_LOGIC                      := '0';
    signal axis_tx_tkeep            : STD_LOGIC_VECTOR(63 downto 0);
    signal axis_tx_tlast            : STD_LOGIC;
    constant C_CLK_PERIOD           : time                           := 10 ns;
begin
    axis_clk   <= not axis_clk after C_CLK_PERIOD / 2;
    axis_reset <= '1', '0' after C_CLK_PERIOD * 20;

    UUT_i : macifudpserver
        generic map(
            G_SLOT_WIDTH      => C_SLOT_WIDTH,
            G_UDP_SERVER_PORT => C_UDP_SERVER_PORT,
            G_ADDR_WIDTH      => C_ADDR_WIDTH
        )
        port map(
            axis_clk                       => axis_clk,
            axis_reset                     => axis_reset,
            ServerMACAddress               => C_SERVER_MAC_ADDRESS,
            ServerIPAddress                => C_SERVER_IP_ADDRESS,
            RecvRingBufferSlotID           => RingBufferSlotID,
            RecvRingBufferSlotClear        => RingBufferSlotClear,
            RecvRingBufferSlotStatus       => RingBufferSlotStatus,
            RecvRingBufferSlotTypeStatus   => RingBufferSlotTypeStatus,
            RecvRingBufferSlotsFilled      => RingBufferSlotsFilled,
            RecvRingBufferDataRead         => RingBufferDataRead,
            RecvRingBufferDataEnable       => RingBufferDataEnable,
            RecvRingBufferDataOut          => RingBufferData,
            RecvRingBufferAddress          => RingBufferAddress,
            SenderRingBufferSlotID         => RingBufferSlotID,
            SenderRingBufferSlotClear      => RingBufferSlotClear,
            SenderRingBufferSlotStatus     => RingBufferSlotStatus,
            SenderRingBufferSlotTypeStatus => RingBufferSlotTypeStatus,
            SenderRingBufferSlotsFilled    => RingBufferSlotsFilled,
            SenderRingBufferDataRead       => RingBufferDataRead,
            SenderRingBufferDataEnable     => RingBufferDataEnable,
            SenderRingBufferDataIn         => RingBufferData,
            SenderRingBufferAddress        => RingBufferAddress,
            axis_tx_tpriority              => axis_tx_tpriority,
            axis_tx_tdata                  => axis_tx_tdata,
            axis_tx_tvalid                 => axis_tx_tvalid,
            axis_tx_tready                 => axis_tx_tready,
            axis_tx_tkeep                  => axis_tx_tkeep,
            axis_tx_tlast                  => axis_tx_tlast,
            axis_rx_tdata                  => axis_rx_tdata,
            axis_rx_tvalid                 => axis_rx_tvalid,
            axis_rx_tuser                  => axis_rx_tuser,
            axis_rx_tkeep                  => axis_rx_tkeep,
            axis_rx_tlast                  => axis_rx_tlast
        );

    StimProc : process
    begin
        wait for C_CLK_PERIOD * 40;
        --------------------------------------------------------------------------------
        -- Send a 65 byte packet from WireShark
        -- Internet Protocol Version 4, Src: 192.168.1.77, Dst: 192.168.1.255
        -- User Datagram Protocol, Src Port: 54792, Dst Port: 8083
        -- Data (21 bytes)
        -- Data: 52454c4152454c41595f524553504f4e4452454c41
        -- [Length: 21]
        --------------------------------------------------------------------------------
        axis_tx_tready <= '1';
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"00414c4552444e4f505345525f59414c4552414c4552_8c2f_1d00_931f_08d6_ff01a8c0_4d01a8c0_c857_11_80_0000_575e_3100_00_45_0008_574022d9bed4_060001000100";
        axis_rx_tlast  <= '0';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"ffffffffffffffff";
        wait for C_CLK_PERIOD;
        axis_rx_tvalid <= '1';
        axis_rx_tdata  <= X"0000000000000000000000000000000000000000_0000_0000_0000_0000_00000000_00000000_0000_00_00_0000_0000_0000_00_00_0000_0000_000000000000_000000000041";
        axis_rx_tlast  <= '1';
        axis_rx_tuser  <= '0';
        axis_rx_tkeep  <= X"0000000000000001";
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

        wait;
    end process StimProc;

end architecture behavorial;
