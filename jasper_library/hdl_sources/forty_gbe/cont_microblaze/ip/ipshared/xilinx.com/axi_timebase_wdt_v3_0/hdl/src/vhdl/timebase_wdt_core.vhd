-------------------------------------------------------------------------------
-- timebase_wdt_core.vhd - entity/architecture pair
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
-- Filename:        timebase_wdt_core.vhd
-- Version:         v2.0
-- Description:     32-bit timebase counter and Watch Dog Timer (WDT)
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--                  timebase_wdt_core.vhd
--
-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         03/18/2010      -- Ceated the version  v1.00.a
-- ^^^^^^
-- ^^^^^^
-- Author:      BSB
-- History:
--  BSB         09/18/2010      -- Ceated the version  v1.01.a
--                              -- Updated with axi lite ipuif v1.01.a
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
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.conv_std_logic_vector;
use IEEE.std_logic_arith.all;

library lib_cdc_v1_0_2;
-------------------------------------------------------------------------------
--                     Definition of Generics
-------------------------------------------------------------------------------
-- WDT generics
--  C_WDT_INTERVAL        -- Watchdog Timer Interval = 2**C_WDT_INTERVAL clocks
--                           Defaults to 2**31 clock cycles 
--                           (** is exponentiation)
--  C_WDT_ENABLE_ONCE     -- WDT enable behavior. If TRUE (1),once the WDT has 
--                           been enabled, it can only be disabled by RESET.
--                           Defaults to FALSE;
--
-- AXI Slave Lite block generics
--  C_FAMILY              -- FPGA Family for which the serial 
--  C_NATIVE_DWIDTH       -- Width of the slave data bus
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------
-- SYSTEM SIGNALS
--  Clk                   -- Clock
--  Reset                 -- Reset Signal
--
-- Freeze                 -- Freeze count value
-- WDT INTERFACE
--  WDT_Reset             -- Output. Watchdog Timer Reset
--  Timebase_Interrupt    -- Output. Timebase Interrupt
--  WDT_Interrupt         -- Output. Watchdog Timer Interrupt
--                      
--  Bus2IP_Data           -- Input. Bus to IP Data Signal
--  Bus2IP_RdCE           -- Input. Bus to IP Read Enable
--  Bus2IP_WrCE           -- Input. Bus to IP Write Enable
--  IP2Bus_Data           -- Output. IP to Bus Data Signal
--  IP2Bus_WrAck          -- Output. IP to Bus Write Acknowledgement Signal
--  IP2Bus_RdAck          -- Output. IP to Bus Read Acknowledgement Signal
--
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Entity section
-------------------------------------------------------------------------------

entity timebase_wdt_core is
 generic 
  (
    C_FAMILY              : string                 := "virtex5";
    C_WDT_INTERVAL        : integer range 8 to 31  := 30;
    C_WDT_ENABLE_ONCE     : boolean                := TRUE;
    C_NATIVE_DWIDTH       : integer range 32 to 32 := 32
  );  
 port 
  (
  -- System signals
    Clk                   : in  std_logic;
    Reset                 : in  std_logic;
    Freeze                : in   std_logic;
  -- IPIC interface signals
    Bus2IP_Data           : in  std_logic_vector
                                (0 to C_NATIVE_DWIDTH - 1 );
    Bus2IP_RdCE           : in  std_logic_vector(0 to 3);
    Bus2IP_WrCE           : in  std_logic_vector(0 to 3);
    IP2Bus_Data           : out std_logic_vector
                                (0 to C_NATIVE_DWIDTH - 1 );
    IP2Bus_WrAck          : out std_logic;
    IP2Bus_RdAck          : out std_logic;
  -- WDT signals          
    WDT_Reset             : out std_logic;
    Timebase_Interrupt    : out std_logic;
    WDT_Interrupt         : out std_logic
  );
end entity timebase_wdt_core;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture imp of timebase_wdt_core is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";
    
-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------

-- These constants are indices into the Control/Status Register.
constant WRS                 : integer := 28;
constant WDS                 : integer := 29;
constant EWDT1               : integer := 30;
constant EWDT2               : integer := 31;

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------

-- Slave interface signals
signal sl_DBus_In            : std_logic_vector
                                 (0 to C_NATIVE_DWIDTH - 1 );                                 
-- Accessible register signals
signal eWDT1_Reg               : std_logic;
signal eWDT2_Reg               : std_logic;
signal wdt_State_Reg           : std_logic;  
signal wdt_Reset_Status_Reg    : std_logic := '0';
signal timebase_Count_Reg      : std_logic_vector(0 to 31);
signal read_Mux_In             : std_logic_vector(0 to 7);

-- Other signals
signal iTimebase_count         : unsigned(31 downto 0);
signal iTimebase_count_in      : unsigned(31 downto 0) := (others => '0');
signal wdt_Bit                 : std_logic;
signal wdt_State_Preset        : std_logic;
signal wdt_State_Reg_In        : std_logic;
signal wdt_Reset_Status_In     : std_logic;
signal iWDT_Reset              : std_logic;
signal wdt_State_Reg_Rst       : std_logic;
signal wdt_State_Reg_Set       : std_logic;
signal eWDT1_Reg_In            : std_logic;
signal eWDT2_Reg_In            : std_logic;
signal enable_Once             : std_logic;
signal timebase_Reg_Reset      : std_logic;
signal count_MSB_Reg           : std_logic;
signal wdt_Bit1                : std_logic;
signal wdt_Bitin_1,wdt_Bitin_1d: std_logic;
signal temp_i                  : std_logic_vector(0 to 1);
signal Freeze_int : std_logic := '0';
-- WDT state machine states
type WDT_FSM is (ResetState, ExpiredOnceDelayed, ExpiredOnce, ExpiredTwice);

signal WDT_Current_State,WDT_Next_State : WDT_FSM;

type WDT_INTR_FSM0 is (S0, S1);

signal Current_State,Next_State : WDT_INTR_FSM0;

-------------------------------------------------------------------------------
-- Architecture Starts
-------------------------------------------------------------------------------

begin  -- VHDL_RTL

-------------------------------------------------------------------------------
-- Generating the acknowledgement signals
-------------------------------------------------------------------------------

-- TWCSR0 or TBR / Invalid Read from TWCSR1
IP2Bus_RdAck <= bus2ip_rdce(0) or bus2ip_rdce(1) or bus2ip_rdce(2);
-- TWCSR0 or TWCSR1 / Invalid Write to TBR
IP2Bus_WrAck <= bus2ip_wrce(0) or bus2ip_wrce(1) or bus2ip_wrce(2); 

-------------------------------------------------------------------------------
-- IP2Bus Interface combinatorial assignment
-------------------------------------------------------------------------------

ip2bus_data    <= sl_DBus_In;
    
-------------------------------------------------------------------------------
-- Read Mux combinatorial assignments
-------------------------------------------------------------------------------

read_Mux_In         <= wdt_Reset_Status_Reg & wdt_State_Reg & eWDT1_Reg 
                       & eWDT2_Reg & timebase_Count_Reg(28 to 31); -- BETAG
                         
with bus2ip_rdce(0 to 2) select
sl_DBus_In(0 to 31) <= timebase_Count_Reg(0 to 27) & read_Mux_In(0 to 3) when "100", -- TWCSR0 reg 
                       timebase_Count_Reg(0 to 27) & read_Mux_In(4 to 7) when "001", -- TBR reg
                       (others=>'0') when others;

-------------------------------------------------------------------------------
-- Generating combinatorial timebase_Reg_Reset signal
-------------------------------------------------------------------------------

timebase_Reg_Reset <= Reset or (Bus2IP_WrCE(0) and not eWDT1_Reg and 
                      not eWDT2_Reg and Bus2IP_Data(EWDT1)) or 
                      (Bus2IP_WrCE(1) and not eWDT1_Reg and 
                      not eWDT2_Reg and Bus2IP_Data(EWDT2));

-------------------------------------------------------------------------------
-- NAME: TIMEBASE_REGS_I
-------------------------------------------------------------------------------
-- Description: Registering timebase counter value. If the Freeze = 1 the 
-- counter will be stalled.
-------------------------------------------------------------------------------

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



TIMEBASE_REGS_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (timebase_Reg_Reset = '1') then
           iTimebase_count <=  (others => '0');
       elsif Freeze_int = '1' then
           iTimebase_count <= iTimebase_count;
       else
           iTimebase_count <= iTimebase_count_in;
       end if;
   end if;
end process TIMEBASE_REGS_I;

-------------------------------------------------------------------------------
-- NAME: TIMEBASE_PROCESS
-------------------------------------------------------------------------------
-- Description: The process implements a 32 bit up counter
-------------------------------------------------------------------------------
   
TIMEBASE_PROCESS: process (iTimebase_count) is
begin
   iTimebase_count_in <= iTimebase_count + 1;
end process TIMEBASE_PROCESS;
-------------------------------------------------------------------------------
temp_i  <= iTimebase_count(C_WDT_INTERVAL) & iTimebase_count(C_WDT_INTERVAL-1);


WDT_STATE_MACHINE_COMB1: process (Current_State,temp_i,iWDT_Reset,Reset) is
begin
   wdt_Bitin_1<= '0';
   Next_State <= Current_State;
   case Current_State is
       when S0 => 
           if temp_i = "10" then
              wdt_Bitin_1 <= '1';
              Next_State  <= S1;
           end if;
       when S1 =>
           if temp_i = "00" then
             wdt_Bitin_1 <= '1';
             Next_State  <= S0;
           end if;
   end case;
end process WDT_STATE_MACHINE_COMB1;

WDT_STATE_MACHINE_SEQ1: process (Clk) is 
begin
   if Clk'event and Clk='1' then
       if Reset='1' or timebase_Reg_Reset  = '1' or iWDT_Reset = '1' then 
           Current_State <= S0;
       else
           Current_State <= Next_State;
       end if;
   end if;
end process WDT_STATE_MACHINE_SEQ1;

wdt_Bit <= ((wdt_Bitin_1 and not wdt_Bitin_1d))and (eWDT1_Reg or eWDT2_Reg);

wdt_Bit1 <= wdt_State_Reg;

-------------------------------------------------------------------------------
-- NAME: WDT_STATE_MACHINE_COMB
-------------------------------------------------------------------------------
-- Description: The combinatorial part of Watchdog Timer state machine
-------------------------------------------------------------------------------

WDT_STATE_MACHINE_COMB: process (WDT_Current_State,wdt_Bit,wdt_State_Reg) is
begin
   iWDT_Reset <= '0';
   WDT_Next_State <= WDT_Current_State;
   case WDT_Current_State is
       when ResetState => 
           if wdt_Bit='1' then 
             WDT_Next_State <= ExpiredOnce;
           end if;
       when ExpiredOnce =>
           WDT_Next_State <= ExpiredOnceDelayed;
       when ExpiredOnceDelayed => 
           if wdt_State_Reg='0' then 
             WDT_Next_State <= ResetState;
           end if;
           if wdt_Bit='1' and wdt_State_Reg='1' then 
             WDT_Next_State <= ExpiredTwice;
           end if;
       when ExpiredTwice =>
           iWDT_Reset <= '1';
   end case;
end process WDT_STATE_MACHINE_COMB;

-------------------------------------------------------------------------------
-- NAME: WDT_STATE_MACHINE_SEQ
-------------------------------------------------------------------------------
-- Description: The sequential part of Watchdog Timer state machine
-------------------------------------------------------------------------------
    
WDT_DELAY_PROCESS: process (Clk) is 
begin
   if Clk'event and Clk='1' then
       if Reset='1' or wdt_State_Reg_Rst = '1' or iWDT_Reset ='1'  then 
           wdt_Bitin_1d <= '1';
       else
           wdt_Bitin_1d <= wdt_Bitin_1;
       end if;
   end if;
end process WDT_DELAY_PROCESS;

-------------------------------------------------------------------------------
-- NAME: WDT_STATE_MACHINE_SEQ
-------------------------------------------------------------------------------
-- Description: The sequential part of Watchdog Timer state machine
-------------------------------------------------------------------------------
    
WDT_STATE_MACHINE_SEQ: process (Clk) is 
begin
   if Clk'event and Clk='1' then
       if Reset='1' then 
           WDT_Current_State <= ResetState;
       else
           WDT_Current_State <= WDT_Next_State;
       end if;
   end if;
end process WDT_STATE_MACHINE_SEQ;

-------------------------------------------------------------------------------
-- combinatorial assignments of register bits
-------------------------------------------------------------------------------

wdt_State_Reg_Rst <= Reset or wdt_State_Reg_In;
wdt_State_Reg_Set <= wdt_Bit and not wdt_State_Preset;

--wdt_State_Reg  <= wdt_State_Reg_Set;
-------------------------------------------------------------------------------
-- NAME: WDT_STATE_I
-------------------------------------------------------------------------------
-- Description: Generating wdt_State_Reg signal 
-------------------------------------------------------------------------------

WDT_STATE_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (wdt_State_Reg_Rst = '1') then
           wdt_State_Reg <=  '0';
       elsif (wdt_State_Reg_Set = '1') then
           wdt_State_Reg <= '1';              
       end if;
   end if;
end process WDT_STATE_I;

-------------------------------------------------------------------------------
-- NAME: WDT_STATE_PRESET_I
-------------------------------------------------------------------------------
-- Description: Generating wdt_State_Preset signal 
-------------------------------------------------------------------------------

WDT_STATE_PRESET_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (Reset = '1') then
           wdt_State_Preset <=  '0';
       else
           wdt_State_Preset <= wdt_Bit;
       end if;
   end if;
end process WDT_STATE_PRESET_I;

-------------------------------------------------------------------------------
-- NAME: WDT_RESET_STATUS_I
-------------------------------------------------------------------------------
-- Description: Generating wdt_Reset_Status_Reg signal 
-------------------------------------------------------------------------------

WDT_RESET_STATUS_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (wdt_Reset_Status_In = '1') then
           wdt_Reset_Status_Reg <=  '0';
       elsif (iWDT_Reset = '1') then
           wdt_Reset_Status_Reg <= '1';              
       end if;
   end if;
end process WDT_RESET_STATUS_I;   

-------------------------------------------------------------------------------
-- combinatorial assignments
-------------------------------------------------------------------------------

enable_Once  <= '1' when C_WDT_ENABLE_ONCE else '0';
eWDT1_Reg_In <= (enable_Once and eWDT1_Reg) or Bus2IP_Data(EWDT1);
eWDT2_Reg_In <= (enable_Once and eWDT2_Reg) or Bus2IP_Data(EWDT2);

-------------------------------------------------------------------------------
-- NAME: EWDT1_I
-------------------------------------------------------------------------------
-- Description: The process registers eWDT1_Reg signal 
-------------------------------------------------------------------------------

EWDT1_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (Reset = '1') then
           eWDT1_Reg <=  '0';
       elsif (Bus2IP_WrCE(0) = '1') then
           eWDT1_Reg <= eWDT1_Reg_In;
       end if;
   end if;
end process EWDT1_I;

-------------------------------------------------------------------------------
-- NAME: EWDT2_I
-------------------------------------------------------------------------------
-- Description: The process registers eWDT2_Reg signal 
-------------------------------------------------------------------------------

EWDT2_I: Process (Clk)
begin
   if (Clk'event and Clk = '1') then
       if (Reset = '1') then
           eWDT2_Reg <=  '0';
       elsif (Bus2IP_WrCE(1) = '1') then
           eWDT2_Reg <= eWDT2_Reg_In;
       end if;
   end if;
end process EWDT2_I;

-------------------------------------------------------------------------------
-- combinatorial assignments
-------------------------------------------------------------------------------

wdt_State_Reg_In     <= Bus2IP_Data(WDS) and Bus2IP_WrCE(0);
wdt_Reset_Status_In  <= Bus2IP_Data(WRS) and Bus2IP_WrCE(0); 
timebase_Count_Reg   <= conv_std_logic_vector(iTimebase_count,32);
WDT_Interrupt        <= wdt_Bit1;

-------------------------------------------------------------------------------
-- NAME: TB_INTERRUPT_PROCESS
-------------------------------------------------------------------------------
-- Description: Process to generate Timebase_Interrupt signal
-------------------------------------------------------------------------------

TB_INTERRUPT_PROCESS: process(Clk) is
begin
   if (Clk'event and Clk='1') then
       if Reset='1' then 
           count_MSB_Reg <= '0';
           Timebase_Interrupt <= '0';
       else
           count_MSB_Reg <= timebase_Count_Reg(0);
           Timebase_Interrupt <= count_MSB_Reg and not timebase_Count_Reg(0);
       end if;
       WDT_Reset    <= iWDT_Reset; 
   end if;
end process TB_INTERRUPT_PROCESS;

end imp;
