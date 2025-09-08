// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// replace scfifof with sync fifo 
// use hmctl_async_fifo.v in the sync mode
// Michael CHu   8/19/2010

`timescale 1 ps / 1 ps
module alt_mem_ddrx_fifo
# (
    parameter
        CTL_FIFO_DATA_WIDTH              =    8,
        CTL_FIFO_ADDR_WIDTH              =    3
)
(
    // general
    ctl_clk,
    ctl_reset_n,

    // pop free fifo entry
    get_valid,
    get_ready,
    get_data,   

    // push free fifo entry
    put_valid,
    put_ready,
    put_data   

);


    // -----------------------------
    // local parameter declarations
    // -----------------------------

    localparam integer CTL_FIFO_DEPTH              = (2 ** CTL_FIFO_ADDR_WIDTH);
    localparam CTL_FIFO_TYPE                       = "SCFIFO";                      // SCFIFO, CUSTOM



    // -----------------------------
    // port declaration
    // -----------------------------

    input                               ctl_clk;
    input                               ctl_reset_n;

    // pop free fifo entry
    input                               get_ready;
    output                              get_valid;
    output [CTL_FIFO_DATA_WIDTH-1:0]    get_data;   

    // push free fifo entry
    output                              put_ready;
    input                               put_valid;
    input  [CTL_FIFO_DATA_WIDTH-1:0]    put_data;


    // -----------------------------
    // port type declaration
    // -----------------------------

    wire                                get_valid;
    wire                                get_ready;
    wire [CTL_FIFO_DATA_WIDTH-1:0]      get_data;   

    wire                                put_valid;
    wire                                put_ready;
    wire [CTL_FIFO_DATA_WIDTH-1:0]      put_data;


    // -----------------------------
    // signal declaration
    // -----------------------------

    reg [CTL_FIFO_DATA_WIDTH-1:0]       fifo          [CTL_FIFO_DEPTH-1:0];
    reg [CTL_FIFO_DEPTH-1:0]            fifo_v;

    wire                                fifo_get;
    wire                                fifo_put;
    wire                                fifo_empty;
    wire                                fifo_full;

    wire zero;



    // -----------------------------
    // module definition
    // -----------------------------

    assign fifo_get = get_valid & get_ready;
    assign fifo_put = put_valid & put_ready;
    assign zero = 1'b0;


    generate
    begin : gen_fifo_instance
        if (CTL_FIFO_TYPE == "SCFIFO")
        begin

            assign get_valid = ~fifo_empty;
            assign put_ready = ~fifo_full;

            hmctl_async_fifo
                #(
                        .FIFO_WIDTH (CTL_FIFO_DATA_WIDTH),
                        .FIFO_DEPTH (CTL_FIFO_DEPTH),                      // has to be a of the form 2 ^ N
                        .HALF_DATA_SUPPORT (0) 
                ) 
                     scfifo_component (

                        //Boot Time Options
                        .cfg_close_to_empty ({{CTL_FIFO_ADDR_WIDTH-1{1'b0}},1'b1}),    // used to determine the offset for calculationg the almost_empty flag
                        .cfg_close_to_full  ({{CTL_FIFO_ADDR_WIDTH-1{1'b1}},1'b0}),     // used to determine the offset for calculationg the almost_full  flag
                        .cfg_sync_mode  (1'b1),                            // changes the FIFO to work in synchronous mode (read and write clock are sourced together)
                        .cfg_inc_sync   (1'b0),                             // Engineering option to increase the synchronizer depth for meta-stability issues


                        //Run Time Options
                        .cfg_fifo_enable (1'b1),                          // Disable FIFO by connecting read/write enable to "0" when set to zero
                        .cfg_test_mode   (1'b0),                             // Engineering option to turn on test path for debug purpose
                        .cfg_x32_mode    (1'b0),                             // read_pop2 only allowed in this mode


                        // clocks
                        .write_clock (ctl_clk),
                        .read_clock  (ctl_clk),

                        // reset and enables
                        .aclr_system_n (ctl_reset_n),
                        .aclr_user_n   (ctl_reset_n),

                        // inputs
                        .write_data   (put_data),
                        .write_push   (put_valid),
                        .read_pop     (get_ready),
                        .read_pop2    (1'b0),                                // asymmetric read option

                        // outputs
                        .read_data    (get_data),
                        .read_data_2entry (),

                        // FIFO output flags
                        .fifo_full  (fifo_full),                                               // reported in write_clock domain.May go high when fifo not full.always high when fifo is full
                        .fifo_almost_full (),                                        // similar to full except reports fifo full when  `CLOSE_TO FULL  entries still available in fifo
                        .fifo_empty (fifo_empty),                                              // reported in read_clock domain.May go high when fifo not empty.always high when fifo is empty
                        .fifo_almost_empty (),                                       // similar to empty except reports fifo empty when `CLOSE_TO EMPTY  entries still available in fifo
                        .fifo_available_entries()            // reported in read_clock domain. entries remaining to be read out of FIFO as seen by read clock

            );


        end
        else // CTL_FIFO_TYPE == "CUSTOM"
        begin

            assign get_valid = fifo_v[0];
            assign put_ready = ~fifo_v[CTL_FIFO_DEPTH-1];
            assign get_data  = fifo[0];


                // put & get management
                integer i; 
                always @ (posedge ctl_clk or negedge ctl_reset_n) 
                begin
                    if (~ctl_reset_n)
                    begin
                        for (i = 0; i < CTL_FIFO_DEPTH; i = i + 1'b1)
                        begin
                            // initialize every entry
                            fifo           [i]     <= 0;
                            fifo_v         [i]     <= 1'b0;

                        end
                    end
                    else
                    begin
                        // get request code must be above put request code
                        if (fifo_get)
                        begin
                            // on a get request, fifo entry is shifted to move next entry to head
                            for (i = 1; i < CTL_FIFO_DEPTH; i = i + 1'b1)
                            begin
                                fifo_v     [i-1]   <=  fifo_v [i];
                                fifo       [i-1]   <=  fifo   [i];
                            end

                                fifo_v     [CTL_FIFO_DEPTH-1]   <=  0;
                        end

                        if (fifo_put)
                        begin
                            // on a put request, next empty fifo entry is written
                            
                            if (~fifo_get)
                            begin
                                // put request only
                                for (i = 1; i < CTL_FIFO_DEPTH; i = i + 1'b1)
                                begin
                                    if ( fifo_v[i-1] & ~fifo_v[i])
                                    begin
                                        fifo_v     [i]   <=  1'b1;
                                        fifo       [i]   <=  put_data;
                                    end
                                end
                                if (~fifo_v[0])
                                begin
                                    fifo_v     [0]   <=  1'b1;
                                    fifo       [0]   <=  put_data;
                                end
                            end
                            else
                            begin
                                // put & get request on same cycle
                                for (i = 1; i < CTL_FIFO_DEPTH; i = i + 1'b1)
                                begin
                                    if ( fifo_v[i-1] & ~fifo_v[i])
                                    begin
                                        fifo_v     [i-1]   <=  1'b1;
                                        fifo       [i-1]   <=  put_data;
                                    end
                                end
                                if (~fifo_v[0])
                                begin
                                    $display("error - fifo underflow");
                                end
                            end

                        end

                    end
                end
        end
    end
    endgenerate


                        function integer log2;
                        input integer value;
                        begin
                                value = value - 1;
                                for (log2=0; value>0; log2=log2+1)
                                        value = value>>1;
                        end
                        endfunction









endmodule

//
// ASSERT
//
// fifo underflow
//
