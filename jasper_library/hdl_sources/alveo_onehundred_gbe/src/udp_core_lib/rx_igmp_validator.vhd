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


entity rx_igmp_validator is
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
        core_clk                : in  std_logic;                                    --! Tx Path Clk
        core_rst_s_n            : in  std_logic;                                    --! Tx Path active low synchronous reset
        igmp_done                : out std_logic;                            --! IGMP Packet Has Finished
        igmp_start               : in  std_logic;                            --! Signal From Arbitrator That Queued IGMP Packet Can Start Sending
        igmp_valid_dest_addr    : out std_logic;                            --! IGMP Packet Is Ready To Send
        
        axi4lite_igmp_mode_control_reg : in t_axi4lite_igmp_mode_control; --! Register to check whether destination addresses match for igmp traffic
        
        dst_ip_addr                     : in std_logic_vector(31 downto 0)    --! Dst Ip Addr Of Incoming Packet, to be compared against valid igmp subscription address
        
     
        
    );
end entity rx_igmp_validator;

architecture behavioural of rx_igmp_validator is
    -- Calculate the FIFO Address Width Based on G_LL_BYTES and C_TOTAL_FIFO_BYTES:

    signal igmp_valid_dest_addr_reg,igmp_start_reg,igmp_done_reg    :  std_logic;                            
        
    signal    axi4lite_igmp_mode_control_reg_in :  t_axi4lite_igmp_mode_control; 
        
    signal    dst_ip_addr_in,igmp_addr_cur                     :  std_logic_vector(31 downto 0) ;  
    
    
    signal igmp_subscribe,igmp_leave         : std_logic;

    type igmp_validator_state is (
        idle,
        reset,
        start,
        done
    );

    ----------------------------------------------------------------------------------
    ---- Vendor Specific Attributes:
    ----------------------------------------------------------------------------------
    attribute syn_encoding : string;
    attribute fsm_encoding : string;
    -- Xilinx Attributes:
    attribute fsm_encoding of igmp_validator_state : type is "one_hot";
    -- Altera Attributes:
    attribute syn_encoding of igmp_validator_state : type is "safe, one-hot";
    
    signal igmp_next_state : igmp_validator_state := start;

begin
    
    axi4lite_igmp_mode_control_reg_in <= axi4lite_igmp_mode_control_reg;
    dst_ip_addr_in                    <= byte_reverse(dst_ip_addr);
    igmp_start_reg                    <= igmp_start;
    
    igmp_valid_dest_addr <= igmp_valid_dest_addr_reg;
    igmp_done            <= igmp_done_reg;
    
    -- Generate IGMP Packets based on igmp control registers
    igmp_pkt_proc : process(core_clk)    
        variable output_idx_i : integer range 0 to 255        := 0;
        variable mcast_groups : integer range 0 to 255        := 0; 
    begin
        if rising_edge(core_clk) then
            if (core_rst_s_n = '0') then
            
                output_idx_i                  := 0;
                mcast_groups                  := 0;

            else
                case igmp_next_state is
                
                    when start  =>
                    
                        output_idx_i                   := 0;
                        mcast_groups := to_integer(unsigned(axi4lite_igmp_mode_control_reg_in.igmp_control.igmp_num));
                        igmp_addr_cur <=  axi4lite_igmp_mode_control_reg_in.mcast_addr(output_idx_i);
                        if igmp_start_reg = '1' then
                           igmp_next_state                <= idle;
                        else
                           igmp_next_state                <= start;                        
                        end if;
                        
                    when idle =>
                         
                         igmp_addr_cur <=  axi4lite_igmp_mode_control_reg_in.mcast_addr(output_idx_i); 
                         
                         if igmp_addr_cur = dst_ip_addr_in then                       
      
                            igmp_valid_dest_addr_reg <= '1'; 
                            igmp_done_reg            <= '1'; 
                            igmp_next_state <= done;
                            
                         elsif output_idx_i < mcast_groups then
                            output_idx_i := output_idx_i + 1;   
                            igmp_next_state <= idle;
                         else
                            igmp_valid_dest_addr_reg <= '0'; 
                            igmp_done_reg            <= '0'; 
                            igmp_next_state <= done;
                         end if;
                    
                    when done =>
                            output_idx_i := 0;
                            igmp_next_state <= reset;
                end case;
            end if;
        end if;
    end process;    

end architecture behavioural;
