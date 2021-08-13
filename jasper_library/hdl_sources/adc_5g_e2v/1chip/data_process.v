`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:59 04/24/2014 
// Design Name: 
// Module Name:    data_process 
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
module data_process
#(
	 parameter SERDES_RATIO = 4
 )
   (
//		rst,
		clk_div_a, //156.25M
//		clk10m,
		dataA,
		dataB,
		dataC,
		dataD,
		//----OUTPUT----
		dataA_out,
		dataB_out,
		dataC_out,
		dataD_out
//		flag
    );	 
//	 input  rst; //active high
//	 input  clk10m;
	 input  clk_div_a;
	 input  [39:0] dataA;
	 input  [39:0] dataB;
	 input  [39:0] dataC;
	 input  [39:0] dataD;
//-------------------for debug---------------
//	 output  flag;
	 output  reg [39:0] dataA_out;
	 output  reg [39:0] dataB_out;
	 output  reg [39:0] dataC_out;
	 output  reg [39:0] dataD_out;	 
///////////////////transform data format////////////////////	 
reg [39:0] dataA_signed;
reg [39:0] dataB_signed;
reg [39:0] dataC_signed;
reg [39:0] dataD_signed;
	
	genvar i;
 //------------channel A-----------	 
    
    generate for(i=0;i<SERDES_RATIO;i=i+1)
       begin : format_A
			  always @(posedge clk_div_a)
				 begin
					 dataA_signed[(i+1)*10-1:i*10] <= dataA[(i+1)*10-1:i*10]-10'sd512;
				 end
       end
   endgenerate	 
//------------channel B-----------	 
    
   generate  for(i=0;i<SERDES_RATIO;i=i+1)
       begin : format_B
			  always @(posedge clk_div_a)
				 begin
					 dataB_signed[(i+1)*10-1:i*10] <= dataB[(i+1)*10-1:i*10]-10'sd512;
				 end
       end
   endgenerate
//------------channel C-----------	 
    
    generate for(i=0;i<SERDES_RATIO;i=i+1)
       begin : format_C
			  always @(posedge clk_div_a)
				 begin
					 dataC_signed[(i+1)*10-1:i*10] <= dataC[(i+1)*10-1:i*10]-10'sd512;
				 end
       end
   endgenerate	 	
//------------channel D-----------	 
   
    generate for(i=0;i<SERDES_RATIO;i=i+1)
       begin : format_D
			  always @(posedge clk_div_a)
				 begin
					 dataD_signed[(i+1)*10-1:i*10] <= dataD[(i+1)*10-1:i*10]-10'sd512;
				 end
       end
   endgenerate	 			
///////////////////register/////////////////////////
reg [39:0] dataA_reg;
reg [39:0] dataB_reg;
reg [39:0] dataC_reg;
reg [39:0] dataD_reg; 
	always@(posedge clk_div_a)
	begin
		dataA_reg <= dataA_signed;
		dataB_reg <= dataB_signed;
	    dataC_reg <= dataC_signed;
	    dataD_reg <= dataD_signed;
	end
////----------------------------------
//genvar m;
////------------A-----------------
//wire [39:0] dataA_off;
//generate for(m=0;m<4;m=m+1)
//    begin: sub_gen_A
//        c_addsub_0 inst_sub_A (
//          .A(dataA_reg[(m+1)*10-1:m*10]),      // input wire [9 : 0] A
//          .B(10'd4),      // input wire [9 : 0] B
//          .CLK(clk_div_a),  // input wire CLK
//          .CE(1'b1),    // input wire CE
//          .S(dataA_off[(m+1)*10-1:m*10])      // output wire [9 : 0] S
//        );
//    end
// endgenerate
 //------------B-----------------
// wire [39:0] dataB_off;
// generate for(m=0;m<4;m=m+1)
//     begin: sub_gen_B
//         c_addsub_0 inst_sub_B (
//           .A(dataB_reg[(m+1)*10-1:m*10]),      // input wire [9 : 0] A
//           .B(10'd4),      // input wire [9 : 0] B
//           .CLK(clk_div_a),  // input wire CLK
//           .CE(1'b1),    // input wire CE
//           .S(dataB_off[(m+1)*10-1:m*10])      // output wire [9 : 0] S
//         );
//     end
//  endgenerate
// //------------C-----------------
//  wire [39:0] dataC_off;
//  generate for(m=0;m<4;m=m+1)
//      begin: sub_gen_C
//          c_addsub_0 inst_sub_C (
//            .A(dataC_reg[(m+1)*10-1:m*10]),      // input wire [9 : 0] A
//            .B(10'd4),      // input wire [9 : 0] B
//            .CLK(clk_div_a),  // input wire CLK
//            .CE(1'b1),    // input wire CE
//            .S(dataC_off[(m+1)*10-1:m*10])      // output wire [9 : 0] S
//          );
//      end
//   endgenerate
//  //------------D-----------------
//   wire [39:0] dataD_off;
//   generate for(m=0;m<4;m=m+1)
//       begin: sub_gen_D
//           c_addsub_0 inst_sub_D (
//             .A(dataD_reg[(m+1)*10-1:m*10]),      // input wire [9 : 0] A
//             .B(10'd4),      // input wire [9 : 0] B
//             .CLK(clk_div_a),  // input wire CLK
//             .CE(1'b1),    // input wire CE
//             .S(dataD_off[(m+1)*10-1:m*10])      // output wire [9 : 0] S
//           );
//       end
//    endgenerate
//----------------------------------	
//reg [39:0] dataA_reg1;
//reg [39:0] dataB_reg1;
//reg [39:0] dataC_reg1;
//reg [39:0] dataD_reg1; 
//	always@(posedge clk_div_a)
//	begin
////		dataA_reg1 <= dataA_off;
////		dataB_reg1 <= dataB_off;
////	    dataC_reg1 <= dataC_off;
////	    dataD_reg1 <= dataD_off;
//		dataA_reg1 <= dataA_reg;
//        dataB_reg1 <= dataB_reg;
//        dataC_reg1 <= dataC_reg;
//        dataD_reg1 <= dataD_reg;
//	end
	always@(posedge clk_div_a)
    begin
	   dataA_out <= dataA_reg;
	   dataB_out <= dataB_reg;
	   dataC_out <= dataC_reg;
	   dataD_out <= dataD_reg;
	end
	//data output order: A C B D
//-----------data valid---------
//reg rst_r1;
//reg rst_r2;
//reg rst_r3;
//always@(posedge clk_div_a)
//begin
//    rst_r1 <= rst;
//    rst_r2 <= rst_r1;
//    rst_r3 <= rst_r2;
//end

//reg valid;
//always@(posedge clk10m or posedge rst)
//	if(rst)
//		valid <= 1'b0;
//	else
//		valid <= 1'b1;
		
//reg valid1;
//reg valid2;
////reg valid3;
//reg valid4;
//always@(posedge clk10m)
//begin
//	valid1 <= valid;
//	valid2 <= valid1;
////	valid3 <= valid2;
//	valid4 <= valid2;
//end
//assign  flag = valid4;

endmodule
