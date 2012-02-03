-------------------------------------------------------------------------------
-- $Id: mux_onehot.vhd,v 1.1 2001/11/08 18:16:08 tise Exp $
-------------------------------------------------------------------------------
-- mux_onehot - arch and entity
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        mux_onehot.vhd
--
-- Description:     Parameterizable multiplexer with one hot select lines
--                  
--
-------------------------------------------------------------------------------
-- Structure:   
--
--              mux_onehot.vhd
--------------------------------------------------------------------------------
-- Author:      Bert Tise
-- History:
--  Bert Tise      2/22/01      -- First version
---------------------------------------------------------------------------------
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
-- Generic definitions:
--
--      C_DW: Data width of buses entering the mux. Valid range is 1 to 256.
--      C_NB: Number of data buses entering the mux. Valid range is 1 to 64.
--
--      The input data is represented by a one-dimensional bus that is made up
--      of all of the data buses concatenated together. For example, a 4 to 1
--      mux with 2 bit data buses (C_DW=2,C_NB=4) is represented by:
--          
--        D = (Bus0Data0, Bus0Data1, Bus1Data0, Bus1Data1, Bus2Data0, Bus2Data1,
--             Bus3Data0, Bus3Data1)
--      
--      There is a separate select line for EACH data bit, leaving it to the 
--      user to set fanout on the select lines before using this mux. The select
--      bus into the mux is created by concatenating the one-hot select bus for
--      a single output bit as many times as needed for the data width. Continuing
--      the 4 to 1, 2 bit example from above:
--
--        S = (Sel0Data0,Sel1Data0,Sel2Data0,Sel3Data0,
--             Sel0Data1,Sel1Data1,Sel2Data1,Sel3Data1)
--  
library ieee;
use ieee.std_logic_1164.all;

library Unisim;
use Unisim.all;

entity mux_onehot is 
   generic( C_DW: integer := 32;
            C_NB: integer := 5 );
   port(
      D: in std_logic_vector(0 to C_DW*C_NB-1);
      S: in std_logic_vector(0 to C_DW*C_NB-1);
      Y: out std_logic_vector(0 to C_DW-1));

end mux_onehot;

architecture imp of mux_onehot is

component MUXCY is
  port (
    O  : out std_logic;
    CI : in  std_logic;
    DI : in  std_logic;
    S  : in  std_logic
  );
end component MUXCY;

signal Dreord:      std_logic_vector(0 to C_DW*((C_NB+1)/2)*2-1);
signal sel:         std_logic_vector(0 to C_DW*((C_NB+1)/2)*2-1);
signal lutout:      std_logic_vector(0 to (C_DW*(C_NB+1)/2)-1); 
signal cyout:       std_logic_vector(0 to (C_DW*(C_NB+1)/2)-1); 
signal PWR:         std_logic := '1';
signal GNDS:        std_logic := '0';


begin

-- Reorder data buses

REORD: process( D )
variable m,n: integer;
begin

for m in 0 to C_DW-1 loop
  for n in 0 to C_NB-1 loop
    Dreord( m*C_NB+n) <= D( n*C_DW+m );
  end loop;
end loop;
end process REORD;

-- Handle case for even number of buses

EVEN_GEN: if C_NB rem 2 = 0 and C_NB /= 2 generate
    DATA_WIDTH_GEN: for i in 0 to C_DW-1 generate

        lutout(i*(C_NB+1)/2) <= not((Dreord(i*C_NB)   and S(i*C_NB)) or
                                    (Dreord(i*C_NB+1) and S(i*C_NB+1)));
        CYMUX_FIRST: MUXCY
            port map (CI=>'0',
                      DI=>'1',
                      S=>lutout(i*(C_NB+1)/2),
                      O=>cyout(i*(C_NB+1)/2));

        NUM_BUSES_GEN: for j in 1 to (C_NB+1)/2-1 generate
            lutout(i*(C_NB+1)/2+j) <= not((Dreord(i*C_NB+j*2)   and S(i*C_NB+j*2)) or
                                          (Dreord(i*C_NB+j*2+1) and S(i*C_NB+j*2+1)));
            CARRY_MUX: MUXCY
                port map (CI=>cyout(i*(C_NB+1)/2+j-1),
                          DI=>'1',
                          S=>lutout(i*(C_NB+1)/2+j),
                          O=>cyout(i*(C_NB+1)/2+j));
        end generate;
    Y(i) <= cyout(i*(C_NB+1)/2+(C_NB+1)/2-1);
    end generate;
end generate;

-- Handle case for odd number of buses

ODD_GEN: if C_NB rem 2 /= 0 and C_NB /= 1 generate
    DATA_WIDTH_GEN: for i in 0 to C_DW-1 generate
        lutout(i*(C_NB+1)/2) <= not((Dreord(i*C_NB)   and S(i*C_NB)) or
                                    (Dreord(i*C_NB+1) and S(i*C_NB+1)));
        CYMUX_FIRST: MUXCY
            port map (CI=>'0',
                      DI=>'1',
                      S=>lutout(i*(C_NB+1)/2),
                      O=>cyout(i*(C_NB+1)/2));

        NUM_BUSES_GEN: for j in 1 to (C_NB+1)/2-2 generate
            lutout(i*(C_NB+1)/2+j) <= not((Dreord(i*C_NB+j*2)   and S(i*C_NB+j*2)) or
                                          (Dreord(i*C_NB+j*2+1) and S(i*C_NB+j*2+1)));
            CARRY_MUX: MUXCY
                port map (CI=>cyout(i*(C_NB+1)/2+j-1),
                          DI=>'1',
                          S=>lutout(i*(C_NB+1)/2+j),
                          O=>cyout(i*(C_NB+1)/2+j));
        end generate;
        
        ODD_BUS_GEN: for j in (C_NB+1)/2-1 to (C_NB+1)/2-1 generate
            lutout(i*(C_NB+1)/2+j) <= not((Dreord(i*C_NB+j*2)   and S(i*C_NB+j*2)));
            CARRY_MUX: MUXCY
                port map (CI=>cyout(i*(C_NB+1)/2+j-1),
                          DI=>'1',
                          S=>lutout(i*(C_NB+1)/2+j),
                          O=>cyout(i*(C_NB+1)/2+j));
        end generate;
    Y(i) <= cyout(i*(C_NB+1)/2+(C_NB+1)/2-1);
    end generate;
end generate;

ONE_GEN: if C_NB = 1 generate
    Y <= D;
end generate;

TWO_GEN: if C_NB = 2 generate
    DATA_WIDTH_GEN2: for i in 0 to C_DW-1 generate
        lutout(i*(C_NB+1)/2) <= ((Dreord(i*C_NB)   and S(i*C_NB)) or
                                 (Dreord(i*C_NB+1) and S(i*C_NB+1)));
        Y(i) <= lutout(i*(C_NB+1)/2);
    end generate;
end generate;   

end imp;
            
                      

