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
      C_NUM_CE : integer := 6
      );
  port
    (
      --------------------------------------
      -- configuration signals to synthersizer & ADC DCM
      --------------------------------------
      adc_syns_rst_o       : out std_logic := '0';
      adc0_psclk           : out std_logic := '0';
      adc0_psen            : out std_logic := '0';
      adc0_psincdec        : out std_logic := '0';
      adc0_psdone          : in  std_logic := '0';
      adc0_clk             : in  std_logic := '0';
      adc_ctrl_request_o   : out std_logic := '0';
      adc_syns_start_o     : out std_logic := '0';
      adc_syns_data_o      : out std_logic_vector(15 downto 0) := X"0000";
      adc_syns_busy_i      : in  std_logic := '0';
      adc_syns_errflag     : in  std_logic;

      --------------------------------------
      -- configuration signals to ADC10D1000
      --------------------------------------
      adc_start_o	   : out std_logic;
      adc_rw_o		   : out std_logic;
      adc_addr_o	   : out std_logic_vector(0 to 6);
      adc_data_o	   : out std_logic_vector(0 to 15);
      adc_ece_o		   : out std_logic;
      adc_busy_i	   : in  std_logic;
      adc_data_i           : in  std_logic_vector(0 to 15);
      adc_calrun_i	   : in  std_logic;
      adc_request_o	   : out std_logic;

      adc_attn_i_start	   : out std_logic;
      adc_attn_i	   : out std_logic_vector(0 to 4);
      adc_attn_q_start	   : out std_logic;
      adc_attn_q	   : out std_logic_vector(0 to 4);

      adc_temp_start_o     : out std_logic;
      adc_temp_i	   : in  std_logic_vector(12 downto 0);

      --------------------------------------
      -- Bus protocol ports
      --------------------------------------
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
  -- Synthesizer control signals
  ----------------------------------------
  -- DDR reset control
  signal adc_syns_rst_int    : std_logic                 := '0';
  signal adc_ctrl_request    : std_logic;
  signal adc_syns_start      : std_logic;
  signal adc_syns_data       : std_logic_vector(0 to 15);
--  signal adc_syns_busy_o       : std_logic;

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


  ----------------------------------------
  -- Signals for user logic slave model s/w accessible register
  ----------------------------------------
  signal slv_reg_write_select : std_logic_vector(0 to 5);
  signal slv_reg_read_select  : std_logic_vector(0 to 5);
  signal slv_ip2bus_data      : std_logic_vector(0 to C_DWIDTH-1);
  signal slv_read_ack         : std_logic;
  signal slv_write_ack        : std_logic;

  signal adc1_clk	      : std_logic;

  ----------------------------------------
  -- Signals for ADC10D1000
  ----------------------------------------
  signal adc_start		: std_logic;
  signal adc_rw			: std_logic;
  signal adc_addr		: std_logic_vector(0 to 6);
  signal adc_data		: std_logic_vector(0 to 15);
  signal adc_request		: std_logic;
  signal adc_ece		: std_logic;

  signal adc_attn_is		: std_logic_vector(0 to 4);
  signal adc_attn_i_start_s	: std_logic;
  signal adc_attn_qs		: std_logic_vector(0 to 4);
  signal adc_attn_q_start_s	: std_logic;

  signal adc_temp_start_s	: std_logic;

begin

  slv_reg_write_select <= Bus2IP_WrCE(0 to 5);
  slv_reg_read_select  <= Bus2IP_RdCE(0 to 5);
  slv_write_ack        <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2) or Bus2IP_WrCE(3) or Bus2IP_WrCE(4) or Bus2IP_WrCE(5);
  slv_read_ack         <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2) or Bus2IP_RdCE(3) or Bus2IP_RdCE(4) or Bus2IP_RdCE(5);

  OUTPUT_3WIRE_PROC : process( Bus2IP_Clk ) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then

      -- Single cycle strobes
      adc_syns_start <= '0';
      adc_start      <= '0';
      adc_attn_i_start_s <= '0';
      adc_attn_q_start_s <= '0';
      adc_temp_start_s   <= '0';

      ---------------------------------
      -- Reset state
      ---------------------------------
      if Bus2IP_Reset = '1' then

        -- DDR reset control
        adc_syns_rst_int   <= '0';

        -- adc0 control
        adc_syns_start     <= '0';
	adc_start	   <= '0';
        adc0_psen          <= '0';
        adc0_psincdec      <= '0';
        if (AUTOCONFIG_0 = 1) then
          adc_ctrl_request <= '0';
        else
          adc_ctrl_request <= '1';
        end if;

	adc_request <= '0';
	adc_ece <= '0';
        adc_attn_i_start_s <= '0';
        adc_attn_q_start_s <= '0';
	adc_attn_is <= (others => '0');
	adc_attn_qs <= (others => '0');

	adc_temp_start_s   <= '0';

      else

        ---------------------------------
        -- IPIF write state machine
        ---------------------------------

        -- ensure that the reset bits are default low
        adc_syns_rst_int <= '0';
        -- ensure that the psen bits are default low
        adc0_psen <= '0';

        case slv_reg_write_select is

          -- DDR reset, mode pin, and shift control
          when "100000" =>
            if ( Bus2IP_BE(3) = '1' ) then
              if Bus2IP_Data(31) = '1' then
                adc_syns_rst_int <= '1';
              end if;
            end if;
            if ( Bus2IP_BE(2) = '1' ) then
              adc_ctrl_request <= not Bus2IP_Data(21);
            end if;
	    if ( Bus2IP_BE(1) = '1' ) then
              adc0_psincdec <= Bus2IP_Data(14);
              if Bus2IP_Data(15) = '1' then
                adc0_psen <= '1';
              end if;
	    end if;
            if ( Bus2IP_BE(0) = '1' ) then
              adc_request <= Bus2IP_Data(0);
            end if;

          -- synthesizer control
          when "010000" =>
            if ( Bus2IP_BE(3) = '1' ) then
              adc_syns_start   <= Bus2IP_Data(31);
            end if;
            if ( Bus2IP_BE(1) = '1' ) then
              adc_syns_data(8 to 15) <= Bus2IP_Data(8 to 15);
            end if;
            if ( Bus2IP_BE(0) = '1' ) then
              adc_syns_data(0 to 7)  <= Bus2IP_Data(0 to 7);
            end if;

          -- adc10D1000 control
          when "001000" =>
            if ( Bus2IP_BE(3) = '1' ) then
              adc_start   <= Bus2IP_Data(31);
	      adc_rw      <= Bus2IP_Data(30);
	      adc_ece	  <= Bus2IP_Data(29);
            end if;
	    if (Bus2IP_BE(2) = '1') then
	      adc_addr(2 to 5) <= Bus2IP_Data(16 to 19);
	      adc_addr(0 to 1) <= "10";
	      adc_addr(6) <=  '0';
	    end if;
            if ( Bus2IP_BE(1) = '1' ) then
              adc_data(8 to 15) <= Bus2IP_Data(8 to 15);
            end if;
            if ( Bus2IP_BE(0) = '1' ) then
              adc_data(0 to 7)  <= Bus2IP_Data(0 to 7);
            end if;
	  -- adc10D1000 read back data
          when "000100" => NULL;
	  -- adc attenuator 1 & 2
          when "000010" => NULL;
            if ( Bus2IP_BE(3) = '1' ) then
	      adc_attn_q_start_s <= Bus2IP_Data(24);
              adc_attn_qs   <= Bus2IP_Data(27 to 31);
            end if;
            if ( Bus2IP_BE(2) = '1' ) then
	      adc_attn_i_start_s <= Bus2IP_Data(16);
              adc_attn_is   <= Bus2IP_Data(19 to 23);
            end if;

	  -- adc card temperature
          when "000001" => 
	    adc_temp_start_s <= Bus2IP_Data(31);

          when others => null;
        end case;
      end if;
    end if;
  end process OUTPUT_3WIRE_PROC;

  REG_READ_PROC : process( slv_reg_read_select, adc_syns_data, adc_ctrl_request, adc_syns_busy_i, adc0_adc1_sample_RR, adc1_adc0_sample_RR, adc0_psdone, 
                           adc_syns_errflag, adc_start, adc_rw, adc_addr, adc_data, adc_data_i, adc_busy_i, adc_request, adc_ece, adc_calrun_i, 
			   adc_temp_i) is
  begin
    case slv_reg_read_select is
      when "100000" => slv_ip2bus_data <= "000" & adc0_psdone & "00" & adc1_adc0_sample_RR & adc0_adc1_sample_RR & 
					  "00000000" & "0000" & (not adc_ctrl_request) & "00" & adc_syns_errflag & "0000000" & adc_request;
      when "010000" => slv_ip2bus_data <= adc_syns_data & "00000000" & "0000000" & adc_syns_busy_i;
      when "001000" => slv_ip2bus_data <= adc_data & '0' & adc_addr & "0000" & adc_calrun_i & adc_ece & adc_rw & adc_start;
      when "000100" => slv_ip2bus_data <= adc_busy_i & "000" & x"000" & adc_data_i;
      when "000010" => slv_ip2bus_data <= (others => '0');
      when "000001" => slv_ip2bus_data <= "0000000000000000000" & adc_temp_i;
      when others => slv_ip2bus_data <= (others => '0');
    end case;
  end process REG_READ_PROC;

  ----------------------------------------
  -- Wiring of output signals
  ----------------------------------------

  --------------------------------------
  -- configuration signals to ADC10D1000
  --------------------------------------
  adc_start_o		<= adc_start;
  adc_rw_o		<= adc_rw;
  adc_addr_o		<= adc_addr;
  adc_data_o		<= adc_data;
  adc_request_o		<= adc_request;
  adc_ece_o		<= adc_ece;
  --------------------------------------
  -- configuration signals to ADC synthesizer
  --------------------------------------
  adc_syns_rst_o       <= adc_syns_rst_int;
  adc0_psclk           <= Bus2IP_Clk;
  adc_ctrl_request_o   <= adc_ctrl_request;
  adc_syns_start_o     <= adc_syns_start;
  adc_syns_data_o      <= adc_syns_data;

  adc_attn_i	       <= adc_attn_is;
  adc_attn_i_start     <= adc_attn_i_start_s;
  adc_attn_q	       <= adc_attn_qs;
  adc_attn_q_start     <= adc_attn_q_start_s;

  adc_temp_start_o     <= adc_temp_start_s;

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

  adc1_clk <= adc0_clk;
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
