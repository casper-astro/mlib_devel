-------------------------------------------------------------------------------
-- axi_window_wdt - entity/architecture pair
-------------------------------------------------------------------------------
--
-- ***************************************************************************
-- DISCLAIMER OF LIABILITY
--
-- This file contains proprietary and confidential information of
-- Xilinx, Inc. ("Xilinx"), that is distributed under a license
-- from Xilinx, and may be used, copied and/or disclosed only
-- pursuant to the terms of a valid license agreement with Xilinx.
--
-- XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
-- ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
-- EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
-- LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
-- MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
-- does not warrant that functions included in the Materials will
-- meet the requirements of Licensee, or that the operation of the
-- Materials will be uninterrupted or error-free, or that defects
-- in the Materials will be corrected. Furthermore, Xilinx does
-- not warrant or make any representations regarding use, or the
-- results of the use, of the Materials in terms of correctness,
-- accuracy, reliability or otherwise.
--
-- Xilinx products are not designed or intended to be fail-safe,
-- or for use in any application requiring fail-safe performance,
-- such as life-support or safety devices or systems, Class III
-- medical devices, nuclear facilities, applications related to
-- the deployment of airbags, or any other applications that could
-- lead to death, personal injury or severe property or
-- environmental damage (individually and collectively, "critical
-- applications"). Customer assumes the sole risk and liability
-- of any use of Xilinx products in critical applications,
-- subject only to applicable laws and regulations governing
-- limitations on product liability.
--
-- Copyright 2001, 2002, 2003, 2004, 2008, 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
-- ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename        :axi_window_wdt.vhd
-- Company         :Xilinx
-- Version         :v3.0
-- Description     :32-bit timebase counter and Watch Dog Timer (WDT)
-- Standard        :VHDL-93
-------------------------------------------------------------------------------
-- Structure:   This section shows the hierarchical structure of
--              axi_window_wdt.
--
--              axi_timebase_wdt_top.vhd
--              -- axi_timebase_windowing.vhd
--              -- axi_timebase_wdt.vhd
--                 -- axi_lite_ipif.vhd
--                 -- timebase_wdt_core.vhd
--
-------------------------------------------------------------------------------
-- ^^^^^^
-- Author:      Kartheek
-- History:
--  Kartheek    23/11/2015      -- Ceated the version  v3.00
-- ^^^^^^
-- ^^^^^^
--
-------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_cmb"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--                     Definition of Generics
-------------------------------------------------------------------------------
-- C_S_AXI_DATA_WIDTH    -- AXI data bus width
-- C_S_AXI_ADDR_WIDTH    -- AXI address bus width
-- C_FAMILY              -- Target FPGA family
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- WINDOW-WDT generics
--  Enable Window WDT    -- ENabling the windowing feature
--  SST Count Width      -- Second sequence timer maximum width
--  Max Count Width      -- First timer maximum width
-------------------------------------------------------------------------------
--                  Definition of Ports
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- s_axi_aclk            -- AXI Clock
-- s_axi_aresetn         -- AXI Reset
-- s_axi_awaddr          -- AXI Write address
-- s_axi_awvalid         -- Write address valid
-- s_axi_awready         -- Write address ready
-- s_axi_wdata           -- Write data
-- s_axi_wstrb           -- Write strobes
-- s_axi_wvalid          -- Write valid
-- s_axi_wready          -- Write ready
-- s_axi_bresp           -- Write response
-- s_axi_bvalid          -- Write response valid
-- s_axi_bready          -- Response ready
-- s_axi_araddr          -- Read address
-- s_axi_arvalid         -- Read address valid
-- s_axi_arready         -- Read address ready
-- s_axi_rdata           -- Read data
-- s_axi_rresp           -- Read response
-- s_axi_rvalid          -- Read valid
-- s_axi_rready          -- Read ready
-------------------------------------------------------------------------------
-- Timebase WDT signals 
-------------------------------------------------------------------------------
-- freeze                -- Freeze count value
-- wdt interface
-- wdt_reset             -- Output. Watchdog Timer Reset
-- timebase_interrupt    -- Output. Timebase Interrupt
-- wdt_interrupt         -- Output. Watchdog Timer Interrupt
-- Window Watchdog signals
-- wdt_reset_pending     -- Output, Indicates Window WDT reset will be asserted after SST count expires.
-- wdt_state_vec         -- Output, Indicates Window WDT reset will be asserted after SST count expires.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library axi_lite_ipif_v3_0_4;
use axi_lite_ipif_v3_0_4.ipif_pkg.SLV64_ARRAY_TYPE;
use axi_lite_ipif_v3_0_4.ipif_pkg.INTEGER_ARRAY_TYPE;
use axi_lite_ipif_v3_0_4.ipif_pkg.calc_num_ce;
library axi_lite_ipif_v3_0_4;
library axi_timebase_wdt_v3_0_1;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
--use IEEE.std_logic_unsigned.all;
-------------------------------------------------------------------------------
-- Entity section
-------------------------------------------------------------------------------

entity axi_window_wdt is
 generic 
  ( C_FAMILY             : string    := "virtex5";
  -- Timebase watchdog timer generics
    C_WDT_INTERVAL       : integer range 8 to 31  := 30;
    C_WDT_ENABLE_ONCE    : integer range 0 to 1   := 1;
  -- axi lite ipif block generics
    C_S_AXI_DATA_WIDTH: integer  range 32 to 32   := 32;
    C_S_AXI_ADDR_WIDTH: integer                   := 4;
    SST_Count_Width      : integer range 8 to 31  := 30;-- Second sequence timer maximum width
    Max_Count_Width      : integer range 8 to 32  := 32
  );  
  port 
  (
    freeze             : in   std_logic;
  -- timebase watchdog timer interface
    wdt_reset          : out std_logic;
    --timebase_interrupt : out std_logic;
    wdt_interrupt      : out std_logic;
    
    --system signals
    s_axi_aclk        : in  std_logic;
    s_axi_aresetn     : in  std_logic := '1';
    s_axi_awaddr      : in  std_logic_vector (C_S_AXI_ADDR_WIDTH-1 downto 0);
                        --(c_s_axi_addr_width-1 downto 0);
    s_axi_awvalid     : in  std_logic;
    s_axi_awready     : out std_logic;
    s_axi_wdata       : in  std_logic_vector (31 downto 0);
                        --(c_s_axi_data_width-1 downto 0);
    s_axi_wstrb       : in  std_logic_vector (3 downto 0);
                        --((c_s_axi_data_width/8)-1 downto 0);
    s_axi_wvalid      : in  std_logic;
    s_axi_wready      : out std_logic;
    s_axi_bresp       : out std_logic_vector(1 downto 0);
    s_axi_bvalid      : out std_logic;
    s_axi_bready      : in  std_logic;
    s_axi_araddr      : in  std_logic_vector (C_S_AXI_ADDR_WIDTH-1 downto 0);
                        --(c_s_axi_addr_width-1 downto 0);
    s_axi_arvalid     : in  std_logic;
    s_axi_arready     : out std_logic;
    s_axi_rdata       : out std_logic_vector (31 downto 0);
                        --(c_s_axi_data_width-1 downto 0);
    s_axi_rresp       : out std_logic_vector(1 downto 0);
    s_axi_rvalid      : out std_logic;
    s_axi_rready      : in  std_logic;
    wdt_reset_pending : out STD_LOGIC;    -- Output, Indicates Window WDT reset will be asserted after SST count expires.
    wdt_state_vec : out STD_LOGIC_VECTOR ( 6 downto 0 ) 
);

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------
-- Fan-Out attributes for XST
ATTRIBUTE MAX_FANOUT                     : string;
ATTRIBUTE MAX_FANOUT   of s_axi_aclk     : signal is "10000";
ATTRIBUTE MAX_FANOUT   of s_axi_aresetn  : signal is "10000";

end entity axi_window_wdt;

-------------------------------------------------------------------------------
-- Architecture section
-------------------------------------------------------------------------------

architecture imp of axi_window_wdt is
-- Pragma Added to supress synth warnings
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of imp : architecture is "yes";

 --Parameters captured for webtalk
   --C_FAMILY
   --C_WDT_INTERVAL
   --C_WDT_ENABLE_ONCE
 

-------------------------------------------------------------------------------
-- Constant declarations
-------------------------------------------------------------------------------

constant ZEROES                 : std_logic_vector(0 to 31) := X"00000000";
constant C_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
        (
          -- TBWDT registers Base Address
          ZEROES & X"0000_0000",
          ZEROES & (X"0000_0000" or X"0000_0030") 
        );

constant C_ARD_NUM_CE_ARRAY     : INTEGER_ARRAY_TYPE :=
        (
          0 => 13--, -- MWCR
      --    1 => 27, --Status Reg
      --    2 => 16, -- FUn COntrol Reg
      --    3 => 32, -- FWCR
      --    4 => 32, -- SWCR
      --    5 => 32, -- TSR0
      --    6 => 32, -- TSR1
      --    7 => 32, -- SSTR
      --    8 => 12, --TFR
      --    9 => 8 -- TRR
        );
constant C_WINDOW_MODE          :integer := 0;
constant C_USE_WSTRB            :integer := 1;
constant C_S_AXI_MIN_SIZE       :std_logic_vector(31 downto 0):= X"00000030";
constant C_DPHASE_TIMEOUT       :integer range 0 to 256   := 32;
constant C_FAIL_CNT_WIDTH       :integer range 1 to 7   := 3;
-------------------------------------------------------------------------------
--  Function Declarations
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Bitwise AND of a std_logic_vector.
-------------------------------------------------------------------------------
    function and_reduce(slv : std_logic_vector) return std_logic is
        variable r : std_logic := '1';
    begin
        for i in slv'range loop
            r := r and slv(i);
        end loop;
        return r;
    end and_reduce;
-------------------------------------------------------------------------------
-- Signal declarations
-------------------------------------------------------------------------------

signal wdt_reset_int   : std_logic;
signal wdt_reset_reg   : std_logic;
signal bus2ip_clk      : std_logic;                    
signal bus2ip_reset    : std_logic; 
signal bus2ip_resetn   : std_logic;
signal ip2bus_data     : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0):= 
                         (others  => '0');
signal ip2bus_error    : std_logic;-- := '0';
signal ip2bus_wrack    : std_logic;-- := '0';
signal ip2bus_rdack    : std_logic;-- := '0';
signal ip2bus_rdack_i  : std_logic;-- := '0';

signal bus2ip_data     : std_logic_vector
                         (C_S_AXI_DATA_WIDTH - 1 downto 0);
signal bus2ip_addr     : std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
signal bus2ip_be       : std_logic_vector
                         ((C_S_AXI_DATA_WIDTH / 8 - 1)  downto 0);
signal bus2ip_cs       : std_logic_vector
                         (((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0);
signal bus2ip_rdce     : std_logic_vector
                         (calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);
signal bus2ip_wrce     : std_logic_vector
                         (calc_num_ce(C_ARD_NUM_CE_ARRAY)-1 downto 0);

signal mwc_reg_acc     : std_logic:='0';
signal status_reg_acc  : std_logic:='0';
signal fcr_reg_acc     : std_logic:='0';
signal fwc_reg_acc     : std_logic:='0';
signal swc_reg_acc     : std_logic:='0';
signal tsr0_reg_acc    : std_logic:='0';
signal tsr1_reg_acc    : std_logic:='0';
signal sst_reg_acc     : std_logic:='0';
signal tfr_reg_acc     : std_logic:='0';
signal trr_reg_acc     : std_logic:='0';
--signal fail_cnt        : std_logic_vector(C_FAIL_CNT_WIDTH-1 downto 0);--:=(others  => '0');
signal fc_en           : std_logic:='0';
signal cnt_en          : std_logic:='0';
signal cnt_val         : std_logic:='0';
signal dis_wdt_fc      : std_logic;
signal aen_reg         : std_logic;
signal aen_trig        : std_logic;
signal wdt_reset_pending_int : std_logic:='0';
-------------------------------------------------------------------------------
-- Constant Declarations
-------------------------------------------------------------------------------
--constant mwc_register : integer := 13;
--constant status_register : integer := 16;
--constant control_register : integer := 20;
--constant FWR_register                 : integer := 24; -- First Window Configuration Register
--constant SWR_register                 : integer := 28; -- Second Window Configuration Register
--constant TSR0_register                : integer := 32; -- Task Signature Register0
--constant TSR1_register                : integer := 36; -- Task Signature Register1
--constant SSTR_register                : integer := 40; -- Second Sequence Timer Register

-- These constants are indices into the Control/Status Register.
constant SSTE_WIDTH          : integer := (2**(SST_Count_Width-1));--0xC --13
constant SSTE_WIDTH_VEC      : std_logic_vector (31 downto 0) := std_logic_vector(to_unsigned(SSTE_WIDTH,32));

constant MWC                 : integer := 0;--0xC --13
-- Status Register -- 0x10 -- 16
constant LBE                 : integer := 26; -- 0x10 -- 16 -- 26:24
constant FCV                 : integer := 22; -- 0x10 -- 16 -- 22:20
constant WRP                 : integer := 17;
constant WINT                : integer := 16;
constant ACNT                : integer := 15;
constant TOUT                : integer := 12;
constant SERR                : integer := 11;
--constant SERR                : integer := 11;
constant TERR                : integer := 10;-- Token Error
constant TERL                : integer := 9; -- Token Early
constant WSW                 : integer := 8; -- Window WDT Second window
constant TVAL                : integer := 5; -- Token Value -- 5:2
constant WCFG                : integer := 1; -- Wrong Configuration
constant WEN                 : integer := 0; -- Window WDT Enable
-- Control Register -- 0x14 -- 20 -- Can be changed only when WEN = 0
constant SBC                 : integer := 15; -- 15:8 -- Selected Byte Count (Interrupt assertion point)
constant BSS                 : integer := 7; -- 7:6 -- Byte segment selection
                                             -- BSS[1:0] provides Byte Segment selection in Second Window Count as
                                             -- 11 = SW Byte3 selected (i.e. BC[7:0] are compared with SW[31:24])
                                             -- 10 = SW Byte2 selected (i.e. BC[7:0] are compared with SW[23:16])
                                             --01 = SW Byte1 selected (i.e. BC[7:0] are compared with SW[15:8])
                                             --00 = SW Byte0 selected (i.e. BC[7:0] are compared with SW[7:0])
constant SSTE                : integer := 4; -- SST Enable
constant PSME                : integer := 3; -- PSM Enable
constant FCE                 : integer := 2; -- Fail Counter Enable
constant WM                  : integer := 1; -- WIndow WDT Mode ; 1 : Q&A ; 0 : Basic
constant WDP                 : integer := 0; -- WWDT Disable Protection
-- Counter Window value Configuration                       
-- Token Feedback Regitser 0x2C -- 44                       
constant FDBK_En             : integer := 12; -- Token Feedback Enbale
constant FDBK                : integer := 11; -- 11:8 Token Feedback
constant SEED                : integer := 3; -- 3:0 Token Seed
-- Token Response Register
constant ANS                 : integer := 7; -- 7:0 Answer/Token Response
--constant SST_ZERO            : integer := 32-SST_Count_Width; -- 7:0 Answer/Token Response

constant ALL_ZERO_WIN : std_logic_vector (31 downto 0) := (others => '0');
---register bit declarations
signal read_sel : std_logic_vector (9 downto 0);
signal mwc_reg : std_logic;
signal wen_edge : std_logic := '0';
signal WEN_reg_d : std_logic := '0';
signal mwc_reg_In : std_logic;
signal LBE_clear_reg : std_logic_vector (2 downto 0);
signal LBE_clear_reg_In : std_logic_vector (2 downto 0);
signal FCV_clear_reg : std_logic_vector (2 downto 0);
signal FCV_clear_reg_In : std_logic_vector (2 downto 0);
signal WRP_clear_reg : std_logic;
signal WRP_clear_reg_In : std_logic;
signal WINT_clear_reg : std_logic;
signal WINT_clear_reg_In : std_logic;
signal ACNT_clear_reg : std_logic_vector (1 downto 0);
signal ACNT_clear_reg_In : std_logic_vector (1 downto 0);
signal TOUT_clear_reg : std_logic;
signal TOUT_clear_reg_In : std_logic;
signal SERR_clear_reg : std_logic;
signal SERR_clear_reg_In : std_logic;
signal TERR_clear_reg : std_logic;
signal TERR_clear_reg_In : std_logic;
signal TERL_clear_reg : std_logic;
signal TERL_clear_reg_In : std_logic;
signal WSW_clear_reg : std_logic;
signal psme_ge : std_logic;
signal WSW_clear_reg_In : std_logic;
signal TVAL_clear_reg : std_logic_vector (3 downto 0);
signal TVAL_clear_reg_In : std_logic_vector (3 downto 0);
signal WCFG_clear_reg : std_logic;
signal WCFG_clear_reg_In : std_logic;
signal WEN_reg_cleark : std_logic;
signal WEN_clear_reg : std_logic;
signal WEN_change : std_logic;
--signal WEN_clear_reg_In : std_logic;
signal LBE_En : std_logic;
signal LBE_reg_1 : std_logic_vector (2 downto 0):=(others => '0');
signal LBE_reg : std_logic_vector (2 downto 0):=(others => '0');
signal LBE_reg_In : std_logic_vector (2 downto 0);
signal FCV_reg : std_logic_vector (2 downto 0);
signal FCV_reg_In : std_logic_vector (2 downto 0);
signal WRP_reg : std_logic;
signal cnt_wrp : std_logic;
signal WINT_reg : std_logic;
signal WINT_reg_In : std_logic;
signal ACNT_reg : std_logic_vector (1 downto 0);
signal ACNT_reg_In : std_logic_vector (1 downto 0);
signal TOUT_reg : std_logic;
signal TOUT_reg_In : std_logic;
signal SERR_reg : std_logic;
signal SERR_reg_In : std_logic;
signal TERR_reg : std_logic;
signal TERR_reg_In : std_logic;
signal TERL_reg : std_logic;
signal TERL_reg_In : std_logic;
signal WSW_reg : std_logic;
signal WSW_reg_d : std_logic;
signal TVAL_reg : std_logic_vector (3 downto 0);--:=(others => '0');
signal TVAL_reg_In : std_logic_vector (3 downto 0);
signal WCFG_reg : std_logic;
signal WCFG_reg_In : std_logic;
signal WEN_reg : std_logic;
signal WEN_reg_In : std_logic;
signal SBC_reg : std_logic_vector (7 downto 0);
signal SBC_reg_In : std_logic_vector (7 downto 0);
signal BSS_reg : std_logic_vector (1 downto 0);
signal BSS_reg_In : std_logic_vector (1 downto 0);
signal SSTE_reg : std_logic;
signal SSTE_reg_In : std_logic;
signal PSME_reg : std_logic;
signal PSME_reg_In : std_logic;
signal FCE_reg : std_logic;
signal FCE_reg_In : std_logic;
signal WM_reg : std_logic;
signal WM_reg_In : std_logic;
signal WDP_reg : std_logic;
signal WDP_reg_In : std_logic;
signal FDBK_En_reg : std_logic;
signal FDBK_En_reg_In : std_logic;
signal FDBK_reg : std_logic_vector (3 downto 0);
signal FDBK_reg_In : std_logic_vector (3 downto 0);
signal SEED_reg : std_logic_vector (3 downto 0);
signal SEED_reg_In : std_logic_vector (3 downto 0);
signal ANS_reg : std_logic_vector (7 downto 0);
signal ANS_reg_In : std_logic_vector (7 downto 0);
signal FW_reg : std_logic_vector (Max_Count_Width-1 downto 0);
signal FW_reg_In : std_logic_vector (Max_Count_Width-1 downto 0);
signal SW_reg : std_logic_vector (Max_Count_Width-1 downto 0);
signal SW_reg_In : std_logic_vector (Max_Count_Width-1 downto 0);
signal TSR0_reg : std_logic_vector (31 downto 0);
signal TSR0_reg_In : std_logic_vector (31 downto 0);
signal TSR1_reg : std_logic_vector (31 downto 0);
signal TSR1_reg_In : std_logic_vector (31 downto 0);
signal SST_reg : std_logic_vector (SST_Count_Width-1 downto 0);
--signal SST_reg_In : std_logic_vector (SST_Count_Width-1 downto 0);
---
signal load_val              :  std_logic_vector (Max_Count_Width-1 downto 0);
signal load_cnt              :  std_logic;
-- Counter enable bit is generated in state machine
signal int_cnt_en            :  std_logic;
signal wint_int              :  std_logic;
signal wdt_cnt_val           :  std_logic_vector (Max_Count_Width-1 downto 0);
 -- If cnt_val is 0 then dis_wdt 
signal dis_wdt_cnt               :  std_logic;

signal fc_sst_enc           :  std_logic_vector (1 downto 0);
signal wsw_clear            :  std_logic:='0';
signal WEN_clear_SW         :  std_logic:='0';
signal WEN_clear_SW_1         :  std_logic:='0';
signal wait_st              :  std_logic:='0';
signal wait_done            :  std_logic:='0';
--signal rst_gen              :  std_logic:='0';
signal wait_st_d            :  std_logic:='0';
signal wait_st_d2           :  std_logic:='0';
signal psme_check           :  std_logic:='0';
signal psme_match           :  std_logic:='0';
-- end diclaration

type WDT_FSM is (IDLE, FIRST_WINDOW, SECOND_WINDOW,SSTE_STATE);

signal WDT_Current_State,WDT_Next_State : WDT_FSM;
ATTRIBUTE ENUM_ENCODING : STRING;
ATTRIBUTE ENUM_ENCODING OF WDT_FSM: TYPE IS "00 01 10 11";


begin  -- VHDL_RTL

psme_ge <= '1' when ((PSME_reg = '1' and TSR0_reg = TSR1_reg) or PSME_reg = '0') else '0';


    WEN_clear_SW <= '1' when (FCE_Reg = '0' or (FCV_Reg = "000" and FCE_Reg = '1')) else '0';
    WEN_clear_SW_1 <= '1' when (FCE_Reg = '0' or (FCV_Reg = "001" and FCE_Reg = '1')) else '0';
ip2bus_error <= bus2ip_cs(0) and not and_reduce(bus2ip_be);


SST_reg <= wdt_cnt_val(SST_Count_Width-1 downto 0) when (WDT_Current_State = SSTE_STATE) else (others => '0');
fc_sst_enc <= (SSTE_reg&FCE_reg); 

---
-- TWCSR0 or TBR / Invalid Read from TWCSR1
IP2Bus_RdAck_i <= bus2ip_rdce(10) or bus2ip_rdce(9) or bus2ip_rdce(8)or bus2ip_rdce(7) or bus2ip_rdce(6)or bus2ip_rdce(5) or bus2ip_rdce(4) or bus2ip_rdce(3) or bus2ip_rdce(2) or bus2ip_rdce(1) or bus2ip_rdce(0);
-- TWCSR0 or TWCSR1 / Invalid Write to TBR
IP2Bus_WrAck <= bus2ip_wrce(10) or bus2ip_wrce(9) or bus2ip_wrce(8)or bus2ip_wrce(7) or bus2ip_wrce(6)or bus2ip_wrce(5) or bus2ip_wrce(4) or bus2ip_wrce(3) or bus2ip_wrce(2) or bus2ip_wrce(1) or bus2ip_wrce(0);

wen_edge <= '1' when (WEN_reg = '1' and WEN_reg_d = '0') else '0';


---Register read/write start
wen_edge_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           WEN_reg_d <=  '0';
           WSW_reg_d <=  '0';
       else
           WEN_reg_d <=WEN_reg;
           WSW_reg_d <=WSW_reg;
       end if;
   end if;
end process wen_edge_I;



mwc_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           mwc_reg <=  '1';
       elsif (wen_edge = '1') then
           mwc_reg <='0';
       elsif (Bus2IP_WrCE(9) = '1') then
           mwc_reg <= Bus2IP_Data(MWC);--mwc_reg_In;
       end if;
   end if;
end process mwc_I;

ACK_GEN: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       IP2Bus_RdAck <= IP2Bus_RdAck_i; 
   end if;
   end process ACK_GEN;

STATUS_I0_WDT : if(C_WINDOW_MODE = 0) 
generate
   -----
    begin
   -----
STATUS_I0: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (Bus2IP_RdCE(9) = '1') then
         IP2Bus_Data(0) <= mwc_reg;
         IP2Bus_Data(1) <= aen_reg;
         IP2Bus_Data(31 downto 2) <= (others => '0');
       elsif (Bus2IP_RdCE(8) = '1') then
         IP2Bus_Data(31 downto 27) <= (others => '0');
         IP2Bus_Data(26 downto 24) <= LBE_reg;
         IP2Bus_Data(23) <= '0';
         IP2Bus_Data(22 downto 20) <= FCV_reg;
         IP2Bus_Data(19 downto 18) <= (others => '0');
         IP2Bus_Data(17) <= WRP_reg;
         IP2Bus_Data(16) <= WINT_reg;
         IP2Bus_Data(15 downto 14) <= ACNT_reg;
         IP2Bus_Data(13) <='0';
         --IP2Bus_Data(12) <= TOUT_reg;
         IP2Bus_Data(12) <= '0';
         IP2Bus_Data(11) <= SERR_reg;
         IP2Bus_Data(10) <= TERR_reg;
         IP2Bus_Data(9) <= TERL_reg;
         IP2Bus_Data(8) <= WSW_reg;
         IP2Bus_Data(7 downto 6) <= (others => '0');
         IP2Bus_Data(5 downto 2) <= TVAL_reg;
         IP2Bus_Data(1) <= WCFG_reg_In;
         IP2Bus_Data(0) <= WEN_reg;
       elsif (Bus2IP_RdCE(7) = '1') then
         IP2Bus_Data(31 downto SBC+1) <= (others => '0');
         IP2Bus_Data(SBC downto 8) <= SBC_reg;
         IP2Bus_Data(BSS downto 6) <= BSS_reg;
         IP2Bus_Data(5) <= '0';
         IP2Bus_Data(SSTE) <= SSTE_reg;
         IP2Bus_Data(PSME) <= PSME_reg;
         IP2Bus_Data(FCE) <= FCE_reg;
         IP2Bus_Data(WM) <= WM_reg;
         IP2Bus_Data(WDP) <= WDP_reg;
       elsif (Bus2IP_RdCE(6) = '1') then
           IP2Bus_Data(Max_Count_Width-1 downto 0) <= FW_reg;
       elsif (Bus2IP_RdCE(5) = '1') then
           IP2Bus_Data(Max_Count_Width-1 downto 0) <= SW_reg;
       elsif (Bus2IP_RdCE(4) = '1') then
           IP2Bus_Data <= TSR0_reg;
       elsif (Bus2IP_RdCE(3) = '1') then
           IP2Bus_Data <= TSR1_reg;
       elsif (Bus2IP_RdCE(2) = '1') then
           IP2Bus_Data(SST_Count_Width-1 downto 0) <= SST_reg;
          --if (SST_ZERO /= 0) then
          --end if;
       else
           IP2Bus_Data <= (others => '0');
       end if;
   end if;
end process STATUS_I0;
TVAL_reg <= (others => '0');
TERL_reg <= '0';
TERR_reg <= '0';
SERR_reg <= '0';
ACNT_reg <= (others => '0');
end generate STATUS_I0_WDT;

STATUS_I_WDT : if(C_WINDOW_MODE = 1) 
generate
   -----
    begin
   -----
STATUS_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (Bus2IP_RdCE(9) = '1') then
         IP2Bus_Data(0) <= mwc_reg;
         IP2Bus_Data(31 downto 1) <= (others => '0');
       elsif (Bus2IP_RdCE(8) = '1') then
         IP2Bus_Data(26 downto 24) <= LBE_reg;
         IP2Bus_Data(22 downto 20) <= FCV_reg;
         IP2Bus_Data(17) <= WRP_reg;
         IP2Bus_Data(16) <= WINT_reg;
         IP2Bus_Data(15 downto 14) <= ACNT_reg;
         --IP2Bus_Data(12) <= TOUT_reg;
         IP2Bus_Data(12) <= '0';
         IP2Bus_Data(11) <= SERR_reg;
         IP2Bus_Data(10) <= TERR_reg;
         IP2Bus_Data(9) <= TERL_reg;
         IP2Bus_Data(8) <= WSW_reg;
         IP2Bus_Data(5 downto 2) <= TVAL_reg;
         IP2Bus_Data(1) <= WCFG_reg_In;
         IP2Bus_Data(0) <= WEN_reg;
         IP2Bus_Data(7 downto 6) <= (others => '0');
         IP2Bus_Data(13) <='0';
         IP2Bus_Data(19 downto 18) <= (others => '0');
         IP2Bus_Data(23) <= '0';
         IP2Bus_Data(31 downto 27) <= (others => '0');
       elsif (Bus2IP_RdCE(7) = '1') then
         IP2Bus_Data(SBC downto 8) <= SBC_reg;
         IP2Bus_Data(BSS downto 6) <= BSS_reg;
         IP2Bus_Data(SSTE) <= SSTE_reg;
         IP2Bus_Data(PSME) <= PSME_reg;
         IP2Bus_Data(FCE) <= FCE_reg;
         IP2Bus_Data(WM) <= WM_reg;
         IP2Bus_Data(WDP) <= WDP_reg;
         IP2Bus_Data(31 downto SBC+1) <= (others => '0');
         IP2Bus_Data(5) <= '0';
       elsif (Bus2IP_RdCE(6) = '1') then
           IP2Bus_Data(Max_Count_Width-1 downto 0) <= FW_reg;
           --IP2Bus_Data(31 downto Max_Count_Width) <= (others => '0');         
       elsif (Bus2IP_RdCE(5) = '1') then
           IP2Bus_Data(Max_Count_Width-1 downto 0) <= SW_reg;
           --IP2Bus_Data(31 downto Max_Count_Width) <= (others => '0');         
       elsif (Bus2IP_RdCE(4) = '1') then
           IP2Bus_Data <= TSR0_reg;
       elsif (Bus2IP_RdCE(3) = '1') then
           IP2Bus_Data <= TSR1_reg;
       elsif (Bus2IP_RdCE(2) = '1') then
           IP2Bus_Data(SST_Count_Width-1 downto 0) <= SST_reg;
       elsif (Bus2IP_RdCE(1) = '1') then
           IP2Bus_Data(FDBK_En) <= FDBK_En_reg;
           IP2Bus_Data(FDBK downto FDBK-3) <= FDBK_reg;
           IP2Bus_Data(SEED downto SEED-3) <= SEED_reg;
           IP2Bus_Data(31 downto FDBK_En+1) <= (others => '0');
           IP2Bus_Data(FDBK-4 downto SEED+1) <= (others => '0');
       elsif (Bus2IP_RdCE(0) = '1') then
           IP2Bus_Data(ANS downto 0) <= ANS_reg;
           IP2Bus_Data(31 downto ANS+1) <= (others => '0');
       else
           IP2Bus_Data <= (others => '0');
       end if;
   end if;
end process STATUS_I;
end generate STATUS_I_WDT;


LBE_UP_Process: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if(LBE_clear_reg = "111" and wdt_reset_reg = '0') then
             LBE_Reg <= (others => '0');
       elsif(LBE_En = '1') then
           LBE_Reg <= LBE_reg_1;
       end if;
   end if;
   end process LBE_UP_Process;


AEN_WC: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
        aen_reg <= '0';--Bus2IP_Data(WEN)
       elsif (Bus2IP_WrCE(9) = '1' and aen_trig = '0') then
        aen_reg <= Bus2IP_Data(1);
       end if;
   end if;
end process AEN_WC;

AEN_TRIG_1: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
        aen_trig <= '0';--Bus2IP_Data(WEN)
       elsif (aen_reg = '1') then
        aen_trig <= '1';
       end if;
   end if;
end process AEN_TRIG_1;

WEN_WC: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1' or WCFG_reg_In = '1') then
        WEN_clear_reg <= '0';--Bus2IP_Data(WEN)
       elsif(Bus2IP_WrCE(8) = '1' and mwc_reg = '1') then
        WEN_clear_reg <= Bus2IP_Data(WEN);
       end if;
   end if;
end process WEN_WC;

WEN_EDGE_1: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if(Bus2IP_WrCE(8) = '1' and mwc_reg = '1') then
        WEN_change <= '1';
    else
        WEN_change <= '0';
       end if;
   end if;
end process WEN_EDGE_1;

STATUS_WC: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
      if (Bus2IP_WrCE(8) = '1' and mwc_reg = '1') then
         LBE_clear_reg <= Bus2IP_Data(LBE downto LBE-2);
         FCV_clear_reg <= Bus2IP_Data(FCV downto FCV-2);
         WRP_clear_reg <= Bus2IP_Data(WRP);
         WINT_clear_reg <= Bus2IP_Data(WINT);
         ACNT_clear_reg <= Bus2IP_Data(ACNT downto ACNT-1);
         TOUT_clear_reg <= Bus2IP_Data(TOUT);
         SERR_clear_reg <= Bus2IP_Data(SERR);
         TERR_clear_reg <= Bus2IP_Data(TERR);
         TERL_clear_reg <= Bus2IP_Data(TERL);
         WSW_clear_reg <= Bus2IP_Data(WSW);
         TVAL_clear_reg <= Bus2IP_Data(TVAL downto TVAL-3);
         WCFG_clear_reg <= Bus2IP_Data(WCFG);
         --WEN_clear_reg <= WEN_clear_reg_In;--Bus2IP_Data(WEN);
       else
         LBE_clear_reg <= (others => '0');
         FCV_clear_reg <= (others => '0');
         WRP_clear_reg <= '0';
         WINT_clear_reg <= '0';
         ACNT_clear_reg <= (others => '0');
         TOUT_clear_reg <= '0';
         SERR_clear_reg <= '0';
         TERR_clear_reg <= '0';
         TERL_clear_reg <= '0';
         WSW_clear_reg <= '0';
         TVAL_clear_reg <= (others => '0');
         WCFG_clear_reg <= '0';    
         --WEN_clear_reg <= '0';--Bus2IP_Data(WEN);
       end if;
   end if;
end process STATUS_WC;


CTRL_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           SBC_reg <=  (others => '0');
           BSS_reg <=  (others => '0');
           SSTE_reg <= '0';
           PSME_reg <= '0';
           FCE_reg <= '0';
           WM_reg <= '0';
           WDP_reg <= '0';
       elsif (Bus2IP_WrCE(7) = '1' and mwc_reg = '1' and WEN_reg = '0') then
           SBC_reg <= Bus2IP_Data(SBC downto 8);--SBC_reg_In;
           BSS_reg <= Bus2IP_Data(BSS downto 6);--BSS_reg_In;
           SSTE_reg <= Bus2IP_Data(SSTE);--SSTE_reg_In;
           PSME_reg <= Bus2IP_Data(PSME);--PSME_reg_In;
           FCE_reg <= Bus2IP_Data(FCE);--FCE_reg_In;
           --WM_reg <= Bus2IP_Data(WM);--WM_reg_In;
           WM_reg <= '0';--Bus2IP_Data(WM);--WM_reg_In;
           WDP_reg <= Bus2IP_Data(WDP);--WDP_reg_In;
      end if;
   end if;
end process CTRL_I;



FWCR_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           FW_reg <=  (others => '0');
       elsif (Bus2IP_WrCE(6) = '1' and mwc_reg = '1' and WEN_reg = '0') then
           FW_reg <= Bus2IP_Data(Max_Count_Width-1 downto 0);--FW_reg_In;
       end if;
   end if;
end process FWCR_I;

SWCR_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           SW_reg <=  (others => '0');
       elsif (Bus2IP_WrCE(5) = '1' and mwc_reg = '1' and WEN_reg = '0') then
           SW_reg <= Bus2IP_Data(Max_Count_Width-1 downto 0);--SW_reg_In;
       end if;
   end if;
end process SWCR_I;

TSR0_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           TSR0_reg <= (others => '0');
       elsif (Bus2IP_WrCE(4) = '1' and mwc_reg = '1') then
           TSR0_reg <= Bus2IP_Data;
      end if;
   end if;
end process TSR0_I;

TSR1_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           TSR1_reg <= (others => '0');
       elsif (Bus2IP_WrCE(3) = '1' and mwc_reg = '1') then
           TSR1_reg <= Bus2IP_Data;
      end if;
   end if;
end process TSR1_I;
QANDA_WDT : if(C_WINDOW_MODE = 1) 
generate
   -----
    begin
   -----
TFR1_I: Process (bus2ip_clk)
begin
   if (bus2ip_clk'event and bus2ip_clk = '1') then
       if (bus2ip_reset = '1') then
           FDBK_En_reg <= '0';
           FDBK_reg <= (others => '0');
           SEED_reg <= (others => '0');
           ANS_reg <= (others => '0');
        elsif (Bus2IP_WrCE(1) = '1' and mwc_reg = '1') then
           FDBK_En_reg <= Bus2IP_Data(FDBK_En);--FDBK_En_reg_In;
           FDBK_reg <= Bus2IP_Data(FDBK downto FDBK-3);--FDBK_reg_In;
           SEED_reg <= Bus2IP_Data(SEED downto SEED-3);--SEED_reg_In;
       elsif (Bus2IP_WrCE(0) = '1' and mwc_reg = '1') then
           ANS_reg <= Bus2IP_Data(ANS downto 0);--ANS_reg_In;
      end if;
   end if;
end process TFR1_I;

end generate QANDA_WDT;
---Statemachine start

WINDOW_WDT_STATE_MACHINE_COMB: process (WDT_Current_State,dis_wdt_cnt,dis_wdt_fc,WSW_clear_reg,fc_sst_enc,psme_ge,WEN_clear_reg,aen_reg,wdt_reset_reg,SW_reg,FW_reg,WEN_clear_SW,WEN_clear_SW_1,PSME_reg,TSR0_Reg,TSR1_reg,WRP_clear_reg,wdp_reg,WEN_Reg,WCFG_reg_In,WEN_change,WSW_reg_d) is
begin
   WDT_Next_State <= WDT_Current_State;
  -- WRP_reg <= '0';
   WSW_reg <= '0';
   WCFG_reg <= '0';
   int_cnt_en <= '0'; 
   wdt_reset_int <= '0';
   WEN_reg_cleark <= '1';
--   WEN_reg <= '0';
   load_val <= (others => '0');
   LBE_reg_1 <= (others => '0');
   --wdt_state_vec <= (others => '0');
   LBE_En <= '0';
   load_cnt <= '0';
   cnt_en <= '0';
   cnt_val <= '0';
   TOUT_reg <= '0';
   wdt_reset_pending_int <= '0';
   case WDT_Current_State is
       when IDLE => --WEN_reg <= WEN_clear_reg; 
               --WRP_reg <= '0';
               wdt_reset_pending_int <= '0';
               WSW_reg <= '0';
               cnt_en <= '0'; 
               int_cnt_en <= '0'; 
               if wdt_reset_reg = '1' then
                   WEN_reg_cleark <= '0';
                   wdt_reset_int <= '1';
                   WDT_Next_State <= IDLE;
               elsif (WEN_clear_reg ='1' or (WSW_reg_d = '1' and WEN_reg = '1' and (WEN_clear_SW = '0' or aen_reg = '1' or wdp_reg = '1'))) then 
                   WEN_reg_cleark <= '1';
                 if(SW_reg = ALL_ZERO_WIN) then
                   WCFG_reg <= '1';
                   WDT_Next_State <= IDLE;
                 elsif(FW_reg = ALL_ZERO_WIN) then
                   load_cnt <= '1';
                   load_val <= SW_reg;
                   WDT_Next_State <= SECOND_WINDOW;
                 else
                   load_cnt <= '1';
                   load_val <= FW_reg;
                   WDT_Next_State <= FIRST_WINDOW;
                 end if;
               else
                 WEN_reg_cleark <= WEN_clear_reg;
                 WDT_Next_State <= IDLE;
                 WCFG_reg <= WCFG_reg_In;
               end if;
       when FIRST_WINDOW =>
           wdt_reset_pending_int <= '0';
           WSW_reg <= '0';
           if(dis_wdt_cnt = '1') then
               load_cnt <= '1';
               int_cnt_en <= '0';
               load_val <= SW_reg;
               cnt_en <= '0'; 
               WDT_Next_State <= SECOND_WINDOW;
           elsif(WSW_clear_reg = '1' or (wen_clear_reg = '0' and wdp_reg = '0' and aen_reg = '0' and WEN_change = '1')) then
               LBE_reg_1 <= "001";
               LBE_En <= '1';
               CASE fc_sst_enc IS
                    WHEN "00"    =>  WDT_Next_State<=IDLE;
                                     wdt_reset_int <= '1'; 
                                     int_cnt_en <= '0';
                    WHEN "01"    =>  
                                     if(dis_wdt_fc = '1') then
                                        WDT_Next_State<=IDLE;
                                        int_cnt_en <= '0';
                                        wdt_reset_int <= '1';
                                     else
                                         cnt_en <= '1'; 
                                         int_cnt_en <= '1';
                                         WDT_Next_State <= FIRST_WINDOW;
                                         cnt_val <= '1'; 
                                     end if;
                    WHEN "10"    =>  
                                        load_cnt <= '1';
                                        int_cnt_en <= '0';
                                        load_val <= SSTE_WIDTH_VEC(Max_Count_Width-1 downto 0);
                                        cnt_en <= '0'; 
                                        WDT_Next_State<=SSTE_STATE;
                                        wdt_reset_int <= '0';
                    WHEN "11"    =>  
                                     if(dis_wdt_fc = '1') then
                                        load_cnt <= '1';
                                        int_cnt_en <= '0';
                                        load_val <= SSTE_WIDTH_VEC(Max_Count_Width-1 downto 0);
                                        cnt_en <= '0'; 
                                        WDT_Next_State<=SSTE_STATE;
                                        wdt_reset_int <= '0';
                                     else
                                         cnt_en <= '1'; 
                                         cnt_val <= '1'; 
                                          int_cnt_en <= '1';
                                          WDT_Next_State <= FIRST_WINDOW;
                                    end if;
                    WHEN  OTHERS =>  NULL;
                END CASE;
           else
               --WEN_reg <= WEN_clear_reg;
               load_cnt <= '0';
               int_cnt_en <= '1';
               WDT_Next_State<=FIRST_WINDOW;
               cnt_en <= '0'; 
           end if;
       when SECOND_WINDOW => 
           wdt_reset_pending_int <= '0';
           WSW_reg <= '1';
           if(WSW_clear_reg = '1' and psme_ge = '1' and WEN_clear_SW_1 = '1' and wen_clear_reg = '0' and wdp_reg = '0' and aen_reg = '0' and WEN_change = '1') then
                   int_cnt_en <= '0';
                   cnt_en <= '1'; 
                   cnt_val <= '0';                  
                   WEN_reg_cleark <= '0';
                   WDT_Next_State<= IDLE;
           elsif(WSW_clear_reg = '1' and psme_ge = '1' and WEN_clear_SW = '0' and wen_clear_reg = '0' and wdp_reg = '0' and aen_reg = '0' and WEN_change = '1') then
                   int_cnt_en <= '0';
                   cnt_en <= '0';                      
                   WDT_Next_State<= IDLE;
           elsif((WSW_clear_reg = '1' and psme_ge = '1') or (WEN_clear_SW = '1' and psme_ge = '1' and wen_clear_reg = '0' and wdp_reg = '0' and aen_reg = '0' and WEN_change = '1')) then
                   int_cnt_en <= '0';
                   if(WSW_clear_reg = '1') then
                    cnt_en <= '1'; 
                    cnt_val <= '0'; 
                   else
                    cnt_en <= '0';                      
                    WEN_reg_cleark <= '0';
                   end if;
                   WDT_Next_State<= IDLE;
           elsif((dis_wdt_cnt = '1') or (WSW_clear_reg = '1' and psme_ge = '0') or ((WEN_clear_SW = '0' or psme_ge = '0') and wen_clear_reg = '0' and wdp_reg = '0' and aen_reg = '0' and WEN_change = '1')) then
                  if(dis_wdt_cnt = '1') then
                    TOUT_reg <= '1';
                    LBE_reg_1 <= "011";
                  else
                    LBE_reg_1 <= "010";
                  end if;
                    LBE_En <= '1';
                  CASE fc_sst_enc IS
                          WHEN "00"    =>  WDT_Next_State<=IDLE;
                                           wdt_reset_int <= '1'; 
                                           int_cnt_en <= '0';
                          WHEN "01"    =>  
                                           if(dis_wdt_fc = '1') then
                                              WDT_Next_State<=IDLE;
                                              wdt_reset_int <= '1';
                                              int_cnt_en <= '0';
                                           else
                                               cnt_en <= '1'; 
                                               cnt_val <= '1';
                                               if(WSW_clear_reg = '1' or dis_wdt_cnt = '1') then
                                                 WDT_Next_State<=IDLE;
                                                 int_cnt_en <= '0';
                                               else
                                                 WDT_Next_State<=SECOND_WINDOW;                                                 
                                                 int_cnt_en <= '1';
                                               end if;
                                           end if;
                          WHEN "10"    =>  
                                              int_cnt_en <= '0';
                                              load_cnt <= '1';
                                              load_val <= SSTE_WIDTH_VEC(Max_Count_Width-1 downto 0);
                                              cnt_en <= '0'; 
                                              WDT_Next_State<=SSTE_STATE;
                                              wdt_reset_int <= '0';
                          WHEN "11"    =>  
                                           if(dis_wdt_fc = '1') then
                                              int_cnt_en <= '0';
                                              load_cnt <= '1';
                                              load_val <= SSTE_WIDTH_VEC(Max_Count_Width-1 downto 0);
                                              cnt_en <= '0'; 
                                              WDT_Next_State<=SSTE_STATE;
                                              wdt_reset_int <= '0';
                                           else
                                               cnt_en <= '1'; 
                                               cnt_val <= '1'; 
                                               if(WSW_clear_reg = '1' or dis_wdt_cnt = '1') then
                                                 int_cnt_en <= '0';
                                                 WDT_Next_State<=IDLE;
                                               else
                                                 int_cnt_en <= '1';
                                                 WDT_Next_State<=SECOND_WINDOW;                                                 
                                               end if;
                                           end if;
                           WHEN  OTHERS =>  NULL;
                      END CASE;
           else
               load_cnt <= '0';
               int_cnt_en <= '1';
               cnt_en <= '0'; 
               WDT_Next_State <= SECOND_WINDOW;
           end if;
       when SSTE_STATE =>
               --WRP_reg <= '1';
               wdt_reset_pending_int <= '1';
               WSW_reg <= '0';
               if(dis_wdt_cnt = '1') then
                   int_cnt_en <= '0';
                   cnt_en <= '0'; 
                   WDT_Next_State<= IDLE;
                   wdt_reset_int <= '1';
                   WEN_reg_cleark <= '0';
                else
                   load_cnt <= '0';
                   int_cnt_en <= '1';
                   cnt_en <= '0'; 
                   WDT_Next_State<= SSTE_STATE;
                end if;


   end case;
end process WINDOW_WDT_STATE_MACHINE_COMB;
--WCFG_Clear
WCFG_clear_SEQ: process (bus2ip_clk) is 
begin
   if bus2ip_clk'event and bus2ip_clk='1' then
           if((WCFG_reg = '1' and WCFG_clear_reg = '1') or bus2ip_reset = '1') then
               WCFG_reg_In <= '0';
           else
               WCFG_reg_In <= WCFG_reg;
           end if; 
    end if; 
end process WCFG_clear_SEQ;

--wdt_interrupt <= '0' when (wint_int = '1' and WINT_clear_reg = '1') else wint_int;
--WINT_reg <= '0' when (wint_int = '1' and WINT_clear_reg = '1') else wint_int;
--
WINT_clear_SEQ: process (bus2ip_clk) is 
begin
   if bus2ip_clk'event and bus2ip_clk='1' then
           --if( (wint_int = '1' and WINT_clear_reg = '1') or bus2ip_reset = '1') then
           --    WINT_reg <= '0';
           --    wdt_interrupt <= '0'; 
           --else
               WINT_reg <= wint_int;
               wdt_interrupt <= wint_int;
           --end if; 
    end if; 
end process WINT_clear_SEQ;
WRP_REG_SEQ: process (bus2ip_clk) is 
begin
   if bus2ip_clk'event and bus2ip_clk='1' then
      if( bus2ip_reset = '1') then
            WRP_reg <= '0';
            --wdt_reset_pending_int <= '0';              
            wdt_reset_pending <= '0';
       elsif(cnt_wrp = '1') then
              --cnt_wrp <= '1';
              WRP_reg <= '0';
              --wdt_reset_pending_int <= '0';              
              wdt_reset_pending <= '0';--wdt_reset_pending_int;
        else
              WRP_reg <= wdt_reset_pending_int;
              wdt_reset_pending <= wdt_reset_pending_int;
       end if;
     end if;
 end process WRP_REG_SEQ;

WEN_CLEAR_SEQ1: process (bus2ip_clk) is 
begin
   if bus2ip_clk'event and bus2ip_clk='1' then
      if( bus2ip_reset = '1') then
            WEN_Reg <= '0';
      else--if( = '1') then
              WEN_Reg <= WEN_reg_cleark;
       end if;
     end if;
 end process WEN_CLEAR_SEQ1;
 
WRP_REG_SEQ1: process (bus2ip_clk) is 
begin
   if bus2ip_clk'event and bus2ip_clk='1' then
      if( bus2ip_reset = '1') then
            cnt_wrp <= '0';
       elsif(wdt_reset_pending_int = '1' and WRP_clear_reg = '1') then
              cnt_wrp <= '1';
       end if;
     end if;
 end process WRP_REG_SEQ1;
 
 wdt_reset <= wdt_reset_reg;

OUT_REG_SEQ: process (bus2ip_clk) is 
begin
   if bus2ip_clk'event and bus2ip_clk='1' then
           if( bus2ip_reset = '1') then
               wdt_reset_reg <= '0';
               wdt_state_vec <= (others => '0');
           else
               wdt_reset_reg <= wdt_reset_int;
               wdt_state_vec <= (FCV_reg&FCE_reg&WM_reg&WSW_reg&WEN_reg);
           end if; 
    end if; 
end process OUT_REG_SEQ;
-------------------------------------------------------------------------------
-- NAME: WDT_STATE_MACHINE_SEQ
-------------------------------------------------------------------------------
-- Description: The sequential part of Watchdog Timer state machine
-------------------------------------------------------------------------------
    
WINDOW_WDT_STATE_MACHINE_SEQ: process (bus2ip_clk) is 
begin
   if bus2ip_clk'event and bus2ip_clk='1' then
       if bus2ip_reset='1' then 
           WDT_Current_State <= IDLE;
       else
           WDT_Current_State <= WDT_Next_State;
       end if;
   end if;
end process WINDOW_WDT_STATE_MACHINE_SEQ;


---Statemachine end
---Register read/write process end
-------------------------------------------------------------------------------
-- Instantiate the Counter
-------------------------------------------------------------------------------

WINDOW_WDT_CNT_I: entity axi_timebase_wdt_v3_0_1.window_wdt_counter
  generic map 
       (
        C_FAMILY              => C_FAMILY,
        C_TIMER_WIDTH         => Max_Count_Width
       )  
  port map 
       (
        Clk                   => bus2ip_clk,
        Reset                 => bus2ip_reset,
        load_cnt              => load_cnt,  --[in]
        load_val              => load_val,  --[in]
        sbc                   => SBC_reg, 
        bss                   => BSS_reg, 
        SWS                   => WSW_reg, 
        wint                  => wint_int, 
        cnt_en                => int_cnt_en ,    --[in]
        int_clr               => WINT_clear_reg ,    --[in]
        cur_cnt_val           => wdt_cnt_val, --[out ]
        dis_wdt               => dis_wdt_cnt--[out]
       );

-------------------------------------------------------------------------------
-- Instantiate the Fail Counter
-------------------------------------------------------------------------------

WINDOW_WDT_FAIL_CNT_I: entity axi_timebase_wdt_v3_0_1.window_wdt_fail_cnt
  generic map 
       (
        C_FAMILY              => C_FAMILY,
        C_FAIL_CNT_WIDTH      => C_FAIL_CNT_WIDTH
       )  
  port map 
       (
        Clk                   => bus2ip_clk,
        Reset                 => bus2ip_reset,
        fail_cnt              => FCV_reg,  --[out]
        fc_en                 => FCE_reg,    --[in]
        cnt_en                => cnt_en,    --[in]
        cnt_val               => cnt_val,   --[in]
        dis_wdt               => dis_wdt_fc  --[out]
       );

    ---------------------------------------------------------------------
    -- INSTANTIATE AXI Lite IPIF
    ---------------------------------------------------------------------
    AXI4_LITE_I : entity axi_lite_ipif_v3_0_4.axi_lite_ipif
      generic map
           (
        C_S_AXI_DATA_WIDTH    => C_S_AXI_DATA_WIDTH,
        C_S_AXI_ADDR_WIDTH    => C_S_AXI_ADDR_WIDTH,
        C_S_AXI_MIN_SIZE      => C_S_AXI_MIN_SIZE,
        C_USE_WSTRB           => C_USE_WSTRB,
        C_DPHASE_TIMEOUT      => C_DPHASE_TIMEOUT,
        C_ARD_ADDR_RANGE_ARRAY=> C_ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY    => C_ARD_NUM_CE_ARRAY,
        C_FAMILY              => C_FAMILY
           )
     port map
        (
        S_AXI_ACLK            => s_axi_aclk,
        S_AXI_ARESETN         => s_axi_aresetn,
        S_AXI_AWADDR          => s_axi_awaddr,
        S_AXI_AWVALID         => s_axi_awvalid,
        S_AXI_AWREADY         => s_axi_awready,
        S_AXI_WDATA           => s_axi_wdata,
        S_AXI_WSTRB           => s_axi_wstrb,
        S_AXI_WVALID          => s_axi_wvalid,
        S_AXI_WREADY          => s_axi_wready,
        S_AXI_BRESP           => s_axi_bresp,
        S_AXI_BVALID          => s_axi_bvalid,
        S_AXI_BREADY          => s_axi_bready,
        S_AXI_ARADDR          => s_axi_araddr,
        S_AXI_ARVALID         => s_axi_arvalid,
        S_AXI_ARREADY         => s_axi_arready,
        S_AXI_RDATA           => s_axi_rdata,
        S_AXI_RRESP           => s_axi_rresp,
        S_AXI_RVALID          => s_axi_rvalid,
        S_AXI_RREADY          => s_axi_rready,
         -- IP Interconnect (IPIC) port signals --------------------------------
        Bus2IP_Clk            => bus2ip_clk,
        Bus2IP_Resetn         => bus2ip_resetn,
        IP2Bus_Data           => ip2bus_data,
        IP2Bus_WrAck          => ip2bus_wrack,
        IP2Bus_RdAck          => ip2bus_rdack,
        IP2Bus_Error          => ip2bus_error,
        Bus2IP_Addr           => bus2ip_addr,
        Bus2IP_Data           => bus2ip_data,
        Bus2IP_RNW            => open,
        Bus2IP_BE             => bus2ip_be,
        Bus2IP_CS             => bus2ip_cs,
        Bus2IP_RdCE           => bus2ip_rdce,
        Bus2IP_WrCE           => bus2ip_wrce                                
    );
bus2ip_reset <= not bus2ip_resetn;
end imp;
-------------------------------------------------------------------------------
--END OF FILE
-------------------------------------------------------------------------------


