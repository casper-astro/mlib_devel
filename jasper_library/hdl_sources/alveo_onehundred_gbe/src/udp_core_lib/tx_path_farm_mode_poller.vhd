-- <h---------------------------------------------------------------------------
--! @file   tx_farm_mode_poller.vhd
--! @page txpathfarmmodepollerpage Tx Farm Mode Poller
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! Provides an access point to 256 entry Dual Port RAM Look up table used to
--! store destination addresses. Responds to:
--! * MAC, IP & Port Address Rds to generate UDP headers when in Farm Mode
--! * IP Address Rds to generate ARP requests for that LUT position
--! * MAC Address Wrs to store received MAC Addr from ARP replies
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
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
use axi4_lib.axi4lite_pkg.all;

entity tx_path_farm_mode_poller is
    port(
        clk                     : in  std_logic;                        --! Tx Path Clk
        axi4lite_aclk           : in  std_logic;                        --! AXI4-Lite Clock
        axi4lite_aresetn        : in  std_logic;                        --! AXI4-Lite Active-Low Asynchronous Reset
        axi4lite_mosi           : in  t_axi4lite_mosi;                  --! AXI4-Lite Master-Out/Slave-In Record from axi4lite.axi4lite_pkg
        axi4lite_miso           : out t_axi4lite_miso;                  --! AXI4-Lite Master In/Slave Out Record from axi4lite.axi4lite_pkg
        header_lut_addr         : in  std_logic_vector(7 downto 0);     --! Header Constructor Access LUT Address
        arp_lut_addr            : in  std_logic_vector(7 downto 0);     --! ARP Handler Access LUT Address
        arp_read_data           : in  std_logic;                        --! ARP Handler Read Request
        arp_write_data          : in  std_logic;                        --! ARP Handler Write Request
        current_pos             : out std_logic_vector(7 downto 0);     --! Current Position Of LUT Output Addresses
        lower_mac_addr_in       : in  std_logic_vector(31 downto 0);    --! Lower MAC Address Write
        upper_mac_addr_in       : in  std_logic_vector(15 downto 0);    --! Upper MAC Address Write
        mac_addr_out            : out std_logic_vector(47 downto 0);    --! MAC Address Out
        ip_addr_out             : out std_logic_vector(31 downto 0);    --! IP Address Out
        port_out                : out std_logic_vector(31 downto 0)     --! Port Address Out

    );
end entity tx_path_farm_mode_poller;

architecture RTL of tx_path_farm_mode_poller is

    signal lut_addr                     : std_logic_vector(7 downto 0);
    signal lut_read_enable              : std_logic;
    signal lower_mac_addr_out           : std_logic_vector(31 downto 0);
    signal upper_mac_addr_out           : std_logic_vector(31 downto 0);
    signal farm_mode_upper_mac_addr_tmp : std_logic_vector(31 downto 0);

begin

    lut_addr        <= arp_lut_addr when arp_write_data = '1'
                       else arp_lut_addr when arp_read_data = '1'
                       else header_lut_addr;
    lut_read_enable <= arp_read_data or arp_write_data; -- and not arp_write_data;
    mac_addr_out    <= upper_mac_addr_out(15 downto 0) & lower_mac_addr_out;

    farm_mode_upper_mac_addr_tmp <= X"0000" & upper_mac_addr_in;

    tx_lut_proc : process(clk)
    begin
        if (rising_edge(clk)) then
            current_pos <= lut_addr;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- AXI4-Lite Manual Code Insertion of Auto-Generated VHDL
    --  (matches Records created by XML File):
    ----------------------------------------------------------------------------
    comp_axi4lite_farm_mode_luts : entity udp_core_lib.axi4lite_farm_mode_lut
        port map(
            axi4lite_aclk                     => axi4lite_aclk,
            axi4lite_aresetn                  => axi4lite_aresetn,
            axi4lite_mosi                     => axi4lite_mosi,
            axi4lite_miso                     => axi4lite_miso,
            farm_mode_lut_lower_mac_addr_clk  => clk,
            farm_mode_lut_lower_mac_addr_en   => '1',
            farm_mode_lut_lower_mac_addr_we   => arp_write_data,
            farm_mode_lut_lower_mac_addr_add  => lut_addr,
            farm_mode_lut_lower_mac_addr_wdat => lower_mac_addr_in,
            farm_mode_lut_lower_mac_addr_rdat => lower_mac_addr_out,
            farm_mode_lut_upper_mac_addr_clk  => clk,
            farm_mode_lut_upper_mac_addr_en   => '1',
            farm_mode_lut_upper_mac_addr_we   => arp_write_data,
            farm_mode_lut_upper_mac_addr_add  => lut_addr,
            farm_mode_lut_upper_mac_addr_wdat => farm_mode_upper_mac_addr_tmp,
            farm_mode_lut_upper_mac_addr_rdat => upper_mac_addr_out,
            farm_mode_lut_ip_addr_clk         => clk,
            farm_mode_lut_ip_addr_en          => '1',
            farm_mode_lut_ip_addr_add         => lut_addr,
            farm_mode_lut_ip_addr_rdat        => ip_addr_out,
            farm_mode_lut_dst_port_clk        => clk,
            farm_mode_lut_dst_port_en         => '1',
            farm_mode_lut_dst_port_add        => lut_addr,
            farm_mode_lut_dst_port_rdat       => port_out
        );

end architecture RTL;
