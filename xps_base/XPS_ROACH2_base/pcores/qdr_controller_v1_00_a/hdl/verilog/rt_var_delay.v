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

module rt_var_delay #(

      //===================
      // local parameters
      //===================
      parameter DATA_WIDTH   = 1,
      parameter INITAL_DELAY = 1,
      parameter DELAY_LEN    = 32
   ) (
      //=============
      // local regs
      //=============
      input clk,
      input in,
      input [4:0] delay,
      
      //==============
      // local wires
      //==============
      output reg out
   );

   reg [DELAY_LEN-1:0] shift_reg;

   always@(posedge clk) begin
      shift_reg[0] = in;
      shift_reg    = shift_reg<<1;
      case (delay[4:0])
         5'd0: out = shift_reg[1];
         5'd1: out = shift_reg[2];
         5'd2: out = shift_reg[3];
         5'd3: out = shift_reg[4];
         5'd4: out = shift_reg[5];
         5'd5: out = shift_reg[6];
         5'd6: out = shift_reg[7];
         5'd7: out = shift_reg[8];
         5'd8: out = shift_reg[9];
         5'd9: out = shift_reg[10];
         5'd10: out = shift_reg[11];
         5'd11: out = shift_reg[12];
         5'd12: out = shift_reg[13];
         5'd13: out = shift_reg[14];
         5'd14: out = shift_reg[15];
         5'd15: out = shift_reg[16];
         5'd16: out = shift_reg[17];
         5'd17: out = shift_reg[18];
         5'd18: out = shift_reg[19];
         5'd19: out = shift_reg[20];
         5'd20: out = shift_reg[21];
         5'd21: out = shift_reg[22];
         5'd22: out = shift_reg[23];
         5'd23: out = shift_reg[24];
         5'd24: out = shift_reg[25];
         5'd25: out = shift_reg[26];
         5'd26: out = shift_reg[27];
         5'd27: out = shift_reg[28];
         5'd28: out = shift_reg[29];
         5'd29: out = shift_reg[30];
         5'd30: out = shift_reg[31];
         default: out = in;
      endcase
   end

endmodule
