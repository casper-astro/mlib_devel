-------------------------------------------------------------------------------
-- $Id: priority_register_logic.vhd,v 1.3 2006/06/02 06:04:03 chandanm Exp $
-------------------------------------------------------------------------------
-- OPB Arbiter - Priority Register Logic
-------------------------------------------------------------------------------
--
--  ***************************************************************************
--  **  Copyright(C) 2003 by Xilinx, Inc. All rights reserved.               **
--  **                                                                       **
--  **  This text contains proprietary, confidential                         **
--  **  information of Xilinx, Inc. , is distributed by                      **
--  **  under license from Xilinx, Inc., and may be used,                    **
--  **  copied and/or disclosed only pursuant to the terms                   **
--  **  of a valid license agreement with Xilinx, Inc.                       **
--  **                                                                       **
--  **  Unmodified source code is guaranteed to place and route,             **
--  **  function and run at speed according to the datasheet                 **
--  **  specification. Source code is provided "as-is", with no              **
--  **  obligation on the part of Xilinx to provide support.                 **
--  **                                                                       **
--  **  Xilinx Hotline support of source code IP shall only include          **
--  **  standard level Xilinx Hotline support, and will only address         **
--  **  issues and questions related to the standard released Netlist        **
--  **  version of the core (and thus indirectly, the original core source). **
--  **                                                                       **
--  **  The Xilinx Support Hotline does not have access to source            **
--  **  code and therefore cannot answer specific questions related          **
--  **  to source HDL. The Xilinx Support Hotline will only be able          **
--  **  to confirm the problem in the Netlist version of the core.           **
--  **                                                                       **
--  **  This copyright and support notice must be retained as part           **
--  **  of this text at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        priority_register_logic.vhd
-- Version:         v1.02e
-- Description:     
--                  This file contains the priority registers and the logic to 
--                  update the registers for a LRU algorithm if the design is 
--                  parameterized for dynamic priority and dynamic priority
--                  has been enabled in the control register. The number of 
--                  priority levels is determined by the number of masters. 
--                  There is a priority register for each priority level 
--                  containing the id of the master at that priority level. The
--                  master id's are right justified in each register. Each 
--                  register is padded with leading zeros.
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--
--              opb_arbiter.vhd
--                --opb_arbiter_core.vhd
--                  -- ipif_regonly_slave.vhd
--                  -- priority_register_logic.vhd
--                      -- priority_reg.vhd
--                      -- onehot2encoded.vhd
--                          -- or_bits.vhd
--                  -- control_register.vhd
--                  -- arb2bus_data_mux.vhd
--                      -- mux_onehot.vhd
--                      -- or_bits.vhd
--                  -- watchdog_timer.vhd
--                  -- arbitration_logic.vhd
--                      -- or_bits.vhd
--                  -- park_lock_logic.vhd
--                      -- or_bits.vhd
--                      -- or_gate.vhd
--                          -- or_muxcy.vhd
-------------------------------------------------------------------------------
-- Author:      ALS
-- History:
--  ALS         08/28/01        -- Version 1.01a creation to include IPIF v1.22a
--  ALS         10/04/01        -- Version 1.02a creation to include IPIF v1.23a
--  ALS         11/27/01
-- ^^^^^^
--  Version 1.02b created to fix registered grant problem.
-- ~~~~~~
--  ALS         01/26/02
-- ^^^^^^
--  Created version 1.02c to fix problem with registered grants, and buslock when
--  the buslock master is holding request high and performing conversion cycles.
-- ~~~~~~
--  ALS         01/09/03
-- ^^^^^^
--  Created version 1.02d to register OPB_timeout to improve timing
-- ~~~~~~
--  bsbrao      09/27/04
-- ^^^^^^
--  Created version 1.02e to upgrade IPIF from opb_ipif_v1_23_a to 
--  opb_ipif_v3_01_a 
-- ~~~~~~
-- chandan      05/25/06
-- ^^^^^^
-- Modified the process  MASTER_LOOP to remove the latch it was creating. 
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
-- 
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_arith.conv_std_logic_vector;

--
-- library unsigned is used for overloading of '=' which allows integer to
-- be compared to std_logic_vector
use ieee.std_logic_unsigned.all;
--
-- Library OPB_ARBITER contains the package OPB_ARB_PKG with contant definitions
library opb_arbiter_v1_02_e;
use opb_arbiter_v1_02_e.opb_arb_pkg.all;

-- Library UNISIM contains Xilinx primitives
library unisim;
use unisim.all;
------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--      C_NUM_MASTERS               -- number of masters
--      C_OPBDATA_WIDTH             -- width of OPB data bus
--      C_NUM_MID_BITS              -- number of bits required to encode masterIDs
--      C_DYNAM_PRIORITY            -- dynamic priority is supported
--
-- Definition of Ports:
--    
--        -- Master Grant signals
--        input MGrant              -- Active high Master grant signals
--        input MGrant_n            -- Active low Master grant signals
--
--        -- IPIF interface
--        input Bus2ip_data         -- Data from OPB bus
--        input Bus2Ip_Reg_WrCE     -- Clock enables for priority regs
--
--        -- Control register interface
--        input Dpen                -- Dynamic priority enable
--        input Prv                 -- Priority registers valid
--
--        -- Priority register output
--        output Priority_register  -- Priority register with leading zeros
--        output Priority_IDs       -- Master IDs for each priority level
--
--        input Clk                 -- Clock
--        input Rst                 -- Reset
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
entity priority_register_logic is
    generic (   C_NUM_MASTERS       : integer   := 16;
                C_OPBDATA_WIDTH     : integer   := 32;
                C_NUM_MID_BITS      : integer   := 4;
                C_DYNAM_PRIORITY    : boolean   := true
            );
  port (
        MGrant              : in std_logic_vector(0 to C_NUM_MASTERS-1);
        MGrant_n            : in std_logic_vector(0 to C_NUM_MASTERS-1);
        Bus2IP_Data         : in std_logic_vector(0 to C_OPBDATA_WIDTH-1 );
        Bus2IP_Reg_WrCE     : in std_logic_vector(0 to C_NUM_MASTERS-1);
        Dpen                : in std_logic;
        Prv                 : in std_logic;
        Priority_register   : out std_logic_vector(0 to C_NUM_MASTERS*C_OPBDATA_WIDTH-1);
        Priority_IDs        : out std_logic_vector(0 to C_NUM_MASTERS*C_NUM_MID_BITS-1);
        Clk                 : in std_logic;
        Rst                 : in std_logic
        );
 
 
end priority_register_logic;




-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------
architecture implementation of priority_register_logic is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
-- pad number of masters to nearest power of 2 
constant NUM_MSTRS_PAD  : integer   := pad_power2(C_NUM_MASTERS);

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------   
-- Internal priority register  
signal priority_register_i : std_logic_vector(0 to C_NUM_MASTERS*C_OPBDATA_WIDTH-1);

-- Internal master ids at each priority level
signal priority_ids_i   : std_logic_vector(0 to C_NUM_MASTERS*C_NUM_MID_BITS-1);

-- create default set of priority IDs for use when the Prv bit is negated 
-- indicating that the priority registers are being updated by the processor
signal default_ids      : std_logic_vector(0 to C_NUM_MASTERS*C_NUM_MID_BITS-1);

-- Register shift controls
-- Set default to zeros, if dynamic priority is not supported, this bus will
-- stay zero.
signal shift            : std_logic_vector(0 to C_NUM_MASTERS-1) := (others => '0');

-- ID of master granted the bus, defaults to zero if dynamic priority is not 
-- supported.
signal granted_mid      : std_logic_vector(0 to C_NUM_MID_BITS-1) := (others => '0'); 

-- Need active low grant signals to properly drive select lines of muxes 
-- this bus will use NUM_MSTRS_PAD so that bus is sized to nearest power of 2.
-- Bus defaults to '0', only the bits up to C_NUM_MASTERS
-- will get assigned a real value.
signal mgrant_n_pad : std_logic_vector(0 to NUM_MSTRS_PAD-1) := (others => '0');

-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
-- The PRIORITY_REG component provides registers for each priority level
-- containing the id of the master at that priority level.
-------------------------------------------------------------------------------
  
component priority_reg 
  generic (
           C_RESET_VALUE    : std_logic_vector;
           C_NUM_MID_BITS   : integer   := 2;
           C_OPBDATA_WIDTH  : integer   := 32
           );
  port (
        Priorreg_wrce   : in std_logic;  
        Bus2Ip_Data     : in std_logic_vector(0 to C_OPBDATA_WIDTH-1);  
        Dpen            : in std_logic;  
        Shift           : in std_logic;  
        Master_id_in    : in std_logic_vector(0 to C_NUM_MID_BITS-1); 
        Master_id_out   : out std_logic_vector(0 to C_NUM_MID_BITS-1);
        Priority        : out std_logic_vector(0 to C_OPBDATA_WIDTH-1);  
        Clk             : in std_logic;
        Rst             : in std_logic
        );
 
end component priority_reg;


-------------------------------------------------------------------------------
-- The shift logic is basically an OR function of the granted priority levels.
-- Each priority register shifts if the grant was at the same or higher priority
-- level. LVL0 priority register shifts if the grant was at LVL0 priority. LVL1
-- priority register shifts if the grant was at LVL0 or LVL1 priority. LVLn-1 
-- priority register shifts if the grant was at LVL0 - LVLn-1 priority. The LVLn
-- priority register always shifts in the Master ID of the last grant.
-- This OR function is accomplished using the carry chain muxes.
-------------------------------------------------------------------------------
component MUXCY
  port (
    O   : out std_logic;
    CI  : in std_logic;
    DI  : in std_logic;
    S   : in std_logic
  );
end component MUXCY;

-------------------------------------------------------------------------------
-- The ONEHOT2ENCODED component is used to determine the master ID that was
-- just granted the bus for shifting into the lowest priority register when
-- dynamic priority is supported.
-------------------------------------------------------------------------------

component onehot2encoded 
    generic (
            C_1HOT_BUS_SIZE : integer   := 8
            );
    port    (
            Bus_1hot     : in    std_logic_vector(0 to C_1HOT_BUS_SIZE-1);
            Bus_enc      : out   std_logic_vector(0 to log2(C_1HOT_BUS_SIZE)-1)
            );
end component onehot2encoded;

begin

-------------------------------------------------------------------------------
-- Assign internal priority register to output ports
-- Use default priority IDs when the priority registers are being updated, i.e.
-- PRV=0.
-------------------------------------------------------------------------------
Priority_register <= priority_register_i;
Priority_IDs      <= priority_ids_i when Prv = '1' 
                       else default_ids;

-- Create the default master IDs for each priority level
-- The default is that LVL0 = Master 0, LVL1 = Master 1, LVLn = Mastern
DEF_IDS_GEN: for i in 0 to C_NUM_MASTERS-1 generate
-- create default set of priority IDs for use when the Prv bit is negated 
-- indicating that the priority registers are being updated by the processor
begin
    default_ids(i*C_NUM_MID_BITS to i*C_NUM_MID_BITS+C_NUM_MID_BITS-1) <=
                conv_std_logic_vector(i, C_NUM_MID_BITS);
end generate DEF_IDS_GEN;

-- assign the padded mgrant_n bus the MGrant_n signals
mgrant_n_pad(0 to C_NUM_MASTERS-1) <= MGrant_n;
-------------------------------------------------------------------------------
-- Dynamic Priority Support
-------------------------------------------------------------------------------
-- If the design has been parameterized for each master, have to first decode
-- the grant signals with the current priority register values to determine
-- which priority level was granted the bus. This is then used to determine
-- which priority registers need to shift in the master ID from the lower
-- priority registers. If dynamic priority is not supported, the shift controls
-- are left at their default value of 0.
-------------------------------------------------------------------------------
DYNAM_PRIORITY_GEN: if C_DYNAM_PRIORITY generate

-- one-hot active-low indicator of which priority level was granted the bus
signal grant_lvl_n  : std_logic_vector(0 to C_NUM_MASTERS-1);

begin

    MASTER_LOOP:    for i in 0 to C_NUM_MASTERS-1 generate
    
        -- decode each master ID in the priority registers to determine
        -- which priority level was granted the bus
        
         MASTER_4 : if C_NUM_MID_BITS = 4 generate
	      signal priority_ids_int : std_logic_vector(0 to 3);
	      begin
	   
	        priority_ids_int  <= priority_ids_i(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
	         
	        DECODE_REQ_PROCESS: process(mgrant_n_pad, priority_ids_int)
	        begin
	          case priority_ids_int is
	            when "0000"  => grant_lvl_n(i) <= mgrant_n_pad(0);
	            when "0001"  => grant_lvl_n(i) <= mgrant_n_pad(1);
	            when "0010"  => grant_lvl_n(i) <= mgrant_n_pad(2);
	            when "0011"  => grant_lvl_n(i) <= mgrant_n_pad(3);
	            when "0100"  => grant_lvl_n(i) <= mgrant_n_pad(4);
	            when "0101"  => grant_lvl_n(i) <= mgrant_n_pad(5);
	            when "0110"  => grant_lvl_n(i) <= mgrant_n_pad(6);
	            when "0111"  => grant_lvl_n(i) <= mgrant_n_pad(7);
	            when "1000"  => grant_lvl_n(i) <= mgrant_n_pad(8);
	            when "1001"  => grant_lvl_n(i) <= mgrant_n_pad(9);
	            when "1010"  => grant_lvl_n(i) <= mgrant_n_pad(10);
	            when "1011"  => grant_lvl_n(i) <= mgrant_n_pad(11);
	            when "1100"  => grant_lvl_n(i) <= mgrant_n_pad(12);
	            when "1101"  => grant_lvl_n(i) <= mgrant_n_pad(13);
	            when "1110"  => grant_lvl_n(i) <= mgrant_n_pad(14);
	            when others  => grant_lvl_n(i) <= mgrant_n_pad(15);
	          end case;
	        end process DECODE_REQ_PROCESS;
	       
	  end generate MASTER_4;
	  
	  MASTER_3 : if C_NUM_MID_BITS = 3 generate
	        signal priority_ids_int : std_logic_vector(0 to 2);
	        begin
	     
	          priority_ids_int  <= priority_ids_i(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
	           
	          DECODE_REQ_PROCESS: process(mgrant_n_pad, priority_ids_int)
	          begin
	            case priority_ids_int is
	              when "000"  => grant_lvl_n(i) <= mgrant_n_pad(0);
	              when "001"  => grant_lvl_n(i) <= mgrant_n_pad(1);
	              when "010"  => grant_lvl_n(i) <= mgrant_n_pad(2);
	              when "011"  => grant_lvl_n(i) <= mgrant_n_pad(3);
	              when "100"  => grant_lvl_n(i) <= mgrant_n_pad(4);
	              when "101"  => grant_lvl_n(i) <= mgrant_n_pad(5);
	              when "110"  => grant_lvl_n(i) <= mgrant_n_pad(6);
	              when others  => grant_lvl_n(i) <= mgrant_n_pad(7);
	            end case;
	          end process DECODE_REQ_PROCESS;
	         
	  end generate MASTER_3;
	  
	  MASTER_2 : if C_NUM_MID_BITS = 2 generate
	        signal priority_ids_int : std_logic_vector(0 to 1);
	        begin
	     
	          priority_ids_int  <= priority_ids_i(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
	           
	          DECODE_REQ_PROCESS: process(mgrant_n_pad, priority_ids_int)
	          begin
	            case priority_ids_int is
	              when "00"  => grant_lvl_n(i) <= mgrant_n_pad(0);
	              when "01"  => grant_lvl_n(i) <= mgrant_n_pad(1);
	              when "10"  => grant_lvl_n(i) <= mgrant_n_pad(2);
	              when others  => grant_lvl_n(i) <= mgrant_n_pad(3);
	            end case;
	          end process DECODE_REQ_PROCESS;
	         
	  end generate MASTER_2;
	  
	  MASTER_1 : if C_NUM_MID_BITS = 1 generate
	        signal priority_ids_int : std_logic_vector (0 to 0);
	        begin
	     
	          priority_ids_int  <= priority_ids_i(i*C_NUM_MID_BITS to (i*C_NUM_MID_BITS)+C_NUM_MID_BITS-1);
	           
	          DECODE_REQ_PROCESS: process(mgrant_n_pad, priority_ids_int)
	          begin
	            case priority_ids_int is
	              when "0"  => grant_lvl_n(i) <= mgrant_n_pad(0);
	              when others  => grant_lvl_n(i) <= mgrant_n_pad(1);
	            end case;
	          end process DECODE_REQ_PROCESS;
	         
  end generate MASTER_1;
  
        -- generate the OR chain which determines the shift signals for the
        -- priority registers. LVL0 shifts if GRANT_LVL0 was asserted, LVL1
        -- shifts if GRANT_LVL0 or GRANT_LVL1 was asserted, LVLn shifts if
        -- any grants LVL0 - LVLn were asserted
        
        MUX0_GEN: if i = 0 generate
            MUX_LVL0: MUXCY
               port map (
                 O  =>  shift(i),       --[out]
                 CI =>  '0',            --[in]
                 DI =>  '1',            --[in]
                 S  =>  grant_lvl_n(i)  --[in]
               );
        end generate MUX0_GEN;
        
        OTHER_MUXES: if i /= 0 generate
            MUX_LVLS: MUXCY
              port map (
                O   =>  shift(i),       --[out]
                CI  =>  shift(i-1),     --[in]
                DI  =>  '1',            --[in]
                S   =>  grant_lvl_n(i)  --[in]
              );
        end generate OTHER_MUXES;
    end generate MASTER_LOOP;
    
    -- have to encode the grant signals to the proper Master ID for shifting
    -- into the lowest priority register

    GRANT_MID_ENC: onehot2encoded
        generic map( C_1HOT_BUS_SIZE => C_NUM_MASTERS)
        port map (
                    Bus_1hot => MGrant,
                    Bus_enc  => granted_mid
                  );
    
end generate DYNAM_PRIORITY_GEN;
            
-------------------------------------------------------------------------------
-- Priority Registers
-------------------------------------------------------------------------------
-- The following instantiations  of PRIORITY_REG provide registers for each
-- priority level which hold the id of the master at that priority level. There
-- is a priority register for each master. The default reset condition is that
-- Master 0 is at level 0 priority, Master 1 is at level 1 priority, etc.
-- Note that if dynamic priority is not supported, DPEN is set to zero and the
-- SHIFT control is set to zero.
--
-- Also note that if dynamic priority is supported, the lowest level priority
-- register shifts in the granted master id. If dynamic priority is not 
-- supported, this ID is set to zeros since it will be unused.
-------------------------------------------------------------------------------
PRIOR_REG_GEN:  for i in 0 to C_NUM_MASTERS-1 generate
    
    LAST_REG: if i = C_NUM_MASTERS-1 generate
    
        LOW_PRIOR_REG: priority_reg
            generic map (   
                        C_RESET_VALUE       => conv_std_logic_vector(i, C_NUM_MID_BITS),
                        C_NUM_MID_BITS      => C_NUM_MID_BITS,
                        C_OPBDATA_WIDTH    => C_OPBDATA_WIDTH
                        )
            port map (
                    Priorreg_wrce   => Bus2IP_Reg_WrCE(i), 
                    Bus2Ip_Data     => Bus2IP_Data,
                    Dpen            => Dpen,
                    Shift           => shift(i),
                    Master_id_in    => granted_mid,
                    Master_id_out   => priority_ids_i(i*C_NUM_MID_BITS to 
                                                      i*C_NUM_MID_BITS + C_NUM_MID_BITS-1),
                    Priority        => priority_register_i(i*C_OPBDATA_WIDTH to
                                                      i*C_OPBDATA_WIDTH + C_OPBDATA_WIDTH-1),
                    Clk             => Clk,
                    Rst             => Rst
                    );
    end generate LAST_REG;
     
    OTHER_REGS: if i /= C_NUM_MASTERS-1 generate
    
        PRIOR_REG: priority_reg
            generic map (   
                        C_RESET_VALUE       => conv_std_logic_vector(i, C_NUM_MID_BITS),
                        C_NUM_MID_BITS      => C_NUM_MID_BITS,
                        C_OPBDATA_WIDTH    => C_OPBDATA_WIDTH
                        )
            port map (
                    Priorreg_wrce   => Bus2IP_Reg_WrCE(i),
                    Bus2Ip_Data     => Bus2IP_Data,
                    Dpen            => Dpen,
                    Shift           => shift(i),
                    Master_id_in    => priority_ids_i((i+1)*C_NUM_MID_BITS to 
                                                      (i+1)*C_NUM_MID_BITS + C_NUM_MID_BITS-1),
                    Master_id_out   => priority_ids_i(i*C_NUM_MID_BITS to 
                                                      i*C_NUM_MID_BITS + C_NUM_MID_BITS-1),
                    Priority        => priority_register_i(i*C_OPBDATA_WIDTH to
                                                      i*C_OPBDATA_WIDTH + C_OPBDATA_WIDTH-1),
                    Clk             => Clk,
                    Rst             => Rst
                    );
     end generate OTHER_REGS;
end generate PRIOR_REG_GEN;


 

 
end implementation;
