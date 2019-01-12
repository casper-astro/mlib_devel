/*

Copyright (c) 2015-2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1ns / 1ps

/*
 * MDIO VCU118 configuration
 */
module mdio_config (
    input sys_clk,
    input sys_clk_rst_sync,
    output mdc,
    inout mdio,
    output done
);

reg [19:0] delay_reg = 20'hfffff;

reg [4:0] mdio_cmd_phy_addr = 5'h03;
reg [4:0] mdio_cmd_reg_addr = 5'h00;
reg [15:0] mdio_cmd_data = 16'd0;
reg [1:0] mdio_cmd_opcode = 2'b01;
reg mdio_cmd_valid = 1'b0;
wire mdio_cmd_ready;

reg [3:0] state_reg = 0;
reg done_reg = 1'b0;
assign done = done_reg;

always @(posedge sys_clk) begin
    if (sys_clk_rst_sync) begin
        state_reg <= 0;
        delay_reg <= 20'hfffff;
        mdio_cmd_reg_addr <= 5'h00;
        mdio_cmd_data <= 16'd0;
        mdio_cmd_valid <= 1'b0;
        done_reg <= 1'b0;
    end else begin
        mdio_cmd_valid <= mdio_cmd_valid & !mdio_cmd_ready;
        if (delay_reg > 0) begin
            delay_reg <= delay_reg - 1;
        end else if (!mdio_cmd_ready) begin
            // wait for ready
            state_reg <= state_reg;
        end else begin
            mdio_cmd_valid <= 1'b0;
            case (state_reg)
                // set SGMII autonegotiation timer to 11 ms
                // write 0x0070 to CFG4 (0x0031)
                4'd0: begin
                    // write to REGCR to load address
                    mdio_cmd_reg_addr <= 5'h0D;
                    mdio_cmd_data <= 16'h001F;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd1;
                end
                4'd1: begin
                    // write address of CFG4 to ADDAR
                    mdio_cmd_reg_addr <= 5'h0E;
                    mdio_cmd_data <= 16'h0031;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd2;
                end
                4'd2: begin
                    // write to REGCR to load data
                    mdio_cmd_reg_addr <= 5'h0D;
                    mdio_cmd_data <= 16'h401F;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd3;
                end
                4'd3: begin
                    // write data for CFG4 to ADDAR
                    mdio_cmd_reg_addr <= 5'h0E;
                    mdio_cmd_data <= 16'h0070;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd4;
                end
                // enable SGMII clock output
                // write 0x4000 to SGMIICTL1 (0x00D3)
                4'd4: begin
                    // write to REGCR to load address
                    mdio_cmd_reg_addr <= 5'h0D;
                    mdio_cmd_data <= 16'h001F;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd5;
                end
                4'd5: begin
                    // write address of SGMIICTL1 to ADDAR
                    mdio_cmd_reg_addr <= 5'h0E;
                    mdio_cmd_data <= 16'h00D3;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd6;
                end
                4'd6: begin
                    // write to REGCR to load data
                    mdio_cmd_reg_addr <= 5'h0D;
                    mdio_cmd_data <= 16'h401F;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd7;
                end
                4'd7: begin
                    // write data for SGMIICTL1 to ADDAR
                    mdio_cmd_reg_addr <= 5'h0E;
                    mdio_cmd_data <= 16'h4000;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd8;
                end
                // enable 10Mbps operation
                // write 0x0015 to 10M_SGMII_CFG (0x016F)
                4'd8: begin
                    // write to REGCR to load address
                    mdio_cmd_reg_addr <= 5'h0D;
                    mdio_cmd_data <= 16'h001F;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd9;
                end
                4'd9: begin
                    // write address of 10M_SGMII_CFG to ADDAR
                    mdio_cmd_reg_addr <= 5'h0E;
                    mdio_cmd_data <= 16'h016F;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd10;
                end
                4'd10: begin
                    // write to REGCR to load data
                    mdio_cmd_reg_addr <= 5'h0D;
                    mdio_cmd_data <= 16'h401F;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd11;
                end
                4'd11: begin
                    // write data for 10M_SGMII_CFG to ADDAR
                    mdio_cmd_reg_addr <= 5'h0E;
                    mdio_cmd_data <= 16'h0015;
                    mdio_cmd_valid <= 1'b1;
                    state_reg <= 4'd12;
                end
                4'd12: begin
                    // done
                    state_reg <= 4'd12;
                    done_reg <= 1'b1;
                end
            endcase
        end
    end
end

wire mdio_i;
wire mdio_o;
wire mdio_t;

mdio_master
mdio_master_inst (
    .clk(sys_clk),
    .rst(sys_clk_rst_sync),

    .cmd_phy_addr(mdio_cmd_phy_addr),
    .cmd_reg_addr(mdio_cmd_reg_addr),
    .cmd_data(mdio_cmd_data),
    .cmd_opcode(mdio_cmd_opcode),
    .cmd_valid(mdio_cmd_valid),
    .cmd_ready(mdio_cmd_ready),

    .data_out(),
    .data_out_valid(),
    .data_out_ready(1'b1),

    .mdc_o(mdc),
    .mdio_i(mdio_i),
    .mdio_o(mdio_o),
    .mdio_t(mdio_t),

    .busy(),

    .prescale(8'd3)
);

assign mdio_i = mdio;
assign mdio = mdio_t ? 1'bz : mdio_o;

endmodule
