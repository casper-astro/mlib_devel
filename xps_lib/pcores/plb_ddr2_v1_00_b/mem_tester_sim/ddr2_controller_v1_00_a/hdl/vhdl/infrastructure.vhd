--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       infrastructure.vhd
--
--  Description :     
--                    Main fucntions of this module
--                       - generation of FPGA clocks.
--                       - generation of reset signals
--                       - implements calibration mechanism
--
--  Date - revision : 05/01/2002
--
--  Author :          Lakshmi Gopalakrishnan ( Modified by Sailja) 
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



library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--library synplify; 
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--

entity infrastructure is
  port(

       sys_rst              : in std_logic;
       clk_int              : in std_logic;
       rst_calib1           : in std_logic;
       delay_sel_val        : in std_logic_vector(4 downto 0);
       delay_sel_val1_val   : out std_logic_vector(4 downto 0)
  );
  
end   infrastructure;

architecture arc_infrastructure of infrastructure is

---- Component declarations -----

component cal_top                                                 
port             (                                                
	          clk         : in std_logic;                     
	          clk0        : in std_logic;                     
	          clk0dcmlock : in std_logic;                     
	          reset       : in std_logic;                     
	          okToSelTap  : in std_logic;
	          tapForDqs   : out std_logic_vector(4 downto 0)
                 );                                               
end component;

---- Signal declarations used on the diagram ----


--signal delay_sel_val           : std_logic_vector(4 downto 0);
signal delay_sel_val1          : std_logic_vector(4 downto 0);
signal delay_sel_val1_r        : std_logic_vector(4 downto 0);
signal rst_calib1_r1           : std_logic;
signal rst_calib1_r2           : std_logic;
signal vcc                     : std_logic;

begin



delay_sel_val1_val <= delay_sel_val1;


-----   To remove delta delays in the clock signals observed during simulation ,Following signals are used 

delay_sel_val1 <= delay_sel_val when (rst_calib1 = '0' and rst_calib1_r2 = '0') else
                  delay_sel_val1_r;


process(clk_int)
begin
 if clk_int'event and clk_int = '1' then
   if sys_rst = '1' then
     delay_sel_val1_r <= "00000";
     rst_calib1_r1    <= '0';
     rst_calib1_r2    <= '0';
   else
     delay_sel_val1_r <= delay_sel_val1;
     rst_calib1_r1    <= rst_calib1;
     rst_calib1_r2    <= rst_calib1_r1;
   end if;
 end if;
end process;



     

end arc_infrastructure;



