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
-- Module Name      : cpuifsenderpacketringbuffer_tb - rtl                     -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
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
-- Dependencies     : cpuifsenderpacketringbuffer                              -
-- Revision History : V1.0 - Initial design                                    -
--                  : V1.1 - Changed architecure to use state machine to do the-
--                           data resize and enable mapping.                   -
--                           This is a better design as it saves BRAMS and LUTs-
--                           Vivado cannot infer BRAM of 8<=>512 aspect ratio. -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpuifsenderpacketringbuffer_tb is
end entity cpuifsenderpacketringbuffer_tb;

architecture behavorial of cpuifsenderpacketringbuffer_tb is
	component cpuifsenderpacketringbuffer is
		generic(
			G_SLOT_WIDTH             : natural := 4;
			constant G_RX_ADDR_WIDTH : natural := 11;
			constant G_TX_ADDR_WIDTH : natural := 5;
			constant G_RX_DATA_WIDTH : natural := 8;
			constant G_TX_DATA_WIDTH : natural := 512
		);
		port(
			RxClk                  : in  STD_LOGIC;
			TxClk                  : in  STD_LOGIC;
			Reset                  : in  STD_LOGIC;
			-- Transmission port
			TxPacketByteEnable     : out STD_LOGIC_VECTOR((G_TX_DATA_WIDTH / 8) - 1 downto 0);
			TxPacketDataRead       : in  STD_LOGIC;
			TxPacketData           : out STD_LOGIC_VECTOR(G_TX_DATA_WIDTH - 1 downto 0);
			TxPacketAddress        : in  STD_LOGIC_VECTOR(G_TX_ADDR_WIDTH - 1 downto 0);
			TxPacketSlotClear      : in  STD_LOGIC;
			TxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
			TxPacketSlotStatus     : out STD_LOGIC;
			-- Reception port
			RxPacketByteEnable     : in  STD_LOGIC_VECTOR((G_RX_DATA_WIDTH / 8) downto 0);
			RxPacketData           : in  STD_LOGIC_VECTOR(G_RX_DATA_WIDTH - 1 downto 0);
			RxPacketAddress        : in  STD_LOGIC_VECTOR(G_RX_ADDR_WIDTH - 1 downto 0);
			RxPacketDataWrite      : in  STD_LOGIC;
			RxPacketReadByteEnable : out STD_LOGIC_VECTOR((G_RX_DATA_WIDTH / 8) downto 0);
			RxPacketDataRead       : in  STD_LOGIC;
			RxPacketDataOut        : out STD_LOGIC_VECTOR(G_RX_DATA_WIDTH - 1 downto 0);
			RxPacketReadAddress    : in  STD_LOGIC_VECTOR(G_RX_ADDR_WIDTH - 1 downto 0);
			RxPacketSlotSet        : in  STD_LOGIC;
			RxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
			RxPacketSlotStatus     : out STD_LOGIC
		);
	end component cpuifsenderpacketringbuffer;
	constant G_SLOT_WIDTH         : natural                                          := 4;
	constant G_RX_ADDR_WIDTH      : natural                                          := 11;
	constant G_TX_ADDR_WIDTH      : natural                                          := 5;
	constant G_RX_DATA_WIDTH      : natural                                          := 8;
	constant G_TX_DATA_WIDTH      : natural                                          := 512;
	signal Clk                    : STD_LOGIC                                        := '1';
	signal Reset                  : STD_LOGIC                                        := '1';
	signal TxPacketByteEnable     : STD_LOGIC_VECTOR((G_TX_DATA_WIDTH / 8) - 1 downto 0);
	signal TxPacketDataRead       : STD_LOGIC                                        := '1';
	signal TxPacketData           : STD_LOGIC_VECTOR(G_TX_DATA_WIDTH - 1 downto 0);
	signal TxPacketAddress        : unsigned(G_TX_ADDR_WIDTH - 1 downto 0)           := (others => '0');
	signal TxPacketSlotClear      : STD_LOGIC                                        := '0';
	signal TxPacketSlotID         : unsigned(G_SLOT_WIDTH - 1 downto 0)              := (others => '0');
	signal TxPacketSlotStatus     : STD_LOGIC;
	signal RxPacketByteEnable     : STD_LOGIC_VECTOR((G_RX_DATA_WIDTH / 8) downto 0) := (others => '0');
	signal RxPacketData           : STD_LOGIC_VECTOR(G_RX_DATA_WIDTH - 1 downto 0)   := (others => '0');
	signal RxPacketAddress        : unsigned(G_RX_ADDR_WIDTH - 1 downto 0)           := (others => '0');
	signal RxPacketDataWrite      : STD_LOGIC                                        := '0';
	signal RxPacketReadByteEnable : STD_LOGIC_VECTOR((G_RX_DATA_WIDTH / 8) downto 0);
	signal RxPacketDataRead       : STD_LOGIC                                        := '0';
	signal RxPacketDataOut        : STD_LOGIC_VECTOR(G_RX_DATA_WIDTH - 1 downto 0);
	signal RxPacketReadAddress    : unsigned(G_RX_ADDR_WIDTH - 1 downto 0)           := (others => '0');
	signal RxPacketSlotSet        : STD_LOGIC                                        := '0';
	signal RxPacketSlotID         : unsigned(G_SLOT_WIDTH - 1 downto 0)              := (others => '0');
	signal RxPacketSlotStatus     : STD_LOGIC;
	constant C_CLK_PERIOD         : time                                             := 10 ns;
begin
	Clk   <= not Clk after C_CLK_PERIOD / 2;
	Reset <= '1', '0' after C_CLK_PERIOD * 10;
	UUTRBi : cpuifsenderpacketringbuffer
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
			TxPacketByteEnable     => TxPacketByteEnable,
			TxPacketDataRead       => TxPacketDataRead,
			TxPacketData           => TxPacketData,
			TxPacketAddress        => std_logic_vector(TxPacketAddress),
			TxPacketSlotClear      => TxPacketSlotClear,
			TxPacketSlotID         => std_logic_vector(TxPacketSlotID),
			TxPacketSlotStatus     => TxPacketSlotStatus,
			RxPacketByteEnable     => RxPacketByteEnable,
			RxPacketData           => RxPacketData,
			RxPacketAddress        => std_logic_vector(RxPacketAddress),
			RxPacketDataWrite      => RxPacketDataWrite,
			RxPacketReadByteEnable => RxPacketReadByteEnable,
			RxPacketDataRead       => RxPacketDataRead,
			RxPacketDataOut        => RxPacketDataOut,
			RxPacketReadAddress    => std_logic_vector(RxPacketReadAddress),
			RxPacketSlotSet        => RxPacketSlotSet,
			RxPacketSlotID         => std_logic_vector(RxPacketSlotID),
			RxPacketSlotStatus     => RxPacketSlotStatus
		);

	StimProc : process
	begin
		wait for C_CLK_PERIOD * 15;
		RxPacketSlotID                           <= (others => '0');
		TxPacketSlotID                           <= (others => '0');
		RxPacketAddress                          <= (others => '0');
		TxPacketAddress                          <= (others => '0');
		TxPacketDataRead                         <= '0';
		TxPacketSlotClear                        <= '0';
		RxPacketSlotSet                          <= '0';
		RxPacketDataWrite                        <= '0';
		RxPacketByteEnable                       <= (others => '0');
		RxPacketData(0)                          <= '1';
		RxPacketData(RxPacketData'left downto 1) <= (others => '0');

		wait for C_CLK_PERIOD * 4;
		-- Send 9 packets frames
		-- The last frame has framming error, and not terminated
		for i in 0 to 8 loop
			RxPacketAddress     <= (others => '0');
			RxPacketReadAddress <= (others => '0');
			RxPacketByteEnable  <= (others => '0');
			wait for C_CLK_PERIOD;
			-- Send packets that are limited by the Ethernet MTU
			for n in 0 to 1521 loop
				case i is
					when 0 =>
						-- Special case for 63rd byte TLAST on second frame
						if (n = 126) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 1 =>
						if (n = 511) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 2 =>
						if (n = 1289) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 3 =>
						if (n = 1511) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 4 =>
						if (n = 1011) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 5 =>
						-- Special case for last TLAST
						if (n = 63) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 6 =>
						-- Special case for first byte TLAST
						if (n = (63 + 1)) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 7 =>
						-- Special case for second byte TLAST
						if (n = (63 + 2)) then
							-- Terminate the transcation with TLAST
							-- Also have some byte enables disabled to test 
							RxPacketByteEnable <= B"11";
						else
							RxPacketByteEnable <= B"01";
						end if;
					when 8 =>
						-- Packet not terminated upstream.
						-- This must simulate a framming error
						RxPacketByteEnable <= B"01";

					when others =>
						-- case where other bytes are enabled
						RxPacketByteEnable <= B"01";
				end case;
				RxPacketData        <= RxPacketData(0) & RxPacketData(RxPacketData'left - 1 downto 0);
				RxPacketDataWrite   <= '0';
				wait for C_CLK_PERIOD;
				RxPacketDataWrite   <= '1';
				RxPacketDataRead    <= '0';
				wait for C_CLK_PERIOD;
				RxPacketDataWrite   <= '0';
				wait for C_CLK_PERIOD;
				RxPacketDataRead    <= '1';
				RxPacketAddress     <= RxPacketAddress + 1;
				wait for C_CLK_PERIOD;
				RxPacketDataRead    <= '0';
				wait for C_CLK_PERIOD;
				RxPacketReadAddress <= RxPacketReadAddress + 1;
				wait for C_CLK_PERIOD;
			end loop;
			wait for C_CLK_PERIOD;
			RxPacketSlotSet     <= '1';
			wait for C_CLK_PERIOD;
			RxPacketSlotSet     <= '0';
			wait for C_CLK_PERIOD;
			RxPacketSlotID      <= RxPacketSlotID + 1;
			wait for C_CLK_PERIOD;
		end loop;
		-- Clean up after the simulation data feed.
		wait for 50000 ns;
		-- Terminate the simulation
		std.env.finish;
	end process StimProc;
end architecture behavorial;
