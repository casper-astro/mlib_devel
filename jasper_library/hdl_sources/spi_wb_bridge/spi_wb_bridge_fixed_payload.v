module spi_wb_bridge_fixed_payload(
    /* wishbone generic signals */
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
    input cs_n,
    input sclk,
    input mosi,
    output miso
    );

    /*
     * This module implements a simple SPI slave -> Wishbone master 
     * interface. For simplicity, commands from the SPI master must
     * be 72 bytes long, in the form {7'b0, 1'write_not_read, 32'address,
     * 32'data}. Responses from the slave have the form: {6'b0, 1'err, 1'ack,
     * 32'b0, 32'data}, where the err, ack and data signals are the responses
     * of the last request. I.e., if the last request was a read, the response
     * will contain the read data from that address. If the last request was
     * a write, the response will be the err/ack flags returned by the
     * wishbone slave. In this case, the 32 data bits in the message are undefined.
     *
     * Obviously this system wastes quite a lot of transaction time. We could
     * implement a system where any 64 bit messages were considered write
     * commands with {32'addr, 32'data}, and any 32 bit messages were
     * considered reads.
     */



    /******************* 
     * Synchronisation * 
     *******************/

    /* Move the SPI signals into the wb clock domain. Use a 3 stage shift-reg
     * on sclk -- two stages for synchronisation, one for edge detection.
     */

    reg [2:0] sclk_sr;
    reg [1:0] mosi_sr;
    reg [1:0] cs_n_sr;

    wire sclk_posedge = (sclk_sr[2:1]== 2'b01);
    wire sclk_negedge = (sclk_sr[2:1]== 2'b10);

    always @(posedge wb_clk_i) begin
        sclk_sr <= {sclk_sr[1:0],sclk};
        mosi_sr <= {mosi_sr[0],mosi};
        cs_n_sr <= {cs_n_sr[0],cs_n};
    end

    /**************** 
     * SPI RX logic * 
     ****************/

    reg [6:0] spi_ctr = 0;   // register for counting spi bits
    reg [71:0] spi_din_reg;  // 32 bits addr, 32 bits data, 8 bits cmd (r/w)
    reg new_cmd;             // A single-cycle strobe indicating new spi data has completed RX

    /* On each detected posedge of sclk shift mosi through a register chain.
     * Strobe new_cmd on reception of the last bit of data.
     */
    
    always @(posedge wb_clk_i) begin
        new_cmd <= 1'b0; //strobe signal
        if (cs_n) begin
            spi_ctr <= 7'b0;
        end else if (sclk_posedge) begin
            spi_ctr <= spi_ctr + 1'b1;
            spi_din_reg <= {spi_din_reg[70:0],mosi};
            new_cmd <= (spi_ctr == 7'd71);
        end
    end

    /************************ 
     * Wishbone Transaction * 
     ************************/
    
    reg [31:0] wb_din_reg; // register to store the data to be sent
    reg wb_err_reg;        // register to store the wb slave error flag
    reg wb_ack_reg;        // register to store the wb slave acknowledgement flag
    always @(posedge wb_clk_i) begin
        if (wb_rst_i) begin
            wbm_cyc_o <= 1'b0;
            wbm_stb_o <= 1'b0;
        end else begin
            /* initiate a new wb transaction on the new_cmd strobe.
             * Transaction ends when the slave responds by strobing
             * ack or err.
             */
            if (new_cmd) begin
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
                wb_ack_reg <= wbm_ack_i;
            end
        end
    end
    
    /********** 
     * SPI TX * 
     **********/

    /* Allow data from the wishbone bus to enter the spi output
     * shift register whenever no transaction is going on. When the 
     * cs_n line indicates a new transaction, the state of the shift register
     * is frozen (with the results of the last read.
     * Shift this value out on each detected negedge of sclk.
     */

    reg [71:0] spi_dout_reg; // {6'b0, err, ack, 32'b0, data}
    always @(posedge wb_clk_i) begin
        new_cmd <= 1'b0; //strobe signal
        if (cs_n) begin
            // the spi output registers can't change during an SPI transaction
            spi_dout_reg <= {6'b0, wb_err_reg, wb_ack_reg, 32'b0, wb_din_reg};
        end else if (sclk_negedge) begin
            spi_dout_reg <= {spi_dout_reg[70:0],1'b0};
        end
    end
    assign miso = spi_dout_reg[71];
endmodule
