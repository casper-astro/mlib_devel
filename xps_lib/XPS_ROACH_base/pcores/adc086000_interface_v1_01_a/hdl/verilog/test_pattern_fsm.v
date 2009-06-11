module adc083000_spi (
  clock,
  reset,
  start,
  word,
  done,
  sdata,
  scs // serial chip select
  );
  
  // Inputs and Outputs
  //===================
  input clock;
  input reset;
  input start;
  input [31:0] word;
  
  output done;
  output sdata;
  output scs;

  // Wires and Regs
  //===============
  reg shift;
  reg load;
  reg done;
  reg scs;
  reg [3:0] STATE, NEXT_STATE;
  wire [31:0] shift_count;
  wire [31:0] pout;
  
  // Module declarations
  //====================
  //module ShiftRegister(PIn, SIn, POut, SOut, Load, Enable, Clock, Reset);
  ShiftRegister TestPatternWriteData(
    .Clock(clock),
    .Reset(reset),
    .Enable(shift),
    .Load(load),
    .SOut(sdata),
    .POut(pout),
    .SIn(),
    .PIn(word)
  );
  defparam TestPatternWriteData.pwidth = 32;
  defparam TestPatternWriteData.swidth = 1;
  
  //module	Counter(Clock, Reset, Set, Load, Enable, In, Count);
  Counter shift_counter(
    .Clock(clock),
    .Reset(reset),
    .Load(),
    .Set(),
    .Enable(shift),
    .In(),
    .Count(shift_count)
  );
  
  // FSM
  //====
  parameter STATE_IDLE = 0;
  parameter STATE_ASSERT_SCS = 1;
  parameter STATE_DONE = 2;
  parameter STATE_SHIFT_BITS = 3;
  
  always @ (posedge clock) begin
    if (reset) begin
      STATE <= STATE_IDLE;
    end else begin
      STATE <= NEXT_STATE;
    end
  end
  
  always @ ( * ) begin
    load = 0;
    scs = 1;
    shift = 0;
    done = 0;
    NEXT_STATE = STATE;
    case (STATE) 

      STATE_IDLE: begin
        load = 1;
        if (start) begin
          NEXT_STATE = STATE_ASSERT_SCS;
        end
      end
      
      STATE_ASSERT_SCS: begin
        scs = 0;
        NEXT_STATE = STATE_SHIFT_BITS;
      end
      
      STATE_SHIFT_BITS: begin 
        scs = 0;
        shift = 1;
        if (shift_count == 6'd32) begin 
          scs = 1;
          shift = 0;
          NEXT_STATE = STATE_DONE;
        end
      end
      
      STATE_DONE: begin
        done = 1;
        if (~start) begin
          NEXT_STATE = STATE_IDLE;
        end
      end
    endcase
  end
endmodule
    
    
    
