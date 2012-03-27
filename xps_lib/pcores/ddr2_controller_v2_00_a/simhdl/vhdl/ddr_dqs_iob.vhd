--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       ddr_dqs_iob.vhd
--
--  Description :     This module instantiates DDR IOB output flip-flops, an 
--                    output buffer with registered tri-state, and an input buffer  
--                    for a single strobe/dqs bit. The DDR IOB output flip-flops 
--                    are used to forward strobe to memory during a write. During
--                    a read, the output of the IBUF is routed to the internal 
--                    delay module, dqs_delay. 
--                    
--  Date - revision : 07/28/2003
--
--  Author :          Maria George
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
--*****************************************************************************

library ieee;
use ieee.std_logic_1164.all;
--library synplify; 
--use synplify.attributes.all;

--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity ddr_dqs_iob is
port(
     clk            : in std_logic;
     ddr_dqs_reset  : in std_logic;
     ddr_dqs_enable : in std_logic;
     ddr_dqs        : inout std_logic;
     dqs            : out std_logic);              
end ddr_dqs_iob;
 
     
architecture arc_ddr_dqs_iob of ddr_dqs_iob is
component FD
port( D : in std_logic;
      Q : out std_logic;
      C : in std_logic);
end component;

component FDDRRSE 
port( Q  : out std_logic;
      C0 : in std_logic;
      C1 : in std_logic;
      CE : in std_logic;
      D0 : in std_logic;
      D1 : in std_logic;
      R  : in std_logic;
      S  : in std_logic);
end component;

component OBUFT
port(
      I : in std_logic;
      T : in std_logic;
      O : out std_logic);
end component;

component IBUF_SSTL2_II
port(
      I : in std_logic;
      O : out std_logic);
end component;

attribute syn_keep : boolean;

signal dqs_q            : std_logic;
signal ddr_dqs_enable1  : std_logic;
signal vcc              : std_logic;
signal gnd              : std_logic;
signal ddr_dqs_enable_b : std_logic;
signal data1            : std_logic;
  signal clk180           : std_logic;

  attribute syn_keep of clk180 : signal is true;

begin

--***********************************************************************
--     Output DDR generation
--     This includes instantiation of the output DDR flip flop.
--     Additionally, to keep synthesis tools from register sharing, manually
--     instantiate the output tri-state flip-flop.
--*********************************************************************** 
vcc <= '1';
gnd <= '0';
ddr_dqs_enable_b <= not ddr_dqs_enable;
data1 <= '0' when ddr_dqs_reset = '1' else
         '1';

  clk180 <= not clk;

U1 : FD port map  ( D => ddr_dqs_enable_b,
                    Q => ddr_dqs_enable1,
                    C => clk);

U2 : FDDRRSE port map (  Q => dqs_q,
                        C0 => clk180,
                        C1 => clk,
                        CE => vcc,
                        D0 => gnd,
                        D1 => data1,
                         R => gnd,
                         S => gnd);
--***********************************************************************
--    IO buffer for dqs signal. Allows for distribution of dqs
--     to the data (DQ) loads.
--***********************************************************************
U3 : OBUFT  port map ( I => dqs_q, 
                       T => ddr_dqs_enable1 ,
                       O => ddr_dqs);

U4 : IBUF_SSTL2_II port map ( I => ddr_dqs,
                              O => dqs);

  
end arc_ddr_dqs_iob;
