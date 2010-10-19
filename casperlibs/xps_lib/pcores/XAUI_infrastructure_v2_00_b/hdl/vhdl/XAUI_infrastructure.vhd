--  Copyright (c) 2005-2006, Regents of the University of California
--  All rights reserved.
--
--  Redistribution and use in source and binary forms, with or without modification,
--  are permitted provided that the following conditions are met:
--
--      - Redistributions of source code must retain the above copyright notice,
--          this list of conditions and the following disclaimer.
--      - Redistributions in binary form must reproduce the above copyright
--          notice, this list of conditions and the following disclaimer
--          in the documentation and/or other materials provided with the
--          distribution.
--      - Neither the name of the University of California, Berkeley nor the
--          names of its contributors may be used to endorse or promote
--          products derived from this software without specific prior
--          written permission.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
--  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
--  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

-- ### ###   ##    ### ###  ##### 
--  #   #     #     #   #     #   
--   # #      #     #   #     #   
--   # #     # #    #   #     #   
--    #      # #    #   #     #   
--   # #    #   #   #   #     #   
--   # #    #####   #   #     #   
--  #   #   #   #   #   #     #   
-- ### ### ### ###   ###    ##### 

-- XAUI infrastructure top level

-- created by Pierre-Yves Droz 2005

------------------------------------------------------------------------------
-- XAUI_infrastructure.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.all;

entity XAUI_infrastructure is
	generic (
		CONTROL_FPGA        : integer := 0
	);        
	port (
		-- input clocks
		brefclk_top_p       : in  std_logic;
		brefclk_top_m       : in  std_logic;
		brefclk_bottom_p    : in  std_logic;
		brefclk_bottom_m    : in  std_logic;

		-- communication clocks
		lnk0_mgt_clk_top_10G     : out std_logic;
		lnk0_mgt_clk_bottom_10G  : out std_logic;
		lnk0_mgt_clk_top_8G      : out std_logic;
		lnk0_mgt_clk_bottom_8G   : out std_logic;
		lnk0_xaui_clk_top        : out std_logic;
		lnk0_xaui_clk_bottom     : out std_logic;
		lnk0_speed_select        : out std_logic;
		lnk1_mgt_clk_top_10G     : out std_logic;
		lnk1_mgt_clk_bottom_10G  : out std_logic;
		lnk1_mgt_clk_top_8G      : out std_logic;
		lnk1_mgt_clk_bottom_8G   : out std_logic;
		lnk1_xaui_clk_top        : out std_logic;
		lnk1_xaui_clk_bottom     : out std_logic;
		lnk1_speed_select        : out std_logic
	);
end entity XAUI_infrastructure;

architecture XAUI_infrastructure_arch of XAUI_infrastructure is

	component IBUFDS_LVDS_25
		port(
			I   : in  std_logic;
			IB  : in  std_logic;
			O   : out std_logic   
		);
	end component;

	component BUFG
		port (
			O   : out std_logic;
			I   : in  std_logic
		);
	end component; 

	signal mgt_clkin_top_10G                  : std_logic;
	signal mgt_clkin_bottom_10G               : std_logic;
	signal mgt_clk_top_10G                    : std_logic;
	signal mgt_clk_bottom_10G                 : std_logic;
	signal xaui_clk_top                       : std_logic;
	signal xaui_clk_bottom                    : std_logic;
begin

--  #    #####   #    #  ######
--  #    #    #  #    #  #     
--  #    #####   #    #  ##### 
--  #    #    #  #    #  #     
--  #    #    #  #    #  #     
--  #    #####    ####   #     

	-- Input buffers

	brefclk_top_ibuf : IBUFDS_LVDS_25 port map (
		I   => brefclk_top_p,
		IB  => brefclk_top_m,
		O   => mgt_clkin_top_10G
	); 

	brefclk_bottom_ibuf : IBUFDS_LVDS_25 port map (
		I   => brefclk_bottom_p,
		IB  => brefclk_bottom_m,
		O   => mgt_clkin_bottom_10G
 	);


-- #####   #    #  ######   #### 
-- #    #  #    #  #       #    #
-- #####   #    #  #####   #     
-- #    #  #    #  #       #  ###
-- #    #  #    #  #       #    #
-- #####    ####   #        #### 

	clktop_bufg: BUFG port map (
		I  => mgt_clkin_top_10G,
		O  => xaui_clk_top
	);

	clkbottom_bufg: BUFG port map (
		I   => mgt_clkin_bottom_10G,
		O   => xaui_clk_bottom
	);

-- misc signal reassignement

	mgt_clk_top_10G    <= mgt_clkin_top_10G    ;
	mgt_clk_bottom_10G <= mgt_clkin_bottom_10G ;

-- signals fanout

	lnk0_mgt_clk_top_10G    <= mgt_clk_top_10G   ;
	lnk0_mgt_clk_bottom_10G <= mgt_clk_bottom_10G;
	lnk0_mgt_clk_top_8G     <= '0';
	lnk0_mgt_clk_bottom_8G  <= '0';
	lnk0_xaui_clk_top       <= xaui_clk_top      ;
	lnk0_xaui_clk_bottom    <= xaui_clk_bottom   ;
	lnk0_speed_select       <= '0';
	lnk1_mgt_clk_top_10G    <= mgt_clk_top_10G   ;
	lnk1_mgt_clk_bottom_10G <= mgt_clk_bottom_10G;
	lnk1_mgt_clk_top_8G     <= '0';
	lnk1_mgt_clk_bottom_8G  <= '0';
	lnk1_xaui_clk_top       <= xaui_clk_top      ;
	lnk1_xaui_clk_bottom    <= xaui_clk_bottom   ;
	lnk1_speed_select       <= '0';


end architecture XAUI_infrastructure_arch;
