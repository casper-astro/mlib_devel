--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_read_controller.vhd
--
--  Description :     This module generates all the control signals  for the 
--                     read data path.
-- 
--                    
--  Date - revision : 10/16/2003
--
--  Author :          Maria George ( Modified by Sailaja)
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
use work.parameter.all;
--library synplify; 
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   data_read_controller_72bit_rl  is
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset_r            : in std_logic;
     reset90_r          : in std_logic;
     reset180_r         : in std_logic;
     reset270_r         : in std_logic;
     rst_dqs_div        : in std_logic;
     delay_sel          : in std_logic_vector(4 downto 0);   
     dqs_int_delay_in0  : in std_logic;
     dqs_int_delay_in1  : in std_logic;
     dqs_int_delay_in2  : in std_logic;
     dqs_int_delay_in3  : in std_logic;
     dqs_int_delay_in4  : in std_logic;
     dqs_int_delay_in5  : in std_logic;
     dqs_int_delay_in6  : in std_logic;
     dqs_int_delay_in7  : in std_logic;
     dqs_int_delay_in8  : in std_logic; 
     next_state         : in std_logic;   
     read_data_valid_1_val  : out std_logic;
     read_data_valid_2_val  : out std_logic;
     transfer_done_0_val    : out std_logic_vector(3 downto 0);
     transfer_done_1_val    : out std_logic_vector(3 downto 0);
     transfer_done_2_val    : out std_logic_vector(3 downto 0);
     transfer_done_3_val    : out std_logic_vector(3 downto 0);
     transfer_done_4_val    : out std_logic_vector(3 downto 0);
     transfer_done_5_val    : out std_logic_vector(3 downto 0);
     transfer_done_6_val    : out std_logic_vector(3 downto 0);
     transfer_done_7_val    : out std_logic_vector(3 downto 0);
     transfer_done_8_val    : out std_logic_vector(3 downto 0);
     fifo_00_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_01_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_02_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_03_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_10_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_11_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_12_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_13_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_20_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_21_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_22_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_23_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_30_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_31_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_32_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_33_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_40_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_41_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_42_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_43_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_50_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_51_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_52_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_53_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_60_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_61_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_62_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_63_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_70_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_71_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_72_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_73_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_80_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_81_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_82_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_83_wr_addr_val    : out std_logic_vector(3 downto 0);
     fifo_00_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_01_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_02_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_03_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_10_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_11_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_12_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_13_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_20_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_21_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_22_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_23_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_30_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_31_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_32_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_33_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_40_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_41_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_42_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_43_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_50_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_51_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_52_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_53_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_60_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_61_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_62_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_63_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_70_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_71_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_72_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_73_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_80_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_81_rd_addr_val    : out std_logic_vector(3 downto 0);    
     fifo_82_rd_addr_val    : out std_logic_vector(3 downto 0);
     fifo_83_rd_addr_val    : out std_logic_vector(3 downto 0);    
     dqs_delayed_col0_val   : out std_logic_vector(8 downto 0);
     dqs_delayed_col1_val   : out std_logic_vector(8 downto 0); 
     dqs_div_col0_val       : out std_logic_vector(8 downto 0);
     dqs_div_col1_val       : out std_logic_vector(8 downto 0)
    
     
     );
end   data_read_controller_72bit_rl;  

architecture   arc_data_read_controller_72bit_rl of   data_read_controller_72bit_rl    is

component dqs_delay                                             
              port (
		    clk_in   : in std_logic;
		    sel_in   : in std_logic_vector(4 downto 0);
		    clk_out  : out std_logic
		  );                                           
end component;

component ddr2_dqs_div
  port (
        dqs           : in std_logic;  -- first column for negative edge data
        dqs1          : in std_logic;  -- second column for positive edge data
        reset         : in std_logic; 
        rst_dqs_div_delayed   : in std_logic; 
        dqs_divn      : out std_logic;
        dqs_divp      : out std_logic
       );
end component;

component ddr2_transfer_done
  port (
        clk0            : in std_logic;
        clk90           : in std_logic;                 
        reset           : in std_logic;
        reset90         : in std_logic;
        reset180        : in std_logic;
        reset270        : in std_logic;        
        dqs_div         : in std_logic;
        transfer_done0  : out std_logic;
        transfer_done1  : out std_logic;
        transfer_done2  : out std_logic;
        transfer_done3  : out std_logic
       );
end component; 


signal fifo_41_not_empty      : std_logic;
signal fifo_43_not_empty      : std_logic;

signal fifo_41_not_empty_r    : std_logic := '0';
signal fifo_43_not_empty_r    : std_logic := '0';
signal fifo_41_not_empty_r1   : std_logic := '0';
signal fifo_43_not_empty_r1   : std_logic := '0';
signal read_data_valid_1      : std_logic;
signal read_data_valid_2      : std_logic;
signal rst_dqs_div_int        : std_logic ;

 signal     transfer_done_0    : std_logic_vector(3 downto 0); 
 signal     transfer_done_1    : std_logic_vector(3 downto 0); 
 signal     transfer_done_2    : std_logic_vector(3 downto 0); 
 signal     transfer_done_3    : std_logic_vector(3 downto 0); 
 signal     transfer_done_4    : std_logic_vector(3 downto 0); 
 signal     transfer_done_5    : std_logic_vector(3 downto 0); 
 signal     transfer_done_6    : std_logic_vector(3 downto 0); 
 signal     transfer_done_7    : std_logic_vector(3 downto 0); 
 signal     transfer_done_8    : std_logic_vector(3 downto 0); 
 signal     fifo_00_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_01_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_02_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_03_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_10_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_11_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_12_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_13_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_20_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_21_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_22_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_23_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_30_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_31_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_32_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_33_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_40_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_41_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_42_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_43_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_50_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_51_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_52_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_53_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_60_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_61_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_62_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_63_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_70_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_71_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_72_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_73_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_80_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_81_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_82_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     fifo_83_wr_addr    : std_logic_vector(3 downto 0) := "0000"; 
 signal     dqs_delayed_col0   : std_logic_vector(8 downto 0); 
 signal     dqs_delayed_col1   : std_logic_vector(8 downto 0);  
 signal     dqs_div_col0       : std_logic_vector(8 downto 0); 
 signal     dqs_div_col1       : std_logic_vector(8 downto 0);   
 signal     rst_dqs_div_delayed: std_logic;                  
 signal     fifo_00_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_01_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_02_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_03_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_10_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_11_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_12_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_13_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_20_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_21_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_22_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_23_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_30_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_31_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_32_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_33_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_40_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_41_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_42_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_43_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_50_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_51_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_52_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_53_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_60_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_61_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_62_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_63_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_70_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_71_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_72_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_73_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_80_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_81_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_82_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     fifo_83_rd_addr    : std_logic_vector(3 downto 0) := "0000";
 signal     read_data_valid_1_reg   : std_logic := '0';
 signal     read_data_valid_2_reg   : std_logic := '0';

 begin

 transfer_done_0_val <= transfer_done_0; 
 transfer_done_1_val <= transfer_done_1; 
 transfer_done_2_val <= transfer_done_2; 
 transfer_done_3_val <= transfer_done_3; 
 transfer_done_4_val <= transfer_done_4; 
 transfer_done_5_val <= transfer_done_5; 
 transfer_done_6_val <= transfer_done_6; 
 transfer_done_7_val <= transfer_done_7; 
 transfer_done_8_val <= transfer_done_8; 
 fifo_00_wr_addr_val <= fifo_00_wr_addr; 
 fifo_01_wr_addr_val <= fifo_01_wr_addr; 
 fifo_02_wr_addr_val <= fifo_02_wr_addr; 
 fifo_03_wr_addr_val <= fifo_03_wr_addr; 
 fifo_10_wr_addr_val <= fifo_10_wr_addr; 
 fifo_11_wr_addr_val <= fifo_11_wr_addr; 
 fifo_12_wr_addr_val <= fifo_12_wr_addr; 
 fifo_13_wr_addr_val <= fifo_13_wr_addr; 
 fifo_20_wr_addr_val <= fifo_20_wr_addr; 
 fifo_21_wr_addr_val <= fifo_21_wr_addr; 
 fifo_22_wr_addr_val <= fifo_22_wr_addr; 
 fifo_23_wr_addr_val <= fifo_23_wr_addr; 
 fifo_30_wr_addr_val <= fifo_30_wr_addr; 
 fifo_31_wr_addr_val <= fifo_31_wr_addr; 
 fifo_32_wr_addr_val <= fifo_32_wr_addr; 
 fifo_33_wr_addr_val <= fifo_33_wr_addr; 
 fifo_40_wr_addr_val <= fifo_40_wr_addr; 
 fifo_41_wr_addr_val <= fifo_41_wr_addr; 
 fifo_42_wr_addr_val <= fifo_42_wr_addr; 
 fifo_43_wr_addr_val <= fifo_43_wr_addr; 
 fifo_50_wr_addr_val <= fifo_50_wr_addr; 
 fifo_51_wr_addr_val <= fifo_51_wr_addr; 
 fifo_52_wr_addr_val <= fifo_52_wr_addr; 
 fifo_53_wr_addr_val <= fifo_53_wr_addr; 
 fifo_60_wr_addr_val <= fifo_60_wr_addr; 
 fifo_61_wr_addr_val <= fifo_61_wr_addr; 
 fifo_62_wr_addr_val <= fifo_62_wr_addr; 
 fifo_63_wr_addr_val <= fifo_63_wr_addr; 
 fifo_70_wr_addr_val <= fifo_70_wr_addr; 
 fifo_71_wr_addr_val <= fifo_71_wr_addr; 
 fifo_72_wr_addr_val <= fifo_72_wr_addr; 
 fifo_73_wr_addr_val <= fifo_73_wr_addr; 
 fifo_80_wr_addr_val <= fifo_80_wr_addr; 
 fifo_81_wr_addr_val <= fifo_81_wr_addr; 
 fifo_82_wr_addr_val <= fifo_82_wr_addr; 
 fifo_83_wr_addr_val <= fifo_83_wr_addr; 
 dqs_delayed_col0_val <= dqs_delayed_col0; 
 dqs_delayed_col1_val <= dqs_delayed_col1; 
 dqs_div_col0_val <= dqs_div_col0; 
 dqs_div_col1_val <= dqs_div_col1; 
 
fifo_00_rd_addr_val <= fifo_00_rd_addr;
fifo_01_rd_addr_val <= fifo_01_rd_addr;
fifo_02_rd_addr_val <= fifo_02_rd_addr;
fifo_03_rd_addr_val <= fifo_03_rd_addr;
fifo_10_rd_addr_val <= fifo_10_rd_addr;
fifo_11_rd_addr_val <= fifo_11_rd_addr;
fifo_12_rd_addr_val <= fifo_12_rd_addr;
fifo_13_rd_addr_val <= fifo_13_rd_addr;
fifo_20_rd_addr_val <= fifo_20_rd_addr;
fifo_21_rd_addr_val <= fifo_21_rd_addr;
fifo_22_rd_addr_val <= fifo_22_rd_addr;
fifo_23_rd_addr_val <= fifo_23_rd_addr;
fifo_30_rd_addr_val <= fifo_30_rd_addr;
fifo_31_rd_addr_val <= fifo_31_rd_addr;
fifo_32_rd_addr_val <= fifo_32_rd_addr;
fifo_33_rd_addr_val <= fifo_33_rd_addr;
fifo_40_rd_addr_val <= fifo_40_rd_addr;
fifo_41_rd_addr_val <= fifo_41_rd_addr;
fifo_42_rd_addr_val <= fifo_42_rd_addr;
fifo_43_rd_addr_val <= fifo_43_rd_addr;
fifo_50_rd_addr_val <= fifo_50_rd_addr;
fifo_51_rd_addr_val <= fifo_51_rd_addr;
fifo_52_rd_addr_val <= fifo_52_rd_addr;
fifo_53_rd_addr_val <= fifo_53_rd_addr;
fifo_60_rd_addr_val <= fifo_60_rd_addr;
fifo_61_rd_addr_val <= fifo_61_rd_addr;
fifo_62_rd_addr_val <= fifo_62_rd_addr;
fifo_63_rd_addr_val <= fifo_63_rd_addr;
fifo_70_rd_addr_val <= fifo_70_rd_addr;
fifo_71_rd_addr_val <= fifo_71_rd_addr;
fifo_72_rd_addr_val <= fifo_72_rd_addr;
fifo_73_rd_addr_val <= fifo_73_rd_addr;
fifo_80_rd_addr_val <= fifo_80_rd_addr;
fifo_81_rd_addr_val <= fifo_81_rd_addr;
fifo_82_rd_addr_val <= fifo_82_rd_addr;
fifo_83_rd_addr_val <= fifo_83_rd_addr;



process(clk90)
begin
if clk90'event and clk90 = '1' then
 if reset90_r = '1' then
    fifo_00_rd_addr  <= "0000";
    fifo_01_rd_addr  <= "0000";
    fifo_02_rd_addr  <= "0000";
    fifo_03_rd_addr  <= "0000";
    fifo_10_rd_addr  <= "0000";
    fifo_11_rd_addr  <= "0000";
    fifo_12_rd_addr  <= "0000";
    fifo_13_rd_addr  <= "0000";
    fifo_20_rd_addr  <= "0000";
    fifo_21_rd_addr  <= "0000";
    fifo_22_rd_addr  <= "0000";
    fifo_23_rd_addr  <= "0000";
    fifo_30_rd_addr  <= "0000";
    fifo_31_rd_addr  <= "0000";
    fifo_32_rd_addr  <= "0000";
    fifo_33_rd_addr  <= "0000";
    fifo_40_rd_addr  <= "0000";
    fifo_41_rd_addr  <= "0000";
    fifo_42_rd_addr  <= "0000";
    fifo_43_rd_addr  <= "0000";
    fifo_50_rd_addr  <= "0000";
    fifo_51_rd_addr  <= "0000";
    fifo_52_rd_addr  <= "0000";
    fifo_53_rd_addr  <= "0000";
    fifo_60_rd_addr  <= "0000";
    fifo_61_rd_addr  <= "0000";
    fifo_62_rd_addr  <= "0000";
    fifo_63_rd_addr  <= "0000";
    fifo_70_rd_addr  <= "0000";
    fifo_71_rd_addr  <= "0000";
    fifo_72_rd_addr  <= "0000";
    fifo_73_rd_addr  <= "0000";
    fifo_80_rd_addr  <= "0000";
    fifo_81_rd_addr  <= "0000";
    fifo_82_rd_addr  <= "0000";
    fifo_83_rd_addr  <= "0000";
 else
    case next_state is
      
         when '0' => 
             if (read_data_valid_1_reg = '1') then  
               fifo_00_rd_addr <= fifo_00_rd_addr + "0001";
               fifo_01_rd_addr <= fifo_01_rd_addr + "0001";
               fifo_10_rd_addr <= fifo_10_rd_addr + "0001";
               fifo_11_rd_addr <= fifo_11_rd_addr + "0001";
               fifo_20_rd_addr <= fifo_20_rd_addr + "0001";
               fifo_21_rd_addr <= fifo_21_rd_addr + "0001";
               fifo_30_rd_addr <= fifo_30_rd_addr + "0001";
               fifo_31_rd_addr <= fifo_31_rd_addr + "0001";
               fifo_40_rd_addr <= fifo_40_rd_addr + "0001";
               fifo_41_rd_addr <= fifo_41_rd_addr + "0001";
               fifo_50_rd_addr <= fifo_50_rd_addr + "0001";
               fifo_51_rd_addr <= fifo_51_rd_addr + "0001";
               fifo_60_rd_addr <= fifo_60_rd_addr + "0001";
               fifo_61_rd_addr <= fifo_61_rd_addr + "0001";
               fifo_70_rd_addr <= fifo_70_rd_addr + "0001";
               fifo_71_rd_addr <= fifo_71_rd_addr + "0001";
               fifo_80_rd_addr <= fifo_80_rd_addr + "0001";
               fifo_81_rd_addr <= fifo_81_rd_addr + "0001";
             else 
               fifo_00_rd_addr <= fifo_00_rd_addr;
               fifo_01_rd_addr <= fifo_01_rd_addr;
               fifo_10_rd_addr <= fifo_10_rd_addr;
               fifo_11_rd_addr <= fifo_11_rd_addr;
               fifo_20_rd_addr <= fifo_20_rd_addr;
               fifo_21_rd_addr <= fifo_21_rd_addr;
               fifo_30_rd_addr <= fifo_30_rd_addr;
               fifo_31_rd_addr <= fifo_31_rd_addr;
               fifo_40_rd_addr <= fifo_40_rd_addr;
               fifo_41_rd_addr <= fifo_41_rd_addr;
               fifo_50_rd_addr <= fifo_50_rd_addr;
               fifo_51_rd_addr <= fifo_51_rd_addr;
               fifo_60_rd_addr <= fifo_60_rd_addr;
               fifo_61_rd_addr <= fifo_61_rd_addr;
               fifo_70_rd_addr <= fifo_70_rd_addr;
               fifo_71_rd_addr <= fifo_71_rd_addr;
               fifo_80_rd_addr <= fifo_80_rd_addr;
               fifo_81_rd_addr <= fifo_81_rd_addr;
             end if; 
             
         when '1' => 
             if (read_data_valid_2_reg = '1') then
               fifo_02_rd_addr <= fifo_02_rd_addr + "0001";
               fifo_03_rd_addr <= fifo_03_rd_addr + "0001";
               fifo_12_rd_addr <= fifo_12_rd_addr + "0001";
               fifo_13_rd_addr <= fifo_13_rd_addr + "0001";
               fifo_22_rd_addr <= fifo_22_rd_addr + "0001";
               fifo_23_rd_addr <= fifo_23_rd_addr + "0001";
               fifo_32_rd_addr <= fifo_32_rd_addr + "0001";
               fifo_33_rd_addr <= fifo_33_rd_addr + "0001";
               fifo_42_rd_addr <= fifo_42_rd_addr + "0001";
               fifo_43_rd_addr <= fifo_43_rd_addr + "0001";
               fifo_52_rd_addr <= fifo_52_rd_addr + "0001";
               fifo_53_rd_addr <= fifo_53_rd_addr + "0001";
               fifo_62_rd_addr <= fifo_62_rd_addr + "0001";
               fifo_63_rd_addr <= fifo_63_rd_addr + "0001";
               fifo_72_rd_addr <= fifo_72_rd_addr + "0001";
               fifo_73_rd_addr <= fifo_73_rd_addr + "0001";
               fifo_82_rd_addr <= fifo_82_rd_addr + "0001";
               fifo_83_rd_addr <= fifo_83_rd_addr + "0001";
             else
               fifo_02_rd_addr <= fifo_02_rd_addr;
               fifo_03_rd_addr <= fifo_03_rd_addr;
               fifo_12_rd_addr <= fifo_12_rd_addr;
               fifo_13_rd_addr <= fifo_13_rd_addr;
               fifo_22_rd_addr <= fifo_22_rd_addr;
               fifo_23_rd_addr <= fifo_23_rd_addr;
               fifo_32_rd_addr <= fifo_32_rd_addr;
               fifo_33_rd_addr <= fifo_33_rd_addr;
               fifo_42_rd_addr <= fifo_42_rd_addr;
               fifo_43_rd_addr <= fifo_43_rd_addr;
               fifo_52_rd_addr <= fifo_52_rd_addr;
               fifo_53_rd_addr <= fifo_53_rd_addr;
               fifo_62_rd_addr <= fifo_62_rd_addr;
               fifo_63_rd_addr <= fifo_63_rd_addr;
               fifo_72_rd_addr <= fifo_72_rd_addr;
               fifo_73_rd_addr <= fifo_73_rd_addr;
               fifo_82_rd_addr <= fifo_82_rd_addr;
               fifo_83_rd_addr <= fifo_83_rd_addr;
             end if;
          when others => 
             fifo_00_rd_addr <= "0000";
             fifo_01_rd_addr <= "0000";
             fifo_02_rd_addr <= "0000";
             fifo_03_rd_addr <= "0000";
             fifo_10_rd_addr <= "0000";
             fifo_11_rd_addr <= "0000";
             fifo_12_rd_addr <= "0000";
             fifo_13_rd_addr <= "0000";
             fifo_20_rd_addr <= "0000";
             fifo_21_rd_addr <= "0000";
             fifo_22_rd_addr <= "0000";
             fifo_23_rd_addr <= "0000";
             fifo_30_rd_addr <= "0000";
             fifo_31_rd_addr <= "0000";
             fifo_32_rd_addr <= "0000";
             fifo_33_rd_addr <= "0000";
             fifo_40_rd_addr <= "0000";
             fifo_41_rd_addr <= "0000";
             fifo_42_rd_addr <= "0000";
             fifo_43_rd_addr <= "0000";
             fifo_50_rd_addr <= "0000";
             fifo_51_rd_addr <= "0000";
             fifo_52_rd_addr <= "0000";
             fifo_53_rd_addr <= "0000";
             fifo_60_rd_addr <= "0000";
             fifo_61_rd_addr <= "0000";
             fifo_62_rd_addr <= "0000";
             fifo_63_rd_addr <= "0000";
             fifo_70_rd_addr <= "0000";
             fifo_71_rd_addr <= "0000";
             fifo_72_rd_addr <= "0000";
             fifo_73_rd_addr <= "0000";
             fifo_80_rd_addr <= "0000";
             fifo_81_rd_addr <= "0000";
             fifo_82_rd_addr <= "0000";
             fifo_83_rd_addr <= "0000";
     end case;                                             
end if;                                                    
end if;                                                    
end process;  

read_data_valid_1_val <= read_data_valid_1_reg;
read_data_valid_2_val <= read_data_valid_2_reg;

rst_dqs_div_int <= not rst_dqs_div;
 
read_data_valid_1     <= '1' when (fifo_41_not_empty_r1 = '1' and fifo_41_not_empty = '1') else
                         '0';

read_data_valid_2     <= '1' when (fifo_43_not_empty_r1 = '1' and fifo_43_not_empty = '1') else
                         '0';
                         

fifo_41_not_empty   <= '0' when (fifo_00_rd_addr(3 downto 0) = fifo_41_wr_addr(3 downto 0)) else
                       '1';                                                                     
fifo_43_not_empty   <= '0' when (fifo_02_rd_addr(3 downto 0) = fifo_43_wr_addr(3 downto 0)) else
                       '1';                                                                     


                     
process (clk90)                                            
begin                                                      
  if (rising_edge(clk90)) then                             
    if (reset90_r = '1') then                                 
      fifo_41_not_empty_r   <= '0';
      fifo_43_not_empty_r   <= '0';
      fifo_41_not_empty_r1  <= '0';
      fifo_43_not_empty_r1  <= '0';      
      read_data_valid_1_reg <= '0';                            
      read_data_valid_2_reg <= '0';                            
    else                                                   
      fifo_41_not_empty_r   <= fifo_41_not_empty;
      fifo_43_not_empty_r   <= fifo_43_not_empty;
      fifo_41_not_empty_r1  <= fifo_41_not_empty_r;
      fifo_43_not_empty_r1  <= fifo_43_not_empty_r; 
      read_data_valid_1_reg <=  read_data_valid_1;                         
      read_data_valid_2_reg <=  read_data_valid_2;
    end if;                                                
  end if;                                                  
end process;              
                          
process (clk90)           
begin                     
  if (rising_edge(clk90)) then
    if (reset90_r = '1') then
      fifo_00_wr_addr <= "0000";
    elsif (transfer_done_0(0) = '1') then 
      fifo_00_wr_addr <= fifo_00_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if (reset90_r = '1') then
      fifo_01_wr_addr <= "0000";
    elsif (transfer_done_0(1) = '1') then 
      fifo_01_wr_addr <= fifo_01_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_02_wr_addr <= "0000";
    elsif (transfer_done_0(2) = '1') then 
      fifo_02_wr_addr <= fifo_02_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_03_wr_addr <= "0000";
    elsif (transfer_done_0(3) = '1') then 
      fifo_03_wr_addr <= fifo_03_wr_addr + "0001";
    end if;
  end if;    
end process;
----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_10_wr_addr <= "0000";
    elsif (transfer_done_1(0) = '1') then 
      fifo_10_wr_addr <= fifo_10_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_11_wr_addr <= "0000";
    elsif (transfer_done_1(1) = '1') then 
      fifo_11_wr_addr <= fifo_11_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_12_wr_addr <= "0000";
    elsif (transfer_done_1(2) = '1') then 
      fifo_12_wr_addr <= fifo_12_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_13_wr_addr <= "0000";
    elsif (transfer_done_1(3) = '1') then 
      fifo_13_wr_addr <= fifo_13_wr_addr + "0001";
    end if;
  end if;    
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_20_wr_addr <= "0000";
    elsif (transfer_done_2(0) = '1') then 
      fifo_20_wr_addr <= fifo_20_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_21_wr_addr <= "0000";
    elsif (transfer_done_2(1) = '1') then 
      fifo_21_wr_addr <= fifo_21_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_22_wr_addr <= "0000";
    elsif (transfer_done_2(2) = '1') then 
      fifo_22_wr_addr <= fifo_22_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_23_wr_addr <= "0000";
    elsif (transfer_done_2(3) = '1') then 
      fifo_23_wr_addr <= fifo_23_wr_addr + "0001";
    end if;
  end if;    
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_30_wr_addr <= "0000";
    elsif (transfer_done_3(0) = '1') then 
      fifo_30_wr_addr <= fifo_30_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_31_wr_addr <= "0000";
    elsif (transfer_done_3(1) = '1') then 
      fifo_31_wr_addr <= fifo_31_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_32_wr_addr <= "0000";
    elsif (transfer_done_3(2) = '1') then 
      fifo_32_wr_addr <= fifo_32_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_33_wr_addr <= "0000";
    elsif (transfer_done_3(3) = '1') then 
      fifo_33_wr_addr <= fifo_33_wr_addr + "0001";
    end if;
  end if;    
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_40_wr_addr <= "0000";
    elsif (transfer_done_4(0) = '1') then 
      fifo_40_wr_addr <= fifo_40_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_41_wr_addr <= "0000";
    elsif (transfer_done_4(1) = '1') then 
      fifo_41_wr_addr <= fifo_41_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_42_wr_addr <= "0000";
    elsif (transfer_done_4(2) = '1') then 
      fifo_42_wr_addr <= fifo_42_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_43_wr_addr <= "0000";
    elsif (transfer_done_4(3) = '1') then 
      fifo_43_wr_addr <= fifo_43_wr_addr + "0001";
    end if;
  end if;    
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_50_wr_addr <= "0000";
    elsif (transfer_done_5(0) = '1') then 
      fifo_50_wr_addr <= fifo_50_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_51_wr_addr <= "0000";
    elsif (transfer_done_5(1) = '1') then 
      fifo_51_wr_addr <= fifo_51_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_52_wr_addr <= "0000";
    elsif (transfer_done_5(2) = '1') then 
      fifo_52_wr_addr <= fifo_52_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_53_wr_addr <= "0000";
    elsif (transfer_done_5(3) = '1') then 
      fifo_53_wr_addr <= fifo_53_wr_addr + "0001";
    end if;
  end if;    
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_60_wr_addr <= "0000";
    elsif (transfer_done_6(0) = '1') then 
      fifo_60_wr_addr <= fifo_60_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_61_wr_addr <= "0000";
    elsif (transfer_done_6(1) = '1') then 
      fifo_61_wr_addr <= fifo_61_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_62_wr_addr <= "0000";
    elsif (transfer_done_6(2) = '1') then 
      fifo_62_wr_addr <= fifo_62_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_63_wr_addr <= "0000";
    elsif (transfer_done_6(3) = '1') then 
      fifo_63_wr_addr <= fifo_63_wr_addr + "0001";
    end if;
  end if;    
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_70_wr_addr <= "0000";
    elsif (transfer_done_7(0) = '1') then 
      fifo_70_wr_addr <= fifo_70_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_71_wr_addr <= "0000";
    elsif (transfer_done_7(1) = '1') then 
      fifo_71_wr_addr <= fifo_71_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_72_wr_addr <= "0000";
    elsif (transfer_done_7(2) = '1') then 
      fifo_72_wr_addr <= fifo_72_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_73_wr_addr <= "0000";
    elsif (transfer_done_7(3) = '1') then 
      fifo_73_wr_addr <= fifo_73_wr_addr + "0001";
    end if;
  end if;    
end process;

----------------------------------------------------------
process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_80_wr_addr <= "0000";
    elsif (transfer_done_8(0) = '1') then 
      fifo_80_wr_addr <= fifo_80_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_81_wr_addr <= "0000";
    elsif (transfer_done_8(1) = '1') then 
      fifo_81_wr_addr <= fifo_81_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_82_wr_addr <= "0000";
    elsif (transfer_done_8(2) = '1') then 
      fifo_82_wr_addr <= fifo_82_wr_addr + "0001";
    end if;
  end if;    
end process;

process (clk90)
begin
  if (rising_edge(clk90)) then
    if ( reset90_r = '1') then
      fifo_83_wr_addr <= "0000";
    elsif (transfer_done_8(3) = '1') then 
      fifo_83_wr_addr <= fifo_83_wr_addr + "0001";
    end if;
  end if;    
end process;




--***********************************************************************
--    Read Data Capture Module Instantiations
--

                             
-------------------------------------------------------------------------------------------------------------------------------------------------
--**************************************************************************************************
-- rst_dqs_div internal delay to match dqs internal delay
--**************************************************************************************************
rst_dqs_div_delay0 : dqs_delay port map (                                                                          
	                                 clk_in   => rst_dqs_div_int,  --rst_dqs_div, --   
	                                 sel_in   => delay_sel,                                
	                                 clk_out  => rst_dqs_div_delayed                               
	                                 );

--**************************************************************************************************
-- DQS Internal Delay Circuit implemented in LUTs
--**************************************************************************************************

-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay0_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in0,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(0)                               
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay0_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in0,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(0)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay1_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in1,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(1)                               
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay1_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in1,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(1)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay2_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in2,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(2)                               
	                             );

-- Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay2_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in2,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(2)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay3_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in3,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(3)                               
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay3_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in3,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(3)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay4_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in4,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(4)                               
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay4_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in4,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(4)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay5_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in5,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(5)                               
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay5_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in5,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(5)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay6_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in6,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(6)                               
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay6_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in6,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(6)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay7_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in7,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(7)
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay7_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in7,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(7)                               
	                             );
	                    
-- Internal Clock Delay circuit placed in the first column (for falling edge data) adjacent to IOBs                               
dqs_delay8_col0 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in8,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col0(8)                               
	                             );

-- Internal Clock Delay circuit placed in the second column (for rising edge data) adjacent to IOBs                               	                    
dqs_delay8_col1 : dqs_delay port map (                                                                          
	                              clk_in   => dqs_int_delay_in8,
	                              sel_in   => delay_sel,                                
	                              clk_out  => dqs_delayed_col1(8)                               
	                             );

-------------------------------------------------------------------------------------------------------------------------------------------------- 
--***************************************************************************************************
-- DQS Divide by 2 instantiations
--*************************************************************************************************** 

ddr2_dqs_div0 : ddr2_dqs_div
port map (        
          dqs           => dqs_delayed_col0(0),
          dqs1          => dqs_delayed_col1(0), 
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(0),
          dqs_divp      => dqs_div_col1(0)
         );
         
ddr2_dqs_div1 : ddr2_dqs_div
port map (     
          dqs           => dqs_delayed_col0(1),
          dqs1          => dqs_delayed_col1(1),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(1),
          dqs_divp      => dqs_div_col1(1)
         );
         
ddr2_dqs_div2 : ddr2_dqs_div
port map (      
          dqs           => dqs_delayed_col0(2),
          dqs1          => dqs_delayed_col1(2),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(2),
          dqs_divp      => dqs_div_col1(2)
         );
         
ddr2_dqs_div3 : ddr2_dqs_div
port map (     
          dqs           => dqs_delayed_col0(3),
          dqs1          => dqs_delayed_col1(3),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(3),
          dqs_divp      => dqs_div_col1(3)
         );

ddr2_dqs_div4 : ddr2_dqs_div
port map (       
          dqs           => dqs_delayed_col0(4),
          dqs1          => dqs_delayed_col1(4),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(4),
          dqs_divp      => dqs_div_col1(4)
         );
         
ddr2_dqs_div5 : ddr2_dqs_div
port map (     
          dqs           => dqs_delayed_col0(5),
          dqs1          => dqs_delayed_col1(5),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(5),
          dqs_divp      => dqs_div_col1(5)          
         );
         
ddr2_dqs_div6 : ddr2_dqs_div
port map (         
          dqs           => dqs_delayed_col0(6),
          dqs1          => dqs_delayed_col1(6),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(6),
          dqs_divp      => dqs_div_col1(6)       
         );
         
ddr2_dqs_div7 : ddr2_dqs_div
port map (        
          dqs           => dqs_delayed_col0(7),
          dqs1          => dqs_delayed_col1(7),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(7),
          dqs_divp      => dqs_div_col1(7)          
         );
         
ddr2_dqs_div8 : ddr2_dqs_div
port map (         
          dqs           => dqs_delayed_col0(8),
          dqs1          => dqs_delayed_col1(8),          
          reset         => reset_r,
          rst_dqs_div_delayed   => rst_dqs_div_delayed,
          dqs_divn      => dqs_div_col0(8),
          dqs_divp      => dqs_div_col1(8)          
         );
         
--------------------------------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************
-- Transfer done instantiations (One instantiation peer strobe)
--****************************************************************************************************************         
        
ddr2_transfer_done0 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,            
            dqs_div         => dqs_div_col1(0),
            transfer_done0  => transfer_done_0(0),
            transfer_done1  => transfer_done_0(1),
            transfer_done2  => transfer_done_0(2),
            transfer_done3  => transfer_done_0(3)
           );

ddr2_transfer_done1 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(1),
            transfer_done0  => transfer_done_1(0),
            transfer_done1  => transfer_done_1(1),
            transfer_done2  => transfer_done_1(2),
            transfer_done3  => transfer_done_1(3)
           );
           
ddr2_transfer_done2 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
            reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(2),
            transfer_done0  => transfer_done_2(0),
            transfer_done1  => transfer_done_2(1),
            transfer_done2  => transfer_done_2(2),
            transfer_done3  => transfer_done_2(3)
           );
           
ddr2_transfer_done3 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
          reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(3),
            transfer_done0  => transfer_done_3(0),
            transfer_done1  => transfer_done_3(1),
            transfer_done2  => transfer_done_3(2),
            transfer_done3  => transfer_done_3(3)
           );
           
ddr2_transfer_done4 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(4),
            transfer_done0  => transfer_done_4(0),
            transfer_done1  => transfer_done_4(1),
            transfer_done2  => transfer_done_4(2),
            transfer_done3  => transfer_done_4(3)
           );
           
ddr2_transfer_done5 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
            reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(5),
            transfer_done0  => transfer_done_5(0),
            transfer_done1  => transfer_done_5(1),
            transfer_done2  => transfer_done_5(2),
            transfer_done3  => transfer_done_5(3)
           );
           
ddr2_transfer_done6 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(6),
            transfer_done0  => transfer_done_6(0),
            transfer_done1  => transfer_done_6(1),
            transfer_done2  => transfer_done_6(2),
            transfer_done3  => transfer_done_6(3)
           );
           
ddr2_transfer_done7 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
           reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(7),
            transfer_done0  => transfer_done_7(0),
            transfer_done1  => transfer_done_7(1),
            transfer_done2  => transfer_done_7(2),
            transfer_done3  => transfer_done_7(3)
           );
           
ddr2_transfer_done8 : ddr2_transfer_done
  port map (
            clk0            => clk,
            clk90           => clk90,
          reset           => reset_r,
            reset90         => reset90_r,
            reset180        => reset180_r,
            reset270        => reset270_r,
            dqs_div         => dqs_div_col1(8),
            transfer_done0  => transfer_done_8(0),
            transfer_done1  => transfer_done_8(1),
            transfer_done2  => transfer_done_8(2),
            transfer_done3  => transfer_done_8(3)
           );

end   arc_data_read_controller_72bit_rl;  

