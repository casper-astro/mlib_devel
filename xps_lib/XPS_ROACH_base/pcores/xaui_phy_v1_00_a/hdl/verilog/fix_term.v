`include "xaui_kat.vh"
module fix_term(
    data_i,
    isk_i,
    data_o,
    isk_o,
    disperr,
    current_term,
    next_term
  );
  input  [31:0] data_i;
  input   [3:0] isk_i;
  output [31:0] data_o;
  output  [3:0] isk_o;
  input   [3:0] disperr;
  input   [3:0] current_term;
  output  [3:0] next_term;

`ifdef TODO
  output  [3:0] term_pre_error_o;
  /* there was an error in the terminating column that needs to be propogated to the previous column
     each bit represents an error byte that needs to be inserted
  */
  output  [3:0] term_curr_error_o;
  /* there was an error in the terminating column that needs to propogated to the same column
     each bit represents an error byte that needs to be inserted
  */
  output  [3:0] term_post_error_o;
  /* there was an error in the column following the terminating column that needs to propogated to the terminating column
     each bit represents an error byte that needs to be inserted
  */

  /* this module performs the frame termination termination interpretation */
`endif

  function [3:0] decode_term;
  input [3:0] term;
  begin
    if (term[0]) begin
      decode_term = 4'b1110;
    end else if (term[1]) begin
      decode_term = 4'b1100;
    end else if (term[2]) begin
      decode_term = 4'b1000;
    end else if (term[3]) begin
      decode_term = 4'b0000;
    end else begin
      decode_term = 4'b0000;
    end
  end
  endfunction

  wire [3:0] is_term = {(isk_i[3] && data_i[31:24] == `SYM_TERM_), (isk_i[2] && data_i[23:16] == `SYM_TERM_),
                        (isk_i[1] && data_i[15:8]  == `SYM_TERM_), (isk_i[0] && data_i[7:0]   == `SYM_TERM_)};

  assign next_term = is_term; 

  wire [3:0] term_bytes = decode_term(is_term); /* which bytes need to be idle K */

  reg [7:0] data_int_3; 
  reg [7:0] data_int_2; 
  reg [7:0] data_int_1; 
  reg [7:0] data_int_0; 
  assign data_o = {data_int_3,  data_int_2, data_int_1, data_int_0};

  reg isk_int_3;
  reg isk_int_2;
  reg isk_int_1;
  reg isk_int_0;
  assign isk_o = {isk_int_3,  isk_int_2, isk_int_1, isk_int_0};

  /* Interpret data coming in */
  /* Frame termination - see check_end function in 802.3ae-2002 spec */
  /* TODO: according to the spec the ERROR symbol must propagate to 
           the byte in the previous column */

  function is_idle;
  input [7:0] in_byte;
  begin
    is_idle = in_byte == `SYM_A_ || in_byte == `SYM_K_ || in_byte == `SYM_R_;
  end
  endfunction

  always @(*) begin

    /* byte 0 */
    if (disperr[0]) begin /* Always report error on disparity check failure */
      data_int_0 <= `SYM_ERR_;
      isk_int_0  <= 1'b1;
    end else if (term_bytes[0]) begin
      /* In the terminating column all symbols must be SYM_Ks*/
      if (isk_i[0] && data_i[7:0] == `SYM_K_) begin
        data_int_0 <=`SYM_IDLE_;
        isk_int_0  <= 1'b1;
      end else begin
        data_int_0 <=`SYM_ERR_;
        isk_int_0  <= 1'b1;
      end
    end else if (|current_term) begin
      /* In the column after the terminating column all symbols must be SYM_Ks or SYM_As*/
      if (isk_i[0] && (data_i[7:0] == `SYM_K_|| data_i[7:0] == `SYM_A_)) begin
        data_int_0 <=`SYM_IDLE_;
        isk_int_0  <= 1'b1;
      end else begin
        data_int_0 <=`SYM_ERR_;
        isk_int_0  <= 1'b1;
      end
    end else begin
      if (is_idle(data_i[7:0]) && isk_i[0]) begin
        data_int_0 <= `SYM_IDLE_;
      end else begin
        data_int_0 <= data_i[7:0];
      end
      isk_int_0  <= isk_i[0];
    end

    /* byte 1 */
    if (disperr[1]) begin /* Always report error on disparity check failure */
      data_int_1 <= `SYM_ERR_;
      isk_int_1  <= 1'b1;
    end else if (term_bytes[1]) begin
      /* In the terminating column all symbols must be SYM_Ks*/
      if (isk_i[1] && data_i[15:8] == `SYM_K_) begin
        data_int_1 <=`SYM_IDLE_;
        isk_int_1  <= 1'b1;
      end else begin
        data_int_1 <=`SYM_ERR_;
        isk_int_1  <= 1'b1;
      end
    end else if (|current_term) begin
      /* In the column after the terminating column all symbols must be SYM_Ks or SYM_As*/
      if (isk_i[1] && (data_i[15:8] == `SYM_K_|| data_i[15:8] == `SYM_A_)) begin
        data_int_1 <=`SYM_IDLE_;
        isk_int_1  <= 1'b1;
      end else begin
        data_int_1 <=`SYM_ERR_;
        isk_int_1  <= 1'b1;
      end
    end else begin
      if (is_idle(data_i[15:8]) && isk_i[1]) begin
        data_int_1 <= `SYM_IDLE_;
      end else begin
        data_int_1 <= data_i[15:8];
      end
      isk_int_1  <= isk_i[1];
    end

    /* byte 2 */
    if (disperr[2]) begin /* Always report error on disparity check failure */
      data_int_2 <= `SYM_ERR_;
      isk_int_2  <= 1'b1;
    end else if (term_bytes[2]) begin
      /* In the terminating column all symbols must be SYM_Ks*/
      if (isk_i[2] && data_i[23:16] == `SYM_K_) begin
        data_int_2 <=`SYM_IDLE_;
        isk_int_2  <= 1'b1;
      end else begin
        data_int_2 <=`SYM_ERR_;
        isk_int_2  <= 1'b1;
      end
    end else if (|current_term) begin
      /* In the column after the terminating column all symbols must be SYM_Ks or SYM_As*/
      if (isk_i[2] && (data_i[23:16] == `SYM_K_|| data_i[23:16] == `SYM_A_)) begin
        data_int_2 <=`SYM_IDLE_;
        isk_int_2  <= 1'b1;
      end else begin
        data_int_2 <=`SYM_ERR_;
        isk_int_2  <= 1'b1;
      end
    end else begin
      if (is_idle(data_i[23:16]) && isk_i[2]) begin
        data_int_2 <= `SYM_IDLE_;
      end else begin
        data_int_2 <= data_i[23:16];
      end
      isk_int_2  <= isk_i[2];
    end

    /* byte 3 */
    if (disperr[3]) begin /* Always report error on disparity check failure */
      data_int_3 <= `SYM_ERR_;
      isk_int_3  <= 1'b1;
    end else if (term_bytes[3]) begin
      /* In the terminating column all symbols must be SYM_Ks*/
      if (isk_i[3] && data_i[31:24] == `SYM_K_) begin
        data_int_3 <=`SYM_IDLE_;
        isk_int_3  <= 1'b1;
      end else begin
        data_int_3 <=`SYM_ERR_;
        isk_int_3  <= 1'b1;
      end
    end else if (|current_term) begin
      /* In the column after the terminating column all symbols must be SYM_Ks or SYM_As*/
      if (isk_i[3] && (data_i[31:24] == `SYM_K_|| data_i[31:24] == `SYM_A_)) begin
        data_int_3 <=`SYM_IDLE_;
        isk_int_3  <= 1'b1;
      end else begin
        data_int_3 <=`SYM_ERR_;
        isk_int_3  <= 1'b1;
      end
    end else begin
      if (is_idle(data_i[31:24]) && isk_i[3]) begin
        data_int_3 <= `SYM_IDLE_;
      end else begin
        data_int_3 <= data_i[31:24];
      end
      isk_int_3  <= isk_i[3];
    end
  end

endmodule
