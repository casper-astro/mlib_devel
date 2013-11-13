module ctrl_opb_attach #(
    parameter C_BASEADDR     = 0,
    parameter C_HIGHADDR     = 0,
    parameter C_OPB_AWIDTH   = 32,
    parameter C_OPB_DWIDTH   = 32
  ) (
    input 	  OPB_Clk,
    input 	  OPB_Rst,
    output [0:31] Sl_DBus,
    output 	  Sl_errAck,
    output 	  Sl_retry,
    output 	  Sl_toutSup,
    output 	  Sl_xferAck,
    input [0:31]  OPB_ABus,
    input [0:3]   OPB_BE,
    input [0:31]  OPB_DBus,
    input 	  OPB_RNW,
    input 	  OPB_select,
    input 	  OPB_seqAddr,

    output [15:0] software_address_bits,
    output 	  cpu_override_en,
    output 	  cpu_override_sel,
    input [3:0]   mem_dram_state,
    input [3:0]   mem_opb_state,
    input [3:0]   arbiter_state,
    input         arbiter_conflict,
    input 	  phy_ready,
    input [7:0]   max_clks
  );


  /************************** Registers *******************************/

  localparam REG_SOFTADDR = 0;
  /* Stores the software controlled dram address bits.
   * Only a limited amount of memory can be mapped to the DRAM on ROACH
   * which necessitates the use of the MSBs of the DRAM address to be control
   * by an indirect software register
   */
  localparam REG_PHYREADY = 1;
  localparam REG_OVERRIDE = 2;
  localparam REG_ARBSTATE = 3;
  localparam REG_MEMSTATE = 4;
  

  /**************** Control Registers OPB Attachment ******************/
  
  /* OPB Address Decoding */
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;
  wire opb_sel = (OPB_ABus >= C_BASEADDR && OPB_ABus < C_HIGHADDR) && OPB_select;


  /* OPB Registers */
  reg Sl_errAck_reg;
  reg Sl_xferAck_reg;
  reg [15:0] soft_addr_reg;
  reg [2:0] opb_data_sel;
  reg override_en_reg;
  reg override_sel_reg;
  
  /* Continuous Read Logic */
  reg [0:31] Sl_DBus_reg;
  
  /* LV testing */
  reg chip_select;

  always @(posedge OPB_Clk) begin
    Sl_errAck_reg  <= 1'b0;
    Sl_xferAck_reg <= 1'b0;
    chip_select <= 0;
	 Sl_DBus_reg <= 32'b0;
    if (OPB_Rst) begin
      soft_addr_reg    <= 16'b0;
      override_en_reg  <= 1'b0;
      override_sel_reg <= 1'b0;
    end else begin
      if (opb_sel && !Sl_xferAck_reg) begin
        opb_data_sel   <= opb_addr[4:2];
		  chip_select    <= 1;
		  if (chip_select==1) begin
           case (opb_data_sel)  /* convert byte to word addressing */
             REG_SOFTADDR: begin
               Sl_xferAck_reg <= 1'b1;
               if (!OPB_RNW) begin
                 if (OPB_BE[3])
                   soft_addr_reg[7:0]  <= OPB_DBus[24:31];
                 if (OPB_BE[2])
                   soft_addr_reg[15:8] <= OPB_DBus[16:23];
               end else begin
                  Sl_DBus_reg <= {16'h0, soft_addr_reg};
               end
             end
	          REG_PHYREADY: begin
               Sl_xferAck_reg <= 1'b1;
               if (!OPB_RNW) begin
               end else begin
                  Sl_DBus_reg <= {31'h0, phy_ready};
               end
	          end
	          REG_OVERRIDE: begin
   	          Sl_xferAck_reg   <= 1'b1;
                if (!OPB_RNW) begin
                   if (OPB_BE[3]) begin
		      			override_en_reg  <= OPB_DBus[31];
				      	override_sel_reg <= OPB_DBus[24];
	                end
	             end else begin
                   Sl_DBus_reg <= {24'b0, override_en_reg, 6'b0, override_sel_reg};
                end
	          end
	          REG_ARBSTATE: begin
         	    Sl_xferAck_reg   <= 1'b1;
	             if (!OPB_RNW) begin
                end else begin
                  Sl_DBus_reg <= {24'b0, arbiter_conflict, 3'b0, arbiter_state};
                end
             end
         	 REG_MEMSTATE: begin
	             Sl_xferAck_reg   <= 1'b1;
         	    if (!OPB_RNW) begin
                end else begin
                   Sl_DBus_reg <= {16'b0,max_clks, mem_opb_state, mem_dram_state};
                end
             end
             default: begin           
                Sl_DBus_reg <= 32'h0;
             end
           endcase
			end // if chip select
      end
    end
  end



  /* OPB output assignments */
  assign Sl_retry    = 1'b0;
  assign Sl_toutSup  = 1'b0;
  assign Sl_errAck   = Sl_errAck_reg;
  assign Sl_xferAck  = Sl_xferAck_reg;
  assign Sl_DBus     = Sl_DBus_reg;

  /* Software-controlled Outputs */
  assign software_address_bits = soft_addr_reg;
  assign cpu_override_en       = override_en_reg;
  assign cpu_override_sel      = override_sel_reg;

endmodule
