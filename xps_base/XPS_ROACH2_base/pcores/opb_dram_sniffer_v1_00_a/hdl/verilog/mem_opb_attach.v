module mem_opb_attach #(
    parameter C_BASEADDR = 0,
    parameter C_HIGHADDR = 0
  ) (
    input         OPB_Clk,
    input         OPB_Rst,
    output [0:31] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input         OPB_RNW,
    input         OPB_select,
    input         OPB_seqAddr,

    input          dram_clk,
    input          dram_rst,

    input [287:0]  dram_rd_data, //*
    input 	   dram_rd_data_end,
    input 	   dram_rd_data_valid, //*
    input 	   dram_rdy, //*
    input 	   dram_wdf_rdy, //*?
    output [31:0]  dram_addr, //*?
    output [2:0]   dram_cmd, //*
    output 	   dram_en, //*
    output [287:0] dram_wdf_data, //*
    output 	   dram_wdf_end, //*?
    output [35:0]  dram_wdf_mask, //*
    output 	   dram_wdf_wren, //*?

    /* debug outputs */
    output [3:0]   dram_state,
    output [3:0]   cpu_state,

   /*DDR3 state counters*/
    output [31:0]  ddr3_s0_ctr,
    output [31:0]  ddr3_s1_ctr,
    output [31:0]  ddr3_s2_ctr,
    output [31:0]  ddr3_s3_ctr,
    output [31:0]  ddr3_s4_ctr,
    output [31:0]  ddr3_s5_ctr,
    output [31:0]  ddr3_s6_ctr,
    output [31:0]  ddr3_s7_ctr,
    output [31:0]  ddr3_sx_ctr,
   
    /*OPB state counters*/
    output [31:0]  opb_s0_ctr,
    output [31:0]  opb_s1_ctr,
    output [31:0]  opb_s2_ctr,
    output [31:0]  opb_s3_ctr,
    output [31:0]  opb_s4_ctr,
    output [31:0]  opb_s5_ctr,
    output [31:0]  opb_sx_ctr,
    
    /* counter resets */
    input       opb_ctr_rst,
    input       ddr3_ctr_rst
  );

   /* OPB states */
   localparam OPB_IDLE     = 4'h0;
   localparam OPB_SELECT   = 4'h1;
   localparam OPB_READ     = 4'h2;
   localparam OPB_READ_X   = 4'h3;
   localparam OPB_WRITE    = 4'h4;
   localparam OPB_WRITE_X  = 4'h5;

   /* OPB signals */
   reg [3:0] 	   opb_state;
   reg 		   opb_ack;
   reg 		   opb_error;
   reg 		   opb_retry;
   reg 		   opb_toutsup;
   reg [0:31] 	   opb_addr;
   reg [0:31] 	   opb_data_out;

   /* DDR3 states */
   localparam DDR3_IDLE       = 4'h0;
   localparam DDR3_READ_INIT  = 4'h1;
   localparam DDR3_READ_HOLD  = 4'h2;
   localparam DDR3_READ_WAIT  = 4'h3;
   localparam DDR3_READ_RESP  = 4'h4;
   localparam DDR3_WRITE_INIT = 4'h5;
   localparam DDR3_WRITE_WAIT = 4'h6;
   localparam DDR3_WRITE_RESP = 4'h7;

   /* DDR3-to-OPB signals */
   reg [3:0] 	   ddr3_state;
   reg 		   ddr3_read_en;
   reg 		   ddr3_read_en_z;
   reg 		   ddr3_read_en_zz;
   reg 		   ddr3_read_done;
//   reg		   ddr3_read_done_z;
//   reg		   ddr3_write_done_z;
   reg [31:0]      ddr3_read_data;
   reg 		   ddr3_write_en;
   reg 		   ddr3_write_en_z;
   reg 		   ddr3_write_en_zz;
   reg 		   ddr3_write_done;
   reg [31:0]      ddr3_write_data;

   /* DDR3 output registers */
   reg [31:0] 	   dram_addr_reg;
   reg [2:0] 	   dram_cmd_reg;
   reg 		   dram_en_reg;
   reg [287:0] 	   dram_wdf_data_reg;
   reg 		   dram_wdf_end_reg;
   reg 		   dram_wdf_mask_reg;
   reg 		   dram_wdf_wren_reg;

   /* diagnostic LV*/
   /*DDR3 state counters*/
   reg [31:0]  ddr3_s0_ctr_reg;
   reg [31:0]  ddr3_s1_ctr_reg;
   reg [31:0]  ddr3_s2_ctr_reg;
   reg [31:0]  ddr3_s3_ctr_reg;
   reg [31:0]  ddr3_s4_ctr_reg;
   reg [31:0]  ddr3_s5_ctr_reg;
   reg [31:0]  ddr3_s6_ctr_reg;
   reg [31:0]  ddr3_s7_ctr_reg;
   reg [31:0]  ddr3_sx_ctr_reg;
   
   /*OPB state counters*/
   reg [31:0]  opb_s0_ctr_reg;
   reg [31:0]  opb_s1_ctr_reg;
   reg [31:0]  opb_s2_ctr_reg;
   reg [31:0]  opb_s3_ctr_reg;
   reg [31:0]  opb_s4_ctr_reg;
   reg [31:0]  opb_s5_ctr_reg;
   reg [31:0]  opb_sx_ctr_reg;
    
   /* OPB state machine */
   always @ (posedge OPB_Clk) begin
      if (OPB_Rst) begin
      
         opb_ack         <= 1'b0;
         opb_error       <= 1'b0;
         opb_retry       <= 1'b0;
         opb_toutsup     <= 1'b0;
         opb_data_out    <= 32'b0;
         opb_state       <= OPB_IDLE;
         
         ddr3_read_en    <= 1'b0;
         ddr3_write_en   <= 1'b0;
         ddr3_write_data <= 32'b0;
      end else begin // if (OPB_Rst)
      
         opb_ack         <= 1'b0;
         opb_error       <= 1'b0;
         opb_retry       <= 1'b0;
         opb_toutsup     <= 1'b0;
         opb_data_out    <= 32'b0;
   
         case (opb_state)

            OPB_IDLE: begin
               ddr3_read_en  <= 0;
               ddr3_write_en <= 0; 
               /* Default idle/wait state */
               if (OPB_select) begin
                  /* We've been selected by master */
                  if (OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR) begin     
                     /* Address is valid, move on */                    
                     opb_addr     <= OPB_ABus - C_BASEADDR;
                     opb_state    <= OPB_SELECT;                    
                  end // if (OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR)
               end // if (OPB_select)
            end // case: OPB_IDLE
              
            OPB_SELECT: begin
               if (OPB_select) begin
                  if (OPB_RNW) begin
                     /* We're reading, change states */
                     opb_state <= OPB_READ;
                  end else begin // if (OPB_RNW)
                     /* We're writing, change states */
                     opb_state <= OPB_WRITE;
                  end // else: if (OPB_RNW)
      	      end else begin
                  opb_state <= OPB_IDLE;
               end
            end 
              
            OPB_READ: begin
               if (OPB_select) begin
                   /* Start the DDR3 read */
                  
                   opb_toutsup     <= 1'b1;
                   ddr3_read_en    <= 1'b1;
                  
                   if (ddr3_read_done) begin
                      /* Read is done, transfer data */
                      
                      ddr3_read_en <= 1'b0;
                      opb_state    <= OPB_READ_X;
                      opb_data_out <= ddr3_read_data;
                      opb_ack      <= 1'b1;
                   end
               end else begin   /* if it is hanging here and DDR3_idle*/
                  opb_state <= OPB_IDLE;
               end  
            end // case: OPB_READ
    
            OPB_READ_X: begin
               opb_state <= OPB_IDLE;
            end
    
            OPB_WRITE: begin
               if (OPB_select) begin
                  /* Start the DDR3 write */
                  opb_toutsup     <= 1'b1;
                  ddr3_write_en   <= 1'b1;
                  ddr3_write_data <= OPB_DBus;
                 
                  if (ddr3_write_done) begin
                     /* Write is done, finish up */
                     ddr3_write_en <= 1'b0;
                     opb_state     <= OPB_IDLE;
                     opb_ack       <= 1'b1;
                  end // if (ddr3_write_done)
               end else begin
                  opb_state <= OPB_IDLE;
               end
            end
         endcase // case (opb_state)
      end // else: !if(OPB_Rst)
   end // always @ (posedge OPB_Clk)

   assign cpu_state  = opb_state;
   assign Sl_xferAck = opb_ack;
   assign Sl_errAck  = opb_error;
   assign Sl_toutSup = opb_toutsup;
   assign Sl_retry   = opb_retry;
   assign Sl_DBus    = opb_data_out;

   /* DDR3 access state machine */
   always @ (posedge dram_clk) begin
      if (dram_rst) begin
      
         ddr3_read_done    <= 1'b1;
         ddr3_write_done   <= 1'b1;
         ddr3_read_data    <= 32'b0;
         ddr3_state        <= DDR3_IDLE;
         
         dram_addr_reg     <= 32'b0;
         dram_cmd_reg      <= 3'b0;
         dram_en_reg       <= 1'b0;
         dram_wdf_data_reg <= 288'b0;
         dram_wdf_end_reg  <= 1'b0;
         dram_wdf_mask_reg <= 36'b0;
         dram_wdf_wren_reg <= 1'b0;
      end else begin // if (dram_rst)
      
         ddr3_read_done  <= 1'b0;
         ddr3_write_done <= 1'b0;
        
         ddr3_read_en_z    <= ddr3_read_en; //value from opb sm
         ddr3_read_en_zz   <= ddr3_read_en_z; // previous value from dram state machine
      
         ddr3_write_en_z   <= ddr3_write_en;
         ddr3_write_en_zz  <= ddr3_write_en_z;
      
//         ddr3_read_done_z  <= ddr3_read_done;   
//         ddr3_write_done_z <= ddr3_write_done;
      
         case (ddr3_state)
         
            DDR3_IDLE: begin
            
               if (ddr3_read_en_z && !ddr3_read_en_zz) begin // used to compare opb value to previous dram value for posedge, now just dram values
                  /* OPB is requesting a read */
                  ddr3_state <= DDR3_READ_INIT;			
               end else if (ddr3_write_en_z && !ddr3_write_en_zz) begin // if posedge(ddr3_read_en)
                 /* OPB is requesting a write */
                 ddr3_state <= DDR3_WRITE_INIT;
               end // else: if posedge(ddr3_write_en)
      
            end // case: DDR3_IDLE
      
            DDR3_READ_INIT: begin
               /* Issue DDR3 command then wait */
               ddr3_state    <= DDR3_READ_HOLD;
               dram_addr_reg <= opb_addr;
               dram_cmd_reg  <= 3'b001;
               dram_en_reg   <= 1'b1;
            end // case: DDR3_READ_INIT
      
            DDR3_READ_HOLD: begin
               /* Hold addr, cmd, end until dram_rdy */
               if (dram_rdy) begin
                  ddr3_state     <= DDR3_READ_WAIT;
                  dram_addr_reg  <= 32'b0;
                  dram_cmd_reg   <= 3'b0;
                  dram_en_reg    <= 1'b0;
               end // if (dram_rdy)
            end // case: DDR3_READ_HOLD
      
            DDR3_READ_WAIT: begin
               /* Wait for the read response */	      
               if (dram_rd_data_end) begin
                  /* Second cycle, finish up */
                  ddr3_state     <= DDR3_READ_RESP;
               end else if (dram_rd_data_valid) begin // if (dram_rd_data_end)
                  /* First cylce read data is valid, grab it */
                  ddr3_read_data <= dram_rd_data[31:0];
               end // else: if (dram_rd_data_valid)	      
            end // case: DDR3_READ_WAIT
      
            DDR3_READ_RESP: begin
               /* Wait for OPB to grab data */
               ddr3_read_done <= 1'b1;             
               if (!ddr3_read_en_z) begin
                  /* OPB is done, finish up */
                  ddr3_state     <= DDR3_IDLE;
               end // if (!ddr3_read_en)
            end // case: DDR3_READ_RESP
      
         endcase // case (ddr3_state)
      end // else: !if(dram_rst)
   end // always @ (posedge dram_clk)
   
   
   assign dram_state    = ddr3_state;
   assign dram_addr     = dram_addr_reg;
   assign dram_cmd      = dram_cmd_reg;
   assign dram_en       = dram_en_reg;
   assign dram_wdf_data = dram_wdf_data_reg;
   assign dram_wdf_end  = dram_wdf_end_reg;
   assign dram_wdf_mask = dram_wdf_mask_reg;
   assign dram_wdf_wren = dram_wdf_wren_reg;


/* DDR3 diagnostic counter logic*/
   always @ (posedge dram_clk) begin
      if (ddr3_ctr_rst) begin
         ddr3_s0_ctr_reg <= 0;
         ddr3_s1_ctr_reg <= 0;
         ddr3_s2_ctr_reg <= 0;
         ddr3_s3_ctr_reg <= 0;
         ddr3_s4_ctr_reg <= 0;
         ddr3_s5_ctr_reg <= 0;
         ddr3_s6_ctr_reg <= 0;
         ddr3_s7_ctr_reg <= 0;
         ddr3_sx_ctr_reg <= 0;
           
      end else begin
         case (dram_state)

            DDR3_IDLE: begin
               ddr3_s0_ctr_reg <= ddr3_s0_ctr_reg +1;
            end

            DDR3_READ_INIT: begin
               ddr3_s1_ctr_reg <= ddr3_s1_ctr_reg +1;
            end

            DDR3_READ_HOLD: begin
               ddr3_s2_ctr_reg <= ddr3_s2_ctr_reg +1;
            end

            DDR3_READ_WAIT: begin
               ddr3_s3_ctr_reg <= ddr3_s3_ctr_reg +1;
            end

            DDR3_READ_RESP: begin
               ddr3_s4_ctr_reg <= ddr3_s4_ctr_reg +1;
            end

            DDR3_WRITE_INIT: begin
               ddr3_s5_ctr_reg <= ddr3_s5_ctr_reg +1;
            end

            DDR3_WRITE_WAIT: begin
               ddr3_s6_ctr_reg <= ddr3_s6_ctr_reg +1;
            end

            DDR3_WRITE_RESP: begin
               ddr3_s7_ctr_reg <= ddr3_s7_ctr_reg +1;
            end

            default: begin
               ddr3_sx_ctr_reg <= ddr3_sx_ctr_reg +1;
            end

         endcase
      end
   end

   assign ddr3_s0_ctr = ddr3_s0_ctr_reg;
   assign ddr3_s1_ctr = ddr3_s1_ctr_reg;
   assign ddr3_s2_ctr = ddr3_s2_ctr_reg;
   assign ddr3_s3_ctr = ddr3_s3_ctr_reg;
   assign ddr3_s4_ctr = ddr3_s4_ctr_reg;
   assign ddr3_s5_ctr = ddr3_s5_ctr_reg;
   assign ddr3_s6_ctr = ddr3_s6_ctr_reg;
   assign ddr3_s7_ctr = ddr3_s7_ctr_reg;
   assign ddr3_sx_ctr = ddr3_sx_ctr_reg;

/* OPB diagnostic counter logic */
   always @ (posedge OPB_Clk) begin
      if (opb_ctr_rst) begin
         opb_s0_ctr_reg <= 0;
         opb_s1_ctr_reg <= 0;
         opb_s2_ctr_reg <= 0;
         opb_s3_ctr_reg <= 0;
         opb_s4_ctr_reg <= 0;
         opb_s5_ctr_reg <= 0;
         opb_sx_ctr_reg <= 0;
      end else begin
         case (opb_state)

            OPB_IDLE: begin
               opb_s0_ctr_reg <= opb_s0_ctr_reg +1;
            end

            OPB_SELECT: begin
               opb_s1_ctr_reg <= opb_s1_ctr_reg +1;
            end

            OPB_READ: begin
               opb_s2_ctr_reg <= opb_s2_ctr_reg +1;
            end

            OPB_READ_X: begin
               opb_s3_ctr_reg <= opb_s3_ctr_reg +1;
            end

            OPB_WRITE: begin
               opb_s4_ctr_reg <= opb_s4_ctr_reg +1;
            end

            OPB_WRITE_X: begin
               opb_s5_ctr_reg <= opb_s5_ctr_reg +1;
            end

            default: begin
               opb_sx_ctr_reg <= opb_sx_ctr_reg +1;
            end

         endcase
      end
   end

   assign opb_s0_ctr =  opb_s0_ctr_reg;
   assign opb_s1_ctr =  opb_s1_ctr_reg;
   assign opb_s2_ctr =  opb_s2_ctr_reg;
   assign opb_s3_ctr =  opb_s3_ctr_reg;
   assign opb_s4_ctr =  opb_s4_ctr_reg;
   assign opb_s5_ctr =  opb_s5_ctr_reg;
   assign opb_sx_ctr =  opb_sx_ctr_reg;

endmodule
