`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
//
// Top level of plb_ddr2 controller
// 
////////////////////////////////////////////////////////////////////////////////

module plb_ddr2(		
		// PLB system inputs
		PLB_Clk,
		PLB_Rst,

		// PLB to slave inputs		
		PLB_PAValid,
		PLB_busLock,
		PLB_masterID,
		PLB_RNW,
		PLB_BE,
		PLB_size,
		PLB_type,
		PLB_MSize,
		PLB_compress,
		PLB_guarded,
		PLB_ordered,
		PLB_lockErr,
		PLB_abort,
		PLB_ABus,
		PLB_pendReq,
		PLB_pendPri,
		PLB_reqPri,
		PLB_SAValid,
		PLB_rdPrim,
		PLB_wrPrim,
		PLB_wrDBus,
		PLB_wrBurst,
		PLB_rdBurst,
		
		// Slave to PLB
		Sl_addrAck,
		Sl_wait,
		Sl_SSize,
		Sl_rearbitrate,
		Sl_MBusy,
		Sl_MErr,
		Sl_wrDAck,
		Sl_wrComp,
		Sl_wrBTerm,
		Sl_rdDBus,
		Sl_rdWdAddr,
		Sl_rdDAck,
		Sl_rdComp,
		Sl_rdBTerm,

`ifndef MODELSIM
                DDR_clk,
                DDR_input_data,
                DDR_byte_enable,
                DDR_get_data,
                DDR_output_data,
                DDR_data_valid,
                DDR_address,
                DDR_read,
                DDR_write,
                DDR_ready
`endif				
		);
   
   //----------------------------------------------------------------------
   // Parameters
   //----------------------------------------------------------------------

   parameter 	  C_MEM_BASE_ADDR   = 32'h00000000;
   parameter 	  C_MEM_HIGH_ADDR   = 32'h0fffffff;
   parameter      C_PLB_AWIDTH      = 32;
   parameter      C_PLB_DWIDTH      = 64;
   parameter 	  C_PLB_MID_WIDTH   = 3;   
   parameter      C_PLB_NUM_MASTERS = 8;
   parameter      C_FAMILY          = "virtex2p";
   
   //----------------------------------------------------------------------
   // Inputs and outputs
   //----------------------------------------------------------------------

   input 			  PLB_Clk;
   input 			  PLB_Rst;
   input 			  PLB_PAValid;
   input 			  PLB_busLock;
   input [0:C_PLB_MID_WIDTH-1] 	  PLB_masterID;
   input 			  PLB_RNW;
   input [0:7] 			  PLB_BE;
   input [0:3] 			  PLB_size;
   input [0:2] 			  PLB_type;
   input [0:1] 			  PLB_MSize;
   input 			  PLB_compress;
   input 			  PLB_guarded;
   input 			  PLB_ordered;
   input 			  PLB_lockErr;
   input 			  PLB_abort;
   input [0:31] 		  PLB_ABus;
   input 			  PLB_pendReq;
   input [0:1] 			  PLB_pendPri;
   input [0:1] 			  PLB_reqPri;
   input 			  PLB_SAValid;
   input 			  PLB_rdPrim;
   input 			  PLB_wrPrim;
   input [0:63] 		  PLB_wrDBus;
   input 			  PLB_wrBurst;
   input 			  PLB_rdBurst;
   
   output 			  Sl_addrAck;
   output 			  Sl_wait;
   output [0:1] 		  Sl_SSize;
   output 			  Sl_rearbitrate;
   output [0:C_PLB_NUM_MASTERS-1] Sl_MBusy;
   output [0:C_PLB_NUM_MASTERS-1] Sl_MErr;
   output 			  Sl_wrDAck;
   output 			  Sl_wrComp;
   output 			  Sl_wrBTerm;
   output [0:63] 		  Sl_rdDBus;   
   output [0:3] 		  Sl_rdWdAddr;
   output 			  Sl_rdDAck;
   output 			  Sl_rdComp;
   output 			  Sl_rdBTerm;

`ifndef MODELSIM
   input                          DDR_clk;
   output [143:0]                 DDR_input_data;
   output [17:0]                  DDR_byte_enable;
   input                          DDR_get_data;
   input [143:0]                  DDR_output_data;
   input                          DDR_data_valid;
   output [31:0]                  DDR_address;
   output                         DDR_read;
   output                         DDR_write;
   input                          DDR_ready;
`else
   wire                           DDR_clk;
   wire [143:0]                   DDR_input_data;
   wire [17:0]                    DDR_byte_enable;
   wire                           DDR_get_data;
   wire [143:0]                   DDR_output_data;
   wire                           DDR_data_valid;
   wire [31:0]                    DDR_address;
   wire                           DDR_read;
   wire                           DDR_write;
   wire                           DDR_ready;
`endif   

`ifdef MODELSIM
   //----------------------------------------------------------------------
   // DDR2 controller
   //----------------------------------------------------------------------
   
   ddr2_controller DDR2_controller( .port0_input_data( DDR_input_data ),
                                    .port0_byte_enable( DDR_byte_enable ),
                                    .port0_get_data( DDR_get_data ),
                                    .port0_output_data( DDR_output_data ),
                                    .port0_data_valid( DDR_data_valid ),
                                    .port0_address( DDR_address ),
                                    .port0_read( DDR_read ),
                                    .port0_write( DDR_write ),
                                    .port0_ready( DDR_ready ),
                                    .clk_in( DDR_clk ),
                                    .reset_in( PLB_Rst )
                                    );
`endif   
   
   //----------------------------------------------------------------------
   // PLB controller
   //----------------------------------------------------------------------

   wire [0:26]                    DDR_addr;   
   wire [0:127]                   DDR_dout;
   wire [0:127]                   DDR_din;
   wire [0:15]                    DDR_be;

   assign                         DDR_address = { DDR_addr, 5'h0 };
   assign                         DDR_input_data = { 16'h0, DDR_din };
   assign                         DDR_dout = DDR_output_data[127:0];
   assign                         DDR_byte_enable = { 2'h0, DDR_be };

   plb_ctrl PLB_controller( .DDR_Clk( DDR_clk ),
			    .DDR_ready( DDR_ready ),
			    .DDR_wr( DDR_write ),
			    .DDR_rd( DDR_read ),
			    .DDR_wr_en( DDR_data_valid ),
			    .DDR_rd_en( DDR_get_data ),
			    .DDR_dout( DDR_dout ),
			    .DDR_din(  DDR_din ),
			    .DDR_be( DDR_be ),
			    .DDR_addr( DDR_addr ),
			    .PLB_Clk( PLB_Clk ),
			    .PLB_Rst( PLB_Rst ),
			    .PLB_PAValid( PLB_PAValid ),
			    .PLB_busLock( PLB_busLock ),
			    .PLB_masterID( PLB_masterID ),
			    .PLB_RNW( PLB_RNW ),
			    .PLB_BE( PLB_BE ),
			    .PLB_size( PLB_size ),
			    .PLB_type( PLB_type ),
			    .PLB_MSize( PLB_MSize ),
			    .PLB_compress( PLB_compress ),
			    .PLB_guarded( PLB_guarded ),
			    .PLB_ordered( PLB_ordered ),
			    .PLB_lockErr( PLB_lockErr ),
			    .PLB_abort( PLB_abort ),
			    .PLB_ABus( PLB_ABus ),
			    .PLB_pendReq( PLB_pendReq ),
			    .PLB_pendPri( PLB_pendPri ),
			    .PLB_reqPri( PLB_reqPri ),
			    .PLB_SAValid( PLB_SAValid ),
			    .PLB_rdPrim( PLB_rdPrim ),
			    .PLB_wrPrim( PLB_wrPrim ),
			    .PLB_wrDBus( PLB_wrDBus ),
			    .PLB_wrBurst( PLB_wrBurst ),
			    .PLB_rdBurst( PLB_rdBurst ),
			    .Sl_addrAck( Sl_addrAck ),
			    .Sl_wait( Sl_wait ),
			    .Sl_SSize( Sl_SSize ),
			    .Sl_rearbitrate( Sl_rearbitrate ),
			    .Sl_MBusy( Sl_MBusy ),
			    .Sl_MErr( Sl_MErr ),
			    .Sl_wrDAck( Sl_wrDAck ),
			    .Sl_wrComp( Sl_wrComp ),
			    .Sl_wrBTerm( Sl_wrBTerm ),
			    .Sl_rdDBus( Sl_rdDBus ),   
			    .Sl_rdWdAddr( Sl_rdWdAddr ),
			    .Sl_rdDAck( Sl_rdDAck ),
			    .Sl_rdComp( Sl_rdComp ),
			    .Sl_rdBTerm( Sl_rdBTerm ) );
   defparam PLB_controller.C_MEM_BASE_ADDR = C_MEM_BASE_ADDR;
   defparam PLB_controller.C_MEM_HIGH_ADDR = C_MEM_HIGH_ADDR;
   defparam PLB_controller.C_PLB_AWIDTH = C_PLB_AWIDTH;
   defparam PLB_controller.C_PLB_DWIDTH = C_PLB_DWIDTH;   
   defparam PLB_controller.C_PLB_MID_WIDTH = C_PLB_MID_WIDTH;
   defparam PLB_controller.C_PLB_NUM_MASTERS = C_PLB_NUM_MASTERS;
   defparam PLB_controller.C_FAMILY = C_FAMILY;
   
   //----------------------------------------------------------------------

endmodule
