----------------------------------------------------------------------------
-- Import useful libraries
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- entity declaraction
entity  adc16_interface  is
    generic (
               G_ROACH2_REV : integer := 1;
               G_ZDOK_REV   : integer := 1;
               G_NUM_CLOCKS : integer := 4;
               G_NUM_UNITS  : integer := 4 -- Typically 4 or 8
    );
    port (
               -- System
               fabric_clk     :  out std_logic;
               fabric_clk_90  :  out std_logic;
               fabric_clk_180 :  out std_logic;
               fabric_clk_270 :  out std_logic;
               locked         :  out std_logic_vector(1 downto 0);
               reset          :  in  std_logic;

               -- ZDOK
               clk_line_p    :  in  std_logic_vector(  G_NUM_CLOCKS-1 downto 0);
               clk_line_n    :  in  std_logic_vector(  G_NUM_CLOCKS-1 downto 0);
               clk_frame_p   :  in  std_logic_vector(  G_NUM_CLOCKS-1 downto 0);
               clk_frame_n   :  in  std_logic_vector(  G_NUM_CLOCKS-1 downto 0);
               ser_a_p       :  in  std_logic_vector(4*G_NUM_UNITS-1 downto 0);
               ser_a_n       :  in  std_logic_vector(4*G_NUM_UNITS-1 downto 0);
               ser_b_p       :  in  std_logic_vector(4*G_NUM_UNITS-1 downto 0);
               ser_b_n       :  in  std_logic_vector(4*G_NUM_UNITS-1 downto 0);

               -- ISERDES Controller (always 8 bits even if G_NUM_UNITS=4)
               iserdes_bitslip  :  in  std_logic_vector(7 downto 0);

               -- Parallel outputs
               a1  :  out std_logic_vector(7 downto 0);
               a2  :  out std_logic_vector(7 downto 0);
               a3  :  out std_logic_vector(7 downto 0);
               a4  :  out std_logic_vector(7 downto 0);
               b1  :  out std_logic_vector(7 downto 0);
               b2  :  out std_logic_vector(7 downto 0);
               b3  :  out std_logic_vector(7 downto 0);
               b4  :  out std_logic_vector(7 downto 0);
               c1  :  out std_logic_vector(7 downto 0);
               c2  :  out std_logic_vector(7 downto 0);
               c3  :  out std_logic_vector(7 downto 0);
               c4  :  out std_logic_vector(7 downto 0);
               d1  :  out std_logic_vector(7 downto 0);
               d2  :  out std_logic_vector(7 downto 0);
               d3  :  out std_logic_vector(7 downto 0);
               d4  :  out std_logic_vector(7 downto 0);
               e1  :  out std_logic_vector(7 downto 0);
               e2  :  out std_logic_vector(7 downto 0);
               e3  :  out std_logic_vector(7 downto 0);
               e4  :  out std_logic_vector(7 downto 0);
               f1  :  out std_logic_vector(7 downto 0);
               f2  :  out std_logic_vector(7 downto 0);
               f3  :  out std_logic_vector(7 downto 0);
               f4  :  out std_logic_vector(7 downto 0);
               g1  :  out std_logic_vector(7 downto 0);
               g2  :  out std_logic_vector(7 downto 0);
               g3  :  out std_logic_vector(7 downto 0);
               g4  :  out std_logic_vector(7 downto 0);
               h1  :  out std_logic_vector(7 downto 0);
               h2  :  out std_logic_vector(7 downto 0);
               h3  :  out std_logic_vector(7 downto 0);
               h4  :  out std_logic_vector(7 downto 0);

               -- Delay Controller (always 64 bits, even if G_NUM_UNITS=4)
               delay_rst        :  in  std_logic_vector(63 downto 0);
               delay_tap        :  in  std_logic_vector(4 downto 0);

               -- Snap Controller
               snap_req         :  in  std_logic;
               snap_we          :  out std_logic;
               snap_addr        :  out std_logic_vector(9 downto 0);

               -- ROACH2 rev and number of ADC boards (for adc16_controller)
               roach2_rev       :  out std_logic_vector(1 downto 0);
               zdok_rev         :  out std_logic_vector(1 downto 0);
               num_units        :  out std_logic_vector(3 downto 0)
    );

end  adc16_interface;

architecture adc16_interface_arc of adc16_interface is

     -- Components

     component adc_unit port (
               -- System
               fabric_clk    :  in std_logic;
               line_clk      :  in std_logic;
               frame_clk     :  in std_logic;
               reset         :  in  std_logic;

               -- ZDOK
               ser_a_p       :  in  std_logic_vector(3 downto 0);
               ser_a_n       :  in  std_logic_vector(3 downto 0);
               ser_b_p       :  in  std_logic_vector(3 downto 0);
               ser_b_n       :  in  std_logic_vector(3 downto 0);

               -- ISERDES Controller
               iserdes_bitslip  :  in  std_logic;
               p_data           :  out std_logic_vector(31 downto 0);
               absel            :  in std_logic;

               -- Delay Controller
               delay_rst_a      :  in  std_logic_vector(3 downto 0);
               delay_rst_b      :  in  std_logic_vector(3 downto 0);
               delay_tap        :  in  std_logic_vector(4 downto 0)
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
               clkout2_90   :  out std_logic;
               clkout2_180  :  out std_logic;
               clkout2_270  :  out std_logic
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

     component BUFG  port  (
               O            : out std_logic;
               I            : in  std_logic
     );
     end component;

     -- Attribute declarations

     attribute keep : string;
     attribute s    : string;

     -- Signals

     type  i4_v1  is array (0 to G_NUM_UNITS-1) of std_logic;
     type  i4_v4  is array (0 to G_NUM_UNITS-1) of std_logic_vector(3 downto 0);
     type  i4_v20 is array (0 to G_NUM_UNITS-1) of std_logic_vector(19 downto 0);
     type  i4_v32 is array (0 to G_NUM_UNITS-1) of std_logic_vector(31 downto 0);

     -- Clocking (keep and s attributes retain unused clocks)
     signal line_clk_in_zdok0 : std_logic;
     signal line_clk_in_zdok1 : std_logic;
     signal line_clk_in       : std_logic_vector(G_NUM_CLOCKS-1 downto 0);
     attribute keep of line_clk_in : signal is "true";
     attribute s    of line_clk_in : signal is "yes";

     -- frame_clk_in signals are not used (they exist for termination only)
     signal frame_clk_in : std_logic_vector(G_NUM_CLOCKS-1 downto 0);
     attribute keep of frame_clk_in : signal is "true";
     attribute s    of frame_clk_in : signal is "yes";

     signal line_clk     : std_logic;
     signal frame_clk    : std_logic;
     signal fabric_clk_0 : std_logic;
     signal absel        : std_logic;
     signal absel_enable : std_logic;
     signal locked_0     : std_logic;

     -- MMCM BUFGs
     signal bufg_i : std_logic_vector(5 downto 0);
     signal bufg_o : std_logic_vector(5 downto 0);

     -- ZDOK
     signal s_ser_a_p : i4_v4;
     signal s_ser_a_n : i4_v4;
     signal s_ser_b_p : i4_v4;
     signal s_ser_b_n : i4_v4;

     -- ISERDES Controller
     signal s_iserdes_bitslip : i4_v1;
     signal s_p_data : i4_v32;
     signal s_p_data0 : i4_v32;

     -- Delay Controller
     signal s_delay_rst_a  : i4_v4;
     signal s_delay_rst_b  : i4_v4;
     signal delay_rst0     : std_logic_vector(63 downto 0);
     signal delay_rst1     : std_logic_vector(63 downto 0);
     signal delay_rst2     : std_logic_vector(63 downto 0);
     signal delay_rst_edge : std_logic_vector(63 downto 0);

     -- Snap Controller
     signal s_snap_req : std_logic_vector(1 downto 0);
     signal s_snap_counter: std_logic_vector(10 downto 0);

     begin

     -- Select line clocks for zdok0 and zdok1
     line_clk_zdok0_1: if G_ZDOK_REV = 1 generate
       line_clk_in_zdok0 <= line_clk_in(3);
     end generate;

     line_clk_zdok0_2: if G_ZDOK_REV = 2 generate
       line_clk_in_zdok0 <= line_clk_in(0);
     end generate;

     line_clk_zdok1_1: if G_ZDOK_REV = 1  and G_NUM_CLOCKS = 8 generate
       line_clk_in_zdok1 <= line_clk_in(7);
     end generate;

     line_clk_zdok1_2: if G_ZDOK_REV = 2  and G_NUM_CLOCKS = 2 generate
       line_clk_in_zdok1 <= line_clk_in(1);
     end generate;

     -- Clocking
     locked(0) <= locked_0;

     adc_mmcm_0 : ADC_MMCM
     PORT MAP (
       reset        => reset,
       locked       => locked_0,
       clkin        => line_clk_in_zdok0,
       clkout0p     => bufg_i(0),
       clkout0n     => open,
       clkout1p     => bufg_i(1),
       clkout1n     => open,
       clkout2      => bufg_i(2),
       clkout2_90   => bufg_i(3),
       clkout2_180  => bufg_i(4),
       clkout2_270  => bufg_i(5)
     );

     -- MMCM BUFGs
     bufg_gen: for i in 0 to 5 generate
       inst : BUFG
       PORT MAP (
         O => bufg_o(i),
         I => bufg_i(i)
       );
     end generate;

     -- IBUFDS for clocks
     ibufds_clk: for i in 0 to G_NUM_CLOCKS-1 generate
       -- ADC line clocks
       line_clk_inst : IBUFDS
       generic map (
         DIFF_TERM  => TRUE,
         IOSTANDARD => "LVDS_25")
       port map (
         I   => clk_line_p(i),
         IB  => clk_line_n(i),
         O   => line_clk_in(i)
       );
       zdok_rev1_frame_clk: if G_ZDOK_REV = 1 generate
         -- ADC frame clocks
         frame_clk_inst : IBUFDS
         generic map (
           DIFF_TERM  => TRUE,
           IOSTANDARD => "LVDS_25")
         port map (
           I   => clk_frame_p(i),
           IB  => clk_frame_n(i),
           O   => frame_clk_in(i)
         );
       end generate;
     end generate;

     -- Internal routing
     line_clk       <= bufg_o(0);
     frame_clk      <= bufg_o(1);
     fabric_clk_0   <= bufg_o(2);
     fabric_clk     <= fabric_clk_0;
     fabric_clk_90  <= bufg_o(3);
     fabric_clk_180 <= bufg_o(4);
     fabric_clk_270 <= bufg_o(5);

     roach2_rev <= std_logic_vector(to_unsigned(G_ROACH2_REV, roach2_rev'length));
     zdok_rev   <= std_logic_vector(to_unsigned(G_ZDOK_REV,   zdok_rev'length));
     num_units  <= std_logic_vector(to_unsigned(G_NUM_UNITS,  num_units'length));

     -- Parallel data outputs
     a1 <= s_p_data(0)(31 downto 24);
     a2 <= s_p_data(0)(23 downto 16);
     a3 <= s_p_data(0)(15 downto  8);
     a4 <= s_p_data(0)( 7 downto  0);
     b1 <= s_p_data(1)(31 downto 24);
     b2 <= s_p_data(1)(23 downto 16);
     b3 <= s_p_data(1)(15 downto  8);
     b4 <= s_p_data(1)( 7 downto  0);
     c1 <= s_p_data(2)(31 downto 24);
     c2 <= s_p_data(2)(23 downto 16);
     c3 <= s_p_data(2)(15 downto  8);
     c4 <= s_p_data(2)( 7 downto  0);
     d1 <= s_p_data(3)(31 downto 24);
     d2 <= s_p_data(3)(23 downto 16);
     d3 <= s_p_data(3)(15 downto  8);
     d4 <= s_p_data(3)( 7 downto  0);

     adc1_board: if G_NUM_UNITS = 8 generate
       e1 <= s_p_data(4)(31 downto 24);
       e2 <= s_p_data(4)(23 downto 16);
       e3 <= s_p_data(4)(15 downto  8);
       e4 <= s_p_data(4)( 7 downto  0);
       f1 <= s_p_data(5)(31 downto 24);
       f2 <= s_p_data(5)(23 downto 16);
       f3 <= s_p_data(5)(15 downto  8);
       f4 <= s_p_data(5)( 7 downto  0);
       g1 <= s_p_data(6)(31 downto 24);
       g2 <= s_p_data(6)(23 downto 16);
       g3 <= s_p_data(6)(15 downto  8);
       g4 <= s_p_data(6)( 7 downto  0);
       h1 <= s_p_data(7)(31 downto 24);
       h2 <= s_p_data(7)(23 downto 16);
       h3 <= s_p_data(7)(15 downto  8);
       h4 <= s_p_data(7)( 7 downto  0);

       adc_mmcm_1 : ADC_MMCM
       PORT MAP (
         reset        => reset,
         locked       => locked(1),
         clkin        => line_clk_in_zdok1,
         clkout0p     => open,
         clkout0n     => open,
         clkout1p     => open,
         clkout1n     => open,
         clkout2      => open,
         clkout2_90   => open,
         clkout2_180  => open,
         clkout2_270  => open
       );

     end generate;

     adc1_dummy: if G_NUM_UNITS /= 8 generate
       e1 <= "00000000";
       e2 <= "00000000";
       e3 <= "00000000";
       e4 <= "00000000";
       f1 <= "00000000";
       f2 <= "00000000";
       f3 <= "00000000";
       f4 <= "00000000";
       g1 <= "00000000";
       g2 <= "00000000";
       g3 <= "00000000";
       g4 <= "00000000";
       h1 <= "00000000";
       h2 <= "00000000";
       h3 <= "00000000";
       h4 <= "00000000";
       locked(1) <= '0';
     end generate;

     -- Generate adc_unit modules and associated wiring
     ADC: for i in 0 to G_NUM_UNITS-1 generate

       -- ZDOK
       s_ser_a_p(i) <= ser_a_p(4*i+3 downto 4*i);
       s_ser_a_n(i) <= ser_a_n(4*i+3 downto 4*i);
       s_ser_b_p(i) <= ser_b_p(4*i+3 downto 4*i);
       s_ser_b_n(i) <= ser_b_n(4*i+3 downto 4*i);

       -- ISERDES Controller
       s_iserdes_bitslip(i) <= iserdes_bitslip(i);

       -- Delay Controller (lower half is for "a"; upper half is for "b")
       s_delay_rst_a(i) <= delay_rst_edge(4*i+3    downto 4*i);
       s_delay_rst_b(i) <= delay_rst_edge(4*i+3+32 downto 4*i+32);

       adc_unit_inst: adc_unit
       port map (
                   fabric_clk => fabric_clk_0,
                   line_clk   => line_clk,
                   frame_clk  => frame_clk,
                   reset      => reset,

                   ser_a_p => s_ser_a_p(i),
                   ser_a_n => s_ser_a_n(i),
                   ser_b_p => s_ser_b_p(i),
                   ser_b_n => s_ser_b_n(i),

                   iserdes_bitslip => s_iserdes_bitslip(i),
                   p_data => s_p_data0(i),
                   absel => absel,

                   delay_rst_a => s_delay_rst_a(i),
                   delay_rst_b => s_delay_rst_b(i),
                   delay_tap => delay_tap
       );
     end generate; -- for i in...

    process(frame_clk)
    begin
      if rising_edge(frame_clk) then
        -- snap_req shift register - Capture snap_req on rising edge
        -- of frame clock so that A/B will be even/odd consistent.
        s_snap_req <= s_snap_req(0) & snap_req;
      end if;
    end process;

    process(frame_clk, locked_0)
    begin
      -- If MMCM is unlocked, reset absel_enable
      if rising_edge(frame_clk) then
        -- Rising edge of frame_clk enables absel toggling if MMCM locked
        -- to ensure that absel has known phase relation to frame_clk.
        absel_enable <= locked_0;
      end if;
    end process;

    process(fabric_clk_0, absel_enable, locked_0)
    begin
      -- rising edge of fabric_clk_0
      if rising_edge(fabric_clk_0) then
        -- Toggle a/b lane selector
        absel <= (not absel) and absel_enable;
      end if;
    end process;

    process(fabric_clk_0)
    begin
      -- rising edge of fabric_clk_0
      if rising_edge(fabric_clk_0) then
        -- s_p_data pipeline
        s_p_data <= s_p_data0;

        -- delay_rst shift register
        delay_rst2 <= delay_rst1;
        delay_rst1 <= delay_rst0;
        delay_rst0 <= delay_rst;

        -- delay_rst rising edge detector (output must be two cycles wide to
        -- guaranty that it is high when frame clock is high).
        delay_rst_edge <= (not delay_rst2) and (delay_rst1 or delay_rst0);

        -- '0' to '1' transition on snap_req
        if s_snap_req(1) = '0' and s_snap_req(0) = '1' then
          -- Reset snap counter
          s_snap_counter <= (others => '0');
        elsif s_snap_counter(10) = '0'  then
          -- Count until MSb is '1'
          s_snap_counter <= s_snap_counter + 1;
        end if;
      end if;
    end process;

    snap_we <= not s_snap_counter(10);
    snap_addr <= s_snap_counter(9 downto 0);

end adc16_interface_arc;
