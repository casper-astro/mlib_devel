-- ASIAA 5 GSps ADC DMUX 1:2 board interface
-- This should run at up to full rate on ROACH 2,
-- with 4-bit samples
--
-----------------------------------------------------------
-- Block Name: adc5g_dmux2
--
----------------------------------------------------------
-- Designers: Rurik Primiani, Homin Jiang, Kim Guzzino
-- 
-- Revisions: initial 8-04-2011
--            for sx475t-1  (Roach2 board)
--
--
--
----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library adc5g_dmux1_interface_v1_00_a;
use adc5g_dmux1_interface_v1_00_a.all;

--------------------------------------------
--    ENTITY section
--------------------------------------------

entity adc5g_dmux2_interface is
  generic (  
    adc_bit_width   : integer :=8;
    clkin_period    : real    :=2.0;  -- clock in period (ns)
    mode            : integer :=0;    -- 1-channel mode
    mmcm_m          : real    :=2.0;  -- MMCM multiplier value
    mmcm_d          : integer :=1;    -- MMCM divide value
    mmcm_o0         : integer :=2;    -- MMCM first clock divide
    mmcm_o1         : integer :=2     -- MMCM second clock divide
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
    user_data_i0    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_i1    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_i2    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_i3    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_i4    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_i5    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_i6    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_i7    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q0    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q1    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q2    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q3    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q4    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q5    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q6    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    user_data_q7    : out std_logic_vector(adc_bit_width/2-1 downto 0);
    adc_reset_o     : out std_logic
    );
end  adc5g_dmux2_interface ;


----------------------------------------------
--    ARCHITECTURE section
----------------------------------------------

architecture behavioral of adc5g_dmux2_interface is

  -- Clock and sync signals
  signal adc_clk       : std_logic;
  signal adc_sync      : std_logic;

  -- MMCM signals
  signal mmcm_clkfbin  : std_logic;
  signal mmcm_clkfbout : std_logic;
  signal mmcm_clkout0  : std_logic;
  signal mmcm_clkout1  : std_logic;
  signal mmcm_clkout2  : std_logic;
  signal mmcm_clkout3  : std_logic;
  signal mmcm_locked   : std_logic;
  signal mmcm_rst      : std_logic;
  
  -- IDDR signals
  signal iddr_clk      : std_logic;
  signal iddr_rst      : std_logic;
  signal iddr0_rst      : std_logic_vector(adc_bit_width-1 downto 0);
  signal iddr1_rst      : std_logic_vector(adc_bit_width-1 downto 0);
  signal iddr2_rst      : std_logic_vector(adc_bit_width-1 downto 0);
  signal iddr3_rst      : std_logic_vector(adc_bit_width-1 downto 0);

  -- FIFO signals
  signal fifo_rst      : std_logic;
  signal fifo_wr_clk   : std_logic;
  signal fifo_rd_clk   : std_logic;
  signal fifo_wr_en    : std_logic;
  signal fifo_rd_en    : std_logic;
  signal fifo_full     : std_logic;
  signal fifo_afull    : std_logic;
  signal fifo_empty    : std_logic;
  signal fifo_din      : std_logic_vector(143 downto 0);
  signal fifo_din_buf0 : std_logic_vector(143 downto 0);
  signal fifo_din_buf1 : std_logic_vector(143 downto 0);
  signal fifo_dout     : std_logic_vector(143 downto 0);

  -- first core, "A"
  signal data0         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data0b_pre    : std_logic_vector(adc_bit_width-1 downto 0);

  -- second core, "C"
  signal data1         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data1b_pre    : std_logic_vector(adc_bit_width-1 downto 0);
                       
  -- third core, "B"   
  signal data2         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data2b_pre    : std_logic_vector(adc_bit_width-1 downto 0);

  -- fourth core, "D"
  signal data3         : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b        : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3a_pre    : std_logic_vector(adc_bit_width-1 downto 0);
  signal data3b_pre    : std_logic_vector(adc_bit_width-1 downto 0);

  -- Gray code to binary converter
  component gc2bin
    generic (
      DATA_WIDTH   : integer := adc_bit_width/2
      );
    port (
      gc  : in std_logic_vector(adc_bit_width/2-1 downto 0);
      bin : out std_logic_vector(adc_bit_width/2-1 downto 0)
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

  -- Synchronize resets for all components 
  IDDR_R : FD port map (C => ctrl_clk_in, D => ctrl_reset, Q =>    iddr_rst);
  MMCM_R : FD port map (C => ctrl_clk_in, D => ctrl_reset, Q =>    mmcm_rst);
  FIFO_R : FD port map (C => ctrl_clk_in, D => ctrl_reset, Q =>    fifo_rst);
  ADC_R  : FD port map (C => ctrl_clk_in, D => ctrl_reset, Q => adc_reset_o);


  chan1_mode: if (mode=0) generate
    GC2BI0 : gc2bin port map (gc  => data0a(adc_bit_width/2-1 downto 0), bin => user_data_i0);
    GC2BI1 : gc2bin port map (gc  => data1a(adc_bit_width/2-1 downto 0), bin => user_data_i1);
    GC2BI2 : gc2bin port map (gc  => data2a(adc_bit_width/2-1 downto 0), bin => user_data_i2);
    GC2BI3 : gc2bin port map (gc  => data3a(adc_bit_width/2-1 downto 0), bin => user_data_i3);
    GC2BI4 : gc2bin port map (gc  => data0a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i4);
    GC2BI5 : gc2bin port map (gc  => data1a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i5);
    GC2BI6 : gc2bin port map (gc  => data2a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i6);
    GC2BI7 : gc2bin port map (gc  => data3a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i7);
                                                    
    GC2BQ0 : gc2bin port map (gc  => data0b(adc_bit_width/2-1 downto 0), bin => user_data_q0);
    GC2BQ1 : gc2bin port map (gc  => data1b(adc_bit_width/2-1 downto 0), bin => user_data_q1);
    GC2BQ2 : gc2bin port map (gc  => data2b(adc_bit_width/2-1 downto 0), bin => user_data_q2);
    GC2BQ3 : gc2bin port map (gc  => data3b(adc_bit_width/2-1 downto 0), bin => user_data_q3);
    GC2BQ4 : gc2bin port map (gc  => data0b(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_q4);
    GC2BQ5 : gc2bin port map (gc  => data1b(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_q5);
    GC2BQ6 : gc2bin port map (gc  => data2b(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_q6);
    GC2BQ7 : gc2bin port map (gc  => data3b(adc_bit_width-1 downto adc_bit_width/2), Bin => user_data_q7);
  end generate chan1_mode;

  chan2_mode: if (mode=1) generate
    GC2BI0 : gc2bin port map (gc  => data0a(adc_bit_width/2-1 downto 0), bin => user_data_i0);
    GC2BI2 : gc2bin port map (gc  => data2a(adc_bit_width/2-1 downto 0), bin => user_data_i1);
    GC2BI4 : gc2bin port map (gc  => data0a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i2);
    GC2BI6 : gc2bin port map (gc  => data2a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i3);
    GC2BQ0 : gc2bin port map (gc  => data0b(adc_bit_width/2-1 downto 0), bin => user_data_i4);
    GC2BQ2 : gc2bin port map (gc  => data2b(adc_bit_width/2-1 downto 0), bin => user_data_i5);
    GC2BQ4 : gc2bin port map (gc  => data0b(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i6);
    GC2BQ6 : gc2bin port map (gc  => data2b(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_i7);
                                                    
    GC2BI1 : gc2bin port map (gc  => data1a(adc_bit_width/2-1 downto 0), bin => user_data_q0);
    GC2BI3 : gc2bin port map (gc  => data3a(adc_bit_width/2-1 downto 0), bin => user_data_q1);
    GC2BI5 : gc2bin port map (gc  => data1a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_q2);
    GC2BI7 : gc2bin port map (gc  => data3a(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_q3);

    GC2BQ1 : gc2bin port map (gc  => data1b(adc_bit_width/2-1 downto 0), bin => user_data_q4);
    GC2BQ3 : gc2bin port map (gc  => data3b(adc_bit_width/2-1 downto 0), bin => user_data_q5);
    GC2BQ5 : gc2bin port map (gc  => data1b(adc_bit_width-1 downto adc_bit_width/2), bin => user_data_q6);
    GC2BQ7 : gc2bin port map (gc  => data3b(adc_bit_width-1 downto adc_bit_width/2), Bin => user_data_q7);
  end generate chan2_mode;


-------------------------------------------------------
-- Component Instantiation
-------------------------------------------------------

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

  MMCM0: MMCM_ADV
    generic map (
      CLKFBOUT_MULT_F    => mmcm_m,
      DIVCLK_DIVIDE      => mmcm_d,
      CLKFBOUT_PHASE     => 0.0,
      CLKIN1_PERIOD      => clkin_period,
      CLKOUT1_DIVIDE     => mmcm_o1,
      CLKOUT2_DIVIDE     => mmcm_o1,
      CLKOUT3_DIVIDE     => mmcm_o1,
      CLKOUT4_DIVIDE     => mmcm_o1,
      CLKOUT1_DUTY_CYCLE => 0.50,
      CLKOUT2_DUTY_CYCLE => 0.50,
      CLKOUT3_DUTY_CYCLE => 0.50,
      CLKOUT4_DUTY_CYCLE => 0.50,
      CLKOUT1_PHASE      => 0.0,
      CLKOUT2_PHASE      => 90.0,
      CLKOUT3_PHASE      => 180.0,
      CLKOUT4_PHASE      => 270.0
      )
    port map (
      CLKFBIN   => mmcm_clkfbin,
      CLKFBOUT  => mmcm_clkfbout,
      CLKINSEL  => '1',
      CLKIN1    => adc_clk,
      CLKIN2    => '0',
      CLKOUT1   => mmcm_clkout0,
      CLKOUT2   => mmcm_clkout1,
      CLKOUT3   => mmcm_clkout2,
      CLKOUT4   => mmcm_clkout3,
      DADDR     => "0000000",
      DCLK      => '0',
      DEN       => '0',
      DI        => X"0000",
      DO        => open,
      DRDY      => open,
      DWE       => '0',
      LOCKED    => mmcm_locked,
      PSCLK     => dcm_psclk,
      PSDONE    => dcm_psdone,
      PSEN      => dcm_psen,
      PSINCDEC  => dcm_psincdec,
      PWRDWN    => '0',
      RST       => mmcm_rst
      );


  CBUF2a:  BUFG     port map (i=> mmcm_clkfbout, o=> mmcm_clkfbin);
  CBUF2b:  BUFG     port map (i=> mmcm_clkout0,  o=> iddr_clk);
  CBUF2c:  BUFG     port map (i=> mmcm_clkout1,  o=> ctrl_clk90_out);
  CBUF2d:  BUFG     port map (i=> mmcm_clkout2,  o=> ctrl_clk180_out);
  CBUF2e:  BUFG     port map (i=> mmcm_clkout3,  o=> ctrl_clk270_out);


  ctrl_clk_out    <= iddr_clk;
  ctrl_dcm_locked <= mmcm_locked;
  sync <= adc_sync;


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

    -----------------------------------------------------------------------------
    -- Capture the data using IDDR
    -----------------------------------------------------------------------------
    iddr0_rbuf: FD port map (C => ctrl_clk_in, D => iddr_rst, Q => iddr0_rst(i));
    iddr0: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data0a_pre(i),
        Q2 => data0b_pre(i),
        C  => iddr_clk,
        CE => '1',
        D  => data0(i),
        R  => iddr0_rst(i),
        S  => '0'
        );

    iddr1_rbuf: FD port map (C => ctrl_clk_in, D => iddr_rst, Q => iddr1_rst(i));
    iddr1: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data1a_pre(i),
        Q2 => data1b_pre(i),
        C  => iddr_clk,
        CE => '1',
        D  => data1(i),
        R  => iddr1_rst(i),
        S  => '0'
        );

    iddr2_rbuf: FD port map (C => ctrl_clk_in, D => iddr_rst, Q => iddr2_rst(i));
    iddr2: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data2a_pre(i),
        Q2 => data2b_pre(i),
        C  => iddr_clk,
        CE => '1',
        D  => data2(i),
        R  => iddr2_rst(i),
        S  => '0'
        );

    iddr3_rbuf: FD port map (C => ctrl_clk_in, D => iddr_rst, Q => iddr3_rst(i));
    iddr3: IDDR
      generic map (
        DDR_CLK_EDGE => "SAME_EDGE_PIPELINED",
        SRTYPE       => "SYNC"
        )
      port map (
        Q1 => data3a_pre(i),
        Q2 => data3b_pre(i),
        C  => iddr_clk,
        CE => '1',
        D  => data3(i),
        R  => iddr3_rst(i),
        S  => '0'
        ); 

  end generate iddrx;


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
  -- inputs : fifo_wr_clk, fifo_rst, fifo_afull
  -- outputs: fifo_rd_en, fifo_din_buf(n)
  FIFO_RD_CTRL: process (fifo_wr_clk, fifo_rst, fifo_afull)
  begin  -- process FIFO_RD_CTRL
    if fifo_wr_clk'event and fifo_wr_clk = '1' then  -- rising clock edge
      if fifo_rst = '1' then              -- synchronous reset (active high)
        fifo_rd_en <= '0';
        fifo_din <= (others => '0');
        fifo_din_buf0 <= (others => '0');
        fifo_din_buf1 <= (others => '0');
      else
        fifo_rd_en <= fifo_afull;
        fifo_din(143 downto adc_bit_width*16) <= (others => '0');
        fifo_din(adc_bit_width*8-1 downto 0) <=
          data0b_pre & data0a_pre &
          data1b_pre & data1a_pre &
          data2b_pre & data2a_pre &
          data3b_pre & data3a_pre;
        fifo_din_buf0 <= fifo_din;
        fifo_din_buf1 <= fifo_din_buf0;
      end if;
    end if;
  end process FIFO_RD_CTRL;

  fifo_wr_en <= '1';
  fifo_wr_clk <= iddr_clk;
  fifo_rd_clk <= ctrl_clk_in;
  data0b <= fifo_dout(adc_bit_width*8-1 downto adc_bit_width*7);
  data0a <= fifo_dout(adc_bit_width*7-1 downto adc_bit_width*6);
  data1b <= fifo_dout(adc_bit_width*6-1 downto adc_bit_width*5);
  data1a <= fifo_dout(adc_bit_width*5-1 downto adc_bit_width*4);
  data2b <= fifo_dout(adc_bit_width*4-1 downto adc_bit_width*3);
  data2a <= fifo_dout(adc_bit_width*3-1 downto adc_bit_width*2);
  data3b <= fifo_dout(adc_bit_width*2-1 downto adc_bit_width);
  data3a <= fifo_dout(adc_bit_width-1   downto 0);

  
end behavioral;    
