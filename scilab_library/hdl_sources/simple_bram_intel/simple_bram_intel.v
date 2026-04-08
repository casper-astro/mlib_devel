module simple_bram_intel #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10
)(
    input                       wr_clk,
    input                       wr_rst,
    input                       wr_en,
    input  [DATA_WIDTH-1:0]     wr_data,

    input                       rd_clk,
    input  [ADDR_WIDTH-1:0]     rd_addr,
    output reg [DATA_WIDTH-1:0] rd_data
);

    localparam DEPTH = (1 << ADDR_WIDTH);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [ADDR_WIDTH-1:0] wr_ptr;

    // Write side: auto-increment circular buffer
    always @(posedge wr_clk) begin
        if (wr_rst) begin
            wr_ptr <= {ADDR_WIDTH{1'b0}};
        end else if (wr_en) begin
            mem[wr_ptr] <= wr_data;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    // Read side (AXI clock domain)
    always @(posedge rd_clk) begin
        rd_data <= mem[rd_addr];
    end

endmodule