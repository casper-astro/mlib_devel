------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
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
-- Description:       User logic.
-- Date:              Mon Jul 24 10:48:58 2006 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.all;
-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_AWIDTH                     -- User logic address bus width
--   C_DWIDTH                     -- User logic data bus width
--   C_NUM_CE                     -- User logic chip enable bus width
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Addr                  -- Bus to IP address bus
--   Bus2IP_Data                  -- Bus to IP data bus for user logic
--   Bus2IP_BE                    -- Bus to IP byte enables for user logic
--   Bus2IP_RdCE                  -- Bus to IP read chip enable for user logic
--   Bus2IP_WrCE                  -- Bus to IP write chip enable for user logic
--   Bus2IP_RdReq                 -- Bus to IP read request
--   Bus2IP_WrReq                 -- Bus to IP write request
--   IP2Bus_Data                  -- IP to Bus data bus for user logic
--   IP2Bus_Retry                 -- IP to Bus retry response
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_ToutSup               -- IP to Bus timeout suppress
--   IP2Bus_Busy                  -- IP to Bus busy response
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    C_WIDE_DATA                    : integer              := 0;
    C_HALF_BURST                   : integer              := 1;
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_AWIDTH                       : integer              := 32;
    C_DWIDTH                       : integer              := 64;
    C_NUM_CE                       : integer              := 1
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    Mem_Cmd_Address                : out std_logic_vector(31 downto 0);
    Mem_Cmd_RNW                    : out std_logic;
    Mem_Cmd_Valid                  : out std_logic;
    Mem_Cmd_Tag                    : out std_logic_vector(31 downto 0);
    Mem_Cmd_Ack                    : in  std_logic;
    Mem_Rd_Dout                    : in  std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
    Mem_Rd_Tag                     : in  std_logic_vector(31 downto 0);
    Mem_Rd_Ack                     : out std_logic;
    Mem_Rd_Valid                   : in  std_logic;
    Mem_Wr_Din                     : out std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
    Mem_Wr_BE                      : out std_logic_vector((18*(C_WIDE_DATA+1))-1 downto 0);
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Addr                    : in  std_logic_vector(0 to C_AWIDTH-1);
    Bus2IP_Data                    : in  std_logic_vector(0 to C_DWIDTH-1);
    Bus2IP_BE                      : in  std_logic_vector(0 to C_DWIDTH/8-1);
    Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
    Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
    Bus2IP_RdReq                   : in  std_logic;
    Bus2IP_WrReq                   : in  std_logic;
    IP2Bus_Data                    : out std_logic_vector(0 to C_DWIDTH-1);
    IP2Bus_Retry                   : out std_logic;
    IP2Bus_Error                   : out std_logic;
    IP2Bus_ToutSup                 : out std_logic;
    IP2Bus_Busy                    : out std_logic;
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is
  signal one            : std_logic := '1';
  signal zero           : std_logic := '0';

  signal pad_zeros_data : std_logic_vector(((C_WIDE_DATA+1)*144-64)-1 downto 0);
  signal pad_zeros_be   : std_logic_vector(((C_WIDE_DATA+1)*18-8)-1 downto 0);

  signal ack_data       : std_logic := '0';

  type fsm_state_type is (
			IDLE,
			DO_READ,
			DO_WRITE,
			READ_WAIT_DATA,
			DUMMY_READ,
			DUMMY_WRITE
		);
  signal fsm_state: fsm_state_type;

begin

  -- misc assignements
  zero           <= '0';
  one            <= '1';
  pad_zeros_be   <= (others => '0');
  pad_zeros_data <= (others => '0');

  -- memory system control signals
  Mem_Cmd_Address           <= Bus2IP_Addr;
  Mem_Cmd_Tag               <= (others => '0');
--  Mem_Rd_Ack                <= ack_data;

  -- data
  Mem_Wr_Din                <= pad_zeros_data & Bus2IP_Data;
  IP2Bus_Data               <= Mem_Rd_Dout(63 downto 0);

  -- acks
  Mem_Rd_Ack                <= '1'; 
  IP2Bus_RdAck              <= '1' when Mem_Rd_Valid = '1' and fsm_state = READ_WAIT_DATA else '0';

  -- byte enables
  Mem_Wr_BE                 <= (pad_zeros_be & Bus2IP_BE) when fsm_state /= DUMMY_WRITE else (others => '0');

  -- state machine
  MEM_CTRL_PROC: process(Bus2IP_Clk)
  begin
  	if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
  		if Bus2IP_Reset = '1' then
			ack_data      <= '0';
			fsm_state     <= IDLE;
			Mem_Cmd_RNW   <= '0';
			Mem_Cmd_Valid <= '0';
			Mem_Cmd_RNW   <= '0';
  			IP2Bus_WrAck  <= '0';
  		else
  			-- make sure that the acks are active for only one cycle
  			IP2Bus_WrAck <= '0';

  			-- finite state machine
			case fsm_state is
				when IDLE =>
					IP2Bus_ToutSup <= '0';
					if Bus2IP_WrReq = '1' then
						fsm_state      <= DO_WRITE;
						Mem_Cmd_Valid  <= '1';
						Mem_Cmd_RNW    <= '0';
						IP2Bus_ToutSup <= '1';
					end if;
					if Bus2IP_RdReq = '1' then
						fsm_state      <= DO_READ;
						Mem_Cmd_Valid  <= '1';
						Mem_Cmd_RNW    <= '1';
						IP2Bus_ToutSup <= '1';
					end if;
				when DO_WRITE =>
					if Mem_Cmd_ack = '1' then
						if C_HALF_BURST = 1 then
							IP2Bus_WrAck  <= '1';
							Mem_Cmd_Valid <= '0';
							fsm_state     <= IDLE;
						else
							fsm_state     <= DUMMY_WRITE;
						end if;
					end if;
				when DUMMY_WRITE =>
					if Mem_Cmd_ack = '1' then
						IP2Bus_WrAck  <= '1';
						Mem_Cmd_Valid <= '0';
						fsm_state     <= IDLE;
					end if;
				when DO_READ =>
					if Mem_Cmd_ack = '1' then
						Mem_Cmd_Valid <= '0';
						fsm_state     <= READ_WAIT_DATA;
					end if;
				when READ_WAIT_DATA =>
					if Mem_Rd_Valid = '1' then
						if C_HALF_BURST = 1 then
							fsm_state    <= IDLE;
						else
							fsm_state    <= DUMMY_READ;
						end if;
					end if;
				when DUMMY_READ =>
					if Mem_Rd_Valid = '1' then
						fsm_state      <= IDLE;
					end if;
			end case;
  		end if;
  	end if;
  end process;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Busy        <= '0';
  IP2Bus_Error       <= '0';
  IP2Bus_Retry       <= '0';

end IMP;
