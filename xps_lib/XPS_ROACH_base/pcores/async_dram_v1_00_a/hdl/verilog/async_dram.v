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
    input [31:0]        Mem_Cmd_Address;
    input               Mem_Cmd_RNW;
    input               Mem_Cmd_Valid;
    input[31:0]         Mem_Cmd_Tag;

    output              Mem_Cmd_Ack;

    output [143:0]      Mem_Rd_Dout;

    input               Mem_Rd_Ack;
    output              Mem_Rd_Valid;
    input[31:0]         Mem_Rd_Tag;

    input [143:0]       Mem_Wr_Din;
    input [17:0]        Mem_Wr_BE;

    //registers and signals

    reg			        dram_rst;

    reg                 Mem_Cmd_Valid_d1;
    reg                 dram_data_valid_d1, dram_data_i_d1;

    //----------------------------------------------------------------------------
    // fifo storage 
    //----------------------------------------------------------------------------

    reg                 txn_pending;

    // fifo control
    reg                 rd_txn_fifo;
    reg                 rd_rd_data_fifo, rd_rd_data_fifo_d1;

    //fifo interface

    //transaction type fifo
    wire[144+32+18+1-1:0]   txn_fifo_input, txn_fifo_output;
    wire                    txn_fifo_we, txn_fifo_re, txn_fifo_almost_full, txn_fifo_empty, txn_fifo_valid;
   
    //read data fifo
    wire[143:0]         rd_data_fifo_input, rd_data_fifo_output;
    wire                rd_data_fifo_we, rd_data_fifo_valid, rd_data_fifo_re, rd_data_fifo_empty, rd_data_fifo_almost_full;

/************************************************************************************/
/* dram_clk clk domain */
/************************************************************************************/

`ifdef DEBUG
    always @ (posedge dram_clk)
    begin
        if(dram_cmd_en && ~dram_rnw) begin 
            $display($time, ":async_dram: issuing write of %x masked with %x to %x", dram_data_o, dram_byte_enable, dram_address);
        end
        if(dram_cmd_en && dram_rnw) begin 
            $display($time, ":async_dram: issuing read of %x",dram_address);
        end
    end
`endif

    //cross clk domain for reset
    always @ ( posedge dram_clk ) begin dram_rst <= Mem_Rst | sys_rst; end

    // outputs to dram
    assign dram_data_o = txn_fifo_output[(144+18+32+1)-1:(18+32+1)]; 
    assign dram_byte_enable = txn_fifo_output[(18+32+1)-1:(32+1)];
    assign dram_address = txn_fifo_output[(32+1)-1:1];
    assign dram_rnw = txn_fifo_output[0]; 
    assign dram_cmd_en = dram_ready & (txn_pending | txn_fifo_valid);

    always @( posedge dram_clk )
    begin
        if( dram_rst ) 
        begin 
            rd_txn_fifo <= 1'b0;
            txn_pending <= 1'b0;
        end else begin

            //Pull transactions out of transaction FIFO when there is stuff to be done 
            //and (there is nothing in the pipeline or the pipeline is about to
            //be cleared)
            if( ~txn_fifo_empty && ( ~txn_pending || dram_ready ) ) 
            begin
                rd_txn_fifo <= 1'b1;
`ifdef DESPERATE_DEBUG
                $display($time,":async_dram: reading transaction fifo");
`endif
            end else begin
                rd_txn_fifo <= 1'b0;
            end

            //hold record of transaction in progress if will not complete this
            //cycle
            if( txn_fifo_valid && ~dram_ready ) 
            begin
                txn_pending <= 1'b1;
            end else begin
                if( dram_ready ) 
                begin 
                    txn_pending <= 1'b0; 
                end
            end
                
        end
    end
    assign txn_fifo_re = rd_txn_fifo;

    //read data in
    assign rd_data_fifo_we = dram_data_valid;
    assign rd_data_fifo_input = dram_data_i;

`ifdef DEBUG
    always @ (posedge dram_clk)
    begin
        if(dram_data_valid)
        begin
            $display($time,":async_dram: received read data %x",dram_data_i);
        end
    end
`endif

/************************************************************************************/
/* Mem_Clk clk domain */
/************************************************************************************/

    reg mem_reset;

    always @ (posedge Mem_Clk) begin mem_reset <= sys_rst | Mem_Rst; end

    //ack if space in FIFOs
    assign Mem_Cmd_Ack = ~txn_fifo_almost_full;
    
    assign txn_fifo_input[(144+18+32+1)-1:0] = { Mem_Wr_Din[143:0], Mem_Wr_BE[17:0], Mem_Cmd_Address[31:0], Mem_Cmd_RNW };

    //register transaction on read or second write
    assign txn_fifo_we = Mem_Cmd_Valid;

`ifdef DEBUG
    always @ (posedge Mem_Clk)
    begin
        if(Mem_Cmd_Valid && ~Mem_Cmd_RNW) begin 
            $display($time,":async_dram: received write transaction %x masked with %x to %x", Mem_Wr_Din, Mem_Wr_BE, Mem_Cmd_Address);
        end
        if(Mem_Cmd_Valid && Mem_Cmd_RNW) begin 
            $display($time,":async_dram: received read transaction for %x",Mem_Cmd_Address);
        end
    end
`endif

/************************************************************************************/
/* Send data back through on read */
/************************************************************************************/

    reg rd_pending;
    
    //read return data out of fifos when available  
    always @ (posedge Mem_Clk)
    begin
        if( mem_reset ) begin
            rd_rd_data_fifo <= 1'b0;
            rd_pending <= 1'b0;
        end else begin
            if( ~rd_data_fifo_empty && (~rd_pending || Mem_Rd_Ack) ) 
            begin
                //if no previous transaction or previous acknowledged transaction
`ifdef DESPERATE_DEBUG
                $display("async_dram: reading return data from read data fifo");
`endif
                rd_rd_data_fifo <= 1'b1;
            end else begin
                rd_rd_data_fifo <= 1'b0;
            end
        end
    
        if( rd_data_fifo_valid && ~Mem_Rd_Ack ) 
        begin
            rd_pending <= 1'b1;
        end else begin
            if( Mem_Rd_Ack ) 
            begin
                rd_pending <= 1'b0;
            end
        end

    end
    assign rd_data_fifo_re = rd_rd_data_fifo;

    assign Mem_Rd_Valid = (rd_pending | rd_data_fifo_valid) & Mem_Rd_Ack; 
    assign Mem_Rd_Dout = rd_data_fifo_output;

`ifdef DEBUG
    always @ (posedge Mem_Clk)
    begin
        if( Mem_Rd_Valid)
        begin
            $display("async_dram: sending back %x",Mem_Rd_Dout);
        end
    end
`endif


/*--------------------------------------------------------------*/
// FIFOs
/*--------------------------------------------------------------*/

/*TODO use valid outputs of FIFOs to control use of data*/

    rd_fifo rd_data_fifo0(
        .din( rd_data_fifo_input ),
        .rd_clk ( Mem_Clk ),
	    .rd_en( rd_data_fifo_re ),
	    .rst( dram_rst ),
	    .wr_clk( dram_clk ),
	    .wr_en( rd_data_fifo_we ),
	    .dout( rd_data_fifo_output ),
	    .empty( rd_data_fifo_empty ),
	    .full( rd_data_fifo_almost_full ),
    	.valid( rd_data_fifo_valid ) 
    );


    transaction_fifo transaction_fifo0(
        .din( txn_fifo_input ),
        .rd_clk( dram_clk ),
        .rd_en( txn_fifo_re ),
        .rst( mem_reset ),
        .wr_clk( Mem_Clk ),
        .wr_en( txn_fifo_we ),
        .dout( txn_fifo_output ),
        .empty( txn_fifo_empty ),
        .full(),
        .prog_full( txn_fifo_almost_full ),
        .valid( txn_fifo_valid )
    );

/*
    generate
        if (BRAM_FIFOS == 0) //making FIFOS from distributed memory
        begin:shallow_fifos

        end
        else //making FIFOs from BRAMs
        begin:deep_fifos

        end
    endgenerate
*/

endmodule
