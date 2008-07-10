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
-- Date:              Wed Jun 08 15:07:29 2005 (by Create and Import Peripheral Wizard)
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
		C_DWIDTH	: integer	:= 32;
		C_NUM_CE	: integer	:= 4
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);
	port
	(
		-- ADD USER PORTS BELOW THIS LINE ------------------
		--USER ports added here
		-- ADD USER PORTS ABOVE THIS LINE ------------------

		user_data_out       : out std_logic_vector(31 downto 0);
		user_clk            : in  std_logic;

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

	----------------------------------------
	-- Signals 
	----------------------------------------
	signal slv_reg_read_select	: std_logic_vector(0 to 3);
	signal slv_reg_write_select	: std_logic_vector(0 to 3);

	signal register_value_int     : std_logic_vector(0 to 31);
	signal register_value         : std_logic_vector(31 downto 0);
	signal register_done          : std_logic;
	signal register_done_recap    : std_logic;
	signal register_done_pre      : std_logic;
	signal register_ready         : std_logic;
	signal register_ready_recap   : std_logic;
	signal register_ready_pre     : std_logic;
	signal transfert_done         : std_logic;

	signal one				: std_logic;
	signal zero				: std_logic;

	signal lock                   : std_logic;

	attribute keep                         : string;
	attribute keep of register_done_recap  : signal is "true";
	attribute keep of register_done_pre    : signal is "true";
	attribute keep of register_ready_recap : signal is "true";
	attribute keep of register_ready_pre   : signal is "true";


begin

	one  <= '1';
	zero <= '0';

	slv_reg_read_select  <= Bus2IP_RdCE(0 to 3);
	slv_reg_write_select <= Bus2IP_WrCE(0 to 3);

	SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
	begin

	if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
		register_done_pre   <= register_done;
		register_done_recap <= register_done_pre;
		if Bus2IP_Reset = '1' then
	      	register_ready   <= '0';
	  else
      if slv_reg_write_select = "1000" then
        if Bus2IP_BE(0) = '1' then register_value_int(0  to  7) <= Bus2IP_Data(0  to  7); end if;
        if Bus2IP_BE(1) = '1' then register_value_int(8  to 15) <= Bus2IP_Data(8  to 15); end if;
        if Bus2IP_BE(2) = '1' then register_value_int(16 to 23) <= Bus2IP_Data(16 to 23); end if;
        if Bus2IP_BE(3) = '1' then register_value_int(24 to 31) <= Bus2IP_Data(24 to 31); end if;

				register_ready <= '1';
				transfert_done <= '0';
	            end if;
			if register_ready = '1' and register_done_recap = '1' then
				register_ready <= '0';
			end if;
			if register_ready = '0' and register_done_recap = '0' then
				transfert_done <= '1';
			end if;
		end if;
	end if;

	end process SLAVE_REG_WRITE_PROC;

	SLAVE_REG_READ_PROC : process( Bus2IP_Clk ) is
	begin
	  if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
		if Bus2IP_Reset = '1' then
			lock <= '0';
		else
			if slv_reg_read_select = "0010" then
				lock <= '1';
			end if;
			if slv_reg_read_select = "0001" then
				lock <= '0';
			end if;
		end if;
	  end if;
	end process SLAVE_REG_READ_PROC;

	----------------------------------------
	-- Endian-ness change
	----------------------------------------
        register_value     <=   register_value_int;

	----------------------------------------
	-- IP to Bus signals
	----------------------------------------

	IP2Bus_Data        <=     register_value when
                                 slv_reg_read_select = "1000" else 	
	                          "0000000000000000000000000000000" & transfert_done when
                                 slv_reg_read_select = "0100" else 
                            "0000000000000000000000000000000" & lock when
                                 slv_reg_read_select = "0010" or slv_reg_read_select = "0001" else                                  
                            X"00000000";

	IP2Bus_Ack         <= '1' when (slv_reg_read_select = "1000") or (slv_reg_read_select = "0100") or (slv_reg_read_select = "0001") or (slv_reg_read_select = "0010") or (slv_reg_write_select = "1000") else '0';
	IP2Bus_Error       <= '0';
	IP2Bus_Retry       <= '0';
	IP2Bus_ToutSup     <= '0';

	----------------------------------------
	-- Register resampling and handshaking
	----------------------------------------

	RESAMPLE_PROC : process( user_clk ) is
	begin
		if user_clk'event and user_clk = '1' then
			register_ready_pre   <= register_ready;
			register_ready_recap <= register_ready_pre;
			if register_ready_recap = '1' and register_done = '0' then
				user_data_out <= register_value;
				register_done <= '1';
			end if;
			if register_ready_recap = '0' and register_done = '1' then
				register_done <= '0';
			end if;

		end if;
	end process RESAMPLE_PROC;
	

end IMP;
