------------------------------------------------------------------------------
--! @file   udp_core_interface_nomac.vhd
--! @page udpcoreinterfacenomacpage UDP Core Interface No Mac
--!
--! \includedoc esdg_stfc_image.md
--!
--! This is 1 of 2 options for instantiating the [UDP Core](../../index.html).
--!
--! For detailed generic/port descriptions refer to [Instantiation](../../instantiation.html).
--!
--! ### Brief ###
--! Top level UDP Core wrapper which does not contain any Layer 1 Ethernet MAC
--! Functions. Contains Clk crossing FIFOs, pipeline stages, reset logic and
--! the @ref udpcoretopxmlmmspage which contains most of the Core functionality
--!
--! For 1 & 10GbE with Layer 1 MAC use 'udp_core_interface_wrapper'
--!
--! ### License ###
--! Copyright(c) 2021 UNITED KINGDOM RESEARCH AND INNOVATION
--! Licensed under the BSD 3-Clause license. See LICENSE file in the project
--! root for details.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library common_stfc_lib;
use common_stfc_lib.common_stfc_pkg.all;

library udp_core_lib;
use udp_core_lib.udp_core_pkg.all;

library axi4_lib;
use axi4_lib.axi4lite_pkg.all;
use axi4_lib.axi4s_pkg.all;

entity udp_core_interface_nomac is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                                          --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                                             --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                                            --! Selects how the Fitter implements the FIFO Memory
        G_FIFO_TYPE             : string  := "inferred_mem";                                    --! Selects how to implement the Core's FIFOs
        G_UDP_CORE_BYTES        : integer := 64;                                                --! Width Of Data Busses In Bytes
        G_NUM_OF_ARP_POS        : natural := 8;                                                 --! Number Of Positions In ARP Table to treat as dynamic ARP Positions
        G_UDP_CLK_FIFOS         : boolean := true;                                              --! Generate Clk Crossing FIFOs At The I/O of UDP Payloads
        G_EXT_CLK_FIFOS         : boolean := true;                                              --! Generate Clk Crossing FIFOs At The I/O of Unsupported Packet Types
        G_TX_EXT_IP_FIFO_CAP    : integer := 2048;                                              --! Capacity In Bytes Of Uns IPV4 Protocol Packets FIFOs in Tx Path
        G_TX_EXT_ETH_FIFO_CAP   : integer := 2048;                                              --! Capacity In Bytes Of Uns Ethernet Type Packets FIFOs in Tx Path
        G_TX_OUT_FIFO_CAP       : integer := 2048;                                              --! Capacity Of FIFO at End Of Tx Path. Necessary For 100GbE But Less Important For 1/10GbE. Can Be Set to 0.
        G_RX_IN_FIFO_CAP        : integer := 2048;                                              --! Capacity Of FIFO at Start Of Rx Path. At least 16 Words Recommended.
        G_RX_INPUT_PIPE_STAGES  : integer := 1;                                                 --! Pipeline Stages From External MAC/PHY To Rx Path
        G_INC_PING              : boolean := true;                                              --! Generate Logic For Internal Ping Replies
        G_INC_ARP               : boolean := true;                                              --! Generate Logic For Internal ARP Requests And Replies
        G_CORE_FREQ_KHZ         : integer := 156250;                                            --! KHz Of Tx Path, Only Used To Calibrate ARP Refresh Timers
        G_INC_ETH               : boolean := TRUE;                                             --! Generate Logic To Transmit Externally Provided Ethernet Payloads
        G_INC_IPV4              : boolean := TRUE                                              --! Generate Logic To Transmit Externally Provided IPV4 Payloads
    );
    port(
        -- AXI4-Lite Interface (defined in axi4lite_pkg):
        axi4lite_aclk           : in  std_logic;                                                --! AXI4-Lite Clock
        axi4lite_aresetn        : in  std_logic;                                                --! AXI4-Lite Active-Low Asynchronous Reset
        axi4lite_mosi           : in  t_axi4lite_mosi;                                          --! Axi4lite Mosi For XML Defined Memory Maps
        axi4lite_miso           : out t_axi4lite_miso;                                          --! Axi4lite Miso For XML Defined Memory Maps
        --Main Core Clocks
        tx_core_clk             : in  std_logic;                                                --! Tx Path Main Clock, Recommend Use PHY Clock
        rx_core_clk             : in  std_logic;                                                --! Rx Path Main Clock, Reccomend Using PHY Clock For 1/10/40GbE. >200MHz for 100GbE
        --PHY Axi4s Interfaces
        rx_axi4s_s_aclk         : in  std_logic;                                                --! Rx PHY Clk
        rx_axi4s_s_areset       : in  std_logic;                                                --! Rx PHY Reset, always required
        rx_axi4s_s_mosi         : in  t_axi4s_mosi;                                             --! Rx Data From PHY Mosi
        rx_axi4s_s_miso         : out t_axi4s_miso;                                             --! Rx Backpressure (To) PHY, Will Be Ignored By a PHY, Included for Debug & Verification
        tx_axi4s_m_aclk         : in  std_logic;                                                --! Tx PHY Clk
        tx_axi4s_m_areset       : in  std_logic;                                                --! Tx PHY reset, always required
        tx_axi4s_m_mosi         : out t_axi4s_mosi;                                             --! Tx Data To PHY
        tx_axi4s_m_miso         : in  t_axi4s_miso;                                             --! Tx Backpressure (From) PHY
        -- UDP Axi4s Interfaces
        udp_axi4s_s_aclk        : in  std_logic                     := 'X';                     --! UDP Tx In Clk, Ignored if G_UDP_CLK_FIFOS = False
        udp_axi4s_s_areset      : in  std_logic                     := '1';                     --! UDP Tx In Reset, Ignored if G_UDP_CLK_FIFOS = False
        udp_axi4s_s_mosi        : in  t_axi4s_mosi;                                             --! UDP Tx In Data
        udp_axi4s_s_miso        : out t_axi4s_miso;                                             --! UDP Tx In Backpressure
        udp_axi4s_m_aclk        : in  std_logic                     := 'X';                     --! UDP Rx Out Clk, Ignored if G_UDP_CLK_FIFOS = False
        udp_axi4s_m_areset      : in  std_logic                     := '1';                     --! UDP Rx Out Reset, Ignored if G_UDP_CLK_FIFOS = False
        udp_axi4s_m_miso        : in  t_axi4s_miso;                                             --! UDP Rx Out Backpressure
        udp_axi4s_m_mosi        : out t_axi4s_mosi;                                             --! UDP Rx Out Data
        --Optional External Network Address Assingment Ports
        ext_mac_addr            : in  std_logic_vector(47 downto 0) := (others => 'X');         --! Optional Mac Address For The Core To Be Set At Board Level
        ext_ip_addr             : in  std_logic_vector(31 downto 0) := (others => 'X');         --! Optional IP Address For The Core To Be Set At Board Level
        ext_port_addr           : in  std_logic_vector(15 downto 0) := (others => 'X');         --! An Optional Port Address For The Core To Be Set At Board Level
        use_ext_addr            : in  std_logic                     := '0';                     --! Use Optional External MAC & IP Addresses
        --Optional Eth Axi4s Interface
        eth_axi4s_s_aclk        : in  std_logic                     := 'X';                     --! Uns Ethernet Packet Tx In Clk
        eth_axi4s_s_areset      : in  std_logic                     := '1';                     --! Uns Ethernet Packet Tx In Reset
        eth_axi4s_s_mosi        : in  t_axi4s_mosi                  := c_axi4s_mosi_default;    --! Uns Ethernet Packet Tx In Data
        eth_axi4s_s_miso        : out t_axi4s_miso;                                             --! Uns Ethernet Packet Tx In Backpressure
        eth_axi4s_m_aclk        : in  std_logic                     := 'X';                     --! Uns Ethernet Packet Rx Out Clk
        eth_axi4s_m_areset      : in  std_logic                     := '1';                     --! Uns Ethernet Packet Rx Out Reset
        eth_axi4s_m_miso        : in  t_axi4s_miso                  := c_axi4s_miso_default;    --! Uns Ethernet Packet Rx Out Backpressure
        eth_axi4s_m_mosi        : out t_axi4s_mosi;                                             --! Uns Ethernet Packet Rx Out Data
        --Optional IPv4 Axi4s Interface
        ipv4_axi4s_s_aclk       : in  std_logic                     := 'X';                     --! Uns IPV4 Packet Tx In Clk
        ipv4_axi4s_s_areset     : in  std_logic                     := '1';                     --! Uns IPV4 Packet Tx In Reset
        ipv4_axi4s_s_mosi       : in  t_axi4s_mosi                  := c_axi4s_mosi_default;    --! Uns IPV4 Packet Tx In Data
        ipv4_axi4s_s_miso       : out t_axi4s_miso;                                             --! Uns IPV4 Packet Tx In Backpressure
        ipv4_axi4s_m_aclk       : in  std_logic                     := 'X';                     --! Uns IPV4 Packet Rx Out Clk
        ipv4_axi4s_m_areset     : in  std_logic                     := '1';                     --! Uns IPV4 Packet Rx Out Reset
        ipv4_axi4s_m_miso       : in  t_axi4s_miso                  := c_axi4s_miso_default;    --! Uns IPV4 Packet Rx Out Backpressure
        ipv4_axi4s_m_mosi       : out t_axi4s_mosi                                              --! Uns IPV4 Packet Rx Out Data
    );
end entity udp_core_interface_nomac;

architecture wrapper of udp_core_interface_nomac is

    --------------------------------------------------------------------------------
    -- Constants:
    --------------------------------------------------------------------------------
    constant C_UDP_FIFO_DESC  : t_axi4s_descr := (tdata_nof_bytes => 64,
                                                  tid_width       => 8,
                                                  tuser_width     => 32,
                                                  has_tlast       => 1,
                                                  has_tkeep       => 1,
                                                  has_tid         => 1,
                                                  has_tuser       => 1);
    constant C_IPV4_FIFO_DESC : t_axi4s_descr := (tdata_nof_bytes => 64,
                                                  tid_width       => 8,
                                                  tuser_width     => 24,
                                                  has_tlast       => 1,
                                                  has_tkeep       => 1,
                                                  has_tid         => 1,
                                                  has_tuser       => 1);
    constant C_ETH_FIFO_DESC  : t_axi4s_descr := (tdata_nof_bytes => 64,
                                                  tid_width       => 8,
                                                  tuser_width     => 16,
                                                  has_tlast       => 1,
                                                  has_tkeep       => 1,
                                                  has_tid         => 1,
                                                  has_tuser       => 1);
    constant C_TX_OUTPUT_PIPE_STAGES        : integer := 4;
    constant C_AXI4S_PIPE_BACKPRESSURE      : boolean := false;
    constant C_RESET_SR_SIZE                : integer := 4;

    --------------------------------------------------------------------------------
    -- Signals:
    --------------------------------------------------------------------------------
    signal udp_axi4s_tx_s_mosi     : t_axi4s_mosi;
    signal udp_axi4s_tx_s_miso     : t_axi4s_miso;
    signal udp_axi4s_rx_m_mosi     : t_axi4s_mosi;
    signal udp_axi4s_rx_m_miso     : t_axi4s_miso;
    signal ipv4_axi4s_tx_s_mosi    : t_axi4s_mosi;
    signal ipv4_axi4s_tx_s_miso    : t_axi4s_miso;
    signal ipv4_axi4s_rx_m_mosi    : t_axi4s_mosi;
    signal ipv4_axi4s_rx_m_miso    : t_axi4s_miso;
    signal eth_axi4s_tx_s_mosi     : t_axi4s_mosi;
    signal eth_axi4s_tx_s_miso     : t_axi4s_miso;
    signal eth_axi4s_rx_m_mosi     : t_axi4s_mosi;
    signal eth_axi4s_rx_m_miso     : t_axi4s_miso;
    signal tx_out_axi4s_m_mosi     : t_axi4s_mosi;
    signal tx_out_axi4s_m_miso     : t_axi4s_miso;
    signal rx_in_axi4s_reg_s_mosi  : t_axi4s_mosi;
    signal rx_in_axi4s_reg_s_miso  : t_axi4s_miso;

    --Reset Shift Registers, Initialise To 0s
    signal tx_axi4s_rstn_SR, rx_axi4s_rstn_SR   : std_logic_vector(C_RESET_SR_SIZE-1 downto 0) := (others => '0');
    signal tx_core_rstn_SR, rx_core_rstn_SR     : std_logic_vector(C_RESET_SR_SIZE-1 downto 0) := (others => '0');

    --Resets and Clock Signals
    signal rx_axi4s_s_areset_n      : std_logic;
    signal tx_axi4s_m_areset_n      : std_logic;
    signal rx_core_int_rst_n        : std_logic;
    signal tx_core_int_rst_n        : std_logic;
    signal rx_axi4s_int_rst_n       : std_logic;
    signal tx_axi4s_int_rst_n       : std_logic;
    signal rx_core_rst_s_n          : std_logic;
    signal tx_core_rst_s_n          : std_logic;
    signal rx_axi4s_rst_s_n         : std_logic;
    signal tx_axi4s_rst_s_n         : std_logic;
    signal ipv4_axi4s_s_areset_n    : std_logic;
    signal eth_axi4s_s_areset_n     : std_logic;
    signal ipv4_axi4s_m_areset_n    : std_logic;
    signal eth_axi4s_m_areset_n     : std_logic;
    signal udp_axi4s_s_areset_n     : std_logic;
    signal udp_axi4s_m_areset_n     : std_logic;
    signal ipv4_axi4s_in_s_areset_n : std_logic;
    signal ipv4_axi4s_in_s_aclk     : std_logic;
    signal eth_axi4s_in_s_aclk      : std_logic;
    signal eth_axi4s_in_s_areset_n  : std_logic;

begin

    rx_axi4s_s_areset_n   <= not rx_axi4s_s_areset;
    tx_axi4s_m_areset_n   <= not tx_axi4s_m_areset;
    ipv4_axi4s_s_areset_n <= not ipv4_axi4s_s_areset;
    ipv4_axi4s_m_areset_n <= not ipv4_axi4s_m_areset;
    --eth_axi4s_s_areset_n  <= not eth_axi4s_s_areset;
    udp_axi4s_s_areset_n  <= not udp_axi4s_s_areset;
    udp_axi4s_m_areset_n  <= not udp_axi4s_m_areset;
    eth_axi4s_s_areset_n  <= not eth_axi4s_s_areset;
    eth_axi4s_m_areset_n  <= not eth_axi4s_m_areset;

    --If External Clock Generic Is Set Use External Interface Clock and Reset Ports For These interfaces Entering The Tx Path
    --otherwise use the Normal Tx Clock
    ipv4_axi4s_in_s_aclk     <= ipv4_axi4s_s_aclk when G_EXT_CLK_FIFOS else tx_core_clk;
    ipv4_axi4s_in_s_areset_n <= ipv4_axi4s_s_areset_n when G_EXT_CLK_FIFOS else tx_core_rst_s_n;
    eth_axi4s_in_s_aclk      <= eth_axi4s_s_aclk when G_EXT_CLK_FIFOS else tx_core_clk;
    eth_axi4s_in_s_areset_n  <= eth_axi4s_s_areset_n when G_EXT_CLK_FIFOS else tx_core_rst_s_n;

    ----------------------------------------------------------------------------
    -- UDP Generate I/O Clk Crossing FIFOs If Generic Set, Else Straight Assign
    ----------------------------------------------------------------------------
    gen_udp_clk_fifos : if G_UDP_CLK_FIFOS generate
        udp_in_fifo_inst : entity axi4_lib.axi4s_fifo
            generic map(
                g_fpga_vendor         => G_FPGA_VENDOR,
                g_fpga_family         => G_FPGA_FAMILY,
                g_implementation      => G_FIFO_IMPLEMENTATION,
                g_dual_clock          => true,
                g_wr_adr_width        => C_FIFO_MIN_WIDTH,
                g_axi4s_descr         => C_UDP_FIFO_DESC,
                g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
                g_out_tdata_nof_bytes => G_UDP_CORE_BYTES,
                g_hold_last_read      => false
            )
            port map(
                s_axi_clk    => udp_axi4s_s_aclk,
                s_axi_rst_n  => udp_axi4s_s_areset_n,
                m_axi_clk    => tx_core_clk,
                m_axi_rst_n  => tx_core_rst_s_n,
                axi4s_s_mosi => udp_axi4s_s_mosi,
                axi4s_s_miso => udp_axi4s_s_miso,
                axi4s_m_mosi => udp_axi4s_tx_s_mosi,
                axi4s_m_miso => udp_axi4s_tx_s_miso
            );
        udp_out_fifo_inst : entity axi4_lib.axi4s_fifo
            generic map(
                g_fpga_vendor         => G_FPGA_VENDOR,
                g_fpga_family         => G_FPGA_FAMILY,
                g_implementation      => G_FIFO_IMPLEMENTATION,
                g_dual_clock          => true,
                g_wr_adr_width        => C_FIFO_MIN_WIDTH,
                g_axi4s_descr         => C_UDP_FIFO_DESC,
                g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
                g_out_tdata_nof_bytes => G_UDP_CORE_BYTES,
                g_hold_last_read      => false
            )
            port map(
                s_axi_clk    => rx_core_clk,
                s_axi_rst_n  => rx_core_rst_s_n,
                m_axi_clk    => udp_axi4s_m_aclk,
                m_axi_rst_n  => udp_axi4s_m_areset_n,
                axi4s_s_mosi => udp_axi4s_rx_m_mosi,
                axi4s_s_miso => udp_axi4s_rx_m_miso,
                axi4s_m_mosi => udp_axi4s_m_mosi,
                axi4s_m_miso => udp_axi4s_m_miso
            );
    end generate gen_udp_clk_fifos;

    gen_udp_same_clk : if not G_UDP_CLK_FIFOS generate
        udp_axi4s_tx_s_mosi <= udp_axi4s_s_mosi;
        udp_axi4s_s_miso    <= udp_axi4s_tx_s_miso;
        udp_axi4s_m_mosi    <= udp_axi4s_rx_m_mosi;
        udp_axi4s_rx_m_miso <= udp_axi4s_m_miso;
    end generate;

    ----------------------------------------------------------------------------
    -- IPV4 Generate I/O Clk Crossing FIFOs If Generic Set, Else Straight Assign
    ----------------------------------------------------------------------------
    ipv4_axi4s_tx_s_mosi <= ipv4_axi4s_s_mosi;
    ipv4_axi4s_s_miso    <= ipv4_axi4s_tx_s_miso;
    gen_ipv4_clk_fifos : if G_EXT_CLK_FIFOS and G_INC_IPV4 generate

        ipv4_out_fifo_inst : entity axi4_lib.axi4s_fifo
            generic map(
                g_fpga_vendor         => G_FPGA_VENDOR,
                g_fpga_family         => G_FPGA_FAMILY,
                g_implementation      => G_FIFO_IMPLEMENTATION,
                g_dual_clock          => true,
                g_wr_adr_width        => C_FIFO_MIN_WIDTH,
                g_axi4s_descr         => C_IPV4_FIFO_DESC,
                g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
                g_out_tdata_nof_bytes => G_UDP_CORE_BYTES,
                g_hold_last_read      => false
            )
            port map(
                s_axi_clk    => rx_core_clk,
                s_axi_rst_n  => rx_core_rst_s_n,
                m_axi_clk    => ipv4_axi4s_m_aclk,
                m_axi_rst_n  => ipv4_axi4s_m_areset_n,
                axi4s_s_mosi => ipv4_axi4s_rx_m_mosi,
                axi4s_s_miso => ipv4_axi4s_rx_m_miso,
                axi4s_m_mosi => ipv4_axi4s_m_mosi,
                axi4s_m_miso => ipv4_axi4s_m_miso
            );
    end generate gen_ipv4_clk_fifos;
    gen_ipv4_same_clk : if not G_EXT_CLK_FIFOS and G_INC_IPV4 generate
        ipv4_axi4s_m_mosi    <= ipv4_axi4s_rx_m_mosi;
        ipv4_axi4s_rx_m_miso <= ipv4_axi4s_m_miso;
    end generate;

    ----------------------------------------------------------------------------
    -- Eth Generate I/O Clk Crossing FIFOs If Generic Set, Else Straight Assign
    ----------------------------------------------------------------------------
    eth_axi4s_tx_s_mosi <= eth_axi4s_s_mosi;
    eth_axi4s_s_miso    <= eth_axi4s_tx_s_miso;
    gen_eth_clk_fifos : if G_EXT_CLK_FIFOS and G_INC_ETH generate
        eth_out_fifo_inst : entity axi4_lib.axi4s_fifo
            generic map(
                g_fpga_vendor         => G_FPGA_VENDOR,
                g_fpga_family         => G_FPGA_FAMILY,
                g_implementation      => G_FIFO_IMPLEMENTATION,
                g_dual_clock          => true,
                g_wr_adr_width        => C_FIFO_MIN_WIDTH,
                g_axi4s_descr         => C_ETH_FIFO_DESC,
                g_in_tdata_nof_bytes  => G_UDP_CORE_BYTES,
                g_out_tdata_nof_bytes => G_UDP_CORE_BYTES,
                g_hold_last_read      => false
            )
            port map(
                s_axi_clk    => rx_core_clk,
                s_axi_rst_n  => rx_core_rst_s_n,
                m_axi_clk    => eth_axi4s_m_aclk,
                m_axi_rst_n  => eth_axi4s_m_areset_n,
                axi4s_s_mosi => eth_axi4s_rx_m_mosi,
                axi4s_s_miso => eth_axi4s_rx_m_miso,
                axi4s_m_mosi => eth_axi4s_m_mosi,
                axi4s_m_miso => eth_axi4s_m_miso
            );
    end generate gen_eth_clk_fifos;

    gen_eth_same_clk : if not G_EXT_CLK_FIFOS and G_INC_ETH generate
        eth_axi4s_m_mosi    <= eth_axi4s_rx_m_mosi;
        eth_axi4s_rx_m_miso <= eth_axi4s_m_miso;
    end generate gen_eth_same_clk;

    --------------------------------------------------------------------------------
    -- UDP Core:
    --------------------------------------------------------------------------------
    udp_core_top_xml_mm_inst : entity udp_core_lib.udp_core_xml_mm_scalable_top
        generic map(
            G_TX_BACKPRESSURE     => C_AXI4S_PIPE_BACKPRESSURE,
            G_FPGA_VENDOR         => G_FPGA_VENDOR,
            G_FPGA_FAMILY         => G_FPGA_FAMILY,
            G_FIFO_IMPLEMENTATION => G_FIFO_IMPLEMENTATION,
            G_FIFO_TYPE           => G_FIFO_TYPE,
            G_UDP_CORE_BYTES      => G_UDP_CORE_BYTES,
            G_NUM_OF_ARP_POS      => G_NUM_OF_ARP_POS,
            G_CORE_FREQ_KHZ       => G_CORE_FREQ_KHZ,
            G_TX_EXT_IP_FIFO_CAP  => G_TX_EXT_IP_FIFO_CAP,
            G_TX_EXT_ETH_FIFO_CAP => G_TX_EXT_ETH_FIFO_CAP,
            G_TX_OUT_FIFO_CAP     => G_TX_OUT_FIFO_CAP,
            G_RX_IN_FIFO_CAP      => G_RX_IN_FIFO_CAP,
            G_INC_PING            => G_INC_PING,
            G_INC_ARP             => G_INC_ARP,
            G_INC_ETH             => G_INC_ETH,
            G_INC_IPV4            => G_INC_IPV4
        )
        port map(
            tx_core_clk           => tx_core_clk,
            rx_core_clk           => rx_core_clk,
            tx_core_rst_s_n       => tx_core_rst_s_n,
            rx_core_rst_s_n       => rx_core_rst_s_n,
            axi4lite_aclk         => axi4lite_aclk,
            axi4lite_aresetn      => axi4lite_aresetn,
            axi4lite_mosi         => axi4lite_mosi,
            axi4lite_miso         => axi4lite_miso,
            rx_axi4s_s_aclk       => rx_axi4s_s_aclk,
            rx_axi4s_s_areset_n   => rx_axi4s_rst_s_n,
            rx_in_axi4s_s_mosi    => rx_in_axi4s_reg_s_mosi,
            rx_in_axi4s_s_miso    => rx_in_axi4s_reg_s_miso,
            tx_axi4s_m_aclk       => tx_axi4s_m_aclk,
            tx_axi4s_m_areset_n   => tx_axi4s_rst_s_n,
            tx_out_axi4s_m_mosi   => tx_out_axi4s_m_mosi,
            tx_out_axi4s_m_miso   => tx_out_axi4s_m_miso,
            udp_axi4s_s_mosi      => udp_axi4s_tx_s_mosi,
            udp_axi4s_s_miso      => udp_axi4s_tx_s_miso,
            udp_axi4s_m_miso      => udp_axi4s_rx_m_miso,
            udp_axi4s_m_mosi      => udp_axi4s_rx_m_mosi,
            ipv4_axi4s_s_aclk     => ipv4_axi4s_in_s_aclk,
            ipv4_axi4s_s_areset_n => ipv4_axi4s_in_s_areset_n,
            ipv4_axi4s_s_mosi     => ipv4_axi4s_tx_s_mosi,
            ipv4_axi4s_s_miso     => ipv4_axi4s_tx_s_miso,
            ipv4_axi4s_m_miso     => ipv4_axi4s_rx_m_miso,
            ipv4_axi4s_m_mosi     => ipv4_axi4s_rx_m_mosi,
            eth_axi4s_s_aclk      => eth_axi4s_in_s_aclk,
            eth_axi4s_s_areset_n  => eth_axi4s_in_s_areset_n,
            eth_axi4s_s_mosi      => eth_axi4s_tx_s_mosi,
            eth_axi4s_s_miso      => eth_axi4s_tx_s_miso,
            eth_axi4s_m_miso      => eth_axi4s_rx_m_miso,
            eth_axi4s_m_mosi      => eth_axi4s_rx_m_mosi,
            ext_mac_addr          => ext_mac_addr,
            ext_ip_addr           => ext_ip_addr,
            ext_port_addr         => ext_port_addr,
            use_ext_addr          => use_ext_addr
        );

    --------------------------------------------------------------------------------
    -- I/O Pipelines For Interface With PHY
    --------------------------------------------------------------------------------
    rx_input_pipe : entity udp_core_lib.udp_axi4s_pipe
        generic map(
            G_STAGES       => G_RX_INPUT_PIPE_STAGES,
            G_BACKPRESSURE => C_AXI4S_PIPE_BACKPRESSURE
        )
        port map(
            axi_clk      => rx_axi4s_s_aclk,
            axi_rst_n    => rx_axi4s_rst_s_n,
            axi4s_s_mosi => rx_axi4s_s_mosi,
            axi4s_s_miso => rx_axi4s_s_miso,
            axi4s_m_mosi => rx_in_axi4s_reg_s_mosi,
            axi4s_m_miso => rx_in_axi4s_reg_s_miso
        );

    tx_output_pipe : entity udp_core_lib.udp_axi4s_pipe
        generic map(
            G_STAGES       => C_TX_OUTPUT_PIPE_STAGES,
            G_BACKPRESSURE => C_AXI4S_PIPE_BACKPRESSURE
        )
        port map(
            axi_clk      => tx_axi4s_m_aclk,
            axi_rst_n    => tx_axi4s_rst_s_n,
            axi4s_s_mosi => tx_out_axi4s_m_mosi,
            axi4s_s_miso => tx_out_axi4s_m_miso,
            axi4s_m_mosi => tx_axi4s_m_mosi,
            axi4s_m_miso => tx_axi4s_m_miso
        );

    ----------------------------------------------------------------------------
    -- Reset Logic: Sync Resets To Various Clks & Pipeline (Helps timing)
    ----------------------------------------------------------------------------
    rx_rst_sync_core_clk_inst : entity common_stfc_lib.reset_sync
        port map(
            clk            => rx_core_clk,
            reset_n        => rx_axi4s_s_areset_n,
            synced_reset   => open,
            synced_reset_n => rx_core_int_rst_n
        );
    rx_rst_sync_phy_clk_inst : entity common_stfc_lib.reset_sync
        port map(
            clk            => rx_axi4s_s_aclk,
            reset_n        => rx_axi4s_s_areset_n,
            synced_reset   => open,
            synced_reset_n => rx_axi4s_int_rst_n
        );
    tx_rst_sync_core_clk_inst : entity common_stfc_lib.reset_sync
        port map(
            clk            => tx_core_clk,
            reset_n        => tx_axi4s_m_areset_n,
            synced_reset   => open,
            synced_reset_n => tx_core_int_rst_n
        );
    tx_rst_sync_phy_clk_inst : entity common_stfc_lib.reset_sync
        port map(
            clk            => tx_axi4s_m_aclk,
            reset_n        => tx_axi4s_m_areset_n,
            synced_reset   => open,
            synced_reset_n => tx_axi4s_int_rst_n
        );
    rx_core_rstn_proc : process(rx_core_clk) is
    begin
        if rising_edge(rx_core_clk) then
            rx_core_rstn_SR <= rx_core_int_rst_n & rx_core_rstn_SR(rx_core_rstn_SR'left downto 1);
        end if;
    end process;
    rx_axi4s_rstn_proc : process(rx_axi4s_s_aclk) is
    begin
        if rising_edge(rx_axi4s_s_aclk) then
            rx_axi4s_rstn_SR <= rx_axi4s_int_rst_n & rx_axi4s_rstn_SR(rx_axi4s_rstn_SR'left downto 1);
        end if;
    end process;
    tx_core_rstn_proc : process(tx_core_clk) is
    begin
        if rising_edge(tx_core_clk) then
            tx_core_rstn_SR <= tx_core_int_rst_n & tx_core_rstn_SR(tx_core_rstn_SR'left downto 1);
        end if;
    end process;
    tx_axi4s_rstn_proc : process(tx_axi4s_m_aclk) is
    begin
        if rising_edge(tx_axi4s_m_aclk) then
            tx_axi4s_rstn_SR <= tx_axi4s_int_rst_n & tx_axi4s_rstn_SR(tx_axi4s_rstn_SR'left downto 1);
        end if;
    end process;
    rx_core_rst_s_n <= rx_core_rstn_SR(0);
    tx_core_rst_s_n <= tx_core_rstn_SR(0);
    rx_axi4s_rst_s_n <= rx_axi4s_rstn_SR(0);
    tx_axi4s_rst_s_n <= tx_axi4s_rstn_SR(0);
    ----------------------------------------------------------------------------
    -- End Of Reset Logic
    ----------------------------------------------------------------------------

end architecture wrapper;
