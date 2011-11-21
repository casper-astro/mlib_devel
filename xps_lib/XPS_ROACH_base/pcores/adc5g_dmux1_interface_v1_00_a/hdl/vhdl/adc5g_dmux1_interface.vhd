-- adc with iserdes block
-- adc 4gsps on 4 channels to zdoc 
--     1 Gbps on each wire DDR with 500Mhz clock
-- if used on a roach2 board with a Virtex6 can run to 5Gsps 1.25Gbps/wire
-----------------------------------------------------------
-- Block Name: adc_pll
--
----------------------------------------------------------
-- Designer: Kim Guzzino
-- 
-- Revisions: initial 3-31-2011
--            for sx95t-2  (Roach1 board)
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

entity adc5g_dmux1_interface is
   generic (  
	  adc_bit_width : integer :=8;
          mode          : integer :=0;    -- 1-channel mode
          clkin_period  : real    :=2.0;  -- clock in period (ns)
          pll_m         : integer :=1;    -- PLL multiplier value
          pll_d         : integer :=1;    -- PLL divide value
          pll_o0        : integer :=1;    -- PLL first clock divide
          pll_o1        : integer :=2     -- PLL second clock divide
	     )  ;
   port (
	 adc_clk_p_i    :  in std_logic;
         adc_clk_n_i    :  in std_logic;
         adc_data0_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i0
         adc_data0_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i0
         adc_data1_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q0
         adc_data1_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q0
         adc_data2_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i1
         adc_data2_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --i1
         adc_data3_p_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q1
         adc_data3_n_i    :  in std_logic_vector(adc_bit_width-1 downto 0); --q1

         --adc_reset_i      :  in std_logic;
         adc_reset_o      :  out std_logic;

         user_data_i0    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_i1    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_i2    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_i3    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_i4    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_i5    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_i6    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_i7    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q0    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q1    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q2    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q3    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q4    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q5    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q6    :  out std_logic_vector(adc_bit_width-1 downto 0);
         user_data_q7    :  out std_logic_vector(adc_bit_width-1 downto 0);

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

end  adc5g_dmux1_interface ;


----------------------------------------------
--    ARCHITECTURE section
----------------------------------------------

architecture behavioral of adc5g_dmux1_interface is

  -- Clock, reset, sync signals
  signal adc_clk      : std_logic;
  signal adc_sync     : std_logic;
  signal reset        : std_logic;

  -- PLL signals
  signal pll_clkfb    : std_logic;
  signal pll_clkout0  : std_logic;
  signal pll_clkout1  : std_logic;
  signal pll_clkout2  : std_logic;
  signal pll_clkout3  : std_logic;
  signal pll_clkout4  : std_logic;
  signal pll_locked   : std_logic;
  signal pll_rst      : std_logic;

  -- ISERDES signals
  signal isd_clk      : std_logic;
  signal isd_clkn     : std_logic;
  signal isd_clkdiv   : std_logic;
  signal isd_rst      : std_logic;

  -- first core, "A"
  signal   data0      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data0a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data0b     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data0c     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data0d     :   std_logic_vector(adc_bit_width-1 downto 0);

  -- first core, "C"
  signal   data1      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data1a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data1b     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data1c     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data1d     :   std_logic_vector(adc_bit_width-1 downto 0);

  -- first core, "B"
  signal   data2      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data2a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data2b     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data2c     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data2d     :   std_logic_vector(adc_bit_width-1 downto 0);

  -- first core, "D"
  signal   data3      :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data3a     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data3b     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data3c     :   std_logic_vector(adc_bit_width-1 downto 0);
  signal   data3d     :   std_logic_vector(adc_bit_width-1 downto 0);

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
  isd_rst <= reset;
  adc_reset_o <= reset;
  

  chan1_mode: if (mode=0) generate
    user_data_i0 <= data0a; 
    user_data_i1 <= data1a; 
    user_data_i2 <= data2a; 
    user_data_i3 <= data3a; 
    user_data_i4 <= data0b; 
    user_data_i5 <= data1b; 
    user_data_i6 <= data2b; 
    user_data_i7 <= data3b; 

    user_data_q0 <= data0c; 
    user_data_q1 <= data1c; 
    user_data_q2 <= data2c; 
    user_data_q3 <= data3c;
    user_data_q4 <= data0d; 
    user_data_q5 <= data1d; 
    user_data_q6 <= data2d; 
    user_data_q7 <= data3d; 
  end generate chan1_mode;
  
  chan2_mode: if (mode=1) generate
    user_data_i0 <= data0a; 
    user_data_i1 <= data2a; 
    user_data_i2 <= data0b; 
    user_data_i3 <= data2b; 
    user_data_i4 <= data0c; 
    user_data_i5 <= data2c; 
    user_data_i6 <= data0d; 
    user_data_i7 <= data2d; 

    user_data_q0 <= data1a; 
    user_data_q1 <= data3a; 
    user_data_q2 <= data1b; 
    user_data_q3 <= data3b;
    user_data_q4 <= data1c; 
    user_data_q5 <= data3c; 
    user_data_q6 <= data1d; 
    user_data_q7 <= data3d; 
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


  PLL: PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLKFBOUT_MULT      => pll_m,
      CLKFBOUT_PHASE     => 0.0,
      CLKIN_PERIOD       => clkin_period,
      CLKOUT0_DIVIDE     => pll_o0,
      CLKOUT0_PHASE      => 0.0,
      CLKOUT0_DUTY_CYCLE => 0.50,
      CLKOUT1_DIVIDE     => pll_o1,
      CLKOUT1_PHASE      => 0.0,
      CLKOUT1_DUTY_CYCLE => 0.50,
      CLKOUT2_DIVIDE     => pll_o1,
      CLKOUT2_PHASE      => 90.0,
      CLKOUT2_DUTY_CYCLE => 0.50,
      CLKOUT3_DIVIDE     => pll_o1,
      CLKOUT3_PHASE      => 180.0,
      CLKOUT3_DUTY_CYCLE => 0.50,
      CLKOUT4_DIVIDE     => pll_o1,
      CLKOUT4_PHASE      => 270.0,
      CLKOUT4_DUTY_CYCLE => 0.50,
      COMPENSATION       => "SYSTEM_SYNCHRONOUS",
      DIVCLK_DIVIDE      => pll_d,
      REF_JITTER         => 0.1
      )
    port map (
      CLKIN     => adc_clk,
      CLKFBIN   => pll_clkfb,
      CLKOUT0   => pll_clkout0,
      CLKOUT1   => pll_clkout1,
      CLKOUT2   => pll_clkout2,
      CLKOUT3   => pll_clkout3,
      CLKOUT4   => pll_clkout4,
      CLKFBOUT  => pll_clkfb,
      LOCKED    => pll_locked,
      RST       => pll_rst
      );


  CBUF2a:  BUFG     port map (i=> pll_clkout0, o=> isd_clk);
  CBUF2b:  BUFG     port map (i=> pll_clkout1, o=> isd_clkdiv);
  CBUF2c:  BUFG     port map (i=> pll_clkout2, o=> ctrl_clk90_out);
  CBUF2d:  BUFG     port map (i=> pll_clkout3, o=> ctrl_clk180_out);
  CBUF2e:  BUFG     port map (i=> pll_clkout4, o=> ctrl_clk270_out);


  ctrl_dcm_locked <= pll_locked;
  sync <= adc_sync;

  ctrl_clk_out <= isd_clkdiv;
  isd_clkn <= not isd_clk;


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

  
  iserdesx : for i in adc_bit_width-1 downto 0 generate

    iserdes0 : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE =>  TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data0d(i),
        Q2 => data0c(i),
        Q3 => data0b(i),
        Q4 => data0a(i),
        Q5 => open,
        Q6 => open,
        SHIFTOUT1 => open,
        SHIFTOUT2 => open,
        BITSLIP   => '0',
        CE1       => '1',
        CE2       => '1',
        CLK       => isd_clk,
        CLKB      => isd_clkn,
        CLKDIV    => isd_clkdiv,
        D         => data0(i),
        OCLK      => '0',
        RST       => isd_rst,
        SHIFTIN1  => '0',
        SHIFTIN2  => '0'
        );

    iserdes1 : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE =>  TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data1d(i),
        Q2 => data1c(i),
        Q3 => data1b(i),
        Q4 => data1a(i),
        Q5 => open,
        Q6 => open,
        SHIFTOUT1 => open,
        SHIFTOUT2 => open,
        BITSLIP   => '0',
        CE1       => '1',
        CE2       => '1',
        CLK       => isd_clk,
        CLKB      => isd_clkn,
        CLKDIV    => isd_clkdiv,
        D         => data1(i),
        OCLK      => '0',
        RST       => isd_rst,
        SHIFTIN1  => '0',
        SHIFTIN2  => '0'
        );

    iserdes2 : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE =>  TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data2d(i),
        Q2 => data2c(i),
        Q3 => data2b(i),
        Q4 => data2a(i),
        Q5 => open,
        Q6 => open,
        SHIFTOUT1 => open,
        SHIFTOUT2 => open,
        BITSLIP   => '0',
        CE1       => '1',
        CE2       => '1',
        CLK       => isd_clk,
        CLKB      => isd_clkn,
        CLKDIV    => isd_clkdiv,
        D         => data2(i),
        OCLK      => '0',
        RST       => isd_rst,
        SHIFTIN1  => '0',
        SHIFTIN2  => '0'
        );

    iserdes3 : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE =>  TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data3d(i),
        Q2 => data3c(i),
        Q3 => data3b(i),
        Q4 => data3a(i),
        Q5 => open,
        Q6 => open,
        SHIFTOUT1 => open,
        SHIFTOUT2 => open,
        BITSLIP   => '0',
        CE1       => '1',
        CE2       => '1',
        CLK       => isd_clk,
        CLKB      => isd_clkn,
        CLKDIV    => isd_clkdiv,
        D         => data3(i),
        OCLK      => '0',
        RST       => isd_rst,
        SHIFTIN1  => '0',
        SHIFTIN2  => '0'
        );
  end generate iserdesx;


end behavioral;    
