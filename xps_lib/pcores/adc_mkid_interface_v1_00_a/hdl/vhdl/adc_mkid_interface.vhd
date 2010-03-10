----------------------------------------------------------------------------------
-- adc_mkid_interface : ADC board with two ADS54RF63  (12 bits) for I and Q signals
----------------------------------------------------------------------------------

-- Author: 
-- Create Date: 	10/05/09



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

        -- clock from FPGA
        fpga_clk           	: in	STD_LOGIC;

        -- clock to FPGA
        adc_clk_out       	: out	STD_LOGIC;
        adc_clk90_out       	: out	STD_LOGIC;
        adc_clk180_out       	: out	STD_LOGIC;
        adc_clk270_out       	: out	STD_LOGIC;


        -- yellow block ports
	user_data_i0		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_data_i1		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_data_q0		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_data_q1		: out	STD_LOGIC_VECTOR (11 downto 0);
	user_sync		: out   STD_LOGIC;


      -- dcm lock
        adc_dcm_locked    	: out   STD_LOGIC
        
	);

end adc_mkid_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------
architecture Structural of adc_mkid_interface is

	signal drdy_clk		:	STD_LOGIC;
        signal data_clk		:	STD_LOGIC;

	signal data_i		:	STD_LOGIC_VECTOR (11 downto 0);
	signal data_q		:	STD_LOGIC_VECTOR (11 downto 0);

        signal dcm_clk      	:	STD_LOGIC;
        signal dcm_clk90     	:	STD_LOGIC;
        signal dcm_clk180       :	STD_LOGIC;
        signal dcm_clk270       :	STD_LOGIC;
        signal clk              :	STD_LOGIC;
        signal clk90            :	STD_LOGIC;
        signal clk180           :	STD_LOGIC;
        signal clk270           :	STD_LOGIC;

begin
  
          

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
			C => clk,
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
			C => clk,
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


        
        -----------------------------------------------------
        -- Clock
        -----------------------------------------------------


        -- Data ready clock from ADC. Only DRDY_I is used.
	-- If necessary, DRDY_Q should be added.
        
	IBUFDS_inst_adc_clk : IBUFGDS
	generic map (
		IOSTANDARD => "LVDS_25") 
	port map (
		O => drdy_clk,           
		I => DRDY_I_p,
		IB => DRDY_I_n
	);
	


        -- BUFG in/out DCM
        
        BUFG_data_clk : BUFG
          port map (I => drdy_clk, O => data_clk);
      
        BUFG_clk : BUFG
          port map (I => dcm_clk, O => clk);
  
        BUFG_clk90 : BUFG
          port map (I => dcm_clk90, O => clk90);

        BUFG_clk180 : BUFG
          port map (I => dcm_clk180, O => clk180);

        BUFG_clk270 : BUFG
          port map (I => dcm_clk270, O => clk270);

  
        -- out clock to fpga
    
        adc_clk_out <= clk;
        adc_clk90_out <= clk90;
        adc_clk180_out <= clk180;
        adc_clk270_out <= clk270;


        -- DCM
        
        CLK_DCM : DCM
          generic map(
            CLK_FEEDBACK          => "1X",
            CLKDV_DIVIDE          => 2.000000,
            CLKFX_DIVIDE          => 1,
            CLKFX_MULTIPLY        => 4,
            CLKIN_DIVIDE_BY_2     => FALSE,
            CLKIN_PERIOD          => 0.000000,
            CLKOUT_PHASE_SHIFT    => "NONE",
            DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE    => "HIGH",
            DLL_FREQUENCY_MODE    => "HIGH",
            DUTY_CYCLE_CORRECTION => TRUE,
            FACTORY_JF            => x"F0F0",
            PHASE_SHIFT           => 0,
            STARTUP_WAIT          => FALSE)
          port map (
            CLKFB                 => clk,
            CLKIN                 => data_clk,
            DSSEN                 => '0',
            PSCLK                 => '0',
            PSEN                  => '0',
            PSINCDEC              => '0',
            RST                   => '0',
            CLKDV                 => open,
            CLKFX                 => open,
            CLKFX180              => open,
            CLK0                  => dcm_clk,
            CLK2X                 => open,
            CLK2X180              => open,
            CLK90                 => dcm_clk90,
            CLK180                => dcm_clk180,
            CLK270                => dcm_clk270,
            LOCKED                => adc_dcm_locked,
            PSDONE                => open,
            STATUS                => open
            );

  
          

end Structural;
