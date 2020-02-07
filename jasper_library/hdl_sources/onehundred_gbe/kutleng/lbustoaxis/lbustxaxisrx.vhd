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
-- Module Name      : lbustxaxisrx - rtl                                        -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to map the AXIS to L-BUS interface.  -
--                                                                             -
-- Dependencies     : maptokeeptomty,mapaxisdatatolbus                         -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity lbustxaxisrx is
    port(
        lbus_txclk      : in  STD_LOGIC;
        lbus_txreset    : in  STD_LOGIC;
        -- Inputs from AXIS bus
        axis_rx_tdata   : in  STD_LOGIC_VECTOR(511 downto 0);
        axis_rx_tvalid  : in  STD_LOGIC;
        axis_rx_tready  : out STD_LOGIC;
        axis_rx_tkeep   : in  STD_LOGIC_VECTOR(63 downto 0);
        axis_rx_tlast   : in  STD_LOGIC;
        axis_rx_tuser   : in  STD_LOGIC;
        -- Outputs to L-BUS interface
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
end entity lbustxaxisrx;

architecture rtl of lbustxaxisrx is
    component maptokeeptomty is
        port(
            lbus_txclk  : in  STD_LOGIC;
            axis_tkeep  : in  STD_LOGIC_VECTOR(15 downto 0);
            lbus_mtyout : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component maptokeeptomty;

    component mapaxisdatatolbus is
        port(
            lbus_txclk   : in  STD_LOGIC;
            axis_data    : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_dataout : out STD_LOGIC_VECTOR(127 downto 0)
        );
    end component mapaxisdatatolbus;
    signal paxis_tvalid : std_logic;

begin

    -- Tie TREADY to the tx_rdyout without delay as this will control empty slots
    axis_rx_tready <= lbus_tx_rdyout;
    -- We will only have SOP in segement 0
    -- Tie down all other SOPs they are not used
    lbus_txsopout1 <= '0';
    lbus_txsopout2 <= '0';
    lbus_txsopout3 <= '0';

    seg0mtymapping_i : maptokeeptomty
        port map(
            lbus_txclk  => lbus_txclk,
            axis_tkeep  => axis_rx_tkeep(15 downto 0),
            lbus_mtyout => lbus_txmtyout0
        );

    seg0datamapping_i : mapaxisdatatolbus
        port map(
            lbus_txclk   => lbus_txclk,
            axis_data    => axis_rx_tdata(127 downto 0),
            lbus_dataout => lbus_txdataout0
        );

    seg1mtymapping_i : maptokeeptomty
        port map(
            lbus_txclk  => lbus_txclk,
            axis_tkeep  => axis_rx_tkeep(31 downto 16),
            lbus_mtyout => lbus_txmtyout1
        );

    seg1datamapping_i : mapaxisdatatolbus
        port map(
            lbus_txclk   => lbus_txclk,
            axis_data    => axis_rx_tdata(255 downto 128),
            lbus_dataout => lbus_txdataout1
        );

    seg2mtymapping_i : maptokeeptomty
        port map(
            lbus_txclk  => lbus_txclk,
            axis_tkeep  => axis_rx_tkeep(47 downto 32),
            lbus_mtyout => lbus_txmtyout2
        );

    seg2datamapping_i : mapaxisdatatolbus
        port map(
            lbus_txclk   => lbus_txclk,
            axis_data    => axis_rx_tdata(383 downto 256),
            lbus_dataout => lbus_txdataout2
        );

    seg3mtymapping_i : maptokeeptomty
        port map(
            lbus_txclk  => lbus_txclk,
            axis_tkeep  => axis_rx_tkeep(63 downto 48),
            lbus_mtyout => lbus_txmtyout3
        );

    seg3datamapping_i : mapaxisdatatolbus
        port map(
            lbus_txclk   => lbus_txclk,
            axis_data    => axis_rx_tdata(511 downto 384),
            lbus_dataout => lbus_txdataout3
        );

    EnableAndEOPMappingProc : process(lbus_txclk)
    begin
        if rising_edge(lbus_txclk) then
            if (lbus_txreset = '1') then
                -- Deassert enable signals on reset
                lbus_txenaout0 <= '0';
                lbus_txenaout1 <= '0';
                lbus_txenaout2 <= '0';
                lbus_txenaout3 <= '0';
                lbus_txeopout0 <= '0';
                lbus_txeopout1 <= '0';
                lbus_txeopout2 <= '0';
                lbus_txeopout3 <= '0';
                lbus_txerrout0 <= '0';
                lbus_txerrout1 <= '0';
                lbus_txerrout2 <= '0';
                lbus_txerrout3 <= '0';
            else
                if (axis_rx_tlast = '1') then
                    -- There is TLAST so EOP must be generated

                    -- Determine where the EOP sits based on TKEEP
                    if (axis_rx_tkeep(63 downto 16) = X"000000000000") then
                        -- Only segment 0 is activated 
                        lbus_txeopout0 <= '1';
                        lbus_txeopout1 <= '0';
                        lbus_txeopout2 <= '0';
                        lbus_txeopout3 <= '0';
                        lbus_txenaout0 <= axis_rx_tvalid;
                        lbus_txenaout1 <= '0';
                        lbus_txenaout2 <= '0';
                        lbus_txenaout3 <= '0';
                        lbus_txerrout0 <= axis_rx_tuser;
                        lbus_txerrout1 <= '0';
                        lbus_txerrout2 <= '0';
                        lbus_txerrout3 <= '0';
                    else
                        if (axis_rx_tkeep(63 downto 32) = X"00000000") then
                            -- Segment 0 to 1 are activated 
                            lbus_txeopout0 <= '0';
                            lbus_txeopout1 <= '1';
                            lbus_txeopout2 <= '0';
                            lbus_txeopout3 <= '0';
                            lbus_txenaout0 <= axis_rx_tvalid;
                            lbus_txenaout1 <= axis_rx_tvalid;
                            lbus_txenaout2 <= '0';
                            lbus_txenaout3 <= '0';
                            lbus_txerrout0 <= axis_rx_tuser;
                            lbus_txerrout1 <= axis_rx_tuser;
                            lbus_txerrout2 <= '0';
                            lbus_txerrout3 <= '0';
                        else
                            if (axis_rx_tkeep(63 downto 48) = X"0000") then
                                -- Segment 0 to 2 are activated 
                                lbus_txeopout0 <= '0';
                                lbus_txeopout1 <= '0';
                                lbus_txeopout2 <= '1';
                                lbus_txeopout3 <= '0';
                                lbus_txenaout0 <= axis_rx_tvalid;
                                lbus_txenaout1 <= axis_rx_tvalid;
                                lbus_txenaout2 <= axis_rx_tvalid;
                                lbus_txenaout3 <= '0';
                                lbus_txerrout0 <= axis_rx_tuser;
                                lbus_txerrout1 <= axis_rx_tuser;
                                lbus_txerrout2 <= axis_rx_tuser;
                                lbus_txerrout3 <= '0';
                            else
                                -- Segment 0 to 3 are activated
                                lbus_txeopout0 <= '0';
                                lbus_txeopout1 <= '0';
                                lbus_txeopout2 <= '0';
                                lbus_txeopout3 <= '1';
                                lbus_txenaout0 <= axis_rx_tvalid;
                                lbus_txenaout1 <= axis_rx_tvalid;
                                lbus_txenaout2 <= axis_rx_tvalid;
                                lbus_txenaout3 <= axis_rx_tvalid;
                                lbus_txerrout0 <= axis_rx_tuser;
                                lbus_txerrout1 <= axis_rx_tuser;
                                lbus_txerrout2 <= axis_rx_tuser;
                                lbus_txerrout3 <= axis_rx_tuser;
                            end if;
                        end if;
                    end if;
                else
                    -- There is no TLAST
                    -- No EOP will be generated
                    lbus_txeopout0 <= '0';
                    lbus_txeopout1 <= '0';
                    lbus_txeopout2 <= '0';
                    lbus_txeopout3 <= '0';
                    -- If there is a valid transaction we pass it through
                    -- We assume all segments are activated is there is no TLAST
                    lbus_txenaout0 <= axis_rx_tvalid;
                    lbus_txenaout1 <= axis_rx_tvalid;
                    lbus_txenaout2 <= axis_rx_tvalid;
                    lbus_txenaout3 <= axis_rx_tvalid;

                end if;
            end if;
        end if;
    end process EnableAndEOPMappingProc;

    SOPMappingProc : process(lbus_txclk)
    begin
        if rising_edge(lbus_txclk) then
            paxis_tvalid <= axis_rx_tvalid;
            if (paxis_tvalid = '0' and axis_rx_tvalid = '1') then
                -- This is the start of the transaction signal start of sop
                lbus_txsopout0 <= '1';
            else
                -- We are inside the data transfer keep sop tied to ground
                lbus_txsopout0 <= '0';
            end if;
        end if;
    end process SOPMappingProc;

end architecture rtl;
