`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company			: 
// Engineer			: 
// 
// Create Date		: 
// Project Name	: GML(General Module Library)
// Module Name		: iserdes_wrap 
// Description		: wrap ISERDES primitive of Virtex4/5 to realize serial-to-parallel convertion
//						  support 2,3,4,5,6,7,8 serialization rate in SDR mode;
//						  support 4,6,8,10 serialization rate in DDR mode
//
// Dependencies	: 
//
// Version			: v1.0
//////////////////////////////////////////////////////////////////////////////////


//Modified record--------
//date		by		Version	Modify	


module iserdes_wrap_adc
  #(
    parameter SERDES_RATIO = 4 //deserialization ratio
    )
   (/*AUTOARG*/
    // Outputs
    Q,
    // Inputs
    rst,
    clk,
    clk_div,
    D
    );
   //--Global----------------
   input		rst;
   input		clk;
   input		clk_div;
   //--Input serial data----
   input		D;
   //--Output parallel data--
   output [SERDES_RATIO-1:0] Q;
   //-----------------
   wire [7:0] Q_tmp;
   assign Q = Q_tmp[SERDES_RATIO-1:0];
reg rst_r1;
reg rst_r2;
always@(posedge clk_div)
begin
    rst_r1 <= rst;
    rst_r2 <= rst_r1;
end  
wire fifo_empty;
//reg  fifo_rd_en;
//always@(posedge clk_div or posedge rst_r2)
//   if(rst_r2)
//       begin
//           fifo_rd_en <= 1'b0; 
//       end
//   else
//       begin
//            if(fifo_empty)
//                fifo_rd_en <= 1'b0;
//            else
//                fifo_rd_en <= 1'b1;
//       end
   //------------------
        ISERDESE3 #(
              .DATA_WIDTH(SERDES_RATIO),  // Parallel data width (4,8)
              .FIFO_ENABLE("TRUE"),     // Enables the use of the FIFO
              .FIFO_SYNC_MODE("TRUE"),  // Enables the use of internal 2-stage synchronizers on the FIFO
              .IS_CLK_B_INVERTED(1'b0),  // Optional inversion for CLK_B
              .IS_CLK_INVERTED(1'b0),    // Optional inversion for CLK
              .IS_RST_INVERTED(1'b0),    // Optional inversion for RST
              .SIM_DEVICE("ULTRASCALE")  // Set the device version (ULTRASCALE, ULTRASCALE_PLUS_ES1)
           )
           ISERDESE3_inst (
              .FIFO_EMPTY(fifo_empty),            // 1-bit output: FIFO empty flag /*fifo_empty*/
              .Q(Q_tmp),                     // 8-bit registered output
              .CLK(clk),                 // 1-bit input: High-speed clock
              .CLKDIV(clk_div),          // 1-bit input: Divided Clock
              .CLK_B(~clk),              // 1-bit input: Inversion of High-speed clock CLK
              .D(D),                     // 1-bit input: Serial Data Input
              .FIFO_RD_CLK(clk_div),        // 1-bit input: FIFO read clock
              .FIFO_RD_EN(1'b1),         //fifo_rd_en 1-bit input: Enables reading the FIFO when asserted
              .RST(rst_r2),               // 1-bit input: Asynchronous Reset
              .INTERNAL_DIVCLK( )
           );


   
   
endmodule


