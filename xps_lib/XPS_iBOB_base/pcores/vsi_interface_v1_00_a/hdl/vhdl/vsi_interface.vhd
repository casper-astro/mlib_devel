-------------------------------------------------------------------------------
--                                                                           --
--  Center for Astronomy Signal Processing and Electronics Research          --
--  http://seti.ssl.berkeley.edu/casper/                                     --
--  Copyright (C) 2006 University of California, Berkeley                    --
--                                                                           --
--  This program is free software; you can redistribute it and/or modify     --
--  it under the terms of the GNU General Public License as published by     --
--  the Free Software Foundation; either version 2 of the License, or        --
--  (at your option) any later version.                                      --
--                                                                           --
--  This program is distributed in the hope that it will be useful,          --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of           --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            --
--  GNU General Public License for more details.                             --
--                                                                           --
--  You should have received a copy of the GNU General Public License along  --
--  with this program; if not, write to the Free Software Foundation, Inc.,  --
--  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.              --
--                                                                           --
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- vsi_interface - entity/architecture pair
-------------------------------------------------------------------------------
--
--
-------------------------------------------------------------------------------
-- Filename:        vsi_interface.vhd
--
-- Description:     VSI connector interface
--
--
-------------------------------------------------------------------------------
-- Structure:   This section should show the hierarchical structure of the
--              designs. Separate lines with blank lines if necessary to improve
--              readability.
--
--              vsi_interface.vhd
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;
-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-- Definition of Generics:
--
-- Definition of Ports:
--          Clkin_p                -- Positive input clock
--          Clkin_m                -- Negative input clock
--          Clkout                 -- Output clock
--
-------------------------------------------------------------------------------

entity vsi_interface is
    generic (
        CONNECTOR       :   in  integer := 0
    );
    port (
        -- GLOBAL CONTROL SIGNALS -------------------------------
        clk             :   in  std_logic                       ;
        -- IN FROM APPLICATION ----------------------------------
        BS              :   in  std_logic_vector (31 downto 0)  ;
        ONEPPS          :   in  std_logic                       ;
        PVALID          :   in  std_logic                       ;
        CLOCK           :   in  std_logic                       ;
        PCTRL           :   in  std_logic                       ;
        PDATA           :   in  std_logic                       ;
        PSPARE1         :   in  std_logic                       ;
        PSPARE2         :   in  std_logic                       ;
        -- OUT TO VSI CONNECTOR ---------------------------------
        VSI_BS_P        :   out std_logic_vector (31 downto 0)  ;
        VSI_ONEPPS_P    :   out std_logic                       ;
        VSI_PVALID_P    :   out std_logic                       ;
        VSI_CLOCK_P     :   out std_logic                       ;
        VSI_PCTRL_P     :   out std_logic                       ;
        VSI_PDATA_P     :   out std_logic                       ;
        VSI_PSPARE1_P   :   out std_logic                       ;
        VSI_PSPARE2_P   :   out std_logic                       ;
        VSI_BS_N        :   out std_logic_vector (31 downto 0)  ;
        VSI_ONEPPS_N    :   out std_logic                       ;
        VSI_PVALID_N    :   out std_logic                       ;
        VSI_CLOCK_N     :   out std_logic                       ;
        VSI_PCTRL_N     :   out std_logic                       ;
        VSI_PDATA_N     :   out std_logic                       ;
        VSI_PSPARE1_N   :   out std_logic                       ;
        VSI_PSPARE2_N   :   out std_logic
    );

end entity vsi_interface;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture IMP of vsi_interface is

    ----------------------------------------------
    -- Polarity translation signals
    ----------------------------------------------
    signal  r_bs        :   std_logic_vector (31 downto 0)  ;
    signal  r_onepps    :   std_logic                       ;
    signal  r_pvalid    :   std_logic                       ;
    signal  r_vsiclock  :   std_logic                       ;
    signal  r_pctrl     :   std_logic                       ;
    signal  r_pdata     :   std_logic                       ;
    signal  r_pspare1   :   std_logic                       ;
    signal  r_pspare2   :   std_logic                       ;

    signal  BSn         :   std_logic_vector (31 downto 0)  ;
    signal  ONEPPSn     :   std_logic                       ;
    signal  PVALIDn     :   std_logic                       ;
    signal  CLOCKn      :   std_logic                       ;
    signal  PCTRLn      :   std_logic                       ;
    signal  PDATAn      :   std_logic                       ;
    signal  PSPARE1n    :   std_logic                       ;
    signal  PSPARE2n    :   std_logic                       ;

    ----------------------------------------------
    -- IOB register
    ----------------------------------------------
    component FD
        port (
            C : in  std_logic   ;
            D : in  std_logic   ;
            Q : out std_logic
        );
    end component;

    attribute IOB : string ;

    attribute IOB of FD_ONEPPS  : label is "true" ;
    attribute IOB of FD_PVALID  : label is "true" ;
    attribute IOB of FD_CLOCK   : label is "true" ;
    attribute IOB of FD_PCTRL   : label is "true" ;
    attribute IOB of FD_PDATA   : label is "true" ;
    attribute IOB of FD_PSPARE1 : label is "true" ;
    attribute IOB of FD_PSPARE2 : label is "true" ;

    ----------------------------------------------
    -- Differential output buffer
    ----------------------------------------------
    component OBUFDS
        port (
            I   :   in  std_logic  ;
            O   :   out std_logic  ;
            OB  :   out std_logic
        );
    end component;

begin

--------------------------------------------------
-- Polarity translation
--------------------------------------------------
-- bs       <= DAS_BS(31 downto 16) & not DAS_BS(15 downto 0) ;
-- onepps   <= not DAS_onepps    ;
-- pvalid   <= not DAS_PVALID  ;
-- vsiclock <= not DAS_CLOCK   ;
-- pctrl    <= DAS_PCTRL   ;
-- pdata    <= DAS_PDATA   ;
-- pspare1  <= DAS_PSPARE1 ;
-- pspare2  <= DAS_PSPARE2 ;

BSn      <= not BS       ;
ONEPPSn  <= not ONEPPS   ;
PVALIDn  <= not PVALID   ;
CLOCKn   <= not CLOCK    ;
PCTRLn   <= not PCTRL    ;
PDATAn   <= not PDATA    ;
PSPARE1n <= not PSPARE1  ;
PSPARE2n <= not PSPARE2  ;


--------------------------------------------------
-- IOB registers
--------------------------------------------------
BS31_16_GEN: if CONNECTOR = 1 generate
    BS31_16_IOB_FF_GEN : for i in 31 downto 16 generate
        attribute IOB of FD_BS31_16 : label is "true" ;
    begin
        FD_BS31_16 : FD
            port map (  C => clk, D => BS(i), Q => r_bs(i)  );
    end generate;
end generate;

BSn31_16_GEN: if CONNECTOR = 0 generate
    BSn31_16_IOB_FF_GEN : for i in 31 downto 16 generate
        attribute IOB of FD_BS31_16 : label is "true" ;
    begin
        FD_BS31_16 : FD
            port map (  C => clk, D => BSn(i), Q => r_bs(i) );
    end generate;
end generate;

BS15_0_IOB_FF_GEN : for i in 15 downto 0 generate
    attribute IOB of FD_BS15_0 : label is "true" ;
begin
    FD_BS15_0 : FD
        port map (  C => clk, D => BS(i), Q => r_bs(i)    );
end generate;

FD_onepps : FD
    port map (  C => clk, D => ONEPPS, Q => r_onepps    );
FD_PVALID : FD
    port map (  C => clk, D => PVALID, Q => r_pvalid  );
FD_CLOCK : FD
    port map (  C => clk, D => CLOCK, Q => r_vsiclock );
FD_PCTRL : FD
    port map (  C => clk, D => PCTRLn, Q => r_pctrl    );
FD_PDATA : FD
    port map (  C => clk, D => PDATAn, Q => r_pdata    );
FD_PSPARE1 : FD
    port map (  C => clk, D => PSPARE1n, Q => r_pspare1    );
FD_PSPARE2 : FD
    port map (  C => clk, D => PSPARE2n, Q => r_pspare2    );

--------------------------------------------------
-- BS differential output buffers
--------------------------------------------------
OBUFDS_BS0 : OBUFDS
    port map (  I => r_bs(0),  O => VSI_BS_P(0),  OB => VSI_BS_N(0)   );
OBUFDS_BS1 : OBUFDS
    port map (  I => r_bs(1),  O => VSI_BS_P(1),  OB => VSI_BS_N(1)   );
OBUFDS_BS2 : OBUFDS
    port map (  I => r_bs(2),  O => VSI_BS_P(2),  OB => VSI_BS_N(2)   );
OBUFDS_BS3 : OBUFDS
    port map (  I => r_bs(3),  O => VSI_BS_P(3),  OB => VSI_BS_N(3)   );
OBUFDS_BS4 : OBUFDS
    port map (  I => r_bs(4),  O => VSI_BS_P(4),  OB => VSI_BS_N(4)   );
OBUFDS_BS5 : OBUFDS
    port map (  I => r_bs(5),  O => VSI_BS_P(5),  OB => VSI_BS_N(5)   );
OBUFDS_BS6 : OBUFDS
    port map (  I => r_bs(6),  O => VSI_BS_P(6),  OB => VSI_BS_N(6)   );
OBUFDS_BS7 : OBUFDS
    port map (  I => r_bs(7),  O => VSI_BS_P(7),  OB => VSI_BS_N(7)   );
OBUFDS_BS8 : OBUFDS
    port map (  I => r_bs(8),  O => VSI_BS_P(8),  OB => VSI_BS_N(8)   );
OBUFDS_BS9 : OBUFDS
    port map (  I => r_bs(9),  O => VSI_BS_P(9),  OB => VSI_BS_N(9)   );
OBUFDS_BS10 : OBUFDS
    port map (  I => r_bs(10), O => VSI_BS_P(10), OB => VSI_BS_N(10)  );
OBUFDS_BS11 : OBUFDS
    port map (  I => r_bs(11), O => VSI_BS_P(11), OB => VSI_BS_N(11)  );
OBUFDS_BS12 : OBUFDS
    port map (  I => r_bs(12), O => VSI_BS_P(12), OB => VSI_BS_N(12)  );
OBUFDS_BS13 : OBUFDS
    port map (  I => r_bs(13), O => VSI_BS_P(13), OB => VSI_BS_N(13)  );
OBUFDS_BS14 : OBUFDS
    port map (  I => r_bs(14), O => VSI_BS_P(14), OB => VSI_BS_N(14)  );
OBUFDS_BS15 : OBUFDS
    port map (  I => r_bs(15), O => VSI_BS_P(15), OB => VSI_BS_N(15)  );
OBUFDS_BS16 : OBUFDS
    port map (  I => r_bs(16), O => VSI_BS_P(16), OB => VSI_BS_N(16)  );
OBUFDS_BS17 : OBUFDS
    port map (  I => r_bs(17), O => VSI_BS_P(17), OB => VSI_BS_N(17)  );
OBUFDS_BS18 : OBUFDS
    port map (  I => r_bs(18), O => VSI_BS_P(18), OB => VSI_BS_N(18)  );
OBUFDS_BS19 : OBUFDS
    port map (  I => r_bs(19), O => VSI_BS_P(19), OB => VSI_BS_N(19)  );
OBUFDS_BS20 : OBUFDS
    port map (  I => r_bs(20), O => VSI_BS_P(20), OB => VSI_BS_N(20)  );
OBUFDS_BS21 : OBUFDS
    port map (  I => r_bs(21), O => VSI_BS_P(21), OB => VSI_BS_N(21)  );
OBUFDS_BS22 : OBUFDS
    port map (  I => r_bs(22), O => VSI_BS_P(22), OB => VSI_BS_N(22)  );
OBUFDS_BS23 : OBUFDS
    port map (  I => r_bs(23), O => VSI_BS_P(23), OB => VSI_BS_N(23)  );
OBUFDS_BS24 : OBUFDS
    port map (  I => r_bs(24), O => VSI_BS_P(24), OB => VSI_BS_N(24)  );
OBUFDS_BS25 : OBUFDS
    port map (  I => r_bs(25), O => VSI_BS_P(25), OB => VSI_BS_N(25)  );
OBUFDS_BS26 : OBUFDS
    port map (  I => r_bs(26), O => VSI_BS_P(26), OB => VSI_BS_N(26)  );
OBUFDS_BS27 : OBUFDS
    port map (  I => r_bs(27), O => VSI_BS_P(27), OB => VSI_BS_N(27)  );
OBUFDS_BS28 : OBUFDS
    port map (  I => r_bs(28), O => VSI_BS_P(28), OB => VSI_BS_N(28)  );
OBUFDS_BS29 : OBUFDS
    port map (  I => r_bs(29), O => VSI_BS_P(29), OB => VSI_BS_N(29)  );
OBUFDS_BS30 : OBUFDS
    port map (  I => r_bs(30), O => VSI_BS_P(30), OB => VSI_BS_N(30)  );
OBUFDS_BS31 : OBUFDS
    port map (  I => r_bs(31), O => VSI_BS_P(31), OB => VSI_BS_N(31)  );

--------------------------------------------------
-- onepps differential output buffers
--------------------------------------------------
OBUFDS_onepps : OBUFDS
    port map (  I => r_onepps, O => VSI_ONEPPS_P, OB => VSI_ONEPPS_N  );

--------------------------------------------------
-- PVALID differential output buffers
--------------------------------------------------
OBUFDS_PVALID : OBUFDS
    port map (  I => r_pvalid, O => VSI_PVALID_P, OB => VSI_PVALID_N  );

--------------------------------------------------
-- CLOCK differential output buffers
--------------------------------------------------
OBUFDS_CLOCK : OBUFDS
    port map (  I => r_vsiclock, O => VSI_CLOCK_P, OB => VSI_CLOCK_N  );

--------------------------------------------------
-- PCTRL differential output buffers
--------------------------------------------------
OBUFDS_PCTRL : OBUFDS
    port map (  I => r_pctrl, O => VSI_PCTRL_P, OB => VSI_PCTRL_N );

--------------------------------------------------
-- PDATA differential output buffers
--------------------------------------------------
OBUFDS_PDATA : OBUFDS
    port map (  I => r_pdata, O => VSI_PDATA_P, OB => VSI_PDATA_N );

--------------------------------------------------
-- PSPARE differential output buffers
--------------------------------------------------
OBUFDS_PSPARE1 : OBUFDS
    port map (  I => r_pspare1, O => VSI_PSPARE1_P, OB => VSI_PSPARE1_N   );
OBUFDS_PSPARE2 : OBUFDS
    port map (  I => r_pspare2, O => VSI_PSPARE2_P, OB => VSI_PSPARE2_N   );

end IMP;
