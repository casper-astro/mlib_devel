-------------------------------------------------------------------------------
-- $Id: cntr_incr_decr_addn_f.vhd,v 1.1 2008/01/17 22:12:37 dougt Exp $
-------------------------------------------------------------------------------
-- cntr_incr_decr_addn_f - entity / architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        cntr_incr_decr_addn_f.vhd
--
-- Description:     This counter can increment, decrement or skip ahead
--                  by an arbitrary amount.
--
--                  If Reset is active, the value Cnt synchronously resets
--                  to all ones. (This reset value, different than the
--                  customary reset value of zero, caters to the original
--                  application of cntr_incr_decr_addn_f as the address
--                  counter for srl_fifo_rbu_f.)
--
--                  Otherwise, on each Clk, one is added to Cnt if Incr is
--                  asserted and one is subtracted if Decr is asserted. (If
--                  both are asserted, then there is no change to Cnt.)
--
--                  If Decr is not asserted, then the input value,
--                  Nm_to_add, is added. (Simultaneous assertion of Incr
--                  would add one more.) If Decr is asserted, then
--                  N_to_add, is ignored, i.e., it is possible to decrement
--                  by one or add N, but not both, and Decr overrides. 
--
--                  The value that Cnt will take on at the next clock
--                  is available as Cnt_p1.
--
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              cntr_incr_decr_addn_f.vhd
--
-------------------------------------------------------------------------------
--
-- History:
--   FLO   12/30/05   First Version.
--
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
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      predecessor value by # clks:            "*_p#"
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
--
entity cntr_incr_decr_addn_f is
  generic (
    C_SIZE   : natural;
    C_FAMILY : string  := "nofamily"
  );
  port (
    Clk           : in  std_logic;
    Reset         : in  std_logic; -- Note: the counter resets to all ones!
    Incr          : in  std_logic;
    Decr          : in  std_logic;
    N_to_add      : in  std_logic_vector(C_SIZE-1 downto 0);
    Cnt           : out std_logic_vector(C_SIZE-1 downto 0);
    Cnt_p1        : out std_logic_vector(C_SIZE-1 downto 0)
  );
end entity cntr_incr_decr_addn_f;


---(
library proc_common_v3_00_a;
library ieee;
use     ieee.numeric_std.UNSIGNED;
use     ieee.numeric_std."+";
library unisim;
use     unisim.all; -- Make unisim entities available for default binding.
--
architecture imp of cntr_incr_decr_addn_f is

  use proc_common_v3_00_a.family_support;
  use family_support.all; -- primitives_type, primitive_array_type, supported

  constant COUNTER_PRIMS_AVAIL : boolean :=
               supported(C_FAMILY, (u_MUXCY_L, u_XORCY, u_FDS));

  signal cnt_i             : std_logic_vector(Cnt'range);  
  signal cnt_i_p1          : std_logic_vector(Cnt'range);

   ---------------------------------------------------------------------------- 
   -- Unisim components declared locally for maximum avoidance of default
   -- binding and vcomponents version issues.
   ---------------------------------------------------------------------------- 
  component MUXCY_L
      port
      (
          LO : out std_ulogic;
          CI : in std_ulogic;
          DI : in std_ulogic;
          S : in std_ulogic
      );
  end component;

  component XORCY
      port
      (
          O : out std_ulogic;
          CI : in std_ulogic;
          LI : in std_ulogic
      );
  end component;

  component FDS
      generic
      (
          INIT : bit := '1'
      );
      port
      (
          Q : out std_ulogic;
          C : in std_ulogic;
          D : in std_ulogic;
          S : in std_ulogic
      );
  end component;

begin  -- architecture imp

  ---(
  STRUCTURAL_A_GEN : if COUNTER_PRIMS_AVAIL = true generate

    signal hsum_A            : std_logic_vector(Cnt'range);
    signal cry               : std_logic_vector(Cnt'length downto 0);
    
  begin
  
    ---(
    cry(0) <= Incr;
  
    Addr_Counters : for I in cnt_i'range generate
  
      hsum_A(I) <= ((Decr or N_to_add(i)) xor cnt_i(I));
  
      MUXCY_L_I : component MUXCY_L
        port map (
          DI => cnt_i(I),
          CI => cry(I),
          S  => hsum_A(I),
          LO => cry(I+1));
  
      XORCY_I : component XORCY
        port map (
          LI => hsum_A(I),
          CI => cry(I),
          O  => cnt_i_p1(I));
  
      FDS_I : component FDS
        port map (
          Q  => cnt_i(I),
          C  => Clk,
          D  => cnt_i_p1(I),
          S  => Reset);
  
    end generate Addr_Counters;
    ---) 
  
  end generate STRUCTURAL_A_GEN;
  ---)

  ---(
  INFERRED_GEN : if COUNTER_PRIMS_AVAIL = false generate
    --
    CNT_I_P1_PROC : process( cnt_i, N_to_add, Decr, Incr
                         ) is
        --
        function qual_n_to_add(N_to_add : std_logic_vector;
                           Decr : std_logic
                          ) return UNSIGNED is
            variable r: UNSIGNED(N_to_add'range);
        begin
            for i in r'range loop
                r(i) := N_to_add(i) or Decr;
            end loop;
            return r;
        end;
        --
        function to_singleton_unsigned(s : std_logic) return unsigned is
            variable r : unsigned(0 to 0) := (others => s);
        begin
            return r;
        end;
        --
    begin
        cnt_i_p1 <= std_logic_vector(   UNSIGNED(cnt_i)
                                      + qual_n_to_add(N_to_add, Decr)
                                      + to_singleton_unsigned(Incr)
                                    );
    end process;
    --
    CNT_I_PROC : process(Clk) is
    begin
        if Clk'event and Clk = '1' then
            if Reset = '1' then
                cnt_i <= (others => '1');
            else
                cnt_i <= cnt_i_p1;
            end if;
        end if;
    end process;
    --
  end generate INFERRED_GEN;
  ---)

  Cnt    <= cnt_i; 
  Cnt_p1 <= cnt_i_p1; 

end architecture imp;
---)
