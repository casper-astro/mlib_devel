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
-- Module Name      : lbustxaxisrx_tb - rtl                                    -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to test mapping of the AXIS to L-BUS -
--                    interface.                                               -
--                                                                             -
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity lbustxaxisrx_tb is
end entity lbustxaxisrx_tb;

architecture behavorial of lbustxaxisrx_tb is
    component lbustxaxisrx is
        port(
            lbus_txclk      : in  STD_LOGIC;
            lbus_txreset    : in  STD_LOGIC;
            --INPUTS FROM AXI BUS
            axis_rx_tdata   : in  STD_LOGIC_VECTOR(511 downto 0);
            axis_rx_tvalid  : in  STD_LOGIC;
            axis_rx_tready  : out STD_LOGIC;
            axis_rx_tkeep   : in  STD_LOGIC_VECTOR(63 downto 0);
            axis_rx_tlast   : in  STD_LOGIC;
            --OUTPUTS TO LBUS
            lbus_tx_rdyout  : in  STD_LOGIC;
            -- Segment 0
            lbus_txdataout0 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout0  : out STD_LOGIC;
            lbus_txsopout0  : out STD_LOGIC;
            lbus_txeopout0  : out STD_LOGIC;
            lbus_txerrout0  : out STD_LOGIC;
            lbus_txmtyout0  : out STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 1
            lbus_txdataout1 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout1  : out STD_LOGIC;
            lbus_txsopout1  : out STD_LOGIC;
            lbus_txeopout1  : out STD_LOGIC;
            lbus_txerrout1  : out STD_LOGIC;
            lbus_txmtyout1  : out STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 2
            lbus_txdataout2 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout2  : out STD_LOGIC;
            lbus_txsopout2  : out STD_LOGIC;
            lbus_txeopout2  : out STD_LOGIC;
            lbus_txerrout2  : out STD_LOGIC;
            lbus_txmtyout2  : out STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 3		
            lbus_txdataout3 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout3  : out STD_LOGIC;
            lbus_txsopout3  : out STD_LOGIC;
            lbus_txeopout3  : out STD_LOGIC;
            lbus_txerrout3  : out STD_LOGIC;
            lbus_txmtyout3  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component lbustxaxisrx;

    signal lbus_txclk     : STD_LOGIC                      := '1';
    signal lbus_txreset   : STD_LOGIC                      := '1';
    signal axis_rx_tdata  : STD_LOGIC_VECTOR(511 downto 0) := (others => '0');
    signal axis_rx_tvalid : STD_LOGIC                      := '0';
    signal axis_rx_tkeep  : STD_LOGIC_VECTOR(63 downto 0)  := (others => '0');
    signal axis_rx_tlast  : STD_LOGIC                      := '0';

    signal axis_rx_tready : STD_LOGIC;

    signal lbus_tx_rdyout : STD_LOGIC := '0';

    signal lbus_txdataout0 : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout0  : STD_LOGIC;
    signal lbus_txsopout0  : STD_LOGIC;
    signal lbus_txeopout0  : STD_LOGIC;
    signal lbus_txerrout0  : STD_LOGIC;
    signal lbus_txmtyout0  : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_txdataout1 : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout1  : STD_LOGIC;
    signal lbus_txsopout1  : STD_LOGIC;
    signal lbus_txeopout1  : STD_LOGIC;
    signal lbus_txerrout1  : STD_LOGIC;
    signal lbus_txmtyout1  : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_txdataout2 : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout2  : STD_LOGIC;
    signal lbus_txsopout2  : STD_LOGIC;
    signal lbus_txeopout2  : STD_LOGIC;
    signal lbus_txerrout2  : STD_LOGIC;
    signal lbus_txmtyout2  : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_txdataout3 : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout3  : STD_LOGIC;
    signal lbus_txsopout3  : STD_LOGIC;
    signal lbus_txeopout3  : STD_LOGIC;
    signal lbus_txerrout3  : STD_LOGIC;
    signal lbus_txmtyout3  : STD_LOGIC_VECTOR(3 downto 0);
    constant C_CLK_PERIOD  : time := 10 ns;
begin

    lbus_txclk     <= not lbus_txclk after C_CLK_PERIOD / 2;
    lbus_txreset   <= '1', '0' after C_CLK_PERIOD * 2;
    lbus_tx_rdyout <= '0', '1' after C_CLK_PERIOD * 4;

    StimProc : process
    begin
        wait for C_CLK_PERIOD * 4;
        -------------------------------------------------
        -- Send a 64 byte packet
        -------------------------------------------------			
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF01";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF11";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF21";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF31";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(511 downto 0)   <= (others => '0');
        axis_rx_tkeep(63 downto 0)    <= (others => '0');
        axis_rx_tvalid                <= '0';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        -------------------------------------------------
        -- Send a 64 byte packet
        -------------------------------------------------			
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF01";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF11";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF21";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF31";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(511 downto 0)   <= (others => '0');
        axis_rx_tkeep(63 downto 0)    <= (others => '0');
        axis_rx_tvalid                <= '0';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        -------------------------------------------------
        -- Send a 128 byte packet
        -------------------------------------------------			
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF02";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF12";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF22";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF32";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF03";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF13";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF23";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF33";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(511 downto 0)   <= (others => '0');
        axis_rx_tkeep(63 downto 0)    <= (others => '0');
        axis_rx_tvalid                <= '0';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        -------------------------------------------------
        -- Send a 100 byte packet
        -------------------------------------------------			
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF02";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF12";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF22";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF32";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF03";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF13";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"000000000000000000000000ABCDEF23";
        axis_rx_tkeep(47 downto 32)   <= X"000F";
        axis_rx_tdata(511 downto 384) <= (others => '0');
        axis_rx_tkeep(63 downto 48)   <= X"0000";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(511 downto 0)   <= (others => '0');
        axis_rx_tkeep(63 downto 0)    <= (others => '0');
        axis_rx_tvalid                <= '0';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        -------------------------------------------------
        -- Send a 88 byte packet
        -------------------------------------------------			
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF02";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF12";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF22";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF32";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF03";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"0000000000000000DEADBEEFABCDEF13";
        axis_rx_tkeep(31 downto 16)   <= X"00FF";
        axis_rx_tdata(383 downto 256) <= (others => '0');
        axis_rx_tkeep(47 downto 32)   <= X"0000";
        axis_rx_tdata(511 downto 384) <= (others => '0');
        axis_rx_tkeep(63 downto 48)   <= X"0000";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(511 downto 0)   <= (others => '0');
        axis_rx_tkeep(63 downto 0)    <= (others => '0');
        axis_rx_tvalid                <= '0';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        -------------------------------------------------
        -- Send a 76 byte packet
        -------------------------------------------------			
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF02";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF12";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF22";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF32";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(127 downto 0)   <= X"00000000ABCDEF01DEADBEEFABCDEF03";
        axis_rx_tkeep(15 downto 0)    <= X"0FFF";
        axis_rx_tdata(255 downto 128) <= (others => '0');
        axis_rx_tkeep(31 downto 16)   <= X"0000";
        axis_rx_tdata(383 downto 256) <= (others => '0');
        axis_rx_tkeep(47 downto 32)   <= X"0000";
        axis_rx_tdata(511 downto 384) <= (others => '0');
        axis_rx_tkeep(63 downto 48)   <= X"0000";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(511 downto 0)   <= (others => '0');
        axis_rx_tkeep(63 downto 0)    <= (others => '0');
        axis_rx_tvalid                <= '0';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;

        -------------------------------------------------
        -- Send a 140 byte packet
        -------------------------------------------------			
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF02";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF12";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF22";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF32";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(127 downto 0)   <= X"DEADBEEFABCDEF01DEADBEEFABCDEF03";
        axis_rx_tkeep(15 downto 0)    <= X"FFFF";
        axis_rx_tdata(255 downto 128) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF13";
        axis_rx_tkeep(31 downto 16)   <= X"FFFF";
        axis_rx_tdata(383 downto 256) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF23";
        axis_rx_tkeep(47 downto 32)   <= X"FFFF";
        axis_rx_tdata(511 downto 384) <= X"DEADBEEFABCDEF01DEADBEEFABCDEF33";
        axis_rx_tkeep(63 downto 48)   <= X"FFFF";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(127 downto 0)   <= X"0000000000CDEF01DEADBEEFABCDEF04";
        axis_rx_tkeep(15 downto 0)    <= X"07FF";
        axis_rx_tdata(255 downto 128) <= (others => '0');
        axis_rx_tkeep(31 downto 16)   <= X"0000";
        axis_rx_tdata(383 downto 256) <= (others => '0');
        axis_rx_tkeep(47 downto 32)   <= X"0000";
        axis_rx_tdata(511 downto 384) <= (others => '0');
        axis_rx_tkeep(63 downto 48)   <= X"0000";
        axis_rx_tvalid                <= '1';
        axis_rx_tlast                 <= '1';
        wait for C_CLK_PERIOD;
        axis_rx_tdata(511 downto 0)   <= (others => '0');
        axis_rx_tkeep(63 downto 0)    <= (others => '0');
        axis_rx_tvalid                <= '0';
        axis_rx_tlast                 <= '0';
        wait for C_CLK_PERIOD;

        wait;
    end process StimProc;

    UUT_i : lbustxaxisrx
        port map(
            lbus_txclk      => lbus_txclk,
            lbus_txreset    => lbus_txreset,
            axis_rx_tdata   => axis_rx_tdata,
            axis_rx_tvalid  => axis_rx_tvalid,
            axis_rx_tready  => axis_rx_tready,
            axis_rx_tkeep   => axis_rx_tkeep,
            axis_rx_tlast   => axis_rx_tlast,
            lbus_tx_rdyout  => lbus_tx_rdyout,
            lbus_txdataout0 => lbus_txdataout0,
            lbus_txenaout0  => lbus_txenaout0,
            lbus_txsopout0  => lbus_txsopout0,
            lbus_txeopout0  => lbus_txeopout0,
            lbus_txerrout0  => lbus_txerrout0,
            lbus_txmtyout0  => lbus_txmtyout0,
            lbus_txdataout1 => lbus_txdataout1,
            lbus_txenaout1  => lbus_txenaout1,
            lbus_txsopout1  => lbus_txsopout1,
            lbus_txeopout1  => lbus_txeopout1,
            lbus_txerrout1  => lbus_txerrout1,
            lbus_txmtyout1  => lbus_txmtyout1,
            lbus_txdataout2 => lbus_txdataout2,
            lbus_txenaout2  => lbus_txenaout2,
            lbus_txsopout2  => lbus_txsopout2,
            lbus_txeopout2  => lbus_txeopout2,
            lbus_txerrout2  => lbus_txerrout2,
            lbus_txmtyout2  => lbus_txmtyout2,
            lbus_txdataout3 => lbus_txdataout3,
            lbus_txenaout3  => lbus_txenaout3,
            lbus_txsopout3  => lbus_txsopout3,
            lbus_txeopout3  => lbus_txeopout3,
            lbus_txerrout3  => lbus_txerrout3,
            lbus_txmtyout3  => lbus_txmtyout3
        );
end architecture behavorial;
