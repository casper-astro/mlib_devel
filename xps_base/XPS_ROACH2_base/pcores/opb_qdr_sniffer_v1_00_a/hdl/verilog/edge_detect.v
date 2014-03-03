//============================================================================//
//                                                                            //
//      Counter test bench                                                    //
//                                                                            //
//      Module name: counter_tb                                               //
//      Desc: runs and tests the counter module, and provides and interface   //
//            to test the module from Python (MyHDL)                          //
//      Date: Oct 2011                                                        //
//      Developer: Rurik Primiani & Wesley New                                //
//      Licence: GNU General Public License ver 3                             //
//      Notes: This only tests the basic functionality of the module, more    //
//             comprehensive testing is done in the python test file          //
//                                                                            //
//============================================================================//

module edge_detect #(

      //===================
      // local parameters
      //===================
      parameter DATA_WIDTH = 8,
      parameter EDGE_TYPE  = "RISE"
   ) (
      //=============
      // local regs
      //=============
      input clk,
      input en,
      input [DATA_WIDTH-1:0] in,
      
      //==============
      // local wires
      //==============
      output [DATA_WIDTH-1:0] pulse_out
   );

   reg [DATA_WIDTH-1:0] delay_reg;
   reg [DATA_WIDTH-1:0] pulse_out_reg;

   always@(posedge clk) begin
      delay_reg     <= in;
      pulse_out_reg <= in & ~delay_reg;
   end

   assign pulse_out = pulse_out_reg;

endmodule
