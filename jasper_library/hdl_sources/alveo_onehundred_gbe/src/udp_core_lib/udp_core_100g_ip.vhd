------------------------------------------------------------------------------
--! @file   udp_core_100g_ip.vhd
--! @page udpcore100gippage UDP Core 100G IP
--!
--! \includedoc esdg_stfc_image.md
--!
--! ### Brief ###
--! This is a top level for a 100GbE instantiation of the UDP Core with record
--! ports broken out into std_logic and std_logic_vectors. This makes the
--! interfaces recognisable to the vendor tools and meets the requirements for
--! packaging as IP.
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

entity udp_core_100g_ip is
    generic(
        G_FPGA_VENDOR           : string  := "xilinx";                                      --! Selects the FPGA Vendor for Compilation
        G_FPGA_FAMILY           : string  := "all";                                         --! Selects the FPGA Family for Compilation
        G_FIFO_IMPLEMENTATION   : string  := "auto";                                        --! Selects how the Fitter implements the FIFO Memory
        G_FIFO_TYPE             : string  := "inferred_mem";                                --! Selects how to implement the Core's FIFOs
        G_NUM_OF_ARP_POS        : natural := 32;                                            --! Number Of Positions In ARP Table
        G_UDP_CLK_FIFOS         : boolean := false;                                         --! Generate Clk Crossing FIFOs At The I/O of UDP Payloads
        G_EXT_CLK_FIFOS         : boolean := false;                                         --! Generate Clk Crossing FIFOs At The I/O of Unsupported Packet Types
        G_TX_EXT_IP_FIFO_CAP    : integer := 2048;                                          --! Capacity In Bytes Of Uns IPV4 Protocol Packets FIFOs in Tx Path
        G_TX_EXT_ETH_FIFO_CAP   : integer := 2048;                                          --! Capacity In Bytes Of Uns Ethernet Type Packets FIFOs in Tx Path
        G_TX_OUT_FIFO_CAP       : integer := 2048;                                          --! Capicity Of FIFO at End Of Tx Path. Necessary For 100GbE But Less Important For 1/10GbE. Can Be Set to 0.
        G_RX_IN_FIFO_CAP        : integer := 2048;                                          --! Capacity Of FIFO at Start Of Rx Path. At least 16 Words Recommended.
        G_RX_INPUT_PIPE_STAGES  : integer := 1;                                             --! Pipeline Stages From External MAC/PHY To Rx Path
        G_INC_PING              : boolean := true;                                          --! Generate Logic For Internal Ping Replies
        G_INC_ARP               : boolean := true;                                          --! Generate Logic For Interal ARP Requests And Replies
        G_CORE_FREQ_KHZ         : integer := 322262;                                        --! KHz Of Tx Path, Used For ARP Refresh Timers, Not Essential
        G_INC_ETH               : boolean := TRUE;                                         --! Generate Logic To Transmit Externally Provided Ethernet Payloads
        G_INC_IPV4              : boolean := TRUE                                          --! Generate Logic To Transmit Externally Provided IPV4 Payloads
    );
    port(
        tx_core_clk             : in  std_logic;                                            --! Tx Path Main Clock, Set To PHY Tx Clock or Set to Lower Clock and Buffer Full Packets Before PHY
        rx_core_clk             : in  std_logic;                                            --! Rx Path Main Clock, can set to PHY Rx Clock, or any f down to ~200MHz
        -- AXI4-Stream Slave Side (UDP Core Transmit Data):
        rx_axis_s_clk           : in  std_logic;                                            --! UDP Core Rx PHY Clock
        rx_axis_s_rst           : in  std_logic;                                            --! UDP Core Rx Active-High Reset
        rx_axis_s_tdata         : in  std_logic_vector(511 downto 0);                       --! Rx Axi4s Signals From PHY
        rx_axis_s_tvalid        : in  std_logic;                                            --! Rx Axi4s Signals From PHY
        rx_axis_s_tkeep         : in  std_logic_vector(63 downto 0);                        --! Rx Axi4s Signals From PHY
        rx_axis_s_tlast         : in  std_logic;                                            --! Rx Axi4s Signals From PHY
        rx_axis_s_tid           : in  std_logic_vector(7 downto 0);                         --! Rx Axi4s Signals From PHY (unused)
        rx_axis_s_tuser         : in  std_logic_vector(31 downto 0);                        --! Rx Axi4s Signals From PHY (unused)
        rx_axis_s_tready        : out std_logic;                                            --! Rx Path Backpressure, only used for debugging
        -- AXI4 Stream Master Out (UDP Core Received Data):
        tx_axis_m_clk           : in  std_logic;                                            --! UDP Core Tx PHY Clock
        tx_axis_m_rst           : in  std_logic;                                            --! UDP Core Tx Active-High Reset
        tx_axis_m_tdata         : out std_logic_vector(511 downto 0);                       --! Tx Axi4s Signals To PHY
        tx_axis_m_tvalid        : out std_logic;                                            --! Tx Axi4s Signals To PHY
        tx_axis_m_tkeep         : out std_logic_vector(63 downto 0);                        --! Tx Axi4s Signals To PHY
        tx_axis_m_tlast         : out std_logic;                                            --! Tx Axi4s Signals To PHY
        tx_axis_m_tid           : out std_logic_vector(7 downto 0);                         --! Tx Axi4s Signals To PHY (unused)
        tx_axis_m_tuser         : out std_logic_vector(31 downto 0);                        --! Tx Axi4s Signals To PHY (unused)
        tx_axis_m_tready        : in  std_logic;                                            --! Tx PHY Backpressure, USED
        -- AXI4-Lite Interface (defined in axi4lite_pkg):
        axi4lite_aclk           : in  std_logic;                                            --! AXI4-Lite Clock
        axi4lite_aresetn        : in  std_logic;                                            --! AXI4-Lite Active-Low Asynchronous Reset
        axi4lite_araddr         : in  std_logic_vector(31 downto 0);                        --! Axi4-Lite Signals
        axi4lite_awaddr         : in  std_logic_vector(31 downto 0);                        --! Axi4-Lite Signals
        axi4lite_arvalid        : in  std_logic;                                            --! Axi4-Lite Signals
        axi4lite_awvalid        : in  std_logic;                                            --! Axi4-Lite Signals
        axi4lite_bready         : in  std_logic;                                            --! Axi4-Lite Signals
        axi4lite_rready         : in  std_logic;                                            --! Axi4-Lite Signals
        axi4lite_wdata          : in  std_logic_vector(31 downto 0);                        --! Axi4-Lite Signals
        axi4lite_wstrb          : in  std_logic_vector(3 downto 0);                         --! Axi4-Lite Signals
        axi4lite_wvalid         : in  std_logic;                                            --! Axi4-Lite Signals
        axi4lite_arready        : out std_logic;                                            --! Axi4-Lite Signals
        axi4lite_awready        : out std_logic;                                            --! Axi4-Lite Signals
        axi4lite_bresp          : out std_logic_vector(1 downto 0);                         --! Axi4-Lite Signals
        axi4lite_bvalid         : out std_logic;                                            --! Axi4-Lite Signals
        axi4lite_rdata          : out std_logic_vector(31 downto 0);                        --! Axi4-Lite Signals
        axi4lite_rresp          : out std_logic_vector(1 downto 0);                         --! Axi4-Lite Signals
        axi4lite_rvalid         : out std_logic;                                            --! Axi4-Lite Signals
        axi4lite_wready         : out std_logic;                                            --! Axi4-Lite Signals
        -- AXI4-Stream Slave Side (UDP Transmit Data):
        udp_axis_s_clk          : in  std_logic;                                            --! UDP Tx In Clk
        udp_axis_s_reset        : in  std_logic;                                            --! UDP Tx In Reset
        udp_axis_s_tdata        : in  std_logic_vector(511 downto 0);                       --! UDP Transmit Axi4s
        udp_axis_s_tvalid       : in  std_logic;                                            --! UDP Transmit Axi4s
        udp_axis_s_tkeep        : in  std_logic_vector(63 downto 0);                        --! UDP Transmit Axi4s
        udp_axis_s_tlast        : in  std_logic;                                            --! UDP Transmit Axi4s
        udp_axis_s_tid          : in  std_logic_vector(7 downto 0);                         --! UDP Transmit Axi4s, route packets via LUT entry using this signal & Farm Mode
        udp_axis_s_tuser        : in  std_logic_vector(31 downto 0);                        --! UDP Transmit Axi4s
        udp_axis_s_tready       : out std_logic;                                            --! UDP Transmit Axi4s
        -- AXI4 Stream Master Out (UDP Received Data):
        udp_axis_m_clk          : in  std_logic;                                            --! UDP Rx Out Clk
        udp_axis_m_reset        : in  std_logic;                                            --! UDP Rx Out Reset
        udp_axis_m_tdata        : out std_logic_vector(511 downto 0);                       --! UDP Received Axi4s
        udp_axis_m_tvalid       : out std_logic;                                            --! UDP Received Axi4s
        udp_axis_m_tkeep        : out std_logic_vector(63 downto 0);                        --! UDP Received Axi4s
        udp_axis_m_tlast        : out std_logic;                                            --! UDP Received Axi4s
        udp_axis_m_tid          : out std_logic_vector(7 downto 0);                         --! UDP Received Axi4s
        udp_axis_m_tuser        : out std_logic_vector(31 downto 0);                        --! UDP Received Axi4s
        udp_axis_m_tready       : in  std_logic;                                            --! UDP Received Axi4s
        -- AXI4-Stream Slave Side (Ethernet Transmit Data):
        eth_axis_s_clk          : in  std_logic                      := '0';                --! Other Ethernet Transmit Interface
        eth_axis_s_reset        : in  std_logic                      := '1';                --! Other Ethernet Transmit Interface
        eth_axis_s_tdata        : in  std_logic_vector(511 downto 0) := (others => '1');    --! Other Ethernet Transmit Interface
        eth_axis_s_tvalid       : in  std_logic                      := '0';                --! Other Ethernet Transmit Interface
        eth_axis_s_tkeep        : in  std_logic_vector(63 downto 0)  := (others => '0');    --! Other Ethernet Transmit Interface
        eth_axis_s_tlast        : in  std_logic                      := '0';                --! Other Ethernet Transmit Interface
        eth_axis_s_tid          : in  std_logic_vector(7 downto 0)   := (others => '0');    --! Other Ethernet Transmit Interface
        eth_axis_s_tuser        : in  std_logic_vector(31 downto 0)  := (others => '0');    --! Other Ethernet Transmit Interface
        eth_axis_s_tready       : out std_logic;                                            --! Other Ethernet Transmit Interface
        -- AXI4 Stream Master Out (Ethernet Received Data):
        eth_axis_m_clk          : in  std_logic                      := '0';                --! Other Ethernet Received Interface
        eth_axis_m_reset        : in  std_logic                      := '1';                --! Other Ethernet Received Interface
        eth_axis_m_tdata        : out std_logic_vector(511 downto 0) := (others => '1');    --! Other Ethernet Received Interface
        eth_axis_m_tvalid       : out std_logic                      := '0';                --! Other Ethernet Received Interface
        eth_axis_m_tkeep        : out std_logic_vector(63 downto 0)  := (others => '0');    --! Other Ethernet Received Interface
        eth_axis_m_tlast        : out std_logic                      := '0';                --! Other Ethernet Received Interface
        eth_axis_m_tid          : out std_logic_vector(7 downto 0)   := (others => '0');    --! Other Ethernet Received Interface
        eth_axis_m_tuser        : out std_logic_vector(31 downto 0)  := (others => '0');    --! Other Ethernet Received Interface
        eth_axis_m_tready       : in  std_logic                      := '0';                --! Other Ethernet Received Interface
        -- AXI4-Stream Slave Side (IPV4 Transmit Data):
        ipv4_axis_s_clk         : in  std_logic                      := '0';                --! Other IPv4 Transmit Interface
        ipv4_axis_s_reset       : in  std_logic                      := '1';                --! Other IPv4 Transmit Interface
        ipv4_axis_s_tdata       : in  std_logic_vector(511 downto 0) := (others => '1');    --! Other IPv4 Transmit Interface
        ipv4_axis_s_tvalid      : in  std_logic                      := '0';                --! Other IPv4 Transmit Interface
        ipv4_axis_s_tkeep       : in  std_logic_vector(63 downto 0)  := (others => '0');    --! Other IPv4 Transmit Interface
        ipv4_axis_s_tlast       : in  std_logic                      := '0';                --! Other IPv4 Transmit Interface
        ipv4_axis_s_tid         : in  std_logic_vector(7 downto 0)   := (others => '0');    --! Other IPv4 Transmit Interface
        ipv4_axis_s_tuser       : in  std_logic_vector(31 downto 0)  := (others => '0');    --! Other IPv4 Transmit Interface
        ipv4_axis_s_tready      : out std_logic;                                            --! Other IPv4 Transmit Interface
        -- AXI4 Stream Master Out (IPV4 Received Data):
        ipv4_axis_m_clk         : in  std_logic                      := '0';                --! Other IPv4 Received Interface
        ipv4_axis_m_reset       : in  std_logic                      := '1';                --! Other IPv4 Received Interface
        ipv4_axis_m_tdata       : out std_logic_vector(511 downto 0) := (others => '1');    --! Other IPv4 Received Interface
        ipv4_axis_m_tvalid      : out std_logic                      := '0';                --! Other IPv4 Received Interface
        ipv4_axis_m_tkeep       : out std_logic_vector(63 downto 0)  := (others => '0');    --! Other IPv4 Received Interface
        ipv4_axis_m_tlast       : out std_logic                      := '0';                --! Other IPv4 Received Interface
        ipv4_axis_m_tid         : out std_logic_vector(7 downto 0)   := (others => '0');    --! Other IPv4 Received Interface
        ipv4_axis_m_tuser       : out std_logic_vector(31 downto 0)  := (others => '0');    --! Other IPv4 Received Interface
        ipv4_axis_m_tready      : in  std_logic                      := '0';                --! Other IPv4 Received Interface
        ext_mac_addr            : in  std_logic_vector(47 downto 0)  := (others => '1');    --! An Optional Mac Address For The Core To Be Set At Board Level
        ext_ip_addr             : in  std_logic_vector(31 downto 0)  := (others => '1');    --! An Optional IP Address For The Core To Be Set At Board Level
        use_ext_addr            : in  std_logic                      := '0'                 --! Use Optional External MAC & IP Addresses
    );
end entity udp_core_100g_ip;

architecture wrapper of udp_core_100g_ip is
    signal axi4lite_mosi : t_axi4lite_mosi;
    signal axi4lite_miso : t_axi4lite_miso;

    signal udp_axis_s_mosi  : t_axi4s_mosi; --! UDP Tx In Data
    signal udp_axis_s_miso  : t_axi4s_miso; --! UDP Tx In Backpressure
    signal udp_axis_m_mosi  : t_axi4s_mosi; --! UDP Tx In Data
    signal udp_axis_m_miso  : t_axi4s_miso; --! UDP Tx In Backpressure
    signal eth_axis_s_mosi  : t_axi4s_mosi; --! UDP Tx In Data
    signal eth_axis_s_miso  : t_axi4s_miso; --! UDP Tx In Backpressure
    signal eth_axis_m_mosi  : t_axi4s_mosi; --! UDP Tx In Data
    signal eth_axis_m_miso  : t_axi4s_miso; --! UDP Tx In Backpressure
    signal ipv4_axis_s_mosi : t_axi4s_mosi; --! UDP Tx In Data
    signal ipv4_axis_s_miso : t_axi4s_miso; --! UDP Tx In Backpressure
    signal ipv4_axis_m_mosi : t_axi4s_mosi; --! UDP Tx In Data
    signal ipv4_axis_m_miso : t_axi4s_miso; --! UDP Tx In Backpressure
    signal xgmii_rx_mosi    : t_xgmii_record;
    signal xgmii_tx_mosi    : t_xgmii_record;
    signal xgmii_tx_ready   : std_logic;
    signal rx_axi4s_s_mosi  : t_axi4s_mosi;
    signal tx_axi4s_m_mosi  : t_axi4s_mosi;
    signal tx_axi4s_m_miso  : t_axi4s_miso;
    signal rx_axi4s_s_miso  : t_axi4s_miso;

begin
    rx_axis_s_tready <= '1';

    udp_axis_s_mosi.tdata(511 downto 0) <= udp_axis_s_tdata;
    udp_axis_s_mosi.tkeep(63 downto 0)  <= udp_axis_s_tkeep;
    udp_axis_s_mosi.tlast               <= udp_axis_s_tlast;
    udp_axis_s_mosi.tvalid              <= udp_axis_s_tvalid;
    udp_axis_s_mosi.tuser               <= udp_axis_s_tuser;
    udp_axis_s_mosi.tid(7 downto 0)     <= udp_axis_s_tid;
    udp_axis_s_tready                   <= udp_axis_s_miso.tready;
    udp_axis_m_tdata                    <= udp_axis_m_mosi.tdata(511 downto 0);
    udp_axis_m_tkeep                    <= udp_axis_m_mosi.tkeep(63 downto 0);
    udp_axis_m_tlast                    <= udp_axis_m_mosi.tlast;
    udp_axis_m_tvalid                   <= udp_axis_m_mosi.tvalid;
    udp_axis_m_tuser                    <= udp_axis_m_mosi.tuser;
    udp_axis_m_tid                      <= udp_axis_m_mosi.tid(7 downto 0);
    udp_axis_m_miso.tready              <= udp_axis_m_tready;

    eth_axis_s_mosi.tdata(511 downto 0) <= eth_axis_s_tdata;
    eth_axis_s_mosi.tkeep(63 downto 0)  <= eth_axis_s_tkeep;
    eth_axis_s_mosi.tlast               <= eth_axis_s_tlast;
    eth_axis_s_mosi.tvalid              <= eth_axis_s_tvalid;
    eth_axis_s_mosi.tuser               <= eth_axis_s_tuser;
    eth_axis_s_mosi.tid(7 downto 0)     <= eth_axis_s_tid;
    eth_axis_s_tready                   <= eth_axis_s_miso.tready;
    eth_axis_m_tdata                    <= eth_axis_m_mosi.tdata(511 downto 0);
    eth_axis_m_tkeep                    <= eth_axis_m_mosi.tkeep(63 downto 0);
    eth_axis_m_tlast                    <= eth_axis_m_mosi.tlast;
    eth_axis_m_tvalid                   <= eth_axis_m_mosi.tvalid;
    eth_axis_m_tuser                    <= eth_axis_m_mosi.tuser;
    eth_axis_m_tid                      <= eth_axis_m_mosi.tid(7 downto 0);
    eth_axis_m_miso.tready              <= eth_axis_m_tready;

    ipv4_axis_s_mosi.tdata(511 downto 0) <= ipv4_axis_s_tdata;
    ipv4_axis_s_mosi.tkeep(63 downto 0)  <= ipv4_axis_s_tkeep;
    ipv4_axis_s_mosi.tlast               <= ipv4_axis_s_tlast;
    ipv4_axis_s_mosi.tvalid              <= ipv4_axis_s_tvalid;
    ipv4_axis_s_mosi.tuser               <= ipv4_axis_s_tuser;
    ipv4_axis_s_mosi.tid(7 downto 0)     <= ipv4_axis_s_tid;
    ipv4_axis_s_tready                   <= ipv4_axis_s_miso.tready;
    ipv4_axis_m_tdata                    <= ipv4_axis_m_mosi.tdata(511 downto 0);
    ipv4_axis_m_tkeep                    <= ipv4_axis_m_mosi.tkeep(63 downto 0);
    ipv4_axis_m_tlast                    <= ipv4_axis_m_mosi.tlast;
    ipv4_axis_m_tvalid                   <= ipv4_axis_m_mosi.tvalid;
    ipv4_axis_m_tuser                    <= ipv4_axis_m_mosi.tuser;
    ipv4_axis_m_tid                      <= ipv4_axis_m_mosi.tid(7 downto 0);
    ipv4_axis_m_miso.tready              <= ipv4_axis_m_tready;

    rx_axi4s_s_mosi.tdata(511 downto 0) <= rx_axis_s_tdata;
    rx_axi4s_s_mosi.tkeep(63 downto 0)  <= rx_axis_s_tkeep;
    rx_axi4s_s_mosi.tlast               <= rx_axis_s_tlast;
    rx_axi4s_s_mosi.tvalid              <= rx_axis_s_tvalid;
    rx_axi4s_s_mosi.tuser               <= rx_axis_s_tuser;
    rx_axi4s_s_mosi.tid(7 downto 0)     <= rx_axis_s_tid;
    tx_axis_m_tdata                     <= tx_axi4s_m_mosi.tdata(511 downto 0);
    tx_axis_m_tkeep                     <= tx_axi4s_m_mosi.tkeep(63 downto 0);
    tx_axis_m_tlast                     <= tx_axi4s_m_mosi.tlast;
    tx_axis_m_tvalid                    <= tx_axi4s_m_mosi.tvalid;
    tx_axis_m_tuser                     <= tx_axi4s_m_mosi.tuser;
    tx_axis_m_tid                       <= tx_axi4s_m_mosi.tid(7 downto 0);
    tx_axi4s_m_miso.tready              <= tx_axis_m_tready;

    axi4lite_mosi.araddr  <= axi4lite_araddr;
    axi4lite_mosi.arvalid <= axi4lite_arvalid;
    axi4lite_mosi.awaddr  <= axi4lite_awaddr;
    axi4lite_mosi.awvalid <= axi4lite_awvalid;
    axi4lite_mosi.bready  <= axi4lite_bready;
    axi4lite_mosi.rready  <= axi4lite_rready;
    axi4lite_mosi.wdata   <= axi4lite_wdata;
    axi4lite_mosi.wstrb   <= axi4lite_wstrb;
    axi4lite_mosi.wvalid  <= axi4lite_wvalid;

    axi4lite_arready <= axi4lite_miso.arready;
    axi4lite_awready <= axi4lite_miso.awready;
    axi4lite_bresp   <= axi4lite_miso.bresp;
    axi4lite_bvalid  <= axi4lite_miso.bvalid;
    axi4lite_rdata   <= axi4lite_miso.rdata;
    axi4lite_rresp   <= axi4lite_miso.rresp;
    axi4lite_rvalid  <= axi4lite_miso.rvalid;
    axi4lite_wready  <= axi4lite_miso.wready;


    udp_core_100g_top_inst : entity udp_core_lib.udp_core_interface_nomac
        generic map(
            G_UDP_CORE_BYTES       => 64,
            G_FPGA_VENDOR          => G_FPGA_VENDOR,
            G_FPGA_FAMILY          => G_FPGA_FAMILY,
            G_FIFO_IMPLEMENTATION  => G_FIFO_IMPLEMENTATION,
            G_FIFO_TYPE            => G_FIFO_TYPE,
            G_NUM_OF_ARP_POS       => G_NUM_OF_ARP_POS,
            G_UDP_CLK_FIFOS        => G_UDP_CLK_FIFOS,
            G_EXT_CLK_FIFOS        => G_EXT_CLK_FIFOS,
            G_TX_EXT_IP_FIFO_CAP   => G_TX_EXT_IP_FIFO_CAP,
            G_TX_EXT_ETH_FIFO_CAP  => G_TX_EXT_ETH_FIFO_CAP,
            G_TX_OUT_FIFO_CAP      => G_TX_OUT_FIFO_CAP,
            G_RX_IN_FIFO_CAP       => G_RX_IN_FIFO_CAP,
            G_RX_INPUT_PIPE_STAGES => G_RX_INPUT_PIPE_STAGES,
            G_INC_PING             => G_INC_PING,
            G_INC_ARP              => G_INC_ARP,
            G_CORE_FREQ_KHZ        => G_CORE_FREQ_KHZ,
            G_INC_ETH              => G_INC_ETH,
            G_INC_IPV4             => G_INC_IPV4
        )
        port map(
            tx_core_clk         => tx_core_clk,
            rx_core_clk         => rx_core_clk,
            rx_axi4s_s_aclk     => rx_axis_s_clk,
            rx_axi4s_s_areset   => rx_axis_s_rst,
            rx_axi4s_s_mosi     => rx_axi4s_s_mosi,
            rx_axi4s_s_miso     => rx_axi4s_s_miso,
            tx_axi4s_m_aclk     => tx_axis_m_clk,
            tx_axi4s_m_areset   => tx_axis_m_rst,
            tx_axi4s_m_miso     => tx_axi4s_m_miso,
            tx_axi4s_m_mosi     => tx_axi4s_m_mosi,
            axi4lite_aclk       => axi4lite_aclk,
            axi4lite_aresetn    => axi4lite_aresetn,
            axi4lite_mosi       => axi4lite_mosi,
            axi4lite_miso       => axi4lite_miso,
            udp_axi4s_s_aclk    => udp_axis_s_clk,
            udp_axi4s_s_areset  => udp_axis_s_reset,
            udp_axi4s_s_mosi    => udp_axis_s_mosi,
            udp_axi4s_s_miso    => udp_axis_s_miso,
            udp_axi4s_m_aclk    => udp_axis_m_clk,
            udp_axi4s_m_areset  => udp_axis_m_reset,
            udp_axi4s_m_miso    => udp_axis_m_miso,
            udp_axi4s_m_mosi    => udp_axis_m_mosi,
            ext_mac_addr        => ext_mac_addr,
            ext_ip_addr         => ext_ip_addr,
            use_ext_addr        => use_ext_addr,
            eth_axi4s_s_aclk    => eth_axis_s_clk,
            eth_axi4s_s_areset  => eth_axis_s_reset,
            eth_axi4s_s_mosi    => eth_axis_s_mosi,
            eth_axi4s_s_miso    => eth_axis_s_miso,
            eth_axi4s_m_aclk    => eth_axis_m_clk,
            eth_axi4s_m_areset  => eth_axis_m_reset,
            eth_axi4s_m_miso    => eth_axis_m_miso,
            eth_axi4s_m_mosi    => eth_axis_m_mosi,
            ipv4_axi4s_s_aclk   => ipv4_axis_s_clk,
            ipv4_axi4s_s_areset => ipv4_axis_s_reset,
            ipv4_axi4s_s_mosi   => ipv4_axis_s_mosi,
            ipv4_axi4s_s_miso   => ipv4_axis_s_miso,
            ipv4_axi4s_m_aclk   => ipv4_axis_m_clk,
            ipv4_axi4s_m_areset => ipv4_axis_m_reset,
            ipv4_axi4s_m_miso   => ipv4_axis_m_miso,
            ipv4_axi4s_m_mosi   => ipv4_axis_m_mosi
        );

end architecture wrapper;
