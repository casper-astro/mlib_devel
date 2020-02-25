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
-- Module Name      : arpramadpwrr - rtl                                       -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to produce a dual port ram for       -
--                    arp address tables.                                      -
--                    Two ports are employed:                                  -
--                    PortA:Write+Read                                         -
--                    PortB:Read                                               -
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--                  : V1.1 - Change to have two ports and clocks.              -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arpramadpwrr is
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
end entity arpramadpwrr;

architecture rtl of arpramadpwrr is
    component ramdpwrr is
        generic(
            G_INIT_VALUE : std_logic := '0';
            G_ADDR_WIDTH : natural   := 8 + 2;
            G_DATA_WIDTH : natural   := 64
        );
        port(
            -- Port A
            ClkA          : in  STD_LOGIC;
            -- PortB
            ClkB          : in  STD_LOGIC;
            -- Port A
            WriteAAddress : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            EnableA       : in  STD_LOGIC;
            WriteAEnable  : in  STD_LOGIC;
            WriteAData    : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            ReadAData     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            -- Port B
            ReadBAddress  : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            EnableB       : in  STD_LOGIC;
            ReadBData     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0)
        );
    end component ramdpwrr;
    signal ReadWriteAddress : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);
    signal ReadADataL       : STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
    signal ReadADataH       : STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
    signal EnableA          : STD_LOGIC;
    signal iWriteAEnable    : STD_LOGIC;
begin

    AddressProc : process(WriteAEnable, ReadAEnable, ReadAAddress, WriteAAddress)
    begin
        if (ReadAEnable = '1') then
            -- This is a read transaction
            -- Use read address and block write operations
            iWriteAEnable    <= '0';
            ReadWriteAddress <= ReadAAddress;
        else
            -- This maybe a write transaction pass it's signals through
            iWriteAEnable    <= WriteAEnable;
            ReadWriteAddress <= WriteAAddress;
        end if;
    end process AddressProc;

    ReadDataProc : process(ReadWriteAddress(0), ReadADataH, ReadADataL)
    begin
        if (ReadWriteAddress(0) = '1') then
            -- Upper Data Operation
            ReadAData <= ReadADataH;
        else
            -- Lower Data Operation
            ReadAData <= ReadADataL;
        end if;
    end process ReadDataProc;

    EnableA <= not (ReadWriteAddress(0));

    RAMH : ramdpwrr
        generic map(
            G_INIT_VALUE => G_INIT_VALUE,
            G_ADDR_WIDTH => G_ADDR_WIDTH - 1,
            G_DATA_WIDTH => G_DATA_WIDTH
        )
        port map(
            ClkA          => ClkA,
            ClkB          => ClkB,
            WriteAAddress => ReadWriteAddress(G_ADDR_WIDTH - 1 downto 1),
            EnableA       => ReadWriteAddress(0),
            WriteAEnable  => iWriteAEnable,
            WriteAData    => WriteAData,
            ReadAData     => ReadADataH,
            ReadBAddress  => ReadBAddress,
            EnableB       => ReadBEnable,
            ReadBData     => ReadBData((G_DATA_WIDTH * 2) - 1 downto G_DATA_WIDTH)
        );

    RAML : ramdpwrr
        generic map(
            G_INIT_VALUE => G_INIT_VALUE,
            G_ADDR_WIDTH => G_ADDR_WIDTH - 1,
            G_DATA_WIDTH => G_DATA_WIDTH
        )
        port map(
            ClkA          => ClkA,
            ClkB          => ClkB,
            WriteAAddress => ReadWriteAddress(G_ADDR_WIDTH - 1 downto 1),
            EnableA       => EnableA,
            WriteAEnable  => iWriteAEnable,
            WriteAData    => WriteAData,
            ReadAData     => ReadADataL,
            ReadBAddress  => ReadBAddress,
            EnableB       => ReadBEnable,
            ReadBData     => ReadBData(G_DATA_WIDTH - 1 downto 0)
        );

end architecture rtl;
