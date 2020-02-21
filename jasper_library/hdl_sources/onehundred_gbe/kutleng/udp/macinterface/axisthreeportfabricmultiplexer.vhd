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
-- Module Name      : axisthreeportfabricmultiplexer - rtl                     -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This multiplexes three AXIS streams to one.              -
--                                                                             -
-- Dependencies     : axisfabricmultiplexer                                    -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axisthreeportfabricmultiplexer is
    generic(
        G_MAX_PACKET_BLOCKS_SIZE : natural := 64;
        G_PRIORITY_WIDTH         : natural := 4;
        G_DATA_WIDTH             : natural := 8
    );
    port(
        axis_clk            : in  STD_LOGIC;
        axis_reset          : in  STD_LOGIC;
        --Inputs from AXIS bus of the MAC side
        --Outputs to AXIS bus MAC side 
        axis_tx_tdata       : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
        axis_tx_tvalid      : out STD_LOGIC;
        axis_tx_tready      : in  STD_LOGIC;
        axis_tx_tkeep       : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
        axis_tx_tlast       : out STD_LOGIC;
        axis_tx_tuser       : out STD_LOGIC;
        -- Port 1
        axis_rx_tpriority_1 : in  STD_LOGIC_VECTOR(G_PRIORITY_WIDTH - 1 downto 0);
        axis_rx_tdata_1     : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
        axis_rx_tvalid_1    : in  STD_LOGIC;
        axis_rx_tready_1    : out STD_LOGIC;
        axis_rx_tkeep_1     : in  STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
        axis_rx_tlast_1     : in  STD_LOGIC;
        -- Port 2
        axis_rx_tpriority_2 : in  STD_LOGIC_VECTOR(G_PRIORITY_WIDTH - 1 downto 0);
        axis_rx_tdata_2     : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
        axis_rx_tvalid_2    : in  STD_LOGIC;
        axis_rx_tready_2    : out STD_LOGIC;
        axis_rx_tkeep_2     : in  STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
        axis_rx_tlast_2     : in  STD_LOGIC;
        -- Port 3
        axis_rx_tpriority_3 : in  STD_LOGIC_VECTOR(G_PRIORITY_WIDTH - 1 downto 0);
        axis_rx_tdata_3     : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
        axis_rx_tvalid_3    : in  STD_LOGIC;
        axis_rx_tready_3    : out STD_LOGIC;
        axis_rx_tkeep_3     : in  STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
        axis_rx_tlast_3     : in  STD_LOGIC
    );
end entity axisthreeportfabricmultiplexer;

architecture rtl of axisthreeportfabricmultiplexer is
    component axisfabricmultiplexer is
        generic(
            G_MAX_PACKET_BLOCKS_SIZE : natural := 64;
            G_MUX_PORTS              : natural := 7;
            G_PRIORITY_WIDTH         : natural := 4;
            G_DATA_WIDTH             : natural := 8
        );
        port(
            axis_clk          : in  STD_LOGIC;
            axis_reset        : in  STD_LOGIC;
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority : out STD_LOGIC_VECTOR(G_PRIORITY_WIDTH - 1 downto 0);
            axis_tx_tdata     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            axis_tx_tvalid    : out STD_LOGIC;
            axis_tx_tready    : in  STD_LOGIC;
            axis_tx_tkeep     : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
            axis_tx_tlast     : out STD_LOGIC;
            axis_tx_tuser     : out STD_LOGIC;
            --Inputs from AXIS 
            ------------------------------------------------------------------------------------------------------------------------
            -- The priority signal is interpreted as follows                                  
            -- 0-2**(G_PRIORITY_WIDTH-1)
            -- Where 0 is lowest priority which means no packets of data are available to forward on that specific AXIS stream port
            -- 1-2**(G_PRIORITY_WIDTH-1) is the number of packets on the AXIS stream port waiting to be transmitted
            -- The more the number of ports that are waiting to be transmitted the higher the port priority
            ----------------------------------------------------------------------------------------------------------------------
            axis_rx_tpriority : in  STD_LOGIC_VECTOR((G_MUX_PORTS * G_PRIORITY_WIDTH) - 1 downto 0);
            axis_rx_tdata     : in  STD_LOGIC_VECTOR((G_MUX_PORTS * G_DATA_WIDTH) - 1 downto 0);
            axis_rx_tvalid    : in  STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0);
            axis_rx_tready    : out STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0);
            axis_rx_tkeep     : in  STD_LOGIC_VECTOR((G_MUX_PORTS * (G_DATA_WIDTH / 8)) - 1 downto 0);
            axis_rx_tlast     : in  STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0)
        );
    end component axisfabricmultiplexer;
    constant C_MUX_PORTS      : natural := 3;
    signal laxis_rx_tpriority : STD_LOGIC_VECTOR((C_MUX_PORTS * G_PRIORITY_WIDTH) - 1 downto 0);
    signal laxis_rx_tdata     : STD_LOGIC_VECTOR((C_MUX_PORTS * G_DATA_WIDTH) - 1 downto 0);
    signal laxis_rx_tvalid    : STD_LOGIC_VECTOR(C_MUX_PORTS - 1 downto 0);
    signal laxis_rx_tready    : STD_LOGIC_VECTOR(C_MUX_PORTS - 1 downto 0);
    signal laxis_rx_tkeep     : STD_LOGIC_VECTOR((C_MUX_PORTS * (G_DATA_WIDTH / 8)) - 1 downto 0);
    signal laxis_rx_tlast     : STD_LOGIC_VECTOR(C_MUX_PORTS - 1 downto 0);

begin
    laxis_rx_tlast(0)  <= axis_rx_tlast_1;
    laxis_rx_tlast(1)  <= axis_rx_tlast_2;
    laxis_rx_tlast(2)  <= axis_rx_tlast_3;
    laxis_rx_tvalid(0) <= axis_rx_tvalid_1;
    laxis_rx_tvalid(1) <= axis_rx_tvalid_2;
    laxis_rx_tvalid(2) <= axis_rx_tvalid_3;
    axis_rx_tready_1   <= laxis_rx_tready(0);
    axis_rx_tready_2   <= laxis_rx_tready(1);
    axis_rx_tready_3   <= laxis_rx_tready(2);

    laxis_rx_tpriority((1 * G_PRIORITY_WIDTH) - 1 downto G_PRIORITY_WIDTH * (1 - 1)) <= axis_rx_tpriority_1;
    laxis_rx_tpriority((2 * G_PRIORITY_WIDTH) - 1 downto G_PRIORITY_WIDTH * (2 - 1)) <= axis_rx_tpriority_2;
    laxis_rx_tpriority((3 * G_PRIORITY_WIDTH) - 1 downto G_PRIORITY_WIDTH * (3 - 1)) <= axis_rx_tpriority_3;

    laxis_rx_tdata((1 * G_DATA_WIDTH) - 1 downto G_DATA_WIDTH * (1 - 1)) <= axis_rx_tdata_1;
    laxis_rx_tdata((2 * G_DATA_WIDTH) - 1 downto G_DATA_WIDTH * (2 - 1)) <= axis_rx_tdata_2;
    laxis_rx_tdata((3 * G_DATA_WIDTH) - 1 downto G_DATA_WIDTH * (3 - 1)) <= axis_rx_tdata_3;

    laxis_rx_tkeep((1 * (G_DATA_WIDTH / 8)) - 1 downto (G_DATA_WIDTH / 8) * (1 - 1)) <= axis_rx_tkeep_1;
    laxis_rx_tkeep((2 * (G_DATA_WIDTH / 8)) - 1 downto (G_DATA_WIDTH / 8) * (2 - 1)) <= axis_rx_tkeep_2;
    laxis_rx_tkeep((3 * (G_DATA_WIDTH / 8)) - 1 downto (G_DATA_WIDTH / 8) * (3 - 1)) <= axis_rx_tkeep_3;

    AXISMUX_i : axisfabricmultiplexer
        generic map(
            G_MAX_PACKET_BLOCKS_SIZE => G_MAX_PACKET_BLOCKS_SIZE,
            G_MUX_PORTS              => C_MUX_PORTS,
            G_PRIORITY_WIDTH         => G_PRIORITY_WIDTH,
            G_DATA_WIDTH             => G_DATA_WIDTH
        )
        port map(
            axis_clk          => axis_clk,
            axis_reset        => axis_reset,
            axis_tx_tpriority => open,
            axis_tx_tdata     => axis_tx_tdata,
            axis_tx_tvalid    => axis_tx_tvalid,
            axis_tx_tready    => axis_tx_tready,
            axis_tx_tkeep     => axis_tx_tkeep,
            axis_tx_tlast     => axis_tx_tlast,
            axis_tx_tuser     => axis_tx_tuser,
            axis_rx_tpriority => laxis_rx_tpriority,
            axis_rx_tdata     => laxis_rx_tdata,
            axis_rx_tvalid    => laxis_rx_tvalid,
            axis_rx_tready    => laxis_rx_tready,
            axis_rx_tkeep     => laxis_rx_tkeep,
            axis_rx_tlast     => laxis_rx_tlast
        );
end architecture rtl;
