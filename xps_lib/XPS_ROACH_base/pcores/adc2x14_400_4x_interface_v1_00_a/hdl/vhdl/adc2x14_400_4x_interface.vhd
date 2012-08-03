----------------------------------------------------------------------------------
-- adc2x14_400_4x_interface : ADC board with two ADS5474 for I and Q signals
--                         Clock divided by 4
----------------------------------------------------------------------------------

-- Authors:             Bruno Serfass, Sean McHugh, Ran Duan  
-- Test & validation: 	Guy Kenfack  
-- 						we obtain good adc perf when the dcm is configured with 45degr capture mode
-- Create Date: 	5/2/2011


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

entity adc2x14_400_4x_interface is
  generic (
    -- parameter OUTPUT_CLK set inside the xps_adc2x14_400_4x matlab script)
    -- if 0, then no output to FPGA (clock from DAC or other instead)
    -- if 1, then output clk0,90,180,270 to FPGA (all 1/4 ADC clk)
    OUTPUT_CLK   : INTEGER := 1
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
    adc_clk90_out       : out	STD_LOGIC;
    adc_clk180_out      : out	STD_LOGIC;
    adc_clk270_out      : out	STD_LOGIC;

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
  
  signal data_serdes_i0    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_serdes_i1    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_serdes_i2    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_serdes_i3    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_serdes_q0    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_serdes_q1    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_serdes_q2    :	STD_LOGIC_VECTOR (13 downto 0);
  signal data_serdes_q3    :	STD_LOGIC_VECTOR (13 downto 0);

  signal recapture_data_i0     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_i1     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_i2     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_i3     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_q0     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_q1     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_q2     :	STD_LOGIC_VECTOR (13 downto 0);
  signal recapture_data_q3     :	STD_LOGIC_VECTOR (13 downto 0);
  
  signal fifo_in_q	:	STD_LOGIC_VECTOR (55 downto 0);
  signal fifo_out_q	:	STD_LOGIC_VECTOR (55 downto 0);
  signal fifo_in_i	:	STD_LOGIC_VECTOR (55 downto 0);
  signal fifo_out_i	:	STD_LOGIC_VECTOR (55 downto 0);

  signal dcm_clk_in    	:	STD_LOGIC;
  signal dcm_clk      	:	STD_LOGIC;
  signal dcm_clk2x      :	STD_LOGIC;
  signal dcm_clk90     	:	STD_LOGIC;
  signal dcm_clk180     :	STD_LOGIC;
  signal dcm_clk270     :	STD_LOGIC;

  signal clk            :	STD_LOGIC;
  signal clkdiv         :	STD_LOGIC;      
  signal clkinv         :	STD_LOGIC;  
  signal clk90div          :	STD_LOGIC;
  signal clk180div         :	STD_LOGIC;
  signal clk270div         :	STD_LOGIC;

     
  signal fifo_rd_en     : STD_LOGIC := '1';
  signal fifo_wr_en     : STD_LOGIC := '1';
 -- signal fifo_rd_en_q   : STD_LOGIC := '0';
 -- signal fifo_rd_en_i   : STD_LOGIC := '0';
  signal fifo_rst       : STD_LOGIC := '0';
  signal fifo_empty_i   : STD_LOGIC;
  signal fifo_empty_q   : STD_LOGIC;
  signal fifo_full_i   : STD_LOGIC;
  signal fifo_full_q   : STD_LOGIC;

  
  ----------------------------------------
  -- Asynchronous FIFO
  ----------------------------------------
  component async_fifo_56x128
    port (
      din: IN std_logic_VECTOR(55 downto 0);
      rd_clk: IN std_logic;
      rd_en: IN std_logic;
      rst: IN std_logic;
      wr_clk: IN std_logic;
      wr_en: IN std_logic;
      dout: OUT std_logic_VECTOR(55 downto 0);
      empty: OUT std_logic;
      full: OUT std_logic);
  end component;

       


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

 ISERDES_inst_generate_data_i : for j in 0 to 13 generate
   ISERDES_NODELAY_inst_i : ISERDES_NODELAY
    generic map (
      BITSLIP_ENABLE => TRUE,
      DATA_RATE => "DDR", 
      DATA_WIDTH => 4, 
      INTERFACE_TYPE => "NETWORKING",
      NUM_CE => 1, 
      SERDES_MODE => "MASTER") 
     port map (
       Q1 => data_serdes_i3(j),
       Q2 => data_serdes_i2(j),
       Q3 => data_serdes_i1(j),
       Q4 => data_serdes_i0(j),
       Q5 => open,
       Q6 => open,
       SHIFTOUT1 => open,
       SHIFTOUT2 => open,
       BITSLIP => '0',
       CE1 => '1',
       CE2 => '0',
       CLK => clk,
       CLKB => not clk,
       CLKDIV => clkdiv,
       D => data_i(j),
       OCLK => '0',   
       RST =>'0',
       SHIFTIN1 => '0',
       SHIFTIN2 => '0'
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


 ISERDES_inst_generate_data_q : for j in 0 to 13 generate
   ISERDES_NODELAY_inst_q : ISERDES_NODELAY
     generic map (
       BITSLIP_ENABLE => TRUE,
       DATA_RATE => "DDR", 
       DATA_WIDTH => 4, 
       INTERFACE_TYPE => "NETWORKING",
       NUM_CE => 1, 
       SERDES_MODE => "MASTER") 
     port map (
       Q1 => data_serdes_q3(j),
       Q2 => data_serdes_q2(j),
       Q3 => data_serdes_q1(j),
       Q4 => data_serdes_q0(j),
       Q5 => open,
       Q6 => open,
       SHIFTOUT1 => open,
       SHIFTOUT2 => open,
       BITSLIP => '0',
       CE1 => '1',
       CE2 => '0',
       CLK => clk,
       CLKB => not clk,
       CLKDIV => clkdiv,
       D => data_q(j),
       OCLK => '0',
       RST =>'0',
       SHIFTIN1 => '0',
       SHIFTIN2 => '0'
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
  -- Re-capture all DDR inputs to clkdiv's rising edge
  -----------------------------------------------------

  ADC_RECAPTURE_PROC : process(clkdiv) is
  begin
    if clkdiv'event and clkdiv = '1' then
      recapture_data_q0  <= data_serdes_q0;
      recapture_data_q1  <= data_serdes_q1;
      recapture_data_q2  <= data_serdes_q2;
      recapture_data_q3  <= data_serdes_q3;
      recapture_data_i0  <= data_serdes_i0;
      recapture_data_i1  <= data_serdes_i1;
      recapture_data_i2  <= data_serdes_i2;
      recapture_data_i3  <= data_serdes_i3; 
    end if;
  end process;  

  
  
  -----------------------------------------------------
  -- FIFO 
  -----------------------------------------------------
  
  -- only if the fpga clock is not from the adc

  GEN_FIFO : if OUTPUT_CLK = 0 generate

    -- Read enable managment
    --  FIFO_RD_EN_PROC : process(fpga_clk) is
    -- begin
    --   if fpga_clk'event and fpga_clk = '1' then
    --     fifo_rd_en_q <= not(fifo_empty_q);
    --     fifo_rd_en_i <= not(fifo_empty_i);
    --     fifo_rd_en <= fifo_rd_en_q and fifo_rd_en_i;
    --   end if;
    -- end process;


    
    fifo_in_q <= recapture_data_q3 & recapture_data_q2 & recapture_data_q1 & recapture_data_q0;
    fifo_in_i <= recapture_data_i3 & recapture_data_i2 & recapture_data_i1 & recapture_data_i0;
    user_data_q0 <= fifo_out_q(13 downto 0);
    user_data_q1 <= fifo_out_q(27 downto 14);
    user_data_q2 <= fifo_out_q(41 downto 28);
    user_data_q3 <= fifo_out_q(55 downto 42);
    user_data_i0 <= fifo_out_i(13 downto 0);
    user_data_i1 <= fifo_out_i(27 downto 14);
    user_data_i2 <= fifo_out_i(41 downto 28);
    user_data_i3 <= fifo_out_i(55 downto 42);
    

          
    ADC_FIFO_Q : async_fifo_56x128      
      port map (
        din    => fifo_in_q,
        rd_clk => fpga_clk,
        rd_en  => fifo_rd_en,
        rst    => fifo_rst,
        wr_clk => clkdiv,
        wr_en  => fifo_wr_en,
        dout   => fifo_out_q,
        empty  => fifo_empty_q, 
        full   => fifo_full_q
        );

    ADC_FIFO_I : async_fifo_56x128
      port map (
        din    => fifo_in_i,
        rd_clk => fpga_clk,
        rd_en  => fifo_rd_en,
        rst    => fifo_rst,
        wr_clk => clkdiv,
        wr_en  => fifo_wr_en,
        dout   => fifo_out_i,
        empty  => fifo_empty_i, 
        full   => fifo_full_i
        );
  
  end generate;



  
  GEN_DATA_OUT: if OUTPUT_CLK = 1 generate
    user_data_q0 <= recapture_data_q0;
    user_data_q1 <= recapture_data_q1;
    user_data_q2 <= recapture_data_q2;
    user_data_q3 <= recapture_data_q3;
    user_data_i0 <= recapture_data_i0;
    user_data_i1 <= recapture_data_i1;
    user_data_i2 <= recapture_data_i2;
    user_data_i3 <= recapture_data_i3;
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

  -- DCM INPUT
  

  BUFG_data_clk : BUFG
    port map (I => drdy_clk, O => dcm_clk_in);
  
  -- DCM OUTPUT

  -- all DCM output clks are  divided by 2 and phase shifted by 90 so for example
  -- clk2x same fequency as dcm_clk_in
  
  BUFG_clk0 : BUFG
    port map (I => dcm_clk, O =>  clkdiv);
  
  BUFG_clk2x : BUFG
    port map (I => dcm_clk2x, O =>  clk);

  BUFG_clk90 : BUFG
    port map (I => dcm_clk90, O => clk90div);
  
  BUFG_clk180 : BUFG
    port map (I => dcm_clk180, O => clk180div);
  
  BUFG_clk270 : BUFG
    port map (I => dcm_clk270, O => clk270div);
  
 
  GEN_OUTCLOCK : if OUTPUT_CLK = 1 generate
    adc_clk_out <= clkdiv;
    adc_clk90_out <= clk90div;
    adc_clk180_out <= clk180div;
    adc_clk270_out <= clk270div;
  end generate;
  

    
  -- DCM 
  CLK_DCM : DCM
    generic map(
      CLK_FEEDBACK          => "1X",
      CLKDV_DIVIDE          => 2.000000,
      CLKFX_DIVIDE          => 4,
      CLKFX_MULTIPLY        => 2,
      CLKIN_DIVIDE_BY_2     => TRUE,
      CLKIN_PERIOD          => 10.00000,
      CLKOUT_PHASE_SHIFT    => "FIXED",
      DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
      DFS_FREQUENCY_MODE    => "LOW",
      DLL_FREQUENCY_MODE    => "LOW",
      DUTY_CYCLE_CORRECTION => TRUE,
      FACTORY_JF            => x"F0F0",
      PHASE_SHIFT           => 32,--45 degr capture
      STARTUP_WAIT          => FALSE)
    port map (
      CLKFB                 => clkdiv,
      CLKIN                 => dcm_clk_in,
      DSSEN                 => '0',
      PSCLK                 => '0',
      PSEN                  => '0',
      PSINCDEC              => '0',
      RST                   => '0',
      CLKDV                 => open,
      CLKFX                 => open,
      CLKFX180              => open,
      CLK0                  => dcm_clk,
      CLK2X                 => dcm_clk2x,
      CLK2X180              => open,
      CLK90                 => dcm_clk90,
      CLK180                => dcm_clk180,
      CLK270                => dcm_clk270,
      LOCKED                => adc_dcm_locked,
      PSDONE                => open,
      STATUS                => open
      );
  
  


  
end Structural;
