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
               clk_line_p    :  in  std_logic_vector(  G_NUM_UNITS-1 downto 0);
               clk_line_n    :  in  std_logic_vector(  G_NUM_UNITS-1 downto 0);
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

               -- Delay Controller (always 32 bits, even if G_NUM_UNITS=4)
               delay_rst        :  in  std_logic_vector(31 downto 0);
               delay_tap        :  in  std_logic_vector(4 downto 0);

               -- Snap Controller
               snap_req         :  in  std_logic;
               snap_we          :  out std_logic;
               snap_addr        :  out std_logic_vector(9 downto 0);

               -- ROACH2 rev and number of ADC boards (for adc16_controller)
               roach2_rev       :  out std_logic_vector(1 downto 0);
               num_units        :  out std_logic_vector(3 downto 0)
    );

end  adc16_interface;

architecture adc16_interface_arc of adc16_interface is

     -- Components
     component adc_unit generic (
               mode          :  string
               );
     port (
               -- System
               line_clk      :  out std_logic;
               frame_clk     :  out std_logic;
               fabric_clk    :  out std_logic;
               fabric_clk_90  :  out std_logic;
               fabric_clk_180 :  out std_logic;
               fabric_clk_270 :  out std_logic;
               locked        :  out std_logic;
               i_line_clk    :  in  std_logic;
               i_frame_clk   :  in  std_logic;
               i_fabric_clk  :  in  std_logic;
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
               p_data           :  out std_logic_vector(31 downto 0);

               -- Delay Controller
               delay_rst        :  in  std_logic_vector(3 downto 0);
               delay_tap        :  in  std_logic_vector(4 downto 0)
    );
    end component;

     -- Signals
     type  i4_v1  is array (0 to G_NUM_UNITS-1) of std_logic;
     type  i4_v4  is array (0 to G_NUM_UNITS-1) of std_logic_vector(3 downto 0);
     type  i4_v20 is array (0 to G_NUM_UNITS-1) of std_logic_vector(19 downto 0);
     type  i4_v32 is array (0 to G_NUM_UNITS-1) of std_logic_vector(31 downto 0);

     signal s_line_clk : i4_v1;
     signal s_frame_clk : i4_v1;
     signal s_fabric_clk : i4_v1;
     signal s_fabric_clk_90 : i4_v1;
     signal s_fabric_clk_180 : i4_v1;
     signal s_fabric_clk_270 : i4_v1;
     signal s_locked : i4_v1;
     signal s_i_line_clk : i4_v1;
     signal s_i_frame_clk : i4_v1;
     signal s_i_fabric_clk : i4_v1;
     signal s_reset : i4_v1;

     -- ZDOK
     signal s_clk_line_p : i4_v1;
     signal s_clk_line_n : i4_v1;
     signal s_ser_a_p : i4_v4;
     signal s_ser_a_n : i4_v4;
     signal s_ser_b_p : i4_v4;
     signal s_ser_b_n : i4_v4;

     -- ISERDES Controller
     signal s_iserdes_bitslip : i4_v1;
     signal s_p_data : i4_v32;
     signal s_p_data0 : i4_v32;

     -- Delay Controller
     signal s_delay_rst : i4_v4;
     signal delay_rst0     : std_logic_vector(31 downto 0);
     signal delay_rst1     : std_logic_vector(31 downto 0);
     signal delay_rst2     : std_logic_vector(31 downto 0);
     signal delay_rst_edge : std_logic_vector(31 downto 0);

     -- Snap Controller
     signal s_snap_req : std_logic_vector(1 downto 0);
     signal s_snap_counter: std_logic_vector(10 downto 0);

     -- Set which ADC is the MASTER
     constant master : integer := 2;

     begin

     -- Internal routing
     fabric_clk <= s_fabric_clk(master);
     fabric_clk_90 <= s_fabric_clk_90(master);
     fabric_clk_180 <= s_fabric_clk_180(master);
     fabric_clk_270 <= s_fabric_clk_270(master);
     roach2_rev <= std_logic_vector(to_unsigned(G_ROACH2_REV, roach2_rev'length));
     num_units  <= std_logic_vector(to_unsigned(G_NUM_UNITS,  num_units'length));

     -- Parallel data outputs (and locked(0))
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
     locked(0) <= s_locked(master);

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
       locked(1) <= s_locked(master+4);
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

       -- Clocks and reset
       s_i_line_clk(i) <= s_line_clk(master);
       s_i_frame_clk(i) <= s_frame_clk(master);
       s_i_fabric_clk(i) <= s_fabric_clk(master);
       s_reset(i) <= reset;

       -- ZDOK
       s_clk_line_p(i) <= clk_line_p(i);
       s_clk_line_n(i) <= clk_line_n(i);
       s_ser_a_p(i) <= ser_a_p(4*i+3 downto 4*i);
       s_ser_a_n(i) <= ser_a_n(4*i+3 downto 4*i);
       s_ser_b_p(i) <= ser_b_p(4*i+3 downto 4*i);
       s_ser_b_n(i) <= ser_b_n(4*i+3 downto 4*i);

       -- ISERDES Controller
       s_iserdes_bitslip(i) <= iserdes_bitslip(i);

       -- Delay Controller
       s_delay_rst(i) <= delay_rst_edge(4*i+3 downto 4*i);

       -- TODO Figure out a cleaner way to set generic based on i=master
       -- condition.  The generic setting is the only difference between these
       -- two conditional generates.
       master_adc: if i = master generate
        master_unit : adc_unit
        generic map (
                   mode => "MASTER")
        port map (
                   line_clk => s_line_clk(i),
                   frame_clk => s_frame_clk(i),
                   fabric_clk => s_fabric_clk(i),
                   fabric_clk_90 => s_fabric_clk_90(i),
                   fabric_clk_180 => s_fabric_clk_180(i),
                   fabric_clk_270 => s_fabric_clk_270(i),
                   locked => s_locked(i),
                   i_line_clk => s_i_line_clk(i),
                   i_frame_clk => s_i_frame_clk(i),
                   i_fabric_clk => s_i_fabric_clk(i),
                   reset => s_reset(i),

                   clk_line_p => s_clk_line_p(i),
                   clk_line_n => s_clk_line_n(i),
                   ser_a_p => s_ser_a_p(i),
                   ser_a_n => s_ser_a_n(i),
                   ser_b_p => s_ser_b_p(i),
                   ser_b_n => s_ser_b_n(i),

                   iserdes_bitslip => s_iserdes_bitslip(i),
                   p_data => s_p_data0(i),

                   delay_rst => s_delay_rst(i),
                   delay_tap => delay_tap
         );
       end generate;

       slave_adc: if i /= master generate
        slave_unit : adc_unit
        generic map (
                   mode => "SLAVE")
        port map (
                   line_clk => s_line_clk(i),
                   frame_clk => s_frame_clk(i),
                   fabric_clk => s_fabric_clk(i),
                   fabric_clk_90 => s_fabric_clk_90(i),
                   fabric_clk_180 => s_fabric_clk_180(i),
                   fabric_clk_270 => s_fabric_clk_270(i),
                   locked => s_locked(i),
                   i_line_clk => s_i_line_clk(i),
                   i_frame_clk => s_i_frame_clk(i),
                   i_fabric_clk => s_i_fabric_clk(i),
                   reset => s_reset(i),

                   clk_line_p => s_clk_line_p(i),
                   clk_line_n => s_clk_line_n(i),
                   ser_a_p => s_ser_a_p(i),
                   ser_a_n => s_ser_a_n(i),
                   ser_b_p => s_ser_b_p(i),
                   ser_b_n => s_ser_b_n(i),

                   iserdes_bitslip => s_iserdes_bitslip(i),
                   p_data => s_p_data0(i),

                   delay_rst => s_delay_rst(i),
                   delay_tap => delay_tap
         );
       end generate; -- i /= master
     end generate; -- for i in...

    -- Capture snap_req on rising edge of frame clock so that A/B will be even/odd consistent
    process(s_frame_clk(master))
    begin
      -- rising edge of s_frame_clk(master)
      if rising_edge(s_frame_clk(master))  then
        -- snap_req shift register
        s_snap_req <= s_snap_req(0) & snap_req;
      end if;
    end process;

    process(s_fabric_clk(master))
    begin
      -- rising edge of s_fabric_clk(master)
      if rising_edge(s_fabric_clk(master))  then
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
