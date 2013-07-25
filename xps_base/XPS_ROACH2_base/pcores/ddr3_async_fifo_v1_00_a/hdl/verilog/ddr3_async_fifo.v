/*=======================================

Filename: ddr3_async_fifo.v
Author: JP J.van Rensburg
Date: 24-06-2013
Description: This is an asynchronous FIFO used in the DDR3 DRAM design for the ROACH-2. This module buffers the write/read data between the User Application and the UI of the DRAM controller. This module ensures that the user application can be clocked off a seperate (slower) clock which ensures that there is no buffer overflow and long write bursts can be handled.

=======================================*/
`timescale 1ns / 1ps

module ddr3_async_fifo #(
) (
//Simulink Memory interface ports
input 			ui_app_clk, //This is the Simulink design fabric clock
input			ui_rst,
input [31:0]		ui_addr,
input			ui_cmd,
input [287:0]		ui_wr_data,
input [35:0]		ui_wr_mask,
input 			ui_wr_en,

output [287:0]		ui_rd_data,
output			ui_rd_valid,
output			ui_cmd_ack,

//DDR3 Controller UI interface ports
input			ddr3_app_clk,//This is the DDR3's UI application clock
input [287:0]		app_rd_data,
input			app_rd_data_end,
input			app_rd_data_valid,
input			app_rdy,
input			app_wdf_rdy,
input			phy_rdy,

output [31:0]		app_addr,
output [2:0]		app_cmd,
output			app_en,
output [287:0]		app_wdf_data,
output 			app_wdf_end,
output [35:0]		app_wdf_mask,
output			app_wdf_wren

);

reg [3:0]	fifo_rst_reg;
wire		fifo_rst;

//reset fifo - pg 125 FIFO Core generator v9.3v mentions that it takes 3 CLK
//cycles for synchronisation after a rst.
always @(posedge ui_app_clk) begin
    if (ui_rst == 1'b1) begin
      fifo_rst_reg <= 4'b0001;
    end else begin
      fifo_rst_reg <= {fifo_rst_reg[2:0], 1'b0};
    end
  end

assign fifo_rst = |fifo_rst_reg;

//Clock data&cmd into the TX FIFO with ui_app_clk 
wire [323:0]	din_tx_fifo;
wire		full_tx_fifo;
wire		ui_en;

reg		full_tx_fifo_reg;
reg		ui_en_reg;

always @(posedge ui_app_clk) begin
full_tx_fifo_reg	<= ~full_tx_fifo;
end

always @(posedge ui_app_clk) begin //controls the en signal of the UI of the DDR3 controller 
	if (ui_rst == 1'b1) begin
		ui_en_reg  <= 1'b0;
	end else if (ui_wr_en == 1'b1) begin
		if (ui_cmd == 1'b0) begin
		ui_en_reg <= ui_en_reg+1;
		end
	end
end

assign ui_en = ui_cmd?ui_wr_en:ui_en_reg;
assign din_tx_fifo = {ui_addr,ui_en,{2'b00,ui_cmd},ui_wr_data};
assign ui_cmd_ack = full_tx_fifo_reg;

//Clock data&cmd out of the TX FIFO with ddr3_app_clk
wire 		empty_tx_fifo;
wire		app_tx_fifo_empty;
wire 		rd_en_tx_fifo;
wire [323:0]	dout_tx_fifo; 
wire [323:0]	app_data;

reg [4:0] 	empty_tx_fifo_reg;
reg [1:0]	rd_en_tx_fifo_reg;
reg [323:0]	dout_tx_fifo_reg[3:0];
reg [72:0]	last_word_tx_fifo_reg;

reg [1:0]	app_rdy_fail_reg;
reg [1:0]	app_wdf_rdy_fail_reg;
reg		app_rdy_fail;
reg		app_wdf_rdy_fail;

integer		i;//Interger in the for loop (shift register)

//Controls reading out of the TX FIFO
always @(posedge ddr3_app_clk) begin 
	if (app_rdy && app_wdf_rdy) begin
		rd_en_tx_fifo_reg	<= {rd_en_tx_fifo_reg[0],1'b1};
	end else begin
		rd_en_tx_fifo_reg	<= {2{1'b0}};
	end
	if (rd_en_tx_fifo_reg[1] == 1'b1) begin
			dout_tx_fifo_reg[0]	<= dout_tx_fifo;
		for (i=1;i<4;i=i+1) begin
			dout_tx_fifo_reg[i]	<= dout_tx_fifo_reg[i-1];
		end
	end
	if (rd_en_tx_fifo_reg[1] == 1'b1) begin
		empty_tx_fifo_reg <= {empty_tx_fifo_reg[3:0],~empty_tx_fifo};
	end
end

reg	app_rdy_reg;
reg	app_wdf_rdy_reg;

//delay app_rdy and app_wdf_rdy by 1 CLK cycle
always @(posedge ddr3_app_clk) begin
app_rdy_reg	<= app_rdy;
app_wdf_rdy_reg	<= app_wdf_rdy;
end

//Ensures that the last cmd that was written to the UI of the DDR3 controller is resent once app_rdy is asserted
always @(posedge ddr3_app_clk) begin
	app_rdy_fail_reg 		<= {app_rdy_fail_reg[0],app_rdy};
	if (rd_en_tx_fifo_reg[0] == 1'b1) begin
		app_rdy_fail		<= 1'b0;
	end else if (ddr3_ui_rdy == 1'b1) begin
		app_rdy_fail		<= 1'b1;
	end else if (app_rdy_fail_pulse_neg_edge & app_wdf_rdy_reg & app_wdf_rdy_fail_pulse_pos_edge  == 1'b1) begin
		app_rdy_fail		<= 1'b1;
	end
end

wire	app_rdy_fail_pulse_neg_edge;
wire	app_rdy_fail_pulse_pos_edge;
assign  app_rdy_fail_pulse_neg_edge	= app_rdy_fail_reg[1] && ~app_rdy_reg;
assign	app_rdy_fail_pulse_pos_edge	= app_rdy_fail_reg[1] || ~app_rdy_reg; 

//Ensures that the last word that was written to the UI of the DDR3 controller is resent once app_wdf_rdy is asserted
always @(posedge ddr3_app_clk) begin
	app_wdf_rdy_fail_reg 		<= {app_wdf_rdy_fail_reg[0],app_wdf_rdy};
	if (rd_en_tx_fifo_reg[0] == 1'b1) begin
		app_wdf_rdy_fail		<= 1'b0;
	end else if (ddr3_ui_rdy == 1'b1) begin
		app_wdf_rdy_fail		<= 1'b1;
	end else if (app_wdf_rdy_fail_pulse_neg_edge && app_rdy_reg && app_rdy_fail_pulse_pos_edge == 1'b1) begin
		app_wdf_rdy_fail		<= 1'b1;
	end
end
//Note -The app_rdy/app_wdf_rdy states described below are unlikely, but never
//the less worth checking for.
//If either app_rdy/app_wdf_rdy goes high when the other one goes low at the
//same clock cycle - controls the re-issuing of the correct cmd/word.
wire	app_wdf_rdy_fail_pulse_neg_edge;
wire	app_wdf_rdy_fail_pulse_pos_edge;
assign 	app_wdf_rdy_fail_pulse_neg_edge	= app_wdf_rdy_fail_reg[1] && ~app_wdf_rdy_reg;
assign 	app_wdf_rdy_fail_pulse_pos_edge = app_wdf_rdy_fail_reg[1] || ~app_wdf_rdy_reg;

//Controls the re-issuing of the correct cmd/word if there is a single clock
//cycle between app_rdy/app_wdf_rdy becoming asserted and then becoming
//deasserted.
//
reg [1:0] app_rdy_fail_pulse_pos_edge_reg;
reg [1:0] app_wdf_rdy_fail_pulse_pos_edge_reg;

always @(posedge ddr3_app_clk) begin
app_rdy_fail_pulse_pos_edge_reg <= {app_rdy_fail_pulse_pos_edge_reg[0],!app_rdy_fail_pulse_pos_edge};
app_wdf_rdy_fail_pulse_pos_edge_reg <= {app_wdf_rdy_fail_pulse_pos_edge_reg[0],!app_wdf_rdy_fail_pulse_pos_edge};
end

reg		ddr3_ui_rdy;
reg [1:0]	ddr3_ui_rdy_reg;
reg		ddr3_ui_rdy_neg_edge;
reg [1:0] 	ddr3_ui_rdy_pos_edge;
//Controls the re-issuing of the correct cmd/word if there is a single clock
//cycle between either app_rdy/app_wdf_rdy becoming asserted and the other
//being deasserted. 
always @(posedge ddr3_app_clk) begin
ddr3_ui_rdy_reg		= {ddr3_ui_rdy_reg[0],app_rdy && app_wdf_rdy};
ddr3_ui_rdy_neg_edge	<= ddr3_ui_rdy_reg[1] && ~(app_rdy && app_wdf_rdy);
ddr3_ui_rdy_pos_edge	<= {ddr3_ui_rdy_pos_edge[0],!(ddr3_ui_rdy_reg[1] || ~(app_rdy && app_wdf_rdy))};
end

always @(posedge ddr3_app_clk) begin
	if (rd_en_tx_fifo_reg[0] == 1'b1) begin
	       	ddr3_ui_rdy	<= 1'b0;
	end else if (app_wdf_rdy_fail_pulse_pos_edge_reg[0] && app_wdf_rdy_fail_pulse_neg_edge == 1'b1) begin
		ddr3_ui_rdy	<= 1'b0;
	end else if (app_rdy_fail_pulse_pos_edge_reg[0] && app_rdy_fail_pulse_neg_edge == 1'b1) begin
		ddr3_ui_rdy	<= 1'b0;
	end else if (ddr3_ui_rdy_neg_edge && ddr3_ui_rdy_pos_edge[1] == 1'b1) begin
		ddr3_ui_rdy	<= 1'b1;
       	end
end

//Combinational logic controlling the UI signals of the DDR3 controller
assign app_data 		= rd_en_tx_fifo_reg[1]?dout_tx_fifo_reg[2]:dout_tx_fifo_reg[3];
assign app_tx_fifo_empty 	= rd_en_tx_fifo_reg[1]? empty_tx_fifo_reg[3]:empty_tx_fifo_reg[4];
assign rd_en_tx_fifo 	 	= rd_en_tx_fifo_reg[1];   

assign app_en 		 	= rd_en_tx_fifo_reg[0] && app_data[291] && app_tx_fifo_empty && ~app_wdf_rdy_fail; 
assign app_cmd 		 	= {2'b00,rd_en_tx_fifo_reg[0] & app_data[288] & app_tx_fifo_empty & ~app_wdf_rdy_fail};
assign app_addr 	 	= app_data[323:292] << 3;//Shift left by 3 binary positions to ensure BL8 addressing for the DDR3 controller.
assign app_wdf_data 	 	= app_data[287:0];
assign app_wdf_end 	 	= rd_en_tx_fifo_reg[0] && ~app_data[288] && app_data[291] & app_tx_fifo_empty && ~app_rdy_fail;
assign app_wdf_wren 	 	= rd_en_tx_fifo_reg[0] && ~app_data[288] && app_tx_fifo_empty && ~app_rdy_fail;
assign app_wdf_mask 	 	= ui_wr_mask;

ddr3_async_tx_fifo ddr3_async_tx_fifo_inst (
  .rst(fifo_rst), // input rst
  .wr_clk(ui_app_clk), // input wr_clk
  .rd_clk(ddr3_app_clk), // input rd_clk
  .din(din_tx_fifo), // input [323 : 0] din
  .wr_en(ui_wr_en), // input wr_en
  .rd_en(rd_en_tx_fifo), // input rd_en
  .dout(dout_tx_fifo), // output [323 : 0] dout
  .full(full_tx_fifo), // output full
  .empty(empty_tx_fifo) // output empty
);

//Clock data into the RX FIFO with ddr3_app_clk

reg [287:0]	din_rx_fifo_reg;
reg		wr_en_rx_fifo_reg;
reg [1:0]	ui_rd_valid_reg;

wire [287:0]	din_rx_fifo;
wire		wr_en_rx_fifo;
wire		empty_rx_fifo;

always @(posedge ddr3_app_clk) begin
din_rx_fifo_reg		<= app_rd_data;
wr_en_rx_fifo_reg	<= app_rd_data_valid;
end

always @(posedge ui_app_clk) begin
ui_rd_valid_reg		<= {ui_rd_valid_reg[0],~empty_rx_fifo};
end

assign din_rx_fifo	= din_rx_fifo_reg;
assign wr_en_rx_fifo	= wr_en_rx_fifo_reg;
assign ui_rd_valid	= &ui_rd_valid_reg;

wire	full_rx_fifo;

ddr3_async_rx_fifo ddr3_async_rx_fifo_inst (
  .rst(fifo_rst), // input rst
  .wr_clk(ddr3_app_clk), // input wr_clk
  .rd_clk(ui_app_clk), // input rd_clk
  .din(din_rx_fifo), // input [287 : 0] din
  .wr_en(wr_en_rx_fifo), // input wr_en
  .rd_en(ui_rd_valid_reg[0]), // input rd_en
  .dout(ui_rd_data), // output [287 : 0] dout
  .full(full_rx_fifo), // output full
  .empty(empty_rx_fifo) // output empty
);

endmodule


