-- Generated from Simulink block test_vcu128/gbe
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity test_vcu128_gbe is
  port (
    tx_rst : in std_logic_vector( 1-1 downto 0 );
    tx_data : in std_logic_vector( 8-1 downto 0 );
    tx_val : in std_logic_vector( 1-1 downto 0 );
    tx_destip : in std_logic_vector( 32-1 downto 0 );
    tx_destport : in std_logic_vector( 16-1 downto 0 );
    tx_eof : in std_logic_vector( 1-1 downto 0 );
    rx_ack : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_dvld : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    test_vcu128_gbe_app_rx_ack : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_rst : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_data : out std_logic_vector( 8-1 downto 0 );
    test_vcu128_gbe_app_tx_destip : out std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_tx_destport : out std_logic_vector( 16-1 downto 0 );
    test_vcu128_gbe_app_tx_dvld : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_eof : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_rst : out std_logic_vector( 1-1 downto 0 )
  );
end test_vcu128_gbe;
architecture structural of test_vcu128_gbe is 
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_data_net : std_logic_vector( 8-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_srcip_net : std_logic_vector( 32-1 downto 0 );
  signal test_vcu128_gbe_app_rx_srcport_net : std_logic_vector( 16-1 downto 0 );
  signal convert_tx_data_dout_net : std_logic_vector( 8-1 downto 0 );
  signal test_vcu128_gbe_app_rx_eof_net : std_logic_vector( 1-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert_rx_ack_dout_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_dvld_net : std_logic_vector( 1-1 downto 0 );
  signal convert_rx_rst_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert_tx_dest_ip_dout_net : std_logic_vector( 32-1 downto 0 );
  signal convert_tx_port_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert_tx_valid_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert_tx_end_of_frame_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert_tx_rst_dout_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
begin
  register_q_net <= tx_rst;
  test_vcu128_gbe_app_rx_data_net <= tx_data;
  logical_y_net <= tx_val;
  test_vcu128_gbe_app_rx_srcip_net <= tx_destip;
  test_vcu128_gbe_app_rx_srcport_net <= tx_destport;
  test_vcu128_gbe_app_rx_eof_net <= tx_eof;
  constant2_op_net <= rx_ack;
  test_vcu128_gbe_app_rx_ack <= convert_rx_ack_dout_net;
  test_vcu128_gbe_app_rx_dvld_net <= test_vcu128_gbe_app_rx_dvld;
  test_vcu128_gbe_app_rx_rst <= convert_rx_rst_dout_net;
  test_vcu128_gbe_app_tx_data <= convert_tx_data_dout_net;
  test_vcu128_gbe_app_tx_destip <= convert_tx_dest_ip_dout_net;
  test_vcu128_gbe_app_tx_destport <= convert_tx_port_dout_net;
  test_vcu128_gbe_app_tx_dvld <= convert_tx_valid_dout_net;
  test_vcu128_gbe_app_tx_eof <= convert_tx_end_of_frame_dout_net;
  test_vcu128_gbe_app_tx_rst <= convert_tx_rst_dout_net;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert_rx_ack : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => constant2_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_rx_ack_dout_net
  );
  convert_rx_rst : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_rx_rst_dout_net
  );
  convert_tx_data : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 8,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 8,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => test_vcu128_gbe_app_rx_data_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_tx_data_dout_net
  );
  convert_tx_dest_ip : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 32,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 32,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => test_vcu128_gbe_app_rx_srcip_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_tx_dest_ip_dout_net
  );
  convert_tx_end_of_frame : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => test_vcu128_gbe_app_rx_eof_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_tx_end_of_frame_dout_net
  );
  convert_tx_port : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 16,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => test_vcu128_gbe_app_rx_srcport_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_tx_port_dout_net
  );
  convert_tx_rst : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => register_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_tx_rst_dout_net
  );
  convert_tx_valid : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_tx_valid_dout_net
  );
end structural;
-- Generated from Simulink block test_vcu128/led
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity test_vcu128_led is
  port (
    gpio_out : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    test_vcu128_led_gateway : out std_logic_vector( 1-1 downto 0 )
  );
end test_vcu128_led;
architecture structural of test_vcu128_led is 
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
begin
  slice2_y_net <= gpio_out;
  test_vcu128_led_gateway <= convert_dout_net;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert : entity xil_defaultlib.test_vcu128_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => slice2_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
end structural;
-- Generated from Simulink block test_vcu128/rst
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity test_vcu128_rst is
  port (
    test_vcu128_rst_user_data_out : in std_logic_vector( 32-1 downto 0 );
    in_reg : out std_logic_vector( 32-1 downto 0 )
  );
end test_vcu128_rst;
architecture structural of test_vcu128_rst is 
  signal slice_reg_y_net : std_logic_vector( 32-1 downto 0 );
  signal reint1_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal test_vcu128_rst_user_data_out_net : std_logic_vector( 32-1 downto 0 );
  signal io_delay_q_net : std_logic_vector( 32-1 downto 0 );
begin
  in_reg <= reint1_output_port_net;
  test_vcu128_rst_user_data_out_net <= test_vcu128_rst_user_data_out;
  io_delay : entity xil_defaultlib.sysgen_delay_d96dec5809 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => test_vcu128_rst_user_data_out_net,
    q => io_delay_q_net
  );
  slice_reg : entity xil_defaultlib.test_vcu128_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 31,
    x_width => 32,
    y_width => 32
  )
  port map (
    x => io_delay_q_net,
    y => slice_reg_y_net
  );
  reint1 : entity xil_defaultlib.sysgen_reinterpret_1dbd733f37 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_reg_y_net,
    output_port => reint1_output_port_net
  );
end structural;
-- Generated from Simulink block test_vcu128_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity test_vcu128_struct is
  port (
    test_vcu128_gbe_app_dbg_data : in std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_dbg_dvld : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_badframe : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_data : in std_logic_vector( 8-1 downto 0 );
    test_vcu128_gbe_app_rx_dvld : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_eof : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_overrun : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_srcip : in std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_rx_srcport : in std_logic_vector( 16-1 downto 0 );
    test_vcu128_gbe_app_tx_afull : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_overflow : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_rst_user_data_out : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    test_vcu128_gbe_app_rx_ack : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_rst : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_data : out std_logic_vector( 8-1 downto 0 );
    test_vcu128_gbe_app_tx_destip : out std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_tx_destport : out std_logic_vector( 16-1 downto 0 );
    test_vcu128_gbe_app_tx_dvld : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_eof : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_rst : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_led_gateway : out std_logic_vector( 1-1 downto 0 )
  );
end test_vcu128_struct;
architecture structural of test_vcu128_struct is 
  signal test_vcu128_gbe_app_dbg_data_net : std_logic_vector( 32-1 downto 0 );
  signal test_vcu128_gbe_app_dbg_dvld_net : std_logic_vector( 1-1 downto 0 );
  signal convert_rx_ack_dout_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_badframe_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_data_net : std_logic_vector( 8-1 downto 0 );
  signal test_vcu128_gbe_app_rx_dvld_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_eof_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_overrun_net : std_logic_vector( 1-1 downto 0 );
  signal convert_rx_rst_dout_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_rx_srcip_net : std_logic_vector( 32-1 downto 0 );
  signal test_vcu128_gbe_app_rx_srcport_net : std_logic_vector( 16-1 downto 0 );
  signal test_vcu128_gbe_app_tx_afull_net : std_logic_vector( 1-1 downto 0 );
  signal convert_tx_data_dout_net : std_logic_vector( 8-1 downto 0 );
  signal convert_tx_dest_ip_dout_net : std_logic_vector( 32-1 downto 0 );
  signal convert_tx_port_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert_tx_valid_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert_tx_end_of_frame_dout_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_gbe_app_tx_overflow_net : std_logic_vector( 1-1 downto 0 );
  signal convert_tx_rst_dout_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal test_vcu128_rst_user_data_out_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal reint1_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 32-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  test_vcu128_gbe_app_dbg_data_net <= test_vcu128_gbe_app_dbg_data;
  test_vcu128_gbe_app_dbg_dvld_net <= test_vcu128_gbe_app_dbg_dvld;
  test_vcu128_gbe_app_rx_ack <= convert_rx_ack_dout_net;
  test_vcu128_gbe_app_rx_badframe_net <= test_vcu128_gbe_app_rx_badframe;
  test_vcu128_gbe_app_rx_data_net <= test_vcu128_gbe_app_rx_data;
  test_vcu128_gbe_app_rx_dvld_net <= test_vcu128_gbe_app_rx_dvld;
  test_vcu128_gbe_app_rx_eof_net <= test_vcu128_gbe_app_rx_eof;
  test_vcu128_gbe_app_rx_overrun_net <= test_vcu128_gbe_app_rx_overrun;
  test_vcu128_gbe_app_rx_rst <= convert_rx_rst_dout_net;
  test_vcu128_gbe_app_rx_srcip_net <= test_vcu128_gbe_app_rx_srcip;
  test_vcu128_gbe_app_rx_srcport_net <= test_vcu128_gbe_app_rx_srcport;
  test_vcu128_gbe_app_tx_afull_net <= test_vcu128_gbe_app_tx_afull;
  test_vcu128_gbe_app_tx_data <= convert_tx_data_dout_net;
  test_vcu128_gbe_app_tx_destip <= convert_tx_dest_ip_dout_net;
  test_vcu128_gbe_app_tx_destport <= convert_tx_port_dout_net;
  test_vcu128_gbe_app_tx_dvld <= convert_tx_valid_dout_net;
  test_vcu128_gbe_app_tx_eof <= convert_tx_end_of_frame_dout_net;
  test_vcu128_gbe_app_tx_overflow_net <= test_vcu128_gbe_app_tx_overflow;
  test_vcu128_gbe_app_tx_rst <= convert_tx_rst_dout_net;
  test_vcu128_led_gateway <= convert_dout_net;
  test_vcu128_rst_user_data_out_net <= test_vcu128_rst_user_data_out;
  clk_net <= clk_1;
  ce_net <= ce_1;
  gbe : entity xil_defaultlib.test_vcu128_gbe 
  port map (
    tx_rst => register_q_net,
    tx_data => test_vcu128_gbe_app_rx_data_net,
    tx_val => logical_y_net,
    tx_destip => test_vcu128_gbe_app_rx_srcip_net,
    tx_destport => test_vcu128_gbe_app_rx_srcport_net,
    tx_eof => test_vcu128_gbe_app_rx_eof_net,
    rx_ack => constant2_op_net,
    test_vcu128_gbe_app_rx_dvld => test_vcu128_gbe_app_rx_dvld_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    test_vcu128_gbe_app_rx_ack => convert_rx_ack_dout_net,
    test_vcu128_gbe_app_rx_rst => convert_rx_rst_dout_net,
    test_vcu128_gbe_app_tx_data => convert_tx_data_dout_net,
    test_vcu128_gbe_app_tx_destip => convert_tx_dest_ip_dout_net,
    test_vcu128_gbe_app_tx_destport => convert_tx_port_dout_net,
    test_vcu128_gbe_app_tx_dvld => convert_tx_valid_dout_net,
    test_vcu128_gbe_app_tx_eof => convert_tx_end_of_frame_dout_net,
    test_vcu128_gbe_app_tx_rst => convert_tx_rst_dout_net
  );
  led : entity xil_defaultlib.test_vcu128_led 
  port map (
    gpio_out => slice2_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    test_vcu128_led_gateway => convert_dout_net
  );
  rst : entity xil_defaultlib.test_vcu128_rst 
  port map (
    test_vcu128_rst_user_data_out => test_vcu128_rst_user_data_out_net,
    in_reg => reint1_output_port_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_b18c6eea6d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_b18c6eea6d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  counter : entity xil_defaultlib.test_vcu128_xlcounter_free 
  generic map (
    core_name0 => "test_vcu128_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 32
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_1a8453a188 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => constant1_op_net,
    d1 => test_vcu128_gbe_app_rx_dvld_net,
    y => logical_y_net
  );
  register_x0 : entity xil_defaultlib.test_vcu128_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => slice1_y_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  slice1 : entity xil_defaultlib.test_vcu128_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => reint1_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.test_vcu128_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 26,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => counter_op_net,
    y => slice2_y_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity test_vcu128_default_clock_driver is
  port (
    test_vcu128_sysclk : in std_logic;
    test_vcu128_sysce : in std_logic;
    test_vcu128_sysclr : in std_logic;
    test_vcu128_clk1 : out std_logic;
    test_vcu128_ce1 : out std_logic
  );
end test_vcu128_default_clock_driver;
architecture structural of test_vcu128_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => test_vcu128_sysclk,
    sysce => test_vcu128_sysce,
    sysclr => test_vcu128_sysclr,
    clk => test_vcu128_clk1,
    ce => test_vcu128_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity test_vcu128 is
  port (
    test_vcu128_gbe_app_dbg_data : in std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_dbg_dvld : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_badframe : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_data : in std_logic_vector( 8-1 downto 0 );
    test_vcu128_gbe_app_rx_dvld : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_eof : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_overrun : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_srcip : in std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_rx_srcport : in std_logic_vector( 16-1 downto 0 );
    test_vcu128_gbe_app_tx_afull : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_overflow : in std_logic_vector( 1-1 downto 0 );
    test_vcu128_rst_user_data_out : in std_logic_vector( 32-1 downto 0 );
    clk : in std_logic;
    test_vcu128_gbe_app_rx_ack : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_rx_rst : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_data : out std_logic_vector( 8-1 downto 0 );
    test_vcu128_gbe_app_tx_destip : out std_logic_vector( 32-1 downto 0 );
    test_vcu128_gbe_app_tx_destport : out std_logic_vector( 16-1 downto 0 );
    test_vcu128_gbe_app_tx_dvld : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_eof : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_gbe_app_tx_rst : out std_logic_vector( 1-1 downto 0 );
    test_vcu128_led_gateway : out std_logic_vector( 1-1 downto 0 )
  );
end test_vcu128;
architecture structural of test_vcu128 is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "test_vcu128,sysgen_core_2018_2,{,compilation=HDL Netlist,block_icon_display=Default,family=virtexuplusHBMes1,part=xcvu37p,speed=-2L-e-es1,package=fsvh2892,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=10,system_simulink_period=1,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=10,constant=2,convert=9,counter=1,delay=1,logical=1,register=1,reinterpret=1,slice=3,}";
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
begin
  test_vcu128_default_clock_driver : entity xil_defaultlib.test_vcu128_default_clock_driver 
  port map (
    test_vcu128_sysclk => clk,
    test_vcu128_sysce => '1',
    test_vcu128_sysclr => '0',
    test_vcu128_clk1 => clk_1_net,
    test_vcu128_ce1 => ce_1_net
  );
  test_vcu128_struct : entity xil_defaultlib.test_vcu128_struct 
  port map (
    test_vcu128_gbe_app_dbg_data => test_vcu128_gbe_app_dbg_data,
    test_vcu128_gbe_app_dbg_dvld => test_vcu128_gbe_app_dbg_dvld,
    test_vcu128_gbe_app_rx_badframe => test_vcu128_gbe_app_rx_badframe,
    test_vcu128_gbe_app_rx_data => test_vcu128_gbe_app_rx_data,
    test_vcu128_gbe_app_rx_dvld => test_vcu128_gbe_app_rx_dvld,
    test_vcu128_gbe_app_rx_eof => test_vcu128_gbe_app_rx_eof,
    test_vcu128_gbe_app_rx_overrun => test_vcu128_gbe_app_rx_overrun,
    test_vcu128_gbe_app_rx_srcip => test_vcu128_gbe_app_rx_srcip,
    test_vcu128_gbe_app_rx_srcport => test_vcu128_gbe_app_rx_srcport,
    test_vcu128_gbe_app_tx_afull => test_vcu128_gbe_app_tx_afull,
    test_vcu128_gbe_app_tx_overflow => test_vcu128_gbe_app_tx_overflow,
    test_vcu128_rst_user_data_out => test_vcu128_rst_user_data_out,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    test_vcu128_gbe_app_rx_ack => test_vcu128_gbe_app_rx_ack,
    test_vcu128_gbe_app_rx_rst => test_vcu128_gbe_app_rx_rst,
    test_vcu128_gbe_app_tx_data => test_vcu128_gbe_app_tx_data,
    test_vcu128_gbe_app_tx_destip => test_vcu128_gbe_app_tx_destip,
    test_vcu128_gbe_app_tx_destport => test_vcu128_gbe_app_tx_destport,
    test_vcu128_gbe_app_tx_dvld => test_vcu128_gbe_app_tx_dvld,
    test_vcu128_gbe_app_tx_eof => test_vcu128_gbe_app_tx_eof,
    test_vcu128_gbe_app_tx_rst => test_vcu128_gbe_app_tx_rst,
    test_vcu128_led_gateway => test_vcu128_led_gateway
  );
end structural;
