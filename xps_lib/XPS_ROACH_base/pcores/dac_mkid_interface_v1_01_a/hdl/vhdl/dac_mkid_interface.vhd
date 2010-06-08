----------------------------------------------------------------------------------
-- dac_mkid_interface : DAC board with two DAC5681 for I and Q signals
----------------------------------------------------------------------------------

-- Authors:             Sean McHugh, Bruno Serfass, Ran Duan
-- Create Date: 	09/02/09
-- modification: 
--
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

entity dac_mkid_interface is
      Generic (
        OUTPUT_CLK   : INTEGER := 0;
        CTRL_CLK_PHASE   :  INTEGER := 0
        );          
      Port (
    
        --------------------------------------
        -- differential signals from/to DAC
        --------------------------------------
        
        
        -- clock from DAC
        dac_clk_p		: in STD_LOGIC;
        dac_clk_n		: in STD_LOGIC;
  
	-- clock to DAC
	dac_smpl_clk_i_p   	: out STD_LOGIC;
	dac_smpl_clk_i_n   	: out STD_LOGIC;
	dac_smpl_clk_q_p   	: out STD_LOGIC;
	dac_smpl_clk_q_n   	: out STD_LOGIC;

	-- enable analog output for DAC
	dac_sync_i_p		: out STD_LOGIC;
	dac_sync_i_n		: out STD_LOGIC;
	dac_sync_q_p		: out STD_LOGIC;
	dac_sync_q_n		: out STD_LOGIC;

	-- data written to DAC
	dac_data_i_p     		: out STD_LOGIC_VECTOR (15 downto 0);
	dac_data_i_n     		: out STD_LOGIC_VECTOR (15 downto 0);
	dac_data_q_p     		: out STD_LOGIC_VECTOR (15 downto 0);
	dac_data_q_n     		: out STD_LOGIC_VECTOR (15 downto 0);

	-- configuration ports of DAC      
	dac_not_sdenb_i		: out	STD_LOGIC;
	dac_not_sdenb_q		: out	STD_LOGIC;
	dac_sclk	       	: out	STD_LOGIC;
	dac_sdi			: out	STD_LOGIC;
	dac_not_reset		: out	STD_LOGIC;
	-- dac_phase			: in	STD_LOGIC;

      --------------------------------------
      -- signals from/to design
      --------------------------------------

	-- defined in xps_dac_mkid.m  
	dac_smpl_clk    		: in	STD_LOGIC;

	-- defined in dac_mkid yellow block and dac_mkid_mask.m
	dac_data_i0			: in	STD_LOGIC_VECTOR (15 downto 0);
	dac_data_i1			: in	STD_LOGIC_VECTOR (15 downto 0);
	dac_data_q0			: in 	STD_LOGIC_VECTOR (15 downto 0);
	dac_data_q1			: in 	STD_LOGIC_VECTOR (15 downto 0);
	dac_sync_i			: in	STD_LOGIC;
	dac_sync_q			: in	STD_LOGIC;

        -- serial ports
	not_sdenb_i			: in	STD_LOGIC;
	not_sdenb_q			: in	STD_LOGIC;
	sclk				: in	STD_LOGIC;
	sdi				: in	STD_LOGIC;
	not_reset			: in	STD_LOGIC;
	-- phase				: out	STD_LOGIC

        -- clock to FPGA
        dac_clk_out       	: out	STD_LOGIC;
        dac_clk90_out       	: out	STD_LOGIC;
        dac_clk180_out       	: out	STD_LOGIC;
        dac_clk270_out       	: out	STD_LOGIC;

        -- dcm lock
        dac_dcm_locked    	: out   STD_LOGIC


        
	);

end dac_mkid_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------
architecture Structural of dac_mkid_interface is

        signal data_i	:	STD_LOGIC_VECTOR (15 downto 0);
        signal data_q	:	STD_LOGIC_VECTOR (15 downto 0);

        signal smpl_clk	        :	STD_LOGIC;
        signal dac_clk_in	:	STD_LOGIC;
        signal dac_clk	        :	STD_LOGIC;      
        signal dcm_clk      	:	STD_LOGIC;
        signal dcm_clk90     	:	STD_LOGIC;
        signal dcm_clk180       :	STD_LOGIC;
        signal dcm_clk270       :	STD_LOGIC;
        signal clk              :	STD_LOGIC;
        signal clk90            :	STD_LOGIC;
        signal clk180           :	STD_LOGIC;
        signal clk270           :	STD_LOGIC;

        

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

      
        -------------------------------------------------------------------
	-- Sample clock in to DAC.  "dac_smpl_clk_i_p/n" is a DDR clock. --
	-------------------------------------------------------------------

    
	BUFR_inst : BUFR
        generic map (
            SIM_DEVICE => "VIRTEX5")
	port map (
		O => smpl_clk,
		CE => '1',
		CLR => '0',
		I => dac_smpl_clk
	);

	OBUFDS_inst_smpl_clk_i : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25")
	port map (
		O =>  dac_smpl_clk_i_p,
		OB => dac_smpl_clk_i_n,
		I =>  smpl_clk
	);
       
	OBUFDS_inst_smpl_clk_q : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25")
	port map (
		O =>  dac_smpl_clk_q_p,
		OB => dac_smpl_clk_q_n,
		I =>  smpl_clk
	);

  

	----------------------------------
	-- Enable analog output for DAC --
	----------------------------------

	OBUFDS_inst_dac_sync_i : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25")
	port map (
		O =>  dac_sync_i_p,
		OB => dac_sync_i_n,
		I =>  dac_sync_i
	);

	OBUFDS_inst_dac_sync_q : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25")
	port map (
		O =>  dac_sync_q_p,
		OB => dac_sync_q_n,
		I =>  dac_sync_q
	);


	-----------------------------------------------------------------------
        --  DAC data outputs
        --      Requires an ODDR to double the data rate, and an 
	--	OBUFDS to convert to differential signal.
        -----------------------------------------------------------------------

	-- DAC output I --

	ODDR_inst_generate_data_i : for j in 0 to 15 generate
		ODDR_inst_data_i : ODDR
		generic map (
			DDR_CLK_EDGE => "SAME_EDGE", 
			INIT => '0',
			SRTYPE => "SYNC")
		port map (
			Q => data_i(j),
			C => smpl_clk,
			CE => '1',
			D1 => dac_data_i0(j),
			D2 => dac_data_i1(j),
			R => '0',
			S => '0'
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



	-- DAC output Q --

	ODDR_inst_generate_data_q : for j in 0 to 15 generate
		ODDR_inst_data_q : ODDR
		generic map (
			DDR_CLK_EDGE => "SAME_EDGE", 
			INIT => '0',
			SRTYPE => "SYNC")
		port map (
			Q => data_q(j),
			C => smpl_clk,
			CE => '1',
			D1 => dac_data_q0(j),
			D2 => dac_data_q1(j),
			R => '0',
			S => '0'
		);
	end generate;

	OBUFDS_inst_generate_data1_q : for j in 0 to 15 generate
		OBUFDS_inst_data1_q : OBUFDS
		generic map (
			IOSTANDARD => "LVDS_25")
		port map (
			O  => dac_data_q_p(j),
			OB => dac_data_q_n(j),
			I => data_q(j)
		);
	end generate;

        -----------------------------------------------------------------------
        -- Clock Management
        -----------------------------------------------------------------------
        
        GEN_DCM : if OUTPUT_CLK = 1 generate
        
          IBUFDS_inst_dac_clk : IBUFGDS
            generic map (
                IOSTANDARD => "LVDS_25") 
            port map (
              O => dac_clk_in,           
              I => dac_clk_p,
              IB => dac_clk_n
              );       

          
          
          BUFG_clk_dac : BUFG
            port map (I => dac_clk_in, O => dac_clk);
          
          BUFG_clk : BUFG
            port map (I => dcm_clk, O => clk);
          
            BUFG_clk90 : BUFG
              port map (I => dcm_clk90, O => clk90);
          
          BUFG_clk180 : BUFG
            port map (I => dcm_clk180, O => clk180);
          
          BUFG_clk270 : BUFG
            port map (I => dcm_clk270, O => clk270);
          
          --  out clock to fpga
          
          dac_clk_out <= clk;
          dac_clk90_out <= clk90;
          dac_clk180_out <= clk180;
          dac_clk270_out <= clk270;       
          
          
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
              CLKIN                 => dac_clk,
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
              LOCKED                => dac_dcm_locked,
              PSDONE                => open,
              STATUS                => open
              );
        
        end generate;   
        
 
end Structural;
