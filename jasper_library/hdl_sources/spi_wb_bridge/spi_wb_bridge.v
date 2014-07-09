module spi_wb_bridge(
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
    output miso,
    /* debug */
    output new_cmd_stb
    );

    /*
     * This module implements a simple SPI slave -> Wishbone master 
     * interface.
     * write commands are 72 bits long, and take the form:
     *   {32'data,32'addr,4'b1000,4'byte_enable}
     * read commands take the form
     *   {32'b0,  32'addr,4'b0000,4'byte_enable}
     * so that addr/byte_enables are found in the same bits of the received
     * vector no matter what the command type.
     * 
     * Responses from the slave have the form:
     * {32'addr, 32'data, 1'wnr, 1'err, 1'ack, 1'b0, 4'byte_enable} 
     * In both cases, the err, ack and addr, data and byte enable signals
     * are the responses of the last request. I.e., if the last request was a read,
     * the response  will contain the read data from that address.
     *
     */



    /******************* 
     * Synchronisation * 
     *******************/

    /* Move the SPI signals into the wb clock domain. Use a 6 stage shift-reg
     * to do some debouncing
     * on sclk and cs_n -- two stages for synchronisation, 4 for edge/stability detection.
     */

    reg [5:0] sclk_sr;
    reg [1:0] mosi_sr;
    reg [1:0] cs_n_sr;

    wire sclk_posedge = (sclk_sr[5:1]== 5'b01111);
    wire sclk_negedge = (sclk_sr[5:1]== 5'b10000);
    //wire cs_n_posedge = (cs_n_sr[5:1]== 5'b01111);
    //wire cs_n_negedge = (cs_n_sr[5:1]== 5'b10000);
    wire cs_n_cur  = cs_n_sr[1]; //current value of cs
    wire mosi_cur  = mosi_sr[1]; //current value of mosi

    always @(posedge wb_clk_i) begin
        sclk_sr <= {sclk_sr[4:0],sclk};
        mosi_sr <= {mosi_sr[0],mosi};
        cs_n_sr <= {cs_n_sr[0],cs_n};
    end

    /**************** 
     * SPI RX logic * 
     ****************/

    reg [6:0] spi_ctr = 0;     // register for counting spi bits
    reg [71:0] spi_din_reg;    // Max 8 bits sel, 32 bits addr, 32 bits data
    reg new_cmd;               // A single-cycle strobe indicating new spi cmd has completed RX
    assign new_cmd_stb = new_cmd;

    /* On each detected posedge of sclk shift mosi through a register chain.
     * Strobe new_cmd on the posedge of sclk if the payload is 72 bits.
     * If the payload is something else ignore the received data.
     */
    
    always @(posedge wb_clk_i) begin
        new_cmd <= 1'b0; //strobe signal
        if (cs_n_cur == 1'b1) begin
            spi_ctr <= 7'b0;
        end else if (sclk_posedge) begin
            spi_ctr <= spi_ctr + 7'b1;
            new_cmd <= (spi_ctr==7'd71);
            spi_din_reg <= {spi_din_reg[70:0],mosi_cur};
        end
    end

    /************************ 
     * Wishbone Transaction * 
     ************************/
    
    reg [31:0] wb_din_reg; // register to store the data to be sent
    reg wb_err_reg;        // register to store the wb slave error flag
    reg wb_ack_reg;        // register to store the wb slave acknowledgement flag
    reg [31:0] last_cmd_addr; //address of last command
    reg [31:0] last_cmd_data; //data payload of last command
    reg [3:0]  last_cmd_be;   //byte enable of last command
    reg        last_cmd_we;   //we state of last command
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
                wbm_we_o  <= spi_din_reg[7];
                wbm_sel_o <= spi_din_reg[3:0];
                wbm_adr_o <= spi_din_reg[39:8];
                wbm_dat_o <= spi_din_reg[71:40]; // This isn't defined if the cmd is a read
                wbm_cyc_o <= 1'b1;
                wbm_stb_o <= 1'b1;
                last_cmd_we   <= spi_din_reg[7];
                last_cmd_be   <= spi_din_reg[3:0];
                last_cmd_addr <= spi_din_reg[39:8];
                last_cmd_data <= spi_din_reg[71:40];
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
     
    reg [71:0] spi_dout_reg; // {6'b0, err, ack, 32'data, 32'b0}
    always @(posedge wb_clk_i) begin
        if (cs_n_cur ==  1'b1) begin
            // capture the wishbone data as the cs line goes low, and prepare to shift out.
            spi_dout_reg <= {wb_din_reg, last_cmd_addr, last_cmd_we, wb_err_reg, wb_ack_reg, 1'b0, last_cmd_be};
        end else if (sclk_negedge) begin
            spi_dout_reg <= {spi_dout_reg[70:0],1'b0};
        end
    end
    assign miso = spi_dout_reg[71];
endmodule
