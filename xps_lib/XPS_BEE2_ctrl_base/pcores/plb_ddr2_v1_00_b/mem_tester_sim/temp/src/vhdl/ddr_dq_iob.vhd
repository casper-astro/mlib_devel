--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       ddr_dq_iob.vhd
--
--  Description :     This module instantiates DDR IOB output flip-flops, an 
--                    output buffer with registered tri-state, and an input buffer  
--                    for a single data bit. The DDR input flip-flops are not used
--                    since data is captured in the CLB flip-flops. 
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
use ieee.std_logic_unsigned.all;
--library synplify; 
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity ddr_dq_iob is 
port (
      ddr_dq_inout       : inout std_logic; --Bi-directional SDRAM data bus
      write_data_falling : in std_logic;    --Transmit data, output on falling edge
      write_data_rising  : in std_logic;    --Transmit data, output on rising edge
      write_en_val       : in std_logic;
      read_data_in       : out std_logic;   -- Received data
      clk90              : in std_logic;    --Clock 90
      reset              : in std_logic); 
 --attribute xc_props of ddr_dq_inout : signal is "IOB=TRUE";       
end ddr_dq_iob;

architecture arc_ddr_dq_iob of ddr_dq_iob is

attribute syn_keep : boolean;

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

component FDPE 
port(
       D   : in std_logic; 
       PRE : in std_logic; 
       C   : in std_logic;
       Q   : out std_logic; 
       CE  : in std_logic);
end component;

component OBUFT
port (
       I : in std_logic;
       T : in std_logic;
       O : out std_logic);
end component;

component IBUF
port (
       I : in std_logic;
       O : out std_logic);
end component;
        


--***********************************************************************\
--     Internal signal declaration
--***********************************************************************/
  
signal ddr_en       : std_logic;  -- Tri-state enable signal
signal ddr_dq_q     : std_logic;  -- Data output intermediate signal
signal ddr_dq_o     : std_logic;  -- Data output intermediate signal
signal GND          : std_logic;
signal clock_en     : std_logic := '1';
signal enable_b     : std_logic;
  signal clk270       : std_logic; 

  attribute syn_keep of clk270  : signal is true;

begin

GND    <= '0';
enable_b <= not write_en_val;
  clk270   <= not clk90;
-- Transmission data path

DDR_OUT : FDDRRSE port map
            (Q  => ddr_dq_q, 
             C0 => clk270, 
             C1 => clk90, 
             CE => clock_en,
             D0 => write_data_rising, 
             D1 => write_data_falling, 
             R  => GND, 
             S  => GND);
   
DQ_T   :   FDPE port map
           ( D   => enable_b, 
             PRE => reset, 
             C   => clk270, 
             Q   => ddr_en, 
             CE  => clock_en);

  
DQ_OBUFT : OBUFT port map
             ( I => ddr_dq_q,
               T => ddr_en,
               O => ddr_dq_inout);

-- Receive data path

DQ_IBUF :  IBUF port map
             ( I => ddr_dq_inout,
               O => read_data_in);


 end arc_ddr_dq_iob;

