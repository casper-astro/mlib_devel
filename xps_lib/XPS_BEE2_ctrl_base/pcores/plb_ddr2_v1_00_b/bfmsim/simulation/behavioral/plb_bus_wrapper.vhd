-------------------------------------------------------------------------------
-- plb_bus_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library proc_common_v1_00_b;
use proc_common_v1_00_b.all;

library plb_v34_v1_02_a;
use plb_v34_v1_02_a.all;

entity plb_bus_wrapper is
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
end plb_bus_wrapper;

architecture STRUCTURE of plb_bus_wrapper is

  component plb_v34 is
    generic (
      C_PLB_NUM_MASTERS : integer;
      C_PLB_NUM_SLAVES : integer;
      C_PLB_MID_WIDTH : integer;
      C_PLB_AWIDTH : integer;
      C_PLB_DWIDTH : integer;
      C_DCR_INTFCE : integer;
      C_BASEADDR : std_logic_vector;
      C_HIGHADDR : std_logic_vector;
      C_DCR_AWIDTH : integer;
      C_DCR_DWIDTH : integer;
      C_EXT_RESET_HIGH : integer;
      C_IRQ_ACTIVE : std_logic;
      C_NUM_OPBCLK_PLB2OPB_REARB : integer
    );
    port (
      PLB_Clk : in std_logic;
      SYS_Rst : in std_logic;
      PLB_Rst : out std_logic;
      PLB_dcrAck : out std_logic;
      PLB_dcrDBus : out std_logic_vector(0 to C_DCR_DWIDTH-1);
      DCR_ABus : in std_logic_vector(0 to C_DCR_AWIDTH-1);
      DCR_DBus : in std_logic_vector(0 to C_DCR_DWIDTH-1);
      DCR_Read : in std_logic;
      DCR_Write : in std_logic;
      M_ABus : in std_logic_vector(0 to (C_PLB_NUM_MASTERS*C_PLB_AWIDTH)-1);
      M_BE : in std_logic_vector(0 to (C_PLB_NUM_MASTERS*(C_PLB_DWIDTH/8))-1);
      M_RNW : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_abort : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_busLock : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_compress : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_guarded : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_lockErr : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_MSize : in std_logic_vector(0 to (C_PLB_NUM_MASTERS*2)-1);
      M_ordered : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_priority : in std_logic_vector(0 to (C_PLB_NUM_MASTERS*2)-1);
      M_rdBurst : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_request : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_size : in std_logic_vector(0 to (C_PLB_NUM_MASTERS*4)-1);
      M_type : in std_logic_vector(0 to (C_PLB_NUM_MASTERS*3)-1);
      M_wrBurst : in std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      M_wrDBus : in std_logic_vector(0 to (C_PLB_NUM_MASTERS*C_PLB_DWIDTH)-1);
      Sl_addrAck : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_MErr : in std_logic_vector(0 to (C_PLB_NUM_SLAVES*C_PLB_NUM_MASTERS)-1);
      Sl_MBusy : in std_logic_vector(0 to C_PLB_NUM_SLAVES*C_PLB_NUM_MASTERS - 1);
      Sl_rdBTerm : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_rdComp : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_rdDAck : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_rdDBus : in std_logic_vector(0 to C_PLB_NUM_SLAVES*C_PLB_DWIDTH-1);
      Sl_rdWdAddr : in std_logic_vector(0 to C_PLB_NUM_SLAVES*4-1);
      Sl_rearbitrate : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_SSize : in std_logic_vector(0 to C_PLB_NUM_SLAVES*2-1);
      Sl_wait : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_wrBTerm : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_wrComp : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      Sl_wrDAck : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      PLB_ABus : out std_logic_vector(0 to C_PLB_AWIDTH-1);
      PLB_BE : out std_logic_vector(0 to (C_PLB_DWIDTH/8)-1);
      PLB_MAddrAck : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MBusy : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MErr : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MRdBTerm : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MRdDAck : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MRdDBus : out std_logic_vector(0 to (C_PLB_NUM_MASTERS*C_PLB_DWIDTH)-1);
      PLB_MRdWdAddr : out std_logic_vector(0 to (C_PLB_NUM_MASTERS*4)-1);
      PLB_MRearbitrate : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MWrBTerm : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MWrDAck : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_MSSize : out std_logic_vector(0 to (C_PLB_NUM_MASTERS*2)-1);
      PLB_PAValid : out std_logic;
      PLB_RNW : out std_logic;
      PLB_SAValid : out std_logic;
      PLB_abort : out std_logic;
      PLB_busLock : out std_logic;
      PLB_compress : out std_logic;
      PLB_guarded : out std_logic;
      PLB_lockErr : out std_logic;
      PLB_masterID : out std_logic_vector(0 to C_PLB_MID_WIDTH-1);
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
      PLB_wrDBus : out std_logic_vector(0 to C_PLB_DWIDTH-1);
      PLB_wrPrim : out std_logic;
      PLB_SaddrAck : out std_logic;
      PLB_SMErr : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_SMBusy : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
      PLB_SrdBTerm : out std_logic;
      PLB_SrdComp : out std_logic;
      PLB_SrdDAck : out std_logic;
      PLB_SrdDBus : out std_logic_vector(0 to C_PLB_DWIDTH-1);
      PLB_SrdWdAddr : out std_logic_vector(0 to 3);
      PLB_Srearbitrate : out std_logic;
      PLB_Sssize : out std_logic_vector(0 to 1);
      PLB_Swait : out std_logic;
      PLB_SwrBTerm : out std_logic;
      PLB_SwrComp : out std_logic;
      PLB_SwrDAck : out std_logic;
      PLB2OPB_rearb : in std_logic_vector(0 to C_PLB_NUM_SLAVES-1);
      ArbAddrVldReg : out std_logic;
      Bus_Error_Det : out std_logic
    );
  end component;

begin

  plb_bus : plb_v34
    generic map (
      C_PLB_NUM_MASTERS => 1,
      C_PLB_NUM_SLAVES => 1,
      C_PLB_MID_WIDTH => 1,
      C_PLB_AWIDTH => 32,
      C_PLB_DWIDTH => 64,
      C_DCR_INTFCE => 0,
      C_BASEADDR => B"1111111111",
      C_HIGHADDR => B"0000000000",
      C_DCR_AWIDTH => 10,
      C_DCR_DWIDTH => 32,
      C_EXT_RESET_HIGH => 0,
      C_IRQ_ACTIVE => '1',
      C_NUM_OPBCLK_PLB2OPB_REARB => 5
    )
    port map (
      PLB_Clk => PLB_Clk,
      SYS_Rst => SYS_Rst,
      PLB_Rst => PLB_Rst,
      PLB_dcrAck => PLB_dcrAck,
      PLB_dcrDBus => PLB_dcrDBus,
      DCR_ABus => DCR_ABus,
      DCR_DBus => DCR_DBus,
      DCR_Read => DCR_Read,
      DCR_Write => DCR_Write,
      M_ABus => M_ABus,
      M_BE => M_BE,
      M_RNW => M_RNW,
      M_abort => M_abort,
      M_busLock => M_busLock,
      M_compress => M_compress,
      M_guarded => M_guarded,
      M_lockErr => M_lockErr,
      M_MSize => M_MSize,
      M_ordered => M_ordered,
      M_priority => M_priority,
      M_rdBurst => M_rdBurst,
      M_request => M_request,
      M_size => M_size,
      M_type => M_type,
      M_wrBurst => M_wrBurst,
      M_wrDBus => M_wrDBus,
      Sl_addrAck => Sl_addrAck,
      Sl_MErr => Sl_MErr,
      Sl_MBusy => Sl_MBusy,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_rdComp => Sl_rdComp,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_wrComp => Sl_wrComp,
      Sl_wrDAck => Sl_wrDAck,
      PLB_ABus => PLB_ABus,
      PLB_BE => PLB_BE,
      PLB_MAddrAck => PLB_MAddrAck,
      PLB_MBusy => PLB_MBusy,
      PLB_MErr => PLB_MErr,
      PLB_MRdBTerm => PLB_MRdBTerm,
      PLB_MRdDAck => PLB_MRdDAck,
      PLB_MRdDBus => PLB_MRdDBus,
      PLB_MRdWdAddr => PLB_MRdWdAddr,
      PLB_MRearbitrate => PLB_MRearbitrate,
      PLB_MWrBTerm => PLB_MWrBTerm,
      PLB_MWrDAck => PLB_MWrDAck,
      PLB_MSSize => PLB_MSSize,
      PLB_PAValid => PLB_PAValid,
      PLB_RNW => PLB_RNW,
      PLB_SAValid => PLB_SAValid,
      PLB_abort => PLB_abort,
      PLB_busLock => PLB_busLock,
      PLB_compress => PLB_compress,
      PLB_guarded => PLB_guarded,
      PLB_lockErr => PLB_lockErr,
      PLB_masterID => PLB_masterID,
      PLB_MSize => PLB_MSize,
      PLB_ordered => PLB_ordered,
      PLB_pendPri => PLB_pendPri,
      PLB_pendReq => PLB_pendReq,
      PLB_rdBurst => PLB_rdBurst,
      PLB_rdPrim => PLB_rdPrim,
      PLB_reqPri => PLB_reqPri,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_wrBurst => PLB_wrBurst,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrPrim => PLB_wrPrim,
      PLB_SaddrAck => PLB_SaddrAck,
      PLB_SMErr => PLB_SMErr,
      PLB_SMBusy => PLB_SMBusy,
      PLB_SrdBTerm => PLB_SrdBTerm,
      PLB_SrdComp => PLB_SrdComp,
      PLB_SrdDAck => PLB_SrdDAck,
      PLB_SrdDBus => PLB_SrdDBus,
      PLB_SrdWdAddr => PLB_SrdWdAddr,
      PLB_Srearbitrate => PLB_Srearbitrate,
      PLB_Sssize => PLB_Sssize,
      PLB_Swait => PLB_Swait,
      PLB_SwrBTerm => PLB_SwrBTerm,
      PLB_SwrComp => PLB_SwrComp,
      PLB_SwrDAck => PLB_SwrDAck,
      PLB2OPB_rearb => PLB2OPB_rearb,
      ArbAddrVldReg => ArbAddrVldReg,
      Bus_Error_Det => Bus_Error_Det
    );

end architecture STRUCTURE;

