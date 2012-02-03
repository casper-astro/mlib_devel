-- ASIAA 5 GSps ADC DMUX 1:2 board interface
-- This should run at the full rate of the ADC but
-- with 4-bit samples. 
--
-----------------------------------------------------------
-- Block Name: adc5g_dmux2
--
----------------------------------------------------------
-- Designer: Rurik Primiani
-- 
-- Revisions: initial 8-04-2011
--            for sx95t-1  (Roach1 board)
--
--
--
----------------------------------------------------------
library ieee;
 use ieee.std_logic_1164.all;

library unisim;
    use unisim.vcomponents.all;

--------------------------------------------
--    ENTITY section
--------------------------------------------

entity adc5g_dmux2_interface is
   generic (  
	  adc_bit_width : integer :=8;
          mode          : integer :=0;    -- 1-channel mode
          clkin_period  : real    :=2.0;  -- clock in period (ns)
          pll_m         : integer :=2;    -- PLL multiplier value
          pll_d         : integer :=1;    -- PLL divide value
          pll_o0        : integer :=2;    -- PLL first clock divide
          pll_o1        : integer :=2     -- PLL second clock divide
	     )  ;
   port (
	 adc_clk_p_i    :  in std_logic;
         adc_clk_n_i    :  in std_logic;
         adc_data0_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
         adc_data0_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
         adc_data1_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
         adc_data1_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
         adc_data2_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
         adc_data2_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
         adc_data3_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3
         adc_data3_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3

         --adc_reset_i      :  in std_logic;
         adc_reset_o      :  out std_logic;

         user_data_i0    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_i1    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_i2    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_i3    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_i4    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_i5    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_i6    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_i7    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q0    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q1    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q2    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q3    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q4    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q5    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q6    :  out std_logic_vector(adc_bit_width/2-1 downto 0);
         user_data_q7    :  out std_logic_vector(adc_bit_width/2-1 downto 0);

         adc_sync_p     :  in  std_logic;
         adc_sync_n     :  in  std_logic;
         sync       :  out std_logic;
    
         ctrl_reset      : in  std_logic;
         ctrl_clk_in     : in  std_logic;
         ctrl_clk_out    : out std_logic;
         ctrl_clk90_out  : out std_logic;
         ctrl_clk180_out : out std_logic;
         ctrl_clk270_out : out std_logic;
         ctrl_dcm_locked : out std_logic;

         --adc_clk_out     : out std_logic;

         dcm_reset       : in  std_logic;
         dcm_psclk       : in  std_logic;
         dcm_psen        : in  std_logic;
         dcm_psincdec    : in  std_logic;
         dcm_psdone      : out std_logic

        );

end  adc5g_dmux2_interface ;


----------------------------------------------
--    ARCHITECTURE section
----------------------------------------------

architecture behavioral of adc5g_dmux2_interface is

  -- Clock, reset, sync signals
  signal adc_clk      : std_logic;
  signal adc_sync     : std_logic;
  signal reset        : std_logic;

  -- PLL signals
  signal pll_clkfbin  : std_logic;
  signal pll_clkfbout : std_logic;
  signal pll_clkout0  : std_logic;
  signal pll_clkout1  : std_logic;
  signal pll_clkout2  : std_logic;
  signal pll_clkout3  : std_logic;
  signal pll_locked   : std_logic;
  signal pll_rst      : std_logic;

  -- IDDR signals
  signal iddr_clk     : std_logic;
  signal iddr_rst     : std_logic;

  -- first core, "A"
  signal   data0      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data0a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data0b     :   std_logic_vector(adc_bit_width-1 downto 0);

  -- second core, "C"
  signal   data1      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data1a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data1b     :   std_logic_vector(adc_bit_width-1 downto 0);

  -- third core, "B"
  signal   data2      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data2a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data2b     :   std_logic_vector(adc_bit_width-1 downto 0);

  -- fourth core, "D"
  signal   data3      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data3a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data3b     :   std_logic_vector(adc_bit_width-1 downto 0);

begin

  -- purpose: synchronously reset the PLL and IDDR's
  -- type   : combinational
  -- inputs : adc_clk
  -- outputs: reset
  RST: process (adc_clk)
  begin  -- process RST
    if (adc_clk'event and adc_clk='1') then
      if (ctrl_reset='1') then
        reset <= '1';
      else
        reset <= '0';
      end if;
    end if;
  end process RST;

  pll_rst <= reset;
  iddr_rst <= reset;
  adc_reset_o <= reset;
  

  chan1_mode: if (mode=0) generate
    user_data_i0 <= data0a(adc_bit_width/2-1 downto 0); 
    user_data_i1 <= data1a(adc_bit_width/2-1 downto 0); 
    user_data_i2 <= data2a(adc_bit_width/2-1 downto 0); 
    user_data_i3 <= data3a(adc_bit_width/2-1 downto 0); 
    user_data_i4 <= data0a(adc_bit_width-1 downto adc_bit_width/2);
    user_data_i5 <= data1a(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_i6 <= data2a(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_i7 <= data3a(adc_bit_width-1 downto adc_bit_width/2); 

    user_data_q0 <= data0b(adc_bit_width/2-1 downto 0); 
    user_data_q1 <= data1b(adc_bit_width/2-1 downto 0); 
    user_data_q2 <= data2b(adc_bit_width/2-1 downto 0); 
    user_data_q3 <= data3b(adc_bit_width/2-1 downto 0); 
    user_data_q4 <= data0b(adc_bit_width-1 downto adc_bit_width/2);
    user_data_q5 <= data1b(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_q6 <= data2b(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_q7 <= data3b(adc_bit_width-1 downto adc_bit_width/2); 
  end generate chan1_mode;

  chan2_mode: if (mode=1) generate
    user_data_i0 <= data0a(adc_bit_width/2-1 downto 0); 
    user_data_i1 <= data2a(adc_bit_width/2-1 downto 0); 
    user_data_i2 <= data0a(adc_bit_width-1 downto adc_bit_width/2);
    user_data_i3 <= data2a(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_i4 <= data0b(adc_bit_width/2-1 downto 0); 
    user_data_i5 <= data2b(adc_bit_width/2-1 downto 0); 
    user_data_i6 <= data0b(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_i7 <= data2b(adc_bit_width-1 downto adc_bit_width/2); 

    user_data_q0 <= data1a(adc_bit_width/2-1 downto 0); 
    user_data_q1 <= data3a(adc_bit_width/2-1 downto 0); 
    user_data_q2 <= data1a(adc_bit_width-1 downto adc_bit_width/2);
    user_data_q3 <= data3a(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_q4 <= data1b(adc_bit_width/2-1 downto 0); 
    user_data_q5 <= data3b(adc_bit_width/2-1 downto 0); 
    user_data_q6 <= data1b(adc_bit_width-1 downto adc_bit_width/2); 
    user_data_q7 <= data3b(adc_bit_width-1 downto adc_bit_width/2); 
  end generate chan2_mode;

-------------------------------------------------------
-- Component Instantiation
-------------------------------------------------------

  -- Clocks

  CBUF0:   IBUFGDS
    generic map(
      DIFF_TERM => TRUE,
      IOSTANDARD => "LVDS_25"
      )
    port map (
      i=> adc_sync_p,
      ib=> adc_sync_n,
      o=> adc_sync
      );

  CBUF1:   IBUFGDS
    generic map(
      DIFF_TERM => TRUE,
      IOSTANDARD => "LVDS_25"
      )
    port map (
      i=> adc_clk_p_i,
      ib=> adc_clk_n_i,
      o=> adc_clk
      );

  PLL0: PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLKFBOUT_MULT      => pll_m,
      CLKFBOUT_PHASE     => 0.0,
      CLKIN_PERIOD       => clkin_period,
      CLKOUT0_DIVIDE     => pll_o1,
      CLKOUT0_PHASE      => 0.0,
      CLKOUT0_DUTY_CYCLE => 0.50,
      CLKOUT1_DIVIDE     => pll_o1,
      CLKOUT1_PHASE      => 90.0,
      CLKOUT1_DUTY_CYCLE => 0.50,
      CLKOUT2_DIVIDE     => pll_o1,
      CLKOUT2_PHASE      => 180.0,
      CLKOUT2_DUTY_CYCLE => 0.50,
      CLKOUT3_DIVIDE     => pll_o1,
      CLKOUT3_PHASE      => 270.0,
      CLKOUT3_DUTY_CYCLE => 0.50,
      COMPENSATION       => "SYSTEM_SYNCHRONOUS",
      DIVCLK_DIVIDE      => pll_d,
      REF_JITTER         => 0.1
      )
    port map (
      CLKIN    => adc_clk,
      CLKFBIN  => pll_clkfbin,
      CLKFBOUT => pll_clkfbout,
      CLKOUT0  => pll_clkout0,
      CLKOUT1  => pll_clkout1,
      CLKOUT2  => pll_clkout2,
      CLKOUT3  => pll_clkout3,
      LOCKED   => pll_locked,
      RST      => pll_rst
      );


  CBUF2a:  BUFG     port map (i=> pll_clkfbout, o=> pll_clkfbin);
  CBUF2b:  BUFG     port map (i=> pll_clkout0,  o=> iddr_clk);
  CBUF2c:  BUFG     port map (i=> pll_clkout1,  o=> ctrl_clk90_out);
  CBUF2d:  BUFG     port map (i=> pll_clkout2,  o=> ctrl_clk180_out);
  CBUF2e:  BUFG     port map (i=> pll_clkout3,  o=> ctrl_clk270_out);


  ctrl_dcm_locked <= pll_locked;
  sync <= adc_sync;

  ctrl_clk_out <= iddr_clk;

  
  IBUFDS0 : for i in adc_bit_width-1 downto 0 generate
    IBUFI0  :  IBUFDS_LVDS_25
      port map (  i  => adc_data0_p_i(i),
                  ib => adc_data0_n_i(i),
                  o  => data0(i)
                  );
  end generate IBUFDS0;


  IBUFDS1 : for i in adc_bit_width-1 downto 0 generate
    IBUFI1  :  IBUFDS_LVDS_25
      port map (  i  => adc_data1_p_i(i),
                  ib => adc_data1_n_i(i),
                  o  => data1(i)
                  );
  end generate IBUFDS1;


  IBUFDS2 : for i in adc_bit_width-1 downto 0 generate
    IBUFI2  :  IBUFDS_LVDS_25
      port map (  i  => adc_data2_p_i(i),
                  ib => adc_data2_n_i(i),
                  o  => data2(i)
                  );
  end generate IBUFDS2;


  IBUFDS3 : for i in adc_bit_width-1 downto 0 generate
    IBUF3  :  IBUFDS_LVDS_25
      port map (  i  => adc_data3_p_i(i),
                  ib => adc_data3_n_i(i),
                  o  => data3(i)
                  );
  end generate IBUFDS3;

  
  iddrx : for i in adc_bit_width-1 downto 0 generate

    iddr0: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data0a(i),
        Q2 => data0b(i),
        C  => iddr_clk,
        CE => '1',
        D  => data0(i),
        R  => iddr_rst,
        S  => '0'
        );

    iddr1: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data1a(i),
        Q2 => data1b(i),
        C  => iddr_clk,
        CE => '1',
        D  => data1(i),
        R  => iddr_rst,
        S  => '0'
        );

    iddr2: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data2a(i),
        Q2 => data2b(i),
        C  => iddr_clk,
        CE => '1',
        D  => data2(i),
        R  => iddr_rst,
        S  => '0'
        );

    iddr3: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data3a(i),
        Q2 => data3b(i),
        C  => iddr_clk,
        CE => '1',
        D  => data3(i),
        R  => iddr_rst,
        S  => '0'
        ); 
  end generate iddrx;


end behavioral;    
