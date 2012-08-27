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
		FIFO_LENGTH : integer   := 512;
		FIFO_WIDTH  : integer   := 32;

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

		user_data_in        : in  std_logic_vector((FIFO_WIDTH-1) downto 0);
		user_level          : in  std_logic_vector(15 downto 0);
		user_reset          : in  std_logic;
		user_clk            : in  std_logic;
		user_we             : in  std_logic;
		user_full           : out std_logic;
		user_level_reached  : out std_logic;

		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add to or delete
		Bus2IP_Clk	    : in	std_logic;
		Bus2IP_Reset	: in	std_logic;
		Bus2IP_Data	    : in	std_logic_vector(0 to C_DWIDTH-1);
		Bus2IP_BE	    : in	std_logic_vector(0 to C_DWIDTH/8-1);
		Bus2IP_RdCE	    : in	std_logic_vector(0 to C_NUM_CE-1);
		Bus2IP_WrCE	    : in	std_logic_vector(0 to C_NUM_CE-1);
		IP2Bus_Data	    : out	std_logic_vector(0 to C_DWIDTH-1);
		IP2Bus_Ack	    : out	std_logic;
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
	function log2(MAXADDRESS : INTEGER) return INTEGER is
		variable temp  : INTEGER;
	begin
		temp := 2;
		for I in 1 to 31 loop
			if(temp >= MAXADDRESS) then
				return I;
			end if;
			temp := temp + temp;
		end loop;
		return 32;
	end;

	function min(A : INTEGER; B : INTEGER) return INTEGER is
	begin
		if(A > B) then
			return B;
		else
			return A;
		end if;
	end;
	
	function max(A : INTEGER; B : INTEGER) return INTEGER is
	begin
		if(A < B) then
			return B;
		else
			return A;
		end if;
	end;

	----------------------------------------
	-- Signals 
	----------------------------------------
	signal slv_reg_read_select	  : std_logic_vector(0 to 3);
	signal slv_reg_write_select	  : std_logic_vector(0 to 3);

	signal fifo_re                : std_logic;
	signal fifo_data_out          : std_logic_vector(31 downto 0);
	signal fifo_empty             : std_logic;
	signal fifo_reset             : std_logic;

	signal fifo_reset_bit         : std_logic;

	signal one				      : std_logic;
	signal zero				      : std_logic;

	signal lock                   : std_logic;

	signal registered_ack         : std_logic;
	signal combinatorial_ack      : std_logic;
	signal current_state          : std_logic_vector(2 downto 0);

	constant IDLE                 : std_logic_vector(2 downto 0) := "000";
	constant GET_DATA             : std_logic_vector(2 downto 0) := "001";

  constant DCOUNT               : integer := (min(log2(FIFO_LENGTH*FIFO_WIDTH/32),log2(FIFO_LENGTH)));

	component asyncfifo
		port (
			din              : IN  std_logic_vector((FIFO_WIDTH-1) downto 0);
			prog_full_thresh : IN  std_logic_vector(log2(FIFO_LENGTH)-1 downto 0);
			rd_clk           : IN  std_logic;
			rd_en            : IN  std_logic;
			rst              : IN  std_logic;
			wr_clk           : IN  std_logic;
			wr_en            : IN  std_logic;
			dout             : OUT std_logic_vector(31 downto 0);
			empty            : OUT std_logic;
			full             : OUT std_logic;
			prog_full        : OUT std_logic;
			rd_data_count    : OUT std_logic_vector(DCOUNT - 1 downto 0)
		);
	end component;
  attribute box_type : string;
  attribute box_type of asyncfifo: component is "user_black_box";
  attribute read_cores: string;
  attribute read_cores of asyncfifo : component is "no";
  --attributes to prevent xst borking designs with multiple instantiations



	signal fifo_user_level        : std_logic_vector((log2(FIFO_LENGTH)-1) downto 0);
	signal data_count_aligned     : std_logic_vector(15 downto 0);
	signal data_count             : std_logic_vector(DCOUNT - 1 downto 0);
  signal fake_bits_nb           : std_logic_vector(7 downto 0);
	
begin

	one  <= '1';
	zero <= '0';

	slv_reg_read_select  <= Bus2IP_RdCE(0 to 3);
	slv_reg_write_select <= Bus2IP_WrCE(0 to 3);

	SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
	begin

	if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
		if Bus2IP_Reset = '1' then
	      	fifo_reset_bit <= '0';
	    	else
			if slv_reg_write_select = "0100" then
				fifo_reset_bit <= Bus2IP_Data(30);
	            end if;
		end if;
	end if;

	end process SLAVE_REG_WRITE_PROC;

	SLAVE_REG_READ_PROC : process( Bus2IP_Clk ) is
	begin
	  if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
		if Bus2IP_Reset = '1' then
			current_state <= IDLE;
			registered_ack <= '0';
			lock <= '0';
		else
			if current_state = IDLE then
				if slv_reg_read_select = "1000" then
					current_state <= GET_DATA;
					registered_ack <= '1';
				end if;
				if slv_reg_read_select = "0010" then
					lock <= '1';
				end if;
				if slv_reg_read_select = "0001" then
					lock <= '0';
				end if;
			end if;
			if current_state = GET_DATA then
				current_state <= IDLE;
				registered_ack <= '0';
			end if;
		end if;
	  end if;
	end process SLAVE_REG_READ_PROC;

	----------------------------------------
	-- IP to Bus signals
	----------------------------------------

	IP2Bus_Data        <= data_count_aligned & fake_bits_nb & "000000" & fifo_reset_bit & fifo_empty when
                                 slv_reg_read_select = "0100" else 
                            "0000000000000000000000000000000" & lock when
                                 slv_reg_read_select = "0010" or slv_reg_read_select = "0001" else                                  
                            fifo_data_out when
                                 current_state = GET_DATA else
                            X"00000000";

	combinatorial_ack  <= '1' when (slv_reg_read_select = "0100") or (slv_reg_read_select = "0001") or (slv_reg_read_select = "0010") or (slv_reg_write_select = "0100") else '0';

	IP2Bus_Ack         <= combinatorial_ack or registered_ack;
	IP2Bus_Error       <= '0';
	IP2Bus_Retry       <= '0';
	IP2Bus_ToutSup     <= '0';

	----------------------------------------
	-- Fifo signals
	----------------------------------------

  -- ROACH compatibility:
  -- Advance fifo on upper 16 bits of a 32 bit word to support
  -- 2 x 16 bit transaction mapping
	fifo_re    <= '1' when (slv_reg_read_select = "1000" and current_state = IDLE and Bus2IP_BE(0) = '1')  else '0';
	fifo_reset <= fifo_reset_bit or Bus2IP_Reset or user_reset;

	fifo_user_level <= user_level((log2(FIFO_LENGTH)-1) downto 0);
	fifo0: asyncfifo
		port map(
			din               => user_data_in,
			prog_full_thresh  => fifo_user_level,
			rd_clk            => Bus2IP_Clk,
			rd_en             => fifo_re,
			rst               => fifo_reset,
			wr_clk            => user_clk,
			wr_en             => user_we,
			dout              => fifo_data_out,
			empty             => fifo_empty,
			full              => user_full,
			prog_full         => user_level_reached,
			rd_data_count     => data_count
		);

	SMALL_WIDTH : if (FIFO_WIDTH < 33) generate
		signal padding : std_logic_vector(16 - DCOUNT - 1 downto 0);
	begin
		padding <= (others => '0');
		data_count_aligned <= padding & data_count;
		fake_bits_nb <= conv_std_logic_vector(0,8);		
	end generate;

	BIG_WIDTH : if (FIFO_WIDTH > 32) generate
		signal msb_padding : std_logic_vector((16-log2(FIFO_LENGTH*FIFO_WIDTH/32)-1) downto 0);
		signal lsb_padding : std_logic_vector((log2(FIFO_LENGTH*FIFO_WIDTH/32)-log2(FIFO_LENGTH)-1) downto 0);
	begin
		lsb_padding        <= (others => '0');
		msb_padding        <= (others => '0');
    fake_bits_nb       <= conv_std_logic_vector(log2(FIFO_LENGTH*FIFO_WIDTH/32)-log2(FIFO_LENGTH),8);
		data_count_aligned <= msb_padding & data_count & lsb_padding;
	end generate;



end IMP;
