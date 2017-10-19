-------------------------------------------------------------------------------
-- TC_Core - entity/architecture pair
-------------------------------------------------------------------------------
--
-- ***************************************************************************
-- DISCLAIMER OF LIABILITY
--
-- This file contains proprietary and confidential information of
-- Xilinx, Inc. ("Xilinx"), that is distributed under a license
-- from Xilinx, and may be used, copied and/or disclosed only
-- pursuant to the terms of a valid license agreement with Xilinx.
--
-- XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
-- ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
-- EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
-- LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
-- MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
-- does not warrant that functions included in the Materials will
-- meet the requirements of Licensee, or that the operation of the
-- Materials will be uninterrupted or error-free, or that defects
-- in the Materials will be corrected. Furthermore, Xilinx does
-- not warrant or make any representations regarding use, or the
-- results of the use, of the Materials in terms of correctness,
-- accuracy, reliability or otherwise.
--
-- Xilinx products are not designed or intended to be fail-safe,
-- or for use in any application requiring fail-safe performance,
-- such as life-support or safety devices or systems, Class III
-- medical devices, nuclear facilities, applications related to
-- the deployment of airbags, or any other applications that could
-- lead to death, personal injury or severe property or
-- environmental damage (individually and collectively, "critical
-- applications"). Customer assumes the sole risk and liability
-- of any use of Xilinx products in critical applications,
-- subject only to applicable laws and regulations governing
-- limitations on product liability.
--
-- Copyright 2001, 2002, 2003, 2004, 2008, 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
-- ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename        :tc_core.vhd
-- Company         :Xilinx
-- Version         :v2.0
-- Description     :Dual Timer/Counter for PLB bus
-- Standard        :VHDL-93
--
-------------------------------------------------------------------------------
-- Structure:
--
--                    --tc_core.vhd
--                       --mux_onehot_f.vhd
--                        --family_support.vhd     
--                       --timer_control.vhd
--                       --count_module.vhd
--                             --counter_f.vhd
--                             --family_support.vhd  
-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         03/18/2010      -- Ceated the version  v1.00.a
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         09/18/2010      -- Ceated the version  v1.01.a
--                              -- axi lite ipif v1.01.a used
-- ^^^
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_cmb"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                     Definition of Generics
-------------------------------------------------------------------------------
-- C_FAMILY           -- Default family
-- C_AWIDTH           -- PLB address bus width
-- C_DWIDTH           -- PLB data bus width
-- C_COUNT_WIDTH      -- Width in the bits of the counter
-- C_ONE_TIMER_ONLY   -- Number of the Timer 
-- C_TRIG0_ASSERT     -- Assertion Level of captureTrig0  
-- C_TRIG1_ASSERT     -- Assertion Level of captureTrig1  
-- C_GEN0_ASSERT      -- Assertion Level for GenerateOut0
-- C_GEN1_ASSERT      -- Assertion Level for GenerateOut1
-- C_ARD_NUM_CE_ARRAY -- Number of chip enable
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------
-- Clk                -- PLB Clock  
-- Rst                -- PLB Reset
-- Bus2ip_addr        -- bus to ip address bus
-- Bus2ip_be          -- byte enables
-- Bus2ip_data        -- bus to ip data bus
--   
-- TC_DBus            -- ip to bus data bus
-- bus2ip_rdce        -- read select
-- bus2ip_wrce        -- write select
-- ip2bus_rdack       -- read acknowledge
-- ip2bus_wrack       -- write acknowledge
-- TC_errAck          -- error acknowledge

-------------------------------------------------------------------------------
-- Timer/Counter signals 
-------------------------------------------------------------------------------
-- CaptureTrig0       -- Capture Trigger 0
-- CaptureTrig1       -- Capture Trigger 1
-- GenerateOut0       -- Generate Output 0
-- GenerateOut1       -- Generate Output 1
-- PWM0               -- Pulse Width Modulation Ouput 0
-- Interrupt          -- Interrupt 
-- Freeze             -- Freeze count value
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

library axi_timer_v2_0_11;
use axi_timer_v2_0_11.TC_Types.QUADLET_TYPE;
use axi_timer_v2_0_11.TC_Types.PWMA0_POS;
use axi_timer_v2_0_11.TC_Types.PWMB0_POS;

library axi_lite_ipif_v3_0_4;
use axi_lite_ipif_v3_0_4.ipif_pkg.calc_num_ce;
use axi_lite_ipif_v3_0_4.ipif_pkg.INTEGER_ARRAY_TYPE;

library unisim;
use unisim.vcomponents.FDRS;

-------------------------------------------------------------------------------
-- Entity declarations
-------------------------------------------------------------------------------
entity tc_core is
  generic (
    C_FAMILY           : string  := "virtex5";
    C_COUNT_WIDTH      : integer := 32;
    C_ONE_TIMER_ONLY   : integer := 0;
    C_DWIDTH           : integer := 32;
    C_AWIDTH           : integer := 5;
    C_TRIG0_ASSERT     : std_logic := '1';
    C_TRIG1_ASSERT     : std_logic := '1';
    C_GEN0_ASSERT      : std_logic := '1';
    C_GEN1_ASSERT      : std_logic := '1';  
    C_ARD_NUM_CE_ARRAY : INTEGER_ARRAY_TYPE 
    );
  port (
    Clk                : in std_logic;
    Rst                : in std_logic;
    -- PLB signals
    Bus2ip_addr        : in std_logic_vector(0 to C_AWIDTH-1);
    Bus2ip_be          : in std_logic_vector(0 to 3);
    Bus2ip_data        : in std_logic_vector(0 to 31);
    TC_DBus            : out std_logic_vector(0 to 31);
    bus2ip_rdce        : in std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    bus2ip_wrce        : in std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    ip2bus_rdack       : out std_logic;
    ip2bus_wrack       : out std_logic;
    TC_errAck          : out std_logic;
    -- PTC signals
    CaptureTrig0       : in std_logic;
    CaptureTrig1       : in std_logic;
    GenerateOut0       : out std_logic;
    GenerateOut1       : out std_logic;
    PWM0               : out std_logic;
    Interrupt          : out std_logic;
    Freeze             : in std_logic
    );
end entity tc_core;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------
architecture imp of tc_core is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";

--Attribute declaration
attribute syn_keep : boolean;
--Signal declaration
signal load_Counter_Reg     : std_logic_vector(0 to 1);
signal load_Load_Reg        : std_logic_vector(0 to 1);
signal write_Load_Reg       : std_logic_vector(0 to 1);
signal captGen_Mux_Sel      : std_logic_vector(0 to 1);
signal loadReg_DBus         : std_logic_vector(0 to C_COUNT_WIDTH*2-1);
signal counterReg_DBus      : std_logic_vector(0 to C_COUNT_WIDTH*2-1);
signal tCSR0_Reg            : QUADLET_TYPE;
signal tCSR1_Reg            : QUADLET_TYPE;
signal counter_TC           : std_logic_vector(0 to 1);
signal counter_En           : std_logic_vector(0 to 1);
signal count_Down           : std_logic_vector(0 to 1);
attribute syn_keep of count_Down : signal is true;
signal iPWM0                : std_logic;
signal iGenerateOut0        : std_logic;
signal iGenerateOut1        : std_logic;
signal pwm_Reset            : std_logic;
signal Read_Reg_In          : QUADLET_TYPE;
signal read_Mux_In          : std_logic_vector(0 to 6*32-1);
signal read_Mux_S           : std_logic_vector(0 to 5);


begin -- architecture imp

-----------------------------------------------------------------------------
-- Generating the acknowledgement/error signals
-----------------------------------------------------------------------------
  
    ip2bus_rdack <= (Bus2ip_rdce(0) or Bus2ip_rdce(1) or Bus2ip_rdce(2) or 
                     Bus2ip_rdce(4) or Bus2ip_rdce(5) or
                     Bus2ip_rdce(6) or Bus2ip_rdce(7));
  
    ip2bus_wrack <= (Bus2ip_wrce(0) or Bus2ip_wrce(1) or Bus2ip_wrce(2) or 
                     Bus2ip_wrce(4) or Bus2ip_wrce(5) or
                     Bus2ip_wrce(6) or Bus2ip_wrce(7));
 
--TCR0 AND TCR1 is read only register, hence writing to these register 
--will not generate error ack. 
--Modify TC_errAck    <= (Bus2ip_wrce(2)or Bus2ip_wrce(6)) on 11/11/08 to;
    TC_errAck    <= '0';

-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
--Process :READ_MUX_INPUT
-----------------------------------------------------------------------------
    READ_MUX_INPUT: process (TCSR0_Reg,TCSR1_Reg,LoadReg_DBus,CounterReg_DBus) is
    begin
      read_Mux_In(0  to 19) <= (others => '0');
      read_Mux_In(20 to 31) <= TCSR0_Reg(20 to 31);
      read_Mux_In(32 to 52) <= (others => '0');
      read_Mux_In(53 to 63) <= TCSR1_Reg(21 to 31);
      if C_COUNT_WIDTH < C_DWIDTH then
        for i in 1 to C_DWIDTH-C_COUNT_WIDTH loop
          read_Mux_In(63 +i)  <= '0';
          read_Mux_In(95 +i)  <= '0';
          read_Mux_In(127+i)  <= '0';
          read_Mux_In(159+i)  <= '0';
        end loop;
      end if;
      read_Mux_In(64 +C_DWIDTH-C_COUNT_WIDTH to  95) <=
        LoadReg_DBus(C_COUNT_WIDTH*0 to C_COUNT_WIDTH*1-1);
      read_Mux_In(96 +C_DWIDTH-C_COUNT_WIDTH to 127) <=
        LoadReg_DBus(C_COUNT_WIDTH*1 to C_COUNT_WIDTH*2-1);
      read_Mux_In(128+C_DWIDTH-C_COUNT_WIDTH to 159) <=
        CounterReg_DBus(C_COUNT_WIDTH*0 to C_COUNT_WIDTH*1-1);
      read_Mux_In(160+C_DWIDTH-C_COUNT_WIDTH to 191) <=
        CounterReg_DBus(C_COUNT_WIDTH*1 to C_COUNT_WIDTH*2-1);
    end process READ_MUX_INPUT;

---------------------------------------------------------              
-- Create read mux select input
-- Bus2ip_rdce(0) -->TCSR0 REG READ ENABLE
-- Bus2ip_rdce(4) -->TCSR1 REG READ ENABLE
-- Bus2ip_rdce(1) -->TLR0  REG READ ENABLE
-- Bus2ip_rdce(5) -->TLR1  REG READ ENABLE
-- Bus2ip_rdce(2) -->TCR0  REG READ ENABLE
-- Bus2ip_rdce(6) -->TCR1  REG READ ENABLE
---------------------------------------------------------

    read_Mux_S <= Bus2ip_rdce(0) & Bus2ip_rdce(4)& Bus2ip_rdce(1)
                  & Bus2ip_rdce(5) & Bus2ip_rdce(2) & Bus2ip_rdce(6); 
              
    -- mux_onehot_f              
    READ_MUX_I: entity axi_timer_v2_0_11.mux_onehot_f
      generic map(
          C_DW => 32,
          C_NB => 6,
          C_FAMILY => C_FAMILY)
      port map(
          D    => read_Mux_In,     --[in]
          S    => read_Mux_S,      --[in]
          Y    => Read_Reg_In      --[out]
          );

    --slave to bus data bus assignment
    TC_DBus <= Read_Reg_In ;
                               
------------------------------------------------------------------

------------------------------------------------------------------
-- COUNTER MODULE
------------------------------------------------------------------
COUNTER_0_I: entity axi_timer_v2_0_11.count_module
  generic map (
    C_FAMILY          => C_FAMILY,
    C_COUNT_WIDTH     => C_COUNT_WIDTH)
  port map (
    Clk               => Clk,                   --[in]
    Reset             => Rst,                   --[in]
    Load_DBus         => Bus2ip_data(C_DWIDTH-C_COUNT_WIDTH to C_DWIDTH-1), --[in]
    Load_Counter_Reg  => load_Counter_Reg(0),   --[in]
    Load_Load_Reg     => load_Load_Reg(0),      --[in]
    Write_Load_Reg    => write_Load_Reg(0),     --[in]
    CaptGen_Mux_Sel   => captGen_Mux_Sel(0),    --[in]
    Counter_En        => counter_En(0),         --[in]
    Count_Down        => count_Down(0),         --[in]
    BE                => Bus2ip_be,             --[in]
    LoadReg_DBus      => loadReg_DBus(C_COUNT_WIDTH*0 to C_COUNT_WIDTH*1-1),    --[out]
    CounterReg_DBus   => counterReg_DBus(C_COUNT_WIDTH*0 to C_COUNT_WIDTH*1-1), --[out]
    Counter_TC        => counter_TC(0)          --[out]
    );
    
----------------------------------------------------------------------    
--GEN_SECOND_TIMER:SECOND COUNTER MODULE IS ADDED TO DESIGN 
--WHEN C_ONE_TIMER_ONLY /= 1 
----------------------------------------------------------------------    
GEN_SECOND_TIMER: if C_ONE_TIMER_ONLY /= 1 generate
COUNTER_1_I: entity axi_timer_v2_0_11.count_module
  generic map (
    C_FAMILY          => C_FAMILY,
    C_COUNT_WIDTH     => C_COUNT_WIDTH)    
  port map (
    Clk               => Clk,                   --[in]
    Reset             => Rst,                   --[in]
    Load_DBus         => Bus2ip_data(C_DWIDTH-C_COUNT_WIDTH to C_DWIDTH-1), --[in]
    Load_Counter_Reg  => load_Counter_Reg(1),   --[in]
    Load_Load_Reg     => load_Load_Reg(1),      --[in]
    Write_Load_Reg    => write_Load_Reg(1),     --[in]
    CaptGen_Mux_Sel   => captGen_Mux_Sel(1),    --[in]
    Counter_En        => counter_En(1),         --[in]
    Count_Down        => count_Down(1),         --[in]
    BE                => Bus2ip_be,             --[in]
    LoadReg_DBus      => loadReg_DBus(C_COUNT_WIDTH*1 to C_COUNT_WIDTH*2-1),    --[out]
    CounterReg_DBus   => counterReg_DBus(C_COUNT_WIDTH*1 to C_COUNT_WIDTH*2-1), --[out]
    Counter_TC        => counter_TC(1)          --[out]
    );
end generate GEN_SECOND_TIMER;

----------------------------------------------------------------------    
--GEN_NO_SECOND_TIMER: GENERATE WHEN C_ONE_TIMER_ONLY = 1 
----------------------------------------------------------------------  
GEN_NO_SECOND_TIMER: if C_ONE_TIMER_ONLY = 1 generate
  loadReg_DBus(C_COUNT_WIDTH*1 to C_COUNT_WIDTH*2-1)    <= (others => '0');
  counterReg_DBus(C_COUNT_WIDTH*1 to C_COUNT_WIDTH*2-1) <= (others => '0');
  counter_TC(1) <= '0';
end generate GEN_NO_SECOND_TIMER;

----------------------------------------------------------------------    
--TIMER_CONTROL_I: TIMER_CONTROL MODULE
----------------------------------------------------------------------  
TIMER_CONTROL_I: entity axi_timer_v2_0_11.timer_control
  generic map (
    C_TRIG0_ASSERT     => C_TRIG0_ASSERT,
    C_TRIG1_ASSERT     => C_TRIG1_ASSERT,
    C_GEN0_ASSERT      => C_GEN0_ASSERT,
    C_GEN1_ASSERT      => C_GEN1_ASSERT,
    C_ARD_NUM_CE_ARRAY => C_ARD_NUM_CE_ARRAY
    )
  port map (
    Clk                => Clk,                -- [in]
    Reset              => Rst,                -- [in]
    CaptureTrig0       => CaptureTrig0,       -- [in]
    CaptureTrig1       => CaptureTrig1,       -- [in]
    GenerateOut0       => iGenerateOut0,      -- [out]
    GenerateOut1       => iGenerateOut1,      -- [out]
    Interrupt          => Interrupt,          -- [out]
    Counter_TC         => counter_TC,         -- [in]
    Bus2ip_data        => Bus2ip_data,        -- [in]
    BE                 => Bus2ip_be,          -- [in]
    Load_Counter_Reg   => load_Counter_Reg,   -- [out]
    Load_Load_Reg      => load_Load_Reg,      -- [out]
    Write_Load_Reg     => write_Load_Reg,     -- [out]
    CaptGen_Mux_Sel    => captGen_Mux_Sel,    -- [out]
    Counter_En         => counter_En,         -- [out]
    Count_Down         => count_Down,         -- [out]
    Bus2ip_rdce        => Bus2ip_rdce,        -- [in]
    Bus2ip_wrce        => Bus2ip_wrce,        -- [in]
    Freeze             => Freeze,             -- [in]
    TCSR0_Reg          => tCSR0_Reg(20 to 31),          -- [out]
    TCSR1_Reg          => tCSR1_Reg(21 to 31)           -- [out]
    );

tCSR0_Reg (0 to 19) <= (others => '0');
tCSR1_Reg (0 to 20) <= (others => '0');

pwm_Reset <= iGenerateOut1 or
             (not tCSR0_Reg(PWMA0_POS) and not tCSR1_Reg(PWMB0_POS));

PWM_FF_I: component FDRS
    port map (
      Q  => iPWM0,                  -- [out]
      C  => Clk,                    -- [in]
      D  => iPWM0,                  -- [in]
      R  => pwm_Reset,              -- [in]
      S  => iGenerateOut0           -- [in]
    );

PWM0         <= iPWM0;
GenerateOut0 <= iGenerateOut0;
GenerateOut1 <= iGenerateOut1;

end architecture IMP;
