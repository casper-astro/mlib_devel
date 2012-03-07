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
-- Date:              Fri Dec 03 21:08:57 2004 (by Create and Import Peripheral Wizard)
-- VHDL-Standard:     VHDL'93
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;

--------------------------------------------------------------------------------
-- Entity section
--------------------------------------------------------------------------------

entity user_logic is
  generic
    (
      -- Bus protocol parameters
      C_DWIDTH : integer := 32;
      C_NUM_CE : integer := 4
      );
  port
    (
      --------------------------------------
      -- configuration signals to the DCM
      --------------------------------------
      clk_clk              : in  std_logic := '0';
      clk_psclk            : out std_logic := '0';
      clk_psen             : out std_logic := '0';
      clk_psincdec         : out std_logic := '0';
      clk_reset            : out std_logic := '0';

      -- Bus protocol ports
      Bus2IP_Clk     : in  std_logic;
      Bus2IP_Reset   : in  std_logic;
      Bus2IP_Data    : in  std_logic_vector(0 to C_DWIDTH-1);
      Bus2IP_BE      : in  std_logic_vector(0 to C_DWIDTH/8-1);
      Bus2IP_RdCE    : in  std_logic_vector(0 to C_NUM_CE-1);
      Bus2IP_WrCE    : in  std_logic_vector(0 to C_NUM_CE-1);
      IP2Bus_Data    : out std_logic_vector(0 to C_DWIDTH-1);
      IP2Bus_Ack     : out std_logic;
      IP2Bus_Retry   : out std_logic;
      IP2Bus_Error   : out std_logic;
      IP2Bus_ToutSup : out std_logic
      );
end entity user_logic;

--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

architecture IMP of user_logic is

  ----------------------------------------
  -- DCM control signals
  ----------------------------------------

  signal clk_1mhz_count : std_logic_vector(0 to 6);

  -- clock speed measure detection
  signal clk_count_start           : std_logic;
  signal clk_count_start_resample0 : std_logic;
  signal clk_count_start_resample1 : std_logic;
  signal clk_count_reset           : std_logic;
  signal clk_count_reset_resample0 : std_logic;
  signal clk_count_reset_resample1 : std_logic;
  signal clk_count_100             : std_logic_vector(31 downto 0);
  signal clk_count                 : std_logic_vector(31 downto 0);
  signal clk_count_resample        : std_logic_vector(31 downto 0);
  signal clk_reset_int             : std_logic;

  ----------------------------------------
  -- Signals for user logic slave model s/w accessible register
  ----------------------------------------
  signal slv_reg0             : std_logic_vector(0 to C_DWIDTH-1);
  signal slv_reg2             : std_logic_vector(0 to C_DWIDTH-1);
  signal slv_reg3             : std_logic_vector(0 to C_DWIDTH-1);
  signal slv_reg_write_select : std_logic_vector(0 to 2);
  signal slv_reg_read_select  : std_logic_vector(0 to 2);
  signal slv_ip2bus_data      : std_logic_vector(0 to C_DWIDTH-1);
  signal slv_read_ack         : std_logic;
  signal slv_write_ack        : std_logic;

begin

  slv_reg_write_select <= Bus2IP_WrCE(0 to 2);
  slv_reg_read_select  <= Bus2IP_RdCE(0 to 2);
  slv_write_ack        <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2);
  slv_read_ack         <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2);

  CPU_PROC : process( Bus2IP_Clk ) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then

      ---------------------------------
      -- Reset state
      ---------------------------------
      if Bus2IP_Reset = '1' then
        -- clk control
        clk_count_start    <= '0';
        clk_count_reset    <= '0';
        clk_psen           <= '0';
        clk_psincdec       <= '0';
        clk_reset_int      <= '0';
      else

        ---------------------------------
        -- IPIF write state machine
        ---------------------------------

        -- ensure that the psen bits are default low
        clk_psen <= '0';

        case slv_reg_write_select is

          -- DCM shift and clock sample control
          when "100" =>
            if ( Bus2IP_BE(1) = '1' ) then
              clk_reset_int <= Bus2IP_Data(15);
            end if;
            if ( Bus2IP_BE(2) = '1' ) then
              clk_count_start   <= Bus2IP_Data(23);
              clk_count_reset   <= Bus2IP_Data(22);
            end if;
            if ( Bus2IP_BE(3) = '1' ) then
              clk_psincdec <= Bus2IP_Data(31);
              if Bus2IP_Data(30) = '1' then
                clk_psen <= '1';
              end if;
            end if;
          when others => null;
        end case;

        ---------------------------------
        -- clock counter and clock counter resample
        ---------------------------------

        if clk_count_start = '1' then
          clk_count_100 <= clk_count_100 + 1; 
        end if;

        if clk_count_reset = '1' then
          clk_count_100 <= (others => '0');
        end if;

        -- resample the clk counter
        clk_count_resample <= clk_count;

      end if;
    end if;
  end process CPU_PROC;

  -- clock counter
  CLK_PROC : process(clk_clk)
  begin
    if clk_clk'event and clk_clk = '1' then
      -- resmple the clk reset and start bit
      clk_count_reset_resample0 <= clk_count_reset;
      clk_count_reset_resample1 <= clk_count_reset_resample0;
      clk_count_start_resample0 <= clk_count_start;
      clk_count_start_resample1 <= clk_count_start_resample0;

      if clk_count_start_resample1 = '1' then
        clk_count <= clk_count + 1;
      end if;

      if clk_count_reset_resample1 = '1' then
        clk_count <= (others => '0');
      end if;
    end if;
  end process;


  REG_READ_PROC : process( slv_reg_read_select, clk_reset_int, clk_count_reset, clk_count_start ) is
  begin
    case slv_reg_read_select is
      when "100" => slv_ip2bus_data <= X"00" & "0000000" & clk_reset_int & "000000" & clk_count_reset & clk_count_start & X"00";
      when "010" => slv_ip2bus_data <= clk_count_100;
      when "001" => slv_ip2bus_data <= clk_count_resample;
      when others => slv_ip2bus_data <= (others => '0');
    end case;
  end process REG_READ_PROC;

  --------------------------------------
  -- configuration signals to DCM
  --------------------------------------
  clk_psclk           <= Bus2IP_Clk;
  clk_reset           <= clk_reset_int;

  ----------------------------------------
  -- Code to drive IP to Bus signals
  ----------------------------------------
  IP2Bus_Data <= slv_ip2bus_data;

  IP2Bus_Ack     <= slv_write_ack or slv_read_ack;
  IP2Bus_Error   <= '0';
  IP2Bus_Retry   <= '0';
  IP2Bus_ToutSup <= '0';

end IMP;
