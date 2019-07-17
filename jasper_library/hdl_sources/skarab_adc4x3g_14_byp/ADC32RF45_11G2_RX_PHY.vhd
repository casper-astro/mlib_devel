----------------------------------------------------------------------------------
-- Company: Peralex
-- Engineers: Francois Tolmie
-- Create Date: 21/11/2018
-- Last Modified Date: 21/11/2018
-- Module Name: ADC32RF45_11G2_RX_PHY
-- Project Name: FRM123701U1R4
-- Target Device: xc7vx690tffg1927-2
-- Description: JESD204B receiver PHY for ADC32RF45 (LMFS=82820, 2.8 GSPS)
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity ADC32RF45_11G2_RX_PHY is
generic(RX_POLARITY_INVERT          : std_logic_vector(3 downto 0) := "0000"; 
        EXAMPLE_SIM_GTRESET_SPEEDUP : string                       := "TRUE";
        STABLE_CLOCK_PERIOD         : integer                      := 6);
port(GTREFCLK_IN              : in  std_logic;
     SYSCLK_IN                : in  std_logic;
     SOFT_RESET_IN            : in  std_logic;
     RXP_IN                   : in  std_logic_vector(3 downto 0);
     RXN_IN                   : in  std_logic_vector(3 downto 0);     
     LANE0_RX_DATA_O          : out std_logic_vector(31 downto 0);
     LANE1_RX_DATA_O          : out std_logic_vector(31 downto 0);
     LANE2_RX_DATA_O          : out std_logic_vector(31 downto 0);
     LANE3_RX_DATA_O          : out std_logic_vector(31 downto 0);
     LANE0_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
     LANE1_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
     LANE2_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
     LANE3_RX_DATA_IS_K_O     : out std_logic_vector(3 downto 0);
     RX_DATA_K28_0_DETECTED_O : out std_logic_vector(3 downto 0);
     GT_BYTE_ALIGNED_O        : out std_logic_vector(3 downto 0);
     GT_RX_READY_O            : out std_logic_vector(3 downto 0);
     GT_RXUSRCLK2_O           : out std_logic);
end ADC32RF45_11G2_RX_PHY;
    
architecture RTL of ADC32RF45_11G2_RX_PHY is

  attribute DowngradeIPIdentifiedWarnings: string;
  attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of RTL : architecture is "jesd204b_11200_rx,gtwizard_v3_6_8,{protocol_file=JESD204}";

  component jesd204b_11200_rx_support
  generic (
    EXAMPLE_SIM_GTRESET_SPEEDUP : string    := "FALSE";
    STABLE_CLOCK_PERIOD         : integer   := 6);
  port(
    SOFT_RESET_RX_IN                        : in   std_logic;
    DONT_RESET_ON_DATA_ERROR_IN             : in   std_logic;
    Q0_CLK1_GTREFCLK_PAD_N_IN               : in   std_logic;
    GTREFCLK_IN                             : in  std_logic;
    Q0_CLK1_GTREFCLK_PAD_P_IN               : in   std_logic;
    GT0_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT0_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT0_DATA_VALID_IN                       : in   std_logic;
    GT1_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT1_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT1_DATA_VALID_IN                       : in   std_logic;
    GT2_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT2_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT2_DATA_VALID_IN                       : in   std_logic;
    GT3_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT3_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT3_DATA_VALID_IN                       : in   std_logic; 
    GT0_RXUSRCLK_OUT                        : out  std_logic;
    GT0_RXUSRCLK2_OUT                       : out  std_logic; 
    GT1_RXUSRCLK_OUT                        : out  std_logic;
    GT1_RXUSRCLK2_OUT                       : out  std_logic; 
    GT2_RXUSRCLK_OUT                        : out  std_logic;
    GT2_RXUSRCLK2_OUT                       : out  std_logic; 
    GT3_RXUSRCLK_OUT                        : out  std_logic;
    GT3_RXUSRCLK2_OUT                       : out  std_logic;

    --GT0
    --------------------------------- CPLL Ports -------------------------------
    gt0_cpllfbclklost_out                   : out  std_logic;
    gt0_cplllock_out                        : out  std_logic;
    gt0_cpllreset_in                        : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt0_eyescanreset_in                     : in   std_logic;
    gt0_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt0_eyescandataerror_out                : out  std_logic;
    gt0_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt0_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt0_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt0_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt0_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt0_gthrxn_in                           : in   std_logic;
    ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
    gt0_rxbufreset_in                       : in   std_logic;
    gt0_rxbufstatus_out                     : out  std_logic_vector(2 downto 0);
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt0_rxbyteisaligned_out                 : out  std_logic;
    gt0_rxbyterealign_out                   : out  std_logic;
    gt0_rxcommadet_out                      : out  std_logic;
    gt0_rxmcommaalignen_in                  : in   std_logic;
    gt0_rxpcommaalignen_in                  : in   std_logic;
    ------------------ Receive Ports - RX Channel Bonding Ports ----------------
    gt0_rxchanbondseq_out                   : out  std_logic;
    gt0_rxchbonden_in                       : in   std_logic;
    gt0_rxchbondlevel_in                    : in   std_logic_vector(2 downto 0);
    gt0_rxchbondmaster_in                   : in   std_logic;
    gt0_rxchbondo_out                       : out  std_logic_vector(4 downto 0);
    gt0_rxchbondslave_in                    : in   std_logic;
    ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
    gt0_rxchanisaligned_out                 : out  std_logic;
    gt0_rxchanrealign_out                   : out  std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt0_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt0_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    gt0_rxoutclkfabric_out                  : out  std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt0_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt0_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt0_rxchariscomma_out                   : out  std_logic_vector(3 downto 0);
    gt0_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------ Receive Ports - Rx Channel Bonding Ports ----------------
    gt0_rxchbondi_in                        : in   std_logic_vector(4 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt0_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt0_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt0_gttxreset_in                        : in   std_logic;
    ---------------------- Transmit Ports - TX Buffer Ports --------------------
    gt0_txbufstatus_out                     : out  std_logic_vector(1 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt0_txpcsreset_in                       : in   std_logic;

    --GT1
    --------------------------------- CPLL Ports -------------------------------
    gt1_cpllfbclklost_out                   : out  std_logic;
    gt1_cplllock_out                        : out  std_logic;
    gt1_cpllreset_in                        : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt1_eyescanreset_in                     : in   std_logic;
    gt1_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt1_eyescandataerror_out                : out  std_logic;
    gt1_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt1_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt1_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt1_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt1_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt1_gthrxn_in                           : in   std_logic;
    ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
    gt1_rxbufreset_in                       : in   std_logic;
    gt1_rxbufstatus_out                     : out  std_logic_vector(2 downto 0);
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt1_rxbyteisaligned_out                 : out  std_logic;
    gt1_rxbyterealign_out                   : out  std_logic;
    gt1_rxcommadet_out                      : out  std_logic;
    gt1_rxmcommaalignen_in                  : in   std_logic;
    gt1_rxpcommaalignen_in                  : in   std_logic;
    ------------------ Receive Ports - RX Channel Bonding Ports ----------------
    gt1_rxchanbondseq_out                   : out  std_logic;
    gt1_rxchbonden_in                       : in   std_logic;
    gt1_rxchbondlevel_in                    : in   std_logic_vector(2 downto 0);
    gt1_rxchbondmaster_in                   : in   std_logic;
    gt1_rxchbondo_out                       : out  std_logic_vector(4 downto 0);
    gt1_rxchbondslave_in                    : in   std_logic;
    ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
    gt1_rxchanisaligned_out                 : out  std_logic;
    gt1_rxchanrealign_out                   : out  std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt1_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt1_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    gt1_rxoutclkfabric_out                  : out  std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt1_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt1_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt1_rxchariscomma_out                   : out  std_logic_vector(3 downto 0);
    gt1_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------ Receive Ports - Rx Channel Bonding Ports ----------------
    gt1_rxchbondi_in                        : in   std_logic_vector(4 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt1_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt1_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt1_gttxreset_in                        : in   std_logic;
    ---------------------- Transmit Ports - TX Buffer Ports --------------------
    gt1_txbufstatus_out                     : out  std_logic_vector(1 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt1_txpcsreset_in                       : in   std_logic;

    --GT2
    --------------------------------- CPLL Ports -------------------------------
    gt2_cpllfbclklost_out                   : out  std_logic;
    gt2_cplllock_out                        : out  std_logic;
    gt2_cpllreset_in                        : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt2_eyescanreset_in                     : in   std_logic;
    gt2_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt2_eyescandataerror_out                : out  std_logic;
    gt2_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt2_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt2_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt2_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt2_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt2_gthrxn_in                           : in   std_logic;
    ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
    gt2_rxbufreset_in                       : in   std_logic;
    gt2_rxbufstatus_out                     : out  std_logic_vector(2 downto 0);
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt2_rxbyteisaligned_out                 : out  std_logic;
    gt2_rxbyterealign_out                   : out  std_logic;
    gt2_rxcommadet_out                      : out  std_logic;
    gt2_rxmcommaalignen_in                  : in   std_logic;
    gt2_rxpcommaalignen_in                  : in   std_logic;
    ------------------ Receive Ports - RX Channel Bonding Ports ----------------
    gt2_rxchanbondseq_out                   : out  std_logic;
    gt2_rxchbonden_in                       : in   std_logic;
    gt2_rxchbondlevel_in                    : in   std_logic_vector(2 downto 0);
    gt2_rxchbondmaster_in                   : in   std_logic;
    gt2_rxchbondo_out                       : out  std_logic_vector(4 downto 0);
    gt2_rxchbondslave_in                    : in   std_logic;
    ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
    gt2_rxchanisaligned_out                 : out  std_logic;
    gt2_rxchanrealign_out                   : out  std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt2_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt2_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    gt2_rxoutclkfabric_out                  : out  std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt2_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt2_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt2_rxchariscomma_out                   : out  std_logic_vector(3 downto 0);
    gt2_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------ Receive Ports - Rx Channel Bonding Ports ----------------
    gt2_rxchbondi_in                        : in   std_logic_vector(4 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt2_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt2_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt2_gttxreset_in                        : in   std_logic;
    ---------------------- Transmit Ports - TX Buffer Ports --------------------
    gt2_txbufstatus_out                     : out  std_logic_vector(1 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt2_txpcsreset_in                       : in   std_logic;

    --GT3
    --------------------------------- CPLL Ports -------------------------------
    gt3_cpllfbclklost_out                   : out  std_logic;
    gt3_cplllock_out                        : out  std_logic;
    gt3_cpllreset_in                        : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt3_eyescanreset_in                     : in   std_logic;
    gt3_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt3_eyescandataerror_out                : out  std_logic;
    gt3_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt3_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt3_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt3_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt3_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt3_gthrxn_in                           : in   std_logic;
    ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
    gt3_rxbufreset_in                       : in   std_logic;
    gt3_rxbufstatus_out                     : out  std_logic_vector(2 downto 0);
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt3_rxbyteisaligned_out                 : out  std_logic;
    gt3_rxbyterealign_out                   : out  std_logic;
    gt3_rxcommadet_out                      : out  std_logic;
    gt3_rxmcommaalignen_in                  : in   std_logic;
    gt3_rxpcommaalignen_in                  : in   std_logic;
    ------------------ Receive Ports - RX Channel Bonding Ports ----------------
    gt3_rxchanbondseq_out                   : out  std_logic;
    gt3_rxchbonden_in                       : in   std_logic;
    gt3_rxchbondlevel_in                    : in   std_logic_vector(2 downto 0);
    gt3_rxchbondmaster_in                   : in   std_logic;
    gt3_rxchbondo_out                       : out  std_logic_vector(4 downto 0);
    gt3_rxchbondslave_in                    : in   std_logic;
    ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
    gt3_rxchanisaligned_out                 : out  std_logic;
    gt3_rxchanrealign_out                   : out  std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt3_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt3_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    gt3_rxoutclkfabric_out                  : out  std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt3_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt3_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt3_rxchariscomma_out                   : out  std_logic_vector(3 downto 0);
    gt3_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------ Receive Ports - Rx Channel Bonding Ports ----------------
    gt3_rxchbondi_in                        : in   std_logic_vector(4 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt3_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt3_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt3_gttxreset_in                        : in   std_logic;
    ---------------------- Transmit Ports - TX Buffer Ports --------------------
    gt3_txbufstatus_out                     : out  std_logic_vector(1 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt3_txpcsreset_in                       : in   std_logic;
    
    --COMMON PORTS 
    GT0_QPLLLOCK_OUT                        : out std_logic;
    GT0_QPLLREFCLKLOST_OUT                  : out std_logic;
    GT0_QPLLOUTCLK_OUT                      : out std_logic;
    GT0_QPLLOUTREFCLK_OUT                   : out std_logic;
    sysclk_in                               : in std_logic);
  end component;

--SIGNALS
  --GT0
  --------------------------------- CPLL Ports -------------------------------
  signal gt0_cpllfbclklost_i             : std_logic;
  signal gt0_cplllock_i                  : std_logic;
  signal gt0_cpllrefclklost_i            : std_logic;
  signal gt0_cpllreset_i                 : std_logic;
  --------------------- RX Initialization and Reset Ports --------------------
  signal gt0_eyescanreset_i              : std_logic;
  signal gt0_rxuserrdy_i                 : std_logic;
  -------------------------- RX Margin Analysis Ports ------------------------
  signal gt0_eyescandataerror_i          : std_logic;
  signal gt0_eyescantrigger_i            : std_logic;
  ------------------- Receive Ports - Digital Monitor Ports ------------------
  signal gt0_dmonitorout_i               : std_logic_vector(14 downto 0);
  ------------------ Receive Ports - FPGA RX interface Ports -----------------
  signal gt0_rxdata_i                    : std_logic_vector(31 downto 0);
  ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
  signal gt0_rxdisperr_i                 : std_logic_vector(3 downto 0);
  signal gt0_rxnotintable_i              : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports - RX AFE Ports ----------------------
  signal gt0_gthrxn_i                    : std_logic;
  ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
  signal gt0_rxbufreset_i                : std_logic;
  signal gt0_rxbufstatus_i               : std_logic_vector(2 downto 0);
  -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
  signal gt0_rxbyteisaligned_i           : std_logic;
  signal gt0_rxbyterealign_i             : std_logic;
  signal gt0_rxcommadet_i                : std_logic;
  signal gt0_rxmcommaalignen_i           : std_logic;
  signal gt0_rxpcommaalignen_i           : std_logic;
  ------------------ Receive Ports - RX Channel Bonding Ports ----------------
  signal gt0_rxchanbondseq_i             : std_logic;
  signal gt0_rxchbonden_i                : std_logic;
  ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
  signal gt0_rxchanisaligned_i           : std_logic;
  signal gt0_rxchanrealign_i             : std_logic;
  --------------------- Receive Ports - RX Equalizer Ports -------------------
  signal gt0_rxmonitorout_i              : std_logic_vector(6 downto 0);
  signal gt0_rxmonitorsel_i              : std_logic_vector(1 downto 0);
  --------------- Receive Ports - RX Fabric Output Control Ports -------------
  signal gt0_rxoutclk_i                  : std_logic;
  signal gt0_rxoutclkfabric_i            : std_logic;
  ------------- Receive Ports - RX Initialization and Reset Ports ------------
  signal gt0_gtrxreset_i                 : std_logic;
  ----------------- Receive Ports - RX Polarity Control Ports ----------------
  signal gt0_rxpolarity_i                : std_logic;
  ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
  signal gt0_rxchariscomma_i             : std_logic_vector(3 downto 0);
  signal gt0_rxcharisk_i                 : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports -RX AFE Ports -----------------------
  signal gt0_gthrxp_i                    : std_logic;
  -------------- Receive Ports -RX Initialization and Reset Ports ------------
  signal gt0_rxresetdone_i               : std_logic;
  --------------------- TX Initialization and Reset Ports --------------------
  signal gt0_gttxreset_i                 : std_logic;
  ---------------------- Transmit Ports - TX Buffer Ports --------------------
  signal gt0_txbufstatus_i               : std_logic_vector(1 downto 0);
  ------------- Transmit Ports - TX Initialization and Reset Ports -----------
  signal gt0_txpcsreset_i                : std_logic;

  --GT1
  --------------------------------- CPLL Ports -------------------------------
  signal gt1_cpllfbclklost_i             : std_logic;
  signal gt1_cplllock_i                  : std_logic;
  signal gt1_cpllrefclklost_i            : std_logic;
  signal gt1_cpllreset_i                 : std_logic;
  --------------------- RX Initialization and Reset Ports --------------------
  signal gt1_eyescanreset_i              : std_logic;
  signal gt1_rxuserrdy_i                 : std_logic;
  -------------------------- RX Margin Analysis Ports ------------------------
  signal gt1_eyescandataerror_i          : std_logic;
  signal gt1_eyescantrigger_i            : std_logic;
  ------------------- Receive Ports - Digital Monitor Ports ------------------
  signal gt1_dmonitorout_i               : std_logic_vector(14 downto 0);
  ------------------ Receive Ports - FPGA RX interface Ports -----------------
  signal gt1_rxdata_i                    : std_logic_vector(31 downto 0);
  ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
  signal gt1_rxdisperr_i                 : std_logic_vector(3 downto 0);
  signal gt1_rxnotintable_i              : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports - RX AFE Ports ----------------------
  signal gt1_gthrxn_i                    : std_logic;
  ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
  signal gt1_rxbufreset_i                : std_logic;
  signal gt1_rxbufstatus_i               : std_logic_vector(2 downto 0);
  -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
  signal gt1_rxbyteisaligned_i           : std_logic;
  signal gt1_rxbyterealign_i             : std_logic;
  signal gt1_rxcommadet_i                : std_logic;
  signal gt1_rxmcommaalignen_i           : std_logic;
  signal gt1_rxpcommaalignen_i           : std_logic;
  ------------------ Receive Ports - RX Channel Bonding Ports ----------------
  signal gt1_rxchanbondseq_i             : std_logic;
  signal gt1_rxchbonden_i                : std_logic;
  ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
  signal gt1_rxchanisaligned_i           : std_logic;
  signal gt1_rxchanrealign_i             : std_logic;
  --------------------- Receive Ports - RX Equalizer Ports -------------------
  signal gt1_rxmonitorout_i              : std_logic_vector(6 downto 0);
  signal gt1_rxmonitorsel_i              : std_logic_vector(1 downto 0);
  --------------- Receive Ports - RX Fabric Output Control Ports -------------
  signal gt1_rxoutclk_i                  : std_logic;
  signal gt1_rxoutclkfabric_i            : std_logic;
  ------------- Receive Ports - RX Initialization and Reset Ports ------------
  signal gt1_gtrxreset_i                 : std_logic;
  ----------------- Receive Ports - RX Polarity Control Ports ----------------
  signal gt1_rxpolarity_i                : std_logic;
  ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
  signal gt1_rxchariscomma_i             : std_logic_vector(3 downto 0);
  signal gt1_rxcharisk_i                 : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports -RX AFE Ports -----------------------
  signal gt1_gthrxp_i                    : std_logic;
  -------------- Receive Ports -RX Initialization and Reset Ports ------------
  signal gt1_rxresetdone_i               : std_logic;
  --------------------- TX Initialization and Reset Ports --------------------
  signal gt1_gttxreset_i                 : std_logic;
  ---------------------- Transmit Ports - TX Buffer Ports --------------------
  signal gt1_txbufstatus_i               : std_logic_vector(1 downto 0);
  ------------- Transmit Ports - TX Initialization and Reset Ports -----------
  signal gt1_txpcsreset_i                : std_logic;

  --GT2
  --------------------------------- CPLL Ports -------------------------------
  signal gt2_cpllfbclklost_i             : std_logic;
  signal gt2_cplllock_i                  : std_logic;
  signal gt2_cpllrefclklost_i            : std_logic;
  signal gt2_cpllreset_i                 : std_logic;
  --------------------- RX Initialization and Reset Ports --------------------
  signal gt2_eyescanreset_i              : std_logic;
  signal gt2_rxuserrdy_i                 : std_logic;
  -------------------------- RX Margin Analysis Ports ------------------------
  signal gt2_eyescandataerror_i          : std_logic;
  signal gt2_eyescantrigger_i            : std_logic;
  ------------------- Receive Ports - Digital Monitor Ports ------------------
  signal gt2_dmonitorout_i               : std_logic_vector(14 downto 0);
  ------------------ Receive Ports - FPGA RX interface Ports -----------------
  signal gt2_rxdata_i                    : std_logic_vector(31 downto 0);
  ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
  signal gt2_rxdisperr_i                 : std_logic_vector(3 downto 0);
  signal gt2_rxnotintable_i              : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports - RX AFE Ports ----------------------
  signal gt2_gthrxn_i                    : std_logic;
  ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
  signal gt2_rxbufreset_i                : std_logic;
  signal gt2_rxbufstatus_i               : std_logic_vector(2 downto 0);
  -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
  signal gt2_rxbyteisaligned_i           : std_logic;
  signal gt2_rxbyterealign_i             : std_logic;
  signal gt2_rxcommadet_i                : std_logic;
  signal gt2_rxmcommaalignen_i           : std_logic;
  signal gt2_rxpcommaalignen_i           : std_logic;
  ------------------ Receive Ports - RX Channel Bonding Ports ----------------
  signal gt2_rxchanbondseq_i             : std_logic;
  signal gt2_rxchbonden_i                : std_logic;
  ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
  signal gt2_rxchanisaligned_i           : std_logic;
  signal gt2_rxchanrealign_i             : std_logic;
  --------------------- Receive Ports - RX Equalizer Ports -------------------
  signal gt2_rxmonitorout_i              : std_logic_vector(6 downto 0);
  signal gt2_rxmonitorsel_i              : std_logic_vector(1 downto 0);
  --------------- Receive Ports - RX Fabric Output Control Ports -------------
  signal gt2_rxoutclk_i                  : std_logic;
  signal gt2_rxoutclkfabric_i            : std_logic;
  ------------- Receive Ports - RX Initialization and Reset Ports ------------
  signal gt2_gtrxreset_i                 : std_logic;
  ----------------- Receive Ports - RX Polarity Control Ports ----------------
  signal gt2_rxpolarity_i                : std_logic;
  ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
  signal gt2_rxchariscomma_i             : std_logic_vector(3 downto 0);
  signal gt2_rxcharisk_i                 : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports -RX AFE Ports -----------------------
  signal gt2_gthrxp_i                    : std_logic;
  -------------- Receive Ports -RX Initialization and Reset Ports ------------
  signal gt2_rxresetdone_i               : std_logic;
  --------------------- TX Initialization and Reset Ports --------------------
  signal gt2_gttxreset_i                 : std_logic;
  ---------------------- Transmit Ports - TX Buffer Ports --------------------
  signal gt2_txbufstatus_i               : std_logic_vector(1 downto 0);
  ------------- Transmit Ports - TX Initialization and Reset Ports -----------
  signal gt2_txpcsreset_i                : std_logic;

  --GT3
  --------------------------------- CPLL Ports -------------------------------
  signal gt3_cpllfbclklost_i             : std_logic;
  signal gt3_cplllock_i                  : std_logic;
  signal gt3_cpllrefclklost_i            : std_logic;
  signal gt3_cpllreset_i                 : std_logic;
  --------------------- RX Initialization and Reset Ports --------------------
  signal gt3_eyescanreset_i              : std_logic;
  signal gt3_rxuserrdy_i                 : std_logic;
  -------------------------- RX Margin Analysis Ports ------------------------
  signal gt3_eyescandataerror_i          : std_logic;
  signal gt3_eyescantrigger_i            : std_logic;
  ------------------- Receive Ports - Digital Monitor Ports ------------------
  signal gt3_dmonitorout_i               : std_logic_vector(14 downto 0);
  ------------------ Receive Ports - FPGA RX interface Ports -----------------
  signal gt3_rxdata_i                    : std_logic_vector(31 downto 0);
  ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
  signal gt3_rxdisperr_i                 : std_logic_vector(3 downto 0);
  signal gt3_rxnotintable_i              : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports - RX AFE Ports ----------------------
  signal gt3_gthrxn_i                    : std_logic;
  ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
  signal gt3_rxbufreset_i                : std_logic;
  signal gt3_rxbufstatus_i               : std_logic_vector(2 downto 0);
  -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
  signal gt3_rxbyteisaligned_i           : std_logic;
  signal gt3_rxbyterealign_i             : std_logic;
  signal gt3_rxcommadet_i                : std_logic;
  signal gt3_rxmcommaalignen_i           : std_logic;
  signal gt3_rxpcommaalignen_i           : std_logic;
  ------------------ Receive Ports - RX Channel Bonding Ports ----------------
  signal gt3_rxchanbondseq_i             : std_logic;
  signal gt3_rxchbonden_i                : std_logic;
  ----------------- Receive Ports - RX Channel Bonding Ports  ----------------
  signal gt3_rxchanisaligned_i           : std_logic;
  signal gt3_rxchanrealign_i             : std_logic;
  --------------------- Receive Ports - RX Equalizer Ports -------------------
  signal gt3_rxmonitorout_i              : std_logic_vector(6 downto 0);
  signal gt3_rxmonitorsel_i              : std_logic_vector(1 downto 0);
  --------------- Receive Ports - RX Fabric Output Control Ports -------------
  signal gt3_rxoutclk_i                  : std_logic;
  signal gt3_rxoutclkfabric_i            : std_logic;
  ------------- Receive Ports - RX Initialization and Reset Ports ------------
  signal gt3_gtrxreset_i                 : std_logic;
  ----------------- Receive Ports - RX Polarity Control Ports ----------------
  signal gt3_rxpolarity_i                : std_logic;
  ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
  signal gt3_rxchariscomma_i             : std_logic_vector(3 downto 0);
  signal gt3_rxcharisk_i                 : std_logic_vector(3 downto 0);
  ------------------------ Receive Ports -RX AFE Ports -----------------------
  signal gt3_gthrxp_i                    : std_logic;
  -------------- Receive Ports -RX Initialization and Reset Ports ------------
  signal gt3_rxresetdone_i               : std_logic;
  --------------------- TX Initialization and Reset Ports --------------------
  signal gt3_gttxreset_i                 : std_logic;
  ---------------------- Transmit Ports - TX Buffer Ports --------------------
  signal gt3_txbufstatus_i               : std_logic_vector(1 downto 0);
  ------------- Transmit Ports - TX Initialization and Reset Ports -----------
  signal gt3_txpcsreset_i                : std_logic;

  -- COMMON PORTS
  ---------------------- Common Block  - Ref Clock Ports ---------------------
  signal gt0_gtrefclk1_common_i : std_logic;
  ------------------------- Common Block - QPLL Ports ------------------------
  signal gt0_qplllock_i       : std_logic;
  signal gt0_qpllrefclklost_i : std_logic;
  signal gt0_qpllreset_i      : std_logic;
  -------------------------- Channel Bonding Wires ---------------------------
  signal gt0_rxchbondo_i : std_logic_vector(4 downto 0);
  signal gt1_rxchbondo_i : std_logic_vector(4 downto 0);
  signal gt2_rxchbondo_i : std_logic_vector(4 downto 0);
  signal gt3_rxchbondo_i : std_logic_vector(4 downto 0);
  ------------------------------- User Clocks ---------------------------------
  signal gt0_txusrclk_i  : std_logic; 
  signal gt0_txusrclk2_i : std_logic; 
  signal gt0_rxusrclk_i  : std_logic; 
  signal gt0_rxusrclk2_i : std_logic;
  signal gt1_txusrclk_i  : std_logic; 
  signal gt1_txusrclk2_i : std_logic; 
  signal gt1_rxusrclk_i  : std_logic; 
  signal gt1_rxusrclk2_i : std_logic;
  signal gt2_txusrclk_i  : std_logic; 
  signal gt2_txusrclk2_i : std_logic; 
  signal gt2_rxusrclk_i  : std_logic; 
  signal gt2_rxusrclk2_i : std_logic; 
  signal gt3_txusrclk_i  : std_logic; 
  signal gt3_txusrclk2_i : std_logic; 
  signal gt3_rxusrclk_i  : std_logic; 
  signal gt3_rxusrclk2_i : std_logic;     
  --------------------------------- Reset -----------------------------------
  signal soft_reset_i         : std_logic;
  signal gt0_txfsmresetdone_i : std_logic;
  signal gt0_rxfsmresetdone_i : std_logic;
  signal gt1_txfsmresetdone_i : std_logic;
  signal gt1_rxfsmresetdone_i : std_logic;
  signal gt2_txfsmresetdone_i : std_logic;
  signal gt2_rxfsmresetdone_i : std_logic;
  signal gt3_txfsmresetdone_i : std_logic;
  signal gt3_rxfsmresetdone_i : std_logic;
  
begin

  GT_RXUSRCLK2_O           <= gt0_rxusrclk2_i;
  soft_reset_i             <= SOFT_RESET_IN; 
  LANE0_RX_DATA_O          <= gt0_rxdata_i;
  LANE1_RX_DATA_O          <= gt1_rxdata_i;
  LANE2_RX_DATA_O          <= gt2_rxdata_i;
  LANE3_RX_DATA_O          <= gt3_rxdata_i;
  LANE0_RX_DATA_IS_K_O     <= gt0_rxcharisk_i;
  LANE1_RX_DATA_IS_K_O     <= gt1_rxcharisk_i;
  LANE2_RX_DATA_IS_K_O     <= gt2_rxcharisk_i;
  LANE3_RX_DATA_IS_K_O     <= gt3_rxcharisk_i;
  RX_DATA_K28_0_DETECTED_O <= gt3_rxchanbondseq_i   & gt2_rxchanbondseq_i   & gt1_rxchanbondseq_i   & gt0_rxchanbondseq_i;
  GT_BYTE_ALIGNED_O        <= gt3_rxbyteisaligned_i & gt2_rxbyteisaligned_i & gt1_rxbyteisaligned_i & gt0_rxbyteisaligned_i;
  GT_RX_READY_O            <= gt3_rxfsmresetdone_i  & gt2_rxfsmresetdone_i  & gt1_rxfsmresetdone_i  & gt0_rxfsmresetdone_i ;

  jesd204b_11200_rx_support_i : jesd204b_11200_rx_support generic map (
      EXAMPLE_SIM_GTRESET_SPEEDUP     => EXAMPLE_SIM_GTRESET_SPEEDUP,
      STABLE_CLOCK_PERIOD             => STABLE_CLOCK_PERIOD)
  port map (
    SOFT_RESET_RX_IN            => soft_reset_i,
    DONT_RESET_ON_DATA_ERROR_IN => '0',
    Q0_CLK1_GTREFCLK_PAD_N_IN   => '0',
    GTREFCLK_IN                 => GTREFCLK_IN,
    Q0_CLK1_GTREFCLK_PAD_P_IN   => '1',
    GT0_TX_FSM_RESET_DONE_OUT   => gt0_txfsmresetdone_i,
    GT0_RX_FSM_RESET_DONE_OUT   => gt0_rxfsmresetdone_i,
    GT0_DATA_VALID_IN           => '1',
    GT1_TX_FSM_RESET_DONE_OUT   => gt1_txfsmresetdone_i,
    GT1_RX_FSM_RESET_DONE_OUT   => gt1_rxfsmresetdone_i,
    GT1_DATA_VALID_IN           => '1',
    GT2_TX_FSM_RESET_DONE_OUT   => gt2_txfsmresetdone_i,
    GT2_RX_FSM_RESET_DONE_OUT   => gt2_rxfsmresetdone_i,
    GT2_DATA_VALID_IN           => '1',
    GT3_TX_FSM_RESET_DONE_OUT   => gt3_txfsmresetdone_i,
    GT3_RX_FSM_RESET_DONE_OUT   => gt3_rxfsmresetdone_i,
    GT3_DATA_VALID_IN           => '1', 
    GT0_RXUSRCLK_OUT            => gt0_rxusrclk_i,
    GT0_RXUSRCLK2_OUT           => gt0_rxusrclk2_i, 
    GT1_RXUSRCLK_OUT            => gt1_rxusrclk_i,
    GT1_RXUSRCLK2_OUT           => gt1_rxusrclk2_i, 
    GT2_RXUSRCLK_OUT            => gt2_rxusrclk_i,
    GT2_RXUSRCLK2_OUT           => gt2_rxusrclk2_i, 
    GT3_RXUSRCLK_OUT            => gt3_rxusrclk_i,
    GT3_RXUSRCLK2_OUT           => gt3_rxusrclk2_i,
    gt0_cpllfbclklost_out       => gt0_cpllfbclklost_i,
    gt0_cplllock_out            => gt0_cplllock_i,
    gt0_cpllreset_in            => '0',
    gt0_eyescanreset_in         => '0',
    gt0_rxuserrdy_in            => '1',
    gt0_eyescandataerror_out    => gt0_eyescandataerror_i,
    gt0_eyescantrigger_in       => '0',
    gt0_dmonitorout_out         => gt0_dmonitorout_i,
    gt0_rxdata_out              => gt0_rxdata_i,
    gt0_rxdisperr_out           => gt0_rxdisperr_i,
    gt0_rxnotintable_out        => gt0_rxnotintable_i,
    gt0_gthrxn_in               => RXN_IN(0),
    gt0_rxbufreset_in           => '0',
    gt0_rxbufstatus_out         => gt0_rxbufstatus_i,
    gt0_rxbyteisaligned_out     => gt0_rxbyteisaligned_i,
    gt0_rxbyterealign_out       => gt0_rxbyterealign_i,
    gt0_rxcommadet_out          => gt0_rxcommadet_i,
    gt0_rxmcommaalignen_in      => '1',
    gt0_rxpcommaalignen_in      => '1',
    gt0_rxchanbondseq_out       => gt0_rxchanbondseq_i,
    gt0_rxchbonden_in           => '1',
    gt0_rxchbondlevel_in        => "000",
    gt0_rxchbondmaster_in       => '0',
    gt0_rxchbondo_out           => gt0_rxchbondo_i,
    gt0_rxchbondslave_in        => '1',
    gt0_rxchanisaligned_out     => gt0_rxchanisaligned_i,
    gt0_rxchanrealign_out       => gt0_rxchanrealign_i,
    gt0_rxmonitorout_out        => gt0_rxmonitorout_i,
    gt0_rxmonitorsel_in         => "00",
    gt0_rxoutclkfabric_out      => gt0_rxoutclkfabric_i,
    gt0_gtrxreset_in            => SOFT_RESET_IN,
    gt0_rxpolarity_in           => RX_POLARITY_INVERT(0),
    gt0_rxchariscomma_out       => gt0_rxchariscomma_i,
    gt0_rxcharisk_out           => gt0_rxcharisk_i,
    gt0_rxchbondi_in            => gt1_rxchbondo_i,
    gt0_gthrxp_in               => RXP_IN(0),
    gt0_rxresetdone_out         => gt0_rxresetdone_i,
    gt0_gttxreset_in            => '0',
    gt0_txbufstatus_out         => gt0_txbufstatus_i,
    gt0_txpcsreset_in           => '0',
    gt1_cpllfbclklost_out       => gt1_cpllfbclklost_i,
    gt1_cplllock_out            => gt1_cplllock_i,
    gt1_cpllreset_in            => '0',
    gt1_eyescanreset_in         => '0',
    gt1_rxuserrdy_in            => '1',
    gt1_eyescandataerror_out    => gt1_eyescandataerror_i,
    gt1_eyescantrigger_in       => '0',
    gt1_dmonitorout_out         => gt1_dmonitorout_i,
    gt1_rxdata_out              => gt1_rxdata_i,
    gt1_rxdisperr_out           => gt1_rxdisperr_i,
    gt1_rxnotintable_out        => gt1_rxnotintable_i,
    gt1_gthrxn_in               => RXN_IN(1),
    gt1_rxbufreset_in           => '0',
    gt1_rxbufstatus_out         => gt1_rxbufstatus_i,
    gt1_rxbyteisaligned_out     => gt1_rxbyteisaligned_i,
    gt1_rxbyterealign_out       => gt1_rxbyterealign_i,
    gt1_rxcommadet_out          => gt1_rxcommadet_i,
    gt1_rxmcommaalignen_in      => '1',
    gt1_rxpcommaalignen_in      => '1',
    gt1_rxchanbondseq_out       => gt1_rxchanbondseq_i,
    gt1_rxchbonden_in           => '1',
    gt1_rxchbondlevel_in        => "001",
    gt1_rxchbondmaster_in       => '0',
    gt1_rxchbondo_out           => gt1_rxchbondo_i,
    gt1_rxchbondslave_in        => '1',
    gt1_rxchanisaligned_out     => gt1_rxchanisaligned_i,
    gt1_rxchanrealign_out       => gt1_rxchanrealign_i,
    gt1_rxmonitorout_out        => gt1_rxmonitorout_i,
    gt1_rxmonitorsel_in         => "00",
    gt1_rxoutclkfabric_out      => gt1_rxoutclkfabric_i,
    gt1_gtrxreset_in            => SOFT_RESET_IN,
    gt1_rxpolarity_in           => RX_POLARITY_INVERT(1),
    gt1_rxchariscomma_out       => gt1_rxchariscomma_i,
    gt1_rxcharisk_out           => gt1_rxcharisk_i,
    gt1_rxchbondi_in            => gt2_rxchbondo_i,
    gt1_gthrxp_in               => RXP_IN(1),
    gt1_rxresetdone_out         => gt1_rxresetdone_i,
    gt1_gttxreset_in            => '0',
    gt1_txbufstatus_out         => gt1_txbufstatus_i,
    gt1_txpcsreset_in           => '0',
    gt2_cpllfbclklost_out       => gt2_cpllfbclklost_i,
    gt2_cplllock_out            => gt2_cplllock_i,
    gt2_cpllreset_in            => '0',
    gt2_eyescanreset_in         => '0',
    gt2_rxuserrdy_in            => '1',
    gt2_eyescandataerror_out    => gt2_eyescandataerror_i,
    gt2_eyescantrigger_in       => '0',
    gt2_dmonitorout_out         => gt2_dmonitorout_i,
    gt2_rxdata_out              => gt2_rxdata_i,
    gt2_rxdisperr_out           => gt2_rxdisperr_i,
    gt2_rxnotintable_out        => gt2_rxnotintable_i,
    gt2_gthrxn_in               => RXN_IN(2),
    gt2_rxbufreset_in           => '0',
    gt2_rxbufstatus_out         => gt2_rxbufstatus_i,
    gt2_rxbyteisaligned_out     => gt2_rxbyteisaligned_i,
    gt2_rxbyterealign_out       => gt2_rxbyterealign_i,
    gt2_rxcommadet_out          => gt2_rxcommadet_i,
    gt2_rxmcommaalignen_in      => '1',
    gt2_rxpcommaalignen_in      => '1',
    gt2_rxchanbondseq_out       => gt2_rxchanbondseq_i,
    gt2_rxchbonden_in           => '1',
    gt2_rxchbondlevel_in        => "010",
    gt2_rxchbondmaster_in       => '1',
    gt2_rxchbondo_out           => gt2_rxchbondo_i,
    gt2_rxchbondslave_in        => '0',
    gt2_rxchanisaligned_out     => gt2_rxchanisaligned_i,
    gt2_rxchanrealign_out       => gt2_rxchanrealign_i,
    gt2_rxmonitorout_out        => gt2_rxmonitorout_i,
    gt2_rxmonitorsel_in         => "00",
    gt2_rxoutclkfabric_out      => gt2_rxoutclkfabric_i,
    gt2_gtrxreset_in            => SOFT_RESET_IN, 
    gt2_rxpolarity_in           => RX_POLARITY_INVERT(2),
    gt2_rxchariscomma_out       => gt2_rxchariscomma_i,
    gt2_rxcharisk_out           => gt2_rxcharisk_i,
    gt2_rxchbondi_in            => "00000",
    gt2_gthrxp_in               => RXP_IN(2),
    gt2_rxresetdone_out         => gt2_rxresetdone_i,
    gt2_gttxreset_in            => '0',
    gt2_txbufstatus_out         => gt2_txbufstatus_i,
    gt2_txpcsreset_in           => '0',
    gt3_cpllfbclklost_out       => gt3_cpllfbclklost_i,
    gt3_cplllock_out            => gt3_cplllock_i,
    gt3_cpllreset_in            => '0',
    gt3_eyescanreset_in         => '0',
    gt3_rxuserrdy_in            => '1',
    gt3_eyescandataerror_out    => gt3_eyescandataerror_i,
    gt3_eyescantrigger_in       => '0',
    gt3_dmonitorout_out         => gt3_dmonitorout_i,
    gt3_rxdata_out              => gt3_rxdata_i,
    gt3_rxdisperr_out           => gt3_rxdisperr_i,
    gt3_rxnotintable_out        => gt3_rxnotintable_i,
    gt3_gthrxn_in               => RXN_IN(3),
    gt3_rxbufreset_in           => '0',
    gt3_rxbufstatus_out         => gt3_rxbufstatus_i,
    gt3_rxbyteisaligned_out     => gt3_rxbyteisaligned_i,
    gt3_rxbyterealign_out       => gt3_rxbyterealign_i,
    gt3_rxcommadet_out          => gt3_rxcommadet_i,
    gt3_rxmcommaalignen_in      => '1',
    gt3_rxpcommaalignen_in      => '1',
    gt3_rxchanbondseq_out       => gt3_rxchanbondseq_i,
    gt3_rxchbonden_in           => '1',
    gt3_rxchbondlevel_in        => "001",
    gt3_rxchbondmaster_in       => '0',
    gt3_rxchbondo_out           => gt3_rxchbondo_i,
    gt3_rxchbondslave_in        => '1',
    gt3_rxchanisaligned_out     => gt3_rxchanisaligned_i,
    gt3_rxchanrealign_out       => gt3_rxchanrealign_i,
    gt3_rxmonitorout_out        => gt3_rxmonitorout_i,
    gt3_rxmonitorsel_in         => "00",
    gt3_rxoutclkfabric_out      => gt3_rxoutclkfabric_i,
    gt3_gtrxreset_in            => SOFT_RESET_IN,
    gt3_rxpolarity_in           => RX_POLARITY_INVERT(3),
    gt3_rxchariscomma_out       => gt3_rxchariscomma_i,
    gt3_rxcharisk_out           => gt3_rxcharisk_i,
    gt3_rxchbondi_in            => gt2_rxchbondo_i,
    gt3_gthrxp_in               => RXP_IN(3),
    gt3_rxresetdone_out         => gt3_rxresetdone_i,
    gt3_gttxreset_in            => '0',
    gt3_txbufstatus_out         => gt3_txbufstatus_i,
    gt3_txpcsreset_in           => '0',
    GT0_QPLLLOCK_OUT            => open,
    GT0_QPLLREFCLKLOST_OUT      => open,
    GT0_QPLLOUTCLK_OUT          => open,
    GT0_QPLLOUTREFCLK_OUT       => open,
    sysclk_in                   => SYSCLK_IN);

end RTL;