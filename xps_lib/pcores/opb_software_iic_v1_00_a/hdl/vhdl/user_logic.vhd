------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2004 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ** YOU MAY COPY AND MODIFY THESE FILES FOR YOUR OWN INTERNAL USE SOLELY  **
-- ** WITH XILINX PROGRAMMABLE LOGIC DEVICES AND XILINX EDK SYSTEM OR       **
-- ** CREATE IP MODULES SOLELY FOR XILINX PROGRAMMABLE LOGIC DEVICES AND    **
-- ** XILINX EDK SYSTEM. NO RIGHTS ARE GRANTED TO DISTRIBUTE ANY FILES      **
-- ** UNLESS THEY ARE DISTRIBUTED IN XILINX PROGRAMMABLE LOGIC DEVICES.     **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic module.
-- Date:              Tue Jan 18 18:03:16 2005 (by Create and Import Peripheral Wizard)
-- VHDL-Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
-- 	active low signals:                    "*_n"
-- 	clock signals:                         "clk", "clk_div#", "clk_#x"
-- 	reset signals:                         "rst", "rst_n"
-- 	generics:                              "C_*"
-- 	user defined types:                    "*_TYPE"
-- 	state machine next state:              "*_ns"
-- 	state machine current state:           "*_cs"
-- 	combinatorial signals:                 "*_com"
-- 	pipelined or register delay signals:   "*_d#"
-- 	counter signals:                       "*cnt*"
-- 	clock enable signals:                  "*_ce"
-- 	internal version of output port:       "*_i"
-- 	device pins:                           "*_pin"
-- 	ports:                                 "- Names begin with Uppercase"
-- 	processes:                             "*_PROCESS"
-- 	component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Definition of Generics:
--   C_DWIDTH                     -- User logic data bus width
--   C_NUM_CE                     -- User logic chip enable bus width
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus for user logic
--   Bus2IP_BE                    -- Bus to IP byte enables for user logic
--   Bus2IP_RdCE                  -- Bus to IP read chip enable for user logic
--   Bus2IP_WrCE                  -- Bus to IP write chip enable for user logic
--   IP2Bus_Data                  -- IP to Bus data bus for user logic
--   IP2Bus_Ack                   -- IP to Bus acknowledgement
--   IP2Bus_Retry                 -- IP to Bus retry response
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_ToutSup               -- IP to Bus timeout suppress
--
--------------------------------------------------------------------------------
-- Entity section
--------------------------------------------------------------------------------

entity user_logic is
	generic
	(
		-- ADD USER GENERICS BELOW THIS LINE ---------------
		--USER generics added here
		-- ADD USER GENERICS ABOVE THIS LINE ---------------

		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol parameters, do not add to or delete
		C_DWIDTH	: integer	:= 8;
		C_NUM_CE	: integer	:= 1
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
	port
	(
		-- ADD USER PORTS BELOW THIS LINE ------------------
		--USER ports added here
		SDA_I		: in std_logic;
		SDA_O		: out std_logic;
		SDA_T		: out std_logic;
		SCL		: out std_logic;
		-- ADD USER PORTS ABOVE THIS LINE ------------------

		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add to or delete
		Bus2IP_Clk	: in	std_logic;
		Bus2IP_Reset	: in	std_logic;
		Bus2IP_Data	: in	std_logic_vector(0 to C_DWIDTH-1);
		Bus2IP_BE	: in	std_logic_vector(0 to C_DWIDTH/8-1);
		Bus2IP_RdCE	: in	std_logic_vector(0 to C_NUM_CE-1);
		Bus2IP_WrCE	: in	std_logic_vector(0 to C_NUM_CE-1);
		IP2Bus_Data	: out	std_logic_vector(0 to C_DWIDTH-1);
		IP2Bus_Ack	: out	std_logic;
		IP2Bus_Retry	: out	std_logic;
		IP2Bus_Error	: out	std_logic;
		IP2Bus_ToutSup	: out	std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
end entity user_logic;

--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

architecture IMP of user_logic is

	--USER signal declarations added here, as needed for user logic
	signal SDA_state : std_logic;

	----------------------------------------
	-- Signals for user logic slave model s/w accessible register example
	----------------------------------------
	signal slv_reg0	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_reg_write_select	: std_logic_vector(0 to 0);
	signal slv_reg_read_select	: std_logic_vector(0 to 0);
	signal slv_ip2bus_data	: std_logic_vector(0 to C_DWIDTH-1);
	signal slv_read_ack	: std_logic;
	signal slv_write_ack	: std_logic;

begin

	--USER logic implementation added here

	----------------------------------------
	-- Example code to read/write user logic slave model s/w accessible registers
	-- 
	-- Note:
	-- The example code presented here is to show you one way of reading/writing
	-- software accessible registers implemented in the user logic slave model.
	-- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
	-- to one software accessible register by the top level template. For example,
	-- if you have four 32 bit software accessible registers in the user logic, you
	-- are basically operating on the following memory mapped registers:
	-- 
	--    Bus2IP_WrCE or   Memory Mapped
	--       Bus2IP_RdCE   Register
	--            "1000"   C_BASEADDR + 0x0
	--            "0100"   C_BASEADDR + 0x4
	--            "0010"   C_BASEADDR + 0x8
	--            "0001"   C_BASEADDR + 0xC
	-- 
	----------------------------------------
	slv_reg_write_select <= Bus2IP_WrCE(0 to 0);
	slv_reg_read_select  <= Bus2IP_RdCE(0 to 0);
	slv_write_ack        <= Bus2IP_WrCE(0);
	slv_read_ack         <= Bus2IP_RdCE(0);

	SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
	begin

	  if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
	    if Bus2IP_Reset = '1' then
	      slv_reg0 <= (others => '0');
	    else
	      case slv_reg_write_select is
	        when "1" =>
	          for byte_index in 0 to (C_DWIDTH/8)-1 loop
	            if ( Bus2IP_BE(byte_index) = '1' ) then
	              slv_reg0(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
	            end if;
	          end loop;
					when others => null;
				end case;
			end if;
		end if;

	end process SLAVE_REG_WRITE_PROC;

	SLAVE_REG_READ_PROC : process( slv_reg_read_select, slv_reg0 ) is
	begin

		case slv_reg_read_select is
			when "1" => slv_ip2bus_data <= (others => SDA_state);
			when others => slv_ip2bus_data <= (others => '0');
		end case;

	end process SLAVE_REG_READ_PROC;

	SCL <= slv_reg0(0);	

	SDA_O <= '0';
	SDA_state <= SDA_I; 
	SDA_T <= slv_reg0(1);

	----------------------------------------
	-- Example code to drive IP to Bus signals
	----------------------------------------
	IP2Bus_Data        <= slv_ip2bus_data;

	IP2Bus_Ack         <= slv_write_ack or slv_read_ack;
	IP2Bus_Error       <= '0';
	IP2Bus_Retry       <= '0';
	IP2Bus_ToutSup     <= '0';

end IMP;
