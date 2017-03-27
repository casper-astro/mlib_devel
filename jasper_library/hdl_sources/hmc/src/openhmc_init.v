module openhmc_init #(
      //Define width of the register file
    parameter HMC_RF_WWIDTH         = 64,
    parameter HMC_RF_RWIDTH         = 64,
    parameter HMC_RF_AWIDTH         = 5
    
  )  (
    input wire clk_hmc,
    input wire res_n_hmc,    
    input wire HMC_IIC_INIT_DONE,
    output wire OPEN_HMC_INIT_DONE,
    //----------------------------------
    //----Connect RF
    //----------------------------------
    output  wire  [HMC_RF_AWIDTH-1:0]    rf_address,
    input   wire  [HMC_RF_RWIDTH-1:0]    rf_read_data,
    input   wire                         rf_invalid_address,
    input   wire                         rf_access_complete,
    output  wire                         rf_read_en,
    output  wire                         rf_write_en,
    output  wire  [HMC_RF_WWIDTH-1:0]    rf_write_data
  );

  reg [7:0] hmc_init_state;
  
  //Debug OpenHMC Registers
  (* mark_debug = "true" *) wire [7:0] dbg_hmc_init_state; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [HMC_RF_AWIDTH-1:0] dbg_rf_address; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [HMC_RF_RWIDTH-1:0] dbg_rf_read_data; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_rf_invalid_address; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_rf_access_complete; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_rf_read_en; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_rf_write_en; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [HMC_RF_WWIDTH-1:0] dbg_rf_write_data; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire [HMC_RF_AWIDTH-1:0] dbg_read_rf_addr; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_rf_read_data_lsb; //Virtual test probe for the logic analyser
  (* mark_debug = "true" *) wire dbg_open_hmc_init_done_i; //Virtual test probe for the logic analyser  
  
  assign dbg_hmc_init_state = hmc_init_state;
  assign dbg_rf_address = rf_address_i;
  assign dbg_rf_read_data = rf_read_data;
  assign dbg_rf_invalid_address = rf_invalid_address;
  assign dbg_rf_access_complete = rf_access_complete; 
  assign dbg_rf_read_en = rf_read_en_i;  
  assign dbg_rf_write_en = rf_write_en_i;  
  assign dbg_rf_write_data = rf_write_data_i; 
  assign dbg_read_rf_addr = read_rf_addr;
  assign dbg_rf_read_data_lsb = rf_read_data[0];
  assign dbg_open_hmc_init_done_i = open_hmc_init_done_i;
  

  // State machine states
  localparam STATE_IDLE = 8'h00;
  localparam WAIT_RF_ACCESS_COMPLETE = 8'h01;
  localparam WAIT_FOR_HMC_IIC_INIT_DONE = 8'h02;  
  localparam HMC_INIT_CONT_SET = 8'h03; 
  localparam WAIT_RF_ACCESS_COMPLETE1 = 8'h04;
  localparam READ_HMC_INIT_REG = 8'h05; 
  localparam WAIT_RF_ACCESS_COMPLETE2 = 8'h06;
  localparam POLL_AGAIN_HMC_INIT_REG = 8'h07;
  localparam READ_HMC_STATUS_REG = 8'h08; 
  localparam WAIT_RF_ACCESS_COMPLETE3 = 8'h09;
  localparam POLL_AGAIN_HMC_STATUS_REG = 8'h0a;
  localparam OPEN_HMC_INIT_COMPLETED = 8'h0b;



// Address    Register                   Description                                            
// 0x0        status_general             General HMC Controller Status                           
// 0x1        status_init                Debug register for initialization                        
// 0x2        control                    Control register                    
// 0x3        sent_p                     Number of posted requests issued                   
// 0x4        sent_np                    Number of non-posted requests issued                    
// 0x5        sent_r                     Number of read requests issued                   
// 0x6        poisoned_packets           Number of poisoned packets received                             
// 0x7        rcvd_rsp                   Number of responses received                     
// 0x8        counter_reset              Reset all counter                          
// 0x9        tx_link_retries            Number of Link retries performed on TX                            
// 0xA        errors_on_rx               Number of errors seen on RX                         
// 0xB        run_length_bit_flip        Number of bit flips performed due to run length limitation                                
// 0xC        error_abort_not_cleared    Number of error_abort_mode not cleared                                    


  // OpenHMC registers via RF (Register File) Interface
  localparam CONTROL_REG_ADDR = 5'h2;
                                          // [63:54],[53:48],[47:45],[44:40],[39:37],[36:32],[31:24],[23:16],[15:11],[10],[9] ,[8] ,[7:5] ,[4] ,[3] ,[2] ,[1] ,[0]
  localparam RELEASE_HMC_P_RST_N_REG_DATA = {10'd0  ,6'h00  ,3'd0   ,5'h18  ,3'd0   ,5'h10  ,8'd0   ,8'hff ,5'd0   ,1'b0,1'b0,1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,1'b1}; // 8'h13 : [1] = 1 => Allow descrablers to lock, [0] = 1 => p_rst_n = 1 
  localparam HMC_INIT_CONT_SET_DATA       = {10'd0  ,6'h00  ,3'd0   ,5'h18  ,3'd0   ,5'h10  ,8'd0   ,8'hff ,5'd0   ,1'b0,1'b0,1'b0,3'b000,1'b1,1'b0,1'b0,1'b1,1'b1}; // 8'h13 : [1] = 1 => Allow descrablers to lock = hmc_init_cont_set, [0] = 1 => p_rst_n = 1 
//                                                                                                   Juri Advised setting tokens to 255 [25:16]
//  localparam RELEASE_HMC_P_RST_N_REG_DATA = {10'd0  ,6'h3f  ,3'd0   ,5'h16  ,3'd0   ,5'h10  ,6'd0   ,10'h64 ,5'd0   ,1'b0,1'b0,1'b0,3'b000,1'b1,1'b0,1'b0,1'b0,1'b1}; // 8'h13 : [1] = 1 => Allow descrablers to lock, [0] = 1 => p_rst_n = 1 
//  localparam HMC_INIT_CONT_SET_DATA       = {10'd0  ,6'h3f  ,3'd0   ,5'h16  ,3'd0   ,5'h10  ,6'd0   ,10'h64 ,5'd0   ,1'b0,1'b0,1'b0,3'b000,1'b1,1'b0,1'b0,1'b1,1'b1}; // 8'h13 : [1] = 1 => Allow descrablers to lock = hmc_init_cont_set, [0] = 1 => p_rst_n = 1 

  //localparam RELEASE_HMC_P_RST_N_REG_DATA = {10'd0  ,6'h30  ,3'd0   ,5'd30  ,3'd0   ,5'h0e  ,6'd0   ,10'h3ff ,5'd0   ,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0,1'b0,1'b1}; // 8'h13 : [1] = 1 => Allow descrablers to lock, [0] = 1 => p_rst_n = 1 
  //localparam HMC_INIT_CONT_SET_DATA       = {10'd0  ,6'h30  ,3'd0   ,5'd30  ,3'd0   ,5'h0e  ,6'd0   ,10'h3ff ,5'd0   ,1'b0,1'b0,1'b0,3'b000,1'b0,1'b0,1'b0,1'b1,1'b1}; // 8'h13 : [1] = 1 => Allow descrablers to lock = hmc_init_cont_set, [0] = 1 => p_rst_n = 1 

  localparam STATUS_INIT_ADDR = 5'h1;
  localparam STATUS_GENERAL_ADDR = 5'h0;
  
  reg open_hmc_init_done_i;
  assign OPEN_HMC_INIT_DONE = open_hmc_init_done_i;
  
  reg rf_read_en_i;
  assign rf_read_en = rf_read_en_i;
  reg rf_write_en_i;
  assign rf_write_en = rf_write_en_i;
  reg [4:0] rf_address_i;
  assign rf_address = rf_address_i;
  reg [63:0] rf_write_data_i;
  assign rf_write_data = rf_write_data_i;  

  reg[4:0] read_rf_addr;

  always @(posedge clk_hmc) begin

  if (res_n_hmc==1'b0) begin
    hmc_init_state <= STATE_IDLE;
    open_hmc_init_done_i <= 1'b0;
    rf_read_en_i <= 1'b0;
    rf_write_en_i <= 1'b0;
    rf_address_i <= 5'd0; 
    rf_write_data_i <= 64'd0;
    read_rf_addr <= 5'd0;
  end else begin

      // defaults
      rf_read_en_i <= 1'b0;
      rf_write_en_i <= 1'b0;

      case (hmc_init_state)
        // Release HMC reset and start init!
        STATE_IDLE: begin
          rf_address_i <= CONTROL_REG_ADDR; 
          rf_write_data_i <= RELEASE_HMC_P_RST_N_REG_DATA; 
          rf_write_en_i <= 1'b1; 
          rf_read_en_i <= 1'b0; 
          hmc_init_state <= WAIT_FOR_HMC_IIC_INIT_DONE;
        end
        WAIT_RF_ACCESS_COMPLETE: begin
          if (rf_access_complete == 1'b1) begin
            hmc_init_state <= WAIT_FOR_HMC_IIC_INIT_DONE;     
          end       
        end     
        // Wait for HMC IIC Init to complete   
        WAIT_FOR_HMC_IIC_INIT_DONE: begin  
          if (HMC_IIC_INIT_DONE == 1'b1) begin
            hmc_init_state <= HMC_INIT_CONT_SET;     
          end  
        end
        // Start OpenHMC init ie Set hmc_init_cont_set = 1 in OpenHMC Control Reg (0x2) to allow descrablers to lock 
        HMC_INIT_CONT_SET: begin 
          rf_address_i <= CONTROL_REG_ADDR; 
          rf_write_data_i <= HMC_INIT_CONT_SET_DATA; 
          rf_write_en_i <= 1'b1; 
          rf_read_en_i <= 1'b0;
          hmc_init_state <= WAIT_RF_ACCESS_COMPLETE1;
        end
        WAIT_RF_ACCESS_COMPLETE1: begin
          if (rf_access_complete == 1'b1) begin
            hmc_init_state <= READ_HMC_INIT_REG;  
          end       
        end 
        // Poll the OpenHMC Status Init Reg to see if all the lanes are descrabled locked and aligned
        READ_HMC_INIT_REG: begin 
          rf_address_i <= read_rf_addr;//STATUS_INIT_ADDR; 
          rf_read_en_i <= 1'b1;
          hmc_init_state <= WAIT_RF_ACCESS_COMPLETE3;
          if (read_rf_addr == 5'h16) begin
            read_rf_addr <= 5'h0;
          end else if (read_rf_addr == 5'h7) begin
            read_rf_addr <= 5'h9;
          end else begin
            read_rf_addr <= read_rf_addr + 1'b1;
          end
        end
        // Read the OpenHMC Status Init Reg to see if all the lanes are descrabled locked and aligned
        WAIT_RF_ACCESS_COMPLETE2: begin
          if (rf_access_complete == 1'b1) begin  
            hmc_init_state <= READ_HMC_STATUS_REG;          
//            // Check to see that [7:0]   = 0xff => Lane by lane descrambler locked
//            //                   [48] = 1 => All descrablers are aligned! 
//            if ((rf_read_data[7:0] == 8'hff) && (rf_read_data[48] == 1'b1)) begin
//              hmc_init_state <= READ_HMC_STATUS_REG;
//            end else begin
//              hmc_init_state <= POLL_AGAIN_HMC_INIT_REG;  
//            end
          end       
        end 
        // OpenHMC still busy with init -> Poll Again
        POLL_AGAIN_HMC_INIT_REG: begin
          hmc_init_state <= READ_HMC_INIT_REG;   
        end 

        // Poll the OpenHMC Status Init Reg to see if all the lanes are descrabled locked and aligned
        READ_HMC_STATUS_REG: begin 
          rf_address_i <= STATUS_GENERAL_ADDR; 
          rf_read_en_i <= 1'b1;
          hmc_init_state <= WAIT_RF_ACCESS_COMPLETE3;
        end
        // Read the OpenHMC Status Init Reg to see if all the lanes are descrabled locked and aligned
        WAIT_RF_ACCESS_COMPLETE3: begin
          if (rf_access_complete == 1'b1) begin 
            hmc_init_state <= READ_HMC_INIT_REG;            
            // Check to see that [0] = 1 => Link is ready for operation
            //read_rf_addr is one ahead of where it is mean't to be and the actual read_rf_addr = 0 when
            //reading 
            if (rf_read_data[0] == 1'b1 && read_rf_addr == 5'h1) begin
              hmc_init_state <= OPEN_HMC_INIT_COMPLETED;
            end else begin
              hmc_init_state <= READ_HMC_INIT_REG;//POLL_AGAIN_HMC_STATUS_REG;  
            end
          end       
        end 
        // OpenHMC not ready yet -> Poll Again
        POLL_AGAIN_HMC_STATUS_REG: begin
          hmc_init_state <= READ_HMC_STATUS_REG;   
        end 

        // OpenHMC has initialized and all the lanes are locked and aligned
        // OpenHMC are ready to receive FLITS!
        OPEN_HMC_INIT_COMPLETED: begin
          open_hmc_init_done_i <= 1'b1;  
          hmc_init_state <= POLL_AGAIN_HMC_INIT_REG; 
        end  
      endcase
    end
  end

endmodule