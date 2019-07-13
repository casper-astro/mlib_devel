//============================================================================//
//                                                                            //
//      Parameterize Counter                                                  //
//                                                                            //
//      Module name: counter                                                  //
//      Desc: parameterized counter, counts up/down in any increment          //
//      Date: Oct 2011                                                        //
//      Developer: Rurik Primiani & Wesley New                                //
//      Licence: GNU General Public License ver 3                             //
//      Notes:                                                                //
//                                                                            //
//============================================================================//

module counter #(
      //==============================
      // Top level block parameters
      //==============================
      parameter DATA_WIDTH   = 8,               // number of bits in counter
      parameter COUNT_FROM   = 0,               // start with this number
      parameter COUNT_TO     = 2**(DATA_WIDTH), // value to count to in CL case
      parameter STEP         = 1                // negative or positive, sets direction
   ) (
      //===============
      // Input Ports
      //===============
      input clk,
      input en,
      input rst,

      //===============
      // Output Ports
      //===============
      output reg [DATA_WIDTH-1:0] count
   );

   // Synchronous logic
   always @(posedge clk) begin
      // if ACTIVE_LOW_RST is defined then reset on a low
      // this should be defined on a system-wide basis
      if ((`ifdef ACTIVE_LOW_RST rst `else !rst `endif) && count < COUNT_TO) begin
         if (en == 1) begin
            count <= count + STEP;
         end
      end else begin
         count <= COUNT_FROM;
      end // else: if(rst != 0)
   end
endmodule

