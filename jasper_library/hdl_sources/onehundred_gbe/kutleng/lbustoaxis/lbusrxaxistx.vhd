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
-- Module Name      : lbusrxaxistx - rtl                                        -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to map the L-BUS to AXIS interface.  -
--                                                                             -
-- Dependencies     : maplbusdatatoaxis,mapmtytotkeep                          -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity lbusrxaxistx is
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
end entity lbusrxaxistx;

architecture rtl of lbusrxaxistx is
    component maplbusdatatoaxis is
        port(
            lbus_rxclk   : in  STD_LOGIC;
            lbus_data    : in  STD_LOGIC_VECTOR(127 downto 0);
            axis_dataout : out STD_LOGIC_VECTOR(127 downto 0)
        );
    end component maplbusdatatoaxis;
    component mapmtytotkeep is
        port(
            lbus_rxclk    : in  STD_LOGIC;
            lbus_rxen     : in  STD_LOGIC;
            lbus_rxmty    : in  STD_LOGIC_VECTOR(3 downto 0);
            axis_tkeepout : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component mapmtytotkeep;

    alias lbus_rxdatain0fs0  : STD_LOGIC_VECTOR(127 downto 0) is lbus_rxdatain0;
    alias lbus_rxdatain1fs0  : STD_LOGIC_VECTOR(127 downto 0) is lbus_rxdatain1;
    alias lbus_rxdatain2fs0  : STD_LOGIC_VECTOR(127 downto 0) is lbus_rxdatain2;
    signal lbus_rxdatain0fs1 : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_rxdatain1fs1 : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_rxdatain2fs1 : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_rxdatain3fs1 : STD_LOGIC_VECTOR(127 downto 0);

    signal aligned_rxdatain0 : STD_LOGIC_VECTOR(127 downto 0);
    signal aligned_rxdatain1 : STD_LOGIC_VECTOR(127 downto 0);
    signal aligned_rxdatain2 : STD_LOGIC_VECTOR(127 downto 0);
    signal aligned_rxdatain3 : STD_LOGIC_VECTOR(127 downto 0);

    alias lbus_rxmtyin0fs0  : STD_LOGIC_VECTOR(3 downto 0) is lbus_rxmtyin0;
    alias lbus_rxmtyin1fs0  : STD_LOGIC_VECTOR(3 downto 0) is lbus_rxmtyin1;
    alias lbus_rxmtyin2fs0  : STD_LOGIC_VECTOR(3 downto 0) is lbus_rxmtyin2;
    signal lbus_rxmtyin0fs1 : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_rxmtyin1fs1 : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_rxmtyin2fs1 : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_rxmtyin3fs1 : STD_LOGIC_VECTOR(3 downto 0);

    signal aligned_rxmtyin0 : STD_LOGIC_VECTOR(3 downto 0);
    signal aligned_rxmtyin1 : STD_LOGIC_VECTOR(3 downto 0);
    signal aligned_rxmtyin2 : STD_LOGIC_VECTOR(3 downto 0);
    signal aligned_rxmtyin3 : STD_LOGIC_VECTOR(3 downto 0);

    alias lbus_rxeopin0fs0 : STD_LOGIC is lbus_rxeopin0;
    alias lbus_rxeopin1fs0 : STD_LOGIC is lbus_rxeopin1;
    alias lbus_rxeopin2fs0 : STD_LOGIC is lbus_rxeopin2;

    signal lbus_rxeopin0fs1 : STD_LOGIC;
    signal lbus_rxeopin1fs1 : STD_LOGIC;
    signal lbus_rxeopin2fs1 : STD_LOGIC;
    signal lbus_rxeopin3fs1 : STD_LOGIC;

    signal aligned_rxeopin0 : STD_LOGIC;
    signal aligned_rxeopin1 : STD_LOGIC;
    signal aligned_rxeopin2 : STD_LOGIC;
    signal aligned_rxeopin3 : STD_LOGIC;

    alias lbus_rxenain0fs0 : STD_LOGIC is lbus_rxenain0;
    alias lbus_rxenain1fs0 : STD_LOGIC is lbus_rxenain1;
    alias lbus_rxenain2fs0 : STD_LOGIC is lbus_rxenain2;

    signal lbus_rxenain0fs1 : STD_LOGIC;
    signal lbus_rxenain1fs1 : STD_LOGIC;
    signal lbus_rxenain2fs1 : STD_LOGIC;
    signal lbus_rxenain3fs1 : STD_LOGIC;

    signal aligned_rxenain0 : STD_LOGIC;
    signal aligned_rxenain1 : STD_LOGIC;
    signal aligned_rxenain2 : STD_LOGIC;
    signal aligned_rxenain3 : STD_LOGIC;

    signal CurrentAlignment : STD_LOGIC_VECTOR(1 downto 0);

begin

    ControlAxisProc : process(lbus_rxclk)
    begin
        if rising_edge(lbus_rxclk) then
            -- Whenever there is an EOP we signal TLAST
            axis_tx_tlast  <= aligned_rxeopin0 or aligned_rxeopin1 or aligned_rxeopin2 or aligned_rxeopin3;
            -- When ever there is an enable we signal TVALID			
            axis_tx_tvalid <= aligned_rxenain0; -- or aligned_rxenain1 or aligned_rxenain2 or aligned_rxenain3;
            if ((aligned_rxeopin0 = '1') or (aligned_rxeopin1 = '1') or (aligned_rxeopin2 = '1') or (aligned_rxeopin3 = '1')) then
                -- Flag an error signal on TUSER if there was an error and TLAST is valid 
                axis_tx_tuser <= lbus_rxerrin0 or lbus_rxerrin1 or lbus_rxerrin2 or lbus_rxerrin3;
            else
                -- Signal no error otherwise
                axis_tx_tuser <= '0';
            end if;
        end if;
    end process ControlAxisProc;

    AlignmentBarrelShifterProc : process(lbus_rxclk)
    begin
        if rising_edge(lbus_rxclk) then
            -- Save the data frame
            lbus_rxdatain0fs1 <= lbus_rxdatain0;
            lbus_rxdatain1fs1 <= lbus_rxdatain1;
            lbus_rxdatain2fs1 <= lbus_rxdatain2;
            lbus_rxdatain3fs1 <= lbus_rxdatain3;
            -- Save the MTY frame
            lbus_rxmtyin0fs1  <= lbus_rxmtyin0;
            lbus_rxmtyin1fs1  <= lbus_rxmtyin1;
            lbus_rxmtyin2fs1  <= lbus_rxmtyin2;
            lbus_rxmtyin3fs1  <= lbus_rxmtyin3;
            -- Save the EOPs 
            lbus_rxeopin0fs1  <= lbus_rxeopin0;
            lbus_rxeopin1fs1  <= lbus_rxeopin1;
            lbus_rxeopin2fs1  <= lbus_rxeopin2;
            lbus_rxeopin3fs1  <= lbus_rxeopin3;
            -- Save the ENAs 
            lbus_rxenain0fs1  <= lbus_rxenain0;
            lbus_rxenain1fs1  <= lbus_rxenain1;
            lbus_rxenain2fs1  <= lbus_rxenain2;
            lbus_rxenain3fs1  <= lbus_rxenain3;

            -- Determine the alignment using a barrel shifter
            case (CurrentAlignment) is
                when b"00" =>
                    -- Data is properly aligned to 64 byte boundary
                    aligned_rxdatain0 <= lbus_rxdatain0fs1;
                    aligned_rxdatain1 <= lbus_rxdatain1fs1;
                    aligned_rxdatain2 <= lbus_rxdatain2fs1;
                    aligned_rxdatain3 <= lbus_rxdatain3fs1;
                    -- Mty is also aligned to 64 byte boundary				
                    aligned_rxmtyin0  <= lbus_rxmtyin0fs1;
                    aligned_rxmtyin1  <= lbus_rxmtyin1fs1;
                    aligned_rxmtyin2  <= lbus_rxmtyin2fs1;
                    aligned_rxmtyin3  <= lbus_rxmtyin3fs1;
                    -- EOP is also aligned to 64 byte boundary
                    aligned_rxeopin0  <= lbus_rxeopin0fs1;
                    aligned_rxeopin1  <= lbus_rxeopin1fs1;
                    aligned_rxeopin2  <= lbus_rxeopin2fs1;
                    aligned_rxeopin3  <= lbus_rxeopin3fs1;
                    -- ENA is also aligned to 64 byte boundary
                    aligned_rxenain0  <= lbus_rxenain0fs1;
                    aligned_rxenain1  <= lbus_rxenain1fs1;
                    aligned_rxenain2  <= lbus_rxenain2fs1;
                    aligned_rxenain3  <= lbus_rxenain3fs1;

                when b"01" =>
                    -- Data is aligned to 16 byte boundary
                    aligned_rxdatain0 <= lbus_rxdatain1fs1;
                    aligned_rxdatain1 <= lbus_rxdatain2fs1;
                    aligned_rxdatain2 <= lbus_rxdatain3fs1;
                    aligned_rxdatain3 <= lbus_rxdatain0fs0;
                    -- Mty is also aligned to 16 byte boundary				
                    aligned_rxmtyin0  <= lbus_rxmtyin1fs1;
                    aligned_rxmtyin1  <= lbus_rxmtyin2fs1;
                    aligned_rxmtyin2  <= lbus_rxmtyin3fs1;
                    aligned_rxmtyin3  <= lbus_rxmtyin0fs0;
                    -- EOP is also aligned to 16 byte boundary
                    aligned_rxeopin0  <= lbus_rxeopin1fs1;
                    aligned_rxeopin1  <= lbus_rxeopin2fs1;
                    aligned_rxeopin2  <= lbus_rxeopin3fs1;
                    aligned_rxeopin3  <= lbus_rxeopin0fs0;
                    -- ENA is also aligned to 16 byte boundary
                    aligned_rxenain0  <= lbus_rxenain1fs1;
                    aligned_rxenain1  <= lbus_rxenain2fs1;
                    aligned_rxenain2  <= lbus_rxenain3fs1;
                    aligned_rxenain3  <= lbus_rxenain0fs0;

                when b"10" =>
                    -- Data is aligned to 32 byte boundary
                    aligned_rxdatain0 <= lbus_rxdatain2fs1;
                    aligned_rxdatain1 <= lbus_rxdatain3fs1;
                    aligned_rxdatain2 <= lbus_rxdatain0fs0;
                    aligned_rxdatain3 <= lbus_rxdatain1fs0;
                    -- Mty is also aligned to 32 byte boundary				
                    aligned_rxmtyin0  <= lbus_rxmtyin2fs1;
                    aligned_rxmtyin1  <= lbus_rxmtyin3fs1;
                    aligned_rxmtyin2  <= lbus_rxmtyin0fs0;
                    aligned_rxmtyin3  <= lbus_rxmtyin1fs0;
                    -- EOP is also aligned to 32 byte boundary
                    aligned_rxeopin0  <= lbus_rxeopin2fs1;
                    aligned_rxeopin1  <= lbus_rxeopin3fs1;
                    aligned_rxeopin2  <= lbus_rxeopin0fs0;
                    aligned_rxeopin3  <= lbus_rxeopin1fs0;
                    -- ENA is also aligned to 32 byte boundary
                    aligned_rxenain0  <= lbus_rxenain2fs1;
                    aligned_rxenain1  <= lbus_rxenain3fs1;
                    aligned_rxenain2  <= lbus_rxenain0fs0;
                    aligned_rxenain3  <= lbus_rxenain1fs0;

                when b"11" =>
                    -- Data is aligned to 48 byte boundary
                    aligned_rxdatain0 <= lbus_rxdatain3fs1;
                    aligned_rxdatain1 <= lbus_rxdatain0fs0;
                    aligned_rxdatain2 <= lbus_rxdatain1fs0;
                    aligned_rxdatain3 <= lbus_rxdatain2fs0;
                    -- Mty is also aligned to 48 byte boundary				
                    aligned_rxmtyin0  <= lbus_rxmtyin3fs1;
                    aligned_rxmtyin1  <= lbus_rxmtyin0fs0;
                    aligned_rxmtyin2  <= lbus_rxmtyin1fs0;
                    aligned_rxmtyin3  <= lbus_rxmtyin2fs0;
                    -- EOP is also aligned to 48 byte boundary
                    aligned_rxeopin0  <= lbus_rxeopin3fs1;
                    aligned_rxeopin1  <= lbus_rxeopin0fs0;
                    aligned_rxeopin2  <= lbus_rxeopin1fs0;
                    aligned_rxeopin3  <= lbus_rxeopin2fs0;
                    -- ENA is also aligned to 48 byte boundary
                    aligned_rxenain0  <= lbus_rxenain3fs1;
                    aligned_rxenain1  <= lbus_rxenain0fs0;
                    aligned_rxenain2  <= lbus_rxenain1fs0;
                    aligned_rxenain3  <= lbus_rxenain2fs0;
                when others =>
                    null;
            end case;
        end if;
    end process AlignmentBarrelShifterProc;

    CurrentAlignmentProc : process(lbus_rxclk)
    begin
        if rising_edge(lbus_rxclk) then
            if (lbus_rxreset = '1') then
                CurrentAlignment <= (others => '0');
            else
                if (lbus_rxsopin0 = '1') then
                    -- The SOP is in segment 0
                    -- The alignment is 64 bytes
                    CurrentAlignment <= b"00";
                else
                    if (lbus_rxsopin1 = '1') then
                        -- The SOP is in segment 1
                        -- The alignment is 16 bytes
                        CurrentAlignment <= b"01";
                    else
                        if (lbus_rxsopin2 = '1') then
                            -- The SOP is in segment 2
                            -- The alignment is 32 bytes
                            CurrentAlignment <= b"10";
                        else
                            if (lbus_rxsopin3 = '1') then
                                -- The SOP is in segment 3
                                -- The alignment is 48 bytes
                                CurrentAlignment <= b"11";
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process CurrentAlignmentProc;

    Seg0DataMapping_i : maplbusdatatoaxis
        port map(
            lbus_rxclk   => lbus_rxclk,
            lbus_data    => aligned_rxdatain0,
            axis_dataout => axis_tx_tdata(127 downto 0)
        );

    Seg0MTYMapping_i : mapmtytotkeep
        port map(
            lbus_rxclk    => lbus_rxclk,
            lbus_rxen     => aligned_rxenain0,
            lbus_rxmty    => aligned_rxmtyin0,
            axis_tkeepout => axis_tx_tkeep(15 downto 0)
        );

    Seg1DataMapping_i : maplbusdatatoaxis
        port map(
            lbus_rxclk   => lbus_rxclk,
            lbus_data    => aligned_rxdatain1,
            axis_dataout => axis_tx_tdata(255 downto 128)
        );

    Seg1MTYMapping_i : mapmtytotkeep
        port map(
            lbus_rxclk    => lbus_rxclk,
            lbus_rxen     => aligned_rxenain1,
            lbus_rxmty    => aligned_rxmtyin1,
            axis_tkeepout => axis_tx_tkeep(31 downto 16)
        );

    Seg2DataMapping_i : maplbusdatatoaxis
        port map(
            lbus_rxclk   => lbus_rxclk,
            lbus_data    => aligned_rxdatain2,
            axis_dataout => axis_tx_tdata(383 downto 256)
        );

    Seg2MTYMapping_i : mapmtytotkeep
        port map(
            lbus_rxclk    => lbus_rxclk,
            lbus_rxen     => aligned_rxenain2,
            lbus_rxmty    => aligned_rxmtyin2,
            axis_tkeepout => axis_tx_tkeep(47 downto 32)
        );

    Seg3DataMapping_i : maplbusdatatoaxis
        port map(
            lbus_rxclk   => lbus_rxclk,
            lbus_data    => aligned_rxdatain3,
            axis_dataout => axis_tx_tdata(511 downto 384)
        );

    Seg3MTYMapping_i : mapmtytotkeep
        port map(
            lbus_rxclk    => lbus_rxclk,
            lbus_rxen     => aligned_rxenain3,
            lbus_rxmty    => aligned_rxmtyin3,
            axis_tkeepout => axis_tx_tkeep(63 downto 48)
        );

end architecture rtl;
