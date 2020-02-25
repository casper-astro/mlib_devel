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
-- Module Name      : udpdatastripper - rtl                                    -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module performs data streaming over UDP             -
--                                                                             -
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udpdatastripper is
	generic(
		G_SLOT_WIDTH : natural := 4;
		G_ADDR_WIDTH : natural := 5
	);
	port(
		axis_clk                 : in  STD_LOGIC;
		axis_reset               : in  STD_LOGIC;
		EthernetMACEnable        : in  STD_LOGIC;
		-- Packet Readout in addressed bus format
		RecvRingBufferSlotID     : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
		RecvRingBufferSlotClear  : out STD_LOGIC;
		RecvRingBufferSlotStatus : in  STD_LOGIC;
		RecvRingBufferDataRead   : out STD_LOGIC;
		-- Enable[0] is a special bit (we assume always 1 when packet is valid)
		-- we use it to save TLAST
		RecvRingBufferDataEnable : in  STD_LOGIC_VECTOR(63 downto 0);
		RecvRingBufferDataOut    : in  STD_LOGIC_VECTOR(511 downto 0);
		RecvRingBufferAddress    : out STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
		--
		UDPPacketLength          : out STD_LOGIC_VECTOR(15 downto 0);
        --
		axis_tuser               : out STD_LOGIC;
		axis_tdata               : out STD_LOGIC_VECTOR(511 downto 0);
		axis_tvalid              : out STD_LOGIC;
		axis_tready              : in  STD_LOGIC;
		axis_tkeep               : out STD_LOGIC_VECTOR(63 downto 0);
		axis_tlast               : out STD_LOGIC
	);
end entity udpdatastripper;

architecture rtl of udpdatastripper is
	type UDPDataStripperSM_t is (
		InitialiseSt,                   -- On the reset state
		CheckEmptySlotSt,
		ExtractPacketDataSt,
		PreExtractPacketDataSt,
		NextSlotSt
	);
	constant C_ADDRESS_MAX        : natural             := (2**G_ADDR_WIDTH) - 1;
    constant C_UDP_HEADER_LENGTH  : unsigned(15 downto 0)         := X"0008";	
	signal StateVariable          : UDPDataStripperSM_t := InitialiseSt;
	signal lRecvRingBufferAddress : unsigned(G_ADDR_WIDTH - 1 downto 0);
	signal lRecvRingBufferSlotID  : unsigned(G_SLOT_WIDTH - 1 downto 0);
	signal lFirstFrame            : std_logic;
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
begin
	RecvRingBufferAddress <= std_logic_vector(lRecvRingBufferAddress);
	RecvRingBufferSlotID  <= std_logic_vector(lRecvRingBufferSlotID);
	
	
	CombOutPut:process(StateVariable,axis_tready)
	begin
		if  (StateVariable = ExtractPacketDataSt) then
			axis_tvalid <= axis_tready;
		else
			axis_tvalid <= '0';
		end if;
	end process CombOutPut;
	
	SynchStateProc : process(axis_clk)
	begin
		if rising_edge(axis_clk) then
			if (axis_reset = '1') then

				StateVariable <= InitialiseSt;
			else
				case (StateVariable) is

					when InitialiseSt =>

						-- Wait for packet after initialization
						StateVariable          <= CheckEmptySlotSt;
						lRecvRingBufferSlotID  <= (others => '0');
						lRecvRingBufferAddress <= (others => '0');
				        lFirstFrame <= '0';

					when CheckEmptySlotSt =>
						if ((RecvRingBufferSlotStatus = '1') and (EthernetMACEnable = '1')) then
							-- There is a packet waiting on the ring buffer
							-- Start from the base address to extract the packet
							lRecvRingBufferAddress <= (others => '0');
							RecvRingBufferDataRead <= '1';
							lFirstFrame <= '1';
							-- This may need to wait before reading as the BRAM may have a latency on 1 clock cycle.
							StateVariable          <= PreExtractPacketDataSt;
						else
							lFirstFrame <= '0';
							RecvRingBufferDataRead <= '0';
							-- Keep searching for a packet
							StateVariable          <= CheckEmptySlotSt;
						end if;
					when PreExtractPacketDataSt =>
						if (axis_tready = '1') then
							-- Read and point to next address
							lRecvRingBufferAddress  <= lRecvRingBufferAddress + 1;
							StateVariable          <= ExtractPacketDataSt;
						else
							StateVariable          <= PreExtractPacketDataSt;						
						end if;

					when ExtractPacketDataSt =>
                        if (lFirstFrame = '1') then
                            UDPPacketLength <= std_logic_vector(unsigned(byteswap(RecvRingBufferDataOut(319 downto 304))) - C_UDP_HEADER_LENGTH) ;
                            lFirstFrame <= '0';
                        end if;
						if (axis_tready = '1') then
							-- Read and point to next address
							lRecvRingBufferAddress  <= lRecvRingBufferAddress + 1;
							--axis_tvalid             <= '1';
							axis_tdata              <= RecvRingBufferDataOut;
							axis_tkeep(63 downto 1) <= RecvRingBufferDataEnable(63 downto 1);
							axis_tkeep(0)           <= '1';

							if ((RecvRingBufferDataEnable(0) = '1') or (lRecvRingBufferAddress = C_ADDRESS_MAX)) then
								-- This is the last byte to terminate the transaction
								-- This is a wrap around condition just terminate the transaction
								RecvRingBufferSlotClear <= '1';
								axis_tlast              <= '1';
								if (lRecvRingBufferAddress = C_ADDRESS_MAX) then
									axis_tuser <= '1';
								else
									axis_tuser <= '0';
								end if;
								StateVariable           <= NextSlotSt;
							else
								axis_tlast    <= '0';
								StateVariable <= ExtractPacketDataSt;
							end if;
						else
							--axis_tvalid   <= '0';
							StateVariable <= ExtractPacketDataSt;
						end if;

					when NextSlotSt =>
						axis_tlast              <= '0';
						axis_tuser              <= '0';
						--axis_tvalid             <= '0';
						RecvRingBufferDataRead  <= '0';
						RecvRingBufferSlotClear <= '0';
						-- Search next slots  
						lRecvRingBufferSlotID   <= lRecvRingBufferSlotID + 1;
						StateVariable           <= CheckEmptySlotSt;

					when others =>
						StateVariable <= InitialiseSt;
				end case;
			end if;
		end if;
	end process SynchStateProc;

end architecture rtl;
