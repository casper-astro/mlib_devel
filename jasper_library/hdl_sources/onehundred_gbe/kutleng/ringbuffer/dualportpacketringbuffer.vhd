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
-- Module Name      : dualportpacketringbuffer - rtl                           -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to create a dual packet ring buffer  -
--                    for packet  buffering.                                   -
--                    The ring buffer operates using a (2**G_SLOT_WIDTH)-1     -
--                    buffer slots. On each slot the data size is              -
--                    ((G_DATA_WIDTH) * ((2**G_ADDR_WIDTH)-1))/8 bytes long.   -
--                    It is also desirable to provide a ringbuffer fullness    -
--                    status, this can be used as a packet priority for        -
--                    consumers that consume data from the ring buffer. Zero   -
--                    fullness means the ringbuffer is empty, but when the     -
--                    fullness approaches (2**G_SLOT_WIDTH)-1 then the         -
--                    ringbuffer must be emptied urgently to avoid overflow.   -
--                    TODO                                                     -
--                    The ringbuffer module can carry auxiliary information on - 
--                    the slot information buffer, this can be packet          -
--                    forwarding information                                   -
-- Dependencies     : packetramsp,packetstatusram                              -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dualportpacketringbuffer is
    generic(
        G_SLOT_WIDTH : natural := 4;
        G_ADDR_WIDTH : natural := 8;
        G_DATA_WIDTH : natural := 64
    );
    port(
        RxClk                  : in  STD_LOGIC;
        TxClk                  : in  STD_LOGIC;
        -- Transmission port
        TxPacketByteEnable     : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
        TxPacketDataRead       : in  STD_LOGIC;
        TxPacketData           : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
        TxPacketAddress        : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
        TxPacketSlotClear      : in  STD_LOGIC;
        TxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        TxPacketSlotStatus     : out STD_LOGIC;
        TxPacketSlotTypeStatus : out STD_LOGIC;
        -- Reception port
        RxPacketByteEnable     : in  STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
        RxPacketDataWrite      : in  STD_LOGIC;
        RxPacketData           : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
        RxPacketAddress        : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
        RxPacketSlotSet        : in  STD_LOGIC;
        RxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        RxPacketSlotType       : in  STD_LOGIC;
        RxPacketSlotStatus     : out STD_LOGIC;
        RxPacketSlotTypeStatus : out STD_LOGIC
    );
end entity dualportpacketringbuffer;

architecture rtl of dualportpacketringbuffer is
    component packetstatusram is
        generic(
            G_ADDR_WIDTH : natural := 4
        );
        port(
            ClkA          : in  STD_LOGIC;
            ClkB          : in  STD_LOGIC;
            -- Port A
            EnableA       : in  STD_LOGIC;
            WriteAEnable  : in  STD_LOGIC;
            WriteAData    : in  STD_LOGIC_VECTOR(1 downto 0);
            WriteAAddress : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            ReadAData     : out STD_LOGIC_VECTOR(1 downto 0);
            -- Port B
            WriteBAddress : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            EnableB       : in  STD_LOGIC;
            WriteBEnable  : in  STD_LOGIC;
            WriteBData    : in  STD_LOGIC_VECTOR(1 downto 0);
            ReadBData     : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component packetstatusram;
    component packetramdp is
        generic(
            G_ADDR_WIDTH : natural := 8 + 2;
            G_DATA_WIDTH : natural := 64
        );
        port(
            ClkA          : in  STD_LOGIC;
            ClkB          : in  STD_LOGIC;
            -- Port A
            WriteAAddress : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            EnableA       : in  STD_LOGIC;
            WriteAEnable  : in  STD_LOGIC;
            WriteAData    : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            ReadAData     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            -- Port B
            WriteBAddress : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            EnableB       : in  STD_LOGIC;
            WriteBEnable  : in  STD_LOGIC;
            WriteBData    : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            ReadBData     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0)
        );
    end component packetramdp;

    signal lRxPacketAddress : std_logic_vector((RxPacketAddress'length + RxPacketSlotID'length) - 1 downto 0);
    signal lTxPacketAddress : std_logic_vector((TxPacketAddress'length + TxPacketSlotID'length) - 1 downto 0);
    signal lTxPacketData    : std_logic_vector((TxPacketData'length + TxPacketByteEnable'length) - 1 downto 0);
    signal lRxPacketData    : std_logic_vector((RxPacketData'length + RxPacketByteEnable'length) - 1 downto 0);
    signal VCC_onebit       : std_logic;
    signal GND_onebit       : std_logic;
    signal GND_twobit       : std_logic_vector(1 downto 0);
    signal GND_dwidth       : std_logic_vector(((G_DATA_WIDTH) + (G_DATA_WIDTH / 8)) - 1 downto 0);

begin
    VCC_onebit <= '1';
    GND_onebit <= '0';
    GND_twobit <= "00";
    GND_dwidth <= (others => '0');

    packetstatusram_i : packetstatusram
        generic map(
            G_ADDR_WIDTH => G_SLOT_WIDTH
        )
        port map(
            ClkA          => RxClk,
            ClkB          => TxClk,
            -- Port A
            EnableA       => RxPacketSlotSet,
            WriteAEnable  => RxPacketSlotSet,
            WriteAData(0) => RxPacketSlotSet,
            WriteAData(1) => RxPacketSlotType,
            WriteAAddress => RxPacketSlotID,
            ReadAData(0)  => RxPacketSlotStatus,
            ReadAData(1)  => RxPacketSlotTypeStatus,
            -- Port B
            WriteBAddress => TxPacketSlotID,
            EnableB       => VCC_onebit,
            WriteBEnable  => TxPacketSlotClear,
            WriteBData    => GND_twobit,
            ReadBData(0)  => TxPacketSlotStatus,
            ReadBData(1)  => TxPacketSlotTypeStatus
        );

    lRxPacketData((RxPacketByteEnable'length + RxPacketData'length) - 1 downto RxPacketData'length) <= RxPacketByteEnable;
    lRxPacketData(RxPacketData'length - 1 downto 0)                                                 <= RxPacketData;

    lRxPacketAddress((RxPacketSlotID'length + RxPacketAddress'length) - 1 downto RxPacketAddress'length) <= RxPacketSlotID;
    lRxPacketAddress(RxPacketAddress'length - 1 downto 0)                                                <= RxPacketAddress;

    lTxPacketAddress((TxPacketSlotID'length + TxPacketAddress'length) - 1 downto TxPacketAddress'length) <= TxPacketSlotID;
    lTxPacketAddress(TxPacketAddress'length - 1 downto 0)                                                <= TxPacketAddress;

    TxPacketByteEnable <= lTxPacketData((TxPacketByteEnable'length + TxPacketData'length) - 1 downto TxPacketData'length);
    TxPacketData       <= lTxPacketData(TxPacketData'length - 1 downto 0);

    Buffer_i : packetramdp
        generic map(
            G_ADDR_WIDTH => (RxPacketAddress'length + RxPacketSlotID'length),
            G_DATA_WIDTH => (RxPacketData'length + RxPacketByteEnable'length)
        )
        port map(
            ClkA          => RxClk,
            ClkB          => TxClk,
            WriteAAddress => lRxPacketAddress,
            EnableA       => RxPacketDataWrite,
            WriteAEnable  => RxPacketDataWrite,
            WriteAData    => lRxPacketData,
            ReadAData     => open,
            WriteBAddress => lTxPacketAddress,
            EnableB       => TxPacketDataRead,
            WriteBEnable  => GND_onebit,
            WriteBData    => GND_dwidth,
            ReadBData     => lTxPacketData
        );
end architecture rtl;
