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
-- Module Name      : mapmtytotkeep - rtl                                      -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to map TKEEP to MTY.                 -
--                                                                             -
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity maptokeeptomty is
    port(
        lbus_txclk  : in  STD_LOGIC;
        axis_tkeep  : in  STD_LOGIC_VECTOR(15 downto 0);
        lbus_mtyout : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity maptokeeptomty;

architecture rtl of maptokeeptomty is

begin

    MappingProc : process(lbus_txclk)
    begin
        if rising_edge(lbus_txclk) then
            case (axis_tkeep) is
                -- When all bytes are enabled 
                -- There are no empty byte slots
                when b"1111111111111111" =>
                    lbus_mtyout <= b"0000";
                -- Only 1 byte is disabled
                -- Only 15 bytes are enabled
                -- There is 1 empty slot
                when b"0111111111111111" =>
                    lbus_mtyout <= b"0001";
                -- Only 2 bytes are disabled
                -- Only 14 bytes are enabled
                -- There are 2 empty slots
                when b"0011111111111111" =>
                    lbus_mtyout <= b"0010";
                -- Only 3 bytes are disabled
                -- Only 13 bytes are enabled
                -- There are 3 empty slots
                when b"0001111111111111" =>
                    lbus_mtyout <= b"0011";
                -- Only 4 bytes are disabled
                -- Only 12 bytes are enabled
                -- There are 4 empty slots
                when b"0000111111111111" =>
                    lbus_mtyout <= b"0100";
                -- Only 5 bytes are disabled
                -- Only 11 bytes are enabled
                -- There are 5 empty slots
                when b"0000011111111111" =>
                    lbus_mtyout <= b"0101";
                -- Only 6 bytes are disabled
                -- Only 10 bytes are enabled
                -- There are 6 empty slots
                when b"0000001111111111" =>
                    lbus_mtyout <= b"0110";
                -- Only 7 bytes are disabled
                -- Only 9 bytes are enabled
                -- There are 7 empty slots
                when b"0000000111111111" =>
                    lbus_mtyout <= b"0111";
                -- Only 8 bytes are disabled
                -- Only 8 bytes are enabled
                -- There are 8 empty slots
                when b"0000000011111111" =>
                    lbus_mtyout <= b"1000";
                -- Only 9 bytes are disabled
                -- Only 7 bytes are enabled
                -- There are 9 empty slots
                when b"0000000001111111" =>
                    lbus_mtyout <= b"1001";
                -- Only 10 bytes are disabled
                -- Only 6 bytes are enabled
                -- There are 10 empty slots
                when b"0000000000111111" =>
                    lbus_mtyout <= b"1010";
                -- Only 11 bytes are disabled
                -- Only 5 bytes are enabled
                -- There are 11 empty slots
                when b"0000000000011111" =>
                    lbus_mtyout <= b"1011";
                -- Only 12 bytes are disabled
                -- Only 4 bytes are enabled
                -- There are 12 empty slots
                when b"0000000000001111" =>
                    lbus_mtyout <= b"1100";
                -- Only 13 bytes are disabled
                -- Only 3 bytes are enabled
                -- There are 13 empty slots
                when b"0000000000000111" =>
                    lbus_mtyout <= b"1101";
                -- Only 14 bytes are disabled
                -- Only 2 bytes are enabled
                -- There are 14 empty slots
                when b"0000000000000011" =>
                    lbus_mtyout <= b"1110";
                -- Only 15 bytes are disabled
                -- Only 1 byte is enabled
                -- There are 15 empty slots
                when b"0000000000000001" =>
                    lbus_mtyout <= b"1111";
                when others =>
                    null;
            end case;
        end if;
    end process MappingProc;

end architecture rtl;
