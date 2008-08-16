--  Copyright (c) 2005-2006, Regents of the University of California
--  All rights reserved.
--
--  Redistribution and use in source and binary forms, with or without modification,
--  are permitted provided that the following conditions are met:
--
--      - Redistributions of source code must retain the above copyright notice,
--          this list of conditions and the following disclaimer.
--      - Redistributions in binary form must reproduce the above copyright
--          notice, this list of conditions and the following disclaimer
--          in the documentation and/or other materials provided with the
--          distribution.
--      - Neither the name of the University of California, Berkeley nor the
--          names of its contributors may be used to endorse or promote
--          products derived from this software without specific prior
--          written permission.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
--  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
--  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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

entity transceiver is
  generic (
    CHBONDMODE : string  := "OFF";
    CONNECTOR  : integer := 0;
    CHANNEL    : integer := 0
  );
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

  function reclock_loc(
  	connector : integer;
  	channel	  : integer
  ) return string is
  begin
    case connector is
	  when 0 =>
		case channel is
		  when 0 => return "SLICE_X15Y200";
		  when 1 => return "SLICE_X27Y200";
		  when 2 => return "SLICE_X39Y200";
		  when 3 => return "SLICE_X63Y200";
		  when others =>
		end case;
	  when 1 =>
		case channel is
		  when 0 => return "SLICE_X75Y200";
		  when 1 => return "SLICE_X87Y200";
		  when 2 => return "SLICE_X99Y200";
		  when 3 => return "SLICE_X123Y200";
		  when others =>
		end case;
	  when 2 =>
		case channel is
		  when 0 => return "SLICE_X14Y0";
		  when 1 => return "SLICE_X26Y0";
		  when 2 => return "SLICE_X38Y0";
		  when 3 => return "SLICE_X96Y0";
		  when others =>
		end case;
	  when 3 =>
		case channel is
		  when 0 => return "SLICE_X74Y0"; 
		  when 1 => return "SLICE_X86Y0"; 
		  when 2 => return "SLICE_X98Y0"; 
		  when 3 => return "SLICE_X121Y0";
		  when others =>
		end case;
	  when others =>
    end case;
  end;

  function pin_loc(
  	connector : integer;
  	channel	  : integer;
  	pin       : string
  ) return string is
  begin
    if connector = 0 then
      if channel = 0 then
        if pin = "rxn" then return "A38"; end if; if pin = "rxp" then return "A39"; end if; if pin = "txn" then return "A41"; end if; if pin = "txp" then return "A40"; end if;
      end if;
      if channel = 1 then
        if pin = "rxn" then return "A34"; end if; if pin = "rxp" then return "A35"; end if; if pin = "txn" then return "A37"; end if; if pin = "txp" then return "A36"; end if;
      end if;
      if channel = 2 then
        if pin = "rxn" then return "A30"; end if; if pin = "rxp" then return "A31"; end if; if pin = "txn" then return "A33"; end if; if pin = "txp" then return "A32"; end if;
      end if;
      if channel = 3 then
        if pin = "rxn" then return "A26"; end if; if pin = "rxp" then return "A27"; end if; if pin = "txn" then return "A29"; end if; if pin = "txp" then return "A28"; end if;
      end if;
   end if;
   if connector = 1 then
      if channel = 0 then
        if pin = "rxn" then return "A22"; end if; if pin = "rxp" then return "A23"; end if; if pin = "txn" then return "A25"; end if; if pin = "txp" then return "A24"; end if;
      end if;
      if channel = 1 then
        if pin = "rxn" then return "A18"; end if; if pin = "rxp" then return "A19"; end if; if pin = "txn" then return "A21"; end if; if pin = "txp" then return "A20"; end if;
      end if;
      if channel = 2 then
        if pin = "rxn" then return "A14"; end if; if pin = "rxp" then return "A15"; end if; if pin = "txn" then return "A17"; end if; if pin = "txp" then return "A16"; end if;
      end if;
      if channel = 3 then
        if pin = "rxn" then return "A10"; end if; if pin = "rxp" then return "A11"; end if; if pin = "txn" then return "A13"; end if; if pin = "txp" then return "A12"; end if;
      end if;
   end if;
   if connector = 2 then
      if channel = 0 then
        if pin = "rxn" then return "BB38"; end if; if pin = "rxp" then return "BB39"; end if; if pin = "txn" then return "BB41"; end if; if pin = "txp" then return "BB40"; end if;
      end if;
      if channel = 1 then
        if pin = "rxn" then return "BB34"; end if; if pin = "rxp" then return "BB35"; end if; if pin = "txn" then return "BB37"; end if; if pin = "txp" then return "BB36"; end if;
      end if;
      if channel = 2 then
        if pin = "rxn" then return "BB30"; end if; if pin = "rxp" then return "BB31"; end if; if pin = "txn" then return "BB33"; end if; if pin = "txp" then return "BB32"; end if;
      end if;
      if channel = 3 then
        if pin = "rxn" then return "BB26"; end if; if pin = "rxp" then return "BB27"; end if; if pin = "txn" then return "BB29"; end if; if pin = "txp" then return "BB28"; end if;
      end if;
   end if;
   if connector = 3 then
      if channel = 0 then
        if pin = "rxn" then return "BB22"; end if; if pin = "rxp" then return "BB23"; end if; if pin = "txn" then return "BB25"; end if; if pin = "txp" then return "BB24"; end if;
      end if;
      if channel = 1 then
        if pin = "rxn" then return "BB18"; end if; if pin = "rxp" then return "BB19"; end if; if pin = "txn" then return "BB21"; end if; if pin = "txp" then return "BB20"; end if;
      end if;
      if channel = 2 then
        if pin = "rxn" then return "BB14"; end if; if pin = "rxp" then return "BB15"; end if; if pin = "txn" then return "BB17"; end if; if pin = "txp" then return "BB16"; end if;
      end if;
      if channel = 3 then
        if pin = "rxn" then return "BB10"; end if; if pin = "rxp" then return "BB11"; end if; if pin = "txn" then return "BB13"; end if; if pin = "txp" then return "BB12"; end if;
      end if;
   end if;
   return "error";   
  end;
  
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
  attribute CHAN_BOND_MODE                : string;
  attribute REF_CLK_V_SEL                 : string;
  attribute RX_LOSS_OF_SYNC_FSM           : string;
  attribute CHAN_BOND_ONE_SHOT            : string;
  attribute TX_PREEMPHASIS                : string;
  attribute TX_DIFF_CTRL                  : string;
  attribute LOC                           : string;
  attribute ASYNC_REG of rx_rst_state     : signal is "TRUE";
  attribute ASYNC_REG of mgt_rx_reset_int : signal is "TRUE";
  attribute ASYNC_REG of tx_rst_state     : signal is "TRUE";
  attribute ASYNC_REG of mgt_tx_reset_int : signal is "TRUE";
  attribute ASYNC_REG of reclock_align    : label  is "TRUE";
  attribute CHAN_BOND_MODE      of mgt    : label  is CHBONDMODE;
  attribute REF_CLK_V_SEL       of mgt    : label  is "1"    ;
  attribute RX_LOSS_OF_SYNC_FSM of mgt    : label  is "TRUE" ;
  attribute CHAN_BOND_ONE_SHOT  of mgt    : label  is "FALSE";
  attribute TX_PREEMPHASIS      of mgt    : label  is "3"    ;
  attribute TX_DIFF_CTRL        of mgt    : label  is "800"  ;
  attribute LOC       of reclock_align    : label  is reclock_loc(CONNECTOR, CHANNEL);
  attribute LOC       of rxn              : signal is pin_loc(CONNECTOR, CHANNEL, "rxn");
  attribute LOC       of rxp              : signal is pin_loc(CONNECTOR, CHANNEL, "rxp");
  attribute LOC       of txn              : signal is pin_loc(CONNECTOR, CHANNEL, "txn");
  attribute LOC       of txp              : signal is pin_loc(CONNECTOR, CHANNEL, "txp");
begin  -- rtl

  loopback(1)   <= loopback_ser;
  loopback(0)   <= '0';
  code_valid(1) <= not (rxnotintable(1) or rxdisperr(1));
  code_valid(0) <= not (rxnotintable(0) or rxdisperr(0));
  syncok        <= not rxlossofsync(1);

  mgt : gt_xaui_2
-- synthesis translate_off
    generic map (
      REF_CLK_V_SEL            => 1,
      CHAN_BOND_MODE           => CHBONDMODE,
      CHAN_BOND_ONE_SHOT       => false,
      RX_LOSS_OF_SYNC_FSM      => true)
-- synthesis translate_on
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
