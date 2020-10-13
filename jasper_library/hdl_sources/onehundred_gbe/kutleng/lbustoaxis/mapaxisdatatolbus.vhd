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
-- Module Name      : mapaxisdatatolbus - rtl                                  -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module is used to align the AXIS data to L-BUS.     -
--                    The two interfaces have differing byte order.            -
--                                                                             -
-- Dependencies     : N/A                                                      -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity mapaxisdatatolbus is
    port(
        lbus_txclk   : in  STD_LOGIC;
        axis_data    : in  STD_LOGIC_VECTOR(127 downto 0);
        lbus_dataout : out STD_LOGIC_VECTOR(127 downto 0)
    );
end entity mapaxisdatatolbus;

architecture rtl of mapaxisdatatolbus is

begin

    MappingProc : process(lbus_txclk)
    begin
        if rising_edge(lbus_txclk) then
            -- Swap the bytes from big endian to little endian
            lbus_dataout(127 downto 120) <= axis_data(7 downto 0);
            lbus_dataout(119 downto 112) <= axis_data(15 downto 8);
            lbus_dataout(111 downto 104) <= axis_data(23 downto 16);
            lbus_dataout(103 downto 96)  <= axis_data(31 downto 24);
            lbus_dataout(95 downto 88)   <= axis_data(39 downto 32);
            lbus_dataout(87 downto 80)   <= axis_data(47 downto 40);
            lbus_dataout(79 downto 72)   <= axis_data(55 downto 48);
            lbus_dataout(71 downto 64)   <= axis_data(63 downto 56);
            lbus_dataout(63 downto 56)   <= axis_data(71 downto 64);
            lbus_dataout(55 downto 48)   <= axis_data(79 downto 72);
            lbus_dataout(47 downto 40)   <= axis_data(87 downto 80);
            lbus_dataout(39 downto 32)   <= axis_data(95 downto 88);
            lbus_dataout(31 downto 24)   <= axis_data(103 downto 96);
            lbus_dataout(23 downto 16)   <= axis_data(111 downto 104);
            lbus_dataout(15 downto 8)    <= axis_data(119 downto 112);
            lbus_dataout(7 downto 0)     <= axis_data(127 downto 120);
        end if;
    end process MappingProc;

end architecture rtl;
