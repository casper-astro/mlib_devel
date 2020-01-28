// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Fri Nov  2 13:29:22 2018
// Host        : adam-cm running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aisaacson/work/git_work/ska_sa/projects/mlib_devel/jasper_library/test_models/test_skarab_adc/myproj/myproj.srcs/sources_1/ip/ADC_AXIS_ASYNC_FIFO/ADC_AXIS_ASYNC_FIFO_stub.v
// Design      : ADC_AXIS_ASYNC_FIFO
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axis_data_fifo_v1_1_18_axis_data_fifo,Vivado 2018.2" *)
module ADC_AXIS_ASYNC_FIFO(s_axis_aresetn, m_axis_aresetn, s_axis_aclk, 
  s_axis_tvalid, s_axis_tready, s_axis_tdata, s_axis_tlast, m_axis_aclk, m_axis_tvalid, 
  m_axis_tready, m_axis_tdata, m_axis_tlast, axis_data_count, axis_wr_data_count, 
  axis_rd_data_count)
/* synthesis syn_black_box black_box_pad_pin="s_axis_aresetn,m_axis_aresetn,s_axis_aclk,s_axis_tvalid,s_axis_tready,s_axis_tdata[127:0],s_axis_tlast,m_axis_aclk,m_axis_tvalid,m_axis_tready,m_axis_tdata[127:0],m_axis_tlast,axis_data_count[31:0],axis_wr_data_count[31:0],axis_rd_data_count[31:0]" */;
  input s_axis_aresetn;
  input m_axis_aresetn;
  input s_axis_aclk;
  input s_axis_tvalid;
  output s_axis_tready;
  input [127:0]s_axis_tdata;
  input s_axis_tlast;
  input m_axis_aclk;
  output m_axis_tvalid;
  input m_axis_tready;
  output [127:0]m_axis_tdata;
  output m_axis_tlast;
  output [31:0]axis_data_count;
  output [31:0]axis_wr_data_count;
  output [31:0]axis_rd_data_count;
endmodule
