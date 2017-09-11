module gc2bin(gc,
	      bin
	      );

   // Top level block parameters
   parameter DATA_WIDTH = 8; // size of the gray code data

   // Input
   input wire [DATA_WIDTH-1:0] gc;
   genvar		       i;
   
   // Output
   output [DATA_WIDTH-1:0]     bin;

   // Generate according to implementation
   generate 
      for (i=0; i<DATA_WIDTH; i=i+1)
	begin : gc2bin
	   assign bin[i] = ^ gc[DATA_WIDTH-1:i];
	end
   endgenerate
   
endmodule

