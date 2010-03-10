----------------------------------------------------------------------------------
-- dac_mkid_interface : DAC board with two DAC5681 for I and Q signals
----------------------------------------------------------------------------------

-- Author: 
-- Create Date: 	09/02/09
-- modification: 	09/10/09 minimalist version.
			09/16/09 Added DCM.


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
    Port (
      
      --------------------------------------
      -- differential signals from/to DAC
      --------------------------------------

      -- clock from DAC
      dac_clk_p    		: in  STD_LOGIC;
      dac_clk_n    		: in  STD_LOGIC;

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

      
      --------------------------------------
      -- signals from/to design
      --------------------------------------
	dac_clk    			: out	STD_LOGIC;
	dac_smpl_clk_i		: in	STD_LOGIC;
	dac_smpl_clk_q		: in	STD_LOGIC;
	dac_sync_i			: in	STD_LOGIC;
	dac_sync_q			: in	STD_LOGIC;
      dac_data_i			: in	STD_LOGIC_VECTOR (15 downto 0);
      dac_data_q			: in 	STD_LOGIC_VECTOR (15 downto 0)
      );

end dac_mkid_interface;


--------------------------------------------------------------------------------
-- Architecture section
--------------------------------------------------------------------------------
architecture Structural of dac_mkid_interface is

begin
  

    -- Clock out to FPGA --

    IBUFDS_inst_dac_clk : IBUFGDS
    generic map (
       IOSTANDARD => "LVDS_25") 
    port map (
       O => dac_clk,           
       I => dac_clk_p,
       IB => dac_clk_n
    );



    -- Sample clock in to DAC --
    
    OBUFDS_inst_smpl_clk_i : OBUFDS
    generic map (
       IOSTANDARD => "LVDS_25")
    port map (
       O =>  dac_smpl_clk_i_p,
       OB => dac_smpl_clk_i_n,
       I =>  dac_smpl_clk_i
    );
       
    OBUFDS_inst_smpl_clk_q : OBUFDS
    generic map (
       IOSTANDARD => "LVDS_25")
    port map (
       O =>  dac_smpl_clk_q_p,
       OB => dac_smpl_clk_q_n,
       I =>  dac_smpl_clk_q
    );



    -- Enable analog output for DAC --
    
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


    -- DAC data outputs --
    
    OBUFDS_inst_generate_data_i : for j in 0 to 15 generate
      OBUFDS_inst_data_i : OBUFDS
        generic map (
          IOSTANDARD => "LVDS_25")
        port map (
          O  => dac_data_i_p(j),
          OB => dac_data_i_n(j),
          I => dac_data_i(j)
          );
    end generate;

    OBUFDS_inst_generate_data_q : for j in 0 to 15 generate
      OBUFDS_inst_data_q : OBUFDS
        generic map (
          IOSTANDARD => "LVDS_25")
        port map (
          O => dac_data_q_p(j),
          OB => dac_data_q_n(j),
          I => dac_data_q(j)
          );
    end generate;


end Structural;
