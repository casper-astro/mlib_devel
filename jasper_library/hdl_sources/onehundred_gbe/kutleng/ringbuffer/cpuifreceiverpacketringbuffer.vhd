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
-- Module Name      : cpuifreceiverpacketringbuffer - rtl                      -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to create an assymetric dual packet  -
--                    ring buffer for CPU packet transfer.                     -
--                    The ring buffer operates using a (2**G_SLOT_WIDTH)-1     -
--                    buffer slots. On each slot the data size is              -
--                    ((G_DATA_MAX_WIDTH) * ((2**G_ADDR_MIN_WIDTH)-1))/8 bytes -
--                    It is also desirable to provide a ringbuffer fullness    -
--                    status, this can be used as a packet priority for        -
--                    consumers that consume data from the ring buffer. Zero   -
--                    fullness means the ringbuffer is empty, but when the     -
--                    fullness approaches (2**G_SLOT_WIDTH)-1 then the         -
--                    ringbuffer must be emptied urgently to avoid overflow.   -
-- Dependencies     : packetringbuffer,dualportpacketringbuffer                -
-- Revision History : V1.0 - Initial design                                    -
--                  : V1.1 - Changed architecure to use state machine to do the-
--                           data resize and enable mapping.                   -
--                           This is a better design as it saves BRAMS and LUTs-
--                           Vivado cannot infer BRAM of 8<=>512 aspect ratio. -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpuifreceiverpacketringbuffer is
    generic(
        G_SLOT_WIDTH             : natural := 4;
        constant G_RX_ADDR_WIDTH : natural := 5;
        constant G_TX_ADDR_WIDTH : natural := 11;
        constant G_RX_DATA_WIDTH : natural := 512;
        constant G_TX_DATA_WIDTH : natural := 8
    );
    port(
        RxClk                  : in  STD_LOGIC;
        TxClk                  : in  STD_LOGIC;
        Reset                  : in  STD_LOGIC;
        -- Reception port
        RxPacketByteEnable     : in  STD_LOGIC_VECTOR((G_RX_DATA_WIDTH / 8) - 1 downto 0);
        RxPacketDataWrite      : in  STD_LOGIC;
        RxPacketData           : in  STD_LOGIC_VECTOR(G_RX_DATA_WIDTH - 1 downto 0);
        RxPacketAddress        : in  STD_LOGIC_VECTOR(G_RX_ADDR_WIDTH - 1 downto 0);
        RxPacketSlotSet        : in  STD_LOGIC;
        RxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        RxPacketSlotStatus     : out STD_LOGIC;
        -- Transmission port
        TxPacketReadByteEnable : out STD_LOGIC_VECTOR((G_TX_DATA_WIDTH / 8) downto 0);
        TxPacketDataOut        : out STD_LOGIC_VECTOR(G_TX_DATA_WIDTH - 1 downto 0);
        TxPacketReadAddress    : in  STD_LOGIC_VECTOR(G_TX_ADDR_WIDTH - 1 downto 0);
        TxPacketDataRead       : in  STD_LOGIC;
        TxPacketSlotClear      : in  STD_LOGIC;
        TxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        TxPacketSlotStatus     : out STD_LOGIC
    );
end entity cpuifreceiverpacketringbuffer;

architecture rtl of cpuifreceiverpacketringbuffer is
    component packetringbuffer is
        generic(
            G_SLOT_WIDTH : natural := 4;
            G_ADDR_WIDTH : natural := 5;
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
            RxPacketSlotType       : in  STD_LOGIC;
            RxPacketSlotStatus     : out STD_LOGIC;
            RxPacketSlotTypeStatus : out STD_LOGIC
        );
    end component packetringbuffer;
    component cpudualportpacketringbuffer is
        generic(
            G_SLOT_WIDTH : natural := 4;
            G_ADDR_WIDTH : natural := 8;
            G_DATA_WIDTH : natural := 64
        );
        port(
            RxClk                  : in  STD_LOGIC;
            TxClk                  : in  STD_LOGIC;
            -- Transmission port
            TxPacketByteEnable     : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) downto 0);
            TxPacketDataRead       : in  STD_LOGIC;
            TxPacketData           : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            TxPacketAddress        : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            TxPacketSlotClear      : in  STD_LOGIC;
            TxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            TxPacketSlotStatus     : out STD_LOGIC;
            TxPacketSlotTypeStatus : out STD_LOGIC;
            -- Reception port
            RxPacketByteEnable     : in  STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) downto 0);
            RxPacketDataWrite      : in  STD_LOGIC;
            RxPacketData           : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            RxPacketAddress        : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            RxPacketSlotSet        : in  STD_LOGIC;
            RxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            RxPacketSlotType       : in  STD_LOGIC;
            RxPacketSlotStatus     : out STD_LOGIC;
            RxPacketSlotTypeStatus : out STD_LOGIC
        );
    end component cpudualportpacketringbuffer;
    type ReceiverPacketRingBufferSM_t is (
        InitialiseSt,                   -- On the reset state
        FindPresentSlotsSt,
        IngressFramingErrorSt,
        PullIngressDataSt,
        SaveIngressDataSt,
        WriteEgressDataSt,
        ClearAndSetSlotsSt,
        NextSlotsSt
    );
    signal StateVariable               : ReceiverPacketRingBufferSM_t := InitialiseSt;
    constant C_BYTE_INDEX_MAX          : natural                      := (G_RX_DATA_WIDTH / 8) - 1;
    constant C_FRAME_INDEX_MAX         : natural                      := (2**G_RX_ADDR_WIDTH) - 1;
    type PayLoadArray_t is array (0 to ((G_RX_DATA_WIDTH / 8) - 1)) of std_logic_vector(7 downto 0);
    -- Payload byte array to map bytes on 512 bit read buffer
    signal lRingBufferData             : PayLoadArray_t;
    signal lRingBufferDataEnable       : std_logic_vector(C_BYTE_INDEX_MAX downto 0);
    signal GNDBit                      : std_logic;
    signal IngressRingBufferDataEnable : std_logic_vector((G_RX_DATA_WIDTH / 8) - 1 downto 0);
    signal IngressRingBufferDataRead   : std_logic;
    signal IngressRingBufferDataOut    : std_logic_vector(G_RX_DATA_WIDTH - 1 downto 0);
    signal IngressRingBufferAddress    : std_logic_vector(G_RX_ADDR_WIDTH - 1 downto 0);
    signal IngressRingBufferSlotClear  : std_logic;
    signal IngressRingBufferSlotID     : unsigned(G_SLOT_WIDTH - 1 downto 0);
    signal IngressRingBufferSlotStatus : std_logic;

    signal EgressRingBufferDataEnable : std_logic_vector((G_TX_DATA_WIDTH / 8) downto 0);
    signal EgressRingBufferDataWrite  : std_logic;
    signal EgressRingBufferData       : std_logic_vector(G_TX_DATA_WIDTH - 1 downto 0);
    signal EgressRingBufferAddress    : unsigned(G_TX_ADDR_WIDTH - 1 downto 0);
    signal EgressRingBufferSlotSet    : std_logic;
    signal EgressRingBufferSlotID     : unsigned(G_SLOT_WIDTH - 1 downto 0);
    signal EgressRingBufferSlotStatus : std_logic;

    signal lFrameIndex : natural range 0 to C_FRAME_INDEX_MAX;
    signal lByteIndex  : natural range 0 to C_BYTE_INDEX_MAX;

begin
    GNDBit                   <= '0';
    IngressRingBufferAddress <= std_logic_vector(to_unsigned(lFrameIndex, G_RX_ADDR_WIDTH));
    IngressPacketBuffer_i : packetringbuffer
        generic map(
            G_SLOT_WIDTH => G_SLOT_WIDTH,
            G_ADDR_WIDTH => G_RX_ADDR_WIDTH,
            G_DATA_WIDTH => G_RX_DATA_WIDTH
        )
        port map(
            Clk                    => RxClk,
            -- Transmission port
            TxPacketByteEnable     => IngressRingBufferDataEnable,
            TxPacketDataRead       => IngressRingBufferDataRead,
            TxPacketData           => IngressRingBufferDataOut,
            TxPacketAddress        => IngressRingBufferAddress,
            TxPacketSlotClear      => IngressRingBufferSlotClear,
            TxPacketSlotID         => std_logic_vector(IngressRingBufferSlotID),
            TxPacketSlotStatus     => IngressRingBufferSlotStatus,
            TxPacketSlotTypeStatus => open,
            RxPacketByteEnable     => RxPacketByteEnable,
            RxPacketDataWrite      => RxPacketDataWrite,
            RxPacketData           => RxPacketData,
            RxPacketAddress        => RxPacketAddress,
            RxPacketSlotSet        => RxPacketSlotSet,
            RxPacketSlotID         => RxPacketSlotID,
            RxPacketSlotType       => GNDBit,
            RxPacketSlotStatus     => RxPacketSlotStatus,
            RxPacketSlotTypeStatus => open
        );

    EgressPacketBuffer_i : cpudualportpacketringbuffer
        generic map(
            G_SLOT_WIDTH => G_SLOT_WIDTH,
            G_ADDR_WIDTH => G_TX_ADDR_WIDTH,
            G_DATA_WIDTH => G_TX_DATA_WIDTH
        )
        port map(
            RxClk                  => RxClk,
            TxClk                  => TxClk,
            -- Transmission port
            TxPacketByteEnable     => TxPacketReadByteEnable,
            TxPacketDataRead       => TxPacketDataRead,
            TxPacketData           => TxPacketDataOut,
            TxPacketAddress        => TxPacketReadAddress,
            TxPacketSlotClear      => TxPacketSlotClear,
            TxPacketSlotID         => TxPacketSlotID,
            TxPacketSlotStatus     => TxPacketSlotStatus,
            TxPacketSlotTypeStatus => open,
            RxPacketByteEnable     => EgressRingBufferDataEnable,
            RxPacketDataWrite      => EgressRingBufferDataWrite,
            RxPacketData           => EgressRingBufferData,
            RxPacketAddress        => std_logic_vector(EgressRingBufferAddress),
            RxPacketSlotSet        => EgressRingBufferSlotSet,
            RxPacketSlotID         => std_logic_vector(EgressRingBufferSlotID),
            RxPacketSlotType       => GNDBit,
            RxPacketSlotStatus     => EgressRingBufferSlotStatus,
            RxPacketSlotTypeStatus => open
        );

    ----------------------------------------------------------------------------
    --                     Packet Resize State Machine                        --   
    ----------------------------------------------------------------------------
    -- This module is a 512 to 8 aspect ratio packet forwarding statemachine. --
    -- The module has two ring buffers Ingress (512:512) and Egress (8:8).    --
    -- A statemachine is used to narrow the transferes from 512 bits to 8 bits--
    -- The module does not need to be very fast as it captures data at line   --
    -- rate but send it via a ring buffer to a slow CPU.                      --
    ---------------------------------------------------------------------------- 

    SynchStateProc : process(TxClk)
    begin
        if rising_edge(TxClk) then
            if (Reset = '1') then

                StateVariable <= InitialiseSt;
            else
                case (StateVariable) is

                    when InitialiseSt =>

                        -- Wait for packet after initialization
                        StateVariable              <= FindPresentSlotsSt;
                        IngressRingBufferSlotID    <= (others => '0');
                        EgressRingBufferSlotID     <= (others => '0');
                        EgressRingBufferAddress    <= (others => '0');
                        IngressRingBufferDataRead  <= '0';
                        EgressRingBufferDataWrite  <= '0';
                        EgressRingBufferData       <= (others => '0');
                        EgressRingBufferDataEnable <= (others => '0');
                        EgressRingBufferSlotSet    <= '0';
                        IngressRingBufferSlotClear <= '0';
                        lFrameIndex                <= 0;
                        lByteIndex                 <= 0;

                    when FindPresentSlotsSt =>
                        if (IngressRingBufferSlotStatus = '1') then
                            -- There is a packet waiting on the ring buffer
                            -- Start from the base address to extract the packet
                            EgressRingBufferAddress   <= (others => '0');
                            IngressRingBufferDataRead <= '1';
                            lFrameIndex               <= 0;
                            StateVariable             <= PullIngressDataSt;
                        else
                            -- Keep searching for a packet
                            StateVariable <= FindPresentSlotsSt;
                        end if;
                    when PullIngressDataSt =>
                        EgressRingBufferDataWrite <= '0';

                        if (lFrameIndex = C_FRAME_INDEX_MAX) then
                            -- This is an error condition
                            -- How do we recover from error?
                            -- Clear the current slot and drop the incorrect framing packet 
                            IngressRingBufferSlotClear <= '1';
                            StateVariable              <= IngressFramingErrorSt;
                        else
                            IngressRingBufferDataRead <= '1';
                            StateVariable             <= SaveIngressDataSt;
                        end if;

                    when IngressFramingErrorSt =>
                        IngressRingBufferSlotClear <= '0';
                        IngressRingBufferSlotID    <= IngressRingBufferSlotID + 1;
                        StateVariable              <= FindPresentSlotsSt;

                    when SaveIngressDataSt =>
                        -- Save the data and the byte enable 
                        IngressRingBufferDataRead <= '0';
                        lRingBufferDataEnable     <= IngressRingBufferDataEnable;
                        for i in 0 to C_BYTE_INDEX_MAX loop
                            lRingBufferData(i) <= IngressRingBufferDataOut((8 * (i + 1)) - 1 downto (8 * i));
                        end loop;
                        -- Point to next Frame index
                        lFrameIndex               <= lFrameIndex + 1;
                        lByteIndex                <= 0;
                        StateVariable             <= WriteEgressDataSt;

                    when WriteEgressDataSt =>
                        EgressRingBufferDataWrite     <= '1';
                        if (lByteIndex = C_BYTE_INDEX_MAX) then
                            if (lRingBufferDataEnable(0) = '1') then
                                -- We are on the last byte enable and have TLAST
                                EgressRingBufferDataEnable(1) <= '1';
                                StateVariable                 <= ClearAndSetSlotsSt;
                            else
                                EgressRingBufferDataEnable(1) <= '0';
                                StateVariable                 <= PullIngressDataSt;
                            end if;
                        else
    	                    -- Point to next byte index
	                        lByteIndex                    <= lByteIndex + 1;
                            if ((lRingBufferDataEnable(0) = '1') and (lRingBufferDataEnable(lByteIndex + 1) = '0')) then
                                -- We are on the last byte enable and have TLAST
                                EgressRingBufferDataEnable(1) <= '1';
                                -- Done with packet output completely 
                                StateVariable                 <= ClearAndSetSlotsSt;
                            else
                                EgressRingBufferDataEnable(1) <= '0';
                                StateVariable                 <= WriteEgressDataSt;
                            end if;
                        end if;
                        -- Write the current byte out
                        EgressRingBufferData          <= lRingBufferData(lByteIndex);
                        EgressRingBufferDataEnable(0) <= lRingBufferDataEnable(lByteIndex);
                        -- Point to next egress buffer address
                        EgressRingBufferAddress       <= EgressRingBufferAddress + 1;

                    when ClearAndSetSlotsSt =>
                        -- Clear the ingress slot and and set the egress slot 
                        EgressRingBufferDataWrite  <= '0';
                        EgressRingBufferSlotSet    <= '1';
                        IngressRingBufferSlotClear <= '1';
                        StateVariable              <= NextSlotsSt;
                    when NextSlotsSt =>
                        EgressRingBufferSlotSet    <= '0';
                        IngressRingBufferSlotClear <= '0';
                        -- Search next slots  
                        EgressRingBufferSlotID     <= EgressRingBufferSlotID + 1;
                        IngressRingBufferSlotID    <= IngressRingBufferSlotID + 1;
                        StateVariable              <= FindPresentSlotsSt;
                    when others =>
                        StateVariable <= InitialiseSt;
                end case;
            end if;
        end if;
    end process SynchStateProc;

end architecture rtl;
