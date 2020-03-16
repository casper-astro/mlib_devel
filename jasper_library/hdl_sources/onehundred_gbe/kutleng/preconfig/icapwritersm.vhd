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
-- Module Name      : icapwritersm - rtl                                       -
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

entity icapwritersm is
    generic(
        G_SLOT_WIDTH : natural := 4;
        --G_UDP_SERVER_PORT : natural range 0 to ((2**16) - 1) := 5;
        -- The address width is log2(2048/(512/8))=5 bits wide
        G_ADDR_WIDTH : natural := 7
    );
    port(
        axis_clk                 : in  STD_LOGIC;
        axis_reset               : in  STD_LOGIC;
        -- Packet Write in addressed bus format
        -- Packet Readout in addressed bus format
        RingBufferSlotID         : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        RingBufferSlotClear      : out STD_LOGIC;
        RingBufferSlotStatus     : in  STD_LOGIC;
        RingBufferSlotTypeStatus : in  STD_LOGIC;
        RingBufferDataRead       : out STD_LOGIC;
        -- Enable[0] is a special bit (we assume always 1 when packet is valid)
        -- we use it to save TLAST
        RingBufferDataEnable     : in  STD_LOGIC_VECTOR(3 downto 0);
        RingBufferDataIn         : in  STD_LOGIC_VECTOR(31 downto 0);
        RingBufferAddress        : out STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
        -- Handshaking signals
        -- Status signal to show when the packet sender is busy
        SenderBusy               : in  STD_LOGIC;
        -- ICAP Writer Response
        ICAPWriteDone            : out STD_LOGIC;
        ICAPWriteResponseSent    : in  STD_LOGIC;
        ICAPIPIdentification     : out STD_LOGIC_VECTOR(15 downto 0);
        ICAPProtocolID           : out STD_LOGIC_VECTOR(15 downto 0);
        ICAPProtocolSequence     : out STD_LOGIC_VECTOR(31 downto 0);
        --Inputs from AXIS bus of the MAC side
        --ICAPE3 interface
        axis_prog_full           : in  STD_LOGIC;
        axis_data_count          : in  STD_LOGIC_VECTOR(13 downto 0);
        ICAP_CSIB                : out STD_LOGIC;
        ICAP_RDWRB               : out STD_LOGIC;
        ICAP_AVAIL               : in  STD_LOGIC;
        ICAP_DataIn              : out STD_LOGIC_VECTOR(31 downto 0);
        ICAP_DataOut             : in  STD_LOGIC_VECTOR(31 downto 0);
        ICAP_Readback            : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity icapwritersm;

architecture rtl of icapwritersm is

    type ConfigurationControllerSM_t is (
        InitialiseSt,                   -- On the reset state
        CheckSlotSt,
        NextSlotSt,
        ReadHeaderSt,
        SaveHeaderSt,
        ReadSequenceSt,
        SaveSequenceSt,
        ReadDWORDCommandSt,
        ICAPWriteDWORDCommandSt,
        ICAPPrepareWriteDWORDCommandSt,
        ICAPPurgeDWORDCommandSt,
        WriteFrameDWORDSt,
        ClearSlotSt,
        WaitICAPResponse,
        WaitICAPReadResponseSt,
        WaitICAPReadResponseASt,
        WaitICAPReadResponseBSt,
        CreateErrorResponseSt,
        SendICAPResponseSt
    );
    signal StateVariable          : ConfigurationControllerSM_t   := InitialiseSt;
    constant C_ICAP_NOP_COMMAND   : std_logic_vector(31 downto 0) := X"20000000";
    -- There are 98 DWORDS on the FRAME Sequence
    constant C_FRAME_DWORD_MAX    : natural                       := (98 - 1);
    constant C_DFRAME_DWORD_MAX   : natural                       := (246 - 1);
    signal lFrameDWORDCounter     : natural range 0 to C_DFRAME_DWORD_MAX;
    signal lCommandHeader         : std_logic_Vector(31 downto 0);
    signal lCommandSequence       : std_logic_vector(31 downto 0);
    alias lCommandDWORD           : std_logic_vector(31 downto 0) is RingBufferDataIn;
    signal lRecvRingBufferSlotID  : unsigned(G_SLOT_WIDTH - 1 downto 0);
    signal lRecvRingBufferAddress : unsigned(G_ADDR_WIDTH - 1 downto 0);
    signal lICAP_CSIB             : std_logic;
    signal lICAP_RDWRB            : std_logic;

    function bitreverse(DataIn : std_logic_vector) return std_logic_vector is
        alias aDataIn  : std_logic_vector (DataIn'length - 1 downto 0) is DataIn;
        variable RData : std_logic_vector(aDataIn'range);
    begin
        for i in aDataIn'range loop
            RData(i) := aDataIn(aDataIn'left - i);
        end loop;

        return RData;
    end function bitreverse;

    function bitbyteswap(DataIn : in std_logic_vector)
    return std_logic_vector is
        variable RData32 : std_logic_vector(31 downto 0);
    begin

        if (DataIn'length = RData32'length) then
            RData32(31 downto 24) := bitreverse(DataIn(31 downto 24));
            RData32(23 downto 16) := bitreverse(DataIn(23 downto 16));
            RData32(15 downto 8)  := bitreverse(DataIn(15 downto 8));
            RData32(7 downto 0)   := bitreverse(DataIn(7 downto 0));
            return std_logic_vector(RData32);
        end if;

    end function bitbyteswap;

begin

    RingBufferSlotID     <= std_logic_vector(lRecvRingBufferSlotID);
    RingBufferAddress    <= std_logic_vector(lRecvRingBufferAddress);
    ICAPIPIdentification <= lCommandHeader(15 downto 0);
    ICAPProtocolID       <= lCommandHeader(31 downto 16);
    ICAPProtocolSequence <= lCommandSequence;

    SynchStateProc : process(axis_clk)
    begin
        if rising_edge(axis_clk) then
            if (axis_reset = '1') then
                -- Initialize SM on reset
                -- Default ICAP to read mode
                ICAP_RDWRB    <= '1';
                -- Keep ICAP desselected
                ICAP_CSIB     <= '1';
                -- Tie ICAP Data to NOP Command when being initialized
                ICAP_DataIn   <= bitbyteswap(C_ICAP_NOP_COMMAND);
                StateVariable <= InitialiseSt;
            else
                -- Do the Xilinx bitswapping on bytes, refer to
                -- UG570(v1.9) April 2,2018,Figure 9-1,Page 140
                --ICAP_DataIn   <= lCommandDWORD;--bitbyteswap(lCommandDWORD);
                ICAP_DataIn <= bitbyteswap(lCommandDWORD);
                ICAP_CSIB   <= lICAP_CSIB;
                ICAP_RDWRB  <= lICAP_RDWRB;
                case (StateVariable) is
                    when InitialiseSt =>
                        -- Wait for packet after initialization
                        StateVariable          <= CheckSlotSt;
                        lICAP_CSIB             <= '1';
                        lICAP_RDWRB            <= '0';
                        lRecvRingBufferSlotID  <= (others => '0');
                        lRecvRingBufferAddress <= (others => '0');

                    when CheckSlotSt =>
                        if ((RingBufferSlotStatus = '1') and (axis_prog_full = '0')) then
                            -- The current slot has data 
                            -- Pull the data only when the axis fifo is not full.
                            RingBufferDataRead <= '1';
                            StateVariable      <= ReadHeaderSt;
                        else
                            RingBufferDataRead <= '0';
                            StateVariable      <= CheckSlotSt;
                        end if;

                    when NextSlotSt =>
                        -- Go to next Slot
                        lRecvRingBufferSlotID  <= lRecvRingBufferSlotID + 1;
                        lRecvRingBufferAddress <= (others => '0');
                        RingBufferSlotClear    <= '0';
                        RingBufferDataRead     <= '0';
                        lICAP_CSIB             <= '1';
                        StateVariable          <= CheckSlotSt;

                    when ReadHeaderSt =>
                        RingBufferDataRead <= '1';
                        StateVariable      <= SaveHeaderSt;

                    when SaveHeaderSt =>
                        RingBufferDataRead     <= '1';
                        -- Advance address to read command sequence
                        lRecvRingBufferAddress <= lRecvRingBufferAddress + 1;
                        lCommandHeader         <= RingBufferDataIn;
                        StateVariable          <= ReadSequenceSt;

                    when ReadSequenceSt =>
                        RingBufferDataRead <= '1';
                        StateVariable      <= SaveSequenceSt;

                    when SaveSequenceSt =>
                        RingBufferDataRead     <= '1';
                        -- Advance address to read DOWRD or FRAME
                        lRecvRingBufferAddress <= lRecvRingBufferAddress + 1;
                        lCommandSequence       <= RingBufferDataIn;

                        if ((lCommandHeader(31 downto 24) = X"DA") or (lCommandHeader(31 downto 24) = X"DE")) then
                            -- This is a DWORD command
                            StateVariable <= ReadDWORDCommandSt;
                        else
                            -- Set ICAP to Write mode for all frames
                            ICAP_RDWRB <= '0';
                            if (lCommandHeader(31 downto 24) = X"A5") then
                                -- This is a FRAME
                                -- Stop writing since the ICAP is not ready
                                lICAP_CSIB         <= '1';
                                -- Set the read length to fixed value
                                lframedwordcounter <= C_FRAME_DWORD_MAX;
                                -- Wait for the ICAP to be ready
                                StateVariable      <= WriteFrameDWORDSt;
                            else
                                if (lCommandHeader(31 downto 24) = X"AD") then
                                    -- This is a DFRAME
                                    -- Stop writing since the ICAP is not ready
                                    lICAP_CSIB         <= '1';
                                    -- Set the read length to dynamic value
                                    lframedwordcounter <= to_integer(unsigned(lCommandHeader(23 downto 16))) - 1;
                                    -- Wait for the ICAP to be ready                                    
                                    StateVariable      <= WriteFrameDWORDSt;
                                else
                                    -- This is an error condition
                                    StateVariable <= CreateErrorResponseSt;
                                end if;
                            end if;
                        end if;

                    when ReadDWORDCommandSt =>
                        RingBufferDataRead <= '1';
                        -- Go to write the DWORD on ICAP
                        StateVariable      <= ICAPPrepareWriteDWORDCommandSt;

                    when ICAPPrepareWriteDWORDCommandSt =>
                        -- Disable ICAP select
                        lICAP_CSIB <= '1';

                        -- Go to write the DWORD on ICAP
                        if (lCommandHeader(31 downto 24) = X"DE") then
                            -- Set ICAP to read mode                            
                            lICAP_RDWRB <= '1';
                        else
                            -- Set ICAP to Write mode                            
                            lICAP_RDWRB <= '0';
                        end if;
                        -- Do the Xilinx bitswapping on bytes, refer to
                        -- UG570(v1.9) April 2,2018,Figure 9-1,Page 140
                        ICAP_DataIn   <= bitbyteswap(lCommandDWORD);
                        StateVariable <= ICAPWriteDWORDCommandSt;

                    when ICAPWriteDWORDCommandSt =>
                        -- Stop reading the ring buffer
                        RingBufferDataRead <= '0';
                        if (ICAP_AVAIL = '1') then
                            -- ICAP is ready issue the command
                            lICAP_CSIB    <= '0';
                            -- Done with write 
                            StateVariable <= ICAPPurgeDWORDCommandSt;

                        else
                            -- Wait until ICAP is ready to take data
                            StateVariable <= ICAPWriteDWORDCommandSt;
                        end if;

                    when ICAPPurgeDWORDCommandSt =>
                        -- Get the ICAP read result
                        ICAP_Readback <= ICAP_DataOut;
                        -- Disselect the ICAP
                        lICAP_CSIB    <= '1';
                        -- Change ICAP to read mode
                        --ICAP_RDWRB    <= '1';
                        StateVariable <= WaitICAPResponse;

                    when WriteFrameDWORDSt =>
                        if (ICAP_AVAIL = '1') then
                            -- ICAP is ready
                            -- Do actual write
                            -- Write the ICAP Data
                            lICAP_CSIB             <= '0';
                            -- Point to next frame dword
                            lRecvRingBufferAddress <= lRecvRingBufferAddress + 1;
                            if (lFrameDWORDCounter = 0) then
                                StateVariable <= WaitICAPResponse;
                            else
                                -- advance frame counter                      
                                lFrameDWORDCounter <= lFrameDWORDCounter - 1;
                                StateVariable      <= WriteFrameDWORDSt;
                            end if;

                        else
                            -- Dont write the ICAP Data since ICAP is not ready
                            lICAP_CSIB    <= '1';
                            -- Wait until ICAP is ready to take data
                            StateVariable <= WriteFrameDWORDSt;
                        end if;

                    -- Error processing    
                    when CreateErrorResponseSt =>
                        -- Prepare a UDP Error packet
                        StateVariable <= WaitICAPResponse;

                    -- Response processing    
                    when WaitICAPResponse =>
                        if (lCommandHeader(31 downto 24) = X"DE") then
                            StateVariable <= WaitICAPReadResponseASt;
                        else
                            -- Signal protocol responder we are done with write
                            ICAPWriteDone <= '1';
                            -- Get the ICAP read result
                            ICAP_Readback <= ICAP_DataOut;
                            -- Done with write 
                            StateVariable <= SendICAPResponseSt;
                        end if;
                        -- Disselect the ICAP.
                        lICAP_CSIB         <= '1';
                        -- Change ICAP to read mode
                        --ICAP_RDWRB         <= '1';
                        -- Reset the FRAME DWORD counter
                        lFrameDWORDCounter <= 0;
                    when WaitICAPReadResponseASt =>
                        StateVariable <= WaitICAPReadResponseBSt;
                    when WaitICAPReadResponseBSt =>
                        StateVariable <= WaitICAPReadResponseSt;
                    when WaitICAPReadResponseSt =>
                        -- Signal protocol responder we are done with read
                        ICAPWriteDone <= '1';
                        -- Get the ICAP read result
                        ICAP_Readback <= ICAP_DataOut;
                        StateVariable <= SendICAPResponseSt;

                    when SendICAPResponseSt =>
                        if (ICAPWriteResponseSent = '1') then
                            -- Response sent 
                            ICAPWriteDone <= '0';
                            -- Go to check the next available receiver slot
                            StateVariable <= ClearSlotSt;
                        else
                            -- Wait for protocol responder to send the ICAP response
                            StateVariable <= SendICAPResponseSt;
                        end if;

                    when ClearSlotSt =>
                        -- Clear the current slot to indicate done with the data
                        RingBufferSlotClear <= '1';
                        StateVariable       <= NextSlotSt;

                    when others =>
                        StateVariable <= InitialiseSt;
                end case;
            end if;
        end if;
    end process SynchStateProc;

end architecture rtl;
