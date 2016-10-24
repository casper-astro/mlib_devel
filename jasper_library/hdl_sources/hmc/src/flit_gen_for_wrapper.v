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
// #   First a HMC 128-byte POSTED WRITE request is generated, then a
// #   HMC 128-byte READ request is issued. The received FLITs are 
// #   decoded and the recovered data is compared to the original written data.
// #
// #   Please consult openHMC document for further info.
// #
// ##########################################################################################################
module flit_gen_for_wrapper #(
    //Define width of the datapath
    parameter LINK                  = 2,
    parameter LOG_FPW               = 2,        //Legal Values: 1,2,3
    parameter FPW                   = 4,        //Legal Values: 2,4,6,8
    parameter DWIDTH                = FPW*128,  //Leave untouched
    //Define HMC interface width
    parameter LOG_NUM_LANES         = 3,                //Set 3 for half-width, 4 for full-width
    parameter NUM_LANES             = 2**LOG_NUM_LANES, //Leave untouched
    parameter NUM_DATA_BYTES        = FPW*16,           //Leave untouched
    parameter READ_NOT_WRITE        = 1
  )  (
    input  wire CLK,
    input  wire RST,
    input  wire OPEN_HMC_INIT_DONE,
    output wire [63:0] DATA_RX_FLIT_CNT,
    output wire [63:0] DATA_RX_ERR_FLIT_CNT,
    output wire DATA_ERR_DETECT,
    input  wire [255:0] DATA_IN,
    output wire [255:0] DATA_OUT,
    input  wire RD_REQ,
    input  wire WR_REQ,
    input  wire [34:0] WR_ADDRESS,
    input  wire [34:0] RD_ADDRESS,
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
    input   wire [NUM_DATA_BYTES-1:0]    m_axis_rx_TUSER
  );

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
  reg [34:0] addr;
  reg [255:0] wr_data,wr_data_chk;
  reg [255:0] rd_data,rd_data1;
  reg s_axis_tx_TVALID_i;
  reg [DWIDTH-1:0]  s_axis_tx_TDATA_i;
  reg [NUM_DATA_BYTES-1:0] s_axis_tx_TUSER_i;
  reg m_axis_rx_TREADY_i;
  reg [8:0] tag, rd_rag;
  reg [63:0] data_rx_flit_cnt;
  reg [63:0] data_rx_err_flit_cnt;
  reg [3:0] data_err_detect,flit;
  reg [15:0] wait_for_NULL_FLITS_to_complete_cnt;
  reg chk_data;
  reg [1:0] wr_cnt;
  reg next_flit;
  reg chk_data;

  // Assign external status ports
  assign DATA_RX_FLIT_CNT = data_rx_flit_cnt;
  assign DATA_RX_ERR_FLIT_CNT = data_rx_err_flit_cnt;
  assign DATA_ERR_DETECT = |data_err_detect;

  assign s_axis_tx_TVALID = s_axis_tx_TVALID_i & s_axis_tx_TREADY;
  assign s_axis_tx_TDATA = s_axis_tx_TDATA_i;
  assign s_axis_tx_TUSER = s_axis_tx_TUSER_i;
  assign m_axis_rx_TREADY = m_axis_rx_TREADY_i;
  assign DATA_OUT = rd_data;


  // State machine state vector elements
  localparam STATE_IDLE         = 4'd0; // Default state: enter on power up or reset, exit on OPEN_HMC_INIT_DONE == 1'b1
  localparam WAIT_AXI_TX_RDY    = 4'd1; // Wait for AXI TX bus to become available
  localparam STATE_WR_RD_DATA   = 4'd2; // Issue  PWR32 Posted Write Request header[64] + write data [256] + tail[64] + padding[128]
  localparam STATE_WR_RD_REQ    = 4'd3; // Issues RD32 Read Request tail [64] + Read request header [64] + paddind[384]
  localparam STATE_WAIT_RD_DATA = 4'd4;
  localparam STATE_CHK_RD_DATA  = 4'd5; // Wait for RX AXI bus to present valid return data and then check it for errors

  // should it be that if link 2 go to write state machine and if link 3 go to read state machine??


  // ***************************************************************************************************************************************************************************************
  // Write state machine 
  // Issues posted WR32 and RD32 request FLITs
  // ***************************************************************************************************************************************************************************************
  always @(posedge CLK) begin

  if (RST) begin
    wr_flit_state <= STATE_IDLE;
    //addr <= WR_ADDRESS; //can this be done? or should WR_ADDRESS be assigned to addr? or can WR_ADDRESS be used without addr at all?
    s_axis_tx_TVALID_i <= 1'b0; // Deassert all control logic until the HMC is properly initialized
    s_axis_tx_TUSER_i  <= {NUM_DATA_BYTES{1'b0}};
    tag <= 9'd1; // Tag is used to deal with out of order return sequences.  Posted write so no tag required and only use for read request?
    wait_for_NULL_FLITS_to_complete_cnt <= 16'd0;
    wr_cnt <= 2'd0;
    //flit_retry <= 1'b0;

  end else begin
      s_axis_tx_TVALID_i <= 1'b0;
      s_axis_tx_TUSER_i  <= {NUM_DATA_BYTES{1'b0}};

      case (wr_flit_state)
        // State: Entry to state machine (from reset)
        STATE_IDLE: begin
          wr_flit_state <= STATE_IDLE;
          if (LINK==3) begin
            addr[3] <= 1'b1; // odd addresses for LINK1
          end
          if (OPEN_HMC_INIT_DONE == 1'b1) begin // We cannot issue any FLITs if the HMC and the openHMC is not initialized!
            wait_for_NULL_FLITS_to_complete_cnt <= wait_for_NULL_FLITS_to_complete_cnt + 1'b1; // Give some time after the openHMC and HMC have initialize before bomming it with FLITs
          end
          if (wait_for_NULL_FLITS_to_complete_cnt[8] == 1'b1) begin
            wr_flit_state <= WAIT_AXI_TX_RDY; // OK waited long enough => bom it with FLITs
          end
        end

        WAIT_AXI_TX_RDY: begin
          wr_flit_state <= WAIT_AXI_TX_RDY; // Wait for TX AXI FIFO to become available
          if ((s_axis_tx_TREADY == 1'b1) && (WR_REQ== 1'b1) && (READ_NOT_WRITE == 0)) begin // Make sure AXI TX FIFO is not FULL  
            wr_flit_state <= STATE_WR_RD_DATA;                 
          end
          if ((s_axis_tx_TREADY == 1'b1) && (RD_REQ== 1'b1) && (READ_NOT_WRITE == 1)) begin // Make sure AXI TX FIFO is not FULL  
            wr_flit_state <= STATE_WR_RD_REQ;
          end
        end
        
        
        // State: Request WR32
        STATE_WR_RD_DATA: begin
          if (s_axis_tx_TREADY == 1'b1) begin // Make sure AXI TX FIFO is not FULL         
            s_axis_tx_TVALID_i <= 1'b1; // Issue a write to TX AXI FIFO
            //                     Padding(128)    Tail (64)        User data(256)             Header (64)          
            s_axis_tx_TDATA_i  <= {128'd0,         64'd0,           DATA_IN,                  3'd0, 3'd0, WR_ADDRESS, 9'd0, 4'd3, 4'd3, 1'b0, 6'b011001}; 
            s_axis_tx_TUSER_i[11:0]  <= 12'b0100_0001_1111; // Header on FLIT0, Tail on FLIT 2, all FLITS 3-0 valid
          end 
         end   
            
          
        // State : Request RD32
        STATE_WR_RD_REQ: begin
          if (s_axis_tx_TREADY == 1'b1) begin // Make sure AXI TX FIFO is not FULL         
            s_axis_tx_TVALID_i <= 1'b1; // Issue a write to TX AXI FIFO
            //                    Padding(384)     Tail (64)                     Header (64)          
            s_axis_tx_TDATA_i  <= {384'd0,         64'd0,                        3'd0, 3'd0, RD_ADDRESS, tag, 4'd3, 4'd3, 1'b0, 6'b110001}; 
            s_axis_tx_TUSER_i[11:0]  <= 12'b0001_0001_0001; // Header on FLIT0, Tail on FLIT 0, only FLIT 0 valid
            tag <= tag + 1'b1;                                                                                                               
          end  
        end    

      endcase
    end    
  end


  // ***************************************************************************************************************************************************************************************
  // Read state machine 
  // Checks incoming memory data from HMC that was requested in the write state machine (RD32 request FLITs)
  // ***************************************************************************************************************************************************************************************
  always @(posedge CLK) begin

  if (RST) begin
    rd_flit_state <= STATE_IDLE;
    m_axis_rx_TREADY_i <= 1'b0;
    data_rx_flit_cnt <= 64'd0;
    data_rx_err_flit_cnt <= 64'd0;
    data_err_detect <= 1'b0; 
    next_flit <= 1'b0;
    //wr_data_chk <= 256'h1234_5678_9abc_def0_1002_3004_5006_7008_900A_B00C_D00E_F001_babe_face_dead_0000;
    chk_data <= 1'b0;
    rd_rag <= 9'd1;

  end else begin
      m_axis_rx_TREADY_i <= 1'b1;
      chk_data <= 1'b0;
      next_flit <= 1'b0;
      case (rd_flit_state)
        STATE_IDLE: begin
          rd_flit_state <= STATE_IDLE;
          if (OPEN_HMC_INIT_DONE == 1'b1) begin
            rd_flit_state <= STATE_WAIT_RD_DATA;
          end
        end

  
        // State: Decode AXI bus and figure out what is data, overheads or NULL FLITs
        //        If there is HMC memory data returned, check this data with the data written to HMC memory in the write state machine 
        STATE_WAIT_RD_DATA: begin 

          // CASE 1 Start
          // Valid FLITSs 3,2,1,0
          if (m_axis_rx_TVALID == 1'b1 && m_axis_rx_TUSER[11:8] == 4'b0100 && m_axis_rx_TUSER[7:4] == 4'b0001 && m_axis_rx_TUSER[3:0] == 4'b1111) begin
             flit[0] <= 1'b1; // Mark FLIT0 as a valid data FLIT, for the FLIT counters
             rd_data <= m_axis_rx_TDATA[319:64];
             rd_rag <= m_axis_rx_TDATA[23:15];
             data_rx_flit_cnt <= data_rx_flit_cnt + 1'b1;
             chk_data <= 1'b1;
          end
            
             
            
          

          // CASE 2 Start
          // Valid FLITSs 3,2,1
          if (m_axis_rx_TVALID == 1'b1 && m_axis_rx_TUSER[11:8] == 4'b1000 && m_axis_rx_TUSER[7:4] == 4'b0010 && m_axis_rx_TUSER[3:0] == 4'b1110) begin
            flit[1] <= 1'b1;
            rd_data <= m_axis_rx_TDATA[319+128:64+128];
            rd_rag <= m_axis_rx_TDATA[23+128:15+128];
            data_rx_flit_cnt <= data_rx_flit_cnt + 1'b1;
            chk_data <= 1'b1;
          end

          // CASE 3 Start
          // Valid FLITSs 3,2
          if (m_axis_rx_TVALID == 1'b1 && m_axis_rx_TUSER[11:8] == 4'b0000 && m_axis_rx_TUSER[7:4] == 4'b0100 && m_axis_rx_TUSER[3:0] == 4'b1100) begin
            flit[2] <= 1'b1;
            rd_data[191:0] <= m_axis_rx_TDATA[511:64+256];
            rd_rag <= m_axis_rx_TDATA[23+256:15+256];
            next_flit <= 1'b1;
          end

          if (m_axis_rx_TVALID == 1'b1 && m_axis_rx_TUSER[11:8] == 4'b0001 && m_axis_rx_TUSER[7:4] == 4'b0000 && m_axis_rx_TUSER[3:0] == 4'b0001 && next_flit == 1'b1) begin
            rd_data[255:192] <= m_axis_rx_TDATA[63:0];
            data_rx_flit_cnt <= data_rx_flit_cnt + 1'b1;
            chk_data <= 1'b1;
          end

           

          // CASE 4 Start
          // Valid FLITSs 3
          if (m_axis_rx_TVALID == 1'b1 && m_axis_rx_TUSER[11:8] == 4'b0000 && m_axis_rx_TUSER[7:4] == 4'b1000 && m_axis_rx_TUSER[3:0] == 4'b1000) begin
            flit[3] <= 1'b1;
            rd_data[63:0] <= m_axis_rx_TDATA[511:64+384];
            rd_rag <= m_axis_rx_TDATA[23+384:15+384];
            next_flit <= 1'b1;
          end

          if (m_axis_rx_TVALID == 1'b1 && m_axis_rx_TUSER[11:8] == 4'b0010 && m_axis_rx_TUSER[7:4] == 4'b0000 && m_axis_rx_TUSER[3:0] == 4'b0011 && next_flit == 1'b1) begin
            rd_data[255:64] <= m_axis_rx_TDATA[191:0];
            data_rx_flit_cnt <= data_rx_flit_cnt + 1'b1;
            chk_data <= 1'b1;
          end


          // If any errors were detected during any of the CASE 1-4 increment the error counters!
          data_rx_err_flit_cnt <= data_rx_err_flit_cnt + data_err_detect[3] + data_err_detect[2] + data_err_detect[1] + data_err_detect[0];
          // Increment received data FLITs!
          data_rx_flit_cnt <= data_rx_flit_cnt + flit[3] + flit[2] + flit[1] + flit[0];
          
        end
      endcase
    end    
  end

endmodule
