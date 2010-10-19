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
-- Version:           2.00.a
-- Description:       User logic.
-- Date:              Thu Dec 14 11:11:59 2006 (by Create and Import Peripheral Wizard)
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
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------
    CLOCK_DIV                      : integer              := 4;
    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_DWIDTH                       : integer              := 32;
    C_NUM_CE                       : integer              := 1
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
                DI              : out std_logic;
                DO              : in  std_logic;
                CLK             : out std_logic;
                CS_N            : out std_logic;
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(0 to C_DWIDTH-1);
    Bus2IP_BE                      : in  std_logic_vector(0 to C_DWIDTH/8-1);
    Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
    Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
    IP2Bus_Data                    : out std_logic_vector(0 to C_DWIDTH-1);
    IP2Bus_Ack                     : out std_logic;
    IP2Bus_Retry                   : out std_logic;
    IP2Bus_Error                   : out std_logic;
    IP2Bus_ToutSup                 : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic
  signal spi_DI        : std_logic;
  signal spi_DO        : std_logic;
  signal spi_CLK       : std_logic;
  signal spi_CS_N      : std_logic;
  signal write_reg     : std_logic_vector(7 downto 0);
  signal read_reg      : std_logic_vector(7 downto 0);
  signal transaction   : std_logic := '0';
  signal clk_count     : std_logic_vector(7 downto 0) := (others => '0');
  signal trans_count   : std_logic_vector(4 downto 0) := (others => '0');


  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg_write_select           : std_logic_vector(0 to 0);
  signal slv_reg_read_select            : std_logic_vector(0 to 0);
  signal slv_ip2bus_data                : std_logic_vector(0 to C_DWIDTH-1);
  signal slv_read_ack                   : std_logic;
  signal slv_write_ack                  : std_logic;

begin

  --USER logic implementation added here

  ------------------------------------------
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
  ------------------------------------------
  slv_reg_write_select <= Bus2IP_WrCE(0 to 0);
  slv_reg_read_select  <= Bus2IP_RdCE(0 to 0);
  slv_read_ack         <= Bus2IP_RdCE(0);
  slv_write_ack        <= Bus2IP_WrCE(0);

  -- implement slave model register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Reset = '1' then
	spi_CLK       <= '1';
        spi_DI        <= '0';
        spi_CS_N      <= '0';
        transaction   <= '0';
        clk_count     <= (others => '0');
        trans_count   <= (others => '0');
      else
        -- bus interface
        case slv_reg_write_select is
          when "1" =>
            if transaction = '0' then
              if ( Bus2IP_BE(3) = '1' ) then
                write_reg   <= Bus2IP_Data(24 to 31);
                transaction <= '1';
              end if;
              if ( Bus2IP_BE(0) = '1' ) then
                spi_CS_N <= Bus2IP_Data(7);
              end if;
            end if;
          when others => null;
        end case;
        -- SPI state machine
        if clk_count = (CLOCK_DIV/2 - 1) then
          clk_count <= (others => '0');
          if transaction = '1' then
            spi_CLK <= not spi_CLK;
            if spi_CLK = '1' then
              if trans_count = 8 then
                -- leave clock at one
                spi_CLK       <= '1';
                trans_count   <= (others => '0');
                read_reg      <= read_reg(6 downto 0) & spi_DO;
                transaction   <= '0';
              else
                trans_count <= trans_count + 1;
                spi_DI      <= write_reg(7);
                write_reg   <= write_reg(6 downto 0) & "0";
                read_reg    <= read_reg(6 downto 0) & spi_DO;
              end if;
            end if;
          end if;
        else
          clk_count <= clk_count + 1;
        end if;

      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  CLK    <= spi_CLK;
  DI     <= spi_DI;
  CS_N   <= spi_CS_N;
  spi_DO <= DO;

  -- implement slave model register read mux
  SLAVE_REG_READ_PROC : process( slv_reg_read_select, spi_CS_N, write_reg, read_reg ) is
  begin

    case slv_reg_read_select is
      when "1" => slv_ip2bus_data <= "0000000" & spi_CS_N & "00000000" & read_reg & write_reg;
      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data        <= slv_ip2bus_data;

  IP2Bus_Ack         <= (slv_write_ack or slv_read_ack) and (not transaction);
  IP2Bus_Error       <= '0';
  IP2Bus_Retry       <= (slv_write_ack or slv_read_ack) and transaction;
  IP2Bus_ToutSup     <= '0';

end IMP;
