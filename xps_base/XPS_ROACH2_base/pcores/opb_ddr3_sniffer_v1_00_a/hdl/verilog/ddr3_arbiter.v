module ddr3_arbiter(
 input  clk,
 input  rst,

 // signals to/from ddr3 
 output reg [  2:0]master_cmd,         
 output reg [ 31:0]master_addr,
 output reg        master_en,           
 output reg [287:0]master_wdf_data,
 output reg [ 35:0]master_wdf_mask,
 output reg        master_wdf_end,      
 output reg        master_wdf_wren,     
 input             master_rdy,          
 input             master_wdf_rdy,      
 input      [287:0]master_rd_data,
 input             master_rd_data_valid,
 input             master_rd_data_end,  

 // signals to/from async fifo (this one has priority)
 input      [  2:0]slave0_cmd,
 input      [ 31:0]slave0_addr,
 input             slave0_en,
 input      [287:0]slave0_wdf_data,
 input      [ 35:0]slave0_wdf_mask,
 input             slave0_wdf_end,
 input             slave0_wdf_wren,
 output reg        slave0_rdy,
 output reg        slave0_wdf_rdy,
 output     [287:0]slave0_rd_data,
 output            slave0_rd_data_valid,
 output            slave0_rd_data_end,

 // sniffer signals (low priority and read-only)
 input      [  2:0]slave1_cmd,
 input      [ 31:0]slave1_addr,
 input             slave1_en,
 input      [287:0]slave1_wdf_data,
 input      [ 35:0]slave1_wdf_mask,
 input             slave1_wdf_end,
 input             slave1_wdf_wren,
 output reg        slave1_rdy,
 output reg        slave1_wdf_rdy,
 output     [287:0]slave1_rd_data,
 output            slave1_rd_data_valid,
 output            slave1_rd_data_end
);
//------------------------------------------------------------------------------
// Command constants
localparam READ  = 3'b001;
localparam WRITE = 3'b000;
//------------------------------------------------------------------------------
// The different states are required to handle the different read and write
// cycle timing options

reg   [1:0]State;
localparam Idle   = 2'd0;
localparam S0Busy = 2'd1;
localparam S1Busy = 2'd2;
//------------------------------------------------------------------------------
// registers for the read outputs
// these written to asynchronously
reg [287:0] slave0_rd_data_reg;
reg         slave0_rd_data_valid_reg;
reg         slave0_rd_data_end_reg;
reg [287:0] slave1_rd_data_reg;
reg         slave1_rd_data_valid_reg;
reg         slave1_rd_data_end_reg;
// these latched
reg [287:0] slave0_rd_data_regZ;
reg         slave0_rd_data_valid_regZ;
reg         slave0_rd_data_end_regZ;
reg [287:0] slave1_rd_data_regZ;
reg         slave1_rd_data_valid_regZ;
reg         slave1_rd_data_end_regZ;
//------------------------------------------------------------------------------
// This is synchronous read data
 
always @(posedge clk) begin
 slave0_rd_data_regZ       <= slave0_rd_data_reg;
 slave0_rd_data_valid_regZ <= slave0_rd_data_valid_reg;
 slave0_rd_data_end_regZ   <= slave0_rd_data_end_reg;
 slave1_rd_data_regZ       <= slave1_rd_data_reg;
 slave1_rd_data_valid_regZ <= slave1_rd_data_valid_reg;
 slave1_rd_data_end_regZ   <= slave1_rd_data_end_reg;
end

assign slave0_rd_data       = slave0_rd_data_regZ;
assign slave0_rd_data_valid = slave0_rd_data_valid_regZ;
assign slave0_rd_data_end   = slave0_rd_data_end_regZ;
assign slave1_rd_data       = slave1_rd_data_regZ;
assign slave1_rd_data_valid = slave1_rd_data_valid_regZ;
assign slave1_rd_data_end   = slave1_rd_data_end_regZ;

//------------------------------------------------------------------------------
// This is asynchronous in order to handle the case where both tries to
// command the controller at the same time.

always @(*) begin
 case(State)
  S0Busy: begin

   master_cmd           = slave0_cmd;
   master_addr          = slave0_addr;
   master_en            = slave0_en;

   master_wdf_data      = slave0_wdf_data;
   master_wdf_mask      = slave0_wdf_mask;
   master_wdf_end       = slave0_wdf_end;
   master_wdf_wren      = slave0_wdf_wren;
    
   slave0_rdy           = master_rdy;
   slave0_wdf_rdy       = master_wdf_rdy;

   slave0_rd_data_reg       = master_rd_data;
   slave0_rd_data_valid_reg = master_rd_data_valid;
   slave0_rd_data_end_reg   = master_rd_data_end;

   slave1_rdy           = 0; // this works with state machine forcing S0Busy
   slave1_wdf_rdy       = 0;

   slave1_rd_data_reg       = 0;
   slave1_rd_data_valid_reg = 0;
   slave1_rd_data_end_reg   = 0;
  end
//------------------------------------------------------------------------------
  S1Busy: begin //  
   master_cmd           = slave1_cmd;
   master_addr          = slave1_addr;
   master_en            = slave1_en;

   master_wdf_data      = slave1_wdf_data;
   master_wdf_mask      = slave1_wdf_mask;
   master_wdf_end       = slave1_wdf_end;
   master_wdf_wren      = slave1_wdf_wren;

   slave0_rdy           = 0;
   slave0_wdf_rdy       = 0;

   slave0_rd_data_reg       = 0;
   slave0_rd_data_valid_reg = 0;
   slave0_rd_data_end_reg   = 0;
 
   slave1_rdy           = master_rdy;
   slave1_wdf_rdy       = master_wdf_rdy;

   slave1_rd_data_reg       = master_rd_data;
   slave1_rd_data_valid_reg = master_rd_data_valid;
   slave1_rd_data_end_reg   = master_rd_data_end;
  end
//------------------------------------------------------------------------------
  default: begin // Idle ("default" to prevent inferred latches)
   if(slave0_en | slave0_wdf_wren) begin // Higher priority*/
    master_cmd           = slave0_cmd;
    master_addr          = slave0_addr;
    master_en            = slave0_en;

    master_wdf_data      = slave0_wdf_data;
    master_wdf_mask      = slave0_wdf_mask;
    master_wdf_end       = slave0_wdf_end;
    master_wdf_wren      = slave0_wdf_wren;
    
    slave0_rdy           = master_rdy;
    slave0_wdf_rdy       = master_wdf_rdy;

    slave0_rd_data_reg       = master_rd_data;
    slave0_rd_data_valid_reg = master_rd_data_valid;
    slave0_rd_data_end_reg   = master_rd_data_end;

    slave1_rdy           = 0;
    slave1_wdf_rdy       = 0;

    slave1_rd_data_reg       = 0;
    slave1_rd_data_valid_reg = 0;
    slave1_rd_data_end_reg   = 0;

   end else if(slave1_en) begin
   //end else if(0) begin
    master_cmd           = slave1_cmd;
    master_addr          = slave1_addr;
    master_en            = slave1_en;

    master_wdf_data      = slave1_wdf_data;
    master_wdf_mask      = slave1_wdf_mask;
    master_wdf_end       = slave1_wdf_end;
    master_wdf_wren      = slave1_wdf_wren;

    slave0_rdy           = 0;
    slave0_wdf_rdy       = 0;

    slave0_rd_data_reg       = 0;
    slave0_rd_data_valid_reg = 0;
    slave0_rd_data_end_reg   = 0;

    slave1_rdy           = master_rdy;
    slave1_wdf_rdy       = master_wdf_rdy;

    slave1_rd_data_reg       = master_rd_data;
    slave1_rd_data_valid_reg = master_rd_data_valid;
    slave1_rd_data_end_reg   = master_rd_data_end;

   end else begin
    master_cmd           = slave0_cmd;
    master_addr          = slave0_addr;
    master_en            = slave0_en;

    master_wdf_data      = slave0_wdf_data;
    master_wdf_mask      = slave0_wdf_mask;
    master_wdf_end       = slave0_wdf_end;
    master_wdf_wren      = slave0_wdf_wren;

    slave0_rdy           = master_rdy;
    slave0_wdf_rdy       = master_wdf_rdy;

    slave0_rd_data_reg       = master_rd_data;
    slave0_rd_data_valid_reg = master_rd_data_valid;
    slave0_rd_data_end_reg   = master_rd_data_end;
    
    slave1_rdy           = master_rdy;
    slave1_wdf_rdy       = master_wdf_rdy;

    slave1_rd_data_reg       = master_rd_data;
    slave1_rd_data_valid_reg = master_rd_data_valid;
    slave1_rd_data_end_reg   = master_rd_data_end;
   end
  end
 endcase
end
//------------------------------------------------------------------------------
// Useful short-cuts
wire [1:0]WriteCommand;
wire [1:0]WriteEnd;
wire [1:0]ReadCommand;
wire [1:0]ReadEnd;

assign WriteCommand[0] = (slave0_cmd == WRITE) & master_rdy & slave0_en;
assign ReadCommand [0] = (slave0_cmd == READ ) & master_rdy & slave0_en;
assign WriteEnd    [0] = (slave0_wdf_end & master_wdf_rdy & slave0_wdf_wren);
assign ReadEnd     [0] = (master_rd_data_end & master_rd_data_valid);

assign WriteCommand[1] = (slave1_cmd == WRITE) & master_rdy & slave1_en;
assign ReadCommand [1] = (slave1_cmd == READ ) & master_rdy & slave1_en;
assign WriteEnd    [1] = (slave1_wdf_end & master_wdf_rdy & slave1_wdf_wren);
assign ReadEnd     [1] = (master_rd_data_end & master_rd_data_valid);
//------------------------------------------------------------------------------

// The commands and corresponding data transfer is not synchronised, so keep
// counters.  Assume that 16-bit is sufficient (not sure how safe this is...)
reg [16:0]WriteCommandCount;
reg [16:0]WriteEndCount;
reg [16:0]ReadCommandCount;
reg [16:0]ReadEndCount;

reg Reset;

always @(posedge clk) begin
 Reset <= rst;

 if(Reset) begin
  State             <= Idle;
  WriteCommandCount <= 0;
  WriteEndCount     <= 0;
  ReadCommandCount  <= 0;
  ReadEndCount      <= 0;
//------------------------------------------------------------------------------

 end else begin
  case(State)
   Idle: begin
    if(slave0_en | slave0_wdf_wren) begin // Higher priority
     State <= S0Busy; 
     
     WriteCommandCount <= WriteCommand[0];
     WriteEndCount     <= WriteEnd    [0];
     ReadCommandCount  <= ReadCommand [0];
     ReadEndCount      <= ReadEnd     [0];

    end else if(slave1_en) begin
    //end else if(0) begin
     State <= S1Busy;

     WriteCommandCount <= WriteCommand[1];
     WriteEndCount     <= WriteEnd    [1];
     ReadCommandCount  <= ReadCommand [1];
     ReadEndCount      <= ReadEnd     [1];
    end else begin
	 WriteCommandCount <= 0;
     WriteEndCount     <= 0;
     ReadCommandCount  <= 0;
     ReadEndCount      <= 0;
	end
   end
//------------------------------------------------------------------------------

   S0Busy: begin
    if(
     (WriteCommandCount == WriteEndCount) && 
     (ReadCommandCount  == ReadEndCount )
    ) begin
     // At this point, another transaction can potentially be lodged...
     if(slave0_en | slave0_wdf_wren) begin
      WriteCommandCount <= WriteCommand[0];
      WriteEndCount     <= WriteEnd    [0];
      ReadCommandCount  <= ReadCommand [0];
      ReadEndCount      <= ReadEnd     [0];

     end else begin // All transactions finished and no new transaction...
      State <= Idle;
     end
     
    end else begin
     WriteCommandCount <= WriteCommandCount + WriteCommand[0];
     WriteEndCount     <= WriteEndCount     + WriteEnd    [0];
     ReadCommandCount  <= ReadCommandCount  + ReadCommand [0];
     ReadEndCount      <= ReadEndCount      + ReadEnd     [0];
    end
   end
//------------------------------------------------------------------------------

   S1Busy: begin
    if(
     (WriteCommandCount == WriteEndCount) && 
     (ReadCommandCount  == ReadEndCount )
    ) begin
     // At this point, another transaction can potentially be lodged...
     if(slave1_en | slave1_wdf_wren) begin
      WriteCommandCount <= WriteCommand[1];
      WriteEndCount     <= WriteEnd    [1];
      ReadCommandCount  <= ReadCommand [1];
      ReadEndCount      <= ReadEnd     [1];

     end else begin // All transactions finished and no new transaction...
      State <= Idle;
     end
     
    end else begin
     WriteCommandCount <= WriteCommandCount + WriteCommand[1];
     WriteEndCount     <= WriteEndCount     + WriteEnd    [1];
     ReadCommandCount  <= ReadCommandCount  + ReadCommand [1];
     ReadEndCount      <= ReadEndCount      + ReadEnd     [1];
    end
   end
//------------------------------------------------------------------------------

   default: begin
    State             <= Idle;
    WriteCommandCount <= 0;
    WriteEndCount     <= 0;
    ReadCommandCount  <= 0;
    ReadEndCount      <= 0;
   end
  endcase
 end
end

endmodule
//------------------------------------------------------------------------------

