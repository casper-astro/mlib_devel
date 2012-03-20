-------------------------------------------------------------------------------
-- $Id: srl_fifo.vhd,v 1.4 2003/06/29 21:50:43 jcanaris Exp $
-------------------------------------------------------------------------------
-- SRL_FIFO entity and architecture
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        srl_fifo.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              srl_fifo.vhd
--
-------------------------------------------------------------------------------
-- Author:          goran
-- Revision:        $Revision: 1.4 $
-- Date:            $Date: 2003/06/29 21:50:43 $
--
-- History:
--   goran  2001-05-11    First Version
--   KC     2001-06-20    Added Addr as an output port, for use as an occupancy
--                        value
--   MSH    2002-03-12    Changed Asynchronous reset to a synchronous reset
--
--   DCW    2002-03-12    Structural implementation of synchronous reset for
--                        Data_Exists DFF (using FDR)
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
library IEEE;
use IEEE.std_logic_1164.all;
library unisim;
use unisim.all;

entity SRL_FIFO is
  generic (
    C_DATA_BITS : natural := 8;
    C_DEPTH     : natural := 16
    );
  port (
    Clk         : in  std_logic;
    Reset       : in  std_logic;
    FIFO_Write  : in  std_logic;
    Data_In     : in  std_logic_vector(0 to C_DATA_BITS-1);
    FIFO_Read   : in  std_logic;
    Data_Out    : out std_logic_vector(0 to C_DATA_BITS-1);
    FIFO_Full   : out std_logic;
    Data_Exists : out std_logic;
    Addr        : out std_logic_vector(0 to 3) -- Added Addr as a port
    );

end entity SRL_FIFO;

architecture IMP of SRL_FIFO is

  component SRL16E is
      -- pragma translate_off
    generic (
      INIT : bit_vector := X"0000"
      );
      -- pragma translate_on    
    port (
      CE  : in  std_logic;
      D   : in  std_logic;
      Clk : in  std_logic;
      A0  : in  std_logic;
      A1  : in  std_logic;
      A2  : in  std_logic;
      A3  : in  std_logic;
      Q   : out std_logic);
  end component SRL16E;

  component LUT4
    generic(
      INIT : bit_vector := X"0000"
      );
    port (
      O  : out std_logic;
      I0 : in  std_logic;
      I1 : in  std_logic;
      I2 : in  std_logic;
      I3 : in  std_logic);
  end component;

  component MULT_AND
    port (
      I0 : in  std_logic;
      I1 : in  std_logic;
      LO : out std_logic);
  end component;

  component MUXCY_L
    port (
      DI : in  std_logic;
      CI : in  std_logic;
      S  : in  std_logic;
      LO : out std_logic);
  end component;

  component XORCY
    port (
      LI : in  std_logic;
      CI : in  std_logic;
      O  : out std_logic);
  end component;

  component FDRE is
    port (
      Q  : out std_logic;
      C  : in  std_logic;
      CE : in  std_logic;
      D  : in  std_logic;
      R  : in  std_logic);
  end component FDRE;

  component FDR is
    port (
      Q  : out std_logic;
      C  : in  std_logic;
      D  : in  std_logic;
      R  : in  std_logic);
  end component FDR;

  signal addr_i       : std_logic_vector(0 to 3);  
  signal buffer_Full  : std_logic;
  signal buffer_Empty : std_logic;

  signal next_Data_Exists : std_logic;
  signal data_Exists_I    : std_logic;

  signal valid_Write : std_logic;

  signal hsum_A  : std_logic_vector(0 to 3);
  signal sum_A   : std_logic_vector(0 to 3);
  signal addr_cy : std_logic_vector(0 to 4);
  
begin  -- architecture IMP

  buffer_Full <= '1' when (addr_i = "1111") else '0';
  FIFO_Full   <= buffer_Full;

  buffer_Empty <= '1' when (addr_i = "0000") else '0';

  next_Data_Exists <= (data_Exists_I and not buffer_Empty) or
                      (buffer_Empty and FIFO_Write) or
                      (data_Exists_I and not FIFO_Read);

  Data_Exists_DFF : FDR
    port map (
      Q  => data_Exists_I,            -- [out std_logic]
      C  => Clk,                      -- [in  std_logic]
      D  => next_Data_Exists,         -- [in  std_logic]
      R  => Reset);                   -- [in std_logic]

  Data_Exists <= data_Exists_I;
  
  valid_Write <= FIFO_Write and (FIFO_Read or not buffer_Full);

  addr_cy(0) <= valid_Write;

  Addr_Counters : for I in 0 to 3 generate

    hsum_A(I) <= (FIFO_Read xor addr_i(I)) and (FIFO_Write or not buffer_Empty);

    MUXCY_L_I : MUXCY_L
      port map (
        DI => addr_i(I),                  -- [in  std_logic]
        CI => addr_cy(I),               -- [in  std_logic]
        S  => hsum_A(I),                -- [in  std_logic]
        LO => addr_cy(I+1));            -- [out std_logic]

    XORCY_I : XORCY
      port map (
        LI => hsum_A(I),                -- [in  std_logic]
        CI => addr_cy(I),               -- [in  std_logic]
        O  => sum_A(I));                -- [out std_logic]

    FDRE_I : FDRE
      port map (
        Q  => addr_i(I),                  -- [out std_logic]
        C  => Clk,                      -- [in  std_logic]
        CE => data_Exists_I,            -- [in  std_logic]
        D  => sum_A(I),                 -- [in  std_logic]
        R  => Reset);                   -- [in std_logic]

  end generate Addr_Counters;

  FIFO_RAM : for I in 0 to C_DATA_BITS-1 generate
    SRL16E_I : SRL16E
      -- pragma translate_off
      generic map (
        INIT => x"0000")
      -- pragma translate_on
      port map (
        CE  => valid_Write,             -- [in  std_logic]
        D   => Data_In(I),              -- [in  std_logic]
        Clk => Clk,                     -- [in  std_logic]
        A0  => addr_i(0),                 -- [in  std_logic]
        A1  => addr_i(1),                 -- [in  std_logic]
        A2  => addr_i(2),                 -- [in  std_logic]
        A3  => addr_i(3),                 -- [in  std_logic]
        Q   => Data_Out(I));            -- [out std_logic]
  end generate FIFO_RAM;
  
-------------------------------------------------------------------------------
-- INT_ADDR_PROCESS
-------------------------------------------------------------------------------
-- This process assigns the internal address to the output port
-------------------------------------------------------------------------------
  INT_ADDR_PROCESS:process (addr_i)
  begin   -- process
    Addr <= addr_i;
  end process;
  

end architecture IMP;
