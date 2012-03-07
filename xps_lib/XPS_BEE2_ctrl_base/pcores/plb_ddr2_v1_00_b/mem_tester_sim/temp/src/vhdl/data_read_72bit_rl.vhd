--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_read.vhd
--
--  Description :     This module comprises the write and read data paths for the
--                    ddr2 memory interface. The read data is 
--                    captured in CLB FFs and finally input to FIFOs.
-- 
--                    
--  Date - revision : 10/16/2003
--
--  Author :          Maria George (modified by Sailaja)
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
entity   data_read_72bit_rl  is
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
end   data_read_72bit_rl;  

architecture   arc_data_read_72bit_rl of   data_read_72bit_rl    is

component RAM_8D
port(
     DPO   : out std_logic_vector(7 downto 0);
     A0    : in std_logic;
     A1    : in std_logic;
     A2    : in std_logic;
     A3    : in std_logic;
     D     : in std_logic_vector(7 downto 0);
     DPRA0 : in std_logic;
     DPRA1 : in std_logic;
     DPRA2 : in std_logic;
     DPRA3 : in std_logic;
     WCLK  : in std_logic;
     WE    : in std_logic
     );
end component;

component ddr2_dqbit
  port (
        reset               : in std_logic;         
        dqs                 : in std_logic;
        dqs1                : in std_logic;     
        dqs_div_1           : in std_logic;
        dqs_div_2           : in std_logic;
        dq                  : in std_logic;
        fbit_0              : out std_logic;
        fbit_1              : out std_logic;
        fbit_2              : out std_logic;
        fbit_3              : out std_logic
       );
end component;   




signal fbit_0                 : std_logic_vector(71 downto 0);
signal fbit_1                 : std_logic_vector(71 downto 0);
signal fbit_2                 : std_logic_vector(71 downto 0);
signal fbit_3                 : std_logic_vector(71 downto 0);
signal fifo_00_data_out       : std_logic_vector(7 downto 0);
signal fifo_01_data_out       : std_logic_vector(7 downto 0);
signal fifo_02_data_out       : std_logic_vector(7 downto 0);
signal fifo_03_data_out       : std_logic_vector(7 downto 0);
signal fifo_10_data_out       : std_logic_vector(7 downto 0);
signal fifo_11_data_out       : std_logic_vector(7 downto 0);
signal fifo_12_data_out       : std_logic_vector(7 downto 0);
signal fifo_13_data_out       : std_logic_vector(7 downto 0);
signal fifo_20_data_out       : std_logic_vector(7 downto 0);
signal fifo_21_data_out       : std_logic_vector(7 downto 0);
signal fifo_22_data_out       : std_logic_vector(7 downto 0);
signal fifo_23_data_out       : std_logic_vector(7 downto 0); 
signal fifo_30_data_out       : std_logic_vector(7 downto 0);
signal fifo_31_data_out       : std_logic_vector(7 downto 0);
signal fifo_32_data_out       : std_logic_vector(7 downto 0);
signal fifo_33_data_out       : std_logic_vector(7 downto 0);
signal fifo_40_data_out       : std_logic_vector(7 downto 0);
signal fifo_41_data_out       : std_logic_vector(7 downto 0);
signal fifo_42_data_out       : std_logic_vector(7 downto 0);
signal fifo_43_data_out       : std_logic_vector(7 downto 0);
signal fifo_50_data_out       : std_logic_vector(7 downto 0);
signal fifo_51_data_out       : std_logic_vector(7 downto 0);
signal fifo_52_data_out       : std_logic_vector(7 downto 0);
signal fifo_53_data_out       : std_logic_vector(7 downto 0);
signal fifo_60_data_out       : std_logic_vector(7 downto 0);
signal fifo_61_data_out       : std_logic_vector(7 downto 0);
signal fifo_62_data_out       : std_logic_vector(7 downto 0);
signal fifo_63_data_out       : std_logic_vector(7 downto 0);
signal fifo_70_data_out       : std_logic_vector(7 downto 0);
signal fifo_71_data_out       : std_logic_vector(7 downto 0);
signal fifo_72_data_out       : std_logic_vector(7 downto 0);
signal fifo_73_data_out       : std_logic_vector(7 downto 0);
signal fifo_80_data_out       : std_logic_vector(7 downto 0);
signal fifo_81_data_out       : std_logic_vector(7 downto 0);
signal fifo_82_data_out       : std_logic_vector(7 downto 0);
signal fifo_83_data_out       : std_logic_vector(7 downto 0);
signal next_state             : std_logic;

--signal user_output_data_1     : std_logic_vector(143 downto 0);



 begin

next_state_val <= next_state;                                          
                        
process(clk90)
begin
if clk90'event and clk90 = '1' then
 if reset90_r = '1' then
    next_state       <= '0';
    data_valid_90    <= '0';
 else
    -- make sure that data_valid default value is 0
    data_valid_90    <= '0'; 
    case next_state is
      
         when '0' => 
             if (read_data_valid_1 = '1') then  
               next_state      <= '1';
               data_valid_90   <= '1';
               output_data_90  <= (
								fifo_81_data_out &
								fifo_71_data_out &
								fifo_61_data_out &
								fifo_51_data_out &
								fifo_41_data_out &
								fifo_31_data_out &
								fifo_21_data_out &
								fifo_11_data_out &
								fifo_01_data_out &
								fifo_80_data_out &
								fifo_70_data_out &
								fifo_60_data_out & 
								fifo_50_data_out &
								fifo_40_data_out & 
								fifo_30_data_out &
								fifo_20_data_out &
								fifo_10_data_out &
								fifo_00_data_out
               );
               	                    
           	                        
           	                        
               	                    
             else
               next_state      <= '0';
             end if;              
         when '1' => 
             if (read_data_valid_2 = '1') then
               next_state     <= '0';
               data_valid_90  <= '1';
               output_data_90 <= (
								fifo_83_data_out &
								fifo_73_data_out &
								fifo_63_data_out &
								fifo_53_data_out &
								fifo_43_data_out &
								fifo_33_data_out &
								fifo_23_data_out &
								fifo_13_data_out &
								fifo_03_data_out &
								fifo_82_data_out &
								fifo_72_data_out &
								fifo_62_data_out &
								fifo_52_data_out &
								fifo_42_data_out &
								fifo_32_data_out &
								fifo_22_data_out &
								fifo_12_data_out &
								fifo_02_data_out
               );
             else
               next_state <= '1';
             end if;
         when others => 
             next_state <= '0';
             output_data_90 <= (others => '0');

     end case;                                             
end if;                                                    
end if;                                                    
end process;  
--------------------------------------- End of modification                                             
                                                           

--------------------------------------------------------------------------------------------------------------------------------
--******************************************************************************************************************************
-- DDR Data bit instantiations (72-bits)
--******************************************************************************************************************************            
           

ddr2_dqbit0 : ddr2_dqbit port map
                              (
                               reset                 => reset270_r,
                               dqs                   => dqs_delayed_col0(0),
                               dqs1                  => dqs_delayed_col1(0),
                               dqs_div_1             => dqs_div_col0(0),
                               dqs_div_2             => dqs_div_col1(0),
                               dq                    => dq(0),
                               fbit_0                => fbit_0(0),
                               fbit_1                => fbit_1(0),
                               fbit_2                => fbit_2(0),
                               fbit_3                => fbit_3(0)
                              );

ddr2_dqbit1 : ddr2_dqbit port map
                              (
                               reset              => reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(1),
                               fbit_0             => fbit_0(1),
                               fbit_1             => fbit_1(1),
                               fbit_2             => fbit_2(1),
                               fbit_3             => fbit_3(1)
                              );

ddr2_dqbit2 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(2),
                               fbit_0             => fbit_0(2),
                               fbit_1             => fbit_1(2),
                               fbit_2             => fbit_2(2),
                               fbit_3             => fbit_3(2)
                              );

ddr2_dqbit3 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(3),
                               fbit_0             => fbit_0(3),
                               fbit_1             => fbit_1(3),
                               fbit_2             => fbit_2(3),
                               fbit_3             => fbit_3(3)
                              );

ddr2_dqbit4 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(4),
                               fbit_0             => fbit_0(4),
                               fbit_1             => fbit_1(4),
                               fbit_2             => fbit_2(4),
                               fbit_3             => fbit_3(4)
                              );

ddr2_dqbit5 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(5),
                               fbit_0             => fbit_0(5),
                               fbit_1             => fbit_1(5),
                               fbit_2             => fbit_2(5),
                               fbit_3             => fbit_3(5)
                              );

ddr2_dqbit6 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(6),
                               fbit_0             => fbit_0(6),
                               fbit_1             => fbit_1(6),
                               fbit_2             => fbit_2(6),
                               fbit_3             => fbit_3(6)
                              );

ddr2_dqbit7 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(0),
                               dqs1               => dqs_delayed_col1(0),
                               dqs_div_1          => dqs_div_col0(0),
                               dqs_div_2          => dqs_div_col1(0),
                               dq                 => dq(7),
                               fbit_0             => fbit_0(7),
                               fbit_1             => fbit_1(7),
                               fbit_2             => fbit_2(7),
                               fbit_3             => fbit_3(7)
                              );

ddr2_dqbit8 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(8),
                               fbit_0             => fbit_0(8),
                               fbit_1             => fbit_1(8),
                               fbit_2             => fbit_2(8),
                               fbit_3             => fbit_3(8)
                              );

ddr2_dqbit9 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(9),
                               fbit_0             => fbit_0(9),
                               fbit_1             => fbit_1(9),
                               fbit_2             => fbit_2(9),
                               fbit_3             => fbit_3(9)
                              );

ddr2_dqbit10 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(10),
                               fbit_0             => fbit_0(10),
                               fbit_1             => fbit_1(10),
                               fbit_2             => fbit_2(10),
                               fbit_3             => fbit_3(10)
                              );

ddr2_dqbit11 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(11),
                               fbit_0             => fbit_0(11),
                               fbit_1             => fbit_1(11),
                               fbit_2             => fbit_2(11),
                               fbit_3             => fbit_3(11)
                              );

ddr2_dqbit12 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(12),
                               fbit_0             => fbit_0(12),
                               fbit_1             => fbit_1(12),
                               fbit_2             => fbit_2(12),
                               fbit_3             => fbit_3(12)
                              );

ddr2_dqbit13 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(13),
                               fbit_0             => fbit_0(13),
                               fbit_1             => fbit_1(13),
                               fbit_2             => fbit_2(13),
                               fbit_3             => fbit_3(13)
                              );

ddr2_dqbit14 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(14),
                               fbit_0             => fbit_0(14),
                               fbit_1             => fbit_1(14),
                               fbit_2             => fbit_2(14),
                               fbit_3             => fbit_3(14)
                              );

ddr2_dqbit15 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(1),
                               dqs1               => dqs_delayed_col1(1),
                               dqs_div_1          => dqs_div_col0(1),
                               dqs_div_2          => dqs_div_col1(1),
                               dq                 => dq(15),
                               fbit_0             => fbit_0(15),
                               fbit_1             => fbit_1(15),
                               fbit_2             => fbit_2(15),
                               fbit_3             => fbit_3(15)
                              );

ddr2_dqbit16 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(16),
                               fbit_0             => fbit_0(16),
                               fbit_1             => fbit_1(16),
                               fbit_2             => fbit_2(16),
                               fbit_3             => fbit_3(16)
                              );

ddr2_dqbit17 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(17),
                               fbit_0             => fbit_0(17),
                               fbit_1             => fbit_1(17),
                               fbit_2             => fbit_2(17),
                               fbit_3             => fbit_3(17)
                              );

ddr2_dqbit18 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(18),
                               fbit_0             => fbit_0(18),
                               fbit_1             => fbit_1(18),
                               fbit_2             => fbit_2(18),
                               fbit_3             => fbit_3(18)
                              );

ddr2_dqbit19 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(19),
                               fbit_0             => fbit_0(19),
                               fbit_1             => fbit_1(19),
                               fbit_2             => fbit_2(19),
                               fbit_3             => fbit_3(19)
                              );

ddr2_dqbit20 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(20),
                               fbit_0             => fbit_0(20),
                               fbit_1             => fbit_1(20),
                               fbit_2             => fbit_2(20),
                               fbit_3             => fbit_3(20)
                              );

ddr2_dqbit21 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(21),
                               fbit_0             => fbit_0(21),
                               fbit_1             => fbit_1(21),
                               fbit_2             => fbit_2(21),
                               fbit_3             => fbit_3(21)
                              );

ddr2_dqbit22 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(22),
                               fbit_0             => fbit_0(22),
                               fbit_1             => fbit_1(22),
                               fbit_2             => fbit_2(22),
                               fbit_3             => fbit_3(22)
                              );

ddr2_dqbit23 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(2),
                               dqs1               => dqs_delayed_col1(2),
                               dqs_div_1          => dqs_div_col0(2),
                               dqs_div_2          => dqs_div_col1(2),
                               dq                 => dq(23),
                               fbit_0             => fbit_0(23),
                               fbit_1             => fbit_1(23),
                               fbit_2             => fbit_2(23),
                               fbit_3             => fbit_3(23)
                              );

ddr2_dqbit24 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(24),
                               fbit_0             => fbit_0(24),
                               fbit_1             => fbit_1(24),
                               fbit_2             => fbit_2(24),
                               fbit_3             => fbit_3(24)
                              );

ddr2_dqbit25 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(25),
                               fbit_0             => fbit_0(25),
                               fbit_1             => fbit_1(25),
                               fbit_2             => fbit_2(25),
                               fbit_3             => fbit_3(25)
                              );

ddr2_dqbit26 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(26),
                               fbit_0             => fbit_0(26),
                               fbit_1             => fbit_1(26),
                               fbit_2             => fbit_2(26),
                               fbit_3             => fbit_3(26)
                              );

ddr2_dqbit27 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(27),
                               fbit_0             => fbit_0(27),
                               fbit_1             => fbit_1(27),
                               fbit_2             => fbit_2(27),
                               fbit_3             => fbit_3(27)
                              );

ddr2_dqbit28 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(28),
                               fbit_0             => fbit_0(28),
                               fbit_1             => fbit_1(28),
                               fbit_2             => fbit_2(28),
                               fbit_3             => fbit_3(28)
                              );

ddr2_dqbit29 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(29),
                               fbit_0             => fbit_0(29),
                               fbit_1             => fbit_1(29),
                               fbit_2             => fbit_2(29),
                               fbit_3             => fbit_3(29)
                              );

ddr2_dqbit30 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(30),
                               fbit_0             => fbit_0(30),
                               fbit_1             => fbit_1(30),
                               fbit_2             => fbit_2(30),
                               fbit_3             => fbit_3(30)
                              );

ddr2_dqbit31 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(3),
                               dqs1               => dqs_delayed_col1(3),
                               dqs_div_1          => dqs_div_col0(3),
                               dqs_div_2          => dqs_div_col1(3),
                               dq                 => dq(31),
                               fbit_0             => fbit_0(31),
                               fbit_1             => fbit_1(31),
                               fbit_2             => fbit_2(31),
                               fbit_3             => fbit_3(31)
                              );

ddr2_dqbit32 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(32),
                               fbit_0             => fbit_0(32),
                               fbit_1             => fbit_1(32),
                               fbit_2             => fbit_2(32),
                               fbit_3             => fbit_3(32)
                              );

ddr2_dqbit33 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(33),
                               fbit_0             => fbit_0(33),
                               fbit_1             => fbit_1(33),
                               fbit_2             => fbit_2(33),
                               fbit_3             => fbit_3(33)
                              );

ddr2_dqbit34 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(34),
                               fbit_0             => fbit_0(34),
                               fbit_1             => fbit_1(34),
                               fbit_2             => fbit_2(34),
                               fbit_3             => fbit_3(34)
                              );

ddr2_dqbit35 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(35),
                               fbit_0             => fbit_0(35),
                               fbit_1             => fbit_1(35),
                               fbit_2             => fbit_2(35),
                               fbit_3             => fbit_3(35)
                              );

ddr2_dqbit36 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(36),
                               fbit_0             => fbit_0(36),
                               fbit_1             => fbit_1(36),
                               fbit_2             => fbit_2(36),
                               fbit_3             => fbit_3(36)
                              );

ddr2_dqbit37 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(37),
                               fbit_0             => fbit_0(37),
                               fbit_1             => fbit_1(37),
                               fbit_2             => fbit_2(37),
                               fbit_3             => fbit_3(37)
                              );

ddr2_dqbit38 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(38),
                               fbit_0             => fbit_0(38),
                               fbit_1             => fbit_1(38),
                               fbit_2             => fbit_2(38),
                               fbit_3             => fbit_3(38)
                              );

ddr2_dqbit39 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(4),
                               dqs1               => dqs_delayed_col1(4),
                               dqs_div_1          => dqs_div_col0(4),
                               dqs_div_2          => dqs_div_col1(4),
                               dq                 => dq(39),
                               fbit_0             => fbit_0(39),
                               fbit_1             => fbit_1(39),
                               fbit_2             => fbit_2(39),
                               fbit_3             => fbit_3(39)
                              );

ddr2_dqbit40 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(40),
                               fbit_0             => fbit_0(40),
                               fbit_1             => fbit_1(40),
                               fbit_2             => fbit_2(40),
                               fbit_3             => fbit_3(40)
                              );

ddr2_dqbit41 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(41),
                               fbit_0             => fbit_0(41),
                               fbit_1             => fbit_1(41),
                               fbit_2             => fbit_2(41),
                               fbit_3             => fbit_3(41)
                              );

ddr2_dqbit42 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(42),
                               fbit_0             => fbit_0(42),
                               fbit_1             => fbit_1(42),
                               fbit_2             => fbit_2(42),
                               fbit_3             => fbit_3(42)
                              );

ddr2_dqbit43 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(43),
                               fbit_0             => fbit_0(43),
                               fbit_1             => fbit_1(43),
                               fbit_2             => fbit_2(43),
                               fbit_3             => fbit_3(43)
                              );

ddr2_dqbit44 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(44),
                               fbit_0             => fbit_0(44),
                               fbit_1             => fbit_1(44),
                               fbit_2             => fbit_2(44),
                               fbit_3             => fbit_3(44)
                              );

ddr2_dqbit45 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(45),
                               fbit_0             => fbit_0(45),
                               fbit_1             => fbit_1(45),
                               fbit_2             => fbit_2(45),
                               fbit_3             => fbit_3(45)
                              );

ddr2_dqbit46 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(46),
                               fbit_0             => fbit_0(46),
                               fbit_1             => fbit_1(46),
                               fbit_2             => fbit_2(46),
                               fbit_3             => fbit_3(46)
                              );

ddr2_dqbit47 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(5),
                               dqs1               => dqs_delayed_col1(5),
                               dqs_div_1          => dqs_div_col0(5),
                               dqs_div_2          => dqs_div_col1(5),
                               dq                 => dq(47),
                               fbit_0             => fbit_0(47),
                               fbit_1             => fbit_1(47),
                               fbit_2             => fbit_2(47),
                               fbit_3             => fbit_3(47)
                              );

ddr2_dqbit48 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(48),
                               fbit_0             => fbit_0(48),
                               fbit_1             => fbit_1(48),
                               fbit_2             => fbit_2(48),
                               fbit_3             => fbit_3(48)
                              );

ddr2_dqbit49 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(49),
                               fbit_0             => fbit_0(49),
                               fbit_1             => fbit_1(49),
                               fbit_2             => fbit_2(49),
                               fbit_3             => fbit_3(49)
                              );

ddr2_dqbit50 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(50),
                               fbit_0             => fbit_0(50),
                               fbit_1             => fbit_1(50),
                               fbit_2             => fbit_2(50),
                               fbit_3             => fbit_3(50)
                              );

ddr2_dqbit51 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(51),
                               fbit_0             => fbit_0(51),
                               fbit_1             => fbit_1(51),
                               fbit_2             => fbit_2(51),
                               fbit_3             => fbit_3(51)
                              );

ddr2_dqbit52 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(52),
                               fbit_0             => fbit_0(52),
                               fbit_1             => fbit_1(52),
                               fbit_2             => fbit_2(52),
                               fbit_3             => fbit_3(52)
                              );

ddr2_dqbit53 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(53),
                               fbit_0             => fbit_0(53),
                               fbit_1             => fbit_1(53),
                               fbit_2             => fbit_2(53),
                               fbit_3             => fbit_3(53)
                              );

ddr2_dqbit54 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(54),
                               fbit_0             => fbit_0(54),
                               fbit_1             => fbit_1(54),
                               fbit_2             => fbit_2(54),
                               fbit_3             => fbit_3(54)
                              );

ddr2_dqbit55 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(6),
                               dqs1               => dqs_delayed_col1(6),
                               dqs_div_1          => dqs_div_col0(6),
                               dqs_div_2          => dqs_div_col1(6),
                               dq                 => dq(55),
                               fbit_0             => fbit_0(55),
                               fbit_1             => fbit_1(55),
                               fbit_2             => fbit_2(55),
                               fbit_3             => fbit_3(55)
                              );

ddr2_dqbit56 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(56),
                               fbit_0             => fbit_0(56),
                               fbit_1             => fbit_1(56),
                               fbit_2             => fbit_2(56),
                               fbit_3             => fbit_3(56)
                              );

ddr2_dqbit57 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(57),
                               fbit_0             => fbit_0(57),
                               fbit_1             => fbit_1(57),
                               fbit_2             => fbit_2(57),
                               fbit_3             => fbit_3(57)
                              );

ddr2_dqbit58 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(58),
                               fbit_0             => fbit_0(58),
                               fbit_1             => fbit_1(58),
                               fbit_2             => fbit_2(58),
                               fbit_3             => fbit_3(58)
                              );

ddr2_dqbit59 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(59),
                               fbit_0             => fbit_0(59),
                               fbit_1             => fbit_1(59),
                               fbit_2             => fbit_2(59),
                               fbit_3             => fbit_3(59)
                              );

ddr2_dqbit60 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(60),
                               fbit_0             => fbit_0(60),
                               fbit_1             => fbit_1(60),
                               fbit_2             => fbit_2(60),
                               fbit_3             => fbit_3(60)
                              );

ddr2_dqbit61 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(61),
                               fbit_0             => fbit_0(61),
                               fbit_1             => fbit_1(61),
                               fbit_2             => fbit_2(61),
                               fbit_3             => fbit_3(61)
                              );

ddr2_dqbit62 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(62),
                               fbit_0             => fbit_0(62),
                               fbit_1             => fbit_1(62),
                               fbit_2             => fbit_2(62),
                               fbit_3             => fbit_3(62)
                              );

ddr2_dqbit63 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(7),
                               dqs1               => dqs_delayed_col1(7),
                               dqs_div_1          => dqs_div_col0(7),
                               dqs_div_2          => dqs_div_col1(7),
                               dq                 => dq(63),
                               fbit_0             => fbit_0(63),
                               fbit_1             => fbit_1(63),
                               fbit_2             => fbit_2(63),
                               fbit_3             => fbit_3(63)
                              );

ddr2_dqbit64 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(64),
                               fbit_0             => fbit_0(64),
                               fbit_1             => fbit_1(64),
                               fbit_2             => fbit_2(64),
                               fbit_3             => fbit_3(64)
                              );

ddr2_dqbit65 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(65),
                               fbit_0             => fbit_0(65),
                               fbit_1             => fbit_1(65),
                               fbit_2             => fbit_2(65),
                               fbit_3             => fbit_3(65)
                              );

ddr2_dqbit66 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(66),
                               fbit_0             => fbit_0(66),
                               fbit_1             => fbit_1(66),
                               fbit_2             => fbit_2(66),
                               fbit_3             => fbit_3(66)
                              );

ddr2_dqbit67 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(67),
                               fbit_0             => fbit_0(67),
                               fbit_1             => fbit_1(67),
                               fbit_2             => fbit_2(67),
                               fbit_3             => fbit_3(67)
                              );

ddr2_dqbit68 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(68),
                               fbit_0             => fbit_0(68),
                               fbit_1             => fbit_1(68),
                               fbit_2             => fbit_2(68),
                               fbit_3             => fbit_3(68)
                              );

ddr2_dqbit69 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(69),
                               fbit_0             => fbit_0(69),
                               fbit_1             => fbit_1(69),
                               fbit_2             => fbit_2(69),
                               fbit_3             => fbit_3(69)
                              );

ddr2_dqbit70 : ddr2_dqbit port map
                              (
                               reset              =>  reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(70),
                               fbit_0             => fbit_0(70),
                               fbit_1             => fbit_1(70),
                               fbit_2             => fbit_2(70),
                               fbit_3             => fbit_3(70)
                              );

ddr2_dqbit71 : ddr2_dqbit port map
                              (
                               reset              => reset270_r,
                               dqs                => dqs_delayed_col0(8),
                               dqs1               => dqs_delayed_col1(8),
                               dqs_div_1          => dqs_div_col0(8),
                               dqs_div_2          => dqs_div_col1(8),
                               dq                 => dq(71),
                               fbit_0             => fbit_0(71),
                               fbit_1             => fbit_1(71),
                               fbit_2             => fbit_2(71),
                               fbit_3             => fbit_3(71)
                              );

--*************************************************************************************************************************
-- Distributed RAM 8 bit wide FIFO instantiations (4 FIFOs per strobe, 1 for each fbit0 through 3)
--*************************************************************************************************************************
-- FIFOs associated with ddr2_dqs(0)
ram_8d_dqs0_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_00_data_out,          
          A0     => fifo_00_wr_addr(0),          
          A1     => fifo_00_wr_addr(1),
          A2     => fifo_00_wr_addr(2),
          A3     => fifo_00_wr_addr(3),
          D      => fbit_0(7 downto 0),      
          DPRA0  => fifo_00_rd_addr(0),
          DPRA1  => fifo_00_rd_addr(1),
          DPRA2  => fifo_00_rd_addr(2),
          DPRA3  => fifo_00_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_0(0)
         );                       

ram_8d_dqs0_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_01_data_out,          
          A0     => fifo_01_wr_addr(0),          
          A1     => fifo_01_wr_addr(1),
          A2     => fifo_01_wr_addr(2),
          A3     => fifo_01_wr_addr(3),
          D      => fbit_1(7 downto 0),      
          DPRA0  => fifo_01_rd_addr(0),
          DPRA1  => fifo_01_rd_addr(1),
          DPRA2  => fifo_01_rd_addr(2),
          DPRA3  => fifo_01_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_0(1)
         );
         
ram_8d_dqs0_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_02_data_out,          
          A0     => fifo_02_wr_addr(0),          
          A1     => fifo_02_wr_addr(1),
          A2     => fifo_02_wr_addr(2),
          A3     => fifo_02_wr_addr(3),
          D      => fbit_2(7 downto 0),      
          DPRA0  => fifo_02_rd_addr(0),
          DPRA1  => fifo_02_rd_addr(1),
          DPRA2  => fifo_02_rd_addr(2),
          DPRA3  => fifo_02_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_0(2)
         ); 
         
ram_8d_dqs0_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_03_data_out,          
          A0     => fifo_03_wr_addr(0),          
          A1     => fifo_03_wr_addr(1),
          A2     => fifo_03_wr_addr(2),
          A3     => fifo_03_wr_addr(3),
          D      => fbit_3(7 downto 0),      
          DPRA0  => fifo_03_rd_addr(0),
          DPRA1  => fifo_03_rd_addr(1),
          DPRA2  => fifo_03_rd_addr(2),
          DPRA3  => fifo_03_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_0(3)
         ); 
         
-- FIFOs associated with ddr2_dqs(1)         
         
ram_8d_dqs1_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_10_data_out,          
          A0     => fifo_10_wr_addr(0),          
          A1     => fifo_10_wr_addr(1),
          A2     => fifo_10_wr_addr(2),
          A3     => fifo_10_wr_addr(3),
          D      => fbit_0(15 downto 8),      
          DPRA0  => fifo_10_rd_addr(0),
          DPRA1  => fifo_10_rd_addr(1),
          DPRA2  => fifo_10_rd_addr(2),
          DPRA3  => fifo_10_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_1(0)
         );         

ram_8d_dqs1_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_11_data_out,          
          A0     => fifo_11_wr_addr(0),          
          A1     => fifo_11_wr_addr(1),
          A2     => fifo_11_wr_addr(2),
          A3     => fifo_11_wr_addr(3),
          D      => fbit_1(15 downto 8),      
          DPRA0  => fifo_11_rd_addr(0),
          DPRA1  => fifo_11_rd_addr(1),
          DPRA2  => fifo_11_rd_addr(2),
          DPRA3  => fifo_11_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_1(1)
         ); 
         
ram_8d_dqs1_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_12_data_out,          
          A0     => fifo_12_wr_addr(0),          
          A1     => fifo_12_wr_addr(1),
          A2     => fifo_12_wr_addr(2),
          A3     => fifo_12_wr_addr(3),
          D      => fbit_2(15 downto 8),      
          DPRA0  => fifo_12_rd_addr(0),
          DPRA1  => fifo_12_rd_addr(1),
          DPRA2  => fifo_12_rd_addr(2),
          DPRA3  => fifo_12_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_1(2)
         ); 
         
ram_8d_dqs1_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_13_data_out,          
          A0     => fifo_13_wr_addr(0),          
          A1     => fifo_13_wr_addr(1),
          A2     => fifo_13_wr_addr(2),
          A3     => fifo_13_wr_addr(3),
          D      => fbit_3(15 downto 8),      
          DPRA0  => fifo_13_rd_addr(0),
          DPRA1  => fifo_13_rd_addr(1),
          DPRA2  => fifo_13_rd_addr(2),
          DPRA3  => fifo_13_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_1(3)
         );                

-- FIFOs associated with ddr2_dqs(2)         
         
ram_8d_dqs2_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_20_data_out,          
          A0     => fifo_20_wr_addr(0),          
          A1     => fifo_20_wr_addr(1),
          A2     => fifo_20_wr_addr(2),
          A3     => fifo_20_wr_addr(3),
          D      => fbit_0(23 downto 16),      
          DPRA0  => fifo_20_rd_addr(0),
          DPRA1  => fifo_20_rd_addr(1),
          DPRA2  => fifo_20_rd_addr(2),
          DPRA3  => fifo_20_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_2(0)
         );         

ram_8d_dqs2_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_21_data_out,          
          A0     => fifo_21_wr_addr(0),          
          A1     => fifo_21_wr_addr(1),
          A2     => fifo_21_wr_addr(2),
          A3     => fifo_21_wr_addr(3),
          D      => fbit_1(23 downto 16),      
          DPRA0  => fifo_21_rd_addr(0),
          DPRA1  => fifo_21_rd_addr(1),
          DPRA2  => fifo_21_rd_addr(2),
          DPRA3  => fifo_21_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_2(1)
         ); 
         
ram_8d_dqs2_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_22_data_out,          
          A0     => fifo_22_wr_addr(0),          
          A1     => fifo_22_wr_addr(1),
          A2     => fifo_22_wr_addr(2),
          A3     => fifo_22_wr_addr(3),
          D      => fbit_2(23 downto 16),      
          DPRA0  => fifo_22_rd_addr(0),
          DPRA1  => fifo_22_rd_addr(1),
          DPRA2  => fifo_22_rd_addr(2),
          DPRA3  => fifo_22_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_2(2)
         ); 
         
ram_8d_dqs2_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_23_data_out,          
          A0     => fifo_23_wr_addr(0),          
          A1     => fifo_23_wr_addr(1),
          A2     => fifo_23_wr_addr(2),
          A3     => fifo_23_wr_addr(3),
          D      => fbit_3(23 downto 16),      
          DPRA0  => fifo_23_rd_addr(0),
          DPRA1  => fifo_23_rd_addr(1),
          DPRA2  => fifo_23_rd_addr(2),
          DPRA3  => fifo_23_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_2(3)
         ); 
         
-- FIFOs associated with ddr2_dqs(3)         
         
ram_8d_dqs3_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_30_data_out,          
          A0     => fifo_30_wr_addr(0),          
          A1     => fifo_30_wr_addr(1),
          A2     => fifo_30_wr_addr(2),
          A3     => fifo_30_wr_addr(3),
          D      => fbit_0(31 downto 24),      
          DPRA0  => fifo_30_rd_addr(0),
          DPRA1  => fifo_30_rd_addr(1),
          DPRA2  => fifo_30_rd_addr(2),
          DPRA3  => fifo_30_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_3(0)
         );         

ram_8d_dqs3_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_31_data_out,          
          A0     => fifo_31_wr_addr(0),          
          A1     => fifo_31_wr_addr(1),
          A2     => fifo_31_wr_addr(2),
          A3     => fifo_31_wr_addr(3),
          D      => fbit_1(31 downto 24),      
          DPRA0  => fifo_31_rd_addr(0),
          DPRA1  => fifo_31_rd_addr(1),
          DPRA2  => fifo_31_rd_addr(2),
          DPRA3  => fifo_31_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_3(1)
         ); 
         
ram_8d_dqs3_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_32_data_out,          
          A0     => fifo_32_wr_addr(0),          
          A1     => fifo_32_wr_addr(1),
          A2     => fifo_32_wr_addr(2),
          A3     => fifo_32_wr_addr(3),
          D      => fbit_2(31 downto 24),      
          DPRA0  => fifo_32_rd_addr(0),
          DPRA1  => fifo_32_rd_addr(1),
          DPRA2  => fifo_32_rd_addr(2),
          DPRA3  => fifo_32_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_3(2)
         ); 
         
ram_8d_dqs3_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_33_data_out,          
          A0     => fifo_33_wr_addr(0),          
          A1     => fifo_33_wr_addr(1),
          A2     => fifo_33_wr_addr(2),
          A3     => fifo_33_wr_addr(3),
          D      => fbit_3(31 downto 24),      
          DPRA0  => fifo_33_rd_addr(0),
          DPRA1  => fifo_33_rd_addr(1),
          DPRA2  => fifo_33_rd_addr(2),
          DPRA3  => fifo_33_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_3(3)
         );
         
-- FIFOs associated with ddr2_dqs(4)         
         
ram_8d_dqs4_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_40_data_out,          
          A0     => fifo_40_wr_addr(0),          
          A1     => fifo_40_wr_addr(1),
          A2     => fifo_40_wr_addr(2),
          A3     => fifo_40_wr_addr(3),
          D      => fbit_0(39 downto 32),      
          DPRA0  => fifo_40_rd_addr(0),
          DPRA1  => fifo_40_rd_addr(1),
          DPRA2  => fifo_40_rd_addr(2),
          DPRA3  => fifo_40_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_4(0)
         );         

ram_8d_dqs4_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_41_data_out,          
          A0     => fifo_41_wr_addr(0),          
          A1     => fifo_41_wr_addr(1),
          A2     => fifo_41_wr_addr(2),
          A3     => fifo_41_wr_addr(3),
          D      => fbit_1(39 downto 32),      
          DPRA0  => fifo_41_rd_addr(0),
          DPRA1  => fifo_41_rd_addr(1),
          DPRA2  => fifo_41_rd_addr(2),
          DPRA3  => fifo_41_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_4(1)
         ); 
         
ram_8d_dqs4_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_42_data_out,          
          A0     => fifo_42_wr_addr(0),          
          A1     => fifo_42_wr_addr(1),
          A2     => fifo_42_wr_addr(2),
          A3     => fifo_42_wr_addr(3),
          D      => fbit_2(39 downto 32),      
          DPRA0  => fifo_42_rd_addr(0),
          DPRA1  => fifo_42_rd_addr(1),
          DPRA2  => fifo_42_rd_addr(2),
          DPRA3  => fifo_42_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_4(2)
         ); 
         
ram_8d_dqs4_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_43_data_out,          
          A0     => fifo_43_wr_addr(0),          
          A1     => fifo_43_wr_addr(1),
          A2     => fifo_43_wr_addr(2),
          A3     => fifo_43_wr_addr(3),
          D      => fbit_3(39 downto 32),      
          DPRA0  => fifo_43_rd_addr(0),
          DPRA1  => fifo_43_rd_addr(1),
          DPRA2  => fifo_43_rd_addr(2),
          DPRA3  => fifo_43_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_4(3)
         ); 
         
-- FIFOs associated with ddr2_dqs(5)         
         
ram_8d_dqs5_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_50_data_out,          
          A0     => fifo_50_wr_addr(0),          
          A1     => fifo_50_wr_addr(1),
          A2     => fifo_50_wr_addr(2),
          A3     => fifo_50_wr_addr(3),
          D      => fbit_0(47 downto 40),      
          DPRA0  => fifo_50_rd_addr(0),
          DPRA1  => fifo_50_rd_addr(1),
          DPRA2  => fifo_50_rd_addr(2),
          DPRA3  => fifo_50_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_5(0)
         );         

ram_8d_dqs5_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_51_data_out,          
          A0     => fifo_51_wr_addr(0),          
          A1     => fifo_51_wr_addr(1),
          A2     => fifo_51_wr_addr(2),
          A3     => fifo_51_wr_addr(3),
          D      => fbit_1(47 downto 40),      
          DPRA0  => fifo_51_rd_addr(0),
          DPRA1  => fifo_51_rd_addr(1),
          DPRA2  => fifo_51_rd_addr(2),
          DPRA3  => fifo_51_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_5(1)
         ); 
         
ram_8d_dqs5_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_52_data_out,          
          A0     => fifo_52_wr_addr(0),          
          A1     => fifo_52_wr_addr(1),
          A2     => fifo_52_wr_addr(2),
          A3     => fifo_52_wr_addr(3),
          D      => fbit_2(47 downto 40),      
          DPRA0  => fifo_52_rd_addr(0),
          DPRA1  => fifo_52_rd_addr(1),
          DPRA2  => fifo_52_rd_addr(2),
          DPRA3  => fifo_52_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_5(2)
         ); 
         
ram_8d_dqs5_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_53_data_out,          
          A0     => fifo_53_wr_addr(0),          
          A1     => fifo_53_wr_addr(1),
          A2     => fifo_53_wr_addr(2),
          A3     => fifo_53_wr_addr(3),
          D      => fbit_3(47 downto 40),      
          DPRA0  => fifo_53_rd_addr(0),
          DPRA1  => fifo_53_rd_addr(1),
          DPRA2  => fifo_53_rd_addr(2),
          DPRA3  => fifo_53_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_5(3)
         );
         
-- FIFOs associated with ddr2_dqs(6)         
         
ram_8d_dqs6_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_60_data_out,          
          A0     => fifo_60_wr_addr(0),          
          A1     => fifo_60_wr_addr(1),
          A2     => fifo_60_wr_addr(2),
          A3     => fifo_60_wr_addr(3),
          D      => fbit_0(55 downto 48),      
          DPRA0  => fifo_60_rd_addr(0),
          DPRA1  => fifo_60_rd_addr(1),
          DPRA2  => fifo_60_rd_addr(2),
          DPRA3  => fifo_60_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_6(0)
         );         

ram_8d_dqs6_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_61_data_out,          
          A0     => fifo_61_wr_addr(0),          
          A1     => fifo_61_wr_addr(1),
          A2     => fifo_61_wr_addr(2),
          A3     => fifo_61_wr_addr(3),
          D      => fbit_1(55 downto 48),      
          DPRA0  => fifo_61_rd_addr(0),
          DPRA1  => fifo_61_rd_addr(1),
          DPRA2  => fifo_61_rd_addr(2),
          DPRA3  => fifo_61_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_6(1)
         ); 
         
ram_8d_dqs6_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_62_data_out,          
          A0     => fifo_62_wr_addr(0),          
          A1     => fifo_62_wr_addr(1),
          A2     => fifo_62_wr_addr(2),
          A3     => fifo_62_wr_addr(3),
          D      => fbit_2(55 downto 48),      
          DPRA0  => fifo_62_rd_addr(0),
          DPRA1  => fifo_62_rd_addr(1),
          DPRA2  => fifo_62_rd_addr(2),
          DPRA3  => fifo_62_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_6(2)
         ); 
         
ram_8d_dqs6_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_63_data_out,          
          A0     => fifo_63_wr_addr(0),          
          A1     => fifo_63_wr_addr(1),
          A2     => fifo_63_wr_addr(2),
          A3     => fifo_63_wr_addr(3),
          D      => fbit_3(55 downto 48),      
          DPRA0  => fifo_63_rd_addr(0),
          DPRA1  => fifo_63_rd_addr(1),
          DPRA2  => fifo_63_rd_addr(2),
          DPRA3  => fifo_63_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_6(3)
         ); 
         
-- FIFOs associated with ddr2_dqs(7)         
         
ram_8d_dqs7_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_70_data_out,          
          A0     => fifo_70_wr_addr(0),          
          A1     => fifo_70_wr_addr(1),
          A2     => fifo_70_wr_addr(2),
          A3     => fifo_70_wr_addr(3),
          D      => fbit_0(63 downto 56),      
          DPRA0  => fifo_70_rd_addr(0),
          DPRA1  => fifo_70_rd_addr(1),
          DPRA2  => fifo_70_rd_addr(2),
          DPRA3  => fifo_70_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_7(0)
         );         

ram_8d_dqs7_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_71_data_out,          
          A0     => fifo_71_wr_addr(0),          
          A1     => fifo_71_wr_addr(1),
          A2     => fifo_71_wr_addr(2),
          A3     => fifo_71_wr_addr(3),
          D      => fbit_1(63 downto 56),      
          DPRA0  => fifo_71_rd_addr(0),
          DPRA1  => fifo_71_rd_addr(1),
          DPRA2  => fifo_71_rd_addr(2),
          DPRA3  => fifo_71_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_7(1)
         ); 
         
ram_8d_dqs7_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_72_data_out,          
          A0     => fifo_72_wr_addr(0),          
          A1     => fifo_72_wr_addr(1),
          A2     => fifo_72_wr_addr(2),
          A3     => fifo_72_wr_addr(3),
          D      => fbit_2(63 downto 56),      
          DPRA0  => fifo_72_rd_addr(0),
          DPRA1  => fifo_72_rd_addr(1),
          DPRA2  => fifo_72_rd_addr(2),
          DPRA3  => fifo_72_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_7(2)
         ); 
         
ram_8d_dqs7_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_73_data_out,          
          A0     => fifo_73_wr_addr(0),          
          A1     => fifo_73_wr_addr(1),
          A2     => fifo_73_wr_addr(2),
          A3     => fifo_73_wr_addr(3),
          D      => fbit_3(63 downto 56),      
          DPRA0  => fifo_73_rd_addr(0),
          DPRA1  => fifo_73_rd_addr(1),
          DPRA2  => fifo_73_rd_addr(2),
          DPRA3  => fifo_73_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_7(3)
         );
         
-- FIFOs associated with ddr2_dqs(8)         
         
ram_8d_dqs8_fbit0 : RAM_8D                  
port map (                                                   
          DPO    => fifo_80_data_out,          
          A0     => fifo_80_wr_addr(0),          
          A1     => fifo_80_wr_addr(1),
          A2     => fifo_80_wr_addr(2),
          A3     => fifo_80_wr_addr(3),
          D      => fbit_0(71 downto 64),      
          DPRA0  => fifo_80_rd_addr(0),
          DPRA1  => fifo_80_rd_addr(1),
          DPRA2  => fifo_80_rd_addr(2),
          DPRA3  => fifo_80_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_8(0)
         );         

ram_8d_dqs8_fbit1 : RAM_8D                  
port map (                                                   
          DPO    => fifo_81_data_out,          
          A0     => fifo_81_wr_addr(0),          
          A1     => fifo_81_wr_addr(1),
          A2     => fifo_81_wr_addr(2),
          A3     => fifo_81_wr_addr(3),
          D      => fbit_1(71 downto 64),      
          DPRA0  => fifo_81_rd_addr(0),
          DPRA1  => fifo_81_rd_addr(1),
          DPRA2  => fifo_81_rd_addr(2),
          DPRA3  => fifo_81_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_8(1)
         ); 
         
ram_8d_dqs8_fbit2 : RAM_8D                  
port map (                                                   
          DPO    => fifo_82_data_out,          
          A0     => fifo_82_wr_addr(0),          
          A1     => fifo_82_wr_addr(1),
          A2     => fifo_82_wr_addr(2),
          A3     => fifo_82_wr_addr(3),
          D      => fbit_2(71 downto 64),      
          DPRA0  => fifo_82_rd_addr(0),
          DPRA1  => fifo_82_rd_addr(1),
          DPRA2  => fifo_82_rd_addr(2),
          DPRA3  => fifo_82_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_8(2)
         ); 
         
ram_8d_dqs8_fbit3 : RAM_8D                  
port map (                                                   
          DPO    => fifo_83_data_out,          
          A0     => fifo_83_wr_addr(0),          
          A1     => fifo_83_wr_addr(1),
          A2     => fifo_83_wr_addr(2),
          A3     => fifo_83_wr_addr(3),
          D      => fbit_3(71 downto 64),      
          DPRA0  => fifo_83_rd_addr(0),
          DPRA1  => fifo_83_rd_addr(1),
          DPRA2  => fifo_83_rd_addr(2),
          DPRA3  => fifo_83_rd_addr(3),
          WCLK   => clk90,          
          WE     => transfer_done_8(3)
         );  

                                                                       
         
end   arc_data_read_72bit_rl;  

























































































































































































































































































































































































































































































































































































































































































































































