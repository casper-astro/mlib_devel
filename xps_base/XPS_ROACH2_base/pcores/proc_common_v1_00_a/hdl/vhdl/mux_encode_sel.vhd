-------------------------------------------------------------------------------
-- $Id: mux_encode_sel.vhd,v 1.3 2003/06/29 21:50:07 jcanaris Exp $
-------------------------------------------------------------------------------
-- mux_encode_sel - entity/architecture pair
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        mux_encode_sel_imp.vhd
-- Version:         v1.00a
-- Description:     Parameterizeable mux with binary encoded select
--                  
-------------------------------------------------------------------------------
-- Structure:   
--                  mux_encode_sel.vhd
--
-------------------------------------------------------------------------------
-- Author:          B.L. Tise
-- History:
--   BLT            2001-04-06    First Version
--   BLT            2001-05-08    Added 8:1 mux
--   BLT            2002-01-18    Changed Common to proc_common_v1_00_a
--
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

-------------------------------------------------------------------------------
-- library and use statements
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library Unisim;
use Unisim.all;
library proc_common_v1_00_a;
use proc_common_v1_00_a.Common_Types.all;

-----------------------------------------------------------------------------
-- Entity section
-----------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Definition of Generics:
--          C_TARGET        -- Xilinx target family, legal values are
--                             VIRTEX and VIRTEXII (not a string)
--          C_Y             -- Y offset from origin of RPM (family-independent
--                             coordinate system)       Y
--          C_X             -- X offset from origin     ^
--                                                      |
--                                                      |
--                                                       ----> X
--          C_U_SET         -- which USER SET the RLOC parameters belong to
--          C_DW            -- width of data buses
--          C_NB            -- number of data buses
--          C_BE            -- TRUE=Big Endian, FALSE=Little Endian
-- Definition of Ports:
--          D               -- data input (Dbus0, Dbus1, Dbus2, ...)
--          S               -- select input (S0,S1,S2,...) S0 most significant
--          Y               -- mux output Y = Dbus(S)
--          YL              -- mux output before last mux stage 
-------------------------------------------------------------------------------

entity mux_encode_sel is
  generic (
    C_TARGET : TARGET_FAMILY_TYPE := VIRTEX2; 
    C_Y      : integer := 0;
    C_X      : integer := 0;
    C_U_SET  : string := "mux_encode_sel";
    C_DW     : integer := 8;
    C_NB     : integer := 4;
    C_BE     : boolean := TRUE
    );
  port (
    D        : in   std_logic_vector(0 to C_DW*C_NB-1);
    S        : in   std_logic_vector(0 to log2(C_NB)-1);
    Y        : out  std_logic_vector(0 to C_DW-1);
    YL       : out  std_logic_vector(0 to C_DW-1)        
    );
  
end entity mux_encode_sel;

-----------------------------------------------------------------------------
-- Architecture section
-----------------------------------------------------------------------------

architecture IMP of mux_encode_sel is

  component LUT3 is
    generic(
      INIT : bit_vector := X"00"
      );
    port (
      O  : out std_logic;
      I0 : in  std_logic;
      I1 : in  std_logic;
      I2 : in  std_logic);
  end component LUT3;
  
  component MUXF5 is
     port (
       O : out std_logic;
       I0 : in std_logic;
       I1 : in std_logic;
       S : in std_logic
     );
   end component MUXF5;
   
  component MUXF5_D is
     port (
       O : out std_logic;
       LO : out std_logic;
       I0 : in std_logic;
       I1 : in std_logic;
       S : in std_logic
     );
   end component MUXF5_D;
   
   component MUXF6_D is
     port (
       O : out std_logic;
       LO : out std_logic;
       I0 : in std_logic;
       I1 : in std_logic;
       S : in std_logic
     );
   end component MUXF6_D;
   
   component MUXF6 is
     port (
       O : out std_logic;
       I0 : in std_logic;
       I1 : in std_logic;
       S : in std_logic
     );
   end component MUXF6;
   
   component MUXF7_D is
     port (
       O : out std_logic;
       LO : out std_logic;
       I0 : in std_logic;
       I1 : in std_logic;
       S : in std_logic
     );
   end component MUXF7_D;
   
   component MUXF8_D is
     port (
       O : out std_logic;
       LO : out std_logic;
       I0 : in std_logic;
       I1 : in std_logic;
       S : in std_logic
     );
   end component MUXF8_D;
   
  attribute INIT       : string;
  attribute RLOC       : string;
  attribute U_SET      : string;



-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------

begin  -- architecture imp

GEN_1: if C_NB = 1 generate
  Y  <= D;
  YL <= D;
end generate GEN_1;

GEN_2: if C_NB = 2 generate
  signal iY : std_logic_vector(0 to C_DW-1);
  begin
  GEN2_LOOP: for i in 0 to C_DW-1 generate
    signal lut_in : std_logic_vector(0 to 2);
    attribute RLOC of LUT3_I : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (C_DW-i-1)/2,
                                          X => C_X);
    attribute U_SET of LUT3_I : label is C_U_SET;
    begin
      lut_in(0 to 1) <= (D(i),D(i+C_DW));
      lut_in(2) <= S(S'right);
      LUT3_I : LUT3
        generic map(
          INIT => X"CA"
          )
        port map (
          O  => iY(i),       -- [out]
          I0 => lut_in(0),   -- [in]
          I1 => lut_in(1),   -- [in]
          I2 => lut_in(2));  -- [in]
  end generate GEN2_LOOP;
  Y  <= iY;
  YL <= iY;
end generate GEN_2;  

GEN_4: if C_NB = 4 generate
  GEN4_LOOP: for i in 0 to C_DW-1 generate
    signal lut_in0     : std_logic_vector(0 to 2);
    signal lut_in1     : std_logic_vector(0 to 2);
    signal mux_f5_in   : std_logic_vector(0 to 1);
    signal mux_f5_sel  : std_logic;
    signal mux_f5_inI0 : std_logic;
    signal mux_f5_inI1 : std_logic;
    attribute RLOC of LUT30_I : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (C_DW-i-1),
                                          X => C_X);
    attribute RLOC of LUT31_I : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (C_DW-i-1),
                                          X => C_X);
    attribute RLOC of MUXF5_I : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (C_DW-i-1),
                                          X => C_X);
    attribute U_SET of LUT30_I : label is C_U_SET;
    attribute U_SET of LUT31_I : label is C_U_SET;
    attribute U_SET of MUXF5_I : label is C_U_SET;    
    begin
      lut_in0(2) <= S(0); 
      lut_in1(2) <= S(0);
      mux_f5_sel <= S(1);
      mux_f5_inI0 <= mux_f5_in(0);
      mux_f5_inI1 <= mux_f5_in(1);
      GEN_BIGENDIAN: if C_BE     generate
        lut_in0(0 to 1) <= (D(i+0*C_DW),D(i+2*C_DW));
        lut_in1(0 to 1) <= (D(i+1*C_DW),D(i+3*C_DW));
        YL(i)           <= mux_f5_in(0);
      end generate GEN_BIGENDIAN;      
      GEN_LITENDIAN: if not C_BE generate
        lut_in0(0 to 1) <= (D(i+3*C_DW),D(i+1*C_DW));
        lut_in1(0 to 1) <= (D(i+2*C_DW),D(i+0*C_DW));
        YL(i)           <= mux_f5_in(0);
      end generate GEN_LITENDIAN;
      LUT30_I : LUT3
        generic map(
          INIT => X"CA"
          )
        port map (
          O  => mux_f5_in(0),  -- [out]
          I0 => lut_in0(0),    -- [in]
          I1 => lut_in0(1),    -- [in]
          I2 => lut_in0(2));   -- [in]
      LUT31_I : LUT3
        generic map(
          INIT => X"CA"
          )
        port map (
          O  => mux_f5_in(1),  -- [out]
          I0 => lut_in1(0),    -- [in]
          I1 => lut_in1(1),    -- [in]
          I2 => lut_in1(2));   -- [in]
      MUXF5_I: MUXF5
        port map (
          O  => Y(i),           --[out]
          I0 => mux_f5_inI0,    --[in]
          I1 => mux_f5_inI1,    --[in]
          S  => mux_f5_sel      --[in]
        );
  end generate GEN4_LOOP;
end generate GEN_4; 

GEN_8: if C_NB = 8 generate
  GEN8_LOOP: for i in 0 to C_DW-1 generate
    signal lut_in0     : std_logic_vector(0 to 2);
    signal lut_in1     : std_logic_vector(0 to 2);
    signal lut_in2     : std_logic_vector(0 to 2);
    signal lut_in3     : std_logic_vector(0 to 2);    
    signal mux_f50_in   : std_logic_vector(0 to 1);
    signal mux_f50_sel  : std_logic;
    signal mux_f50_inI0 : std_logic;
    signal mux_f50_inI1 : std_logic;
    signal mux_f51_in   : std_logic_vector(0 to 1);
    signal mux_f51_sel  : std_logic;
    signal mux_f51_inI0 : std_logic;
    signal mux_f51_inI1 : std_logic;
    signal mux_f6_in   : std_logic_vector(0 to 1);
    signal mux_f6_sel  : std_logic;
    signal mux_f6_inI0 : std_logic;
    signal mux_f6_inI1 : std_logic;
    attribute RLOC of LUT30_I  : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (2*(C_DW-i)-2),
                                          X => C_X);
    attribute RLOC of LUT31_I  : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (2*(C_DW-i)-2),
                                          X => C_X);
    attribute RLOC of MUXF50_I : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (2*(C_DW-i)-2),
                                          X => C_X);
    attribute RLOC of MUXF51_I : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (2*(C_DW-i)-1),
                                          X => C_X);
    attribute RLOC of LUT32_I  : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (2*(C_DW-i)-1),
                                          X => C_X);
    attribute RLOC of LUT33_I  : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (2*(C_DW-i)-1),
                                          X => C_X);
    attribute RLOC of MUXF6_I  : label is Get_RLOC_Name(
                                          Target => C_TARGET,
                                          Y => C_Y + (2*(C_DW-i)-2),
                                          X => C_X);
    attribute U_SET of LUT30_I  : label is C_U_SET;
    attribute U_SET of LUT31_I  : label is C_U_SET;
    attribute U_SET of LUT32_I  : label is C_U_SET;
    attribute U_SET of LUT33_I  : label is C_U_SET;
    attribute U_SET of MUXF50_I : label is C_U_SET;    
    attribute U_SET of MUXF51_I : label is C_U_SET;    
    attribute U_SET of MUXF6_I  : label is C_U_SET;    
    begin
      lut_in0(2)   <= S(0); 
      lut_in1(2)   <= S(0);
      lut_in2(2)   <= S(0); 
      lut_in3(2)   <= S(0);
      mux_f50_sel  <= S(1);
      mux_f50_inI0 <= mux_f50_in(0);
      mux_f50_inI1 <= mux_f50_in(1);
      mux_f51_sel  <= S(1);
      mux_f51_inI0 <= mux_f51_in(0);
      mux_f51_inI1 <= mux_f51_in(1);
      mux_f6_sel   <= S(2);
      mux_f6_inI0  <= mux_f6_in(0);
      mux_f6_inI1  <= mux_f6_in(1);
      GEN_BIGENDIAN: if C_BE     generate
        lut_in0(0 to 1) <= (D(i+1*C_DW),D(i+5*C_DW));
        lut_in1(0 to 1) <= (D(i+3*C_DW),D(i+7*C_DW));
        lut_in2(0 to 1) <= (D(i+0*C_DW),D(i+4*C_DW));
        lut_in3(0 to 1) <= (D(i+2*C_DW),D(i+6*C_DW));
        YL(i)           <= mux_f6_in(1);
      end generate GEN_BIGENDIAN;      
      GEN_LITENDIAN: if not C_BE generate
        lut_in0(0 to 1) <= (D(i+6*C_DW),D(i+2*C_DW));
        lut_in1(0 to 1) <= (D(i+4*C_DW),D(i+0*C_DW));
        lut_in2(0 to 1) <= (D(i+7*C_DW),D(i+3*C_DW));
        lut_in3(0 to 1) <= (D(i+5*C_DW),D(i+1*C_DW));
        YL(i)           <= mux_f6_in(1);
      end generate GEN_LITENDIAN;
      LUT30_I : LUT3
        generic map(
          INIT => X"CA"
          )
        port map (
          O  => mux_f50_in(0), -- [out]
          I0 => lut_in0(0),    -- [in]
          I1 => lut_in0(1),    -- [in]
          I2 => lut_in0(2));   -- [in]
      LUT31_I : LUT3
        generic map(
          INIT => X"CA"
          )
        port map (
          O  => mux_f50_in(1), -- [out]
          I0 => lut_in1(0),    -- [in]
          I1 => lut_in1(1),    -- [in]
          I2 => lut_in1(2));   -- [in]
      MUXF50_I: MUXF5
        port map (
          O  => mux_f6_in(1),  -- [out]
          I0 => mux_f50_inI0,  -- [in]
          I1 => mux_f50_inI1,  -- [in]
          S  => mux_f50_sel    -- [in]
        );
      LUT32_I : LUT3
        generic map(
          INIT => X"CA"
          )
        port map (
          O  => mux_f51_in(0), -- [out]
          I0 => lut_in2(0),    -- [in]
          I1 => lut_in2(1),    -- [in]
          I2 => lut_in2(2));   -- [in]
      LUT33_I : LUT3
        generic map(
          INIT => X"CA"
          )
        port map (
          O  => mux_f51_in(1), -- [out]
          I0 => lut_in3(0),    -- [in]
          I1 => lut_in3(1),    -- [in]
          I2 => lut_in3(2));   -- [in]
      MUXF51_I: MUXF5
        port map (
          O  => mux_f6_in(0),   -- [out]
          I0 => mux_f51_inI0,   -- [in]
          I1 => mux_f51_inI1,   -- [in]
          S  => mux_f51_sel     -- [in]
        );  
      MUXF6_I: MUXF6
        port map (
          O  => Y(i),           --[out]
          I0 => mux_f6_inI0,    --[in]
          I1 => mux_f6_inI1,    --[in]
          S  => mux_f6_sel      --[in]
        );  
  end generate GEN8_LOOP;
end generate GEN_8; 


end architecture IMP;

