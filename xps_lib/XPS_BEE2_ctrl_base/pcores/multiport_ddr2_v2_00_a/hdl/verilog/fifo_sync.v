module fifo_sync
  (
   clk,
   rst,
   din,
   wr_en,
   dout,
   rd_en,
   empty,
   full
   );

   parameter            D_WIDTH = 1;
   parameter            A_WIDTH = 1;   
   parameter            DEPTH   = 16;
   
   input                clk;
   input                rst;
   input [D_WIDTH-1:0]  din;
   input                wr_en;
   output [D_WIDTH-1:0] dout;
   input                rd_en;
   output               empty;
   output               full;

   ////////////////////
   // Implementation //
   ////////////////////

   // change attribute to block or distributed   
   // synthesis attribute ram_style of mem is auto
   reg [D_WIDTH-1:0] mem [DEPTH-1:0];

   reg               full_state;
   
   reg [A_WIDTH-1:0] head, tail;

   wire              push, pop;
   wire              full_test, empty_test;

   // Full and empty signals
   assign            empty = empty_test & ~full_state;
   assign            full = full_state;
   
   // Push and pop signals
   assign            push = ~full & wr_en;
   assign            pop = ~empty & rd_en;

   // Full and empty test signals
   assign            empty_test = (head == tail);
   assign            full_test = ((tail + 1'b1) == head);

   // Read output
   assign            dout = mem[head];

   always @( posedge clk )
     begin
        if (push)
          mem[tail] <= din;
     end

   always @( posedge clk )
     begin
        if (rst)
          full_state <= 1'b0;
        else if (push & ~pop & full_test)
          full_state <= 1'b1;
        else if (pop & ~push)
          full_state <= 1'b0;
     end
   
   always @( posedge clk )
     begin
        if (rst)
          tail <= {A_WIDTH{1'b0}};
        else if (push)
          tail <= tail + 1'b1;
     end

   always @( posedge clk )
     begin
        if (rst)
          head <= {A_WIDTH{1'b0}};
        else if (pop)
          head <= head + 1'b1;
     end

endmodule
