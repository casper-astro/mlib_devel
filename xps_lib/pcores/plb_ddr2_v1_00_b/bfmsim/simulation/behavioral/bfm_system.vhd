-------------------------------------------------------------------------------
-- bfm_system.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity bfm_system is
  port (
    sys_reset : in std_logic;
    sys_clk : in std_logic
  );
end bfm_system;

architecture STRUCTURE of bfm_system is

  component bfm_processor_wrapper is
    port (
      PLB_CLK : in std_logic;
      PLB_RESET : in std_logic;
      SYNCH_OUT : out std_logic_vector(0 to 31);
      SYNCH_IN : in std_logic_vector(0 to 31);
      PLB_MAddrAck : in std_logic;
      PLB_MSsize : in std_logic_vector(0 to 1);
      PLB_MRearbitrate : in std_logic;
      PLB_MBusy : in std_logic;
      PLB_MErr : in std_logic;
      PLB_MWrDAck : in std_logic;
      PLB_MRdDBus : in std_logic_vector(0 to 63);
      PLB_MRdWdAddr : in std_logic_vector(0 to 3);
      PLB_MRdDAck : in std_logic;
      PLB_MRdBTerm : in std_logic;
      PLB_MWrBTerm : in std_logic;
      M_request : out std_logic;
      M_priority : out std_logic_vector(0 to 1);
      M_buslock : out std_logic;
      M_RNW : out std_logic;
      M_BE : out std_logic_vector(0 to 7);
      M_msize : out std_logic_vector(0 to 1);
      M_size : out std_logic_vector(0 to 3);
      M_type : out std_logic_vector(0 to 2);
      M_compress : out std_logic;
      M_guarded : out std_logic;
      M_ordered : out std_logic;
      M_lockErr : out std_logic;
      M_abort : out std_logic;
      M_ABus : out std_logic_vector(0 to 31);
      M_wrDBus : out std_logic_vector(0 to 63);
      M_wrBurst : out std_logic;
      M_rdBurst : out std_logic
    );
  end component;

  component bfm_monitor_wrapper is
    port (
      PLB_CLK : in std_logic;
      PLB_RESET : in std_logic;
      SYNCH_OUT : out std_logic_vector(0 to 31);
      SYNCH_IN : in std_logic_vector(0 to 31);
      M_request : in std_logic_vector(0 to 0);
      M_priority : in std_logic_vector(0 to 1);
      M_buslock : in std_logic_vector(0 to 0);
      M_RNW : in std_logic_vector(0 to 0);
      M_BE : in std_logic_vector(0 to 7);
      M_msize : in std_logic_vector(0 to 1);
      M_size : in std_logic_vector(0 to 3);
      M_type : in std_logic_vector(0 to 2);
      M_compress : in std_logic_vector(0 to 0);
      M_guarded : in std_logic_vector(0 to 0);
      M_ordered : in std_logic_vector(0 to 0);
      M_lockErr : in std_logic_vector(0 to 0);
      M_abort : in std_logic_vector(0 to 0);
      M_ABus : in std_logic_vector(0 to 31);
      M_wrDBus : in std_logic_vector(0 to 63);
      M_wrBurst : in std_logic_vector(0 to 0);
      M_rdBurst : in std_logic_vector(0 to 0);
      PLB_MAddrAck : in std_logic_vector(0 to 0);
      PLB_MRearbitrate : in std_logic_vector(0 to 0);
      PLB_MBusy : in std_logic_vector(0 to 0);
      PLB_MErr : in std_logic_vector(0 to 0);
      PLB_MWrDAck : in std_logic_vector(0 to 0);
      PLB_MRdDBus : in std_logic_vector(0 to 63);
      PLB_MRdWdAddr : in std_logic_vector(0 to 3);
      PLB_MRdDAck : in std_logic_vector(0 to 0);
      PLB_MRdBTerm : in std_logic_vector(0 to 0);
      PLB_MWrBTerm : in std_logic_vector(0 to 0);
      PLB_Mssize : in std_logic_vector(0 to 1);
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_MasterID : in std_logic_vector(0 to 0);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_msize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_compress : in std_logic;
      PLB_guarded : in std_logic;
      PLB_ordered : in std_logic;
      PLB_lockErr : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_pendReq : in std_logic;
      PLB_pendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      Sl_addrAck : in std_logic_vector(0 to 0);
      Sl_wait : in std_logic_vector(0 to 0);
      Sl_rearbitrate : in std_logic_vector(0 to 0);
      Sl_wrDAck : in std_logic_vector(0 to 0);
      Sl_wrComp : in std_logic_vector(0 to 0);
      Sl_wrBTerm : in std_logic_vector(0 to 0);
      Sl_rdDBus : in std_logic_vector(0 to 63);
      Sl_rdWdAddr : in std_logic_vector(0 to 3);
      Sl_rdDAck : in std_logic_vector(0 to 0);
      Sl_rdComp : in std_logic_vector(0 to 0);
      Sl_rdBTerm : in std_logic_vector(0 to 0);
      Sl_MBusy : in std_logic_vector(0 to 0);
      Sl_MErr : in std_logic_vector(0 to 0);
      Sl_ssize : in std_logic_vector(0 to 1);
      PLB_SaddrAck : in std_logic;
      PLB_Swait : in std_logic;
      PLB_Srearbitrate : in std_logic;
      PLB_SwrDAck : in std_logic;
      PLB_SwrComp : in std_logic;
      PLB_SwrBTerm : in std_logic;
      PLB_SrdDBus : in std_logic_vector(0 to 63);
      PLB_SrdWdAddr : in std_logic_vector(0 to 3);
      PLB_SrdDAck : in std_logic;
      PLB_SrdComp : in std_logic;
      PLB_SrdBTerm : in std_logic;
      PLB_SMBusy : in std_logic_vector(0 to 0);
      PLB_SMErr : in std_logic_vector(0 to 0);
      PLB_Sssize : in std_logic_vector(0 to 1)
    );
  end component;

  component synch_bus_wrapper is
    port (
      FROM_SYNCH_OUT : in std_logic_vector(0 to 95);
      TO_SYNCH_IN : out std_logic_vector(0 to 31)
    );
  end component;

  component plb_bus_wrapper is
    port (
      PLB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      PLB_Rst : out std_logic;
      PLB_dcrAck : out std_logic;
      PLB_dcrDBus : out std_logic_vector(0 to 31);
      DCR_ABus : in std_logic_vector(0 to 9);
      DCR_DBus : in std_logic_vector(0 to 31);
      DCR_Read : in std_logic;
      DCR_Write : in std_logic;
      M_ABus : in std_logic_vector(0 to 31);
      M_BE : in std_logic_vector(0 to 7);
      M_RNW : in std_logic_vector(0 to 0);
      M_abort : in std_logic_vector(0 to 0);
      M_busLock : in std_logic_vector(0 to 0);
      M_compress : in std_logic_vector(0 to 0);
      M_guarded : in std_logic_vector(0 to 0);
      M_lockErr : in std_logic_vector(0 to 0);
      M_MSize : in std_logic_vector(0 to 1);
      M_ordered : in std_logic_vector(0 to 0);
      M_priority : in std_logic_vector(0 to 1);
      M_rdBurst : in std_logic_vector(0 to 0);
      M_request : in std_logic_vector(0 to 0);
      M_size : in std_logic_vector(0 to 3);
      M_type : in std_logic_vector(0 to 2);
      M_wrBurst : in std_logic_vector(0 to 0);
      M_wrDBus : in std_logic_vector(0 to 63);
      Sl_addrAck : in std_logic_vector(0 to 0);
      Sl_MErr : in std_logic_vector(0 to 0);
      Sl_MBusy : in std_logic_vector(0 to 0);
      Sl_rdBTerm : in std_logic_vector(0 to 0);
      Sl_rdComp : in std_logic_vector(0 to 0);
      Sl_rdDAck : in std_logic_vector(0 to 0);
      Sl_rdDBus : in std_logic_vector(0 to 63);
      Sl_rdWdAddr : in std_logic_vector(0 to 3);
      Sl_rearbitrate : in std_logic_vector(0 to 0);
      Sl_SSize : in std_logic_vector(0 to 1);
      Sl_wait : in std_logic_vector(0 to 0);
      Sl_wrBTerm : in std_logic_vector(0 to 0);
      Sl_wrComp : in std_logic_vector(0 to 0);
      Sl_wrDAck : in std_logic_vector(0 to 0);
      PLB_ABus : out std_logic_vector(0 to 31);
      PLB_BE : out std_logic_vector(0 to 7);
      PLB_MAddrAck : out std_logic_vector(0 to 0);
      PLB_MBusy : out std_logic_vector(0 to 0);
      PLB_MErr : out std_logic_vector(0 to 0);
      PLB_MRdBTerm : out std_logic_vector(0 to 0);
      PLB_MRdDAck : out std_logic_vector(0 to 0);
      PLB_MRdDBus : out std_logic_vector(0 to 63);
      PLB_MRdWdAddr : out std_logic_vector(0 to 3);
      PLB_MRearbitrate : out std_logic_vector(0 to 0);
      PLB_MWrBTerm : out std_logic_vector(0 to 0);
      PLB_MWrDAck : out std_logic_vector(0 to 0);
      PLB_MSSize : out std_logic_vector(0 to 1);
      PLB_PAValid : out std_logic;
      PLB_RNW : out std_logic;
      PLB_SAValid : out std_logic;
      PLB_abort : out std_logic;
      PLB_busLock : out std_logic;
      PLB_compress : out std_logic;
      PLB_guarded : out std_logic;
      PLB_lockErr : out std_logic;
      PLB_masterID : out std_logic_vector(0 to 0);
      PLB_MSize : out std_logic_vector(0 to 1);
      PLB_ordered : out std_logic;
      PLB_pendPri : out std_logic_vector(0 to 1);
      PLB_pendReq : out std_logic;
      PLB_rdBurst : out std_logic;
      PLB_rdPrim : out std_logic;
      PLB_reqPri : out std_logic_vector(0 to 1);
      PLB_size : out std_logic_vector(0 to 3);
      PLB_type : out std_logic_vector(0 to 2);
      PLB_wrBurst : out std_logic;
      PLB_wrDBus : out std_logic_vector(0 to 63);
      PLB_wrPrim : out std_logic;
      PLB_SaddrAck : out std_logic;
      PLB_SMErr : out std_logic_vector(0 to 0);
      PLB_SMBusy : out std_logic_vector(0 to 0);
      PLB_SrdBTerm : out std_logic;
      PLB_SrdComp : out std_logic;
      PLB_SrdDAck : out std_logic;
      PLB_SrdDBus : out std_logic_vector(0 to 63);
      PLB_SrdWdAddr : out std_logic_vector(0 to 3);
      PLB_Srearbitrate : out std_logic;
      PLB_Sssize : out std_logic_vector(0 to 1);
      PLB_Swait : out std_logic;
      PLB_SwrBTerm : out std_logic;
      PLB_SwrComp : out std_logic;
      PLB_SwrDAck : out std_logic;
      PLB2OPB_rearb : in std_logic_vector(0 to 0);
      ArbAddrVldReg : out std_logic;
      Bus_Error_Det : out std_logic
    );
  end component;

  component plb_ddr2_wrapper is
    port (
      PLB_Clk : in std_logic;
      PLB_Rst : in std_logic;
      Sl_addrAck : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to 0);
      Sl_MErr : out std_logic_vector(0 to 0);
      Sl_rdBTerm : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdDAck : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to 63);
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rearbitrate : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrDAck : out std_logic;
      PLB_abort : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_BE : in std_logic_vector(0 to 7);
      PLB_busLock : in std_logic;
      PLB_compress : in std_logic;
      PLB_guarded : in std_logic;
      PLB_lockErr : in std_logic;
      PLB_masterID : in std_logic_vector(0 to 0);
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_ordered : in std_logic;
      PLB_PAValid : in std_logic;
      PLB_pendPri : in std_logic_vector(0 to 1);
      PLB_pendReq : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_RNW : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrBurst : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to 63);
      PLB_wrPrim : in std_logic;
      SYNCH_IN : in std_logic_vector(0 to 31);
      SYNCH_OUT : out std_logic_vector(0 to 31)
    );
  end component;

  component IBUF is
    port (
      I : in std_logic;
      O : out std_logic
    );
  end component;

  component BUFGP is
    port (
      I : in std_logic;
      O : out std_logic
    );
  end component;

  -- Internal signals

  signal net_gnd0 : std_logic;
  signal net_gnd1 : std_logic_vector(0 to 0);
  signal net_gnd10 : std_logic_vector(0 to 9);
  signal net_gnd32 : std_logic_vector(0 to 31);
  signal pgassign1 : std_logic_vector(0 to 95);
  signal plb_bus_M_ABus : std_logic_vector(0 to 31);
  signal plb_bus_M_BE : std_logic_vector(0 to 7);
  signal plb_bus_M_MSize : std_logic_vector(0 to 1);
  signal plb_bus_M_RNW : std_logic_vector(0 to 0);
  signal plb_bus_M_abort : std_logic_vector(0 to 0);
  signal plb_bus_M_busLock : std_logic_vector(0 to 0);
  signal plb_bus_M_compress : std_logic_vector(0 to 0);
  signal plb_bus_M_guarded : std_logic_vector(0 to 0);
  signal plb_bus_M_lockErr : std_logic_vector(0 to 0);
  signal plb_bus_M_ordered : std_logic_vector(0 to 0);
  signal plb_bus_M_priority : std_logic_vector(0 to 1);
  signal plb_bus_M_rdBurst : std_logic_vector(0 to 0);
  signal plb_bus_M_request : std_logic_vector(0 to 0);
  signal plb_bus_M_size : std_logic_vector(0 to 3);
  signal plb_bus_M_type : std_logic_vector(0 to 2);
  signal plb_bus_M_wrBurst : std_logic_vector(0 to 0);
  signal plb_bus_M_wrDBus : std_logic_vector(0 to 63);
  signal plb_bus_PLB_ABus : std_logic_vector(0 to 31);
  signal plb_bus_PLB_BE : std_logic_vector(0 to 7);
  signal plb_bus_PLB_MAddrAck : std_logic_vector(0 to 0);
  signal plb_bus_PLB_MBusy : std_logic_vector(0 to 0);
  signal plb_bus_PLB_MErr : std_logic_vector(0 to 0);
  signal plb_bus_PLB_MRdBTerm : std_logic_vector(0 to 0);
  signal plb_bus_PLB_MRdDAck : std_logic_vector(0 to 0);
  signal plb_bus_PLB_MRdDBus : std_logic_vector(0 to 63);
  signal plb_bus_PLB_MRdWdAddr : std_logic_vector(0 to 3);
  signal plb_bus_PLB_MRearbitrate : std_logic_vector(0 to 0);
  signal plb_bus_PLB_MSSize : std_logic_vector(0 to 1);
  signal plb_bus_PLB_MSize : std_logic_vector(0 to 1);
  signal plb_bus_PLB_MWrBTerm : std_logic_vector(0 to 0);
  signal plb_bus_PLB_MWrDAck : std_logic_vector(0 to 0);
  signal plb_bus_PLB_PAValid : std_logic;
  signal plb_bus_PLB_RNW : std_logic;
  signal plb_bus_PLB_Rst : std_logic;
  signal plb_bus_PLB_SAValid : std_logic;
  signal plb_bus_PLB_SMBusy : std_logic_vector(0 to 0);
  signal plb_bus_PLB_SMErr : std_logic_vector(0 to 0);
  signal plb_bus_PLB_SaddrAck : std_logic;
  signal plb_bus_PLB_SrdBTerm : std_logic;
  signal plb_bus_PLB_SrdComp : std_logic;
  signal plb_bus_PLB_SrdDAck : std_logic;
  signal plb_bus_PLB_SrdDBus : std_logic_vector(0 to 63);
  signal plb_bus_PLB_SrdWdAddr : std_logic_vector(0 to 3);
  signal plb_bus_PLB_Srearbitrate : std_logic;
  signal plb_bus_PLB_Sssize : std_logic_vector(0 to 1);
  signal plb_bus_PLB_Swait : std_logic;
  signal plb_bus_PLB_SwrBTerm : std_logic;
  signal plb_bus_PLB_SwrComp : std_logic;
  signal plb_bus_PLB_SwrDAck : std_logic;
  signal plb_bus_PLB_abort : std_logic;
  signal plb_bus_PLB_busLock : std_logic;
  signal plb_bus_PLB_compress : std_logic;
  signal plb_bus_PLB_guarded : std_logic;
  signal plb_bus_PLB_lockErr : std_logic;
  signal plb_bus_PLB_masterID : std_logic_vector(0 to 0);
  signal plb_bus_PLB_ordered : std_logic;
  signal plb_bus_PLB_pendPri : std_logic_vector(0 to 1);
  signal plb_bus_PLB_pendReq : std_logic;
  signal plb_bus_PLB_rdBurst : std_logic;
  signal plb_bus_PLB_rdPrim : std_logic;
  signal plb_bus_PLB_reqPri : std_logic_vector(0 to 1);
  signal plb_bus_PLB_size : std_logic_vector(0 to 3);
  signal plb_bus_PLB_type : std_logic_vector(0 to 2);
  signal plb_bus_PLB_wrBurst : std_logic;
  signal plb_bus_PLB_wrDBus : std_logic_vector(0 to 63);
  signal plb_bus_PLB_wrPrim : std_logic;
  signal plb_bus_Sl_MBusy : std_logic_vector(0 to 0);
  signal plb_bus_Sl_MErr : std_logic_vector(0 to 0);
  signal plb_bus_Sl_SSize : std_logic_vector(0 to 1);
  signal plb_bus_Sl_addrAck : std_logic_vector(0 to 0);
  signal plb_bus_Sl_rdBTerm : std_logic_vector(0 to 0);
  signal plb_bus_Sl_rdComp : std_logic_vector(0 to 0);
  signal plb_bus_Sl_rdDAck : std_logic_vector(0 to 0);
  signal plb_bus_Sl_rdDBus : std_logic_vector(0 to 63);
  signal plb_bus_Sl_rdWdAddr : std_logic_vector(0 to 3);
  signal plb_bus_Sl_rearbitrate : std_logic_vector(0 to 0);
  signal plb_bus_Sl_wait : std_logic_vector(0 to 0);
  signal plb_bus_Sl_wrBTerm : std_logic_vector(0 to 0);
  signal plb_bus_Sl_wrComp : std_logic_vector(0 to 0);
  signal plb_bus_Sl_wrDAck : std_logic_vector(0 to 0);
  signal synch : std_logic_vector(0 to 31);
  signal synch0 : std_logic_vector(0 to 31);
  signal synch1 : std_logic_vector(0 to 31);
  signal synch2 : std_logic_vector(0 to 31);
  signal sys_clk_BUFGP : std_logic;
  signal sys_reset_IBUF : std_logic;

begin

  -- Internal assignments

  pgassign1(0 to 31) <= synch0(0 to 31);
  pgassign1(32 to 63) <= synch1(0 to 31);
  pgassign1(64 to 95) <= synch2(0 to 31);
  net_gnd0 <= '0';
  net_gnd1(0 to 0) <= B"0";
  net_gnd10(0 to 9) <= B"0000000000";
  net_gnd32(0 to 31) <= B"00000000000000000000000000000000";

  bfm_processor : bfm_processor_wrapper
    port map (
      PLB_CLK => sys_clk_BUFGP,
      PLB_RESET => plb_bus_PLB_Rst,
      SYNCH_OUT => synch0,
      SYNCH_IN => synch,
      PLB_MAddrAck => plb_bus_PLB_MAddrAck(0),
      PLB_MSsize => plb_bus_PLB_MSSize,
      PLB_MRearbitrate => plb_bus_PLB_MRearbitrate(0),
      PLB_MBusy => plb_bus_PLB_MBusy(0),
      PLB_MErr => plb_bus_PLB_MErr(0),
      PLB_MWrDAck => plb_bus_PLB_MWrDAck(0),
      PLB_MRdDBus => plb_bus_PLB_MRdDBus,
      PLB_MRdWdAddr => plb_bus_PLB_MRdWdAddr,
      PLB_MRdDAck => plb_bus_PLB_MRdDAck(0),
      PLB_MRdBTerm => plb_bus_PLB_MRdBTerm(0),
      PLB_MWrBTerm => plb_bus_PLB_MWrBTerm(0),
      M_request => plb_bus_M_request(0),
      M_priority => plb_bus_M_priority,
      M_buslock => plb_bus_M_busLock(0),
      M_RNW => plb_bus_M_RNW(0),
      M_BE => plb_bus_M_BE,
      M_msize => plb_bus_M_MSize,
      M_size => plb_bus_M_size,
      M_type => plb_bus_M_type,
      M_compress => plb_bus_M_compress(0),
      M_guarded => plb_bus_M_guarded(0),
      M_ordered => plb_bus_M_ordered(0),
      M_lockErr => plb_bus_M_lockErr(0),
      M_abort => plb_bus_M_abort(0),
      M_ABus => plb_bus_M_ABus,
      M_wrDBus => plb_bus_M_wrDBus,
      M_wrBurst => plb_bus_M_wrBurst(0),
      M_rdBurst => plb_bus_M_rdBurst(0)
    );

  bfm_monitor : bfm_monitor_wrapper
    port map (
      PLB_CLK => sys_clk_BUFGP,
      PLB_RESET => plb_bus_PLB_Rst,
      SYNCH_OUT => synch1,
      SYNCH_IN => synch,
      M_request => plb_bus_M_request(0 to 0),
      M_priority => plb_bus_M_priority,
      M_buslock => plb_bus_M_busLock(0 to 0),
      M_RNW => plb_bus_M_RNW(0 to 0),
      M_BE => plb_bus_M_BE,
      M_msize => plb_bus_M_MSize,
      M_size => plb_bus_M_size,
      M_type => plb_bus_M_type,
      M_compress => plb_bus_M_compress(0 to 0),
      M_guarded => plb_bus_M_guarded(0 to 0),
      M_ordered => plb_bus_M_ordered(0 to 0),
      M_lockErr => plb_bus_M_lockErr(0 to 0),
      M_abort => plb_bus_M_abort(0 to 0),
      M_ABus => plb_bus_M_ABus,
      M_wrDBus => plb_bus_M_wrDBus,
      M_wrBurst => plb_bus_M_wrBurst(0 to 0),
      M_rdBurst => plb_bus_M_rdBurst(0 to 0),
      PLB_MAddrAck => plb_bus_PLB_MAddrAck(0 to 0),
      PLB_MRearbitrate => plb_bus_PLB_MRearbitrate(0 to 0),
      PLB_MBusy => plb_bus_PLB_MBusy(0 to 0),
      PLB_MErr => plb_bus_PLB_MErr(0 to 0),
      PLB_MWrDAck => plb_bus_PLB_MWrDAck(0 to 0),
      PLB_MRdDBus => plb_bus_PLB_MRdDBus,
      PLB_MRdWdAddr => plb_bus_PLB_MRdWdAddr,
      PLB_MRdDAck => plb_bus_PLB_MRdDAck(0 to 0),
      PLB_MRdBTerm => plb_bus_PLB_MRdBTerm(0 to 0),
      PLB_MWrBTerm => plb_bus_PLB_MWrBTerm(0 to 0),
      PLB_Mssize => plb_bus_PLB_MSSize,
      PLB_PAValid => plb_bus_PLB_PAValid,
      PLB_SAValid => plb_bus_PLB_SAValid,
      PLB_rdPrim => plb_bus_PLB_rdPrim,
      PLB_wrPrim => plb_bus_PLB_wrPrim,
      PLB_MasterID => plb_bus_PLB_masterID(0 to 0),
      PLB_abort => plb_bus_PLB_abort,
      PLB_busLock => plb_bus_PLB_busLock,
      PLB_RNW => plb_bus_PLB_RNW,
      PLB_BE => plb_bus_PLB_BE,
      PLB_msize => plb_bus_PLB_MSize,
      PLB_size => plb_bus_PLB_size,
      PLB_type => plb_bus_PLB_type,
      PLB_compress => plb_bus_PLB_compress,
      PLB_guarded => plb_bus_PLB_guarded,
      PLB_ordered => plb_bus_PLB_ordered,
      PLB_lockErr => plb_bus_PLB_lockErr,
      PLB_ABus => plb_bus_PLB_ABus,
      PLB_wrDBus => plb_bus_PLB_wrDBus,
      PLB_wrBurst => plb_bus_PLB_wrBurst,
      PLB_rdBurst => plb_bus_PLB_rdBurst,
      PLB_pendReq => plb_bus_PLB_pendReq,
      PLB_pendPri => plb_bus_PLB_pendPri,
      PLB_reqPri => plb_bus_PLB_reqPri,
      Sl_addrAck => plb_bus_Sl_addrAck(0 to 0),
      Sl_wait => plb_bus_Sl_wait(0 to 0),
      Sl_rearbitrate => plb_bus_Sl_rearbitrate(0 to 0),
      Sl_wrDAck => plb_bus_Sl_wrDAck(0 to 0),
      Sl_wrComp => plb_bus_Sl_wrComp(0 to 0),
      Sl_wrBTerm => plb_bus_Sl_wrBTerm(0 to 0),
      Sl_rdDBus => plb_bus_Sl_rdDBus,
      Sl_rdWdAddr => plb_bus_Sl_rdWdAddr,
      Sl_rdDAck => plb_bus_Sl_rdDAck(0 to 0),
      Sl_rdComp => plb_bus_Sl_rdComp(0 to 0),
      Sl_rdBTerm => plb_bus_Sl_rdBTerm(0 to 0),
      Sl_MBusy => plb_bus_Sl_MBusy(0 to 0),
      Sl_MErr => plb_bus_Sl_MErr(0 to 0),
      Sl_ssize => plb_bus_Sl_SSize,
      PLB_SaddrAck => plb_bus_PLB_SaddrAck,
      PLB_Swait => plb_bus_PLB_Swait,
      PLB_Srearbitrate => plb_bus_PLB_Srearbitrate,
      PLB_SwrDAck => plb_bus_PLB_SwrDAck,
      PLB_SwrComp => plb_bus_PLB_SwrComp,
      PLB_SwrBTerm => plb_bus_PLB_SwrBTerm,
      PLB_SrdDBus => plb_bus_PLB_SrdDBus,
      PLB_SrdWdAddr => plb_bus_PLB_SrdWdAddr,
      PLB_SrdDAck => plb_bus_PLB_SrdDAck,
      PLB_SrdComp => plb_bus_PLB_SrdComp,
      PLB_SrdBTerm => plb_bus_PLB_SrdBTerm,
      PLB_SMBusy => plb_bus_PLB_SMBusy(0 to 0),
      PLB_SMErr => plb_bus_PLB_SMErr(0 to 0),
      PLB_Sssize => plb_bus_PLB_Sssize
    );

  synch_bus : synch_bus_wrapper
    port map (
      FROM_SYNCH_OUT => pgassign1,
      TO_SYNCH_IN => synch
    );

  plb_bus : plb_bus_wrapper
    port map (
      PLB_Clk => sys_clk_BUFGP,
      SYS_Rst => sys_reset_IBUF,
      PLB_Rst => plb_bus_PLB_Rst,
      PLB_dcrAck => open,
      PLB_dcrDBus => open,
      DCR_ABus => net_gnd10,
      DCR_DBus => net_gnd32,
      DCR_Read => net_gnd0,
      DCR_Write => net_gnd0,
      M_ABus => plb_bus_M_ABus,
      M_BE => plb_bus_M_BE,
      M_RNW => plb_bus_M_RNW(0 to 0),
      M_abort => plb_bus_M_abort(0 to 0),
      M_busLock => plb_bus_M_busLock(0 to 0),
      M_compress => plb_bus_M_compress(0 to 0),
      M_guarded => plb_bus_M_guarded(0 to 0),
      M_lockErr => plb_bus_M_lockErr(0 to 0),
      M_MSize => plb_bus_M_MSize,
      M_ordered => plb_bus_M_ordered(0 to 0),
      M_priority => plb_bus_M_priority,
      M_rdBurst => plb_bus_M_rdBurst(0 to 0),
      M_request => plb_bus_M_request(0 to 0),
      M_size => plb_bus_M_size,
      M_type => plb_bus_M_type,
      M_wrBurst => plb_bus_M_wrBurst(0 to 0),
      M_wrDBus => plb_bus_M_wrDBus,
      Sl_addrAck => plb_bus_Sl_addrAck(0 to 0),
      Sl_MErr => plb_bus_Sl_MErr(0 to 0),
      Sl_MBusy => plb_bus_Sl_MBusy(0 to 0),
      Sl_rdBTerm => plb_bus_Sl_rdBTerm(0 to 0),
      Sl_rdComp => plb_bus_Sl_rdComp(0 to 0),
      Sl_rdDAck => plb_bus_Sl_rdDAck(0 to 0),
      Sl_rdDBus => plb_bus_Sl_rdDBus,
      Sl_rdWdAddr => plb_bus_Sl_rdWdAddr,
      Sl_rearbitrate => plb_bus_Sl_rearbitrate(0 to 0),
      Sl_SSize => plb_bus_Sl_SSize,
      Sl_wait => plb_bus_Sl_wait(0 to 0),
      Sl_wrBTerm => plb_bus_Sl_wrBTerm(0 to 0),
      Sl_wrComp => plb_bus_Sl_wrComp(0 to 0),
      Sl_wrDAck => plb_bus_Sl_wrDAck(0 to 0),
      PLB_ABus => plb_bus_PLB_ABus,
      PLB_BE => plb_bus_PLB_BE,
      PLB_MAddrAck => plb_bus_PLB_MAddrAck(0 to 0),
      PLB_MBusy => plb_bus_PLB_MBusy(0 to 0),
      PLB_MErr => plb_bus_PLB_MErr(0 to 0),
      PLB_MRdBTerm => plb_bus_PLB_MRdBTerm(0 to 0),
      PLB_MRdDAck => plb_bus_PLB_MRdDAck(0 to 0),
      PLB_MRdDBus => plb_bus_PLB_MRdDBus,
      PLB_MRdWdAddr => plb_bus_PLB_MRdWdAddr,
      PLB_MRearbitrate => plb_bus_PLB_MRearbitrate(0 to 0),
      PLB_MWrBTerm => plb_bus_PLB_MWrBTerm(0 to 0),
      PLB_MWrDAck => plb_bus_PLB_MWrDAck(0 to 0),
      PLB_MSSize => plb_bus_PLB_MSSize,
      PLB_PAValid => plb_bus_PLB_PAValid,
      PLB_RNW => plb_bus_PLB_RNW,
      PLB_SAValid => plb_bus_PLB_SAValid,
      PLB_abort => plb_bus_PLB_abort,
      PLB_busLock => plb_bus_PLB_busLock,
      PLB_compress => plb_bus_PLB_compress,
      PLB_guarded => plb_bus_PLB_guarded,
      PLB_lockErr => plb_bus_PLB_lockErr,
      PLB_masterID => plb_bus_PLB_masterID(0 to 0),
      PLB_MSize => plb_bus_PLB_MSize,
      PLB_ordered => plb_bus_PLB_ordered,
      PLB_pendPri => plb_bus_PLB_pendPri,
      PLB_pendReq => plb_bus_PLB_pendReq,
      PLB_rdBurst => plb_bus_PLB_rdBurst,
      PLB_rdPrim => plb_bus_PLB_rdPrim,
      PLB_reqPri => plb_bus_PLB_reqPri,
      PLB_size => plb_bus_PLB_size,
      PLB_type => plb_bus_PLB_type,
      PLB_wrBurst => plb_bus_PLB_wrBurst,
      PLB_wrDBus => plb_bus_PLB_wrDBus,
      PLB_wrPrim => plb_bus_PLB_wrPrim,
      PLB_SaddrAck => plb_bus_PLB_SaddrAck,
      PLB_SMErr => plb_bus_PLB_SMErr(0 to 0),
      PLB_SMBusy => plb_bus_PLB_SMBusy(0 to 0),
      PLB_SrdBTerm => plb_bus_PLB_SrdBTerm,
      PLB_SrdComp => plb_bus_PLB_SrdComp,
      PLB_SrdDAck => plb_bus_PLB_SrdDAck,
      PLB_SrdDBus => plb_bus_PLB_SrdDBus,
      PLB_SrdWdAddr => plb_bus_PLB_SrdWdAddr,
      PLB_Srearbitrate => plb_bus_PLB_Srearbitrate,
      PLB_Sssize => plb_bus_PLB_Sssize,
      PLB_Swait => plb_bus_PLB_Swait,
      PLB_SwrBTerm => plb_bus_PLB_SwrBTerm,
      PLB_SwrComp => plb_bus_PLB_SwrComp,
      PLB_SwrDAck => plb_bus_PLB_SwrDAck,
      PLB2OPB_rearb => net_gnd1(0 to 0),
      ArbAddrVldReg => open,
      Bus_Error_Det => open
    );

  plb_ddr2 : plb_ddr2_wrapper
    port map (
      PLB_Clk => sys_clk_BUFGP,
      PLB_Rst => plb_bus_PLB_Rst,
      Sl_addrAck => plb_bus_Sl_addrAck(0),
      Sl_MBusy => plb_bus_Sl_MBusy(0 to 0),
      Sl_MErr => plb_bus_Sl_MErr(0 to 0),
      Sl_rdBTerm => plb_bus_Sl_rdBTerm(0),
      Sl_rdComp => plb_bus_Sl_rdComp(0),
      Sl_rdDAck => plb_bus_Sl_rdDAck(0),
      Sl_rdDBus => plb_bus_Sl_rdDBus,
      Sl_rdWdAddr => plb_bus_Sl_rdWdAddr,
      Sl_rearbitrate => plb_bus_Sl_rearbitrate(0),
      Sl_SSize => plb_bus_Sl_SSize,
      Sl_wait => plb_bus_Sl_wait(0),
      Sl_wrBTerm => plb_bus_Sl_wrBTerm(0),
      Sl_wrComp => plb_bus_Sl_wrComp(0),
      Sl_wrDAck => plb_bus_Sl_wrDAck(0),
      PLB_abort => plb_bus_PLB_abort,
      PLB_ABus => plb_bus_PLB_ABus,
      PLB_BE => plb_bus_PLB_BE,
      PLB_busLock => plb_bus_PLB_busLock,
      PLB_compress => plb_bus_PLB_compress,
      PLB_guarded => plb_bus_PLB_guarded,
      PLB_lockErr => plb_bus_PLB_lockErr,
      PLB_masterID => plb_bus_PLB_masterID(0 to 0),
      PLB_MSize => plb_bus_PLB_MSize,
      PLB_ordered => plb_bus_PLB_ordered,
      PLB_PAValid => plb_bus_PLB_PAValid,
      PLB_pendPri => plb_bus_PLB_pendPri,
      PLB_pendReq => plb_bus_PLB_pendReq,
      PLB_rdBurst => plb_bus_PLB_rdBurst,
      PLB_rdPrim => plb_bus_PLB_rdPrim,
      PLB_reqPri => plb_bus_PLB_reqPri,
      PLB_RNW => plb_bus_PLB_RNW,
      PLB_SAValid => plb_bus_PLB_SAValid,
      PLB_size => plb_bus_PLB_size,
      PLB_type => plb_bus_PLB_type,
      PLB_wrBurst => plb_bus_PLB_wrBurst,
      PLB_wrDBus => plb_bus_PLB_wrDBus,
      PLB_wrPrim => plb_bus_PLB_wrPrim,
      SYNCH_IN => synch,
      SYNCH_OUT => synch2
    );

  ibuf_0 : IBUF
    port map (
      I => sys_reset,
      O => sys_reset_IBUF
    );

  bufgp_1 : BUFGP
    port map (
      I => sys_clk,
      O => sys_clk_BUFGP
    );

end architecture STRUCTURE;

