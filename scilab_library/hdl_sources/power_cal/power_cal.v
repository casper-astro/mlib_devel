module power_cal#(
    parameter integer BIT_WIDTH = 16,
    parameter DATA_TYPE = "signed"
)(
    input clk,
    input  wire [BIT_WIDTH-1:0] re,
    input  wire [BIT_WIDTH-1:0] im,
    output wire [2*BIT_WIDTH : 0] pwr
);

reg [2*BIT_WIDTH : 0] r;

generate
    if (DATA_TYPE == "signed") begin
        wire signed [BIT_WIDTH-1:0] re_signed = re;
        wire signed [BIT_WIDTH-1:0] im_signed = im; 
        always @(posedge clk)
        begin
            r <= re_signed * re_signed + im_signed * im_signed;
        end
    end
    else if (DATA_TYPE == "unsigned") begin
        always @(posedge clk)
        begin
            r <= re * re + im * im;
        end
    end
    else begin
       initial begin
           $error("Invalid DATA_TYPE. Use 'signed' or 'unsigned'.");
       end
    end
endgenerate

// this introduces one cycle delay

assign pwr = r;

endmodule