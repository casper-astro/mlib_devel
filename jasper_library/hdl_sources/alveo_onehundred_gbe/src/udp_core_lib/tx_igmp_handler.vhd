-- <h---------------------------------------------------------------------------
--! @file tx_igmp_handler.vhd
--! @page txigmphandler Tx igmp Handler
--!
--! Amit Bansod, abansod@mpifr.de
--!
--! ### Brief ###
--! Constructs and Sends IPV4 IGMP Queries
--!
--! ### License ###
--! Copyright(c) 2021 
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
-- ---------------------------------------------------------------------------h>
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library common_mem_lib;
use common_mem_lib.common_mem_pkg.all;

library axi4_lib;
use axi4_lib.axi4s_pkg.all;
use axi4_lib.axi4lite_pkg.all;

use udp_core_lib.axi4lite_igmp_mode_control_pkg.all;


entity tx_igmp_handler is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                              --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                                 --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                                --! Selects how the Fitter implements the FIFO Memory
        G_UDP_CORE_BYTES        : natural := 8;                                     --! Width Of Data Bus In Bytes
        G_TUSER_WIDTH           : natural := 32;                                    --! TUSER Is Used To Pass Side Channel Data Depending On IPV4 Or Ethernet Packet (eg. Type, Length)
        G_TID_WIDTH             : natural := 8;                                     --! TID
        G_CORE_FREQ_KHZ         : integer := 156250;                                 --! Used to Calibrate the Refresh Timers
        
        G_EXT_FIFO_CAP          : integer := (64 * 8)                               --! How much FIFO Space To Allocate TO Incoming Packets
    );
    port(
        axi4lite_aclk           : in  std_logic;                            --! AXI4-Lite Clock
        axi4lite_aresetn        : in  std_logic;                            --! AXI4-Lite Asyncrounous Active Low Reset
        core_clk                : in  std_logic;                                    --! Tx Path Clk
        core_rst_s_n            : in  std_logic;                                    --! Tx Path active low synchronous reset
     --   payload_in_clk          : in  std_logic;                                    --! Data in Clk
     --   payload_in_rst_n        : in  std_logic;                                    --! Data in active low synchronous reset
     --   tx_igmp_s_mosi           : in  t_axi4s_mosi;                         --! Axi4s IGMP Data From Rx to Tx Path FIFO
     --   tx_igmp_s_miso           : out t_axi4s_miso;                         --! Axi4s IGMP Backpressure To Rx to Tx Path FIFO
        tx_igmp_m_mosi           : out t_axi4s_mosi;                         --! Axi4s IGMP Data Out To Tx
        tx_igmp_m_miso           : in  t_axi4s_miso;                         --! Axi4s IGMP Backpressure From Tx
        igmp_rdy                 : out std_logic;                            --! IGMP Packet Is Ready To Send
        igmp_en                  : out std_logic;                            --! IGMP Enabled or not to rx_filter_stage_1
        igmp_ip_lower_limit      : out std_logic_vector(31 downto 0);       --! IGMP Packet Destination IP Lower Limit for  rx_filter_stage_1
        igmp_ip_upper_limit      : out std_logic_vector(31 downto 0);       --! IGMP Packet Destination IP Lower Limit for  rx_filter_stage_1
        igmp_done                : out std_logic;                            --! IGMP Packet Has Finished
        igmp_start               : in  std_logic;                            --! Signal From Arbitrator That Queued IGMP Packet Can Start Sending
        igmp_ip_dst_addr         : out  std_logic_vector(31 downto 0);    --! IP Addr To Route igmp  Request To, passed from Tx Path via igmp handler
        ip_length                : out std_logic_vector(15 downto 0);         --! Length of IGMP IPV4 Packet for Header Constructor
        igmp_axi4lite_mosi       : in  t_axi4lite_mosi;                               --! Axi4lite MM Arrays for Control and Status Regs
        igmp_axi4lite_miso       : out t_axi4lite_miso                                --! Axi4lite MM Arrays for Control and Status Regs
--        pass_in_rdy             : out std_logic;                                    --! Output ready Signal out
--        start_frame             : in  std_logic;                                    --! Start Output Signal in
--        pass_tid                : out std_logic_vector(G_TID_WIDTH - 1 downto 0);   --! Sidechannel TID Out
--        pass_tuser              : out std_logic_vector(G_TUSER_WIDTH - 1 downto 0); --! Sidechannel TUSER Out
--        payload_out_mosi        : out t_axi4s_mosi                                  --! Axi4s Packet Data Out
    );
end entity tx_igmp_handler;

architecture behavioural of tx_igmp_handler is
    -- Calculate the FIFO Address Width Based on G_LL_BYTES and C_TOTAL_FIFO_BYTES:
    
    constant C_IGMP_MEM_QUERY      : std_logic_vector(7 downto 0)                   := X"11";
    constant C_IGMP_v1_REPORT      : std_logic_vector(7 downto 0)                   := X"12";
    constant C_IGMP_v2_REPORT      : std_logic_vector(7 downto 0)                   := X"16";
    constant C_IGMP_v3_REPORT      : std_logic_vector(7 downto 0)                   := X"22";
    constant C_IGMP_GRP_LEAVE      : std_logic_vector(7 downto 0)                   := X"17";
    constant C_IGMP_MAX_RSP_TIME   : std_logic_vector(7 downto 0)                   := X"64";
    
    constant C_MAX_NO_POS          : integer                       := 256;
    constant C_MAX_WIDTH           : integer                       := 64;
    constant C_IGMP_HEADER         : integer                       := 28;  --ip header plus data
    constant C_OUTPUT_LENGTH       : integer                       := 8;
    constant C_TOTAL_FIFO_BYTES    : integer                       := 129; -- Store Over 2 * 64 byte Packets
    constant C_FIFO_WIDTH          : integer                       := udp_maximum(C_FIFO_MIN_WIDTH, log_2_ceil(C_TOTAL_FIFO_BYTES / G_UDP_CORE_BYTES));
    constant C_FIFO_CAPCACITY      : integer                       := 2**C_FIFO_WIDTH;
    constant C_OUTPUT_REG_LENGTH   : integer                       := header_words(C_OUTPUT_LENGTH, G_UDP_CORE_BYTES) + 1;
    constant C_TOTAL_REG_LENGTH    : integer                       := header_words((64 - 14), G_UDP_CORE_BYTES) + 1;
    constant C_LAST_BYTE_POS       : integer                       := 8; --udp_maximum(((64 - 14) rem G_UDP_CORE_BYTES) - 1, 0);
    constant C_REG_LENGTH          : integer                       := 64;
    constant C_IGMP_LOOP_TIME_MS   : integer                       := 10000; --The order of time units that the Refresh Timeout CTRL Register Sets
    
    constant C_FIFO_ADDR_WIDTH : integer       := udp_maximum(3, log_2_ceil(G_EXT_FIFO_CAP / (G_UDP_CORE_BYTES * 8)));
    constant C_FIFO_DESC       : t_axi4s_descr := (tdata_nof_bytes => G_UDP_CORE_BYTES,
                                                   tid_width       => G_TID_WIDTH,
                                                   tuser_width     => G_TUSER_WIDTH,
                                                   has_tlast       => 1,
                                                   has_tkeep       => 1,
                                                   has_tid         => 1,
                                                   has_tuser       => 1);
                                                   
    --Intermediate MOSI/MISO signals
    signal axi4s_igmp_out_int_mosi : t_axi4s_mosi;
    signal axi4s_igmp_out_int_miso : t_axi4s_miso;
    signal axi4s_igmp_in_int_mosi  : t_axi4s_mosi;
    signal axi4s_igmp_in_int_miso  : t_axi4s_miso;
    
    
    signal igmp_output_complete  : std_logic_vector(C_OUTPUT_REG_LENGTH * G_UDP_CORE_BYTES * 8 - 1 downto 0) := (others => '0');
    alias igmp_out_type          : std_logic_vector(7 downto 0) is igmp_output_complete(1* 8 - 1 downto 0 * 8);
    alias igmp_out_max_rsp_time  : std_logic_vector(7 downto 0) is igmp_output_complete(2* 8 - 1 downto 1 * 8);
    alias igmp_out_chksum        : std_logic_vector(15 downto 0) is igmp_output_complete(4* 8 - 1 downto 2 * 8);
    alias igmp_out_addr          : std_logic_vector(31 downto 0) is igmp_output_complete(8* 8 - 1 downto 4 * 8);
    
    signal igmp_out_addr_reg                                : std_logic_vector(31 downto 0); 
    signal igmp_ip_dst_addr_reg                             : std_logic_vector(31 downto 0);
    
    signal ip_length_int                                    : std_logic_vector(15 downto 0);
    
    signal igmp_header_1                                    : std_logic_vector(15 downto 0);
    signal igmp_header_20                                   : std_logic_vector(31 downto 0);
    signal igmp_checksum_reg                                : std_logic_vector(15 downto 0);
    
    signal axi4lite_igmp_mode_control_out_we : t_axi4lite_igmp_mode_control_decoded;
    signal axi4lite_igmp_mode_control_out    : t_axi4lite_igmp_mode_control;
    
    signal last_valid_was_last   : std_logic;
    signal axi4s_mosi_int        : t_axi4s_mosi;
    signal axi4s_miso_int        : t_axi4s_miso;
    signal sending_frame         : std_logic;
    
    signal count_increment       : std_logic;
    
    
    signal igmp_sending     : std_logic := '0';
    
    
    signal igmp_subscribe,igmp_leave         : std_logic;

    type igmp_state is (
        idle,
        reset,
        start,
        byte_rev,
        chksum_cal,
        chksum_pipe,
        subscribe,  
        igmp_wait,
        leave
    );

    ----------------------------------------------------------------------------------
    ---- Vendor Specific Attributes:
    ----------------------------------------------------------------------------------
    attribute syn_encoding : string;
    attribute fsm_encoding : string;
    -- Xilinx Attributes:
    attribute fsm_encoding of igmp_state : type is "one_hot";
    -- Altera Attributes:
    attribute syn_encoding of igmp_state : type is "safe, one-hot";
    
    signal igmp_next_state : igmp_state := idle;

begin

    tx_igmp_m_mosi          <= axi4s_igmp_out_int_mosi;
    axi4s_igmp_out_int_miso <= tx_igmp_m_miso;
    
--  axi4s_miso_int.tready <= start_frame or sending_frame;

    ip_length                <= byte_reverse(ip_length_int);
    
    igmp_ip_dst_addr <= igmp_ip_dst_addr_reg;
    
    igmp_en              <= axi4lite_igmp_mode_control_out.igmp_control.igmp_en;
    igmp_ip_lower_limit  <= axi4lite_igmp_mode_control_out.mcast_addr(0);
    igmp_ip_upper_limit  <= axi4lite_igmp_mode_control_out.mcast_addr(to_integer(unsigned(axi4lite_igmp_mode_control_out.igmp_control.igmp_num))-1);
    
    --Control and Status Memory Maps
    axi4lite_igmp_mode_control_inst : entity udp_core_lib.axi4lite_igmp_mode_control
        port map(
            axi4lite_aclk                    => axi4lite_aclk,
            axi4lite_aresetn                 => axi4lite_aresetn,
            axi4lite_mosi                    => igmp_axi4lite_mosi,
            axi4lite_miso                    => igmp_axi4lite_miso,
            axi4lite_igmp_mode_control_out_we => axi4lite_igmp_mode_control_out_we,
            axi4lite_igmp_mode_control_out    => axi4lite_igmp_mode_control_out
        );
    
    timer_inst : entity udp_core_lib.udp_core_timer
        generic map(
            clk_freq_in_khz  => G_CORE_FREQ_KHZ,
            pulse_time_in_ms => C_IGMP_LOOP_TIME_MS
        )
        port map(
            clk             => core_clk,
            rst_n           => core_rst_s_n,
            end_of_interval => count_increment
        );
    
    -- Generate IGMP Packets based on igmp control registers
    igmp_pkt_proc : process(core_clk)    
        variable output_idx_i : integer range 0 to 255        := 0;
        variable mcast_groups : integer range 0 to 255        := 0; 
        variable igmp_chk_sum_01 : unsigned(16 downto 0);
        variable header_igmp_10  : unsigned(15 downto 0);
        variable igmp_chk_sum_02 : unsigned(17 downto 0);
        variable igmp_chk_sum_20 : unsigned(16 downto 0);
    begin
        if rising_edge(core_clk) then
            if (core_rst_s_n = '0') then
            
                igmp_sending                   <= '0';
                output_idx_i                  := 0;
                mcast_groups                  := 0;
                axi4s_igmp_out_int_mosi.tvalid <= '0';
                igmp_output_complete           <= (others => '0');
                igmp_rdy                       <= '0';
                igmp_done                      <= '0';
                igmp_next_state     <= idle;
                igmp_chk_sum_01 := (others => '0');
                igmp_chk_sum_02 := (others => '0');
                header_igmp_10 := (others => '0');

            else
                case igmp_next_state is
                
                    when reset  =>
                    
                        output_idx_i                   := 0;
                        mcast_groups                  := 0;
                        axi4s_igmp_out_int_mosi.tvalid <= '0';
                        igmp_output_complete           <= (others => '0');
                        igmp_rdy                       <= '0';
                        igmp_done                      <= '0';
                        igmp_sending                   <= '0';
                        igmp_next_state                <= idle;
                        
                        igmp_chk_sum_01 := (others => '0');
                        header_igmp_10 := (others => '0');
                        igmp_chk_sum_02 := (others => '0');
                        
                    when idle =>
                         
                         
                        axi4s_igmp_out_int_mosi.tvalid <= '0';
                        axi4s_igmp_out_int_mosi.tlast  <= '0';
                        
                         if axi4lite_igmp_mode_control_out.igmp_control.igmp_en = '1' then
                         
                           mcast_groups := to_integer(unsigned(axi4lite_igmp_mode_control_out.igmp_control.igmp_num));
                            
                            if output_idx_i < mcast_groups then --track already sent requests
                                if axi4lite_igmp_mode_control_out.igmp_control.igmp_sub = '1' then --subscribe to given address
                                   igmp_next_state <= subscribe;
                                else  --leave multicast addresses
                                    igmp_next_state <= leave;
                                end if;    
                            else 
                               igmp_next_state <= igmp_wait; --wait till next round of async requests are sent
                            end if; 
                         elsif axi4lite_igmp_mode_control_out.igmp_control.igmp_rst = '1' then
                            igmp_next_state <= reset;
                         else
                            igmp_next_state <= idle;
                         end if;
                    
                    when subscribe =>
                  
                            igmp_out_type          <= C_IGMP_v2_REPORT;
                            igmp_out_max_rsp_time  <= C_IGMP_MAX_RSP_TIME;
                            igmp_header_1          <= C_IGMP_v2_REPORT & C_IGMP_MAX_RSP_TIME;
                            --IGMP Groups Positions
                            igmp_out_addr_reg <=    axi4lite_igmp_mode_control_out.mcast_addr(output_idx_i);
                            igmp_out_addr     <=    byte_reverse(axi4lite_igmp_mode_control_out.mcast_addr(output_idx_i)); --netowrk byte order
                            
                            output_idx_i := output_idx_i + 1;       
                            
                            igmp_next_state <= byte_rev;
                            
                    when leave =>
                    
                            igmp_out_type          <= C_IGMP_GRP_LEAVE;
                            igmp_out_max_rsp_time  <= C_IGMP_MAX_RSP_TIME;
                            igmp_header_1          <= C_IGMP_v2_REPORT & C_IGMP_MAX_RSP_TIME;
                            
                            --IGMP Groups Positions
                            igmp_out_addr_reg <=    axi4lite_igmp_mode_control_out.mcast_addr(output_idx_i);
                            igmp_out_addr     <=    byte_reverse(axi4lite_igmp_mode_control_out.mcast_addr(output_idx_i)); --netowrk byte order
                            
                            output_idx_i := output_idx_i + 1;  
                            igmp_next_state <= byte_rev;
                            
                    when byte_rev  =>
                                             
                         header_igmp_10 :=  unsigned(igmp_header_1);  
                                                  
                         igmp_next_state <= chksum_cal;
                                            
                    when chksum_cal =>
                    
                            igmp_chk_sum_01 := unsigned('0' & igmp_out_addr_reg(15 downto 0))  + unsigned('0' & igmp_out_addr_reg(31 downto 16));
                    
                            igmp_chk_sum_02 := ("00" & header_igmp_10) + ('0' & igmp_chk_sum_01);
                            
                            igmp_chk_sum_20 := ('0' & igmp_chk_sum_02(15 downto 0)) + ('0' & igmp_chk_sum_02(17 downto 16)); -- Add in the carries, note this might make 1 more carry
                            
                            igmp_checksum_reg      <= not std_logic_vector(igmp_chk_sum_20(15 downto 0) + (X"000" & "000" & igmp_chk_sum_20(16 downto 16))); -- Add in last possible carry here                       
                            
                            igmp_ip_dst_addr_reg <= igmp_out_addr; --network byte order
                            
                            
                            igmp_rdy                   <= '1';
                            
                            ip_length_int               <= std_logic_vector(to_unsigned(C_IGMP_HEADER, ip_length'length)); 
                                                   
                            igmp_next_state <= chksum_pipe;
                            
                                            
                    when chksum_pipe =>
                            
                            igmp_out_chksum <= byte_reverse(igmp_checksum_reg); --network byte order
                            
                            igmp_next_state <= start;
                            
                    when start =>
                    
                            if igmp_start = '1' then
                                igmp_rdy     <= '0';
                                igmp_sending <= '1';
                                
                                ip_length_int               <= std_logic_vector(to_unsigned(C_IGMP_HEADER, ip_length'length)); 
                                
                                --Start of output
                                axi4s_igmp_out_int_mosi.tdata(G_UDP_CORE_BYTES * 8 - 1 downto 0) <= igmp_output_complete(8 * G_UDP_CORE_BYTES - 1 downto 0);
                               
                                axi4s_igmp_out_int_mosi.tvalid                                   <= '1';
                                --Wide Core Width Mean ARP Packet Only Requires 1 CLK Cycle
                                axi4s_igmp_out_int_mosi.tlast                                <= '1';
                                axi4s_igmp_out_int_mosi.tkeep(G_UDP_CORE_BYTES - 1 downto 0) <= int_to_tkeep(C_LAST_BYTE_POS, G_UDP_CORE_BYTES);
                                igmp_next_state                                   <= idle;
                                --axi4s_arp_in_int_miso.tready                                <= '0';
                                igmp_done                                                    <= '1';
                             end if;
                    
                    when igmp_wait =>
                    
                        --IGMP Timeout
                        if count_increment = '1' then
                           igmp_next_state <= idle;
                           output_idx_i := 0;
                        else
                           igmp_next_state <= igmp_wait;
                        end if;
                end case;
            end if;
        end if;
    end process;

    proc_sof : process(core_clk)
    begin
        if rising_edge(core_clk) then
            if core_rst_s_n = '0' then
                last_valid_was_last <= '0';
            else
                if axi4s_mosi_int.tvalid = '1' then
                    last_valid_was_last <= axi4s_mosi_int.tlast;
                end if;
            end if;
        end if;
    end process;

    

end architecture behavioural;
