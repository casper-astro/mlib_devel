// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.

`timescale 1 ps / 1 ps

module seq_altera_hhp_apb2avalon_bridge #(
  parameter DWIDTH = 32,              // Data width
  parameter AWIDTH = 10,              // Address width
  parameter BYTEENABLE_WIDTH = 4,     // Byteenable width
  parameter BURSTCOUNT_WIDTH = 1      // Burstcount width
)(
//Clock and Reset
  clk_p,
  sp_reset_n,

//APB Slave Port
  paddr,
  psel,
  penable,
  pwrite,
  pwdata,
  pready,
  prdata,
  pslverr,
  
//Avalon Master Port
  av_beginbursttransfer,
  av_burstcount,
  av_addr,
  av_write,
  av_read,
  av_writedata,
  av_readdata,
  av_rdata_valid,
  av_byteenable,
  av_waitrequest,
  debug_hphy_reg,
  debug_hphy_comb
);

// State declaration
parameter [5:0] 
    IDLE        =6'b000001,
    SETUP       =6'b000010,
    WRITE_ACCESS=6'b000100,
    READ_ACCESS =6'b001000,
    RD_WAIT     =6'b010000,
    READY       =6'b100000;

//Clock and Reset
input clk_p;
input sp_reset_n;

//APB Signals
input [DWIDTH-1:0] pwdata;
input [AWIDTH-1:0] paddr;
input psel;
input penable;
input pwrite;

output pslverr;
output reg pready;
output reg [DWIDTH-1:0] prdata;

//Avalon Signals
input [DWIDTH-1:0] av_readdata;
input av_rdata_valid;
input av_waitrequest;

output reg av_beginbursttransfer;
output [BURSTCOUNT_WIDTH-1:0] av_burstcount;
output [AWIDTH-1:0] av_addr;
output reg av_write;
output reg av_read;
output [BYTEENABLE_WIDTH-1:0] av_byteenable;
output [DWIDTH-1:0] av_writedata;

// State FF
reg [5:0] state;


//debug signals
output wire [8:0] debug_hphy_reg;
output wire       debug_hphy_comb;



always @ (posedge clk_p or negedge sp_reset_n)
begin
    if (!sp_reset_n) begin
        state <= IDLE;
        pready <= 1'b0;
        av_write <= 1'b0;
        av_read <= 1'b0;
        av_beginbursttransfer <= 'b0;
        prdata <= 'b0;
    end else
        case(state)
            IDLE: 
                if (psel)
                    begin
                        state <= SETUP;
                        av_write <= 1'b0;
                        av_read <= 1'b0;
                        pready <= 1'b0;
                        prdata <= 'b0;
                    end
                else
                    begin
                        state <= IDLE;
                        av_write <= 1'b0;
                        av_read <= 1'b0;
                        pready <= 1'b0;
                        prdata <= 'b0;
                    end
            
            SETUP:
                if (penable & pwrite)
                    begin
                        state <= WRITE_ACCESS;
                        av_write <= 1'b1;
                        av_read <= 1'b0;
                        av_beginbursttransfer <= 1'b1;
                    end
                else if (penable & !pwrite)
                    begin
                        state <= READ_ACCESS;
                        av_write <= 1'b0;
                        av_read <= 1'b1;
                        av_beginbursttransfer <= 1'b1;
                    end
                else
                    state <= SETUP;
            
            WRITE_ACCESS:
                if (!av_waitrequest)
                    begin
                        state <= READY;
                        pready <= 1'b1;
                        av_write <= 1'b0;
                        av_read <= 1'b0;
                        av_beginbursttransfer <= 1'b0;
                    end
                else
                    begin
                        state <= WRITE_ACCESS;
                        av_beginbursttransfer <= 1'b0;
                    end
            
            READ_ACCESS: 
                if (!av_waitrequest)
                    begin
                        av_write <= 1'b0;
                        av_read <= 1'b0;
                        av_beginbursttransfer <= 1'b0;
                        if (av_rdata_valid) begin
                            state <= READY;
                            pready <= 1'b1;
                            prdata <= av_readdata;
                        end else begin
                            state <= RD_WAIT;
                            pready <= 1'b0;  
                        end
                    end
                else
                    begin
                        av_beginbursttransfer <= 1'b0;
                        state <= READ_ACCESS;
                    end
            
            RD_WAIT: 
                if (av_rdata_valid) begin
                   state <= READY;
                   pready <= 1'b1;
                   prdata <= av_readdata;
                end else
                   state <= RD_WAIT;
            
            READY:
                begin
                    state <= IDLE;
                    av_write <= 1'b0;
                    av_read <= 1'b0;
                    pready <= 1'b0;
                    prdata <= 'b0;
                end
            default : state <= IDLE;
        endcase
end

assign av_writedata = pwdata;
assign av_byteenable = {BYTEENABLE_WIDTH{1'b1}}; //Tie byteenable to 1
assign av_burstcount = 'b1; //Tie burstcount to 1
assign av_addr = paddr;
assign pslverr = 1'b0; //Tie pslverr to 0

function integer log2;  //constant function
  input integer value;
  begin
    if (value > 1)
      value = value -1;
    for (log2=0; value>0; log2=log2+1)
      value = value>>1;
  end
endfunction


//debug signals
assign debug_hphy_reg  = {state[5:0],pready,av_write,av_read};
assign debug_hphy_comb = {av_waitrequest};


endmodule
