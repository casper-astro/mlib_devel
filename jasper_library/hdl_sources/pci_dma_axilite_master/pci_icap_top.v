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
   input pcie_refclk_p,
   input pcie_refclk_n,
    
   input pcie_rst_n, 
   input [0:0] pci_exp_rxp,
   input [0:0] pci_exp_rxn,
   output [0:0] pci_exp_txp,
   output [0:0] pci_exp_txn,
   output  [31 : 0]                     m_axil_awaddr,
   output  [32-1: 0]                    m_axil_awuser,
   output  [2 : 0]                      m_axil_awprot,
   output                               m_axil_awvalid,
   input                                m_axil_awready,
   output  [31 : 0]                     m_axil_wdata,
   output  [3 : 0]                      m_axil_wstrb,
   output                               m_axil_wvalid,
   input                                m_axil_wready,
   input                                m_axil_bvalid,
   input  [1:0]                         m_axil_bresp,
   output                               m_axil_bready,
   output  [31 : 0]                     m_axil_araddr,
   output  [32-1: 0]                    m_axil_aruser,
   output  [2 : 0]                      m_axil_arprot,
   output                               m_axil_arvalid,
   input                                m_axil_arready,
   input  [31 : 0]                      m_axil_rdata ,
   input  [1 : 0]                       m_axil_rresp ,
   input                                m_axil_rvalid,
   output                               m_axil_rready,
      
   output axi_aclk,
   output axi_aresetn,
   
   input wb_ack_i,
   output [31:0] wb_adr_o,
   output wb_cyc_o,
   input [31:0] wb_dat_i,
   output [31:0] wb_dat_o,
   output wb_rst_o,
   output [3:0] wb_sel_o,
   output wb_stb_o,
   output wb_we_o
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
  reg axi_rst_reg = 1'b0;
  

  pci_axi_wb_master pcie_master_inst (
    .M_AXIS_0_tdata(M_AXIS_0_tdata),
    .M_AXIS_0_tkeep(M_AXIS_0_tkeep),
    .M_AXIS_0_tlast(),
    .M_AXIS_0_tready(M_AXIS_0_tready),
    .M_AXIS_0_tvalid(M_AXIS_0_tvalid),
    .m_axil_araddr(m_axil_araddr),
    .m_axil_arprot(m_axil_arprot),
    .m_axil_arready(m_axil_arready),
    .m_axil_arvalid(m_axil_arvalid),
    .m_axil_awaddr(m_axil_awaddr),
    .m_axil_awprot(m_axil_awprot),
    .m_axil_awready(m_axil_awready),
    .m_axil_awvalid(m_axil_awvalid),
    .m_axil_bready(m_axil_bready),
    .m_axil_bresp(m_axil_bresp),
    .m_axil_bvalid(m_axil_bvalid),
    .m_axil_rdata(m_axil_rdata),
    .m_axil_rready(m_axil_rready),
    .m_axil_rresp(m_axil_rresp),
    .m_axil_rvalid(m_axil_rvalid),
    .m_axil_wdata(m_axil_wdata),
    .m_axil_wready(m_axil_wready),
    .m_axil_wstrb(m_axil_wstrb),
    .m_axil_wvalid(m_axil_wvalid),
    .axi_aclk(axi_aclk),
    .axi_aresetn(axi_aresetn),
    .axilite_rst_n(~axi_rst_reg),
    .pci_exp_rxn(pci_exp_rxn),
    .pci_exp_rxp(pci_exp_rxp),
    .pci_exp_txn(pci_exp_txn),
    .pci_exp_txp(pci_exp_txp),
    .sys_clk(pcie_refclk_div2),
    .sys_clk_gt(pcie_refclk),
    .sys_rst_n(pcie_rst_n_buf),
    .user_lnk_up(user_lnk_up),
    .usr_irq_req(1'b0),
    .ACK_I(wb_ack_i),
    .ADR_O(wb_adr_o),
    .CYC_O(wb_cyc_o),
    .DAT_I(wb_dat_i),
    .DAT_O(wb_dat_o),
    .RST_O(wb_rst_o),
    .SEL_O(wb_sel_o),
    .STB_O(wb_stb_o),
    .WE_O(wb_we_o)
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
  
  reg [16:0] axi_rst_ctr;
  always @(posedge axi_aclk) begin
    if (!PRDONE) begin
      axi_rst_ctr <= 17'b0;
      axi_rst_reg <= 1'b1;
    end else begin
      if (axi_rst_ctr == {17{1'b1}}) begin
        axi_rst_reg <= 1'b0;
      end else begin
        axi_rst_reg <= 1'b1;
        axi_rst_ctr <= axi_rst_ctr + 1'b1;
      end
    end
  end 
    


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