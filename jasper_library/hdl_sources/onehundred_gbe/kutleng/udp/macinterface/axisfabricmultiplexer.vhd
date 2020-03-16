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
-- Module Name      : axisfabricmultiplexer - rtl                              -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This multiplexes multiple AXIS streams to one.           -
--                    TODO                                                     -
--                    Find a parallel algorithm for the arbitration            -
--                                                                             -
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axisfabricmultiplexer is
    generic(
        G_MAX_PACKET_BLOCKS_SIZE : natural := 64;
        G_MUX_PORTS              : natural := 7;
        G_PRIORITY_WIDTH         : natural := 4;
        G_DATA_WIDTH             : natural := 8
    );
    port(
        axis_clk          : in  STD_LOGIC;
        axis_reset        : in  STD_LOGIC;
        --Outputs to AXIS bus MAC side 
        axis_tx_tpriority : out STD_LOGIC_VECTOR(G_PRIORITY_WIDTH - 1 downto 0);
        axis_tx_tdata     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
        axis_tx_tvalid    : out STD_LOGIC;
        axis_tx_tready    : in  STD_LOGIC;
        axis_tx_tkeep     : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
        axis_tx_tlast     : out STD_LOGIC;
        axis_tx_tuser     : out STD_LOGIC;
        --Inputs from AXIS 
        ------------------------------------------------------------------------------------------------------------------------
        -- The priority signal is interpreted as follows                                  
        -- 0-2**(G_PRIORITY_WIDTH-1)
        -- Where 0 is lowest priority which means no packets of data are available to forward on that specific AXIS stream port
        -- 1-2**(G_PRIORITY_WIDTH-1) is the number of packets on the AXIS stream port waiting to be transmitted
        -- The more the number of ports that are waiting to be transmitted the higher the port priority
        ----------------------------------------------------------------------------------------------------------------------
        axis_rx_tpriority : in  STD_LOGIC_VECTOR((G_MUX_PORTS * G_PRIORITY_WIDTH) - 1 downto 0);
        axis_rx_tdata     : in  STD_LOGIC_VECTOR((G_MUX_PORTS * G_DATA_WIDTH) - 1 downto 0);
        axis_rx_tvalid    : in  STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0);
        axis_rx_tready    : out STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0);
        axis_rx_tkeep     : in  STD_LOGIC_VECTOR((G_MUX_PORTS * (G_DATA_WIDTH / 8)) - 1 downto 0);
        axis_rx_tlast     : in  STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0)
    );
end entity axisfabricmultiplexer;

architecture rtl of axisfabricmultiplexer is
    type AxisMultiplexerSM_t is (
        -- Start checking for a ready packet
        SearchReadyPacket,
        -- Packet processing accepts axis Packets  less than 64 bytes and more
        -- It is important to note that packets can only have one clock cycle
        -- when they have packet data bytes length of less than (G_DATA_WIDTH/8).
        -- This can happen for ARP packets and UDP packets with less than 20 bytes pay load		
        ProcessPacketSt
    );
    type MuxTDataArray_t is array (G_MUX_PORTS - 1 downto 0) of std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    type MuxTKeepArray_t is array (G_MUX_PORTS - 1 downto 0) of std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);
    type PriorityArray_t is array (G_MUX_PORTS - 1 downto 0) of std_logic_vector(G_PRIORITY_WIDTH - 1 downto 0);

    constant C_MUX_PORT_MAX                : natural := (G_MUX_PORTS - 1);
    constant C_MAXIMUM_CLOCKS_PER_TRANSFER : natural := (512 - 1);

    signal StateVariable               : AxisMultiplexerSM_t := SearchReadyPacket;
    signal axis_rx_tdata_array         : MuxTDataArray_t;
    signal axis_rx_tkeep_array         : MuxTKeepArray_t;
    signal axis_rx_tpriority_array     : PriorityArray_t;
    signal rx_tlast                    : std_logic_vector(G_MUX_PORTS - 1 downto 0);
    signal rx_tvalid                   : std_logic_vector(G_MUX_PORTS - 1 downto 0);
    signal SlotCounterMaximumReached   : std_logic;
    signal HighestPrioritySlot         : natural range 0 to C_MUX_PORT_MAX;
    signal CurrentHighestPriorityValue : unsigned(G_PRIORITY_WIDTH - 1 downto 0);
    signal HighestPriorityValue        : unsigned(G_PRIORITY_WIDTH - 1 downto 0);
    signal CurrentHighestPrioritySlot  : natural range 0 to C_MUX_PORT_MAX;
    signal CurrentActiveSlot           : natural range 0 to C_MUX_PORT_MAX;
    signal SlotCounter                 : natural range 0 to C_MUX_PORT_MAX;
    signal ExtractCurrentSlotPriority  : std_logic;
    signal DataPacketBlockCounter      : natural range 0 to (G_MAX_PACKET_BLOCKS_SIZE - 1);
    signal TransferClockCount          : natural range 0 to C_MAXIMUM_CLOCKS_PER_TRANSFER;

begin

    SaveArraryProc : process(axis_clk)
    begin
        if rising_edge(axis_clk) then
            for n in 0 to (G_MUX_PORTS - 1) loop
                axis_rx_tdata_array(n)     <= axis_rx_tdata((G_DATA_WIDTH * (n + 1)) - 1 downto G_DATA_WIDTH * n);
                axis_rx_tkeep_array(n)     <= axis_rx_tkeep(((G_DATA_WIDTH / 8) * (n + 1)) - 1 downto (G_DATA_WIDTH / 8) * n);
                axis_rx_tpriority_array(n) <= axis_rx_tpriority((G_PRIORITY_WIDTH * (n + 1)) - 1 downto G_PRIORITY_WIDTH * n);
                rx_tlast(n)                <= axis_rx_tlast(n);
                rx_tvalid(n)               <= axis_rx_tvalid(n);
            end loop;
        end if;
    end process SaveArraryProc;

    PriorityArbiterProc : process(axis_clk)
        ---------------------------------------------------------------------------------------------------
        -- This priority arbiter works by checking the number of packets on each multiplexed AXIS bus.
        -- As this priority number increases from empty packet on the wait queue (0),  
        -- and when there is a packet (1), 
        -- to the maximum number of waiting packets before overflow (2**G_PRIORITY_WIDTH-1).
        -- The multiplexed port with the highest priority on any scan will be sent out without round robin. 
        -- This is a purely priority based on number of waiting packets scheduler.
        -- The algorithm lack efficiency in that it scans serially for G_MUX_PORTS.
        -- Hence it introduces an inefficiency in the streaming path of maximum G_MUX_PORTS+2 wait cycles.
        -- A parallel priority encoder method must be investigated to reduce this to a fixed one cycle 
        -- arbitration scheme
        -- TODO Find a parallel algorithm for the arbitration  
        ---------------------------------------------------------------------------------------------------
    begin
        if (rising_edge(axis_clk)) then

            if ((axis_reset = '1') or (SlotCounter = C_MUX_PORT_MAX)) then
                SlotCounter               <= 0;
                SlotCounterMaximumReached <= '1';
            else
                -- Keep scanning for the highest priority slot
                SlotCounter               <= SlotCounter + 1;
                SlotCounterMaximumReached <= '0';
            end if;
            if ((axis_reset = '1') or (SlotCounterMaximumReached = '1')) then
                -- Reset and save the priority at Slot 0 
                HighestPriorityValue <= unsigned(axis_rx_tpriority_array(SlotCounter));
                HighestPrioritySlot  <= SlotCounter;
            else
                -- current scan cycle: latch higher priority
                if (unsigned(axis_rx_tpriority_array(SlotCounter)) > unsigned(HighestPriorityValue)) then
                    HighestPriorityValue <= unsigned(axis_rx_tpriority_array(SlotCounter));
                    HighestPrioritySlot  <= SlotCounter;
                end if;
            end if;

            if ((axis_reset = '1') or (ExtractCurrentSlotPriority = '1')) then
                CurrentHighestPriorityValue <= (others => '0');
            else
                if (SlotCounterMaximumReached = '1') then
                    -- Save the highest priority value and its slot from the priority scan cycle
                    -- TODO This is where the improvement must come in to reduce dead cycles
                    CurrentHighestPriorityValue <= HighestPriorityValue;
                    CurrentHighestPrioritySlot  <= HighestPrioritySlot;
                end if;
            end if;
        end if;
    end process PriorityArbiterProc;

    StateMachineProc : process(axis_clk)
    begin
        if rising_edge(axis_clk) then
            if (axis_reset = '1') then
                ExtractCurrentSlotPriority <= '0';
                StateVariable              <= SearchReadyPacket;
            else
                if (axis_tx_tready = '1') then
                    case StateVariable is
                        -- Evaluate Ethernet header
                        when SearchReadyPacket =>
                            axis_tx_tlast     <= '0';
                            axis_tx_tvalid    <= '0';
                            axis_tx_tuser     <= '0';
                            axis_tx_tdata     <= (others => '0');
                            axis_tx_tkeep     <= (others => '0');
                            axis_tx_tpriority <= (others => '0');
                            axis_rx_tready    <= (others => '0');

                            if (CurrentHighestPriorityValue /= 0) then
                                ExtractCurrentSlotPriority <= '1';
                                CurrentActiveSlot          <= CurrentHighestPrioritySlot;
                                DataPacketBlockCounter     <= 0;
                                TransferClockCount         <= 0;
                                TransferClockCount         <= 0;
                                DataPacketBlockCounter     <= 0;
                                StateVariable              <= ProcessPacketSt;
                            else

                                ExtractCurrentSlotPriority <= '0';
                            end if;

                        when ProcessPacketSt =>
                            -- Stop getting the next slot priority 
                            ExtractCurrentSlotPriority <= '0';
                            TransferClockCount         <= TransferClockCount + 1;

                            if (TransferClockCount = C_MAXIMUM_CLOCKS_PER_TRANSFER) or (DataPacketBlockCounter = (G_MAX_PACKET_BLOCKS_SIZE - 1)) then
                                -- Abort the upstream active transfer because of time out errors or 
                                -- data exceeds G_MAX_PACKET_BLOCKS_SIZE
                                axis_tx_tlast                     <= '1';
                                -- Terminate the transfer from the multiplexed input AXIS 
                                axis_rx_tready(CurrentActiveSlot) <= '0';
                                -- Flag the error condition for the packet to be dropped
                                axis_tx_tuser                     <= '1';
                                StateVariable                     <= SearchReadyPacket;
                            else
                                -- Pass all other signals
                                axis_tx_tvalid    <= rx_tvalid(CurrentActiveSlot);
                                axis_tx_tlast     <= rx_tlast(CurrentActiveSlot);
                                axis_tx_tdata     <= axis_rx_tdata_array(CurrentActiveSlot);
                                axis_tx_tkeep     <= axis_rx_tkeep_array(CurrentActiveSlot);
                                axis_tx_tpriority <= axis_rx_tpriority_array(CurrentActiveSlot);
                                -- Flag no errors
                                axis_tx_tuser     <= '0';

                                if (rx_tvalid(CurrentActiveSlot) = '1') then
                                    DataPacketBlockCounter <= DataPacketBlockCounter + 1;
                                    -- If the data is valid 
                                    if (rx_tlast(CurrentActiveSlot) = '1') then
                                        -- check if the packet has tlast
                                        -- Terminate the transfer from the multiplexed input AXIS 
                                        axis_rx_tready(CurrentActiveSlot) <= '0';
                                        StateVariable                     <= SearchReadyPacket;
                                    else
                                        -- Enable the current slot
                                        axis_rx_tready(CurrentActiveSlot) <= '1';
                                        StateVariable                     <= ProcessPacketSt;
                                    end if;
                                else
                                    -- Enable the current slot  
                                    axis_rx_tready(CurrentActiveSlot) <= '1';
                                    StateVariable                     <= ProcessPacketSt;
                                end if;
                            end if;

                        when others =>
                            StateVariable <= SearchReadyPacket;
                    end case;
                end if;
            end if;
        end if;
    end process StateMachineProc;

end architecture rtl;
