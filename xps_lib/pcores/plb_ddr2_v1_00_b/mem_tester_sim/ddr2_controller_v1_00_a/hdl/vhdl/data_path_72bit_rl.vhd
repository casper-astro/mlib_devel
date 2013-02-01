--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_path.vhd
--
--  Description :     This module comprises the write and read data paths for the
--                    DDR1 memory interface. The write data along with write enable 
--                    signals are forwarded to the DDR IOB FFs. The read data is 
--                    captured in CLB FFs and finally input to FIFOs.
-- 
--                    
--  Date - revision : 10/16/2003
--
--  Author :          Maria George (Modified by Sailaja)
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
entity   data_path_72bit_rl  is
port(
	-- system ports
	clk                    : in std_logic;
	clk90                  : in std_logic;
	reset                  : in std_logic;
	reset90                : in std_logic;
	reset180               : in std_logic;
	reset270               : in std_logic;
	delay_sel              : in std_logic_vector(4 downto 0);   

	-- data ports (on clk0)
	input_data             : in std_logic_vector(143 downto 0);
	write_enable           : in std_logic;
	input_data_valid       : in std_logic;
	byte_enable            : in std_logic_vector(17 downto 0);
	output_data_valid      : out std_logic;
	output_data            : out std_logic_vector(143 downto 0);

	-- iobs ports
	ddr_dqs_int_delay_in0  : in std_logic;
	ddr_dqs_int_delay_in1  : in std_logic;
	ddr_dqs_int_delay_in2  : in std_logic;
	ddr_dqs_int_delay_in3  : in std_logic;
	ddr_dqs_int_delay_in4  : in std_logic;
	ddr_dqs_int_delay_in5  : in std_logic;
	ddr_dqs_int_delay_in6  : in std_logic;
	ddr_dqs_int_delay_in7  : in std_logic;
	ddr_dqs_int_delay_in8  : in std_logic;  
	ddr_dq                 : in std_logic_vector(71 downto 0);       
	ddr_write_en           : out std_logic;
	ddr_data_mask_falling  : out std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : out std_logic_vector(8 downto 0);
	ddr_write_data_falling : out std_logic_vector(71 downto 0);
	ddr_write_data_rising  : out std_logic_vector(71 downto 0);
	ddr_rst_dqs_div_in     : in std_logic
     );
end   data_path_72bit_rl;  

architecture   arc_data_path_72bit_rl of   data_path_72bit_rl    is

component	data_read_72bit_rl 
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset90_r          : in std_logic;
     reset270_r         : in std_logic;
     dq                 : in std_logic_vector(71 downto 0);  
     read_data_valid_1  : in std_logic;
     read_data_valid_2  : in std_logic; 
     transfer_done_0    : in std_logic_vector(3 downto 0);
     transfer_done_1    : in std_logic_vector(3 downto 0);
     transfer_done_2    : in std_logic_vector(3 downto 0);
     transfer_done_3    : in std_logic_vector(3 downto 0);
     transfer_done_4    : in std_logic_vector(3 downto 0);
     transfer_done_5    : in std_logic_vector(3 downto 0);
     transfer_done_6    : in std_logic_vector(3 downto 0);
     transfer_done_7    : in std_logic_vector(3 downto 0);
     transfer_done_8    : in std_logic_vector(3 downto 0);
     fifo_00_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_01_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_02_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_03_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_10_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_11_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_12_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_13_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_20_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_21_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_22_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_23_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_30_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_31_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_32_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_33_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_40_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_41_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_42_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_43_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_50_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_51_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_52_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_53_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_60_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_61_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_62_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_63_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_70_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_71_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_72_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_73_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_80_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_81_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_82_wr_addr    : in std_logic_vector(3 downto 0);
     fifo_83_wr_addr    : in std_logic_vector(3 downto 0);
     dqs_delayed_col0   : in std_logic_vector(8 downto 0);
     dqs_delayed_col1   : in std_logic_vector(8 downto 0);
     dqs_div_col0       : in std_logic_vector(8 downto 0);
     dqs_div_col1       : in std_logic_vector(8 downto 0);
     fifo_00_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_01_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_02_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_03_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_10_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_11_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_12_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_13_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_20_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_21_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_22_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_23_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_30_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_31_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_32_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_33_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_40_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_41_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_42_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_43_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_50_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_51_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_52_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_53_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_60_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_61_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_62_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_63_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_70_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_71_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_72_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_73_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_80_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_81_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_82_rd_addr    : in std_logic_vector(3 downto 0);
     fifo_83_rd_addr    : in std_logic_vector(3 downto 0);
     next_state_val     : out std_logic;     
     output_data_90     : out std_logic_vector(143 downto 0);
     data_valid_90      : out std_logic
    );
end component;

component	data_read_controller_72bit_rl 
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
     dqs_div_col0_val      : out std_logic_vector(8 downto 0);
     dqs_div_col1_val       : out std_logic_vector(8 downto 0)
    );
end component;

component	data_write_72bit 
port(
     clk                : in std_logic;
     clk90              : in std_logic;
     reset_r            : in std_logic;
     reset90_r          : in std_logic;
     reset180_r         : in std_logic;
     reset270_r         : in std_logic;

     input_data         : in std_logic_vector(143 downto 0);
     byte_enable        : in std_logic_vector(17 downto 0);
     write_enable       : in std_logic;
     input_data_valid   : in std_logic;

     write_en_val       : out std_logic;
     write_data_falling : out std_logic_vector(71 downto 0);
     write_data_rising  : out std_logic_vector(71 downto 0);
     data_mask_falling  : out std_logic_vector(8 downto 0);
     data_mask_rising   : out std_logic_vector(8 downto 0)
     );
end component;   

component data_path_rst
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
end component;

signal reset_r          : std_logic;
signal reset90_r        : std_logic;
signal reset180_r       : std_logic;
signal reset270_r       : std_logic;                                         

 signal fifo_00_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_01_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_02_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_03_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_10_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_11_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_12_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_13_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_20_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_21_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_22_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_23_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_30_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_31_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_32_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_33_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_40_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_41_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_42_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_43_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_50_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_51_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_52_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_53_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_60_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_61_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_62_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_63_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_70_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_71_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_72_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_73_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_80_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_81_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_82_rd_addr    : std_logic_vector(3 downto 0);
 signal fifo_83_rd_addr    : std_logic_vector(3 downto 0);
 signal read_data_valid_1  : std_logic;
 signal read_data_valid_2  : std_logic;
 signal transfer_done_0    : std_logic_vector(3 downto 0);           
 signal transfer_done_1    : std_logic_vector(3 downto 0);           
 signal transfer_done_2    : std_logic_vector(3 downto 0);           
 signal transfer_done_3    : std_logic_vector(3 downto 0);           
 signal transfer_done_4    : std_logic_vector(3 downto 0);           
 signal transfer_done_5    : std_logic_vector(3 downto 0);           
 signal transfer_done_6    : std_logic_vector(3 downto 0);           
 signal transfer_done_7    : std_logic_vector(3 downto 0);           
 signal transfer_done_8    : std_logic_vector(3 downto 0);           
 signal fifo_00_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_01_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_02_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_03_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_10_wr_addr    : std_logic_vector(3 downto 0);          
 signal fifo_11_wr_addr    : std_logic_vector(3 downto 0);             
 signal fifo_12_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_13_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_20_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_21_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_22_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_23_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_30_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_31_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_32_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_33_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_40_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_41_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_42_wr_addr    : std_logic_vector(3 downto 0);          
 signal fifo_43_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_50_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_51_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_52_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_53_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_60_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_61_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_62_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_63_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_70_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_71_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_72_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_73_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_80_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_81_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_82_wr_addr    : std_logic_vector(3 downto 0);           
 signal fifo_83_wr_addr    : std_logic_vector(3 downto 0);           
 signal dqs_delayed_col0   : std_logic_vector(8 downto 0);
 signal dqs_delayed_col1   : std_logic_vector(8 downto 0);
 signal dqs_div_col0       : std_logic_vector(8 downto 0);
 signal dqs_div_col1       : std_logic_vector(8 downto 0);
 signal next_state         : std_logic;

 signal data_valid_90      : std_logic;
 signal output_data_90     : std_logic_vector(143 downto 0);

 begin

data_read0	:	data_read_72bit_rl 
port map (
           clk                 =>    clk,          
           clk90               =>    clk90,
           reset90_r           =>    reset90_r,
           reset270_r          =>    reset270_r,
           dq                  =>    ddr_dq,
           read_data_valid_1   =>    read_data_valid_1,
           read_data_valid_2   =>    read_data_valid_2,
           transfer_done_0     =>    transfer_done_0,
           transfer_done_1     =>    transfer_done_1,
           transfer_done_2     =>    transfer_done_2,
           transfer_done_3     =>    transfer_done_3,
           transfer_done_4     =>    transfer_done_4,
           transfer_done_5     =>    transfer_done_5,
           transfer_done_6     =>    transfer_done_6,
           transfer_done_7     =>    transfer_done_7,
           transfer_done_8     =>    transfer_done_8,
           fifo_00_wr_addr     =>    fifo_00_wr_addr,
           fifo_01_wr_addr     =>    fifo_01_wr_addr,
           fifo_02_wr_addr     =>    fifo_02_wr_addr,
           fifo_03_wr_addr     =>    fifo_03_wr_addr,
           fifo_10_wr_addr     =>    fifo_10_wr_addr,
           fifo_11_wr_addr     =>    fifo_11_wr_addr,
           fifo_12_wr_addr     =>    fifo_12_wr_addr,
           fifo_13_wr_addr     =>    fifo_13_wr_addr,
           fifo_20_wr_addr     =>    fifo_20_wr_addr,
           fifo_21_wr_addr     =>    fifo_21_wr_addr,
           fifo_22_wr_addr     =>    fifo_22_wr_addr,
           fifo_23_wr_addr     =>    fifo_23_wr_addr,
           fifo_30_wr_addr     =>    fifo_30_wr_addr,
           fifo_31_wr_addr     =>    fifo_31_wr_addr,
           fifo_32_wr_addr     =>    fifo_32_wr_addr,
           fifo_33_wr_addr     =>    fifo_33_wr_addr,
           fifo_40_wr_addr     =>    fifo_40_wr_addr,
           fifo_41_wr_addr     =>    fifo_41_wr_addr,
           fifo_42_wr_addr     =>    fifo_42_wr_addr,
           fifo_43_wr_addr     =>    fifo_43_wr_addr,
           fifo_50_wr_addr     =>    fifo_50_wr_addr,
           fifo_51_wr_addr     =>    fifo_51_wr_addr,
           fifo_52_wr_addr     =>    fifo_52_wr_addr,
           fifo_53_wr_addr     =>    fifo_53_wr_addr,
           fifo_60_wr_addr     =>    fifo_60_wr_addr,
           fifo_61_wr_addr     =>    fifo_61_wr_addr,
           fifo_62_wr_addr     =>    fifo_62_wr_addr,
           fifo_63_wr_addr     =>    fifo_63_wr_addr,
           fifo_70_wr_addr     =>    fifo_70_wr_addr,
           fifo_71_wr_addr     =>    fifo_71_wr_addr,
           fifo_72_wr_addr     =>    fifo_72_wr_addr,
           fifo_73_wr_addr     =>    fifo_73_wr_addr,
           fifo_80_wr_addr     =>    fifo_80_wr_addr,
           fifo_81_wr_addr     =>    fifo_81_wr_addr,
           fifo_82_wr_addr     =>    fifo_82_wr_addr,
           fifo_83_wr_addr     =>    fifo_83_wr_addr,
           dqs_delayed_col0    =>    dqs_delayed_col0,
           dqs_delayed_col1    =>    dqs_delayed_col1,
           dqs_div_col0        =>    dqs_div_col0,
           dqs_div_col1        =>    dqs_div_col1,   
           fifo_00_rd_addr     =>    fifo_00_rd_addr,
           fifo_01_rd_addr     =>    fifo_01_rd_addr,
           fifo_02_rd_addr     =>    fifo_02_rd_addr,
           fifo_03_rd_addr     =>    fifo_03_rd_addr,
           fifo_10_rd_addr     =>    fifo_10_rd_addr,
           fifo_11_rd_addr     =>    fifo_11_rd_addr,
           fifo_12_rd_addr     =>    fifo_12_rd_addr,
           fifo_13_rd_addr     =>    fifo_13_rd_addr,
           fifo_20_rd_addr     =>    fifo_20_rd_addr,
           fifo_21_rd_addr     =>    fifo_21_rd_addr,
           fifo_22_rd_addr     =>    fifo_22_rd_addr,
           fifo_23_rd_addr     =>    fifo_23_rd_addr,
           fifo_30_rd_addr     =>    fifo_30_rd_addr,
           fifo_31_rd_addr     =>    fifo_31_rd_addr,
           fifo_32_rd_addr     =>    fifo_32_rd_addr,
           fifo_33_rd_addr     =>    fifo_33_rd_addr,
           fifo_40_rd_addr     =>    fifo_40_rd_addr,
           fifo_41_rd_addr     =>    fifo_41_rd_addr,
           fifo_42_rd_addr     =>    fifo_42_rd_addr,
           fifo_43_rd_addr     =>    fifo_43_rd_addr,
           fifo_50_rd_addr     =>    fifo_50_rd_addr,
           fifo_51_rd_addr     =>    fifo_51_rd_addr,
           fifo_52_rd_addr     =>    fifo_52_rd_addr,
           fifo_53_rd_addr     =>    fifo_53_rd_addr,
           fifo_60_rd_addr     =>    fifo_60_rd_addr,
           fifo_61_rd_addr     =>    fifo_61_rd_addr,
           fifo_62_rd_addr     =>    fifo_62_rd_addr,
           fifo_63_rd_addr     =>    fifo_63_rd_addr,
           fifo_70_rd_addr     =>    fifo_70_rd_addr,
           fifo_71_rd_addr     =>    fifo_71_rd_addr,
           fifo_72_rd_addr     =>    fifo_72_rd_addr,
           fifo_73_rd_addr     =>    fifo_73_rd_addr,
           fifo_80_rd_addr     =>    fifo_80_rd_addr,
           fifo_81_rd_addr     =>    fifo_81_rd_addr,
           fifo_82_rd_addr     =>    fifo_82_rd_addr,
           fifo_83_rd_addr     =>    fifo_83_rd_addr,
           output_data_90      =>    output_data_90,
           next_state_val      =>    next_state,
           data_valid_90       =>    data_valid_90
         );


data_read_controller0	:	data_read_controller_72bit_rl 
port map (
            clk                =>   clk,
            clk90              =>   clk90,
            reset_r            =>   reset_r,
            reset90_r          =>   reset90_r,
            reset180_r         =>   reset180_r,
            reset270_r         =>   reset270_r,
            rst_dqs_div        =>   ddr_rst_dqs_div_in,
            delay_sel          =>   delay_sel,
            dqs_int_delay_in0  =>   ddr_dqs_int_delay_in0,
            dqs_int_delay_in1  =>   ddr_dqs_int_delay_in1,
            dqs_int_delay_in2  =>   ddr_dqs_int_delay_in2,
            dqs_int_delay_in3  =>   ddr_dqs_int_delay_in3,
            dqs_int_delay_in4  =>   ddr_dqs_int_delay_in4,
            dqs_int_delay_in5  =>   ddr_dqs_int_delay_in5,
            dqs_int_delay_in6  =>   ddr_dqs_int_delay_in6,
            dqs_int_delay_in7  =>   ddr_dqs_int_delay_in7,
            dqs_int_delay_in8  =>   ddr_dqs_int_delay_in8,
            next_state             =>    next_state,
            fifo_00_rd_addr_val    =>    fifo_00_rd_addr,
            fifo_01_rd_addr_val    =>    fifo_01_rd_addr,
            fifo_02_rd_addr_val    =>    fifo_02_rd_addr,
            fifo_03_rd_addr_val    =>    fifo_03_rd_addr,
            fifo_10_rd_addr_val    =>    fifo_10_rd_addr,
            fifo_11_rd_addr_val    =>    fifo_11_rd_addr,
            fifo_12_rd_addr_val    =>    fifo_12_rd_addr,
            fifo_13_rd_addr_val    =>    fifo_13_rd_addr,
            fifo_20_rd_addr_val    =>    fifo_20_rd_addr,
            fifo_21_rd_addr_val    =>    fifo_21_rd_addr,
            fifo_22_rd_addr_val    =>    fifo_22_rd_addr,
            fifo_23_rd_addr_val    =>    fifo_23_rd_addr,
            fifo_30_rd_addr_val    =>    fifo_30_rd_addr,
            fifo_31_rd_addr_val    =>    fifo_31_rd_addr,
            fifo_32_rd_addr_val    =>    fifo_32_rd_addr,
            fifo_33_rd_addr_val    =>    fifo_33_rd_addr,
            fifo_40_rd_addr_val    =>    fifo_40_rd_addr,
            fifo_41_rd_addr_val    =>    fifo_41_rd_addr,
            fifo_42_rd_addr_val    =>    fifo_42_rd_addr,
            fifo_43_rd_addr_val    =>    fifo_43_rd_addr,
            fifo_50_rd_addr_val    =>    fifo_50_rd_addr,
            fifo_51_rd_addr_val    =>    fifo_51_rd_addr,
            fifo_52_rd_addr_val    =>    fifo_52_rd_addr,
            fifo_53_rd_addr_val    =>    fifo_53_rd_addr,
            fifo_60_rd_addr_val    =>    fifo_60_rd_addr,
            fifo_61_rd_addr_val    =>    fifo_61_rd_addr,
            fifo_62_rd_addr_val    =>    fifo_62_rd_addr,
            fifo_63_rd_addr_val    =>    fifo_63_rd_addr,
            fifo_70_rd_addr_val    =>    fifo_70_rd_addr,
            fifo_71_rd_addr_val    =>    fifo_71_rd_addr,
            fifo_72_rd_addr_val    =>    fifo_72_rd_addr,
            fifo_73_rd_addr_val    =>    fifo_73_rd_addr,
            fifo_80_rd_addr_val    =>    fifo_80_rd_addr,
            fifo_81_rd_addr_val    =>    fifo_81_rd_addr,
            fifo_82_rd_addr_val    =>    fifo_82_rd_addr,
            fifo_83_rd_addr_val    =>    fifo_83_rd_addr,
            read_data_valid_1_val  =>   read_data_valid_1,
            read_data_valid_2_val  =>   read_data_valid_2,
            transfer_done_0_val    =>   transfer_done_0,
            transfer_done_1_val    =>   transfer_done_1,
            transfer_done_2_val    =>   transfer_done_2,
            transfer_done_3_val    =>   transfer_done_3,
            transfer_done_4_val    =>   transfer_done_4,
            transfer_done_5_val    =>   transfer_done_5,
            transfer_done_6_val    =>   transfer_done_6,
            transfer_done_7_val    =>   transfer_done_7,
            transfer_done_8_val    =>   transfer_done_8,
            fifo_00_wr_addr_val    =>   fifo_00_wr_addr,
            fifo_01_wr_addr_val    =>   fifo_01_wr_addr,
            fifo_02_wr_addr_val    =>   fifo_02_wr_addr,
            fifo_03_wr_addr_val    =>   fifo_03_wr_addr,
            fifo_10_wr_addr_val    =>   fifo_10_wr_addr,
            fifo_11_wr_addr_val    =>   fifo_11_wr_addr,
            fifo_12_wr_addr_val    =>   fifo_12_wr_addr,
            fifo_13_wr_addr_val    =>   fifo_13_wr_addr,
            fifo_20_wr_addr_val    =>   fifo_20_wr_addr,
            fifo_21_wr_addr_val    =>   fifo_21_wr_addr,
            fifo_22_wr_addr_val    =>   fifo_22_wr_addr,
            fifo_23_wr_addr_val    =>   fifo_23_wr_addr,
            fifo_30_wr_addr_val    =>   fifo_30_wr_addr,
            fifo_31_wr_addr_val    =>   fifo_31_wr_addr,
            fifo_32_wr_addr_val    =>   fifo_32_wr_addr,
            fifo_33_wr_addr_val    =>   fifo_33_wr_addr,
            fifo_40_wr_addr_val    =>   fifo_40_wr_addr,
            fifo_41_wr_addr_val    =>   fifo_41_wr_addr,
            fifo_42_wr_addr_val    =>   fifo_42_wr_addr,
            fifo_43_wr_addr_val    =>   fifo_43_wr_addr,
            fifo_50_wr_addr_val    =>   fifo_50_wr_addr,
            fifo_51_wr_addr_val    =>   fifo_51_wr_addr,
            fifo_52_wr_addr_val    =>   fifo_52_wr_addr,
            fifo_53_wr_addr_val    =>   fifo_53_wr_addr,
            fifo_60_wr_addr_val    =>   fifo_60_wr_addr,
            fifo_61_wr_addr_val    =>   fifo_61_wr_addr,
            fifo_62_wr_addr_val    =>   fifo_62_wr_addr,
            fifo_63_wr_addr_val    =>   fifo_63_wr_addr,
            fifo_70_wr_addr_val    =>   fifo_70_wr_addr,
            fifo_71_wr_addr_val    =>   fifo_71_wr_addr,
            fifo_72_wr_addr_val    =>   fifo_72_wr_addr,
            fifo_73_wr_addr_val    =>   fifo_73_wr_addr,
            fifo_80_wr_addr_val    =>   fifo_80_wr_addr,
            fifo_81_wr_addr_val    =>   fifo_81_wr_addr,
            fifo_82_wr_addr_val    =>   fifo_82_wr_addr,
            fifo_83_wr_addr_val    =>   fifo_83_wr_addr,
            dqs_delayed_col0_val   =>   dqs_delayed_col0,
            dqs_delayed_col1_val   =>   dqs_delayed_col1,
            dqs_div_col0_val       =>   dqs_div_col0,
            dqs_div_col1_val       =>   dqs_div_col1
         );

         
data_write0	:	data_write_72bit 
port map (
			clk                =>   clk,
			clk90              =>   clk90,
			reset_r            =>   reset_r,
			reset90_r          =>   reset90_r,
			reset180_r         =>   reset180_r,
			reset270_r         =>   reset270_r,
			
			input_data         =>   input_data,
			byte_enable        =>   byte_enable,
			write_enable       =>   write_enable,
			input_data_valid   =>   input_data_valid,
			
			write_en_val       =>   ddr_write_en,
			write_data_falling =>   ddr_write_data_falling,
			write_data_rising  =>   ddr_write_data_rising,
			data_mask_falling  =>   ddr_data_mask_falling,
			data_mask_rising   =>   ddr_data_mask_rising
			);

data_path_rst0 : data_path_rst 
port map (
          clk                =>   clk,            
          clk90              =>   clk90,
          reset              =>   reset,
          reset90            =>   reset90,
          reset180           =>   reset180,
          reset270           =>   reset270,
          reset_r            =>   reset_r,
          reset90_r          =>   reset90_r,
          reset180_r         =>   reset180_r,
          reset270_r         =>   reset270_r
         );

-- resample the data from the data path on clk0
data_resample: process(clk)
begin
	if clk'event and clk = '1' then
		if reset = '1' then
			output_data        <= (others => '0');
			output_data_valid  <= '0';
		else
			output_data        <= output_data_90;
			output_data_valid  <= data_valid_90;
		end if;
	end if;	
end process data_resample;
                                                                       
end   arc_data_path_72bit_rl;  


























































































































































































































































































































































































































































































































































































































































































































































