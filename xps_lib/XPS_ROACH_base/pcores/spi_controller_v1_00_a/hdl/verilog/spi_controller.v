`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:46 05/19/2010 
// Design Name: 
// Module Name:    spi_interface 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spi_controller(
    input clk,
    input [7:0] data,
    input wr_strobe,
    output sdata,
    output sclk,
    output cs_n
    );

  localparam IDLE_STATE    = 1'b0;
  localparam SENDING_STATE = 1'b1;
  reg [2:0] counter;
  reg wr_strobe_z;
  reg state;
  reg sdata_reg;
  reg cs_n_reg;
  reg [5:0] ce_ctr = 0;
  reg ce_reg;
  
  assign ce=ce_reg;
  
  assign sclk  = ce_ctr[5];
  assign sdata = sdata_reg;
  assign cs_n  = cs_n_reg;

  always @(posedge clk) begin
     ce_ctr <= ce_ctr +1;
	  if (ce_ctr==0) begin
	    ce_reg <= 1'b1;
	  end else begin
	    ce_reg <= 1'b0;
	  end
  end


  always @(posedge clk) begin
  if (ce_reg) begin
    case (state)
	   IDLE_STATE: begin
		  counter   <= 7;
		  cs_n_reg  <= 1;
		  sdata_reg <= 0;
		  wr_strobe_z <= wr_strobe;
	     if (~wr_strobe_z && wr_strobe) begin
	       state <= SENDING_STATE;
		  end else begin
			 state <= IDLE_STATE;
		  end
		end
		SENDING_STATE: begin
		  cs_n_reg  <= 0;
		  sdata_reg <= data[counter];
		  counter   <= counter-1;
		  if (counter==0) begin
		    state <= IDLE_STATE;
		  end else begin
		    state <= SENDING_STATE;
		  end
		end
      default: begin
        state <= IDLE_STATE;
		end
    endcase
  end
  end

endmodule
