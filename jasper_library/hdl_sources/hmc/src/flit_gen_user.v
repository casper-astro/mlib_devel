// #########################################################################################################
// # Project: meerKAT (SKA-SA)
// # Module: flit_gen
// # Coded by: Henno Kriel (henno@ska.ac.za)
// # Date: 25 Feb 2016
// #
// # Description
// #   The purpose of this module is to test the HMC memory, by generating test data 
// #   that is written to the HMC DRAM. The test data is then read back and verified.
// #   This module writes/reads on the same HMC link and only one link.
// #   
// #   This module generates test FLITs for the openHMC AXI interface.
// #   First a HMC 32-byte POSTED WRITE request is generated, then a
// #   HMC 32-byte READ request is issued. The received FLITs are 
// #   decoded and the recovered data is compared to the original written data.
// #
// #   Please consult openHMC document for further info.
// #
// ##########################################################################################################
module flit_gen_user #(
    //Define width of the datapath
    parameter LOG_FPW               = 2,        //Legal Values: 1,2,3
    parameter FPW                   = 4,        //Legal Values: 2,4,6,8
    parameter DWIDTH                = FPW*128,  //Leave untouched
    //Define HMC interface width
    parameter LOG_NUM_LANES         = 3,                //Set 3 for half-width, 4 for full-width
    parameter NUM_LANES             = 2**LOG_NUM_LANES, //Leave untouched
    parameter NUM_DATA_BYTES        = FPW*16           //Leave untouched
  )  (
    input  wire CLK,
    input  wire RST,
    input  wire POST_DONE,
    //----------------------------------
    //----Connect AXI Ports
    //----------------------------------
    //From AXI to HMC Ctrl TX
    output  wire                         s_axis_tx_TVALID,
    input   wire                         s_axis_tx_TREADY,
    output  wire [DWIDTH-1:0]            s_axis_tx_TDATA,
    output  wire [NUM_DATA_BYTES-1:0]    s_axis_tx_TUSER,
    //From HMC Ctrl RX to AXI
    input   wire                         m_axis_rx_TVALID,
    output  wire                         m_axis_rx_TREADY,
    input   wire [DWIDTH-1:0]            m_axis_rx_TDATA,
    input   wire [NUM_DATA_BYTES-1:0]    m_axis_rx_TUSER,


    // write interface
    input  wire [26:0] WR_ADDRESS,
    input  wire [255:0] DATA_IN,
    input  wire WR_REQ,
    output wire WR_READY,

    // read interface
    input  wire [26:0] RD_ADDRESS,
    input  wire RD_REQ, 
    output wire [255:0] DATA_OUT, 
    input  wire [8:0] TAG_IN,   
    output wire [8:0] TAG_OUT,
    output wire DATA_VALID,
    output wire RD_READY,
    output wire [6:0] FLIT_TAIL_ERRSTAT
    


  );
  
  
  //Debug HMC Registers
  (* mark_debug = "true" *) wire dbg_flit_gen_post_done; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_s_tx_tvalid; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_s_tx_tready; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [DWIDTH-1:0] dbg_flit_gen_s_tx_tdata; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [NUM_DATA_BYTES-1:0] dbg_flit_gen_s_tx_tuser; //Virtual test probe for the logic analyser
  
  (* mark_debug = "true" *) wire dbg_flit_gen_m_rx_tvalid; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_m_rx_tvalid_r; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_m_rx_tready; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [DWIDTH-1:0] dbg_flit_gen_m_rx_tdata; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [DWIDTH-1:0] dbg_flit_gen_m_rx_tdata_r; //Virtual test probe for the logic analyser

  (* mark_debug = "true" *) wire [NUM_DATA_BYTES-1:0] dbg_flit_gen_m_rx_tuser; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [NUM_DATA_BYTES-1:0] dbg_flit_gen_m_rx_tuser_r; //Virtual test probe for the logic analyser
  
  (* mark_debug = "true" *) wire [26:0] dbg_flit_gen_wr_address; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire dbg_flit_gen_wr_req; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [255:0] dbg_flit_gen_data_in; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_wr_ready; //Virtual test probe for the logic analyser
  
  (* mark_debug = "true" *) wire [26:0] dbg_flit_gen_rd_address; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire dbg_flit_gen_rd_req; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [255:0] dbg_flit_gen_data_out; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [8:0] dbg_flit_gen_tag_in; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [8:0] dbg_flit_gen_tag_out; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_data_valid; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_rd_ready; //Virtual test probe for the logic analyser
  
  (* mark_debug = "true" *) wire [3:0] dbg_flit_gen_rd_flit_state; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [3:0] dbg_flit_gen_wr_flit_state; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_flit_gen_next_flit_case3_second; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire dbg_flit_gen_next_flit_case3_third; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire dbg_flit_gen_next_flit_case4_second; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire dbg_flit_gen_next_flit_case4_third; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire [63:0] data_valid_rx_valid_count; //Virtual test probe for the logic analyser    
  (* mark_debug = "true" *) wire [63:0] data_valid_rx_hmc_valid_count; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire [63:0] dbg_flit_case1_first_count; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire [63:0] dbg_flit_case2_first_count; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire [63:0] dbg_flit_case3_first_count; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire [63:0] dbg_flit_case4_first_count; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire [63:0] dbg_flit_case3_second_count; //Virtual test probe for the logic analyser 
  (* mark_debug = "true" *) wire [63:0] dbg_flit_case4_second_count; //Virtual test probe for the logic analyser  
  (* mark_debug = "true" *) wire [63:0] dbg_flit_case3_second_spec_count; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [3:0] dbg_flit_error_rsp; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [63:0] dbg_wr_req_count; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [63:0] dbg_rd_req_count; //Virtual test probe for the logic analyser
  
  
  assign dbg_flit_gen_post_done = POST_DONE;
  assign dbg_flit_gen_s_tx_tvalid = s_axis_tx_TVALID_i; // & s_axis_tx_TREADY;
  assign dbg_flit_gen_s_tx_tready = s_axis_tx_TREADY;
  assign dbg_flit_gen_s_tx_tdata = s_axis_tx_TDATA_i;
  assign dbg_flit_gen_s_tx_tuser = s_axis_tx_TUSER_i; 
  
  assign dbg_flit_gen_m_rx_tvalid_r = m_axis_rx_TVALID_R;  
  assign dbg_flit_gen_m_rx_tready = m_axis_rx_TREADY_FIFO;//m_axis_rx_TREADY_i;  
  assign dbg_flit_gen_m_rx_tdata_r = m_axis_rx_TDATA_R;
  assign dbg_flit_gen_m_rx_tuser_r = m_axis_rx_TUSER_R; 
  
  assign dbg_flit_gen_m_rx_tvalid = m_axis_rx_TVALID;  
  assign dbg_flit_gen_m_rx_tdata = m_axis_rx_TDATA;
  assign dbg_flit_gen_m_rx_tuser = m_axis_rx_TUSER;  
  
  assign dbg_flit_gen_wr_address = WR_ADDRESS;  
  assign dbg_flit_gen_wr_req = WR_REQ;  
  assign dbg_flit_gen_data_in = DATA_IN;
  assign dbg_flit_gen_wr_ready = req_rdy;//(req_rdy == 1'b1) ? s_axis_tx_TREADY : 1'b0; 
  
  assign dbg_flit_gen_rd_address = RD_ADDRESS;  
  assign dbg_flit_gen_rd_req = RD_REQ;  
  assign dbg_flit_gen_data_out = rd_data;
  assign dbg_flit_gen_tag_in = TAG_IN; 
  assign dbg_flit_gen_tag_out = rd_tag;  
  assign dbg_flit_gen_data_valid = rd_data_val;  
  assign dbg_flit_gen_rd_ready = req_rdy;//(req_rdy == 1'b1) ? s_axis_tx_TREADY : 1'b0;
  
  assign dbg_flit_gen_rd_flit_state = rd_flit_state;
  assign dbg_flit_gen_wr_flit_state = wr_flit_state;
  
  assign dbg_flit_gen_next_flit_case3_second =  next_flit_case3_second;
  assign dbg_flit_gen_next_flit_case3_third = next_flit_case3_third;
  assign dbg_flit_gen_next_flit_case4_second =  next_flit_case4_second;
  assign dbg_flit_gen_next_flit_case4_third =  next_flit_case4_third;
  
  assign dbg_wr_req_count = wr_req_count;
  assign dbg_rd_req_count = rd_req_count;
  
  
// FLIT Layout
// -----------
// 1 FLIT = 128 bits. Thus 4 FLITS per AXI word (512bits)

// AXI Layout: TDATA
// -----------------
// 
// The AXI TDATA is packed as follows:
// [511:384] FLIT3 Processed last
// [383:256] FLIT2
// [255:128] FLIT1
// [127:0]   FLIT0 Processed first

// AXI Layout: TUSER
// -----------------

//TUSER[3:0] - Specifies if valid FLIT is present 
//TUSER[3] - FLIT3 Valid => 1'b1
//TUSER[2] - FLIT2 Valid => 1'b1
//TUSER[1]  - FLIT1 Valid => 1'b1
//TUSER[0]  - FLIT0 Valid => 1'b1

//TUSER[7:4] - Specifies if FLIT Header is present
//TUSER[7] - FLIT3 Header Present => 1'b1
//TUSER[6] - FLIT2 Header Present => 1'b1
//TUSER[5] - FLIT1 Header Present => 1'b1
//TUSER[4] - FLIT0 Header Present => 1'b1

//TUSER[11:8] - Specifies if FLIT Tail is present
//TUSER[11] - FLIT3 Tail Present => 1'b1
//TUSER[10] - FLIT2 Tail Present => 1'b1
//TUSER[9]  - FLIT1 Tail Present => 1'b1
//TUSER[8]  - FLIT0 Tail Present => 1'b1

// AXI Control: 
// TREADY - AXI Bus is ready to accept and process
// TVALID - AXI Bus cycle is active (processs TDATA,TUSER)
// 



// Examples
//
// If the FLIT is a non data FLIT (eg for FLIT0):
// s_axis_tx_TDATA[127:64] is TAIL[63:0]  processed last
// s_axis_tx_TDATA[63:0] is HEADER[63:0]  processed first
//
// If the FLIT is a data FLIT (eg for 32 byte  (256bits) data write):
// Command description             Symbol    CMD Bit  Packet Length in FLITs  Corresponding Response Return
// 32-byte POSTED WRITE request    P_WR32    011001   3                       None (Posted)
//
// FLIT3
// NULL FLIT (Padding) processed last
// s_axis_tx_TDATA[511:384] = 0 
// 
// FLIT2
// s_axis_tx_TDATA[383:320] is Write 32bytes Request (P_WR32) TAIL[63:0]  
// s_axis_tx_TDATA[319:256] is write data [255:192]
//
// FLIT1
// s_axis_tx_TDATA[255:128] is write data [191:64]
//
// FLIT0
// s_axis_tx_TDATA[127:64] is write data [63:0]
// s_axis_tx_TDATA[63:0] is Write 32bytes Request (P_WR32) HEADER[63:0]  processed first


// HEADER LAYOUT
// -------------
// Request Packet Header Layout
// 63:61 CUB[2:0]  Cube ID: CUB field used as an HMC identifier when multiple HMC devices are chained together.

// 60:58 RES[2:0]  Reserved Reserved: These bits are reserved for future address or Cube ID expansion. The responder will ignore bits in this field from 
//                 the requester except for including them in the CRC calculation. The HMC can use portions of this field range internally.
 
// 57:24 ADDR[33:0] Address Request address. For some commands, control fields are included within this range.
// 23:15 TAG[8:0] Tag number uniquely identifying this request.
// 14:11 DLN[3:0] Duplicate of packet length field.
// 10:7  LNG[3:0] Length of packet in FLITs (1 FLIT is 128 bits). Includes header,any data payload, and tail.
// 6 RES [0] Reserved: The responder will ignore this bit from the requester except for including it in the CRC calculation. The HMC can use this field internally.
// 5:0   CMD[5:0]  Packet command. (See Table 19 on page 44 for the list of request commands.)

// TAIL LAYOUT
// -------------
// [63:0] = 0 - The tail must always be set to 0 when requesting - the openHMC core will populate the required fields and CRC


// COMMAND LIST
// ------------

// CMD
// Command description      Symbol  CMD Bit  Packet Length in FLITs  Corresponding Response Return
// 32-byte WRITE request    WR32    001001   3                       WR_RS

// CMD
// Command description             Symbol    CMD Bit  Packet Length in FLITs  Corresponding Response Return
// 32-byte POSTED WRITE request    P_WR32    011001   3                       None (Posted)
// 48-byte POSTED WRITE request    P_WR48    011010   4                       None (Posted)
// 64-byte POSTED WRITE request    P_WR64    011011   5                       None (Posted)
// 96-byte POSTED WRITE request    P_WR96    011101   7                       None (Posted)
// 128-byte POSTED WRITE request   P_WR128   011111   9                       None (Posted)
// Notes: TAG is ignored, No response packet is generated. If an error occurs during the execution of the write request, an Error Response packet will be 
// generated indicating the occurrence of the error to the host.

// CMD
// Command description             Symbol    CMD Bit  Packet Length in FLITs  Corresponding Response Return
// 32-byte READ request            RD32      110001   1                       RD_RS
// 48-byte READ request            RD48      110010   1                       RD_RS
// 64-byte READ request            RD64      110011   1                       RD_RS
// 96-byte READ request            RD96      110101   1                       RD_RS
// 128-byte READ request           RD128     110111   1                       RD_RS


// Signals used in this module
  reg [3:0] wr_flit_state,rd_flit_state;
  reg s_axis_tx_TVALID_i;
  reg [DWIDTH-1:0]  s_axis_tx_TDATA_i;
  reg [NUM_DATA_BYTES-1:0] s_axis_tx_TUSER_i;
  reg m_axis_rx_TREADY_i;
  wire m_axis_rx_TREADY_FIFO;
  reg [8:0] tag;
  reg [15:0] wait_for_NULL_FLITS_to_complete_cnt;
  reg next_flit_case3_second;
  reg next_flit_case3_third;
  reg next_flit_case4_second;
  reg next_flit_case4_third;
  reg tx_data_hold;
  reg [63:0] wr_req_count;
  reg [63:0] rd_req_count;
  reg req_rdy;
  

  // Assign external status ports
  assign s_axis_tx_TVALID = s_axis_tx_TVALID_i; //& s_axis_tx_TREADY;
  assign s_axis_tx_TDATA = s_axis_tx_TDATA_i;
  assign s_axis_tx_TUSER = s_axis_tx_TUSER_i;
  assign m_axis_rx_TREADY = m_axis_rx_TREADY_FIFO;//m_axis_rx_TREADY_i;


  // State machine state vector elements
  localparam STATE_IDLE         = 4'd0; // Default state: enter on power up or reset, exit on POST_DONE == 1'b1
  localparam WAIT_AXI_TX_RDY    = 4'd1; // Wait for AXI TX bus to become available
  localparam STATE_WR_RD_DATA   = 4'd2; // Issue WR32 Request header + write data [255:0] or RD32 Requests
  localparam STATE_CHK_RD_DATA  = 4'd5; // Wait for RX AXI bus to present valid return data and then check it for errors



  // ***************************************************************************************************************************************************************************************
  // Request State Machine: Issue either write or read request for 256bit (32byte) 
  // ***************************************************************************************************************************************************************************************
  always @(posedge CLK) begin : wr_flit

  if (RST) begin
    wr_flit_state <= STATE_IDLE;
    //addr <= 27'd0; // request addr {2'b00,addr,4b000} [33:32] reserved = "00", 16byte addr, [3:0] reserved 0 (min 16 byte transactions) 
    s_axis_tx_TDATA_i  <= 512'd0;
    s_axis_tx_TVALID_i <= 1'b0; // Deassert all control logic until the HMC is properly initialized
    s_axis_tx_TUSER_i  <= {NUM_DATA_BYTES{1'b0}};
    tag <= 9'd1; // Tag is used to deal with out of order return sequences 
    wait_for_NULL_FLITS_to_complete_cnt <= 16'd0;
    req_rdy <= 1'b0;
    tx_data_hold <= 1'b0;
    wr_req_count <= 64'd0;
    rd_req_count <= 64'd0;
    
  end else begin
      s_axis_tx_TVALID_i <= 1'b0;
      s_axis_tx_TUSER_i  <= {NUM_DATA_BYTES{1'b0}};
      s_axis_tx_TDATA_i  <= 512'd0;

      case (wr_flit_state)
        // State: Entry to state machine (from reset)
        STATE_IDLE: begin
          wr_flit_state <= STATE_IDLE;
          if (POST_DONE == 1'b1) begin // We cannot issue any FLITs if the HMC and the openHMC is not initialized!
            wait_for_NULL_FLITS_to_complete_cnt <= wait_for_NULL_FLITS_to_complete_cnt + 1'b1; // Give some time after the openHMC and HMC have initialize before bomming it with FLITs
          end
          if (wait_for_NULL_FLITS_to_complete_cnt[8] == 1'b1) begin
            wr_flit_state <= WAIT_AXI_TX_RDY; // OK waited long enough => bom it with FLITs
          end
        req_rdy <= 1'b0;
        end
        WAIT_AXI_TX_RDY: begin
          req_rdy <= 1'b0;
          wr_flit_state <= WAIT_AXI_TX_RDY; // Wait for TX AXI FIFO to become available
          if (s_axis_tx_TREADY == 1'b1) begin // Make sure AXI TX FIFO is not FULL  
            wr_flit_state <= STATE_WR_RD_DATA;
          end
        end
        // State: Request WR128 header, followed by write data (WR_REQ_DATA[447:0])
        STATE_WR_RD_DATA: begin
           
          
          wr_flit_state <= STATE_WR_RD_DATA;
          //if write is enabled            
          if (WR_REQ == 1'b1) begin // Write request uses FLITs 2..0       
            //s_axis_tx_TVALID_i <= 1'b1; // Issue a write to TX AXI FIFO                
            s_axis_tx_TDATA_i[383:0]  <= {64'd0, DATA_IN, {3'd0,3'd0,{2'd0,WR_ADDRESS,5'd0},tag, 4'd3, 4'd3, 1'b0, 6'b011001}}; // posted write req 32 bytes
            s_axis_tx_TUSER_i[2:0]  <= 3'b111; // all FLITS 2-0 valid  - Write Req 
            s_axis_tx_TUSER_i[6:4]  <= 3'b001; // Header on FLIT0 - Write Req  
            s_axis_tx_TUSER_i[10:8]  <= 3'b100; // Tail on FLIT2 - Write Req 
            wr_req_count <= wr_req_count + 1'b1;
          end
          //if read is enabled
          if (RD_REQ == 1'b1) begin  // Read request uses FLIT 3        
            //s_axis_tx_TVALID_i <= 1'b1; // Issue a write to TX AXI FIFO, with a READ32 command request ie (read 32bytes / 256bits from requested address)
            s_axis_tx_TDATA_i[511:384]  <= {64'd0, {3'd0,3'd0,{2'd0,RD_ADDRESS,5'd0},TAG_IN, 4'd1, 4'd1, 1'b0, 6'b110001}}; // red req 32 bytes
            s_axis_tx_TUSER_i[3]  <= 1'b1; // Valid on FLIT3 - Read Req   
            s_axis_tx_TUSER_i[7]  <= 1'b1; // Header on FLIT3 - Read Req
            s_axis_tx_TUSER_i[11]  <= 1'b1; // Tail on FLIT3 - Read Req  
            rd_req_count <= rd_req_count + 1'b1;
          end
          //if read or write is enabled
          if (WR_REQ == 1'b1 || RD_REQ == 1'b1) begin
            s_axis_tx_TVALID_i <= 1'b1; // Issue a write to TX AXI FIFO
          end else begin
            s_axis_tx_TVALID_i <= 1'b0; // Disable a write to TX AXI FIFO
            s_axis_tx_TUSER_i  <= {NUM_DATA_BYTES{1'b0}};
            s_axis_tx_TDATA_i  <= 512'd0;
            req_rdy <= 1'b0;      
          end
          //if AXI bus is not ready, then deassert write and read ready signals  
          if(s_axis_tx_TREADY == 1'b1) begin
            req_rdy <= 1'b1;
          end else begin
            req_rdy <= 1'b0;
          end
    end    
      endcase
    end    
  end

  //assign WR_READY = (req_rdy == 1'b1) ? s_axis_tx_TREADY : 1'b0;
  //assign RD_READY = (req_rdy == 1'b1) ? s_axis_tx_TREADY : 1'b0;
 
 assign WR_READY = req_rdy;
 assign RD_READY = req_rdy;

  // ***************************************************************************************************************************************************************************************
  // Read state machine 
  // Checks incomming memory data from HMC that was requested in the write state machine (WR32 and RD32 request FLITs)
  // ***************************************************************************************************************************************************************************************
  reg [8:0] rd_tag,rd_tag_i, rd_tag_hold;
  reg [255:0] rd_data, rd_data_i, rd_data_hold;
  reg [63:0] rd_tail, rd_tail_hold;
  
  reg rd_data_val, rd_data_val_hold;
  reg [63:0] r_data_valid_rx_valid_count;
  reg [63:0] r_data_valid_rx_hmc_valid_count;
  
  reg [63:0] r_flit_case1_first_count;
  reg [63:0] r_flit_case2_first_count;
  reg [63:0] r_flit_case3_first_count;
  reg [63:0] r_flit_case4_first_count;
  reg [63:0] r_flit_case3_second_count;
  reg [63:0] r_flit_case4_second_count;
  reg [63:0] r_flit_case3_second_spec_count;
  reg [3:0] r_flit_error_rsp;
  
  wire [DWIDTH-1:0] m_axis_rx_TDATA_R;
  wire [15:0] m_axis_rx_TUSER_R;
  wire m_axis_rx_TVALID_R;
  
  wire hmc_fifo_overflow;
  wire hmc_fifo_underflow;
  
  assign data_valid_rx_valid_count = r_data_valid_rx_valid_count;
  assign data_valid_rx_hmc_valid_count = r_data_valid_rx_hmc_valid_count;
  assign dbg_flit_case1_first_count = r_flit_case1_first_count;
  assign dbg_flit_case2_first_count = r_flit_case2_first_count;
  assign dbg_flit_case3_first_count = r_flit_case3_first_count;
  assign dbg_flit_case4_first_count = r_flit_case4_first_count;
  assign dbg_flit_case3_second_count = r_flit_case3_second_count;
  assign dbg_flit_case4_second_count = r_flit_case4_second_count;
  assign dbg_flit_case3_second_spec_count = r_flit_case3_second_spec_count;
  assign dbg_flit_error_rsp = r_flit_error_rsp;
  
  
  //AXI Stream FIFO Added to meet timing closure, as the data needs to be registered to meet
  //the timing and no data can be lost
  //FIFO is 528 bits wide to accommodate the AXI bus and 32 deep to prevent the FIFO from overflowing when data
  //cannot be read from FIFO
  hmc_user_axi_fifo hmc_user_axi_fifo_inst(
   .s_aresetn(~RST),
   .s_aclk(CLK),
   .s_axis_tvalid(m_axis_rx_TVALID),
   .s_axis_tready(m_axis_rx_TREADY_FIFO),   //Output
   .s_axis_tdata(m_axis_rx_TDATA),
   .s_axis_tuser(m_axis_rx_TUSER[15:0]),
   .m_axis_tvalid(m_axis_rx_TVALID_R),
   .m_axis_tready(m_axis_rx_TREADY_i),  //Input
   .m_axis_tdata(m_axis_rx_TDATA_R),
   .m_axis_tuser(m_axis_rx_TUSER_R),
   .axis_overflow(hmc_fifo_overflow),  //Output
   .axis_underflow(hmc_fifo_underflow)  //Output
   
);  
  
  
  always @(posedge CLK) begin : rd_flit

  if (RST) begin
    // Deassert all control signals on reset
    rd_flit_state <= STATE_IDLE;     // Enter state machine in IDLE state
    m_axis_rx_TREADY_i <= 1'b0;      // Signal to from this module to 

    // For 128byte Requests we need 9 FLITs, this will require 3 AXI (4 FLITs per access) accesses (ie 3 clock cycles)

    next_flit_case3_second <= 1'b0;  // AXI access 2 of 3    
    next_flit_case3_third <= 1'b0;   // AXI access 3 of 3    
    next_flit_case4_second <= 1'b0;  // AXI access 2 of 3    
    next_flit_case4_third <= 1'b0;   // AXI access 3 of 3    

    rd_data_val <= 1'b0;
    rd_data_val_hold <= 1'b0;  // in the case were 2 valid responses falls on the same AXI transaction
    rd_data <= 256'd0;
    rd_tag <= 9'd0;
    rd_tail_hold <= 64'd0;
    rd_tail <= 64'd0;
       
    r_data_valid_rx_valid_count <= 64'b0;
    r_data_valid_rx_hmc_valid_count <= 64'b0;
    r_flit_case1_first_count <= 64'b0;
    r_flit_case2_first_count <= 64'b0;
    r_flit_case3_first_count <= 64'b0;
    r_flit_case4_first_count <= 64'b0;
    r_flit_case3_second_count <= 64'b0;
    r_flit_case4_second_count <= 64'b0;
    r_flit_case3_second_spec_count <= 64'b0;
    r_flit_error_rsp <= 4'b0;
    
  end else begin
            
      m_axis_rx_TREADY_i <= 1'b1; // After reset this module is always ready
      rd_data_val <= 1'b0;
      rd_data_val_hold <= 1'b0;
      
      if ((rd_data_val == 1'b1) && (POST_DONE == 1'b1))
      begin
         r_data_valid_rx_hmc_valid_count <= r_data_valid_rx_hmc_valid_count + 1'b1;
      end 
      if ((m_axis_rx_TVALID_R == 1'b1) && (POST_DONE == 1'b1))
      begin
          r_data_valid_rx_valid_count <= r_data_valid_rx_valid_count + 1'b1;
          r_flit_error_rsp [3:0] <= m_axis_rx_TUSER_R[15:12];
      end 
            
      // in the case were 2 valid responses falls on the same AXI transaction on the previous cycle, this module asserted m_axis_rx_TREADY_i <= 1'b0 (not ready - hold off for one cycle)
      // Now generate data valid from 2nd transaction data
      //if (rd_data_val_hold == 1'b1) begin
      if (rd_data_val_hold == 1'b1) begin     
        rd_tag <= rd_tag_hold;      
        rd_data <= rd_data_hold;
        rd_tail <= rd_tail_hold;        
        rd_data_val <= rd_data_val_hold;
        
      // do not decode next axi cycle, as it was put on hold  
      end else begin     
         
          // Start state decoding
          case (rd_flit_state)
            // State: Entry to state machine (from reset)
            STATE_IDLE: begin
              rd_flit_state <= STATE_IDLE;
              if (POST_DONE == 1'b1) begin
                rd_flit_state <= STATE_CHK_RD_DATA;
              end
            end
            // State: Decode AXI bus and figure out what is data, overheads or NULL FLITs
            //        If there is HMC memory data returned, check this data with the data written to HMC memory in the write state machine 
            STATE_CHK_RD_DATA: begin
              rd_flit_state <= STATE_CHK_RD_DATA; 
    
              // 4 FLITs per AXI Access [511:0]:
              //   FLIT0 axis bus [127:0]
              //   FLIT1 axis bus [255:128]
              //   FLIT2 axis bus [383:256]
              //   FLIT3 axis bus [511:384]
    
    
              // ****************** First time around FLITs ******************
              // CASE 1 Start
              // Valid FLITSs 2,1,0
              // This case follows the same sequence as the RD32 request issued by the write state machine
              // The read data returned will be in the same sequence
              // The RD32 tag that is returned in the FLIT header(m_axis_rx_TDATA[23:15])
              if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[10:8] == 3'b100 && m_axis_rx_TUSER_R[6:4] == 3'b001 && m_axis_rx_TUSER_R[2:0] == 3'b111) begin
                rd_tag <= m_axis_rx_TDATA_R[23:15];
                rd_data [255:0] <= m_axis_rx_TDATA_R[255+64:64];
                rd_tail [63:0] <= m_axis_rx_TDATA_R[255+64+64:255+64+1];
                rd_data_val <= 1'b1;
                r_flit_case1_first_count <= r_flit_case1_first_count + 1'b1;
              end 
    
              // ****************** First time around FLITs ******************
              // CASE 2 Start
              // Valid FLITSs 3,2,1
              if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[11:9] == 3'b100 && m_axis_rx_TUSER_R[7:5] == 3'b001 && m_axis_rx_TUSER_R[3:1] == 3'b111) begin
                rd_tag <= m_axis_rx_TDATA_R[23+128:15+128];
                rd_data [255:0] <= m_axis_rx_TDATA_R[255+64+128:64+128];
                rd_tail [63:0] <= m_axis_rx_TDATA_R[255+64+128+64:255+64+128+1];
                rd_data_val <= 1'b1;
                r_flit_case2_first_count <= r_flit_case2_first_count + 1'b1;
              end 
    
              // ****************** First time around FLITs ******************
              // CASE 3 Start
              // Valid FLITSs 3,2
              if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[11:10] == 2'b00 && m_axis_rx_TUSER_R[7:6] == 2'b01 && m_axis_rx_TUSER_R[3:2] == 2'b11) begin
                rd_tag_i <= m_axis_rx_TDATA_R[23+256:15+256];
                rd_data_i[191:0] <= m_axis_rx_TDATA_R[191+64+256:64+256];
                //No tail
                rd_tail [63:0] <= 64'd0;
                next_flit_case3_second <= 1'b1;  // AXI access 2 of 2 
                r_flit_case3_first_count <= r_flit_case3_first_count + 1'b1;
              end 
    
              // ****************** First time around FLITs ******************
              // CASE 4 Start
              // Valid FLITSs 3
              if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[11] == 1'b0 && m_axis_rx_TUSER_R[7] == 1'b1 && m_axis_rx_TUSER_R[3] == 1'b1) begin
                rd_tag_i <= m_axis_rx_TDATA_R[23+384:15+384];
                rd_data_i[63:0] <= m_axis_rx_TDATA_R[63+64+384:64+384];
                //No tail
                rd_tail [63:0] <= 64'd0;
                next_flit_case4_second <= 1'b1;  // AXI access 2 of 2 
                r_flit_case4_first_count <= r_flit_case4_first_count + 1'b1;
              end 
    
    
              // ****************** Second time around FLITs ******************
              // CASE 3 cont...
              // Valid FLITSs 0
              if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[8] == 1'b1 && m_axis_rx_TUSER_R[4] == 1'b0 && m_axis_rx_TUSER_R[0] == 1'b1 && next_flit_case3_second == 1'b1) begin
                rd_data [255:192] <= m_axis_rx_TDATA_R[63:0];
                rd_data [191:0] <= rd_data_i[191:0];
                rd_tail [63:0] <= m_axis_rx_TDATA_R[64+63:63+1];
                rd_tag <= rd_tag_i;
                rd_data_val <= 1'b1;
                next_flit_case3_second <= 1'b0;
                r_flit_case3_second_count <= r_flit_case3_second_count + 1'b1;
              //do not clear if there are still case 3 responses coming on FLIT 2,3!
                if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[11:10] == 2'b00 && m_axis_rx_TUSER_R[7:6] == 2'b01 && m_axis_rx_TUSER_R[3:2] == 2'b11) begin
                  next_flit_case3_second <= 1'b1;
                end 
                
              end
              
              // Special CASE 3 cont... There can also be 3 valid FLITS in this same cycle, producing a second valid! 
              // Valid FLITSs 0
              if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[11:8] == 4'b1001 && m_axis_rx_TUSER_R[7:4] == 4'b0010 && m_axis_rx_TUSER_R[3:0] == 4'b1111 && next_flit_case3_second == 1'b1) begin
                rd_data [255:192] <= m_axis_rx_TDATA_R[63:0];
                rd_tail [63:0] <= m_axis_rx_TDATA_R[64+63:63+1];
                rd_data [191:0] <= rd_data_i[191:0];
                rd_tag <= rd_tag_i;
                rd_data_val <= 1'b1;
                next_flit_case3_second <= 1'b0;
                m_axis_rx_TREADY_i <= 1'b0; // have to deal with 2 valids -> inform AXI to standby, so that next cycle does not produce data to deal with!
                // valid data from case 2
                rd_tag_hold <= m_axis_rx_TDATA_R[23+128:15+128];
                rd_data_hold [255:0] <= m_axis_rx_TDATA_R[255+64+128:64+128];
                rd_tail_hold [63:0] <= m_axis_rx_TDATA_R[255+64+128+64:255+64+128+1];
                rd_data_val_hold <= 1'b1;
                r_flit_case3_second_spec_count <= r_flit_case3_second_spec_count + 1'b1;
              end          
    
              // CASE 4 cont...
              // Valid FLITSs 1,0
              if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[9:8] == 2'b10 && m_axis_rx_TUSER_R[5:4] == 4'b00 && m_axis_rx_TUSER_R[1:0] == 4'b11 && next_flit_case4_second == 1'b1) begin
                rd_data [255:64] <= m_axis_rx_TDATA_R[191:0];
                rd_data [63:0] <= rd_data_i[63:0];
                rd_tail [63:0] <= m_axis_rx_TDATA_R[191+64:192];
                rd_tag <= rd_tag_i;
                rd_data_val <= 1'b1;
                next_flit_case4_second <= 1'b0;
                //do not clear if there are still case 4 responses coming on FLIT 3!
                if (m_axis_rx_TVALID_R == 1'b1 && m_axis_rx_TUSER_R[11] == 1'b0 && m_axis_rx_TUSER_R[7] == 1'b1 && m_axis_rx_TUSER_R[3] == 1'b1) begin
                  next_flit_case4_second <= 1'b1;
                end                
                r_flit_case4_second_count <= r_flit_case4_second_count + 1'b1;
              end
              
            end
          endcase
       end  
    end    
  end

  assign TAG_OUT = rd_tag;
  assign DATA_VALID = rd_data_val;
  assign DATA_OUT = rd_data;
  assign FLIT_TAIL_ERRSTAT = rd_tail[26:20]; //Assign ERRSTAT register of FLIT tail

endmodule