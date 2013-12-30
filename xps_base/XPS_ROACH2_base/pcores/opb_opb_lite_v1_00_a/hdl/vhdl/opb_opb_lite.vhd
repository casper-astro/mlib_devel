--SINGLE_FILE_TAG
-------------------------------------------------------------------------------
-- $Id: opb_opb_lite.vhd,v 1.8 2006/07/25 12:49:06 chandanm Exp $
-------------------------------------------------------------------------------
-- OPB_OPB_Lite - entity/architecture pair
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
-- Filename:        opb_opb_lite.vhd
-- Version:         v1.00a
-- Description:     Simple reduced functionality OPB to OPB bridge
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              opb_opb_lite.vhd
--
-------------------------------------------------------------------------------
-- @BEGIN_CHANGELOG EDK_Im_SP1 
-- Updated the sensetivity list of the process BRIDGE_SM_COMB_PROC for the
-- signal mopb_timeout.
-- @END_CHANGELOG 
-------------------------------------------------------------------------------

-- Author:      BLT
-- History:
--  BLT             1-10-2002      -- First version
-- ^^^^^^
--      First version of simple OPB to OPB bridge.
-- ~~~~~~
--  DB              12-22-2003
-- ^^^^^^
--      Fixed master data bus to no longer mirror the slave databus during
--      read operations. Fixes the problem where incorrect data was returned
--      during read operations
-- ~~~~~~
-- Chandan  	    06-30-2006 
-- ^^^^^^
-- Updated the sensetivity list of the process BRIDGE_SM_COMB_PROC for the
-- signal mopb_timeout.
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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_misc.all;
library Unisim;
use Unisim.all;
library Proc_Common_v1_00_a;
use Proc_Common_v1_00_a.pselect;

-------------------------------------------------------------------------------
-- Port declarations
-------------------------------------------------------------------------------

entity OPB_OPB_Lite is
  generic (
    C_NUM_DECODES       : integer range 1 to 4 := 1;
    C_DEC0_BASEADDR     : std_logic_vector := X"2000_0000";
    C_DEC0_HIGHADDR     : std_logic_vector := X"2000_FFFF";
    C_DEC1_BASEADDR     : std_logic_vector := X"7000_0000";
    C_DEC1_HIGHADDR     : std_logic_vector := X"7000_FFFF";
    C_DEC2_BASEADDR     : std_logic_vector := X"5000_0000";
    C_DEC2_HIGHADDR     : std_logic_vector := X"5FFF_FFFF";
    C_DEC3_BASEADDR     : std_logic_vector := X"6000_0000";
    C_DEC3_HIGHADDR     : std_logic_vector := X"6FFF_FFFF";
    C_OPB_DWIDTH        : integer := 32;
    C_OPB_AWIDTH        : integer := 32
    );   
  port (
    -- OPB signals (Slave Side)
    SOPB_Clk           : in  std_logic;
    SOPB_Rst           : in  std_logic;
    SOPB_ABus          : in  std_logic_vector(0 to C_OPB_AWIDTH-1);
    SOPB_BE            : in  std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    SOPB_DBus          : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    SOPB_RNW           : in  std_logic;
    SOPB_select        : in  std_logic;
    SOPB_seqAddr       : in  std_logic;
    Sl_DBus            : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    Sl_errAck          : out std_logic;
    Sl_retry           : out std_logic;
    Sl_toutSup         : out std_logic;
    Sl_xferAck         : out std_logic;
    
    -- OPB signals (Master Side)
    MOPB_Clk           : in  std_logic;
    MOPB_Rst           : in  std_logic;
    M_ABus             : out std_logic_vector(0 to C_OPB_AWIDTH-1);
    M_BE               : out std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    M_busLock          : out std_logic;
    M_DBus             : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    M_request          : out std_logic;
    M_RNW              : out std_logic;
    M_select           : out std_logic;
    M_seqAddr          : out std_logic;
    MOPB_DBus          : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    MOPB_errAck        : in  std_logic;
    MOPB_MGrant        : in  std_logic;
    MOPB_retry         : in  std_logic;
    MOPB_timeout       : in  std_logic;
    MOPB_xferAck       : in  std_logic
    );
end entity OPB_OPB_Lite;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture IMP of OPB_OPB_Lite is

type int_array_type is 
  array (0 to C_NUM_DECODES-1) of integer;
type int_array_type4 is 
  array (0 to 3) of integer;
type slv_array_type is
  array (0 to 3) of std_logic_vector(0 to C_OPB_AWIDTH-1);
  
function Addr_Bits (x,y : std_logic_vector(0 to C_OPB_AWIDTH-1)) 
return integer is
  variable addr_nor : std_logic_vector(0 to C_OPB_AWIDTH-1);
begin
  addr_nor := x xor y;
  for i in 0 to C_OPB_AWIDTH-1 loop
    if addr_nor(i)='1' then return i;
    end if;
  end loop;
  return(C_OPB_AWIDTH);
end function Addr_Bits;

function max(x0 : integer; 
             x1 : integer; 
             x2 : integer;
             x3 : integer;
             n  : integer) return integer is
  variable maxval : integer;           
begin
  maxval := x0;
  if x1 > maxval and n>1 then maxval := x1; end if;
  if x2 > maxval and n>2 then maxval := x2; end if;
  if x3 > maxval and n>3 then maxval := x3; end if;
  return maxval;
end function max;

component pselect is  
  generic (
    C_AB     : integer;
    C_AW     : integer;
    C_BAR    : std_logic_vector(0 to 31)
    );
  port (
    A        : in   std_logic_vector(0 to C_AW-1);
    AValid   : in   std_logic;
    CS       : out  std_logic
    );
end component pselect;

component FDC is
  port (
    Q   : out std_logic;
    C   : in std_logic;
    CLR : in std_logic;
    D   : in std_logic
  );
end component FDC;

component FDR is
  port (
    Q : out std_logic;
    C : in  std_logic;
    D : in  std_logic;
    R : in  std_logic
  );
end component FDR;

-- Address decode signals
signal decode_Select         : std_logic_vector(0 to C_NUM_DECODES-1);
signal errack_d              : std_logic;
signal M_request_in          : std_logic;
signal M_select_in           : std_logic;
signal M_select_internal     : std_logic;
signal m_select_internal_not : std_logic;
signal opb_ABus_Reg          : std_logic_vector(0 to C_OPB_AWIDTH-1);
signal opb_RNW_Reg           : std_logic;
signal opb_select_Reg        : std_logic;
signal retry_d               : std_logic;
signal Sl_xferAck_copy       : std_logic;
signal Sl_xferAck_copy_not   : std_logic;
signal sopb_select_not       : std_logic;
signal sopb_dbus_reset       : std_logic;
signal valid_Access          : std_logic;
signal xferack_d             : std_logic;
signal M_int_RNW             : std_logic;
signal OPB_select_int_Reg    : std_logic;
signal M_DBus_enable_n       : std_logic;

constant C_BASEADDR_ARRAY    : slv_array_type := 
  (C_DEC0_BASEADDR,C_DEC1_BASEADDR,C_DEC2_BASEADDR,C_DEC3_BASEADDR);
   
constant C_MEM_AB            : int_array_type4 := (
  Addr_Bits(C_DEC0_BASEADDR,C_DEC0_HIGHADDR),
  Addr_Bits(C_DEC1_BASEADDR,C_DEC1_HIGHADDR),
  Addr_Bits(C_DEC2_BASEADDR,C_DEC2_HIGHADDR),
  Addr_Bits(C_DEC3_BASEADDR,C_DEC3_HIGHADDR));

constant MAX_AB              : integer := max(C_MEM_AB(0),
                                             C_MEM_AB(1),
                                             C_MEM_AB(2),
                                             C_MEM_AB(3),
                                             C_NUM_DECODES);
                                             
type Bridge_State_Machine is (Idle,Request_State,Select_State,Clear_Decode1,
                              Clear_Decode2);
signal bridge_state_current  : Bridge_State_Machine;
signal bridge_state_next     : Bridge_State_Machine;
-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------

begin -- architecture IMP
 
  -----------------------------------------------------------------------------
  -- Register all the OPB input signals
  -----------------------------------------------------------------------------

  m_select_internal_not <= not M_select_in;
  
  BE_FF_GENERATE: for i in 0 to C_OPB_DWIDTH/8-1 generate
    BE_FF_I: FDR  
    port map (
      Q    => M_BE(i),              -- [out]
      C    => SOPB_Clk,             -- [in]
      D    => SOPB_BE(i),           -- [in]
      R    => m_select_internal_not -- [in]
    );
  end generate BE_FF_GENERATE;
  
  ABUS_DEC_FF_GENERATE: for i in 0 to C_OPB_AWIDTH-1 generate
    ABUS_FF_I: FDR  
    port map (
      Q    => OPB_ABus_Reg(i),  -- [out]
      C    => SOPB_Clk,         -- [in]
      D    => SOPB_ABus(i),     -- [in]
      R    => SOPB_Rst          -- [in]
    );
  end generate ABUS_DEC_FF_GENERATE;

  ABUS_FF_GENERATE: for i in 0 to C_OPB_AWIDTH-1 generate
    ABUS_FF_I: FDR 
    port map (
      Q    => M_ABus(i),            -- [out]
      C    => SOPB_Clk,             -- [in]
      D    => SOPB_ABus(i),         -- [in]
      R    => m_select_internal_not -- [in]
    );
  end generate ABUS_FF_GENERATE;
  
  RNW_FF_I: FDR  
  port map (
    Q    => M_RNW,                  -- [out]
    C    => SOPB_Clk,               -- [in]
    D    => SOPB_RNW,               -- [in]
    R    => m_select_internal_not   -- [in]
  );

  RNW_INT_FF_I: FDC  
  port map (
    Q    => M_int_RNW,              -- [out]
    C    => SOPB_Clk,               -- [in]
    D    => SOPB_RNW,               -- [in]
    CLR  => SOPB_Rst                -- [in]
  );

  SELECT_INT_FF_I: FDC  
  port map (
    Q    => OPB_select_int_Reg,     -- [out]
    C    => SOPB_Clk,               -- [in]
    D    => SOPB_select,            -- [in]
    CLR  => SOPB_Rst                -- [in]
  );

  SEQADDR_FF_I: FDR  
  port map (
    Q    => M_seqAddr,              -- [out]
    C    => SOPB_Clk,               -- [in]
    D    => SOPB_seqAddr,           -- [in]
    R    => m_select_internal_not   -- [in]
  );
  
-- Don't drive data on the Master dbus during a read or 
-- when not selected - these registers used to be reset using
-- m_select_internal_not, but are now also reset during read
-- operations
M_DBus_enable_n <=  not M_select_in or (M_select_in and SOPB_RNW);

  MDBUS_FF_GENERATE: for i in 0 to C_OPB_DWIDTH-1 generate
    DBUS_FF_I: FDR  
    port map (
      Q    => M_DBus(i),            -- [out]
      C    => SOPB_Clk,             -- [in]
      D    => SOPB_DBus(i),         -- [in]
      R    => M_DBus_enable_n  -- [in]
    );
  end generate MDBUS_FF_GENERATE;

  sl_xferAck_copy_not <= not Sl_xferAck_copy;
  
  SDBUS_FF_GENERATE: for i in 0 to C_OPB_DWIDTH-1 generate
    DBUS_FF_I: FDR  
    port map (
      Q    => Sl_DBus(i),         -- [out]
      C    => SOPB_Clk,           -- [in]
      D    => MOPB_DBus(i),       -- [in]
      R    => sopb_dbus_reset     -- [in]
    );
  end generate SDBUS_FF_GENERATE;

  xferack_d <= (MOPB_xferAck or MOPB_timeout) and M_select_internal;
 
  sopb_select_not <= not SOPB_select;
  sopb_dbus_reset <= not SOPB_select or not M_select_internal;
  
  -- Check on abort behavior: can these FDC's be converted to FDR's?
  
  XFERACK_FF_I: FDC  
  port map (
    Q    => Sl_xferAck,                         -- [out]
    C    => SOPB_Clk,                           -- [in]
    D    => xferack_d,                          -- [in]
    CLR  => sopb_select_not                     -- [in]
  );

  XFERACK_COPY_FF_I: FDC  
  port map (
    Q    => Sl_xferAck_copy,                    -- [out]
    C    => SOPB_Clk,                           -- [in]
    D    => xferack_d,                          -- [in]
    CLR  => sopb_select_not                     -- [in]
  );
  
  retry_d <= MOPB_retry and M_select_internal;
  
  RETRY_FF_I: FDC  
  port map (
    Q    => Sl_retry,                           -- [out]
    C    => SOPB_Clk,                           -- [in]
    D    => retry_d,                            -- [in]
    CLR  => sopb_select_not                     -- [in]
  );

  errack_d <= (MOPB_errAck or MOPB_timeout) and M_select_internal;
  
  ERRACK_FF_I: FDC  
  port map (
    Q    => Sl_errAck,                          -- [out]
    C    => SOPB_Clk,                           -- [in]
    D    => errack_d,                           -- [in]
    CLR  => sopb_select_not                     -- [in]
  );
  
  TOUTSUP_FF_I: FDC  
  port map (
    Q    => Sl_toutSup,                         -- [out]
    C    => SOPB_Clk,                           -- [in]
    D    => M_select_internal,                  -- [in]
    CLR  => sopb_select_not                     -- [in]
  );
  
  -----------------------------------------------------------------------------
  -- Address decode
  -----------------------------------------------------------------------------
  
  MEM_DECODE_GEN: for i in 0 to C_NUM_DECODES-1 generate
    MEM_SELECT_I: pselect
      generic map (
        C_AB     => C_MEM_AB(i),
        C_AW     => C_OPB_AWIDTH,
        C_BAR    => C_BASEADDR_ARRAY(i))  
      port map (
        A        => opb_ABus_Reg,         -- [in]
        AValid   => OPB_select_int_Reg,   -- [in]
        CS       => decode_Select(i));    -- [out]
  end generate MEM_DECODE_GEN;    
    
  valid_Access <= or_reduce(decode_Select);
  
  BRIDGE_SM_COMB_PROC: process(bridge_state_current,SOPB_select,
                               MOPB_MGrant,MOPB_xferAck,MOPB_retry,
                               MOPB_errAck,valid_Access,MOPB_timeout) is
  begin
    bridge_state_next <= bridge_state_current;
    M_select_in  <= '0';
    M_request_in <= '0';
    
    case bridge_state_current is

      when Idle => 
        if valid_Access='1' then
          bridge_state_next <= Request_State;
          M_request_in <= '1';
        end if;
        
      when Request_State =>
        M_request_in <= '1';
        if SOPB_select='0' then
          bridge_state_next <= Clear_Decode1;  -- abort detected
          M_request_in <= '0';
        elsif MOPB_MGrant='1' then
          bridge_state_next <= Select_State;
          M_select_in  <= '1';
          M_request_in <= '0';
        end if;
        
      when Select_State =>
        M_select_in <= '1'; 
        if SOPB_select='0'  or
           MOPB_xferAck='1' or
           MOPB_retry='1'   or 
           MOPB_timeout='1' 
        then      
          bridge_state_next <= Clear_Decode1;
          M_select_in <= '0';
        end if;
      
      when Clear_Decode1 =>
        bridge_state_next <= Clear_Decode2;
    
      when Clear_Decode2 =>
        bridge_state_next <= Idle;
    
    end case;
  end process BRIDGE_SM_COMB_PROC;        
  
  BRIDGE_SM_SEQ_PROC: process (SOPB_Clk) is
  begin
    if SOPB_Clk'event and SOPB_Clk='1' then
      if SOPB_Rst='1' then
        bridge_state_current <= Idle;
        M_select  <= '0';
        M_select_internal  <= '0';
        M_request <= '0';
      else
        bridge_state_current <= bridge_state_next;
        M_select  <= M_select_in;
        M_select_internal  <= M_select_in;
        M_request <= M_request_in;
      end if;
    end if;
  end process BRIDGE_SM_SEQ_PROC;

  M_busLock <= '0';
  
end architecture IMP;
