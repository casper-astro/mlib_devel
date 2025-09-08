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



`timescale 1 ps / 1 ps
module alt_mem_ddrx_buffer
# (
    // module parameter port list
    parameter
        ADDR_WIDTH    =    3,
        DATA_WIDTH    =    8
)
(
    // port list
    ctl_clk,
    ctl_reset_n,

    // write interface
    write_valid,
    write_address,
    write_data,

    // read interface
    read_valid,
    read_address,
    read_data
);

    // -----------------------------
    // local parameter declaration
    // -----------------------------

    localparam  BUFFER_DEPTH    =  two_pow_N(ADDR_WIDTH); 

    // -----------------------------
    // port declaration
    // -----------------------------

    input                           ctl_clk;
    input                           ctl_reset_n;
    
    // write interface
    input                           write_valid;
    input   [ADDR_WIDTH-1:0]        write_address;
    input   [DATA_WIDTH-1:0]        write_data;

    // read interface
    input                           read_valid;
    input   [ADDR_WIDTH-1:0]        read_address;
    output  [DATA_WIDTH-1:0]        read_data;


    // -----------------------------
    // port type declaration
    // -----------------------------

    wire                            ctl_clk;
    wire                            ctl_reset_n;
                                                   
    // write interface                             
    wire                            write_valid;
    wire    [ADDR_WIDTH-1:0]        write_address;
    wire    [DATA_WIDTH-1:0]        write_data;
                                                   
    // read interface                              
    wire                            read_valid;
    wire    [ADDR_WIDTH-1:0]        read_address;
    wire    [DATA_WIDTH-1:0]        read_data;
    // memory size

    reg     [DATA_WIDTH-1:0]        memory_storage  [BUFFER_DEPTH-1:0];
    reg     [DATA_WIDTH-1:0]        read_data_reg;

    integer i;
    integer j;
//    integer w_mem_depth = two_pow_N(write_address);
  //  integer r_mem_depth = two_pow_N(read_address);
//  always @ (posedge ctl_clk or negedge ctl_reset_n)
   
   assign   read_data =  read_data_reg;
   
   always @ (posedge ctl_clk, negedge ctl_reset_n) begin 
      if (ctl_reset_n == 1'b0)
        for (i=0; i<BUFFER_DEPTH; i=i+1) begin
             for (j=0; j<DATA_WIDTH; j=j+1) begin 
                memory_storage[i][j] <= 1'b0; 
 	     end
        end
     else
       begin
	  
	  if ( write_valid == 1'b1) 
	    memory_storage[write_address] <= write_data;
	  
	  read_data_reg <= memory_storage[read_address];
       end
  end
   
    // -----------------------------
    // module definition
    // -----------------------------
   



    function integer two_pow_N;
        input integer value;
    begin
        two_pow_N = 2 << (value-1);
    end
    endfunction


endmodule
