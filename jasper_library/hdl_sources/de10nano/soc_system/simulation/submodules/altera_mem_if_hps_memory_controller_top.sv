// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1ps / 1ps

module altera_mem_if_hps_memory_controller_top #(
    parameter

        //==========================================================================================
        // MMR parameters
        //==========================================================================================

        CFG_CFG_AVALON_DATA_BYTES   = 'd4,
        CFG_CFG_AVALON_ADDR_WIDTH   = 'd8, // must match standard mmr interface for other sim models

        //==========================================================================================
        // MPFE parameters
        //==========================================================================================

        CFG_PORT_WIDTH_WIDTH        = 2,
        MAX_CMD_PT_NUM              = 10,
        MAX_FIFO_NUM                = 6,
        MAX_FABRIC_CMD_PT_NUM       = 6,
        MAX_FABRIC_FIFO_NUM         = 4,
        CMD_FIFO_DEPTH              = 4,
        CMD_ASYNC_FIFO_DEPTH         = CMD_FIFO_DEPTH,  
        CMD_SYNC_FIFO_DEPTH          = CMD_FIFO_DEPTH,
        RD_FIFO_DEPTH               = 8,
        RD_ASYNC_FIFO_DEPTH         = RD_FIFO_DEPTH,   
        RD_SYNC_FIFO_DEPTH          = RD_FIFO_DEPTH,
        RD_FIFO_WIDTH               = 80,
        WR_FIFO_DEPTH               = 8,
        WR_ASYNC_FIFO_DEPTH         = WR_FIFO_DEPTH, 
        WR_SYNC_FIFO_DEPTH          = WR_FIFO_DEPTH,
        WR_FIFO_WIDTH               = 90,
        WR_FIFO_L2_WIDTH            = 73,
        WR_FIFO_L3_WIDTH            = 37,
        WR_CTRL_WIDTH               = 90,
        RD_BUF_DEPTH                = 32,
        RD_BUF_WIDTH                = 80,
        MAX_MEM_BL                  = 8,
        MAX_PORT_BL                 = 255,
        MAX_CTRL_DWIDTH             = 64,
        MAX_FIFO_DWIDTH             = 64,
        MAX_CFG_PRI_WIDTH           = 3,
        MAX_ST_WT_WIDTH             = 5,
        MAX_CTRL_CMD_WIDTH          = 2,
        MAX_CTRL_PRI_WIDTH          = 1,
        MAX_CTRL_ADDR_WIDTH         = 32,
        MAX_CTRL_BL_WIDTH           = 3,    //Maximum burst length supported by DRAM standards
        MAX_CTRL_ID_WIDTH           = 10,    //log2(MAX_CMD_PT_NUM) + RD_BUF_ADDR_SIZE
        MAX_CTRL_CMDE_WIDTH         = 0,
        MAX_MERGE_COUNT_WIDTH       = 3,
        MAX_PORT_CMD_WIDTH          = 2,
        MAX_PORT_PRI_WIDTH          = 0,
        MAX_PORT_ADDR_WIDTH         = 32,
        MAX_PORT_BL_WIDTH           = 8,   //Maximum burst length supported by Avalon MM //log2(MAX_PORT_BL)+1
        MAX_PORT_TID_WIDTH          = 0,
        MAX_PORT_CMDE_WIDTH         = 0,
        MAX_CYC_TO_RLD_JARS         = 256,

        //==========================================================================================
        // CMD path parameters
        //==========================================================================================

        CMD_FIFO_DWIDTH             = (MAX_PORT_CMDE_WIDTH + MAX_PORT_TID_WIDTH + MAX_PORT_BL_WIDTH + MAX_PORT_ADDR_WIDTH + MAX_PORT_PRI_WIDTH + MAX_PORT_CMD_WIDTH),
        MAX_PORT_WIDTH              = MAX_FIFO_NUM*MAX_FIFO_DWIDTH,  // CC: 256
        MAX_CTRL_CMD_PORT_DWIDTH    = (MAX_CTRL_CMDE_WIDTH + MAX_MERGE_COUNT_WIDTH + MAX_CTRL_ID_WIDTH + MAX_CTRL_BL_WIDTH + MAX_CTRL_ADDR_WIDTH + MAX_CTRL_PRI_WIDTH + MAX_CTRL_CMD_WIDTH),


        RD_BUF_ADDR_SIZE            = (log2(RD_BUF_DEPTH)+1),     // CC: 6
        MAX_16_BIT_ENTRIES          = log2(MAX_FIFO_NUM * WR_FIFO_DEPTH * MAX_FIFO_DWIDTH /16+1),
        MAX_SUM_PRI_WT_WIDTH        = (MAX_CFG_PRI_WIDTH + MAX_ST_WT_WIDTH),
        MAX_DY_WT_WIDTH             = MAX_ST_WT_WIDTH + log2(MAX_CMD_PT_NUM) + 2,
        MAX_PT_WT_WIDTH             = MAX_CFG_PRI_WIDTH + MAX_DY_WT_WIDTH,


        //==========================================================================================
        // AXI parameters
        //==========================================================================================
        //Command port
        MAX_PROT_RULE_NUM = 20,
        MAX_AXI_PORT_CMD_WIDTH      = 2,
      	MAX_AXI_PORT_PRI_WIDTH      = 1,
    	MAX_AXI_PORT_ADDR_WIDTH     = 32,
    	MAX_AXI_PORT_BL_WIDTH       = 8,
    	MAX_AXI_PORT_BL_WIDTH_PLUS1 = MAX_AXI_PORT_BL_WIDTH+1,
    	MAX_AXI_PORT_TID_WIDTH      = 12,
   	MAX_AXI_PORT_F_TID_WIDTH    = 8,
    	MAX_AXI_PORT_L2_TID_WIDTH   = 8,
    	MAX_AXI_PORT_L3_TID_WIDTH   = MAX_AXI_PORT_TID_WIDTH,
        MAX_AXI_PORT_BSIZE_WIDTH    = 3,
        MAX_AXI_PORT_BURST_WIDTH    = 2,
        MAX_AXI_PORT_LOCK_WIDTH     = 2,
        MAX_AXI_PORT_PROT_WIDTH     = 2,
    	AXI_CMD_PORT_DWIDTH         = (MAX_AXI_PORT_CMD_WIDTH + MAX_AXI_PORT_PRI_WIDTH + MAX_AXI_PORT_ADDR_WIDTH + MAX_AXI_PORT_BL_WIDTH + MAX_AXI_PORT_TID_WIDTH + MAX_AXI_PORT_BSIZE_WIDTH + MAX_AXI_PORT_BURST_WIDTH + MAX_AXI_PORT_LOCK_WIDTH + MAX_AXI_PORT_PROT_WIDTH),
    	AXI_CMD_PORT_F_DWIDTH      = (MAX_AXI_PORT_CMD_WIDTH + MAX_AXI_PORT_PRI_WIDTH + MAX_AXI_PORT_ADDR_WIDTH + MAX_AXI_PORT_BL_WIDTH + MAX_AXI_PORT_F_TID_WIDTH + MAX_AXI_PORT_BSIZE_WIDTH + MAX_AXI_PORT_BURST_WIDTH + MAX_AXI_PORT_LOCK_WIDTH + MAX_AXI_PORT_PROT_WIDTH),
    	AXI_CMD_PORT_L2_DWIDTH      = (MAX_AXI_PORT_CMD_WIDTH + MAX_AXI_PORT_PRI_WIDTH + MAX_AXI_PORT_ADDR_WIDTH + MAX_AXI_PORT_BL_WIDTH + MAX_AXI_PORT_L2_TID_WIDTH + MAX_AXI_PORT_BSIZE_WIDTH + MAX_AXI_PORT_BURST_WIDTH + MAX_AXI_PORT_LOCK_WIDTH + MAX_AXI_PORT_PROT_WIDTH),
    	AXI_CMD_PORT_L3_DWIDTH      = (MAX_AXI_PORT_CMD_WIDTH + MAX_AXI_PORT_PRI_WIDTH + MAX_AXI_PORT_ADDR_WIDTH + MAX_AXI_PORT_BL_WIDTH + MAX_AXI_PORT_L3_TID_WIDTH + MAX_AXI_PORT_BSIZE_WIDTH + MAX_AXI_PORT_BURST_WIDTH + MAX_AXI_PORT_LOCK_WIDTH + MAX_AXI_PORT_PROT_WIDTH),
        AXI_CMD_FIFO_DWIDTH         = MAX_PORT_CMD_WIDTH+MAX_AXI_PORT_ADDR_WIDTH+MAX_AXI_PORT_BL_WIDTH_PLUS1*2+MAX_AXI_PORT_TID_WIDTH+MAX_AXI_PORT_BSIZE_WIDTH+MAX_AXI_PORT_BURST_WIDTH+2+MAX_AXI_PORT_PROT_WIDTH+MAX_AXI_PORT_PRI_WIDTH,

    	//Command bus format:
    	//Compile time constant: MAX_PORT_CMD_WIDTH (2)
    	//Bit [0]     : ARVALID
        //              -tied to a 1 for AXI read ports (else zero)
    	//Bit [1]     : AWVALID
        //              -tied to a 1 for AXI write ports (else zero)
    	//Compile time constant: MAX_PORT_PRI_WIDTH (1)
    	//Bit [2]     : priority
    	// Compile time constant: MAX_AXI_PORT_ADDR_WIDTH (32)
    	//Bit [34:3]  : AWADDR/ARADDR
        //              -AXI address
    	//compile time constant: MAX_AXI_PORT_BL_WIDTH (8)
    	//Bit [42:35] : AWLEN/ARLEN (padded 0s in MSBs)
        //              -burst length
    	//compile time constant: MAX_AXI_PORT_TID_WIDTH (4)
    	//Bit [46:43] : AWID/ARID 
        //              -transaction ID
    	//compile time constant: MAX_AXI_PORT_BSIZE_WIDTH (3)
    	//Bit [49:47] : AWSIZE/ARSIZE 
        //              -burst size
    	//compile time constant: MAX_AXI_PORT_BURST_WIDTH (2)
    	//Bit [51:50] : AWSIZE/ARSIZE 
        //              -burst type
    	//compile time constant: MAX_AXI_PORT_LOCK_WIDTH (2)
    	//Bit [53:52] : AWLOCK/ARLOCK 
        //              -lock type
    	//Bit [55:54] : AWPROT/ARPROT 
        //              -protection type
    	//Note AWCACHE currently n/c



        //Write data port
        MAX_AXI_PORT_WDATA_WIDTH    = MAX_FIFO_DWIDTH,
        MAX_AXI_PORT_WSTRB_WIDTH    = MAX_FIFO_DWIDTH/8,
        MAX_AXI_PORT_LAST_WIDTH     = 1,
    	AXI_WR_PORT_WIDTH           = (MAX_AXI_PORT_LAST_WIDTH + MAX_AXI_PORT_WSTRB_WIDTH + MAX_AXI_PORT_WDATA_WIDTH), 

        MAX_AXI_PORT_L3_WDATA_WIDTH = 32,
        MAX_AXI_PORT_L3_WSTRB_WIDTH = MAX_AXI_PORT_L3_WDATA_WIDTH/8,

    	//Write data FORMAT:
    	//Compile time constant: MAX_AXI_PORT_WDATA_WIDTH (64)
    	//Bit [63:0]  : WDATA
        //              -write data
    	//Compile time constant: MAX_AXI_PORT_WSTRB_WIDTH (8)
    	//Bit [71:64] : WSTRB
        //              -write strobes
    	//compile time constant: MAX_AXI_PORT_LAST_WIDTH (1)
    	//Bit [72]    : WLAST
        //             -last cycle transfer for the burst

    	//Note WID is temporarily n/c. we get the TID from write cmd bus. There is a chance to add these bits back for a place holder.


        //Write ack port
        MAX_AXI_PORT_BRESP_WIDTH    = 2,
    	AXI_WACK_PORT_DWIDTH        = (MAX_AXI_PORT_TID_WIDTH + MAX_AXI_PORT_BRESP_WIDTH),
    	AXI_WACK_PORT_F_DWIDTH      = (MAX_AXI_PORT_F_TID_WIDTH + MAX_AXI_PORT_BRESP_WIDTH),
    	AXI_WACK_PORT_L2_DWIDTH     = (MAX_AXI_PORT_L2_TID_WIDTH + MAX_AXI_PORT_BRESP_WIDTH),
    	AXI_WACK_PORT_L3_DWIDTH     = (MAX_AXI_PORT_L3_TID_WIDTH + MAX_AXI_PORT_BRESP_WIDTH),

    	//Write ack FORMAT:
    	//Compile time constant: MAX_AXI_PORT_BRESP_WIDTH (2)
    	//Bit [1:0]  : BRESP
        //             -write response
    	//Compile time constant: MAX_AXI_PORT_TID_WIDTH (4)
    	//Bit [13:2] : BID
        //             -write transaction ID

    	//Note we only support OKAY response.


        //Read data port
        MAX_AXI_PORT_L2_RDATA_WIDTH = MAX_FIFO_DWIDTH,
        MAX_AXI_PORT_L3_RDATA_WIDTH = 32,
        MAX_AXI_PORT_RRESP_WIDTH    = 2,
        AXI_RD_PORT_L2_DWIDTH       = (MAX_AXI_PORT_L2_RDATA_WIDTH + MAX_AXI_PORT_L2_TID_WIDTH + MAX_AXI_PORT_RRESP_WIDTH + MAX_AXI_PORT_LAST_WIDTH),
        AXI_RD_PORT_L3_DWIDTH       = (MAX_AXI_PORT_L3_RDATA_WIDTH + MAX_AXI_PORT_L3_TID_WIDTH + MAX_AXI_PORT_RRESP_WIDTH + MAX_AXI_PORT_LAST_WIDTH),
   	//Read data FORMAT:
    	//Compile time constant: MAX_AXI_PORT_RDATA_WIDTH (64)
    	//Bit [63:0]  : RDATA
        //              -read data
    	//Compile time constant: MAX_AXI_PORT_TID_WIDTH (4)
    	//Bit [65:64] : RRESP
        //              -read response
    	//compile time constant: MAX_AXI_PORT_LAST_WIDTH (1)
    	//Bit [66]    : RLAST
        //             -last cycle transfer for the burst
    	//Bit [79:67] : RID
        //              -Read transaction ID
   	//Note we only support OKAY response.



        //==========================================================================================
        // NextGen parameters
        //==========================================================================================

        // Local interface parameters
        CFG_LOCAL_SIZE_WIDTH                                = 3,
        CFG_LOCAL_ADDR_WIDTH                                = 32,
        CFG_LOCAL_DATA_WIDTH                                = 80,                   // Maximum DQ width of 40
        CFG_LOCAL_ID_WIDTH                                  = MAX_CTRL_ID_WIDTH + MAX_MERGE_COUNT_WIDTH,    // CC: modified from 8
        CFG_LOCAL_IF_TYPE                                   = "AVALON",             // not used
        
        // Memory interface parameters
        CFG_MEM_IF_CHIP                                     = 2,
        CFG_MEM_IF_CS_WIDTH                                 = 1,
        CFG_MEM_IF_BA_WIDTH                                 = 3,
        CFG_MEM_IF_ROW_WIDTH                                = 16,
        CFG_MEM_IF_COL_WIDTH                                = 12,
        CFG_MEM_IF_ADDR_WIDTH                               = 20,
        CFG_MEM_IF_CKE_WIDTH                                = 2,
        CFG_MEM_IF_ODT_WIDTH                                = 2,
        CFG_MEM_IF_CLK_PAIR_COUNT                           = 2,
        CFG_MEM_IF_DQ_WIDTH                                 = 40,
        CFG_MEM_IF_DQS_WIDTH                                = 5,
        CFG_MEM_IF_DM_WIDTH                                 = 5,
        
        // Controller parameters
        CFG_DWIDTH_RATIO                                    = 2,
        CFG_ODT_ENABLED                                     = 1,            // NOTICE: required?
        CFG_OUTPUT_REGD                                     = 0,            // NOTICE: un-used and will be removed
        CFG_CTL_TBP_NUM                                     = 8,
        CFG_LPDDR2_ENABLED                                  = 1,
       
        // Data path buffer & fifo parameters
        CFG_WRBUFFER_ADDR_WIDTH                             = 6,
        CFG_RDBUFFER_ADDR_WIDTH                             = 6,

        // MMR port width; Note: The config ports need to match the phy
        // cfg: general
        CFG_PORT_WIDTH_INTERFACE_WIDTH                      = 8,
        CFG_PORT_WIDTH_DEVICE_WIDTH                         = 8,
        
        // cfg: address mapping signals
        CFG_PORT_WIDTH_COL_ADDR_WIDTH                       = 8,
        CFG_PORT_WIDTH_ROW_ADDR_WIDTH                       = 8,
        CFG_PORT_WIDTH_BANK_ADDR_WIDTH                      = 8,
        CFG_PORT_WIDTH_CS_ADDR_WIDTH                        = 8,
        
        // cfg: timing parameters                                                                                             
        CFG_PORT_WIDTH_CAS_WR_LAT                           = 8,          // max will be 8 in DDR3
        CFG_PORT_WIDTH_ADD_LAT                              = 8,          // max will be 10 in DDR3
        CFG_PORT_WIDTH_TCL                                  = 8,          // max will be 11 in DDR3
        CFG_PORT_WIDTH_TRFC                                 = 8,          // 12-140       enough?
        CFG_PORT_WIDTH_TREFI                                = 16,         // 780 - 6240   enough?
        CFG_PORT_WIDTH_TWR                                  = 8,          // 2 - 12       enough?
        CFG_PORT_WIDTH_TMRD                                 = 8,          // 4 - ?        enough?
        
        // PHY parameters
        CFG_WLAT_BUS_WIDTH                                  = 4,
        CFG_RLAT_BUS_WIDTH                                  = 5
        
    )
    (   //==========================================================================================
        // MPFE ports
        //==========================================================================================
        
        // CMD path - user Avalon ST interface
        input                                                       cmd_port_clk_0,
        input                                                       cmd_port_clk_1,
        input                                                       cmd_port_clk_2,
        input                                                       cmd_port_clk_3,
        input                                                       cmd_port_clk_4,
        input                                                       cmd_port_clk_5,
        
        input   [AXI_CMD_PORT_F_DWIDTH                          -1:0]   cmd_data_0,
        input   [AXI_CMD_PORT_F_DWIDTH                          -1:0]   cmd_data_1,
        input   [AXI_CMD_PORT_F_DWIDTH                          -1:0]   cmd_data_2,
        input   [AXI_CMD_PORT_F_DWIDTH                          -1:0]   cmd_data_3,
        input   [AXI_CMD_PORT_F_DWIDTH                          -1:0]   cmd_data_4,
        input   [AXI_CMD_PORT_F_DWIDTH                          -1:0]   cmd_data_5,

        input                                                       cmd_valid_0,
        input                                                       cmd_valid_1,
        input                                                       cmd_valid_2,
        input                                                       cmd_valid_3,
        input                                                       cmd_valid_4,
        input                                                       cmd_valid_5,

        output                                                      cmd_ready_0,
        output                                                      cmd_ready_1,
        output                                                      cmd_ready_2,
        output                                                      cmd_ready_3,
        output                                                      cmd_ready_4,
        output                                                      cmd_ready_5,

        // Wrack path - user Avalon ST interface
        input                                                       wrack_ready_0,
        input                                                       wrack_ready_1,
        input                                                       wrack_ready_2,
        input                                                       wrack_ready_3,
        input                                                       wrack_ready_4,
        input                                                       wrack_ready_5,

        output                                                      wrack_valid_0,
        output                                                      wrack_valid_1,
        output                                                      wrack_valid_2,
        output                                                      wrack_valid_3,
        output                                                      wrack_valid_4,
        output                                                      wrack_valid_5,
        
        output  [AXI_WACK_PORT_F_DWIDTH-1:0]                        wrack_data_0,
        output  [AXI_WACK_PORT_F_DWIDTH-1:0]                        wrack_data_1,
        output  [AXI_WACK_PORT_F_DWIDTH-1:0]                        wrack_data_2,
        output  [AXI_WACK_PORT_F_DWIDTH-1:0]                        wrack_data_3,
        output  [AXI_WACK_PORT_F_DWIDTH-1:0]                        wrack_data_4,
        output  [AXI_WACK_PORT_F_DWIDTH-1:0]                        wrack_data_5,

        // RD path - user Avalon ST interface
        input                                                       rd_clk_0,
        input                                                       rd_clk_1,
        input                                                       rd_clk_2,
        input                                                       rd_clk_3,

        output                                                      rd_valid_0,
        output                                                      rd_valid_1,
        output                                                      rd_valid_2,
        output                                                      rd_valid_3,

        output  [RD_FIFO_WIDTH-1:0]  			    	    rd_data_0,
        output  [RD_FIFO_WIDTH-1:0]  			    	    rd_data_1,
        output  [RD_FIFO_WIDTH-1:0]  			    	    rd_data_2,
        output  [RD_FIFO_WIDTH-1:0]  			    	    rd_data_3,
        
        input                                                       rd_ready_0,
        input                                                       rd_ready_1,
        input                                                       rd_ready_2,
        input                                                       rd_ready_3,

        // WR path - user Avalon ST interface
        input                                                       wr_clk_0,
        input                                                       wr_clk_1,
        input                                                       wr_clk_2,
        input                                                       wr_clk_3,

        input   [WR_FIFO_WIDTH-1:0]  			    	    wr_data_0,
        input   [WR_FIFO_WIDTH-1:0]   			    	    wr_data_1,
        input   [WR_FIFO_WIDTH-1:0]   			    	    wr_data_2,
        input   [WR_FIFO_WIDTH-1:0]   			    	    wr_data_3,

        input                                                       wr_valid_0,
        input                                                       wr_valid_1,
        input                                                       wr_valid_2,
        input                                                       wr_valid_3,

        output                                                      wr_ready_0,
        output                                                      wr_ready_1,
        output                                                      wr_ready_2,
        output                                                      wr_ready_3,


     //bonding ports
     //read data return channel
     output [MAX_FABRIC_FIFO_NUM-1 :0] bonding_out_1,
     //write data channel
     output [MAX_FABRIC_FIFO_NUM-1 :0] bonding_out_2,

     

        //==========================================================================================
        // NextGen ports
        //==========================================================================================

        // Sideband signals
        output                                                      local_init_done,

        // Controller commands to the AFI interface
        output  [(CFG_DWIDTH_RATIO/2)                       -1:0]   afi_rst_n,
        output  [CFG_MEM_IF_BA_WIDTH*(CFG_DWIDTH_RATIO/2)   -1:0]   afi_ba,
        output  [CFG_MEM_IF_ADDR_WIDTH*(CFG_DWIDTH_RATIO/2) -1:0]   afi_addr,
        output  [CFG_MEM_IF_CKE_WIDTH*(CFG_DWIDTH_RATIO/2)  -1:0]   afi_cke,
        output  [CFG_MEM_IF_CHIP*(CFG_DWIDTH_RATIO/2)       -1:0]   afi_cs_n,
        output  [(CFG_DWIDTH_RATIO/2)                       -1:0]   afi_ras_n,
        output  [(CFG_DWIDTH_RATIO/2)                       -1:0]   afi_cas_n,
        output  [(CFG_DWIDTH_RATIO/2)                       -1:0]   afi_we_n,
        output  [(CFG_MEM_IF_ODT_WIDTH*(CFG_DWIDTH_RATIO/2))-1:0]   afi_odt,

        // Controller read and write data to the AFI interface
        input   [CFG_WLAT_BUS_WIDTH                         -1:0]   afi_wlat,
        input   [CFG_RLAT_BUS_WIDTH                         -1:0]   afi_rlat, // not used
        output  [CFG_MEM_IF_DQS_WIDTH*(CFG_DWIDTH_RATIO/2)  -1:0]   afi_dqs_burst,
        output  [CFG_MEM_IF_DM_WIDTH*CFG_DWIDTH_RATIO       -1:0]   afi_dm,
        output  [CFG_MEM_IF_DQ_WIDTH*CFG_DWIDTH_RATIO       -1:0]   afi_wdata,
        output  [CFG_MEM_IF_DQS_WIDTH*(CFG_DWIDTH_RATIO/2)  -1:0]   afi_wdata_valid,
        output  [CFG_MEM_IF_DQS_WIDTH*(CFG_DWIDTH_RATIO/2)  -1:0]   afi_rdata_en,
        output  [CFG_MEM_IF_DQS_WIDTH*(CFG_DWIDTH_RATIO/2)  -1:0]   afi_rdata_en_full,
        input   [CFG_MEM_IF_DQ_WIDTH*CFG_DWIDTH_RATIO       -1:0]   afi_rdata,
        input   [(CFG_DWIDTH_RATIO/2)                       -1:0]   afi_rdata_valid,

        // Status and control signal to the AFI interface
        input                                                       afi_cal_success,
        input                                                       afi_cal_fail,
        output                                                      afi_cal_req,
        output                                                      afi_init_req,
        output  [CFG_MEM_IF_CLK_PAIR_COUNT                  -1:0]   afi_mem_clk_disable,

        // DQS enable tracking
        output  [CFG_MEM_IF_CHIP                            -1:0]   afi_ctl_refresh_done,       // Controller asserts this after tRFC is done, also acts as stall ack to phy
        input   [CFG_MEM_IF_CHIP                            -1:0]   afi_seq_busy,               // Sequencer busy signal to controller, also acts as stall request to ctlr
        output  [CFG_MEM_IF_CHIP                            -1:0]   afi_ctl_long_idle,          // Controller asserts this after long period of no refresh, protocol is the same as rfsh_done


        //==========================================================================================
        // Memory-Mapped Register ports
        //==========================================================================================

        input                                       csr_clk, // not used, but required to make qsys happy
        input                                       csr_reset_n, // not used, but required to make qsys happy
        input                                       csr_read_req,
        input                                       csr_write_req,
        input   [CFG_CFG_AVALON_ADDR_WIDTH    -1:0] csr_addr,
        input   [CFG_CFG_AVALON_DATA_BYTES*8  -1:0] csr_wdata,
        input   [CFG_CFG_AVALON_DATA_BYTES    -1:0] csr_be,
        output  [CFG_CFG_AVALON_DATA_BYTES*8  -1:0] csr_rdata,
        output                                      csr_rdata_valid,
        output                                      csr_waitrequest,


     	input    [11:0]    cfg_port_width,          //Specifies per command port data width.  This regis
     	input    [17:0]    cfg_cport_wfifo_map,          //Specifies command port to wr fifo associativity.  
     	input    [17:0]    cfg_cport_rfifo_map,          //Specifies command port to rd fifo associativity 
     	input    [15:0]    cfg_rfifo_cport_map,          //Specifies the command port for each read FIFO.  Ea
     	input    [15:0]    cfg_wfifo_cport_map,          //Specifies command port to write fifo associativity
     	input    [11:0]    cfg_cport_type,          //Command port type.  Specifies which command ports 
     	input    [5:0]     cfg_axi_mm_select,       //select the FPGA port mode.

	// These much match the phy we are using for simulation, which is the regular AV/CV hard phy,
	// and not the HPS phy
     	output    [23:0]                                              cfg_dramconfig,
     	output    [CFG_PORT_WIDTH_CAS_WR_LAT                  -1:0]   cfg_caswrlat,
     	output    [CFG_PORT_WIDTH_ADD_LAT                     -1:0]   cfg_addlat,
     	output    [CFG_PORT_WIDTH_TCL                         -1:0]   cfg_tcl,
     	output    [CFG_PORT_WIDTH_TRFC                        -1:0]   cfg_trfc,
     	output    [CFG_PORT_WIDTH_TREFI                       -1:0]   cfg_trefi,
     	output    [CFG_PORT_WIDTH_TWR                         -1:0]   cfg_twr,
    	output    [CFG_PORT_WIDTH_TMRD                        -1:0]   cfg_tmrd,
     	output    [CFG_PORT_WIDTH_COL_ADDR_WIDTH              -1:0]   cfg_coladdrwidth,
     	output    [CFG_PORT_WIDTH_ROW_ADDR_WIDTH              -1:0]   cfg_rowaddrwidth,
     	output    [CFG_PORT_WIDTH_BANK_ADDR_WIDTH             -1:0]   cfg_bankaddrwidth,
     	output    [CFG_PORT_WIDTH_CS_ADDR_WIDTH               -1:0]   cfg_csaddrwidth,
     	output    [CFG_PORT_WIDTH_INTERFACE_WIDTH             -1:0]   cfg_interfacewidth,
     	output    [CFG_PORT_WIDTH_DEVICE_WIDTH                -1:0]   cfg_devicewidth,

        //==========================================================================================
        // common ports
        //==========================================================================================

        input   ctl_clk,
        input   ctl_reset_n

     
    );

//==========================================================================================
// Adapt width of some ports to PHY simulation models
//==========================================================================================

localparam CFG_PORT_WIDTH_CAS_WR_LAT_TMP      = 4;
localparam CFG_PORT_WIDTH_ADD_LAT_TMP         = 5;
localparam CFG_PORT_WIDTH_TCL_TMP             = 5;
localparam CFG_PORT_WIDTH_TRFC_TMP            = 4;
localparam CFG_PORT_WIDTH_TREFI_TMP           = 13;
localparam CFG_PORT_WIDTH_TWR_TMP             = 4;
localparam CFG_PORT_WIDTH_TMRD_TMP            = 4;
localparam CFG_PORT_WIDTH_COL_ADDR_WIDTH_TMP  = 5;
localparam CFG_PORT_WIDTH_ROW_ADDR_WIDTH_TMP  = 5;
localparam CFG_PORT_WIDTH_BANK_ADDR_WIDTH_TMP = 3;
localparam CFG_PORT_WIDTH_CS_ADDR_WIDTH_TMP   = 3;
localparam CFG_PORT_WIDTH_INTERFACE_WIDTH_TMP = 8;
localparam CFG_PORT_WIDTH_DEVICE_WIDTH_TMP    = 4;

wire    [20:0]                                              cfg_dramconfig_tmp;
wire    [CFG_PORT_WIDTH_CAS_WR_LAT_TMP              -1:0]   cfg_caswrlat_tmp;
wire    [CFG_PORT_WIDTH_ADD_LAT_TMP                 -1:0]   cfg_addlat_tmp;
wire    [CFG_PORT_WIDTH_TCL_TMP                     -1:0]   cfg_tcl_tmp;
wire    [CFG_PORT_WIDTH_TRFC_TMP                    -1:0]   cfg_trfc_tmp;
wire    [CFG_PORT_WIDTH_TREFI_TMP                   -1:0]   cfg_trefi_tmp;
wire    [CFG_PORT_WIDTH_TWR_TMP                     -1:0]   cfg_twr_tmp;
wire    [CFG_PORT_WIDTH_TMRD_TMP                    -1:0]   cfg_tmrd_tmp;
wire    [CFG_PORT_WIDTH_COL_ADDR_WIDTH_TMP          -1:0]   cfg_coladdrwidth_tmp;
wire    [CFG_PORT_WIDTH_ROW_ADDR_WIDTH_TMP          -1:0]   cfg_rowaddrwidth_tmp;
wire    [CFG_PORT_WIDTH_BANK_ADDR_WIDTH_TMP         -1:0]   cfg_bankaddrwidth_tmp;
wire    [CFG_PORT_WIDTH_CS_ADDR_WIDTH_TMP           -1:0]   cfg_csaddrwidth_tmp;
wire    [CFG_PORT_WIDTH_INTERFACE_WIDTH_TMP         -1:0]   cfg_interfacewidth_tmp;
wire    [CFG_PORT_WIDTH_DEVICE_WIDTH_TMP            -1:0]   cfg_devicewidth_tmp;

assign cfg_dramconfig        = cfg_dramconfig_tmp;
assign cfg_caswrlat          = cfg_caswrlat_tmp;
assign cfg_addlat            = cfg_addlat_tmp;
assign cfg_tcl               = cfg_tcl_tmp;
assign cfg_trfc              = cfg_trfc_tmp;
assign cfg_trefi             = cfg_trefi_tmp;
assign cfg_twr               = cfg_twr_tmp;
assign cfg_tmrd              = cfg_tmrd_tmp;
assign cfg_coladdrwidth      = cfg_coladdrwidth_tmp;
assign cfg_rowaddrwidth      = cfg_rowaddrwidth_tmp;
assign cfg_bankaddrwidth     = cfg_bankaddrwidth_tmp;
assign cfg_csaddrwidth       = cfg_csaddrwidth_tmp;
assign cfg_interfacewidth    = cfg_interfacewidth_tmp;
assign cfg_devicewidth       = cfg_devicewidth_tmp;



hps_hmctl_mpfe_top hps_hmctl_mpfe_top_inst (

	.cold_reset_n(ctl_reset_n),
	.warm_reset_n(1),
	.warm_rst_req(0),
	.preserve_content(0),
	.warm_rst_ack(),
	.hmctl_interrupt(),
	.port_clk_0(cmd_port_clk_0),
	.port_clk_1(cmd_port_clk_1),
	.port_clk_2(cmd_port_clk_2),
	.port_clk_3(cmd_port_clk_3),
	.port_clk_4(cmd_port_clk_4),
	.port_clk_5(cmd_port_clk_5),
	.port_clk_6(0),
	.port_clk_7(0),
	.port_clk_8(0),
	.port_clk_9(0),
	.i_avst_cmd_reset_n_0(0),
	.i_avst_cmd_reset_n_1(0),
	.i_avst_cmd_reset_n_2(0),
	.i_avst_cmd_reset_n_3(0),
	.i_avst_cmd_reset_n_4(0),
	.i_avst_cmd_reset_n_5(0),
	.i_avst_cmd_reset_n_6(0),
	.i_avst_cmd_reset_n_7(0),
	.i_avst_cmd_reset_n_8(0),
	.i_avst_cmd_reset_n_9(0),
	.i_avst_cmd_data_0(cmd_data_0),
	.i_avst_cmd_data_1(cmd_data_1),
	.i_avst_cmd_data_2(cmd_data_2),
	.i_avst_cmd_data_3(cmd_data_3),
	.i_avst_cmd_data_4(cmd_data_4),
	.i_avst_cmd_data_5(cmd_data_5),
	.i_avst_cmd_data_6(0),
	.i_avst_cmd_data_7(0),
	.i_avst_cmd_data_8(0),
	.i_avst_cmd_data_9(0),
	.i_avst_cmd_valid_0(cmd_valid_0),
	.i_avst_cmd_valid_1(cmd_valid_1),
	.i_avst_cmd_valid_2(cmd_valid_2),
	.i_avst_cmd_valid_3(cmd_valid_3),
	.i_avst_cmd_valid_4(cmd_valid_4),
	.i_avst_cmd_valid_5(cmd_valid_5),
	.i_avst_cmd_valid_6(0),
	.i_avst_cmd_valid_7(0),
	.i_avst_cmd_valid_8(0),
	.i_avst_cmd_valid_9(0),
	.o_cmd_avst_ready_0(cmd_ready_0),
	.o_cmd_avst_ready_1(cmd_ready_1),
	.o_cmd_avst_ready_2(cmd_ready_2),
	.o_cmd_avst_ready_3(cmd_ready_3),
	.o_cmd_avst_ready_4(cmd_ready_4),
	.o_cmd_avst_ready_5(cmd_ready_5),
	.o_cmd_avst_ready_6(),
	.o_cmd_avst_ready_7(),
	.o_cmd_avst_ready_8(),
	.o_cmd_avst_ready_9(),
	.i_avst_wrack_ready_0(wrack_ready_0),
	.i_avst_wrack_ready_1(wrack_ready_1),
	.i_avst_wrack_ready_2(wrack_ready_2),
	.i_avst_wrack_ready_3(wrack_ready_3),
	.i_avst_wrack_ready_4(wrack_ready_4),
	.i_avst_wrack_ready_5(wrack_ready_5),
	.i_avst_wrack_ready_6(0),
	.i_avst_wrack_ready_7(0),
	.i_avst_wrack_ready_8(0),
	.i_avst_wrack_ready_9(0),
	.o_wrack_avst_valid_0(wrack_valid_0),
	.o_wrack_avst_valid_1(wrack_valid_1),
	.o_wrack_avst_valid_2(wrack_valid_2),
	.o_wrack_avst_valid_3(wrack_valid_3),
	.o_wrack_avst_valid_4(wrack_valid_4),
	.o_wrack_avst_valid_5(wrack_valid_5),
	.o_wrack_avst_valid_6(),
	.o_wrack_avst_valid_7(),
	.o_wrack_avst_valid_8(),
	.o_wrack_avst_valid_9(),
	.o_wrack_avst_data_0(wrack_data_0),
	.o_wrack_avst_data_1(wrack_data_1),
	.o_wrack_avst_data_2(wrack_data_2),
	.o_wrack_avst_data_3(wrack_data_3),
	.o_wrack_avst_data_4(wrack_data_4),
	.o_wrack_avst_data_5(wrack_data_5),
	.o_wrack_avst_data_6(),
	.o_wrack_avst_data_7(),
	.o_wrack_avst_data_8(),
	.o_wrack_avst_data_9(),
	.i_avst_rd_clk_0(rd_clk_0),
	.i_avst_rd_clk_1(rd_clk_1),
	.i_avst_rd_clk_2(rd_clk_2),
	.i_avst_rd_clk_3(rd_clk_3),
	.i_avst_rd_clk_4(0),
	.i_avst_rd_clk_5(0),
	.i_avst_rd_reset_n_0(0),
	.i_avst_rd_reset_n_1(0),
	.i_avst_rd_reset_n_2(0),
	.i_avst_rd_reset_n_3(0),
	.i_avst_rd_reset_n_4(0),
	.i_avst_rd_reset_n_5(0),
	.o_rd_avst_valid_0(rd_valid_0),
	.o_rd_avst_valid_1(rd_valid_1),
	.o_rd_avst_valid_2(rd_valid_2),
	.o_rd_avst_valid_3(rd_valid_3),
	.o_rd_avst_valid_4(),
	.o_rd_avst_valid_5(),
	.o_rd_avst_data_0(rd_data_0),
	.o_rd_avst_data_1(rd_data_1),
	.o_rd_avst_data_2(rd_data_2),
	.o_rd_avst_data_3(rd_data_3),
	.o_rd_avst_data_4(),
	.o_rd_avst_data_5(),
	.i_avst_rd_ready_0(rd_ready_0),
	.i_avst_rd_ready_1(rd_ready_1),
	.i_avst_rd_ready_2(rd_ready_2),
	.i_avst_rd_ready_3(rd_ready_3),
	.i_avst_rd_ready_4(0),
	.i_avst_rd_ready_5(0),
	.i_avst_wr_clk_0(wr_clk_0),
	.i_avst_wr_clk_1(wr_clk_1),
	.i_avst_wr_clk_2(wr_clk_2),
	.i_avst_wr_clk_3(wr_clk_3),
	.i_avst_wr_clk_4(0),
	.i_avst_wr_clk_5(0),
	.i_avst_wr_reset_n_0(0),
	.i_avst_wr_reset_n_1(0),
	.i_avst_wr_reset_n_2(0),
	.i_avst_wr_reset_n_3(0),
	.i_avst_wr_reset_n_4(0),
	.i_avst_wr_reset_n_5(0),
	.i_avst_wr_data_0(wr_data_0),
	.i_avst_wr_data_1(wr_data_1),
	.i_avst_wr_data_2(wr_data_2),
	.i_avst_wr_data_3(wr_data_3),
	.i_avst_wr_data_4(0),
	.i_avst_wr_data_5(0),
	.i_avst_wr_valid_0(wr_valid_0),
	.i_avst_wr_valid_1(wr_valid_1),
	.i_avst_wr_valid_2(wr_valid_2),
	.i_avst_wr_valid_3(wr_valid_3),
	.i_avst_wr_valid_4(0),
	.i_avst_wr_valid_5(0),
	.o_wr_avst_ready_0(wr_ready_0),
	.o_wr_avst_ready_1(wr_ready_1),
	.o_wr_avst_ready_2(wr_ready_2),
	.o_wr_avst_ready_3(wr_ready_3),
	.o_wr_avst_ready_4(),
	.o_wr_avst_ready_5(),
	.bonding_out_1(bonding_out_1),
	.bonding_out_2(bonding_out_2),
	.local_refresh_ack(),
	.local_power_down_ack(),
	.local_init_done(local_init_done),
	.afi_rst_n(afi_rst_n),
	.afi_ba(afi_ba),
	.afi_addr(afi_addr),
	.afi_cke(afi_cke),
	.afi_cs_n(afi_cs_n),
	.afi_ras_n(afi_ras_n),
	.afi_cas_n(afi_cas_n),
	.afi_we_n(afi_we_n),
	.afi_odt(afi_odt),
	.afi_wlat(afi_wlat),
	.afi_dqs_burst(afi_dqs_burst),
	.afi_dm(afi_dm),
	.afi_wdata(afi_wdata),
	.afi_wdata_valid(afi_wdata_valid),
	.afi_rdata_en(afi_rdata_en),
	.afi_rdata_en_full(afi_rdata_en_full),
	.afi_rdata(afi_rdata),
	.afi_rdata_valid(afi_rdata_valid),
	.ctl_cal_success(afi_cal_success),
	.ctl_cal_fail(afi_cal_fail),
	.ctl_cal_req(afi_cal_req),
	.ctl_init_req(afi_init_req),
	.ctl_cal_byte_lane_sel_n ( ),
	.ctl_mem_clk_disable(afi_mem_clk_disable),
	.afi_ctl_refresh_done(afi_ctl_refresh_done),
	.afi_seq_busy(afi_seq_busy),
	.afi_ctl_long_idle(afi_ctl_long_idle),
	.mmr_read_req(csr_read_req),
	.mmr_write_req(csr_write_req),
	.mmr_burst_count(2'b01),
	.mmr_burst_begin(1'b1),
	.mmr_addr({2'b00,csr_addr}), // zero-fill to match 10-bit address in model
	.mmr_wdata(csr_wdata),
	.mmr_be(csr_be),
	.mmr_rdata(csr_rdata),
	.mmr_rdata_valid(csr_rdata_valid),
	.mmr_waitrequest(csr_waitrequest),
	.fabric_in_cfg_port_width(cfg_port_width),
	.fabric_in_cfg_cport_wfifo_map(cfg_cport_wfifo_map),
	.fabric_in_cfg_cport_rfifo_map(cfg_cport_rfifo_map),
	.fabric_in_cfg_rfifo_cport_map(cfg_rfifo_cport_map),
	.fabric_in_cfg_wfifo_cport_map(cfg_wfifo_cport_map),
	.fabric_in_cfg_cport_type(cfg_cport_type),
	.fabric_in_cfg_axi_mm_select(cfg_axi_mm_select),
	.dram_config(cfg_dramconfig_tmp),
	.cfg_cas_wr_lat(cfg_caswrlat_tmp),
	.cfg_add_lat(cfg_addlat_tmp),
	.cfg_tcl(cfg_tcl_tmp),
	.cfg_trfc(cfg_trfc_tmp),
	.cfg_trefi(cfg_trefi_tmp),
	.cfg_twr(cfg_twr_tmp),
	.cfg_tmrd(cfg_tmrd_tmp),
	.cfg_col_addr_width(cfg_coladdrwidth_tmp),
	.cfg_row_addr_width(cfg_rowaddrwidth_tmp),
	.cfg_bank_addr_width(cfg_bankaddrwidth_tmp),
	.cfg_cs_addr_width(cfg_csaddrwidth_tmp),
	.cfg_interface_width(cfg_interfacewidth_tmp),
	.cfg_device_width(cfg_devicewidth_tmp),
	.cfg_csr_ac_delay_en(),
	.cfg_csr_dq_delay_en(),
	.cfg_csr_dqs_delay_en(),
	.cfg_csr_dqslogic_delay_en(),
	.cfg_csr_reset_delay_en(),
	.cfg_csr_lpddr_dis(),
	.cfg_csr_add_lat_sel(),
	.cfg_sample_count(),
	.cfg_longidle_smpl_count(),
	.dft_in_fpga_scan_en(0),
	.dft_in_fpga_atpg_en(0),
	.dft_in_fpga_pipeline_se_enable(0) ,
	.cfg_dfx_bypass_enable(0),
	.dfx_scan_clk(0),
	.dfx_scan_din(0),
	.dfx_scan_en(0),
	.dfx_scan_load(0),
	.dfx_scan_dout(),
	.ctl_clk(ctl_clk),
	.ctl_reset_n(1)
);


//==================================================================================================
//  Methods
//==================================================================================================

    function integer log2;              //constant function
       input integer value;    // leda_off [DCVER_4] :: Incompatible port connection in module instantiation
       begin
           value = value - 1;    // leda_off [VER_2_10_3_5] :: Specify base format ('d,'b,'h,'o) for constant
           for (log2=0; value>0; log2=log2+1)
               value = value>>1;    // leda_off [VER_2_10_3_5] :: Specify base format ('d,'b,'h,'o) for constant
       end
    endfunction



  endmodule
  
