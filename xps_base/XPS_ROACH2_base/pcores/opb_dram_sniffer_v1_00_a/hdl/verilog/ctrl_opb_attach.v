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

    output [31:0] software_address_bits,
    output 	  cpu_override_en,
    output 	  cpu_override_sel,
    input [3:0]   mem_dram_state,
    input [3:0]   mem_opb_state,
    input [3:0]   arbiter_state,
    input         arbiter_conflict,
    input 	  phy_ready,
   /*DDR3 state counters*/
    input [31:0]  ddr3_s0_ctr,
    input [31:0]  ddr3_s1_ctr,
    input [31:0]  ddr3_s2_ctr,
    input [31:0]  ddr3_s3_ctr,
    input [31:0]  ddr3_s4_ctr,
    input [31:0]  ddr3_s5_ctr,
    input [31:0]  ddr3_s6_ctr,
    input [31:0]  ddr3_s7_ctr,
    input [31:0]  ddr3_sx_ctr,
   
    /*OPB state counters*/
    input [31:0]  opb_s0_ctr,
    input [31:0]  opb_s1_ctr,
    input [31:0]  opb_s2_ctr,
    input [31:0]  opb_s3_ctr,
    input [31:0]  opb_s4_ctr,
    input [31:0]  opb_s5_ctr,
    input [31:0]  opb_sx_ctr,

    input [0:31]  ctrl_opb_addr_lil,
    input [31:0]  ctrl_opb_addr_big,
    
    /* counter resets */
    output       opb_ctr_rst,
    output       ddr3_ctr_rst
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

  localparam REG_DDR3_S0  = 5;
  localparam REG_DDR3_S1  = 6;
  localparam REG_DDR3_S2  = 7;
  localparam REG_DDR3_S3  = 8;
  localparam REG_DDR3_S4  = 9;
  localparam REG_DDR3_S5  = 10;
  localparam REG_DDR3_S6  = 11;
  localparam REG_DDR3_S7  = 12;
  localparam REG_DDR3_SX  = 13;

  localparam REG_OPB_S0  = 14;
  localparam REG_OPB_S1  = 15;
  localparam REG_OPB_S2  = 16;
  localparam REG_OPB_S3  = 17;
  localparam REG_OPB_S4  = 18;
  localparam REG_OPB_S5  = 19;
  localparam REG_OPB_SX  = 20;

  localparam REG_OPB_CTR_RST  = 21;
  localparam REG_DDR3_CTR_RST = 22;

  localparam REG_OPB_ADDR_LIL = 23;
  localparam REG_OPB_ADDR_BIG = 24;

  /**************** Control Registers OPB Attachment ******************/
  
  /* OPB Address Decoding */
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;
  wire opb_sel = (OPB_ABus >= C_BASEADDR && OPB_ABus < C_HIGHADDR) && OPB_select;


  /* OPB Registers */
  reg Sl_errAck_reg;
  reg Sl_xferAck_reg;
  reg [31:0] soft_addr_reg;
  reg [7:0] opb_data_sel;
  reg override_en_reg;
  reg override_sel_reg;
  
  /* Continuous Read Logic */
  reg [0:31] Sl_DBus_reg;
  
  /* LV testing */
  reg chip_select;
  reg opb_ctr_rst_reg;
  reg ddr3_ctr_rst_reg;


  always @(posedge OPB_Clk) begin
    Sl_errAck_reg  <= 1'b0;
    Sl_xferAck_reg <= 1'b0;
    chip_select <= 0;
	 Sl_DBus_reg <= 32'b0;
    if (OPB_Rst) begin
      soft_addr_reg    <= 31'b0;
      override_en_reg  <= 1'b0;
      override_sel_reg <= 1'b0;
    end else begin
      if (opb_sel && !Sl_xferAck_reg) begin
        opb_data_sel   <= opb_addr[9:2];
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
                     if (OPB_BE[1])
                        soft_addr_reg[23:16]  <= OPB_DBus[8:15];
                     if (OPB_BE[0])
                        soft_addr_reg[31:24] <= OPB_DBus[0:7];
                  end else begin
                     Sl_DBus_reg <= {soft_addr_reg};
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
                    Sl_DBus_reg <= {24'b0, mem_opb_state, mem_dram_state};
                 end
              end

              REG_DDR3_S0: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s0_ctr};
                 end
              end

              REG_DDR3_S1: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s1_ctr};
                 end
              end

              REG_DDR3_S2: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s2_ctr};
                 end
              end

              REG_DDR3_S3: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s3_ctr};
                 end
              end

              REG_DDR3_S4: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s4_ctr};
                 end
              end

              REG_DDR3_S5: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s5_ctr};
                 end
              end

              REG_DDR3_S6: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s6_ctr};
                 end
              end

              REG_DDR3_S7: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_s7_ctr};
                 end
              end

              REG_DDR3_SX: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {ddr3_sx_ctr};
                 end
              end

              REG_OPB_S0: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {opb_s0_ctr};
                 end
              end

              default: begin           
                 Sl_DBus_reg <= 32'h0;
              end
           
              REG_OPB_S1: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {opb_s1_ctr};
                 end
              end

              REG_OPB_S2: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {opb_s2_ctr};
                 end
              end

              REG_OPB_S3: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {opb_s3_ctr};
                 end
              end

              REG_OPB_S4: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {opb_s4_ctr};
                 end
              end

              REG_OPB_S5: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {opb_s5_ctr};
                 end
              end

              REG_OPB_SX: begin
                 Sl_xferAck_reg   <= 1'b1;
                 if (!OPB_RNW) begin
                 end else begin
                    Sl_DBus_reg <= {opb_sx_ctr};
                 end
              end

              REG_DDR3_CTR_RST: begin
   	          Sl_xferAck_reg   <= 1'b1;
                  if (!OPB_RNW) begin
                     if (OPB_BE[3]) begin
		     	ddr3_ctr_rst_reg  <= OPB_DBus[31];
	             end
	          end else begin
                     Sl_DBus_reg <= {31'b0, ddr3_ctr_rst_reg};
                  end
	      end
	      
              REG_OPB_CTR_RST: begin
   	          Sl_xferAck_reg   <= 1'b1;
                  if (!OPB_RNW) begin
                     if (OPB_BE[3]) begin
		     	opb_ctr_rst_reg  <= OPB_DBus[31];
	             end
	          end else begin
                     Sl_DBus_reg <= {31'b0, opb_ctr_rst_reg};
                  end
	      end
	      
              REG_OPB_ADDR_LIL: begin
   	          Sl_xferAck_reg   <= 1'b1;
                  if (!OPB_RNW) begin
	          end else begin
                     Sl_DBus_reg <= {ctrl_opb_addr_lil};
                  end
	      end
	      
              REG_OPB_ADDR_BIG: begin
   	          Sl_xferAck_reg   <= 1'b1;
                  if (!OPB_RNW) begin
	          end else begin
                     Sl_DBus_reg <= {ctrl_opb_addr_big};
                  end
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

  assign ddr3_ctr_rst = ddr3_ctr_rst_reg;
  assign opb_ctr_rst  = opb_ctr_rst_reg;

endmodule
