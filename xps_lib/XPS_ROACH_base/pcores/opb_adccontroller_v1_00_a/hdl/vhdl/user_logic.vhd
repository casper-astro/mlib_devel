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
      -- configuration signals to ADC 0
      --------------------------------------
      adc0_adc3wire_clk    : out std_logic := '0';
      adc0_adc3wire_data   : out std_logic := '0';
      adc0_adc3wire_strobe : out std_logic := '0';
      adc0_modepin         : out std_logic := '0';
      adc0_ddrb            : out std_logic := '0';
      adc0_dcm_reset       : out std_logic := '0';
      adc0_psclk           : out std_logic := '0';
      adc0_psen            : out std_logic := '0';
      adc0_psincdec        : out std_logic := '0';
      adc0_psdone          : in  std_logic := '0';
      adc0_clk             : in  std_logic := '0';

      --------------------------------------
      -- configuration signals to ADC 1
      --------------------------------------
      adc1_adc3wire_clk    : out std_logic := '0';
      adc1_adc3wire_data   : out std_logic := '0';
      adc1_adc3wire_strobe : out std_logic := '0';
      adc1_modepin         : out std_logic := '0';
      adc1_ddrb            : out std_logic := '0';
      adc1_dcm_reset       : out std_logic := '0';
      adc1_psclk           : out std_logic := '0';
      adc1_psen            : out std_logic := '0';
      adc1_psincdec        : out std_logic := '0';
      adc1_psdone          : in  std_logic := '0';
      adc1_clk             : in  std_logic := '0';

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

  signal clk_1mhz_count : std_logic_vector(0 to 6);

  -- adc0
  signal adc0_shift_count    : std_logic_vector(0 to 4)  := "00000";
  signal adc0_shift_register : std_logic_vector(0 to 18) := "0000000000000000000";
  signal adc0_do_shift       : std_logic                 := '0';
  signal adc0_strobe_n       : std_logic                 := '0';
  signal adc0_clk_mask       : std_logic                 := '0';
  signal adc0_modepin_int    : std_logic                 := '0';
  signal adc0_data           : std_logic_vector(0 to 15) := X"0000";
  signal adc0_address        : std_logic_vector(0 to 2)  := "000";

  -- adc1
  signal adc1_shift_count    : std_logic_vector(0 to 4)  := "00000";             
  signal adc1_shift_register : std_logic_vector(0 to 18) := "0000000000000000000";
  signal adc1_do_shift       : std_logic                 := '0';                 
  signal adc1_strobe_n       : std_logic                 := '0';                 
  signal adc1_clk_mask       : std_logic                 := '0';                 
  signal adc1_modepin_int    : std_logic                 := '0';                 
  signal adc1_data           : std_logic_vector(0 to 15) := X"0000";             
  signal adc1_address        : std_logic_vector(0 to 2)  := "000";               

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

  signal adc0_ddrb_reg       : std_logic                 := '0';
  signal adc1_ddrb_reg       : std_logic                 := '0';
  attribute iob: string; 
  attribute iob of adc0_ddrb_reg : signal is "true"; --ensure IOB packing to ensure minimum skew
  attribute iob of adc1_ddrb_reg : signal is "true"; 


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

  signal dcm_reset_shifter_0  : std_logic_vector(4 downto 0);
  signal dcm_reset_shifter_1  : std_logic_vector(4 downto 0);

begin

  DCM_RESET_EXTEND : process( Bus2IP_Clk ) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Reset = '1' then
        dcm_reset_shifter_0 <= "11111";
        dcm_reset_shifter_1 <= "11111";
      else
        case dcm_reset_shifter_0 is
          when "00000" =>
            if adc0_ddrb_int = '1' then
              dcm_reset_shifter_0 <= "11111";
            end if;
          when others =>
            dcm_reset_shifter_0 <= dcm_reset_shifter_0(3 downto 0) & '0';
        end case;
        case dcm_reset_shifter_1 is
          when "00000" =>
            if adc1_ddrb_int = '1' then
              dcm_reset_shifter_1 <= "11111";
            end if;
          when others =>
            dcm_reset_shifter_1 <= dcm_reset_shifter_1(3 downto 0) & '0';
        end case;
      end if;
    end if;
  end process DCM_RESET_EXTEND;

  adc0_dcm_reset <= dcm_reset_shifter_0(4);
  adc1_dcm_reset <= dcm_reset_shifter_1(4);
 

  slv_reg_write_select <= Bus2IP_WrCE(0 to 2);
  slv_reg_read_select  <= Bus2IP_RdCE(0 to 2);
  slv_write_ack        <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2);
  slv_read_ack         <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2);

  OUTPUT_3WIRE_PROC : process( Bus2IP_Clk ) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then

      ---------------------------------
      -- Reset state
      ---------------------------------
      if Bus2IP_Reset = '1' then

        -- DDR reset control
        adc0_ddrb_int      <= '0';
        adc1_ddrb_int      <= '0';

        -- adc0 control
        adc0_shift_count   <= (others => '0');
        adc0_shift_register<= (others => '0');
        adc0_do_shift      <= '0';
        adc0_modepin_int   <= '0';
        adc0_address       <= (others => '0');
        adc0_data          <= (others => '0');
        adc0_strobe_n      <= '0';
        adc0_clk_mask      <= '0';
        adc0_psen          <= '0';
        adc0_psincdec      <= '0';

        -- adc1 control
        adc1_shift_count   <= (others => '0');
        adc1_shift_register<= (others => '0');
        adc1_do_shift      <= '0';
        adc1_modepin_int   <= '0';
        adc1_address       <= (others => '0');
        adc1_data          <= (others => '0');
        adc1_strobe_n      <= '0';
        adc1_clk_mask      <= '0';
        adc1_psen          <= '0';
        adc1_psincdec      <= '0';
      else

        ---------------------------------
        -- IPIF write state machine
        ---------------------------------

        -- ensure that the reset bits are default low
        adc0_ddrb_int <= '0';
        adc1_ddrb_int <= '0';
        adc0_ddrb_reg <= adc0_ddrb_int;
        adc1_ddrb_reg <= adc0_ddrb_int;
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
              adc0_modepin_int <= Bus2IP_Data(23);
              adc1_modepin_int <= Bus2IP_Data(22);
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
              adc0_do_shift      <= Bus2IP_Data(31);
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
              adc1_do_shift      <= Bus2IP_Data(31);
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

        ---------------------------------
        -- adc control state machines
        ---------------------------------

        if clk_1mhz_count = "1111111" then
          clk_1mhz_count       <= "0000000";

          -- adc0
          if adc0_do_shift = '1' then
            adc0_shift_count        <= adc0_shift_count + 1;
            case adc0_shift_count is
              when "00000" =>
                adc0_shift_register <= adc0_address & adc0_data;
                adc0_strobe_n       <= '0';
                adc0_clk_mask       <= '1';
              when "00001" =>
                adc0_strobe_n       <= '1';
              when "10101" =>
                adc0_strobe_n       <= '0';
              when "10110" =>
                adc0_shift_count    <= "00000";
                adc0_do_shift       <= '0';
                adc0_strobe_n       <= '0';
                adc0_clk_mask       <= '0';
              when others  =>
                adc0_shift_register <= adc0_shift_register(1 to 18) & '0';
            end case;
          end if;

          -- adc1
          if adc1_do_shift = '1' then
            adc1_shift_count        <= adc1_shift_count + 1;
            case adc1_shift_count is
              when "00000" =>
                adc1_shift_register <= adc1_address & adc1_data;
                adc1_strobe_n       <= '0';
                adc1_clk_mask       <= '1';
              when "00001" =>
                adc1_strobe_n       <= '1';
              when "10101" =>
                adc1_strobe_n       <= '0';
              when "10110" =>
                adc1_shift_count    <= "00000";
                adc1_do_shift       <= '0';
                adc1_strobe_n       <= '0';
                adc1_clk_mask       <= '0';
              when others  =>
                adc1_shift_register <= adc1_shift_register(1 to 18) & '0';
            end case;
          end if;

        else
          clk_1mhz_count       <= clk_1mhz_count + 1;
        end if;

      end if;
    end if;
  end process OUTPUT_3WIRE_PROC;

  REG_READ_PROC : process( slv_reg_read_select, adc0_data, adc0_address, adc0_modepin_int, adc0_do_shift, adc1_data, adc1_address, adc1_modepin_int, adc1_do_shift , adc0_adc1_sample_RR, adc1_adc0_sample_RR) is
  begin
    case slv_reg_read_select is
      when "100" => slv_ip2bus_data <= "00" & adc1_psdone & adc0_psdone & "00" & adc1_adc0_sample_RR & adc0_adc1_sample_RR & "00000000" & "000000" & adc1_modepin_int & adc0_modepin_int & "00000000";
      when "010" => slv_ip2bus_data <= adc0_data & "00000" & adc0_address & "0000000" & adc0_do_shift;
      when "001" => slv_ip2bus_data <= adc1_data & "00000" & adc1_address & "0000000" & adc1_do_shift;
      when others => slv_ip2bus_data <= (others => '0');
    end case;
  end process REG_READ_PROC;

  ----------------------------------------
  -- Wiring of output signals
  ----------------------------------------

  --------------------------------------
  -- configuration signals to ADC 0
  --------------------------------------
  adc0_adc3wire_clk    <= clk_1Mhz_count(0) and adc0_clk_mask;
  adc0_adc3wire_data   <= adc0_shift_register(0);
  adc0_adc3wire_strobe <= not(adc0_strobe_n);
  adc0_modepin         <= adc0_modepin_int;
  adc0_ddrb            <= adc0_ddrb_reg;
  adc0_psclk           <= Bus2IP_Clk;

  --------------------------------------
  -- configuration signals to ADC 1
  --------------------------------------
  adc1_adc3wire_clk    <= clk_1Mhz_count(0) and adc1_clk_mask;
  adc1_adc3wire_data   <= adc1_shift_register(0);
  adc1_adc3wire_strobe <= not(adc1_strobe_n);
  adc1_modepin         <= adc1_modepin_int;
  adc1_ddrb            <= adc1_ddrb_reg;
  adc1_psclk           <= Bus2IP_Clk;

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
