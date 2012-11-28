----------------------------------------------------------------------------
-- Import useful libraries
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- entity declaraction
entity  adc16_interface  is
    port (
	            -- System
					div_clk      :  out std_logic;
					ctrl_clk      :  in  std_logic;
					data_clk      :  in  std_logic;
					reset         :  in  std_logic;
					
					-- ZDOK
               clk_line_p    :  in  std_logic_vector(3 downto 0);
					clk_line_n    :  in  std_logic_vector(3 downto 0);
					ser_a_p       :  in  std_logic_vector(15 downto 0);
					ser_a_n       :  in  std_logic_vector(15 downto 0);
					ser_b_p       :  in  std_logic_vector(15 downto 0);
					ser_b_n       :  in  std_logic_vector(15 downto 0);
					
					
					-- ISERDES Controller
					iserdes_bitslip  :  in  std_logic_vector(3 downto 0);
					load_phase_set   :  in  std_logic_vector(3 downto 0);
					p_data_a         :  out std_logic_vector(31 downto 0);
					p_data_b         :  out std_logic_vector(31 downto 0);
					p_data_c         :  out std_logic_vector(31 downto 0);
					p_data_d         :  out std_logic_vector(31 downto 0);
					
					-- Delay Controller		
               delay_rst        :  in  std_logic_vector(15 downto 0);
               delay_tap        :  in  std_logic_vector(4 downto 0)			
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
					div_clk       :  out std_logic;
					ref_clk       :  out std_logic;
					i_line_clk    :  in  std_logic;
					i_div_clk     :  in  std_logic;
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
					
					-- Delay Controller					
               delay_clk        :  in  std_logic; -- 200MHz
               delay_rst        :  in  std_logic_vector(3 downto 0);
               delay_tap        :  in  std_logic_vector(19 downto 0)					
    );
    end component;
	  
	  -- Signals
	  type  i4_v1  is array (0 to 3) of std_logic;
	  type  i4_v4  is array (0 to 3) of std_logic_vector(3 downto 0);
	  type  i4_v20 is array (0 to 3) of std_logic_vector(19 downto 0);
     type  i4_v32 is array (0 to 3) of std_logic_vector(31 downto 0);
	    
	  signal s_line_clk : i4_v1;
	  signal s_div_clk : i4_v1;
	  signal s_ref_clk : i4_v1;
	  signal s_i_line_clk : i4_v1;
	  signal s_i_div_clk : i4_v1;
	  signal s_ctrl_clk : i4_v1;
	  signal s_data_clk : i4_v1;
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
	  signal s_load_phase_set : i4_v1;
	  signal s_p_data : i4_v32;
					
	  -- Delay Controller					
     signal s_delay_clk : i4_v1;
     signal s_delay_rst : i4_v4;
     signal s_delay_tap : i4_v20;	  
	  
     begin
	  
	  -- Internal routing
	  
	  div_clk <= s_div_clk(0);
	  
	  -- ADC A
	  s_i_line_clk(0) <= s_line_clk(0);
	  s_i_div_clk(0) <= s_div_clk(0);
	  s_ctrl_clk(0) <= ctrl_clk;
	  s_data_clk(0) <= data_clk;
	  s_reset(0) <= reset;
	  
     -- ZDOK
     s_clk_line_p(0) <= clk_line_p(0);
	  s_clk_line_n(0) <= clk_line_n(0);
	  s_ser_a_p(0) <= ser_a_p(3 downto 0);
	  s_ser_a_n(0) <= ser_a_n(3 downto 0);
	  s_ser_b_p(0) <= ser_b_p(3 downto 0);
	  s_ser_b_n(0) <= ser_b_n(3 downto 0);
								
	  -- ISERDES Controller
	  s_iserdes_bitslip(0) <= iserdes_bitslip(0);
	  s_load_phase_set(0) <= load_phase_set(0);
	  p_data_a <= s_p_data(0);
					
	  -- Delay Controller					
     s_delay_clk(0) <= s_div_clk(0);
     s_delay_rst(0) <= delay_rst(3 downto 0);
     s_delay_tap(0) <= delay_tap&delay_tap&delay_tap&delay_tap;	  

	  -- ADC B
	  s_i_line_clk(1) <= s_line_clk(0);
	  s_i_div_clk(1) <= s_div_clk(0);
	  s_ctrl_clk(1) <= ctrl_clk;
	  s_data_clk(1) <= data_clk;
	  s_reset(1) <= reset;
	  
     -- ZDOK
     s_clk_line_p(1) <= clk_line_p(1);
	  s_clk_line_n(1) <= clk_line_n(1);
	  s_ser_a_p(1) <= ser_a_p(7 downto 4);
	  s_ser_a_n(1) <= ser_a_n(7 downto 4);
	  s_ser_b_p(1) <= ser_b_p(7 downto 4);
	  s_ser_b_n(1) <= ser_b_n(7 downto 4);
								
	  -- ISERDES Controller
	  s_iserdes_bitslip(1) <= iserdes_bitslip(1);
	  s_load_phase_set(1) <= load_phase_set(1);
	  p_data_b <= s_p_data(1);
					
	  -- Delay Controller					
     s_delay_clk(1) <= s_div_clk(0);
     s_delay_rst(1) <= delay_rst(7 downto 4);
     s_delay_tap(1) <= delay_tap&delay_tap&delay_tap&delay_tap;	  

	  -- ADC C
	  s_i_line_clk(2) <= s_line_clk(0);
	  s_i_div_clk(2) <= s_div_clk(0);
	  s_ctrl_clk(2) <= ctrl_clk;
	  s_data_clk(2) <= data_clk;
	  s_reset(2) <= reset;
	  
     -- ZDOK
     s_clk_line_p(2) <= clk_line_p(2);
	  s_clk_line_n(2) <= clk_line_n(2);
	  s_ser_a_p(2) <= ser_a_p(11 downto 8);
	  s_ser_a_n(2) <= ser_a_n(11 downto 8);
	  s_ser_b_p(2) <= ser_b_p(11 downto 8);
	  s_ser_b_n(2) <= ser_b_n(11 downto 8);
								
	  -- ISERDES Controller
	  s_iserdes_bitslip(2) <= iserdes_bitslip(2);
	  s_load_phase_set(2) <= load_phase_set(2);
	  p_data_c <= s_p_data(2);
					
	  -- Delay Controller					
     s_delay_clk(2) <= s_div_clk(0);
     s_delay_rst(2) <= delay_rst(11 downto 8);
     s_delay_tap(2) <= delay_tap&delay_tap&delay_tap&delay_tap;	  

	  -- ADC D
	  s_i_line_clk(3) <= s_line_clk(0);
	  s_i_div_clk(3) <= s_div_clk(0);
	  s_ctrl_clk(3) <= ctrl_clk;
	  s_data_clk(3) <= data_clk;
	  s_reset(3) <= reset;
	  
     -- ZDOK
     s_clk_line_p(3) <= clk_line_p(3);
	  s_clk_line_n(3) <= clk_line_n(3);
	  s_ser_a_p(3) <= ser_a_p(15 downto 12);
	  s_ser_a_n(3) <= ser_a_n(15 downto 12);
	  s_ser_b_p(3) <= ser_b_p(15 downto 12);
	  s_ser_b_n(3) <= ser_b_n(15 downto 12);
								
	  -- ISERDES Controller
	  s_iserdes_bitslip(3) <= iserdes_bitslip(3);
	  s_load_phase_set(3) <= load_phase_set(3);
	  p_data_d <= s_p_data(3);
					
	  -- Delay Controller					
     s_delay_clk(3) <= s_div_clk(0);
     s_delay_rst(3) <= delay_rst(15 downto 12);
     s_delay_tap(3) <= delay_tap&delay_tap&delay_tap&delay_tap;	  
	  
	 -- ADC A
	 adc_A : adc_unit
    generic map (
               mode => "MASTER")
    port map (
					line_clk => s_line_clk(0),
					div_clk => s_div_clk(0),
					ref_clk => s_ref_clk(0),
					i_line_clk => s_i_line_clk(0),
					i_div_clk => s_i_div_clk(0),
					ctrl_clk => s_ctrl_clk(0),
					data_clk => s_data_clk(0),
					reset => s_reset(0),
					
					clk_line_p => s_clk_line_p(0),
					clk_line_n => s_clk_line_n(0),
					ser_a_p => s_ser_a_p(0),
					ser_a_n => s_ser_a_n(0),
					ser_b_p => s_ser_b_p(0),
					ser_b_n => s_ser_b_n(0),
					
					iserdes_bitslip => s_iserdes_bitslip(0),
					load_phase_set => s_load_phase_set(0),
					p_data => s_p_data(0),
					
					delay_clk => s_delay_clk(0),
               delay_rst => s_delay_rst(0),
               delay_tap => s_delay_tap(0)
	  );
	 
    -- ADC B
	 adc_B : adc_unit
    generic map (
               mode => "SLAVE")
    port map (
					line_clk => s_line_clk(1),
					div_clk => s_div_clk(1),
					ref_clk => s_ref_clk(1),
					i_line_clk => s_i_line_clk(1),
					i_div_clk => s_i_div_clk(1),
					ctrl_clk => s_ctrl_clk(1),
					data_clk => s_data_clk(1),
					reset => s_reset(1),
					
					clk_line_p => s_clk_line_p(1),
					clk_line_n => s_clk_line_n(1),
					ser_a_p => s_ser_a_p(1),
					ser_a_n => s_ser_a_n(1),
					ser_b_p => s_ser_b_p(1),
					ser_b_n => s_ser_b_n(1),
					
					iserdes_bitslip => s_iserdes_bitslip(1),
					load_phase_set => s_load_phase_set(1),
					p_data => s_p_data(1),
					
					delay_clk => s_delay_clk(1),
               delay_rst => s_delay_rst(1),
               delay_tap => s_delay_tap(1)
	  );
	 
    -- ADC C
	 adc_C : adc_unit
    generic map (
               mode => "SLAVE")
    port map (
					line_clk => s_line_clk(2),
					div_clk => s_div_clk(2),
					ref_clk => s_ref_clk(2),
					i_line_clk => s_i_line_clk(2),
					i_div_clk => s_i_div_clk(2),
					ctrl_clk => s_ctrl_clk(2),
					data_clk => s_data_clk(2),
					reset => s_reset(2),
					
					clk_line_p => s_clk_line_p(2),
					clk_line_n => s_clk_line_n(2),
					ser_a_p => s_ser_a_p(2),
					ser_a_n => s_ser_a_n(2),
					ser_b_p => s_ser_b_p(2),
					ser_b_n => s_ser_b_n(2),
					
					iserdes_bitslip => s_iserdes_bitslip(2),
					load_phase_set => s_load_phase_set(2),
					p_data => s_p_data(2),
					
					delay_clk => s_delay_clk(2),
               delay_rst => s_delay_rst(2),
               delay_tap => s_delay_tap(2)
	  );
	 
    -- ADC D
	 adc_D : adc_unit
    generic map (
               mode => "SLAVE")
    port map (
					line_clk => s_line_clk(3),
					div_clk => s_div_clk(3),
					ref_clk => s_ref_clk(3),
					i_line_clk => s_i_line_clk(3),
					i_div_clk => s_i_div_clk(3),
					ctrl_clk => s_ctrl_clk(3),
					data_clk => s_data_clk(3),
					reset => s_reset(3),
					
					clk_line_p => s_clk_line_p(3),
					clk_line_n => s_clk_line_n(3),
					ser_a_p => s_ser_a_p(3),
					ser_a_n => s_ser_a_n(3),
					ser_b_p => s_ser_b_p(3),
					ser_b_n => s_ser_b_n(3),
					
					iserdes_bitslip => s_iserdes_bitslip(3),
					load_phase_set => s_load_phase_set(3),
					p_data => s_p_data(3),
					
					delay_clk => s_delay_clk(3),
               delay_rst => s_delay_rst(3),
               delay_tap => s_delay_tap(3)
	  );
	 	 
end adc16_interface_arc;

