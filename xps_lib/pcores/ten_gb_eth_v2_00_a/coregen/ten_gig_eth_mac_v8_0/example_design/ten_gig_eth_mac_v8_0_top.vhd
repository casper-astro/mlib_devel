-------------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:22 $
-------------------------------------------------------------------------------
-- File       : CompName_TOP.vhd  
-- Author     : Xilinx Inc.
-------------------------------------------------------------------------------
-- Description: This is the top level vhdl code for the Ten Gigabit Etherent MAC
-------------------------------------------------------------------------------

library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

entity ten_gig_eth_mac_v8_0_top is
  port(
    ---------------------------------------------------------------------------
    -- Interface to the host.
    ---------------------------------------------------------------------------
    reset          : in  std_logic                     -- Resets the MAC.
;
    tx_clk         : out  std_logic;                    -- The transmit clock back to the host.
	tx_ifg_delay   : in   std_logic_vector(7 downto 0); -- Temporary. IFG delay.
    tx_statistics_vector : out std_logic_vector(24 downto 0); -- Statistics information on the last frame.
    tx_statistics_valid  : out std_logic;                     -- High when stats are valid.

    pause_val      : in  std_logic_vector(15 downto 0); -- Indicates the length of the pause that should be transmitted.
    pause_req      : in  std_logic                     -- A '1' indicates that a pause frame should  be sent.
;
    rx_clk               : out std_logic;                     -- The RX clock from the reconcilliation sublayer.
    rx_statistics_vector : out std_logic_vector(28 downto 0); -- Statistics info on the last received frame.
    rx_statistics_valid  : out std_logic                      -- High when above stats are valid.
;
    configuration_vector : in std_logic_vector(66 downto 0)
;
    gtx_clk        : in  std_logic;                     -- The global transmit clock from the outside world.
    xgmii_txd      : out std_logic_vector(63 downto 0); -- Transmitted data
    xgmii_txc      : out std_logic_vector(7 downto 0)  -- Transmitted control
;
    xgmii_rx_clk   : in  std_logic;                     -- The rx clock from the PHY layer.
    xgmii_rxd      : in  std_logic_vector(63 downto 0); -- Received data
    xgmii_rxc      : in  std_logic_vector(7 downto 0)  -- received control
);
end ten_gig_eth_mac_v8_0_top;


architecture wrapper of ten_gig_eth_mac_v8_0_top is
  
  -----------------------------------------------------------------------------
  -- Component Declaration for XGMAC (the 10Gb/E MAC core).
  ----------------------------------------------------------------------------- 
    component ten_gig_eth_mac_v8_0
    port (
    reset          : in  std_logic
;
    tx_underrun    : in  std_logic;
    tx_data        : in  std_logic_vector(63 downto 0);
    tx_data_valid  : in  std_logic_vector(7 downto 0); 
    tx_start       : in  std_logic;
    tx_ack         : out std_logic;
    tx_ifg_delay   : in   std_logic_vector(7 downto 0);
    tx_statistics_vector : out std_logic_vector(24 downto 0);
    tx_statistics_valid  : out std_logic;
    pause_val      : in  std_logic_vector(15 downto 0);
    pause_req      : in  std_logic
;
    rx_data        : out std_logic_vector(63 downto 0);
    rx_data_valid  : out std_logic_vector(7 downto 0);
    rx_good_frame  : out std_logic;
    rx_bad_frame   : out std_logic;
    rx_statistics_vector : out std_logic_vector(28 downto 0);
    rx_statistics_valid  : out std_logic
;
    configuration_vector : in std_logic_vector(66 downto 0)

;
    tx_clk0        : in  std_logic;
    tx_dcm_lock    : in  std_logic;
    xgmii_txd      : out std_logic_vector(63 downto 0);
    xgmii_txc      : out std_logic_vector(7 downto 0)
;
    rx_clk0        : in  std_logic;
    rx_dcm_lock    : in  std_logic;
    xgmii_rxd      : in  std_logic_vector(63 downto 0); 
    xgmii_rxc      : in  std_logic_vector(7 downto 0)
  );
  end component;

  -----------------------------------------------------------------------------
  -- Component declaration for the client loopback design.
  -----------------------------------------------------------------------------
  component client_loopback
   port (
      reset                : in  std_logic;  -- asynchronous reset
      tx_data              : out std_logic_vector(63 downto 0);
      tx_data_valid        : out std_logic_vector(7 downto 0);
      tx_underrun          : out std_logic;
      tx_start             : out std_logic;
      tx_ack               : in  std_logic;
      tx_clk               : in  std_logic;
      rx_data              : in  std_logic_vector(63 downto 0);
      rx_data_valid        : in  std_logic_vector(7 downto 0);
      rx_good_frame        : in  std_logic;
      rx_bad_frame         : in  std_logic;
      rx_clk               : in  std_logic;
      overflow             : out std_logic
      );
  end component;


  constant D_LOCAL_FAULT : bit_vector(63 downto 0) := X"0100009C0100009C";
  constant C_LOCAL_FAULT : bit_vector(7 downto 0) := "00010001";

  -----------------------------------------------------------------------------
  -- Internal Signal Declaration for XGMAC (the 10Gb/E MAC core).
  -----------------------------------------------------------------------------  
  signal reset_terms_tx      : std_logic;
  signal reset_terms_rx      : std_logic;
  signal gtx_clk_dcm        : std_logic;
  signal tx_dcm_clk0        : std_logic;
  signal tx_dcm_clk90       : std_logic;
  signal tx_dcm_clk180      : std_logic;
  signal tx_dcm_clk270      : std_logic;
  signal tx_dcm_locked      : std_logic;
  signal tx_dcm_locked_reg  : std_logic;  -- Registered version (TX_CLK0)

  signal tx_clk0, tx_clk90 : std_logic;  -- transmit clocks on global routing
  signal tx_clk180, tx_clk270 : std_logic;
  signal txd_out : std_logic_vector(63 downto 0);
  signal txc_out : std_logic_vector(7 downto 0);
  signal xgmii_txd_int : std_logic_vector(63 downto 0);
  signal xgmii_txc_int : std_logic_vector(7 downto 0);
  signal rx_dcm_locked      : std_logic;  -- Locked signal from RX DCM
  signal rx_dcm_locked_reg  : std_logic;  -- registered version (RX_CLK0)

  signal xgmii_rx_clk_dcm : std_logic;
  signal rx_clk0 : std_logic;
  signal rx_clk180 : std_logic;
  signal rx_dcm_clk0 : std_logic;
  signal rx_dcm_clk180 : std_logic;
  signal rxd_sdr : std_logic_vector(63 downto 0);
  signal rxc_sdr : std_logic_vector(7 downto 0);
  signal xgmii_rxd_core : std_logic_vector(63 downto 0);
  signal xgmii_rxc_core : std_logic_vector(7 downto 0);

  signal vcc, gnd : std_logic;
  signal rx_statistics_vector_int : std_logic_vector(28 downto 0);
  signal rx_statistics_valid_int  : std_logic;
  signal tx_statistics_vector_int : std_logic_vector(24 downto 0);
  signal tx_statistics_valid_int  : std_logic;
  
  signal configuration_vector_core : std_logic_vector(66 downto 0);
  signal tx_data       : std_logic_vector(63 downto 0);
  signal tx_data_valid : std_logic_vector(7 downto 0);
  signal tx_underrun   : std_logic;
  signal tx_start      : std_logic;
  signal tx_ack        : std_logic;
  signal rx_data       : std_logic_vector(63 downto 0);
  signal rx_data_valid : std_logic_vector(7 downto 0);
  signal rx_good_frame : std_logic;
  signal rx_bad_frame  : std_logic;
  signal overflow      : std_logic;

  attribute INIT : string;

    attribute keep : string;
    attribute keep of tx_data : signal is "true";
    attribute keep of tx_data_valid : signal is "true";
    attribute keep of tx_start : signal is "true";
    attribute keep of tx_ack : signal is "true";
    attribute keep of tx_underrun : signal is "true";
    attribute keep of rx_data : signal is "true";
    attribute keep of rx_data_valid : signal is "true";
    attribute keep of rx_good_frame : signal is "true";
    attribute keep of rx_bad_frame  : signal is "true";

  function bit_to_string (
    constant b : bit)
    return string is
  begin  -- bit_to_string
    if b = '1' then
      return "1";
    else
      return "0";
    end if;
  end bit_to_string;

begin
  vcc <= '1';
  gnd <= '0';

  ------------------------------
  -- Instantiate the XGMAC core
  ------------------------------
  xgmac_core : ten_gig_eth_mac_v8_0
    port map (
      reset                => reset
,
      tx_underrun          => tx_underrun,
      tx_data              => tx_data,
      tx_data_valid        => tx_data_valid,
      tx_start             => tx_start,
      tx_ack               => tx_ack,
      tx_ifg_delay         => tx_ifg_delay,
      tx_statistics_vector => tx_statistics_vector_int,
      tx_statistics_valid  => tx_statistics_valid_int,
      pause_val            => pause_val,
      pause_req            => pause_req
,
      rx_data              => rx_data,
      rx_data_valid        => rx_data_valid,
      rx_good_frame        => rx_good_frame,
      rx_bad_frame         => rx_bad_frame,
      rx_statistics_vector => rx_statistics_vector_int,
      rx_statistics_valid  => rx_statistics_valid_int
,
      configuration_vector => configuration_vector_core
,
      tx_clk0       => tx_clk0,
      tx_dcm_lock   => tx_dcm_locked_reg,
      xgmii_txd     => txd_out,
      xgmii_txc     => txc_out
,
      rx_clk0       => rx_clk0,
      rx_dcm_lock   => rx_dcm_locked_reg,
      xgmii_rxd     => xgmii_rxd_core,
      xgmii_rxc     => xgmii_rxc_core
      );
 
      xgmii_rxd_core  <= rxd_sdr after 1 ns;
      xgmii_rxc_core  <= rxc_sdr after 1 ns;


  -------------------------------------------
  -- Instantiate the example client loopback.
  -------------------------------------------
  design_example : client_loopback
    port map (
      reset                => reset,
      tx_data              => tx_data,
      tx_data_valid        => tx_data_valid,
      tx_underrun          => tx_underrun,
      tx_start             => tx_start,
      tx_ack               => tx_ack,
      tx_clk               => tx_clk0,
      rx_data              => rx_data,
      rx_data_valid        => rx_data_valid,
      rx_good_frame        => rx_good_frame,
      rx_bad_frame         => rx_bad_frame,
      rx_clk               => rx_clk0,
      overflow             => overflow);


-------------------------------------------------------------------------------
-- Core reset is handled here. 
-- Core is held in reset for two clock cycles after dcm(s) have
-- have locked up. DCMs going out of lock will also reset the core
-- and keep it there until the DCM has relocked.
-------------------------------------------------------------------------------

  reset_terms_tx <= (not tx_dcm_locked);
  reset_terms_rx <= (not rx_dcm_locked);

  -- apply the RX block reset
  configuration_vector_core(52) <= configuration_vector(52) or reset_terms_rx;

  -- Flow control reset 
  -- reset rx side registers if RX DCM goes out of lock, 
  configuration_vector_core(62) <= configuration_vector(62) or reset_terms_rx;
  -- reset tx side registers if tx dcm goes out of lock
  configuration_vector_core(63) <= configuration_vector(63) or reset_terms_tx;

  -- Transmit Block Reset
  configuration_vector_core(59) <= configuration_vector(59) or reset_terms_tx;
  configuration_vector_core(51 downto 0) <= configuration_vector(51 downto 0);
  configuration_vector_core(58 downto 53) <= configuration_vector(58 downto 53);
  configuration_vector_core(61 downto 60) <= configuration_vector(61 downto 60);
  configuration_vector_core(66 downto 64) <= configuration_vector(66 downto 64);


  -- Transmit clock management
  gtx_clk_ibufg : IBUFG
    port map (
      I => gtx_clk,
      O => gtx_clk_dcm);

  -- Clock management
  tx_dcm : DCM
    port map (
      CLKIN           => gtx_clk_dcm,
      CLKFB           => tx_clk0,
      RST             => reset,
      DSSEN           => gnd,
      PSINCDEC        => gnd,
      PSEN            => gnd,
      PSCLK           => gnd,
      CLK0            => tx_dcm_clk0,
      CLK90           => tx_dcm_clk90, 
      CLK180          => tx_dcm_clk180,
      CLK270          => tx_dcm_clk270,
      CLK2X           => open,
      CLK2X180        => open, 
      CLKDV           => open, 
      CLKFX           => open, 
      CLKFX180        => open, 
      LOCKED          => tx_dcm_locked,
      STATUS          => open, 
      PSDONE          => open);

  tx_bufg0 : BUFG
    port map (
      I => tx_dcm_clk0,
      O => tx_clk0);

  tx_bufg90 : BUFG
    port map (
      I => tx_dcm_clk90,
      O => tx_clk90);

  tx_bufg180 : BUFG
    port map (
      I => tx_dcm_clk180,
      O => tx_clk180);

  tx_bufg270 : BUFG
    port map (
      I => tx_dcm_clk270,
      O => tx_clk270);

  -- We are explicitly instancing an OBUF for this signal because if we 
  -- make a simple assignement and rely on XST to put the OBUF in, it 
  -- will munge the name of the tx_clk0 net into a new name and the UCF 
  -- clock constraint will no longer attach in ngdbuild.
  tx_clk_obuf : OBUF
    port map (
      I => tx_clk0,
      O => tx_clk);
  

  -- Register the dcm_locked signal into the system clock domain
  p_tx_dcm_locked : process (tx_clk0)
  begin
    if tx_clk0'event and tx_clk0 = '1' then
      tx_dcm_locked_reg <= tx_dcm_locked;
    end if;
  end process p_tx_dcm_locked;

  -- receive clock management
  --  Global input clock buffer for Receiver Clock
  xgmii_rx_clk_ibufg : IBUFG
    port map (
      I => xgmii_rx_clk,
      O => xgmii_rx_clk_dcm);
  
  rx_dcm : DCM
    port map (
      CLKIN    => xgmii_rx_clk_dcm,
      CLKFB    => rx_clk0,
      RST      => reset,
      DSSEN    => gnd,
      PSINCDEC => gnd,
      PSEN     => gnd,
      PSCLK    => gnd,
      CLK0     => rx_dcm_clk0,
      CLK90    => open,
      CLK180   => rx_dcm_clk180,
      CLK270   => open,
      CLK2X    => open,
      CLK2X180 => open,
      CLKDV    => open,
      CLKFX    => open,
      CLKFX180 => open,
      LOCKED   => rx_dcm_locked,
      STATUS   => open,
      PSDONE   => open);                                   

  rx_bufg0 : BUFG
    port map(
      I => rx_dcm_clk0,
      O => rx_clk0);

  rx_bufg180 : BUFG
   port map (
      I => rx_dcm_clk180,
      O => rx_clk180);

  -- We are explicitly instancing an OBUF for this signal because if we 
  -- make a simple assignement and rely on XST to put the OBUF in, it 
  -- will munge the name of the rx_clk0 net into a new name and the UCF 
  -- clock constraint will no longer attach in ngdbuild.

  rx_clk_obuf : OBUF
    port map (
      I => rx_clk0,
      O => rx_clk);
  
  -- Register the dcm_locked signal into the system clock domain
  p_rx_dcm_locked : process (rx_clk0)
  begin
    if rx_clk0'event and rx_clk0 = '1' then
      rx_dcm_locked_reg <= rx_dcm_locked;
    end if;
  end process p_rx_dcm_locked;



  -- infer some registers which should go into the IOBs
  P_INPUT_FF : process (rx_clk0)
  begin
    if rx_clk0'event and rx_clk0 = '1' then
      rxd_sdr <= xgmii_rxd;
      rxc_sdr <= xgmii_rxc;
    end if;
  end process P_INPUT_FF;

  G_OUTPUT_FF_D : for I in 0 to 63 generate
    attribute INIT of txd_oreg : label is bit_to_string(D_LOCAL_FAULT(I));
  begin
    txd_oreg : FD
      -- synthesis translate_off
      generic map (
        INIT => D_LOCAL_FAULT(I))
      -- synthesis translate_on
      port map (
        Q  => xgmii_txd(I),
        C  => tx_clk0,
        D  => txd_out(I));
  end generate;

  G_OUTPUT_FF_C : for I in 0 to 7 generate
    attribute INIT of txc_oreg : label is bit_to_string(C_LOCAL_FAULT(I));
  begin
    txc_oreg : FD
      -- synthesis translate_off
      generic map (
        INIT => C_LOCAL_FAULT(I))
      -- synthesis translate_on
      port map (
        Q  => xgmii_txc(I),
        C  => tx_clk0,
        D  => txc_out(I));
  end generate;

          
   
   txstatvectorreg: process (reset, tx_clk0)
      begin
      if reset = '1' then
         tx_statistics_vector      <= (others => '0');
         tx_statistics_valid       <= '0';
      elsif tx_clk0'event and tx_clk0 = '1' then
         tx_statistics_vector      <= tx_statistics_vector_int;
         tx_statistics_valid       <= tx_statistics_valid_int;
      end if;
   end process txstatvectorreg;
   rxstatvectorreg: process (reset, rx_clk0)
      begin
      if reset = '1' then
         rx_statistics_vector      <= (others => '0');
         rx_statistics_valid       <= '0';
      elsif rx_clk0'event and rx_clk0 = '1' then
         rx_statistics_vector      <= rx_statistics_vector_int;
         rx_statistics_valid       <= rx_statistics_valid_int;
      end if;
   end process rxstatvectorreg;


end wrapper;


