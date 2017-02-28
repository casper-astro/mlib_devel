module wb_adc16_onehot_encoder (
    clk,
    chip_sel,
    lane_sel,
    onehot
    );

    parameter N_CHIPS = 8;
    input clk;
    input [N_CHIPS - 1 : 0] chip_sel;
    input [2 : 0] lane_sel;
    output reg [N_CHIPS*8 - 1 : 0] onehot;

    genvar i;
    generate
    for (i=0; i<N_CHIPS; i=i+1) begin : chip_loop
        always @(posedge clk) begin
            onehot[i*8+7:i*8] <= 8'b0;
            case(lane_sel)
                3'd0 : onehot[i*8+0] <= chip_sel[i];
                3'd1 : onehot[i*8+1] <= chip_sel[i];
                3'd2 : onehot[i*8+2] <= chip_sel[i];
                3'd3 : onehot[i*8+3] <= chip_sel[i];
                3'd4 : onehot[i*8+4] <= chip_sel[i];
                3'd5 : onehot[i*8+5] <= chip_sel[i];
                3'd6 : onehot[i*8+6] <= chip_sel[i];
                3'd7 : onehot[i*8+7] <= chip_sel[i];
            endcase
        end
    end 
    endgenerate

endmodule
