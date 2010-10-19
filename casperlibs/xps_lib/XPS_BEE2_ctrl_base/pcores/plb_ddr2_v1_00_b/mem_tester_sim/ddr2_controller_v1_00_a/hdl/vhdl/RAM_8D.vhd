--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       RAM_8D.vhd
--
--  Description :      This block is used to build the asynchronous FIFOs from the 
--                     LUT RAMs. This is specific for data clocked at the rising edge
--                     of the clock
--
--  Date - revision : 05/01/2002
--
--  Author :          Lakshmi Gopalakrishnan
--
--  Contact : e-mail  hotline@xilinx.com
--            phone   + 1 800 255 7778 
--
--  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are 
--              provided to you "as is". Xilinx and its licensors make and you 
--              receive no warranties or conditions, express, implied, 
--              statutory or otherwise, and Xilinx specifically disclaims any 
--              implied warranties of merchantability, non-infringement, or 
--              fitness for a particular purpose. Xilinx does not warrant that 
--              the functions contained in these designs will meet your 
--              requirements, or that the operation of these designs will be 
--              uninterrupted or error free, or that defects in the Designs 
--              will be corrected. Furthermore, Xilinx does not warrant or 
--              make any representations regarding use or the results of the 
--              use of the designs in terms of correctness, accuracy, 
--              reliability, or otherwise. 
--
--              LIMITATION OF LIABILITY. In no event will Xilinx or its 
--              licensors be liable for any loss of data, lost profits, cost 
--              or procurement of substitute goods or services, or for any 
--              special, incidental, consequential, or indirect damages 
--              arising from the use or operation of the designs or 
--              accompanying documentation, however caused and on any theory 
--              of liability. This limitation will apply even if Xilinx 
--              has been advised of the possibility of such damage. This 
--              limitation shall apply not-withstanding the failure of the 
--              essential purpose of any limited remedies herein. 
--
--  Copyright © 2002 Xilinx, Inc.
--  All rights reserved 
-- 
--****************************************************************************************
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity RAM_8D is 
port(
   DPO : out std_logic_vector(7 downto 0);
   A0 : in std_logic;
   A1 : in std_logic;
   A2 : in std_logic;
   A3 : in std_logic;
   D  : in std_logic_vector(7 downto 0);
   DPRA0 : in std_logic;
   DPRA1 : in std_logic;
   DPRA2 : in std_logic;
   DPRA3 : in std_logic;
   WCLK  : in std_logic;
   WE    : in std_logic);
end RAM_8D;

architecture arc_RAM_8D of RAM_8D is 

component RAM16X1D
  port (D     : in std_logic;
        WE    : in std_logic;
        WCLK  : in std_logic;
        A0    : in std_logic;
        A1    : in std_logic;
        A2    : in std_logic;
        A3    : in std_logic;
        DPRA0 : in std_logic;
        DPRA1 : in std_logic;
        DPRA2 : in std_logic;
        DPRA3 : in std_logic;
 
        SPO   : out std_logic;
        DPO   : out std_logic);
end component;

          
begin
  
B0 : RAM16X1D port map ( D => D(0),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(0) );

B1 : RAM16X1D port map ( D => D(1),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(1) );

B2 : RAM16X1D port map ( D => D(2),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(2) );

B3 : RAM16X1D port map ( D => D(3),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(3) );

B4 : RAM16X1D port map ( D => D(4),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(4) );

B5 : RAM16X1D port map ( D => D(5),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(5) );

B6 : RAM16X1D port map ( D => D(6),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(6) );

B7 : RAM16X1D port map ( D => D(7),
                         WE => WE ,
                         WCLK => WCLK ,
                         A0 => A0,
                         A1 => A1,
                         A2 => A2,
                         A3 => A3,
                         DPRA0 => DPRA0,
                         DPRA1 => DPRA1,
                         DPRA2 => DPRA2,
                         DPRA3 => DPRA3,
                         SPO   => open,
                         DPO   => DPO(7) );

end arc_RAM_8D;
