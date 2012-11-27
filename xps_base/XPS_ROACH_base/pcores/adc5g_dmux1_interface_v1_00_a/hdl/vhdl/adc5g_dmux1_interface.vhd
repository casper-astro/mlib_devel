-- ASIAA 5 GSps ADC DMUX 1:1 board interface
-- This should run at up to 3.6 GSps on a ROACH 1
-- with a -1 speed grade chip
--
-----------------------------------------------------------
-- Block Name: adc5g_dmux1
--
----------------------------------------------------------
-- Designers: Rurik Primiani, Homin Jiang, Kim Guzzino
-- 
-- Revisions: initial 8-04-2011
--            for sx95t-1  (Roach1 board)
--
--
--
----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library adc5g_dmux1_interface_v1_00_a;
use adc5g_dmux1_interface_v1_00_a.all;

--------------------------------------------
--    ENTITY section
--------------------------------------------

entity adc5g_dmux1_interface is
  generic (  
    adc_bit_width   : integer :=8;
    clkin_period    : real    :=2.0;  -- clock in period (ns)
    mode            : integer :=0;    -- 1-channel mode
    pll_m           : integer :=2;    -- PLL multiplier value
    pll_d           : integer :=1;    -- PLL divide value
    pll_o0          : integer :=2;    -- PLL first clock divide
    pll_o1          : integer :=2     -- PLL second clock divide
    );
  port (
    adc_clk_p_i     : in std_logic;
    adc_clk_n_i     : in std_logic;
    adc_sync_p      : in std_logic;
    adc_sync_n      : in std_logic;
    dcm_reset       : in std_logic;
    dcm_psclk       : in std_logic;
    dcm_psen        : in std_logic;
    dcm_psincdec    : in std_logic;
    ctrl_reset      : in std_logic;
    ctrl_clk_in     : in std_logic;
    adc_data0_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc_data0_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i0:i1
    adc_data1_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc_data1_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q0:q1
    adc_data2_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc_data2_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --i2:i3
    adc_data3_p_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3
    adc_data3_n_i   : in std_logic_vector(adc_bit_width-1 downto 0); --q2:q3

    sync            : out std_logic;
    dcm_psdone      : out std_logic;
    ctrl_clk_out    : out std_logic;
    ctrl_clk90_out  : out std_logic;
    ctrl_clk180_out : out std_logic;
    ctrl_clk270_out : out std_logic;
    ctrl_dcm_locked : out std_logic;
    fifo_full_cnt   : out std_logic_vector(15 downto 0);
    fifo_empty_cnt  : out std_logic_vector(15 downto 0);
    user_data_i0    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i1    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i2    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i3    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i4    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i5    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i6    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_i7    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q0    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q1    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q2    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q3    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q4    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q5    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q6    : out std_logic_vector(adc_bit_width-1 downto 0);
    user_data_q7    : out std_logic_vector(adc_bit_width-1 downto 0);
    adc_reset_o     : out std_logic
    );
end  adc5g_dmux1_interface ;


----------------------------------------------
--    ARCHITECTURE section
----------------------------------------------

architecture behavioral of adc5g_dmux1_interface is

  -- Clock and sync signals
  signal adc_clk       : std_logic;
  signal adc_sync      : std_logic;

  -- PLL signals
  signal pll_clkin    : std_logic;
  signal pll_clkfb    : std_logic;
  signal pll_clkout0  : std_logic;
  signal pll_clkout1  : std_logic;
  signal pll_clkout2  : std_logic;
  signal pll_clkout3  : std_logic;
  signal pll_clkout4  : std_logic;
  signal pll_locked   : std_logic;
  signal pll_rst      : std_logic;

  -- DCM signals
  signal dcm_clkfbin  : std_logic;
  signal dcm_clkfbout : std_logic;
  signal dcm_locked   : std_logic;
  signal dcm_rst      : std_logic;
  
  -- ISERDES signals
  signal isd_clk       : std_logic;
  signal isd_clkn      : std_logic;
  signal isd_clkdiv    : std_logic;
  signal isd_rst       : std_logic;
  signal isd0_rst0     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd1_rst0     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd2_rst0     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd3_rst0     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd0_rst1     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd1_rst1     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd2_rst1     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd3_rst1     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd0_rst2     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd1_rst2     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd2_rst2     : std_logic_vector(adc_bit_width-1 downto 0);
  signal isd3_rst2     : std_logic_vector(adc_bit_width-1 downto 0);

  -- FIFO signals
  signal fifo_rst      : std_logic;
  signal fifo_wr_clk   : std_logic;
  signal fifo_rd_clk   : std_logic;
  signal fifo_wr_en    : std_logic;
  signal fifo_rd_en    : std_logic;
  signal fifo_full     : std_logic;
  signal fifo_afull    : std_logic;
  signal fifo_empty    : std_logic;
  signal fifo_full_ci  : std_logic_vector(15 downto 0);
  signal fifo_empty_ci : std_logic_vector(15 downto 0);
  signal fifo_din      : std_logic_vector(143 downto 0);
  signal fifo_din_buf0 : std_logic_vector(143 downto 0);
  signal fifo_din_buf1 : std_logic_vector(143 downto 0);
  signal fifo_dout     : std_logic_vector(143 downto 0);

  -- first core, "A"
  signal data0         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0c        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0d        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0c_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0d_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0c_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0d_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0c_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0d_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0c_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0d_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0c_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0d_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0c_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0d_post   : std_logic_vector(adc_bit_width-1 downto 0);
                       
  -- second core, "B"  
  signal data1         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1c        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1d        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1c_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1d_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1c_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1d_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1c_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1d_prebuf1: std_logic_vector(adc_bit_width-1 downto 0); 
  signal data1a_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1c_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1d_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1c_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1d_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1c_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1d_post   : std_logic_vector(adc_bit_width-1 downto 0);
                      
  -- third core, "C"   
  signal data2         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2c        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2d        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2c_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2d_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2c_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2d_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2c_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2d_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2c_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2d_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2c_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2d_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2c_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2d_post   : std_logic_vector(adc_bit_width-1 downto 0);
                       
  -- fourth core, "D"  
  signal data3         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3c        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3d        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3c_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3d_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3c_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3d_prebuf0: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3c_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3d_prebuf1: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3c_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3d_prebuf2: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3c_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3d_prebuf3: std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3c_post   : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3d_post   : std_logic_vector(adc_bit_width-1 downto 0);

  -- Gray code to binary converter
  component gc2bin
    generic (
      DATA_WIDTH   : integer := adc_bit_width
      );
    port (
      gc  : in std_logic_vector(adc_bit_width-1 downto 0);
      bin : out std_logic_vector(adc_bit_width-1 downto 0)
      );
  end component;

  -- async FIFO for clock-domain crossing
  component fifo_generator_v5_3
    port (
      rst         : in  std_logic;
      wr_clk      : in  std_logic;
      rd_clk      : in  std_logic;
      din         : in  std_logic_vector(143 downto 0);
      wr_en       : in  std_logic;
      rd_en       : in  std_logic;
      dout        : out std_logic_vector(143 downto 0);
      full        : out std_logic;
      almost_full : out std_logic;
      empty       : out std_logic);
  end component;
  
begin

  -- Resets
  adc_reset_o <= '0';
  isd_rst     <= ctrl_reset;
  pll_rst     <= ctrl_reset;
  dcm_rst     <= ctrl_reset;
  fifo_rst    <= not pll_locked;

  -- Clocks

  CBUF0:   IBUFDS
    generic map(
      DIFF_TERM => TRUE,
      IOSTANDARD => "LVDS_25"
      )
    port map (
      i=> adc_sync_p,
      ib=> adc_sync_n,
      o=> adc_sync
      );

  CBUF1:   IBUFDS
    generic map(
      DIFF_TERM => TRUE,
      IOSTANDARD => "LVDS_25"
      )
    port map (
      i=> adc_clk_p_i,
      ib=> adc_clk_n_i,
      o=> adc_clk
      );

  DCM0: DCM_ADV
    generic map (
      DLL_FREQUENCY_MODE  => "HIGH",
      DFS_FREQUENCY_MODE  => "HIGH",
      CLKOUT_PHASE_SHIFT  => "VARIABLE_POSITIVE",
      CLKIN_PERIOD        => clkin_period
      )
    port map (
      CLK0      => dcm_clkfbout,
      CLK90     => pll_clkin,
      CLKIN     => adc_clk,
      CLKFB     => dcm_clkfbin,
      DADDR     => "0000000",
      DCLK      => '0',
      DEN       => '0',
      DI        => X"0000",
      DO        => open,
      DRDY      => open,
      DWE       => '0',
      LOCKED    => dcm_locked,
      PSCLK     => dcm_psclk,
      PSDONE    => dcm_psdone,
      PSEN      => dcm_psen,
      PSINCDEC  => dcm_psincdec,
      RST       => dcm_rst
      );

  CBUF2a:  BUFG     port map (i=> dcm_clkfbout, o=> dcm_clkfbin);

  PLL: PLL_BASE
    generic map (
      COMPENSATION       => "SYSTEM_SYNCHRONOUS",
      BANDWIDTH          => "OPTIMIZED",
      CLKIN_PERIOD       => clkin_period,
      DIVCLK_DIVIDE      => pll_d,
      CLKFBOUT_MULT      => pll_m,
      CLKFBOUT_PHASE     => 0.0,
      CLKOUT0_DIVIDE     => pll_o0,
      CLKOUT1_DIVIDE     => pll_o1,
      CLKOUT2_DIVIDE     => pll_o1,
      CLKOUT3_DIVIDE     => pll_o1,
      CLKOUT4_DIVIDE     => pll_o1,
      CLKOUT0_PHASE      => 0.0,
      CLKOUT1_PHASE      => 0.0,
      CLKOUT2_PHASE      => 90.0,
      CLKOUT3_PHASE      => 180.0,
      CLKOUT4_PHASE      => 270.0,
      CLKOUT1_DUTY_CYCLE => 0.50,
      CLKOUT0_DUTY_CYCLE => 0.50,
      CLKOUT2_DUTY_CYCLE => 0.50,
      CLKOUT3_DUTY_CYCLE => 0.50,
      CLKOUT4_DUTY_CYCLE => 0.50,
      REF_JITTER         => 0.1
      )
    port map (
      CLKIN     => pll_clkin,
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

  CBUF2b:  BUFG     port map (i=> pll_clkout0,  o=> isd_clk);
  CBUF2c:  BUFG     port map (i=> pll_clkout1,  o=> isd_clkdiv);
  CBUF2d:  BUFG     port map (i=> pll_clkout2,  o=> ctrl_clk90_out);
  CBUF2e:  BUFG     port map (i=> pll_clkout3,  o=> ctrl_clk180_out);
  CBUF2f:  BUFG     port map (i=> pll_clkout4,  o=> ctrl_clk270_out);

  ctrl_dcm_locked <= dcm_locked;
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

    iserdes0  : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE=> TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data0d_pre(i),
        Q2 => data0c_pre(i),
        Q3 => data0b_pre(i),
        Q4 => data0a_pre(i),
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

    iserdes1  : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE=> TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data1d_pre(i),
        Q2 => data1c_pre(i),
        Q3 => data1b_pre(i),
        Q4 => data1a_pre(i),
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

    iserdes2  : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE=> TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data2d_pre(i),
        Q2 => data2c_pre(i),
        Q3 => data2b_pre(i),
        Q4 => data2a_pre(i),
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

    iserdes3  : ISERDES_NODELAY
      generic map (
        BITSLIP_ENABLE=> TRUE,
        DATA_RATE     => "DDR",
        DATA_WIDTH    =>  4,
        INTERFACE_TYPE=> "NETWORKING",
        SERDES_MODE   => "MASTER",
        NUM_CE        =>  2
        )
      port map  (
        Q1 => data3d_pre(i),
        Q2 => data3c_pre(i),
        Q3 => data3b_pre(i),
        Q4 => data3a_pre(i),
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

  -- Convert from gray-code to binary
  GC2B0A : gc2bin port map (gc  => data0a_prebuf0, bin => data0a_prebuf1);
  GC2B0B : gc2bin port map (gc  => data0b_prebuf0, bin => data0b_prebuf1);
  GC2B0C : gc2bin port map (gc  => data0c_prebuf0, bin => data0c_prebuf1);
  GC2B0D : gc2bin port map (gc  => data0d_prebuf0, bin => data0d_prebuf1);
  GC2B1A : gc2bin port map (gc  => data1a_prebuf0, bin => data1a_prebuf1);
  GC2B1B : gc2bin port map (gc  => data1b_prebuf0, bin => data1b_prebuf1);
  GC2B1C : gc2bin port map (gc  => data1c_prebuf0, bin => data1c_prebuf1);
  GC2B1D : gc2bin port map (gc  => data1d_prebuf0, bin => data1d_prebuf1);
  GC2B2A : gc2bin port map (gc  => data2a_prebuf0, bin => data2a_prebuf1);
  GC2B2B : gc2bin port map (gc  => data2b_prebuf0, bin => data2b_prebuf1);
  GC2B2C : gc2bin port map (gc  => data2c_prebuf0, bin => data2c_prebuf1);
  GC2B2D : gc2bin port map (gc  => data2d_prebuf0, bin => data2d_prebuf1);
  GC2B3A : gc2bin port map (gc  => data3a_prebuf0, bin => data3a_prebuf1);
  GC2B3B : gc2bin port map (gc  => data3b_prebuf0, bin => data3b_prebuf1);
  GC2B3C : gc2bin port map (gc  => data3c_prebuf0, bin => data3c_prebuf1);
  GC2B3D : gc2bin port map (gc  => data3d_prebuf0, bin => data3d_prebuf1);
  
  -- Buffer up samples (to help with timing on ROACH2 rev-1)
  data_buf : for i in adc_bit_width-1 downto 0 generate
    -- first stage of buffers
    D0A_1: FD port map (C => isd_clkdiv, D => data0a_pre(i), Q => data0a_prebuf0(i));
    D0B_1: FD port map (C => isd_clkdiv, D => data0b_pre(i), Q => data0b_prebuf0(i));
    D0C_1: FD port map (C => isd_clkdiv, D => data0c_pre(i), Q => data0c_prebuf0(i));
    D0D_1: FD port map (C => isd_clkdiv, D => data0d_pre(i), Q => data0d_prebuf0(i));
    D1A_1: FD port map (C => isd_clkdiv, D => data1a_pre(i), Q => data1a_prebuf0(i));
    D1B_1: FD port map (C => isd_clkdiv, D => data1b_pre(i), Q => data1b_prebuf0(i));
    D1C_1: FD port map (C => isd_clkdiv, D => data1c_pre(i), Q => data1c_prebuf0(i));
    D1D_1: FD port map (C => isd_clkdiv, D => data1d_pre(i), Q => data1d_prebuf0(i));
    D2A_1: FD port map (C => isd_clkdiv, D => data2a_pre(i), Q => data2a_prebuf0(i));
    D2B_1: FD port map (C => isd_clkdiv, D => data2b_pre(i), Q => data2b_prebuf0(i));
    D2C_1: FD port map (C => isd_clkdiv, D => data2c_pre(i), Q => data2c_prebuf0(i));
    D2D_1: FD port map (C => isd_clkdiv, D => data2d_pre(i), Q => data2d_prebuf0(i));
    D3A_1: FD port map (C => isd_clkdiv, D => data3a_pre(i), Q => data3a_prebuf0(i));
    D3B_1: FD port map (C => isd_clkdiv, D => data3b_pre(i), Q => data3b_prebuf0(i));
    D3C_1: FD port map (C => isd_clkdiv, D => data3c_pre(i), Q => data3c_prebuf0(i));
    D3D_1: FD port map (C => isd_clkdiv, D => data3d_pre(i), Q => data3d_prebuf0(i));
    -- second stage of buffers
    D0A_2: FD port map (C => isd_clkdiv, D => data0a_prebuf1(i), Q => data0a_prebuf2(i));
    D0B_2: FD port map (C => isd_clkdiv, D => data0b_prebuf1(i), Q => data0b_prebuf2(i));
    D0C_2: FD port map (C => isd_clkdiv, D => data0c_prebuf1(i), Q => data0c_prebuf2(i));
    D0D_2: FD port map (C => isd_clkdiv, D => data0d_prebuf1(i), Q => data0d_prebuf2(i));
    D1A_2: FD port map (C => isd_clkdiv, D => data1a_prebuf1(i), Q => data1a_prebuf2(i));
    D1B_2: FD port map (C => isd_clkdiv, D => data1b_prebuf1(i), Q => data1b_prebuf2(i));
    D1C_2: FD port map (C => isd_clkdiv, D => data1c_prebuf1(i), Q => data1c_prebuf2(i));
    D1D_2: FD port map (C => isd_clkdiv, D => data1d_prebuf1(i), Q => data1d_prebuf2(i));
    D2A_2: FD port map (C => isd_clkdiv, D => data2a_prebuf1(i), Q => data2a_prebuf2(i));
    D2B_2: FD port map (C => isd_clkdiv, D => data2b_prebuf1(i), Q => data2b_prebuf2(i));
    D2C_2: FD port map (C => isd_clkdiv, D => data2c_prebuf1(i), Q => data2c_prebuf2(i));
    D2D_2: FD port map (C => isd_clkdiv, D => data2d_prebuf1(i), Q => data2d_prebuf2(i));
    D3A_2: FD port map (C => isd_clkdiv, D => data3a_prebuf1(i), Q => data3a_prebuf2(i));
    D3B_2: FD port map (C => isd_clkdiv, D => data3b_prebuf1(i), Q => data3b_prebuf2(i));
    D3C_2: FD port map (C => isd_clkdiv, D => data3c_prebuf1(i), Q => data3c_prebuf2(i));
    D3D_2: FD port map (C => isd_clkdiv, D => data3d_prebuf1(i), Q => data3d_prebuf2(i));
    -- third stage of buffers
    D0A_3: FD port map (C => isd_clkdiv, D => data0a_prebuf2(i), Q => data0a_prebuf3(i));
    D0B_3: FD port map (C => isd_clkdiv, D => data0b_prebuf2(i), Q => data0b_prebuf3(i));
    D0C_3: FD port map (C => isd_clkdiv, D => data0c_prebuf2(i), Q => data0c_prebuf3(i));
    D0D_3: FD port map (C => isd_clkdiv, D => data0d_prebuf2(i), Q => data0d_prebuf3(i));
    D1A_3: FD port map (C => isd_clkdiv, D => data1a_prebuf2(i), Q => data1a_prebuf3(i));
    D1B_3: FD port map (C => isd_clkdiv, D => data1b_prebuf2(i), Q => data1b_prebuf3(i));
    D1C_3: FD port map (C => isd_clkdiv, D => data1c_prebuf2(i), Q => data1c_prebuf3(i));
    D1D_3: FD port map (C => isd_clkdiv, D => data1d_prebuf2(i), Q => data1d_prebuf3(i));
    D2A_3: FD port map (C => isd_clkdiv, D => data2a_prebuf2(i), Q => data2a_prebuf3(i));
    D2B_3: FD port map (C => isd_clkdiv, D => data2b_prebuf2(i), Q => data2b_prebuf3(i));
    D2C_3: FD port map (C => isd_clkdiv, D => data2c_prebuf2(i), Q => data2c_prebuf3(i));
    D2D_3: FD port map (C => isd_clkdiv, D => data2d_prebuf2(i), Q => data2d_prebuf3(i));
    D3A_3: FD port map (C => isd_clkdiv, D => data3a_prebuf2(i), Q => data3a_prebuf3(i));
    D3B_3: FD port map (C => isd_clkdiv, D => data3b_prebuf2(i), Q => data3b_prebuf3(i));
    D3C_3: FD port map (C => isd_clkdiv, D => data3c_prebuf2(i), Q => data3c_prebuf3(i));
    D3D_3: FD port map (C => isd_clkdiv, D => data3d_prebuf2(i), Q => data3d_prebuf3(i));
  end generate data_buf;
  
  -- Use FIFO to cross clock domains
  FIFO : fifo_generator_v5_3
    port map (
      rst         => fifo_rst,
      wr_clk      => fifo_wr_clk,
      rd_clk      => fifo_rd_clk,
      din         => fifo_din_buf1,
      wr_en       => fifo_wr_en,
      rd_en       => fifo_rd_en,
      dout        => fifo_dout,
      full        => fifo_full,
      almost_full => fifo_afull,
      empty       => fifo_empty
      );

  -- purpose: control the FIFO read enable signal
  -- type   : sequential
  -- inputs : fifo_wr_clk, fifo_rst, fifo_empty
  -- outputs: fifo_rd_en, fifo_din_buf(n)
  FIFO_RD_CTRL: process (fifo_wr_clk, fifo_rst, fifo_empty)
  begin  -- process FIFO_RD_CTRL
    if fifo_wr_clk'event and fifo_wr_clk = '1' then  -- rising clock edge
      if fifo_rst = '1' then              -- synchronous reset (active high)
        fifo_wr_en <= '0';
        fifo_rd_en <= '0';
        fifo_din <= (others => '0');
        fifo_din_buf0 <= (others => '0');
        fifo_din_buf1 <= (others => '0');
      else
        fifo_wr_en <= '1';
        fifo_rd_en <= not fifo_empty;
        fifo_din(143 downto adc_bit_width*16) <= (others => '0');
        fifo_din(adc_bit_width*16-1 downto 0) <=
          data0d_prebuf3 & data0c_prebuf3 & data0b_prebuf3 & data0a_prebuf3 &
          data1d_prebuf3 & data1c_prebuf3 & data1b_prebuf3 & data1a_prebuf3 &
          data2d_prebuf3 & data2c_prebuf3 & data2b_prebuf3 & data2a_prebuf3 &
          data3d_prebuf3 & data3c_prebuf3 & data3b_prebuf3 & data3a_prebuf3;
        fifo_din_buf0 <= fifo_din;
        fifo_din_buf1 <= fifo_din_buf0;
      end if;
    end if;
  end process FIFO_RD_CTRL;

  -- purpose: count the number of times the FIFO's full signal is asserted
  -- type   : sequential
  -- inputs : fifo_wr_clk, ctrl_reset, fifo_full_ci
  -- outputs: fifo_full_ci
  FIFO_FULL_CNTR: process (fifo_wr_clk, ctrl_reset)
  begin  -- process FIFO_FULL_CNTR
    if ctrl_reset = '1' then              -- asynchronous reset (active high)
      fifo_full_ci <= (others => '0');
    elsif fifo_wr_clk'event and fifo_wr_clk = '1' then  -- rising clock edge
      if fifo_full = '1' then
        fifo_full_ci <= std_logic_vector(unsigned(fifo_full_ci) + 1);
      end if;
    end if;
  end process;
  fifo_full_cnt <= fifo_full_ci;

  -- purpose: count the number of times the FIFO's empty signal is asserted
  -- type   : sequential
  -- inputs : fifo_rd_clk, ctrl_reset, fifo_empty_ci
  -- outputs: fifo_empty_ci
  FIFO_EMPTY_CNTR: process (fifo_rd_clk, ctrl_reset)
  begin  -- process FIFO_EMPTY_CNTR
    if ctrl_reset = '1' then              -- asynchronous reset (active high)
      fifo_empty_ci <= (others => '0');
    elsif fifo_rd_clk'event and fifo_rd_clk = '1' then  -- rising clock edge
      if fifo_empty = '1' then
        fifo_empty_ci <= std_logic_vector(unsigned(fifo_empty_ci) + 1);
      end if;
    end if;
  end process;
  fifo_empty_cnt <= fifo_empty_ci;

  fifo_wr_clk <= isd_clkdiv;
  fifo_rd_clk <= ctrl_clk_in;
  data0d <= fifo_dout(adc_bit_width*16-1 downto adc_bit_width*15); 
  data0c <= fifo_dout(adc_bit_width*15-1 downto adc_bit_width*14);
  data0b <= fifo_dout(adc_bit_width*14-1 downto adc_bit_width*13);
  data0a <= fifo_dout(adc_bit_width*13-1 downto adc_bit_width*12);
  data1d <= fifo_dout(adc_bit_width*12-1 downto adc_bit_width*11);
  data1c <= fifo_dout(adc_bit_width*11-1 downto adc_bit_width*10);
  data1b <= fifo_dout(adc_bit_width*10-1 downto adc_bit_width*9);
  data1a <= fifo_dout(adc_bit_width*9-1  downto adc_bit_width*8);
  data2d <= fifo_dout(adc_bit_width*8-1  downto adc_bit_width*7);
  data2c <= fifo_dout(adc_bit_width*7-1  downto adc_bit_width*6);
  data2b <= fifo_dout(adc_bit_width*6-1  downto adc_bit_width*5);
  data2a <= fifo_dout(adc_bit_width*5-1  downto adc_bit_width*4);
  data3d <= fifo_dout(adc_bit_width*4-1  downto adc_bit_width*3);
  data3c <= fifo_dout(adc_bit_width*3-1  downto adc_bit_width*2);
  data3b <= fifo_dout(adc_bit_width*2-1  downto adc_bit_width);
  data3a <= fifo_dout(adc_bit_width-1    downto 0);
  
  -- Re-order the outputs
  -- when only one input is used (either A or C)
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
  
  -- Re-order the outputs
  -- when both the A & C inputs are used
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


end behavioral;    
