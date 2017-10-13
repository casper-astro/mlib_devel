module xaui_infrastructure #(
  ) 
(
  // Global signals
  input   reset,
  output  xaui_clk,

  // FPGA Pins 
  // GTX Transceivers Ports
  input   mgt_rx_n0,
  input   mgt_rx_p0,
  output  mgt_tx_n0,
  output  mgt_tx_p0,

  input   mgt_rx_n1,
  input   mgt_rx_p1,
  output  mgt_tx_n1,
  output  mgt_tx_p1,

  input   mgt_rx_n2,
  input   mgt_rx_p2,
  output  mgt_tx_n2,
  output  mgt_tx_p2,

  input   mgt_rx_n3,
  input   mgt_rx_p3,
  output  mgt_tx_n3,
  output  mgt_tx_p3,

  input   mgt_ref_clk_n, 
  input   mgt_ref_clk_p,

  // 
  input   loss_of_signal_sfp0,
  input   tx_fault_sfp0,
  output  tx_disable_sfp0,

  input   loss_of_signal_sfp1,
  input   tx_fault_sfp1,
  output  tx_disable_sfp1,

  input   loss_of_signal_sfp2,
  input   tx_fault_sfp2,
  output  tx_disable_sfp2,

  input   loss_of_signal_sfp3,
  input   tx_fault_sfp3,
  output  tx_disable_sfp3,

  ////// New 10G PCS PMA core signals over BUS = XAUI_SYS
  output REF_CLK_IN0,
  output REF_CLK_IN_BUFH0,
  output GT0_QPLLLOCK0,
  output GT0_QPLLOUTCLK0,
  output GT0_QPLLOUTREFCLK0,
  output clk156_0,
  output dclk0,
  output mmcm_locked0,

  input txp0,
  input txn0,
  output rxp0,
  output rxn0,  
  output signal_detect0,
  output tx_fault0,     
  input tx_disable0,  
  input xaui_clk_out0, 
  input [7:0] phy_stat0,

  output REF_CLK_IN1,
  output REF_CLK_IN_BUFH1,
  output GT0_QPLLLOCK1,
  output GT0_QPLLOUTCLK1,
  output GT0_QPLLOUTREFCLK1,
  output clk156_1,
  output dclk1,
  output mmcm_locked1,
  input txp1,
  input txn1,
  output rxp1,
  output rxn1,  
  output signal_detect1,
  output tx_fault1,     
  input tx_disable1,  
  input xaui_clk_out1, 
  input [7:0] phy_stat1,
  ////// New 10G PCS PMA core signals over BUS = XAUI_SYS


  ////// New 10G PCS PMA core signals over BUS = XAUI_SYS
  output REF_CLK_IN2,
  output REF_CLK_IN_BUFH2,
  output GT0_QPLLLOCK2,
  output GT0_QPLLOUTCLK2,
  output GT0_QPLLOUTREFCLK2,
  output clk156_2,
  output dclk2,
  output mmcm_locked2,
  input txp2,
  input txn2,
  output rxp2,
  output rxn2,  
  output signal_detect2,
  output tx_fault2,     
  input tx_disable2,  
  input xaui_clk_out2, 
  input [7:0] phy_stat2,
  ////// New 10G PCS PMA core signals over BUS = XAUI_SYS

  ////// New 10G PCS PMA core signals over BUS = XAUI_SYS
  output REF_CLK_IN3,
  output REF_CLK_IN_BUFH3,
  output GT0_QPLLLOCK3,
  output GT0_QPLLOUTCLK3,
  output GT0_QPLLOUTREFCLK3,
  output clk156_3,
  output dclk3,
  output mmcm_locked3,
  input txp3,
  input txn3,
  output rxp3,
  output rxn3,  
  output signal_detect3,
  output tx_fault3,     
  input tx_disable3,  
  input xaui_clk_out3, 
  input [7:0] phy_stat3,
  ////// New 10G PCS PMA core signals over BUS = XAUI_SYS

  output [7:0] stat,

  /////  Not used any more!
  input   [5-1:0] mgt_txpostemphasis4,
  input   [4-1:0] mgt_txpreemphasis4,  
  input   [4-1:0] mgt_txdiffctrl4,     
  input   [3-1:0] mgt_rxeqmix4, 

  input   [5-1:0] mgt_txpostemphasis5, 
  input   [4-1:0] mgt_txpreemphasis5,  
  input   [4-1:0] mgt_txdiffctrl5,     
  input   [3-1:0] mgt_rxeqmix5, 

  input   [5-1:0] mgt_txpostemphasis6, 
  input   [4-1:0] mgt_txpreemphasis6,  
  input   [4-1:0] mgt_txdiffctrl6,     
  input   [3-1:0] mgt_rxeqmix6, 

  input   [5-1:0] mgt_txpostemphasis7, 
  input   [4-1:0] mgt_txpreemphasis7,  
  input   [4-1:0] mgt_txdiffctrl7,     
  input   [3-1:0] mgt_rxeqmix7       


  );

    //-------------------------  Static signal Assigments ---------------------   

    wire tied_to_ground_i             = 1'b0;
    wire [63:0] tied_to_ground_vec_i  = 64'h0000000000000000;
    wire tied_to_vcc_i                = 1'b1;
    wire [63:0] tied_to_vcc_vec_i     = 64'hffffffffffffffff;

  wire xaui_clk_ref_clk;
   
  // This is the clock buffer for all the PHY's GTE's for the bank. 4 MGT's are using the same 156.25MHz external reference oscillator.
  // IBUFDS_GTE2
  IBUFDS_GTE2 #(
    .CLKSWING_CFG("11")
  ) ibufds_instq1_clk0_inst (
    .O(xaui_clk_ref_clk),  // 156.25MHz external reference oscillator output for 10G ETH PCS/PMA Xilinx Core
    .ODIV2(),
    .CEB(1'b0),
    .I(mgt_ref_clk_p),  // 156.25MHz external reference oscillator LVDS P 
    .IB(mgt_ref_clk_n)  // 156.25MHz external reference oscillator LVDS N
  );

  //_________________________________________________________________________
  //_________________________GTXE2_COMMON____________________________________
  //_________________________________________________________________________

  //BUFHCE bufh_inst 
  BUFG bufh_inst
  (
      //.CE                             (tied_to_vcc_i),
      .I                              (xaui_clk_ref_clk),   // xaui_clk_ref_clk = q1_clk0_refclk_i -> 156.25MHz Ref Clk Osc
      .O                              (q1_clk0_refclk_i_bufh) 
  );

  // Reset logic from the gtwizard top level output file....
  // Adapt the reset_counter to count clk156 ticks.
  // 128 ticks at 6.4ns period will be >> 500 ns.
  // Removed all 'after DLY' text.

  reg [7:0] reset_counter = 8'h00;
  reg [3:0] reset_pulse;

  wire areset = reset;

  always @(posedge q1_clk0_refclk_i_bufh or posedge areset)
  begin
    if (areset == 1'b1)
      reset_counter <= 8'b0;
    else if (!reset_counter[7])
      reset_counter   <=   reset_counter + 1'b1;   
    else
      reset_counter   <=   reset_counter;
  end

  always @(posedge q1_clk0_refclk_i_bufh)
  begin
    if(!reset_counter[7])
      reset_pulse   <=   4'b1110;
    else
      reset_pulse   <=   {1'b0, reset_pulse[3:1]};
  end

  assign   QPLLRESET_IN  =     reset_pulse[0];

//***************************** Parameter Declarations ************************
    parameter QPLL_FBDIV_TOP =  66;
    parameter SIM_VERSION    =  "4.0";
    parameter WRAPPER_SIM_GTRESET_SPEEDUP = "false";    // Set to "true" to speed up sim reset

    parameter QPLL_FBDIV_IN  =  (QPLL_FBDIV_TOP == 16)  ? 10'b0000100000 : 
        (QPLL_FBDIV_TOP == 20)  ? 10'b0000110000 :
        (QPLL_FBDIV_TOP == 32)  ? 10'b0001100000 :
        (QPLL_FBDIV_TOP == 40)  ? 10'b0010000000 :
        (QPLL_FBDIV_TOP == 64)  ? 10'b0011100000 :
        (QPLL_FBDIV_TOP == 66)  ? 10'b0101000000 :
        (QPLL_FBDIV_TOP == 80)  ? 10'b0100100000 :
        (QPLL_FBDIV_TOP == 100) ? 10'b0101110000 : 10'b0000000000;

   parameter QPLL_FBDIV_RATIO = (QPLL_FBDIV_TOP == 16)  ? 1'b1 : 
        (QPLL_FBDIV_TOP == 20)  ? 1'b1 :
        (QPLL_FBDIV_TOP == 32)  ? 1'b1 :
        (QPLL_FBDIV_TOP == 40)  ? 1'b1 :
        (QPLL_FBDIV_TOP == 64)  ? 1'b1 :
        (QPLL_FBDIV_TOP == 66)  ? 1'b0 :
        (QPLL_FBDIV_TOP == 80)  ? 1'b1 :
        (QPLL_FBDIV_TOP == 100) ? 1'b1 : 1'b1;

  wire GT0_QPLLLOCK_OUT_i;
  wire GT0_QPLLOUTCLK_i; 

  GTXE2_COMMON #
  (
          // Simulation attributes
          .SIM_RESET_SPEEDUP   (WRAPPER_SIM_GTRESET_SPEEDUP),
          .SIM_QPLLREFCLK_SEL  (3'b001),
          .SIM_VERSION         (SIM_VERSION),


         //----------------COMMON BLOCK Attributes---------------
          .BIAS_CFG                               (64'h0000040000001000),
          .COMMON_CFG                             (32'h00000000),
          .QPLL_CFG                               (27'h0680181),
          .QPLL_CLKOUT_CFG                        (4'b0000),
          .QPLL_COARSE_FREQ_OVRD                  (6'b010000),
          .QPLL_COARSE_FREQ_OVRD_EN               (1'b0),
          .QPLL_CP                                (10'b0000011111),
          .QPLL_CP_MONITOR_EN                     (1'b0),
          .QPLL_DMONITOR_SEL                      (1'b0),
          .QPLL_FBDIV                             (QPLL_FBDIV_IN),
          .QPLL_FBDIV_MONITOR_EN                  (1'b0),
          .QPLL_FBDIV_RATIO                       (QPLL_FBDIV_RATIO),
          .QPLL_INIT_CFG                          (24'h000006),
          .QPLL_LOCK_CFG                          (16'h21E8),
          .QPLL_LPF                               (4'b1111),
          .QPLL_REFCLK_DIV                        (1)

  )
  gtxe2_common_0_i
  (
      //----------- Common Block  - Dynamic Reconfiguration Port (DRP) -----------
      .DRPADDR                        (tied_to_ground_vec_i[7:0]),
      .DRPCLK                         (tied_to_ground_i),
      .DRPDI                          (tied_to_ground_vec_i[15:0]),
      .DRPDO                          (),
      .DRPEN                          (tied_to_ground_i),
      .DRPRDY                         (),
      .DRPWE                          (tied_to_ground_i),
      //-------------------- Common Block  - Ref Clock Ports ---------------------
      .GTGREFCLK                      (tied_to_ground_i),
      .GTNORTHREFCLK0                 (tied_to_ground_i),
      .GTNORTHREFCLK1                 (tied_to_ground_i),
      .GTREFCLK0                      (xaui_clk_ref_clk), // 156.25 MHz MGT Ref Osc
      .GTREFCLK1                      (tied_to_ground_i),
      .GTSOUTHREFCLK0                 (tied_to_ground_i),
      .GTSOUTHREFCLK1                 (tied_to_ground_i),
      //----------------------- Common Block - QPLL Ports ------------------------
      .QPLLDMONITOR                   (),
      .QPLLFBCLKLOST                  (),
      .QPLLLOCK                       (GT0_QPLLLOCK_OUT_i),
      .QPLLLOCKDETCLK                 (tied_to_ground_i),
      .QPLLLOCKEN                     (tied_to_vcc_i),
      .QPLLOUTCLK                     (GT0_QPLLOUTCLK_i),
      .QPLLOUTREFCLK                  (gt0_qplloutrefclk_i),
      .QPLLOUTRESET                   (tied_to_ground_i),
      .QPLLPD                         (tied_to_ground_i),
      .QPLLREFCLKLOST                 (),
      .QPLLREFCLKSEL                  (3'b001),
      .QPLLRESET                      (reset_pulse[0]),
      .QPLLRSVD1                      (16'b0000000000000000),
      .QPLLRSVD2                      (5'b11111),
      .REFCLKOUTMONITOR               (),
      //--------------------------- Common Block Ports ---------------------------
      .BGBYPASSB                      (tied_to_vcc_i),
      .BGMONITORENB                   (tied_to_vcc_i),
      .BGPDB                          (tied_to_vcc_i),
      .BGRCALOVRD                     (5'b00000),
      .PMARSVD                        (8'b00000000),
      .RCALENB                        (tied_to_vcc_i)

  );
  //_________________________________________________________________________
  //_________________________GTXE2_COMMON____________________________________
  //_________________________________________________________________________


  //_________________________________________________________________________
  //_________________________Common MMCM-____________________________________
  //_________________________________________________________________________
  wire clkfbout;
  wire gt0_qplllock_i = GT0_QPLLLOCK_OUT_i; 

  // MMCM to generate both clk156 and dclk
  MMCME2_BASE #
  (
    .BANDWIDTH            ("OPTIMIZED"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (4.0),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE_F     (4.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (6.400),
    .CLKOUT1_DIVIDE       (8),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .REF_JITTER1          (0.010)
  )
  clkgen_i
  (
    .CLKFBIN(clkfbout),
    .CLKIN1(q1_clk0_refclk_i_bufh),
    .PWRDWN(1'b0),
    .RST(!gt0_qplllock_i),
    .CLKFBOUT(clkfbout),
    .CLKOUT0(clk156_buf),
    .CLKOUT1(dclk_buf),
    .LOCKED(mmcm_locked)
  );

  BUFG clk156_bufg_inst 
  (
      .I                              (clk156_buf),
      .O                              (clk156) 
  );

  BUFG dclk_bufg_inst 
  (
      .I                              (dclk_buf),
      .O                              (dclk) 
  ); 
  //_________________________________________________________________________
  //_________________________Common MMCM_____________________________________
  //_________________________________________________________________________


//_____________________________________________________________________________________
//___________________ROUTE COMMON SIGNALS to "XAUI_PHY" (10G ETH PCS/PMA Xilinx Core __
//_____________________________________________________________________________________

// Route MMCM clk156 to each 10G ETH PCS/PMA Xilinx Core
  assign clk156_3 = clk156;
  assign clk156_2 = clk156;
  assign clk156_1 = clk156;
  assign clk156_0 = clk156;

// Route MMCM dclk to each 10G ETH PCS/PMA Xilinx Core
  assign dclk3 = dclk;
  assign dclk2 = dclk;
  assign dclk1 = dclk;
  assign dclk0 = dclk;

// Route MMCM Lock Signal to each 10G ETH PCS/PMA Xilinx Core
  assign mmcm_locked3 = mmcm_locked;
  assign mmcm_locked2 = mmcm_locked;
  assign mmcm_locked1 = mmcm_locked;
  assign mmcm_locked0 = mmcm_locked;

// Route GTXE2_COMMON Lock Signal to each 10G ETH PCS/PMA Xilinx Core
  assign GT0_QPLLLOCK3 = GT0_QPLLLOCK_OUT_i;
  assign GT0_QPLLLOCK2 = GT0_QPLLLOCK_OUT_i;
  assign GT0_QPLLLOCK1 = GT0_QPLLLOCK_OUT_i;
  assign GT0_QPLLLOCK0 = GT0_QPLLLOCK_OUT_i;

// Route GTXE2_COMMON QPLL Clock Signal to each 10G ETH PCS/PMA Xilinx Core
  assign GT0_QPLLOUTCLK3 = GT0_QPLLOUTCLK_i;
  assign GT0_QPLLOUTCLK2 = GT0_QPLLOUTCLK_i;
  assign GT0_QPLLOUTCLK1 = GT0_QPLLOUTCLK_i;
  assign GT0_QPLLOUTCLK0 = GT0_QPLLOUTCLK_i;

// Route GTXE2_COMMON QPLL Ref Clock Signal to each 10G ETH PCS/PMA Xilinx Core
  assign GT0_QPLLOUTREFCLK3 = gt0_qplloutrefclk_i;
  assign GT0_QPLLOUTREFCLK2 = gt0_qplloutrefclk_i;
  assign GT0_QPLLOUTREFCLK1 = gt0_qplloutrefclk_i;
  assign GT0_QPLLOUTREFCLK0 = gt0_qplloutrefclk_i;

// Route 156.25MHz external reference oscillator routed to each 10G ETH PCS/PMA Xilinx Core
  assign REF_CLK_IN3 = xaui_clk_ref_clk;
  assign REF_CLK_IN2 = xaui_clk_ref_clk;
  assign REF_CLK_IN1 = xaui_clk_ref_clk;
  assign REF_CLK_IN0 = xaui_clk_ref_clk;

// Route 156.25MHz external reference oscillator routed to each 10G ETH PCS/PMA Xilinx Core
  assign REF_CLK_IN_BUFH3 = q1_clk0_refclk_i_bufh;
  assign REF_CLK_IN_BUFH2 = q1_clk0_refclk_i_bufh;
  assign REF_CLK_IN_BUFH1 = q1_clk0_refclk_i_bufh;
  assign REF_CLK_IN_BUFH0 = q1_clk0_refclk_i_bufh;

// This is the 156.25MHz XGMII (for 10G ETH MAC XGMII data interface) clock generated by the 10G ETH PCS/PMA Xilinx Core from the external reference oscillator
  wire xaui_clk_i = xaui_clk_out0;
  assign xaui_clk = xaui_clk_i;

// These signals are routed to the SFP+ cages, data to/from 10G ETH PCS/PMA Xilinx Core
  assign mgt_tx_p0 = txp0;
  assign mgt_tx_n0 = txn0;
  assign mgt_tx_p1 = txp1;
  assign mgt_tx_n1 = txn1;
  assign mgt_tx_p2 = txp2;
  assign mgt_tx_n2 = txn2;
  assign mgt_tx_p3 = txp3;
  assign mgt_tx_n3 = txn3;

  assign rxp0 = mgt_rx_p0;
  assign rxn0 = mgt_rx_n0;
  assign rxp1 = mgt_rx_p1;
  assign rxn1 = mgt_rx_n1;
  assign rxp2 = mgt_rx_p2;
  assign rxn2 = mgt_rx_n2;
  assign rxp3 = mgt_rx_p3;
  assign rxn3 = mgt_rx_n3;


// These signals are routed to the SFP+ cages, controlled and monitor from 10G ETH PCS/PMA Xilinx Core
  assign signal_detect3 = ~loss_of_signal_sfp3;
  assign signal_detect2 = ~loss_of_signal_sfp2;
  assign signal_detect1 = ~loss_of_signal_sfp1;
  assign signal_detect0 = ~loss_of_signal_sfp0;

  assign tx_fault3 = tx_fault_sfp3;
  assign tx_fault2 = tx_fault_sfp2;
  assign tx_fault1 = tx_fault_sfp1;
  assign tx_fault0 = tx_fault_sfp0;

  assign tx_disable_sfp3 = tx_disable3;
  assign tx_disable_sfp2 = tx_disable2;
  assign tx_disable_sfp1 = tx_disable1;
  assign tx_disable_sfp0 = tx_disable0;
//_____________________________________________________________________________________
//___________________ROUTE COMMON SIGNALS to "XAUI_PHY" (10G ETH PCS/PMA Xilinx Core __
//_____________________________________________________________________________________


//_____________________________________________________________________________________
//___________________ROUTE COMMON SIGNALS to "XAUI_PHY" (10G ETH PCS/PMA Xilinx Core __
//_____________________________________________________________________________________

  // Status of 10G Cores
  reg [31:0] cnt;

  always @(posedge xaui_clk_i) begin
    if (reset) begin
      cnt<=32'b0;
    end else begin
      cnt<=cnt + 1'b1;
    end
  end

  assign stat[0] = signal_detect0;
  assign stat[1] = signal_detect1;
  assign stat[2] = signal_detect2;
  assign stat[3] = signal_detect3;
  assign stat[4] = phy_stat0[0];
  assign stat[5] = phy_stat1[0];
  assign stat[6] = phy_stat2[0];
  assign stat[7] = phy_stat3[0];

    // [7:6] BASE-KR Reserved,  
    // 5 Auto Negotiation link_up
    // 4 Auto Negotiation Enable
    // 3 Auto Negotiation Complete
    // 2 Training Done
    // 1 FEC OK
    // 0 PCS Block Lock

endmodule
