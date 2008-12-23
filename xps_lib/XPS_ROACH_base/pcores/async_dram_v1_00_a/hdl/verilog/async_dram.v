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
    dram_reset,
    dram_data_o,
    dram_byte_enable,
    dram_data_i,
    dram_data_valid,
    dram_address,
    dram_rnw,
    dram_cmd_en,
    dram_ready
    );
    output dram_reset;

    //sys ports
    input                   sys_rst;

    // -- dram ports -----------------
    input                   dram_clk;
    output [144-1:0]        dram_data_o;
    output [18-1:0]         dram_byte_enable;
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

    output [(144 * (C_WIDE_DATA+1))-1:0]      Mem_Rd_Dout;

    input               Mem_Rd_Ack;
    output              Mem_Rd_Valid;
    input[31:0]         Mem_Rd_Tag;

    input [(144*(C_WIDE_DATA+1))-1:0]       Mem_Wr_Din;
    input [(18*(C_WIDE_DATA+1))-1:0]        Mem_Wr_BE;

    //registers and signals

    reg			        dram_rst;
    assign              dram_reset = dram_rst;

    //----------------------------------------------------------------------------
    // fifo storage 
    //----------------------------------------------------------------------------

    reg write_toggle;

    //fifo interface

    //data and byte enable fifo
    wire[(144*(C_WIDE_DATA+1)+(18*(C_WIDE_DATA+1)))-1:0]        dat_fifo_input;
    wire[(144+18)-1:0]      dat_fifo_output;
    wire                    dat_fifo_we, dat_fifo_re, dat_fifo_almost_full, dat_fifo_empty;
    
    //operation and address fifo
    wire[(32+1)-1:0]        txn_fifo_input, txn_fifo_output;
    wire                    txn_fifo_we, txn_fifo_re, txn_fifo_almost_full, txn_fifo_empty;

    //read data fifo
    wire[143:0]             rd_data_fifo_input; 
    wire[(144*(C_WIDE_DATA+1))-1:0] rd_data_fifo_output;
    wire                    rd_data_fifo_we, rd_data_fifo_re, rd_data_fifo_empty, rd_data_fifo_full, rd_data_fifo_almost_full;


/************************************************************************************/
/* dram_clk clk domain */
/************************************************************************************/

`ifdef DEBUG
    always @ (posedge dram_clk)
    begin
        if( dram_cmd_en && ~dram_rnw ) begin 
            $display($time, ": async_dram: issuing write of 0x%x masked with %x to 0x%x", dram_data_o, dram_byte_enable, dram_address);
        end
        if( dram_cmd_en && dram_rnw ) begin 
            $display($time, ": async_dram: issuing read of 0x%x",dram_address);
        end
    end
`endif

    reg second_write;
    wire rnw;
    assign rnw = txn_fifo_output[0];

    //cross clk domain for reset
    always @ ( posedge dram_clk ) begin dram_rst <= Mem_Rst | sys_rst; end

    // outputs to dram
    assign dram_data_o = dat_fifo_output[(144+18)-1:18];
    assign dram_byte_enable = dat_fifo_output[(18)-1:0];
    assign dram_address = txn_fifo_output[(32+1)-1:1];
    assign dram_rnw = rnw;
    assign dram_cmd_en = ~txn_fifo_empty | second_write;

    always @ (posedge dram_clk) 
    begin 
        if( dram_reset )
        begin
            second_write <= 1'b0;
        end else begin
            second_write <= 1'b0;
            if( !second_write ) 
            begin
               if( !txn_fifo_empty & dram_ready & !rnw ) 
               begin
                   second_write <= 1'b1;
               end 
            end  
        end 
    end
   
    assign txn_fifo_re = (!txn_fifo_empty & dram_ready & rnw) | second_write;
    assign dat_fifo_re = (!txn_fifo_empty & dram_ready & !rnw) | second_write;

`ifdef DESPERATE_DEBUG
    always @ (posedge dram_clk) 
    begin
        if( txn_fifo_re ) begin $display($time, ": async_dram: Read address fifo. add = 0x%x txn = %x", txn_fifo_output[(32+1)-1:1], txn_fifo_output[0]); end
        if( dat_fifo_re ) begin $display($time, ": async_dram: Read data fifo. data = 0x%x, Mask = 0x%x", dat_fifo_output[(144+18)-1:18], dat_fifo_output[17:0]); end
    end
`endif

    //read data in
    assign rd_data_fifo_we = dram_data_valid;
    assign rd_data_fifo_input = dram_data_i;

`ifdef DEBUG
    always @ (posedge dram_clk)
    begin
        if(dram_data_valid)
        begin
            $display($time,": async_dram: received read data %x",dram_data_i);
        end
    end
`endif

/************************************************************************************/
/* Mem_Clk clk domain */
/************************************************************************************/

    reg mem_reset;

    always @ (posedge Mem_Clk) begin mem_reset <= sys_rst | Mem_Rst; end

generate if(C_WIDE_DATA == 0) 
    begin:toggle_narrow
        always @( posedge Mem_Clk )
        begin
            if(mem_reset) 
            begin write_toggle <= 1'b0; 
            end else begin 
                if( Mem_Cmd_Valid && ~Mem_Cmd_RNW) 
                begin 
                    write_toggle <= ~write_toggle; 
                end
            end
        end
    end else begin:toggle_wide
        always @ (posedge Mem_Clk ) begin write_toggle <= 1'b1; end
    end
endgenerate

    //prevent transactions if transaction fifos almost full or if reads in
    //danger of overflowing return buffer
    assign Mem_Cmd_Ack = ~txn_fifo_almost_full & ~dat_fifo_almost_full & ~rd_data_fifo_almost_full;
    
    assign txn_fifo_input[(32+1)-1:0] = {Mem_Cmd_Address, Mem_Cmd_RNW};

generate
    if( C_WIDE_DATA == 0 ) 
    begin:data_narrow 
        assign dat_fifo_input[(144+18)-1:0] = {Mem_Wr_Din[144-1:0], Mem_Wr_BE[18-1:0]}; 
    end else begin:data_wide
        assign dat_fifo_input[(144*2+18*2)-1:0] = {Mem_Wr_Din[(144*2)-1:144], Mem_Wr_BE[(18*2)-1:18], Mem_Wr_Din[143:0], Mem_Wr_BE[17:0]};
    end
endgenerate
    
    //record data on a write
    assign dat_fifo_we = Mem_Cmd_Ack & Mem_Cmd_Valid & ~Mem_Cmd_RNW;
    //record transaction on a read or second write
    assign txn_fifo_we = Mem_Cmd_Ack & Mem_Cmd_Valid & ((write_toggle & ~Mem_Cmd_RNW) | Mem_Cmd_RNW);

`ifdef DEBUG
    always @ (posedge Mem_Clk)
    begin
        if(Mem_Cmd_Valid && ~Mem_Cmd_RNW) begin 
            $display($time,": async_dram: received write transaction %x masked with %x to %x", Mem_Wr_Din, Mem_Wr_BE, Mem_Cmd_Address);
        end
        if(Mem_Cmd_Valid && Mem_Cmd_RNW) begin 
            $display($time,": async_dram: received read transaction for %x",Mem_Cmd_Address);
        end
    end
`endif

/************************************************************************************/
/* Send data back through on read */
/************************************************************************************/

    //read return data out of fifos when available  
    assign rd_data_fifo_re = ~rd_data_fifo_empty & Mem_Rd_Ack;

    assign Mem_Rd_Valid = ~rd_data_fifo_empty ; 
    assign Mem_Rd_Dout = rd_data_fifo_output;

`ifdef DEBUG
    always @ (posedge Mem_Clk)
    begin
        if( Mem_Rd_Valid)
        begin
            $display($time,": async_dram: sending back %x",Mem_Rd_Dout);
        end
    end
`endif


/*--------------------------------------------------------------*/
// FIFOs
/*--------------------------------------------------------------*/

`ifdef DEBUG
    always @ (rd_data_fifo_full)
    begin
        if( rd_data_fifo_full ) 
        begin
            $display($time,": async_dram: rd_data_fifo full");
        end
    end
`endif

`ifdef DEBUG
    always @ (rd_data_fifo_almost_full)
    begin
        if( rd_data_fifo_almost_full ) 
        begin
            $display($time,": async_dram: rd_data_fifo almost full");
        end
    end
`endif

generate
    if (BRAM_FIFOS == 0) //making FIFOS from distributed memory
    begin:shallow_fifos
         
        rd_fifo_dist rd_data_fifo0(
            .din( rd_data_fifo_input ),
            .rd_clk ( Mem_Clk ),
            .rd_en( rd_data_fifo_re ),
            .rst( dram_rst ),
            .wr_clk( dram_clk ),
            .wr_en( rd_data_fifo_we ),
            .dout( rd_data_fifo_output ),
            .empty( rd_data_fifo_empty ),
            .full( ),
            .prog_full( rd_data_fifo_almost_full ) 
        );

        data_fifo_dist dat_fifo(
            .din( dat_fifo_input ),
            .rd_clk( dram_clk ),
            .rd_en( dat_fifo_re ),
            .rst( mem_reset ),
            .wr_clk( Mem_Clk ),
            .wr_en( dat_fifo_we ),
            .dout( dat_fifo_output ),
            .empty( dat_fifo_empty ),
            .full( rd_data_fifo_full ),
            .prog_full( dat_fifo_almost_full )
        );
        
        transaction_fifo_dist txn_fifo(
            .din( txn_fifo_input ),
            .rd_clk( dram_clk ),
            .rd_en( txn_fifo_re ),
            .rst( mem_reset ),
            .wr_clk( Mem_Clk ),
            .wr_en( txn_fifo_we ),
            .dout( txn_fifo_output ),
            .empty( txn_fifo_empty ),
            .full(),
            .prog_full( txn_fifo_almost_full )
        );

    end else begin:deep_fifos

        rd_fifo_bram rd_data_fifo0(
            .din( rd_data_fifo_input ),
            .rd_clk ( Mem_Clk ),
            .rd_en( rd_data_fifo_re ),
            .rst( dram_rst ),
            .wr_clk( dram_clk ),
            .wr_en( rd_data_fifo_we ),
            .dout( rd_data_fifo_output ),
            .empty( rd_data_fifo_empty ),
            .full( rd_data_fifo_full ),
            .prog_full( rd_data_fifo_almost_full ) 
        );

        data_fifo_bram dat_fifo(
            .din( dat_fifo_input ),
            .rd_clk( dram_clk ),
            .rd_en( dat_fifo_re ),
            .rst( mem_reset ),
            .wr_clk( Mem_Clk ),
            .wr_en( dat_fifo_we ),
            .dout( dat_fifo_output ),
            .empty( dat_fifo_empty ),
            .full(),
            .prog_full( dat_fifo_almost_full )
        );
        
        transaction_fifo_bram txn_fifo(
            .din( txn_fifo_input ),
            .rd_clk( dram_clk ),
            .rd_en( txn_fifo_re ),
            .rst( mem_reset ),
            .wr_clk( Mem_Clk ),
            .wr_en( txn_fifo_we ),
            .dout( txn_fifo_output ),
            .empty( txn_fifo_empty ),
            .full(),
            .prog_full( txn_fifo_almost_full )
        );
        
    end
endgenerate


endmodule
