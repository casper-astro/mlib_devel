--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--
--*******************************************************************************
--
--  File name :       data_write.vhd
--
--  Description :     This module comprises the write data paths for the
--                    DDR1 memory interface.                 
-- 
--                    
--  Date - revision : 10/16/2003
--
--  Author :          Maria George (Modifed by Sailaja)
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
entity   data_write_72bit  is
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
end   data_write_72bit;  

architecture   arc_data_write_72bit of   data_write_72bit    is

signal write_data             : std_logic_vector(143 downto 0);
signal write_data_falling_int : std_logic_vector(71 downto 0);
signal write_data_rising_int  : std_logic_vector(71 downto 0);
signal data_mask_falling_int  : std_logic_vector(8 downto 0);
signal data_mask_rising_int   : std_logic_vector(8 downto 0);

signal write_data_falling_val : std_logic_vector(71 downto 0);
signal write_data_rising_val  : std_logic_vector(71 downto 0);
signal data_mask_falling_val  : std_logic_vector(8 downto 0);
signal data_mask_rising_val   : std_logic_vector(8 downto 0);

signal clk180                 : std_logic;
signal clk270                 : std_logic;

attribute syn_preserve : boolean;
attribute syn_preserve of write_data_falling_val  : signal is true;
attribute syn_preserve of write_data_rising_val   : signal is true;
attribute syn_preserve of write_data_falling_int  : signal is true;
attribute syn_preserve of write_data_rising_int   : signal is true;
attribute syn_preserve of data_mask_falling_val   : signal is true;
attribute syn_preserve of data_mask_rising_val    : signal is true;
attribute syn_preserve of data_mask_falling_int   : signal is true;
attribute syn_preserve of data_mask_rising_int    : signal is true;

begin
                                                                     
clk270      <= not clk90;
clk180      <= not clk;
 
-- internal signal remapping
write_data_falling <= write_data_falling_val;
write_data_rising  <= write_data_rising_val ;
data_mask_falling  <= data_mask_falling_val ;
data_mask_rising   <= data_mask_rising_val  ;

-- first data sampling on clk
process(clk)
begin
	if clk'event and clk = '1' then
		if reset_r = '1' then
			write_data_falling_int    <= (others => '0');
			write_data_rising_int     <= (others => '0');
			data_mask_falling_int     <= (others => '0');
			data_mask_rising_int      <= (others => '0');
		else
			if input_data_valid = '1' then
				write_data_rising_int    <= input_data(71 downto 0);
				write_data_falling_int     <= input_data(143 downto 72);
				data_mask_rising_int     <= not byte_enable(8 downto 0);
				data_mask_falling_int      <= not byte_enable(17 downto 9);
			end if;
		end if;

	end if;
end process;

-- falling needs a second data sampling on clk180, rising is directly connected to the output
process(clk180)
begin
	if clk180'event and clk180 = '1' then
		if reset180_r = '1' then
			write_data_falling_val  <= (others => '0');
			data_mask_falling_val   <= (others => '0');
		else
			write_data_falling_val  <= write_data_falling_int;
			data_mask_falling_val   <= data_mask_falling_int;
		end if;
	end if;
end process;

write_data_rising_val <= write_data_rising_int;
data_mask_rising_val  <= data_mask_rising_int ;

-- write enable data path

process(clk270)
begin
	if clk270'event and clk270 = '1' then
		if reset270_r = '1' then
			write_en_val    <= '0';
		else
			write_en_val    <= write_enable;
		end if;
	end if;
end process;
                                                      
end   arc_data_write_72bit;  
