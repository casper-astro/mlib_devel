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
-- Module Name      : mac100gphy - rtl                                         -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module instantiates one QSFP28+ ports with CMACs.   -
-- Dependencies     : gmacqsfptop                                              -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity mac100gphy is
    generic(
        C_MAC_INSTANCE : natural range 0 to 1 := 0
    );
    port(
        -- Ethernet reference clock for 156.25MHz
        -- QSFP+ 
        mgt_qsfp_clock_p             : in  STD_LOGIC;
        mgt_qsfp_clock_n             : in  STD_LOGIC;
        --RX     
        qsfp_mgt_rx_p                : in  STD_LOGIC_VECTOR(3 downto 0);
        qsfp_mgt_rx_n                : in  STD_LOGIC_VECTOR(3 downto 0);
        -- TX
        qsfp_mgt_tx_p                : out STD_LOGIC_VECTOR(3 downto 0);
        qsfp_mgt_tx_n                : out STD_LOGIC_VECTOR(3 downto 0);
        -- Reference clock to generate 100MHz from
        Clk100MHz                    : in  STD_LOGIC;
        ------------------------------------------------------------------------
        -- These signals/buses run at 322.265625MHz clock domain               -
        ------------------------------------------------------------------------
        -- Global System Enable
        Enable                       : in  STD_LOGIC;
        Reset                        : in  STD_LOGIC;
        -- Statistics interface
        gmac_reg_core_type           : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_phy_status_h        : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_phy_status_l        : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_phy_control_h       : in  STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_phy_control_l       : in  STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_tx_packet_rate      : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_tx_packet_count     : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_tx_valid_rate       : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_tx_valid_count      : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_rx_packet_rate      : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_rx_packet_count     : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_rx_valid_rate       : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_rx_valid_count      : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_rx_bad_packet_count : out STD_LOGIC_VECTOR(31 downto 0);
        gmac_reg_counters_reset      : in  STD_LOGIC;
        -- Lbus and AXIS
        lbus_reset                   : in  STD_LOGIC;
        -- Overflow signal
        lbus_tx_ovfout               : out STD_LOGIC;
        -- Underflow signal
        lbus_tx_unfout               : out STD_LOGIC;
        -- AXIS Bus
        -- RX Bus
        axis_rx_clkin                : in  STD_LOGIC;
        axis_rx_tdata                : in  STD_LOGIC_VECTOR(511 downto 0);
        axis_rx_tvalid               : in  STD_LOGIC;
        axis_rx_tready               : out STD_LOGIC;
        axis_rx_tkeep                : in  STD_LOGIC_VECTOR(63 downto 0);
        axis_rx_tlast                : in  STD_LOGIC;
        axis_rx_tuser                : in  STD_LOGIC;
        -- TX Bus
        axis_tx_clkout               : out STD_LOGIC;
        axis_tx_tdata                : out STD_LOGIC_VECTOR(511 downto 0);
        axis_tx_tvalid               : out STD_LOGIC;
        axis_tx_tkeep                : out STD_LOGIC_VECTOR(63 downto 0);
        axis_tx_tlast                : out STD_LOGIC;
        -- User signal for errors and dropping of packets
        axis_tx_tuser                : out STD_LOGIC
    );
end entity mac100gphy;

architecture rtl of mac100gphy is
    component gmacqsfptop is
        port(
            -- Reference clock to generate 100MHz from
            Clk100MHz                    : in  STD_LOGIC;
            -- Ethernet reference clock for 156.25MHz
            -- QSFP+ 
            mgt_qsfp_clock_p             : in  STD_LOGIC;
            mgt_qsfp_clock_n             : in  STD_LOGIC;
            --RX     
            qsfp_mgt_rx_p                : in  STD_LOGIC_VECTOR(3 downto 0);
            qsfp_mgt_rx_n                : in  STD_LOGIC_VECTOR(3 downto 0);
            -- TX
            qsfp_mgt_tx_p                : out STD_LOGIC_VECTOR(3 downto 0);
            qsfp_mgt_tx_n                : out STD_LOGIC_VECTOR(3 downto 0);
            ------------------------------------------------------------------------
            -- These signals/buses run at 322.265625MHz clock domain.              -
            ------------------------------------------------------------------------
            -- Global System Enable
            Enable                       : in  STD_LOGIC;
            Reset                        : in  STD_LOGIC;
            -- Statistics interface            
            gmac_reg_core_type           : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_h        : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_l        : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_control_h       : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_control_l       : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_rate      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_count     : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_rate       : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_count      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_rate      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_count     : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_rate       : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_count      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_bad_packet_count : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_counters_reset      : in  STD_LOGIC;
            -- Lbus and AXIS
            -- This bus runs at 322.265625MHz
            lbus_reset                   : in  STD_LOGIC;
            -- Overflow signal
            lbus_tx_ovfout               : out STD_LOGIC;
            -- Underflow signal
            lbus_tx_unfout               : out STD_LOGIC;
            -- AXIS Bus
            -- RX Bus
            axis_rx_clkin                : in  STD_LOGIC;
            axis_rx_tdata                : in  STD_LOGIC_VECTOR(511 downto 0);
            axis_rx_tvalid               : in  STD_LOGIC;
            axis_rx_tready               : out STD_LOGIC;
            axis_rx_tkeep                : in  STD_LOGIC_VECTOR(63 downto 0);
            axis_rx_tlast                : in  STD_LOGIC;
            axis_rx_tuser                : in  STD_LOGIC;
            -- TX Bus
            axis_tx_clkout               : out STD_LOGIC;
            axis_tx_tdata                : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tx_tvalid               : out STD_LOGIC;
            axis_tx_tkeep                : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tx_tlast                : out STD_LOGIC;
            -- User signal for errors and dropping of packets
            axis_tx_tuser                : out STD_LOGIC
        );
    end component gmacqsfptop;

    component axispacketbufferfifo
        port(
            s_aclk        : IN  STD_LOGIC;
            s_aresetn     : IN  STD_LOGIC;
            s_axis_tvalid : IN  STD_LOGIC;
            s_axis_tready : OUT STD_LOGIC;
            s_axis_tdata  : IN  STD_LOGIC_VECTOR(511 DOWNTO 0);
            s_axis_tkeep  : IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
            s_axis_tlast  : IN  STD_LOGIC;
            s_axis_tuser  : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
            m_axis_tvalid : OUT STD_LOGIC;
            m_axis_tready : IN  STD_LOGIC;
            m_axis_tdata  : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
            m_axis_tkeep  : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
            m_axis_tlast  : OUT STD_LOGIC;
            m_axis_tuser  : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
        );
    end component axispacketbufferfifo;
    signal axis_tdata  : STD_LOGIC_VECTOR(511 downto 0);
    signal axis_tvalid : STD_LOGIC;
    signal axis_tready : STD_LOGIC;
    signal axis_tkeep  : STD_LOGIC_VECTOR(63 downto 0);
    signal axis_tlast  : STD_LOGIC;
    signal axis_tuser  : STD_LOGIC;
    signal ResetN      : STD_LOGIC;

begin
    ResetN <= not Reset;

    AXISPAcketBufferFIFO_i : axispacketbufferfifo
        PORT MAP(
            s_aclk          => axis_rx_clkin,
            s_aresetn       => ResetN,
            s_axis_tvalid   => axis_rx_tvalid,
            s_axis_tready   => axis_rx_tready,
            s_axis_tdata    => axis_rx_tdata,
            s_axis_tkeep    => axis_rx_tkeep,
            s_axis_tlast    => axis_rx_tlast,
            s_axis_tuser(0) => axis_rx_tuser,
            m_axis_tvalid   => axis_tvalid,
            m_axis_tready   => axis_tready,
            m_axis_tdata    => axis_tdata,
            m_axis_tkeep    => axis_tkeep,
            m_axis_tlast    => axis_tlast,
            m_axis_tuser(0) => axis_tuser
        );

    assert C_MAC_INSTANCE > 1 report "Error bad C_MAC_INSTANCE = " & integer'image(C_MAC_INSTANCE) severity failure;

    CMAC0_i : gmacqsfptop
        port map(
            Clk100MHz                    => Clk100MHz,
            Enable                       => Enable,
            Reset                        => Reset,
            mgt_qsfp_clock_p             => mgt_qsfp_clock_p,
            mgt_qsfp_clock_n             => mgt_qsfp_clock_n,
            qsfp_mgt_rx_p                => qsfp_mgt_rx_p,
            qsfp_mgt_rx_n                => qsfp_mgt_rx_n,
            qsfp_mgt_tx_p                => qsfp_mgt_tx_p,
            qsfp_mgt_tx_n                => qsfp_mgt_tx_n,
            gmac_reg_core_type           => gmac_reg_core_type,
            gmac_reg_phy_status_h        => gmac_reg_phy_status_h,
            gmac_reg_phy_status_l        => gmac_reg_phy_status_l,
            gmac_reg_phy_control_h       => gmac_reg_phy_control_h,
            gmac_reg_phy_control_l       => gmac_reg_phy_control_l,
            gmac_reg_tx_packet_rate      => gmac_reg_tx_packet_rate,
            gmac_reg_tx_packet_count     => gmac_reg_tx_packet_count,
            gmac_reg_tx_valid_rate       => gmac_reg_tx_valid_rate,
            gmac_reg_tx_valid_count      => gmac_reg_tx_valid_count,
            gmac_reg_rx_packet_rate      => gmac_reg_rx_packet_rate,
            gmac_reg_rx_packet_count     => gmac_reg_rx_packet_count,
            gmac_reg_rx_valid_rate       => gmac_reg_rx_valid_rate,
            gmac_reg_rx_valid_count      => gmac_reg_rx_valid_count,
            gmac_reg_rx_bad_packet_count => gmac_reg_rx_bad_packet_count,
            gmac_reg_counters_reset      => gmac_reg_counters_reset,
            lbus_reset                   => lbus_reset,
            lbus_tx_ovfout               => lbus_tx_ovfout,
            lbus_tx_unfout               => lbus_tx_unfout,
            axis_rx_clkin                => axis_rx_clkin,
            axis_rx_tdata                => axis_tdata,
            axis_rx_tvalid               => axis_tvalid,
            axis_rx_tready               => axis_tready,
            axis_rx_tkeep                => axis_tkeep,
            axis_rx_tlast                => axis_tlast,
            axis_rx_tuser                => axis_tuser,
            axis_tx_clkout               => axis_tx_clkout,
            axis_tx_tdata                => axis_tx_tdata,
            axis_tx_tvalid               => axis_tx_tvalid,
            axis_tx_tkeep                => axis_tx_tkeep,
            axis_tx_tlast                => axis_tx_tlast,
            axis_tx_tuser                => axis_tx_tuser
        );

end architecture rtl;
