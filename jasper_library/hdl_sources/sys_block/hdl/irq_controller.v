module irq_controller(
    input  clk,
    input  rst,
    input  [31:0] irq_sys_i,
    input  [31:0] irq_app_i,
    input  [31:0] irq_sys_mask, 
    input  [31:0] irq_app_mask, 
    input  irq_sys_clear,
    input  irq_app_clear,
    output [31:0] irq_sys_o,
    output [31:0] irq_app_o,
    output irq_out
  );

  wire [31:0] irq_sys_reg;
  wire [31:0] irq_app_reg;
  assign irq_out = |(irq_sys_reg & irq_sys_mask) || |(irq_app_reg & irq_app_mask);

  FDCPE #(
    .INIT(1'b0)                              // Initial value of register (1'b0 or 1'b1)
  ) FD_irq_sys[31:0] (
    .Q   (irq_sys_reg),                      // Data output
    .C   (clk),                              // Clock input
    .CE  (1'b1),                             // Clock enable input
    .CLR (rst),                              // Asynchronous clear input
    .D   (irq_sys_clear ? 32'b0 : irq_sys_reg), // Data input
    .PRE (irq_sys_i[31:0])                     // Asynchronous set input
  );

  FDCPE #(
    .INIT(1'b0)                              // Initial value of register (1'b0 or 1'b1)
  ) FD_irq_app[31:0] (
    .Q   (irq_app_reg),                      // Data output
    .C   (clk),                              // Clock input
    .CE  (1'b1),                             // Clock enable input
    .CLR (rst),                              // Asynchronous clear input
    .D   (irq_app_clear ? 32'b0 : irq_app_reg), // Data input
    .PRE (irq_app_i[31:0])                     // Asynchronous set input
  );

  assign irq_sys_o = irq_sys_reg;
  assign irq_app_o = irq_app_reg;
  
endmodule
