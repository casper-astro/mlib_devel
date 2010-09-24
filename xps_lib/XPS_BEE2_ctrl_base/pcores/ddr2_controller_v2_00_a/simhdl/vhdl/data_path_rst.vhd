--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_path_rst.vhd
--
--  Description :     This module generates the reset signals for data read module
--                    
--  Date - revision : 10/16/2003
--
--  Author :          Maria George ( Modified by Padmaja Sannala)
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
entity data_path_rst is
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset              : in std_logic;
     reset90            : in std_logic;
     reset180           : in std_logic;
     reset270           : in std_logic;    
     reset_r            : out std_logic;
     reset90_r          : out std_logic;
     reset180_r         : out std_logic;
     reset270_r         : out std_logic
     );
end data_path_rst;

architecture arc_data_path_rst of data_path_rst is

attribute syn_keep : boolean;
  component FD
    port(
      Q                              : out STD_LOGIC;
      C                              : in STD_LOGIC;
      D                              : in STD_LOGIC
      );
  end component;



  signal clk180    : std_logic;
  signal clk270    : std_logic;


  attribute syn_keep of clk180 : signal is true;
  attribute syn_keep of clk270 : signal is true;
begin
  
-- ********************************
--  generation of clk180 and clk270
-- *********************************


   clk180 <= not clk;
   clk270 <= not clk90;





--***********************************************************************
-- Reset flip-flops
--***********************************************************************

rst0_r : FD port map (                      
                      Q => reset_r,
                      C => clk,
                      D => reset
                      );
                      
rst90_r : FD port map (                      
                      Q => reset90_r,
                      C => clk90,
                      D => reset90
                      );
                      
rst180_r : FD port map (                      
                      Q => reset180_r,
                      C => clk180,
                      D => reset180
                      );                                            

rst270_r : FD port map (                      
                      Q => reset270_r,
                      C => clk270,
                      D => reset270
                      );
                                                                      
         
end arc_data_path_rst;


























































































































































































































































































































































































































































































































































































































































































































































