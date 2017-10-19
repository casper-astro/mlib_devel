module spi_wb_bridge_debounce(
    /* wishbone signals */
    input wb_clk_i,
    input wb_rst_i,
    /* wishbone signals to arbiter */
    output reg wbm_cyc_o,
    output reg wbm_stb_o,
    output reg wbm_we_o,
    output reg [3:0] wbm_sel_o,
    output reg [31:0] wbm_adr_o,
    output reg [31:0] wbm_dat_o,
    /* wishbone signals from arbiter */
    input [31:0] wbm_dat_i,
    input wbm_ack_i,
    input wbm_err_i,
    /* spi signals */
    input ncs,
    input sclk,
    input mosi,
    output miso
    );

    /* register the s_clk input in a shift register, to do some debouncing.
     * Only use the stable sclk signals later to avoid clock domain issues.
     * sclk is considered stable if it is the same for 4 clock cycles -- make
     * sure the wb_clk:sclk ratio is suitably high!
     */

    reg [3:0] sclk_sr;
    reg [1:0] sclk_debounced; // two element shift reg to allow edge detection

    wire sclk_stable = ~^sclk_sr;
    wire sclk_posedge = (sclk_debounced == 2'b01);

    always @(posedge wb_clk_i) begin
        sclk_sr <= {sclk_sr[3:0],sclk};
        if (sclk_stable) begin
            sclk_debounced <= {sclk_debounced[0],sclk};
        end
    end

    /* SPI logic */

    reg [6:0] spi_ctr = 0;   // register for counting spi bits
    reg [71:0] spi_din_reg;  // 32 bits addr, 32 bits data, 8 bits cmd (r/w)
    reg [71:0] spi_dout_reg; // {status, 7'b0, 32'b0, data}

    always @(posedge wb_clk_i) begin
        if (ncs) begin //ncs is asynchronous and may glitch, but this shouldn't matter
            // the spi output registers can't change during an SPI transaction
            spi_ctr <= 7'b0;
            spi_dout_reg[31:0] <= wb_din_reg;
            spi_dout_reg[71]   <= wb_err_reg;
        end else if (sclk_posedge) begin // sclk_posedge is stable
            spi_ctr <= spi_ctr + 1'b1;
            spi_din_reg <= {spi_din_reg[70:0],mosi};
            spi_dout_reg <= {spi_dout_reg[70:0],1'b0};
        end
    end
    assign miso = spi_dout_reg[71];

    /* wishbone transaction */
    
    reg [31:0] wb_din_reg;
    reg wb_err_reg;
    always @(posedge wb_clk_i) begin
        if (wb_rst_i) begin
            wbm_cyc_o <= 1'b0;
            wbm_stb_o <= 1'b0;
        end else begin
            if (ncs && sclk_posedge && (spi_ctr == 7'd71)) begin
                wbm_we_o  <= spi_din_reg[71];
                wbm_sel_o <= spi_din_reg[67:64];
                wbm_adr_o <= spi_din_reg[63:32];
                wbm_dat_o <= spi_din_reg[31:0];
                wbm_cyc_o <= 1'b1;
                wbm_stb_o <= 1'b1;
            end
            if (wbm_ack_i || wbm_err_i) begin
                wbm_cyc_o <= 1'b0;
                wbm_stb_o <= 1'b0;
                wb_din_reg <= wbm_dat_i;
                wb_err_reg <= wbm_err_i;
            end
        end
    end
    
endmodule