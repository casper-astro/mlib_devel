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
-- Module Name      : arpcache - rtl                                           -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to create an ARP cache using dual    -
--                    port ram.                                                - 
-- Dependencies     : arpramadpwrr,arpramadpwr                                 -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arpcache is
    generic(
        G_WRITE_DATA_WIDTH : natural range 32 to 64 := 32;
        G_NUM_CACHE_BLOCKS : natural range 1 to 4   := 1;
        G_ARP_CACHE_ASIZE  : natural                := 13
    );
    port(
        CPUClk             : in  STD_LOGIC;
        EthernetClk        : in  STD_LOGIC_VECTOR(G_NUM_CACHE_BLOCKS - 1 downto 0);
        -- CPU port
        CPUReadDataEnable  : in  STD_LOGIC;
        CPUReadData        : out STD_LOGIC_VECTOR(G_WRITE_DATA_WIDTH - 1 downto 0);
        CPUReadAddress     : in  STD_LOGIC_VECTOR(G_ARP_CACHE_ASIZE - 1 downto 0);
        CPUWriteDataEnable : in  STD_LOGIC;
        CPUWriteData       : in  STD_LOGIC_VECTOR(G_WRITE_DATA_WIDTH - 1 downto 0);
        CPUWriteAddress    : in  STD_LOGIC_VECTOR(G_ARP_CACHE_ASIZE - 1 downto 0);
        -- Ethernet port
        ARPReadDataEnable  : in  STD_LOGIC_VECTOR(G_NUM_CACHE_BLOCKS - 1 downto 0);
        ARPReadData        : out STD_LOGIC_VECTOR((G_NUM_CACHE_BLOCKS * G_WRITE_DATA_WIDTH * 2) - 1 downto 0);
        ARPReadAddress     : in  STD_LOGIC_VECTOR((G_NUM_CACHE_BLOCKS * (G_ARP_CACHE_ASIZE - 1)) - 1 downto 0)
    );
end entity arpcache;

architecture rtl of arpcache is
    constant C_BROADCAST_ADDRESS_BIT : std_logic := '1';

    component arpramadpwrr is
        generic(
            G_INIT_VALUE : std_logic := '0';
            G_ADDR_WIDTH : natural   := 13;
            G_DATA_WIDTH : natural   := 32
        );
        port(
            ClkA          : in  STD_LOGIC;
            ClkB          : in  STD_LOGIC;
            -- Port A
            WriteAEnable  : in  STD_LOGIC;
            WriteAAddress : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            WriteAData    : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            ReadAEnable   : in  STD_LOGIC;
            ReadAAddress  : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            ReadAData     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            -- Port B
            ReadBAddress  : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 2 downto 0);
            ReadBEnable   : in  STD_LOGIC;
            ReadBData     : out STD_LOGIC_VECTOR((G_DATA_WIDTH * 2) - 1 downto 0)
        );
    end component arpramadpwrr;
    component arpramadpwr is
        generic(
            G_INIT_VALUE : std_logic := '0';
            G_ADDR_WIDTH : natural   := 13;
            G_DATA_WIDTH : natural   := 32
        );
        port(
            ClkA          : in  STD_LOGIC;
            ClkB          : in  STD_LOGIC;
            -- Port A
            WriteAEnable  : in  STD_LOGIC;
            WriteAAddress : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            WriteAData    : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            -- Port B
            ReadBAddress  : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 2 downto 0);
            ReadBEnable   : in  STD_LOGIC;
            ReadBData     : out STD_LOGIC_VECTOR((G_DATA_WIDTH * 2) - 1 downto 0)
        );
    end component arpramadpwr;

begin

    DPRAMi : for i in 0 to G_NUM_CACHE_BLOCKS - 1 generate
    begin
        DPRAM0i : if i = 0 generate
        begin
            DPRAM00i : arpramadpwrr
                generic map(
                    -- Initialize with all ones so that default is broadcast
                    -- MAC address FF:FF:FF:FF:FF:FF
                    G_INIT_VALUE => C_BROADCAST_ADDRESS_BIT,
                    G_ADDR_WIDTH => G_ARP_CACHE_ASIZE,
                    G_DATA_WIDTH => G_WRITE_DATA_WIDTH
                )
                port map(
                    ClkA          => CPUClk,
                    ClkB          => EthernetClk(i),
                    WriteAEnable  => CPUWriteDataEnable,
                    WriteAAddress => CPUWriteAddress,
                    WriteAData    => CPUWriteData,
                    ReadAEnable   => CPUReadDataEnable,
                    ReadAAddress  => CPUReadAddress,
                    ReadAData     => CPUReadData, -- The first cache block has readback
                    ReadBAddress  => ARPReadAddress((G_ARP_CACHE_ASIZE - 1) - 1 downto 0),
                    ReadBEnable   => ARPReadDataEnable(i),
                    ReadBData     => ARPReadData((G_WRITE_DATA_WIDTH * 2) - 1 downto 0)
                );
        end generate;
        DPRAMNi : if i /= 0 generate
        begin
            DPRAMN1i : arpramadpwr
                generic map(
                    -- Initialize with all ones so that default is broadcast
                    -- MAC address FF:FF:FF:FF:FF:FF
                    G_INIT_VALUE => C_BROADCAST_ADDRESS_BIT,
                    G_ADDR_WIDTH => G_ARP_CACHE_ASIZE,
                    G_DATA_WIDTH => G_WRITE_DATA_WIDTH
                )
                port map(
                    ClkA          => CPUClk,
                    ClkB          => EthernetClk(i),
                    WriteAEnable  => CPUWriteDataEnable,
                    WriteAAddress => CPUWriteAddress,
                    WriteAData    => CPUWriteData,
                    ReadBAddress  => ARPReadAddress(((G_ARP_CACHE_ASIZE - 1) * (i + 1)) - 1 downto ((G_ARP_CACHE_ASIZE - 1) * (i))),
                    ReadBEnable   => ARPReadDataEnable(i),
                    ReadBData     => ARPReadData(((G_WRITE_DATA_WIDTH * 2) * (i + 1)) - 1 downto ((G_WRITE_DATA_WIDTH * 2) * (i)))
                );
        end generate;
    end generate DPRAMi;

end architecture rtl;
