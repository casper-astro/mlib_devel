//----------------------------------------------------------------------------
// user_fifo.v
//----------------------------------------------------------------------------

`timescale 1ps / 1ps

module user_fifo
  (
   // FIFO interface ports
   WrFifo_Din,                  // Write FIFO data-in
   WrFifo_WrEn,                 // Write FIFO write enable
   WrFifo_Full,                 // Write FIFO full
   WrFifo_RdCnt,                // Write FIFO write count 
   RdFifo_Dout,                 // Read FIFO data-out
   RdFifo_RdEn,                 // Read FIFO read enable
   RdFifo_Empty,                // Read FIFO empty
   RdFifo_RdCnt,                // Read FIFO read count
   User_Rst,                    // User reset
   User_Clk,                    // User clock
   Sys_Rst,                     // System clock reset
   Sys_Clk,                     // 100MHz system clock for CCLK generation
 
   // SelectMAP interface ports
   D_I,                         // Data bus input
   D_O,                         // Data bus output
   D_T,                         // Data bus tristate enable
   RDWR_B,                      // Read/write signal
   CS_B,                        // Chip select
   INIT_B,                      // Initialization/interrupt signal
   CCLK                         // CCLK output
   );

   // FIFO interface ports
   input [0:31]                WrFifo_Din;
   input 		       WrFifo_WrEn;
   output 		       WrFifo_Full;
   output [0:7]                WrFifo_RdCnt;
   output [0:31]	       RdFifo_Dout;
   input 		       RdFifo_RdEn;
   output 		       RdFifo_Empty;
   output [0:7]                RdFifo_RdCnt;
   input 		       User_Rst;
   input 		       User_Clk;
   input                       Sys_Rst;
   input                       Sys_Clk;
   
   // SelectMAP protocol ports
   input [0:7]                 D_I;
   output [0:7]                D_O;
   output [0:7]                D_T;   
   input 		       RDWR_B;
   input 		       CS_B;
   output 		       INIT_B;
   output                      CCLK;
      
   //  ____        __ _       _ _   _                 
   // |  _ \  ___ / _(_)_ __ (_) |_(_) ___  _ __  ___ 
   // | | | |/ _ \ |_| | '_ \| | __| |/ _ \| '_ \/ __|
   // | |_| |  __/  _| | | | | | |_| | (_) | | | \__ \
   // |____/ \___|_| |_|_| |_|_|\__|_|\___/|_| |_|___/
   //                                                    
   
   //----------------------------------------------------------------------------
   // Signal definitions
   //----------------------------------------------------------------------------
   // Write FIFO signals
   wire [0:31] 		       WrFifo_Dout;
   wire 		       WrFifo_Empty;
   wire 		       WrFifo_RdEn;
   wire [0:7]                  WrFifo_WrCnt;
   // Read FIFO signals
   wire [0:31]                 RdFifo_Din;
   wire 		       RdFifo_Full;
   wire 		       RdFifo_WrEn;
   wire [0:7]                  RdFifo_WrCnt;

   //----------------------------------------------------------------------------
   // Generate CCLK and associated reset
   //----------------------------------------------------------------------------
   wire                        ClkEn = ~CCLK;
   reg                         CCLK;
   wire                        SYNC;
   reg [0:2]                   CS_B_sys_reg;
   
   assign                      SYNC = CS_B_sys_reg[2] && ~CS_B_sys_reg[1];

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          CS_B_sys_reg  <= 3'b111;
        else
          CS_B_sys_reg  <= { CS_B, CS_B_sys_reg[0:1] };
     end
   
   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          CCLK <= 1'b0;
        else if (SYNC && CCLK)
          CCLK <= 1'b1;
        else
          CCLK <= ~CCLK;
     end
   
   //----------------------------------------------------------------------------
   // IO Registers
   //----------------------------------------------------------------------------
   reg [0:7]                   D_I_reg;
   reg [0:7]                   D_O;
   reg                         RDWR_B_reg;
   reg                         CS_B_reg;
   reg                         INIT_B;

   // Register the inputs
   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          begin
             D_I_reg    <= 8'h0;
             RDWR_B_reg <= 1'b1;
             CS_B_reg   <= 1'b1;
          end
        else if (ClkEn)
          begin
             D_I_reg    <= D_I;
             RDWR_B_reg <= RDWR_B;
             CS_B_reg   <= CS_B;
          end
     end
   
   //  _____ ___ _____ ___      
   // |  ___|_ _|  ___/ _ \ ___ 
   // | |_   | || |_ | | | / __|
   // |  _|  | ||  _|| |_| \__ \ 
   // |_|   |___|_|   \___/|___/
   //
   // Write FIFO:  The write is with respect to the user.  The user writes data to this
   //              FIFO and the control side of SelectMAP reads the data.
   //
   // Read FIFO:  The read is with respect to the user.  The user reads data sent from the
   //             control side of SelectMAP.
   //

   //----------------------------------------------------------------------------
   // Write counter
   //----------------------------------------------------------------------------   
   wire       WrEn = ~RDWR_B_reg && ~CS_B_reg && ~RdFifo_Full;
   reg [0:2]  WrCnt;

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          WrCnt <= 3'h0;
        else if (~|WrCnt && WrEn && ClkEn)
          WrCnt <= 3'b100;
        else if (ClkEn)          
          WrCnt <= { 1'b0, WrCnt[0:1] };
     end
   
   //----------------------------------------------------------------------------
   // Write register (write from SelectMAP)
   //----------------------------------------------------------------------------
   reg [0:23] WR_reg;

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          WR_reg <= 32'h0;
        else if (WrEn && ClkEn)
          WR_reg <= { WR_reg[8:23], D_I_reg };
     end
   
   //----------------------------------------------------------------------------
   // Read FIFO
   //----------------------------------------------------------------------------
   assign RdFifo_WrEn = WrEn && WrCnt[2];
   assign RdFifo_Din = { WR_reg, D_I_reg };
   
   fifo_async_32x128 RdFifo( .din( RdFifo_Din ),
			     .dout( RdFifo_Dout ),
			     .rd_clk( User_Clk ),
			     .rd_en( RdFifo_RdEn ),
			     .wr_clk( Sys_Clk ),
			     .wr_en( RdFifo_WrEn && ClkEn ),
			     .rst( User_Rst ),
			     .empty( RdFifo_Empty ),
			     .full( RdFifo_Full ),
                             .rd_data_count( RdFifo_RdCnt ),
                             .wr_data_count( RdFifo_WrCnt ) );

   //----------------------------------------------------------------------------
   // Read counter
   //----------------------------------------------------------------------------   
   wire      RdEn = RDWR_B_reg && ~CS_B_reg && ~WrFifo_Empty;
   reg [0:2] RdCnt;

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          RdCnt <= 3'h0;
        else if (~|RdCnt && RdEn && ClkEn)
          RdCnt <= 3'b100;
        else if (RdEn && ClkEn)
          RdCnt <= { 1'b0, RdCnt[0:1] };
     end

   //----------------------------------------------------------------------------
   // Read register
   //----------------------------------------------------------------------------   
   reg [0:31] RD_reg;

   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          RD_reg <= 32'h0;
        else if (~|RdCnt && ~RdEn && ClkEn)
          RD_reg <= WrFifo_Dout;
        else if (RdEn && ClkEn)
          RD_reg <= { RD_reg[8:31], 8'h0 };
     end
   
   //----------------------------------------------------------------------------
   // Write FIFO
   //----------------------------------------------------------------------------   
   assign WrFifo_RdEn = RdEn && RdCnt[2];
   
   fifo_async_32x128 WrFifo( .din( WrFifo_Din ),
			     .dout( WrFifo_Dout ),
			     .rd_clk( Sys_Clk ),
			     .rd_en( WrFifo_RdEn && ClkEn ),
			     .wr_clk( User_Clk ),
			     .wr_en( WrFifo_WrEn ),
			     .rst( User_Rst ),
			     .empty( WrFifo_Empty ),
			     .full( WrFifo_Full ),
                             .rd_data_count( WrFifo_RdCnt ),
                             .wr_data_count( WrFifo_WrCnt ) );

   //  ____       _           _   __  __    _    ____  
   // / ___|  ___| | ___  ___| |_|  \/  |  / \  |  _ \ 
   // \___ \ / _ \ |/ _ \/ __| __| |\/| | / _ \ | |_) |
   //  ___) |  __/ |  __/ (__| |_| |  | |/ ___ \|  __/ 
   // |____/ \___|_|\___|\___|\__|_|  |_/_/   \_\_|    
   //
   
   //----------------------------------------------------------------------------
   // SelectMAP control outputs
   //----------------------------------------------------------------------------
   wire [0:7] DataCnt = RDWR_B_reg ? WrFifo_RdCnt : RdFifo_RdCnt;

   assign     D_T    = {8{~RDWR_B}};             
   
   always @( posedge Sys_Clk )
     begin
        if (Sys_Rst)
          begin
             D_O    <= 8'h0;
             INIT_B <= 1'b1;
          end
        else if (ClkEn)
          begin
             D_O    <= CS_B_reg ? DataCnt : RD_reg[0:7];
             INIT_B <= WrFifo_Empty;
          end
     end
      
   //----------------------------------------------------------------------------

endmodule
