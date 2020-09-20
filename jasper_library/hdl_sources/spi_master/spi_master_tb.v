module spi_master_tb;

    reg clk = 0;
    always #5 clk = !clk;

    reg [2:0] cs_n_in;
    reg [23:0] din;
    reg trigger = 0;
    reg ack;
    wire [23:0] dout;
    wire dvld;

    wire [2:0] cs_n;
    wire sclk;
    wire mosi;

    initial begin
      $dumpfile("spi_master_tb.vcd");
      $dumpvars(0,spi_master_tb);
      #55 din = 24'hdeadbe; cs_n_in = 3'b010; trigger = 1'b1;
      #10 din = 0; cs_n_in = 0; trigger = 0;
      #2500 $finish;
    end

    always @(posedge clk) begin
      if (dvld == 1'b1) begin
        ack <= 1'b1;
      end
    end

    spi_master #(
      .NCLKDIVBITS(2)
      ) uut (
      .clk(clk),
      .cs_n_in(cs_n_in),
      .din(din),
      .trigger(trigger),
      .ack(ack),
      .dout(dout),
      .dvld(dvld),

      .cs_n(cs_n),
      .sclk(sclk),
      .mosi(mosi),
      .miso(~mosi) // Inverted loopback
    );

endmodule
