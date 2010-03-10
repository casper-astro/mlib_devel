----------------------------------------------------------------------------------
-- adc_mkid_interface : ADC board with two ADS54RF63 for I and Q signals
----------------------------------------------------------------------------------

-- Author: 
-- Create Date: 	10/05/09
-- modification: 	10/05/09	Using DRDY_I as the fpga clock.
--					changed app_clk to IBUFG


----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.vcomponents.all;


--------------------------------------------------------------------------------
-- Entity section
--------------------------------------------------------------------------------

entity adc_mkid_interface is
	Port (
      
	--------------------------------------
	-- differential signals in from ADC
	--------------------------------------

	-- data ready from ADC
	DRDY_I_p		: in STD_LOGIC;
	DRDY_I_n		: in STD_LOGIC;
	DRDY_Q_p		: in STD_LOGIC;
	DRDY_Q_n		: in STD_LOGIC;

	-- external port for synching multiple boards
	ADC_ext_in_p	: in STD_LOGIC;
	ADC_ext_in_n	: in STD_LOGIC;

	-- data read from ADC
	DI_p     		: in STD_LOGIC_VECTOR (11 downto 0);
	DI_n     		: in STD_LOGIC_VECTOR (11 downto 0);
	DQ_p     		: in STD_LOGIC_VECTOR (11 downto 0);
	DQ_n     		: in STD_LOGIC_VECTOR (11 downto 0);

      
      --------------------------------------
      -- signals out to design
      --------------------------------------

        -- clock from FPGA (not used in this interface)    
        fpga_clk           	: in	STD_LOGIC;

        -- clock to FPGA
        adc_clk_out       	: out	STD_LOGIC;

        -- yellow block ports
	user_data_i0		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_data_i1		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_data_q0		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_data_q1		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_sync		: out   STD_LOGIC;


      -- dcm lock (not used in this interface)
        adc_dcm_locked    	: out   STD_LOGIC
        
	);

end adc_mkid_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------
architecture Structural of adc_mkid_interface is

	signal drdy_clk		:	STD_LOGIC;
	signal data_i		:	STD_LOGIC_VECTOR (11 downto 0);
	signal data_q		:	STD_LOGIC_VECTOR (11 downto 0);

	signal data_clk		:	STD_LOGIC;

begin
  
	-----------------------------------------------------
	-- Data ready clock from ADC.  Only DRDY_I is used. 
	-- If necessary, DRDY_Q should be added.
	-- Also, DRDY_I is sent to app_clk to drive the fpga.
	-----------------------------------------------------

	IBUFDS_inst_dac_clk : IBUFGDS
	generic map (
		IOSTANDARD => "LVDS_25") 
	port map (
		O => drdy_clk,           
		I => DRDY_I_p,
		IB => DRDY_I_n
	);
	
	BUFG_inst_fpga_clk : BUFG
	port map (
		O => adc_clk_out,
		I => drdy_clk
	);

	BUFG_inst_data_clk : BUFG
	port map (
		O => data_clk,
		I => drdy_clk
	);

          

	------------------------------------------------------
	-- ADC data inputs --
	-- 	Requires an IDDR to double the data rate, and an 
	--	IBUFDS to convert from a differential signal.
	------------------------------------------------------

	-- ADC input I --

	IBUFDS_inst_generate_data_i : for j in 0 to 11 generate
		IBUFDS_inst_data_i : IBUFDS
		generic map (
			IOSTANDARD => "LVDS_25")
		port map (
			O  => data_i(j),
			I => DI_p(j),
			IB => DI_n(j)
		);
	end generate;

	IDDR_inst_generate_data_i : for j in 0 to 11 generate
		IDDR_inst_data_i : IDDR
		generic map (
			DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", 
			INIT_Q1 => '0', INIT_Q2 => '0', SRTYPE => "SYNC")
		port map (
			Q1 => user_data_i0(j),
			Q2 => user_data_i1(j),
			C => data_clk,
			CE => '1',
			D => data_i(j),
			R => '0',
			S => '0'
		);
	end generate;




	-- ADC input Q --

	IBUFDS_inst_generate_data_q : for j in 0 to 11 generate
		IBUFDS_inst_data_q : IBUFDS
		generic map (
			IOSTANDARD => "LVDS_25")
		port map (
			O  => data_q(j),
			I => DQ_p(j),
			IB => DQ_n(j)
		);
	end generate;

	IDDR_inst_generate_data_q : for j in 0 to 11 generate
		IDDR_inst_data_q : IDDR
		generic map (
			DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", 
			INIT_Q1 => '0', INIT_Q2 => '0', SRTYPE => "SYNC")
		port map (
			Q1 => user_data_q0(j),
			Q2 => user_data_q1(j),
			C => data_clk,
			CE => '1',
			D => data_q(j),
			R => '0',
			S => '0'
		);
	end generate;


	-----------------------------------------------------
	-- clock for synching several boards.
	-----------------------------------------------------

	IBUFDS_inst_user_sync : IBUFGDS
	generic map (
		IOSTANDARD => "LVDS_25") 
	port map (
		O => user_sync,           
		I => ADC_ext_in_p,
		IB => ADC_ext_in_n
	);


end Structural;
