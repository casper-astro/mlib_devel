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
-- Date:              Tue May 23 16:27:56 2006 (by Create and Import Peripheral Wizard)
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
--   C_MAX_AR_DWIDTH              -- User logic max data bus width of address ranges
--   C_NUM_ADDR_RNG               -- User logic number of address ranges to be decoded
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Addr                  -- Bus to IP address bus
--   Bus2IP_Burst                 -- Bus to IP burst-mode qualifier
--   Bus2IP_RNW                   -- Bus to IP read/not write
--   Bus2IP_RdReq                 -- Bus to IP read request
--   Bus2IP_WrReq                 -- Bus to IP write request
--   IP2Bus_Retry                 -- IP to Bus retry response
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_ToutSup               -- IP to Bus timeout suppress
--   IP2Bus_AddrAck               -- IP to Bus address acknowledgement
--   IP2Bus_Busy                  -- IP to Bus busy response
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   Bus2IP_ArData                -- Bus to IP data bus for address ranges
--   Bus2IP_ArBE                  -- Bus to IP byte enables for address ranges
--   Bus2IP_ArCS                  -- Bus to IP chip select for address ranges
--   IP2Bus_ArData                -- IP to Bus data bus for address ranges
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
    C_NUM_ADDR_RNG                 : integer              := 1
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    --USER ports added here
    -- ADD USER PORTS ABOVE THIS LINE ------------------

	pads_address  : out std_logic_vector(18 downto 0);
	pads_bw_b     : out std_logic_vector(3  downto 0);
	pads_we_b     : out std_logic;
	pads_adv_ld_b : out std_logic;
	pads_clk      : out std_logic;
	pads_ce       : out std_logic;
	pads_oe_b     : out std_logic;
	pads_cen_b    : out std_logic;
	pads_dq_T     : out std_logic_vector(35 downto 0);
	pads_dq_I     : in  std_logic_vector(35 downto 0);
	pads_dq_O     : out std_logic_vector(35 downto 0);
	pads_mode     : out std_logic;
	pads_zz       : out std_logic;

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Addr                    : in  std_logic_vector(0 to C_AWIDTH-1);
    Bus2IP_Burst                   : in  std_logic;
    Bus2IP_RNW                     : in  std_logic;
    Bus2IP_RdReq                   : in  std_logic;
    Bus2IP_WrReq                   : in  std_logic;
    IP2Bus_Retry                   : out std_logic;
    IP2Bus_Error                   : out std_logic;
    IP2Bus_ToutSup                 : out std_logic;
    IP2Bus_AddrAck                 : out std_logic;
    IP2Bus_Busy                    : out std_logic;
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    Bus2IP_ArData                  : in  std_logic_vector(0 to C_MAX_AR_DWIDTH-1);
    Bus2IP_ArBE                    : in  std_logic_vector(0 to C_MAX_AR_DWIDTH/8-1);
    Bus2IP_ArCS                    : in  std_logic_vector(0 to C_NUM_ADDR_RNG-1);
    IP2Bus_ArData                  : out std_logic_vector(0 to C_MAX_AR_DWIDTH-1)
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic

  ------------------------------------------
  -- Signals for user logic address range example
  ------------------------------------------
  type BYTE_RAM_TYPE is array (0 to 255) of std_logic_vector(0 to 7);
  type DO_TYPE is array (0 to C_NUM_ADDR_RNG-1) of std_logic_vector(0 to C_MAX_AR_DWIDTH-1);
  signal ar_data_out                    : DO_TYPE;
  signal ar_address                     : std_logic_vector(0 to 18);
  signal ar_select                      : std_logic_vector(0 to 0);
  signal ar_read_enable                 : std_logic;
  signal ar_read_ack_dly1               : std_logic;
  signal ar_read_ack_dly2               : std_logic;
  signal ar_read_ack_dly3               : std_logic;
  signal ar_read_ack_dly4               : std_logic;
  signal ar_read_ack                    : std_logic;
  signal ar_write_ack                   : std_logic;

  signal sram_data_in                   : std_logic_vector(35 downto 0);
  signal sram_data_out                  : std_logic_vector(35 downto 0);
  signal sram_write_enable              : std_logic;
begin

  --USER logic implementation added here

  ------------------------------------------
  -- Example code to access user logic address ranges
  -- 
  -- Note:
  -- The example code presented here is to show you one way of using
  -- the user logic address range features. Those *_Ar* IPIC signals
  -- are dedicated to these user logic address ranges. Each user logic
  -- address range has its own address space and is allocated one bit
  -- on the Bus2IP_ArCS/Bus2IP_ArCE signals to indicated selection of
  -- that range. Typically these user logic address ranges are used to
  -- implement memory controller type cores, but it can also be used
  -- in cores that need to access other address space (not C_BASEADDR
  -- based), s.t. bridges. This code snippet infers 1 256x32-bit (byte
  -- accessible) single-port Block RAM by XST.
  ------------------------------------------
  ar_select      <= Bus2IP_ArCS;
  ar_read_enable <= ( Bus2IP_ArCS(0) ) and Bus2IP_RdReq;
  ar_read_ack    <= ar_read_ack_dly4;
  ar_write_ack   <= ( Bus2IP_ArCS(0) ) and Bus2IP_WrReq;

  ar_address     <= Bus2IP_Addr(C_AWIDTH-21 to C_AWIDTH-3);

  -- This process generates the read acknowledge 4 clock after read enable
  -- is presented to the SRAM block. The SRAM block has a 4 clock delay
  -- from read enable to data out.
  BRAM_RD_ACK_PROC : process( Bus2IP_Clk ) is
  begin

    if ( Bus2IP_Clk'event and Bus2IP_Clk = '1' ) then
      if ( Bus2IP_Reset = '1' ) then
        ar_read_ack_dly1 <= '0';
        ar_read_ack_dly2 <= '0';
        ar_read_ack_dly3 <= '0';
        ar_read_ack_dly4 <= '0';
      else
        ar_read_ack_dly1 <= ar_read_enable;
        ar_read_ack_dly2 <= ar_read_ack_dly1;
        ar_read_ack_dly3 <= ar_read_ack_dly2;
        ar_read_ack_dly4 <= ar_read_ack_dly3;
      end if;
    end if;

  end process BRAM_RD_ACK_PROC;


  sram_if_0 : entity plb_sram_v1_00_a.sram_interface
	port map
	(
		clk                            => Bus2IP_Clk       ,
		we                             => sram_write_enable,
		be                             => Bus2IP_ArBE      ,
		address                        => ar_address       ,
		data_in                        => sram_data_in     ,
		data_out                       => sram_data_out    ,
		data_valid                     => open             ,

		pads_address                   => pads_address ,
		pads_bw_b                      => pads_bw_b    ,
		pads_we_b                      => pads_we_b    ,
		pads_adv_ld_b                  => pads_adv_ld_b,
		pads_clk                       => pads_clk     ,
		pads_ce                        => pads_ce      ,
		pads_oe_b                      => pads_oe_b    ,
		pads_cen_b                     => pads_cen_b   ,
		pads_dq_T                      => pads_dq_T    ,
		pads_dq_I                      => pads_dq_I    ,
		pads_dq_O                      => pads_dq_O    ,
		pads_mode                      => pads_mode    ,
		pads_zz                        => pads_zz      
	);

  sram_write_enable <= not(Bus2IP_RNW) and Bus2IP_ArCS(0);
  sram_data_in      <= Bus2IP_ArData(0 to 7) & "0" & Bus2IP_ArData(8 to 15) & "0" & Bus2IP_ArData(16 to 23) & "0" & Bus2IP_ArData(24 to 31) & "0";
  IP2Bus_ArData     <= sram_data_out(35 downto 28) & sram_data_out(26 downto 19) & sram_data_out(17 downto 10) & sram_data_out(8 downto 1);

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_WrAck       <= ar_write_ack;
  IP2Bus_RdAck       <= ar_read_ack;
  IP2Bus_AddrAck     <= ar_write_ack or ar_read_enable;
  IP2Bus_Busy        <= '0';
  IP2Bus_Error       <= '0';
  IP2Bus_Retry       <= '0';
  IP2Bus_ToutSup     <= '0';

end IMP;
