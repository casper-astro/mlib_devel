------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.            **
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
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Thu Nov 13 09:51:56 2008 (by Create and Import Peripheral Wizard)
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

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;
-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_AWIDTH                     -- User logic address bus width
--   C_MAX_AR_DWIDTH              -- User logic max data bus width of address ranges
--   C_NUM_ADDR_RNG               -- User logic number of address ranges to be decoded
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Addr                  -- Bus to IP address bus
--   Bus2IP_RNW                   -- Bus to IP read/not write
--   IP2Bus_Ack                   -- IP to Bus acknowledgement
--   IP2Bus_Retry                 -- IP to Bus retry response
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_ToutSup               -- IP to Bus timeout suppress
--   Bus2IP_Data                -- Bus to IP data bus for address ranges
--   Bus2IP_BE                  -- Bus to IP byte enables for address ranges
--   Bus2IP_CS                  -- Bus to IP chip select for address ranges
--   IP2Bus_Data                -- IP to Bus data bus for address ranges
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_AWIDTH                       : integer              := 32;
    C_MAX_AR_DWIDTH                : integer              := 32;
    C_NUM_ADDR_RNG                 : integer              := 2
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    -- Clock
    ddr_clk          : in  std_logic;

    -- USER interface
    user_input_data  : in  std_logic_vector(143 downto 0);
    user_byte_enable : in  std_logic_vector(17  downto 0);
    user_get_data    : out std_logic;
    user_output_data : out std_logic_vector(143 downto 0);
    user_data_valid  : out std_logic;
    user_address     : in  std_logic_vector(31  downto 0);
    user_read        : in  std_logic;
    user_write       : in  std_logic;
    user_half_burst  : in  std_logic;
    user_ready       : out std_logic;
    user_reset       : in  std_logic;

    -- DDR2 controller ports
    ctrl_input_data  : out std_logic_vector(143 downto 0);
    ctrl_byte_enable : out std_logic_vector(17  downto 0);
    ctrl_get_data    : in  std_logic;
    ctrl_output_data : in  std_logic_vector(143 downto 0);
    ctrl_data_valid  : in  std_logic;
    ctrl_address     : out std_logic_vector(31  downto 0);
    ctrl_read        : out std_logic;
    ctrl_write       : out std_logic;
    ctrl_half_burst  : out std_logic;
    ctrl_ready       : in  std_logic;
    ctrl_reset       : out std_logic;
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Addr                    : in  std_logic_vector(0 to C_AWIDTH-1);
    Bus2IP_RNW                     : in  std_logic;
    IP2Bus_Ack                     : out std_logic;
    IP2Bus_Retry                   : out std_logic;
    IP2Bus_Error                   : out std_logic;
    IP2Bus_ToutSup                 : out std_logic;
    Bus2IP_Data                  : in  std_logic_vector(0 to C_MAX_AR_DWIDTH-1);
    Bus2IP_BE                    : in  std_logic_vector(0 to C_MAX_AR_DWIDTH/8-1);
    Bus2IP_CS                    : in  std_logic_vector(0 to C_NUM_ADDR_RNG-1);
    IP2Bus_Data                  : out std_logic_vector(0 to C_MAX_AR_DWIDTH-1)
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Reset  : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic
 signal one            : std_logic := '1';
  signal zero           : std_logic := '0';

  type plb_fsm_state_type is (
			IDLE,
			DO_READ,
			DO_WRITE
		);

  type ddr_fsm_state_type is (
			IDLE,
			WAIT_READY,
			WAIT_WRITE,
			WAIT_READ,
			END_HANDSHAKE
		);

  component RAM16X1D
    port (DPO   : out STD_ULOGIC;
          SPO   : out STD_ULOGIC;
          A0    : in  STD_ULOGIC;
          A1    : in  STD_ULOGIC;
          A2    : in  STD_ULOGIC;
          A3    : in  STD_ULOGIC;
          D     : in  STD_ULOGIC;
          DPRA0 : in  STD_ULOGIC;
          DPRA1 : in  STD_ULOGIC;
          DPRA2 : in  STD_ULOGIC;
          DPRA3 : in  STD_ULOGIC;
          WCLK  : in  STD_ULOGIC;
          WE    : in  STD_ULOGIC
          );
  end component;

  -- activation control
  signal dimm_select            : std_logic := '0';

  -- PLB side signals
  signal plb_fsm_state          : plb_fsm_state_type;
  signal plb_req_transaction    : std_logic;
  signal plb_ack_transaction    : std_logic;

  -- DDR side signals
  signal ddr_read_data          : std_logic_vector(31 downto 0);
  signal ddr_fsm_state          : ddr_fsm_state_type;
  signal ddr_req_transaction    : std_logic;
  signal ddr_ack_transaction    : std_logic;
  signal switch_ctrl_ppc        : std_logic;
  signal switch_ctrl_ppc_R      : std_logic;
  signal switch_ctrl_ppc_RR     : std_logic;
  signal switch_rd_ppc          : std_logic;
  signal switch_wr_ppc          : std_logic;
  signal switch_wr_ppc_R        : std_logic;
  signal ctrl_address_int       : std_logic_vector(31  downto 0);
  signal ctrl_read_int          : std_logic;
  signal ctrl_write_int         : std_logic;
  signal ctrl_half_burst_int    : std_logic;

  -- FIFO signals
  signal ddr_rd_fifo_push_address : std_logic_vector(3 downto 0);
  signal ddr_rd_fifo_pop_address  : std_logic_vector(3 downto 0);
  signal ddr_wr_fifo_push_address : std_logic_vector(3 downto 0);
  signal ddr_wr_fifo_pop_address  : std_logic_vector(3 downto 0);
  signal extra_write              : std_logic;
  signal extra_read               : std_logic;
  signal ddr_wr_fifo_in           : std_logic;
  signal ddr_rd_fifo_in           : std_logic;

begin

  -- misc assignements
  zero           <= '0';
  one            <= '1';

  -- PLB clock state machine
  PLB_PROC: process(Bus2IP_Clk)
  begin
  	if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
  		if Bus2IP_Reset = '1' then
			plb_fsm_state       <= IDLE;
			plb_req_transaction <= '0';
			plb_ack_transaction <= '0';
  			IP2Bus_Ack        <= '0';
			IP2Bus_ToutSup      <= '0';
  		else
  			-- make sure that the acks are active for only one cycle
  			IP2Bus_Ack <= '0';

			-- resampling of 4-way handshake signals from the ddr clock domain
			plb_ack_transaction  <= ddr_ack_transaction;

  			-- finite state machine
			case plb_fsm_state is
				when IDLE =>
					IP2Bus_ToutSup <= '0';
					if Bus2IP_RNW = '0' and Bus2IP_CS(0) = '1' and dimm_select = '1' then
						plb_fsm_state       <= DO_WRITE;
						plb_req_transaction <= '1';
						IP2Bus_ToutSup      <= '1';
					end if;
					if Bus2IP_RNW = '1' and Bus2IP_CS(0) = '1' and dimm_select = '1' then
						plb_fsm_state       <= DO_READ;
						plb_req_transaction <= '1';
						IP2Bus_ToutSup      <= '1';
					end if;
					if Bus2IP_RNW = '0' and Bus2IP_CS(1) = '1' then
						if Bus2IP_BE(3) = '1' then
							dimm_select <= Bus2IP_Data(31);
						end if;
						IP2Bus_Ack        <= '1';
					end if;
					if Bus2IP_RNW = '1' and Bus2IP_CS(1) = '1' then
						IP2Bus_Data         <= "0000000000000000000000000000000" & dimm_select;
						IP2Bus_Ack        <= '1';
					end if;

				when DO_WRITE =>
					if plb_ack_transaction = '1' and plb_req_transaction = '1' then
						plb_req_transaction <= '0';
						IP2Bus_Ack        <= '1';
					end if;
					if plb_ack_transaction = '0' and plb_req_transaction = '0' then
						plb_fsm_state       <= IDLE;
					end if;
				when DO_READ =>
					if plb_ack_transaction = '1' and plb_req_transaction = '1' then
						plb_req_transaction <= '0';
						IP2Bus_Ack        <= '1';
						IP2Bus_Data         <= ddr_read_data;
					end if;
					if plb_ack_transaction = '0' and plb_req_transaction = '0' then
						plb_fsm_state       <= IDLE;
					end if;
			end case;
  		end if;
  	end if;
  end process;

  -- DDR clock state machine
  DDR_PROC: process(ddr_clk)
  begin
  	if ddr_clk'event and ddr_clk = '1' then
  		if Bus2IP_Reset = '1' then
			ddr_fsm_state       <= IDLE;
			ddr_req_transaction <= '0';
			ddr_ack_transaction <= '0';
			ddr_rd_fifo_push_address <= (others => '0');
			ddr_rd_fifo_pop_address  <= (others => '0');
			ddr_wr_fifo_push_address <= (others => '0');
			ddr_wr_fifo_pop_address  <= (others => '0');
  		else
			-- single cycle active signals
			extra_write <= '0';
			extra_read  <= '0';

			-- resampling of 4-way handshake signals from the ddr clock domain
			ddr_req_transaction  <= plb_req_transaction;

  			-- finite state machine
			case ddr_fsm_state is
				when IDLE =>
					if ddr_req_transaction = '1' then
						switch_ctrl_ppc     <= '1';
						ddr_fsm_state       <= WAIT_READY;
					end if;
				when WAIT_READY =>
					if ctrl_ready = '1' then
						switch_ctrl_ppc     <= '0';
						if Bus2IP_RNW = '1' then
							ddr_fsm_state <= WAIT_READ;
						else
							ddr_fsm_state <= WAIT_WRITE;
						end if;
					end if;
				when WAIT_READ =>
					if ctrl_data_valid = '1' and switch_rd_ppc = '1' then
						ddr_read_data <= ctrl_output_data(31 downto 0);
						ddr_fsm_state <= END_HANDSHAKE;
					end if;
				when WAIT_WRITE =>
					if ctrl_get_data = '1' and switch_wr_ppc = '1' then
						ddr_fsm_state <= END_HANDSHAKE;
					end if;
				when END_HANDSHAKE =>
					if ddr_req_transaction = '1' and ddr_ack_transaction = '0' then
						ddr_ack_transaction <= '1';
					end if;
					if ddr_req_transaction = '0' and ddr_ack_transaction = '1' then
						ddr_ack_transaction <= '0';
						ddr_fsm_state       <= IDLE;
					end if;
			end case;
			-- write fifo control
			-- pop
			if ctrl_get_data = '1' then
				ddr_wr_fifo_pop_address <= ddr_wr_fifo_pop_address + 1;
				switch_wr_ppc_R         <= switch_wr_ppc;
			end if;
			-- push
			if ctrl_ready = '1' and ctrl_write_int = '1' then
				ddr_wr_fifo_push_address <= ddr_wr_fifo_push_address + 1;
				if ctrl_half_burst_int = '0' then
					extra_write <= '1';
				end if;
			end if;
			if extra_write = '1' then
				ddr_wr_fifo_push_address <= ddr_wr_fifo_push_address + 1;
			end if;
			-- read fifo control
			-- pop
			if ctrl_data_valid = '1' then
				ddr_rd_fifo_pop_address <= ddr_rd_fifo_pop_address + 1;
			end if;
			-- push
			if ctrl_ready = '1' and ctrl_read_int = '1' then
				ddr_rd_fifo_push_address <= ddr_rd_fifo_push_address + 1;
				if ctrl_half_burst_int = '0' then
					extra_read <= '1';
				end if;
			end if;
			if extra_read = '1' then
				ddr_rd_fifo_push_address <= ddr_rd_fifo_push_address + 1;
			end if;
			-- address and command mux
			if ctrl_ready = '1' then
				if switch_ctrl_ppc = '1' then
  					ctrl_address_int    <= Bus2IP_Addr;
  					ctrl_read_int       <= Bus2IP_RNW;
  					ctrl_write_int      <= not Bus2IP_RNW;
  					ctrl_half_burst_int <= '1';
  				else
  					ctrl_address_int    <= user_address;
  					ctrl_read_int       <= user_read;
  					ctrl_write_int      <= user_write;
  					ctrl_half_burst_int <= user_half_burst;
				end if;
				switch_ctrl_ppc_R  <= switch_ctrl_ppc;
				switch_ctrl_ppc_RR <= switch_ctrl_ppc_R;
  			end if;
  		end if;
  	end if;
  end process;

  -- FIFOs
  rd_fifo : RAM16X1D
  port map (DPO   => switch_rd_ppc,
            DPRA0 => ddr_rd_fifo_pop_address(0),
            DPRA1 => ddr_rd_fifo_pop_address(1),
            DPRA2 => ddr_rd_fifo_pop_address(2),
            DPRA3 => ddr_rd_fifo_pop_address(3),
            SPO   => open,

            A0    => ddr_rd_fifo_push_address(0),
            A1    => ddr_rd_fifo_push_address(1),
            A2    => ddr_rd_fifo_push_address(2),
            A3    => ddr_rd_fifo_push_address(3),
            D     => ddr_rd_fifo_in,
            WCLK  => ddr_clk,
            WE    => one
            );
  ddr_rd_fifo_in   <= switch_ctrl_ppc_R when extra_read = '0' else switch_ctrl_ppc_RR;

  wr_fifo : RAM16X1D
  port map (DPO   => switch_wr_ppc,
            DPRA0 => ddr_wr_fifo_pop_address(0),
            DPRA1 => ddr_wr_fifo_pop_address(1),
            DPRA2 => ddr_wr_fifo_pop_address(2),
            DPRA3 => ddr_wr_fifo_pop_address(3),
            SPO   => open,

            A0    => ddr_wr_fifo_push_address(0),
            A1    => ddr_wr_fifo_push_address(1),
            A2    => ddr_wr_fifo_push_address(2),
            A3    => ddr_wr_fifo_push_address(3),
            D     => ddr_wr_fifo_in,
            WCLK  => ddr_clk,
            WE    => one
            );
  ddr_wr_fifo_in   <= switch_ctrl_ppc_R when extra_write = '0' else switch_ctrl_ppc_RR;

  -- 200Mhz DDR2 signals
  ctrl_input_data(31  downto  0) <= Bus2IP_Data    when switch_wr_ppc_R   = '1' else user_input_data(31  downto  0);
  ctrl_input_data(143 downto 32) <=                                                  user_input_data(143 downto 32);
  ctrl_byte_enable(3  downto 0)  <= Bus2IP_BE      when switch_wr_ppc_R   = '1' else user_byte_enable(3   downto 0);
  ctrl_byte_enable(17 downto 4)  <=                                                  user_byte_enable(17  downto 4);
  ctrl_reset                     <=                                                  '0';
  ctrl_address                   <=                                                  ctrl_address_int;
  ctrl_read                      <=                                                  ctrl_read_int;
  ctrl_write                     <=                                                  ctrl_write_int;
  ctrl_half_burst                <=                                                  ctrl_half_burst_int;
  user_get_data                  <= '0'            when switch_wr_ppc     = '1' else ctrl_get_data;
  user_output_data               <=                                                  ctrl_output_data;
  user_data_valid                <= '0'            when switch_rd_ppc     = '1' else ctrl_data_valid;
  user_ready                     <= '0'            when switch_ctrl_ppc   = '1' else ctrl_ready;

 
  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Error       <= '0';
  IP2Bus_Retry       <= '0';

end IMP;
