//----------------------------------------------------------------------------
// user_fifo_test.v
//----------------------------------------------------------------------------

`timescale 1ps / 1ps

module user_fifo_test
  (
   // User clock ports
   Clkin_p,
   Clkin_m,
   
   // SelectMAP interface ports
   D,                           // Data bus
   RDWR_B,                      // Read/write signal
   CS_B,                        // Chip select
   INIT_B,                      // Initialization/interrupt signal
   CCLK                         // Local CCLK output
   );

   // User clock/reset ports
   input                       Clkin_p;
   input                       Clkin_m;
  
   // SelectMAP protocol ports
   inout [0:7]                 D;
   input 		       RDWR_B;
   input 		       CS_B;
   output 		       INIT_B;
   output                      CCLK;

   // Wires
   wire                        CCLK_int;
   
   wire [0:31]                 LoopData;
   wire 		       LoopEmpty;
   wire 		       LoopFull;

   wire [0:7]                  D_I;
   wire [0:7]                  D_O;
   wire [0:7]                  D_T;

   wire                        User_Clk;
   wire                        User_Rst;
   
   // IO buffers
   OBUF obuf_cclk( .I( CCLK_int ),
                   .O( CCLK )
                   );
   
   IOBUF iobuf_d0( .I( D_O[0] ),
                   .IO( D[0] ),
                   .O( D_I[0] ),
                   .T( D_T[0] )
                   );
   
   IOBUF iobuf_d1( .I( D_O[1] ),
                   .IO( D[1] ),
                   .O( D_I[1] ),
                   .T( D_T[1] )
                   );
   
   IOBUF iobuf_d2( .I( D_O[2] ),
                   .IO( D[2] ),
                   .O( D_I[2] ),
                   .T( D_T[2] )
                   );
   
   IOBUF iobuf_d3( .I( D_O[3] ),
                   .IO( D[3] ),
                   .O( D_I[3] ),
                   .T( D_T[3] )
                   );
   
   IOBUF iobuf_d4( .I( D_O[4] ),
                   .IO( D[4] ),
                   .O( D_I[4] ),
                   .T( D_T[4] )
                   );
   
   IOBUF iobuf_d5( .I( D_O[5] ),
                   .IO( D[5] ),
                   .O( D_I[5] ),
                   .T( D_T[5] )
                   );
   
   IOBUF iobuf_d6( .I( D_O[6] ),
                   .IO( D[6] ),
                   .O( D_I[6] ),
                   .T( D_T[6] )
                   );
   
   IOBUF iobuf_d7( .I( D_O[7] ),
                   .IO( D[7] ),
                   .O( D_I[7] ),
                   .T( D_T[7] )
                   );

   // Clock buffer and reset
   IBUFGDS_LVDS_25 diff_usrclk_buf( .I( Clkin_p ),
                                    .IB( Clkin_m ), 
                                    .O( User_Clk )
                                    );

   wire [0:3] rst;
   
   FD rst0( .D( 1'b0 ),
            .Q( rst[0] ),
            .C( User_Clk )
            );
   defparam rst0.INIT = 1'b1;

   FD rst1( .D( rst[0] ),
            .Q( rst[1] ),
            .C( User_Clk )
            );
   defparam rst1.INIT = 1'b1;

   FD rst2( .D( rst[1] ),
            .Q( rst[2] ),
            .C( User_Clk )
            );
   defparam rst2.INIT = 1'b1;

   FD rst3( .D( rst[2] ),
            .Q( rst[3] ),
            .C( User_Clk )
            );
   defparam rst3.INIT = 1'b1;

   assign   User_Rst = |rst;
   
   // FIFO module instantiation
   user_fifo test_fifo( 
                        .WrFifo_Din( LoopData ),
		        .WrFifo_WrEn( ~LoopFull && ~LoopEmpty ),
			.WrFifo_Full( LoopFull ),
                        .WrFifo_RdCnt(  ),
			.RdFifo_Dout( LoopData ),
			.RdFifo_RdEn( ~LoopFull && ~LoopEmpty ),
			.RdFifo_Empty( LoopEmpty ),
                        .RdFifo_RdCnt(  ),
			.User_Rst( User_Rst ),
			.User_Clk( User_Clk ),
			.Sys_Rst( User_Rst ),
			.Sys_Clk( User_Clk ),                        
			.D_I( D_I ),
			.D_O( D_O ),
			.D_T( D_T ),                         
			.RDWR_B( RDWR_B ),
			.CS_B( CS_B ),
			.INIT_B( INIT_B ),
                        .CCLK( CCLK_int )
                        );
   
endmodule
