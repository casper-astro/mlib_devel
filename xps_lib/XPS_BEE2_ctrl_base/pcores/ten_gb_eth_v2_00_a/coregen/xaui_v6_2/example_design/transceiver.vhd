-------------------------------------------------------------------------------
-- Title : RocketIO transceiver container
-- Project : XAUI
-------------------------------------------------------------------------------
-- File : transceiver.vhd
-------------------------------------------------------------------------------
-- This entity contains a single RocketIO transceiver primitive and some
-- associated circuitry to handle reclocking of a control signal.

library ieee;
use ieee.std_logic_1164.all;

entity transceiver  is
  generic (
    CHBONDMODE : string := "OFF");
  port (
    reset        : in  std_logic;
    clk          : in  std_logic;
    brefclk      : in  std_logic;
    brefclk2     : in  std_logic;
    refclksel    : in  std_logic;
    dcm_locked   : in  std_logic;
    txdata       : in  std_logic_vector(15 downto 0);
    txcharisk    : in  std_logic_vector(1 downto 0);
    txp          : out std_logic;
    txn          : out std_logic;
    rxdata       : out std_logic_vector(15 downto 0);
    rxcharisk    : out std_logic_vector(1 downto 0);
    rxp          : in  std_logic;
    rxn          : in  std_logic;
    loopback_ser : in  std_logic;
    powerdown    : in  std_logic;
    chbondi      : in  std_logic_vector(3 downto 0);
    chbondo      : out std_logic_vector(3 downto 0);
    enable_align : in  std_logic;
    syncok       : out std_logic;
    enchansync   : in  std_logic;
    code_valid   : out std_logic_vector(1 downto 0);
    code_comma   : out std_logic_vector(1 downto 0);
    mgt_tx_reset : out std_logic;
    mgt_rx_reset : out std_logic);

end transceiver;

-------------------------------------------------------------------------------

library unisim;
use unisim.vcomponents.all;
architecture rtl of transceiver is
  
  signal rxbufstatus                     : std_logic_vector(1 downto 0);
  signal rxlossofsync                    : std_logic_vector(1 downto 0);
  signal rxrealign, rxrecclk, rxcommadet : std_logic;
  signal loopback                        : std_logic_vector(1 downto 0);
  signal rxnotintable                    : std_logic_vector(1 downto 0);
  signal rxdisperr                       : std_logic_vector(1 downto 0);
  signal txbuferr                        : std_logic;
  signal rx_rst_state                    : std_logic_vector(3 downto 0);
  signal tx_rst_state                    : std_logic_vector(3 downto 0);
  signal mgt_tx_reset_int                : std_logic;
  signal mgt_rx_reset_int                : std_logic;
  signal enable_align_mgt                : std_logic;
  
  attribute ASYNC_REG                     : string;
  attribute ASYNC_REG of rx_rst_state     : signal is "TRUE";
  attribute ASYNC_REG of mgt_rx_reset_int : signal is "TRUE";
  attribute ASYNC_REG of tx_rst_state     : signal is "TRUE";
  attribute ASYNC_REG of mgt_tx_reset_int : signal is "TRUE";
  attribute ASYNC_REG of reclock_align    : label is "TRUE";

begin  -- rtl
  loopback(1)   <= loopback_ser;
  loopback(0)   <= '0';
  code_valid(1) <= not (rxnotintable(1) or rxdisperr(1));
  code_valid(0) <= not (rxnotintable(0) or rxdisperr(0));
  syncok        <= not rxlossofsync(1);

  mgt : gt_xaui_2
    generic map (
      REF_CLK_V_SEL            => 1,
      CHAN_BOND_MODE           => CHBONDMODE,
      CHAN_BOND_ONE_SHOT       => false,
      RX_LOSS_OF_SYNC_FSM      => false)
    port map (
      CHBONDDONE     => open,
      CHBONDO        => chbondo,
      CONFIGOUT      => open,
      RXBUFSTATUS    => rxbufstatus,
      RXCHARISCOMMA  => code_comma,
      RXCHARISK      => rxcharisk,
      RXCHECKINGCRC  => open,
      RXCLKCORCNT    => open,
      RXCOMMADET     => rxcommadet,
      RXCRCERR       => open,
      RXDATA         => rxdata,
      RXDISPERR      => rxdisperr,
      RXLOSSOFSYNC   => rxlossofsync,
      RXNOTINTABLE   => rxnotintable,
      RXREALIGN      => rxrealign,
      RXRECCLK       => rxrecclk,
      RXRUNDISP      => open,
      TXBUFERR       => txbuferr,
      TXKERR         => open,
      TXN            => txn,
      TXP            => txp,
      TXRUNDISP      => open,
      CHBONDI        => chbondi,
      CONFIGENABLE   => '0',
      CONFIGIN       => '0',
      ENCHANSYNC     => enchansync,
      ENMCOMMAALIGN  => enable_align_mgt,
      ENPCOMMAALIGN  => enable_align_mgt,
      LOOPBACK       => loopback,
      POWERDOWN      => powerdown,
      BREFCLK        => brefclk,
      BREFCLK2       => brefclk2,
      REFCLK         => '0',
      REFCLK2        => '0',
      REFCLKSEL      => refclksel,
      RXN            => rxn,
      RXP            => rxp,
      RXPOLARITY     => '0',
      RXRESET        => mgt_rx_reset_int,
      RXUSRCLK       => clk,
      RXUSRCLK2      => clk,
      TXBYPASS8B10B  => "00",
      TXCHARDISPMODE => "00",
      TXCHARDISPVAL  => "00",
      TXCHARISK      => txcharisk,
      TXDATA         => txdata,
      TXFORCECRCERR  => '0',
      TXINHIBIT      => '0',
      TXPOLARITY     => '0',
      TXRESET        => mgt_tx_reset_int,
      TXUSRCLK       => clk,
      TXUSRCLK2      => clk);

  -- The placement of this register with respect to the RocketIO transceiver is
  -- critical; please refer to the User Constraint File and the LogiCORE XAUI
  -- User Guide for a detailed description.
  reclock_align : FD
    port map (
      D => enable_align,
      C => rxrecclk,
      Q => enable_align_mgt);

  -- Babysitting reset for RocketIO transceiver transmit
  -- resets. RocketIO transceiver is held in reset if DCM is not
  -- locked or if there has been an error in the buffer.
  p_mgt_tx_reset : process (clk, dcm_locked)
  begin
    if dcm_locked = '0' then
      tx_rst_state <= (others => '1');
      mgt_tx_reset_int <= '1';
    elsif clk'event and clk = '1' then
      if txbuferr = '1' or reset = '1' then
        tx_rst_state <= (others => '1');
        mgt_tx_reset_int <= '1';
      else
        tx_rst_state <= '0' & tx_rst_state(3 downto 1);
        mgt_tx_reset_int <= tx_rst_state(0);
      end if;
    end if;
  end process p_mgt_tx_reset;
  mgt_tx_reset <= mgt_tx_reset_int;
    
  p_mgt_rx_reset : process (clk, dcm_locked)
  begin
    if dcm_locked = '0' then
      rx_rst_state     <= (others => '1');
      mgt_rx_reset_int <= '1';
    elsif clk'event and clk = '1' then
      if rxbufstatus(1) = '1' or reset = '1' then
        rx_rst_state     <= (others => '1');
        mgt_rx_reset_int <= '1';
      else
        rx_rst_state <= '0' & rx_rst_state(3 downto 1);
        mgt_rx_reset_int <= rx_rst_state(0);
      end if;
    end if;
  end process p_mgt_rx_reset;
  mgt_rx_reset <= mgt_rx_reset_int;


end rtl;
