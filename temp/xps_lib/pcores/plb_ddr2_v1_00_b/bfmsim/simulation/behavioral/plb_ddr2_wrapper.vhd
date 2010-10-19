-------------------------------------------------------------------------------
-- plb_ddr2_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library plb_ddr2_v1_00_a;
use plb_ddr2_v1_00_a.all;

library plb_ddr2_tb_v1_00_a;
use plb_ddr2_tb_v1_00_a.all;

entity plb_ddr2_wrapper is
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
end plb_ddr2_wrapper;

architecture STRUCTURE of plb_ddr2_wrapper is

  component plb_ddr2_tb is
    generic (
      C_MEM_BASE_ADDR : integer;
      C_MEM_HIGH_ADDR : integer;
      C_PLB_AWIDTH : integer;
      C_PLB_DWIDTH : integer;
      C_PLB_NUM_MASTERS : integer;
      C_PLB_MID_WIDTH : integer;
      C_FAMILY : string
    );
    port (
      PLB_Clk : in std_logic;
      PLB_Rst : in std_logic;
      Sl_addrAck : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      Sl_MErr : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      Sl_rdBTerm : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdDAck : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to (C_PLB_DWIDTH-1));
      Sl_rdWdAddr : out std_logic_vector(0 to (3));
      Sl_rearbitrate : out std_logic;
      Sl_SSize : out std_logic_vector(0 to (1));
      Sl_wait : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrDAck : out std_logic;
      PLB_abort : in std_logic;
      PLB_ABus : in std_logic_vector(0 to (C_PLB_AWIDTH-1));
      PLB_BE : in std_logic_vector(0 to (C_PLB_DWIDTH/8-1));
      PLB_busLock : in std_logic;
      PLB_compress : in std_logic;
      PLB_guarded : in std_logic;
      PLB_lockErr : in std_logic;
      PLB_masterID : in std_logic_vector(0 to (C_PLB_MID_WIDTH-1));
      PLB_MSize : in std_logic_vector(0 to (1));
      PLB_ordered : in std_logic;
      PLB_PAValid : in std_logic;
      PLB_pendPri : in std_logic_vector(0 to (1));
      PLB_pendReq : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_reqPri : in std_logic_vector(0 to (1));
      PLB_RNW : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_size : in std_logic_vector(0 to (3));
      PLB_type : in std_logic_vector(0 to (2));
      PLB_wrBurst : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to (C_PLB_DWIDTH-1));
      PLB_wrPrim : in std_logic;
      SYNCH_IN : in std_logic_vector(0 to 31);
      SYNCH_OUT : out std_logic_vector(0 to 31)
    );
  end component;

begin

  plb_ddr2 : plb_ddr2_tb
    generic map (
      C_MEM_BASE_ADDR => 16#00000000#,
      C_MEM_HIGH_ADDR => 16#3fffffff#,
      C_PLB_AWIDTH => 32,
      C_PLB_DWIDTH => 64,
      C_PLB_NUM_MASTERS => 1,
      C_PLB_MID_WIDTH => 1,
      C_FAMILY => "virtex2p"
    )
    port map (
      PLB_Clk => PLB_Clk,
      PLB_Rst => PLB_Rst,
      Sl_addrAck => Sl_addrAck,
      Sl_MBusy => Sl_MBusy,
      Sl_MErr => Sl_MErr,
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
      PLB_abort => PLB_abort,
      PLB_ABus => PLB_ABus,
      PLB_BE => PLB_BE,
      PLB_busLock => PLB_busLock,
      PLB_compress => PLB_compress,
      PLB_guarded => PLB_guarded,
      PLB_lockErr => PLB_lockErr,
      PLB_masterID => PLB_masterID,
      PLB_MSize => PLB_MSize,
      PLB_ordered => PLB_ordered,
      PLB_PAValid => PLB_PAValid,
      PLB_pendPri => PLB_pendPri,
      PLB_pendReq => PLB_pendReq,
      PLB_rdBurst => PLB_rdBurst,
      PLB_rdPrim => PLB_rdPrim,
      PLB_reqPri => PLB_reqPri,
      PLB_RNW => PLB_RNW,
      PLB_SAValid => PLB_SAValid,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_wrBurst => PLB_wrBurst,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrPrim => PLB_wrPrim,
      SYNCH_IN => SYNCH_IN,
      SYNCH_OUT => SYNCH_OUT
    );

end architecture STRUCTURE;

