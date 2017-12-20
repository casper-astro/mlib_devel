

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

--***********************************Entity Declaration************************

entity gmii_to_sgmii_gt_common is

port
(

        gt0_gtrefclk0_common_in : in   std_logic;
        gt0_qplloutclk        : out  std_logic;
        gt0_qplloutrefclk     : out  std_logic;
        gt0_qplllock_out        : out  std_logic;
        gt0_qplllockdetclk_in   : in   std_logic;
        gt0_qpllrefclklost_out  : out  std_logic;
        gt0_qpllreset_in        : in   std_logic
);

end gmii_to_sgmii_gt_common;
architecture RTL of gmii_to_sgmii_gt_common is
-- Signal declarations
  --***************************** Signal Declarations *****************************

    -- ground and tied_to_vcc_i signals
    signal  tied_to_ground_i                :   std_logic;
    signal  tied_to_ground_vec_i            :   std_logic_vector(63 downto 0);
    signal  tied_to_vcc_i                   :   std_logic;


--*************************Logic to set Attribute QPLL_FB_DIV*****************************
    impure function conv_qpll_fbdiv_top (qpllfbdiv_top : in integer) return bit_vector is
    begin
       if (qpllfbdiv_top = 16) then
         return "0000100000";
       elsif (qpllfbdiv_top = 20) then
         return "0000110000" ;
       elsif (qpllfbdiv_top = 32) then
         return "0001100000" ;
       elsif (qpllfbdiv_top = 40) then
         return "0010000000" ;
       elsif (qpllfbdiv_top = 64) then
         return "0011100000" ;
       elsif (qpllfbdiv_top = 66) then
         return "0101000000" ;
       elsif (qpllfbdiv_top = 80) then
         return "0100100000" ;
       elsif (qpllfbdiv_top = 100) then
         return "0101110000" ;
       else 
         return "0000000000" ;
       end if;
    end function;

    impure function conv_qpll_fbdiv_ratio (qpllfbdiv_top : in integer) return bit is
    begin
       if (qpllfbdiv_top = 16) then
         return '1';
       elsif (qpllfbdiv_top = 20) then
         return '1' ;
       elsif (qpllfbdiv_top = 32) then
         return '1' ;
       elsif (qpllfbdiv_top = 40) then
         return '1' ;
       elsif (qpllfbdiv_top = 64) then
         return '1' ;
       elsif (qpllfbdiv_top = 66) then
         return '0' ;
       elsif (qpllfbdiv_top = 80) then
         return '1' ;
       elsif (qpllfbdiv_top = 100) then
         return '1' ;
       else 
         return '1' ;
       end if;
    end function;

    constant   QPLL_FBDIV_TOP   :   integer  := 16; 
    constant   QPLL_FBDIV_IN    :   bit_vector(9 downto 0) := conv_qpll_fbdiv_top(QPLL_FBDIV_TOP);
    constant   QPLL_FBDIV_RATIO :   bit := conv_qpll_fbdiv_ratio(QPLL_FBDIV_TOP);
    constant   WRAPPER_SIM_GTRESET_SPEEDUP : string := "FALSE" ;
begin                       
    tied_to_ground_i                    <= '0';
    tied_to_ground_vec_i(63 downto 0)   <= (others => '0');
    tied_to_vcc_i                       <= '1';
    --_________________________________________________________________________
    --_________________________________________________________________________
    --_________________________GTHE2_COMMON____________________________________

    gthe2_common_0_i : GTHE2_COMMON
    generic map
    (
            -- Simulation attributes
            SIM_RESET_SPEEDUP    => WRAPPER_SIM_GTRESET_SPEEDUP,
            SIM_QPLLREFCLK_SEL   => ("001"),
            SIM_VERSION          => "2.0",


       ------------------COMMON BLOCK Attributes---------------
        BIAS_CFG                                =>     (x"0000040000001050"),
        COMMON_CFG                              =>     (x"0000001C"),
        QPLL_CFG                                =>     (x"04801C7"),
        QPLL_CLKOUT_CFG                         =>     ("1111"),
        QPLL_COARSE_FREQ_OVRD                   =>     ("010000"),
        QPLL_COARSE_FREQ_OVRD_EN                =>     ('0'),
        QPLL_CP                                 =>     ("0000011111"),
        QPLL_CP_MONITOR_EN                      =>     ('0'),
        QPLL_DMONITOR_SEL                       =>     ('0'),
        QPLL_FBDIV                              =>     (QPLL_FBDIV_IN),
        QPLL_FBDIV_MONITOR_EN                   =>     ('0'),
        QPLL_FBDIV_RATIO                        =>     (QPLL_FBDIV_RATIO),
        QPLL_INIT_CFG                           =>     (x"000006"),
        QPLL_LOCK_CFG                           =>     (x"05E8"),
        QPLL_LPF                                =>     ("1111"),
        QPLL_REFCLK_DIV                         =>     (1),
        RSVD_ATTR0                              =>     (x"0000"),
        RSVD_ATTR1                              =>     (x"0000"),
        QPLL_RP_COMP                            =>     ('0'),
        QPLL_VTRL_RESET                         =>     ("00"),
        RCAL_CFG                                =>     ("00")

        
    )
    port map
    (
        ------------- Common Block  - Dynamic Reconfiguration Port (DRP) -----------
        DRPADDR                         =>      tied_to_ground_vec_i(7 downto 0),
        DRPCLK                          =>      tied_to_ground_i,
        DRPDI                           =>      tied_to_ground_vec_i(15 downto 0),
        DRPDO                           =>      open,
        DRPEN                           =>      tied_to_ground_i,
        DRPRDY                          =>      open,
        DRPWE                           =>      tied_to_ground_i,
        ---------------------- Common Block  - Ref Clock Ports ---------------------
        GTGREFCLK                       =>      tied_to_ground_i,
        GTNORTHREFCLK0                  =>      tied_to_ground_i,
        GTNORTHREFCLK1                  =>      tied_to_ground_i,
        GTREFCLK0                       =>      gt0_gtrefclk0_common_in,
        GTREFCLK1                       =>      tied_to_ground_i,
        GTSOUTHREFCLK0                  =>      tied_to_ground_i,
        GTSOUTHREFCLK1                  =>      tied_to_ground_i,
        ------------------------- Common Block -  QPLL Ports -----------------------
        QPLLDMONITOR                    =>      open,
        ----------------------- Common Block - Clocking Ports ----------------------
        QPLLOUTCLK                      =>      gt0_qplloutclk,
        QPLLOUTREFCLK                   =>      gt0_qplloutrefclk,
        REFCLKOUTMONITOR                =>      open,
        ------------------------- Common Block - QPLL Ports ------------------------
        BGRCALOVRDENB                   =>      tied_to_vcc_i,
        PMARSVDOUT                      =>      open,
        QPLLFBCLKLOST                   =>      open,
        QPLLLOCK                        =>      gt0_qplllock_out,
        QPLLLOCKDETCLK                  =>      gt0_qplllockdetclk_in,
        QPLLLOCKEN                      =>      tied_to_vcc_i,
        QPLLOUTRESET                    =>      tied_to_ground_i,
        QPLLPD                          =>      tied_to_vcc_i,
        QPLLREFCLKLOST                  =>      gt0_qpllrefclklost_out,
        QPLLREFCLKSEL                   =>      "001",
        QPLLRESET                       =>      gt0_qpllreset_in,
        QPLLRSVD1                       =>      "0000000000000000",
        QPLLRSVD2                       =>      "11111",
        --------------------------------- QPLL Ports -------------------------------
        BGBYPASSB                       =>      tied_to_vcc_i,
        BGMONITORENB                    =>      tied_to_vcc_i,
        BGPDB                           =>      tied_to_vcc_i,
        BGRCALOVRD                      =>      "11111",
        PMARSVD                         =>      "00000000",
        RCALENB                         =>      tied_to_vcc_i

    );
end RTL;
