//----------------------------------------------------------------------------
// user_logic.v - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** Xilinx, Inc.                                                          **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
// ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
// ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
// ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
// ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
// ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
// ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
// ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
// ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
// ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
// ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
// ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
// ** FOR A PARTICULAR PURPOSE.                                             **
// **                                                                       **
// ** YOU MAY COPY AND MODIFY THESE FILES FOR YOUR OWN INTERNAL USE SOLELY  **
// ** WITH XILINX PROGRAMMABLE LOGIC DEVICES AND XILINX EDK SYSTEM OR       **
// ** CREATE IP MODULES SOLELY FOR XILINX PROGRAMMABLE LOGIC DEVICES AND    **
// ** XILINX EDK SYSTEM. NO RIGHTS ARE GRANTED TO DISTRIBUTE ANY FILES      **
// ** UNLESS THEY ARE DISTRIBUTED IN XILINX PROGRAMMABLE LOGIC DEVICES.     **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          user_logic.v
// Version:           1.00.a
// Description:       User logic module.
// Date:              Tue Nov  8 14:11:03 2005 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

module user_logic
  (
   // -- ADD USER PORTS BELOW THIS LINE ---------------
   D_I,                         // Data bus input
   D_O,                         // Data bus output
   D_T,                         // Data bus tristate
   RDWR_B,                      // Read/write signal
   CS_B,                        // Chip select
   INIT_B,                      // Initialization/interrupt signal   
   // -- ADD USER PORTS ABOVE THIS LINE ---------------

   // -- DO NOT EDIT BELOW THIS LINE ------------------
   // -- Bus protocol ports, do not add to or delete 
   Bus2IP_Clk,                     // Bus to IP clock
   Bus2IP_Reset,                   // Bus to IP reset
   IP2Bus_IntrEvent,               // IP to Bus interrupt event
   Bus2IP_Data,                    // Bus to IP data bus for user logic
   Bus2IP_BE,                      // Bus to IP byte enables for user logic
   Bus2IP_RdCE,                    // Bus to IP read chip enable for user logic
   Bus2IP_WrCE,                    // Bus to IP write chip enable for user logic
   IP2Bus_Data,                    // IP to Bus data bus for user logic
   IP2Bus_Ack,                     // IP to Bus acknowledgement
   IP2Bus_Retry,                   // IP to Bus retry response
   IP2Bus_Error,                   // IP to Bus error response
   IP2Bus_ToutSup,                 // IP to Bus timeout suppress
   IP2Bus_PostedWrInh              // IP to Bus posted write inhibit
   // -- DO NOT EDIT ABOVE THIS LINE ------------------
   ); // user_logic

   // -- ADD USER PARAMETERS BELOW THIS LINE ------------
   // --USER parameters added here 
   // -- ADD USER PARAMETERS ABOVE THIS LINE ------------

   // -- DO NOT EDIT BELOW THIS LINE --------------------
   // -- Bus protocol parameters, do not add to or delete
   parameter C_DWIDTH                       = 32;
   parameter C_NUM_CE                       = 2;
   parameter C_IP_INTR_NUM                  = 1;
   // -- DO NOT EDIT ABOVE THIS LINE --------------------

   // -- ADD USER PORTS BELOW THIS LINE -----------------
   input [0:7]                 D_I;
   output [0:7]                D_O;
   output [0:7]                D_T;   
   input 		       RDWR_B;
   input 		       CS_B;
   output 		       INIT_B;
   // -- ADD USER PORTS ABOVE THIS LINE -----------------

   // -- DO NOT EDIT BELOW THIS LINE --------------------
   // -- Bus protocol ports, do not add to or delete
   input                        Bus2IP_Clk;
   input                        Bus2IP_Reset;
   output [0 : C_IP_INTR_NUM-1] IP2Bus_IntrEvent;
   input [0 : C_DWIDTH-1]       Bus2IP_Data;
   input [0 : C_DWIDTH/8-1]     Bus2IP_BE;
   input [0 : C_NUM_CE-1]       Bus2IP_RdCE;
   input [0 : C_NUM_CE-1]       Bus2IP_WrCE;
   output [0 : C_DWIDTH-1]      IP2Bus_Data;
   output                       IP2Bus_Ack;
   output                       IP2Bus_Retry;
   output                       IP2Bus_Error;
   output                       IP2Bus_ToutSup;
   output                       IP2Bus_PostedWrInh;
   // -- DO NOT EDIT ABOVE THIS LINE --------------------

   //----------------------------------------------------------------------------
   // Implementation
   //----------------------------------------------------------------------------

   // --USER nets declarations added here, as needed for user logic

   // Nets for user logic slave model s/w accessible register example
   wire [0 : 1]                 slv_reg_write_select;
   wire [0 : 1]                 slv_reg_read_select;
   reg [0 : C_DWIDTH-1]         slv_ip2bus_data;
   wire                         slv_read_ack;
   wire                         slv_write_ack;

   wire [0:31]                  RFIFO_Data;
   wire [0:7]                   RFIFO_Cnt;
   wire [0:7]                   WFIFO_Cnt;
   // --USER logic implementation added here

   // ------------------------------------------------------
   // Example code to read/write user logic slave model s/w accessible registers
   // 
   // Note:
   // The example code presented here is to show you one way of reading/writing
   // software accessible registers implemented in the user logic slave model.
   // Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
   // to one software accessible register by the top level template. For example,
   // if you have four 32 bit software accessible registers in the user logic, you
   // are basically operating on the following memory mapped registers:
   // 
   //    Bus2IP_WrCE or   Memory Mapped
   //       Bus2IP_RdCE   Register
   //            "1000"   C_BASEADDR + 0x0
   //            "0100"   C_BASEADDR + 0x4
   //            "0010"   C_BASEADDR + 0x8
   //            "0001"   C_BASEADDR + 0xC
   // 
   // ------------------------------------------------------
   
   assign      slv_reg_write_select = Bus2IP_WrCE[0:1],
               slv_reg_read_select  = Bus2IP_RdCE[0:1],
               slv_write_ack        = Bus2IP_WrCE[0] || Bus2IP_WrCE[1],
               slv_read_ack         = Bus2IP_RdCE[0] || Bus2IP_RdCE[1];


   // implement slave model register read mux
   always @( * )
     begin: SLAVE_REG_READ_PROC

        case ( slv_reg_read_select )
          2'b10 : slv_ip2bus_data <= { 8'h0, RFIFO_Cnt, WFIFO_Cnt, 8'h0 };
          2'b01 : slv_ip2bus_data <= RFIFO_Data;
          default : slv_ip2bus_data <= 0;
        endcase

     end // SLAVE_REG_READ_PROC

   // ------------------------------------------------------------
   // SelectMAP FIFO
   // ------------------------------------------------------------

   user_fifo selectmap_fifo( 
                             .WrFifo_Din( Bus2IP_Data ),
		             .WrFifo_WrEn( slv_reg_write_select[1] ),
			     .WrFifo_Full(  ),
                             .WrFifo_RdCnt( WFIFO_Cnt ),
			     .RdFifo_Dout( RFIFO_Data ),
			     .RdFifo_RdEn( slv_reg_read_select[1] ),
			     .RdFifo_Empty(  ),
                             .RdFifo_RdCnt( RFIFO_Cnt ),
			     .User_Rst( Bus2IP_Reset ),
			     .User_Clk( Bus2IP_Clk ),
			     .Sys_Rst( Bus2IP_Reset ),
			     .Sys_Clk( Bus2IP_Clk ),                        
			     .D_I( D_I ),
			     .D_O( D_O ),
			     .D_T( D_T ),                         
			     .RDWR_B( RDWR_B ),
			     .CS_B( CS_B ),
			     .INIT_B( INIT_B ),
                             .CCLK(  )
                             );
   
   // ------------------------------------------------------------
   // Example code to drive IP to Bus signals
   // ------------------------------------------------------------

   assign IP2Bus_Data        = slv_ip2bus_data;
   assign IP2Bus_Ack         = slv_write_ack || slv_read_ack;
   assign IP2Bus_Error       = 0;
   assign IP2Bus_Retry       = 0;
   assign IP2Bus_ToutSup     = 0;
   assign IP2Bus_PostedWrInh = 0;
   assign IP2Bus_IntrEvent   = INIT_B;

endmodule
