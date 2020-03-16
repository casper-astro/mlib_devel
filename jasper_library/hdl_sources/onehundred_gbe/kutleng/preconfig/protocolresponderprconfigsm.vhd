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
-- Module Name      : protocolresponderprconfigsm - rtl                        -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : The configcontroller module receives commands and frames -
--                    for partial reconfiguration and writes to the ICAPE3.    -
--                    The module doesn't check for errors or anything,it just  -
--                    writes the DWORD or the FRAME.It responds with a DWORD   -
--                    status that contains all the necessary errors or status  -
--                    of the partial reconfiguration operation.                -
--                                                                             -
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity protocolresponderprconfigsm is
    generic(
        G_SLOT_WIDTH : natural := 4;
        --G_UDP_SERVER_PORT : natural range 0 to ((2**16) - 1) := 5;
        -- The address width is log2(2048/(512/8))=5 bits wide
        G_ADDR_WIDTH : natural := 5
    );
    port(
        axis_clk                   : in  STD_LOGIC;
        axis_reset                 : in  STD_LOGIC;
        -- Source IP Addressing information
        ServerMACAddress           : in  STD_LOGIC_VECTOR(47 downto 0);
        ServerIPAddress            : in  STD_LOGIC_VECTOR(31 downto 0);
        ServerUDPPort              : in  STD_LOGIC_VECTOR(15 downto 0);
        -- Response IP Addressing information
        ClientMACAddress           : in  STD_LOGIC_VECTOR(47 downto 0);
        ClientIPAddress            : in  STD_LOGIC_VECTOR(31 downto 0);
        ClientUDPPort              : in  STD_LOGIC_VECTOR(15 downto 0);
        -- Packet Readout in addressed bus format
        SenderRingBufferSlotID     : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        SenderRingBufferSlotSet    : out STD_LOGIC;
        SenderRingBufferSlotType   : out STD_LOGIC;
        SenderRingBufferDataWrite  : out STD_LOGIC;
        -- Enable[0] is a special bit (we assume always 1 when packet is valid)
        -- we use it to save TLAST
        SenderRingBufferDataEnable : out STD_LOGIC_VECTOR(63 downto 0);
        SenderRingBufferDataOut    : out STD_LOGIC_VECTOR(511 downto 0);
        SenderRingBufferAddress    : out STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
        -- Handshaking signals
        -- Status signal to show when the packet sender is busy
        SenderBusy                 : out STD_LOGIC;
        -- Protocol Error
        ProtocolError              : in  STD_LOGIC;
        ProtocolErrorClear         : out STD_LOGIC;
        ProtocolErrorID            : in  STD_LOGIC_VECTOR(31 downto 0);
        ProtocolIPIdentification   : in  STD_LOGIC_VECTOR(15 downto 0);
        ProtocolID                 : in  STD_LOGIC_VECTOR(15 downto 0);
        ProtocolSequence           : in  STD_LOGIC_VECTOR(31 downto 0);
        -- ICAP Writer Response
        ICAPWriteDone              : in  STD_LOGIC;
        ICAPWriteResponseSent      : out STD_LOGIC;
        ICAPIPIdentification       : in  STD_LOGIC_VECTOR(15 downto 0);
        ICAPProtocolID             : in  STD_LOGIC_VECTOR(15 downto 0);
        ICAPProtocolSequence       : in  STD_LOGIC_VECTOR(31 downto 0);
        --ICAPE3 interface
        axis_prog_full             : in  STD_LOGIC;
        axis_prog_empty            : in  STD_LOGIC;
        axis_data_count            : in  STD_LOGIC_VECTOR(13 downto 0);
        ICAP_FilledSlots           : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        ICAP_PRDONE                : in  STD_LOGIC;
        ICAP_PRERROR               : in  STD_LOGIC;
        ICAP_Readback              : in  STD_LOGIC_VECTOR(31 downto 0)
    );
end entity protocolresponderprconfigsm;

architecture rtl of protocolresponderprconfigsm is

    type ConfigurationControllerSM_t is (
        InitialiseSt,                   -- On the reset state
        CheckProtocolICAPSt,
        AcknowledgeProtocolSt,
        AcknowledgeICAPSt,
        CheckAddressingChangesSt,
        PrecomputeHeaderCheckSumSt,
        ComposeResponsePacketSt,
        GenerateUDPIPCheckSumSt,
        WriteUDPResponceSt,
        NextSlotsSt
    );
    signal StateVariable : ConfigurationControllerSM_t := InitialiseSt;
    constant C_DWORD_MAX : natural                     := (16 - 1);

    constant C_RESPONSE_UDP_LENGTH    : std_logic_vector(15 downto 0) := X"0012"; --was 12
    constant C_RESPONSE_IPV4_LENGTH   : std_logic_vector(15 downto 0) := X"0026"; --was 26
    constant C_RESPONSE_ETHER_TYPE    : std_logic_vector(15 downto 0) := X"0800";
    constant C_RESPONSE_IPV4IHL       : std_logic_vector(7 downto 0)  := X"45";
    constant C_RESPONSE_DSCPECN       : std_logic_vector(7 downto 0)  := X"00";
    constant C_RESPONSE_FLAGS_OFFSET  : std_logic_vector(15 downto 0) := X"4000";
    constant C_RESPONSE_TIME_TO_LEAVE : std_logic_vector(7 downto 0)  := X"40";
    constant C_RESPONSE_UDP_PROTOCOL  : std_logic_vector(7 downto 0)  := X"11";

    -- Tuples registers
    signal lRingBufferData          : std_logic_vector(511 downto 0);
    signal lSenderRingBufferSlotID  : unsigned(G_SLOT_WIDTH - 1 downto 0);
    signal lSenderRingBufferAddress : unsigned(G_ADDR_WIDTH - 1 downto 0);

    alias lDestinationMACAddress    : std_logic_vector(47 downto 0) is lRingBufferData(47 downto 0);
    alias lSourceMACAddress         : std_logic_vector(47 downto 0) is lRingBufferData(95 downto 48);
    alias lEtherType                : std_logic_vector(15 downto 0) is lRingBufferData(111 downto 96);
    alias lIPVIHL                   : std_logic_vector(7  downto 0) is lRingBufferData(119 downto 112);
    alias lDSCPECN                  : std_logic_vector(7  downto 0) is lRingBufferData(127 downto 120);
    alias lTotalLength              : std_logic_vector(15 downto 0) is lRingBufferData(143 downto 128);
    alias lIdentification           : std_logic_vector(15 downto 0) is lRingBufferData(159 downto 144);
    alias lFlagsOffset              : std_logic_vector(15 downto 0) is lRingBufferData(175 downto 160);
    alias lTimeToLeave              : std_logic_vector(7  downto 0) is lRingBufferData(183 downto 176);
    alias lProtocol                 : std_logic_vector(7  downto 0) is lRingBufferData(191 downto 184);
    alias lIPHeaderChecksum         : std_logic_vector(15 downto 0) is lRingBufferData(207 downto 192);
    alias lSourceIPAddress          : std_logic_vector(31 downto 0) is lRingBufferData(239 downto 208);
    alias lDestinationIPAddress     : std_logic_vector(31 downto 0) is lRingBufferData(271 downto 240);
    alias lSourceUDPPort            : std_logic_vector(15 downto 0) is lRingBufferData(287 downto 272);
    alias lDestinationUDPPort       : std_logic_vector(15 downto 0) is lRingBufferData(303 downto 288);
    alias lUDPDataStreamLength      : std_logic_vector(15 downto 0) is lRingBufferData(319 downto 304);
    alias lUDPCheckSum              : std_logic_vector(15 downto 0) is lRingBufferData(335 downto 320);
    alias lPRPacketID               : std_logic_vector(15 downto 0) is lRingBufferData(351 downto 336);
    alias lPRPacketSequence         : std_logic_vector(31 downto 0) is lRingBufferData(383 downto 352);
    alias lPRDWordCommand           : std_logic_vector(31 downto 0) is lRingBufferData(415 downto 384);
    --    alias lPRFIFOState              : std_logic_vector(15 downto 0) is lRingBufferData(367 downto 352);
    --    alias lPRPacketSequence         : std_logic_vector(31 downto 0) is lRingBufferData(399 downto 368);
    --    alias lPRDWordCommand           : std_logic_vector(31 downto 0) is lRingBufferData(431 downto 400);
    signal lIPHDRCheckSum           : unsigned(16 downto 0);
    signal lPreIPHDRCheckSum        : unsigned(17 downto 0);
    signal lUDPHDRCheckSum          : unsigned(17 downto 0);
    signal lPreUDPHDRCheckSum       : unsigned(17 downto 0);
    signal lServerMACAddress        : std_logic_vector(47 downto 0);
    signal lServerMACAddressChanged : std_logic;
    signal lServerIPAddress         : std_logic_vector(31 downto 0);
    signal lServerIPAddressChanged  : std_logic;
    signal lServerUDPPort           : std_logic_vector(15 downto 0);
    signal lServerUDPPortChanged    : std_logic;
    signal lClientMACAddress        : std_logic_vector(47 downto 0);
    signal lClientMACAddressChanged : std_logic;
    signal lClientIPAddress         : std_logic_vector(31 downto 0);
    signal lClientIPAddressChanged  : std_logic;
    signal lClientUDPPort           : std_logic_vector(15 downto 0);
    signal lClientUDPPortChanged    : std_logic;
    signal lAddressingChanged       : std_logic;
    signal lICAP_PRDONE             : std_logic;
    signal lICAP_PRERROR            : std_logic;
    signal laxis_prog_full          : std_logic;
    signal laxis_prog_empty         : std_logic;
    signal lProtocolErrorStatus     : std_logic;
    signal lIPIdentification        : unsigned(15 downto 0);
    signal lPacketID                : std_logic_vector(15 downto 0);
    signal lFIFOState               : std_logic_vector(15 downto 0);
    signal lPacketSequence          : std_logic_vector(31 downto 0);
    signal lPacketDWORDCommand      : std_logic_vector(31 downto 0);
    signal lCheckSumCounter         : natural range 0 to C_DWORD_MAX;

    -- The left over is 22 bytes
    function byteswap(DataIn : in unsigned)
    return unsigned is
        variable RData48 : unsigned(47 downto 0);
        variable RData32 : unsigned(31 downto 0);
        variable RData24 : unsigned(23 downto 0);
        variable RData16 : unsigned(15 downto 0);
    begin
        if (DataIn'length = RData48'length) then
            RData48(7 downto 0)   := DataIn((47 + DataIn'right) downto (40 + DataIn'right));
            RData48(15 downto 8)  := DataIn((39 + DataIn'right) downto (32 + DataIn'right));
            RData48(23 downto 16) := DataIn((31 + DataIn'right) downto (24 + DataIn'right));
            RData48(31 downto 24) := DataIn((23 + DataIn'right) downto (16 + DataIn'right));
            RData48(39 downto 32) := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData48(47 downto 40) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return unsigned(RData48);
        end if;
        if (DataIn'length = RData32'length) then
            RData32(7 downto 0)   := DataIn((31 + DataIn'right) downto (24 + DataIn'right));
            RData32(15 downto 8)  := DataIn((23 + DataIn'right) downto (16 + DataIn'right));
            RData32(23 downto 16) := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData32(31 downto 24) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return unsigned(RData32);
        end if;
        if (DataIn'length = RData24'length) then
            RData24(7 downto 0)   := DataIn((23 + DataIn'right) downto (16 + DataIn'right));
            RData24(15 downto 8)  := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData24(23 downto 16) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return unsigned(RData24);
        end if;
        if (DataIn'length = RData16'length) then
            RData16(7 downto 0)  := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData16(15 downto 8) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return unsigned(RData16);
        end if;
    end byteswap;

    function byteswap(DataIn : in std_logic_vector)
    return std_logic_vector is
        variable RData48 : std_logic_vector(47 downto 0);
        variable RData32 : std_logic_vector(31 downto 0);
        variable RData24 : std_logic_vector(23 downto 0);
        variable RData16 : std_logic_vector(15 downto 0);
    begin
        if (DataIn'length = RData48'length) then
            RData48(7 downto 0)   := DataIn((47 + DataIn'right) downto (40 + DataIn'right));
            RData48(15 downto 8)  := DataIn((39 + DataIn'right) downto (32 + DataIn'right));
            RData48(23 downto 16) := DataIn((31 + DataIn'right) downto (24 + DataIn'right));
            RData48(31 downto 24) := DataIn((23 + DataIn'right) downto (16 + DataIn'right));
            RData48(39 downto 32) := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData48(47 downto 40) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return std_logic_vector(RData48);
        end if;
        if (DataIn'length = RData32'length) then
            RData32(7 downto 0)   := DataIn((31 + DataIn'right) downto (24 + DataIn'right));
            RData32(15 downto 8)  := DataIn((23 + DataIn'right) downto (16 + DataIn'right));
            RData32(23 downto 16) := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData32(31 downto 24) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return std_logic_vector(RData32);
        end if;
        if (DataIn'length = RData24'length) then
            RData24(7 downto 0)   := DataIn((23 + DataIn'right) downto (16 + DataIn'right));
            RData24(15 downto 8)  := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData24(23 downto 16) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return std_logic_vector(RData24);
        end if;
        if (DataIn'length = RData16'length) then
            RData16(7 downto 0)  := DataIn((15 + DataIn'right) downto (8 + DataIn'right));
            RData16(15 downto 8) := DataIn((7 + DataIn'right) downto (0 + DataIn'right));
            return std_logic_vector(RData16);
        end if;
    end byteswap;

    function bitreverse(DataIn : std_logic_vector) return std_logic_vector is
        alias aDataIn  : std_logic_vector ((DataIn'length - 1) downto 0) is DataIn;
        variable RData : std_logic_vector(aDataIn'range);
    begin
        for i in aDataIn'range loop
            RData(i) := aDataIn(aDataIn'left - i);
        end loop;

        return RData;
    end function bitreverse;

    function bitbyteswap(DataIn : in std_logic_vector)
    return std_logic_vector is
        variable RData48 : std_logic_vector(47 downto 0);
        variable RData32 : std_logic_vector(31 downto 0);
        variable RData24 : std_logic_vector(23 downto 0);
        variable RData16 : std_logic_vector(15 downto 0);
    begin
        if (DataIn'length = RData48'length) then
            RData48(7 downto 0)   := bitreverse(DataIn((47 + DataIn'right) downto (40 + DataIn'right)));
            RData48(15 downto 8)  := bitreverse(DataIn((39 + DataIn'right) downto (32 + DataIn'right)));
            RData48(23 downto 16) := bitreverse(DataIn((31 + DataIn'right) downto (24 + DataIn'right)));
            RData48(31 downto 24) := bitreverse(DataIn((23 + DataIn'right) downto (16 + DataIn'right)));
            RData48(39 downto 32) := bitreverse(DataIn((15 + DataIn'right) downto (8 + DataIn'right)));
            RData48(47 downto 40) := bitreverse(DataIn((7 + DataIn'right) downto (0 + DataIn'right)));
            return std_logic_vector(RData48);
        end if;
        if (DataIn'length = RData32'length) then
            RData32(7 downto 0)   := bitreverse(DataIn((31 + DataIn'right) downto (24 + DataIn'right)));
            RData32(15 downto 8)  := bitreverse(DataIn((23 + DataIn'right) downto (16 + DataIn'right)));
            RData32(23 downto 16) := bitreverse(DataIn((15 + DataIn'right) downto (8 + DataIn'right)));
            RData32(31 downto 24) := bitreverse(DataIn((7 + DataIn'right) downto (0 + DataIn'right)));
            return std_logic_vector(RData32);
        end if;
        if (DataIn'length = RData24'length) then
            RData24(7 downto 0)   := bitreverse(DataIn((23 + DataIn'right) downto (16 + DataIn'right)));
            RData24(15 downto 8)  := bitreverse(DataIn((15 + DataIn'right) downto (8 + DataIn'right)));
            RData24(23 downto 16) := bitreverse(DataIn((7 + DataIn'right) downto (0 + DataIn'right)));
            return std_logic_vector(RData24);
        end if;
        if (DataIn'length = RData16'length) then
            RData16(7 downto 0)  := bitreverse(DataIn((15 + DataIn'right) downto (8 + DataIn'right)));
            RData16(15 downto 8) := bitreverse(DataIn((7 + DataIn'right) downto (0 + DataIn'right)));
            return std_logic_vector(RData16);
        end if;
    end function bitbyteswap;

begin

    SenderRingBufferSlotID  <= std_logic_vector(lSenderRingBufferSlotID);
    SenderRingBufferAddress <= std_logic_vector(lSenderRingBufferAddress);

    AddressingChangeProc : process(axis_clk)
    begin
        if (rising_edge(axis_clk)) then

            if (lServerMACAddress = ServerMACAddress) then
                lServerMACAddressChanged <= '0';
            else
                -- Flag the change of MAC address
                lServerMACAddressChanged <= '1';
            end if;

            if (lServerIPAddress = ServerIPAddress) then
                lServerIPAddressChanged <= '0';
            else
                -- Flag the change of IP address
                lServerIPAddressChanged <= '1';
            end if;

            if (lServerUDPPort = ServerUDPPort) then
                lServerUDPPortChanged <= '0';
            else
                -- Flag the change of port
                lServerUDPPortChanged <= '1';
            end if;

            if (lClientMACAddress = ClientMACAddress) then
                lClientMACAddressChanged <= '0';
            else
                -- Flag the change of MAC address
                lClientMACAddressChanged <= '1';
            end if;

            if (lClientIPAddress = ClientIPAddress) then
                lClientIPAddressChanged <= '0';
            else
                -- Flag the change of IP address
                lClientIPAddressChanged <= '1';
            end if;

            if (lClientUDPPort = ClientUDPPort) then
                lClientUDPPortChanged <= '0';
            else
                -- Flag the change of port
                lClientUDPPortChanged <= '1';
            end if;

            lAddressingChanged <= lClientUDPPortChanged or lClientIPAddressChanged or lClientMACAddressChanged or lServerUDPPortChanged or lServerIPAddressChanged or lServerMACAddressChanged;

        end if;
    end process AddressingChangeProc;

    SynchStateProc : process(axis_clk)
    begin
        if rising_edge(axis_clk) then

            if (axis_reset = '1') then

                StateVariable <= InitialiseSt;
            else
                case (StateVariable) is

                    when InitialiseSt =>

                        -- Wait for packet after initialization
                        StateVariable             <= CheckProtocolICAPSt;
                        lSenderRingBufferSlotID   <= (others => '0');
                        lSenderRingBufferAddress  <= (others => '0');
                        -- Reset the packet data to null
                        lRingBufferData           <= (others => '0');
                        SenderRingBufferDataWrite <= '0';
                        SenderRingBufferSlotSet   <= '0';
                        SenderRingBufferSlotType  <= '0';

                        lICAP_PRDONE         <= '0';
                        lICAP_PRERROR        <= '0';
                        lProtocolErrorStatus <= '0';
                        lCheckSumCounter     <= 0;
                        SenderBusy           <= '0';

                    when CheckProtocolICAPSt =>
                        SenderBusy       <= '0';
                        lCheckSumCounter <= 0;
                        if (ProtocolError = '1') then

                            -- There is a protocol error
                            ProtocolErrorClear   <= '1';
                            lProtocolErrorStatus <= '1';
                            lPacketSequence      <= ProtocolSequence;
                            lPacketDWORDCommand  <= ProtocolErrorID;
                            lIPIdentification    <= unsigned(ProtocolIPIdentification); -- Dont increment identification + 1;
                            StateVariable        <= AcknowledgeProtocolSt;

                        else

                            if (ICAPWriteDone = '1') then

                                ICAPWriteResponseSent <= '1';
                                lICAP_PRDONE          <= ICAP_PRDONE;
                                lICAP_PRERROR         <= ICAP_PRERROR;
                                lPacketDWORDCommand   <= ICAP_Readback;
                                laxis_prog_full       <= axis_prog_full;
                                laxis_prog_empty      <= axis_prog_empty;
                                lPacketSequence       <= ICAPProtocolSequence;
                                lIPIdentification     <= unsigned(ICAPIPIdentification); -- Dont increment identification  + 1;
                                StateVariable         <= AcknowledgeICAPSt;

                            else

                                StateVariable <= CheckProtocolICAPSt;

                            end if;

                        end if;

                    when AcknowledgeProtocolSt =>
                        -- Signal the busy status of the packet responder
                        SenderBusy <= '1';

                        lPacketID <= lProtocolErrorStatus & ProtocolID(14 downto 0);

                        if (ProtocolError = '1') then
                            StateVariable <= AcknowledgeProtocolSt;
                        else
                            ProtocolErrorClear <= '0';
                            StateVariable      <= ComposeResponsePacketSt;
                        end if;

                    when AcknowledgeICAPSt =>
                        -- Signal the busy status of the packet responder
                        SenderBusy <= '1';
                        -- Send the fifo status
                        lPacketID  <= ICAP_FilledSlots & lICAP_PRERROR & lICAP_PRDONE & laxis_prog_full & laxis_prog_empty & ICAPProtocolID(13 - G_SLOT_WIDTH - 2 downto 0);
                        lFIFOState <= laxis_prog_full & laxis_prog_empty & axis_data_count(13 downto 0);
                        if (ICAPWriteDone = '1') then
                            StateVariable <= AcknowledgeICAPSt;
                        else
                            ICAPWriteResponseSent <= '0';
                            StateVariable         <= ComposeResponsePacketSt;
                        end if;

                    when ComposeResponsePacketSt =>
                        --------------------------------------------------------
                        --                  Ethernet Header                    -
                        --------------------------------------------------------                        
                        -- Swap the source and destination MACS
                        lDestinationMACAddress          <= byteswap(ClientMACAddress);
                        lSourceMACAddress               <= byteswap(ServerMACAddress);
                        lEtherType                      <= byteswap(C_RESPONSE_ETHER_TYPE);
                        --------------------------------------------------------
                        --                   IPV4 Header                       -
                        --------------------------------------------------------                         
                        lIPVIHL                         <= C_RESPONSE_IPV4IHL;
                        lDSCPECN                        <= C_RESPONSE_DSCPECN;
                        lTotalLength                    <= byteswap(C_RESPONSE_IPV4_LENGTH);
                        lIdentification                 <= byteswap(std_logic_vector(lIPIdentification));
                        lFlagsOffset                    <= byteswap(C_RESPONSE_FLAGS_OFFSET);
                        lTimeToLeave                    <= C_RESPONSE_TIME_TO_LEAVE;
                        lProtocol                       <= C_RESPONSE_UDP_PROTOCOL;
                        -- The checksum must change now
                        lIPHeaderChecksum               <= (others => '0');
                        -- Swap the IP Addresses
                        lDestinationIPAddress           <= byteswap(ClientIPAddress);
                        lSourceIPAddress                <= byteswap(ServerIPAddress);
                        -- Swap the ports
                        lDestinationUDPPort             <= byteswap(ClientUDPPort);
                        lSourceUDPPort                  <= byteswap(ServerUDPPort);
                        -- Change the UDP length
                        -- TODO Set the UDP Packet length
                        lUDPDataStreamLength            <= byteswap(C_RESPONSE_UDP_LENGTH);
                        -- The UDP Checksum must change or can put to zero
                        lUDPCheckSum                    <= (others => '0');
                        -- These three will be overwritten later
                        -- The response PacketID
                        lPRPacketID                     <= byteswap(lPacketID);
                        --                        lPRFIFOState                    <= byteswap(lFIFOState);
                        -- The response Packet Sequence
                        lPRPacketSequence               <= byteswap(lPacketSequence);
                        -- The response Configuration Status
                        lPRDWordCommand                 <= byteswap(lPacketDWORDCommand);
                        -- Rest of data is zeros
                        lRingBufferData(511 downto 416) <= (others => '0');
                        -- Go to check if dressing has changed
                        StateVariable                   <= CheckAddressingChangesSt;

                    when CheckAddressingChangesSt =>

                        if (lAddressingChanged = '1') then
                            -- Save the new addressing as it has changed.
                            lServerMACAddress <= byteswap(ServerMACAddress);
                            lServerIPAddress  <= byteswap(ServerIPAddress);
                            lServerUDPPort    <= byteswap(ServerUDPPort);
                            lClientMACAddress <= byteswap(ClientMACAddress);
                            lClientIPAddress  <= byteswap(ClientIPAddress);
                            lClientUDPPort    <= byteswap(ClientUDPPort);
                            StateVariable     <= PrecomputeHeaderCheckSumSt;
                        else
                            StateVariable <= GenerateUDPIPCheckSumSt;
                        end if;

                    when PrecomputeHeaderCheckSumSt =>
                        if (lCheckSumCounter = 9) then
                            lCheckSumCounter <= 0;
                            StateVariable    <= GenerateUDPIPCheckSumSt;
                        else
                            lCheckSumCounter <= lCheckSumCounter + 1;
                            StateVariable    <= PrecomputeHeaderCheckSumSt;
                        end if;

                        case (lCheckSumCounter) is
                            when 0 =>
                                lPreUDPHDRCheckSum <= '0' & '0' & unsigned(byteswap(lDestinationIPAddress(15 downto 0)));
                                lPreIPHDRCheckSum  <= '0' & '0' & unsigned(byteswap(lDestinationIPAddress(15 downto 0)));

                            when 1 =>
                                lPreUDPHDRCheckSum(16 downto 0) <= ('0' & lPreUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lDestinationIPAddress(31 downto 16)))) + lPreUDPHDRCheckSum(17 downto 16);
                                lPreIPHDRCheckSum(16 downto 0)  <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lDestinationIPAddress(31 downto 16)))) + lPreIPHDRCheckSum(17 downto 16);

                            when 2 =>
                                lPreUDPHDRCheckSum(16 downto 0) <= ('0' & lPreUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lSourceIPAddress(15 downto 0)))) + lPreUDPHDRCheckSum(17 downto 16);
                                lPreIPHDRCheckSum(16 downto 0)  <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lSourceIPAddress(15 downto 0)))) + lPreIPHDRCheckSum(17 downto 16);

                            when 3 =>
                                lPreUDPHDRCheckSum(16 downto 0) <= ('0' & lPreUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lSourceIPAddress(31 downto 16)))) + lPreUDPHDRCheckSum(17 downto 16);
                                lPreIPHDRCheckSum(16 downto 0)  <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lSourceIPAddress(31 downto 16)))) + lPreIPHDRCheckSum(17 downto 16);

                            when 4 =>
                                lPreUDPHDRCheckSum(16 downto 0) <= ('0' & lPreUDPHDRCheckSum(15 downto 0)) + unsigned(C_RESPONSE_UDP_PROTOCOL) + lPreUDPHDRCheckSum(17 downto 16);
                                lPreIPHDRCheckSum(16 downto 0)  <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + (unsigned(C_RESPONSE_TIME_TO_LEAVE) & unsigned(C_RESPONSE_UDP_PROTOCOL)) + lPreIPHDRCheckSum(17 downto 16);

                            when 5 =>
                                lPreUDPHDRCheckSum(16 downto 0) <= ('0' & lPreUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(C_RESPONSE_UDP_LENGTH)) + lPreUDPHDRCheckSum(17 downto 16);
                                lPreIPHDRCheckSum(16 downto 0)  <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + ('0' & unsigned(C_RESPONSE_FLAGS_OFFSET)) + lPreIPHDRCheckSum(17 downto 16);

                            when 6 =>
                                lPreIPHDRCheckSum(16 downto 0) <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + ('0' & unsigned(C_RESPONSE_IPV4_LENGTH)) + lPreIPHDRCheckSum(17 downto 16);

                            when 7 =>
                                lPreIPHDRCheckSum(16 downto 0) <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + ('0' & unsigned(C_RESPONSE_IPV4IHL) & unsigned(C_RESPONSE_DSCPECN)) + lPreIPHDRCheckSum(17 downto 16);

                            when others =>
                                null;
                        end case;

                    when GenerateUDPIPCheckSumSt =>
                        if (lCheckSumCounter = 11) then
                            lCheckSumCounter         <= 0;
                            lSenderRingBufferAddress <= (others => '0');
                            SenderRingBufferDataOut  <= lRingBufferData;
                            StateVariable            <= WriteUDPResponceSt;
                        else
                            lCheckSumCounter <= lCheckSumCounter + 1;
                            StateVariable    <= GenerateUDPIPCheckSumSt;
                        end if;

                        case (lCheckSumCounter) is
                            when 0 =>
                                lIPHDRCheckSum  <= ('0' & lPreIPHDRCheckSum(15 downto 0)) + ('0' & unsigned(lIPIdentification)) + lPreIPHDRCheckSum(17 downto 16);
                                lUDPHDRCheckSum <= lPreUDPHDRCheckSum;

                            when 1 =>
                                if (lIPHDRCheckSum(16) = '1') then
                                    lIPHDRCheckSum(15 downto 0) <= lIPHDRCheckSum(15 downto 0) + 1;
                                end if;
                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(C_RESPONSE_UDP_LENGTH)) + lUDPHDRCheckSum(17 downto 16);
                            when 2 =>
                                if (lIPHDRCheckSum(15 downto 0) /= X"FFFF") then
                                    lIPHeaderChecksum <= not (byteswap(std_logic_vector(lIPHDRCheckSum(15 downto 0))));
                                else
                                    lIPHeaderChecksum <= byteswap(std_logic_vector(lIPHDRCheckSum(15 downto 0)));
                                end if;
                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(lPacketID)) + lUDPHDRCheckSum(17 downto 16);
                            when 3 =>

                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(lPacketSequence(31 downto 16))) + lUDPHDRCheckSum(17 downto 16);
                            when 4 =>
                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(lPacketSequence(15 downto 0))) + lUDPHDRCheckSum(17 downto 16);
                            when 5 =>
                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(lPacketDWordCommand(31 downto 16))) + lUDPHDRCheckSum(17 downto 16);
                            when 6 =>
                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(lPacketDWordCommand(15 downto 0))) + lUDPHDRCheckSum(17 downto 16);
                            when 7 =>
                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lSourceUDPPort))) + lUDPHDRCheckSum(17 downto 16);
                            when 8 =>
                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(byteswap(lDestinationUDPPort))) + lUDPHDRCheckSum(17 downto 16);
                            --                            when 9 =>
                            --                                lUDPHDRCheckSum(16 downto 0) <= ('0' & lUDPHDRCheckSum(15 downto 0)) + ('0' & unsigned(lFIFOState)) + lUDPHDRCheckSum(17 downto 16);
                            when 9 =>
                                if (lUDPHDRCheckSum(16) = '1') then
                                    lUDPHDRCheckSum(15 downto 0) <= lUDPHDRCheckSum(15 downto 0) + 1;
                                end if;
                            when 10 =>
                                if (lUDPHDRCheckSum(15 downto 0) /= X"FFFF") then
                                    lUDPCheckSum <= not (byteswap(std_logic_vector(lUDPHDRCheckSum(15 downto 0))));
                                else
                                    lUDPCheckSum <= byteswap(std_logic_vector(lUDPHDRCheckSum(15 downto 0)));
                                end if;
                            when others =>
                                null;
                        end case;

                    when WriteUDPResponceSt =>
                        -- Set the transmitter slot
                        SenderRingBufferSlotSet    <= '1';
                        SenderRingBufferSlotType   <= '1';
                        -- Save the return packet
                        SenderRingBufferDataEnable <= X"0fffffffffffffff";
                        -- Write the response packet to the Ringbuffer                        
                        SenderRingBufferDataWrite  <= '1';
                        -- Go to the next slots so that the system
                        -- can progress on the systems slots
                        StateVariable              <= NextSlotsSt;

                    when NextSlotsSt =>
                        -- Transmitter
                        lSenderRingBufferSlotID    <= lSenderRingBufferSlotID + 1;
                        lSenderRingBufferAddress   <= lSenderRingBufferAddress + 1;
                        SenderRingBufferDataEnable <= (others => '0');
                        SenderRingBufferDataOut    <= (others => '0');
                        SenderRingBufferSlotSet    <= '0';
                        SenderRingBufferDataWrite  <= '0';
                        -- Go to check to see if there has been a ready response
                        -- packet from ICAP or Packet Error
                        StateVariable              <= CheckProtocolICAPSt;

                    when others =>
                        StateVariable <= InitialiseSt;
                end case;
            end if;
        end if;
    end process SynchStateProc;

end architecture rtl;
