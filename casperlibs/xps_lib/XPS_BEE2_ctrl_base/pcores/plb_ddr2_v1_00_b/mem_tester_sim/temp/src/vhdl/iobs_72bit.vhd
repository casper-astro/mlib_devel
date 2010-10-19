--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       iobs.vhd
--
--  Description :     
--                    In this module all the inputs and outputs are declared 
--                    using the components in the IOB's
--
--  Date - revision : 05/01/2002
--
--  Author :          Lakshmi Gopalakrishnan (Modified by Sailaja)
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
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity   iobs_72bit  is
port(
	-- system ports
	clk                    : in std_logic;
	clk90                  : in std_logic;
	reset                  : in std_logic;
	reset90                : in std_logic;
	reset180               : in std_logic;
	reset270               : in std_logic;

	-- signals from/to the fabric  
	ddr_rasb               : in std_logic;
	ddr_casb               : in std_logic;
	ddr_web                : in std_logic;
	ddr_cke                : in std_logic;
	ddr_csb                : in std_logic_vector(1 downto 0);
	ddr_ODT                : in std_logic_vector(1 downto 0);
	ddr_address            : in std_logic_vector((row_address_p-1) downto 0);
	ddr_ba                 : in std_logic_vector((bank_address_p-1) downto 0);
	ddr_write_data_falling : in std_logic_vector(71 downto 0);
	ddr_write_data_rising  : in std_logic_vector(71 downto 0);
	ddr_data_mask_falling  : in std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : in std_logic_vector(8 downto 0);                                                                           
	ddr_rst_dqs_div_out    : in std_logic;
	ddr_rst_dqs_div_in     : out std_logic;
	ddr_dqs_int_delay_in0  : out std_logic;
	ddr_dqs_int_delay_in1  : out std_logic;
	ddr_dqs_int_delay_in2  : out std_logic;
	ddr_dqs_int_delay_in3  : out std_logic;
	ddr_dqs_int_delay_in4  : out std_logic;
	ddr_dqs_int_delay_in5  : out std_logic;
	ddr_dqs_int_delay_in6  : out std_logic;
	ddr_dqs_int_delay_in7  : out std_logic;
	ddr_dqs_int_delay_in8  : out std_logic;
	ddr_dq                 : out std_logic_vector(71 downto 0);
	ddr_force_nop          : in  std_logic_vector(1 downto 0);

	-- I/O pads
	pad_dqs                : inout std_logic_vector(8 downto 0);                                                                                        
	pad_dq                 : inout std_logic_vector(71 downto 0);
	pad_dm                 : out std_logic_vector(8 downto 0);
	pad_clk0               : out std_logic;
	pad_clk0b              : out std_logic;
	pad_clk1               : out std_logic;
	pad_clk1b              : out std_logic;
	pad_clk2               : out std_logic;
	pad_clk2b              : out std_logic;
	pad_rasb               : out std_logic;
	pad_casb               : out std_logic;
	pad_web                : out std_logic;
	pad_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	pad_address            : out std_logic_vector((row_address_p-1) downto 0);
	pad_cke                : out std_logic;
	pad_csb                : out std_logic_vector(1 downto 0);
	pad_ODT                : out std_logic_vector(1 downto 0);
	pad_rst_dqs_div_in     : in  std_logic;
	pad_rst_dqs_div_out    : out std_logic;

	-- control signals
	ctrl_dqs_reset         : in std_logic;
	ctrl_dqs_enable        : in std_logic;   
	ctrl_write_en          : in std_logic
);
end   iobs_72bit;  


architecture   arc_iobs_72bit of   iobs_72bit    is

component	infrastructure_iobs_72bit 
port(
     clk0              : in std_logic;
     clk90             : in std_logic;
     ddr2_clk0         : out std_logic;
     ddr2_clk0b        : out std_logic;
     ddr2_clk1         : out std_logic;
     ddr2_clk1b        : out std_logic;
     ddr2_clk2         : out std_logic;
     ddr2_clk2b        : out std_logic
     );
end component;


component controller_iobs 
port(
	clk0                : in std_logic;
	clk90               : in std_logic;
	ddr_rasb            : in std_logic;
	ddr_casb            : in std_logic;
	ddr_web             : in std_logic;
	ddr_cke             : in std_logic;
	ddr_csb             : in std_logic_vector(1 downto 0);
	ddr_ODT             : in std_logic_vector(1 downto 0);
	ddr_address         : in std_logic_vector((row_address_p -1) downto 0);
	ddr_ba              : in std_logic_vector((bank_address_p -1) downto 0);
	ddr_rst_dqs_div_out : in std_logic;
	ddr_rst_dqs_div_in  : out std_logic;
	ddr_force_nop       : in std_logic_vector(1 downto 0);
	pad_rasb            : out std_logic;
	pad_casb            : out std_logic;
	pad_web             : out std_logic;
	pad_ba              : out std_logic_vector((bank_address_p -1) downto 0);
	pad_address         : out std_logic_vector((row_address_p -1) downto 0);
	pad_cke             : out std_logic;
	pad_csb             : out std_logic_vector(1 downto 0);
	pad_ODT             : out std_logic_vector(1 downto 0);
	pad_rst_dqs_div_out : out std_logic;
	pad_rst_dqs_div_in  : in std_logic
);
end component;


component	data_path_iobs_72bit 
port(
     clk               : in std_logic;
     dqs_reset         : in std_logic;
     dqs_enable        : in std_logic;
     ddr_dqs           : inout std_logic_vector(8 downto 0);
     ddr_dq            : inout std_logic_vector(71 downto 0);
     write_data_falling: in std_logic_vector(71 downto 0);
     write_data_rising : in std_logic_vector(71 downto 0);
     write_en_val      : in std_logic;
     clk90             : in std_logic;
     reset270_r        : in std_logic;
     data_mask_f       : in std_logic_vector(8 downto 0);
     data_mask_r       : in std_logic_vector(8 downto 0);
     dqs_int_delay_in0 : out std_logic;
     dqs_int_delay_in1 : out std_logic;
     dqs_int_delay_in2 : out std_logic;
     dqs_int_delay_in3 : out std_logic;
     dqs_int_delay_in4 : out std_logic;
     dqs_int_delay_in5 : out std_logic;
     dqs_int_delay_in6 : out std_logic;
     dqs_int_delay_in7 : out std_logic;
     dqs_int_delay_in8 : out std_logic;
     dq                : out std_logic_vector(71 downto 0);
     ddr_dm            : out std_logic_vector(8 downto 0)  
);
end component;           

signal reset270_r : std_logic;
signal clk270     : std_logic;
attribute syn_keep : boolean;
attribute syn_keep of clk270 : signal is true;

begin

-- generation of clk270
clk270 <= not clk90;

-- register the reset270 signal
reset_reg270: process(clk270)
begin
	if clk270'event and clk270 = '0' then
		reset270_r <= reset270;
	end if;
end process;

infrastructure_iobs0	:	infrastructure_iobs_72bit	port	map	( 
                                                     clk0             => clk,
                                                     clk90            => clk90,
                                                     ddr2_clk0        => pad_clk0,
                                                     ddr2_clk0b       => pad_clk0b,
                                                     ddr2_clk1        => pad_clk1,
                                                     ddr2_clk1b       => pad_clk1b,
                                                     ddr2_clk2        => pad_clk2,
                                                     ddr2_clk2b       => pad_clk2b
                                                    );

controller_iobs0 : controller_iobs port map (
			clk0                 =>  clk,
			clk90                =>  clk90,
			ddr_rasb             =>  ddr_rasb,
			ddr_casb             =>  ddr_casb,
			ddr_web              =>  ddr_web, 
			ddr_cke              =>  ddr_cke,
			ddr_csb              =>  ddr_csb,
			ddr_ODT              =>  ddr_ODT,
			ddr_address          =>  ddr_address((row_address_p -1) downto 0),
			ddr_ba               =>  ddr_ba((bank_address_p -1) downto 0),
			ddr_rst_dqs_div_out  =>  ddr_rst_dqs_div_out,
			ddr_rst_dqs_div_in   =>  ddr_rst_dqs_div_in,
			ddr_force_nop        =>  ddr_force_nop,
			pad_rasb             =>  pad_rasb,
			pad_casb             =>  pad_casb,
			pad_web              =>  pad_web,
			pad_ba               =>  pad_ba((bank_address_p -1) downto 0),
			pad_address          =>  pad_address((row_address_p -1) downto 0),
			pad_cke              =>  pad_cke,
			pad_csb              =>  pad_csb, 
			pad_ODT              =>  pad_ODT, 
			pad_rst_dqs_div_in	 =>  pad_rst_dqs_div_in,
			pad_rst_dqs_div_out  =>  pad_rst_dqs_div_out
);

data_path_iobs0	:	data_path_iobs_72bit	port	map	( 
                                         clk                =>   clk,
                                         dqs_reset          =>   ctrl_dqs_reset,
                                         dqs_enable         =>   ctrl_dqs_enable,
                                         ddr_dqs            =>   pad_dqs(8 downto 0),
                                         ddr_dq             =>   pad_dq(71 downto 0),
                                         write_data_falling =>   ddr_write_data_falling(71 downto 0),
                                         write_data_rising  =>   ddr_write_data_rising(71 downto 0),
                                         write_en_val       =>   ctrl_write_en,
                                         clk90              =>   clk90,
                                         reset270_r         =>   reset270_r,
                                         data_mask_f        =>   ddr_data_mask_falling(8 downto 0),
                                         data_mask_r        =>   ddr_data_mask_rising(8 downto 0),
                                         dqs_int_delay_in0  =>   ddr_dqs_int_delay_in0,
                                         dqs_int_delay_in1  =>   ddr_dqs_int_delay_in1,
                                         dqs_int_delay_in2  =>   ddr_dqs_int_delay_in2,
                                         dqs_int_delay_in3  =>   ddr_dqs_int_delay_in3,
                                         dqs_int_delay_in4  =>   ddr_dqs_int_delay_in4,
                                         dqs_int_delay_in5  =>   ddr_dqs_int_delay_in5,
                                         dqs_int_delay_in6  =>   ddr_dqs_int_delay_in6,
                                         dqs_int_delay_in7  =>   ddr_dqs_int_delay_in7,
                                         dqs_int_delay_in8  =>   ddr_dqs_int_delay_in8, 
                                         dq                 =>   ddr_dq(71 downto 0),
                                         ddr_dm             =>   pad_dm(8 downto 0)
                                        );

   

end   arc_iobs_72bit;  
         
 
