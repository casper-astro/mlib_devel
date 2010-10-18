--******************************************************************************
--
--  Xilinx, Inc. 2002                 www.xilinx.com
--
--  XAPP 253 - Synthesizable DDR SDRAM Controller
--
--*******************************************************************************
--
--  File name :       clk_dcm.vhd
--
--  Description :     This module generates the system clock for controller block
--                    This also generates the recapture clock, clock for the
--                    Refresh counter and also for the data path
--
--  Date - revision : 05/01/2002
--
--  Author :          Lakshmi Gopalakrishnan ( Modified by Padmaja Sannala)
--
--  Contact : e-mail  hotline@xilinx.com
--            phone   + 1 800 255 7778 
--
--  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are 
--              provided to you "as is". Xilinx and its licensors make and you 
--              receive no warranties or conditions, express, implied, 
--              statutory or otherwise, and Xilinx specifically disclaims any 
--              implied warranties of merchantability, non-infringement, or 
--              fitness for a particular purpose. Xilinx does not warrant that 
--              the functions contained in these designs will meet your 
--              requirements, or that the operation of these designs will be 
--              uninterrupted or error free, or that defects in the Designs 
--              will be corrected. Furthermore, Xilinx does not warrant or 
--              make any representations regarding use or the results of the 
--              use of the designs in terms of correctness, accuracy, 
--              reliability, or otherwise. 
--
--              LIMITATION OF LIABILITY. In no event will Xilinx or its 
--              licensors be liable for any loss of data, lost profits, cost 
--              or procurement of substitute goods or services, or for any 
--              special, incidental, consequential, or indirect damages 
--              arising from the use or operation of the designs or 
--              accompanying documentation, however caused and on any theory 
--              of liability. This limitation will apply even if Xilinx 
--              has been advised of the possibility of such damage. This 
--              limitation shall apply not-withstanding the failure of the 
--              essential purpose of any limited remedies herein. 
--
--  Copyright © 2002 Xilinx, Inc.
--  All rights reserved 
-- 
--*****************************************************************************
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.parameter.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
--library synplify; 
--use synplify.attributes.all; 

--library work;
--use work.hispdclks_pkg_2vp20.all;

entity clk_dcm is 

port(
   input_clk   : in std_logic;
   rst         : in std_logic;
   clk         : out std_logic;
   clk90       : out std_logic;
   dcm_lock    : out std_logic
   );
end clk_dcm;

architecture arc_clk_dcm of clk_dcm is

--attribute syn_hier : string;
--attribute syn_hier of arc_clk_dcm: architecture is "hard";

component DCM
-- pragma translate_off
    generic ( 
             DLL_FREQUENCY_MODE    : string := "LOW";
             DUTY_CYCLE_CORRECTION : boolean := TRUE
            );  
-- pragma translate_on

    port ( CLKIN     : in  std_logic;
           CLKFB     : in  std_logic;
           DSSEN     : in  std_logic;
           PSINCDEC  : in  std_logic;
           PSEN      : in  std_logic;
           PSCLK     : in  std_logic;
           RST       : in  std_logic;
           CLK0      : out std_logic;
           CLK90     : out std_logic;
           CLK180    : out std_logic;
           CLK270    : out std_logic;
           CLK2X     : out std_logic;
           CLK2X180  : out std_logic;
           CLKDV     : out std_logic;
           CLKFX     : out std_logic;
           CLKFX180  : out std_logic;
           LOCKED    : out std_logic;
           PSDONE    : out std_logic;
           STATUS    : out std_logic_vector(7 downto 0)
          );
end component;

 component BUFG
  port ( I : in std_logic;
         O : out std_logic);
 end component;

 component myBUFG
  port ( I : in std_logic;
         O : out std_logic);
 end component;

 component dcmx3y0_2vp70_sim
   port (  clock1_in     : in std_logic;   
           clock2_in     : in std_logic;   
           clock1_out    : out std_logic;   
           clock2_out    : out std_logic);   
end component;

signal clk0dcm             : std_logic;
signal clk90dcm            : std_logic;
signal clk0d2inv           : std_logic;
signal clk90d2inv          : std_logic;
signal clk0_buf            : std_logic;
signal clk90_buf           : std_logic;
signal vcc                 : std_logic;
signal gnd                 : std_logic;
signal dcm1_lock           : std_logic;


attribute DLL_FREQUENCY_MODE : string; 
attribute DUTY_CYCLE_CORRECTION : string;
attribute CLKIN_DIVIDE_BY_2     : string;

---attribute syn_noclockbuf : boolean;
----attribute syn_noclockbuf of clk0_buf: signal is true;
----attribute syn_noclockbuf of clk90_buf: signal is true;

attribute DLL_FREQUENCY_MODE of DCM_INST1    : label is "LOW";
attribute DUTY_CYCLE_CORRECTION of DCM_INST1 : label is "TRUE";

begin

vcc <= '1';
gnd <= '0';

clk    <= clk0_buf;
clk90  <= clk90_buf;

DCM_INST1 :  DCM 
                 port map ( CLKIN    => input_clk,
                            CLKFB    => clk0_buf,
                            DSSEN    => gnd,
                            PSINCDEC => gnd,
                            PSEN     => gnd,
                            PSCLK    => gnd,
                            RST      => RST,
                            CLK0     => clk0dcm,
                            CLK90    => clk90dcm,
                            CLK180   => open,
                            CLK270   => open,
                            CLK2X    => open,
                            CLK2X180 => open,
                            CLKDV    => open,
                            CLKFX    => open,
                            CLKFX180 => open,
                            LOCKED   => dcm1_lock,
                            PSDONE   => open,
                            STATUS   => open);

DCD0    : dcmx3y0_2vp70_sim
        port map ( clock1_in   =>   clk0dcm,
                   clock2_in   =>   clk90dcm,
                   clock1_out  =>   clk0d2inv,
                   clock2_out  =>   clk90d2inv);

BUFG_CLK0    : myBUFG port map ( I => clk0d2inv ,
                               O => clk0_buf);
                                                              
BUFG_CLK90   : myBUFG port map ( I => clk90d2inv,
                               O => clk90_buf); 

dcm_lock <= dcm1_lock;                                 

end arc_clk_dcm;




