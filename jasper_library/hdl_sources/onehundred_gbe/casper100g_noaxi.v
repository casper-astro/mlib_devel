module casper100g_noaxi#(
    parameter FABRIC_MAC = 48'hff_ff_ff_ff_ff_ff,
    parameter FABRIC_IP = 32'hc0a805c8,
    parameter FABRIC_PORT = 16'h2710,
    parameter FABRIC_GATEWAY = 32'h1,
    parameter FABRIC_ENABLE_ON_START = 1'b0
   ) (
        // 100MHz reference clock needed by 100G Ethernet PHY
        // This must be a stable 100MHz clock as per the 100G PHY requirements 
        input RefClk100MHz,
        // Clock locked signal to control operations to be halted until clocks 
        // are stable.  
        input RefClkLocked,
        // Aximm clock is the AXI Lite MM clock for the gmac register interface
        // Usually 125MHz 
        input aximm_clk,
        // ICAP is the 125MHz ICAP clock used for PR
        input icap_clk,
        // Axis reset is the global synchronous reset to the highest clock
        input axis_reset,
        // Ethernet reference clock for 156.25MHz
        // QSFP+ 1
        input mgt_qsfp_clock_p,
        input mgt_qsfp_clock_n,
        //RX     
        input [3:0] qsfp_mgt_rx_p,
        input [3:0] qsfp_mgt_rx_n,
        // TX
        output [3:0] qsfp_mgt_tx_p,
        output [3:0] qsfp_mgt_tx_n,
        // Settings
        output qsfp_modsell_ls,
        output qsfp_resetl_ls,
        input qsfp_modprsl_ls,
        input qsfp_intl_ls,
        output qsfp_lpmode_ls,

        input user_clk,
        
        // Yellow block interfaces
        output gbe_tx_afull,
        output gbe_tx_overflow,
        output [511:0] gbe_rx_data,
        output gbe_rx_valid,
        output [31:0] gbe_rx_source_ip,
        output [15:0] gbe_rx_source_port,
        output [31:0] gbe_rx_dest_ip,
        output [15:0] gbe_rx_dest_port,
        output gbe_rx_end_of_frame,
        output gbe_rx_bad_frame,
        output gbe_rx_overrun,
        output gbe_led_up,
        output gbe_led_rx,
        output gbe_led_tx,

        // Control registers
        input [31:0] gmac_reg_phy_control_h,
        input [31:0] gmac_reg_phy_control_l,
        input [31:0] gmac_reg_mac_address_h,
        input [31:0] gmac_reg_mac_address_l,
        input [31:0] gmac_reg_local_ip_address,
        input [31:0] gmac_reg_local_ip_netmask,
        input [31:0] gmac_reg_gateway_ip_address,
        input [31:0] gmac_reg_multicast_ip_address,
        input [31:0] gmac_reg_multicast_ip_mask,
        input [31:0] gmac_reg_udp_port,
        input [31:0] gmac_reg_core_ctrl,
        input [31:0] gmac_reg_count_reset,
        output [31:0] gmac_reg_core_type             ,
        output [31:0] gmac_reg_phy_status_h          ,
        output [31:0] gmac_reg_phy_status_l          ,
        output [31:0] gmac_reg_tx_packet_rate        ,
        output [31:0] gmac_reg_tx_packet_count       ,
        output [31:0] gmac_reg_tx_valid_rate         ,
        output [31:0] gmac_reg_tx_valid_count        ,
        output [31:0] gmac_reg_tx_overflow_count     ,
        output [31:0] gmac_reg_tx_almost_full_count  ,
        output [31:0] gmac_reg_rx_packet_rate        ,
        output [31:0] gmac_reg_rx_packet_count       ,
        output [31:0] gmac_reg_rx_valid_rate         ,
        output [31:0] gmac_reg_rx_valid_count        ,
        output [31:0] gmac_reg_rx_overflow_count     ,
        output [31:0] gmac_reg_rx_almost_full_count  ,
        output [31:0] gmac_reg_rx_bad_packet_count   ,
        output [31:0] gmac_reg_arp_size              ,
        output [31:0] gmac_reg_word_size             ,
        output [31:0] gmac_reg_buffer_max_size       ,

        input [31:0] gmac_arp_cache_write_enable     ,
        input [31:0] gmac_arp_cache_read_enable      ,
        input [31:0] gmac_arp_cache_write_data       ,
        input [31:0] gmac_arp_cache_write_address    ,
        input [31:0] gmac_arp_cache_read_address     ,
        output [31:0] gmac_arp_cache_read_data       ,

        input gmac_reg_phy_control_h_we,
        input gmac_reg_phy_control_l_we,
        input gmac_reg_mac_address_h_we,
        input gmac_reg_mac_address_l_we,
        input gmac_reg_local_ip_address_we,
        input gmac_reg_local_ip_netmask_we,
        input gmac_reg_gateway_ip_address_we,
        input gmac_reg_multicast_ip_address_we,
        input gmac_reg_multicast_ip_mask_we,
        input gmac_reg_udp_port_we,
        input gmac_reg_core_ctrl_we,
        input gmac_reg_count_reset_we,
        input gmac_arp_cache_write_enable_we,
        input gmac_arp_cache_read_enable_we,
        input gmac_arp_cache_write_data_we,
        input gmac_arp_cache_write_address_we,
        input gmac_arp_cache_read_address_we,

        input gbe_rst,
        input gbe_rx_ack,
        input gbe_rx_overrun_ack,
        input [31:0] gbe_tx_dest_ip,
        input [15:0] gbe_tx_dest_port,
        input [511:0] gbe_tx_data,
        input [3:0] gbe_tx_valid,
        input gbe_tx_end_of_frame
        
    );

    assign gbe_tx_afull = 1'b0;
    assign gbe_rx_source_ip = 32'b0;
    assign gbe_rx_source_port = 16'b0;
    assign gbe_rx_dest_ip = 32'b0;
    assign gbe_rx_dest_port = 16'b0;
    assign gbe_rx_bad_frame = 1'b0;
    //assign gbe_rx_overrun = 1'b0;
    assign gbe_led_up = 1'b0;
    assign gbe_led_rx = 1'b0;
    assign gbe_led_tx = 1'b0;

    //wire rx_valid_int;
    wire tx_valid_int;

    assign tx_valid_int = |gbe_tx_valid;
    //assign gbe_rx_valid = {4{rx_valid_int}};

    // Register AXI signals
    reg [31:0] gmac_reg_phy_control_h_reg;
    reg [31:0] gmac_reg_phy_control_l_reg;
    reg [31:0] gmac_reg_mac_address_h_reg = {16'b0, FABRIC_MAC[47:32]};
    reg [31:0] gmac_reg_mac_address_l_reg = FABRIC_MAC[31:0];
    reg [31:0] gmac_reg_local_ip_address_reg = FABRIC_IP;
    reg [31:0] gmac_reg_local_ip_netmask_reg = 32'hffffff00;
    reg [31:0] gmac_reg_gateway_ip_address_reg = FABRIC_GATEWAY;
    reg [31:0] gmac_reg_multicast_ip_address_reg;
    reg [31:0] gmac_reg_multicast_ip_mask_reg;
    reg [31:0] gmac_reg_udp_port_reg = FABRIC_PORT;
    reg [31:0] gmac_reg_core_ctrl_reg = FABRIC_ENABLE_ON_START;
    reg [31:0] gmac_reg_count_reset_reg;
    reg [31:0] gmac_arp_cache_write_enable_reg;
    reg [31:0] gmac_arp_cache_read_enable_reg;
    reg [31:0] gmac_arp_cache_write_data_reg;
    reg [31:0] gmac_arp_cache_write_address_reg;
    reg [31:0] gmac_arp_cache_read_address_reg;
    always @(posedge aximm_clk) begin
        if ( gmac_reg_phy_control_h_we )
            gmac_reg_phy_control_h_reg <= gmac_reg_phy_control_h;
        if ( gmac_reg_phy_control_l_we )
            gmac_reg_phy_control_l_reg <= gmac_reg_phy_control_l;
        if ( gmac_reg_mac_address_h_we )
            gmac_reg_mac_address_h_reg <= gmac_reg_mac_address_h;
        if ( gmac_reg_mac_address_l_we )
            gmac_reg_mac_address_l_reg <= gmac_reg_mac_address_l;
        if ( gmac_reg_local_ip_address_we )
            gmac_reg_local_ip_address_reg <= gmac_reg_local_ip_address;
        if ( gmac_reg_local_ip_netmask_we )
            gmac_reg_local_ip_netmask_reg <= gmac_reg_local_ip_netmask;
        if ( gmac_reg_gateway_ip_address_we )
            gmac_reg_gateway_ip_address_reg <= gmac_reg_gateway_ip_address;
        if ( gmac_reg_multicast_ip_address_we )
            gmac_reg_multicast_ip_address_reg <= gmac_reg_multicast_ip_address;
        if ( gmac_reg_multicast_ip_mask_we )
            gmac_reg_multicast_ip_mask_reg <= gmac_reg_multicast_ip_mask;
        if ( gmac_reg_udp_port_we )
            gmac_reg_udp_port_reg <= gmac_reg_udp_port;
        if ( gmac_reg_core_ctrl_we )
            gmac_reg_core_ctrl_reg <= gmac_reg_core_ctrl;
        if ( gmac_reg_count_reset_we )
            gmac_reg_count_reset_reg <= gmac_reg_count_reset;
        if ( gmac_arp_cache_write_enable_we )
            gmac_arp_cache_write_enable_reg <= gmac_arp_cache_write_enable;
        if ( gmac_arp_cache_read_enable_we )
            gmac_arp_cache_read_enable_reg <= gmac_arp_cache_read_enable;
        if ( gmac_arp_cache_write_data_we )
            gmac_arp_cache_write_data_reg <= gmac_arp_cache_write_data;
        if ( gmac_arp_cache_write_address_we )
            gmac_arp_cache_write_address_reg <= gmac_arp_cache_write_address;
        if ( gmac_arp_cache_read_address_we )
            gmac_arp_cache_read_address_reg <= gmac_arp_cache_read_address;
    end

    casper100gethernetblock_no_cpu #(
        .G_INCLUDE_ICAP(1'b0),
        .G_AXI_DATA_WIDTH(512),
        .G_NUM_STREAMING_DATA_SERVERS(1),
        .G_SLOT_WIDTH(2)
    ) casper100gethernetblock_inst (
        .RefClk100MHz(RefClk100MHz),
        .RefClkLocked(RefClkLocked),
        .aximm_clk(aximm_clk),
        .icap_clk(),
        .axis_reset(axis_reset),
        // Ethernet reference clock for 156.25MHz
        // QSFP+ 1
        .mgt_qsfp_clock_p(mgt_qsfp_clock_p),
        .mgt_qsfp_clock_n(mgt_qsfp_clock_n),
        //RX     
        .qsfp_mgt_rx_p(qsfp_mgt_rx_p),
        .qsfp_mgt_rx_n(qsfp_mgt_rx_n),
        // TX
        .qsfp_mgt_tx_p(qsfp_mgt_tx_p),
        .qsfp_mgt_tx_n(qsfp_mgt_tx_n),
        // Settings
        .qsfp_modsell_ls(qsfp_modsell_ls),
        .qsfp_resetl_ls(qsfp_resetl_ls),
        .qsfp_modprsl_ls(qsfp_modprsl_ls),
        .qsfp_intl_ls(qsfp_intl_ls),
        .qsfp_lpmode_ls(qsfp_lpmode_ls),
        // Control register interfaces
        .gmac_reg_phy_control_h       (gmac_reg_phy_control_h_reg       ), 
        .gmac_reg_phy_control_l       (gmac_reg_phy_control_l_reg       ), 
        .gmac_reg_mac_address_h       (gmac_reg_mac_address_h_reg       ), 
        .gmac_reg_mac_address_l       (gmac_reg_mac_address_l_reg       ),
        .gmac_reg_local_ip_address    (gmac_reg_local_ip_address_reg    ), 
        .gmac_reg_local_ip_netmask    (gmac_reg_local_ip_netmask_reg    ),
        .gmac_reg_gateway_ip_address  (gmac_reg_gateway_ip_address_reg  ), 
        .gmac_reg_multicast_ip_address(gmac_reg_multicast_ip_address_reg), 
        .gmac_reg_multicast_ip_mask   (gmac_reg_multicast_ip_mask_reg   ), 
        .gmac_reg_udp_port            (gmac_reg_udp_port_reg            ), 
        .gmac_reg_core_ctrl           (gmac_reg_core_ctrl_reg           ),
        .gmac_reg_count_reset         (gmac_reg_count_reset_reg         ),
        .gmac_reg_core_type           (gmac_reg_core_type               ),
        .gmac_reg_phy_status_h        (gmac_reg_phy_status_h            ),
        .gmac_reg_phy_status_l        (gmac_reg_phy_status_l            ),
        .gmac_reg_tx_packet_rate      (gmac_reg_tx_packet_rate          ),
        .gmac_reg_tx_packet_count     (gmac_reg_tx_packet_count         ),
        .gmac_reg_tx_valid_rate       (gmac_reg_tx_valid_rate           ),
        .gmac_reg_tx_valid_count      (gmac_reg_tx_valid_count          ),
        .gmac_reg_tx_overflow_count   (gmac_reg_tx_overflow_count       ),
        .gmac_reg_tx_almost_full_count(gmac_reg_tx_almost_full_count    ),
        .gmac_reg_rx_packet_rate      (gmac_reg_rx_packet_rate          ),
        .gmac_reg_rx_packet_count     (gmac_reg_rx_packet_count         ),
        .gmac_reg_rx_valid_rate       (gmac_reg_rx_valid_rate           ),
        .gmac_reg_rx_valid_count      (gmac_reg_rx_valid_count          ),
        .gmac_reg_rx_overflow_count   (gmac_reg_rx_overflow_count       ),
        .gmac_reg_rx_almost_full_count(gmac_reg_rx_almost_full_count    ),
        .gmac_reg_rx_bad_packet_count (gmac_reg_rx_bad_packet_count     ),
        .gmac_reg_arp_size            (gmac_reg_arp_size                ),
        .gmac_reg_word_size           (gmac_reg_word_size               ),
        .gmac_reg_buffer_max_size     (gmac_reg_buffer_max_size         ),
        // Weirdo register-controlled ARP cache interface
        .gmac_arp_cache_write_enable  (gmac_arp_cache_write_enable_reg  ),
        .gmac_arp_cache_read_enable   (gmac_arp_cache_read_enable_reg   ),
        .gmac_arp_cache_write_data    (gmac_arp_cache_write_data_reg    ),
        .gmac_arp_cache_write_address (gmac_arp_cache_write_address_reg ),
        .gmac_arp_cache_read_address  (gmac_arp_cache_read_address_reg  ),
        .gmac_arp_cache_read_data     (gmac_arp_cache_read_data         ),
        // Fabric interface
        // Streaming data clocks 
        .axis_streaming_data_clk(user_clk),
        .axis_streaming_data_rx_packet_length(),
        
        // Streaming data outputs to AXIS of the Yellow Blocks
        //.axis_streaming_data_rx_tdata(gbe_rx_data),
        //.axis_streaming_data_rx_tvalid(rx_valid_int),
        //.axis_streaming_data_rx_tready(1'b1),//(gbe_rx_ack),
        //.axis_streaming_data_rx_tkeep(),
        //.axis_streaming_data_rx_tlast(gbe_rx_end_of_frame),
        //.axis_streaming_data_rx_tuser(1'b0),
        .yellow_block_rx_data      (gbe_rx_data),
        .yellow_block_rx_valid     (gbe_rx_valid),
        .yellow_block_rx_eof       (gbe_rx_end_of_frame),
        .yellow_block_rx_overrun   (gbe_rx_overrun),

        //Data inputs from AXIS bus of the Yellow Blocks
        .axis_streaming_data_tx_destination_ip(gbe_tx_dest_ip),
        .axis_streaming_data_tx_destination_udp_port(gbe_tx_dest_port),
        .axis_streaming_data_tx_source_udp_port(gmac_reg_udp_port_reg[15:0]),
        // packet_length is not used internally with JH's udppacker. It is kept here
        // for compatibility with the original packing module.
        .axis_streaming_data_tx_packet_length(16'b0),
        
        .axis_streaming_data_tx_tdata(gbe_tx_data),
        .axis_streaming_data_tx_tvalid(tx_valid_int),
        // TUSER is (I think) a discard flag
        .axis_streaming_data_tx_tuser(32'b0),
        // Could expose byte enables to user to allow finer payload control.
        // BUT, need to check what patterns are actually allowed. Eg. valid
        // bytes must be a contiguous block in the LSBs
        .axis_streaming_data_tx_tkeep(64'hffffffffffffffff),
        .axis_streaming_data_tx_tlast(gbe_tx_end_of_frame),
        .axis_streaming_data_tx_tready(gbe_tx_overflow)
    );

endmodule
