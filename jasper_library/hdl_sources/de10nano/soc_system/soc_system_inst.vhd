	component soc_system is
		port (
			axi_bridge_0_m0_awaddr  : out   std_logic_vector(20 downto 0);                    -- awaddr
			axi_bridge_0_m0_awprot  : out   std_logic_vector(2 downto 0);                     -- awprot
			axi_bridge_0_m0_awvalid : out   std_logic;                                        -- awvalid
			axi_bridge_0_m0_awready : in    std_logic                     := 'X';             -- awready
			axi_bridge_0_m0_wdata   : out   std_logic_vector(31 downto 0);                    -- wdata
			axi_bridge_0_m0_wstrb   : out   std_logic_vector(3 downto 0);                     -- wstrb
			axi_bridge_0_m0_wlast   : out   std_logic;                                        -- wlast
			axi_bridge_0_m0_wvalid  : out   std_logic;                                        -- wvalid
			axi_bridge_0_m0_wready  : in    std_logic                     := 'X';             -- wready
			axi_bridge_0_m0_bresp   : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- bresp
			axi_bridge_0_m0_bvalid  : in    std_logic                     := 'X';             -- bvalid
			axi_bridge_0_m0_bready  : out   std_logic;                                        -- bready
			axi_bridge_0_m0_araddr  : out   std_logic_vector(20 downto 0);                    -- araddr
			axi_bridge_0_m0_arprot  : out   std_logic_vector(2 downto 0);                     -- arprot
			axi_bridge_0_m0_arvalid : out   std_logic;                                        -- arvalid
			axi_bridge_0_m0_arready : in    std_logic                     := 'X';             -- arready
			axi_bridge_0_m0_rdata   : in    std_logic_vector(31 downto 0) := (others => 'X'); -- rdata
			axi_bridge_0_m0_rresp   : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- rresp
			axi_bridge_0_m0_rvalid  : in    std_logic                     := 'X';             -- rvalid
			axi_bridge_0_m0_rready  : out   std_logic;                                        -- rready
			clk_clk                 : in    std_logic                     := 'X';             -- clk
			memory_mem_a            : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba           : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck           : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n         : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke          : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n         : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n        : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n        : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n         : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n      : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq           : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs          : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n        : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt          : out   std_logic;                                        -- mem_odt
			memory_mem_dm           : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin        : in    std_logic                     := 'X'              -- oct_rzqin
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			axi_bridge_0_m0_awaddr  => CONNECTED_TO_axi_bridge_0_m0_awaddr,  -- axi_bridge_0_m0.awaddr
			axi_bridge_0_m0_awprot  => CONNECTED_TO_axi_bridge_0_m0_awprot,  --                .awprot
			axi_bridge_0_m0_awvalid => CONNECTED_TO_axi_bridge_0_m0_awvalid, --                .awvalid
			axi_bridge_0_m0_awready => CONNECTED_TO_axi_bridge_0_m0_awready, --                .awready
			axi_bridge_0_m0_wdata   => CONNECTED_TO_axi_bridge_0_m0_wdata,   --                .wdata
			axi_bridge_0_m0_wstrb   => CONNECTED_TO_axi_bridge_0_m0_wstrb,   --                .wstrb
			axi_bridge_0_m0_wlast   => CONNECTED_TO_axi_bridge_0_m0_wlast,   --                .wlast
			axi_bridge_0_m0_wvalid  => CONNECTED_TO_axi_bridge_0_m0_wvalid,  --                .wvalid
			axi_bridge_0_m0_wready  => CONNECTED_TO_axi_bridge_0_m0_wready,  --                .wready
			axi_bridge_0_m0_bresp   => CONNECTED_TO_axi_bridge_0_m0_bresp,   --                .bresp
			axi_bridge_0_m0_bvalid  => CONNECTED_TO_axi_bridge_0_m0_bvalid,  --                .bvalid
			axi_bridge_0_m0_bready  => CONNECTED_TO_axi_bridge_0_m0_bready,  --                .bready
			axi_bridge_0_m0_araddr  => CONNECTED_TO_axi_bridge_0_m0_araddr,  --                .araddr
			axi_bridge_0_m0_arprot  => CONNECTED_TO_axi_bridge_0_m0_arprot,  --                .arprot
			axi_bridge_0_m0_arvalid => CONNECTED_TO_axi_bridge_0_m0_arvalid, --                .arvalid
			axi_bridge_0_m0_arready => CONNECTED_TO_axi_bridge_0_m0_arready, --                .arready
			axi_bridge_0_m0_rdata   => CONNECTED_TO_axi_bridge_0_m0_rdata,   --                .rdata
			axi_bridge_0_m0_rresp   => CONNECTED_TO_axi_bridge_0_m0_rresp,   --                .rresp
			axi_bridge_0_m0_rvalid  => CONNECTED_TO_axi_bridge_0_m0_rvalid,  --                .rvalid
			axi_bridge_0_m0_rready  => CONNECTED_TO_axi_bridge_0_m0_rready,  --                .rready
			clk_clk                 => CONNECTED_TO_clk_clk,                 --             clk.clk
			memory_mem_a            => CONNECTED_TO_memory_mem_a,            --          memory.mem_a
			memory_mem_ba           => CONNECTED_TO_memory_mem_ba,           --                .mem_ba
			memory_mem_ck           => CONNECTED_TO_memory_mem_ck,           --                .mem_ck
			memory_mem_ck_n         => CONNECTED_TO_memory_mem_ck_n,         --                .mem_ck_n
			memory_mem_cke          => CONNECTED_TO_memory_mem_cke,          --                .mem_cke
			memory_mem_cs_n         => CONNECTED_TO_memory_mem_cs_n,         --                .mem_cs_n
			memory_mem_ras_n        => CONNECTED_TO_memory_mem_ras_n,        --                .mem_ras_n
			memory_mem_cas_n        => CONNECTED_TO_memory_mem_cas_n,        --                .mem_cas_n
			memory_mem_we_n         => CONNECTED_TO_memory_mem_we_n,         --                .mem_we_n
			memory_mem_reset_n      => CONNECTED_TO_memory_mem_reset_n,      --                .mem_reset_n
			memory_mem_dq           => CONNECTED_TO_memory_mem_dq,           --                .mem_dq
			memory_mem_dqs          => CONNECTED_TO_memory_mem_dqs,          --                .mem_dqs
			memory_mem_dqs_n        => CONNECTED_TO_memory_mem_dqs_n,        --                .mem_dqs_n
			memory_mem_odt          => CONNECTED_TO_memory_mem_odt,          --                .mem_odt
			memory_mem_dm           => CONNECTED_TO_memory_mem_dm,           --                .mem_dm
			memory_oct_rzqin        => CONNECTED_TO_memory_oct_rzqin         --                .oct_rzqin
		);

