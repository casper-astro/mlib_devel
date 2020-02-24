`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:14 09/20/2012 
// Design Name: 
// Module Name:    ibufds_wrap 
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
module ibufds_wrap_adc
  #(
    parameter DATA_WIDTH = 10
    )
   (/*AUTOARG*/
    // Outputs
    dout,
    // Inputs
    din_p,
    din_n
    );
   input [DATA_WIDTH-1:0] din_p;
   input [DATA_WIDTH-1:0] din_n;
   output [DATA_WIDTH-1:0] dout;
   
   genvar 		   i;
   generate for(i=0;i<DATA_WIDTH;i=i+1)
     begin: ibufds_gen_adc
        IBUFDS #(
                 .DQS_BIAS("FALSE")       // 
                 ) 
	     IBUFDS_inst 
	             (
                     .O  (dout[i]),  // Buffer output
                     .I  (din_p[i]),  // Diff_p buffer input (connect directly to top-level port)
                     .IB (din_n[i]) // Diff_n buffer input (connect directly to top-level port)
                  );
     end
   endgenerate

endmodule  


