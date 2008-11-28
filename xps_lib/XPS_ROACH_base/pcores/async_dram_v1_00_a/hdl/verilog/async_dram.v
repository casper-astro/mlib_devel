`timescale 1ns / 1ps

module async_dram
    (
       // -- Mem cmd ports ---------------
    Mem_Clk,
    Mem_Rst,
    Mem_Rdy,
    Mem_Cmd_Address,
    Mem_Cmd_RNW,
    Mem_Cmd_Valid,
    Mem_Cmd_Ack,
    Mem_Rd_Dout,
    Mem_Rd_Ack,
    Mem_Rd_Valid,
    Mem_Wr_Din,
    Mem_Wr_BE,

    // -- DDR2 ports ---------------
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

    //Use bram to make nice deep fifos which are needed for certain
    //applications.
    //Default is shallow, distributed RAM fifos
    PARAMETER         BRAM_FIFOS = 0;

    // -- dram ports -----------------
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
    output              Mem_Rdy;
    input [31:0]        Mem_Cmd_Address;
    input               Mem_Cmd_RNW;
    input               Mem_Cmd_Valid;

    output              Mem_Cmd_Ack;

    output [143:0]      Mem_Rd_Dout;

    input               Mem_Rd_Ack;
    output              Mem_Rd_Valid;

    input [143:0]       Mem_Wr_Din;
    input [17:0]        Mem_Wr_BE;


    //----------------------------------------------------------------------------
    // fifo storage 
    //----------------------------------------------------------------------------

    reg                 Mem_Cmd_Valid_d1;

    //data + byte enables
    wire[(144+18)-1:0]  data_fifo_input, data_fifo_output;
    wire                data_fifo_we, data_fifo_re, data_fifo_almost_full, data_fifo_empty;
    
    //address
    wire[31:0]          add_fifo_input, add_fifo_output;
    wire                add_fifo_we, add_fifo_re, add_fifo_almost_full, add_fifo_empty;

    //transaction type
    wire                txn_fifo_input, txn_fifo_output;
    wire                txn_fifo_we, txn_fifo_re, txn_fifo_almost_full, txn_fifo_empty;

    // fifo control
    reg     rd_txn_fifo, rd_txn_fifo_d1, rd_data_fifo_d1, rd_add_fifo;
    wire    rd_data_fifo;

    // outputs to dram

    //----------------------------------------------------------------------------
    // Implementation
    //----------------------------------------------------------------------------
   
    //cross clock domain on way out 

/************************************************************************************/
/* dram_clk clk domain */
/************************************************************************************/

    //pull transactions out of FIFO when remote side indicates time slice available
    always @( posedge dram_clk )
    begin
            if( Mem_Rst ) begin 
                rd_txn_fifo <= 1'b0;
            end else begin
                if(~txn_fifo_empty && dram_ready) rd_txn_fifo <= 1'b1; 
                else rd_txn_fifo <= 1'b0;

                rd_txn_fifo_d1 <= rd_txn_fifo;
            end
    end

    assign txn_fifo_re <= rd_txn_fifo;

    //read data from data fifo if necessary
    assign data_fifo_re <= rd_txn_fifo_d1 | ~txn_fifo_output;
    assign data
    always @( posedge dram_clk )
    begin
            if( Mem_Rst ) begin 
                data_fifo_re <= 1'b0;
            end else begin
                data_fifo_re_d1 
            end
    end


/************************************************************************************/
/* Mem_Clk clk domain */
/************************************************************************************/

    //save address, data, byte enables, transaction type in FIFOs
    always @( posedge Mem_Clk ) begin Mem_Cmd_Valid_d1; end
    
    assign data_fifo_input = { Mem_Wr_Din, Mem_Wr_BE };
    assign data_fifo_we = Mem_Cmd_Valid | Mem_Cmd_Valid_d1;

    assign add_fifo_input = Mem_Cmd_Address;
    assign add_fifo_we = Mem_Cmd_Valid; 

    assign txn_fifo_input = Mem_Cmd_RNW;
    assign txn_fifo_we = Mem_Cmd_Valid;

    generate
    if (BRAM_FIFOS == 0) //making FIFOS from distributed memory
    begin:shallow_fifo
    end
    else //making FIFOs from BRAMs
    begin:deep_fifo
    end

endmodule
