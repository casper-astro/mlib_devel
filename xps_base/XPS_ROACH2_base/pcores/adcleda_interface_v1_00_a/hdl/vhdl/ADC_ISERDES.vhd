----------------------------------------------------------------------------
-- Import useful libraries
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- entity declaraction
entity  ADC_ISERDES  is

    port (
	            -- System
					reset        :  in  std_logic;
					bitslip      :  in  std_logic;
	 
               -- Clock inputs
					clkin        :  in  std_logic; -- line
					clkdiv       :  in  std_logic; -- frame/system

		         -- Phase shift
					s_data        :  in  std_logic;
					p_data        :  out std_logic_vector(3 downto 0)			
    );

end  ADC_ISERDES;

architecture ADC_ISERDES_arc of ADC_ISERDES is

     -- Components
	  
	  component ISERDES generic (
      DATA_RATE            : string;
      DATA_WIDTH           : integer;
      DYN_CLKDIV_INV_EN    : boolean;
      DYN_CLK_INV_EN       : boolean;
      INTERFACE_TYPE       : string;
      NUM_CE               : integer;
      OFB_USED             : boolean;
      SERDES_MODE          : string
      );
     port (
	   O            : out std_logic;
      Q1           : out std_logic;
		Q2           : out std_logic;
		Q3           : out std_logic;
		Q4           : out std_logic;
		Q5           : out std_logic;
		Q6           : out std_logic;
      SHIFTOUT1    : out std_logic;
      SHIFTOUT2    : out std_logic;
		D            : in  std_logic;
      DLYINC       : in  std_logic;
		DLYCE        : in  std_logic;
		DLYRST       : in  std_logic;
		REV          : in  std_logic;
      CLK          : in  std_logic;
      CE1          : in  std_logic;
      CE2          : in  std_logic;
		SR           : in  std_logic;
      CLKDIV       : in  std_logic;
      OCLK         : in  std_logic;
      BITSLIP      : in  std_logic;
      SHIFTIN1     : in  std_logic;
      SHIFTIN2     : in  std_logic;
      OFB          : in  std_logic
		);
     end component;
	  
	  -- ISERDES Master
	  signal iserdes_m_q1        : std_logic;
	  signal iserdes_m_q2        : std_logic;
	  signal iserdes_m_q3        : std_logic;
	  signal iserdes_m_q4        : std_logic;
	  signal iserdes_m_d         : std_logic;
     signal iserdes_m_clk       : std_logic;
     signal iserdes_m_sr        : std_logic;
     signal iserdes_m_clkdiv    : std_logic;
     signal iserdes_m_bitslip   : std_logic;

     signal iserdes_bitslip_d1 : std_logic;
     signal iserdes_bitslip_d2 : std_logic;
     signal iserdes_bitslip_d3 : std_logic;

     begin

	  -- Signal routing
	  iserdes_m_clk <= clkin;
	  iserdes_m_clkdiv <= clkdiv;
	  iserdes_m_sr <= reset;	  
	  iserdes_m_d <= s_data;
	  p_data(0) <= iserdes_m_q1;
	  p_data(1) <= iserdes_m_q2;
	  p_data(2) <= iserdes_m_q3;
	  p_data(3) <= iserdes_m_q4;

     process (clkdiv)
     begin
         if rising_edge(clkdiv) then
             iserdes_bitslip_d1 <= bitslip;
             iserdes_bitslip_d2 <= iserdes_bitslip_d1;
             iserdes_bitslip_d3 <= iserdes_bitslip_d2;
             iserdes_m_bitslip <= (not iserdes_bitslip_d3 and iserdes_bitslip_d2);
         end if;
     end process;
	  
	  -- ISERDES Master
     iserdes_m_inst : ISERDES
     GENERIC MAP (
      DATA_RATE            => "DDR",
      DATA_WIDTH           => 4,
      DYN_CLKDIV_INV_EN    => false,
      DYN_CLK_INV_EN       => false,
      INTERFACE_TYPE       => "NETWORKING",
      NUM_CE               => 1,
      OFB_USED             => false,
      SERDES_MODE          => "MASTER"
      )
     PORT MAP (
	   O            => open,
      Q1           => iserdes_m_q1,
		Q2           => iserdes_m_q2,
		Q3           => iserdes_m_q3,
		Q4           => iserdes_m_q4,
		Q5           => open,
		Q6           => open,
      SHIFTOUT1    => open,
      SHIFTOUT2    => open,
		D            => iserdes_m_d,
		DLYINC       => '0',
		DLYCE        => '0',
		DLYRST       => '0',
		REV          => '0',
      CLK          => iserdes_m_clk,
      CE1          => '1',
      CE2          => '0',
      SR           => iserdes_m_sr,
      CLKDIV       => iserdes_m_clkdiv,
      OCLK         => '0',
      BITSLIP      => iserdes_m_bitslip,
      SHIFTIN1     => '0',
      SHIFTIN2     => '0',
      OFB          => '0'
      );	
		
end ADC_ISERDES_arc;

