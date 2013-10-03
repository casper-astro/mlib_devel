----------------------------------------------------------------------------------
-- adc2x14_400_4x_interface : ADC board with two ADS5474 for I and Q signals
----------------------------------------------------------------------------------

-- Authors:             Bruno Serfass, Sean McHugh, Ran Duan     
-- Create Date: 	01/22/2011
----------------------------------------------------------------------------------
-- modified for the Roach2 : September 10, 2013  : Guy kenfack

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
    -- parameter OUTPUT_CLK set inside the xps_adc2x14_400_4x matlab script)
    -- if 0, then no output to FPGA (clock from DAC or other instead)
    -- if 1, then output clk0,90,180,270 to FPGA (all 1/4 ADC clk)
    
entity adc2x14_400_4x_interface is
  generic (
    OUTPUT_CLK   : INTEGER := 0
    );   
  Port (
      
    --------------------------------------
    -- differential signals in from ADC
    --------------------------------------
    
    -- data ready clock from ADC
    DRDY_I_p		: in STD_LOGIC;
    DRDY_I_n		: in STD_LOGIC;
    DRDY_Q_p		: in STD_LOGIC;
    DRDY_Q_n		: in STD_LOGIC;
    
    -- external port for synching multiple boards
    ADC_ext_in_p	: in STD_LOGIC;
    ADC_ext_in_n	: in STD_LOGIC;
    
    -- data read from ADC (14 bits)
    DI_p     		: in STD_LOGIC_VECTOR (13 downto 0);
    DI_n     		: in STD_LOGIC_VECTOR (13 downto 0);
    DQ_p     		: in STD_LOGIC_VECTOR (13 downto 0);
    DQ_n     		: in STD_LOGIC_VECTOR (13 downto 0);
    
      
    --------------------------------------
    -- signals to/from design
    --------------------------------------
    
    -- clock from FPGA    
    fpga_clk    	: in	STD_LOGIC;

    -- clock to FPGA
    adc_clk_out       	: out	STD_LOGIC;
    adc_clk90_out       	: out	STD_LOGIC;
    adc_clk180_out       	: out	STD_LOGIC;
    adc_clk270_out       	: out	STD_LOGIC;

    -- dcm locked 
    adc_dcm_locked    	: out   STD_LOGIC;

    -- yellow block ports
    user_data_i0	: out	STD_LOGIC_VECTOR (13 downto 0);
    user_data_i1	: out	STD_LOGIC_VECTOR (13 downto 0);
    user_data_i2	: out	STD_LOGIC_VECTOR (13 downto 0);
    user_data_i3	: out	STD_LOGIC_VECTOR (13 downto 0);
    
    user_data_q0	: out	STD_LOGIC_VECTOR (13 downto 0);
    user_data_q1	: out	STD_LOGIC_VECTOR (13 downto 0);
    user_data_q2	: out	STD_LOGIC_VECTOR (13 downto 0);
    user_data_q3	: out	STD_LOGIC_VECTOR (13 downto 0);
    
    user_sync	       	: out   STD_LOGIC
    );
  
end adc2x14_400_4x_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------
architecture Structural of adc2x14_400_4x_interface is
  
  signal drdy_clk      	:	STD_LOGIC;
  signal data_clk      	:	STD_LOGIC;
  signal data_i		:	STD_LOGIC_VECTOR (13 downto 0);
  signal data_q		:	STD_LOGIC_VECTOR (13 downto 0);
  
  signal data_rise_i    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_fall_i    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_rise_q    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_fall_q    :	STD_LOGIC_VECTOR (13 downto 0);
	---
	signal	din_i0_fast	, din_i0_slow :  std_logic_vector (27 downto 0);
	signal	din_i1_fast	, din_i1_slow :  std_logic_vector (27 downto 0);
	signal din_i0_val,din_i0_reg	:    std_logic_vector (13 downto 0);
	signal din_i1_val,din_i1_reg	:    std_logic_vector (13 downto 0);
	---
   	signal user_data_i0_val	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i1_val	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i2_val	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i3_val	: STD_LOGIC_VECTOR (13 downto 0);
	---
   	signal user_data_i0_val0	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i1_val0	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i2_val0	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i3_val0	: STD_LOGIC_VECTOR (13 downto 0);
	---
   	signal user_data_i0_val1	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i1_val1	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i2_val1	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_i3_val1	: STD_LOGIC_VECTOR (13 downto 0);
	---
   	signal user_data_q0_val0	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q1_val0	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q2_val0	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q3_val0	: STD_LOGIC_VECTOR (13 downto 0);
	---              
   	signal user_data_q0_val1	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q1_val1	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q2_val1	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q3_val1	: STD_LOGIC_VECTOR (13 downto 0);
   	---   
	signal	din_q0_fast	, din_q0_slow :  std_logic_vector (27 downto 0);
	signal	din_q1_fast	, din_q1_slow :  std_logic_vector (27 downto 0);
	signal din_q0_val,din_q0_reg	:    std_logic_vector (13 downto 0);
	signal din_q1_val,din_q1_reg	:    std_logic_vector (13 downto 0);
	---
   	signal user_data_q0_val	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q1_val	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q2_val	: STD_LOGIC_VECTOR (13 downto 0);
   	signal user_data_q3_val	: STD_LOGIC_VECTOR (13 downto 0);
   	---  		
  signal recapture_data_rise_q ,user_voieB_t0_val    :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_fall_q ,user_voieB_t1_val    :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_rise_i ,user_voieA_t0_val     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_fall_i ,user_voieA_t1_val     :	STD_LOGIC_VECTOR (13 downto 0);
  
  signal dcm_clk , clkdv_buf    	:	STD_LOGIC;                 
  signal dcm_clk90  ,  clkdv_out 	:	STD_LOGIC;                 
  signal dcm_clk180     :	STD_LOGIC;
  signal dcm_clk270     :	STD_LOGIC;
  signal clk            :	STD_LOGIC;
  signal clk90          :	STD_LOGIC;
  signal clk180         :	STD_LOGIC;
  signal clk270         :	STD_LOGIC;

  
   signal GND_BIT         : std_logic;
   signal GND_BUS_7       : std_logic_vector (6 downto 0);
   signal GND_BUS_16      : std_logic_vector (15 downto 0);  

   


begin
  
  ------------------------------------------------------
  -- ADC data inputs --
  -- 	Requires an IDDR to double the data rate, and an 
  --	IBUFDS to convert from a differential signal.
  ------------------------------------------------------
  
  -- ADC input I --

  IBUFDS_inst_generate_data_i : for j in 0 to 13 generate
    IBUFDS_inst_data_i : IBUFDS
      generic map (
        IOSTANDARD => "LVDS_25")
      port map (
        O  => data_i(j),
        I => DI_p(j),
        IB => DI_n(j)
        );
  end generate;


    
  IDDR_inst_generate_data_i : for j in 0 to 13 generate
    IDDR_inst_data_i : IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", 
        INIT_Q1 => '0', INIT_Q2 => '0', SRTYPE => "SYNC")
      port map (
        Q1 => data_rise_i(j),
        Q2 => data_fall_i(j),
        C => clk90,
        CE => '1',
        D => data_i(j),
        R => '0',
        S => '0'
        );
  end generate;

    
  -- ADC input Q --

  IBUFDS_inst_generate_data_q : for j in 0 to 13 generate
    IBUFDS_inst_data_q : IBUFDS
      generic map (
        IOSTANDARD => "LVDS_25")
      port map (
        O  => data_q(j),
        I => DQ_p(j),
        IB => DQ_n(j)
        );
  end generate;

  IDDR_inst_generate_data_q : for j in 0 to 13 generate
    IDDR_inst_data_q : IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED", 
        INIT_Q1 => '0', INIT_Q2 => '0', SRTYPE => "SYNC")
      port map (
        Q1 => data_rise_q(j),
        Q2 => data_fall_q(j),
        C => clk90,
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
  -- Re-capture all DDR-captured data onto 0-degree clock
  -----------------------------------------------------

  ADC_RECAPTURE_PROC : process(clk) is
  begin
    if clk'event and clk = '1' then
      recapture_data_rise_q  <= data_rise_q;
      recapture_data_fall_q  <= data_fall_q;
      recapture_data_rise_i  <= data_rise_i;
      recapture_data_fall_i  <= data_fall_i;
    end if;
  end process;  
  
  
  --- valeur du domaine rapide à sampler de DEMUX2
  GEN_DATA_OUT: if OUTPUT_CLK = 1 generate
    --user_data_q0 <= recapture_data_rise_q;		-- old output data
    --user_data_q1 <= recapture_data_fall_q;		-- old output data
    --user_data_i0 <= recapture_data_rise_i;		-- old output data
    --user_data_i1 <= recapture_data_fall_i;		-- old output data
    
    --- I channel
    user_voieA_t0_val <= recapture_data_rise_i;	
	user_voieA_t1_val <= recapture_data_fall_i;
	
	user_data_i0 <= user_data_i0_val   ;
	user_data_i1 <= user_data_i1_val   ;
	user_data_i2 <= user_data_i2_val   ;
	user_data_i3 <= user_data_i3_val   ;	
	
	---	Q channel

    user_voieB_t0_val <= recapture_data_rise_q;	
	user_voieB_t1_val <= recapture_data_fall_q;
	
	user_data_q0 <= user_data_q0_val   ;
	user_data_q1 <= user_data_q1_val   ;
	user_data_q2 <= user_data_q2_val   ;
	user_data_q3 <= user_data_q3_val   ;	
		
	
	---
  end generate; 
	  

--------- ADC demux2 again with div2 CLK :Channel I	--------- 
	
	din_i0_val <= user_voieA_t0_val ;
	din_i1_val <= user_voieA_t1_val ;
	
	
process (clk)
begin

 	if Rising_edge(clk) then
 		din_i0_reg <= din_i0_val;
 		din_i0_fast <= din_i0_reg&din_i0_val;
		--
 		din_i1_reg <= din_i1_val; 		 		
		din_i1_fast <= din_i1_reg&din_i1_val;			
	end if;
	
	end process;	
------ Capture fast to slow ---------------

 div_demux_I :process (clkdv_out)
	begin

 	if Rising_edge(clkdv_out) then
	    din_i0_slow <= din_i0_fast ;
  		din_i1_slow <= din_i1_fast ; 	
  		--
  		user_data_i0_val  <= din_i0_slow(27 downto 14);
  		user_data_i1_val  <= din_i1_slow(27 downto 14);
  		user_data_i2_val  <= din_i0_slow(13 downto 0);
  		user_data_i3_val  <= din_i1_slow(13 downto 0);
			
	end if;
	end process;
			
	-- fin design demux2 channel I
--------- ADC demux2 again with div2 CLK :Channel Q	--------- 
	
	din_q0_val <= user_voieB_t0_val ;
	din_q1_val <= user_voieB_t1_val ;
	
	
process (clk)
begin

 	if Rising_edge(clk) then
 		din_q0_reg <= din_q0_val;
 		din_q0_fast <= din_q0_reg&din_q0_val;
		--
 		din_q1_reg <= din_q1_val; 		 		
		din_q1_fast <= din_q1_reg&din_q1_val;			
	end if;
	
	end process;	
------ Capture fast to slow ---------------

 div_demux_Q  :process (clkdv_out)
	begin

 	if Rising_edge(clkdv_out) then
	    din_q0_slow <= din_q0_fast ;
  		din_q1_slow <= din_q1_fast ; 	
  		--
  		user_data_q0_val  <= din_q0_slow(27 downto 14);
  		user_data_q1_val  <= din_q1_slow(27 downto 14);
  		user_data_q2_val  <= din_q0_slow(13 downto 0);
  		user_data_q3_val  <= din_q1_slow(13 downto 0);
			
	end if;
	end process;
			
	-- fin design demux2 channel Q
		
  
  -----------------------------------------------------
  -- FIFO 
  -----------------------------------------------------
  -- only if the fpga clock is not from the adc

  GEN_FIFO : if OUTPUT_CLK = 0 generate
  
    user_data_q0 <= user_data_q0_val1 ;
    user_data_q1 <= user_data_q1_val1 ;
    user_data_q2 <= user_data_q2_val1 ;
    user_data_q3 <= user_data_q3_val1 ;
    --
    user_data_i0 <= user_data_i0_val1;
    user_data_i1 <= user_data_i1_val1;
    user_data_i2 <= user_data_i2_val1;
    user_data_i3 <= user_data_i3_val1;
    

	-- we assume that we will read @ 100Mhz with an fpga_clk
	-- double registering for crossing the clocks domain 
	
	
 div_demux_I :process (fpga_clk)
	begin

 	if Rising_edge(fpga_clk) then
	
  		--
  		user_data_i0_val0  <= user_data_i0_val;
  		user_data_i1_val0  <= user_data_i1_val;
  		user_data_i2_val0  <= user_data_i2_val;
  		user_data_i3_val0  <= user_data_i3_val;
  		--
  		user_data_i0_val1  <= user_data_i0_val0;
  		user_data_i1_val1  <= user_data_i1_val0;
  		user_data_i2_val1  <= user_data_i2_val0;
  		user_data_i3_val1  <= user_data_i3_val0;
  		--
  		user_data_q0_val0  <= user_data_q0_val;
  		user_data_q1_val0  <= user_data_q1_val;
  		user_data_q2_val0  <= user_data_q2_val;
  		user_data_q3_val0  <= user_data_q3_val;
  		--                            
  		user_data_q0_val1  <= user_data_q0_val0;
  		user_data_q1_val1  <= user_data_q1_val0;
  		user_data_q2_val1  <= user_data_q2_val0;
  		user_data_q3_val1  <= user_data_q3_val0;  		
			
	end if;
	end process;	
	
	
      
  end generate;




    
  -----------------------------------------------------
  -- Clock 
  -----------------------------------------------------

  -- data ready clock from ADC (using DRDY_I)

  IBUFDS_inst_adc_clk : IBUFGDS
    generic map (
      IOSTANDARD => "LVDS_25") 
    port map (
      O => drdy_clk,           
      I => DRDY_I_p,
      IB => DRDY_I_n
      );


  -- BUFG
 
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

  GEN_OUTCLOCK : if OUTPUT_CLK = 1 generate
    adc_clk_out <= clkdv_out;	-- clk;   
    adc_clk90_out <= clk90;
    adc_clk180_out <= clk180;
    adc_clk270_out <= clk270;
  end generate;

  -- DCM 
--   CLK_DCM : DCM
--     generic map(
--       CLK_FEEDBACK          => "1X",
--       CLKDV_DIVIDE          => 2.000000,
--       CLKFX_DIVIDE          => 1,
--       CLKFX_MULTIPLY        => 4,
--       CLKIN_DIVIDE_BY_2     => FALSE,
--       CLKIN_PERIOD          => 5.000000,
--       CLKOUT_PHASE_SHIFT    => "NONE",
--       DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
--       DFS_FREQUENCY_MODE    => "HIGH",
--       DLL_FREQUENCY_MODE    => "HIGH",
--       DUTY_CYCLE_CORRECTION => TRUE,
--       FACTORY_JF            => x"F0F0",
--       PHASE_SHIFT           => 0,
--       STARTUP_WAIT          => FALSE)
--     port map (
--       CLKFB                 => clk,
--       CLKIN                 => data_clk,
--       DSSEN                 => '0',
--       PSCLK                 => '0',
--       PSEN                  => '0',
--       PSINCDEC              => '0',
--       RST                   => '0',
--       CLKDV                 => open,
--       CLKFX                 => open,
--       CLKFX180              => open,
--       CLK0                  => dcm_clk,
--       CLK2X                 => open,
--       CLK2X180              => open,
--       CLK90                 => dcm_clk90,
--       CLK180                => dcm_clk180,
--       CLK270                => dcm_clk270,
--       LOCKED                => adc_dcm_locked,
--       PSDONE                => open,
--       STATUS                => open
--       );

---------------

  
   DCM_ADV_INST : DCM_ADV
   generic map( CLK_FEEDBACK 		=> "1X",
            CLKDV_DIVIDE 			=> 2.0,
            CLKFX_DIVIDE 			=> 1,
            CLKFX_MULTIPLY 			=> 4,
            CLKIN_DIVIDE_BY_2 		=> FALSE,
            CLKIN_PERIOD 			=> 5.000,			-- 200 MHz
            CLKOUT_PHASE_SHIFT 		=> "NONE",
            DCM_AUTOCALIBRATION 	=> TRUE,
            DCM_PERFORMANCE_MODE 	=> "MAX_SPEED",
            DESKEW_ADJUST 			=> "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE 		=> "HIGH",
            DLL_FREQUENCY_MODE 		=> "HIGH",
            DUTY_CYCLE_CORRECTION 	=> TRUE,
            FACTORY_JF 				=> x"F0F0",
            PHASE_SHIFT 			=> 0,
            STARTUP_WAIT 			=> FALSE
            )
      port map (CLKFB				=> clk,
                CLKIN				=> data_clk,
                DADDR(6 downto 0)	=> GND_BUS_7(6 downto 0),
                DCLK				=> GND_BIT,
                DEN					=> GND_BIT,
                DI(15 downto 0)		=> GND_BUS_16(15 downto 0),
                DWE					=> GND_BIT,
                PSCLK				=> GND_BIT,
                PSEN				=> GND_BIT,
                PSINCDEC			=> GND_BIT,
                RST					=> GND_BIT,
                CLKDV				=> clkdv_buf,
                CLKFX				=> open,
                CLKFX180			=> open,
                CLK0				=> dcm_clk,
                CLK2X				=> open,
                CLK2X180			=> open,
                CLK90				=> dcm_clk90,
                CLK180				=> dcm_clk180,
                CLK270				=> dcm_clk270,
                DO					=> open,
                DRDY				=> open,
                LOCKED				=> adc_dcm_locked,
                PSDONE				=> open
                );
     
   GND_BIT 					<= '0';
   GND_BUS_7(6 downto 0) 	<= "0000000";
   GND_BUS_16(15 downto 0) 	<= "0000000000000000";
   --
   CLKDV_BUFG_INST : BUFG
      port map (
      			I=> clkdv_buf,
                O=> clkdv_out
                );
  
end Structural;
