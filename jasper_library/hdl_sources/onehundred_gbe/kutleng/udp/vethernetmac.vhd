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
-- Module Name      : vethernetmac - rtl                                       -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module instantiates two QSFP28+ ports with CMACs.   -
--                    The udpipinterfacepr module is instantiated to connect   -
--                    UDP functionality on QSFP28+[1].                         -
--                    To test bandwidth the testcomms module is instantiated on-
--                    QSFP28+[2].                                              -
-- Dependencies     : 														   -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity vethernetmac is
    generic(
        C_VMAC_ADDRESS : STD_LOGIC_VECTOR(47 downto 0)
    );
    port(
        ------------------------------------------------------------------------
        -- These signals/busses run at 322.265625MHz clock domain              -
        ------------------------------------------------------------------------
        -- Global System Enable
        Enable                       : in  STD_LOGIC;
        Reset                        : in  STD_LOGIC;
        vmac_register_data_out       : in  STD_LOGIC_VECTOR(31 downto 0);
        vmac_register_data_in        : out STD_LOGIC_VECTOR(31 downto 0);
        vmac_register_address        : out STD_LOGIC_VECTOR(3 downto 0);
        vmac_register_control        : out STD_LOGIC_VECTOR(1 downto 0);
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
        pcie_axis_rx_tdata           : in  STD_LOGIC_VECTOR(511 downto 0);
        pcie_axis_rx_tvalid          : in  STD_LOGIC;
        pcie_axis_rx_tready          : out STD_LOGIC;
        pcie_axis_rx_tkeep           : in  STD_LOGIC_VECTOR(63 downto 0);
        pcie_axis_rx_tlast           : in  STD_LOGIC;
        pcie_axis_tx_tdata           : out STD_LOGIC_VECTOR(511 downto 0);
        pcie_axis_tx_tvalid          : out STD_LOGIC;
        pcie_axis_tx_tready          : in  STD_LOGIC;
        pcie_axis_tx_tkeep           : out STD_LOGIC_VECTOR(63 downto 0);
        pcie_axis_tx_tlast           : out STD_LOGIC;
        -- AXIS Bus
        -- RX Bus
        ethernet_axis_rx_tdata       : in  STD_LOGIC_VECTOR(511 downto 0);
        ethernet_axis_rx_tvalid      : in  STD_LOGIC;
        ethernet_axis_rx_tready      : out STD_LOGIC;
        ethernet_axis_rx_tkeep       : in  STD_LOGIC_VECTOR(63 downto 0);
        ethernet_axis_rx_tlast       : in  STD_LOGIC;
        ethernet_axis_rx_tuser       : in  STD_LOGIC;
        -- TX Bus
        ethernet_axis_tx_tdata       : out STD_LOGIC_VECTOR(511 downto 0);
        ethernet_axis_tx_tvalid      : out STD_LOGIC;
        ethernet_axis_tx_tkeep       : out STD_LOGIC_VECTOR(63 downto 0);
        ethernet_axis_tx_tlast       : out STD_LOGIC;
        -- User signal for errors and dropping of packets
        ethernet_axis_tx_tuser       : out STD_LOGIC
    );

end entity vethernetmac;

architecture rtl of vethernetmac is
begin
end architecture rtl;

