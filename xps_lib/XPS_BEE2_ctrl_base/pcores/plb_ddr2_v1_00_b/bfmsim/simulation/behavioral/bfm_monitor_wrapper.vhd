-------------------------------------------------------------------------------
-- bfm_monitor_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library plb_bfm;
use plb_bfm.all;

library plb_monitor_bfm_v1_00_a;
use plb_monitor_bfm_v1_00_a.all;

entity bfm_monitor_wrapper is
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
end bfm_monitor_wrapper;

architecture STRUCTURE of bfm_monitor_wrapper is

  component plb_monitor_bfm is
    generic (
      PLB_MONITOR_NUM : std_logic_vector(0 to 3);
      PLB_SLAVE0_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE0_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE1_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE1_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE2_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE2_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE3_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE3_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE4_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE4_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE5_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE5_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE6_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE6_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE7_ADDR_LO_0 : std_logic_vector(0 to 31);
      PLB_SLAVE7_ADDR_HI_0 : std_logic_vector(0 to 31);
      PLB_SLAVE0_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE0_ADDR_HI_1 : std_logic_vector(0 to 31);
      PLB_SLAVE1_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE1_ADDR_HI_1 : std_logic_vector(0 to 31);
      PLB_SLAVE2_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE2_ADDR_HI_1 : std_logic_vector(0 to 31);
      PLB_SLAVE3_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE3_ADDR_HI_1 : std_logic_vector(0 to 31);
      PLB_SLAVE4_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE4_ADDR_HI_1 : std_logic_vector(0 to 31);
      PLB_SLAVE5_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE5_ADDR_HI_1 : std_logic_vector(0 to 31);
      PLB_SLAVE6_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE6_ADDR_HI_1 : std_logic_vector(0 to 31);
      PLB_SLAVE7_ADDR_LO_1 : std_logic_vector(0 to 31);
      PLB_SLAVE7_ADDR_HI_1 : std_logic_vector(0 to 31);
      C_PLB_AWIDTH : integer;
      C_PLB_DWIDTH : integer;
      C_PLB_NUM_MASTERS : integer;
      C_PLB_NUM_SLAVES : integer;
      C_PLB_MID_WIDTH : integer
    );
    port (
      PLB_CLK : in std_logic;
      PLB_RESET : in std_logic;
      SYNCH_OUT : out std_logic_vector(0 to 31);
      SYNCH_IN : in std_logic_vector(0 to 31);
      M_request : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_priority : in std_logic_vector(0 to ((2*C_PLB_NUM_MASTERS)-1));
      M_buslock : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_RNW : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_BE : in std_logic_vector(0 to ((C_PLB_NUM_MASTERS*C_PLB_DWIDTH/8)-1));
      M_msize : in std_logic_vector(0 to ((2*C_PLB_NUM_MASTERS)-1));
      M_size : in std_logic_vector(0 to ((4*C_PLB_NUM_MASTERS)-1));
      M_type : in std_logic_vector(0 to ((3*C_PLB_NUM_MASTERS)-1));
      M_compress : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_guarded : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_ordered : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_lockErr : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_abort : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_ABus : in std_logic_vector(0 to ((C_PLB_AWIDTH*C_PLB_NUM_MASTERS)-1));
      M_wrDBus : in std_logic_vector(0 to ((C_PLB_DWIDTH*C_PLB_NUM_MASTERS)-1));
      M_wrBurst : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_rdBurst : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MAddrAck : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MRearbitrate : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MBusy : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MErr : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MWrDAck : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MRdDBus : in std_logic_vector(0 to ((C_PLB_DWIDTH*C_PLB_NUM_MASTERS)-1));
      PLB_MRdWdAddr : in std_logic_vector(0 to ((4*C_PLB_NUM_MASTERS)-1));
      PLB_MRdDAck : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MRdBTerm : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MWrBTerm : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_Mssize : in std_logic_vector(0 to ((2*C_PLB_NUM_MASTERS)-1));
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_MasterID : in std_logic_vector(0 to C_PLB_MID_WIDTH-1);
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to ((C_PLB_DWIDTH/8)-1));
      PLB_msize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_compress : in std_logic;
      PLB_guarded : in std_logic;
      PLB_ordered : in std_logic;
      PLB_lockErr : in std_logic;
      PLB_ABus : in std_logic_vector(0 to 31);
      PLB_wrDBus : in std_logic_vector(0 to (C_PLB_DWIDTH-1));
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_pendReq : in std_logic;
      PLB_pendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      Sl_addrAck : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_wait : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_rearbitrate : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_wrDAck : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_wrComp : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_wrBTerm : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_rdDBus : in std_logic_vector(0 to ((C_PLB_DWIDTH*C_PLB_NUM_SLAVES)-1));
      Sl_rdWdAddr : in std_logic_vector(0 to ((4*C_PLB_NUM_SLAVES)-1));
      Sl_rdDAck : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_rdComp : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_rdBTerm : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_MBusy : in std_logic_vector(0 to ((C_PLB_NUM_MASTERS*C_PLB_NUM_SLAVES)-1));
      Sl_MErr : in std_logic_vector(0 to ((C_PLB_NUM_MASTERS*C_PLB_NUM_SLAVES)-1));
      Sl_ssize : in std_logic_vector(0 to ((2*C_PLB_NUM_SLAVES)-1));
      PLB_SaddrAck : in std_logic;
      PLB_Swait : in std_logic;
      PLB_Srearbitrate : in std_logic;
      PLB_SwrDAck : in std_logic;
      PLB_SwrComp : in std_logic;
      PLB_SwrBTerm : in std_logic;
      PLB_SrdDBus : in std_logic_vector(0 to C_PLB_DWIDTH-1);
      PLB_SrdWdAddr : in std_logic_vector(0 to 3);
      PLB_SrdDAck : in std_logic;
      PLB_SrdComp : in std_logic;
      PLB_SrdBTerm : in std_logic;
      PLB_SMBusy : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_SMErr : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_Sssize : in std_logic_vector(0 to 1)
    );
  end component;

begin

  bfm_monitor : plb_monitor_bfm
    generic map (
      PLB_MONITOR_NUM => "0000",
      PLB_SLAVE0_ADDR_LO_0 => X"00000000",
      PLB_SLAVE0_ADDR_HI_0 => X"00000000",
      PLB_SLAVE1_ADDR_LO_0 => X"00000000",
      PLB_SLAVE1_ADDR_HI_0 => X"00000000",
      PLB_SLAVE2_ADDR_LO_0 => X"00000000",
      PLB_SLAVE2_ADDR_HI_0 => X"00000000",
      PLB_SLAVE3_ADDR_LO_0 => X"00000000",
      PLB_SLAVE3_ADDR_HI_0 => X"00000000",
      PLB_SLAVE4_ADDR_LO_0 => X"00000000",
      PLB_SLAVE4_ADDR_HI_0 => X"00000000",
      PLB_SLAVE5_ADDR_LO_0 => X"00000000",
      PLB_SLAVE5_ADDR_HI_0 => X"00000000",
      PLB_SLAVE6_ADDR_LO_0 => X"00000000",
      PLB_SLAVE6_ADDR_HI_0 => X"00000000",
      PLB_SLAVE7_ADDR_LO_0 => X"00000000",
      PLB_SLAVE7_ADDR_HI_0 => X"00000000",
      PLB_SLAVE0_ADDR_LO_1 => X"00000000",
      PLB_SLAVE0_ADDR_HI_1 => X"00000000",
      PLB_SLAVE1_ADDR_LO_1 => X"00000000",
      PLB_SLAVE1_ADDR_HI_1 => X"00000000",
      PLB_SLAVE2_ADDR_LO_1 => X"00000000",
      PLB_SLAVE2_ADDR_HI_1 => X"00000000",
      PLB_SLAVE3_ADDR_LO_1 => X"00000000",
      PLB_SLAVE3_ADDR_HI_1 => X"00000000",
      PLB_SLAVE4_ADDR_LO_1 => X"00000000",
      PLB_SLAVE4_ADDR_HI_1 => X"00000000",
      PLB_SLAVE5_ADDR_LO_1 => X"00000000",
      PLB_SLAVE5_ADDR_HI_1 => X"00000000",
      PLB_SLAVE6_ADDR_LO_1 => X"00000000",
      PLB_SLAVE6_ADDR_HI_1 => X"00000000",
      PLB_SLAVE7_ADDR_LO_1 => X"00000000",
      PLB_SLAVE7_ADDR_HI_1 => X"00000000",
      C_PLB_AWIDTH => 32,
      C_PLB_DWIDTH => 64,
      C_PLB_NUM_MASTERS => 1,
      C_PLB_NUM_SLAVES => 1,
      C_PLB_MID_WIDTH => 1
    )
    port map (
      PLB_CLK => PLB_CLK,
      PLB_RESET => PLB_RESET,
      SYNCH_OUT => SYNCH_OUT,
      SYNCH_IN => SYNCH_IN,
      M_request => M_request,
      M_priority => M_priority,
      M_buslock => M_buslock,
      M_RNW => M_RNW,
      M_BE => M_BE,
      M_msize => M_msize,
      M_size => M_size,
      M_type => M_type,
      M_compress => M_compress,
      M_guarded => M_guarded,
      M_ordered => M_ordered,
      M_lockErr => M_lockErr,
      M_abort => M_abort,
      M_ABus => M_ABus,
      M_wrDBus => M_wrDBus,
      M_wrBurst => M_wrBurst,
      M_rdBurst => M_rdBurst,
      PLB_MAddrAck => PLB_MAddrAck,
      PLB_MRearbitrate => PLB_MRearbitrate,
      PLB_MBusy => PLB_MBusy,
      PLB_MErr => PLB_MErr,
      PLB_MWrDAck => PLB_MWrDAck,
      PLB_MRdDBus => PLB_MRdDBus,
      PLB_MRdWdAddr => PLB_MRdWdAddr,
      PLB_MRdDAck => PLB_MRdDAck,
      PLB_MRdBTerm => PLB_MRdBTerm,
      PLB_MWrBTerm => PLB_MWrBTerm,
      PLB_Mssize => PLB_Mssize,
      PLB_PAValid => PLB_PAValid,
      PLB_SAValid => PLB_SAValid,
      PLB_rdPrim => PLB_rdPrim,
      PLB_wrPrim => PLB_wrPrim,
      PLB_MasterID => PLB_MasterID,
      PLB_abort => PLB_abort,
      PLB_busLock => PLB_busLock,
      PLB_RNW => PLB_RNW,
      PLB_BE => PLB_BE,
      PLB_msize => PLB_msize,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_compress => PLB_compress,
      PLB_guarded => PLB_guarded,
      PLB_ordered => PLB_ordered,
      PLB_lockErr => PLB_lockErr,
      PLB_ABus => PLB_ABus,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrBurst => PLB_wrBurst,
      PLB_rdBurst => PLB_rdBurst,
      PLB_pendReq => PLB_pendReq,
      PLB_pendPri => PLB_pendPri,
      PLB_reqPri => PLB_reqPri,
      Sl_addrAck => Sl_addrAck,
      Sl_wait => Sl_wait,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_wrDAck => Sl_wrDAck,
      Sl_wrComp => Sl_wrComp,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdComp => Sl_rdComp,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_MBusy => Sl_MBusy,
      Sl_MErr => Sl_MErr,
      Sl_ssize => Sl_ssize,
      PLB_SaddrAck => PLB_SaddrAck,
      PLB_Swait => PLB_Swait,
      PLB_Srearbitrate => PLB_Srearbitrate,
      PLB_SwrDAck => PLB_SwrDAck,
      PLB_SwrComp => PLB_SwrComp,
      PLB_SwrBTerm => PLB_SwrBTerm,
      PLB_SrdDBus => PLB_SrdDBus,
      PLB_SrdWdAddr => PLB_SrdWdAddr,
      PLB_SrdDAck => PLB_SrdDAck,
      PLB_SrdComp => PLB_SrdComp,
      PLB_SrdBTerm => PLB_SrdBTerm,
      PLB_SMBusy => PLB_SMBusy,
      PLB_SMErr => PLB_SMErr,
      PLB_Sssize => PLB_Sssize
    );

end architecture STRUCTURE;

