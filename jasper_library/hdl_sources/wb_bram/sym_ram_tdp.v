
// Asymetric RAM - TDP  
// READ_FIRST MODE.
// File: HDL_Coding_Techniques/rams/asym_ram_tdp_read_first.v


module sym_ram_tdp (clkA, clkB, enaA, enaB, weA, weB, addrA, addrB, diA, doA, diB, doB);
  parameter WIDTH = 4;
  parameter SIZE = 1024;
  parameter ADDRWIDTH = 10;
  parameter N_REGISTERS = 3;
  input clkA;
  input clkB;
  input weA, weB;
  input enaA, enaB;
  
  input [ADDRWIDTH-1:0] addrA;
  input [ADDRWIDTH-1:0] addrB;
  input [WIDTH-1:0] diA;
  input [WIDTH-1:0] diB;
  
  output [WIDTH-1:0] doA;
  output [WIDTH-1:0] doB;
  
  function integer log2;
  input integer value;
  reg [31:0] shifted;
  integer res;
  begin
    if (value < 2)
      log2 = value;
    else
    begin
      shifted = value-1;
      for (res=0; shifted>0; res=res+1)
        shifted = shifted>>1;
      log2 = res;
    end
  end
  endfunction
  
  reg [WIDTH-1:0] RAM [0:SIZE-1];
  reg [WIDTH-1:0] readA;
  reg [WIDTH-1:0] readB;

  
  always @(posedge clkB)
  begin
    if (enaB) begin
      readB <= RAM[addrB] ;
      if (weB)
        RAM[addrB] <= diB;
    end     
  end
  
  always @(posedge clkA)
  begin : portA
    if (enaA) begin
      readA <= RAM[addrA];
      if (weA)
        RAM[addrA] <= diA;
    end
  end
  
  // The tools will not correctly absorb a register into the BRAM
  // if we use a shift register on the ram output.
  // So place one register explicitly, and if necessary put
  // a shift reg afterwards
  wire [WIDTH-1:0] readA_core_out;
  wire [WIDTH-1:0] readB_core_out;
  generate
  if (N_REGISTERS > 0) begin
    reg [WIDTH-1:0] readA_reg;
    reg [WIDTH-1:0] readB_reg;
    always @(posedge clkA) begin
      readA_reg <= readA;
    end
    always @(posedge clkB) begin
      readB_reg <= readB;
    end
    assign readA_core_out = readA_reg;
    assign readB_core_out = readB_reg;
  end else begin
    assign readA_core_out = readA;
    assign readB_core_out = readB;
  end 
  endgenerate
  
  // And now the shift reg (N_REGISTERS - 1), since
  // one register is already placed.
  // NOTE: if the register chain here is larger than
  // 1 it seems that it will suck the register
  // back out of the bram primitive. However,
  // the shift register implementation has been maintained
  // so the block won't die if N_REG > 2 is selected.
  // TODO: what happens when the user puts a register immediately
  // downstream of this block? Do we need explicit SHREG_EXTRACT is NO
  // directives?
  generate
  integer i;
  if (N_REGISTERS == 0) begin : no_registers
    assign doA = readA_core_out;
    assign doB = readB_core_out;
  end else if (N_REGISTERS == 1) begin: single_register
    assign doA = readA_core_out;
    assign doB = readB_core_out;
  end else if (N_REGISTERS > 1) begin : shift_reg_out
    reg [WIDTH-1:0] shreg_out_a [N_REGISTERS-2:0];
    reg [WIDTH-1:0] shreg_out_b [N_REGISTERS-2:0];
    always @(posedge clkA) begin
      shreg_out_a[0] <= readA_core_out;
      for (i=1; i<N_REGISTERS-1; i=i+1) begin
        shreg_out_a[i] <= shreg_out_a[i-1];
      end
    end
    always @(posedge clkB) begin
      shreg_out_b[0] <= readB_core_out;
      for (i=1; i<N_REGISTERS-1; i=i+1) begin
        shreg_out_b[i] <= shreg_out_b[i-1];
      end
    end
  
    assign doA = shreg_out_a[N_REGISTERS-2];
    assign doB = shreg_out_b[N_REGISTERS-2];
  end
  endgenerate
  
endmodule
