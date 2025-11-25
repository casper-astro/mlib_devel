// Commented soc_system.v
// (Added explanatory comments throughout)

`timescale 1 ps / 1 ps
module soc_system (
    //=========================================================================
    // Clock and Reset Interface
    //=========================================================================
    input  wire        clk_clk,                         // HPS lightweight AXI clock
    output wire        hps_0_h2f_reset_reset_n,         // Reset from HPS to FPGA fabric

    //=========================================================================
    // HPS ? FPGA Lightweight AXI (FULL AXI) Master Interface
    // These are exported directly so the CASPER top-level can bridge them
    // into AXI4-Lite via axi_axil_adapter.
    //=========================================================================
    output wire [11:0] hps_0_h2f_lw_axi_master_awid,    // AXI Write ID
    output wire [20:0] hps_0_h2f_lw_axi_master_awaddr,  // Write address
    output wire [3:0]  hps_0_h2f_lw_axi_master_awlen,   // Burst length
    output wire [2:0]  hps_0_h2f_lw_axi_master_awsize,  // Burst size
    output wire [1:0]  hps_0_h2f_lw_axi_master_awburst, // Burst type
    output wire [1:0]  hps_0_h2f_lw_axi_master_awlock,  // Lock signal
    output wire [3:0]  hps_0_h2f_lw_axi_master_awcache, // Cache type
    output wire [2:0]  hps_0_h2f_lw_axi_master_awprot,  // Protection type
    output wire        hps_0_h2f_lw_axi_master_awvalid, // Write address valid
    input  wire        hps_0_h2f_lw_axi_master_awready, // Write address ready

    output wire [11:0] hps_0_h2f_lw_axi_master_wid,     // Write data ID
    output wire [31:0] hps_0_h2f_lw_axi_master_wdata,   // Write data
    output wire [3:0]  hps_0_h2f_lw_axi_master_wstrb,   // Byte enables
    output wire        hps_0_h2f_lw_axi_master_wlast,   // Last beat of burst
    output wire        hps_0_h2f_lw_axi_master_wvalid,  // Write data valid
    input  wire        hps_0_h2f_lw_axi_master_wready,  // Write data ready

    input  wire [11:0] hps_0_h2f_lw_axi_master_bid,     // Write response ID
    input  wire [1:0]  hps_0_h2f_lw_axi_master_bresp,   // Write response
    input  wire        hps_0_h2f_lw_axi_master_bvalid,  // Write response valid
    output wire        hps_0_h2f_lw_axi_master_bready,  // Write response ready

    output wire [11:0] hps_0_h2f_lw_axi_master_arid,    // Read ID
    output wire [20:0] hps_0_h2f_lw_axi_master_araddr,  // Read address
    output wire [3:0]  hps_0_h2f_lw_axi_master_arlen,   // Read burst length
    output wire [2:0]  hps_0_h2f_lw_axi_master_arsize,  // Read burst size
    output wire [1:0]  hps_0_h2f_lw_axi_master_arburst, // Read burst type
    output wire [1:0]  hps_0_h2f_lw_axi_master_arlock,  // Read lock
    output wire [3:0]  hps_0_h2f_lw_axi_master_arcache, // Read cache encoded
    output wire [2:0]  hps_0_h2f_lw_axi_master_arprot,  // Read protection
    output wire        hps_0_h2f_lw_axi_master_arvalid, // Read address valid
    input  wire        hps_0_h2f_lw_axi_master_arready, // Read address ready

    input  wire [11:0] hps_0_h2f_lw_axi_master_rid,     // Read data ID
    input  wire [31:0] hps_0_h2f_lw_axi_master_rdata,   // Read data
    input  wire [1:0]  hps_0_h2f_lw_axi_master_rresp,   // Read response
    input  wire        hps_0_h2f_lw_axi_master_rlast,   // Last read beat
    input  wire        hps_0_h2f_lw_axi_master_rvalid,  // Read data valid
    output wire        hps_0_h2f_lw_axi_master_rready,  // Read data ready

    //=========================================================================
    // HPS DDR3 Hard Memory Interface
    //=========================================================================
    output wire [14:0] memory_mem_a,                    // Address bus
    output wire [2:0]  memory_mem_ba,                   // Bank address
    output wire        memory_mem_ck,                   // Clock
    output wire        memory_mem_ck_n,                 // Clock (inverted)
    output wire        memory_mem_cke,                  // Clock enable
    output wire        memory_mem_cs_n,                 // Chip select
    output wire        memory_mem_ras_n,                // Row select
    output wire        memory_mem_cas_n,                // Column select
    output wire        memory_mem_we_n,                 // Write enable
    output wire        memory_mem_reset_n,              // Reset
    inout  wire [31:0] memory_mem_dq,                   // Data bus
    inout  wire [3:0]  memory_mem_dqs,                  // DQS strobe
    inout  wire [3:0]  memory_mem_dqs_n,                // DQS strobe inverted
    output wire        memory_mem_odt,                  // ODT
    output wire [3:0]  memory_mem_dm,                   // Data mask
    input  wire        memory_oct_rzqin                 // RZQ calibration reference
);

//==========================================================================
// Instantiate the HPS Hard Processor System block
//==========================================================================
// The HPS subsystem provides:
//   * DDR3 memory controller
//   * Lightweight AXI (full AXI) master into FPGA fabric
//   * Reset and clock generation
//   * All hard IP pad control
//==========================================================================

soc_system_hps_0 #(
    .F2S_Width (0),   // No FPGA?HPS signals (unused)
    .S2F_Width (0)    // No HPS?FPGA custom streaming (unused)
) hps_0 (
    // --- Hard DDR3 wiring ---
    .mem_a          (memory_mem_a),
    .mem_ba         (memory_mem_ba),
    .mem_ck         (memory_mem_ck),
    .mem_ck_n       (memory_mem_ck_n),
    .mem_cke        (memory_mem_cke),
    .mem_cs_n       (memory_mem_cs_n),
    .mem_ras_n      (memory_mem_ras_n),
    .mem_cas_n      (memory_mem_cas_n),
    .mem_we_n       (memory_mem_we_n),
    .mem_reset_n    (memory_mem_reset_n),
    .mem_dq         (memory_mem_dq),
    .mem_dqs        (memory_mem_dqs),
    .mem_dqs_n      (memory_mem_dqs_n),
    .mem_odt        (memory_mem_odt),
    .mem_dm         (memory_mem_dm),
    .oct_rzqin      (memory_oct_rzqin),

    // --- Reset routing to FPGA fabric ---
    .h2f_rst_n      (hps_0_h2f_reset_reset_n),

    // --- HPS-generated AXI clock ---
    .h2f_lw_axi_clk (clk_clk),

    // --- AXI Master Interface (Full AXI) ---
    // Write Address
    .h2f_lw_AWID    (hps_0_h2f_lw_axi_master_awid),
    .h2f_lw_AWADDR  (hps_0_h2f_lw_axi_master_awaddr),
    .h2f_lw_AWLEN   (hps_0_h2f_lw_axi_master_awlen),
    .h2f_lw_AWSIZE  (hps_0_h2f_lw_axi_master_awsize),
    .h2f_lw_AWBURST (hps_0_h2f_lw_axi_master_awburst),
    .h2f_lw_AWLOCK  (hps_0_h2f_lw_axi_master_awlock),
    .h2f_lw_AWCACHE (hps_0_h2f_lw_axi_master_awcache),
    .h2f_lw_AWPROT  (hps_0_h2f_lw_axi_master_awprot),
    .h2f_lw_AWVALID (hps_0_h2f_lw_axi_master_awvalid),
    .h2f_lw_AWREADY (hps_0_h2f_lw_axi_master_awready),

    // Write Data
    .h2f_lw_WID     (hps_0_h2f_lw_axi_master_wid),
    .h2f_lw_WDATA   (hps_0_h2f_lw_axi_master_wdata),
    .h2f_lw_WSTRB   (hps_0_h2f_lw_axi_master_wstrb),
    .h2f_lw_WLAST   (hps_0_h2f_lw_axi_master_wlast),
    .h2f_lw_WVALID  (hps_0_h2f_lw_axi_master_wvalid),
    .h2f_lw_WREADY  (hps_0_h2f_lw_axi_master_wready),

    // Write Response
    .h2f_lw_BID     (hps_0_h2f_lw_axi_master_bid),
    .h2f_lw_BRESP   (hps_0_h2f_lw_axi_master_bresp),
    .h2f_lw