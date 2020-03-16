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
-- Module Name      : cpuifreceiverpacketringbuffer_tb - rtl                   -
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
-- Dependencies     : cpuifreceiverpacketringbuffer                            -
-- Revision History : V1.0 - Initial design                                    -
--                  : V1.1 - Changed architecure to use state machine to do the-
--                           data resize and enable mapping.                   -
--                           This is a better design as it saves BRAMS and LUTs-
--                           Vivado cannot infer BRAM of 8<=>512 aspect ratio. -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpuifreceiverpacketringbuffer_tb is
end entity cpuifreceiverpacketringbuffer_tb;

architecture behavorial of cpuifreceiverpacketringbuffer_tb is
	component cpuifreceiverpacketringbuffer is
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
	end component cpuifreceiverpacketringbuffer;

	constant G_SLOT_WIDTH         : natural                                              := 4;
	constant G_RX_ADDR_WIDTH      : natural                                              := 5;
	constant G_TX_ADDR_WIDTH      : natural                                              := 11;
	constant G_RX_DATA_WIDTH      : natural                                              := 512;
	constant G_TX_DATA_WIDTH      : natural                                              := 8;
	signal Clk                    : STD_LOGIC                                            := '1';
	signal Reset                  : STD_LOGIC                                            := '1';
	signal RxPacketByteEnable     : STD_LOGIC_VECTOR((G_RX_DATA_WIDTH / 8) - 1 downto 0) := (others => '0');
	signal RxPacketDataWrite      : STD_LOGIC                                            := '0';
	signal RxPacketData           : STD_LOGIC_VECTOR(G_RX_DATA_WIDTH - 1 downto 0)       := (others => '0');
	signal RxPacketAddress        : unsigned(G_RX_ADDR_WIDTH - 1 downto 0)               := (others => '0');
	signal RxPacketSlotSet        : STD_LOGIC                                            := '0';
	signal RxPacketSlotID         : unsigned(G_SLOT_WIDTH - 1 downto 0)                  := (others => '0');
	signal RxPacketSlotStatus     : STD_LOGIC;
	signal TxPacketReadByteEnable : STD_LOGIC_VECTOR((G_TX_DATA_WIDTH / 8) downto 0);
	signal TxPacketDataOut        : STD_LOGIC_VECTOR(G_TX_DATA_WIDTH - 1 downto 0);
	signal TxPacketReadAddress    : unsigned(G_TX_ADDR_WIDTH - 1 downto 0)               := (others => '0');
	signal TxPacketDataRead       : STD_LOGIC                                            := '0';
	signal TxPacketSlotClear      : STD_LOGIC                                            := '0';
	signal TxPacketSlotID         : unsigned(G_SLOT_WIDTH - 1 downto 0)                  := (others => '0');
	signal TxPacketSlotStatus     : STD_LOGIC;
	constant C_CLK_PERIOD         : time                                                 := 10 ns;
begin
	Clk   <= not Clk after C_CLK_PERIOD / 2;
	Reset <= '1', '0' after C_CLK_PERIOD * 10;

	UUTRBi : cpuifreceiverpacketringbuffer
		generic map(
			G_SLOT_WIDTH    => G_SLOT_WIDTH,
			G_RX_ADDR_WIDTH => G_RX_ADDR_WIDTH,
			G_TX_ADDR_WIDTH => G_TX_ADDR_WIDTH,
			G_RX_DATA_WIDTH => G_RX_DATA_WIDTH,
			G_TX_DATA_WIDTH => G_TX_DATA_WIDTH
		)
		port map(
			RxClk                  => Clk,
			TxClk                  => Clk,
			Reset                  => Reset,
			RxPacketByteEnable     => RxPacketByteEnable,
			RxPacketDataWrite      => RxPacketDataWrite,
			RxPacketData           => RxPacketData,
			RxPacketAddress        => std_logic_vector(RxPacketAddress),
			RxPacketSlotSet        => RxPacketSlotSet,
			RxPacketSlotID         => std_logic_vector(RxPacketSlotID),
			RxPacketSlotStatus     => RxPacketSlotStatus,
			TxPacketReadByteEnable => TxPacketReadByteEnable,
			TxPacketDataOut        => TxPacketDataOut,
			TxPacketReadAddress    => std_logic_vector(TxPacketReadAddress),
			TxPacketDataRead       => TxPacketDataRead,
			TxPacketSlotClear      => TxPacketSlotClear,
			TxPacketSlotID         => std_logic_vector(TxPacketSlotID),
			TxPacketSlotStatus     => TxPacketSlotStatus
		);
	StimProc : process
	begin
		wait for C_CLK_PERIOD * 15;
		RxPacketSlotID                           <= (others => '0');
		TxPacketSlotID                           <= (others => '0');
		RxPacketAddress                          <= (others => '0');
		TxPacketReadAddress                      <= (others => '0');
		TxPacketDataRead                         <= '0';
		TxPacketSlotClear                        <= '0';
		RxPacketSlotSet                          <= '0';
		RxPacketDataWrite                        <= '0';
		RxPacketByteEnable                       <= (others => '0');
		RxPacketData(0)                          <= '1';
		RxPacketData(RxPacketData'left downto 1) <= (others => '0');

		wait for C_CLK_PERIOD * 4;
		for i in 0 to 14 loop
			RxPacketAddress    <= (others => '0');
			RxPacketByteEnable <= (others => '0');
    		wait for C_CLK_PERIOD;
			for n in 0 to 7 loop
				if (n = 7) then
					-- Terminate the transcation with TLAST
					-- Also have some byte enables disabled to test 
					case i is
					when 0 =>
							-- Case where only one byte is abled
							RxPacketByteEnable <= X"0000_0000_0000_0001";
						when 1 =>
							-- Case where only one byte is disabled
							RxPacketByteEnable <= X"7FFF_FFFF_FFFF_FFFF";
						when 2 =>
							-- Case where some bytes are enabled 
							RxPacketByteEnable <= X"0000_0000_0000_FFFF";
						when 3 =>
							-- Case where some bytes are enabled
							RxPacketByteEnable <= X"0000_0000_FFFF_FFFF";
						when others =>
							-- case where other bytes are enabled
							RxPacketByteEnable <= X"0000_FFFF_FFFF_FFFF";
					end case;
				else
					RxPacketByteEnable <= X"FFFF_FFFF_FFFF_FFFE";
				end if;
				RxPacketData      <= RxPacketData(0) & RxPacketData(RxPacketData'left - 1 downto 0);
				RxPacketDataWrite <= '0';
				wait for C_CLK_PERIOD;
				RxPacketDataWrite <= '1';
				wait for C_CLK_PERIOD;
				RxPacketDataWrite <= '0';
				wait for C_CLK_PERIOD;
				RxPacketAddress   <= RxPacketAddress + 1;
				wait for C_CLK_PERIOD;
			end loop;
			wait for C_CLK_PERIOD;			
			RxPacketSlotSet    <= '1';
			wait for C_CLK_PERIOD;
			RxPacketSlotSet    <= '0';
			wait for C_CLK_PERIOD;
			RxPacketSlotID     <= RxPacketSlotID + 1;
			wait for C_CLK_PERIOD;
		end loop;
		-- Clean up after the simulation data feed.
		wait for 90000ns;
		-- Terminate the simulation
		std.env.finish;
	end process StimProc;
end architecture behavorial;
