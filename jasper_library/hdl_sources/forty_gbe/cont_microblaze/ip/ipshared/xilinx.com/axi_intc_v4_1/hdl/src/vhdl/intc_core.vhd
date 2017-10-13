-------------------------------------------------------------------
-- (c) Copyright 1984 - 2014 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-------------------------------------------------------------------

-- ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        intc_core.vhd
-- Version:         v3.1
-- Description:     Interrupt controller without a bus interface
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--           -- axi_intc.vhd  (wrapper for top level)
--               -- axi_lite_ipif.vhd
--               -- intc_core.vhd
--
-------------------------------------------------------------------------------
-- Author:      PB
-- History:
--  PB     07/29/09
--  ^^^^^^^
--  - Initial release of v1.00.a
--  PB     03/26/10
--
--  - updated based on the xps_intc_v2_01_a
-- ~~~~~~
--  - Initial release of v2.00.a
--  - Updated by pkaruna

--  ^^^^^^^
--  SK     10/10/12
--
--  1. Added cascade mode support in v1.03.a version of the core
-- 2.  Updated major version of the core
-- ~~~~~~
-- ~~~~~~
--  SK       12/16/12      -- v3.0
--  1. up reved to major version for 2013.1 Vivado release. No logic updates.
--  2. Updated the version of AXI LITE IPIF to v2.0 in X.Y format
--  3. updated the proc common version to v4_0
--  4. No Logic Updates
-- ^^^^^^
-- ^^^^^^^
--  SA     03/25/13
--
--  1. Added software interrupt support in v3.1 version of the core
-- ~~~~~~
--  SA     09/05/13
--
--  1. Added support for nested interrupts using ILR register in v4.1
-- ~~~~~~
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;
use ieee.std_logic_misc.all;

library axi_intc_v4_1_7;
use axi_intc_v4_1_7.all;

-------------------------------------------------------------------------------
-- Definition of Generics:
--  -- Intc Parameters
--       C_DWIDTH              -- Data bus width
--       C_NUM_INTR_INPUTS     -- Number of interrupt inputs
--       C_NUM_SW_INTR         -- Number of software interrupts
--       C_KIND_OF_INTR        -- Kind of interrupt (0-Level/1-Edge)
--       C_KIND_OF_EDGE        -- Kind of edge (0-falling/1-rising)
--       C_KIND_OF_LVL         -- Kind of level (0-low/1-high)
--       C_ASYNC_INTR          -- Interrupt is asynchronous (0-sync/1-async)
--       C_NUM_SYNC_FF         -- Number of synchronization flip-flops for async interrupts
--       C_HAS_IPR             -- Set to 1 if has Interrupt Pending Register
--       C_HAS_SIE             -- Set to 1 if has Set Interrupt Enable Bits
--                                Register
--       C_HAS_CIE             -- Set to 1 if has Clear Interrupt Enable Bits
--                                Register
--       C_HAS_IVR             -- Set to 1 if has Interrupt Vector Register
--       C_HAS_ILR             -- Set to 1 if has Interrupt Level Register for nested interupt support
--       C_IRQ_IS_LEVEL        -- If set to 0 generates edge interrupt
--                             -- If set to 1 generates level interrupt
--       C_IRQ_ACTIVE          -- Defines the edge for output interrupt if
--                             -- C_IRQ_IS_LEVEL=0 (0-FALLING/1-RISING)
--                             -- Defines the level for output interrupt if
--                             -- C_IRQ_IS_LEVEL=1 (0-LOW/1-HIGH)
--   C_IVR_RESET_VALUE         -- Reset value for the vectroed interrupt registers in RAM
--   C_DISABLE_SYNCHRONIZERS   -- If the processor clock and axi clock are of same
--                                value then user can decide to disable this
--   C_MB_CLK_NOT_CONNECTED    -- If the processor clock is not connected or used in design
--   C_HAS_FAST                -- If user wants to choose the fast interrupt mode of the core
--                             -- then it is needed to have this paraemter set. Default is Standard Mode interrupt
--   C_ENABLE_ASYNC            -- This parameter is used only for Vivado standalone mode of the core, not used in RTL
--   C_EN_CASCADE_MODE         -- If no. of interrupts goes beyond 32, then this parameter need to set
--   C_CASCADE_MASTER          -- If cascade mode is set, then this parameter should be set to the first instance
--                             -- of the core which is connected to the processor
-------------------------------------------------------------------------------
-- Definition of Ports:
--  Clocks and reset
--   Clk                 -- Clock
--   Rst                 -- Reset
--  Intc Interface Signals
--   Intr                -- Input Interruput request
--   Reg_addr            -- Address bus
--   Bus2ip_rdce         -- Read
--   Bus2ip_wrce         -- Write
--   Wr_data             -- Write data bus
--   Rd_data             -- Read data bus
--   Irq                 -- Output Interruput request
--  Processor_clk        -- input same as processor clock
--  Processor_rst        -- input same as processor reset
--  Processor_ack        -- input Connected to processor ACK
--  Interrupt_address    -- output Connected to processor interrupt address pins
--  Interrupt_address_in -- Input this is coming from lower level module in case
--                       -- the cascade mode is set and all AXI INTC instances are marked
--                       -- as C_HAS_FAST = 1
--  Processor_ack_out    -- Output this is going to lower level module in case
--                       -- the cascade mode is set and all AXI INTC instances are marked
--                       -- as C_HAS_FAST = 1
-------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Entity
------------------------------------------------------------------------------
entity intc_core is
    generic
    (
      C_FAMILY                : string  := "virtex6";
      C_DWIDTH                : integer := 32;
      C_NUM_INTR_INPUTS       : integer range 1 to 32 := 2;
      C_NUM_SW_INTR           : integer range 0 to 31 := 0;
      C_KIND_OF_INTR          : std_logic_vector(31 downto 0)
                                := "11111111111111111111111111111111";
      C_KIND_OF_EDGE          : std_logic_vector(31 downto 0)
                                := "11111111111111111111111111111111";
      C_KIND_OF_LVL           : std_logic_vector(31 downto 0)
                                := "11111111111111111111111111111111";
      C_ASYNC_INTR            : std_logic_vector(31 downto 0) :=
                                   "11111111111111111111111111111111";
      C_NUM_SYNC_FF           : integer range 0 to 7 := 2;
      C_HAS_IPR               : integer range 0 to 1 := 1;
      C_HAS_SIE               : integer range 0 to 1 := 1;
      C_HAS_CIE               : integer range 0 to 1 := 1;
      C_HAS_IVR               : integer range 0 to 1 := 1;
      C_HAS_ILR               : integer range 0 to 1 := 0;
      C_IRQ_IS_LEVEL          : integer range 0 to 1 := 1;
      C_IRQ_ACTIVE            : std_logic := '1';
      C_DISABLE_SYNCHRONIZERS : integer range 0 to 1 := 0;
      C_MB_CLK_NOT_CONNECTED  : integer range 0 to 1 := 0;
      C_HAS_FAST              : integer range 0 to 1 := 0;
      C_IVAR_RESET_VALUE      : std_logic_vector(31 downto 0) :=
                                      "00000000000000000000000000010000";
      C_EN_CASCADE_MODE       : integer range 0 to 1 := 0; -- default no cascade mode, if set enable cascade mode
      C_CASCADE_MASTER        : integer range 0 to 1 := 0  -- default slave, if set become cascade master and connects ports to Processor

   );
    port
    (
      -- Inputs
      Clk               : in  std_logic;                      --- AXI Clock
      Rst_n             : in  std_logic;                      --- active low AXI Reset
      Intr              : in  std_logic_vector(C_NUM_INTR_INPUTS - 1 downto 0);
      Reg_addr          : in  std_logic_vector(6 downto 0);
      Bus2ip_rdce       : in  std_logic_vector(0 to 16);
      Bus2ip_wrce       : in  std_logic_vector(0 to 16);
      Wr_data           : in  std_logic_vector(C_DWIDTH - 1 downto 0);
      -- Outputs
      Rd_data           : out std_logic_vector(C_DWIDTH - 1 downto 0);
      Processor_clk     : in  std_logic;                      --- MB Clk, clock from MicroBlaze
      processor_rst     : in  std_logic;                      --- active high MB rst, reset from MicroBlaze
      Irq               : out std_logic;
      Processor_ack     : in  std_logic_vector(1 downto 0);   --- added for fast interrupt mode
      Interrupt_address : out std_logic_vector(31 downto 0);  --- added for fast interrupt mode
      --
      Interrupt_address_in : in std_logic_vector(31 downto 0);
      Processor_ack_out    : out std_logic_vector(1 downto 0)
      --
  );

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

attribute buffer_type: string;
attribute buffer_type of Intr: signal is "none";

end intc_core;

------------------------------------------------------------------------------
-- Architecture
------------------------------------------------------------------------------
architecture imp of intc_core is

    -- Component Declarations
    -- ======================
    constant C_NUM_INTR     : integer := C_NUM_INTR_INPUTS + C_NUM_SW_INTR;

    constant RESET_ACTIVE   : std_logic   := '0';

    CONSTANT INDEX_BIT      : INTEGER := INTEGER(CEIL(LOG2(REAL(C_NUM_INTR+1))));

    constant MICROBLAZE_FIXED_ADDRESS   : std_logic_vector   := X"00000010";

    CONSTANT IVR_ALL_ONES   : std_logic_vector(INDEX_BIT-1 downto 0) := (others => '1');

    --- *** --- Decision is pending for logic used - mail sent to Bsb on 3rd Oct, 2012
    CONSTANT C_USE_METHOD : integer := 1;
    --- *** ---
    -- Signal declaration
    -- ==================
    signal processor_rst_n         : std_logic;

    signal ack_b01                 : std_logic;
    signal first_ack               : std_logic;
    signal first_ack_active        : std_logic;
    signal second_ack              : std_logic;
    signal first_ack_sync          : std_logic;
    signal second_ack_sync         : std_logic;
    signal second_ack_sync_d1      : std_logic;
    signal second_ack_sync_d2      : std_logic;
    signal second_ack_sync_d3      : std_logic;
    signal second_ack_sync_mb_clk  : std_logic;

    signal Irq_i                   : std_logic;

    signal ivr_data_in      : std_logic_vector(INDEX_BIT - 1 downto 0);

    signal wr_data_int      : std_logic_vector(C_NUM_INTR - 1 downto 0);
    signal mer_int          : std_logic_vector(1 downto 0);
    signal mer              : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal sie              : std_logic_vector(C_NUM_INTR - 1 downto 0);
    signal cie              : std_logic_vector(C_NUM_INTR - 1 downto 0);
    signal iar              : std_logic_vector(C_NUM_INTR - 1 downto 0);
    signal ier              : std_logic_vector(C_NUM_INTR - 1 downto 0);
    signal isr_en           : std_logic;
    signal hw_intr          : std_logic_vector(C_NUM_INTR_INPUTS - 1 downto 0);
    signal isr_data_in      : std_logic_vector(C_NUM_INTR_INPUTS - 1 downto 0);
    signal isr              : std_logic_vector(C_NUM_INTR - 1 downto 0);
    signal ivr              : std_logic_vector(INDEX_BIT - 1 downto 0);
    signal ivr_out          : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal ilr              : std_logic_vector(INDEX_BIT downto 0);
    signal ilr_out          : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal imr              : std_logic_vector(C_NUM_INTR - 1 downto 0);
    signal imr_out          : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal ipr              : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal irq_gen_i        : std_logic;
    signal irq_gen          : std_logic;
    signal irq_gen_sync     : std_logic;
    signal read             : std_logic;
    signal ier_out          : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal isr_out          : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal ack_or_i         : std_logic;
    signal ack_or           : std_logic;
    signal ack_or_sync      : std_logic;
    signal read_ivar        : std_logic;
    signal write_ivar       : std_logic;
    signal isr_or           : std_logic;

    signal ivar_index_mb_clk         : std_logic_vector(INDEX_BIT-1 downto 0);
    signal ivar_index_axi_clk        : std_logic_vector(INDEX_BIT-1 downto 0);

    signal in_idle                      : std_logic;
    signal in_idle_axi_clk              : std_logic;
    signal idle_and_irq                 : std_logic;
    signal idle_and_irq_d1              : std_logic;
    signal ivar_index_sample_en_i       : std_logic;
    signal ivar_index_sample_en         : std_logic;
    signal ivar_index_sample_en_mb_clk  : std_logic;
    signal irq_dis_sample_mb_clk        : std_logic;

    signal ivar_rd_addr_mb_clk       : std_logic_vector(4 downto 0);

    signal mer_0_sync       : std_logic;
    --signal bus2ip_rdce_fast : std_logic_vector(0 to 31);
    --signal bus2ip_wrce_fast : std_logic_vector(0 to 31);
    signal bus2ip_rdce_fast : std_logic;
    signal bus2ip_wrce_fast : std_logic;

    signal ivar_rd_data_axi_clk : std_logic_vector(C_DWIDTH - 1 downto 0);
    signal ivar_rd_data_mb_clk  : std_logic_vector(C_DWIDTH - 1 downto 0);

    signal isr_ored_30_0_bits : std_logic;
    signal Interrupt_address_in_reg_int : std_logic_vector(31 downto 0);

    signal intr_31_deassert_info : std_logic;
    signal intr_31_deasserted_d1      : std_logic;
    signal intr_31_deasserted         : std_logic;

    -- --------------------------------------------------------------------------------------
    -- -- Function to find logic OR of 32 bit width vector
    -- --------------------------------------------------------------------------------------
    -- Function OR32_VEC2STDLOGIC (vec_in : std_logic_vector) return std_logic is
    -- variable or_out                : std_logic := '0';
    -- begin
    --     for i in 0 to 31 loop
    --         or_out := vec_in(i) or or_out;
    --     end loop;
    -- return or_out;
    -- end function Or32_vec2stdlogic;
    -- --------------------------------------------------------------------------------------

    FUNCTION calc_ivar_ram_addr_bits (
       constant C_NUM_INTR : integer)
       RETURN integer is
    begin
       if (C_NUM_INTR > 16) then
          RETURN 5;
       else
          RETURN 4;
       end if;
    end FUNCTION calc_ivar_ram_addr_bits;
    -------------------------------------
    FUNCTION calc_ivar_ram_depth (
       constant C_NUM_INTR : integer)
       RETURN integer is
    begin
       if (C_NUM_INTR > 16) then
          RETURN 32;
       else
          RETURN 16;
       end if;
    end FUNCTION calc_ivar_ram_depth;
    ---------------------------------
    CONSTANT IVAR_MEM_ADDR_LINES  : INTEGER := calc_ivar_ram_addr_bits (C_NUM_INTR);
    CONSTANT IVAR_MEM_DEPTH       : INTEGER := calc_ivar_ram_depth (C_NUM_INTR);

  --------------------------------------------------------------------------------------
  -- Function to convert std_logic to std_logic_vector
  --------------------------------------------------------------------------------------
  Function scalar_to_vector (scalar_in : std_logic) return std_logic_vector is
  variable vec_out                : std_logic_vector(0 downto 0) := "0";
  begin
      vec_out(0) := scalar_in;
  return vec_out;
  end function scalar_to_vector;

-- Begin of architecture
begin
-----
    -- active low reset
    processor_rst_n <= not Processor_rst;

    read        <= bus2ip_rdce(0) or -- for ISR
                   bus2ip_rdce(1) or -- for IPR
                   bus2ip_rdce(2) or -- for IER
                   bus2ip_rdce(6) or -- for IVR
                   bus2ip_rdce(7) or -- for MER
                   bus2ip_rdce(8) or -- for IMR
                   bus2ip_rdce(9);   -- for ILR
    --------------------------------------------------------------------------
    --                      GENERATING ALL REGISTERS
    --------------------------------------------------------------------------
    wr_data_int <= Wr_data(C_NUM_INTR - 1 downto 0);

    -------------------------------------------------------------------------
    -- GENERATING IVAR READ ENABLES
    -------------------------------------------------------------------------

    bus2ip_rdce_fast <= bus2ip_rdce(16);
    bus2ip_wrce_fast <= bus2ip_wrce(16);
    write_ivar       <= bus2ip_wrce_fast;
    read_ivar        <= bus2ip_rdce_fast;


--------------------------------------------------------------------------
-- Process for generating ACK enable and type and syncing them to ACLK
--------------------------------------------------------------------------
ACK_EN_SYNC_ON_MB_CLK_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
--------------------------
    NO_CASCADE_MASTER_MODE : if (C_EN_CASCADE_MODE = 0) and (C_CASCADE_MASTER = 0) generate
    -----
    begin
    -----
          -- dont bypass the processor ack to output
          Processor_ack_out <= (others => '0');
          -----------------------------------------
          Processor_ack_EN_REG_P: process (Processor_ack) is
          -----
          begin
          -----
              ack_b01 <= (not Processor_ack(1)) and Processor_ack(0); -- ack = b01
          end process Processor_ack_EN_REG_P;
          -----------------------------------------
          first_ack_active_REG_P: process (Processor_clk) is
          -----
          begin
          -----
              if (Processor_clk'event and Processor_clk = '1') then
                  if (processor_rst_n = RESET_ACTIVE) then
                      first_ack_active <= '0';
                  else
                      if (ack_b01 = '1') then
                         first_ack_active <= '1';
                      elsif (Processor_ack(1) = '1') then
                         first_ack_active <= '0';
                      else
                         first_ack_active <= first_ack_active;
                      end if;
                  end if;
              end if;
          end process first_ack_active_REG_P;
          -----------------------------------------
          first_second_ack_REG_P: process (Processor_clk) is
          -----
          begin
          -----
              if (Processor_clk'event and Processor_clk = '1') then
                  if (processor_rst_n = RESET_ACTIVE) then
                      first_ack  <= '0';
                      second_ack <= '0';
                  else
                      first_ack  <= ack_b01;
                      second_ack <= first_ack_active and Processor_ack(1);
                  end if;
              end if;
          end process first_second_ack_REG_P;
          -----------------------------------------
          ACK_EN_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                  --Synchronize first_ack to AXI clock domain
                  Processor_first_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                  port map (
                      CLK_1             => Processor_clk,
                      RESET_1_n         => processor_rst_n,
                      DATA_IN           => first_ack,
                      CLK_2             => Clk,
                      RESET_2_n         => Rst_n,
                      SYNC_DATA_OUT     => first_ack_sync
                     );
                  --------------------------------------------
                  --Synchronize second_ack to AXI clock domain
                  Processor_second_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                  port map (
                      CLK_1             => Processor_clk,
                      RESET_1_n         => processor_rst_n,
                      DATA_IN           => second_ack,
                      CLK_2             => Clk,
                      RESET_2_n         => Rst_n,
                      SYNC_DATA_OUT     => second_ack_sync
                     );

          end generate ACK_EN_SYNC_EN_GEN;
          -----------------------------------------
          ACK_EN_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
                 first_ack_sync  <= first_ack;
                 second_ack_sync <= second_ack;
          end generate ACK_EN_SYNC_DISABLE_GEN;
          -----------------------------------------
          second_ack_d2_reg_p: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      second_ack_sync_d1  <= '0';
                      second_ack_sync_d2  <= '0';
                      second_ack_sync_d3  <= '0';
                  else
                      second_ack_sync_d1  <= second_ack_sync;
                      second_ack_sync_d2  <= second_ack_sync_d1;
                      second_ack_sync_d3  <= second_ack_sync_d2;
                  end if;
              end if;
          end process second_ack_d2_reg_p;
          -----------------------------------------
          SECOND_ACK_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                  --Synchronize Second_ack_sync_d2 back to processor clock domain
                  Second_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                  port map (
                      CLK_1             => Clk,
                      RESET_1_n         => Rst_n,
                      DATA_IN           => second_ack_sync_d2,
                      CLK_2             => Processor_clk,
                      RESET_2_n         => processor_rst_n,
                      SYNC_DATA_OUT     => second_ack_sync_mb_clk
                     );

          end generate SECOND_ACK_SYNC_EN_GEN;
          -----------------------------------------
          SECOND_ACK_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
                 second_ack_sync_mb_clk <= second_ack_sync_d2;
                 --second_ack_sync_mb_clk <= second_ack_sync;
          end generate SECOND_ACK_SYNC_DISABLE_GEN;
          -----------------------------------------

    end generate NO_CASCADE_MASTER_MODE;
    -----------------------------

    CASCADE_MASTER_MODE_10 : if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 0) generate
    ------------------------
    -----
    begin
    -----

         --------------------------------------------------
         Processor_ack_out <= (Processor_ack(1) and (not isr_ored_30_0_bits)) & -- to avoide any delay the processor is
                              (Processor_ack(0) and (not isr_ored_30_0_bits)) ; -- simply passed to below modules
         ack_b01           <= (not Processor_ack(1)) and Processor_ack(0); -- ack = b01
         --------------------------------------------------
         first_ack_active_REG_P: process (Processor_clk) is
         -----
         begin
         -----
             if (Processor_clk'event and Processor_clk = '1') then
                 if (processor_rst_n = RESET_ACTIVE) then
                     first_ack_active <= '0';
                 else
                     if (ack_b01 = '1')then
                        first_ack_active <= '1';
                     elsif((Processor_ack(1) = '1')
                           ) then
                        first_ack_active <= '0';
                     else
                        first_ack_active <= first_ack_active;
                     end if;
                 end if;
             end if;
         end process first_ack_active_REG_P;
         ---------------------------
         first_second_ack_REG_P: process (Processor_clk) is
         -----
         begin
         -----
             if (Processor_clk'event and Processor_clk = '1') then
                 if (processor_rst_n = RESET_ACTIVE) then
                     first_ack  <= '0';
                     second_ack <= '0';
                 else
                     first_ack  <= ack_b01;
                     second_ack <= first_ack_active and Processor_ack(1);
                 end if;
             end if;
         end process first_second_ack_REG_P;
         -----------------------------------



        ACK_EN_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                --Synchronize first_ack to AXI clock domain
                Processor_first_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                port map (
                    CLK_1             => Processor_clk,
                    RESET_1_n         => processor_rst_n,
                    DATA_IN           => first_ack,
                    CLK_2             => Clk,
                    RESET_2_n         => Rst_n,
                    SYNC_DATA_OUT     => first_ack_sync
                   );
                --------------------------------------------
                --Synchronize second_ack to AXI clock domain
                Processor_second_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                port map (
                    CLK_1             => Processor_clk,
                    RESET_1_n         => processor_rst_n,
                    DATA_IN           => second_ack,
                    CLK_2             => Clk,
                    RESET_2_n         => Rst_n,
                    SYNC_DATA_OUT     => second_ack_sync
                   );
                --------------------------------------------
        end generate ACK_EN_SYNC_EN_GEN;
        --------------------------------------------
        ACK_EN_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
               first_ack_sync  <= first_ack;
               second_ack_sync <= second_ack;
        end generate ACK_EN_SYNC_DISABLE_GEN;
        --------------------------------------------
        second_ack_d2_reg_p: process (Clk) is
        -----
        begin
        -----
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    second_ack_sync_d1  <= '0';
                    second_ack_sync_d2  <= '0';
                    second_ack_sync_d3  <= '0';
                else
                    second_ack_sync_d1  <= second_ack_sync;
                    second_ack_sync_d2  <= second_ack_sync_d1;
                    second_ack_sync_d3  <= second_ack_sync_d2;
                end if;
            end if;
        end process second_ack_d2_reg_p;
        --------------------------------------------
        SECOND_ACK_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                --Synchronize Second_ack_sync_d2 back to processor clock domain
                Second_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                port map (
                    CLK_1             => Clk,
                    RESET_1_n         => Rst_n,
                    DATA_IN           => second_ack_sync_d2,
                    CLK_2             => Processor_clk,
                    RESET_2_n         => processor_rst_n,
                    SYNC_DATA_OUT     => second_ack_sync_mb_clk
                   );

        end generate SECOND_ACK_SYNC_EN_GEN;
        --------------------------------------------
        SECOND_ACK_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
        -----
        begin
        -----
               second_ack_sync_mb_clk <= second_ack_sync_d2;
               --second_ack_sync_mb_clk <= second_ack_sync;
        end generate SECOND_ACK_SYNC_DISABLE_GEN;
        --------------------------------------------

    end generate CASCADE_MASTER_MODE_10;
    -----------------------------

    CASCADE_MASTER_MODE_11 : if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 1) generate
    ------------------------
    -----
    begin
    -----


         --------------------------------------------------
         Processor_ack_out <= (Processor_ack(1) and (not isr_ored_30_0_bits)) &
                              (Processor_ack(0) and (not isr_ored_30_0_bits)) ;
         ack_b01           <= (not Processor_ack(1)) and Processor_ack(0); -- ack = b01
         --------------------------------------------------
         first_ack_active_REG_P: process (Processor_clk) is
         -----
         begin
         -----
             if (Processor_clk'event and Processor_clk = '1') then
                 if (processor_rst_n = RESET_ACTIVE) then
                     first_ack_active <= '0';
                 else
                     if (ack_b01 = '1')then
                        first_ack_active <= '1';
                     elsif((Processor_ack(1) = '1')
                           ) then
                        first_ack_active <= '0';
                     else
                        first_ack_active <= first_ack_active;
                     end if;
                 end if;
             end if;
         end process first_ack_active_REG_P;
         ---------------------------
         first_second_ack_REG_P: process (Processor_clk) is
         -----
         begin
         -----
             if (Processor_clk'event and Processor_clk = '1') then
                 if (processor_rst_n = RESET_ACTIVE) then
                     first_ack  <= '0';
                     second_ack <= '0';
                 else
                     first_ack  <= ack_b01;
                     second_ack <= first_ack_active and Processor_ack(1);
                 end if;
             end if;
         end process first_second_ack_REG_P;
         -----------------------------------

         ACK_EN_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                  --Synchronize first_ack to AXI clock domain
                  Processor_first_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                  port map (
                      CLK_1             => Processor_clk,
                      RESET_1_n         => processor_rst_n,
                      DATA_IN           => first_ack,
                      CLK_2             => Clk,
                      RESET_2_n         => Rst_n,
                      SYNC_DATA_OUT     => first_ack_sync
                     );

                  --Synchronize second_ack to AXI clock domain
                  Processor_second_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                  port map (
                      CLK_1             => Processor_clk,
                      RESET_1_n         => processor_rst_n,
                      DATA_IN           => second_ack,
                      CLK_2             => Clk,
                      RESET_2_n         => Rst_n,
                      SYNC_DATA_OUT     => second_ack_sync
                     );

          end generate ACK_EN_SYNC_EN_GEN;
          ------------------------------------
          ACK_EN_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
          -----
          begin
          -----
                 first_ack_sync  <= first_ack;
                 second_ack_sync <= second_ack;
          end generate ACK_EN_SYNC_DISABLE_GEN;
          ------------------------------------
          second_ack_d2_reg_p: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      second_ack_sync_d1  <= '0';
                      second_ack_sync_d2  <= '0';
                      second_ack_sync_d3  <= '0';
                  else
                      second_ack_sync_d1  <= second_ack_sync;
                      second_ack_sync_d2  <= second_ack_sync_d1;
                      second_ack_sync_d3  <= second_ack_sync_d2;
                  end if;
              end if;
          end process second_ack_d2_reg_p;
          ------------------------------------
          SECOND_ACK_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                  --Synchronize Second_ack_sync_d2 back to processor clock domain
                  Second_ack_EN_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                  port map (
                      CLK_1             => Clk,
                      RESET_1_n         => Rst_n,
                      DATA_IN           => second_ack_sync_d2,
                      CLK_2             => Processor_clk,
                      RESET_2_n         => processor_rst_n,
                      SYNC_DATA_OUT     => second_ack_sync_mb_clk
                     );

          end generate SECOND_ACK_SYNC_EN_GEN;
          ------------------------------------
          SECOND_ACK_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
                 second_ack_sync_mb_clk <= second_ack_sync_d2;
                 --second_ack_sync_mb_clk <= second_ack_sync;
          end generate SECOND_ACK_SYNC_DISABLE_GEN;
          ------------------------------------

    end generate CASCADE_MASTER_MODE_11;
    -----------------------------

end generate ACK_EN_SYNC_ON_MB_CLK_GEN;

--------------------------------------------------------------------------
-- Process for generating ACK enable and type and syncing them to ACLK
--------------------------------------------------------------------------
ACK_EN_SYNC_ON_AXI_CLK_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 1)) generate

    NO_CASCADE_MASTER : if (C_EN_CASCADE_MODE = 0) and (C_CASCADE_MASTER = 0) generate
    -----
    begin
    -----
          -- dont bypass the processor ack to output
          Processor_ack_out <= (others => '0');
          -----------------
          Processor_ack_EN_REG_P: process (Processor_ack) is
          -----
          begin
          -----
              ack_b01 <= (not Processor_ack(1)) and Processor_ack(0); -- ack = b01
          end process Processor_ack_EN_REG_P;
          -----------------------------------
          first_ack_active_REG_P: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      first_ack_active <= '0';
                  else
                      if (ack_b01 = '1') then
                         first_ack_active <= '1';
                      elsif (Processor_ack(1) = '1') then
                         first_ack_active <= '0';
                      else
                         first_ack_active <= first_ack_active;
                      end if;
                  end if;
              end if;
          end process first_ack_active_REG_P;
          -----------------------------------
          first_second_ack_REG_P: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      first_ack  <= '0';
                      second_ack <= '0';
                  else
                      first_ack  <= ack_b01;
                      second_ack <= first_ack_active and Processor_ack(1);
                  end if;
              end if;
          end process first_second_ack_REG_P;
          -----------------------------------
          first_ack_sync  <= first_ack;
          second_ack_sync <= second_ack;
          -----------------------------------
          second_ack_d2_reg_p: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      second_ack_sync_d1  <= '0';
                      second_ack_sync_d2  <= '0';
                      second_ack_sync_d3  <= '0';
                  else
                      second_ack_sync_d1  <= second_ack_sync;
                      second_ack_sync_d2  <= second_ack_sync_d1;
                      second_ack_sync_d3  <= second_ack_sync_d2;
                  end if;
              end if;
          end process second_ack_d2_reg_p;
          -----------------------------------
          second_ack_sync_mb_clk <= second_ack_sync_d2;

    end generate NO_CASCADE_MASTER;
    -------------------------------

    CASCADE_MASTER_MODE_10 : if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 0) generate
    ------------------------
    -----
    begin
    -----
          --------------------------------------------------
          Processor_ack_out <= (Processor_ack(1) and (not isr_ored_30_0_bits)) &
                               (Processor_ack(0) and (not isr_ored_30_0_bits)) ;
          ack_b01           <= (not Processor_ack(1)) and Processor_ack(0); -- ack = b01
          --------------------------------------------------

          first_ack_active_REG_P: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      first_ack_active <= '0';
                  else
                      if (ack_b01 = '1') then
                         first_ack_active <= '1';
                      elsif((Processor_ack(1) = '1')
                            )then
                         first_ack_active <= '0';
                      else
                         first_ack_active <= first_ack_active;
                      end if;
                  end if;
              end if;
          end process first_ack_active_REG_P;
          -----------------------------------
          first_second_ack_REG_P: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      first_ack  <= '0';
                      second_ack <= '0';
                  else
                      first_ack  <= ack_b01;
                      second_ack <= first_ack_active and Processor_ack(1);
                  end if;
              end if;
          end process first_second_ack_REG_P;
          -----------------------------------
          first_ack_sync  <= first_ack;
          second_ack_sync <= second_ack;
          -----------------------------------
          second_ack_d2_reg_p: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      second_ack_sync_d1  <= '0';
                      second_ack_sync_d2  <= '0';
                      second_ack_sync_d3  <= '0';
                  else
                      second_ack_sync_d1  <= second_ack_sync;
                      second_ack_sync_d2  <= second_ack_sync_d1;
                      second_ack_sync_d3  <= second_ack_sync_d2;
                  end if;
              end if;
          end process second_ack_d2_reg_p;
          -----------------------------------
          second_ack_sync_mb_clk <= second_ack_sync_d2;

       end generate CASCADE_MASTER_MODE_10;
       -------------------------------
       CASCADE_MASTER_MODE_11 : if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 1) generate
       -----
       begin
       -----
          --------------------------------------------------
          Processor_ack_out <= (Processor_ack(1) and (not isr_ored_30_0_bits)) &
                               (Processor_ack(0) and (not isr_ored_30_0_bits)) ;
          ack_b01           <= (not Processor_ack(1)) and Processor_ack(0); -- ack = b01
          --------------------------------------------------

          first_ack_active_REG_P: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      first_ack_active <= '0';
                  else
                      if (ack_b01 = '1') then
                         first_ack_active <= '1';
                      elsif((Processor_ack(1) = '1')-- and
                            --(isr(31) = '0')          and
                            --(ier(31) = '0')          -- and
                            -- (isr_ored_30_0_bits = '1')
                            )then
                         first_ack_active <= '0';
                      else
                         first_ack_active <= first_ack_active;
                      end if;
                  end if;
              end if;
          end process first_ack_active_REG_P;

          first_second_ack_REG_P: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      first_ack  <= '0';
                      second_ack <= '0';
                  else
                      first_ack  <= ack_b01;
                      second_ack <= first_ack_active and Processor_ack(1);
                  end if;
              end if;
          end process first_second_ack_REG_P;
          -----------------------------------
          first_ack_sync  <= first_ack;
          second_ack_sync <= second_ack;
          -----------------------------------
          second_ack_d2_reg_p: process (Clk) is
          -----
          begin
          -----
              if (Clk'event and Clk = '1') then
                  if (Rst_n = RESET_ACTIVE) then
                      second_ack_sync_d1  <= '0';
                      second_ack_sync_d2  <= '0';
                      second_ack_sync_d3  <= '0';
                  else
                      second_ack_sync_d1  <= second_ack_sync;
                      second_ack_sync_d2  <= second_ack_sync_d1;
                      second_ack_sync_d3  <= second_ack_sync_d2;
                  end if;
              end if;
          end process second_ack_d2_reg_p;
          -----------------------------------
          second_ack_sync_mb_clk <= second_ack_sync_d2;
          --second_ack_sync_mb_clk <= second_ack_sync;
          -----------------------------------
       end generate CASCADE_MASTER_MODE_11;
       -------------------------------

----------------------------------------
end generate ACK_EN_SYNC_ON_AXI_CLK_GEN;

SECOND_ACK_FAST_0_GEN: if (C_HAS_FAST = 0) generate
-----
begin
-----
             second_ack_sync_mb_clk <= ack_or_sync;
             Processor_ack_out      <= (others => '0');
end generate SECOND_ACK_FAST_0_GEN;

--------------------------------------------------------------------------
-- Process MER_ME_P for MER ME bit generation
--------------------------------------------------------------------------
   MER_ME_P: process (Clk) is
   -----
   begin
   -----
       if (Clk'event and Clk = '1') then
           if (Rst_n = RESET_ACTIVE) then
               mer_int(0) <= '0';
           elsif (bus2ip_wrce(7) = '1') then
               mer_int(0) <= Wr_data(0);
           end if;
       end if;
   end process MER_ME_P;

   --------------------------------------------------------------------------
   -- Process MER_HIE_P for generating MER HIE bit
   --------------------------------------------------------------------------
   MER_HIE_P: process (Clk)is
   -----
   begin
   -----
       if (Clk'event and Clk = '1') then
           if (Rst_n = RESET_ACTIVE) then
               mer_int(1) <= '0';
           elsif ((bus2ip_wrce(7) = '1') and (mer_int(1) = '0')) then
               mer_int(1) <= Wr_data(1);
           end if;
       end if;
   end process MER_HIE_P;
   -----------------------------------
   mer(1 downto 0) <= mer_int;
   mer(C_DWIDTH - 1 downto 2) <= (others => '0');
   -----------------------------------

   ----------------------------------------------------------------------
   -- Generate SIE if (C_HAS_SIE = 1)
   ----------------------------------------------------------------------
   SIE_GEN: if (C_HAS_SIE = 1) generate
   -----
   begin
   -----
       SIE_BIT_GEN : for i in 0 to (C_NUM_INTR - 1) generate
           --------------------------------------------------------------
           -- Process SIE_P for generating SIE register
           --------------------------------------------------------------
           SIE_P: process (Clk) is
           -----
           begin
           -----
               if (Clk'event and Clk = '1') then
                   if ((Rst_n = RESET_ACTIVE) or (sie(i) = '1')) then
                       sie(i) <= '0';
                   elsif (bus2ip_wrce(4) = '1') then
                       sie(i) <= wr_data_int(i);
                   end if;
               end if;
           end process SIE_P;
       end generate SIE_BIT_GEN;
   end generate SIE_GEN;

   ----------------------------------------------------------------------
   -- Assign sie_out ALL ZEROS if (C_HAS_SIE = 0)
   ----------------------------------------------------------------------
   SIE_NO_GEN: if (C_HAS_SIE = 0) generate
   -----
   begin
   -----
       sie <= (others => '0');
   end generate SIE_NO_GEN;

   ----------------------------------------------------------------------
   -- Generate CIE if (C_HAS_CIE = 1)
   ----------------------------------------------------------------------
   CIE_GEN: if (C_HAS_CIE = 1) generate
   -----
   begin
   -----
       CIE_BIT_GEN : for i in 0 to (C_NUM_INTR - 1) generate
           ------------------------------------------------------------------
           -- Process CIE_P for generating CIE register
           ------------------------------------------------------------------
           CIE_P: process (Clk) is
           -----
           begin
           -----
               if (Clk'event and Clk = '1') then
                   if ((Rst_n = RESET_ACTIVE) or (cie(i) = '1')) then
                       cie(i) <= '0';
                   elsif (bus2ip_wrce(5) = '1') then
                       cie(i) <= wr_data_int(i);
                   end if;
               end if;
           end process CIE_P;
       end generate CIE_BIT_GEN;
   end generate CIE_GEN;

   ----------------------------------------------------------------------
   -- Assign cie_out ALL ZEROS if (C_HAS_CIE = 0)
   ----------------------------------------------------------------------
   CIE_NO_GEN: if (C_HAS_CIE = 0) generate
       cie <= (others => '0');
   end generate CIE_NO_GEN;

   -- Generating write enable & data input for ISR
   isr_en      <= mer(1) or bus2ip_wrce(0);
   isr_data_in <= hw_intr when mer(1) = '1' else
                  Wr_data(C_NUM_INTR_INPUTS - 1 downto 0);

--------------------------------------------------------------------------
-- Generate Registers of width equal C_NUM_INTR
--------------------------------------------------------------------------
REG_GEN : for i in 0 to (C_NUM_INTR - 1) generate
-----
begin
-----
        --IAR_NORMAL_MODE_GEN: if ((C_HAS_FAST = 0) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
        IAR_NORMAL_MODE_GEN: if (C_HAS_FAST = 0) generate
        -----
        begin
        -----
             ----------------------------------------------------------------------
             -- Process FAST_IAR_BIT_P for generating IAR register
             ----------------------------------------------------------------------
             IAR_NORMAL_BIT_P:  process (Clk) is
             -----
             begin
             -----
                 if (Clk'event and Clk = '1') then
                     if (Rst_n = RESET_ACTIVE) or (iar(i) = '1') then
                         iar(i) <= '0';
                     elsif ((bus2ip_wrce(3) = '1')) then
                         iar(i) <= wr_data_int(i);
                     else
                         iar(i) <= '0';
                     end if;
                 end if;
             end process IAR_NORMAL_BIT_P;
          -----------------------------------
        end generate IAR_NORMAL_MODE_GEN;
        ---------------------------------

        IAR_FAST_MODE_GEN: if (C_HAS_FAST = 1) generate
        -----
        begin
        -----
             ----------------------------------------------------------------------
             -- Process FAST_IAR_BIT_P for generating IAR register
             ----------------------------------------------------------------------
             IAR_FAST_BIT_P:  process (Clk) is
             -----
             begin
             -----
                 if (Clk'event and Clk = '1') then
                     if (Rst_n = RESET_ACTIVE) or (iar(i) = '1') then
                         iar(i) <= '0';
                     elsif ((bus2ip_wrce(3) = '1') and (imr(i) = '0')) then
                         iar(i) <= wr_data_int(i);
                     elsif (imr(i) = '1') then
                       if (((C_KIND_OF_INTR(i) = '1') and (first_ack_sync = '1')) or
                           ((C_KIND_OF_INTR(i) = '0') and (second_ack_sync = '1'))) then
                           if (i = TO_INTEGER(unsigned(ivar_index_axi_clk))) then         -- -- clearing IAR based on Processor_ack in FAST_INTERRUPT mode
                             iar(i) <= '1';
                           else
                             iar(i) <= iar(i);
                           end if;
                       else
                         iar(i) <= iar(i);
                       end if;
                     else
                       iar(i) <= iar(i);
                     end if;
                 end if;
             end process IAR_FAST_BIT_P;
          -----------------------------------
        end generate IAR_FAST_MODE_GEN;
        -------------------------------

        ----------------------------------------------------------------------
        -- Process IER_BIT_P for generating IER register
        ----------------------------------------------------------------------
        IER_BIT_P: process (Clk) is
        -----
        begin
        -----
            if (Clk'event and Clk = '1') then
                if ((Rst_n = RESET_ACTIVE) or (cie(i) = '1')) then
                    ier(i) <= '0';
                elsif (sie(i) = '1') then
                    ier(i) <= '1';
                elsif (bus2ip_wrce(2) = '1') then
                    ier(i) <= wr_data_int(i);
                end if;
            end if;
        end process IER_BIT_P;

        ----------------------------------------------------------------------
        -- Process ISR_P for generating ISR register
        ----------------------------------------------------------------------
        ISR_P: process (Clk) is
        -----
        begin
        -----
            if (Clk'event and Clk = '1') then
                if ((Rst_n = RESET_ACTIVE) or (iar(i) = '1'))  then
                    isr(i) <= '0';
                elsif (i < C_NUM_INTR_INPUTS) then
                  if (isr_en = '1') then
                    isr(i) <= isr_data_in(i);
                  end if;
                elsif (i >= C_NUM_INTR_INPUTS) then
                  if (bus2ip_wrce(0) = '1') then
                    isr(i) <= Wr_data(i);
                  end if;
                end if;
            end if;
        end process ISR_P;

        ----------------------------------------------------------------------
        -- Process IMR_P for generating IMR(Interrrupt Mode Register) Register
        ----------------------------------------------------------------------
        IMR_FAST_MODE_GEN: if (C_HAS_FAST = 1) generate
        -----
        begin
        -----
            IMR_P: process (Clk) is
            -----
            begin
            -----
                if (Clk'event and Clk = '1') then
                    if (Rst_n = RESET_ACTIVE) then
                        imr(i) <= '0';
                    elsif bus2ip_wrce(8) = '1'  then
                        imr(i) <= wr_data_int(i);
                    end if;
                end if;
            end process IMR_P;
        end generate IMR_FAST_MODE_GEN;
        -----------------------------------
end generate REG_GEN;
---------------------

---------------------------------------------------------------------------
-- Proces IVAR_REG_P for generating IVAR Registers
---------------------------------------------------------------------------
IVAR_FAST_MODE_GEN: if (C_HAS_FAST = 1) generate
-----
begin
-----
        IVAR_REG_MEM_MB_CLK_GEN: if (C_MB_CLK_NOT_CONNECTED = 0) generate
                 IVAR_REG_MEM_I: entity axi_intc_v4_1_7.shared_ram_ivar
                             generic map (
                                   C_WIDTH       => C_DWIDTH,
                                   C_DPRAM_DEPTH => IVAR_MEM_DEPTH,
                                   C_ADDR_LINES  => IVAR_MEM_ADDR_LINES,
                                   C_IVAR_RESET_VALUE => C_IVAR_RESET_VALUE
                               )
                             port map (
                                   Addra    => Reg_addr(IVAR_MEM_ADDR_LINES-1 downto 0),
                                   Addrb    => ivar_rd_addr_mb_clk(IVAR_MEM_ADDR_LINES-1 downto 0),
                                   Clka     => Clk,
                                   Clkb     => Processor_clk,
                                   Dina     => wr_data,
                                   --Dinb     => (others => '0'),
                                   --Ena      => '1',
                                   --Enb      => '1',
                                   Wea      => write_ivar,
                                   --Web      => '0',
                                   Douta    => ivar_rd_data_axi_clk,
                                   Doutb    => ivar_rd_data_mb_clk
                               );
        end generate IVAR_REG_MEM_MB_CLK_GEN;

        IVAR_REG_MEM_AXI_CLK_GEN: if (C_MB_CLK_NOT_CONNECTED = 1) generate
                 IVAR_REG_MEM_I: entity axi_intc_v4_1_7.shared_ram_ivar
                             generic map (
                                   C_WIDTH       => C_DWIDTH,
                                   C_DPRAM_DEPTH => IVAR_MEM_DEPTH,
                                   C_ADDR_LINES  => IVAR_MEM_ADDR_LINES,
                                   C_IVAR_RESET_VALUE => C_IVAR_RESET_VALUE
                               )
                             port map (
                                   Addra    => Reg_addr(IVAR_MEM_ADDR_LINES-1 downto 0),
                                   Addrb    => ivar_rd_addr_mb_clk(IVAR_MEM_ADDR_LINES-1 downto 0),
                                   Clka     => Clk,
                                   Clkb     => Clk,
                                   Dina     => wr_data,
                                   --Dinb     => (others => '0'),
                                   --Ena      => '1',
                                   --Enb      => '1',
                                   Wea      => write_ivar,
                                   --Web      => '0',
                                   Douta    => ivar_rd_data_axi_clk,
                                   Doutb    => ivar_rd_data_mb_clk
                               );
        end generate IVAR_REG_MEM_AXI_CLK_GEN;

end generate IVAR_FAST_MODE_GEN;
-----------------------------------------------------------------------
-- Generating ier_out & isr_out if C_NUM_INTR /= C_DWIDTH
-----------------------------------------------------------------------
REG_OUT_GEN_DWIDTH_NOT_EQ_NUM_INTR: if (C_NUM_INTR /= C_DWIDTH) generate
-----
begin
-----
        ier_out(C_NUM_INTR - 1 downto 0) <= ier;
        ier_out(C_DWIDTH - 1 downto C_NUM_INTR) <= (others => '0');

        isr_out(C_NUM_INTR - 1 downto 0) <= isr;
        isr_out(C_DWIDTH - 1 downto C_NUM_INTR) <= (others => '0');

        imr_out(C_NUM_INTR - 1 downto 0) <= imr;
        imr_out(C_DWIDTH - 1 downto C_NUM_INTR) <= (others => '0');

        isr_ored_30_0_bits <= or_reduce(isr(C_NUM_INTR-1 downto 0));
end generate REG_OUT_GEN_DWIDTH_NOT_EQ_NUM_INTR;

------------------------------------------------------------------------
-- Generating ier_out & isr_out if C_NUM_INTR = C_DWIDTH
------------------------------------------------------------------------
REG_OUT_GEN_DWIDTH_EQ_NUM_INTR: if (C_NUM_INTR = C_DWIDTH) generate
-----
begin
-----
        ier_out <= ier;
        isr_out <= isr;
        imr_out <= imr;
        isr_ored_30_0_bits <= or_reduce(isr(C_NUM_INTR-2 downto 0));

end generate REG_OUT_GEN_DWIDTH_EQ_NUM_INTR;

    ilr_out (INDEX_BIT-1 downto 0) <= ilr(INDEX_BIT - 1 downto 0);
    ilr_out (C_DWIDTH-1 downto INDEX_BIT) <= (others => '1') when ilr(INDEX_BIT) = '1' else
                                             (others => '0');

    ivr_out (INDEX_BIT-1 downto 0) <= ivr;
    ivr_out (C_DWIDTH-1 downto INDEX_BIT) <= (others => '1') when ((ivr = IVR_ALL_ONES)) else
                                             (others => '0');

    --------------------------------------------------------------------------
    -- Generate IPR if (C_HAS_IPR = 1)
    --------------------------------------------------------------------------
    IPR_GEN: if (C_HAS_IPR = 1) generate
        ----------------------------------------------------------------------
        -- Process IPR_P for generating IPR register
        ----------------------------------------------------------------------
        IPR_P: process (Clk) is
        -----
        begin
        -----
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    ipr <= (others => '0');
                else
                    ipr <= isr_out and ier_out;
                end if;
            end if;
        end process IPR_P;
        ------------------
    end generate IPR_GEN;
    ---------------------

    --------------------------------------------------------------------------
    -- Assign IPR ALL ZEROS if (C_HAS_IPR = 0)
    --------------------------------------------------------------------------
    IPR_NO_GEN: if (C_HAS_IPR = 0) generate
        ipr <= (others => '0');
    end generate IPR_NO_GEN;

    --------------------------------------------------------------------------
    -- Generate IVR if (C_HAS_IVR = 1 or C_HAS_FAST = 1)
    --------------------------------------------------------------------------
    IVR_GEN: if ((C_HAS_IVR = 1) or (C_HAS_FAST = 1)) generate
    begin
        ----------------------------------------------------------------------
        -- Process IVR_DATA_GEN_P for generating interrupt vector address
        ----------------------------------------------------------------------
        IVR_DATA_GEN_P: process (isr, ier) is
        variable ivr_in : std_logic_vector(INDEX_BIT - 1 downto 0)
                                       := (others => '1');
        -----
        begin
        -----
            for i in 0 to (C_NUM_INTR - 1) loop
                if ((isr(i) = '1') and (ier(i) = '1')) then
                    --ivr_in := CONV_STD_LOGIC_VECTOR(i, INDEX_BIT);
                    ivr_in := std_logic_vector(to_unsigned(i, INDEX_BIT));
                    exit;
                else
                    ivr_in := (others => '1');
                end if;
            end loop;
            ivr_data_in <= ivr_in;
        end process IVR_DATA_GEN_P;

        ----------------------------------------------------------------------
        -- Process IVR_P for generating IVR register
        ----------------------------------------------------------------------
        IVR_P: process (Clk) is
        -----
        begin
        -----
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    ivr <= (others => '1');
                else
                    ivr <= ivr_data_in;
                end if;
            end if;
        end process IVR_P;
    end generate IVR_GEN;

    --------------------------------------------------------------------------
    -- Assign IVR ALL ONES if (C_HAS_IVR = 0) and (C_HAS_FAST = 0)
    --------------------------------------------------------------------------
     IVR_NO_GEN: if ((C_HAS_IVR = 0) and (C_HAS_FAST = 0)) generate
        ivr <= (others => '1');
     end generate IVR_NO_GEN;

    --------------------------------------------------------------------------
    -- Generate ILR if (C_HAS_ILR = 1)
    --------------------------------------------------------------------------
    ILR_GEN: if (C_HAS_ILR = 1) generate
    begin
        ----------------------------------------------------------------------
        -- Process ILR_P for generating ILR register
        ----------------------------------------------------------------------
        ILR_P: process (Clk) is
        -----
        begin
        -----
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    ilr <= (others => '1');
                elsif (bus2ip_wrce(9) = '1') then
                    ilr <= Wr_data(INDEX_BIT downto 0);
                end if;
            end if;
        end process ILR_P;
    end generate ILR_GEN;

    --------------------------------------------------------------------------
    -- Assign ILR ALL ONES if (C_HAS_ILR = 0)
    --------------------------------------------------------------------------
    ILR_NO_GEN: if (C_HAS_ILR = 0) generate
    begin
        ilr <= (others => '1');
    end generate ILR_NO_GEN;

    --------------------------------------------------------------------------
    --                      DETECTING HW INTERRUPT
    --------------------------------------------------------------------------
    ---------------------------------------------------------------------------
    -- Detecting the interrupts
    ---------------------------------------------------------------------------
    INTR_DETECT_GEN: for i in 0 to C_NUM_INTR_INPUTS - 1 generate
        signal synced_intr : std_logic := '0';
    begin
        -----------------------------------------------------------------------
        -- Generating the synchronization flip-flops if C_ASYNC_INTR(i) = 1
        -----------------------------------------------------------------------
        ASYNC_GEN: if C_ASYNC_INTR(i) = '1' and C_NUM_SYNC_FF > 0 generate
            signal intr_ff : std_logic_vector(0 to C_NUM_SYNC_FF - 1) := (others => '0');
            attribute ASYNC_REG : string;
            attribute ASYNC_REG of intr_ff : signal is "TRUE";
        begin
            --------------------------------------------
            -- Process SYNC_P to synchronize hw_intr
            --------------------------------------------
            SYNC_P : process (Clk) is
            begin
                if Clk'event and Clk = '1' then
                  intr_ff(0) <= Intr(i);
                  for k in intr_ff'left to intr_ff'right - 1 loop
                    intr_ff(k + 1) <= intr_ff(k);
                  end loop;
                end if;
            end process SYNC_P;

            synced_intr <= intr_ff(intr_ff'right);

            ------------------------------
        end generate ASYNC_GEN;

        -----------------------------------------------------------------------
        -- No synchronization flip-flops if C_ASYNC_INTR(i) = 0
        -----------------------------------------------------------------------
        SYNC_GEN: if C_ASYNC_INTR(i) = '0' or C_NUM_SYNC_FF = 0 generate
        begin
            synced_intr <= Intr(i);
        end generate SYNC_GEN;

        -----------------------------------------------------------------------
        -- Generating the edge triggered interrupts if C_KIND_OF_INTR(i) = 1
        -----------------------------------------------------------------------
        EDGE_DETECT_GEN: if C_KIND_OF_INTR(i) = '1' generate
            signal intr_d1   : std_logic;
            signal intr_edge : std_logic;
        begin
            ----------------------------------------------------------------
            -- Process REG_INTR_EDGE_P to register the interrupt signal edge
            ----------------------------------------------------------------
            REG_INTR_EDGE_P : process (Clk) is
            begin
                if(Clk'event and Clk='1') then
                    if Rst_n = RESET_ACTIVE then
                        intr_d1 <= not C_KIND_OF_EDGE(i);
                    else
                        intr_d1 <= synced_intr;
                    end if;
                end if;
            end process REG_INTR_EDGE_P;

            -- Creating one-shot edge triggered interrupt
            intr_edge <= '1' when (synced_intr =     C_KIND_OF_EDGE(i)) and
                                  (intr_d1     = not C_KIND_OF_EDGE(i)) else
                         '0';

            -----------------------------------------------------------------
            -- Process DETECT_INTR_P to generate the edge triggered interrupt
            -----------------------------------------------------------------
            DETECT_INTR_P : process (Clk) is
            begin
                if Clk'event and Clk='1' then
                    if (Rst_n = RESET_ACTIVE) or (iar(i) = '1') then
                        hw_intr(i) <= '0';
                    elsif (intr_edge = '1') then
                        hw_intr(i) <= '1';
                    end if;
                end if;
            end process DETECT_INTR_P;
            --------------------------
        end generate EDGE_DETECT_GEN;

        ----------------------------------------------------------------------
        -- Generating the Level trigeered interrupts if C_KIND_OF_INTR(i) = 0
        ----------------------------------------------------------------------
        LVL_DETECT_GEN: if C_KIND_OF_INTR(i) = '0' generate
        begin
            ------------------------------------------------------------------
            -- Process LVL_P to generate hw_intr (active high or low)
            ------------------------------------------------------------------
            LVL_P : process (Clk) is
            begin
                if Clk'event and Clk = '1' then
                    if (Rst_n = RESET_ACTIVE) or (iar(i) = '1') then
                        hw_intr(i) <= '0';
                    elsif synced_intr = C_KIND_OF_LVL(i) then
                        hw_intr(i) <= '1';
                    end if;
                end if;
            end process LVL_P;
            ------------------
        end generate LVL_DETECT_GEN;
    end generate INTR_DETECT_GEN;

    --------------------------------------------------------------------------
    -- Checking Active Interrupt/Interrupts
    --------------------------------------------------------------------------
    IRQ_ONE_INTR_GEN: if (C_NUM_INTR = 1) generate
    -----
    begin
    -----
        irq_gen_i<= isr(0) and ier(0) and ilr(0);
    end generate IRQ_ONE_INTR_GEN;

    IRQ_MULTI_INTR_GEN: if (C_NUM_INTR > 1) generate
    -----
    begin
    -----
        --------------------------------------------------------------
        -- Process IRQ_GEN_P to generate irq_gen
        --------------------------------------------------------------
        IRQ_GEN_P: process (isr, ier, ilr) is
            variable ilr_value   : integer;
            variable irq_gen_int : std_logic;
        -----
        begin
        -----
            ilr_value   := TO_INTEGER(unsigned( ilr(INDEX_BIT - 1 downto 0) ));
            irq_gen_int := '0';
            for i in 0 to (isr'length - 1) loop
                if (C_HAS_ILR = 1) then
                    exit when (i = ilr_value) and (ilr(INDEX_BIT) = '0');
                end if;
                irq_gen_int := irq_gen_int or (isr(i) and ier(i));
            end loop;
            irq_gen_i <= irq_gen_int;
        end process IRQ_GEN_P;
        ----------------------

    end generate IRQ_MULTI_INTR_GEN;
    --------------------------------
    -- Registering irq_gen_i as it will be going through double synchronizer
    IRQ_GEN_REG_P : Process(Clk)is
    -----
    begin
    -----
        if (Clk'event and Clk = '1') then
            if (Rst_n = RESET_ACTIVE) then
                irq_gen   <= '0';
            else
                irq_gen   <= irq_gen_i;
            end if;
        end if;
    end process IRQ_GEN_REG_P;
    --------------------------

    --------------------------------------------------------------
    -- Synchronizing irq_gen
    --------------------------------------------------------------
    IRQ_GEN_SYNC_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
             signal irq_gen_sync_vec : std_logic_vector(0 downto 0);
    -----
    begin
    -----
             -- Synchronize irq_gen to Processor clock domain
             IRQ_GEN_DOUBLE_SYNC_I: entity axi_intc_v4_1_7.double_synchronizer
             generic map (
               C_DWIDTH => 1
             )
             port map (
                 CLK_2         => Processor_clk,
                 RESET_2_n     => processor_rst_n,
                 DATA_IN       => scalar_to_vector(irq_gen),
                 SYNC_DATA_OUT => irq_gen_sync_vec
             );

             irq_gen_sync <= irq_gen_sync_vec(0);

    end generate IRQ_GEN_SYNC_GEN;

    IRQ_GEN_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
             irq_gen_sync <= irq_gen;
    end generate IRQ_GEN_SYNC_DISABLE_GEN;

    ---------------------------------------------------------------
    -- Process to synchronize irq_gen and "ivar" to Processor Clock
    ---------------------------------------------------------------
    IVAR_INDEX_SYNC_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
    -----
    begin
    -----
        IN_IDLE_SYNC_EN_GEN: if (C_DISABLE_SYNCHRONIZERS = 0) generate
                    signal in_idle_axi_clk_vec : std_logic_vector(0 downto 0);
        begin
                    IN_IDLE_DOUBLE_SYNC_I: entity axi_intc_v4_1_7.double_synchronizer
                    generic map (
                      C_DWIDTH => 1
                    )
                    port map (
                        CLK_2         => Clk,
                        RESET_2_n     => Rst_n,
                        DATA_IN       => scalar_to_vector(in_idle),
                        SYNC_DATA_OUT => in_idle_axi_clk_vec
                       );
                    in_idle_axi_clk <= in_idle_axi_clk_vec(0);
        end generate IN_IDLE_SYNC_EN_GEN;
        ---------------------------------

        IN_IDLE_SYNC_DISABLE_GEN: if (C_DISABLE_SYNCHRONIZERS = 1) generate
                    in_idle_axi_clk <= in_idle;
        end generate IN_IDLE_SYNC_DISABLE_GEN;
        --------------------------------------

        idle_and_irq <= in_idle_axi_clk and irq_gen_i and mer(0);
        ------------------------------------

        IDLE_IRQ_DELAY_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    idle_and_irq_d1 <= '0';
                else
                    idle_and_irq_d1 <= idle_and_irq;
                end if;
            end if;
        end process IDLE_IRQ_DELAY_P;
        ------------------------------------
        ivar_index_sample_en_i <= idle_and_irq and (not idle_and_irq_d1);
        ------------------------------------
        SAMPLE_REG_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    ivar_index_sample_en <= '0';
                else
                    ivar_index_sample_en <= ivar_index_sample_en_i;
                end if;
            end if;
        end process SAMPLE_REG_P;
        ------------------------------------
        IVAR_INDEX_SYNC_EN_GEN: if (C_DISABLE_SYNCHRONIZERS = 0) generate
                  IRQ_GEN_EDGE_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                      port map (
                          CLK_1             => Clk,
                          RESET_1_n         => Rst_n,
                          DATA_IN           => ivar_index_sample_en,
                          CLK_2             => Processor_clk,
                          RESET_2_n         => processor_rst_n,
                          SYNC_DATA_OUT     => ivar_index_sample_en_mb_clk
                         );
        end generate IVAR_INDEX_SYNC_EN_GEN;
        ------------------------------------
        IVAR_INDEX_SYNC_DISABLE_GEN: if (C_DISABLE_SYNCHRONIZERS = 1) generate
                  ivar_index_sample_en_mb_clk <= ivar_index_sample_en;
        end generate IVAR_INDEX_SYNC_DISABLE_GEN;
        ------------------------------------
        IVAR_INDEX_AXI_REG_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    ivar_index_axi_clk <= (others => '0');
                else
                    if (ivar_index_sample_en_i = '1') then
                       ivar_index_axi_clk <= ivr_data_in;
                    else
                       ivar_index_axi_clk <= ivar_index_axi_clk;
                    end if;
                end if;
            end if;
        end process IVAR_INDEX_AXI_REG_P;
        ------------------------------------
        IVAR_INDEX_MB_REG_P : Process(Processor_clk)
        begin
            if (Processor_clk'event and Processor_clk = '1') then
                if (processor_rst_n = RESET_ACTIVE) then
                    ivar_index_mb_clk <= (others => '0');
                else
                    if (ivar_index_sample_en_mb_clk = '1') then
                       ivar_index_mb_clk <= ivar_index_axi_clk;
                    else
                       ivar_index_mb_clk <= ivar_index_mb_clk;
                    end if;
                end if;
            end if;
        end process IVAR_INDEX_MB_REG_P;
        ------------------------------------
        ivar_rd_addr_mb_clk <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(ivar_index_mb_clk)), 5));
        ------------------------------------
    end generate IVAR_INDEX_SYNC_GEN;

    ---------------------------------------------------------------------
    -- Process to synchronize irq_gen disable to Processor Clock with ILR
    ---------------------------------------------------------------------
    IRQ_DIS_SYNC_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 0) and (C_HAS_ILR = 1)) generate
        signal irq_dis          : std_logic;
        signal irq_dis_d1       : std_logic;
        signal irq_dis_sample_i : std_logic;
        signal irq_dis_sample   : std_logic;
    begin
        irq_dis <= not irq_gen_i;

        IDLE_NOT_IRQ_DELAY_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    irq_dis_d1 <= '0';
                else
                    irq_dis_d1 <= irq_dis;
                end if;
            end if;
        end process IDLE_NOT_IRQ_DELAY_P;

        irq_dis_sample_i <= irq_dis and (not irq_dis_d1);

        SAMPLE_REG_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    irq_dis_sample <= '0';
                else
                    irq_dis_sample <= irq_dis_sample_i;
                end if;
            end if;
        end process SAMPLE_REG_P;

        IRQ_DIS_SYNC_EN_GEN: if (C_DISABLE_SYNCHRONIZERS = 0) generate
                  IRQ_GEN_EDGE_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                      port map (
                          CLK_1             => Clk,
                          RESET_1_n         => Rst_n,
                          DATA_IN           => irq_dis_sample,
                          CLK_2             => Processor_clk,
                          RESET_2_n         => processor_rst_n,
                          SYNC_DATA_OUT     => irq_dis_sample_mb_clk
                         );
        end generate IRQ_DIS_SYNC_EN_GEN;

        IRQ_DIS_SYNC_DISABLE_GEN: if (C_DISABLE_SYNCHRONIZERS = 1) generate
                  irq_dis_sample_mb_clk <= irq_dis_sample;
        end generate IRQ_DIS_SYNC_DISABLE_GEN;

    end generate IRQ_DIS_SYNC_GEN;

    ---------------------------------------------------------------
    -- Process to synchronize irq_gen and "ivar" to Processor Clock
    ---------------------------------------------------------------
    IVAR_INDEX_SYNC_ON_AXI_CLK_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 1)) generate
    -----
    begin
    -----
        in_idle_axi_clk <= in_idle;
        ------------------------------------
        idle_and_irq <= in_idle_axi_clk and irq_gen and mer(0);
        ------------------------------------
        IDLE_IRQ_DELAY_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    idle_and_irq_d1 <= '0';
                else
                    idle_and_irq_d1 <= idle_and_irq;
                end if;
            end if;
        end process IDLE_IRQ_DELAY_P;
        --------------------------------

        ivar_index_sample_en_i <= idle_and_irq and (not idle_and_irq_d1);
        --------------------------------
        SAMPLE_REG_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    ivar_index_sample_en <= '0';
                else
                    ivar_index_sample_en <= ivar_index_sample_en_i;
                end if;
            end if;
        end process SAMPLE_REG_P;
        --------------------------------
        ivar_index_sample_en_mb_clk <= ivar_index_sample_en;
        --------------------------------
        IVAR_INDEX_AXI_REG_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    ivar_index_axi_clk <= (others => '0');
                else
                    if (ivar_index_sample_en_i = '1') then
                       ivar_index_axi_clk <= ivr;
                    else
                       ivar_index_axi_clk <= ivar_index_axi_clk;
                    end if;
                end if;
            end if;
        end process IVAR_INDEX_AXI_REG_P;
        --------------------------------
        ivar_index_mb_clk <= ivar_index_axi_clk;
        --------------------------------
        ivar_rd_addr_mb_clk <= std_logic_vector(to_unsigned(TO_INTEGER(unsigned(ivar_index_mb_clk)), 5));

    end generate IVAR_INDEX_SYNC_ON_AXI_CLK_GEN;

    ---------------------------------------------------------------------
    -- Process to synchronize irq_gen disable to Processor Clock with ILR
    ---------------------------------------------------------------------
    IRQ_DIS_SYNC_ON_AXI_CLK_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 1) and (C_HAS_ILR = 1)) generate
        signal irq_dis          : std_logic;
        signal irq_dis_d1       : std_logic;
        signal irq_dis_sample_i : std_logic;
        signal irq_dis_sample   : std_logic;
    begin
        irq_dis <= not irq_gen;

        IDLE_IRQ_DELAY_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    irq_dis_d1 <= '0';
                else
                    irq_dis_d1 <= irq_dis;
                end if;
            end if;
        end process IDLE_IRQ_DELAY_P;

        irq_dis_sample_i <= irq_dis and (not irq_dis_d1);

        SAMPLE_REG_P : Process(Clk)
        begin
            if (Clk'event and Clk = '1') then
                if (Rst_n = RESET_ACTIVE) then
                    irq_dis_sample <= '0';
                else
                    irq_dis_sample <= irq_dis_sample_i;
                end if;
            end if;
        end process SAMPLE_REG_P;

        irq_dis_sample_mb_clk <= irq_dis_sample;
    end generate IRQ_DIS_SYNC_ON_AXI_CLK_GEN;

    NO_IRQ_DIS_SYNC: if (C_HAS_FAST = 0) or (C_HAS_ILR = 0) generate
    begin
        irq_dis_sample_mb_clk <= '0';
    end generate NO_IRQ_DIS_SYNC;

    ----------------------------------------------------------------------
    -- MER_0_DOUBLE_SYNC_I to synchronize MER(0) with Processor_clk
    ----------------------------------------------------------------------
    MER_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                signal mer_0_sync_vec : std_logic_vector(0 downto 0);
    begin
                --Synchronize mer(0) to Processor clock domain
                MER_0_DOUBLE_SYNC_I: entity axi_intc_v4_1_7.double_synchronizer
                generic map (
                  C_DWIDTH => 1
                )
                port map (
                    CLK_2         => Processor_clk,
                    RESET_2_n     => processor_rst_n,
                    DATA_IN       => scalar_to_vector(mer(0)),
                    SYNC_DATA_OUT => mer_0_sync_vec
                );
                mer_0_sync <= mer_0_sync_vec(0);
    end generate MER_SYNC_EN_GEN;
    ------------------------------
    MER_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
                mer_0_sync <= mer(0);
    end generate MER_SYNC_DISABLE_GEN;

    --------------------------------------------------------------------------
    -- Generating LEVEL interrupt if C_IRQ_IS_LEVEL = 1
    --------------------------------------------------------------------------
    IRQ_LEVEL_GEN: if (C_IRQ_IS_LEVEL = 1) generate

            -- Level IRQ generation if C_HAS_FAST is 1
            IRQ_LEVEL_FAST_ON_MB_CLK_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 0)) generate

                   -- Type declaration
                   type STATE_TYPE is (IDLE, GEN_LEVEL_IRQ, WAIT_ACK);
                   -- Signal declaration
                   signal current_state : STATE_TYPE;
                   begin

                   -- generate in_idle signal
                   GEN_IN_IDLE_P : process (Processor_clk)
                   begin
                       if(Processor_clk'event and Processor_clk='1') then
                           if (processor_rst_n = RESET_ACTIVE) then
                               in_idle <= '0';
                           else
                               if (current_state = IDLE) then
                                    in_idle <= '1';
                               else
                                    in_idle <= '0';
                               end if;
                           end if;
                       end if;
                   end process GEN_IN_IDLE_P;

                   --------------------------------------------------------------
                   --The sequential process below maintains the current_state
                   --------------------------------------------------------------
                   GEN_CS_P : process (Processor_clk)
                   begin
                       if(Processor_clk'event and Processor_clk='1') then
                           if (processor_rst_n = RESET_ACTIVE) then
                               current_state <= IDLE;
                           else
                               case current_state is
                                   when IDLE      => if ((ivar_index_sample_en_mb_clk = '1')) then
                                                         current_state <= GEN_LEVEL_IRQ;
                                                     else
                                                         current_state <= IDLE;
                                                     end if;
                                   when GEN_LEVEL_IRQ =>
                                                     if (imr(TO_INTEGER(unsigned(ivar_index_mb_clk))) = '1') then
                                                         if (first_ack = '1') then
                                                            current_state <= WAIT_ACK;
                                                         else
                                                            current_state <= GEN_LEVEL_IRQ;
                                                         end if;
                                                     else
                                                         if (ack_or_sync = '1') or (irq_dis_sample_mb_clk = '1') then
                                                             current_state <= IDLE;
                                                         else
                                                             current_state <= GEN_LEVEL_IRQ;
                                                         end if;
                                                     end if;
                                   when WAIT_ACK  => if (second_ack_sync_mb_clk = '1') then
                                                         current_state <= IDLE;
                                                     else
                                                         current_state <= WAIT_ACK;
                                                     end if;
                                   -- coverage off
                                   when others    => current_state <= IDLE;
                                   -- coverage on
                               end case;
                           end if;
                       end if;
                   end process GEN_CS_P;

                --------------------------------------------------------------------
                -- Process IRQ_LEVEL_P for generating LEVEL interrupt
                --------------------------------------------------------------------
                Irq_i <= C_IRQ_ACTIVE when (current_state = GEN_LEVEL_IRQ) else
                         not C_IRQ_ACTIVE;
                -----------------------------
                GEN_LEVEL_IRQ_P : process (Processor_clk)
                begin
                    if(Processor_clk'event and Processor_clk='1') then
                        if (processor_rst_n = RESET_ACTIVE) then
                            Irq      <= (not C_IRQ_ACTIVE);
                        else
                            Irq      <= Irq_i;
                        end if;
                    end if;
                end process GEN_LEVEL_IRQ_P;
                -----------------------------
                NO_CASCADE_IVAR_ADDRESS: -- if (C_CASCADE_MASTER = 0) generate
                                         if (C_EN_CASCADE_MODE = 0) and (C_CASCADE_MASTER = 0) generate
                begin
                -----
                     Interrupt_address <= ivar_rd_data_mb_clk;
                end generate NO_CASCADE_IVAR_ADDRESS;
                -------------------------------------
                CASCADE_IVAR_ADDRESS: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 0) generate
                     signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                -----
                begin
                -----
                REG_IP_INTR_ADDR_IN: process(Processor_clk)is
                begin
                    if(Processor_clk'event and Processor_clk='1') then
                        if (processor_rst_n = RESET_ACTIVE) then
                            Interrupt_address_in_reg <= (others => '0');
                        else
                            Interrupt_address_in_reg <= Interrupt_address_in;
                        end if;
                    end if;
                end process REG_IP_INTR_ADDR_IN;
                --------------------------------
                Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                --------------------------------
                Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                    (ier(31) = '1') and
                                                                    (isr_ored_30_0_bits = '0')
                                                                   )
                                          else
                                          ivar_rd_data_mb_clk;
                end generate CASCADE_IVAR_ADDRESS;
                ----------------------------------
                CASCADE_IVAR_ADDRESS_MST_MD: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 1) generate
                -- local signal declaration
                signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                -----
                begin
                -----
                REG_IP_INTR_ADDR_IN: process(Processor_clk)is
                begin
                    if(Processor_clk'event and Processor_clk='1') then
                        if (processor_rst_n = RESET_ACTIVE) then
                            Interrupt_address_in_reg <= (others => '0');
                        else
                            Interrupt_address_in_reg <= Interrupt_address_in;
                        end if;
                    end if;
                end process REG_IP_INTR_ADDR_IN;
                --------------------------------
                Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                --------------------------------
                Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                    (ier(31) = '1') and
                                                                    (isr_ored_30_0_bits = '0')
                                                                   )
                                          else
                                          ivar_rd_data_mb_clk;
                end generate CASCADE_IVAR_ADDRESS_MST_MD;
            end generate IRQ_LEVEL_FAST_ON_MB_CLK_GEN;
            ------------------------------------------------------------------


            IRQ_LEVEL_FAST_ON_AXI_CLK_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 1)) generate
                   -- Type declaration
                   type STATE_TYPE is (IDLE, GEN_LEVEL_IRQ, WAIT_ACK);
                   -- Signal declaration
                   signal current_state : STATE_TYPE;
                   begin

                   -- generate in_idle signal
                   GEN_IN_IDLE_P : process (Clk)
                   begin
                       if(Clk'event and Clk='1') then
                           if (Rst_n = RESET_ACTIVE) then
                               in_idle <= '0';
                           else
                               if (current_state = IDLE) then
                                    in_idle <= '1';
                               else
                                    in_idle <= '0';
                               end if;
                           end if;
                       end if;
                   end process GEN_IN_IDLE_P;


                   --------------------------------------------------------------
                   --The sequential process below maintains the current_state
                   --------------------------------------------------------------
                   GEN_CS_P : process (Clk)
                   begin
                       if(Clk'event and Clk='1') then
                           if (Rst_n = RESET_ACTIVE) then
                               current_state <= IDLE;
                           else
                               case current_state is
                                   when IDLE      => if (ivar_index_sample_en_mb_clk = '1') then
                                                         current_state <= GEN_LEVEL_IRQ;
                                                     else
                                                         current_state <= IDLE;
                                                     end if;
                                   when GEN_LEVEL_IRQ =>
                                                     if (imr(TO_INTEGER(unsigned(ivar_index_mb_clk))) = '1') then
                                                         if (first_ack = '1') then
                                                            current_state <= WAIT_ACK;
                                                         else
                                                            current_state <= GEN_LEVEL_IRQ;
                                                         end if;
                                                     else
                                                         if (ack_or_sync = '1') or (irq_dis_sample_mb_clk = '1') then
                                                             current_state <= IDLE;
                                                         else
                                                             current_state <= GEN_LEVEL_IRQ;
                                                         end if;
                                                     end if;
                                   when WAIT_ACK  => if (second_ack_sync_mb_clk = '1') then
                                                         current_state <= IDLE;
                                                     else
                                                         current_state <= WAIT_ACK;
                                                     end if;
                                   -- coverage off
                                   when others    => current_state <= IDLE;
                                   -- coverage on
                               end case;
                           end if;
                       end if;
                   end process GEN_CS_P;

                --------------------------------------------------------------------
                -- Process IRQ_LEVEL_P for generating LEVEL interrupt
                --------------------------------------------------------------------
                Irq_i <= C_IRQ_ACTIVE when (current_state = GEN_LEVEL_IRQ) else
                         not C_IRQ_ACTIVE;
                -------------------------------
                GEN_LEVEL_IRQ_P : process (Clk)
                begin
                    if(Clk'event and Clk='1') then
                        if (Rst_n = RESET_ACTIVE) then
                            Irq      <= (not C_IRQ_ACTIVE);
                        else
                            Irq      <= Irq_i;
                        end if;
                    end if;
                end process GEN_LEVEL_IRQ_P;
                ----------------------------
                -- Interrupt_address <= ivar_rd_data_mb_clk;
                NO_CASCADE_IVAR_ADDRESS: -- if (C_CASCADE_MASTER = 0) generate
                                         if (C_EN_CASCADE_MODE = 0) and (C_CASCADE_MASTER = 0) generate
                begin
                -----
                Interrupt_address <= ivar_rd_data_mb_clk;
                end generate NO_CASCADE_IVAR_ADDRESS;

                CASCADE_IVAR_ADDRESS: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 0) generate
                     signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                -----
                begin
                -----
                REG_IP_INTR_ADDR_IN: process(Clk)is
                begin
                    if(Clk'event and Clk='1') then
                        if (Rst_n = RESET_ACTIVE) then
                            Interrupt_address_in_reg <= (others => '0');
                        else
                            Interrupt_address_in_reg <= Interrupt_address_in;
                        end if;
                    end if;
                end process REG_IP_INTR_ADDR_IN;
                --------------------------------
                Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                --------------------------------
                Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                    (ier(31) = '1') and
                                                                    (isr_ored_30_0_bits = '0')
                                                                   )
                                          else
                                          ivar_rd_data_mb_clk;
                end generate CASCADE_IVAR_ADDRESS;
                ----------------------------------
                CASCADE_IVAR_ADDRESS_MST_MD: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 1) generate
                     signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                -----
                begin
                -----
                REG_IP_INTR_ADDR_IN: process(Clk)is
                begin
                    if(Clk'event and Clk='1') then
                        if (Rst_n = RESET_ACTIVE) then
                            Interrupt_address_in_reg <= (others => '0');
                        else
                            Interrupt_address_in_reg <= Interrupt_address_in;
                        end if;
                    end if;
                end process REG_IP_INTR_ADDR_IN;
                --------------------------------
                Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                --------------------------------
                Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                    (ier(31) = '1') and
                                                                    (isr_ored_30_0_bits = '0')
                                                                   )
                                          else
                                          ivar_rd_data_mb_clk;
                end generate CASCADE_IVAR_ADDRESS_MST_MD;
                -------------------------------------------
            end generate IRQ_LEVEL_FAST_ON_AXI_CLK_GEN;

            -- Level IRQ generation if C_HAS_FAST is 0
            IRQ_LEVEL_NORMAL_ON_MB_CLK_GEN: if ((C_HAS_FAST = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                --------------------------------------------------------------------
                -- Process IRQ_LEVEL_P for generating LEVEL interrupt
                --------------------------------------------------------------------
                IRQ_LEVEL_P: process (Processor_clk) is
                begin
                    if(Processor_clk'event and Processor_clk = '1') then
                        if ((processor_rst_n = RESET_ACTIVE) or (irq_gen_sync = '0')) then
                                Irq               <= not C_IRQ_ACTIVE;
                        elsif ((irq_gen_sync = '1') and (mer_0_sync = '1')) then
                                Irq               <= C_IRQ_ACTIVE;
                        end if;
                    end if;
                end process IRQ_LEVEL_P;
                -------------------------------------
                Interrupt_address <= (others => '0');
                -------------------------------------
            end generate IRQ_LEVEL_NORMAL_ON_MB_CLK_GEN;

            IRQ_LEVEL_NORMAL_ON_AXI_CLK_GEN: if ((C_HAS_FAST = 0) and (C_MB_CLK_NOT_CONNECTED = 1)) generate
                --------------------------------------------------------------------
                -- Process IRQ_LEVEL_P for generating LEVEL interrupt
                --------------------------------------------------------------------
                IRQ_LEVEL_ON_AXI_P: process (Clk) is
                begin
                    if(Clk'event and Clk = '1') then
                        if ((Rst_n = RESET_ACTIVE) or (irq_gen_sync = '0')) then
                                Irq               <= not C_IRQ_ACTIVE;
                        elsif ((irq_gen_sync = '1') and (mer_0_sync = '1')) then
                                Irq               <= C_IRQ_ACTIVE;
                        end if;
                    end if;
                end process IRQ_LEVEL_ON_AXI_P;

                Interrupt_address <= (others => '0');

            end generate IRQ_LEVEL_NORMAL_ON_AXI_CLK_GEN;


    end generate IRQ_LEVEL_GEN;


    ----------------------------------------------------------------------
    -- Generating ack_or for C_NUM_INTR = 1
    ----------------------------------------------------------------------
    ACK_OR_ONE_INTR_GEN: if (C_NUM_INTR = 1) generate
        ack_or_i <= iar(0);
    end generate ACK_OR_ONE_INTR_GEN;

    ----------------------------------------------------------------------
    -- Generating ack_or for C_NUM_INTR > 1
    ----------------------------------------------------------------------
    ACK_OR_MULTI_INTR_GEN: if (C_NUM_INTR > 1) generate
    -----
    begin
    -----
        --------------------------------------------------------------
        -- Process ACK_OR_GEN_P to generate ack_or (ORed Acks)
        --------------------------------------------------------------
        ACK_OR_GEN_P: process (iar)
            variable ack_or_int : std_logic := '0';
        begin
            ack_or_int := iar(0);
            for i in 1 to (iar'length - 1) loop
                ack_or_int := ack_or_int or (iar(i));
            end loop;
            ack_or_i <= ack_or_int;
        end process ACK_OR_GEN_P;

    end generate ACK_OR_MULTI_INTR_GEN;
    ----------------------------------
    ACK_OR_REG_P : Process(Clk)
    begin
        if (Clk'event and Clk = '1') then
            if (Rst_n = RESET_ACTIVE) then
                ack_or    <= '0';
            else
                ack_or    <= ack_or_i;
            end if;
        end if;
    end process ACK_OR_REG_P;
    -------------------------

    ACK_OR_SYNC_EN_GEN: if ((C_DISABLE_SYNCHRONIZERS = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
              ACK_OR_PULSE_SYNC_I: entity axi_intc_v4_1_7.pulse_synchronizer
                  port map (
                      CLK_1             => Clk,
                      RESET_1_n         => Rst_n,
                      DATA_IN           => ack_or,
                      CLK_2             => Processor_clk,
                      RESET_2_n         => processor_rst_n,
                      SYNC_DATA_OUT     => ack_or_sync
                     );
    end generate ACK_OR_SYNC_EN_GEN;

    ACK_OR_SYNC_DISABLE_GEN: if ((C_DISABLE_SYNCHRONIZERS = 1) or (C_MB_CLK_NOT_CONNECTED = 1)) generate
              ack_or_sync <= ack_or;
    end generate ACK_OR_SYNC_DISABLE_GEN;


    --------------------------------------------------------------------------
    -- Generating EDGE interrupt if C_IRQ_IS_LEVEL = 0
    --------------------------------------------------------------------------
    IRQ_EDGE_GEN: if (C_IRQ_IS_LEVEL = 0) generate

            IRQ_EDGE_FAST_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                    -- Type declaration
                    type STATE_TYPE is (IDLE, GEN_PULSE, WAIT_ACK);
                    -- Signal declaration
                    signal current_state : STATE_TYPE;
                    begin

                    -- generate in_idle signal
                    GEN_IN_IDLE_P : process (Processor_clk)
                    begin
                        if(Processor_clk'event and Processor_clk='1') then
                            if (processor_rst_n = RESET_ACTIVE) then
                                in_idle <= '0';
                            else
                                if (current_state = IDLE) then
                                     in_idle <= '1';
                                else
                                     in_idle <= '0';
                                end if;
                            end if;
                        end if;
                    end process GEN_IN_IDLE_P;

                    --------------------------------------------------------------
                    --The sequential process below maintains the current_state
                    --------------------------------------------------------------
                    GEN_CS_P : process (Processor_clk)
                    begin
                        if(Processor_clk'event and Processor_clk='1') then
                            if (processor_rst_n = RESET_ACTIVE) then
                                current_state <= IDLE;
                            else
                                case current_state is
                                    when IDLE      => if (ivar_index_sample_en_mb_clk = '1') then
                                                          current_state <= GEN_PULSE;
                                                      else
                                                          current_state <= IDLE;
                                                      end if;
                                    when GEN_PULSE =>
                                                     if (imr(TO_INTEGER(unsigned(ivar_index_mb_clk))) = '1') then
                                                         if (first_ack = '1') then
                                                            current_state <= WAIT_ACK;
                                                         else
                                                            current_state <= GEN_PULSE;
                                                         end if;
                                                     else
                                                         if (ack_or_sync = '1') or (irq_dis_sample_mb_clk = '1') then
                                                             current_state <= IDLE;
                                                         else
                                                             current_state <= GEN_PULSE;
                                                         end if;
                                                     end if;
                                    when WAIT_ACK  => if (second_ack_sync_mb_clk = '1') then
                                                          current_state <= IDLE;
                                                      else
                                                          current_state <= WAIT_ACK;
                                                      end if;
                                    -- coverage off
                                    when others    => current_state <= IDLE;
                                    -- coverage on
                                end case;
                            end if;
                        end if;
                    end process GEN_CS_P;

                    Irq_i <= C_IRQ_ACTIVE when (current_state = GEN_PULSE) else
                             (not C_IRQ_ACTIVE);

                    GEN_IRQ_P : process (Processor_clk)
                    begin
                        if(Processor_clk'event and Processor_clk='1') then
                            if (processor_rst_n = RESET_ACTIVE) then
                                Irq      <= (not C_IRQ_ACTIVE);
                            else
                                Irq      <= Irq_i;
                            end if;
                        end if;
                    end process GEN_IRQ_P;

                    -- Interrupt_address <= ivar_rd_data_mb_clk; -- 09-09-2012
                    NO_CASCADE_IVAR_ADDRESS: -- if (C_CASCADE_MASTER = 0) generate
                                             if (C_EN_CASCADE_MODE = 0) and (C_CASCADE_MASTER = 0) generate
                    begin
                    -----
                    Interrupt_address <= ivar_rd_data_mb_clk;
                    end generate NO_CASCADE_IVAR_ADDRESS;

                    CASCADE_IVAR_ADDRESS: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 0) generate
                         signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                    -----
                    begin
                    -----

                    REG_IP_INTR_ADDR_IN: process(Processor_clk)is
                    begin
                        if(Processor_clk'event and Processor_clk='1') then
                            if (processor_rst_n = RESET_ACTIVE) then
                                Interrupt_address_in_reg <= (others => '0');
                            else
                                Interrupt_address_in_reg <= Interrupt_address_in;
                            end if;
                        end if;
                    end process REG_IP_INTR_ADDR_IN;
                --------------------------------
                Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                --------------------------------

                    Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                        (ier(31) = '1') and
                                                                        (isr_ored_30_0_bits = '0')
                                                                       )
                                              else
                                              ivar_rd_data_mb_clk;
                    end generate CASCADE_IVAR_ADDRESS;
                    ---------------------------------------------------
                    CASCADE_IVAR_ADDRESS_MST_MD: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 1) generate
                    signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                    -----
                                    begin
                                    -----
                                    REG_IP_INTR_ADDR_IN: process(Processor_clk)is
                                    begin
                                        if(Processor_clk'event and Processor_clk='1') then
                                            if (processor_rst_n = RESET_ACTIVE) then
                                                Interrupt_address_in_reg <= (others => '0');
                                            else
                                                Interrupt_address_in_reg <= Interrupt_address_in;
                                            end if;
                                        end if;
                                    end process REG_IP_INTR_ADDR_IN;
                --------------------------------
                Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                --------------------------------
                                    Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                                        (ier(31) = '1') and
                                                                                        (isr_ored_30_0_bits = '0')
                                                                                       )
                                                              else
                                                              ivar_rd_data_mb_clk;
                            end generate CASCADE_IVAR_ADDRESS_MST_MD;

                    ---------------------------------------------------

            end generate IRQ_EDGE_FAST_GEN;

            IRQ_EDGE_FAST_ON_AXI_CLK_GEN: if ((C_HAS_FAST = 1) and (C_MB_CLK_NOT_CONNECTED = 1)) generate
                    -- Type declaration
                    type STATE_TYPE is (IDLE, GEN_PULSE, WAIT_ACK);
                    -- Signal declaration
                    signal current_state : STATE_TYPE;
                    begin

                    -- generate in_idle signal
                    GEN_IN_IDLE_P : process (Clk)
                    begin
                        if(Clk'event and Clk='1') then
                            if (Rst_n = RESET_ACTIVE) then
                                in_idle <= '0';
                            else
                                if (current_state = IDLE) then
                                     in_idle <= '1';
                                else
                                     in_idle <= '0';
                                end if;
                            end if;
                        end if;
                    end process GEN_IN_IDLE_P;

                    --------------------------------------------------------------
                    --The sequential process below maintains the current_state
                    --------------------------------------------------------------
                    GEN_CS_P : process (Clk)
                    begin
                        if(Clk'event and Clk='1') then
                            if (Rst_n = RESET_ACTIVE) then
                                current_state <= IDLE;
                            else
                                case current_state is
                                    when IDLE      => if (ivar_index_sample_en_mb_clk = '1') then
                                                          current_state <= GEN_PULSE;
                                                      else
                                                          current_state <= IDLE;
                                                      end if;
                                    when GEN_PULSE =>
                                                     if (imr(TO_INTEGER(unsigned(ivar_index_mb_clk))) = '1') then
                                                         if (first_ack = '1') then
                                                            current_state <= WAIT_ACK;
                                                         else
                                                            current_state <= GEN_PULSE;
                                                         end if;
                                                     else
                                                         if (ack_or_sync = '1') or (irq_dis_sample_mb_clk = '1') then
                                                             current_state <= IDLE;
                                                         else
                                                             current_state <= GEN_PULSE;
                                                         end if;
                                                     end if;
                                    when WAIT_ACK  => if (second_ack_sync_mb_clk = '1') then
                                                          current_state <= IDLE;
                                                      else
                                                          current_state <= WAIT_ACK;
                                                      end if;
                                    -- coverage off
                                    when others    => current_state <= IDLE;
                                    -- coverage on
                                end case;
                            end if;
                        end if;
                    end process GEN_CS_P;
                    ---------------------------
                    Irq_i <= C_IRQ_ACTIVE when (current_state = GEN_PULSE) else
                             (not C_IRQ_ACTIVE);
                    ---------------------------
                    GEN_IRQ_P : process (Clk)
                    begin
                        if(Clk'event and Clk='1') then
                            if (Rst_n = RESET_ACTIVE) then
                                Irq      <= (not C_IRQ_ACTIVE);
                            else
                                Irq      <= Irq_i;
                            end if;
                        end if;
                    end process GEN_IRQ_P;
                    -----------------------
                    -- Interrupt_address <= ivar_rd_data_mb_clk; -- 09-09-2012
                    NO_CASCADE_IVAR_ADDRESS: -- if (C_CASCADE_MASTER = 0) generate
                                             if (C_EN_CASCADE_MODE = 0) and (C_CASCADE_MASTER = 0) generate
                    begin
                    -----
                    Interrupt_address <= ivar_rd_data_mb_clk;
                    end generate NO_CASCADE_IVAR_ADDRESS;
                    -------------------------------------
                    CASCADE_IVAR_ADDRESS: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 0) generate
                         signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                    -----
                    begin
                    -----
                    REG_IP_INTR_ADDR_IN: process(Clk)is
                    begin
                        if(Clk'event and Clk='1') then
                            if (Rst_n = RESET_ACTIVE) then
                                Interrupt_address_in_reg <= (others => '0');
                            else
                                Interrupt_address_in_reg <= Interrupt_address_in;
                            end if;
                        end if;
                    end process REG_IP_INTR_ADDR_IN;
                    --------------------------------
                    Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                    --------------------------------
                    Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                        (ier(31) = '1') and
                                                                        (isr_ored_30_0_bits = '0')
                                                                        )
                                         else
                                         ivar_rd_data_mb_clk;
                    end generate CASCADE_IVAR_ADDRESS;
                    ---------------------------------------------------------------
                    CASCADE_IVAR_ADDRESS_MST_MD: if (C_EN_CASCADE_MODE = 1) and (C_CASCADE_MASTER = 1) generate
                         signal Interrupt_address_in_reg : std_logic_vector(31 downto 0);
                    -----
                                    begin
                                    -----
                                    REG_IP_INTR_ADDR_IN: process(Clk)is
                                    begin
                                        if(Clk'event and Clk='1') then
                                            if (Rst_n = RESET_ACTIVE) then
                                                Interrupt_address_in_reg <= (others => '0');
                                            else
                                                Interrupt_address_in_reg <= Interrupt_address_in;
                                            end if;
                                        end if;
                                    end process REG_IP_INTR_ADDR_IN;
                --------------------------------
                Interrupt_address_in_reg_int <= Interrupt_address_in_reg;
                --------------------------------
                                    Interrupt_address <= Interrupt_address_in_reg when ((isr(31) = '1') and
                                                                                        (ier(31) = '1') and
                                                                                        (isr_ored_30_0_bits = '0')
                                                                                       )
                                                              else
                                                              ivar_rd_data_mb_clk;
                            end generate CASCADE_IVAR_ADDRESS_MST_MD;

                    ---------------------------------------------------------------

            end generate IRQ_EDGE_FAST_ON_AXI_CLK_GEN;



            --IRQ_EDGE_NORMAL_GEN: if (C_HAS_FAST = 0) generate

            IRQ_EDGE_NO_MB_CLK_GEN: if ((C_HAS_FAST = 0) and (C_MB_CLK_NOT_CONNECTED = 1)) generate
                -- Type declaration
                type STATE_TYPE is (IDLE, GEN_PULSE, WAIT_ACK);
                -- Signal declaration
                signal current_state : STATE_TYPE;

            begin

                --------------------------------------------------------------
                --The sequential process below maintains the current_state
                --------------------------------------------------------------
                GEN_CS_P : process (Clk)
                begin
                    if(Clk'event and Clk='1') then
                        if (Rst_n = RESET_ACTIVE) then
                            current_state <= IDLE;
                        else
                            case current_state is
                                when IDLE => if ((irq_gen_sync = '1') and (mer_0_sync = '1')) then
                                                 current_state <= GEN_PULSE;
                                             else
                                                 current_state <= IDLE;
                                             end if;
                                when GEN_PULSE =>
                                                  current_state <= WAIT_ACK;
                                when WAIT_ACK  => if (ack_or_sync = '1') then
                                                      current_state <= IDLE;
                                                  else
                                                      current_state <= WAIT_ACK;
                                                  end if;
                            end case;
                        end if;
                    end if;
                end process GEN_CS_P;

                GEN_IRQ_AND_ADDR_P : process (Clk)
                begin
                    if(Clk'event and Clk='1') then
                        if (Rst_n = RESET_ACTIVE) then
                            Irq               <= (not C_IRQ_ACTIVE);
                        else
                            if (current_state = GEN_PULSE) then
                              Irq               <= C_IRQ_ACTIVE;
                            else
                              Irq               <= not C_IRQ_ACTIVE;
                            end if;
                        end if;
                    end if;
                end process GEN_IRQ_AND_ADDR_P;

                Interrupt_address <= (others => '0');

            end generate IRQ_EDGE_NO_MB_CLK_GEN;


            IRQ_EDGE_MB_CLK_GEN: if ((C_HAS_FAST = 0) and (C_MB_CLK_NOT_CONNECTED = 0)) generate
                -- Type declaration
                type STATE_TYPE is (IDLE, GEN_PULSE, WAIT_ACK, WAIT_SYNC);
                -- Signal declaration
                signal current_state : STATE_TYPE;

            begin

                --------------------------------------------------------------
                --The sequential process below maintains the current_state
                --------------------------------------------------------------
                GEN_CS_P : process (Processor_clk)
                begin
                    if(Processor_clk'event and Processor_clk='1') then
                        if (processor_rst_n = RESET_ACTIVE) then
                            current_state <= IDLE;
                        else
                            case current_state is
                                when IDLE => if ((irq_gen_sync = '1') and (mer_0_sync = '1')) then
                                                 current_state <= GEN_PULSE;
                                             else
                                                 current_state <= IDLE;
                                             end if;
                                when GEN_PULSE =>
                                                  current_state <= WAIT_ACK;
                                when WAIT_ACK  => if (ack_or_sync = '1') then
                                                      if (C_DISABLE_SYNCHRONIZERS = 1) then
                                                           current_state <= IDLE;
                                                      else
                                                           current_state <= WAIT_SYNC;
                                                      end if;
                                                  else
                                                      current_state <= WAIT_ACK;
                                                  end if;
                                when WAIT_SYNC => current_state <= IDLE;
                                -- coverage off
                                when others    => current_state <= IDLE;
                                -- coverage on
                            end case;
                        end if;
                    end if;
                end process GEN_CS_P;

                GEN_IRQ_AND_ADDR_P : process (Processor_clk)
                begin
                    if(Processor_clk'event and Processor_clk='1') then
                        if (processor_rst_n = RESET_ACTIVE) then
                            Irq               <= (not C_IRQ_ACTIVE);
                        else
                            if (current_state = GEN_PULSE) then
                              Irq               <= C_IRQ_ACTIVE;
                            else
                              Irq               <= not C_IRQ_ACTIVE;
                            end if;
                        end if;
                    end if;
                end process GEN_IRQ_AND_ADDR_P;

                Interrupt_address <= (others => '0');

            end generate IRQ_EDGE_MB_CLK_GEN;

            --end generate IRQ_EDGE_NORMAL_GEN;

    end generate IRQ_EDGE_GEN;

    --Read data in Normal mode (C_HAS_FAST = 0)
    OUTPUT_DATA_NORMAL_GEN: if (C_HAS_FAST = 0) generate
    -----
    begin
    -----
        ------------------------------------------------------------------------
        -- Process OUTPUT_DATA_GEN_P for generating Rd_data
        ------------------------------------------------------------------------
        OUTPUT_DATA_GEN_P: process (read, Reg_addr, isr_out, ipr, ier_out,
                                    ilr_out, ivr_out, mer) is
        -----
        begin
        -----
            if (read = '1') then
                case Reg_addr(6 downto 0) is
                    when "0000000"  => Rd_data <= isr_out; -- ISR (R/W)
                    when "0000001"  => Rd_data <= ipr;     -- IPR (Read only)
                    when "0000010"  => Rd_data <= ier_out; -- IER (R/W)
                    when "0000110"  => Rd_data <= ivr_out; -- IVR (Read only)
                    when "0000111"  => Rd_data <= mer;     -- MER (R/W)
                    when "0001001"  => Rd_data <= ilr_out; -- ILR (R(W)
                               -- IAR, SIE, CIE (Write only)
                    -- coverage off
                    when others     => Rd_data <= (others => '0');
                    -- coverage on
                end case;
            else
                Rd_data <= (others => '0');
            end if;
        end process OUTPUT_DATA_GEN_P;

    end generate OUTPUT_DATA_NORMAL_GEN;

    --Read data in mixed mode (C_HAS_FAST = 1) and C_EN_CASCADE_MODE = 1 and C_CASCADE_MASTER = 1
    CASCADE_OP_DATA_FAST_GEN: if ((C_HAS_FAST = 1)        and
                                  (C_EN_CASCADE_MODE = 1)
                                  ) generate
        -----
        begin
        -----
        ------------------------------------------------------------------------
        -- Process OUTPUT_DATA_GEN_P for generating Rd_data
        ------------------------------------------------------------------------
        OUTPUT_DATA_GEN_P: process (read        ,
                                    read_ivar   ,
                                    Reg_addr    ,
                                    isr_out     ,
                                    ipr         ,
                                    ier_out     ,
                                    ilr_out     ,
                                    ivr_out     ,
                                    mer         ,
                                    imr_out     ,
                                    ivar_rd_data_axi_clk,
                                    Interrupt_address_in_reg_int,
                                    ier                 ,
                                    isr                 ,
                                    isr_ored_30_0_bits) is
        begin
        -----
            if (read = '1') then
                case Reg_addr(6 downto 0) is
                    when "0000000"  => Rd_data <= isr_out; -- ISR (R/W)
                    when "0000001"  => Rd_data <= ipr;     -- IPR (Read only)
                    when "0000010"  => Rd_data <= ier_out; -- IER (R/W)
                    when "0000110"  => Rd_data <= ivr_out; -- IVR (Read only)
                    when "0000111"  => Rd_data <= mer;     -- MER (R/W)
                    when "0001000"  => Rd_data <= imr_out; -- IMR (R/W)
                    when "0001001"  => Rd_data <= ilr_out; -- ILR (R(W)
                               -- IAR, SIE, CIE (Write only)
                    -- coverage off
                    when others     => Rd_data <= (others => '0');
                    -- coverage on
                end case;
            elsif (read_ivar = '1') then              -- read IVAR of 31st bit in case the interrupt is present
                   if((isr(31) = '1')   and           -- else to read IVAR of lower modules the processor has to
                      (ier(31) = '1')   and           -- initiate the transaction for lower module separately
                      (isr_ored_30_0_bits = '0')
                      )then
                          Rd_data <= Interrupt_address_in_reg_int;
                   else
                          Rd_data <= ivar_rd_data_axi_clk;
                   end if;
            else
                Rd_data <= (others => '0');
            end if;
        end process OUTPUT_DATA_GEN_P;

    end generate CASCADE_OP_DATA_FAST_GEN;
    --------------------------------------------------------------------------
    NO_CASCADE_OP_DATA_FAST_GEN: if (C_HAS_FAST = 1)        and
                                    (C_CASCADE_MASTER = 0)  and
                                    (C_EN_CASCADE_MODE = 0)
                                    generate
        -----
        begin
        -----

        ------------------------------------------------------------------------
        -- Process OUTPUT_DATA_GEN_P for generating Rd_data
        ------------------------------------------------------------------------
        OUTPUT_DATA_GEN_P: process (read        ,
                                    read_ivar   ,
                                    Reg_addr    ,
                                    isr_out     ,
                                    ipr         ,
                                    ier_out     ,
                                    ilr_out     ,
                                    ivr_out     ,
                                    mer         ,
                                    imr_out     ,
                                    ivar_rd_data_axi_clk) is
        begin

            if (read = '1') then
                case Reg_addr(6 downto 0) is
                    when "0000000"  => Rd_data <= isr_out; -- ISR (R/W)
                    when "0000001"  => Rd_data <= ipr;     -- IPR (Read only)
                    when "0000010"  => Rd_data <= ier_out; -- IER (R/W)
                    when "0000110"  => Rd_data <= ivr_out; -- IVR (Read only)
                    when "0000111"  => Rd_data <= mer;     -- MER (R/W)
                    when "0001000"  => Rd_data <= imr_out; -- IMR (R/W)
                    when "0001001"  => Rd_data <= ilr_out; -- ILR (R(W)
                               -- IAR, SIE, CIE (Write only)
                    -- coverage off
                    when others     => Rd_data <= (others => '0');
                    -- coverage on
                end case;
            elsif (read_ivar = '1') then
                Rd_data <= ivar_rd_data_axi_clk;
            else
                Rd_data <= (others => '0');
            end if;
        end process OUTPUT_DATA_GEN_P;

    end generate NO_CASCADE_OP_DATA_FAST_GEN;
    --------------------------------------------------------------------------

end imp;
