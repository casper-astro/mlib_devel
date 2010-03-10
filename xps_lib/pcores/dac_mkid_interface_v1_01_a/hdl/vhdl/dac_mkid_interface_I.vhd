----------------------------------------------------------------------------------
-- dac_mkid_interface : DAC board with two DAC5681 for I and Q signals
----------------------------------------------------------------------------------

-- Author: 
-- Create Date: 09/02/2009
-- modification: 09/10 minimalist version.




----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.vcomponents.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;


--------------------------------------------------------------------------------
-- Entity section
--------------------------------------------------------------------------------

entity dac_mkid_interface is
    Port (
      
      --------------------------------------
      -- differential signals from/to DAC
      --------------------------------------

      -- clock from DAC
      dac_clk_p    	: in  STD_LOGIC;
      dac_clk_n    	: in  STD_LOGIC;

      -- clock to DAC
      dac_smpl_clk_i_p   	: out STD_LOGIC;
      dac_smpl_clk_i_n   	: out STD_LOGIC;
      dac_smpl_clk_q_p   	: out STD_LOGIC;
      dac_smpl_clk_q_n   	: out STD_LOGIC;
   
      -- sync
      -- dac_sync_i_p   : out STD_LOGIC;
      -- dac_sync_i_n   : out STD_LOGIC;
      -- dac_sync_q_p   : out STD_LOGIC;
      -- dac_sync_q_n   : out STD_LOGIC;

      -- data
      dac_data_i_p     	: out STD_LOGIC_VECTOR (15 downto 0);
      dac_data_i_n     	: out STD_LOGIC_VECTOR (15 downto 0);
      dac_data_q_p     	: out STD_LOGIC_VECTOR (15 downto 0);
      dac_data_q_n     	: out STD_LOGIC_VECTOR (15 downto 0);

      
      --------------------------------------
      -- signals from/to design
      --------------------------------------
      dac_clk    			: out STD_LOGIC;
	dac_sampl_clk_i		: in	STD_LOGIC;
	dac_sampl_clk_q		: in	STD_LOGIC;
      dac_data_i			: in  STD_LOGIC_VECTOR (15 downto 0);
      dac_data_q			: in 	STD_LOGIC_VECTOR (15 downto 0)
      );

end dac_mkid_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------

-------------------------------
-- Should this be a Structural?
-------------------------------
architecture Behavioral of dac_mkid_interface is
    -- signal dsp_clk_0    : std_logic;
    -- signal dsp_clk_180  : std_logic;

    signal dac_clk		: std_logic;
    signal dac_smpl_clk_i     : std_logic;
    signal dac_smpl_clk_q     : std_logic;
    signal data_i : std_logic_vector (15 downto 0);
    signal data_q : std_logic_vector (15 downto 0);
        
    -- signal dac_clk_dcm  : std_logic;
    -- signal dac_clk      : std_logic;

    -- signal data_clk_dcm   : std_logic;
    -- signal data_clk90_dcm : std_logic;

    -- signal sync_i : std_logic;
    -- signal sync_q : std_logic;       

    attribute IOB : string;


    ----------------------------------------
    -- differential input buffer
    ----------------------------------------

-------------------------------------------------------------------------
-- Do we need to define a component since they're already in the library?
-------------------------------------------------------------------------
    component IBUFGDS
        generic  (
            IOSTANDARD  :   string := "LVDS_25"
        );
        port (
            O           :   out std_logic;
            I           :   in  std_logic;
            IB          :   in  std_logic
        );
    end component;

    ----------------------------------------
    -- differential output buffer
    ----------------------------------------
    component OBUFDS
        generic (
            IOSTANDARD  :   string := "LVDS_25"
        );
        port (
            O           :   out std_logic;
            OB          :   out std_logic;
            I           :   in  std_logic
        );
    end component;

   

    ----------------------------------------
    -- global clock buffer
    ----------------------------------------
    component BUFG
        port (
            I  : in  std_logic;
            O  : out std_logic
        );
    end component;

    
    -----------------------------------------
    -- clock DCM
    ----------------------------------------

    -- component DCM
    --     generic (
    --         CLK_FEEDBACK            : string        := "1X";
    --         CLKDV_DIVIDE            : real          := 2.000000;
    --         CLKFX_DIVIDE            : integer       := 1;
    --         CLKFX_MULTIPLY          : integer       := 2;
    --         CLKIN_DIVIDE_BY_2       : boolean       := false;
    --         CLKIN_PERIOD            : real          := 0.000000;
    --         CLKOUT_PHASE_SHIFT      : string        := "NONE";
    --         DESKEW_ADJUST           : string        := "SYSTEM_SYNCHRONOUS";
    --         DFS_FREQUENCY_MODE      : string        := "LOW";
    --         DLL_FREQUENCY_MODE      : string        := "LOW";
    --         DUTY_CYCLE_CORRECTION   : boolean       := true;
    --         FACTORY_JF              : bit_vector    := x"C080";
    --         PHASE_SHIFT             : integer       := 0;
    --         STARTUP_WAIT            : boolean       := false;
    --         DSS_MODE                : string        := "NONE"
    --     );
    --     port (
    --         CLKIN                   : in  std_logic;
    --         CLKFB                   : in  std_logic;
    --         RST                     : in  std_logic;
    --         PSEN                    : in  std_logic;
    --         PSINCDEC                : in  std_logic;
    --         PSCLK                   : in  std_logic;
    --         DSSEN                   : in  std_logic;
    --         CLK0                    : out std_logic;
    --         CLK90                   : out std_logic;
    --         CLK180                  : out std_logic;
    --         CLK270                  : out std_logic;
    --         CLKDV                   : out std_logic;
    --         CLK2X                   : out std_logic;
    --         CLK2X180                : out std_logic;
    --         CLKFX                   : out std_logic;
    --         CLKFX180                : out std_logic;
    --         STATUS                  : out std_logic_vector (7 downto 0);
    --         LOCKED                  : out std_logic;
    --         PSDONE                  : out std_logic
    --     );
    -- end component;

    -- attribute IOB of FDDR_inst_dac_data_clk_i : label is "TRUE";
    -- attribute IOB of FDDR_inst_dac_data_clk_q : label is "TRUE";

    -- attribute IOB of FD_inst_sync_i : label is "TRUE"; 
    -- attribute IOB of FD_inst_sync_q : label is "TRUE"; 
    
begin
  
    IBUFDS_inst_dsp_clk : IBUFGDS
    generic map (
       IOSTANDARD => "LVDS_25") 
    port map (
       O => dac_clk,           
       I => dac_clk_p,
       IB => dac_clk_n
    );

    
    -- BUFG_user0 : BUFG
    -- port map (
    --    I => dac_clk_dcm,
    --    O => dac_clk
    -- );

   
    -- clk_phase_0_gen : if CTRL_CLK_PHASE = 0 generate
    -- begin
    --     data_clk_i <= dac_clk;
    --     data_clk_q <= dac_clk;
    -- end generate;

    -- clk_phase_180_gen : if CTRL_CLK_PHASE = 1 generate
    -- begin
    --     data_clk_i <= not dac_clk;
    --     data_clk_q <= not dac_clk;
    -- end generate;

    
    -- BUFG_user90 : BUFG
    -- port map (
    --     I => data_clk90_dcm,
    --     O => user_data_clk90
    -- );

    
    -- FDDR_inst_dac_data_clk_i : FDDRRSE
    -- port map (
    --     Q   => dac_data_clk_i,
    --     D0  => '0',
    --     D1  => '1',
    --     C0  => data_clk_i,
    --     C1  => not data_clk_i
    -- );


    -- FDDR_inst_dac_data_clk_q : FDDRRSE
    -- port map (
    --     Q   => dac_data_clk_q,
    --     D0  => '0',
    --     D1  => '1',
    --     C0  => data_clk_q,
    --     C1  => not data_clk_q
    -- );



    -- clocks to the DAC
    
    OBUFDS_inst_data_clk_i : OBUFDS
    generic map (
       IOSTANDARD => "LVDS_25")
    port map (
       O =>  dac_smpl_clk_i_p,
       OB => dac_smpl_clk_i_n,
       I =>  dac_smpl_clk_i
    );

    -- The following line was commented out:
    -- user_data_clk_i <= data_clk_i;

    
    OBUFDS_inst_data_clk_q : OBUFDS
    generic map (
       IOSTANDARD => "LVDS_25")
    port map (
       O =>  dac_smpl_clk_q_p,
       OB => dac_smpl_clk_q_n,
       I =>  dac_smpl_clk_q
    );

    -- The following line was commented out: 
    -- user_data_clk_q <= data_clk_q;


    -- sync bits --
    
    -- OBUFDS_inst_sync_i : OBUFDS
    -- generic map (
    --    IOSTANDARD => "LVDS_25")
    -- port map (
    --    O =>  dac_sync_i_p,
    --    OB => dac_sync_i_n,
    --    I =>  sync_i
    -- );


    -- OBUFDS_inst_sync_q : OBUFDS
    -- generic map (
    --    IOSTANDARD => "LVDS_25")
    -- port map (
    --    O =>  dac_sync_q_p,
    --    OB => dac_sync_q_n,
    --    I =>  sync_q
    -- );


    -- FD_inst_sync_i : FD
    --   port map (
    --     Q => sync_i,
    --     C => data_clk_i,
    --     D => user_sync_i
    --     );
    

    -- FD_inst_sync_q : FD
    --   port map (
    --     Q => sync_q,
    --     C => data_clk_q,
    --     D => user_sync_q
    --     );

    

    -- DAC data outputs --
    
    OBUFDS_inst_generate_data_i : for i in 0 to 15 generate
      OBUFDS_inst_data_i : OBUFDS
        generic map (
          IOSTANDARD => "LVDS_25")
        port map (
          O  => dac_data_i_p(i),
          OB => dac_data_i_n(i),
          I => dac_data_i(i)
          );
    end generate;

    OBUFDS_inst_generate_data_q : for i in 0 to 15 generate
      OBUFDS_inst_data_q : OBUFDS
        generic map (
          IOSTANDARD => "LVDS_25")
        port map (
          O => dac_data_q_p(i),
          OB => dac_data_q_n(i),
          I => dac_data_q(i)
          );
    end generate;


    -- FD_inst_generate_data_i : for i in 0 to 15 generate
    --     attribute IOB of FD_inst_data_i : label is "TRUE";
    -- begin
    --   FD_inst_data_i : FD
    --     port map (
    --       Q => data_i(i),
    --       C => data_clk_i,
    --       D => user_data_i(i)
    --       );
    -- end generate;



    -- FD_inst_generate_data_q : for i in 0 to 15 generate
    --     attribute IOB of FD_inst_data_q : label is "TRUE";
    -- begin
    --   FD_inst_data_q : FD
    --     port map (
    --       Q => data_q(i),
    --       C => data_clk_q,
    --       D => user_data_q(i)
    --       );
    -- end generate;


        

    -- DAC_DCM : DCM
    -- generic map(
    --     CLK_FEEDBACK          => "1X",
    --     CLKDV_DIVIDE          => 2.000000,
    --     CLKFX_DIVIDE          => 1,
    --     CLKFX_MULTIPLY        => 2,
    --     CLKIN_DIVIDE_BY_2     => FALSE,
    --     CLKIN_PERIOD          => 3.906250,
    --     CLKOUT_PHASE_SHIFT    => "NONE",
    --     DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
    --     DFS_FREQUENCY_MODE    => "LOW",
    --     DLL_FREQUENCY_MODE    => "LOW",
    --     DUTY_CYCLE_CORRECTION => TRUE,
    --     FACTORY_JF            => x"C080",
    --     PHASE_SHIFT           => 0,
    --     STARTUP_WAIT          => FALSE)
    -- port map (
    --     CLKFB                 => dac_clk,
    --     CLKIN                 => dsp_clk_0,
    --     DSSEN                 => '0',
    --     PSCLK                 => '0',
    --     PSEN                  => '0',
    --     PSINCDEC              => '0',
    --     RST                   => '0',
    --     CLKDV                 => open,
    --     CLKFX                 => open,
    --     CLKFX180              => open,
    --     CLK0                  => dac_clk_dcm,
    --     CLK2X                 => open,
    --     CLK2X180              => open,
    --     CLK90                 => open,
    --     CLK180                => data_clk90_dcm,
    --     CLK270                => open,
    --     -- LOCKED                => ctrl_dcm_locked,
    --     PSDONE                => open,
    --     STATUS                => open
    -- );

end Behavioral;
