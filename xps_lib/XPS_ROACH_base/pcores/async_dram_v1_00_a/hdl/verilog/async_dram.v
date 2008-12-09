`timescale 1ns / 1ps

module async_dram #(

    //Use bram to make nice deep fifos which are needed for certain
    //applications.
    //Default is shallow, distributed RAM fifos
    parameter         TAG_BUFFER_EN = 0,
    parameter         BRAM_FIFOS    = 0,
    parameter         C_WIDE_DATA   = 0,
    parameter         C_HALF_BURST  = 0
    ) (
    sys_rst,
       // -- Mem cmd ports ---------------
    Mem_Clk,
    Mem_Rst,
    Mem_Cmd_Address,
    Mem_Cmd_RNW,
    Mem_Cmd_Valid,
    Mem_Cmd_Ack,
    Mem_Cmd_Tag,
    Mem_Rd_Dout,
    Mem_Rd_Ack,
    Mem_Rd_Valid,
    Mem_Rd_Tag,
    Mem_Wr_Din,
    Mem_Wr_BE,

    // -- DDR2 ports ---------------
    dram_reset,
    dram_clk,
    dram_data_o,
    dram_byte_enable,
    dram_data_i,
    dram_data_valid,
    dram_address,
    dram_rnw,
    dram_cmd_en,
    dram_ready
    );

    //sys ports
    input                   sys_rst;

    // -- dram ports -----------------
    output                  dram_reset;
    input                   dram_clk;
    output [143:0]          dram_data_o;
    output [17:0]           dram_byte_enable;
    input [143:0]           dram_data_i;
    input                   dram_data_valid;
    output [31:0]           dram_address;
    output                  dram_rnw;
    output                  dram_cmd_en;
    input                   dram_ready;

    // -- Mem cmd ports -----------------
    input               Mem_Clk;
    input               Mem_Rst;
    output              Mem_Error;
    output              Mem_Ready;
    input [31:0]        Mem_Cmd_Address;
    input               Mem_Cmd_RNW;
    input               Mem_Cmd_Valid;
    input [31:0]        Mem_Cmd_Tag;

    output              Mem_Cmd_Ack;

    output [143:0]      Mem_Rd_Dout;

    input               Mem_Rd_Ack;
    output              Mem_Rd_Valid;
    input [31:0]        Mem_Rd_Tag;

    input [143:0]       Mem_Wr_Din;
    input [17:0]        Mem_Wr_BE;


    //----------------------------------------------------------------------------
    // fifo storage 
    //----------------------------------------------------------------------------

    reg			        dram_rst;

    reg                 Mem_Cmd_Valid_d1;
    reg                 dram_data_valid_d1, dram_data_i_d1;

    // fifo control
    reg     rd_txn_fifo, rd_txn_fifo_d1, rd_txn_fifo_d2;
    reg     rd_data_fifo_d1;
    wire    rd_data_fifo, rd_add_fifo;
    reg     rd_rd_data_fifo, rd_rd_data_fifo_d1;

    //data + byte enables fifo
    wire[(144+18)-1:0]  data_fifo_input, data_fifo_output;
    wire                data_fifo_we, data_fifo_re, data_fifo_almost_full, data_fifo_empty;
    
    //address fifo
    wire[31:0]          add_fifo_input, add_fifo_output;
    wire                add_fifo_we, add_fifo_re, add_fifo_almost_full, add_fifo_empty;

    //transaction type fifo
    wire                txn_fifo_input, txn_fifo_output;
    reg                 txn_fifo_output_d1;
    wire                txn_fifo_we, txn_fifo_re, txn_fifo_almost_full, txn_fifo_empty;
   
    //read data fifo
    wire[143:0]         rd_data_fifo_input, rd_data_fifo_output;
    wire                rd_data_fifo_we, rd_data_fifo_re;

    //----------------------------------------------------------------------------
    // Implementation
    //----------------------------------------------------------------------------
    
    /************************************************************************************/
    /* dram_clk clk domain */
    /************************************************************************************/

    // outputs to dram
    assign dram_address = add_fifo_output;
    assign dram_rnw = txn_fifo_output_d1; 
    assign dram_byte_enable = data_fifo_output[18-1:0];
    assign dram_data_o = data_fifo_output[144+18-1:144]; 
    assign dram_cmd_en = rd_txn_fifo_d2;

    //cross clk domain for reset
    always @ ( posedge dram_clk ) begin dram_rst <= Mem_Rst; end

    //pull transactions out of transaction FIFO when remote side indicates time slice available
    //and there is stuff to be done and we are not in the middle of another
    //transaction
    always @( posedge dram_clk )
    begin
        if( dram_rst ) begin rd_txn_fifo <= 1'b0;
        end else begin
            if(~txn_fifo_empty && dram_ready && ~rd_txn_fifo) rd_txn_fifo <= 1'b1; 
            else rd_txn_fifo <= 1'b0;

            rd_txn_fifo_d1 <= rd_txn_fifo;
            rd_txn_fifo_d2 <= rd_txn_fifo_d1;
            txn_fifo_output_d1 <= txn_fifo_output;
        end
    end
    assign txn_fifo_re = rd_txn_fifo;

    //always read address from address fifo
    assign rd_add_fifo = rd_txn_fifo_d1;
    assign add_fifo_re = rd_add_fifo;

    //read data from data fifo if output of transaction fifo indicates a write
    assign rd_data_fifo = rd_txn_fifo_d1 & ~txn_fifo_output;
    always @( posedge dram_clk ) begin rd_data_fifo_d1 <= rd_data_fifo; end
    assign data_fifo_re = rd_data_fifo | rd_data_fifo_d1;

    assign dram_reset = dram_rst;

    //read data in
    assign rd_data_fifo_we = dram_data_valid;
    assign rd_data_fifo_input = dram_data_i;

    /************************************************************************************/
    /* Mem_Clk clk domain */
    /************************************************************************************/

    reg write_toggle;
    wire second_write;
    reg mem_reset;

    always @ (posedge Mem_Clk) begin mem_reset <= sys_rst | Mem_Rst; end

    //keep track of when second write happens
    always @ (posedge Mem_Clk) 
    begin
        if( mem_reset ) write_toggle <= 0;
        else if( Mem_Cmd_Valid & ~Mem_Cmd_RNW ) write_toggle <= ~second_write;
    end

    assign second_write = write_toggle & ~Mem_Cmd_RNW & Mem_Cmd_Valid;

    //ack if transaction accepted
    assign Mem_Cmd_Ack = Mem_Cmd_Valid & (~add_fifo_almost_full | ~txn_fifo_almost_full | ~data_fifo_almost_full);
    
    assign data_fifo_input[144+18-1:0] = { Mem_Wr_Din[143:0], Mem_Wr_BE[17:0] };
    //write into data fifo on a write transaction
    assign data_fifo_we = second_write;

    assign add_fifo_input = Mem_Cmd_Address;
    //write address on read or second write
    assign add_fifo_we = (Mem_Cmd_Valid & Mem_Cmd_RNW) | second_write; 

    assign txn_fifo_input = Mem_Cmd_RNW;
    //register transaction on read or second write
    assign txn_fifo_we = (Mem_Cmd_Valid & Mem_Cmd_RNW) | second_write;

    generate
        if (BRAM_FIFOS == 0) //making FIFOS from distributed memory
        begin:shallow_fifo

        end
        else //making FIFOs from BRAMs
        begin:deep_fifo

        end
    endgenerate

endmodule
