----------------------------------------------------------------------------------
-- dac_mkid_4x_interface : DAC board with two DAC5681 for I and Q signals
--                         FPGA clock = DAC/ADC  clock divided by 4
--                         (use "dac_mkid" yellow block instead for FPGA clock  = DAC/ADC clock divided by 2)
----------------------------------------------------------------------------------

-- Author: Bruno Serfass, Sean McHugh, Ran Duan
-- Create Date:  Dec 2010   
-- modification:

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

entity dac_mkid_4x_interface is
  generic (
    -- parameter OUTPUT_CLK set inside the xps_dac_mkid_4x matlab script)
    -- if 0, then no output to FPGA (clock from ADC instead)
    -- if 1, then output clk0,90,180,270 to FPGA (all 1/4 DAC clk)
    OUTPUT_CLK   : INTEGER := 0
    );
  Port (
    
    --------------------------------------
    -- differential signals from/to DAC
    --------------------------------------

    -- clock from DAC
    dac_clk_p          	: in  STD_LOGIC;
    dac_clk_n          	: in  STD_LOGIC;

    -- clock to DAC
    dac_smpl_clk_i_p   	: out STD_LOGIC;
    dac_smpl_clk_i_n   	: out STD_LOGIC;
    dac_smpl_clk_q_p   	: out STD_LOGIC;
    dac_smpl_clk_q_n   	: out STD_LOGIC;
    
    -- enable analog output for DAC
    dac_sync_i_p      	: out STD_LOGIC;
    dac_sync_i_n	: out STD_LOGIC;
    dac_sync_q_p	: out STD_LOGIC;
    dac_sync_q_n	: out STD_LOGIC;
    
    -- data written to DAC
    dac_data_i_p     	: out STD_LOGIC_VECTOR (15 downto 0);
    dac_data_i_n     	: out STD_LOGIC_VECTOR (15 downto 0);
    dac_data_q_p     	: out STD_LOGIC_VECTOR (15 downto 0);
    dac_data_q_n     	: out STD_LOGIC_VECTOR (15 downto 0);
    
    
    dac_not_sdenb_i		: out	STD_LOGIC;
    dac_not_sdenb_q		: out	STD_LOGIC;
    dac_sclk	         	: out	STD_LOGIC;
    dac_sdi			: out	STD_LOGIC;
    dac_not_reset		: out	STD_LOGIC;
    

    
    --------------------------------------
    -- signals from/to design
    --------------------------------------

    -- clock from FPGA
    fpga_clk            : in	STD_LOGIC;
  
    -- dcm locked
    dac_clk_out         : out	STD_LOGIC;
    dac_clk90_out       : out	STD_LOGIC;      
    dac_clk180_out      : out	STD_LOGIC;
    dac_clk270_out      : out	STD_LOGIC;
    dac_dcm_locked      : out	STD_LOGIC;
    
    
    -- yellow block ports    
    user_data_i0        : in	STD_LOGIC_VECTOR (15 downto 0);
    user_data_i1        : in	STD_LOGIC_VECTOR (15 downto 0);
    user_data_i2        : in	STD_LOGIC_VECTOR (15 downto 0);
    user_data_i3        : in	STD_LOGIC_VECTOR (15 downto 0);
    
    user_data_q0        : in 	STD_LOGIC_VECTOR (15 downto 0);
    user_data_q1        : in 	STD_LOGIC_VECTOR (15 downto 0);
    user_data_q2        : in 	STD_LOGIC_VECTOR (15 downto 0);
    user_data_q3        : in 	STD_LOGIC_VECTOR (15 downto 0);

    user_sync_i	        : in	STD_LOGIC;
    user_sync_q	        : in	STD_LOGIC;
    
    

    not_sdenb_i			: in	STD_LOGIC;
    not_sdenb_q			: in	STD_LOGIC;
    sclk			: in	STD_LOGIC;
    sdi				: in	STD_LOGIC;
    not_reset			: in	STD_LOGIC
    -- phase				: out	STD_LOGIC
    
    );

end dac_mkid_4x_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------
architecture Structural of dac_mkid_4x_interface is

  signal data_i	:	STD_LOGIC_VECTOR (15 downto 0);
  signal data_q	:	STD_LOGIC_VECTOR (15 downto 0);

  signal dac_clk_in     :       STD_LOGIC;
  signal dac_clk        :       STD_LOGIC;
  signal data_clk_i        :       STD_LOGIC;
  signal data_clk_q        :       STD_LOGIC;
 
  
  signal dcm_clk      	:	STD_LOGIC;
  signal dcm_clkdiv     :	STD_LOGIC;
  signal dcm_clk2x      :	STD_LOGIC;
  signal dcm_clk90     	:	STD_LOGIC;
  signal dcm_clk180     :	STD_LOGIC;
  signal dcm_clk270     :	STD_LOGIC;
  signal dcm_clk_in     :	STD_LOGIC;

  signal clk            :	STD_LOGIC;
  signal clkdiv         :	STD_LOGIC;
  signal clk90div       :	STD_LOGIC;
  signal clk180div      :	STD_LOGIC;
  signal clk270div      :	STD_LOGIC;
  
begin

  -----------------------------------------------------------------------
  -- Serial input (DAC configuration)
  -----------------------------------------------------------------------
  
  OBUF_inst_not_sdenb_i : OBUF
    generic map (
      IOSTANDARD => "DEFAULT")
    Port map (
      O => dac_not_sdenb_i,
      I => not_sdenb_i
      );
  
  OBUF_inst_not_sdenb_q : OBUF
    generic map (
      IOSTANDARD => "DEFAULT")
    Port map (
      O => dac_not_sdenb_q,
      I => not_sdenb_q
      );
  
  OBUF_inst_sclk : OBUF
    generic map (
      IOSTANDARD => "DEFAULT")
    Port map (
      O => dac_sclk,
      I => sclk
      );
  
  OBUF_inst_sdi : OBUF
    generic map (
      IOSTANDARD => "DEFAULT")
    Port map (
      O => dac_sdi,
      I => sdi
      );
  
  OBUF_inst_not_reset : OBUF
    generic map (
      IOSTANDARD => "DEFAULT")
    Port map (
      O => dac_not_reset,
      I => not_reset
      );

  
  ----------------------------------
  -- sync output to DAC --
  ----------------------------------
  
  OBUFDS_inst_dac_sync_i : OBUFDS
    generic map (
      IOSTANDARD => "LVDS_25")
    port map (
      O =>  dac_sync_i_p,
      OB => dac_sync_i_n,
      I =>  user_sync_i
      );

  OBUFDS_inst_dac_sync_q : OBUFDS
    generic map (
      IOSTANDARD => "LVDS_25")
    port map (
      O =>  dac_sync_q_p,
      OB => dac_sync_q_n,
      I =>  user_sync_q
      );
  
 
  ----------------------------------------
  -- Data to DAC using OSERDES
  ----------------------------------------
  
  -- signal I --
    
  OSERDES_inst_data_i_generate : for j in 0 to 15 generate
    OSERDES_inst_data_i : OSERDES
      generic map (
        DATA_RATE_OQ	=> "DDR",
        DATA_RATE_TQ	=> "BUF",
        DATA_WIDTH	=> 4,
        INIT_OQ	      	=> '0',
        INIT_TQ	       	=> '0',
        SERDES_MODE	=> "MASTER",
        SRVAL_OQ       	=> '0',
        SRVAL_TQ       	=> '0',
        TRISTATE_WIDTH	=> 1
        )
      port map (
        SHIFTOUT1	=> open,
        SHIFTOUT2	=> open,
        D1     	=> user_data_i0(j),
        D2     	=> user_data_i1(j),
        D3     	=> user_data_i2(j),
        D4     	=> user_data_i3(j),
        D5     	=> '0',
        D6      => '0',
        OCE    	=> '1',
        T1     	=> '0',
        T2	=> '1',
        T3	=> '1',
        T4	=> '1',
        TCE  	=> '1',
        REV   	=> '0',
        SR     	=> '0',
        CLK   	=> clk,
        CLKDIV 	=> clkdiv,
        TQ     	=> open,
        OQ     	=> data_i(j),
        SHIFTIN1        => '0',
        SHIFTIN2 	=> '0'
        );
  end generate;
    

  OBUFDS_inst_generate_data_i : for j in 0 to 15 generate
    OBUFDS_inst_data1_i : OBUFDS
      generic map (
        IOSTANDARD => "LVDS_25")
      port map (
        O  => dac_data_i_p(j),
        OB => dac_data_i_n(j),
        I => data_i(j)
        );
  end generate;



  -- signal Q --

  OSERDES_inst_data_q_generate : for j in 0 to 15 generate
   OSERDES_inst_data_q : OSERDES                                
     generic map (
       DATA_RATE_OQ	=> "DDR",
       DATA_RATE_TQ	=> "BUF",
       DATA_WIDTH	=> 4,
       INIT_OQ	      	=> '0',
       INIT_TQ	       	=> '0',
       SERDES_MODE	=> "MASTER",
       SRVAL_OQ		=> '0',
       SRVAL_TQ		=> '0',
       TRISTATE_WIDTH	=> 1
       )
     port map (
       SHIFTOUT1	=> open,
       SHIFTOUT2	=> open,
       D1      	=> user_data_q0(j),
       D2	=> user_data_q1(j),
       D3      	=> user_data_q2(j),
       D4      	=> user_data_q3(j),
       D5      	=> '0',
       D6	=> '0',
       OCE	=> '1',
       T1	=> '0',
       T2	=> '1',
       T3	=> '1',
       T4	=> '1',
       TCE  	=> '1',
       REV   	=> '0',
       SR     	=> '0',
       CLK   	=> clk,
       CLKDIV   => clkdiv,
       TQ      	=> open,
       OQ      	=> data_q(j),
       SHIFTIN1	=> '0',
       SHIFTIN2	=> '0'
       );
  end generate;

  
  OBUFDS_inst_generate_data_q : for j in 0 to 15 generate
    OBUFDS_inst_data1_q : OBUFDS
      generic map (
        IOSTANDARD => "LVDS_25")
      port map (
        O  => dac_data_q_p(j),
        OB => dac_data_q_n(j),
        I => data_q(j)
        );
  end generate;

  ---------------------------------------
  -- Clock driver (use also OSERDES
  -- to match delay with data)
  ------------------------------------------
  
  OSERDES_inst_clk_i : OSERDES
    generic map (
      DATA_RATE_OQ	=> "DDR",
      DATA_RATE_TQ	=> "BUF",
      DATA_WIDTH	=> 4,
      INIT_OQ	      	=> '0',
      INIT_TQ	       	=> '0',
      SERDES_MODE	=> "MASTER",
      SRVAL_OQ       	=> '0',
      SRVAL_TQ       	=> '0',
      TRISTATE_WIDTH	=> 1
      )
    port map (
      SHIFTOUT1	=> open,
      SHIFTOUT2	=> open,
      D1     	=> '0',
      D2     	=> '1',
      D3     	=> '0',
      D4     	=> '1',
      D5     	=> '0',
      D6        => '0',
      OCE    	=> '1',
      T1     	=> '0',
      T2	=> '1',
      T3	=> '1',
      T4	=> '1',
      TCE  	=> '1',
      REV   	=> '0',
      SR     	=> '0',
      CLK   	=> clk,
      CLKDIV 	=> clkdiv,
      TQ     	=> open,
      OQ     	=> data_clk_i,
      SHIFTIN1  => '0',
      SHIFTIN2 	=> '0'
      );



  OSERDES_inst_clk_q : OSERDES
    generic map (
      DATA_RATE_OQ	=> "DDR",
      DATA_RATE_TQ	=> "BUF",
      DATA_WIDTH	=> 4,
      INIT_OQ	      	=> '0',
      INIT_TQ	       	=> '0',
      SERDES_MODE	=> "MASTER",
      SRVAL_OQ       	=> '0',
      SRVAL_TQ       	=> '0',
      TRISTATE_WIDTH	=> 1
      )
    port map (
      SHIFTOUT1	=> open,
      SHIFTOUT2	=> open,
      D1     	=> '0',
      D2     	=> '1',
      D3     	=> '0',
      D4     	=> '1',
      D5     	=> '0',
      D6        => '0',
      OCE    	=> '1',
      T1     	=> '0',
      T2	=> '1',
      T3	=> '1',
      T4	=> '1',
      TCE  	=> '1',
      REV   	=> '0',
      SR     	=> '0',
      CLK   	=> clk,
      CLKDIV 	=> clkdiv,
      TQ     	=> open,
      OQ     	=> data_clk_q,
      SHIFTIN1  => '0',
      SHIFTIN2 	=> '0'
      );
  

  OBUFDS_inst_smpl_clk_i : OBUFDS
    generic map (
      IOSTANDARD => "LVDS_25")
    port map (
      O =>  dac_smpl_clk_i_p,
      OB => dac_smpl_clk_i_n,
      I =>  data_clk_i
      );
  
  OBUFDS_inst_smpl_clk_q : OBUFDS
    generic map (
      IOSTANDARD => "LVDS_25")
    port map (
      O =>  dac_smpl_clk_q_p,
      OB => dac_smpl_clk_q_n,
      I =>  data_clk_q
      );
  
 
  -----------------------------------
  -- Clock  Management 
  -----------------------------------
   
  -- Use clk from DAC, output to FPGA

  GEN_OUTCLOCK1 : if OUTPUT_CLK = 1 generate

    -- get clock from DAC
    
    IBUFDS_inst_dac_clk : IBUFGDS
      generic map (
        IOSTANDARD => "LVDS_25") 
      port map (
        O => dac_clk_in,           
        I => dac_clk_p,
        IB => dac_clk_n
        );

    --  buffer DCM input
   
    BUFG_clk_dac : BUFG
      port map (I => dac_clk_in, O => dcm_clk_in);
    
    
    -- buffer DCM output

    -- dcm_clk_in divided by 2 in DCM so all the 0,90,180,270
    -- 
  
    -- clk    = dcm_clk_in (however divided, then multiplied by 2 in DCM so
    --           that it is synchronize qith clkdiv)
    -- clkdiv = dcm_clk_in divided by 2 =  DAC/ADC clock divided by 4    

    
    BUFG_clk : BUFG
      port map (I => dcm_clk, O => clkdiv);


    BUFG_clk2x : BUFG
      port map (I => dcm_clk2x, O => clk);
    
    
    BUFG_clk90 : BUFG
      port map (I => dcm_clk90, O => clk90div);
    
    BUFG_clk180 : BUFG
      port map (I => dcm_clk180, O => clk180div);
  
    BUFG_clk270 : BUFG
      port map (I => dcm_clk270, O => clk270div);
   

   
    dac_clk_out <= clkdiv;
    dac_clk90_out <= clk90div;
    dac_clk180_out <= clk180div;
    dac_clk270_out <= clk270div;


    
    CLK_DCM1 : DCM
      generic map(
        CLK_FEEDBACK          => "1X",
        CLKDV_DIVIDE          => 2.000000,
        CLKFX_DIVIDE          => 1,
        CLKFX_MULTIPLY        => 4,
        CLKIN_DIVIDE_BY_2     => TRUE,
        CLKIN_PERIOD          => 3.703704,
        CLKOUT_PHASE_SHIFT    => "NONE",
        DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
        DFS_FREQUENCY_MODE    => "HIGH",
        DLL_FREQUENCY_MODE    => "HIGH",
        DUTY_CYCLE_CORRECTION => TRUE,
        FACTORY_JF            => x"F0F0",
        PHASE_SHIFT           => 0,
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
        LOCKED                => dac_dcm_locked,
        PSDONE                => open,
        STATUS                => open
        );

  end generate;



  -- use clock from FPGA only

  GEN_OUTCLOCK2 : if OUTPUT_CLK = 0 generate
    
    -- clock from FPGA
    
    BUFG_clkfpga : BUFG
      port map (I => fpga_clk, O => dcm_clk_in);
  
    
    -- buffer DCM output

    -- clk    = 2xFPGA (or DAC/ADC clock divided by 2)
    -- clkdiv = FPGA clk (or DAC/ADC clock divided by 4)
    
    BUFG_clk2x : BUFG
      port map (I => dcm_clk2x, O => clk);
  
    BUFG_clkx : BUFG
      port map (I => dcm_clk, O => clkdiv);
  
    
    CLK_DCM2 : DCM
      generic map(
        CLK_FEEDBACK          => "1X",
        CLKDV_DIVIDE          => 2.000000,
        CLKFX_DIVIDE          => 1,
        CLKFX_MULTIPLY        => 4,
        CLKIN_DIVIDE_BY_2     => FALSE,
        CLKIN_PERIOD          => 3.703704,
        CLKOUT_PHASE_SHIFT    => "NONE",
        DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
        DFS_FREQUENCY_MODE    => "HIGH",
        DLL_FREQUENCY_MODE    => "HIGH",
        DUTY_CYCLE_CORRECTION => TRUE,
        FACTORY_JF            => x"F0F0",
        PHASE_SHIFT           => 0,
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
        CLK90                 => open,
        CLK180                => open,
        CLK270                => open,
        LOCKED                => dac_dcm_locked,
        PSDONE                => open,
        STATUS                => open
        );

  end generate;




  
end Structural;
