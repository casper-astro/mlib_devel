//============================================================================//
//                                                                            //
//      Parameterize Clock Domain Crosser                                     //
//                                                                            //
//      Module name: clk_domain_crosser                                       //
//      Desc: parameterized module to move data demains clock domains         //
//      Date: Sept 2013                                                       //
//      Developer: Wesley New                                                 //
//      Licence: GNU General Public License ver 3                             //
//      Notes: this module uses 2 registers to syncronize between clock       //
//             domains                                                        //
//                                                                            //
//============================================================================//

module clk_domain_crosser #(
      parameter DATA_WIDTH = 32
   ) (
      //===============
      // Input Ports
      //===============
      input                  in_clk,
      input                  out_clk,
      input                  rst,
      input [DATA_WIDTH-1:0] data_in,

      //===============
      // Output Ports
      //===============
      output [DATA_WIDTH-1:0] data_out
   );

   reg [DATA_WIDTH-1:0] data_out_meta;
   reg [DATA_WIDTH-1:0] data_out_reg_0;
   reg [DATA_WIDTH-1:0] data_out_reg_1;

   // Assign statements
   assign data_out = data_out_reg_1;

   // Always block to declare  synchronous logic from source clock domain 
   always @ (posedge in_clk) begin
      data_out_meta <= data_in;
   end
   // Always block to declare synchronous logic in destination clock domain

   always @ (posedge out_clk or posedge rst) begin
      if (`ifdef ACTIVE_LOW_RST !rst `else rst `endif) begin
         data_out_reg_0 <= 'b0;
         data_out_reg_1 <= 'b0;
      end else begin
         data_out_reg_0 <= data_out_meta;
         data_out_reg_1 <= data_out_reg_0;
      end
   end
endmodule
