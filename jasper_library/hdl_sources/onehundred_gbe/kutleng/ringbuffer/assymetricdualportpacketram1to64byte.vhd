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
-- Module Name      : assymetricdualportpacketram1to64byte - rtl               -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to create a true dual port ram for   -
--                    packet slot buffering. The ring buffer is asymmetric i.e -
--                    ingress is 1 byte and egress 64 bytes.                   -
--                    Data packing is little endian i.e. first byte to low bits-
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity assymetricdualportpacketram1to64byte is
    generic(
        G_ADDR_WIDTH : natural := 8 + 2;
        G_SLOT_WIDTH : natural := 4
    );
    port(
        ClkA             : in  STD_LOGIC;
        ClkB             : in  STD_LOGIC;
        -- Port A
        WriteByteEnableA : in  STD_LOGIC_VECTOR(0 downto 0);
        WriteAAddress    : in  STD_LOGIC_VECTOR((G_ADDR_WIDTH + G_SLOT_WIDTH) - 1 downto 0);
        EnableA          : in  STD_LOGIC;
        WriteAEnable     : in  STD_LOGIC;
        WriteAData       : in  STD_LOGIC_VECTOR(7 downto 0);
        ReadByteEnableA  : out STD_LOGIC_VECTOR(0 downto 0);
        ReadAData        : out STD_LOGIC_VECTOR(7 downto 0);
        -- Port B
        ReadBAddress     : in  STD_LOGIC_VECTOR((G_ADDR_WIDTH + G_SLOT_WIDTH - 5) - 1 downto 0);
        EnableB          : in  STD_LOGIC;
        ReadByteEnableB  : out STD_LOGIC_VECTOR((512 / 8) - 1 downto 0);
        ReadBData        : out STD_LOGIC_VECTOR(511 downto 0)
    );
end entity assymetricdualportpacketram1to64byte;

architecture rtl of assymetricdualportpacketram1to64byte is
    component assymetrictruedualportram is
        generic(
            WIDTHA     : integer := 4;
            SIZEA      : integer := 1024;
            ADDRWIDTHA : integer := 10;
            WIDTHB     : integer := 16;
            SIZEB      : integer := 256;
            ADDRWIDTHB : integer := 8
        );
        port(
            clkA  : in  std_logic;
            clkB  : in  std_logic;
            enA   : in  std_logic;
            enB   : in  std_logic;
            weB   : in  std_logic;
            addrA : in  std_logic_vector(ADDRWIDTHA - 1 downto 0);
            addrB : in  std_logic_vector(ADDRWIDTHB - 1 downto 0);
            doB   : out std_logic_vector(WIDTHB - 1 downto 0);
            diB   : in  std_logic_vector(WIDTHB - 1 downto 0);
            doA   : out std_logic_vector(WIDTHA - 1 downto 0)
        );
    end component assymetrictruedualportram;
begin

    -- Split the RAMS into sub blocks that are less than 256bits as this is the limit
    -- for generic inference.
    -- We need bit lengths of about 512 wide.
    RAMAi : assymetrictruedualportram
        generic map(
            WIDTHB     => 4,
            SIZEB      => (2**(G_ADDR_WIDTH + G_SLOT_WIDTH - 5)),
            ADDRWIDTHB => (G_ADDR_WIDTH + G_SLOT_WIDTH - 5),
            WIDTHA     => 256,
            SIZEA      => (2**(G_ADDR_WIDTH + G_SLOT_WIDTH)),
            ADDRWIDTHA => (G_ADDR_WIDTH + G_SLOT_WIDTH)
        )
        port map(
            clkA  => ClkB,
            clkB  => ClkA,
            enA   => EnableB,
            enB   => EnableA,
            weB   => WriteAEnable,
            addrB => WriteAAddress,
            addrA => ReadBAddress,
            diB   => WriteAData(3 downto 0),
            doB   => ReadAData(3 downto 0),
            doA   => ReadBData(255 downto 0)
        );

    RAMBi : assymetrictruedualportram
        generic map(
            WIDTHB     => 4,
            SIZEB      => (2**(G_ADDR_WIDTH + G_SLOT_WIDTH - 5)),
            ADDRWIDTHB => (G_ADDR_WIDTH + G_SLOT_WIDTH - 5),
            WIDTHA     => 256,
            SIZEA      => (2**(G_ADDR_WIDTH + G_SLOT_WIDTH)),
            ADDRWIDTHA => (G_ADDR_WIDTH + G_SLOT_WIDTH)
        )
        port map(
            clkA  => ClkB,
            clkB  => ClkA,
            enA   => EnableB,
            enB   => EnableA,
            weB   => WriteAEnable,
            addrB => WriteAAddress,
            addrA => ReadBAddress,
            diB   => WriteAData(7 downto 4),
            doB   => ReadAData(7 downto 4),
            doA   => ReadBData(511 downto 256)
        );

end architecture rtl;
