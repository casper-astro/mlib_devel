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
-- Module Name      : arpreceiver - rtl                                        -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module implements an ARP & RARP receiver by  -
--                    extracting the ARP and RARP data from the 512 bit        -
--                    interface.                                               -
--                    TODO                                                     -
--                    The ARP module needs to be extended to work on 802.1Q    - 
--                    based networks. At this moment it wont work where there  -
--                    is VLAN tagging.                                         -
-- Dependencies     : packetringbuffer                                         -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arpreceiver is
    generic(
        G_SLOT_WIDTH : natural := 4
    );
    port(
        axis_clk                 : in  STD_LOGIC;
        axis_reset               : in  STD_LOGIC;
        -- Setup information
        ARPMACAddress            : in  STD_LOGIC_VECTOR(47 downto 0);
        ARPIPAddress             : in  STD_LOGIC_VECTOR(31 downto 0);
        -- Bus Readout
        RingBufferSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        RingBufferSlotClear      : in  STD_LOGIC;
        RingBufferSlotStatus     : out STD_LOGIC;
        RingBufferSlotTypeStatus : out STD_LOGIC;
        RingBufferSlotsFilled    : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        RingBufferDataRead       : in  STD_LOGIC;
        RingBufferDataEnable     : out STD_LOGIC_VECTOR(63 downto 0);
        RingBufferDataOut        : out STD_LOGIC_VECTOR(511 downto 0);
        RingBufferAddress        : in  STD_LOGIC_VECTOR(8 downto 0);
        --Inputs from AXIS bus 
        axis_rx_tdata            : in  STD_LOGIC_VECTOR(511 downto 0);
        axis_rx_tvalid           : in  STD_LOGIC;
        axis_rx_tuser            : in  STD_LOGIC;
        axis_rx_tkeep            : in  STD_LOGIC_VECTOR(63 downto 0);
        axis_rx_tlast            : in  STD_LOGIC
    );
end entity arpreceiver;

architecture rtl of arpreceiver is

    component packetringbuffer is
        generic(
            G_SLOT_WIDTH : natural := 4;
            G_ADDR_WIDTH : natural := 8;
            G_DATA_WIDTH : natural := 64
        );
        port(
            Clk                    : in  STD_LOGIC;
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
            RxPacketSlotType       : in  STD_LOGIC
        );
    end component packetringbuffer;

    type AxisARPReaderSM_t is (
        InitialiseSt,                   -- On the reset state
        ProcessPacketSt                 -- ARP Processing (Accept ARP Packets only 64 bytes or less)
    );
    signal StateVariable     : AxisARPReaderSM_t             := InitialiseSt;
    constant C_BROADCAST_MAC : std_logic_vector(47 downto 0) := X"FF_FF_FF_FF_FF_FF";
    -- Packet Type ARP=0x0806 
    constant C_ARP_TYPE      : std_logic_vector(15 downto 0) := X"0806";
    -- Packet Type RARP=0x0835 
    constant C_RARP_TYPE     : std_logic_vector(15 downto 0) := X"0835";
    -- Packet Type VLAN=0x8100 
    --constant C_VLAN_TYPE      : std_logic_vector(15 downto 0)       := X"8100";
    -- Packet Type DVLAN=0x88A8 
    --constant C_DVLAN_TYPE     : std_logic_vector(15 downto 0)       := X"88A8";
    -- Ethernet Type=0x0001 
    constant C_ETHERNET_TYPE : std_logic_vector(15 downto 0) := X"0001";
    -- IPV4 Type=0x8000 
    constant C_IPV4_TYPE     : std_logic_vector(15 downto 0) := X"0800";
    -- ARP Request=0x0001 
    constant C_ARP_REQ       : std_logic_vector(15 downto 0) := X"0001";
    -- ARP Response=0x0002 
    constant C_ARP_RESP      : std_logic_vector(15 downto 0) := X"0002";
    -- RARP Request=0x0003 
    constant C_RARP_REQ      : std_logic_vector(15 downto 0) := X"0003";
    -- RARP Response=0x0004 
    constant C_RARP_RESP     : std_logic_vector(15 downto 0) := X"0004";
    -- HWMAC Size=0x06 
    constant C_HWMAC_SIZE    : std_logic_vector(7 downto 0)  := X"06";
    -- IPV4 Size=0x04 
    constant C_IPV4_SIZE     : std_logic_vector(7 downto 0)  := X"04";
    -- Tuples registers
    signal lPacketByteEnable : std_logic_vector(RingBufferDataEnable'length - 1 downto 0);
    signal lPacketDataWrite  : std_logic;
    signal lPacketData       : std_logic_vector(RingBufferDataOut'length - 1 downto 0);
    signal lPacketAddress    : unsigned(RingBufferAddress'length - 1 downto 0);
    signal lPacketSlotSet    : std_logic;
    signal lPacketSlotType   : std_logic;
    signal lPacketSlotID     : unsigned(RingBufferSlotID'length - 1 downto 0);
    alias lDestinationMAC    : std_logic_vector(47 downto 0) is axis_rx_tdata(47 downto 0);
    alias lSourceMAC         : std_logic_vector(47 downto 0) is axis_rx_tdata(95 downto 48);
    alias lEtherType         : std_logic_vector(15 downto 0) is axis_rx_tdata(111 downto 96);
    alias lHardType          : std_logic_vector(15 downto 0) is axis_rx_tdata(127 downto 112);
    alias lProtoType         : std_logic_vector(15 downto 0) is axis_rx_tdata(143 downto 128);
    alias lHardSize          : std_logic_vector(7  downto 0) is axis_rx_tdata(151 downto 144);
    alias lProtoSize         : std_logic_vector(7  downto 0) is axis_rx_tdata(159 downto 152);
    alias lARPOperation      : std_logic_vector(15 downto 0) is axis_rx_tdata(175 downto 160);
    alias lSenderMAC         : std_logic_vector(47 downto 0) is axis_rx_tdata(223 downto 176);
    alias lSenderIP          : std_logic_vector(31 downto 0) is axis_rx_tdata(255 downto 224);
    --	alias lDestMAC            : std_logic_vector(47 downto 0) is axis_rx_tdata(303 downto 256);
    alias lDestIP            : std_logic_vector(31 downto 0) is axis_rx_tdata(335 downto 304);
    signal lFilledSlots      : unsigned(G_SLOT_WIDTH - 1 downto 0);

    function byteswap(DataIn : in std_logic_vector)
    return std_logic_vector is
        variable RData48 : std_logic_vector(47 downto 0);
        variable RData32 : std_logic_vector(31 downto 0);
        variable RData24 : std_logic_vector(23 downto 0);
        variable RData16 : std_logic_vector(15 downto 0);
    begin
        if (DataIn'length = RData48'length) then
            RData48(7 downto 0)   := DataIn(47 downto 40);
            RData48(15 downto 8)  := DataIn(39 downto 32);
            RData48(23 downto 16) := DataIn(31 downto 24);
            RData48(31 downto 24) := DataIn(23 downto 16);
            RData48(39 downto 32) := DataIn(15 downto 8);
            RData48(47 downto 40) := DataIn(7 downto 0);
            return std_logic_vector(RData48);
        end if;
        if (DataIn'length = RData32'length) then
            RData32(7 downto 0)   := DataIn(31 downto 24);
            RData32(15 downto 8)  := DataIn(23 downto 16);
            RData32(23 downto 16) := DataIn(15 downto 8);
            RData32(31 downto 24) := DataIn(7 downto 0);
            return std_logic_vector(RData32);
        end if;
        if (DataIn'length = RData24'length) then
            RData24(7 downto 0)   := DataIn(23 downto 16);
            RData24(15 downto 8)  := DataIn(15 downto 8);
            RData24(23 downto 16) := DataIn(7 downto 0);
            return std_logic_vector(RData24);
        end if;
        if (DataIn'length = RData16'length) then
            RData16(7 downto 0)  := DataIn(15 downto 8);
            RData16(15 downto 8) := DataIn(7 downto 0);
            return std_logic_vector(RData16);
        end if;
    end byteswap;

begin
    FilledSlotCounterProc : process(axis_clk)
    begin
        if rising_edge(axis_clk) then
            if (axis_reset = '1') then
                lFilledSlots <= (others => '0');
            else
                if ((RingBufferSlotClear = '0') and (lPacketSlotSet = '1')) then
                    lFilledSlots <= lFilledSlots + 1;
                elsif ((RingBufferSlotClear = '1') and (lPacketSlotSet = '0')) then
                    lFilledSlots <= lFilledSlots - 1;
                else
                    -- Its a neutral operation
                    lFilledSlots <= lFilledSlots;
                end if;
            end if;
        end if;
    end process FilledSlotCounterProc;

    RingBufferSlotsFilled <= std_logic_vector(lFilledSlots);

    PackerBuffer_i : packetringbuffer
        generic map(
            G_SLOT_WIDTH => G_SLOT_WIDTH,
            G_ADDR_WIDTH => RingBufferAddress'length,
            G_DATA_WIDTH => RingBufferDataOut'length
        )
        port map(
            Clk                    => axis_clk,
            -- Transmission port
            TxPacketByteEnable     => RingBufferDataEnable,
            TxPacketDataRead       => RingBufferDataRead,
            TxPacketData           => RingBufferDataOut,
            TxPacketAddress        => RingBufferAddress,
            TxPacketSlotClear      => RingBufferSlotClear,
            TxPacketSlotID         => RingBufferSlotID,
            TxPacketSlotStatus     => RingBufferSlotStatus,
            TxPacketSlotTypeStatus => RingBufferSlotTypeStatus,
            RxPacketByteEnable     => lPacketByteEnable,
            RxPacketDataWrite      => lPacketDataWrite,
            RxPacketData           => lPacketData,
            RxPacketAddress        => std_logic_vector(lPacketAddress),
            RxPacketSlotSet        => lPacketSlotSet,
            RxPacketSlotID         => std_logic_vector(lPacketSlotID),
            RxPacketSlotType       => lPacketSlotType
        );

    SynchStateProc : process(axis_clk)
    begin
        if rising_edge(axis_clk) then
            if (axis_reset = '1') then
                -- Initialize SM on reset
                StateVariable <= InitialiseSt;
            else
                case (StateVariable) is
                    when InitialiseSt =>

                        -- Wait for packet after initialization
                        StateVariable    <= ProcessPacketSt;
                        lPacketAddress   <= (others => '0');
                        lPacketSlotID    <= (others => '0');
                        lPacketDataWrite <= '0';

                    when ProcessPacketSt =>
                        if (lPacketSlotSet = '1') then
                            -- If the previous slot was set then point to next slot.
                            lPacketSlotID <= unsigned(lPacketSlotID) + 1;
                        end if;

                        if ((axis_rx_tvalid = '1') and (lHardType = byteswap(C_ETHERNET_TYPE)) and (lProtoType = byteswap(C_IPV4_TYPE)) and (lHardSize = C_HWMAC_SIZE) and (lProtoSize = C_IPV4_SIZE)) then

                            if (((lDestinationMAC = byteswap(C_BROADCAST_MAC)) or (lDestinationMAC = byteswap(ARPMACAddress))) and (lARPOperation = byteswap(C_ARP_REQ)) and (lDestIP = byteswap(ARPIPAddress)) and (lEtherType = byteswap(C_ARP_TYPE))) then
                                -- This is an ARP request to this system
                                -- Supply ARP Request signals and progress slots
                                if (axis_rx_tlast = '1') then
                                    -- If this is the last segment then restart the packet address
                                    lPacketAddress <= (others => '0');
                                    if (axis_rx_tuser = '0') then
                                        -- packet has no errors
                                        lPacketSlotSet <= '1';
                                    else
                                        -- This is a packet containing 
                                        -- errors, drop it
                                        lPacketSlotSet <= '0';
                                    end if;
                                else
                                    lPacketSlotSet <= '0';                                
                                    lPacketAddress <= unsigned(lPacketAddress) + 1;
                                end if;
                                -- tkeep(0) is always 1 when writing data is valid
                                -- For the case of TLAST insert TLAST
                                -- on the last bit  
                                lPacketByteEnable(0)           <= axis_rx_tlast;
                                lPacketByteEnable(63 downto 1) <= axis_rx_tkeep(63 downto 1);
                                lPacketDataWrite <= '1';
                                lPacketSlotType <= axis_rx_tlast;
                                --Send the ARP Response
                                lPacketData(47 downto 0) <= lSourceMAC;
                                lPacketData(95 downto 48) <= byteswap(ARPMACAddress);
                                lPacketData(111 downto 96) <= lEtherType;
                                lPacketData(127 downto 112) <= lHardType;
                                lPacketData(143 downto 128) <= lProtoType;
                                lPacketData(151 downto 144) <= lHardSize;
                                lPacketData(159 downto 152) <= lProtoSize;
                                lPacketData(175 downto 160) <= byteswap(C_ARP_RESP);
                                lPacketData(223 downto 176) <= byteswap(ARPMACAddress);
                                lPacketData(255 downto 224) <= byteswap(ARPIPAddress);
                                lPacketData(303 downto 256) <= lSenderMAC;
                                lPacketData(335 downto 304) <= lSenderIP;
                                lPacketData(511 downto 336) <= (others => '0');
                            else
                                if ((lDestinationMAC = byteswap(ARPMACAddress)) and (lARPOperation = byteswap(C_RARP_REQ)) and (lEtherType = byteswap(C_RARP_TYPE))) then
                                    --Supply RARP Request signals and progress slots
                                    if (axis_rx_tlast = '1') then
                                        -- If this is the last segment then restart the packet address
                                        if (axis_rx_tuser = '0') then
                                            -- packet has no errors
                                            lPacketSlotSet <= '1';
                                        else
                                            -- This is a packet containing 
                                            -- errors, drop it
                                            lPacketSlotSet <= '0';
                                        end if;
                                        lPacketAddress <= (others => '0');
                                        -- tkeep(0) is always 1 when writing data is valid 
                                        lPacketByteEnable(0)           <= '1';
                                        lPacketByteEnable(63 downto 1) <= axis_rx_tkeep(63 downto 1);
                                    else
                                        -- tkeep(0) is always 1 when writing data is valid 
                                        lPacketByteEnable(0)           <= '0';
                                        lPacketByteEnable(63 downto 1) <= axis_rx_tkeep(63 downto 1);
                                        lPacketSlotSet <= '0';
                                        lPacketAddress <= unsigned(lPacketAddress) + 1;
                                    end if;
                                    lPacketDataWrite <= '1';
                                    lPacketSlotType <= axis_rx_tlast;
                                    --Send the RARP Response
                                    lPacketData(47 downto 0) <= lSourceMAC;
                                    lPacketData(95 downto 48) <= byteswap(ARPMACAddress);
                                    lPacketData(111 downto 96) <= lEtherType;
                                    lPacketData(127 downto 112) <= lHardType;
                                    lPacketData(143 downto 128) <= lProtoType;
                                    lPacketData(151 downto 144) <= lHardSize;
                                    lPacketData(159 downto 152) <= lProtoSize;
                                    lPacketData(175 downto 160) <= byteswap(C_RARP_RESP);
                                    lPacketData(223 downto 176) <= byteswap(ARPMACAddress);
                                    lPacketData(255 downto 224) <= byteswap(ARPIPAddress);
                                    lPacketData(303 downto 256) <= lSenderMAC;
                                    lPacketData(335 downto 304) <= lSenderIP;
                                    lPacketData(511 downto 336) <= (others => '0');
                                else
                                    --Terminate all signals
                                    lPacketAddress    <= (others => '0');
                                    lPacketDataWrite  <= '0';
                                    lPacketByteEnable <= axis_rx_tkeep;
                                    lPacketSlotType   <= '0';
                                    lPacketSlotSet    <= '0';
                                end if;
                            end if;

                            -- Keep processing packets
                            StateVariable <= ProcessPacketSt;
                        -- We only work with packets where the ARP is on a 64 byte packet size
                        else
                            --Terminate all signals
                            lPacketAddress    <= (others => '0');
                            lPacketDataWrite  <= '0';
                            lPacketByteEnable <= axis_rx_tkeep;
                            lPacketSlotType   <= '0';
                            lPacketSlotSet    <= '0';

                            if (axis_rx_tuser = '1') then
                                -- There was an error
                                StateVariable <= InitialiseSt;
                            else
                                -- Process packet until done
                                StateVariable <= ProcessPacketSt;
                            end if;
                        end if;

                    when others =>
                        StateVariable <= InitialiseSt;
                end case;
            end if;
        end if;
    end process SynchStateProc;

end architecture rtl;
