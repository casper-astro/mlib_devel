----------------------------------------------------------------------------------
-- adc_mkid_interface : ADC board with two ADS54RF63 for I and Q signals
----------------------------------------------------------------------------------
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
  generic (
    OUTPUT_CLK   : INTEGER := 1
  --  clkin_period    : real    :=10.0;  -- clock in period (ns)
  --  mode            : integer :=0;    -- 1-channel mode
  --  mmcm_m          : real    :=16.0;  -- MMCM multiplier value
  --  mmcm_d          : integer :=12;    -- MMCM divide value
  --  mmcm_o0         : real    :=8.0;  -- MMCM first clock divide
  --  mmcm_o1         : integer :=2   -- MMCM second clock divide
	 
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
    
    -- data read from ADC (12 bits)
    DI_p     		: in STD_LOGIC_VECTOR (11 downto 0);
    DI_n     		: in STD_LOGIC_VECTOR (11 downto 0);
    DQ_p     		: in STD_LOGIC_VECTOR (11 downto 0);
    DQ_n     		: in STD_LOGIC_VECTOR (11 downto 0);
    
      
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
    user_data_i0	: out	STD_LOGIC_VECTOR (11 downto 0);
    user_data_i1	: out	STD_LOGIC_VECTOR (11 downto 0);
    user_data_q0	: out	STD_LOGIC_VECTOR (11 downto 0);
    user_data_q1	: out	STD_LOGIC_VECTOR (11 downto 0);
    user_sync	       	: out   STD_LOGIC
    );
  
end adc_mkid_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------
architecture Structural of adc_mkid_interface is
  
  signal drdy_clk      	:	STD_LOGIC;
  signal data_clk      	:	STD_LOGIC;
  signal data_i		:	STD_LOGIC_VECTOR (11 downto 0);
  signal data_q		:	STD_LOGIC_VECTOR (11 downto 0);
  
  signal data_rise_i    :	STD_LOGIC_VECTOR (11 downto 0);
  signal data_fall_i    :	STD_LOGIC_VECTOR (11 downto 0);
  signal data_rise_q    :	STD_LOGIC_VECTOR (11 downto 0);
  signal data_fall_q    :	STD_LOGIC_VECTOR (11 downto 0);


  signal recapture_data_rise_q     :	STD_LOGIC_VECTOR (11 downto 0);
  signal recapture_data_fall_q     :	STD_LOGIC_VECTOR (11 downto 0);
  signal recapture_data_rise_i     :	STD_LOGIC_VECTOR (11 downto 0);
  signal recapture_data_fall_i     :	STD_LOGIC_VECTOR (11 downto 0);
  
  signal fifo_in_q	:	STD_LOGIC_VECTOR (23 downto 0);
  signal fifo_out_q	:	STD_LOGIC_VECTOR (23 downto 0);
  signal fifo_in_i	:	STD_LOGIC_VECTOR (23 downto 0);
  signal fifo_out_i	:	STD_LOGIC_VECTOR (23 downto 0);

  signal dcm_clk      	:	STD_LOGIC;
  signal dcm_clk90     	:	STD_LOGIC;
  signal dcm_clk180     :	STD_LOGIC;
  signal dcm_clk270     :	STD_LOGIC;
  signal clk,clk_fb,clk1           :	STD_LOGIC;
  signal clk90          :	STD_LOGIC;
  signal clk180         :	STD_LOGIC;
  signal clk270         :	STD_LOGIC;

  
  signal fifo_rd_en     : STD_LOGIC := '1';
  signal fifo_wr_en     : STD_LOGIC := '1';
 -- signal fifo_rd_en_q   : STD_LOGIC := '0';
 -- signal fifo_rd_en_i   : STD_LOGIC := '0';
  signal fifo_rst       : STD_LOGIC := '0';
  signal fifo_empty_i   : STD_LOGIC;
  signal fifo_empty_q   : STD_LOGIC;
  signal fifo_full_i   : STD_LOGIC;
  signal fifo_full_q   : STD_LOGIC;

----------------------------------------------------------------------------------
----------------------MMCM

  signal clkin1      : std_logic;
  -- Output clock buffering / unused connectors
  signal clkfbout         : std_logic;
  signal clkfboutb_unused : std_logic;
  signal clkout0          : std_logic;
  signal clkout0b_unused  : std_logic;
  signal clkout1          : std_logic;
  signal clkout1b_unused  : std_logic;
  signal clkout2          : std_logic;
  signal clkout2b_unused  : std_logic;
  signal clkout3          : std_logic;
  signal clkout3b_unused  : std_logic;
  signal clkout4_unused   : std_logic;
  signal clkout5_unused   : std_logic;
  signal clkout6_unused   : std_logic;
  -- Dynamic programming unused signals
  signal do_unused        : std_logic_vector(15 downto 0);
  signal drdy_unused      : std_logic;
  -- Unused status signals
  signal clkfbstopped_unused : std_logic;
  signal clkinstopped_unused : std_logic;
  signal clkfb_in_buf_out : std_logic;
  signal clkfb_bufg_out   : std_logic;
  signal clkfb_oddr_out   : std_logic;

-----------------------------------------------------------------
  
  ----------------------------------------
  -- Asynchronous FIFO
  ----------------------------------------
  component async_fifo_24x128
    port (
      din: IN std_logic_VECTOR(23 downto 0);
      rd_clk: IN std_logic;
      rd_en: IN std_logic;
      rst: IN std_logic;
      wr_clk: IN std_logic;
      wr_en: IN std_logic;
      dout: OUT std_logic_VECTOR(23 downto 0);
      empty: OUT std_logic;
      full: OUT std_logic);
  end component;


    component MMCM_BASE
        generic (
            BANDWIDTH          : string  := "OPTIMIZED"; -- Jitter programming ("HIGH","LOW","OPTIMIZED")
            CLKFBOUT_MULT_F    : integer := 8;           -- Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
            CLKFBOUT_PHASE     : real    := 0.0;
            CLKIN1_PERIOD      : real    := 4.0;
            CLKOUT0_DIVIDE_F   : integer := 4;           -- Divide amount for CLKOUT0 (1.000-128.000).
            CLKOUT0_DUTY_CYCLE : real    := 0.5; 
            CLKOUT1_DUTY_CYCLE : real    := 0.5;
            CLKOUT2_DUTY_CYCLE : real    := 0.5;
            CLKOUT3_DUTY_CYCLE : real    := 0.5;
            CLKOUT4_DUTY_CYCLE : real    := 0.5;
            CLKOUT5_DUTY_CYCLE : real    := 0.5;
            CLKOUT6_DUTY_CYCLE : real    := 0.5;
            CLKOUT0_PHASE      : real    := 0.0;
            CLKOUT1_PHASE      : integer := 90;
            CLKOUT2_PHASE      : integer := 180;
            CLKOUT3_PHASE      : integer := 270;
            CLKOUT4_PHASE      : real    := 0.0;
            CLKOUT5_PHASE      : real    := 0.0;
            CLKOUT6_PHASE      : real    := 0.0;
            CLKOUT1_DIVIDE     : integer := 4;            -- THIS IS THE DIVISOR
            CLKOUT2_DIVIDE     : integer := 4;
            CLKOUT3_DIVIDE     : integer := 4;
            CLKOUT4_DIVIDE     : integer := 1;
            CLKOUT5_DIVIDE     : integer := 1;
            CLKOUT6_DIVIDE     : integer := 1;
            CLKOUT4_CASCADE    : string  := "FALSE";
            CLOCK_HOLD         : string  := "FALSE";
            DIVCLK_DIVIDE      : integer := 2;            -- Master division value (1-80)
            REF_JITTER1        : real    := 0.0;
            STARTUP_WAIT       : string  := "FALSE"
        );
        port (
            CLKIN1    : in  std_logic;
            CLKFBIN   : in  std_logic;
            
            CLKFBOUT  : out std_logic;
            CLKFBOUTB : out std_logic;
            
            CLKOUT0   : out std_logic;
            CLKOUT0B  : out std_logic;
            CLKOUT1   : out std_logic;
            CLKOUT1B  : out std_logic;
            CLKOUT2   : out std_logic;
            CLKOUT2B  : out std_logic;
            CLKOUT3   : out std_logic;
            CLKOUT3B  : out std_logic;
            CLKOUT4   : out std_logic;
            CLKOUT5   : out std_logic;
            CLKOUT6   : out std_logic;
            LOCKED    : out std_logic;
            
            PWRDWN    : in  std_logic;
            RST       : in  std_logic
        );
    end component;




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
  -- Re-capture all DDR inputs to clk's rising edge
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


    
    fifo_in_q <= recapture_data_fall_q & recapture_data_rise_q;
    fifo_in_i <= recapture_data_fall_i & recapture_data_rise_i;
    user_data_q0 <= fifo_out_q(11 downto 0);
    user_data_q1 <= fifo_out_q(23 downto 12);
    user_data_i0 <= fifo_out_i(11 downto 0);
    user_data_i1 <= fifo_out_i(23 downto 12);

          
    ADC_FIFO_Q : async_fifo_24x128      
      port map (
        din    => fifo_in_q,
        rd_clk => fpga_clk,
        rd_en  => fifo_rd_en,
        rst    => fifo_rst,
        wr_clk => clk,
        wr_en  => fifo_wr_en,
        dout   => fifo_out_q,
        empty  => fifo_empty_q, 
        full   => fifo_full_q
        );

    ADC_FIFO_I : async_fifo_24x128
      port map (
        din    => fifo_in_i,
        rd_clk => fpga_clk,
        rd_en  => fifo_rd_en,
        rst    => fifo_rst,
        wr_clk => clk,
        wr_en  => fifo_wr_en,
        dout   => fifo_out_i,
        empty  => fifo_empty_i, 
        full   => fifo_full_i
        );
  
  end generate;



  
  GEN_DATA_OUT: if OUTPUT_CLK = 1 generate
    user_data_q0 <= recapture_data_rise_q;
    user_data_q1 <= recapture_data_fall_q;
    user_data_i0 <= recapture_data_rise_i;
    user_data_i1 <= recapture_data_fall_i;
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

  BUFG_clk_fb : BUFG
    port map (I => clkfbout, O => clk_fb);
  
  BUFG_clk90 : BUFG
    port map (I => dcm_clk90, O => clk90);

  BUFG_clk180 : BUFG
    port map (I => dcm_clk180, O => clk180);

  BUFG_clk270 : BUFG
    port map (I => dcm_clk270, O => clk270);

  
  -- out clock to fpga 

  GEN_OUTCLOCK : if OUTPUT_CLK = 1 generate
    adc_clk_out <= clk;   
    adc_clk90_out <= clk90;
    adc_clk180_out <= clk180;
    adc_clk270_out <= clk270;
  end generate;


		MMCM_adc : MMCM_BASE
    		generic map(
        		BANDWIDTH          => "OPTIMIZED", -- Jitter programming ("HIGH","LOW","OPTIMIZED")
        		CLKFBOUT_MULT_F    => 8,           -- Multiply value for all CLKOUT (5.0-64.0). THIS IS THE MULTIPLIER
        		CLKFBOUT_PHASE     => 0.0,
        		CLKIN1_PERIOD      => 4.0,
        		CLKOUT0_DIVIDE_F   => 4,           -- Divide amount for CLKOUT0 (1.000-128.000).
        		CLKOUT0_DUTY_CYCLE => 0.5,
        		CLKOUT1_DUTY_CYCLE => 0.5,
        		CLKOUT2_DUTY_CYCLE => 0.5,
        		CLKOUT3_DUTY_CYCLE => 0.5,
        		CLKOUT4_DUTY_CYCLE => 0.5,
        		CLKOUT5_DUTY_CYCLE => 0.5,
        		CLKOUT6_DUTY_CYCLE => 0.5,
        		CLKOUT0_PHASE      => 0.0,
        		CLKOUT1_PHASE      => 90,
        		CLKOUT2_PHASE      => 180,
        		CLKOUT3_PHASE      => 270,
        		CLKOUT4_PHASE      => 0.0,
        		CLKOUT5_PHASE      => 0.0,
        		CLKOUT6_PHASE      => 0.0,
        		CLKOUT1_DIVIDE     => 4,            -- THIS IS THE DIVISOR
        		CLKOUT2_DIVIDE     => 4,
        		CLKOUT3_DIVIDE     => 4,
        		CLKOUT4_DIVIDE     => 1,
        		CLKOUT5_DIVIDE     => 1,
        		CLKOUT6_DIVIDE     => 1,
        		CLKOUT4_CASCADE    => "FALSE",
        		CLOCK_HOLD         => "FALSE",
        		DIVCLK_DIVIDE      => 2,            -- Master division value (1-80)
        		REF_JITTER1        => 0.0,
        		STARTUP_WAIT       => "FALSE")
    		port map(
        		CLKIN1    => data_clk,
        		CLKFBIN   => clk_fb  ,
        		CLKFBOUT  => clkfbout,
        		CLKFBOUTB => open,
        		CLKOUT0   => dcm_clk,
        		CLKOUT0B  => open,
        		CLKOUT1   => dcm_clk90,
        		CLKOUT1B  => open,
        		CLKOUT2   => dcm_clk180,
        		CLKOUT2B  => open,
        		CLKOUT3   => dcm_clk270,
        		CLKOUT3B  => open,
        		CLKOUT4   => open,
        		CLKOUT5   => open,
        		CLKOUT6   => open,
        		LOCKED    => adc_dcm_locked,   
       	 		PWRDWN    => '0',
        		RST       => '0'
		    	);


				
end Structural;
