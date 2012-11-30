/*
 
 Modified version of: 
 XPS_ROACH2_BASE/pcores/opb_katcontroller/hdl/verilog/opb_katcontroller.v
 
 */
module opb_adc16_controller(
    input         OPB_Clk,
    input         OPB_Rst,
    output [0:31] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input         OPB_RNW,
    input         OPB_select,
    input         OPB_seqAddr,

	  output        adc0_adc3wire_clk,
	  output        adc0_adc3wire_data,
	  output        adc0_adc3wire_cs0,
	  output        adc0_adc3wire_cs1,
	  output        adc0_adc3wire_cs2,
	  output        adc0_adc3wire_cs3,
	  
	  output        adc0_reset,
	  output        [0:3] adc0_iserdes_bitslip,
         output        [0:3] adc0_load_phase_set,
	  
	  output        [0:15] adc0_delay_rst,
	  output        [0:4] adc0_delay_tap
  );
  parameter C_BASEADDR    = 32'h00000000;
  parameter C_HIGHADDR    = 32'h0000FFFF;
  parameter C_OPB_AWIDTH  = 32;
  parameter C_OPB_DWIDTH  = 32;
  parameter C_FAMILY      = "";

  /********* Global Signals *************/

  wire [0:31] adc0_adc3wire_wire;
  wire [0:31] adc0_ctrl_wire;

  /************ OPB Logic ***************/

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;

  reg opb_ack;

  /*** Registers ****/

  /* ADC0 3-Wire Register */
  reg [0:31] adc0_adc3wire_reg;
  assign adc0_adc3wire_wire = adc0_adc3wire_reg;

  /* ======================================= */
  /* ADC0 3-Wire Register Bits               */
  /* ======================================= */
  /* C = SCL (clock)                         */
  /* D = SDA (data)                          */
  /* 0 = CS0 (chip select 0)                 */
  /* 1 = CS0 (chip select 1)                 */
  /* 2 = CS0 (chip select 2)                 */
  /* 3 = CS0 (chip select 3)                 */
  /* ======================================= */
  /* |<-- MSb                       LSb -->| */
  /* 0000_0000_0011_1111_1111_2222_2222_2233 */
  /* 0123_4567_8901_2345_6789_0123_4567_8901 */
  /* C--- ---- ---- ---- ---- ---- ---- ---- */
  /* -D-- ---- ---- ---- ---- ---- ---- ---- */
  /* --0- ---- ---- ---- ---- ---- ---- ---- */
  /* ---1 ---- ---- ---- ---- ---- ---- ---- */
  /* ---- 2--- ---- ---- ---- ---- ---- ---- */
  /* ---- -3-- ---- ---- ---- ---- ---- ---- */
  /* ======================================= */

  assign adc0_adc3wire_clk  = adc0_adc3wire_wire[0];
  assign adc0_adc3wire_data = adc0_adc3wire_wire[1];
  assign adc0_adc3wire_cs0  = adc0_adc3wire_wire[2];
  assign adc0_adc3wire_cs1  = adc0_adc3wire_wire[3];
  assign adc0_adc3wire_cs2  = adc0_adc3wire_wire[4];
  assign adc0_adc3wire_cs3  = adc0_adc3wire_wire[5];

  /* ADC0 Control Register */
  reg [0:31] adc0_ctrl_reg;
  assign adc0_ctrl_wire = adc0_ctrl_reg;

  /* ======================================= */
  /* ADC0 Control Register Bits              */
  /* ======================================= */
  /* D = Delay RST                           */
  /* T = Delay Tap                           */
  /* B = ISERDES Bit Slip                    */
  /* P = Load Phase Set                      */
  /* R = Reset                               */
  /* ======================================= */
  /* |<-- MSb                       LSb -->| */
  /* 0000 0000 0011 1111 1111 2222 2222 2233 */
  /* 0123 4567 8901 2345 6789 0123 4567 8901 */
  /* DDDD DDDD DDDD DDDD ---- ---- ---- ---- */
  /* ---- ---- ---- ---- TTTT T--- ---- ---- */
  /* ---- ---- ---- ---- ---- -BBB B--- ---- */
  /* ---- ---- ---- ---- ---- ---- -PPP P--- */
  /* ---- ---- ---- ---- ---- ---- ---- -R-- */
  /* ======================================= */

  assign adc0_delay_rst       = adc0_ctrl_wire[ 0:15];
  assign adc0_delay_tap       = adc0_ctrl_wire[16:20];
  assign adc0_iserdes_bitslip = adc0_ctrl_wire[21:24];
  assign adc0_load_phase_set  = adc0_ctrl_wire[25:28];
  assign adc0_reset           = adc0_ctrl_wire[29   ];

  reg [31:0] opb_data_out;

  always @(posedge OPB_Clk) begin
    opb_ack <= 1'b0;

    adc0_adc3wire_reg <= adc0_adc3wire_reg;
    adc0_ctrl_reg <= adc0_ctrl_reg;

    if (OPB_Rst) begin
    end else begin
      if (addr_match && OPB_select && !opb_ack) begin
        if (!OPB_RNW) begin
          case (opb_addr[2])
           0:  begin
	            opb_ack <= 1'b1;
	            if (OPB_BE[0]) begin
                    adc0_adc3wire_reg[0:7] <= OPB_DBus[0:7];
	            end
	            if (OPB_BE[1]) begin
                    adc0_adc3wire_reg[8:15] <= OPB_DBus[8:15];
	            end
	            if (OPB_BE[2]) begin
                    adc0_adc3wire_reg[16:23] <= OPB_DBus[16:23];
	            end
	            if (OPB_BE[3]) begin
                    adc0_adc3wire_reg[24:31] <= OPB_DBus[24:31];
	            end
           end
           1:  begin
	            opb_ack <= 1'b1;
	            if (OPB_BE[0]) begin
                    adc0_ctrl_reg[0:7] <= OPB_DBus[0:7];
	            end
	            if (OPB_BE[1]) begin
                    adc0_ctrl_reg[8:15] <= OPB_DBus[8:15];
	            end
	            if (OPB_BE[2]) begin
                    adc0_ctrl_reg[16:23] <= OPB_DBus[16:23];
	            end
	            if (OPB_BE[3]) begin
                    adc0_ctrl_reg[24:31] <= OPB_DBus[24:31];
	            end
           end
		  endcase
        end else begin // if (!OPB_RNW)
	      case (opb_addr[2])
	       0:  begin
	               opb_ack <= 1'b1;
	               opb_data_out <= adc0_adc3wire_reg;
	           end
	       1:  begin
	               opb_ack <= 1'b1;
	               opb_data_out <= adc0_ctrl_reg;
	           end
	      endcase
	    end
      end
    end
  
  
  end

  assign Sl_DBus     = Sl_xferAck ? opb_data_out : 32'b0;
  assign Sl_errAck   = 1'b0;
  assign Sl_retry    = 1'b0;
  assign Sl_toutSup  = 1'b0;
  assign Sl_xferAck  = opb_ack;

endmodule
