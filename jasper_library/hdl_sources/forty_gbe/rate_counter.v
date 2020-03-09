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
      input rate_clk, // clock that we know the rate of, to measure 1 second
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
   reg                   pulse;
   reg                   pulse_r1;
   reg                   pulse_r2;
   reg                   valid_rst;

   // 1 second counter
   counter #(
      .DATA_WIDTH   (DATA_WIDTH),
      .COUNT_FROM   (0),
      .COUNT_TO     (CLK_RATE),
      .STEP         (1)
   ) sec_cntr (
      .clk   (rate_clk),
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

   // generate a pulse when the rate counter wraps
   always @(posedge rate_clk) begin
      if (sec_cnt == {DATA_WIDTH{1'b0}}) begin
         pulse <= 1;
      end else begin
         pulse <= 0;
      end
   end

   // double register the pulse to get it onto the user clk domain
   always @(posedge clk) begin
      pulse_r1 <= pulse;
      pulse_r2 <= pulse_r1;
   end

   // when the pulse is asserted, latch the counter to the output
   always @(posedge clk) begin
      if (pulse_r2 == 1'b1) begin
         valid_rst <= 1;
         rate <= out;
      end else begin
         valid_rst <= 0;
      end
   end


endmodule

