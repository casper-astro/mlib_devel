/*
 *
 *  Module name: openhmc_rx_pkt_serializer
 *  Ensures maximum one FLIT transaction per an AXI cycle. This eases the requirements of the FLIT decoder
 *
 */ 

`default_nettype none

module openhmc_rx_pkt_serializer #(
    parameter LOG_FPW           = 2,
    parameter FPW               = 4,
    parameter DWIDTH            = FPW*128,
    parameter NUM_DATA_BYTES    = FPW*16
) (

    //----------------------------------
    //----SYSTEM INTERFACE
    //----------------------------------
    input   wire                        clk,
    input   wire                        res_n,

    //----------------------------------
    //----Connect USER Logic
    //----------------------------------
    //To USER Logic
    input  wire                         out_TREADY,
    output reg                          out_TVALID,
    output reg  [DWIDTH-1:0]            out_TDATA,
    output wire [NUM_DATA_BYTES-1:0] out_TUSER,

    //----------------------------------
    //----Connect openHMC
    //----------------------------------
    //From openHMC
    output reg                           in_TREADY,
    input  wire                          in_TVALID,
    input  wire  [DWIDTH-1:0]            in_TDATA,
    input  wire  [NUM_DATA_BYTES-1:0] in_TUSER
);

//=====================================================================================================
//-----------------------------------------------------------------------------------------------------
//---------WIRING AND SIGNAL STUFF---------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
//=====================================================================================================

reg [FPW-1:0]       next_valid;
reg [FPW-1:0]       valid_mask;
reg                 stall;
reg                 tail_seen;
reg                 hdr_seen;

reg [FPW-1:0]       buf_valid_mask;
reg                 buf_stall;
reg                 buf_tail_seen;
reg                 buf_hdr_seen;

wire [FPW-1:0]      flit_in_is_tail;
wire [FPW-1:0]      flit_in_is_valid;
wire [FPW-1:0]      flit_in_is_hdr;
wire [127:0]        flit_in            [FPW-1:0];

wire[127:0]         out_flit            [FPW-1:0];
reg [FPW-1:0]       out_flit_is_tail;
reg [FPW-1:0]       out_flit_is_valid;
reg [FPW-1:0]       out_flit_is_hdr;

reg [DWIDTH-1:0]    buf_data;
reg                 use_buf;

reg [FPW-1:0]       buf_flit_is_tail;
reg [FPW-1:0]       buf_flit_is_valid;
reg [FPW-1:0]       buf_flit_is_hdr;

generate
genvar i;
    for(i=0;i<FPW;i=i+1) begin : reorder_data
        //Input to FLITS
        assign flit_in[i]           = in_TDATA[i*128+:128];
        assign flit_in_is_valid[i]  = in_TUSER[i];
        assign flit_in_is_hdr[i]    = in_TUSER[i+FPW];
        assign flit_in_is_tail[i]   = in_TUSER[i+(2*FPW)];

        assign out_flit[i]          = out_TDATA[i*128+:128];
        //Assign the outputs
        assign out_TUSER            = {out_flit_is_tail,out_flit_is_hdr,out_flit_is_valid};
    end
endgenerate

//=====================================================================================================
//-----------------------------------------------------------------------------------------------------
//---------LOGIC STARTS HERE---------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------
//=====================================================================================================

integer i_f;

always @(*) begin
    stall         = 1'b0;
    tail_seen     = 1'b0;
    hdr_seen      = 1'b0;

    buf_stall         = 1'b0;
    buf_tail_seen     = 1'b0;
    buf_hdr_seen      = 1'b0;

    valid_mask    = {FPW{1'b0}};
    buf_valid_mask= {FPW{1'b0}};

    if(in_TVALID) begin
        for(i_f=0;i_f<FPW;i_f=i_f+1)begin
            if(flit_in_is_tail[i_f]) tail_seen = 1'b1;
            if(flit_in_is_hdr[i_f]) begin
                if(hdr_seen || tail_seen) stall = 1'b1;
                hdr_seen = 1'b1;
            end
            valid_mask[i_f] = ~stall;
        end
    end

    for(i_f=0;i_f<FPW;i_f=i_f+1)begin
        if(buf_flit_is_tail[i_f] && next_valid[i_f]) buf_tail_seen = 1'b1;

        if(buf_flit_is_hdr[i_f] && next_valid[i_f]) begin
            if(buf_hdr_seen || buf_tail_seen) buf_stall = 1'b1;
            buf_hdr_seen = 1'b1;
        end
        buf_valid_mask[i_f] = ~buf_stall;
    end
end


`ifdef ASYNC_RES
always @(posedge clk or negedge res_n)  begin `else
always @(posedge clk)  begin `endif
    if(!res_n) begin
        out_TVALID  <= 1'b0;
        next_valid  <= {FPW{1'b0}};

        in_TREADY  <= 1'b0;

        use_buf     <= 1'b0;
        buf_data    <= {DWIDTH{1'b0}};

            buf_flit_is_tail   <= {FPW{1'b0}};
            buf_flit_is_hdr    <= {FPW{1'b0}};
            buf_flit_is_valid  <= {FPW{1'b0}};

    end else begin

        in_TREADY   <= out_TREADY && !((!use_buf && stall && in_TVALID && in_TREADY) || (use_buf && buf_stall));
        
        if(out_TREADY) next_valid          <= use_buf ? buf_flit_is_valid & ~buf_valid_mask : flit_in_is_valid & ~valid_mask;
        else if (in_TREADY) next_valid <= {FPW{1'b1}};

        if(in_TVALID && in_TREADY) begin
            buf_data            <= in_TDATA;
            buf_flit_is_tail    <= flit_in_is_tail;
            buf_flit_is_hdr     <= flit_in_is_hdr;
            buf_flit_is_valid   <= flit_in_is_valid;
        end

        use_buf     <= (!use_buf && stall && in_TREADY && in_TVALID) || (use_buf && (buf_stall || !out_TREADY)) || (in_TREADY && in_TVALID && !out_TREADY);

        if(out_TREADY) begin
            out_TDATA       <= use_buf ? buf_data : in_TDATA;
            out_TVALID      <= (in_TVALID && in_TREADY) || use_buf;
        end

        if(out_TREADY) begin
            if(use_buf) begin
                out_flit_is_tail   <= buf_flit_is_tail  & buf_valid_mask & next_valid;
                out_flit_is_valid  <= buf_flit_is_valid & buf_valid_mask & next_valid;
                out_flit_is_hdr    <= buf_flit_is_hdr   & buf_valid_mask & next_valid; 
            end else begin
                out_flit_is_tail   <= flit_in_is_tail  & valid_mask;
                out_flit_is_valid  <= flit_in_is_valid & valid_mask;
                out_flit_is_hdr    <= flit_in_is_hdr   & valid_mask;               
            end

        end
    end
end

endmodule // htl_rx_pkt_serializer
`default_nettype wire