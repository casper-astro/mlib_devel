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
      AUTOCONFIG_0 : integer := 1;
      AUTOCONFIG_1 : integer := 1;
      -- Bus protocol parameters
      C_DWIDTH : integer := 32;
      C_NUM_CE : integer := 4
      );
  port
    (
      --------------------------------------
      -- configuration signals to ADC 0
      --------------------------------------
      adc0_modepin         : out std_logic := '0';
      adc0_ddrb            : out std_logic := '0';
      adc0_psclk           : out std_logic := '0';
      adc0_psen            : out std_logic := '0';
      adc0_psincdec        : out std_logic := '0';
      adc0_psdone          : in  std_logic := '0';
      adc0_clk             : in  std_logic := '0';
      adc0_3wire_request   : out std_logic := '0';
      adc0_3wire_start     : out std_logic := '0';
      adc0_3wire_data      : out std_logic_vector(15 downto 0) := X"0000";
      adc0_3wire_addr      : out std_logic_vector( 2 downto 0) := "000";
      adc0_3wire_busy      : in  std_logic := '0';

      --------------------------------------
      -- configuration signals to ADC 1
      --------------------------------------
      adc1_modepin         : out std_logic := '0';
      adc1_ddrb            : out std_logic := '0';
      adc1_psclk           : out std_logic := '0';
      adc1_psen            : out std_logic := '0';
      adc1_psincdec        : out std_logic := '0';
      adc1_psdone          : in  std_logic := '0';
      adc1_clk             : in  std_logic := '0';
      adc1_3wire_request   : out std_logic := '0';
      adc1_3wire_start     : out std_logic := '0';
      adc1_3wire_data      : out std_logic_vector(15 downto 0) := X"0000";
      adc1_3wire_addr      : out std_logic_vector( 2 downto 0) := "000";
      adc1_3wire_busy      : in  std_logic := '0';

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
  -- components declaration
  ----------------------------------------

  component FD
    port (
      Q  : out STD_ULOGIC;
      C  : in  STD_ULOGIC;
      D  : in  STD_ULOGIC
    );
  end component;

  component FDE
    port (
      Q  : out STD_ULOGIC;
      CE : in  STD_ULOGIC;
      C  : in  STD_ULOGIC;
      D  : in  STD_ULOGIC
    );
  end component;

  ----------------------------------------
  -- adc control signals
  ----------------------------------------

  -- adc configration arbitration signal
  signal adc0_3wire_request_int : std_logic                := '0';
  signal adc1_3wire_request_int : std_logic                := '0';

  -- adc0
  signal adc0_modepin_int     : std_logic                 := '0';
  signal adc0_3wire_start_int : std_logic                 := '0';
  signal adc0_data            : std_logic_vector(0 to 15) := X"0000";
  signal adc0_address         : std_logic_vector(0 to 2)  := "000";

  -- adc1
  signal adc1_modepin_int     : std_logic                 := '0';                 
  signal adc1_3wire_start_int : std_logic                 := '0';
  signal adc1_data            : std_logic_vector(0 to 15) := X"0000";             
  signal adc1_address         : std_logic_vector(0 to 2)  := "000";               

  -- clock phase detection
  signal adc0_adc1_sample    : std_logic;
  signal adc0_adc1_sample_R  : std_logic;
  signal adc0_adc1_sample_RR : std_logic;
  signal adc1_adc0_sample    : std_logic;
  signal adc1_adc0_sample_R  : std_logic;
  signal adc1_adc0_sample_RR : std_logic;

  signal adc0_toggle         : std_logic;
  signal adc1_toggle         : std_logic;
  signal adc0_toggle_R       : std_logic;
  signal adc1_toggle_R       : std_logic;
  signal not_adc0_toggle     : std_logic;
  signal not_adc1_toggle     : std_logic;

  -- DDR reset control
  signal adc0_ddrb_int       : std_logic                 := '0';
  signal adc1_ddrb_int       : std_logic                 := '0';

  ----------------------------------------
  -- Signals for user logic slave model s/w accessible register
  ----------------------------------------
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

  OUTPUT_3WIRE_PROC : process( Bus2IP_Clk ) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then

      -- Single cycle strobes
      adc0_3wire_start_int <= '0';
      adc1_3wire_start_int <= '0';

      ---------------------------------
      -- Reset state
      ---------------------------------
      if Bus2IP_Reset = '1' then

        -- DDR reset control
        adc0_ddrb_int      <= '0';
        adc1_ddrb_int      <= '0';

        -- adc0 control
        adc0_modepin_int   <= '0';
        adc0_address       <= (others => '0');
        adc0_data          <= (others => '0');
        adc0_psen          <= '0';
        adc0_psincdec      <= '0';
        if (AUTOCONFIG_0 = 1) then
          adc0_3wire_request_int <= '0';
        else
          adc0_3wire_request_int <= '1';
        end if;

        -- adc1 control
        adc1_modepin_int   <= '0';
        adc1_address       <= (others => '0');
        adc1_data          <= (others => '0');
        adc1_psen          <= '0';
        adc1_psincdec      <= '0';
        if (AUTOCONFIG_1 = 1) then
          adc1_3wire_request_int <= '0';
        else
          adc1_3wire_request_int <= '1';
        end if;

      else

        ---------------------------------
        -- IPIF write state machine
        ---------------------------------

        -- ensure that the reset bits are default low
        adc0_ddrb_int <= '0';
        adc1_ddrb_int <= '0';
        -- ensure that the psen bits are default low
        adc0_psen <= '0';
        adc1_psen <= '0';

        case slv_reg_write_select is

          -- DDR reset, mode pin, and shift control
          when "100" =>
            if ( Bus2IP_BE(3) = '1' ) then
              if Bus2IP_Data(31) = '1' then
                adc0_ddrb_int <= '1';
              end if;
              if Bus2IP_Data(30) = '1' then
                adc1_ddrb_int <= '1';
              end if;
            end if;
            if ( Bus2IP_BE(2) = '1' ) then
              adc0_modepin_int       <= Bus2IP_Data(23);
              adc1_modepin_int       <= Bus2IP_Data(22);
              adc0_3wire_request_int <= not Bus2IP_Data(21);
              adc1_3wire_request_int <= not Bus2IP_Data(20);
            end if;
            if ( Bus2IP_BE(1) = '1' ) then
              adc0_psincdec <= Bus2IP_Data(14);
              adc1_psincdec <= Bus2IP_Data(10);
              if Bus2IP_Data(15) = '1' then
                adc0_psen <= '1';
              end if;
              if Bus2IP_Data(11) = '1' then
                adc1_psen <= '1';
              end if;
            end if;

          -- adc0 control
          when "010" =>
            if ( Bus2IP_BE(3) = '1' ) then
              adc0_3wire_start_int   <= Bus2IP_Data(31);
            end if;
            if ( Bus2IP_BE(2) = '1' ) then
              adc0_address       <= Bus2IP_Data(21 to 23);
            end if;
            if ( Bus2IP_BE(1) = '1' ) then
              adc0_data(8 to 15) <= Bus2IP_Data(8 to 15);
            end if;
            if ( Bus2IP_BE(0) = '1' ) then
              adc0_data(0 to 7)  <= Bus2IP_Data(0 to 7);
            end if;

          -- adc1 control
          when "001" =>
            if ( Bus2IP_BE(3) = '1' ) then
              adc1_3wire_start_int   <= Bus2IP_Data(31);
            end if;
            if ( Bus2IP_BE(2) = '1' ) then
              adc1_address       <= Bus2IP_Data(21 to 23);
            end if;
            if ( Bus2IP_BE(1) = '1' ) then
              adc1_data(8 to 15) <= Bus2IP_Data(8 to 15);
            end if;
            if ( Bus2IP_BE(0) = '1' ) then
              adc1_data(0 to 7)  <= Bus2IP_Data(0 to 7);
            end if;

          when others => null;
        end case;
      end if;
    end if;
  end process OUTPUT_3WIRE_PROC;

  REG_READ_PROC : process( slv_reg_read_select, adc0_data, adc0_address, adc0_modepin_int, adc0_3wire_request_int, adc0_3wire_busy, adc1_data, adc1_address, adc1_modepin_int, adc1_3wire_busy, adc1_3wire_request_int, adc0_adc1_sample_RR, adc1_adc0_sample_RR, adc1_psdone, adc0_psdone) is
  begin
    case slv_reg_read_select is
      when "100" => slv_ip2bus_data <= "00" & adc1_psdone & adc0_psdone & "00" & adc1_adc0_sample_RR & adc0_adc1_sample_RR & "00000000" & "0000" & (not adc0_3wire_request_int) & (not adc1_3wire_request_int) & adc1_modepin_int & adc0_modepin_int & "00000000";
      when "010" => slv_ip2bus_data <= adc0_data & "00000" & adc0_address & "0000000" & adc0_3wire_busy;
      when "001" => slv_ip2bus_data <= adc1_data & "00000" & adc1_address & "0000000" & adc1_3wire_busy;
      when others => slv_ip2bus_data <= (others => '0');
    end case;
  end process REG_READ_PROC;

  ----------------------------------------
  -- Wiring of output signals
  ----------------------------------------

  --------------------------------------
  -- configuration signals to ADC 0
  --------------------------------------
  adc0_modepin         <= adc0_modepin_int;
  adc0_ddrb            <= adc0_ddrb_int;
  adc0_psclk           <= Bus2IP_Clk;
  adc0_3wire_request   <= adc0_3wire_request_int;
  adc0_3wire_start     <= adc0_3wire_start_int;
  adc0_3wire_data      <= adc0_data;
  adc0_3wire_addr      <= adc0_address;

  --------------------------------------
  -- configuration signals to ADC 1
  --------------------------------------
  adc1_modepin         <= adc1_modepin_int;
  adc1_ddrb            <= adc1_ddrb_int;
  adc1_psclk           <= Bus2IP_Clk;
  adc1_3wire_request   <= adc1_3wire_request_int;
  adc1_3wire_start     <= adc1_3wire_start_int;
  adc1_3wire_data      <= adc1_data;
  adc1_3wire_addr      <= adc1_address;

  ----------------------------------------
  -- Code to drive IP to Bus signals
  ----------------------------------------
  IP2Bus_Data <= slv_ip2bus_data;

  IP2Bus_Ack     <= slv_write_ack or slv_read_ack;
  IP2Bus_Error   <= '0';
  IP2Bus_Retry   <= '0';
  IP2Bus_ToutSup <= '0';

  ----------------------------------------
  -- Clock phase detect circuit
  ----------------------------------------

  -- half rate toggling flip-flops
  FD_ADC0_HALF : FD
    port map ( 
      Q  => adc0_toggle, 
      C  => adc0_clk,
      D  => not_adc0_toggle
    );
  not_adc0_toggle <= not adc0_toggle;
  FD_ADC1_HALF : FD
    port map ( 
      Q  => adc1_toggle, 
      C  => adc1_clk,
      D  => not_adc1_toggle
    );
  not_adc1_toggle <= not adc1_toggle;
  -- half rate delayed flip-flops
  FD_ADC0_HALF_R : FD
    port map ( 
      Q  => adc0_toggle_R, 
      C  => adc0_clk,
      D  => adc0_toggle
    );
  not_adc0_toggle <= not adc0_toggle;
  FD_ADC1_HALF_R : FD
    port map ( 
      Q  => adc1_toggle_R, 
      C  => adc1_clk,
      D  => adc1_toggle
    );
  not_adc1_toggle <= not adc1_toggle;
  -- clock sampling flip-flops
  FD_ADC0_ADC1 : FDE
    port map ( 
      Q  => adc0_adc1_sample, 
      CE => not_adc0_toggle,
      C  => adc0_clk,
      D  => adc1_toggle_R
    );
  FD_ADC1_ADC0 : FDE
    port map ( 
      Q  => adc1_adc0_sample, 
      CE => not_adc1_toggle,
      C  => adc1_clk,
      D  => adc0_toggle_R
    );
  -- bus clock resampling
  BUSCLK_RESAMPLE : process( Bus2IP_Clk ) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      adc0_adc1_sample_R  <= adc0_adc1_sample;
      adc0_adc1_sample_RR <= adc0_adc1_sample_R;
      adc1_adc0_sample_R  <= adc1_adc0_sample;
      adc1_adc0_sample_RR <= adc1_adc0_sample_R;
    end if;
  end process BUSCLK_RESAMPLE;

end IMP;
