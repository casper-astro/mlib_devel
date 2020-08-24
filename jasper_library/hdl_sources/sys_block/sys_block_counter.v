//============================================================================//
//                                                                            //
//      Parameterize Counter                                                  //
//                                                                            //
//      Module name: counter                                                  //
//      Desc: parameterized counter, counts up/down in any increment          //
//      Date: Oct 2011                                                        //
//      Developer: Rurik Primiani & Wesley New                                //
//      Adapted by: Mathews Chirindo                                          //
//      Date: Jan 2020                                                        //
//      Licence: GNU General Public License ver 3                             //
//      Notes:                                                                //
//                                                                            //
//============================================================================//

module sys_block_counter #(
      //==============================
      // Top level block parameters
      //==============================
      parameter DATA_WIDTH   = 32,               // number of bits in counters
      parameter COUNT_FROM   = 0,               // start with this number
      parameter COUNT_TO     = 2**(DATA_WIDTH), // value to count to in CL case
      parameter STEP         = 1                // negative or positive, sets direction
   ) (
      //===============
      // Input Ports
      //===============
      input user_clk,
      input en,
      input user_rst,

      //===============
      // Output Ports
      //===============
      output reg [DATA_WIDTH-1:0] count_out,
      output we
   );
   
   assign we = 1'b1;
   
// Synchronous logic
   always @(posedge user_clk) begin
      // if ACTIVE_LOW_RST is defined then reset on a low
      // this should be defined on a system-wide basis
       if (`ifdef ACTIVE_LOW_RST user_rst `else !user_rst `endif) begin
         if (en == 1) begin
           count_out <= count_out + STEP;
         end
       end 
       else begin
         count_out <= COUNT_FROM;
       end // else: if(rst != 0)
   end
endmodule

