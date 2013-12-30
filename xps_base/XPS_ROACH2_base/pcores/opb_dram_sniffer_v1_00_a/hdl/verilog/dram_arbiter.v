module dram_arbiter(
    input 	   clk,
    input 	   rst,

    /* Monitor/Control Ports */
    input 	   override_en,
    input 	   override_sel,
    output [3:0]   arbiter_state,
    output         arbiter_conflict,		  

    /* Master Ports: Output to the DDR3 */
    input [287:0]  master_rd_data,
    input 	   master_rd_data_end,
    input 	   master_rd_data_valid,
    input 	   master_rdy,
    input 	   master_wdf_rdy,
    output [31:0]  master_addr,
    output [2:0]   master_cmd,
    output 	   master_en,
    output [287:0] master_wdf_data,
    output 	   master_wdf_end,
    output [35:0]  master_wdf_mask,
    output 	   master_wdf_wren,
    
    /* Slave 0 Ports: FPGA Interface */
    output [287:0] slave0_rd_data,
    output 	   slave0_rd_data_end,
    output 	   slave0_rd_data_valid,
    output 	   slave0_rdy,
    output 	   slave0_wdf_rdy,
    input [31:0]   slave0_addr,
    input [2:0]    slave0_cmd,
    input 	   slave0_en,
    input [287:0]  slave0_wdf_data,
    input 	   slave0_wdf_end,
    input [35:0]   slave0_wdf_mask,
    input 	   slave0_wdf_wren,

    /* Slave 1 Ports: CPU Interface */
    output [287:0] slave1_rd_data,
    output 	   slave1_rd_data_end,
    output 	   slave1_rd_data_valid,
    output 	   slave1_rdy,
    output 	   slave1_wdf_rdy,
    input [31:0]   slave1_addr,
    input [2:0]    slave1_cmd,
    input 	   slave1_en,
    input [287:0]  slave1_wdf_data,
    input 	   slave1_wdf_end,
    input [35:0]   slave1_wdf_mask,
    input 	   slave1_wdf_wren
  );

   /* Slave select states */
   localparam SEL_SLAVE0   = 1'b0;
   localparam SEL_SLAVE1   = 1'b1;

   /* Arbitration states */
   localparam ARB_WAIT     = 4'h0;
   localparam ARB_SLAVE0   = 4'h1;
   localparam ARB_SLAVE1   = 4'h2;
   localparam ARB_OVERRIDE = 4'h3;

   /* Arbitration signals */
   reg             arb_slave_sel;
   reg             arb_expire_en;
   reg             arb_expire_rst;
   reg [6:0]       arb_expire_cnt;
   reg             arb_expired;
   reg             arb_conflict;
   reg [3:0] 	   arb_state;

   /* Master outputs */
   reg [31:0] 	   master_addr_reg;
   reg [2:0] 	   master_cmd_reg;
   reg 		   master_en_reg;
   reg [287:0] 	   master_wdf_data_reg;
   reg 		   master_wdf_end_reg;
   reg [35:0] 	   master_wdf_mask_reg;
   reg 		   master_wdf_wren_reg;

   /* Slave 0 outputs */
   reg [287:0] 	   slave0_rd_data_reg;
   reg 		   slave0_rd_data_end_reg;   
   reg 		   slave0_rd_data_valid_reg;
   reg 		   slave0_rdy_reg;
   reg 		   slave0_wdf_rdy_reg;

   /* Slave 1 outputs */
   reg [287:0] 	   slave1_rd_data_reg;
   reg 		   slave1_rd_data_end_reg;   
   reg 		   slave1_rd_data_valid_reg;
   reg 		   slave1_rdy_reg;
   reg 		   slave1_wdf_rdy_reg;

   /* Slave 0 delayed inputs */
   reg [31:0] 	   slave0_addr_z;
   reg [2:0]	   slave0_cmd_z;
   reg 		   slave0_en_z;
   reg [287:0]	   slave0_wdf_data_z;
   reg  	   slave0_wdf_end_z;
   reg [35:0]	   slave0_wdf_mask_z;
   reg  	   slave0_wdf_wren_z;

   /* Slave 1 delayed inputs */
   reg [31:0] 	   slave1_addr_z;
   reg [2:0]	   slave1_cmd_z;
   reg 		   slave1_en_z;
   reg [287:0]	   slave1_wdf_data_z;
   reg  	   slave1_wdf_end_z;
   reg [35:0]	   slave1_wdf_mask_z;
   reg  	   slave1_wdf_wren_z;


   /* Delay slave inputs for arbitration */
   always @ (posedge clk) begin

      slave0_addr_z      <= slave0_addr;
      slave0_cmd_z 	 <= slave0_cmd;
      slave0_en_z 	 <= slave0_en;
      slave0_wdf_data_z  <= slave0_wdf_data;
      slave0_wdf_end_z 	 <= slave0_wdf_end;
      slave0_wdf_mask_z  <= slave0_wdf_mask;
      slave0_wdf_wren_z  <= slave0_wdf_wren;

      slave1_addr_z 	 <= slave1_addr;
      slave1_cmd_z 	 <= slave1_cmd;
      slave1_en_z 	 <= slave1_en;
      slave1_wdf_data_z  <= slave1_wdf_data;
      slave1_wdf_end_z 	 <= slave1_wdf_end;
      slave1_wdf_mask_z  <= slave1_wdf_mask;
      slave1_wdf_wren_z  <= slave1_wdf_wren;;

   end // always @ (posedge clk)


   /* Expire after 128 clocks */
   always @ (posedge clk) begin

      if (arb_expire_rst) begin

	 arb_expired     <= 1'b0;
	 arb_expire_cnt  <= 7'b0000000;

      end else if (arb_expire_en) begin // if (arb_expire_rst)

	 if (arb_expire_cnt < 7'b1111111) begin
	    arb_expire_cnt <= arb_expire_cnt + 1;
	 end else begin
	    arb_expired <= 1'b1;
	 end

      end // if (arb_expire_en)

   end // always @ (posedge clk)


   /* Slave select mux */
   always @ (*) begin

      if (rst) begin
	 
	 master_addr_reg          <=  32'b0;
	 master_cmd_reg           <=   3'b0;
	 master_en_reg            <=   1'b0;
	 master_wdf_data_reg      <= 288'b0;
	 master_wdf_end_reg       <=   1'b0;
	 master_wdf_mask_reg      <=  36'b0;
	 master_wdf_wren_reg      <=   1'b0;

	 slave0_rd_data_reg       <= 288'b0;
	 slave0_rd_data_end_reg   <=   1'b0;
	 slave0_rd_data_valid_reg <=   1'b0;
	 slave0_rdy_reg           <=   1'b0;
	 slave0_wdf_rdy_reg       <=   1'b0;

	 slave1_rd_data_reg       <= 288'b0;
	 slave1_rd_data_end_reg   <=   1'b0;
	 slave1_rd_data_valid_reg <=   1'b0;
	 slave1_rdy_reg           <=   1'b0;
	 slave1_wdf_rdy_reg       <=   1'b0;

      end else begin // if (rst)

	 case (arb_slave_sel)

	   SEL_SLAVE0: begin

	      master_addr_reg          <= slave0_addr;
	      master_cmd_reg           <= slave0_cmd;
	      master_en_reg            <= slave0_en;
	      master_wdf_data_reg      <= slave0_wdf_data;
	      master_wdf_end_reg       <= slave0_wdf_end;
	      master_wdf_mask_reg      <= slave0_wdf_mask;
	      master_wdf_wren_reg      <= slave0_wdf_wren;

	      slave0_rd_data_reg       <= master_rd_data;
	      slave0_rd_data_end_reg   <= master_rd_data_end;
	      slave0_rd_data_valid_reg <= master_rd_data_valid;
	      slave0_rdy_reg           <= master_rdy;
	      slave0_wdf_rdy_reg       <= master_wdf_rdy;

	      slave1_rd_data_reg       <= 288'b0;
	      slave1_rd_data_end_reg   <=   1'b0;
	      slave1_rd_data_valid_reg <=   1'b0;
	      slave1_rdy_reg           <=   1'b0;
	      slave1_wdf_rdy_reg       <=   1'b0;

	   end // case: SEL_SLAVE0

	   SEL_SLAVE1: begin

	      master_addr_reg          <= slave1_addr;
	      master_cmd_reg           <= slave1_cmd;
	      master_en_reg            <= slave1_en;
	      master_wdf_data_reg      <= slave1_wdf_data;
	      master_wdf_end_reg       <= slave1_wdf_end;
	      master_wdf_mask_reg      <= slave1_wdf_mask;
	      master_wdf_wren_reg      <= slave1_wdf_wren;

	      slave0_rd_data_reg       <= 288'b0;
	      slave0_rd_data_end_reg   <=   1'b0;
	      slave0_rd_data_valid_reg <=   1'b0;
	      slave0_rdy_reg           <=   1'b0;
	      slave0_wdf_rdy_reg       <=   1'b0;

	      slave1_rd_data_reg       <= master_rd_data;
	      slave1_rd_data_end_reg   <= master_rd_data_end;
	      slave1_rd_data_valid_reg <= master_rd_data_valid;
	      slave1_rdy_reg           <= master_rdy;
	      slave1_wdf_rdy_reg       <= master_wdf_rdy;

	   end // case: SEL_SLAVE1

	 endcase // case (arb_slave_sel)

      end // else: !if (rst)

   end // always @ (*)

   
   /* Top level state machine */
   always @ (posedge clk) begin

      /* No software override so we need to arbitrate */

      if (rst) begin

	 arb_expire_en  <=       1'b0;
	 arb_expire_rst <=       1'b1;
	 arb_conflict   <=       1'b0;
	 arb_state      <=   ARB_WAIT;
	 arb_slave_sel  <= SEL_SLAVE0;
	 
      end else begin // if (rst)

	 arb_conflict   <=       1'b0;
	 arb_expire_rst <=       1'b0;

	 case (arb_state)

	   ARB_WAIT: begin

	      /* Wait state defaults to slave 0 */
	      
	      arb_slave_sel <= SEL_SLAVE0;

	      if (override_en) begin

		 /* CPU is overriding the arbiter */

		 arb_state <= ARB_OVERRIDE;

	      end else if (slave0_en) begin // if (override_en)

		 /* Slave 0 takes priority */
		 
		 arb_state <= ARB_SLAVE0;

		 if (slave1_en) begin

		    /* If slave 1 tries to issue a comamand 
		     at the same time as slave 0, then take 
		     note of the conflict */

		    arb_conflict <= 1'b1;

		 end // if (slave1_en)

	      end else if (slave1_en) begin // if (slave0_en)

		 /* Slave 1 is allowed to proceed if 
		  slave 0 is not issuing a command */
		 
		 arb_state <= ARB_SLAVE1;

	      end // else: !if(slave0_en)
	      
	   end // case: ARB_WAIT

	   ARB_OVERRIDE: begin

	      arb_slave_sel <= override_sel;

	      if (!override_en) begin

		 /* CPU no longer forcing override,
		  fallback to waiting */
		 
		 arb_state <= ARB_WAIT;

	      end // if (!override_en)

	   end // case: ARB_OVERRIDE

	   ARB_SLAVE0: begin

	      arb_slave_sel <= SEL_SLAVE0;

	      if (slave1_en) begin

		 /* Slave 1 is trying to issue a command
		  so ignore it and note the conflict */
		 
		 arb_conflict <= 1'b1;

	      end // if (slave1_en)

	      if (!slave0_en && slave0_en_z) begin

		 /* Slave 0 may be done, start the expiration
		  counter to give it time to continue */

		 arb_expire_en  <= 1'b1;
		 arb_expire_rst <= 1'b1;

	      end // if (!slave0_en)

	      if (arb_expired) begin

		 /* It's been 128 clocks since the last time
		  slave0_en was high, go back to waiting */

		 arb_expire_en  <= 1'b0;
		 arb_expire_rst <= 1'b1;
		 arb_state      <= ARB_WAIT;

	      end // if (arb_expired)

	   end // case: ARB_SLAVE0

	   ARB_SLAVE1: begin

	      arb_slave_sel <= SEL_SLAVE1;

	      if (slave0_en) begin

		 /* Slave 0 is issuing a command, switch over */
		 
		 arb_expire_en  <= 1'b0;
		 arb_expire_rst <= 1'b1;
		 arb_state <= ARB_SLAVE0;

	      end // if (slave0_en)

	      if (!slave1_en && slave1_en_z) begin

		 /* Slave 1 may be done, start the expiration
		  counter to give it time to continue */

		 arb_expire_en  <= 1'b1;
		 arb_expire_rst <= 1'b1;

	      end // if (!slave0_en)

	      if (arb_expired) begin

		 /* It's been 128 clocks since the last time
		  slave0_en was high, go back to waiting */

		 arb_expire_en  <= 1'b0;
		 arb_expire_rst <= 1'b1;
		 arb_state      <= ARB_WAIT;

	      end // if (arb_expired)

	   end // case: ARB_SLAVE1
	   
	 endcase // case (arb_state)

      end // else: !if(rst)
      
   end // always @ (posedge clk)

   assign  arbiter_state        = arb_state;

   assign  master_addr          = master_addr_reg;
   assign  master_cmd           = master_cmd_reg;
   assign  master_en            = master_en_reg;
   assign  master_wdf_data      = master_wdf_data_reg;
   assign  master_wdf_end       = master_wdf_end_reg;
   assign  master_wdf_mask      = master_wdf_mask_reg;
   assign  master_wdf_wren      = master_wdf_wren_reg;

   assign  slave0_rd_data       = slave0_rd_data_reg;
   assign  slave0_rd_data_end   = slave0_rd_data_end_reg;   
   assign  slave0_rd_data_valid = slave0_rd_data_valid_reg;
   assign  slave0_rdy           = slave0_rdy_reg;
   assign  slave0_wdf_rdy       = slave0_wdf_rdy_reg;

   assign  slave1_rd_data       = slave1_rd_data_reg;
   assign  slave1_rd_data_end   = slave1_rd_data_end_reg;   
   assign  slave1_rd_data_valid = slave1_rd_data_valid_reg;
   assign  slave1_rdy           = slave1_rdy_reg;
   assign  slave1_wdf_rdy       = slave1_wdf_rdy_reg;

endmodule
