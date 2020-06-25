module rate_counter #(
      //==============================
      // Top level block parameters
      //==============================
      parameter CLK_RATE     = 156250000,        // clock rate in hertz
      parameter DATA_WIDTH   = 10
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
      output reg [DATA_WIDTH-1:0] rate
   );
   wire [DATA_WIDTH-1:0] out;
   wire [DATA_WIDTH-1:0] sec_cnt;
   reg                   valid_rst;

   // 1 second counter
   counter #(
      .DATA_WIDTH   (DATA_WIDTH),
      .COUNT_FROM   (0),
      .COUNT_TO     (CLK_RATE),
      .STEP         (1)
   ) sec_cntr (
      .clk   (clk),
      .en    (1),
      .rst   (rst), 
      .count (sec_cnt)
   );

   // valid counter
   counter #(
      .DATA_WIDTH   (DATA_WIDTH),
      .COUNT_FROM   (0),
      .COUNT_TO     (4294967295),
      .STEP         (1)
   ) valid_cntr (
      .clk   (clk),
      .en    (en),
      .rst   (valid_rst),
      .count (out)
   );

   always @(posedge clk) begin
      if (sec_cnt == 1'b0) begin
         valid_rst <= 1;
         rate <= out;
      end else begin
         valid_rst <= 0;
      end
   end


endmodule

