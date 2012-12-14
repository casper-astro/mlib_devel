----------------------------------------------------------------------------
-- Import useful libraries
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- entity declaraction
entity  adc_unit  is
    generic ( mode : string := "MASTER" );
    port (
               -- System
               line_clk      :  out std_logic;
               div_clk       :  out std_logic;
               fabric_clk    :  out std_logic;
               i_line_clk    :  in  std_logic;
               i_div_clk     :  in  std_logic;
               i_fabric_clk  :  in  std_logic;
               ctrl_clk      :  in  std_logic;
               data_clk      :  in  std_logic;
               reset         :  in  std_logic;

               -- ZDOK
               clk_line_p    :  in  std_logic;
               clk_line_n    :  in  std_logic;
               ser_a_p       :  in  std_logic_vector(3 downto 0);
               ser_a_n       :  in  std_logic_vector(3 downto 0);
               ser_b_p       :  in  std_logic_vector(3 downto 0);
               ser_b_n       :  in  std_logic_vector(3 downto 0);


               -- ISERDES Controller
               iserdes_bitslip  :  in  std_logic;
               load_phase_set   :  in  std_logic;
               p_data           :  out std_logic_vector(31 downto 0);

               -- MMCM Controller
               delay_clk        :  in  std_logic; -- 200MHz
               delay_rst        :  in  std_logic_vector(3 downto 0);
               delay_tap        :  in  std_logic_vector(19 downto 0)
    );

end  adc_unit;

architecture adc_unit_arc of adc_unit is

     -- Components
      component IODELAYE1 generic(
         CINVCTRL_SEL           :  boolean;         -- TRUE, FALSE
         DELAY_SRC              :  string;          -- I, IO, O, CLKIN, DATAIN
         HIGH_PERFORMANCE_MODE  :  boolean;         -- TRUE, FALSE
         IDELAY_TYPE            :  string;          -- FIXED, DEFAULT, VARIABLE, or VAR_LOADABLE
         IDELAY_VALUE           :  integer;         -- 0 to 31
         ODELAY_TYPE            :  string;          -- Has to be set to FIXED when IODELAYE1 is configured for Input
         ODELAY_VALUE           :  integer;         -- Set to 0 as IODELAYE1 is configured for Input
         REFCLK_FREQUENCY       :  real;
         SIGNAL_PATTERN         :  string           -- CLOCK, DATA
         );
       port (
         DATAOUT                : out std_logic;
         DATAIN                 : in  std_logic;
         C                      : in  std_logic;
         CE                     : in  std_logic;
         INC                    : in  std_logic;
         IDATAIN                : in  std_logic;
         ODATAIN                : in  std_logic;
         RST                    : in  std_logic;
         T                      : in  std_logic;
         CNTVALUEIN             : in  std_logic_vector(4 downto 0);
         CNTVALUEOUT            : out std_logic_vector(4 downto 0);
         CLKIN                  : in  std_logic;
         CINVCTRL               : in  std_logic
         );
      end component;

     component ADC_ISERDES   port (
               -- System
               reset        :  in  std_logic;
               bitslip      :  in  std_logic;

               -- Clock inputs
               clkin        :  in  std_logic; -- line
               clkdiv       :  in  std_logic; -- frame/system

               -- Data (serial in, parallel out)
               s_data       :  in  std_logic;
               p_data       :  out std_logic_vector(7 downto 0)
      );
     end component;

     component MMCM_PCNTRL   port (
               sysclk       :  in  std_logic;
               reset        :  in  std_logic;
               mode         :  in  std_logic;
               shift        :  in  std_logic;
               shift_val    :  in  std_logic_vector(7 downto 0);-- max 56
               ready        :  out std_logic;
               o_psdone     :  out std_logic;

               -- DCM inputs/outputs
               MMCM_PSCLK    :  out std_logic;
               MMCM_PSEN     :  out std_logic;
               MMCM_PSINCDEC :  out std_logic;
               MMCM_PSDONE   :  in  std_logic;
               MMCM_LOCKED   :  in  std_logic
      );
     end component;

     component ADC_MMCM   port (
               -- System
               reset        :  in  std_logic;
               locked       :  out std_logic;

               -- Clock inputs
               clkin        :  in  std_logic;

               -- Clock outputs
               clkout0p     :  out std_logic;
               clkout0n     :  out std_logic;
               clkout1p     :  out std_logic;
               clkout1n     :  out std_logic;
               clkout2      :  out std_logic;

               -- Phase shift
               psincdec     :  in  std_logic;
               psen         :  in  std_logic;
               psclk        :  in  std_logic;
               psdone       :  out std_logic
      );
     end component;

     component BUFR  port  (
               CE           : in  std_logic;
               CLR          : in  std_logic;
               O            : out std_logic;
               I            : in  std_logic
      );
     end component;

     component BUFG  port  (
               O            : out std_logic;
               I            : in  std_logic
      );
     end component;

     component IBUFDS  generic (
               DIFF_TERM    : boolean;
               IOSTANDARD   : string
     );
     port (
               I            : in  std_logic;
               IB           : in  std_logic;
               O            : out std_logic
     );
     end component;

     -- Signals
     signal sysclk : std_logic;

     signal adc_iserdes_a_reset : std_logic;
     signal adc_iserdes_a_bitslip : std_logic;
     signal adc_iserdes_a_clkin : std_logic;
     signal adc_iserdes_a_clkdiv : std_logic;
     signal adc_iserdes_a_s_data : std_logic_vector(3 downto 0);
     signal adc_iserdes_a_p_data : std_logic_vector(15 downto 0);

     signal adc_iserdes_b_reset : std_logic;
     signal adc_iserdes_b_bitslip : std_logic;
     signal adc_iserdes_b_clkin : std_logic;
     signal adc_iserdes_b_clkdiv : std_logic;
     signal adc_iserdes_b_s_data : std_logic_vector(3 downto 0);
     signal adc_iserdes_b_p_data : std_logic_vector(15 downto 0);

     signal adc_iserdes_data0 : std_logic_vector(31 downto 0);
     signal adc_iserdes_data1 : std_logic_vector(31 downto 0);
     signal adc_iserdes_data1_delay : std_logic_vector(31 downto 0);
     signal adc_iserdes_data : std_logic_vector(31 downto 0);
     signal adc_iserdes_sel : std_logic;

     signal mmcm_pcntrl_sysclk : std_logic;
     signal mmcm_pcntrl_reset : std_logic;
     signal mmcm_pcntrl_mode : std_logic;
     signal mmcm_pcntrl_shift : std_logic;
     signal mmcm_pcntrl_shift_val : std_logic_vector(7 downto 0);
     signal mmcm_pcntrl_ready : std_logic;
     signal mmcm_pcntrl_o_psdone : std_logic;
     signal mmcm_pcntrl_psclk : std_logic;
     signal mmcm_pcntrl_psen : std_logic;
     signal mmcm_pcntrl_psincdec : std_logic;
     signal mmcm_pcntrl_psdone : std_logic;
     signal mmcm_pcntrl_locked : std_logic;

     signal adc_mmcm_reset : std_logic;
     signal adc_mmcm_locked : std_logic;
     signal adc_mmcm_clkin : std_logic;
     signal adc_mmcm_clkout0p : std_logic;
     signal adc_mmcm_clkout0n : std_logic;
     signal adc_mmcm_clkout1p : std_logic;
     signal adc_mmcm_clkout1n : std_logic;
     signal adc_mmcm_clkout2  : std_logic;
     signal adc_mmcm_psincdec : std_logic;
     signal adc_mmcm_psen : std_logic;
     signal adc_mmcm_psclk : std_logic;
     signal adc_mmcm_psdone : std_logic;

     signal bufg_i : std_logic_vector(2 downto 0);
     signal bufg_o : std_logic_vector(2 downto 0);
     signal ibufds_clk_i : std_logic;
     signal ibufds_clk_ib : std_logic;
     signal ibufds_clk_o : std_logic;
     signal ibufds_ser1_i : std_logic_vector(3 downto 0);
     signal ibufds_ser1_ib : std_logic_vector(3 downto 0);
     signal ibufds_ser1_o : std_logic_vector(3 downto 0);
     signal ibufds_ser2_i : std_logic_vector(3 downto 0);
     signal ibufds_ser2_ib : std_logic_vector(3 downto 0);
     signal ibufds_ser2_o : std_logic_vector(3 downto 0);

     signal load_phase : std_logic;

     -- delay signals
     type  delayTAPtype  is array (0 to 3) of std_logic_vector(4 downto 0);

    -- now define the RAM itself (initialized to X)

     signal delay_a_out     : std_logic_vector(3 downto 0);
     signal delay_a_in      : std_logic_vector(3 downto 0);
     signal delay_b_out     : std_logic_vector(3 downto 0);
     signal delay_b_in      : std_logic_vector(3 downto 0);
     signal delay_clock     : std_logic;
     signal delay_reset   : std_logic_vector(3 downto 0);
     signal delay_intap   : delayTAPtype;
     signal delay_outtap  : delayTAPtype;

     begin

     -- Internal routing

     line_clk <= bufg_o(0);
     div_clk <= bufg_o(1);
     fabric_clk <= bufg_o(2);

     -- Differential signals

     ibufds_clk_i <= clk_line_p;
     ibufds_clk_ib <= clk_line_n;
     ibufds_ser1_i <= ser_a_p;
     ibufds_ser1_ib <= ser_a_n;
     ibufds_ser2_i <= ser_b_p;
     ibufds_ser2_ib <= ser_b_n;

     -- Everything else

     adc_iserdes_a_reset <= reset;
     adc_iserdes_b_reset <= reset;
     adc_iserdes_a_bitslip <= iserdes_bitslip;
     adc_iserdes_b_bitslip <= iserdes_bitslip;
     bufg_i(0) <= adc_mmcm_clkout0p;
     bufg_i(1) <= adc_mmcm_clkout1p;
     bufg_i(2) <= adc_mmcm_clkout2;
     adc_iserdes_a_clkin <= i_line_clk;
     adc_iserdes_b_clkin <= i_line_clk;
     adc_iserdes_a_clkdiv <= i_div_clk;
     adc_iserdes_b_clkdiv <= i_div_clk;
     --adc_iserdes_a_s_data <= ibufds_ser1_o;
     --adc_iserdes_b_s_data <= ibufds_ser2_o;

     mmcm_pcntrl_sysclk <= ctrl_clk;
     mmcm_pcntrl_reset <= reset;
     mmcm_pcntrl_mode <= '0';
     mmcm_pcntrl_shift <= '0';
     mmcm_pcntrl_shift_val <= "00000000";
     mmcm_pcntrl_psdone <= adc_mmcm_psdone;
     mmcm_pcntrl_locked <= adc_mmcm_locked;
     --mmcm_ready <= mmcm_pcntrl_ready;
     --mmcm_psdone <= mmcm_pcntrl_o_psdone;

     adc_mmcm_reset <= reset;

     --clock_m_gen : if mode = "MASTER" generate
     adc_mmcm_clkin <= ibufds_clk_o;
     --end generate clock_m_gen;

     adc_mmcm_psincdec <= mmcm_pcntrl_psincdec;
     adc_mmcm_psen <= mmcm_pcntrl_psen;
     adc_mmcm_psclk <= mmcm_pcntrl_psclk;

     -- delay
     adc_iserdes_a_s_data <= delay_a_out;
     delay_a_in <= ibufds_ser1_o;

     adc_iserdes_b_s_data <= delay_b_out;
     delay_b_in <= ibufds_ser2_o;

     delay_clock <= delay_clk;
     delay_reset <= delay_rst;
     delay_intap(0) <= delay_tap(4 downto 0);
     delay_intap(1) <= delay_tap(9 downto 5);
     delay_intap(2) <= delay_tap(14 downto 10);
     delay_intap(3) <= delay_tap(19 downto 15);

     process (i_fabric_clk, adc_iserdes_sel, adc_iserdes_data0, adc_iserdes_data1)
     begin
       -- Mux data based on adc_iserdes_sel state
       if adc_iserdes_sel = '1' then
         adc_iserdes_data <= adc_iserdes_data0;
       else
         adc_iserdes_data <= adc_iserdes_data1;
       end if;

       -- rising edge of fabric clock
       if i_fabric_clk'event and i_fabric_clk = '1' then
         p_data <= adc_iserdes_data;
         adc_iserdes_sel <= not adc_iserdes_sel;
       end if;
     end process;

     -- ISERDES block
     ISERDES_GEN : for i in 0 to 3 generate
     begin
     adc_iserdes_a_inst : ADC_ISERDES
     PORT MAP (
               reset      => adc_iserdes_a_reset,
               bitslip    => adc_iserdes_a_bitslip,
               clkin      => adc_iserdes_a_clkin,
               clkdiv     => adc_iserdes_a_clkdiv,
               s_data     => adc_iserdes_a_s_data(i),
               p_data     => adc_iserdes_data0(8*i+7 downto 8*i)
      );
     adc_iserdes_b_inst : ADC_ISERDES
     PORT MAP (
               reset      => adc_iserdes_b_reset,
               bitslip    => adc_iserdes_b_bitslip,
               clkin      => adc_iserdes_b_clkin,
               clkdiv     => adc_iserdes_b_clkdiv,
               s_data     => adc_iserdes_b_s_data(i),
               p_data     => adc_iserdes_data1(8*i+7 downto 8*i)
      );
    ibufds_ser1_inst : IBUFDS
    generic map (
               DIFF_TERM  => TRUE,
               IOSTANDARD => "LVDS_25")
    port map (
               I   => ibufds_ser1_i(i),
               IB  => ibufds_ser1_ib(i),
               O   => ibufds_ser1_o(i)
     );

    ibufds_ser2_inst : IBUFDS
    generic map (
               DIFF_TERM  => TRUE,
               IOSTANDARD => "LVDS_25")
    port map (
               I   => ibufds_ser2_i(i),
               IB  => ibufds_ser2_ib(i),
               O   => ibufds_ser2_o(i)
     );



     iodelay1_a : IODELAYE1
       generic map (
         CINVCTRL_SEL           => FALSE,            -- TRUE, FALSE
         DELAY_SRC              => "I",              -- I, IO, O, CLKIN, DATAIN
         HIGH_PERFORMANCE_MODE  => TRUE,             -- TRUE, FALSE
         IDELAY_TYPE            => "VAR_LOADABLE",   -- FIXED, DEFAULT, VARIABLE, or VAR_LOADABLE
         IDELAY_VALUE           => 0,                -- 0 to 31
         ODELAY_TYPE            => "FIXED",          -- Has to be set to FIXED when IODELAYE1 is configured for Input
         ODELAY_VALUE           => 0,                -- Set to 0 as IODELAYE1 is configured for Input
         REFCLK_FREQUENCY       => 200.0,
         SIGNAL_PATTERN         => "DATA"           -- CLOCK, DATA
         )
       port map (
         DATAOUT                => delay_a_out(i),
         DATAIN                 => '0', -- Data from FPGA logic
         C                      => delay_clock,
         CE                     => '0', --DELAY_DATA_CE,
         INC                    => '0', --DELAY_DATA_INC,
         IDATAIN                => delay_a_in(i), -- Driven by IOB
         ODATAIN                => '0',
         RST                    => delay_reset(i),
         T                      => '1',
         CNTVALUEIN             => delay_intap(i), --DELAY_TAP_IN,
         CNTVALUEOUT            => delay_outtap(i), --DELAY_TAP_OUT,
         CLKIN                  => '0',
         CINVCTRL               => '0'
         );

     iodelay1_b : IODELAYE1
       generic map (
         CINVCTRL_SEL           => FALSE,            -- TRUE, FALSE
         DELAY_SRC              => "I",              -- I, IO, O, CLKIN, DATAIN
         HIGH_PERFORMANCE_MODE  => TRUE,             -- TRUE, FALSE
         IDELAY_TYPE            => "VAR_LOADABLE",   -- FIXED, DEFAULT, VARIABLE, or VAR_LOADABLE
         IDELAY_VALUE           => 0,                -- 0 to 31
         ODELAY_TYPE            => "FIXED",          -- Has to be set to FIXED when IODELAYE1 is configured for Input
         ODELAY_VALUE           => 0,                -- Set to 0 as IODELAYE1 is configured for Input
         REFCLK_FREQUENCY       => 200.0,
         SIGNAL_PATTERN         => "DATA"           -- CLOCK, DATA
         )
       port map (
         DATAOUT                => delay_b_out(i),
         DATAIN                 => '0', -- Data from FPGA logic
         C                      => delay_clock,
         CE                     => '0', --DELAY_DATA_CE,
         INC                    => '0', --DELAY_DATA_INC,
         IDATAIN                => delay_b_in(i), -- Driven by IOB
         ODATAIN                => '0',
         RST                    => delay_reset(i),
         T                      => '1',
         CNTVALUEIN             => delay_intap(i), --DELAY_TAP_IN,
         CNTVALUEOUT            => delay_outtap(i), --DELAY_TAP_OUT,
         CLKIN                  => '0',
         CINVCTRL               => '0'
         );

     end generate ISERDES_GEN;


     master_gen : if mode = "MASTER" generate
     -- MMCM_CNTRL block
     mmcm_pcntrl_inst : MMCM_PCNTRL
     PORT MAP (
               sysclk         => mmcm_pcntrl_sysclk,
               reset          => mmcm_pcntrl_reset,
               mode           => mmcm_pcntrl_mode,
               shift          => mmcm_pcntrl_shift,
               shift_val      => mmcm_pcntrl_shift_val,
               ready          => mmcm_pcntrl_ready,
               o_psdone       => mmcm_pcntrl_o_psdone,
               MMCM_PSCLK     => mmcm_pcntrl_psclk,
               MMCM_PSEN      => mmcm_pcntrl_psen,
               MMCM_PSINCDEC  => mmcm_pcntrl_psincdec,
               MMCM_PSDONE    => mmcm_pcntrl_psdone,
               MMCM_LOCKED    => mmcm_pcntrl_locked
      );

     -- MMCM block
     adc_mmcm_inst : ADC_MMCM
     PORT MAP (
     -- System
               reset        => adc_mmcm_reset,
               locked       => adc_mmcm_locked,
               clkin        => adc_mmcm_clkin,
               clkout0p     => adc_mmcm_clkout0p,
               clkout0n     => adc_mmcm_clkout0n,
               clkout1p     => adc_mmcm_clkout1p,
               clkout1n     => adc_mmcm_clkout1n,
               clkout2      => adc_mmcm_clkout2,
               psincdec     => adc_mmcm_psincdec,
               psen         => adc_mmcm_psen,
               psclk        => adc_mmcm_psclk,
               psdone       => adc_mmcm_psdone
      );

    -- BUFG
    bufg1_inst : BUFG
    PORT MAP (
               O => bufg_o(0),
               I => bufg_i(0)
      );

    bufg2_inst : BUFG
    PORT MAP (
               O => bufg_o(1),
               I => bufg_i(1)
      );

    bufg3_inst : BUFG
    PORT MAP (
               O => bufg_o(2),
               I => bufg_i(2)
      );

    ibufds_clk_inst : IBUFDS
    generic map (
               DIFF_TERM  => TRUE,
               IOSTANDARD => "LVDS_25")
    port map (
               I   => ibufds_clk_i,
               IB  => ibufds_clk_ib,
               O   => ibufds_clk_o
     );

    end generate master_gen;

end adc_unit_arc;

