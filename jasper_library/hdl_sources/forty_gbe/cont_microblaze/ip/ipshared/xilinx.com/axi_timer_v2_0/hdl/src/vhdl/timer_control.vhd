-------------------------------------------------------------------------------
-- timer_control - entity/architecture pair
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
-- Filename        :timer_control.vhd
-- Company         :Xilinx
-- Version         :v2.0
-- Description     :Control logic for Peripheral Timer/Counter
-- Standard        :VHDL-93
--
-------------------------------------------------------------------------------
-- Structure:
--              timer_control.vhd
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
--                     Definition of Generics
-------------------------------------------------------------------------------
--    C_TRIG0_ASSERT     -- Assertion Level of captureTrig0  
--    C_TRIG1_ASSERT     -- Assertion Level of captureTrig1  
--    C_GEN0_ASSERT      -- Assertion Level for GenerateOut0 
--    C_GEN1_ASSERT      -- Assertion Level for GenerateOut1 
--    C_ARD_NUM_CE_ARRAY -- Number of chip enable
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------
--    Clk                -- system clock 
--    Reset              -- system reset 
--    CaptureTrig0       -- Capture Trigger 0 
--    CaptureTrig1       -- Capture Trigger 1 
--    GenerateOut0       -- Generate Output 0 
--    GenerateOut1       -- Generate Output 1
--    Interrupt          -- Interrupt 
--    Counter_TC         -- Carry out signal of counter 
--    Bus2ip_data        -- bus2ip data bus 
--    BE                 -- te enab  les 
--    Load_Counter_Reg   -- Load counter register control 
--    Load_Load_Reg      -- Load load register control 
--    Write_Load_Reg     -- write control of TLR reg  
--    CaptGen_Mux_Sel    -- mux select for capture and generate 
--    Counter_En         -- counter enable signal 
--    Count_Down         -- count down signal 
--    Bus2ip_rdce        -- read select 
--    Bus2ip_wrce        -- write select 
--    Freeze             -- freeze 
--    TCSR0_Reg          -- Control/Status register 0 
--    TCSR1_Reg          -- Control/Status register 1 
-------------------------------------------------------------------------------
  
library ieee;
use ieee.std_logic_1164.all;

library axi_lite_ipif_v3_0_4;
library lib_cdc_v1_0_2;
library lib_pkg_v1_0_2;
use axi_lite_ipif_v3_0_4.ipif_pkg.calc_num_ce;
use axi_lite_ipif_v3_0_4.ipif_pkg.INTEGER_ARRAY_TYPE;
use lib_pkg_v1_0_2.lib_pkg.RESET_ACTIVE;

library unisim;
use unisim.vcomponents.FDRSE;

library axi_timer_v2_0_11;
use axi_timer_v2_0_11.TC_Types.QUADLET_TYPE;
use axi_timer_v2_0_11.TC_Types.TWELVE_BIT_TYPE;
use axi_timer_v2_0_11.TC_Types.ELEVEN_BIT_TYPE;
use axi_timer_v2_0_11.TC_Types.ARHT0_POS;
use axi_timer_v2_0_11.TC_Types.ARHT1_POS;
use axi_timer_v2_0_11.TC_Types.CAPT0_POS;
use axi_timer_v2_0_11.TC_Types.CAPT1_POS;
use axi_timer_v2_0_11.TC_Types.CMPT0_POS;
use axi_timer_v2_0_11.TC_Types.CMPT1_POS;
use axi_timer_v2_0_11.TC_Types.ENALL_POS;
use axi_timer_v2_0_11.TC_Types.ENIT0_POS;
use axi_timer_v2_0_11.TC_Types.ENIT1_POS;
use axi_timer_v2_0_11.TC_Types.ENT0_POS;
use axi_timer_v2_0_11.TC_Types.ENT1_POS;
use axi_timer_v2_0_11.TC_Types.LOAD0_POS;
use axi_timer_v2_0_11.TC_Types.LOAD1_POS;
use axi_timer_v2_0_11.TC_Types.MDT0_POS;
use axi_timer_v2_0_11.TC_Types.MDT1_POS;
use axi_timer_v2_0_11.TC_Types.PWMA0_POS;
use axi_timer_v2_0_11.TC_Types.PWMB0_POS;
use axi_timer_v2_0_11.TC_Types.T0INT_POS;
use axi_timer_v2_0_11.TC_Types.T1INT_POS;
use axi_timer_v2_0_11.TC_Types.UDT0_POS;
use axi_timer_v2_0_11.TC_Types.UDT1_POS;
use axi_timer_v2_0_11.TC_Types.CASC_POS;


-------------------------------------------------------------------------------
-- Entity declarations
-------------------------------------------------------------------------------
entity timer_control is
  generic (
    C_TRIG0_ASSERT     : std_logic := '1';
    C_TRIG1_ASSERT     : std_logic := '1';
    C_GEN0_ASSERT      : std_logic := '1';
    C_GEN1_ASSERT      : std_logic := '1';
    C_ARD_NUM_CE_ARRAY : INTEGER_ARRAY_TYPE 
    );
  port (
    Clk                : in   std_logic;
    Reset              : in   std_logic;
    CaptureTrig0       : in   std_logic;
    CaptureTrig1       : in   std_logic;
    GenerateOut0       : out  std_logic;
    GenerateOut1       : out  std_logic;
    Interrupt          : out  std_logic;
    Counter_TC         : in   std_logic_vector(0 to 1);
    Bus2ip_data        : in   std_logic_vector(0 to 31);
    BE                 : in   std_logic_vector(0 to 3);
    Load_Counter_Reg   : out  std_logic_vector(0 to 1);
    Load_Load_Reg      : out  std_logic_vector(0 to 1);
    Write_Load_Reg     : out  std_logic_vector(0 to 1);
    CaptGen_Mux_Sel    : out  std_logic_vector(0 to 1);
    Counter_En         : out  std_logic_vector(0 to 1);
    Count_Down         : out  std_logic_vector(0 to 1);
    Bus2ip_rdce        : in   std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2ip_wrce        : in   std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Freeze             : in   std_logic;
    TCSR0_Reg          : out  TWELVE_BIT_TYPE;
    TCSR1_Reg          : out  ELEVEN_BIT_TYPE
    );
end entity timer_control;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------
architecture imp of timer_control is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";

-------------------------------------------------------------------------------
-- Signal declaration
-------------------------------------------------------------------------------
    signal TCSR0_In          : TWELVE_BIT_TYPE;
    signal TCSR0_Reset       : TWELVE_BIT_TYPE;
    signal TCSR0_Set         : TWELVE_BIT_TYPE;
    signal TCSR0_CE          : TWELVE_BIT_TYPE;
    signal TCSR0             : TWELVE_BIT_TYPE;
    signal TCSR1_In          : ELEVEN_BIT_TYPE;
    signal TCSR1_Reset       : ELEVEN_BIT_TYPE;
    signal TCSR1_Set         : ELEVEN_BIT_TYPE;
    signal TCSR1_CE          : ELEVEN_BIT_TYPE;
    signal TCSR1             : ELEVEN_BIT_TYPE;
    signal captureTrig0_d    : std_logic;
    signal captureTrig1_d    : std_logic;
    signal captureTrig0_d2   : std_logic;
    signal captureTrig1_d2   : std_logic;
    signal captureTrig0_Edge : std_logic;
    signal captureTrig1_Edge : std_logic;
    signal captureTrig0_pulse: std_logic;
    signal captureTrig0_pulse_d1: std_logic;
    signal captureTrig0_pulse_d2: std_logic;
    signal captureTrig1_pulse: std_logic;
    signal read_done0        : std_logic;
    signal read_done1        : std_logic;
    signal generateOutPre0   : std_logic;
    signal generateOutPre1   : std_logic;
    signal pair0_Select      : std_logic;
    signal counter_TC_Reg    : std_logic_vector(0 to 1);
    signal counter_TC_Reg2   : std_logic;
    signal tccr0_select      : std_logic;
    signal tccr1_select      : std_logic;
    signal interrupt_reg     : std_logic;
    signal CaptureTrig0_int : std_logic := '0';
    signal CaptureTrig1_int : std_logic := '0';
    signal Freeze_int : std_logic := '0';
-------------------------------------------------------------------------------
-- Bits in Timer Control Status Register 0 (TCSR0)
-------------------------------------------------------------------------------
    alias CASC               : std_logic is TCSR0(CASC_POS);
    alias T0INT              : std_logic is TCSR0(T0INT_POS);
    alias ENT0               : std_logic is TCSR0(ENT0_POS);
    alias ENIT0              : std_logic is TCSR0(ENIT0_POS);
    alias LOAD0              : std_logic is TCSR0(LOAD0_POS);
    alias ARHT0              : std_logic is TCSR0(ARHT0_POS);
    alias CAPT0              : std_logic is TCSR0(CAPT0_POS);
    alias CMPT0              : std_logic is TCSR0(CMPT0_POS);
    alias UDT0               : std_logic is TCSR0(UDT0_POS);
    alias MDT0               : std_logic is TCSR0(MDT0_POS);
    alias PWMA0              : std_logic is TCSR0(PWMA0_POS);

-------------------------------------------------------------------------------
-- Bits in Timer Control Status Register 1 (TCSR1)
-------------------------------------------------------------------------------
    alias T1INT              : std_logic is TCSR1(T1INT_POS);
    alias ENT1               : std_logic is TCSR1(ENT1_POS);
    alias ENIT1              : std_logic is TCSR1(ENIT1_POS);
    alias LOAD1              : std_logic is TCSR1(LOAD1_POS);
    alias ARHT1              : std_logic is TCSR1(ARHT1_POS);
    alias CAPT1              : std_logic is TCSR1(CAPT1_POS);
    alias CMPT1              : std_logic is TCSR1(CMPT1_POS);
    alias UDT1               : std_logic is TCSR1(UDT1_POS);
    alias MDT1               : std_logic is TCSR1(MDT1_POS);
    alias PWMB0              : std_logic is TCSR1(PWMB0_POS);

-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------
begin -- architecture imp

    pair0_Select <= (Bus2ip_wrce(0) or Bus2ip_wrce(4));

---------------------------------------------------
--Creating TCSR0 Register
---------------------------------------------------

    TCSR0_GENERATE: for i in TWELVE_BIT_TYPE'range generate
      TCSR0_FF_I: component FDRSE
      port map (
        Q  => TCSR0(i),       -- [out]
        C  => Clk,            -- [in]
        CE => TCSR0_CE(i),    -- [in]
        D  => TCSR0_In(i),    -- [in]
        R  => TCSR0_Reset(i), -- [in]
        S  => TCSR0_Set(i)    -- [in]
      );
    end generate TCSR0_GENERATE;

------------------------------------------------------------------------------------
---Interrupt bit (23-bit) of TCSR0 register is cleared by writing 1 to Interrupt bit
------------------------------------------------------------------------------------
    TCSR0_Reset <= (others => '1') when Reset = RESET_ACTIVE else 
                   "000100000000"  
                    when Bus2ip_data(T0INT_POS)='1' and Bus2ip_wrce(0)='1' else
                   (others => '0') ; 

----------------------------------------------------
--TCSR0 PROCESS:
--TO GENERATE CLOCK ENABLES, AND RESET
--OF TCSR0 REGISTER
----------------------------------------------------
    TCSR0_PROCESS: process (Bus2ip_wrce,Bus2ip_data,MDT0, 
                            captureTrig0_Edge,generateOutPre0,TCSR0,
                            pair0_select,Reset,BE,ENT0,CASC,generateOutPre1) is
    begin

      TCSR0_Set   <= (others => '0');
      ---------------------------------------------
      --Generating clock enables for TCSR0 register
      ---------------------------------------------
      TCSR0_CE(31) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(30) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(29) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(28) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(27) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(26) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(25) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(24) <= Bus2ip_wrce(0) and BE(3);
      TCSR0_CE(23) <= Bus2ip_wrce(0) and BE(2);
      TCSR0_CE(22) <= Bus2ip_wrce(0) and BE(2);
      TCSR0_CE(21) <= Bus2ip_wrce(0) and BE(2);
      TCSR0_CE(20) <= Bus2ip_wrce(0) and BE(2);

      TCSR0_In    <= Bus2ip_data(20 to 31);
      TCSR0_In(T0INT_POS) <= TCSR0(T0INT_POS);

     ---------------------------------------------------- 
      ---interrupt bit (23-bit) of TCSR1 register is set to 1
      ----------------------------------------------------
      if (CASC = '0') then
        if (((MDT0='1' and captureTrig0_Edge='1' and ENT0='1') or
           (MDT0='0' and generateOutPre0='1'))) then
          TCSR0_Set(T0INT_POS) <= '1';
        else
          TCSR0_Set(T0INT_POS) <= '0';
        end if;
      else
        if (((MDT0='1' and captureTrig0_Edge='1' and ENT0='1') or
           (MDT0='0' and generateOutPre1='1'))) then
          TCSR0_Set(T0INT_POS) <= '1';
        else
          TCSR0_Set(T0INT_POS) <= '0';
        end if;
      end if;

      TCSR0_CE(ENALL_POS) <= pair0_Select and BE(2);
      TCSR0_CE(ENT0_POS)  <= pair0_Select;

      TCSR0_In(ENT0_POS)  <= (Bus2ip_data(ENT0_POS) and Bus2ip_wrce(0) and BE(3)) or
                             (Bus2ip_data(ENALL_POS) and BE(2)) or
                             (TCSR0(ENT0_POS) and (not Bus2ip_wrce(0)));  

    end process TCSR0_PROCESS;

---------------------------------------------------
--Creating TCSR1 Register
---------------------------------------------------
    TCSR1_GENERATE: for i in ELEVEN_BIT_TYPE'range generate
      TCSR1_FF_I: component FDRSE
      port map (
        Q  => TCSR1(i),       -- [out]
        C  => Clk,            -- [in]
        CE => TCSR1_CE(i),    -- [in]
        D  => TCSR1_In(i),    -- [in]
        R  => TCSR1_Reset(i), -- [in]
        S  => TCSR1_Set(i)    -- [in]
      );
    end generate TCSR1_GENERATE;


------------------------------------------------------------------------------------
---Interrupt bit (23-bit) of TCSR1 register is cleared by writing 1 to Interrupt bit
------------------------------------------------------------------------------------
    TCSR1_Reset <= (others => '1') when Reset = RESET_ACTIVE else 
                   "00100000000" 
                   when Bus2ip_data(T1INT_POS)='1' and Bus2ip_wrce(4)='1' else
                   (others => '0') ; 
------------------------------------------------------------------------

----------------------------------------------------
--TCSR1 PROCESS:
--TO GENERATE CLOCK ENABLES, AND RESET
--OF TCSR1 REGISTER
----------------------------------------------------
    TCSR1_PROCESS: process (Bus2ip_data,Bus2ip_wrce,MDT1, 
                            captureTrig1_Edge,generateOutPre1,TCSR1,
                            pair0_Select,Reset,BE,ENT1,CASC,
                            MDT0,captureTrig0_Edge,ENT0) is
    begin
       TCSR1_Set   <= (others => '0');

      ---------------------------------------------
      --Generating clock enables for TCSR1 register
      ---------------------------------------------
      TCSR1_CE(31) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(30) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(29) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(28) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(27) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(26) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(25) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(24) <= Bus2ip_wrce(4) and BE(3);
      TCSR1_CE(23) <= Bus2ip_wrce(4) and BE(2);
      TCSR1_CE(22) <= Bus2ip_wrce(4) and BE(2);
      TCSR1_CE(21) <= Bus2ip_wrce(4) and BE(2);

      TCSR1_In    <= Bus2ip_data(21 to 31);
      TCSR1_In(T1INT_POS) <= TCSR1(T1INT_POS);

       ----------------------------------------------------------------
      ---interrupt bit of TCSR1 register is set to 1
      ----------------------------------------------------------------
      if (((MDT1='1' and captureTrig1_Edge='1' and ENT1='1') or
         (MDT1='0' and generateOutPre1='1')) and CASC='0') then
        TCSR1_Set(T1INT_POS) <= '1';
      else
        TCSR1_Set(T1INT_POS) <= '0';
      end if;

      TCSR1_CE(ENALL_POS) <= pair0_Select and BE(2);
      TCSR1_CE(ENT1_POS)  <= pair0_Select;

      TCSR1_In(ENT1_POS) <= (Bus2ip_data(ENT1_POS) and Bus2ip_wrce(4) and BE(3)) or
                            (Bus2ip_data(ENALL_POS) and BE(2)) or
                            (TCSR1(ENT1_POS) and (not Bus2ip_wrce(4)));
    end process TCSR1_PROCESS;

-------------------------------------------------------------------------------
-- Counter Controls
-------------------------------------------------------------------------------
    READ_DONE0_I: component FDRSE
      port map (
        Q  => read_done0,        -- [out]
        C  => Clk,               -- [in]
        CE => '1',               -- [in]
        D  => read_done0,        -- [in]
        R  => captureTrig0_Edge, -- [in]
        S  => tccr0_select       -- [in]
      );

    READ_DONE1_I: component FDRSE
      port map (
        Q  => read_done1,        -- [out]
        C  => Clk,               -- [in]
        CE => '1',               -- [in]
        D  => read_done1,        -- [in]
        R  => captureTrig1_Edge, -- [in]
        S  => tccr1_select       -- [in]
      );

INPUT_DOUBLE_REGS3 : entity lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => 4
    )
    port map (
        prmry_aclk                 => '0',
        prmry_resetn               => '0',
        prmry_in                   => Freeze,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => Clk,
        scndry_resetn              => '0',
        scndry_out                 => Freeze_int,
        scndry_vect_out            => open
    );


    -------------------------------------------------------
    ---Generating count enable and count down for counter 0
    -------------------------------------------------------
    Counter_En(0)    <= (not Freeze_int and ENT0 and (MDT0 or (not Counter_TC(0)
                        or (ARHT0 or PWMA0)))) when (CASC = '0') else
                        ((not Freeze_int) and ENT0 and (MDT0 or (not Counter_TC(1)) or ARHT0));
    Count_Down(0)    <= UDT0;
    -------------------------------------------------------

    -------------------------------------------------------
    ---Generating count enable and count down for counter 1
    -------------------------------------------------------
    Counter_En(1)    <= (not Freeze_int and ENT1 and (MDT1 or (not Counter_TC(1) 
                        or (ARHT1 or PWMB0)))) when (CASC = '0') else
                         ((not Freeze_int) and ENT0 and generateOutPre0 and (MDT0 or (not Counter_TC(1)) or ARHT0));
          
    Count_Down(1)    <= UDT1 when (CASC = '0') else
                        UDT0;
    -------------------------------------------------------

    -------------------------------------------------------
    ---Load counter0 and counter1 with TLR register value
    -------------------------------------------------------
    Load_Counter_Reg(0)  <=  ((Counter_TC(0) and (ARHT0 or PWMA0) and (not MDT0)) or LOAD0) when (CASC = '0') else
                             ((Counter_TC(1) and ARHT0 and (not MDT0)) or LOAD0) ;

    Load_Counter_Reg(1)  <=  ((Counter_TC(1) and ARHT1 and not PWMB0 and (not MDT1)) or
                              LOAD1 or (Counter_TC(0) and PWMB0)) when (CASC = '0') else
                             ((Counter_TC(1) and ARHT0 and (not MDT0)) or LOAD1) ;
    -------------------------------------------------------

    Load_Load_Reg(0) <=  (MDT0 and captureTrig0_Edge and ARHT0) or
                         (MDT0 and captureTrig0_Edge and not ARHT0 and read_done0);

    Load_Load_Reg(1) <=  ((MDT1 and captureTrig1_Edge and ARHT1) or
                          (MDT1 and captureTrig1_Edge and not ARHT1 and read_done1)) when (CASC = '0') else
                         ((MDT0 and captureTrig1_Edge and ARHT0) or
                          (MDT0 and captureTrig1_Edge and not ARHT0 and read_done1));
    -------------------------------------------------------

    Write_Load_Reg(0) <= Bus2ip_wrce(1);  
    Write_Load_Reg(1) <= Bus2ip_wrce(5);  
    CaptGen_Mux_Sel(0)<= Bus2ip_wrce(1);  
    CaptGen_Mux_Sel(1)<= Bus2ip_wrce(5);  

    tccr0_select <= (Bus2ip_wrce(1) or Bus2ip_rdce(1));
    tccr1_select <= (Bus2ip_wrce(5) or Bus2ip_rdce(5));

-------------------------------------------------------
---CAPTGEN_SYNC_PROCESS:
-- Process to register the signals
-------------------------------------------------------
INPUT_DOUBLE_REGS : entity lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => 4
    )
    port map (
        prmry_aclk                 => '0',
        prmry_resetn               => '0',
        prmry_in                   => CaptureTrig0,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => Clk,
        scndry_resetn              => '0',
        scndry_out                 => CaptureTrig0_int,
        scndry_vect_out            => open
    );


INPUT_DOUBLE_REGS2 : entity lib_cdc_v1_0_2.cdc_sync
    generic map (
        C_CDC_TYPE                 => 1,
        C_RESET_STATE              => 0,
        C_SINGLE_BIT               => 1,
        C_VECTOR_WIDTH             => 32,
        C_MTBF_STAGES              => 4
    )
    port map (
        prmry_aclk                 => '0',
        prmry_resetn               => '0',
        prmry_in                   => CaptureTrig1,
        prmry_vect_in              => (others => '0'),

        scndry_aclk                => Clk,
        scndry_resetn              => '0',
        scndry_out                 => CaptureTrig1_int,
        scndry_vect_out            => open
    );

    CAPTGEN_SYNC_PROCESS: process(Clk) is
    begin
      if Clk'event and Clk='1' then
        if Reset='1' then
          captureTrig0_d <= not C_TRIG0_ASSERT;
          captureTrig1_d <= not C_TRIG1_ASSERT;

          captureTrig0_d2 <= '0';
          captureTrig1_d2 <= '0';

          counter_TC_Reg(0) <= '0';
          counter_TC_Reg(1) <= '0';

          counter_TC_Reg2 <= '0';
         -- counter_TC_Reg2(1) <= '0';

          generateOutPre0 <= '0';
          generateOutPre1 <= '0';

          GenerateOut0 <= not C_GEN0_ASSERT;
          GenerateOut1 <= not C_GEN1_ASSERT;

          Interrupt <= '0';
        else
          captureTrig0_d <= (CaptureTrig0_int xor not(C_TRIG0_ASSERT)) and CAPT0;
          captureTrig1_d <= (CaptureTrig1_int xor not(C_TRIG1_ASSERT)) and CAPT1;

          captureTrig0_d2 <= captureTrig0_d;
          captureTrig1_d2 <= captureTrig1_d;

          counter_TC_Reg(0) <= Counter_TC(0);
          counter_TC_Reg(1) <= Counter_TC(1);

          counter_TC_Reg2 <= counter_TC_Reg(0);
         -- counter_TC_Reg2(1) <= counter_TC_Reg(1);

          generateOutPre0 <= Counter_TC(0) and (not counter_TC_Reg(0));
          generateOutPre1 <= Counter_TC(1) and (not counter_TC_Reg(1));

          GenerateOut0 <= ((((generateOutPre0 and CMPT0) xor not(C_GEN0_ASSERT)) and (not CASC)) or
                           (((generateOutPre1 and CMPT0) xor not(C_GEN0_ASSERT)) and CASC)); 

          GenerateOut1 <= ((((generateOutPre1 and CMPT1) xor not(C_GEN1_ASSERT)) and (not CASC)) or
                           (((generateOutPre0 and CMPT0) xor not(C_GEN0_ASSERT)) and CASC)); 

          Interrupt <= (ENIT0 and T0INT) or (ENIT1 and T1INT);
          -- for edge-sensitive interrupt
          --interrupt_reg<= (ENIT0 and T0INT) or (ENIT1 and T1INT);
          --Interrupt <= ((ENIT0 and T0INT) or (ENIT1 and T1INT))
          --                              and (not interrupt_reg);
        end if;
      end if;
    end process CAPTGEN_SYNC_PROCESS;

    captureTrig0_pulse <= captureTrig0_d and not captureTrig0_d2;
    captureTrig1_pulse <= captureTrig1_d and not captureTrig1_d2;

    captureTrig0_Edge  <= captureTrig0_pulse when (CASC = '0') else
                          (((not Counter_TC(0)) and (not counter_TC_Reg(0)) and captureTrig0_pulse) or
                           (captureTrig0_pulse_d2 and counter_TC_Reg2) or
                           (captureTrig0_pulse_d1 and counter_TC_Reg2));

    captureTrig1_Edge  <= captureTrig1_pulse when (CASC = '0') else
                          captureTrig0_Edge;

    DELAY_CAPT_TRIG_PROCESS: process(Clk) is
    begin
      if Clk'event and Clk='1' then
        if Reset='1' then
          captureTrig0_pulse_d1 <= '0';
          captureTrig0_pulse_d2 <= '0';
        else
          captureTrig0_pulse_d1 <= captureTrig0_pulse;
          captureTrig0_pulse_d2 <= captureTrig0_pulse_d1;
        end if;
      end if;
    end process DELAY_CAPT_TRIG_PROCESS;

    TCSR0_Reg <= TCSR0;
    TCSR1_Reg <= TCSR1;

end architecture imp;
