`timescale 1ns/1ps
`define LOG2(x) ((x) == 8 ? 3 : (x) == 4 ? 2 : 1)
module fifo_generator_v4_4_bhv_ver_as
  (
   WR_CLK, RD_CLK, RST, DIN, WR_EN, RD_EN,
   PROG_EMPTY_THRESH, PROG_EMPTY_THRESH_ASSERT, PROG_EMPTY_THRESH_NEGATE,
   PROG_FULL_THRESH, PROG_FULL_THRESH_ASSERT, PROG_FULL_THRESH_NEGATE,
   DOUT, FULL, ALMOST_FULL, WR_ACK, OVERFLOW, EMPTY, ALMOST_EMPTY, VALID,
   UNDERFLOW, RD_DATA_COUNT, WR_DATA_COUNT, PROG_FULL, PROG_EMPTY
   );
   
   /***************************************************************************
    * Declare user parameters and their defaults
    ***************************************************************************/
   parameter  C_DATA_COUNT_WIDTH             = 2;
   parameter  C_DIN_WIDTH                    = 8;
   parameter  C_DOUT_RST_VAL                 = "";
   parameter  C_DOUT_WIDTH                   = 8;
   parameter  C_FULL_FLAGS_RST_VAL           = 1;
   parameter  C_HAS_ALMOST_EMPTY             = 0;
   parameter  C_HAS_ALMOST_FULL              = 0;
   parameter  C_HAS_DATA_COUNT               = 0;
   parameter  C_HAS_OVERFLOW                 = 0;
   parameter  C_HAS_RD_DATA_COUNT            = 0;
   parameter  C_HAS_RST                      = 0;
   parameter  C_HAS_UNDERFLOW                = 0;
   parameter  C_HAS_VALID                    = 0;
   parameter  C_HAS_WR_ACK                   = 0;
   parameter  C_HAS_WR_DATA_COUNT            = 0;
   parameter  C_IMPLEMENTATION_TYPE          = 0;
   parameter  C_MEMORY_TYPE                  = 1;
   parameter  C_OVERFLOW_LOW                 = 0;
   parameter  C_PRELOAD_LATENCY              = 1;
   parameter  C_PRELOAD_REGS                 = 0;
   parameter  C_PROG_EMPTY_THRESH_ASSERT_VAL = 0;
   parameter  C_PROG_EMPTY_THRESH_NEGATE_VAL = 0;
   parameter  C_PROG_EMPTY_TYPE              = 0;
   parameter  C_PROG_FULL_THRESH_ASSERT_VAL  = 0;
   parameter  C_PROG_FULL_THRESH_NEGATE_VAL  = 0;
   parameter  C_PROG_FULL_TYPE               = 0;
   parameter  C_RD_DATA_COUNT_WIDTH          = 2;
   parameter  C_RD_DEPTH                     = 256;
   parameter  C_RD_PNTR_WIDTH                = 8;
   parameter  C_UNDERFLOW_LOW                = 0;
   parameter  C_USE_DOUT_RST                 = 0;
   parameter  C_USE_EMBEDDED_REG             = 0;
   parameter  C_USE_FWFT_DATA_COUNT          = 0;
   parameter  C_VALID_LOW                    = 0;
   parameter  C_WR_ACK_LOW                   = 0;
   parameter  C_WR_DATA_COUNT_WIDTH          = 2;
   parameter  C_WR_DEPTH                     = 256;
   parameter  C_WR_PNTR_WIDTH                = 8;

   /***************************************************************************
    * Declare Input and Output Ports
    ***************************************************************************/
   input [C_DIN_WIDTH-1:0] DIN;
   input [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH;
   input [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_ASSERT;
   input [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_NEGATE;
   input [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH;
   input [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_ASSERT;
   input [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_NEGATE;
   input 		       RD_CLK;
   input 		       RD_EN;
   input 		       RST;
   input 		       WR_CLK;
   input 		       WR_EN;
   output 		       ALMOST_EMPTY;
   output 		       ALMOST_FULL;
   output [C_DOUT_WIDTH-1:0]   DOUT;
   output 		       EMPTY;
   output 		       FULL;
   output 		       OVERFLOW;
   output 		       PROG_EMPTY;
   output 		       PROG_FULL;
   output 		       VALID;
   output [C_RD_DATA_COUNT_WIDTH-1:0] RD_DATA_COUNT;
   output                             UNDERFLOW;
   output                             WR_ACK;
   output [C_WR_DATA_COUNT_WIDTH-1:0] WR_DATA_COUNT;
   
  /*************************************************************************
   * Declare the type for each Input/Output port, and connect each I/O
   * to it's associated internal signal in the behavioral model
   * 
   * The values for the outputs are assigned in assign statements immediately
   * following wire, parameter, and function declarations in this code.
   *************************************************************************/
   //Inputs
   wire [C_DIN_WIDTH-1:0] DIN;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_ASSERT;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_NEGATE;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_ASSERT;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_NEGATE;   
   wire RD_CLK;
   wire RD_EN;
   wire RST;
   wire WR_CLK;
   wire WR_EN;

   //Outputs
   wire ALMOST_EMPTY;
   wire ALMOST_FULL;
   wire [C_DOUT_WIDTH-1:0] DOUT;   
   wire EMPTY;
   wire FULL;
   wire OVERFLOW;
   wire PROG_EMPTY;
   wire PROG_FULL;
   wire VALID;  
   wire [C_RD_DATA_COUNT_WIDTH-1:0] RD_DATA_COUNT;
   wire UNDERFLOW;
   wire WR_ACK;   
   wire [C_WR_DATA_COUNT_WIDTH-1:0] WR_DATA_COUNT;
   
  
   /***************************************************************************
    * Parameters used as constants
    **************************************************************************/
   //When RST is present, set FULL reset value to '1'.
   //If core has no RST, make sure FULL powers-on as '0'.
   parameter C_DEPTH_RATIO_WR =  
      (C_WR_DEPTH>C_RD_DEPTH) ? (C_WR_DEPTH/C_RD_DEPTH) : 1;
   parameter C_DEPTH_RATIO_RD =  
      (C_RD_DEPTH>C_WR_DEPTH) ? (C_RD_DEPTH/C_WR_DEPTH) : 1;
   parameter C_FIFO_WR_DEPTH = C_WR_DEPTH - 1;
   parameter C_FIFO_RD_DEPTH = C_RD_DEPTH - 1;

   
   // EXTRA_WORDS = 2 * C_DEPTH_RATIO_WR / C_DEPTH_RATIO_RD
   // WR_DEPTH : RD_DEPTH = 1:2 => EXTRA_WORDS = 1
   // WR_DEPTH : RD_DEPTH = 1:4 => EXTRA_WORDS = 1 (rounded to ceiling)
   // WR_DEPTH : RD_DEPTH = 2:1 => EXTRA_WORDS = 4
   // WR_DEPTH : RD_DEPTH = 4:1 => EXTRA_WORDS = 8
   parameter EXTRA_WORDS = (C_DEPTH_RATIO_RD > 1)? 1:(2 * C_DEPTH_RATIO_WR);
   // extra_words_dc = 2 * C_DEPTH_RATIO_WR / C_DEPTH_RATIO_RD
   //  C_DEPTH_RATIO_WR | C_DEPTH_RATIO_RD | C_PNTR_WIDTH    | EXTRA_WORDS_DC
   //  -----------------|------------------|-----------------|---------------
   //  1                | 8                | C_RD_PNTR_WIDTH | 0
   //  1                | 4                | C_RD_PNTR_WIDTH | 0
   //  1                | 2                | C_RD_PNTR_WIDTH | 1
   //  1                | 1                | C_WR_PNTR_WIDTH | 2
   //  2                | 1                | C_WR_PNTR_WIDTH | 4
   //  4                | 1                | C_WR_PNTR_WIDTH | 8
   //  8                | 1                | C_WR_PNTR_WIDTH | 16
   parameter EXTRA_WORDS_DC = ( C_DEPTH_RATIO_RD > 2)?
                              0:(2 * C_DEPTH_RATIO_WR/C_DEPTH_RATIO_RD);  
   

   parameter [31:0] reads_per_write = C_DIN_WIDTH/C_DOUT_WIDTH;
   
   parameter [31:0] log2_reads_per_write = `LOG2(reads_per_write);
   
   parameter [31:0] writes_per_read = C_DOUT_WIDTH/C_DIN_WIDTH;
   
   parameter [31:0] log2_writes_per_read = `LOG2(writes_per_read);



   /**************************************************************************
    * FIFO Contents Tracking and Data Count Calculations
    *************************************************************************/
   
   //Memory which will be used to simulate a FIFO
   reg [C_DIN_WIDTH-1:0] memory[C_WR_DEPTH-1:0];

   //The amount of data stored in the FIFO at any time is given
   // by num_wr_bits (in the WR_CLK domain) and num_rd_bits (in the RD_CLK
   // domain.
   //num_wr_bits is calculated by considering the total words in the FIFO,
   // and the state of the read pointer (which may not have yet crossed clock
   // domains.)
   //num_rd_bits is calculated by considering the total words in the FIFO,
   // and the state of the write pointer (which may not have yet crossed clock
   // domains.)
   reg [31:0]  num_wr_bits;
   reg [31:0]  num_rd_bits;
   reg [31:0]  next_num_wr_bits;
   reg [31:0]  next_num_rd_bits;

   //The write pointer - tracks write operations
   // (Works opposite to core: wr_ptr is a DOWN counter)
   reg [31:0]  wr_ptr;

   //The read pointer - tracks read operations
   // (Works opposite to core: rd_ptr is a DOWN counter)
   reg [31:0]  rd_ptr;

   //Pointers passed into opposite clock domain
   reg [31:0]  wr_ptr_rdclk;
   reg [31:0]  wr_ptr_rdclk_next;
   reg [31:0]  rd_ptr_wrclk;
   reg [31:0]  rd_ptr_wrclk_next;

   //Amount of data stored in the FIFO scaled to the narrowest (deepest) port
   // (Do not include data in FWFT stages)
   //Used to calculate PROG_EMPTY.
   wire [31:0] num_read_words_pe = 
     num_rd_bits/(C_DOUT_WIDTH/C_DEPTH_RATIO_WR);

   //Amount of data stored in the FIFO scaled to the narrowest (deepest) port
   // (Do not include data in FWFT stages)
   //Used to calculate PROG_FULL.
   wire [31:0] num_write_words_pf =
     num_wr_bits/(C_DIN_WIDTH/C_DEPTH_RATIO_RD);

   /**************************
    * Read Data Count
    *************************/

   /* ORIGINAL CODE - Removed 10/24/07 jeo
   //Amount of data stored in the FIFO scaled to read words
   // (Do not include data in FWFT stages)
   //Not used in the code.
   wire [31:0] num_read_words_dc = num_rd_bits/C_DOUT_WIDTH;
   
   //Amount of data stored in the FIFO scaled to read words
   // (Include data in FWFT stages)
   //Not used in the code.
   wire [31:0] num_read_words_fwft_dc = (num_rd_bits/C_DOUT_WIDTH+2);
   
   //Not used in the code.
   wire [31:0] num_read_words_dc_i = 
     C_USE_FWFT_DATA_COUNT ? num_read_words_fwft_dc : num_read_words_dc;

   //Not used in the code.
   wire [C_RD_DATA_COUNT_WIDTH-1:0] num_read_words_sized = 
     num_read_words_dc_i[C_RD_PNTR_WIDTH-1 : C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH];
   
   //Not used in the code.
   wire [C_RD_DATA_COUNT_WIDTH-1:0] num_read_words_sized_fwft = 
     num_read_words_dc_i[C_RD_PNTR_WIDTH : C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH+1];

   //Used to calculate ideal_rd_count (RD_DATA_COUNT)
   wire [C_RD_DATA_COUNT_WIDTH-1:0] num_read_words_sized_i = 
     C_USE_FWFT_DATA_COUNT ? num_read_words_sized_fwft : num_read_words_sized;
   */

   reg [31:0] num_read_words_dc;
   reg [C_RD_DATA_COUNT_WIDTH-1:0] num_read_words_sized_i;
   
   always @(num_rd_bits) begin
     if (C_USE_FWFT_DATA_COUNT) begin
	
	//If using extra logic for FWFT Data Counts, 
	// then scale FIFO contents to read domain, 
	// and add two read words for FWFT stages
	//This value is only a temporary value and not used in the code.
        num_read_words_dc = (num_rd_bits/C_DOUT_WIDTH+2);
	
        //Trim the read words for use with RD_DATA_COUNT
	num_read_words_sized_i = 
          num_read_words_dc[C_RD_PNTR_WIDTH : C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH+1];
	
     end else begin
	
	//If not using extra logic for FWFT Data Counts, 
	// then scale FIFO contents to read domain.
	//This value is only a temporary value and not used in the code.
        num_read_words_dc = num_rd_bits/C_DOUT_WIDTH;
	
        //Trim the read words for use with RD_DATA_COUNT
	num_read_words_sized_i = 
          num_read_words_dc[C_RD_PNTR_WIDTH-1 : C_RD_PNTR_WIDTH-C_RD_DATA_COUNT_WIDTH];
	
     end //if (C_USE_FWFT_DATA_COUNT)
   end //always





   
   
   
   /**************************
    * Write Data Count
    *************************/
   /* ORIGINAL CODE - Removed 10/24/07 jeo

   //Calculate the Data Count value for the number of write words, when not
   // using First-Word Fall-Through with extra logic for Data Counts. This 
   // calculates only the number of words in the internal FIFO.
   //The expression (((A-1)/B))+1 divides A/B, but takes the 
   // ceiling of the result.
   //When num_wr_bits==0, set the result manually to prevent division errors.
   wire [31:0] 	num_write_words_dc = 
     (num_wr_bits==0) ? 0 : ((num_wr_bits-1)/C_DIN_WIDTH) + 1;

   //Calculate the Data Count value for the number of write words, when using
   // First-Word Fall-Through with extra logic for Data Counts. This takes into
   // consideration the number of words that are expected to be stored in the
   // FWFT register stages (it always assumes they are filled).
   //The expression (((A-1)/B))+1 divides A/B, but takes the 
   // ceiling of the result.
   //When num_wr_bits==0, set the result manually to prevent division errors.
   //EXTRA_WORDS_DC is the number of words added to write_words due to FWFT.
   wire [31:0] num_write_words_fwft_dc = 
     (num_wr_bits==0) ? EXTRA_WORDS_DC :  (((num_wr_bits-1)/C_DIN_WIDTH) + 1) + EXTRA_WORDS_DC ;

   wire [31:0] num_write_words_dc_i = 
     C_USE_FWFT_DATA_COUNT ? num_write_words_fwft_dc : num_write_words_dc;
    
    
   
   wire [C_WR_DATA_COUNT_WIDTH-1:0] num_write_words_sized = 
     num_write_words_dc_i[C_WR_PNTR_WIDTH-1 : C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH];
   
   wire [C_WR_DATA_COUNT_WIDTH-1:0] num_write_words_sized_fwft = 
     num_write_words_dc_i[C_WR_PNTR_WIDTH : C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH+1];

       wire [C_WR_DATA_COUNT_WIDTH-1:0] num_write_words_sized_i = C_USE_FWFT_DATA_COUNT?
                                num_write_words_sized_fwft:num_write_words_sized;
   
   */

   reg [31:0] num_write_words_dc;
   reg [C_WR_DATA_COUNT_WIDTH-1:0] num_write_words_sized_i;
   
   always @(num_wr_bits) begin
     if (C_USE_FWFT_DATA_COUNT) begin
	
	//Calculate the Data Count value for the number of write words, 
	// when using First-Word Fall-Through with extra logic for Data 
	// Counts. This takes into consideration the number of words that 
	// are expected to be stored in the FWFT register stages (it always 
	// assumes they are filled).
	//This value is scaled to the Write Domain.
	//The expression (((A-1)/B))+1 divides A/B, but takes the 
	// ceiling of the result.
	//When num_wr_bits==0, set the result manually to prevent 
	// division errors.
	//EXTRA_WORDS_DC is the number of words added to write_words 
	// due to FWFT.
	//This value is only a temporary value and not used in the code.
        num_write_words_dc = (num_wr_bits==0) ? EXTRA_WORDS_DC :  (((num_wr_bits-1)/C_DIN_WIDTH)+1) + EXTRA_WORDS_DC ;
	
        //Trim the write words for use with WR_DATA_COUNT
	num_write_words_sized_i = 
          num_write_words_dc[C_WR_PNTR_WIDTH : C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH+1];
	
     end else begin
	
	//Calculate the Data Count value for the number of write words, when NOT
	// using First-Word Fall-Through with extra logic for Data Counts. This 
	// calculates only the number of words in the internal FIFO.
	//The expression (((A-1)/B))+1 divides A/B, but takes the 
	// ceiling of the result.
	//This value is scaled to the Write Domain.
	//When num_wr_bits==0, set the result manually to prevent 
	// division errors.
	//This value is only a temporary value and not used in the code.
        num_write_words_dc = (num_wr_bits==0) ? 0 : ((num_wr_bits-1)/C_DIN_WIDTH)+1;
	
        //Trim the read words for use with RD_DATA_COUNT
	num_write_words_sized_i = 
          num_write_words_dc[C_WR_PNTR_WIDTH-1 : C_WR_PNTR_WIDTH-C_WR_DATA_COUNT_WIDTH];
	
     end //if (C_USE_FWFT_DATA_COUNT)
   end //always

    
    
   /***************************************************************************
    * Internal registers and wires
    **************************************************************************/

   //Temporary signals used for calculating the model's outputs. These
   //are only used in the assign statements immediately following wire,
   //parameter, and function declarations.
   wire [C_DOUT_WIDTH-1:0] ideal_dout_out;      
   wire valid_i;
   wire valid_out;  
   wire underflow_i;

   //Ideal FIFO signals. These are the raw output of the behavioral model,
   //which behaves like an ideal FIFO.
   reg [C_DOUT_WIDTH-1:0] ideal_dout;
   reg [C_DOUT_WIDTH-1:0]  ideal_dout_d1;
   reg 			   ideal_wr_ack;
   reg 			   ideal_valid;
   reg 			   ideal_overflow;
   reg 			   ideal_underflow;
   reg 			   ideal_full;
   reg 			   ideal_empty;
   reg 			   ideal_almost_full;
   reg 			   ideal_almost_empty;
   reg 			   ideal_prog_full;
   reg 			   ideal_prog_empty;
   reg [C_WR_DATA_COUNT_WIDTH-1 : 0] ideal_wr_count;
   reg [C_RD_DATA_COUNT_WIDTH-1 : 0] ideal_rd_count;

   //Assorted reg values for delayed versions of signals   
   reg 	       valid_d1;
   reg         prog_full_d;
   reg         prog_empty_d;

   //Internal reset signals
   reg 	       rd_rst_asreg    =0;
   reg 	       rd_rst_asreg_d1 =0;
   reg 	       rd_rst_asreg_d2 =0;
   reg 	       rd_rst_reg      =0;
   reg 	       rd_rst_d1       =0;
   reg 	       wr_rst_asreg    =0;
   reg 	       wr_rst_asreg_d1 =0;
   reg 	       wr_rst_asreg_d2 =0;
   reg 	       wr_rst_reg      =0;
   reg 	       wr_rst_d1       =0;

   wire        rd_rst_comb;
   wire        rd_rst_i;
   wire        wr_rst_comb;
   wire        wr_rst_i;   
   
   
   //user specified value for reseting the size of the fifo
   reg [C_DOUT_WIDTH-1:0] 	     dout_reset_val;
   
   //temporary registers for WR_RESPONSE_LATENCY feature
   
   integer                           tmp_wr_listsize;
   integer                           tmp_rd_listsize;
   
   //Signal for registered version of prog full and empty
   
   //Threshold values for Programmable Flags
   integer                           prog_empty_actual_thresh_assert;
   integer                           prog_empty_actual_thresh_negate;
   integer                           prog_full_actual_thresh_assert;
   integer                           prog_full_actual_thresh_negate;
   

  /****************************************************************************
   * Function Declarations
   ***************************************************************************/

  /**************************************************************************
   * write_fifo
   *   This task writes a word to the FIFO memory and updates the 
   * write pointer.
   *   FIFO size is relative to write domain.
  ***************************************************************************/
  task write_fifo;
    begin
      memory[wr_ptr]     <= DIN;
      // (Works opposite to core: wr_ptr is a DOWN counter)
      if (wr_ptr == 0) begin
        wr_ptr          <= C_WR_DEPTH - 1;
      end else begin
        wr_ptr          <= wr_ptr - 1;
      end
    end
  endtask // write_fifo

  /**************************************************************************
   * read_fifo
   *   This task reads a word from the FIFO memory and updates the read 
   * pointer. It's output is the ideal_dout bus.
   *   FIFO size is relative to write domain.
   ***************************************************************************/
  task read_fifo;
    integer i;
    reg [C_DOUT_WIDTH-1:0] tmp_dout;
    reg [C_DIN_WIDTH-1:0]  memory_read;
    reg [31:0]             tmp_rd_ptr;
    reg [31:0]             rd_ptr_high;
    reg [31:0]             rd_ptr_low;
    begin
      // output is wider than input
      if (reads_per_write == 0) begin
        tmp_dout = 0;
        tmp_rd_ptr = (rd_ptr << log2_writes_per_read)+(writes_per_read-1);
        for (i = writes_per_read - 1; i >= 0; i = i - 1) begin
          tmp_dout = tmp_dout << C_DIN_WIDTH;
          tmp_dout = tmp_dout | memory[tmp_rd_ptr];
	   
          // (Works opposite to core: rd_ptr is a DOWN counter)
          if (tmp_rd_ptr == 0) begin
            tmp_rd_ptr = C_WR_DEPTH - 1;
          end else begin
            tmp_rd_ptr = tmp_rd_ptr - 1;
          end
        end

      // output is symmetric
      end else if (reads_per_write == 1) begin
        tmp_dout = memory[rd_ptr];

      // input is wider than output
      end else begin
        rd_ptr_high = rd_ptr >> log2_reads_per_write;
        rd_ptr_low  = rd_ptr & (reads_per_write - 1);
        memory_read = memory[rd_ptr_high];
        tmp_dout    = memory_read >> (rd_ptr_low*C_DOUT_WIDTH);
      end
      ideal_dout <= tmp_dout;
       
      // (Works opposite to core: rd_ptr is a DOWN counter)
      if (rd_ptr == 0) begin
        rd_ptr <= C_RD_DEPTH - 1;
      end else begin
        rd_ptr <= rd_ptr - 1;
      end
    end
  endtask

  /**************************************************************************
  * log2_val
  *   Returns the 'log2' value for the input value for the supported ratios
  ***************************************************************************/
  function [31:0] log2_val;
    input [31:0] binary_val;

    begin
      if (binary_val == 8) begin
        log2_val = 3;
      end else if (binary_val == 4) begin
        log2_val = 2;
      end else begin
        log2_val = 1;
      end
    end
  endfunction

  /***********************************************************************
  * hexstr_conv
  *   Converts a string of type hex to a binary value (for C_DOUT_RST_VAL)
  ***********************************************************************/
  function [C_DOUT_WIDTH-1:0] hexstr_conv;
    input [(C_DOUT_WIDTH*8)-1:0] def_data;

    integer index,i,j;
    reg [3:0] bin;

    begin
      index = 0;
      hexstr_conv = 'b0;
      for( i=C_DOUT_WIDTH-1; i>=0; i=i-1 )
      begin
        case (def_data[7:0])
          8'b00000000 :
          begin
            bin = 4'b0000;
            i = -1;
          end
          8'b00110000 : bin = 4'b0000;
          8'b00110001 : bin = 4'b0001;
          8'b00110010 : bin = 4'b0010;
          8'b00110011 : bin = 4'b0011;
          8'b00110100 : bin = 4'b0100;
          8'b00110101 : bin = 4'b0101;
          8'b00110110 : bin = 4'b0110;
          8'b00110111 : bin = 4'b0111;
          8'b00111000 : bin = 4'b1000;
          8'b00111001 : bin = 4'b1001;
          8'b01000001 : bin = 4'b1010;
          8'b01000010 : bin = 4'b1011;
          8'b01000011 : bin = 4'b1100;
          8'b01000100 : bin = 4'b1101;
          8'b01000101 : bin = 4'b1110;
          8'b01000110 : bin = 4'b1111;
          8'b01100001 : bin = 4'b1010;
          8'b01100010 : bin = 4'b1011;
          8'b01100011 : bin = 4'b1100;
          8'b01100100 : bin = 4'b1101;
          8'b01100101 : bin = 4'b1110;
          8'b01100110 : bin = 4'b1111;
          default :
          begin
            bin = 4'bx;
          end
        endcase
        for( j=0; j<4; j=j+1)
        begin
          if ((index*4)+j < C_DOUT_WIDTH)
          begin
            hexstr_conv[(index*4)+j] = bin[j];
          end
        end
        index = index + 1;
        def_data = def_data >> 8;
      end
    end
  endfunction

  /*************************************************************************
  * Initialize Signals for clean power-on simulation
  *************************************************************************/
   initial begin
      num_wr_bits        = 0;
      num_rd_bits        = 0;
      next_num_wr_bits   = 0;
      next_num_rd_bits   = 0;
      rd_ptr             = C_RD_DEPTH - 1;
      wr_ptr             = C_WR_DEPTH - 1;
      rd_ptr_wrclk       = rd_ptr;
      wr_ptr_rdclk       = wr_ptr;
      dout_reset_val     = hexstr_conv(C_DOUT_RST_VAL);
      ideal_dout         = dout_reset_val;
      ideal_dout_d1      = 0 ;
      ideal_wr_ack       = 1'b0;
      ideal_valid        = 1'b0;
      valid_d1           = 1'b0;
      ideal_overflow     = 1'b0;
      ideal_underflow    = 1'b0;
      ideal_full         = 1'b0;
      ideal_empty        = 1'b1;
      ideal_almost_full  = 1'b0;
      ideal_almost_empty = 1'b1;
      ideal_wr_count     = 0;
      ideal_rd_count     = 0;
      ideal_prog_full    = 1'b0;
      ideal_prog_empty   = 1'b1;
      prog_full_d        = 1'b0;
      prog_empty_d       = 1'b1;
    end


  /*************************************************************************
   * Connect the module inputs and outputs to the internal signals of the 
   * behavioral model.
   *************************************************************************/
   //Inputs
   /*
    wire [C_DIN_WIDTH-1:0] DIN;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_ASSERT;
   wire [C_RD_PNTR_WIDTH-1:0] PROG_EMPTY_THRESH_NEGATE;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_ASSERT;
   wire [C_WR_PNTR_WIDTH-1:0] PROG_FULL_THRESH_NEGATE;   
   wire RD_CLK;
   wire RD_EN;
   wire RST;
   wire WR_CLK;
   wire WR_EN;
    */

   //Outputs
   generate
      if (C_HAS_ALMOST_EMPTY==1) begin : blockAE1
   assign ALMOST_EMPTY = ideal_almost_empty;
      end
   endgenerate
   
   generate
      if (C_HAS_ALMOST_FULL==1) begin : blockAF1
   assign ALMOST_FULL  = ideal_almost_full;
      end
   endgenerate

   //Dout may change behavior based on latency
   assign ideal_dout_out[C_DOUT_WIDTH-1:0] = (C_PRELOAD_LATENCY==2 &&
                          (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1))?
                         ideal_dout_d1: ideal_dout;   
   assign DOUT[C_DOUT_WIDTH-1:0] = ideal_dout_out; 
  
   assign EMPTY = ideal_empty;
   assign FULL  = ideal_full;

   //Overflow may be active-low
   generate
      if (C_HAS_OVERFLOW==1) begin : blockOF1
   assign OVERFLOW = ideal_overflow ? !C_OVERFLOW_LOW : C_OVERFLOW_LOW;
      end
   endgenerate

   assign PROG_EMPTY = ideal_prog_empty;
   assign PROG_FULL  = ideal_prog_full;

   //Valid may change behavior based on latency or active-low
   generate
      if (C_HAS_VALID==1) begin : blockVL1
   assign valid_i   = (C_PRELOAD_LATENCY==0) ? (RD_EN & ~EMPTY) : ideal_valid;
   assign valid_out = (C_PRELOAD_LATENCY==2 &&
                       (C_MEMORY_TYPE==0 || C_MEMORY_TYPE==1))?
                       valid_d1: valid_i;  
   assign VALID     = valid_out ? !C_VALID_LOW : C_VALID_LOW;
     end
   endgenerate

   generate
      if (C_HAS_RD_DATA_COUNT==1) begin : blockRC1
   assign RD_DATA_COUNT[C_RD_DATA_COUNT_WIDTH-1:0] = ideal_rd_count;
      end
   endgenerate

   //Underflow may change behavior based on latency or active-low   
   generate
      if (C_HAS_UNDERFLOW==1) begin : blockUF1
   assign underflow_i = (C_PRELOAD_LATENCY==0) ? (RD_EN & EMPTY) : ideal_underflow;
   assign UNDERFLOW   = underflow_i ? !C_UNDERFLOW_LOW : C_UNDERFLOW_LOW;
    end
   endgenerate

   //Write acknowledge may be active low
   generate
      if (C_HAS_WR_ACK==1) begin : blockWK1
   assign WR_ACK = ideal_wr_ack ? !C_WR_ACK_LOW : C_WR_ACK_LOW;
     end
   endgenerate
   
   generate
      if (C_HAS_WR_DATA_COUNT==1) begin : blockWC1
   assign WR_DATA_COUNT[C_WR_DATA_COUNT_WIDTH-1:0] = ideal_wr_count;
      end
   endgenerate

  /**************************************************************************
  * Internal reset logic
  **************************************************************************/
  assign wr_rst_i         = C_HAS_RST ? wr_rst_reg : 0;
  assign rd_rst_i         = C_HAS_RST ? rd_rst_reg : 0;
  
  generate
      if (C_HAS_RST==1) begin : blockRST2
  assign wr_rst_comb      = !wr_rst_asreg_d2 && wr_rst_asreg;
  assign rd_rst_comb      = !rd_rst_asreg_d2 && rd_rst_asreg;

  always @(posedge WR_CLK or posedge RST) begin
    if (RST == 1'b1) begin
      wr_rst_asreg <= 1'b1;
    end else begin
      if (wr_rst_asreg_d1 == 1'b1) begin
        wr_rst_asreg <= 1'b0;
      end else begin
        wr_rst_asreg <= wr_rst_asreg;
      end
    end    
  end   

  always @(posedge WR_CLK) begin
    wr_rst_asreg_d1 <= wr_rst_asreg;
    wr_rst_asreg_d2 <= wr_rst_asreg_d1;
  end
  
  always @(posedge WR_CLK or posedge wr_rst_comb) begin
    if (wr_rst_comb == 1'b1) begin
      wr_rst_reg <= 1'b1;
    end else begin
      wr_rst_reg <= 1'b0;
    end    
  end   

  always @(posedge WR_CLK or posedge wr_rst_i) begin
    if (wr_rst_i == 1'b1) begin
      wr_rst_d1 <= 1'b1;
    end else begin
      wr_rst_d1 <= wr_rst_i;
    end    
  end 
  
  always @(posedge RD_CLK or posedge RST) begin
    if (RST == 1'b1) begin
      rd_rst_asreg <= 1'b1;
    end else begin
      if (rd_rst_asreg_d1 == 1'b1) begin
        rd_rst_asreg <= 1'b0;
      end else begin
        rd_rst_asreg <= rd_rst_asreg;
      end
    end    
  end   

  always @(posedge RD_CLK) begin
    rd_rst_asreg_d1 <= rd_rst_asreg;
    rd_rst_asreg_d2 <= rd_rst_asreg_d1;
  end
  
   always @(posedge RD_CLK or posedge rd_rst_comb) begin
    if (rd_rst_comb == 1'b1) begin
      rd_rst_reg <= 1'b1;
    end else begin
      rd_rst_reg <= 1'b0;
    end    
  end   
      end
  endgenerate 

  /**************************************************************************
  * Assorted registers for delayed versions of signals
  **************************************************************************/
  //Capture delayed version of valid
  generate
      if (C_HAS_VALID==1) begin : blockVL2
  always @(posedge RD_CLK or posedge rd_rst_i) begin
    if (rd_rst_i == 1'b1) begin
      valid_d1 <= 1'b0;
    end else begin
      valid_d1 <= valid_i;
    end    
  end 
      end
 endgenerate  
   
  //Capture delayed version of dout
  always @(posedge RD_CLK or posedge rd_rst_i) begin
    if (rd_rst_i == 1'b1 && C_USE_DOUT_RST == 1) begin
      ideal_dout_d1 <= dout_reset_val;
    end else begin
      ideal_dout_d1 <= ideal_dout;
    end    
  end   
  
   /**************************************************************************
    * Overflow and Underflow Flag calculation
    *  (handled separately because they don't support rst)
    **************************************************************************/
   generate
      if (C_HAS_OVERFLOW==1) begin : blockOF2
   always @(posedge WR_CLK) begin
     ideal_overflow    <= WR_EN & ideal_full;
   end
      end
   endgenerate

   generate
      if (C_HAS_UNDERFLOW==1) begin : blockUF2
   always @(posedge RD_CLK) begin
     ideal_underflow    <= ideal_empty & RD_EN;
   end
      end
   endgenerate

   /**************************************************************************
   * Write Domain Logic
   **************************************************************************/
   always @(posedge WR_CLK or posedge wr_rst_i) begin : gen_fifo_w

     /****** Reset fifo (case 1)***************************************/
     if (wr_rst_i == 1'b1) begin
       num_wr_bits       <= 0;
       next_num_wr_bits  <= 0;
       wr_ptr            <= C_WR_DEPTH - 1;
       rd_ptr_wrclk      <= C_RD_DEPTH - 1;
       ideal_wr_ack      <= 0;
       ideal_full        <= C_FULL_FLAGS_RST_VAL;
       ideal_almost_full <= C_FULL_FLAGS_RST_VAL;
       ideal_wr_count    <= 0;

       ideal_prog_full   <= C_FULL_FLAGS_RST_VAL;
       prog_full_d       <= C_FULL_FLAGS_RST_VAL;

     end else begin //wr_rst_i==0

       //Determine the current number of words in the FIFO
       tmp_wr_listsize = (C_DEPTH_RATIO_RD > 1) ? num_wr_bits/C_DOUT_WIDTH :
                         num_wr_bits/C_DIN_WIDTH;
       rd_ptr_wrclk_next = rd_ptr;
       if (rd_ptr_wrclk < rd_ptr_wrclk_next) begin
         next_num_wr_bits = num_wr_bits -
                            C_DOUT_WIDTH*(rd_ptr_wrclk + C_RD_DEPTH
                                          - rd_ptr_wrclk_next);
       end else begin
         next_num_wr_bits = num_wr_bits -
                            C_DOUT_WIDTH*(rd_ptr_wrclk - rd_ptr_wrclk_next);
       end

       //If this is a write, handle the write by adding the value
       // to the linked list, and updating all outputs appropriately
       if (WR_EN == 1'b1) begin
         if (ideal_full == 1'b1) begin

           //If the FIFO is full, do NOT perform the write,
           // update flags accordingly
           if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD 
             >= C_FIFO_WR_DEPTH) begin
             //write unsuccessful - do not change contents

             //Do not acknowledge the write
             ideal_wr_ack      <= 0;
             //Reminder that FIFO is still full
             ideal_full        <= 1'b1;
             ideal_almost_full <= 1'b1;

             ideal_wr_count    <= num_write_words_sized_i;

           //If the FIFO is one from full, but reporting full
           end else 
	     if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD ==
                C_FIFO_WR_DEPTH-1) begin
             //No change to FIFO

             //Write not successful
             ideal_wr_ack      <= 0;
             //With DEPTH-1 words in the FIFO, it is almost_full
             ideal_full        <= 1'b0;
             ideal_almost_full <= 1'b1;

             ideal_wr_count    <= num_write_words_sized_i;


           //If the FIFO is completely empty, but it is
           // reporting FULL for some reason (like reset)
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD <=
                C_FIFO_WR_DEPTH-2) begin
             //No change to FIFO

             //Write not successful
             ideal_wr_ack      <= 0;
             //FIFO is really not close to full, so change flag status.
             ideal_full        <= 1'b0;
             ideal_almost_full <= 1'b0;

             ideal_wr_count    <= num_write_words_sized_i;
           end //(tmp_wr_listsize == 0)

         end else begin

           //If the FIFO is full, do NOT perform the write,
           // update flags accordingly
           if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD >=
              C_FIFO_WR_DEPTH) begin
             //write unsuccessful - do not change contents

             //Do not acknowledge the write
             ideal_wr_ack       <= 0;
             //Reminder that FIFO is still full
             ideal_full         <= 1'b1;
             ideal_almost_full  <= 1'b1;

             ideal_wr_count     <= num_write_words_sized_i;

           //If the FIFO is one from full
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD ==
                C_FIFO_WR_DEPTH-1) begin
             //Add value on DIN port to FIFO
             write_fifo;
             next_num_wr_bits = next_num_wr_bits + C_DIN_WIDTH;

             //Write successful, so issue acknowledge
             // and no error
             ideal_wr_ack      <= 1;
             //This write is CAUSING the FIFO to go full
             ideal_full        <= 1'b1;
             ideal_almost_full <= 1'b1;

             ideal_wr_count    <= num_write_words_sized_i;

           //If the FIFO is 2 from full
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD == 
                C_FIFO_WR_DEPTH-2) begin
             //Add value on DIN port to FIFO
             write_fifo;
             next_num_wr_bits =  next_num_wr_bits + C_DIN_WIDTH;
             //Write successful, so issue acknowledge
             // and no error
             ideal_wr_ack      <= 1;
             //Still 2 from full
             ideal_full        <= 1'b0;
             //2 from full, and writing, so set almost_full
             ideal_almost_full <= 1'b1;

             ideal_wr_count    <= num_write_words_sized_i;

           //If the FIFO is not close to being full
           end else 
             if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD <
                C_FIFO_WR_DEPTH-2) begin
             //Add value on DIN port to FIFO
             write_fifo;
             next_num_wr_bits  = next_num_wr_bits + C_DIN_WIDTH;
             //Write successful, so issue acknowledge
             // and no error
             ideal_wr_ack      <= 1;
             //Not even close to full.
             ideal_full        <= 1'b0;
             ideal_almost_full <= 1'b0;

             ideal_wr_count    <= num_write_words_sized_i;

           end

         end

       end else begin //(WR_EN == 1'b1)

         //If user did not attempt a write, then do not
         // give ack or err
         ideal_wr_ack   <= 0;

         //Implied statements:
         //ideal_empty <= ideal_empty;
         //ideal_almost_empty <= ideal_almost_empty;

         //Check for full
         if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD >= C_FIFO_WR_DEPTH)
           ideal_full <= 1'b1;
         else
           ideal_full <= 1'b0;

         //Check for almost_full
         if ((tmp_wr_listsize + C_DEPTH_RATIO_RD - 1)/C_DEPTH_RATIO_RD >= C_FIFO_WR_DEPTH-1)
           ideal_almost_full  <= 1'b1;
         else
           ideal_almost_full  <= 1'b0;

         ideal_wr_count <= num_write_words_sized_i;
       end

       /*********************************************************
        * Programmable FULL flags
        *********************************************************/
       //Single Programmable Full Constant Threshold
       if (C_PROG_FULL_TYPE==1) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_full_actual_thresh_assert = C_PROG_FULL_THRESH_ASSERT_VAL-EXTRA_WORDS;
           prog_full_actual_thresh_negate = C_PROG_FULL_THRESH_ASSERT_VAL-EXTRA_WORDS;
         end else begin
           prog_full_actual_thresh_assert = C_PROG_FULL_THRESH_ASSERT_VAL;
           prog_full_actual_thresh_negate = C_PROG_FULL_THRESH_ASSERT_VAL;
         end

       //Two Programmable Full Constant Thresholds
       end else if (C_PROG_FULL_TYPE==2) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_full_actual_thresh_assert = C_PROG_FULL_THRESH_ASSERT_VAL-EXTRA_WORDS;
           prog_full_actual_thresh_negate = C_PROG_FULL_THRESH_NEGATE_VAL-EXTRA_WORDS;
         end else begin
           prog_full_actual_thresh_assert = C_PROG_FULL_THRESH_ASSERT_VAL;
           prog_full_actual_thresh_negate = C_PROG_FULL_THRESH_NEGATE_VAL;
         end

       //Single Programmable Full Threshold Input
       end else if (C_PROG_FULL_TYPE==3) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_full_actual_thresh_assert = PROG_FULL_THRESH-EXTRA_WORDS;
           prog_full_actual_thresh_negate = PROG_FULL_THRESH-EXTRA_WORDS;
         end else begin
           prog_full_actual_thresh_assert = PROG_FULL_THRESH;
           prog_full_actual_thresh_negate = PROG_FULL_THRESH;
         end

       //Two Programmable Full Threshold Inputs
       end else if (C_PROG_FULL_TYPE==4) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_full_actual_thresh_assert = PROG_FULL_THRESH_ASSERT-EXTRA_WORDS;
           prog_full_actual_thresh_negate = PROG_FULL_THRESH_NEGATE-EXTRA_WORDS;
         end else begin
           prog_full_actual_thresh_assert = PROG_FULL_THRESH_ASSERT;
           prog_full_actual_thresh_negate = PROG_FULL_THRESH_NEGATE;
         end
       end //C_PROG_FULL_TYPE
       
       if (num_write_words_pf==0) begin
          prog_full_d <= 1'b0;
       end else begin
         if (((1+(num_write_words_pf-1)/C_DEPTH_RATIO_RD) 
              == prog_full_actual_thresh_assert-1) && WR_EN) begin
            prog_full_d <= 1'b1;
         end else if ((1+(num_write_words_pf-1)/C_DEPTH_RATIO_RD) 
                      >= prog_full_actual_thresh_assert) begin
            prog_full_d <= 1'b1;
         end else if ((1+(num_write_words_pf-1)/C_DEPTH_RATIO_RD) 
                      < prog_full_actual_thresh_negate) begin
            prog_full_d <= 1'b0;
         end
       end  

       if (wr_rst_d1==1 && wr_rst_i==0) begin
         ideal_prog_full   <= 0;
       end else begin
         ideal_prog_full   <= prog_full_d;
       end
       num_wr_bits       <= next_num_wr_bits;
       rd_ptr_wrclk      <= rd_ptr;

     end //wr_rst_i==0
   end // write always

   
   /**************************************************************************
   * Read Domain Logic
   **************************************************************************/
   always @(posedge RD_CLK or posedge rd_rst_i) begin : gen_fifo_r

     /****** Reset fifo (case 1)***************************************/
     if (rd_rst_i) begin
       num_rd_bits        <= 0;
       next_num_rd_bits   <= 0;
       rd_ptr             <= C_RD_DEPTH -1;
       wr_ptr_rdclk       <= C_WR_DEPTH -1;
       if (C_USE_DOUT_RST == 1) begin
       ideal_dout         <= dout_reset_val;
       end else begin
       ideal_dout         <= ideal_dout;
       end
       ideal_valid        <= 1'b0;
       ideal_empty        <= 1'b1;
       ideal_almost_empty <= 1'b1;
       ideal_rd_count     <= 0;

       ideal_prog_empty   <= 1'b1;
       prog_empty_d       <= 1;


     end else begin //rd_rst_i==0

       //Determine the current number of words in the FIFO
       tmp_rd_listsize = (C_DEPTH_RATIO_WR > 1) ? num_rd_bits/C_DIN_WIDTH :
                         num_rd_bits/C_DOUT_WIDTH;
       wr_ptr_rdclk_next = wr_ptr;

       if (wr_ptr_rdclk < wr_ptr_rdclk_next) begin
         next_num_rd_bits = num_rd_bits +
                            C_DIN_WIDTH*(wr_ptr_rdclk +C_WR_DEPTH
                                         - wr_ptr_rdclk_next);
       end else begin
         next_num_rd_bits = num_rd_bits +
                             C_DIN_WIDTH*(wr_ptr_rdclk - wr_ptr_rdclk_next);
       end

       /*****************************************************************/
       // Read Operation - Read Latency 1
       /*****************************************************************/
       if (C_PRELOAD_LATENCY==1 || C_PRELOAD_LATENCY==2) begin

         if (RD_EN == 1'b1) begin

           if (ideal_empty == 1'b1) begin

             //If the FIFO is completely empty, and is reporting empty
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0)
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid        <= 1'b0;
                 //Reminder that FIFO is still empty
                 ideal_empty        <= 1'b1;
                 ideal_almost_empty <= 1'b1;

                 ideal_rd_count     <= num_read_words_sized_i;
               end // if (tmp_rd_listsize <= 0)

             //If the FIFO is one from empty, but it is reporting empty
             else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 1)
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid        <= 1'b0;
                 //Note that FIFO is no longer empty, but is almost empty (has one word left)
                 ideal_empty        <= 1'b0;
                 ideal_almost_empty <= 1'b1;

                 ideal_rd_count     <= num_read_words_sized_i;

               end // if (tmp_rd_listsize == 1)

             //If the FIFO is two from empty, and is reporting empty
             else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2)
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid        <= 1'b0;
                 //Fifo has two words, so is neither empty or almost empty
                 ideal_empty        <= 1'b0;
                 ideal_almost_empty <= 1'b0;

                 ideal_rd_count     <= num_read_words_sized_i;

               end // if (tmp_rd_listsize == 2)

             //If the FIFO is not close to empty, but is reporting that it is
             // Treat the FIFO as empty this time, but unset EMPTY flags.
             if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) && (tmp_rd_listsize/C_DEPTH_RATIO_WR<C_FIFO_RD_DEPTH))
               begin
                 //Do not change the contents of the FIFO

                 //Do not acknowledge the read from empty FIFO
                 ideal_valid <= 1'b0;
                 //Note that the FIFO is No Longer Empty or Almost Empty
                 ideal_empty  <= 1'b0;
                 ideal_almost_empty <= 1'b0;

                 ideal_rd_count <= num_read_words_sized_i;

               end // if ((tmp_rd_listsize > 2) && (tmp_rd_listsize<=C_FIFO_RD_DEPTH-1))
             end // else: if(ideal_empty == 1'b1)

           else //if (ideal_empty == 1'b0)
             begin

               //If the FIFO is completely full, and we are successfully reading from it
               if (tmp_rd_listsize/C_DEPTH_RATIO_WR >= C_FIFO_RD_DEPTH)
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= 1'b1;
                   //Not close to empty
                   ideal_empty        <= 1'b0;
                   ideal_almost_empty <= 1'b0;

                   ideal_rd_count     <= num_read_words_sized_i;

                 end // if (tmp_rd_listsize == C_FIFO_RD_DEPTH)

               //If the FIFO is not close to being empty
               else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) && (tmp_rd_listsize/C_DEPTH_RATIO_WR<=C_FIFO_RD_DEPTH))
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= 1'b1;
                   //Not close to empty
                   ideal_empty        <= 1'b0;
                   ideal_almost_empty <= 1'b0;

                   ideal_rd_count     <= num_read_words_sized_i;

                 end // if ((tmp_rd_listsize > 2) && (tmp_rd_listsize<=C_FIFO_RD_DEPTH-1))

               //If the FIFO is two from empty
               else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2)
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= 1'b1;
                   //Fifo is not yet empty. It is going almost_empty
                   ideal_empty        <= 1'b0;
                   ideal_almost_empty <= 1'b1;

                   ideal_rd_count     <= num_read_words_sized_i;

                 end // if (tmp_rd_listsize == 2)

               //If the FIFO is one from empty
               else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR == 1))
                 begin
                   //Read the value from the FIFO
                   read_fifo;
                   next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

                   //Acknowledge the read from the FIFO, no error
                   ideal_valid        <= 1'b1;
                   //Note that FIFO is GOING empty
                   ideal_empty        <= 1'b1;
                   ideal_almost_empty <= 1'b1;

                   ideal_rd_count     <= num_read_words_sized_i;

                 end // if (tmp_rd_listsize == 1)


               //If the FIFO is completely empty
               else if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0)
                 begin
                   //Do not change the contents of the FIFO

                   //Do not acknowledge the read from empty FIFO
                   ideal_valid        <= 1'b0;
                   //Reminder that FIFO is still empty
                   ideal_empty        <= 1'b1;
                   ideal_almost_empty <= 1'b1;

                   ideal_rd_count     <= num_read_words_sized_i;

                 end // if (tmp_rd_listsize <= 0)

             end // if (ideal_empty == 1'b0)

           end //(RD_EN == 1'b1)

         else //if (RD_EN == 1'b0)
           begin
             //If user did not attempt a read, do not give an ack or err
             ideal_valid          <= 1'b0;

             //Check for empty
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0)
               ideal_empty        <= 1'b1;
             else
               ideal_empty        <= 1'b0;

             //Check for almost_empty
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 1)
               ideal_almost_empty <= 1'b1;
             else
               ideal_almost_empty <= 1'b0;

             ideal_rd_count       <= num_read_words_sized_i;

           end // else: !if(RD_EN == 1'b1)

       /*****************************************************************/
       // Read Operation - Read Latency 0
       /*****************************************************************/
       end else if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
         if (RD_EN == 1'b1) begin

           if (ideal_empty == 1'b1) begin

             //If the FIFO is completely empty, and is reporting empty
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= 1'b0;
               //Reminder that FIFO is still empty
               ideal_empty        <= 1'b1;
               ideal_almost_empty <= 1'b1;

               ideal_rd_count     <= num_read_words_sized_i;

             //If the FIFO is one from empty, but it is reporting empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 1) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= 1'b0;
               //Note that FIFO is no longer empty, but is almost empty (has one word left)
               ideal_empty        <= 1'b0;
               ideal_almost_empty <= 1'b1;

               ideal_rd_count     <= num_read_words_sized_i;

             //If the FIFO is two from empty, and is reporting empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= 1'b0;
               //Fifo has two words, so is neither empty or almost empty
               ideal_empty        <= 1'b0;
               ideal_almost_empty <= 1'b0;

               ideal_rd_count     <= num_read_words_sized_i;

               //If the FIFO is not close to empty, but is reporting that it is
             // Treat the FIFO as empty this time, but unset EMPTY flags.
             end else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) &&
                         (tmp_rd_listsize/C_DEPTH_RATIO_WR<C_FIFO_RD_DEPTH)) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= 1'b0;
               //Note that the FIFO is No Longer Empty or Almost Empty
               ideal_empty        <= 1'b0;
               ideal_almost_empty <= 1'b0;

               ideal_rd_count     <= num_read_words_sized_i;

             end // if ((tmp_rd_listsize > 2) && (tmp_rd_listsize<=C_FIFO_RD_DEPTH-1))

           end else begin

             //If the FIFO is completely full, and we are successfully reading from it
             if (tmp_rd_listsize/C_DEPTH_RATIO_WR >= C_FIFO_RD_DEPTH) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= 1'b1;
               //Not close to empty
               ideal_empty        <= 1'b0;
               ideal_almost_empty <= 1'b0;

               ideal_rd_count     <= num_read_words_sized_i;

             //If the FIFO is not close to being empty
             end else if ((tmp_rd_listsize/C_DEPTH_RATIO_WR > 2) &&
                          (tmp_rd_listsize/C_DEPTH_RATIO_WR<=C_FIFO_RD_DEPTH)) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= 1'b1;
               //Not close to empty
               ideal_empty        <= 1'b0;
               ideal_almost_empty <= 1'b0;

               ideal_rd_count     <= num_read_words_sized_i;

             //If the FIFO is two from empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 2) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= 1'b1;
               //Fifo is not yet empty. It is going almost_empty
               ideal_empty        <= 1'b0;
               ideal_almost_empty <= 1'b1;

               ideal_rd_count     <= num_read_words_sized_i;

             //If the FIFO is one from empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR == 1) begin
               //Read the value from the FIFO
               read_fifo;
               next_num_rd_bits = next_num_rd_bits - C_DOUT_WIDTH;

               //Acknowledge the read from the FIFO, no error
               ideal_valid        <= 1'b1;
               //Note that FIFO is GOING empty
               ideal_empty        <= 1'b1;
               ideal_almost_empty <= 1'b1;

               ideal_rd_count     <= num_read_words_sized_i;

             //If the FIFO is completely empty
             end else if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0) begin
               //Do not change the contents of the FIFO

               //Do not acknowledge the read from empty FIFO
               ideal_valid        <= 1'b0;
               //Reminder that FIFO is still empty
               ideal_empty        <= 1'b1;
               ideal_almost_empty <= 1'b1;

               ideal_rd_count     <= num_read_words_sized_i;

             end // if (tmp_rd_listsize <= 0)

           end // if (ideal_empty == 1'b0)

         end else begin//(RD_EN == 1'b0)

         
           //If user did not attempt a read, do not give an ack or err
           ideal_valid           <= 1'b0;

           //Check for empty
           if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 0)
             ideal_empty         <= 1'b1;
           else
             ideal_empty         <= 1'b0;

           //Check for almost_empty
           if (tmp_rd_listsize/C_DEPTH_RATIO_WR <= 1)
             ideal_almost_empty  <= 1'b1;
           else
             ideal_almost_empty  <= 1'b0;

           ideal_rd_count        <= num_read_words_sized_i;

         end // else: !if(RD_EN == 1'b1)
       end //if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0)


       /*********************************************************
        * Programmable EMPTY flags
        *********************************************************/
       //Determine the Assert and Negate thresholds for Programmable Empty
       //  (Subtract 2 read-sized words when using Preload 0)

       //Single Programmable Empty Constant Threshold
       if (C_PROG_EMPTY_TYPE==1) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_empty_actual_thresh_assert = C_PROG_EMPTY_THRESH_ASSERT_VAL-2;
           prog_empty_actual_thresh_negate = C_PROG_EMPTY_THRESH_ASSERT_VAL-2;
         end
         else begin
           prog_empty_actual_thresh_assert = C_PROG_EMPTY_THRESH_ASSERT_VAL;
           prog_empty_actual_thresh_negate = C_PROG_EMPTY_THRESH_ASSERT_VAL;
         end

       //Two Programmable Empty Constant Thresholds
       end else if (C_PROG_EMPTY_TYPE==2) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_empty_actual_thresh_assert = C_PROG_EMPTY_THRESH_ASSERT_VAL-2;
           prog_empty_actual_thresh_negate = C_PROG_EMPTY_THRESH_NEGATE_VAL-2;
         end
         else begin
           prog_empty_actual_thresh_assert = C_PROG_EMPTY_THRESH_ASSERT_VAL;
           prog_empty_actual_thresh_negate = C_PROG_EMPTY_THRESH_NEGATE_VAL;
         end

       //Single Programmable Empty Constant Threshold
       end else if (C_PROG_EMPTY_TYPE==3) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_empty_actual_thresh_assert = PROG_EMPTY_THRESH-2;
           prog_empty_actual_thresh_negate = PROG_EMPTY_THRESH-2;
         end
         else begin
           prog_empty_actual_thresh_assert = PROG_EMPTY_THRESH;
           prog_empty_actual_thresh_negate = PROG_EMPTY_THRESH;

         end
       //Two Programmable Empty Constant Thresholds
       end else if (C_PROG_EMPTY_TYPE==4) begin
         if (C_PRELOAD_REGS==1 && C_PRELOAD_LATENCY==0) begin
           prog_empty_actual_thresh_assert = PROG_EMPTY_THRESH_ASSERT-2;
           prog_empty_actual_thresh_negate = PROG_EMPTY_THRESH_NEGATE-2;
         end
         else begin
           prog_empty_actual_thresh_assert = PROG_EMPTY_THRESH_ASSERT;
           prog_empty_actual_thresh_negate = PROG_EMPTY_THRESH_NEGATE;
         end
       end

       if ((num_read_words_pe/C_DEPTH_RATIO_WR == prog_empty_actual_thresh_assert+1) 
           && RD_EN) begin
         prog_empty_d <= 1'b1;
       end else if (num_read_words_pe/C_DEPTH_RATIO_WR 
                    <= prog_empty_actual_thresh_assert) begin
         prog_empty_d <= 1'b1;
       end else if (num_read_words_pe/C_DEPTH_RATIO_WR 
                    > prog_empty_actual_thresh_negate) begin
         prog_empty_d <= 1'b0;
       end


       ideal_prog_empty <= prog_empty_d;
       num_rd_bits      <= next_num_rd_bits;
       wr_ptr_rdclk     <= wr_ptr;
     end //rd_rst_i==0
   end //always

endmodule // fifo_generator_v4_4_bhv_ver_as
