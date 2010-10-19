--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       ddr2_cntrl_72bit_rl
--
--  Description :     
--                    Main DDR SDRAM controller block. This includes the following
--                    features:
--                    - The main controller state machine that controlls the 
--                    initialization process upon power up, as well as the 
--                    read, write, and refresh commands. 
--                    - handles the data path during READ and WRITEs.
--                    - Generates control signals for other modules, including the
--                      data strobe(DQS) signal
--
--  Date - revision : 05/01/2002
--
--  Author :          Lakshmi Gopalakrishnan ( Modified by Sailaja)
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
----------------------------------------
-- ENTITY DECLARATION
----------------------------------------
entity   ddr2_cntrl_72bit_rl  is
port(
	-- system interface
	sys_clk_int            : in std_logic; 
	sys_clk90_int          : in std_logic; 
	sys_delay_sel_val      : in std_logic_vector(4 downto 0); 
	sys_rst                : in std_logic; 
	sys_rst90              : in std_logic; 
	sys_rst180             : in std_logic; 
	sys_rst270             : in std_logic; 

	-- user interface
	user_input_data        : in  STD_LOGIC_VECTOR(143 downto 0);
	user_byte_enable       : in  STD_LOGIC_VECTOR(17 downto 0);
	user_get_data          : out STD_LOGIC;
	user_output_data       : out STD_LOGIC_VECTOR(143 downto 0):=(OTHERS => 'Z');
	user_data_valid        : out STD_LOGIC;
	user_col_address       : in  STD_LOGIC_VECTOR((column_address_p - 1) downto 0);
	user_row_address       : in  STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	user_bank_address      : in  STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	user_rank_address      : in  STD_LOGIC;
	user_read              : in  STD_LOGIC;
	user_write             : in  STD_LOGIC;
	user_ready             : out  STD_LOGIC;

	-- pads
	pad_rst_dqs_div_in     : in std_logic;
	pad_rst_dqs_div_out    : out std_logic;
	pad_dqs                : inout std_logic_vector(8 downto 0);
	pad_dq                 : inout std_logic_vector(71 downto 0):= (OTHERS => 'Z');
	pad_cke                : out std_logic;
	pad_csb                : out std_logic_vector(1 downto 0);
	pad_rasb               : out std_logic;
	pad_casb               : out std_logic;
	pad_web                : out std_logic;
	pad_dm                 : out std_logic_vector(8 downto 0);  
	pad_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	pad_address            : out std_logic_vector((row_address_p-1) downto 0);
	pad_ODT                : out std_logic_vector(1 downto 0);
	pad_clk0               : out std_logic;
	pad_clk0b              : out std_logic;
	pad_clk1               : out std_logic;
	pad_clk1b              : out std_logic;
	pad_clk2               : out std_logic;
	pad_clk2b              : out std_logic

);
end   ddr2_cntrl_72bit_rl;  

----------------------------------------
-- ARCHITECTURE DECLARATION
----------------------------------------

architecture   arc_ddr2_cntrl_72bit_rl of   ddr2_cntrl_72bit_rl    is

----------------------------------------
-- state machine controller declaration
----------------------------------------
component controller 
port(
	-- system signals
	clk                    : in std_logic;
	reset                  : in std_logic;

	-- user interface
	user_get_data          : out STD_LOGIC;
	user_col_address       : in  STD_LOGIC_VECTOR((column_address_p - 1) downto 0);
	user_row_address       : in  STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	user_bank_address      : in  STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	user_rank_address      : in  STD_LOGIC;
	user_read              : in  STD_LOGIC;
	user_write             : in  STD_LOGIC;
	user_ready             : out STD_LOGIC;

	-- pads
	ddr_rasb               : out std_logic;
	ddr_casb               : out std_logic;
	ddr_ODT                : out std_logic_vector(1 downto 0);
	ddr_web                : out std_logic;
	ddr_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address            : out std_logic_vector((row_address_p-1) downto 0);
	ddr_cke                : out std_logic;
	ddr_csb                : out std_logic_vector(1 downto 0);
	ddr_rst_dqs_div_out    : out std_logic;
	ddr_force_nop          : out std_logic_vector(1 downto 0);
	
	-- data path control
	dqs_enable             : out std_logic;
	dqs_reset              : out std_logic;
	write_enable           : out std_logic;
	input_data_valid       : out std_logic;

	-- infrastructure control
	rst_calib              : out std_logic
);
end component;                                    

----------------------------------------
-- data path declaration
----------------------------------------
component	data_path_72bit_rl 
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
	ddr_rst_dqs_div_in     : in std_logic;
	ddr_write_en           : out std_logic;
	ddr_data_mask_falling  : out std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : out std_logic_vector(8 downto 0);
	ddr_write_data_falling : out std_logic_vector(71 downto 0);
	ddr_write_data_rising  : out std_logic_vector(71 downto 0)
);
end component;

----------------------------------------
-- infrastructure declaration
----------------------------------------
component infrastructure
port(
	sys_rst                : in std_logic;
	clk_int                : in std_logic;
	rst_calib1             : in std_logic;
	delay_sel_val          : in std_logic_vector(4 downto 0);
	delay_sel_val1_val     : out std_logic_vector(4 downto 0)
);
end component;

----------------------------------------
-- IO pads declaration
----------------------------------------
component	iobs_72bit 
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
	pad_rst_dqs_div_in     : in std_logic;
	pad_rst_dqs_div_out    : out std_logic;

	-- control signals
	ctrl_dqs_reset         : in std_logic;
	ctrl_dqs_enable        : in std_logic;   
	ctrl_write_en          : in std_logic

);
end component;

                                 
----------------------------------------
-- signals declaration
----------------------------------------

	-- infrastructure signals
	signal rst_calib              : std_logic;
	signal rst_calib_180          : std_logic;
	signal delay_sel              : std_logic_vector(4 downto 0);

	-- controller local resets
	signal local_rst              : std_logic := '1';
	signal local_rst90            : std_logic := '1';
	signal local_rst180           : std_logic := '1';
	signal local_rst270           : std_logic := '1';

	-- state machine controller signals
	signal ddr_rasb               :  std_logic;
	signal ddr_casb               :  std_logic;
	signal ddr_web                :  std_logic;
	signal ddr_ba                 :  std_logic_vector((bank_address_p-1) downto 0);
	signal ddr_address            :  std_logic_vector((row_address_p-1) downto 0);
	signal ddr_cke                :  std_logic;
	signal ddr_csb                :  std_logic_vector(1 downto 0);
	signal ddr_ODT                :  std_logic_vector(1 downto 0);
	signal ddr_force_nop          :  std_logic_vector(1 downto 0);

	-- data path signals
	-- control
	signal write_enable           : std_logic;
	signal dqs_enable             : std_logic;
	signal dqs_reset              : std_logic;
	signal input_data_valid       : std_logic;
	-- active signals
	signal ddr_rst_dqs_div_in     : std_logic;
	signal ddr_rst_dqs_div_out    : std_logic;
	signal ddr_dqs_int_delay_in0  : std_logic;
	signal ddr_dqs_int_delay_in1  : std_logic;
	signal ddr_dqs_int_delay_in2  : std_logic;
	signal ddr_dqs_int_delay_in3  : std_logic;
	signal ddr_dqs_int_delay_in4  : std_logic;
	signal ddr_dqs_int_delay_in5  : std_logic;
	signal ddr_dqs_int_delay_in6  : std_logic;
	signal ddr_dqs_int_delay_in7  : std_logic;
	signal ddr_dqs_int_delay_in8  : std_logic;
	signal ddr_dq                 : std_logic_vector(71 downto 0);
	signal ddr_write_en           : std_logic;
	signal ddr_data_mask_falling  : std_logic_vector(8 downto 0);
	signal ddr_data_mask_rising   : std_logic_vector(8 downto 0);
	signal ddr_write_data_falling : std_logic_vector(71 downto 0);
	signal ddr_write_data_rising  : std_logic_vector(71 downto 0);

begin

----------------------------------------
-- state machine controller signals mapping
----------------------------------------
controller0 : controller port map (
	-- system signals
	clk                    => sys_clk_int        ,
	reset                  => local_rst          ,

	-- user interface
	user_get_data          => user_get_data      ,
	user_col_address       => user_col_address   ,
	user_row_address       => user_row_address   ,
	user_bank_address      => user_bank_address  ,
	user_rank_address      => user_rank_address  ,
	user_read              => user_read          ,
	user_write             => user_write         ,
	user_ready             => user_ready         ,

	-- pads
	ddr_rasb               => ddr_rasb           , 
	ddr_casb               => ddr_casb           , 
	ddr_ODT                => ddr_ODT            , 
	ddr_web                => ddr_web            , 
	ddr_ba                 => ddr_ba             , 
	ddr_address            => ddr_address        , 
	ddr_cke                => ddr_cke            , 
	ddr_csb                => ddr_csb            , 
	ddr_rst_dqs_div_out    => ddr_rst_dqs_div_out, 
	ddr_force_nop          => ddr_force_nop      ,
	
	-- data path control
	dqs_enable             => dqs_enable         ,
	dqs_reset              => dqs_reset          ,
	write_enable           => write_enable       ,
	input_data_valid       => input_data_valid   ,

	-- infrastructure control
	rst_calib              => rst_calib         
);

----------------------------------------
-- data path signals mapping
----------------------------------------
data_path0	:	data_path_72bit_rl
port	map	( 
	-- system ports
	clk                    => sys_clk_int           ,
	clk90                  => sys_clk90_int         ,
	reset                  => local_rst             ,  
	reset90                => local_rst90           ,
	reset180               => local_rst180          ,
	reset270               => local_rst270          ,
	delay_sel              => delay_sel             ,   

	-- data ports (on clk0)
	input_data             => user_input_data       ,
	write_enable           => write_enable          ,
	byte_enable            => user_byte_enable      ,
	output_data_valid      => user_data_valid       ,
	output_data            => user_output_data      ,
	input_data_valid       => input_data_valid      ,

	-- iobs ports
	ddr_dqs_int_delay_in0  => ddr_dqs_int_delay_in0 ,
	ddr_dqs_int_delay_in1  => ddr_dqs_int_delay_in1 ,
	ddr_dqs_int_delay_in2  => ddr_dqs_int_delay_in2 ,
	ddr_dqs_int_delay_in3  => ddr_dqs_int_delay_in3 ,
	ddr_dqs_int_delay_in4  => ddr_dqs_int_delay_in4 ,
	ddr_dqs_int_delay_in5  => ddr_dqs_int_delay_in5 ,
	ddr_dqs_int_delay_in6  => ddr_dqs_int_delay_in6 ,
	ddr_dqs_int_delay_in7  => ddr_dqs_int_delay_in7 ,
	ddr_dqs_int_delay_in8  => ddr_dqs_int_delay_in8 ,  
	ddr_dq                 => ddr_dq                ,       
	ddr_rst_dqs_div_in     => ddr_rst_dqs_div_in    ,
	ddr_write_en           => ddr_write_en          ,
	ddr_data_mask_falling  => ddr_data_mask_falling ,
	ddr_data_mask_rising   => ddr_data_mask_rising  ,
	ddr_write_data_falling => ddr_write_data_falling,
	ddr_write_data_rising  => ddr_write_data_rising
);                           

----------------------------------------
-- infrastructure signals mapping
----------------------------------------
infrastructure0 : infrastructure port map
(
	sys_rst                => local_rst,
	clk_int                => sys_clk_int,
	rst_calib1             => rst_calib_180,
	delay_sel_val          => sys_delay_sel_val,
	delay_sel_val1_val     => delay_sel
); 

----------------------------------------
-- IO pads signals mapping
----------------------------------------
iobs0	:	iobs_72bit	port	map 
(
	-- system ports
	clk                    => sys_clk_int           ,
	clk90                  => sys_clk90_int         ,
	reset                  => local_rst             ,  
	reset90                => local_rst90           ,
	reset180               => local_rst180          ,
	reset270               => local_rst270          ,

	-- signals from/to the fabric  
	ddr_rasb               => ddr_rasb              , 
	ddr_casb               => ddr_casb              , 
	ddr_web                => ddr_web               , 
	ddr_cke                => ddr_cke               , 
	ddr_csb                => ddr_csb               , 
	ddr_ODT                => ddr_ODT               , 
	ddr_address            => ddr_address           , 
	ddr_ba                 => ddr_ba                , 
	ddr_write_data_falling => ddr_write_data_falling, 
	ddr_write_data_rising  => ddr_write_data_rising , 
	ddr_data_mask_falling  => ddr_data_mask_falling , 
	ddr_data_mask_rising   => ddr_data_mask_rising  ,                                                      
	ddr_rst_dqs_div_out    => ddr_rst_dqs_div_out   , 
	ddr_rst_dqs_div_in     => ddr_rst_dqs_div_in    , 
	ddr_dqs_int_delay_in0  => ddr_dqs_int_delay_in0 , 
	ddr_dqs_int_delay_in1  => ddr_dqs_int_delay_in1 , 
	ddr_dqs_int_delay_in2  => ddr_dqs_int_delay_in2 , 
	ddr_dqs_int_delay_in3  => ddr_dqs_int_delay_in3 , 
	ddr_dqs_int_delay_in4  => ddr_dqs_int_delay_in4 , 
	ddr_dqs_int_delay_in5  => ddr_dqs_int_delay_in5 , 
	ddr_dqs_int_delay_in6  => ddr_dqs_int_delay_in6 , 
	ddr_dqs_int_delay_in7  => ddr_dqs_int_delay_in7 , 
	ddr_dqs_int_delay_in8  => ddr_dqs_int_delay_in8 , 
	ddr_dq                 => ddr_dq                , 
	ddr_force_nop          => ddr_force_nop         ,
	
	-- I/O pads
	pad_dqs                => pad_dqs               ,                                                                     
	pad_dq                 => pad_dq                ,
	pad_dm                 => pad_dm                ,
	pad_clk0               => pad_clk0              ,
	pad_clk0b              => pad_clk0b             ,
	pad_clk1               => pad_clk1              ,
	pad_clk1b              => pad_clk1b             ,
	pad_clk2               => pad_clk2              ,
	pad_clk2b              => pad_clk2b             ,
	pad_rasb               => pad_rasb              ,
	pad_casb               => pad_casb              ,
	pad_web                => pad_web               ,
	pad_ba                 => pad_ba                ,
	pad_address            => pad_address           ,
	pad_cke                => pad_cke               ,
	pad_csb                => pad_csb               ,
	pad_ODT                => pad_ODT               ,
	pad_rst_dqs_div_in     => pad_rst_dqs_div_in    ,
	pad_rst_dqs_div_out    => pad_rst_dqs_div_out   ,

	-- control signals
	ctrl_dqs_reset         => dqs_reset             ,
	ctrl_dqs_enable        => dqs_enable            ,   
	ctrl_write_en          => ddr_write_en

);


-- delay the calibration reset by half a cycle
calib_reset_delay: process(sys_clk_int)
begin
	if sys_clk_int'event and sys_clk_int = '0' then
		if local_rst180 = '1' then
			rst_calib_180 <= '0';
		else
			rst_calib_180 <= rst_calib;
		end if;
	end if;
end process  calib_reset_delay;
					
-- controller local resets
local_rst_proc: process(sys_clk_int)
begin
	if sys_clk_int'event and sys_clk_int = '1' then
		local_rst <= sys_rst;
	end if;
end process local_rst_proc;

local_rst90_proc: process(sys_clk90_int)
begin
	if sys_clk90_int'event and sys_clk90_int = '1' then
		local_rst90 <= sys_rst90;
	end if;
end process local_rst90_proc;

local_rst180_proc: process(sys_clk_int)
begin
	if sys_clk_int'event and sys_clk_int = '0' then
		local_rst180 <= sys_rst180;
	end if;
end process local_rst180_proc;

local_rst270_proc: process(sys_clk90_int)
begin
	if sys_clk90_int'event and sys_clk90_int = '0' then
		local_rst270 <= sys_rst270;
	end if;
end process local_rst270_proc;

end   arc_ddr2_cntrl_72bit_rl;  

