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

    // fifo control
    reg                 rd_rd_data_fifo, rd_rd_data_fifo_d1;

    //fifo interface

    //data and byte enable fifo
    wire[(144*(C_WIDE_DATA+1)+(18*(C_WIDE_DATA+1)))-1:0]        dat_fifo_input;
    wire[(144+18)-1:0]      dat_fifo_output;
    wire                    dat_fifo_we, dat_fifo_re, dat_fifo_almost_full, dat_fifo_empty;
    
    //operation and address fifo
    wire[(32+1)-1:0]        add_fifo_input, add_fifo_output;
    wire                    add_fifo_we, add_fifo_re, add_fifo_almost_full, add_fifo_empty;

    //read data fifo
    wire[143:0]             rd_data_fifo_input; 
    wire[(144*(C_WIDE_DATA+1))-1:0] rd_data_fifo_output;
    wire                    rd_data_fifo_we, rd_data_fifo_valid, rd_data_fifo_re, rd_data_fifo_empty, rd_data_fifo_almost_full;


/************************************************************************************/
/* dram_clk clk domain */
/************************************************************************************/

`ifdef DEBUG
    always @ (posedge dram_clk)
    begin
        if( dram_cmd_en && ~dram_rnw ) begin 
            $display($time, ":async_dram: issuing write of 0x%x masked with %x to 0x%x", dram_data_o, dram_byte_enable, dram_address);
        end
        if( dram_cmd_en && dram_rnw ) begin 
            $display($time, ":async_dram: issuing read of 0x%x",dram_address);
        end
    end
`endif
    
    wire rnw;
    assign rnw = add_fifo_output[0];

    //cross clk domain for reset
    always @ ( posedge dram_clk ) begin dram_rst <= Mem_Rst | sys_rst; end

    // outputs to dram
    assign dram_data_o = dat_fifo_output[(144+18)-1:18];
    assign dram_byte_enable = dat_fifo_output[(18)-1:0];
    assign dram_address = add_fifo_output[(32+1)-1:1];
    assign dram_rnw = rnw;
    assign dram_cmd_en = ~add_fifo_empty | second_write;

    reg second_write;
    always @ (posedge dram_clk) 
    begin 
        if( dram_reset )
        begin
            second_write <= 1'b0;
        end else begin
            second_write <= 1'b0;
            if( ~second_write ) 
            begin
               if( ~add_fifo_empty & dram_ready & ~rnw ) 
               begin
                   second_write <= 1'b1;
               end 
            end  
        end 
    end
   
    assign add_fifo_re = (~add_fifo_empty & dram_ready) & (second_write | rnw);
    assign dat_fifo_re = (~add_fifo_empty | second_write) & dram_ready & ~rnw;

    always @ (posedge dram_clk) 
    begin
        if( add_fifo_re ) begin $display($time, " :Read transaction add = 0x%x txn = %x", add_fifo_output[(32+1)-1:1], add_fifo_output[0]); end
        if( dat_fifo_re ) begin $display($time, " :Read data. Data = 0x%x, Mask = 0x%x", dat_fifo_output[(144+18)-1:18], dat_fifo_output[17:0]); end
    end

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

    generate
        if(C_WIDE_DATA == 0)
        begin
            always @( posedge Mem_Clk )
            begin
                if(mem_reset) 
                begin write_toggle <= 1'b0; 
                end else begin 
                    if( Mem_Cmd_Valid) 
                    begin 
                        if( Mem_Cmd_RNW )
                        begin
                            write_toggle <= 1'b0;
                        end else begin
                            write_toggle <= ~write_toggle; 
                        end
                    end
                end
            end
        end else begin
            always @ (posedge Mem_Clk ) begin write_toggle <= 1'b1; end
        end
    endgenerate

    //ack if space in FIFOs
    assign Mem_Cmd_Ack = ~add_fifo_almost_full & ~dat_fifo_almost_full;
    
    assign add_fifo_input[(32+1)-1:0] = {Mem_Cmd_Address, Mem_Cmd_RNW};

/*    generate
    begin
        if( C_WIDE_DATA == 0 ) 
        begin 
        */
            assign dat_fifo_input[(144+18)-1:0] = {Mem_Wr_Din[144-1:0], Mem_Wr_BE[18-1:0]}; 
/*        end else begin
            assign dat_fifo_input[(144*2+18*2)-1:0] = {Mem_Wr_Din[(144*2)-1:144], Mem_Wr_BE[(18*2)-1:18], Mem_Wr_Din[143:0], Mem_Wr_BE[17:0]};
        end
    endgenerate
  */  
    //register transaction on read or second write
    assign dat_fifo_we = Mem_Cmd_Valid & ~Mem_Cmd_RNW;
    assign add_fifo_we = Mem_Cmd_Valid & ((write_toggle & ~Mem_Cmd_RNW) | Mem_Cmd_RNW);

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

    //read return data out of fifos when available  
    assign rd_data_fifo_re = ~rd_data_fifo_empty & Mem_Rd_Ack;

    assign Mem_Rd_Valid = ~rd_data_fifo_empty ; 
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
    
    address_fifo_bram add_fifo(
        .din( add_fifo_input ),
        .rd_clk( dram_clk ),
        .rd_en( add_fifo_re ),
        .rst( mem_reset ),
        .wr_clk( Mem_Clk ),
        .wr_en( add_fifo_we ),
        .dout( add_fifo_output ),
        .empty( add_fifo_empty ),
        .full(),
        .prog_full( add_fifo_almost_full )
    );
    /*
    operation_fifo opn_fifo(
        .din( opn_fifo_input ),
        .rd_clk( dram_clk ),
        .rd_en( opn_fifo_re ),
        .rst( mem_reset ),
        .wr_clk( Mem_Clk ),
        .wr_en( opn_fifo_we ),
        .dout( opn_fifo_output ),
        .empty( opn_fifo_empty ),
        .full(),
        .prog_full( opn_fifo_almost_full )
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
    */

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
