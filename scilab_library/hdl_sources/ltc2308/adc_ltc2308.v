module adc_ltc2308(
    input  wire        clk,
    input  wire        rst_n,

    input  wire        measure_start,
    input  wire [2:0]  measure_ch,

    output reg         measure_done,
    output reg  [11:0] measure_dataread,

    output reg         ADC_CONVST,
    output reg         ADC_SCK,
    output reg         ADC_SDI,
    input  wire        ADC_SDO
);

`define DATA_BITS_NUM       12
`define CMD_BITS_NUM        6

`define tWHCONV             3
`define tCONV               64
`define tHCONVST            320

`define tCONVST_HIGH_START  0
`define tCONVST_HIGH_END    (`tCONVST_HIGH_START + `tWHCONV)
`define tCONFIG_START       (`tCONVST_HIGH_END)
`define tCLK_START          (`tCONVST_HIGH_START + `tCONV)
`define tCONFIG_END         (`tCLK_START + `CMD_BITS_NUM - 1)
`define tCLK_END            (`tCLK_START + `DATA_BITS_NUM)
`define tDONE               (`tCLK_END + `tHCONVST)

`define UNI_MODE            1'b1
`define SLP_MODE            1'b0

reg        pre_measure_start;
wire       start_reset_n;
wire       local_reset_n;
reg [15:0] tick;
reg        clk_enable;
reg [(`DATA_BITS_NUM-1):0] read_data;
reg [3:0]  write_pos;
reg [(`CMD_BITS_NUM-1):0] config_cmd;
reg [3:0]  sdi_index;

localparam integer data_bits_num_holder = `DATA_BITS_NUM;
localparam integer cmd_bits_num_holder  = `CMD_BITS_NUM;

wire config_init;
wire config_enable;
wire config_done;
wire read_ch_done;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        pre_measure_start <= 1'b0;
    else
        pre_measure_start <= measure_start;
end

assign start_reset_n = (~pre_measure_start & measure_start) ? 1'b0 : 1'b1;
assign local_reset_n = rst_n & start_reset_n;

always @(posedge clk or negedge local_reset_n) begin
    if (~local_reset_n)
        tick <= 16'd0;
    else if (tick < `tDONE)
        tick <= tick + 16'd1;
end

always @(*) begin
    ADC_CONVST = (tick >= `tCONVST_HIGH_START && tick < `tCONVST_HIGH_END) ? 1'b1 : 1'b0;
    ADC_SCK    = clk_enable ? clk : 1'b0;
    measure_dataread = read_data;
end

always @(negedge clk or negedge local_reset_n) begin
    if (~local_reset_n)
        clk_enable <= 1'b0;
    else if ((tick >= `tCLK_START) && (tick < `tCLK_END))
        clk_enable <= 1'b1;
    else
        clk_enable <= 1'b0;
end

always @(negedge clk or negedge local_reset_n) begin
    if (~local_reset_n) begin
        read_data <= {data_bits_num_holder{1'b0}};
        write_pos <= data_bits_num_holder - 1;
    end else if (clk_enable) begin
        read_data[write_pos] <= ADC_SDO;
        if (write_pos != 0)
            write_pos <= write_pos - 4'd1;
    end
end

assign read_ch_done = (tick == `tDONE) ? 1'b1 : 1'b0;

always @(posedge clk or negedge local_reset_n) begin
    if (~local_reset_n)
        measure_done <= 1'b0;
    else if (read_ch_done)
        measure_done <= 1'b1;
end

always @(negedge local_reset_n) begin
    case (measure_ch)
        3'd0: config_cmd <= {4'h8, `UNI_MODE, `SLP_MODE};
        3'd1: config_cmd <= {4'hC, `UNI_MODE, `SLP_MODE};
        3'd2: config_cmd <= {4'h9, `UNI_MODE, `SLP_MODE};
        3'd3: config_cmd <= {4'hD, `UNI_MODE, `SLP_MODE};
        3'd4: config_cmd <= {4'hA, `UNI_MODE, `SLP_MODE};
        3'd5: config_cmd <= {4'hE, `UNI_MODE, `SLP_MODE};
        3'd6: config_cmd <= {4'hB, `UNI_MODE, `SLP_MODE};
        3'd7: config_cmd <= {4'hF, `UNI_MODE, `SLP_MODE};
        default: config_cmd <= {4'hF, 2'b00};
    endcase
end

assign config_init   = (tick == `tCONFIG_START) ? 1'b1 : 1'b0;
assign config_enable = (tick > `tCLK_START && tick <= `tCONFIG_END) ? 1'b1 : 1'b0;
assign config_done   = (tick > `tCONFIG_END) ? 1'b1 : 1'b0;

always @(negedge clk or negedge local_reset_n) begin
    if (~local_reset_n) begin
        ADC_SDI  <= 1'b0;
        sdi_index <= cmd_bits_num_holder - 2;
    end else if (config_init) begin
        ADC_SDI  <= config_cmd[`CMD_BITS_NUM-1];
        sdi_index <= cmd_bits_num_holder - 2;
    end else if (config_enable) begin
        ADC_SDI  <= config_cmd[sdi_index];
        sdi_index <= sdi_index - 3'd1;
    end else if (config_done) begin
        ADC_SDI <= 1'b0;
    end
end

endmodule
