/*************************************************************************************************************************
* Module: async
* Author: Henno Kriel
* Date: 22 Jan 2018
* 
* Description: 
* Domain Cross Sync 
*************************************************************************************************************************/

module async #(
    //Define width of the datapath
    parameter BUS_WIDTH = 32  // Max 64 bits

)(
    input  wire RST,
    input  wire CLK,
    input  wire [BUS_WIDTH-1:0] BUS_IN, 
    output wire [BUS_WIDTH-1:0] BUS_OUT
);

(* shreg_extract = "no", ASYNC_REG = "TRUE", KEEP = "TRUE" *) reg [BUS_WIDTH-1:0] bus_syncR;
(* shreg_extract = "no", ASYNC_REG = "TRUE", KEEP = "TRUE" *) reg [BUS_WIDTH-1:0] bus_syncRR, bus_syncRRR;

always @(posedge CLK) begin 
  if (RST == 1'b1) begin
    bus_syncR <= {BUS_WIDTH{1'b0}}; 
    bus_syncRR <= {BUS_WIDTH{1'b0}}; 
    bus_syncRRR <= {BUS_WIDTH{1'b0}};  
  end else begin
    bus_syncR <= BUS_IN;
    bus_syncRR <= bus_syncR;
    bus_syncRRR <= bus_syncRR;
  end
end

assign BUS_OUT = bus_syncRRR;

endmodule

`default_nettype wire

