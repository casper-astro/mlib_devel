`timescale 1ns/1ps
/*
 * $RDCfile: $ $Revision: 1.1.2.6 $ $Date: 2008/07/22 06:40:34 $
 *******************************************************************************
 *
 * FIFO Generator - Verilog Behavioral Model
 *
 *******************************************************************************
 *
 * Copyright(C) 2006 by Xilinx, Inc. All rights reserved.
 * This text/file contains proprietary, confidential
 * information of Xilinx, Inc., is distributed under
 * license from Xilinx, Inc., and may be used, copied
 * and/or disclosed only pursuant to the terms of a valid
 * license agreement with Xilinx, Inc. Xilinx hereby
 * grants you a license to use this text/file solely for
 * design, simulation, implementation and creation of
 * design files limited to Xilinx devices or technologies.
 * Use with non-Xilinx devices or technologies is expressly
 * prohibited and immediately terminates your license unless
 * covered by a separate agreement.
 *
 * Xilinx is providing theis design, code, or information
 * "as-is" solely for use in developing programs and
 * solutions for Xilinx devices, with no obligation on the
 * part of Xilinx to provide support. By providing this design,
 * code, or information as one possible implementation of
 * this feature, application or standard. Xilinx is making no
 * representation that this implementation is free from any
 * claims of infringement. You are responsible for obtaining
 * any rights you may require for your implementation.
 * Xilinx expressly disclaims any warranty whatsoever with
 * respect to the adequacy of the implementation, including
 * but not limited to any warranties or representations that this
 * implementation is free from claims of infringement, implied
 * warranties of merchantability or fitness for a particular
 * purpose.
 *
 * Xilinx products are not intended for use in life support
 * appliances, devices, or systems. Use in such applications is
 * expressly prohibited.
 *
 * This copyright and support notice must be retained as part
 * of this text at all times. (c)Copyright 1995-2006 Xilinx, Inc.
 * All rights reserved.
 *
 *******************************************************************************
 *
 * Filename: FIFO_GENERATOR_V4_4.v
 *
 * Author     : Xilinx
 *
 *******************************************************************************
 * Structure:
 * 
 * fifo_generator_v4_4.vhd
 *    |
 *    +-fifo_generator_v4_4_bhv_as
 *    |
 *    +-fifo_generator_v4_4_bhv_ss
 *    |
 *    +-fifo_generator_v4_4_bhv_preload0
 * 
 *******************************************************************************
 * Description:
 *
 * The Verilog behavioral model for the FIFO Generator.
 *
 *   The behavioral model has three parts:
 *      - The behavioral model for independent clocks FIFOs (_as)
 *      - The behavioral model for common clock FIFOs (_ss)
 *      - The "preload logic" block which implements First-word Fall-through
 * 
 *******************************************************************************
 * Description:
 *  The verilog behavioral model for the FIFO generator core.
 *
 *******************************************************************************
 */

`define LOG2(x) ((x) == 8 ? 3 : (x) == 4 ? 2 : 1)
/*******************************************************************************
 * Declaration of top-level module
 ******************************************************************************/

/**************************************************************************
 * First-Word Fall-Through module (preload 0)
 **************************************************************************/
module fifo_generator_v4_4_bhv_ver_preload0
 (
  RD_CLK,
  RD_RST,
  SRST,
  RD_EN,
  FIFOEMPTY,
  FIFODATA,
  USERDATA,
  USERVALID,
  USERUNDERFLOW,
  USEREMPTY,
  USERALMOSTEMPTY,
  RAMVALID,
  FIFORDEN
  );

 parameter  C_DOUT_RST_VAL            = "";
 parameter  C_DOUT_WIDTH              = 8;
 parameter  C_HAS_RST                 = 0;
 parameter  C_HAS_SRST                = 0;
 parameter  C_USE_DOUT_RST            = 0;
 parameter  C_USERVALID_LOW           = 0;
 parameter  C_USERUNDERFLOW_LOW       = 0;

 //Inputs
 input                     RD_CLK;
 input                     RD_RST;
 input                     SRST;
 input                     RD_EN;
 input                     FIFOEMPTY;
 input  [C_DOUT_WIDTH-1:0] FIFODATA;

 //Outputs
 output [C_DOUT_WIDTH-1:0] USERDATA;
 output                    USERVALID;
 output                    USERUNDERFLOW;
 output                    USEREMPTY;
 output                    USERALMOSTEMPTY;
 output                    RAMVALID;
 output                    FIFORDEN;

 //Inputs
 wire                      RD_CLK;
 wire                      RD_RST;
 wire                      RD_EN;
 wire                      FIFOEMPTY;
 wire [C_DOUT_WIDTH-1:0]   FIFODATA;

 //Outputs
 reg [C_DOUT_WIDTH-1:0]    USERDATA;
 wire                      USERVALID;
 wire                      USERUNDERFLOW;
 wire                      USEREMPTY;
 wire                      USERALMOSTEMPTY;
 wire                      RAMVALID;
 wire                      FIFORDEN;

 //Internal signals
 wire                      preloadstage1;
 wire                      preloadstage2;
 reg                       ram_valid_i;
 reg                       read_data_valid_i;
 wire                      ram_regout_en;
 wire                      ram_rd_en;
 reg                       empty_i        = 1'b1;
 reg                       empty_q        = 1'b1;
 reg                       rd_en_q        = 1'b0;
 reg                       almost_empty_i = 1'b1;
 reg                       almost_empty_q = 1'b1;
 wire 		           rd_rst_i;
 wire 		           srst_i;


/*************************************************************************
* FUNCTIONS
*************************************************************************/

   /*************************************************************************
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

   
   //*************************************************************************
   //  Set power-on states for regs
   //*************************************************************************
   initial begin
      ram_valid_i       = 1'b0;
      read_data_valid_i = 1'b0;
      USERDATA          = hexstr_conv(C_DOUT_RST_VAL);
   end //initial

   //***************************************************************************
   //  connect up optional reset
   //***************************************************************************
   assign rd_rst_i = C_HAS_RST ? RD_RST : 0;
   assign srst_i = C_HAS_SRST ? SRST : 0;


   //***************************************************************************
   //  preloadstage2 indicates that stage2 needs to be updated. This is true
   //  whenever read_data_valid is false, and RAM_valid is true.
   //***************************************************************************
   assign preloadstage2 = ram_valid_i & (~read_data_valid_i | RD_EN);

   //***************************************************************************
   //  preloadstage1 indicates that stage1 needs to be updated. This is true
   //  whenever the RAM has data (RAM_EMPTY is false), and either RAM_Valid is
   //  false (indicating that Stage1 needs updating), or preloadstage2 is active
   //  (indicating that Stage2 is going to update, so Stage1, therefore, must
   //  also be updated to keep it valid.
   //***************************************************************************
   assign preloadstage1 = ((~ram_valid_i | preloadstage2) & ~FIFOEMPTY);

   //***************************************************************************
   // Calculate RAM_REGOUT_EN
   //  The output registers are controlled by the ram_regout_en signal.
   //  These registers should be updated either when the output in Stage2 is
   //  invalid (preloadstage2), OR when the user is reading, in which case the
   //  Stage2 value will go invalid unless it is replenished.
   //***************************************************************************
   assign ram_regout_en = preloadstage2;

   //***************************************************************************
   // Calculate RAM_RD_EN
   //   RAM_RD_EN will be asserted whenever the RAM needs to be read in order to
   //  update the value in Stage1.
   //   One case when this happens is when preloadstage1=true, which indicates
   //  that the data in Stage1 or Stage2 is invalid, and needs to automatically
   //  be updated.
   //   The other case is when the user is reading from the FIFO, which 
   // guarantees that Stage1 or Stage2 will be invalid on the next clock 
   // cycle, unless it is replinished by data from the memory. So, as long 
   // as the RAM has data in it, a read of the RAM should occur.
   //***************************************************************************
   assign ram_rd_en = (RD_EN & ~FIFOEMPTY) | preloadstage1;
   
   //***************************************************************************
   // Calculate RAMVALID_P0_OUT
   //   RAMVALID_P0_OUT indicates that the data in Stage1 is valid.
   //
   //   If the RAM is being read from on this clock cycle (ram_rd_en=1), then
   //   RAMVALID_P0_OUT is certainly going to be true.
   //   If the RAM is not being read from, but the output registers are being
   //   updated to fill Stage2 (ram_regout_en=1), then Stage1 will be emptying,
   //   therefore causing RAMVALID_P0_OUT to be false.
   //   Otherwise, RAMVALID_P0_OUT will remain unchanged.
   //***************************************************************************
   // PROCESS regout_valid
   always @ (posedge RD_CLK or posedge rd_rst_i) begin  
      if (rd_rst_i) begin 
	 // asynchronous reset (active high)
	 ram_valid_i     <= 1'b0;
      end else begin
         if (srst_i) begin 
            // synchronous reset (active high)
            ram_valid_i     <= 1'b0;
         end else begin
            if (ram_rd_en == 1'b1) begin
               ram_valid_i   <= 1'b1;
            end else begin
               if (ram_regout_en == 1'b1)
                 ram_valid_i <= 1'b0;
               else
                 ram_valid_i <= ram_valid_i;
            end
         end //srst_i
      end //rd_rst_i
   end //always
   
   //***************************************************************************
   // Calculate READ_DATA_VALID
   //  READ_DATA_VALID indicates whether the value in Stage2 is valid or not.
   //  Stage2 has valid data whenever Stage1 had valid data and 
   //  ram_regout_en_i=1, such that the data in Stage1 is propogated 
   //  into Stage2.
   //***************************************************************************
   always @ (posedge RD_CLK or posedge rd_rst_i) begin
      if (rd_rst_i)
	read_data_valid_i <= 1'b0;
      else if (srst_i)
	read_data_valid_i <= 1'b0;
      else 
	read_data_valid_i <= ram_valid_i | (read_data_valid_i & ~RD_EN);
   end //always
   
   
   //**************************************************************************
   // Calculate EMPTY
   //  Defined as the inverse of READ_DATA_VALID
   //
   // Description:
   //
   //  If read_data_valid_i indicates that the output is not valid,
   // and there is no valid data on the output of the ram to preload it
   // with, then we will report empty.
   //
   //  If there is no valid data on the output of the ram and we are
   // reading, then the FIFO will go empty.
   //
   //**************************************************************************
   always @ (posedge RD_CLK or posedge rd_rst_i) begin
      if (rd_rst_i) begin
	 // asynchronous reset (active high)
	 empty_i <= 1'b1;
	 empty_q <= 1'b1;
      end else begin
         if (srst_i) begin
            // synchronous reset (active high)
            empty_i <= 1'b1;
            empty_q <= 1'b1;
         end else begin
            // rising clock edge
            empty_i <= (~ram_valid_i & ~read_data_valid_i) | (~ram_valid_i & RD_EN);
            empty_q <= empty_i;
         end
      end
   end //always
   
   //Register RD_EN from user to calculate USERUNDERFLOW.
   always @ (posedge RD_CLK or posedge rd_rst_i) begin
      if (rd_rst_i) begin
	 // asynchronous reset (active high)
	 rd_en_q <= 1'b0;
      end else begin
         if (srst_i) begin
            // synchronous reset (active high)
            rd_en_q <= 1'b0;
         end else begin
            // rising clock edge
            rd_en_q <= RD_EN;
         end
      end
   end //always
   
   
   //***************************************************************************
   // Calculate user_almost_empty
   //  user_almost_empty is defined such that, unless more words are written
   //  to the FIFO, the next read will cause the FIFO to go EMPTY.
   //
   //  In most cases, whenever the output registers are updated (due to a user
   // read or a preload condition), then user_almost_empty will update to
   // whatever RAM_EMPTY is.
   //
   //  The exception is when the output is valid, the user is not reading, and
   // Stage1 is not empty. In this condition, Stage1 will be preloaded from the
   // memory, so we need to make sure user_almost_empty deasserts properly under
   // this condition.
   //***************************************************************************
   always @ (posedge RD_CLK or posedge rd_rst_i)
     begin
	if (rd_rst_i) begin         // asynchronous reset (active high)
	     almost_empty_i <= 1'b1;
	     almost_empty_q <= 1'b1;
	end else begin // rising clock edge
           if (srst_i) begin          // synchronous reset (active high)
              almost_empty_i <= 1'b1;
              almost_empty_q <= 1'b1;
           end else begin
              if ((ram_regout_en) | (~FIFOEMPTY & read_data_valid_i & ~RD_EN)) begin
                 almost_empty_i <= FIFOEMPTY;
              end
              almost_empty_q   <= empty_i;
           end
        end
     end //always
   
   
   assign USEREMPTY       = empty_i;
   assign USERALMOSTEMPTY = almost_empty_i;
   assign FIFORDEN        = ram_rd_en;
   assign RAMVALID        = ram_valid_i;
   assign USERVALID       = C_USERVALID_LOW ? ~read_data_valid_i : read_data_valid_i;
   assign USERUNDERFLOW   = C_USERUNDERFLOW_LOW ? ~(empty_q & rd_en_q) : empty_q & rd_en_q;
   
   always @ (posedge RD_CLK or posedge rd_rst_i)
     begin
	if (rd_rst_i && C_USE_DOUT_RST == 1)  //asynchronous reset (active high)
	  USERDATA   <= hexstr_conv(C_DOUT_RST_VAL);
	else begin // rising clock edge
          if (srst_i && C_USE_DOUT_RST == 1)
	    USERDATA   <= hexstr_conv(C_DOUT_RST_VAL);
	  else if (ram_regout_en)
            USERDATA <= FIFODATA;
        end
     end //always
   
   
   
   
   
endmodule
