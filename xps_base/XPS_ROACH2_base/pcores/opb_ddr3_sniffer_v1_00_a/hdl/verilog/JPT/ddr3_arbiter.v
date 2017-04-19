module ddr3_arbiter(
 input  clk,
 input  rst,

 // signals to/from ddr3 
 output reg [ 31:0]master_addr,
 output reg        master_wdf_wren,     // positive logic write strobe
 output reg        master_en,           // equivalent to master_cmd_valid
 output reg [287:0]master_wdf_data,
 output reg [ 35:0]master_wdf_mask,
 output reg [  2:0]master_cmd,          // new output (000=write, 001=read)
 output reg        master_wdf_end,      // new output - last write value
 input      [287:0]master_rd_data,
 input             master_rd_data_valid,
 input             master_rd_data_end,  // new input - last read value
 input             master_rdy,          // ready for command
 input             master_wdf_rdy,      // write data fifo ready

 // signals to/from async fifo (this one has priority)
 input      [ 31:0]slave0_addr,
 input             slave0_wdf_wren,
 input             slave0_en,
 input      [287:0]slave0_wdf_data,
 input      [ 35:0]slave0_wdf_mask,
 input      [  2:0]slave0_cmd,
 input             slave0_wdf_end,
 output reg [287:0]slave0_rd_data,
 output reg        slave0_rd_data_valid,
 output reg        slave0_rd_data_end,
 output reg        slave0_rdy,
 output reg        slave0_wdf_rdy,

 // sniffer signals (low priority and read-only)
 input      [ 31:0]slave1_addr,
 input             slave1_wdf_wren,
 input             slave1_en,
 input      [287:0]slave1_wdf_data,
 input      [ 35:0]slave1_wdf_mask,
 input      [  2:0]slave1_cmd,
 input             slave1_wdf_end,
 output reg [287:0]slave1_rd_data,
 output reg        slave1_rd_data_valid,
 output reg        slave1_rd_data_end,
 output reg        slave1_rdy,
 output reg        slave1_wdf_rdy
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

// This is asynchronous in order to handle the case where both tries to
// command the controller at the same time.

always @(*) begin
 case(State)
  Idle: begin
   if(slave0_en | slave0_wdf_wren) begin // Higher priority
    master_cmd           <= slave0_cmd;
    master_addr          <= slave0_addr;
    master_en            <= slave0_en;

    master_wdf_data      <= slave0_wdf_data;
    master_wdf_mask      <= slave0_wdf_mask;
    master_wdf_end       <= slave0_wdf_end;
    master_wdf_wren      <= slave0_wdf_wren;
    
    slave0_rdy           <= master_rdy;
    slave0_wdf_rdy       <= master_wdf_rdy;

    slave0_rd_data       <= master_rd_data;
    slave0_rd_data_valid <= master_rd_data_valid;
    slave0_rd_data_end   <= master_rd_data_end;

    slave1_rdy           <= 0;
    slave1_wdf_rdy       <= 0;

    slave1_rd_data       <= 0;
    slave1_rd_data_valid <= 0;
    slave1_rd_data_end   <= 0;

   end else if(slave1_en | slave1_wdf_wren) begin
    master_cmd           <= slave1_cmd;
    master_addr          <= slave1_addr;
    master_en            <= slave1_en;

    master_wdf_data      <= slave1_wdf_data;
    master_wdf_mask      <= slave1_wdf_mask;
    master_wdf_end       <= slave1_wdf_end;
    master_wdf_wren      <= slave1_wdf_wren;

    slave0_rdy           <= 0;
    slave0_wdf_rdy       <= 0;

    slave0_rd_data       <= 0;
    slave0_rd_data_valid <= 0;
    slave0_rd_data_end   <= 0;
    
    slave1_rdy           <= master_rdy;
    slave1_wdf_rdy       <= master_wdf_rdy;

    slave1_rd_data       <= master_rd_data;
    slave1_rd_data_valid <= master_rd_data_valid;
    slave1_rd_data_end   <= master_rd_data_end;

   end else begin
    master_cmd           <= 'hX;
    master_addr          <= 'hX;
    master_en            <=   0;

    master_wdf_data      <= 'hX;
    master_wdf_mask      <= 'hX;
    master_wdf_end       <= 'hX;
    master_wdf_wren      <=   0;
    
    slave0_rdy           <= master_rdy;
    slave0_wdf_rdy       <= master_wdf_rdy;

    slave0_rd_data       <= master_rd_data;
    slave0_rd_data_valid <= master_rd_data_valid;
    slave0_rd_data_end   <= master_rd_data_end;
    
    slave1_rdy           <= master_rdy;
    slave1_wdf_rdy       <= master_wdf_rdy;

    slave1_rd_data       <= master_rd_data;
    slave1_rd_data_valid <= master_rd_data_valid;
    slave1_rd_data_end   <= master_rd_data_end;
   end
  end
//------------------------------------------------------------------------------

  S0Busy: begin
   master_cmd           <= slave0_cmd;
   master_addr          <= slave0_addr;
   master_en            <= slave0_en;

   master_wdf_data      <= slave0_wdf_data;
   master_wdf_mask      <= slave0_wdf_mask;
   master_wdf_end       <= slave0_wdf_end;
   master_wdf_wren      <= slave0_wdf_wren;
    
   slave0_rdy           <= master_rdy;
   slave0_wdf_rdy       <= master_wdf_rdy;

   slave0_rd_data       <= master_rd_data;
   slave0_rd_data_valid <= master_rd_data_valid;
   slave0_rd_data_end   <= master_rd_data_end;

   slave1_rdy           <= 0;
   slave1_wdf_rdy       <= 0;

   slave1_rd_data       <= 0;
   slave1_rd_data_valid <= 0;
   slave1_rd_data_end   <= 0;
  end
//------------------------------------------------------------------------------
  
  default: begin // S1Busy ("default" to prevent inferred latches)
   master_cmd           <= slave1_cmd;
   master_addr          <= slave1_addr;
   master_en            <= slave1_en;

   master_wdf_data      <= slave1_wdf_data;
   master_wdf_mask      <= slave1_wdf_mask;
   master_wdf_end       <= slave1_wdf_end;
   master_wdf_wren      <= slave1_wdf_wren;

   slave0_rdy           <= 0;
   slave0_wdf_rdy       <= 0;

   slave0_rd_data       <= 0;
   slave0_rd_data_valid <= 0;
   slave0_rd_data_end   <= 0;
    
   slave1_rdy           <= master_rdy;
   slave1_wdf_rdy       <= master_wdf_rdy;

   slave1_rd_data       <= master_rd_data;
   slave1_rd_data_valid <= master_rd_data_valid;
   slave1_rd_data_end   <= master_rd_data_end;
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
reg [15:0]WriteCommandCount;
reg [15:0]WriteEndCount;
reg [15:0]ReadCommandCount;
reg [15:0]ReadEndCount;

always @(posedge clk) begin
 if(rst) begin
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

    end else if(slave1_en | slave1_wdf_wren) begin
     State <= S1Busy;

     WriteCommandCount <= WriteCommand[1];
     WriteEndCount     <= WriteEnd    [1];
     ReadCommandCount  <= ReadCommand [1];
     ReadEndCount      <= ReadEnd     [1];
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

   default:;
  endcase
 end
end
//------------------------------------------------------------------------------

endmodule
//------------------------------------------------------------------------------

