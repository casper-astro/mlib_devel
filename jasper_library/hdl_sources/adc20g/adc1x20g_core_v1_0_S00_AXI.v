
`timescale 1 ns / 1 ps
/*
v2.0 12/15/2014.  Added the two input pairs for XV and YV
*/

	module adc1x20g_core_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		 parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 4,
		parameter WHICH_ADC = 1
	)
	(
		// Users to add ports here

        input wire Q8_CLK1_GTREFCLK_PAD_N_IN,
        input wire Q8_CLK1_GTREFCLK_PAD_P_IN,
        input wire DRP_CLK_IN,
        input wire [7:0] RXN_IN,
        input wire [7:0] RXP_IN,
        output wire [7:0] TXN_OUT,
        output wire [7:0] TXP_OUT,
        output wire TX_USR_CLK,
        output wire RX_USR_CLK,
        output wire TRACK_DATA_OUT,
        output [327:0] dout,
        output FLASH1,
        output FLASH2,
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 1;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 4
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	        end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID)
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          2'h0:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          2'h1:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          2'h2:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          2'h3:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                    end
	        endcase
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	wire [31:0] chan_drp_out_word;
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      reg_data_out <= 0;
	    end 
	  else
	    begin    
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        2'h0   : reg_data_out <= slv_reg0;
	        2'h1   : reg_data_out <= slv_reg1;
//	        2'h2   : reg_data_out <= slv_reg2;
	        2'h2   : reg_data_out <= chan_drp_out_word;
	        2'h3   : reg_data_out <= slv_reg3;
	        default : reg_data_out <= 0;
	      endcase
	    end   
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

// Add user logic here
//Sync all the control registers to the USR_CLOCK
    reg [31:0] slv_reg0_sync;
    reg [31:0] slv_reg1_sync;
//And differentiate the PPM_ENABLE
reg ppm_en_reg;
always @ (posedge RX_USR_CLK) begin
	slv_reg0_sync <= slv_reg0;
	slv_reg1_sync <= slv_reg1;
	ppm_en_reg <= slv_reg0_sync[18];
end
wire ppm_en_pulse = slv_reg0_sync[18] && !ppm_en_reg;

   
    wire RX_MCOMMA_EN = slv_reg0_sync[0];
    wire RX_PCOMMA_EN = slv_reg0_sync[1];
    wire RX_8B10BEN = slv_reg0_sync[2];
    wire TX_8B10BEN = slv_reg0_sync[3];
    wire [2:0] RX_PRBSEL = slv_reg0_sync[6:4];
    wire [2:0] TX_PRBSEL = slv_reg0_sync[9:7];
    wire RX_CHBOND_EN = slv_reg0_sync[10];
    wire PRBSCTR_RESET = slv_reg0_sync[11];
    wire DONT_RESET_ON_DATA_ERROR = slv_reg0_sync[12];
    wire [4:0] TX_PPM_CTRL = slv_reg0_sync[17:13];
    wire INV_TXOUT = slv_reg0_sync[19];
    wire MODULATION_ON = slv_reg0_sync[20];
    wire MODULATION_ALIGN = slv_reg0_sync[21];
    wire [1:0] MOD_SEL = slv_reg0_sync[23:22];
    wire inhibit_output = slv_reg0_sync[24];
    wire RESET = slv_reg0_sync[31];
    wire [19:0] sample_interval = slv_reg1_sync[19:0];
    
//The DRP channel interface.  Sync the control registers and the output data to the DRP_CLK
    wire [15:0] chan_drp_out;
    wire [9:0] chan_drp_rdy;
    reg [31:0] slv_reg2_sync;
    reg [31:0] drp_data_out_sync;
    always @ (posedge DRP_CLK_IN) begin
        slv_reg2_sync <= slv_reg2;
        drp_data_out_sync <= {6'h0, chan_drp_rdy, chan_drp_out};
    end
    wire [8:0] chan_drp_addr = slv_reg2_sync[8:0];
    wire [15:0] chan_drp_datain = slv_reg2_sync[24:9];
    wire chan_drp_enable  = slv_reg2_sync[25];
    wire chan_drp_we = slv_reg2_sync[26];
    wire [3:0] chan_drp_sel  = slv_reg2_sync[30:27];
    assign chan_drp_out_word = drp_data_out_sync;
    
   //Remap the GTH in and out pairs to include only the active ones
   wire [9:0] RXP_remap;
   wire [9:0] RXN_remap;
   wire [9:0] TXP_remap;
   wire [9:0] TXN_remap;
   
   assign RXP_remap[0] = RXP_IN[0];
   assign RXP_remap[1] = RXP_IN[6];
   assign RXP_remap[2] = 0;
   assign RXP_remap[3] = RXP_IN[1];
   assign RXP_remap[4] = RXP_IN[2];
   assign RXP_remap[5] = RXP_IN[3];
   assign RXP_remap[6] = 0;
   assign RXP_remap[7] = RXP_IN[7];
   assign RXP_remap[8] = RXP_IN[4];
   assign RXP_remap[9] = RXP_IN[5];
   
   assign RXN_remap[0] = RXN_IN[0];
   assign RXN_remap[1] = RXN_IN[6];
   assign RXN_remap[2] = 0;
   assign RXN_remap[3] = RXN_IN[1];
   assign RXN_remap[4] = RXN_IN[2];
   assign RXN_remap[5] = RXN_IN[3];
   assign RXN_remap[6] = 0;
   assign RXN_remap[7] = RXN_IN[7];
   assign RXN_remap[8] = RXN_IN[4];
   assign RXN_remap[9] = RXN_IN[5];
   
   assign TXP_OUT[0] = TXP_remap[0];
   assign TXP_OUT[1] = TXP_remap[3];
   assign TXP_OUT[2] = TXP_remap[4];
   assign TXP_OUT[3] = TXP_remap[5];
   assign TXP_OUT[4] = TXP_remap[8];
   assign TXP_OUT[5] = TXP_remap[9];
   assign TXP_OUT[6] = TXP_remap[1];
   assign TXP_OUT[7] = TXP_remap[7];
   
   assign TXN_OUT[0] = TXN_remap[0];
   assign TXN_OUT[1] = TXN_remap[3];
   assign TXN_OUT[2] = TXN_remap[4];
   assign TXN_OUT[3] = TXN_remap[5];
   assign TXN_OUT[4] = TXN_remap[8];
   assign TXN_OUT[5] = TXN_remap[9];
   assign TXN_OUT[6] = TXN_remap[1];
   assign TXN_OUT[7] = TXN_remap[7];
   
    //Instantiate the core
    gtwizard_0_exdes #(.EXAMPLE_SIM_GTRESET_SPEEDUP("FALSE"),.WHICH_ADC(WHICH_ADC))
    the_core(
    .Q8_CLK1_GTREFCLK_PAD_N_IN(Q8_CLK1_GTREFCLK_PAD_N_IN),
    .Q8_CLK1_GTREFCLK_PAD_P_IN(Q8_CLK1_GTREFCLK_PAD_P_IN),
    .DRP_CLK_IN(DRP_CLK_IN),
    .TRACK_DATA_OUT(TRACK_DATA_OUT),
    .DONT_RESET_ON_DATA_ERROR(DONT_RESET_ON_DATA_ERROR),
    .RXN_IN(RXN_remap),
    .RXP_IN(RXP_remap),
    .TXN_OUT(TXN_remap),
    .TXP_OUT(TXP_remap),
    .RX_MCOMMA_EN(RX_MCOMMA_EN),
    .RX_PCOMMA_EN(RX_PCOMMA_EN),
    .RESET(RESET),
    .RX_8B10BEN(RX_8B10BEN),
    .TX_8B10BEN(TX_8B10BEN),
    .INV_TXOUT(INV_TXOUT),
    .TX_PPM_EN(ppm_en_pulse),
    .TX_PPM_CTRL(TX_PPM_CTRL),
    .MODULATION_ON(MODULATION_ON),
    .MODULATION_ALIGN(MODULATION_ALIGN),
    .MOD_SEL(MOD_SEL),

    .RX_PRBSEL(RX_PRBSEL),
    .TX_PRBSEL(TX_PRBSEL),
    .RX_CHBOND_EN(RX_CHBOND_EN),
    .PRBSCTR_RESET(PRBSCTR_RESET),
    .TX_USR_CLK(TX_USR_CLK),
    .RX_USR_CLK(RX_USR_CLK),
    .dout(dout),
    .sample_interval(sample_interval),
    .inhibit_output(inhibit_output),
    .chan_drp_addr(chan_drp_addr),
    .chan_drp_datain(chan_drp_datain),
    .chan_drp_enable(chan_drp_enable),
    .chan_drp_we(chan_drp_we),
    .chan_drp_out(chan_drp_out),
    .chan_drp_sel(chan_drp_sel),
    .chan_drp_rdy(chan_drp_rdy),
    .FLASH1(FLASH1),
    .FLASH2(FLASH2)

    );

	// User logic ends

	endmodule
