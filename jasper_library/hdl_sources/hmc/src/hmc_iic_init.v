// #########################################################################################################
// # Project: meerKAT (SKA-SA)
// # Module: hmc_iic_init
// # Coded by: Henno Kriel (henno@ska.ac.za)
// # Date: 19 Aug 2015
// #
// # Description
// #   This module connects to the HMC Cube IIC bus (SCL,SDA).
// #   The module will generate IIC bus cycles in accordance with the HMC spec.
// #   HMC IIC initialization instructions (found in HMC Register Addendum & HMC spec)
// #   are constructed in the module and then fed byte for byte to the 
// #   DIGI-KEY I2C master core (i2c_master.vhd). 
// #   Once all the initialization instructions are successfully sent, 
// #   the module will assert HMC_IIC_INIT_DONE
// ##########################################################################################################

module hmc_iic_init #(
    parameter CLK_FREQ = 156_000_000,   // System clock speed [Hz]
    parameter IIC_FREQ = 10_000,        // IIC clock speed [Hz] 
    parameter HMC_CUBE_IIC_ADDR = 8'h10, // HMC Cube IIC Address
    parameter IO_EXP_IIC_ADDR = 8'h20
  )  (
    input  CLK,  // System clock
    input  RST,  // System reset
    output IIC_ACK_ERR,  // Signal to indicate that the last IIC bus cycle did not complete properly   
    output IIC_BUSY,     // Signal to indicate that this module is hogging the IIC bus
    output HMC_IIC_INIT_DONE, // All the requested HMC IIC initialization commands have been sent successfully => HMC IIC init done 
    output HMC_RESET,
    input  TX_PHY_RESET_DONE, // Flag to indicate when the GTH TX PHY is ready
    input  RX_PHY_RESET_DONE, // Flag to indicate when the GTH RX PHY is ready
    output TX_PHY_RESET, // Flag to reset the GTH TX PHY    
    output RX_PHY_RESET, //Flag to reset the GTH RX PHY    
    input  HMC_POST_DONE,
    output POST_DONE_LATCH,
    // IIC BUS to HMC
    //inout   SDA, // IIC Data
    //inout   SCL  // IIC Clock 
    output SDA_OUT,
    output SCL_OUT,
    input SCL_IN,
    input SDA_IN
  );

  // internal signals
  wire [7:0] iic_read_data;
  reg [7:0] iic_data,iic_addr;
  reg [7:0] phy_state;
  reg iic_cmd;
  reg [63:0] wr_data_shift;
  reg [7:0] iic_num_bytes_i;
  reg [7:0] iic_inst_cnt_i;
  reg op_iic_busy;
  reg [31:0] init_time, init_done_time, init_done_time_set, init_time_set;

  // state machine state vector
  localparam STATE_IDLE        = 4'd0;
  localparam STATE_IIC_ADDR    = 4'd1;
  localparam STATE_IIC_WAIT    = 4'd2;
  localparam STATE_IIC_DATA    = 4'd3;
  localparam STATE_DONE        = 4'd5;

// ******************************************************************************************************************************************************************************************
// HMC IO Expander initialization commands
// ******************************************************************************************************************************************************************************************
// P0 - No Connect
// P1 - No Connect
// P2 - No Connect
// P3 - Output: L2_RX_PS_3V3 HMC Link 2 Power Down (0 = Power Down, 1 = UP)
// P4 - Input:  FERR_N_A_3V3 (HMC Cube Error)
// P5 - Output: L3_RX_PS_3V3 HMC Link 3 Power Down (0 = Power Down, 1 = UP)
// P6 - Output: POST_LED (0 = POST DONE)
// P7 - No Connect

// Table 2. Address Reference
// INPUTS
// 
// I2C BUS SLAVE ADDRESS
// A2 A1 A0
// L L L 32 (decimal), 20 (hexadecimal)  Mezz 0
// L L H 33 (decimal), 21 (hexadecimal)  Mezz 1
// L H L 34 (decimal), 22 (hexadecimal)  Mezz 2
// L H H 35 (decimal), 23 (hexadecimal)  Mezz 3
// 

localparam IIC_IO_EXPANDER_OUTPUT = 16'h01_FF; //Output Port Register 0x01, Set all ports to '1' (0xff)
localparam IIC_IO_EXPANDER_CONFIG = 16'b000_0011_1001_0111; //Port Configuration Register 0x03, Set Port (1 => Input, 0 => Output)

// ******************************************************************************************************************************************************************************************
// HMC IIC initialization commands
// ******************************************************************************************************************************************************************************************

  // Specify the register address
  // Specify the register data
  // The current setup is for 10G, Half Width, Link2 & Link3
  localparam GLOBAL_CONF_REG_ADDR = 32'h00280000;
  localparam GLOBAL_CONF_REG_DATA = 32'h00000040;  // issue warm reset

  localparam ADDR_CONF_REG_ADDR = 32'h002c0000;  // Address Configuration Register
  localparam ADDR_CONF_REG_DATA = 32'h00000000;  // [3:0] == 0 => 32-byte block size (MAX). 
                                                 // [3:0] == 1 => 64-byte block size (MAX). 
                                                 // [3:0] == 2 => 128-byte block size (MAX). 
                                                 // Low-interleave address mapping with the byte address set as the lowest five 
                                                 // bits of the ADRS field in the request header, along with the default vault and bank mapping. 

  localparam LINK_RUN_LENGTH_L2_ADDR = 32'h00260003;
  localparam LINK_RUN_LENGTH_L2_DATA = 32'h003c0000; // Set run length limit to 60
  localparam LINK_RUN_LENGTH_L3_ADDR = 32'h00270003;
  localparam LINK_RUN_LENGTH_L3_DATA = 32'h003c0000; // Set run length limit to 60

  localparam LINK_RETRY_L2_ADDR = 32'h000E0000;
  //localparam LINK_RETRY_L2_DATA = {8'd0,8'd16,2'd0,6'd6,1'b0,3'd5,3'd3,1'b1}; 
  localparam LINK_RETRY_L2_DATA = {8'd0,8'd16,2'd0,6'd6,1'b0,3'd5,3'd7,1'b1}; 
  localparam LINK_RETRY_L3_ADDR = 32'h000F0000;
  //localparam LINK_RETRY_L3_DATA = {8'd0,8'd16,2'd0,6'd6,1'b0,3'd5,3'd3,1'b1}; 
  localparam LINK_RETRY_L3_DATA = {8'd0,8'd16,2'd0,6'd6,1'b0,3'd5,3'd7,1'b1}; 

  // [0]: Retry status
  //   0x0: Retry is disabled, 0x1: Retry is enabled
  // [3:1] Retry limit 
  //   Controls the number of consecutive retry attempts for which there is no resulting progress (i.e., local error abort never clears or received RRP does not advance despite un- 
  //   retired packets in the local retry buffer). Once this limit has been met, an error response packet is sent with link error in the ERRSTAT field to notify the host that the re- 
  //   try attempt limit has been met. If retry limit = 0, there is no limit on the number of retries that can occur with no resulting progress.
  // [6:4] Retry timeout period 
  //   0x0: 154ns 
  //   0x1: 205ns 
  //   0x2: 307ns 
  //   0x3: 384ns 
  //   0x4: 614ns 
  //   0x5: 820ns 
  //   0x6: 1229ns 
  //   0x7: 1637ns 
  // [7]: Reserved 
  // [13:8]: Init retry packet transmit number 
  //   0x2 - 0x3F: The number of IRTRY packets transmitted from link master during LinkRetry_Init is approximately four times the number specified in this field
  // [15:14] Reserved
  // [21:16] Init retry packet receive number
  //   The number of IRTRY packets that the link slave will detect before it clears the error abort mode
  // [31:22] Reserved

//  localparam INPUT_BUFFER_TOKEN_COUNT_L2_ADDR = 32'h00060000;
//  localparam INPUT_BUFFER_TOKEN_COUNT_L2_DATA = {24'd0,8'd199}; //  Value represents the buffer space available in the link input buffer when it is empty; maximum token count is 230. 
//                                                                //  In Rev 1.0 Errata ES devices, it is recommended that the token count be configured as less than 200 tokens (0xC8).
//  localparam INPUT_BUFFER_TOKEN_COUNT_L3_ADDR = 32'h00070000;
//  localparam INPUT_BUFFER_TOKEN_COUNT_L3_DATA = {24'd0,8'd199}; //  Value represents the buffer space available in the link input buffer when it is empty; maximum token count is 230. 
                                                                //  In Rev 1.0 Errata ES devices, it is recommended that the token count be configured as less than 200 tokens (0xC8).

// Juri advised 219 Tokens
  localparam INPUT_BUFFER_TOKEN_COUNT_L2_ADDR = 32'h00060000;
  localparam INPUT_BUFFER_TOKEN_COUNT_L2_DATA = {24'd0,8'd219}; //  Value represents the buffer space available in the link input buffer when it is empty; maximum token count is 230. 
                                                                //  In Rev 1.0 Errata ES devices, it is recommended that the token count be configured as less than 200 tokens (0xC8).
  localparam INPUT_BUFFER_TOKEN_COUNT_L3_ADDR = 32'h00070000;
  localparam INPUT_BUFFER_TOKEN_COUNT_L3_DATA = {24'd0,8'd219}; //  Value represents the buffer space available in the link input buffer when it is empty; maximum token count is 230. 
                                                                //  In Rev 1.0 Errata ES devices, it is recommended that the token count be configured as less than 200 tokens (0xC8).

  localparam LINK_CONFIG_L2_ADDR = 32'h00260000;
  //localparam LINK_CONFIG_L2_DATA = {20'd0, 1'd1,1'd1,1'd1,1'd1, 1'd1,1'd1,1'd1,1'd1, 1'd1,1'd0,2'd1}; 
  localparam LINK_CONFIG_L2_DATA = {20'd0, 1'd1,1'd1,1'd1,1'd0, 1'd1,1'd1,1'd1,1'd1, 1'd1,1'd0,2'd1}; 

  localparam LINK_CONFIG_L3_ADDR = 32'h00270000;
  //localparam LINK_CONFIG_L3_DATA = {20'd0, 1'd1,1'd1,1'd1,1'd1, 1'd1,1'd1,1'd1,1'd1, 1'd1,1'd0,2'd1};
  localparam LINK_CONFIG_L3_DATA = {20'd0, 1'd1,1'd1,1'd1,1'd0, 1'd1,1'd1,1'd1,1'd1, 1'd1,1'd0,2'd1};
  
  // [1:0] Link mode 
  //   0x0: Link is not used 
  //   0x1: Link is a host link and a source link 
  //   0x2: Link is a host link and not a source link 
  //   0x3: Link is a pass-through link 
  // [2] Link response open loop mode 
  //   0x0: Response open loop mode is off 
  //   0x1: Response open loop mode is on 
  // [3] Link packet sequence detection 
  //   0x0: Packet sequence detection is off 
  //   0x1: Packet sequence detection is on 
  // [4] Link CRC detection 
  //   0x0: Link CRC error detection is off 
  //   0x1: Link CRC error detection is on 
  // [5] Link duplicate length detection 
  //   0x0: DLN detection is off 
  //   0x1: DLN detection is on 
  // [6] Packet input enable
  //   0x0: Decode and parsing of incoming packets is disabled 
  //   0x1: Decode and parsing of incoming packets is enabled 
  // [7] Packet output enable 
  //   0x0: Transmission of outgoing packets is disabled 
  //   0x1: Transmission of outgoing packets is enabled 
  // [8] Inhibit link down mode 
  //   When set to 1, the HSS PLLs will remain on regardless of the state of LxRXPS signals (applies only to links not reset in power-down mode) 
  // [9] Link descramble enable
  //   0x0: Receiver descramblers are disabled 
  //   0x1: Transmit scramblers are enabled 
  // [10] Link scramble enable 
  //   0x0: Transmit scramblers are disabled 
  //   0x1: Receiver descramblers are enabled 
  // [11] Error response packet 
  //   When set to 1, the HMC will send error response packets on this link
  // [31:12] Reserved

  localparam ERIDATA0_L2_ADDR = 32'h002B0002;//32'h002B01E2;
  localparam ERIDATA0_L2_DATA = 32'h10010000; // [31] = 0 => No Loop Back, [29:27] = 2 => PRBS15+, [17:16] = 1 => Half-width, [1:0] = 0 => 10Gb/s
  
  localparam ERIDATA0_L3_ADDR = 32'h002B0003;//32'h002B01E3;
  localparam ERIDATA0_L3_DATA = 32'h10010000; // [31] = 0 => No Loop Back, [29:27] = 2 => PRBS15+, [17:16] = 1 => Half-width, [1:0] = 0 => 10Gb/s
  
  localparam ERIREQ_LINK_SETUP_ADDR = 32'h002B0004; //32'h002B01E4;
  localparam ERIREQ_LINK_SETUP_DATA = 32'h813F0005;
  //AI: INIT_CONTINUE_DELAY (normally between 220ms - 2200ms), so added 3.4s to make sure
  //localparam ERIREQ_INIT_CONTINUE_DELAY_ADDR = 32'h002B0000; 
  //localparam ERIREQ_INIT_CONTINUE_DELAY_DATA = 32'h00008000; // 3.4s Increase time out delay (value here gets multiplied by 104us to give additional time) 
  
  localparam ERIREQ_INIT_CONTINUE_ADDR = 32'h002B0004; //32'h002B01E4;
  localparam ERIREQ_INIT_CONTINUE_DATA = 32'h800000FF; // Issue HMC init continue!! 
  
  //PRBS Verification needs to be run a few times to ensure the results are accurate
  //localparam ERIREQ_PRBS_VERIFICATION_1_ADDR = 32'h002B0004; //32'h002B01E4;
  //localparam ERIREQ_PRBS_VERIFICATION_1_DATA = 32'h80000025; // PRBS Verification!! 

  //localparam ERIREQ_PRBS_VERIFICATION_2_ADDR = 32'h002B0004; //32'h002B01E4;
  //localparam ERIREQ_PRBS_VERIFICATION_2_DATA = 32'h80000025; // PRBS Verification!! 

  //localparam ERIREQ_PRBS_VERIFICATION_3_ADDR = 32'h002B0004; //32'h002B01E4;
  //localparam ERIREQ_PRBS_VERIFICATION_3_DATA = 32'h80000025; // PRBS Verification!! 
  

// ******************************************************************************************************************************************************************************************


// ******************************************************************************************************************************************************************************************
// HMC IIC initialization command seqence
// ******************************************************************************************************************************************************************************************

  // Command sequence to be executed
  localparam IIC_IO_EXPANDER_SETUP1 = 8'd0;
  localparam IIC_IO_EXPANDER_SETUP2 = 8'd1;
  localparam IIC_IO_EXPANDER_SETUP3 = 8'd2;
  localparam IIC_IO_EXPANDER_SETUP4 = 8'd3;
  localparam IIC_IO_EXPANDER_SETUP5 = 8'd4;
  localparam IIC_IO_EXPANDER_SETUP6 = 8'd5;
  localparam IIC_IO_EXPANDER_SETUP7 = 8'd6;
  localparam IIC_IO_EXPANDER_SETUP8 = 8'd7;
  localparam IIC_IO_EXPANDER_SETUP9 = 8'd8;

  localparam HMC_CUBE_SETUP_OFFSET = IIC_IO_EXPANDER_SETUP9;

  localparam ADDR_CONF_REG = HMC_CUBE_SETUP_OFFSET + 8'd1;

  localparam LINK_RUN_LENGTH_L2 = HMC_CUBE_SETUP_OFFSET + 8'd2;
  localparam LINK_RUN_LENGTH_L3 = HMC_CUBE_SETUP_OFFSET + 8'd3;

  localparam LINK_RETRY_L2 = HMC_CUBE_SETUP_OFFSET + 8'd4;
  localparam LINK_RETRY_L3 = HMC_CUBE_SETUP_OFFSET + 8'd5;

  localparam INPUT_BUFFER_TOKEN_COUNT_L2 = HMC_CUBE_SETUP_OFFSET + 8'd6;
  localparam INPUT_BUFFER_TOKEN_COUNT_L3 = HMC_CUBE_SETUP_OFFSET + 8'd7;

  localparam LINK_CONFIG_L2 = HMC_CUBE_SETUP_OFFSET + 8'd8;
  localparam LINK_CONFIG_L3 = HMC_CUBE_SETUP_OFFSET + 8'd9;

  localparam ERIDATA0_L2 = HMC_CUBE_SETUP_OFFSET + 8'd10;
  localparam ERIDATA0_L3 = HMC_CUBE_SETUP_OFFSET + 8'd11;
  localparam ERIREQ_LINK_SETUP = HMC_CUBE_SETUP_OFFSET + 8'd12;
  //AI: Increase INIT CONTINUE time (data sheet min: 220ms - max: 1200ms)
  //localparam ERIREQ_INIT_CONTINUE_DELAY = HMC_CUBE_SETUP_OFFSET + 8'd13;
  localparam ERIREQ_INIT_CONTINUE = HMC_CUBE_SETUP_OFFSET + 8'd13;
  //AI: PRBS Verification 
  //localparam ERIREQ_PRBS_VERIFICATION_1 = HMC_CUBE_SETUP_OFFSET + 8'd15;
  //localparam ERIREQ_PRBS_VERIFICATION_2 = HMC_CUBE_SETUP_OFFSET + 8'd16;
  //localparam ERIREQ_PRBS_VERIFICATION_3 = HMC_CUBE_SETUP_OFFSET + 8'd17;
  
  //localparam ERIREQ_INIT_CONTINUE = HMC_CUBE_SETUP_OFFSET + 8'd13;

  // indicates the number of HMC IIC commands to send
  // localparam NUM_IIC_INST = ERIREQ_INIT_CONTINUE + 8'd1;
  localparam NUM_IIC_INST = ERIREQ_INIT_CONTINUE + 8'd1;
  
  localparam POST_DONE1 = NUM_IIC_INST + 8'd0;
  localparam POST_DONE2 = NUM_IIC_INST + 8'd1;
  localparam POST_DONE3 = NUM_IIC_INST + 8'd2;
  localparam POST_DONE4 = NUM_IIC_INST + 8'd3;
  localparam POST_DONE5 = NUM_IIC_INST + 8'd4;

// ******************************************************************************************************************************************************************************************

  // assert when all the commands have successfully been sent!
  reg hmc_iic_init_done_i, hmc_iic_done_start_timer_i;
  assign HMC_IIC_INIT_DONE = hmc_iic_init_done_i;

  reg hmc_reset;
  assign HMC_RESET = hmc_reset;
  
  reg tx_phy_reset;
  assign TX_PHY_RESET = tx_phy_reset;
  
  reg rx_phy_reset;
  assign RX_PHY_RESET = rx_phy_reset;

  reg [7:0] num_iic_inst;

  reg [1:0] hmc_post_doneR;
  reg post_done_latch,post_done_latchR;
  
  (* mark_debug = "true" *) wire dbg_hmc_iic_init_tx_phy_reset_done;
  (* mark_debug = "true" *) wire dbg_hmc_iic_init_rx_phy_reset_done;  
  (* mark_debug = "true" *) wire dbg_hmc_iic_init_tx_phy_reset;
  (* mark_debug = "true" *) wire dbg_hmc_iic_init_rx_phy_reset;
  (* mark_debug = "true" *) wire dbg_hmc_iic_init_hmc_iic_init_done_i;
  (* mark_debug = "true" *) wire dbg_hmc_iic_init_hmc_iic_done_start_timer_i;
  (* mark_debug = "true" *) wire [31:0] dbg_hmc_iic_init_init_done_time;
  
  assign dbg_hmc_iic_init_tx_phy_reset = tx_phy_reset;
  assign dbg_hmc_iic_init_rx_phy_reset = rx_phy_reset;
  assign dbg_hmc_iic_init_hmc_iic_init_done_i = hmc_iic_init_done_i;
  assign dbg_hmc_iic_init_hmc_iic_done_start_timer_i = hmc_iic_done_start_timer_i;
  assign dbg_hmc_iic_init_init_done_time = init_done_time; 
  assign dbg_hmc_iic_init_tx_phy_reset_done = TX_PHY_RESET_DONE; 
  assign dbg_hmc_iic_init_rx_phy_reset_done = RX_PHY_RESET_DONE;        
  
  
  
  (* mark_debug = "true" *) wire [63:0] data_rx_flit_cnt_link2,data_rx_flit_cnt_link3;
  (* mark_debug = "true" *) wire [63:0] data_rx_err_flit_cnt_link2,data_rx_err_flit_cnt_link3;
  wire data_err_detect_link2,data_err_detect_link3;

// ******************************************************************************************************************************************************************************************
// HMC IIC initialization state machine
// ******************************************************************************************************************************************************************************************

  // state machine to feed the HMC IIC monster
  always @(posedge CLK) begin

  if (RST) begin
    phy_state <= STATE_IDLE;
    wr_data_shift <= 64'd0; // each HMC IIC instruction is a 64bit IIC instruction (32b Addr, 32b Data), this will be broken up into bytes by shifting by 8bits at a time to the i2c_master.vhd
    op_iic_busy <= 1'b0; // keep track of the current IIC bus cycle
    iic_inst_cnt_i <= 8'h0; // keep track of the current HMC IIC instruction (essentially a sequence number)
    init_time <= 32'h0; // The HMC needs some time to wake up - this counter is used to ensure that we don't bom the HMC with IIC traffic while it is still half awake
    hmc_iic_init_done_i <= 1'b0; // keep track of when all the instructions were processed
    hmc_iic_done_start_timer_i <= 1'b0; //Keep track when init continue has been asserted
    init_time_set <= 32'd1;
    init_done_time <= 32'd0;
    init_done_time_set <= 32'd6250000; //40ms with 6.4ns clock period (much greater than the recommended 20ms)
    hmc_reset <= 1'b1;
    num_iic_inst <= NUM_IIC_INST;
    hmc_post_doneR <= 2'b00;
    post_done_latch <= 1'b0;
    post_done_latchR <= 1'b0;
    tx_phy_reset <= 1'b1;  //Reset TX PHY
    rx_phy_reset <= 1'b1;  //Reset RX PHY

  end else begin
      // HMC IIC init State machine 
      hmc_post_doneR <= {hmc_post_doneR[0],HMC_POST_DONE};
      post_done_latchR <= post_done_latch;
      //as soon as init done has been sent wait 20ms for valid data to be sent back from HMC device
      if (hmc_iic_done_start_timer_i == 1'b1) begin
         //HMC should be outputing data now
         if (init_done_time >= init_done_time_set) begin
            rx_phy_reset <= 1'b0;  //deassert Reset RX PHY
         end else begin
            init_done_time <= init_done_time + 1'b1; //increment counter   
         end
      end
      //Assert hmc_iic_init_done when GTH RX Phy is ready
      if (RX_PHY_RESET_DONE == 1'b1) begin
         hmc_iic_init_done_i <= 1'b1;
      end
          
      case (phy_state)
        STATE_IDLE: begin
          tx_phy_reset <= 1'b0;  //deassert TX PHY Reset as initialisation process starts
          iic_cmd <= 1'b0;
          op_iic_busy <= 1'b0;
          if (hmc_post_doneR == 2'b01) begin
            num_iic_inst <= num_iic_inst + 8'd5;            
          end
          if (init_time > init_time_set) begin  // wait for 0.5s for HMC to wake up (PLLs to lock etc) after reset            
            if (iic_inst_cnt_i < num_iic_inst) begin // check to see if we have sent all the requested HMC IIC instructions
              op_iic_busy <= 1'b1; // keep track of IIC bus cycle
              iic_num_bytes_i <= 8'h7; // keep track of the number of bytes shifted (decrementing)
              phy_state <= STATE_IIC_ADDR; // Next state send IIC address via i2c_master.vhd
              iic_addr <= HMC_CUBE_IIC_ADDR;  // Set the IIC address of the HMC Cube IIC address

              // Select and load wr_data_shift command shift register with HMC IIC init instruction, based on sequence counter 
              // wr_data_shift[63:32] is register address
              // wr_data_shift[31:0] is register data
              case (iic_inst_cnt_i) 

                // IO Expander Setup
                // Mezz 0
                IIC_IO_EXPANDER_SETUP1: begin wr_data_shift <= {IIC_IO_EXPANDER_CONFIG,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR; end
                // Mezz 0
                IIC_IO_EXPANDER_SETUP2: begin wr_data_shift <= {IIC_IO_EXPANDER_CONFIG,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR; end
                // Mezz 1
                IIC_IO_EXPANDER_SETUP3: begin wr_data_shift <= {IIC_IO_EXPANDER_CONFIG,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+1; end
                // Mezz 2
                IIC_IO_EXPANDER_SETUP4: begin wr_data_shift <= {IIC_IO_EXPANDER_CONFIG,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+2; end
                // mezz 3
                IIC_IO_EXPANDER_SETUP5: begin wr_data_shift <= {IIC_IO_EXPANDER_CONFIG,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+3; end

                // Mezz 0
                IIC_IO_EXPANDER_SETUP6: begin wr_data_shift <= {16'b000_0001_1111_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR; end
                // Mezz 1
                IIC_IO_EXPANDER_SETUP7: begin wr_data_shift <= {16'b000_0001_1111_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+1; end
                // Mezz 2
                IIC_IO_EXPANDER_SETUP8: begin wr_data_shift <= {16'b000_0001_1111_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+2; end
                // mezz 3
                IIC_IO_EXPANDER_SETUP9: begin wr_data_shift <= {16'b000_0001_1111_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+3; init_time_set <= 32'd78000000; hmc_reset <= 1'b0;end
                // HMC Cube Setup
                ADDR_CONF_REG: begin wr_data_shift <= {ADDR_CONF_REG_ADDR ,ADDR_CONF_REG_DATA}; end

                LINK_RUN_LENGTH_L2: begin wr_data_shift <= {LINK_RUN_LENGTH_L2_ADDR,LINK_RUN_LENGTH_L2_DATA}; end
                LINK_RUN_LENGTH_L3: begin wr_data_shift <= {LINK_RUN_LENGTH_L3_ADDR,LINK_RUN_LENGTH_L3_DATA}; end

                LINK_RETRY_L2: begin wr_data_shift <= {LINK_RETRY_L2_ADDR,LINK_RETRY_L2_DATA}; end
                LINK_RETRY_L3: begin wr_data_shift <= {LINK_RETRY_L3_ADDR,LINK_RETRY_L3_DATA}; end

                INPUT_BUFFER_TOKEN_COUNT_L2: begin wr_data_shift <= {INPUT_BUFFER_TOKEN_COUNT_L2_ADDR,INPUT_BUFFER_TOKEN_COUNT_L2_DATA}; end
                INPUT_BUFFER_TOKEN_COUNT_L3: begin wr_data_shift <= {INPUT_BUFFER_TOKEN_COUNT_L3_ADDR,INPUT_BUFFER_TOKEN_COUNT_L3_DATA}; end

                LINK_CONFIG_L2: begin wr_data_shift <= {LINK_CONFIG_L2_ADDR,LINK_CONFIG_L2_DATA}; end
                LINK_CONFIG_L3: begin wr_data_shift <= {LINK_CONFIG_L3_ADDR,LINK_CONFIG_L3_DATA}; end

                ERIDATA0_L2: begin wr_data_shift <= {ERIDATA0_L2_ADDR,ERIDATA0_L2_DATA}; end
                ERIDATA0_L3: begin wr_data_shift <= {ERIDATA0_L3_ADDR,ERIDATA0_L3_DATA}; end
                
                ERIREQ_LINK_SETUP: begin wr_data_shift <= {ERIREQ_LINK_SETUP_ADDR,ERIREQ_LINK_SETUP_DATA}; end
                //AI: Add INIT_CONTINUE Delay
                //ERIREQ_INIT_CONTINUE_DELAY: begin wr_data_shift <= {ERIREQ_INIT_CONTINUE_DELAY_ADDR,ERIREQ_INIT_CONTINUE_DELAY_DATA};end                
                ERIREQ_INIT_CONTINUE: begin wr_data_shift <= {ERIREQ_INIT_CONTINUE_ADDR,ERIREQ_INIT_CONTINUE_DATA};end
                
                //ERIREQ_PRBS_VERIFICATION_1: begin wr_data_shift <= {ERIREQ_PRBS_VERIFICATION_1_ADDR,ERIREQ_PRBS_VERIFICATION_1_DATA};end
                //ERIREQ_PRBS_VERIFICATION_2: begin wr_data_shift <= {ERIREQ_PRBS_VERIFICATION_2_ADDR,ERIREQ_PRBS_VERIFICATION_2_DATA};end
                //ERIREQ_PRBS_VERIFICATION_3: begin wr_data_shift <= {ERIREQ_PRBS_VERIFICATION_3_ADDR,ERIREQ_PRBS_VERIFICATION_3_DATA};end

                // Mezz 0
                POST_DONE1: begin wr_data_shift <= {16'b000_0001_1011_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR; end
                // Mezz 1
                POST_DONE2: begin wr_data_shift <= {16'b000_0001_1011_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+1; end
                // Mezz 2
                POST_DONE3: begin wr_data_shift <= {16'b000_0001_1011_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+2; end
                // mezz 3
                POST_DONE4: begin wr_data_shift <= {16'b000_0001_1011_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+3; end
                // mezz 3
                POST_DONE5: begin wr_data_shift <= {16'b000_0001_1011_1111,48'd0}; iic_num_bytes_i <= 8'h1; iic_addr <= IO_EXP_IIC_ADDR+3; post_done_latch <= 1'b1; end
                                                       
              endcase
            // No more instructions to process => HMC IIC init done - now need to wait 20ms for data to be sent out of HMC device (data sheet)
            end else begin
              //hmc_iic_init_done_i <= 1'b1;
              hmc_iic_done_start_timer_i <= 1'b1;  
            end
          // init counter increment
          end else begin
            //Only start incrementing this counter when GTH TX PHY is ready
            if (TX_PHY_RESET_DONE == 1'b1) begin
              init_time <= init_time + 1'b1;
            end 
          end
        end

        // Feed the i2c_master.vhd with IIC address and first byte of data HMC IIC Register Address [31:24]
        STATE_IIC_ADDR: begin
          phy_state <= STATE_IIC_WAIT;            
          iic_cmd <= 1'b1; // Initiate IIC bus cycle
          iic_data <= wr_data_shift[63:56]; // data HMC IIC Register Address [31:24]
          wr_data_shift <= {wr_data_shift[55:0],8'h0}; // next byte data HMC IIC Register Address [23:16]
        end  

        // Wait for iic operation to begin and load the next byte 
        STATE_IIC_WAIT: begin          
          if (iic_busy == 1'b1) begin // As soon as the current cycle is underway, load the next cycle
            phy_state <= STATE_IIC_DATA; 
            if (iic_num_bytes_i == 8'd0) // check if all the bytes have been shifted and sent over IIC
              iic_cmd <= 1'b0; // terminate the IIC bus cycle
            else begin
              iic_num_bytes_i <= iic_num_bytes_i - 1'b1; // decrement byte counter
              iic_cmd <= 1'b1;  // extend IIC bus cycle to accept another byte
              iic_data <= wr_data_shift[63:56]; // transmit current byte in shift register
              wr_data_shift <= {wr_data_shift[55:0],8'h0}; // load the next byte in shift register
            end
          end else begin
            phy_state <= STATE_IIC_WAIT; // Wait for iic operation to begin
          end
        end

        // issue next byte write when IIC is ready
        STATE_IIC_DATA: begin         
          if (iic_busy == 1'b1) begin // Wait for iic operation to complete
            phy_state <= STATE_IIC_DATA;
          end else begin
            if (iic_cmd == 1'b1) // more bytes of the current instruction are cued up, process them
              phy_state <= STATE_IIC_WAIT;
            else            
              phy_state <= STATE_DONE; // last byte whas transmitted of current 64bit instruction, load the next one
          end
        end

        // last byte whas transmitted of current 64bit instruction, load the next one      
        STATE_DONE: begin
          iic_cmd <= 1'b0;
          phy_state <= STATE_IDLE; // return to idle state and check if there are more instructions to send
          iic_inst_cnt_i <= iic_inst_cnt_i + 1'b1; // increment the instruction sequence number for the next one
        end

      endcase
    end
  end

  assign POST_DONE_LATCH = post_done_latchR;

// ******************************************************************************************************************************************************************************************

// ******************************************************************************************************************************************************************************************
// IIC bus master
// ******************************************************************************************************************************************************************************************
  assign IIC_BUSY = op_iic_busy;

  // DIGI-KEY IIC master
  // performs the actual IIC bus cycle
  i2c_master #(
    .input_clk(CLK_FREQ),
    .bus_clk(IIC_FREQ)
  ) i2c_master_inst (
    .clk       (CLK),// --system clock
    .reset_n   (~RST),// --active low reset
    .ena       (iic_cmd),// --latch in command
    .addr      (iic_addr[6:0]),// --address of target slave
    .rw        (iic_addr[7]),// --'0' is write, '1' is read
    .data_wr   (iic_data),// --data to write to slave
    .busy      (iic_busy),// --indicates transaction in progress
    .data_rd   (iic_read_data),// --data read from slave
    .ack_error (IIC_ACK_ERR),// --flag if improper acknowledge from slave
    .sda       (sda_in_i),// --serial data output of i2c bus
    .sda_out   (sda_out),
    .scl       (scl_in_i),// --serial clock output of i2c bus 
    .scl_out   (scl_out)   
  );

  assign SDA_OUT = sda_out;//sda_out_i = sda_out;
  assign SCL_OUT = scl_out;//scl_out_i = scl_out;

  assign sda_in_i = SDA_IN;//sda_in;
  assign scl_in_i = SCL_IN;//scl_in;

// ******************************************************************************************************************************************************************************************

//// ******************************************************************************************************************************************************************************************
//// Xilinx I/O Buffers
//// ******************************************************************************************************************************************************************************************
//  // SDA is a OPEN DRAIN pin
//  IOBUF #(
//    .IOSTANDARD("LVCMOS18")
//  ) IOBUF_sda (
//    .IO (SDA),
//    .I  (1'b0), // if the drive is enabled (sda = '0', drive a '0' on the pin, else sda='1' tristates the pin and the external IIC pull up does the work)
//    .O  (sda_in),
//    .T  (sda_out_i) 
//  );
//
//// SCL is a OPEN DRAIN pin
//  IOBUF #(
//    .IOSTANDARD("LVCMOS18")
//  ) IOBUF_scl (
//    .IO (SCL),
//    .I  (1'b0), // if the drive is enabled (scl = '0', drive a '0' on the pin, else scl='1' tristates the pin and the external IIC pull up does the work)
//    .O  (scl_in),
//    .T  (scl_out_i)
//  );

// ******************************************************************************************************************************************************************************************

endmodule