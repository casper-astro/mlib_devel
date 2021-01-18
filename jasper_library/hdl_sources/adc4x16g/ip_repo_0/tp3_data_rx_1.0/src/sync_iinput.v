`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2018 02:31:32 PM
// Design Name: 
// Module Name: sync_iinput
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_input(
    input clk,
    input data_in,
    output data_out
    );
//  ASYNC_REG="TRUE" - Specifies registers will be receiving asynchronous data
    //                     input to allow tools to report and improve metastability
    //
    // The following parameters are available for customization:
    //
    //   SYNC_STAGES     - Integer value for number of synchronizing registers, must be 2 or higher
    //   PIPELINE_STAGES - Integer value for number of registers on the output of the
    //                     synchronizer for the purpose of improveing performance.
    //                     Particularly useful for high-fanout nets.
    //   INIT            - Initial value of synchronizer registers upon startup, 1'b0 or 1'b1.
    
       parameter SYNC_STAGES = 3;
       parameter PIPELINE_STAGES = 1;
       parameter INIT = 1'b0;
    
    
       (* ASYNC_REG="TRUE" *) reg [SYNC_STAGES-1:0] sreg = {SYNC_STAGES{INIT}};
    
       always @(posedge clk)
         sreg <= {sreg[SYNC_STAGES-2:0], data_in};
    
       generate
          if (PIPELINE_STAGES==0) begin: no_pipeline
    
             assign data_out = sreg[SYNC_STAGES-1];
    
          end else if (PIPELINE_STAGES==1) begin: one_pipeline
    
             reg sreg_pipe = INIT;
    
             always @(posedge clk)
                sreg_pipe <= sreg[SYNC_STAGES-1];
    
             assign data_out = sreg_pipe;
    
          end else begin: multiple_pipeline
    
            (* shreg_extract = "no" *) reg [PIPELINE_STAGES-1:0] sreg_pipe = {PIPELINE_STAGES{INIT}};
    
             always @(posedge clk)
                sreg_pipe <= {sreg_pipe[PIPELINE_STAGES-2:0], sreg[SYNC_STAGES-1]};
    
             assign data_out = sreg_pipe[PIPELINE_STAGES-1];
    
          end
       endgenerate


endmodule
