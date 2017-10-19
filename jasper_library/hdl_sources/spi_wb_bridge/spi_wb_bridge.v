module spi_wb_bridge #(
    parameter LITTLE_ENDIAN = 1
    )(
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
     * write commands are 14 bytes long, and take the form:
     *   {4'b1000, 4'byte_enable, 32'addr, 32'data, 32'XXXX, 8'b0000_0001}
     * read commands take the form
     *   {4'b0000, 4'byte_enable, 32'addr, 32'XXXX, 32'XXXX 8'b0000_0001}
     *
     * Responses from the slave have the form:
     * {8'XXXX, 32'XXXX, 32'XXXX, 32'read_data, 1'ack, 1'error, 2'b0, 4'byte_enable} 
     *
     * Commands are not particularly efficient (i.e., lots of bits are unused)
     * but 32 dead bits after address in the read case give a long window over
     * which the wb bus transaction so that the read data can be returned.
     * The last byte of the command gives space for a return status message,
     * and could be (not yet implemented) used to embed multiple commands in
     * a single spi message.
     *
     * On a raspberry pi it seems that the delay between SPI messages from the CPU
     * dominates transaction time losses, so the length of the message isn't
     * particularly important.
     *
     */

    localparam SPI_MESS_LEN = 8*14;
    localparam LOG2_SPI_MESS_LEN = 7;


    /******************* 
     * Synchronisation * 
     *******************/

    /* Move the SPI signals into the wb clock domain. Use a 4 stage shift-reg
     * to do some debouncing
     * on sclk and cs_n -- two stages for synchronisation, 2 for edge/stability detection.
     */

    reg [3:0] sclk_sr;
    reg [1:0] mosi_sr;
    reg [1:0] cs_n_sr;

    wire sclk_posedge = (sclk_sr[3:1]== 3'b011);
    wire sclk_negedge = (sclk_sr[3:1]== 3'b100);
    wire cs_n_cur  = cs_n_sr[1]; //current value of cs
    wire mosi_cur  = mosi_sr[1]; //current value of mosi

    always @(posedge wb_clk_i) begin
        sclk_sr <= {sclk_sr[3:0],sclk};
        mosi_sr <= {mosi_sr[0],mosi};
        cs_n_sr <= {cs_n_sr[0],cs_n};
    end

    /**************** 
     * SPI RX logic * 
     ****************/

    reg [LOG2_SPI_MESS_LEN - 1:0] spi_ctr = 0;      // register for counting spi bits
    reg [SPI_MESS_LEN - 1:0] spi_din_reg;           // Max 8 bits sel, 32 bits addr, 32 bits data
    reg new_cmd;                                    // A single-cycle strobe indicating new spi cmd has completed RX
    reg cmd_end;
    assign new_cmd_stb = new_cmd;

    
    reg [31:0] cmd_addr;
    reg [31:0] cmd_din;
    reg [3:0]  cmd_be;
    reg        cmd_wnr;
    always @(posedge wb_clk_i) begin
        /* strobes */
        new_cmd <= 1'b0;
        cmd_end <= 1'b0;
        if (cs_n_cur == 1'b1) begin
            /* spi_ctr is only reset on cs_n high. This is incompatible with
             * multiple commands in a single SPI transaction.
             */
            spi_ctr <= {LOG2_SPI_MESS_LEN{1'b0}};
            new_cmd <= 1'b0;
            cmd_end <= 1'b0;
        end else if (sclk_posedge) begin
            spi_ctr <= spi_ctr + 1;
            spi_din_reg <= {spi_din_reg[SPI_MESS_LEN - 2 : 0], mosi_cur};
            if (spi_ctr == 1-1) begin
                cmd_wnr <= mosi_cur;
            end
            if (spi_ctr == 8-1) begin
                cmd_be <= {spi_din_reg[2:0], mosi_cur};
            end
            if (spi_ctr == 40-1) begin
                cmd_addr <= {spi_din_reg[30:0], mosi_cur};
                new_cmd <= !cmd_wnr;
            end
            if (spi_ctr == 72-1) begin
                cmd_din <= {spi_din_reg[30:0], mosi_cur};
                new_cmd <= cmd_wnr;
            end
            if (spi_ctr == 112-1) begin
                cmd_end <= 1'b1;
            end
        end
    end

    /************************ 
     * Wishbone Transaction * 
     ************************/

    wire [31:0] addr_end_fix;
    wire [31:0] data_end_fix;
    generate
    if (LITTLE_ENDIAN) begin
        assign addr_end_fix[31:24] = cmd_addr[7 :0 ];
        assign addr_end_fix[23:16] = cmd_addr[15:8 ];
        assign addr_end_fix[15:8 ] = cmd_addr[23:16];
        assign addr_end_fix[7 :0 ] = cmd_addr[31:24];
        assign data_end_fix[31:24] = cmd_din[7 :0 ];
        assign data_end_fix[23:16] = cmd_din[15:8 ];
        assign data_end_fix[15:8 ] = cmd_din[23:16];
        assign data_end_fix[7 :0 ] = cmd_din[31:24];
    end else begin
        assign addr_end_fix[31:0] = cmd_addr[31:0];
        assign data_end_fix[31:0] = cmd_din[31:0];
    end
    endgenerate
    
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
                wbm_we_o  <= cmd_wnr;
                wbm_sel_o <= cmd_be;
                wbm_adr_o <= addr_end_fix;
                wbm_dat_o <= data_end_fix; // This isn't defined if the cmd is a read
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
     * shift register after clock 72 (the spi cycle before it needs to be
     * sent.
     */

    wire [31:0] wb_din_end_fix;
    generate
    if (LITTLE_ENDIAN) begin
        assign wb_din_end_fix[31:24] = wb_din_reg[7 :0 ];
        assign wb_din_end_fix[23:16] = wb_din_reg[15:8 ];
        assign wb_din_end_fix[15:8 ] = wb_din_reg[23:16];
        assign wb_din_end_fix[7 :0 ] = wb_din_reg[31:24];
    end else begin
        assign wb_din_end_fix[31:0] = wb_din_reg[31:0];
    end
    endgenerate

     
    reg [32+8-1:0] spi_dout_reg = 0; // {32'data, err, ack, 2'0, 4'be}
    always @(posedge wb_clk_i) begin
        if (cs_n_cur) begin
            spi_dout_reg <= 40'b0;
        end else if (spi_ctr == 72) begin
            if (sclk_negedge) begin
                spi_dout_reg <= {wb_din_end_fix, wb_ack_reg, wb_err_reg, 2'b0, cmd_be};
            end
        end else if (sclk_negedge) begin
            spi_dout_reg <= {spi_dout_reg[38:0],1'b0};
        end
    end
    assign miso = spi_dout_reg[39];
endmodule
