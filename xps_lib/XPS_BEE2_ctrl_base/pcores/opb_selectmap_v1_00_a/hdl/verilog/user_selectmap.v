//----------------------------------------------------------------------------
// user_selectmap.v - module
//----------------------------------------------------------------------------

`timescale 1ps / 1ps

module user_selectmap
  ( 
    // Bus protocol ports
    Bus2IP_Clk,                  // Bus to IP clock
    Bus2IP_Reset,                // Bus to IP reset
    IP2Bus_IntrEvent,            // IP to Bus interrupt event
    Bus2IP_Data,                 // Bus to IP data bus for user logic
    Bus2IP_BE,                   // Bus to IP byte enables for user logic
    Bus2IP_RdCE,                 // Bus to IP read chip enable for user logic
    Bus2IP_WrCE,                 // Bus to IP write chip enable for user logic
    IP2Bus_Data,                 // IP to Bus data bus for user logic
    IP2Bus_Ack,                  // IP to Bus acknowledgement
    IP2Bus_Retry,                // IP to Bus retry response
    IP2Bus_Error,                // IP to Bus error response
    IP2Bus_ToutSup,              // IP to Bus timeout suppress
    IP2Bus_PostedWrInh,          // IP to Bus posted write inhibit
    
    // SelectMAP interface ports
    D_I,                         // Data bus input
    D_O,                         // Data bus output
    D_T,                         // Data bus tristate
    RDWR_B,                      // Read/write signal
    CS_B,                        // Chip select
    PROG_B,                      // Program/reset signal
    INIT_B,                      // Initialization/interrupt/busy signal
    DONE,                        // Programming done signal
    CCLK                         // Configuration clock
    );

   // -- Bus protocol parameters, do not add to or delete
   parameter C_DWIDTH        = 32;
   parameter C_NUM_CE        = 2;
   parameter C_IP_INTR_NUM   = 1;
   
   // Bus protocol ports
   input 		       Bus2IP_Clk;
   input 		       Bus2IP_Reset;
   output [0:C_IP_INTR_NUM-1]  IP2Bus_IntrEvent;
   input [0:C_DWIDTH-1]        Bus2IP_Data;
   input [0:C_DWIDTH/8-1]      Bus2IP_BE;
   input [0:C_NUM_CE-1]        Bus2IP_RdCE;
   input [0:C_NUM_CE-1]        Bus2IP_WrCE;
   output [0:C_DWIDTH-1]       IP2Bus_Data;
   output 		       IP2Bus_Ack;
   output 		       IP2Bus_Retry;
   output 		       IP2Bus_Error;
   output 		       IP2Bus_ToutSup;
   output                      IP2Bus_PostedWrInh;

   // SelectMAP protocol ports
   input [0:7]                 D_I;
   output [0:7]                D_O;
   output [0:7]                D_T;   
   output 		       RDWR_B;
   output 		       CS_B;
   input 		       INIT_B;
   input 		       DONE;
   output 		       PROG_B;
   output 		       CCLK;
   
   //  ____        __ _       _ _   _                 
   // |  _ \  ___ / _(_)_ __ (_) |_(_) ___  _ __  ___ 
   // | | | |/ _ \ |_| | '_ \| | __| |/ _ \| '_ \/ __|
   // | |_| |  __/  _| | | | | | |_| | (_) | | | \__ \ 
   // |____/ \___|_| |_|_| |_|_|\__|_|\___/|_| |_|___/ 
   //                                                    

   //----------------------------------------------------------------------------
   // Register inputs off OPB bus
   //----------------------------------------------------------------------------
   reg [0:C_DWIDTH-1]          Bus2IP_Data_reg;
   reg [0:C_DWIDTH/8-1]        Bus2IP_BE_reg;
   reg [0:C_NUM_CE-1]          Bus2IP_RdCE_reg;
   reg [0:C_NUM_CE-1]          Bus2IP_WrCE_reg;

   always @( posedge Bus2IP_Clk )
     begin
        Bus2IP_Data_reg <= Bus2IP_Data;
        Bus2IP_BE_reg   <= Bus2IP_BE;
        Bus2IP_RdCE_reg <= Bus2IP_RdCE;
        Bus2IP_WrCE_reg <= Bus2IP_WrCE;
     end
   
   //----------------------------------------------------------------------------
   // Generate clock enable (same as CCLK)
   //----------------------------------------------------------------------------
   reg ClkEn;

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          ClkEn <= 1'b1;
        else
          ClkEn <= ~ClkEn;
     end

   //----------------------------------------------------------------------------
   // IO pad registers
   //----------------------------------------------------------------------------

   reg [0:7]                   D_I_reg;    // synthesis attribute iob of D_I_reg is true
   reg [0:7]                   D_O;        // synthesis attribute iob of D_O is true
   reg [0:7]                   D_T;        // synthesis attribute iob of D_T is true      
   reg                         RDWR_B;     // synthesis attribute iob of RDWR_B is true
   reg                         CS_B;       // synthesis attribute iob of CS_B is true
   reg                         PROG_B;     // synthesis attribute iob of PROG_B is true
   reg                         INIT_B_reg; // synthesis attribute iob of INIT_B_reg is true
   reg                         DONE_reg;   // synthesis attribute iob of DONE_reg is true

   always @( posedge Bus2IP_Clk )
     begin
        D_I_reg    <= D_I;
        INIT_B_reg <= INIT_B;
        DONE_reg   <= DONE;
     end

   //----------------------------------------------------------------------------
   // Signal definitions
   //----------------------------------------------------------------------------
   // SelectMAP signal
   wire                        RDWR_B_int;       // Internal RDWR_B signal
   wire                        CS_B_int;         // Internal CS_B signal
   // Transfer counters
   `define                     RD_CNT  3
   `define 		       WR_CNT  3
   `define                     CTL_CNT 3
   reg [0:`RD_CNT-1]           XFER_rd_cnt;      // Read transfer counter
   reg [0:`WR_CNT-1]           XFER_wr_cnt;      // Write transfer counter
   reg [0:`CTL_CNT-1]          XFER_ctl_cnt;     // Control transfer counter
   // State machine signals
   reg                         InIdle;           // Not doing read or write
   reg                         InWrite;          // Doing write, bus clock
   reg                         InRead;           // Doing read, bus clock
   reg                         InCtrlRead;       // Doing ctrl read, bus clock
   wire                        StartWrite_C;     // Doing write, cfg clock
   wire                        StartRead_C;      // Doing read, cfg clock
   wire                        StartCtrlRead_C;  // Doing ctrl read, cfg clock
   wire 		       StartWrite;       // First cycle of data write
   wire 		       StartRead;        // First cycle of data read
   wire                        StartCtrlRead;    // First cycle of ctrl read
   wire 		       EndWrite;         // Data write is done
   wire                        EndRead;          // Data read is done
   wire                        EndCtrlRead;      // Ctrl read is done
   // Control register
   reg                         CTRL_mode;        // Operation mode register
   reg [0:7]                   CTRL_RdCnt;       // Read FIFO count
   reg [0:7]                   CTRL_WrCnt;       // Write FIFO count 
   wire [0:31] 		       CTRL_BusData;     // Output to IP2Bus_Data for control register
   wire 		       CTRL_RdCE;        // Read control register
   wire 		       CTRL_RdCE_C;      // Read control register, config clock
   wire 		       CTRL_WrCE;        // Write control register
   wire 		       CTRL_Ack;         // Control register data ack
   // Data register
   reg [0:31] 		       DATA_wr_reg;      // Data write shift register
   reg [0:31] 		       DATA_rd_reg;      // Data read register
   wire [0:31] 		       DATA_BusData;     // Output to IP2Bus_Data
   wire                        DATA_RdCE;        // Data register read enable
   wire                        DATA_RdCE_C;      // Data register read enable, config clock   
   wire                        DATA_WrCE;        // Data register write enable
   wire                        DATA_WrCE_C;      // Data register write enable, cfg clock   
   wire 		       DATA_wr_Ack;      // Data write ack
   wire			       DATA_rd_Ack;      // Data read ack
   wire 		       DATA_Ack;         // Data register data ack

   //   ____            _             _ 
   //  / ___|___  _ __ | |_ _ __ ___ | |
   // | |   / _ \| '_ \| __| '__/ _ \| |
   // | |__| (_) | | | | |_| | | (_) | |
   //  \____\___/|_| |_|\__|_|  \___/|_|
   //                                      

   //----------------------------------------------------------------------------
   // Read counter values
   //----------------------------------------------------------------------------
   reg [0:`RD_CNT-1]           Rd0Cnt;
   reg [0:`RD_CNT-1]           Rd1Cnt;
   reg [0:`RD_CNT-1]           Rd2Cnt;
   reg [0:`RD_CNT-1]           Rd3Cnt;
   reg [0:`RD_CNT-1]           RdCSCnt;
   reg [0:`RD_CNT-1]           RdDoneCnt;   
   
   always @( * )
     begin
        if (CTRL_mode)
          begin
             Rd0Cnt = `RD_CNT'd2;
             Rd1Cnt = `RD_CNT'd3;
             Rd2Cnt = `RD_CNT'd4;
             Rd3Cnt = `RD_CNT'd5;
             RdCSCnt = `RD_CNT'd4;
             RdDoneCnt = `RD_CNT'd6;
          end
        else
          begin
             Rd0Cnt = `RD_CNT'd3;
             Rd1Cnt = `RD_CNT'd4;
             Rd2Cnt = `RD_CNT'd5;
             Rd3Cnt = `RD_CNT'd6;
             RdCSCnt = `RD_CNT'd5;
             RdDoneCnt = `RD_CNT'd7;
          end
     end
   
   //----------------------------------------------------------------------------
   // Start/End signals
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     InIdle <= (~InWrite && ~InRead && ~InCtrlRead);
   
   assign StartWrite = InIdle && DATA_WrCE;
   assign StartRead = InIdle && DATA_RdCE;
   assign StartCtrlRead = InIdle && CTRL_RdCE;
   assign StartWrite_C = InIdle && DATA_WrCE_C;
   assign StartRead_C = InIdle && DATA_RdCE_C;
   assign StartCtrlRead_C = InIdle && CTRL_RdCE_C;

   assign EndWrite = (InWrite && (XFER_wr_cnt == `WR_CNT'd4));
   assign EndRead = (InRead && (XFER_rd_cnt == RdDoneCnt));
   assign EndCtrlRead = (InCtrlRead && (XFER_ctl_cnt == `CTL_CNT'd4));
   
   //----------------------------------------------------------------------------
   // Set the state
   //----------------------------------------------------------------------------   
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || EndWrite)
          InWrite <= 1'b0;
        else if (StartWrite_C && ClkEn)
          InWrite <= 1'b1;
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || EndRead)
          InRead <= 1'b0;
        else if (StartRead_C && ClkEn)
          InRead <= 1'b1;
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || EndCtrlRead)
          InCtrlRead <= 1'b0;
        else if (StartCtrlRead_C && ClkEn)
          InCtrlRead <= 1'b1;
     end
      
   //   ____            _             _   ____            _     _            
   //  / ___|___  _ __ | |_ _ __ ___ | | |  _ \ ___  __ _(_)___| |_ ___ _ __ 
   // | |   / _ \| '_ \| __| '__/ _ \| | | |_) / _ \/ _` | / __| __/ _ \ '__|
   // | |__| (_) | | | | |_| | | (_) | | |  _ <  __/ (_| | \__ \ ||  __/ |   
   //  \____\___/|_| |_|\__|_|  \___/|_| |_| \_\___|\__, |_|___/\__\___|_|   
   //                                               |___/                    
   //
   // Control register - This register return information about the DONE, and INIT_B
   //                    signals.  It is also used to set the PROG_B signal.
   //
   // Bits:         0-3         4       5        6       7    
   //      +-------------------------------------------------+
   //      |       ...       | MODE | PROG_B | INIT_B | DONE |
   //      +-------------------------------------------------+
   //                             8-15
   //      +-------------------------------------------------+
   //      |                   Read FIFO count               |
   //      +-------------------------------------------------+
   //                            16-23
   //      +-------------------------------------------------+
   //      |                  Write FIFO count               |
   //      +-------------------------------------------------+
   //                            24-31
   //      +-------------------------------------------------+
   //      |                      ...                        |
   //      +-------------------------------------------------+
   //

   //----------------------------------------------------------------------------
   // Bus control signals for control register
   //----------------------------------------------------------------------------   
   assign CTRL_RdCE = Bus2IP_RdCE_reg[0];
   assign CTRL_WrCE = Bus2IP_WrCE_reg[0];
   assign CTRL_Ack = EndCtrlRead | CTRL_WrCE;

   //----------------------------------------------------------------------------
   // Stretch the RdCE signal
   //----------------------------------------------------------------------------   
   reg    CTRL_RdCE_dly;

   assign CTRL_RdCE_C = (CTRL_RdCE | CTRL_RdCE_dly);

   always @( posedge Bus2IP_Clk )
     CTRL_RdCE_dly <= (CTRL_RdCE && ~EndCtrlRead);
   
   //----------------------------------------------------------------------------
   // Control register write
   //----------------------------------------------------------------------------   
   always @( posedge Bus2IP_Clk )
     begin
	// Either clear or write PROG_B bit
	if (Bus2IP_Reset)
          begin
	     PROG_B    <= 1'b1;
             CTRL_mode <= 1'b0;
          end
	else if (CTRL_WrCE && Bus2IP_BE_reg[0])
          begin
	     PROG_B    <= Bus2IP_Data_reg[5];
             CTRL_mode <= Bus2IP_Data_reg[4];
          end
     end

   //----------------------------------------------------------------------------
   // Control register read
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || StartCtrlRead)
          CTRL_WrCnt <= 8'b0;
        else if (XFER_ctl_cnt == `CTL_CNT'h2)
          CTRL_WrCnt <= D_I_reg;
     end

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || StartCtrlRead)
          CTRL_RdCnt <= 8'b0;
        else if (XFER_ctl_cnt == `CTL_CNT'h3)
          CTRL_RdCnt <= D_I_reg;
     end
   
   assign CTRL_BusData = { 4'h0, CTRL_mode, PROG_B, INIT_B_reg, DONE_reg,
                           CTRL_RdCnt,
                           CTRL_WrCnt,
                           8'h0 };
   
   //  ____        _          ____            _     _            
   // |  _ \  __ _| |_ __ _  |  _ \ ___  __ _(_)___| |_ ___ _ __ 
   // | | | |/ _` | __/ _` | | |_) / _ \/ _` | / __| __/ _ \ '__|
   // | |_| | (_| | || (_| | |  _ <  __/ (_| | \__ \ ||  __/ |   
   // |____/ \__,_|\__\__,_| |_| \_\___|\__, |_|___/\__\___|_|   
   //                                   |___/                    
   //
   // Data register - This register holds bytes while they are transfered back and forth
   //                 over the selectMAP data pins.
   //
   // Bytes:        0                 1               2                 3
   //       +--------------------------------------------------------------------+
   //       |     Byte 0     |     Byte 1     |     Byte 2     |      Byte 3     |
   //       +--------------------------------------------------------------------+
   //

   //----------------------------------------------------------------------------
   // Transfer signals
   //----------------------------------------------------------------------------
   assign DATA_RdCE = Bus2IP_RdCE_reg[1];
   assign DATA_WrCE = Bus2IP_WrCE_reg[1];
   assign DATA_Ack = DATA_rd_Ack | DATA_wr_Ack;
   
   //----------------------------------------------------------------------------
   // Stretch the WrCE/RdCE signals
   //----------------------------------------------------------------------------
   reg    DATA_WrCE_dly;
   reg    DATA_RdCE_dly;

   assign DATA_WrCE_C = (DATA_WrCE | DATA_WrCE_dly);
   assign DATA_RdCE_C = (DATA_RdCE | DATA_RdCE_dly);
   
   always @( posedge Bus2IP_Clk )
     begin
        DATA_WrCE_dly <= (DATA_WrCE & ~EndWrite);
        DATA_RdCE_dly <= (DATA_RdCE & ~EndRead);
     end
  
   //----------------------------------------------------------------------------
   // Write datapath
   //----------------------------------------------------------------------------   
   assign DATA_wr_Ack = StartWrite;

   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || EndWrite)       // Reset to zero
          DATA_wr_reg <= 31'h0;
	else if (StartWrite)                // Load with 24-bits of data
	  DATA_wr_reg <= Bus2IP_Data_reg[0:31];
	else if (InWrite && ClkEn) // Shift left 8-bits (LSByte on left)
	  DATA_wr_reg <= { DATA_wr_reg[8:31], 8'h0 };
     end

   //----------------------------------------------------------------------------
   // Read datapath
   //----------------------------------------------------------------------------
   wire RdEn0 = (XFER_rd_cnt == Rd0Cnt) && (CTRL_mode ? ClkEn : ~ClkEn);
   wire RdEn1 = (XFER_rd_cnt == Rd1Cnt) && (CTRL_mode ? ClkEn : ~ClkEn);
   wire RdEn2 = (XFER_rd_cnt == Rd2Cnt) && (CTRL_mode ? ClkEn : ~ClkEn);
   wire RdEn3 = (XFER_rd_cnt == Rd3Cnt) && (CTRL_mode ? ClkEn : ~ClkEn);
   
   assign DATA_rd_Ack = EndRead;
   
   always @( posedge Bus2IP_Clk )
     begin
	if (Bus2IP_Reset || EndRead)  // Reset to zero
	  DATA_rd_reg <= 31'h0;
	else if (RdEn0)               // Load byte 0
	  DATA_rd_reg[0:7]   <= D_I_reg;
	else if (RdEn1)               // Load byte 1
	  DATA_rd_reg[8:15]  <= D_I_reg;
	else if (RdEn2)               // Load byte 2
	  DATA_rd_reg[16:23] <= D_I_reg;
        else if (RdEn3)               // Load byte 3
          DATA_rd_reg[24:31] <= D_I_reg;
     end

   assign DATA_BusData = DATA_rd_reg;

   //   ____                  _                
   //  / ___|___  _   _ _ __ | |_ ___ _ __ ___ 
   // | |   / _ \| | | | '_ \| __/ _ \ '__/ __|
   // | |__| (_) | |_| | | | | ||  __/ |  \__ \ //
   //  \____\___/ \__,_|_| |_|\__\___|_|  |___/ 
   //                                          

   //----------------------------------------------------------------------------
   // Control counter
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || StartCtrlRead)
          XFER_ctl_cnt <= `CTL_CNT'h0;
        else if (InCtrlRead && ClkEn)
          XFER_ctl_cnt <= XFER_ctl_cnt + 1'b1;
     end
   
   //----------------------------------------------------------------------------
   // Read transfer counter
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset || StartRead)
          XFER_rd_cnt <= `RD_CNT'h0;
        else if (InRead && ClkEn)
          XFER_rd_cnt <= XFER_rd_cnt + 1'b1;
     end

   //----------------------------------------------------------------------------
   // Write transfer counter
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     begin
	if (Bus2IP_Reset || StartWrite)
	  XFER_wr_cnt <= `WR_CNT'h0;
	else if (InWrite &&  ClkEn)
	  XFER_wr_cnt <= XFER_wr_cnt + 1'b1;
     end
      
   //  ____       _           _   __  __    _    ____  
   // / ___|  ___| | ___  ___| |_|  \/  |  / \  |  _ \ 
   // \___ \ / _ \ |/ _ \/ __| __| |\/| | / _ \ | |_) |
   //  ___) |  __/ |  __/ (__| |_| |  | |/ ___ \|  __/ 
   // |____/ \___|_|\___|\___|\__|_|  |_/_/   \_\_|    
   //

   //----------------------------------------------------------------------------
   // SelectMAP control
   //----------------------------------------------------------------------------
   wire   DataRdCS = InRead && (XFER_rd_cnt < RdCSCnt);
   wire   DataWrCS = InWrite && ~EndWrite;
      
   assign CS_B_int = ~(DataRdCS || DataWrCS);
   assign RDWR_B_int = ~(StartCtrlRead_C || StartWrite_C || InWrite);

   always @( posedge Bus2IP_Clk )
     begin
        CS_B   <= CS_B_int;
        RDWR_B <= RDWR_B_int;
     end

   //----------------------------------------------------------------------------
   // Generate configuration clock
   //----------------------------------------------------------------------------
   reg    CCLK_reg;
   assign CCLK = CCLK_reg;
   
   always @( posedge Bus2IP_Clk )
     begin
        if (Bus2IP_Reset)
          CCLK_reg <= 1'b0;
        else
          CCLK_reg <= ~CCLK_reg;
     end

   //----------------------------------------------------------------------------
   // SelectMAP data
   //----------------------------------------------------------------------------
   always @( posedge Bus2IP_Clk )
     D_T <= {8{RDWR_B_int}};
    

   always @( posedge Bus2IP_Clk )
     D_O <= DATA_wr_reg[0:7];

   //  ___ ____ ___ ____ 
   // |_ _|  _ \_ _/ ___|
   //  | || |_) | | |    
   //  | ||  __/| | |___ 
   // |___|_|  |___\____|
   //                       
   
   //----------------------------------------------------------------------------
   // Control/data register to bus MUX (for reads)
   //----------------------------------------------------------------------------
   reg [0:31] IP2Bus_Data_mux;
   assign     IP2Bus_Data = IP2Bus_Data_mux;
   
   always @( * )
     begin
	if (CTRL_RdCE)
	  IP2Bus_Data_mux = CTRL_BusData;
	else if (DATA_RdCE)
	  IP2Bus_Data_mux = DATA_BusData;
	else
	  IP2Bus_Data_mux = 32'h0;
     end

   //----------------------------------------------------------------------------
   // Bus control signals
   //----------------------------------------------------------------------------
   assign IP2Bus_Ack         = CTRL_Ack | DATA_Ack;
   assign IP2Bus_IntrEvent   = ~INIT_B_reg & CTRL_mode;
   assign IP2Bus_Error       = 1'b0;
   assign IP2Bus_Retry       = 1'b0;
   assign IP2Bus_ToutSup     = InRead | InWrite;
   assign IP2Bus_PostedWrInh = InWrite;

   //----------------------------------------------------------------------------
   
endmodule
