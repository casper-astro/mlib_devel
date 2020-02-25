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
-- Module Name      : lbustoaxis - rtl                                         -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to map the L-BUS <=> AXIS interface. -
--                                                                             -
-- Dependencies     : lbustxaxisrx,lbusrxaxistx                                -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity lbustoaxis is
    port(
        lbus_rxclk      : in  STD_LOGIC;
        lbus_txclk      : in  STD_LOGIC;
        lbus_rxreset    : in  STD_LOGIC;
        lbus_txreset    : in  STD_LOGIC;
        --Inputs from AXIS bus 
        axis_rx_tdata   : in  STD_LOGIC_VECTOR(511 downto 0);
        axis_rx_tvalid  : in  STD_LOGIC;
        axis_rx_tready  : out STD_LOGIC;
        axis_rx_tkeep   : in  STD_LOGIC_VECTOR(63 downto 0);
        axis_rx_tlast   : in  STD_LOGIC;
        axis_rx_tuser   : in  STD_LOGIC;
        -- Outputs to AXIS bus
        axis_tx_tdata   : out STD_LOGIC_VECTOR(511 downto 0);
        axis_tx_tvalid  : out STD_LOGIC;
        axis_tx_tkeep   : out STD_LOGIC_VECTOR(63 downto 0);
        axis_tx_tlast   : out STD_LOGIC;
        axis_tx_tuser   : out STD_LOGIC;
        --Outputs to L-BUS interface
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
        lbus_txmtyout3  : out STD_LOGIC_VECTOR(3 downto 0);
        -- Inputs from L-BUS interface
        -- Segment 0		
        lbus_rxdatain0  : in  STD_LOGIC_VECTOR(127 downto 0);
        lbus_rxenain0   : in  STD_LOGIC;
        lbus_rxsopin0   : in  STD_LOGIC;
        lbus_rxeopin0   : in  STD_LOGIC;
        lbus_rxerrin0   : in  STD_LOGIC;
        lbus_rxmtyin0   : in  STD_LOGIC_VECTOR(3 downto 0);
        -- Segment 1		
        lbus_rxdatain1  : in  STD_LOGIC_VECTOR(127 downto 0);
        lbus_rxenain1   : in  STD_LOGIC;
        lbus_rxsopin1   : in  STD_LOGIC;
        lbus_rxeopin1   : in  STD_LOGIC;
        lbus_rxerrin1   : in  STD_LOGIC;
        lbus_rxmtyin1   : in  STD_LOGIC_VECTOR(3 downto 0);
        -- Segment 2		
        lbus_rxdatain2  : in  STD_LOGIC_VECTOR(127 downto 0);
        lbus_rxenain2   : in  STD_LOGIC;
        lbus_rxsopin2   : in  STD_LOGIC;
        lbus_rxeopin2   : in  STD_LOGIC;
        lbus_rxerrin2   : in  STD_LOGIC;
        lbus_rxmtyin2   : in  STD_LOGIC_VECTOR(3 downto 0);
        -- Segment 3		
        lbus_rxdatain3  : in  STD_LOGIC_VECTOR(127 downto 0);
        lbus_rxenain3   : in  STD_LOGIC;
        lbus_rxsopin3   : in  STD_LOGIC;
        lbus_rxeopin3   : in  STD_LOGIC;
        lbus_rxerrin3   : in  STD_LOGIC;
        lbus_rxmtyin3   : in  STD_LOGIC_VECTOR(3 downto 0)
    );
end entity lbustoaxis;

architecture rtl of lbustoaxis is
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
            axis_rx_tuser   : in  STD_LOGIC;
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

    component lbusrxaxistx is
        port(
            lbus_rxclk     : in  STD_LOGIC;
            lbus_rxreset   : in  STD_LOGIC;
            -- Outputs to AXIS bus
            axis_tx_tdata  : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tx_tvalid : out STD_LOGIC;
            axis_tx_tkeep  : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tx_tlast  : out STD_LOGIC;
            axis_tx_tuser  : out STD_LOGIC;
            -- Inputs from L-BUS interface
            lbus_rxdatain0 : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain0  : in  STD_LOGIC;
            lbus_rxsopin0  : in  STD_LOGIC;
            lbus_rxeopin0  : in  STD_LOGIC;
            lbus_rxerrin0  : in  STD_LOGIC;
            lbus_rxmtyin0  : in  STD_LOGIC_VECTOR(3 downto 0);
            lbus_rxdatain1 : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain1  : in  STD_LOGIC;
            lbus_rxsopin1  : in  STD_LOGIC;
            lbus_rxeopin1  : in  STD_LOGIC;
            lbus_rxerrin1  : in  STD_LOGIC;
            lbus_rxmtyin1  : in  STD_LOGIC_VECTOR(3 downto 0);
            lbus_rxdatain2 : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain2  : in  STD_LOGIC;
            lbus_rxsopin2  : in  STD_LOGIC;
            lbus_rxeopin2  : in  STD_LOGIC;
            lbus_rxerrin2  : in  STD_LOGIC;
            lbus_rxmtyin2  : in  STD_LOGIC_VECTOR(3 downto 0);
            lbus_rxdatain3 : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain3  : in  STD_LOGIC;
            lbus_rxsopin3  : in  STD_LOGIC;
            lbus_rxeopin3  : in  STD_LOGIC;
            lbus_rxerrin3  : in  STD_LOGIC;
            lbus_rxmtyin3  : in  STD_LOGIC_VECTOR(3 downto 0)
        );
    end component lbusrxaxistx;
begin

    LBUSRXAXISTX_i : lbusrxaxistx
        port map(
            lbus_rxclk     => lbus_rxclk,
            lbus_rxreset   => lbus_rxreset,
            axis_tx_tdata  => axis_tx_tdata,
            axis_tx_tvalid => axis_tx_tvalid,
            axis_tx_tkeep  => axis_tx_tkeep,
            axis_tx_tlast  => axis_tx_tlast,
            axis_tx_tuser  => axis_tx_tuser,
            lbus_rxdatain0 => lbus_rxdatain0,
            lbus_rxenain0  => lbus_rxenain0,
            lbus_rxsopin0  => lbus_rxsopin0,
            lbus_rxeopin0  => lbus_rxeopin0,
            lbus_rxerrin0  => lbus_rxerrin0,
            lbus_rxmtyin0  => lbus_rxmtyin0,
            lbus_rxdatain1 => lbus_rxdatain1,
            lbus_rxenain1  => lbus_rxenain1,
            lbus_rxsopin1  => lbus_rxsopin1,
            lbus_rxeopin1  => lbus_rxeopin1,
            lbus_rxerrin1  => lbus_rxerrin1,
            lbus_rxmtyin1  => lbus_rxmtyin1,
            lbus_rxdatain2 => lbus_rxdatain2,
            lbus_rxenain2  => lbus_rxenain2,
            lbus_rxsopin2  => lbus_rxsopin2,
            lbus_rxeopin2  => lbus_rxeopin2,
            lbus_rxerrin2  => lbus_rxerrin2,
            lbus_rxmtyin2  => lbus_rxmtyin2,
            lbus_rxdatain3 => lbus_rxdatain3,
            lbus_rxenain3  => lbus_rxenain3,
            lbus_rxsopin3  => lbus_rxsopin3,
            lbus_rxeopin3  => lbus_rxeopin3,
            lbus_rxerrin3  => lbus_rxerrin3,
            lbus_rxmtyin3  => lbus_rxmtyin3
        );

    LBUSTXAXISRX_i : lbustxaxisrx
        port map(
            lbus_txclk      => lbus_txclk,
            lbus_txreset    => lbus_txreset,
            axis_rx_tdata   => axis_rx_tdata,
            axis_rx_tvalid  => axis_rx_tvalid,
            axis_rx_tready  => axis_rx_tready,
            axis_rx_tkeep   => axis_rx_tkeep,
            axis_rx_tlast   => axis_rx_tlast,
            axis_rx_tuser   => axis_rx_tuser,
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

end architecture rtl;
