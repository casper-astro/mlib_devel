`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2020 02:40:57 PM
// Design Name: 
// Module Name: pci_top_bb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pci_top(
   input           pcie_refclk_p,
   input           pcie_refclk_n,
    
   input           pcie_rst_n, 
   input  [0:0]    pci_exp_rxp,
   input  [0:0]    pci_exp_rxn,
   output [0:0]    pci_exp_txp,
   output [0:0]    pci_exp_txn,
   output [31:0]   m_axil_awaddr,
   output [32-1:0] m_axil_awuser,
   output [2:0]    m_axil_awprot,
   output          m_axil_awvalid,
   input           m_axil_awready,
   output [31:0]   m_axil_wdata,
   output [3:0]    m_axil_wstrb,
   output          m_axil_wvalid,
   input           m_axil_wready,
   input           m_axil_bvalid,
   input  [1:0]    m_axil_bresp,
   output          m_axil_bready,
   output [31:0]   m_axil_araddr,
   output [32-1:0] m_axil_aruser,
   output [2:0]    m_axil_arprot,
   output          m_axil_arvalid,
   input           m_axil_arready,
   input  [31:0]   m_axil_rdata ,
   input  [1:0]    m_axil_rresp ,
   input           m_axil_rvalid,
   output          m_axil_rready,
      
   output          axi_aclk,
   output          axi_aresetn

  );
    
  wire user_lnk_up;
  wire gt_cplllock;
  wire gt_txresetdone;
  wire gt_rxresetdone;
  wire mcap_design_switch;
  wire pcie_refclk;
  wire pcie_refclk_div2;
  wire pcie_rst_n_buf;
  
  wire [31:0] M_AXIS_0_tdata;
  wire [3:0] M_AXIS_0_tkeep;
  wire M_AXIS_0_tready;
  wire M_AXIS_0_tvalid;
  
  wire PRDONE;
  wire PRERROR;
  

  pcie_master pcie_master_inst (
    .M_AXIS_0_tdata(M_AXIS_0_tdata),
    .M_AXIS_0_tkeep(M_AXIS_0_tkeep),
    .M_AXIS_0_tlast(),
    .M_AXIS_0_tready(M_AXIS_0_tready),
    .M_AXIS_0_tvalid(M_AXIS_0_tvalid),
    .M_AXI_LITE_0_araddr(m_axil_araddr),
    .M_AXI_LITE_0_arprot(m_axil_arprot),
    .M_AXI_LITE_0_arready(m_axil_arready),
    .M_AXI_LITE_0_arvalid(m_axil_arvalid),
    .M_AXI_LITE_0_awaddr(m_axil_awaddr),
    .M_AXI_LITE_0_awprot(m_axil_awprot),
    .M_AXI_LITE_0_awready(m_axil_awready),
    .M_AXI_LITE_0_awvalid(m_axil_awvalid),
    .M_AXI_LITE_0_bready(m_axil_bready),
    .M_AXI_LITE_0_bresp(m_axil_bresp),
    .M_AXI_LITE_0_bvalid(m_axil_bvalid),
    .M_AXI_LITE_0_rdata(m_axil_rdata),
    .M_AXI_LITE_0_rready(m_axil_rready),
    .M_AXI_LITE_0_rresp(m_axil_rresp),
    .M_AXI_LITE_0_rvalid(m_axil_rvalid),
    .M_AXI_LITE_0_wdata(m_axil_wdata),
    .M_AXI_LITE_0_wready(m_axil_wready),
    .M_AXI_LITE_0_wstrb(m_axil_wstrb),
    .M_AXI_LITE_0_wvalid(m_axil_wvalid),
    .axi_aclk_0(axi_aclk),
    .axi_aresetn_0(axi_aresetn),
    .pcie_mgt_0_rxn(pci_exp_rxn),
    .pcie_mgt_0_rxp(pci_exp_rxp),
    .pcie_mgt_0_txn(pci_exp_txn),
    .pcie_mgt_0_txp(pci_exp_txp),
    .sys_clk_0(pcie_refclk_div2),
    .sys_clk_gt_0(pcie_refclk),
    .sys_rst_n_0(pcie_rst_n_buf),
    .user_lnk_up_0(user_lnk_up),
    .usr_irq_req_0(1'b0)
  );

  ICAPE3 #(
     .DEVICE_ID(32'h03628093), // Specifies the pre-programmed Device ID value to be used for simulation purposes.
     .ICAP_AUTO_SWITCH("DISABLE"), // Enable switch ICAP using sync word
     .SIM_CFG_FILE_NAME("NONE") // Specifies the Raw Bitstream (RBT) file to be parsed by the simulation model
  ) ICAPE3_inst (
     .AVAIL    (M_AXIS_0_tready),    // 1-bit output: Availability status of ICAP
     .O        (),         // 32-bit output: Configuration data output bus
     .PRDONE   (PRDONE),   // 1-bit output: Indicates completion of Partial Reconfiguration
     .PRERROR  (PRERROR),  // 1-bit output: Indicates Error during Partial Reconfiguration
     .CLK      (axi_aclk),      // 1-bit input: Clock input
     .CSIB     (!M_AXIS_0_tvalid),     // 1-bit input: Active-Low ICAP enable
     .I        (M_AXIS_0_tdata),        // 32-bit input: Configuration data input bus
     .RDWRB    (1'b0)     // 1-bit input: Read/Write Select input
  );


//  ila_0 ila_i (
//    .clk(axil_clk),
//    .probe0(axil_rst_n),
//    .probe1(pcie_rst_n),
//    .probe2(user_lnk_up),
//    .probe3(mcap_design_switch),//gt_cplllock),
//    .probe4(1'b0),//gt_rxresetdone),
//    .probe5(1'b0),//gt_txresetdone),
//    .probe6(axil_rst),
//    .probe7(1'b0)
//  );

  IBUFDS_GTE4  pci_refclk_buf (
    .CEB(1'b0),
    .I(pcie_refclk_p),
    .IB(pcie_refclk_n),
    .O(pcie_refclk),
    .ODIV2(pcie_refclk_div2)
  );
  
  IBUF pcie_rst_ibuf_inst (
    .I(pcie_rst_n),
    .O(pcie_rst_n_buf)
  );
    
    endmodule
