-------------------------------------------------------------------------------
-- $Id: opb_bam.vhd,v 1.1.2.1 2009/10/06 21:15:01 gburch Exp $
-------------------------------------------------------------------------------
-- opb_bam.vhd
-------------------------------------------------------------------------------
--
-- *************************************************************************
-- **                                                                     **
-- ** DISCLAIMER OF LIABILITY                                             **
-- **                                                                     **
-- ** This text/file contains proprietary, confidential                   **
-- ** information of Xilinx, Inc., is distributed under                   **
-- ** license from Xilinx, Inc., and may be used, copied                  **
-- ** and/or disclosed only pursuant to the terms of a valid              **
-- ** license agreement with Xilinx, Inc. Xilinx hereby                   **
-- ** grants you a license to use this text/file solely for               **
-- ** design, simulation, implementation and creation of                  **
-- ** design files limited to Xilinx devices or technologies.             **
-- ** Use with non-Xilinx devices or technologies is expressly            **
-- ** prohibited and immediately terminates your license unless           **
-- ** covered by a separate agreement.                                    **
-- **                                                                     **
-- ** Xilinx is providing this design, code, or information               **
-- ** "as-is" solely for use in developing programs and                   **
-- ** solutions for Xilinx devices, with no obligation on the             **
-- ** part of Xilinx to provide support. By providing this design,        **
-- ** code, or information as one possible implementation of              **
-- ** this feature, application or standard, Xilinx is making no          **
-- ** representation that this implementation is free from any            **
-- ** claims of infringement. You are responsible for obtaining           **
-- ** any rights you may require for your implementation.                 **
-- ** Xilinx expressly disclaims any warranty whatsoever with             **
-- ** respect to the adequacy of the implementation, including            **
-- ** but not limited to any warranties or representations that this      **
-- ** implementation is free from claims of infringement, implied         **
-- ** warranties of merchantability or fitness for a particular           **
-- ** purpose.                                                            **
-- **                                                                     **
-- ** Xilinx products are not intended for use in life support            **
-- ** appliances, devices, or systems. Use in such applications is        **
-- ** expressly prohibited.                                               **
-- **                                                                     **
-- ** Any modifications that are made to the Source Code are              **
-- ** done at the user’s sole risk and will be unsupported.               **
-- ** The Xilinx Support Hotline does not have access to source           **
-- ** code and therefore cannot answer specific questions related         **
-- ** to source HDL. The Xilinx Hotline support of original source        **
-- ** code IP shall only address issues and questions related             **
-- ** to the standard Netlist version of the core (and thus               **
-- ** indirectly, the original core source).                              **
-- **                                                                     **
-- ** Copyright (c) 2003,2009 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        opb_bam.vhd
-- Version:         v3.01a
-- Description:     Bus Attachment Module, OPB to IPIC.
--
-- VHDL Standard:   VHDL 93
-------------------------------------------------------------------------------
-- Structure:       opb_bam
--                      -- reset_mir
--                      -- interrupt_control
--                      -- rdpfifo_top
--                      -- wrpfifo_top
--                      -- opb_be_gen
--                      -- brst_addr_cntr
--                      -- brst_addr_cntr_reg
--                          -- opb_flex_addr_cntr
--                      -- write_buffer
--                          -- srl_fifo3
--
-------------------------------------------------------------------------------
-- Author:      Farrell Ostler
--
-- History:
--
--      FLO     10/22/02
-- ^^^^^^
--      Initial version.
-- ~~~~~~
--      FLO     12/09/02
-- ^^^^^^
--      Support now for posted writes and burst of posted writes under
--      OPB_seqAddr=1. (The latter not  yet tested.)
-- ~~~~~~
--      FLO     03/21/03
-- ^^^^^^
--      Hooked up neglected connection of OPB_BE to opb_be_s0.
-- ~~~~~~
--      FLO     05/15/2003
-- ^^^^^^
--      Introduced signal OPB_seqAddr_eff to disable bursts when parameter
--      C_DEV_BURST_ENABLE is false.
-- ~~~~~~
--
--      FLO     05/27/2003
-- ^^^^^^
--     Use sln_xferack_s1 to enable other than '0' values to the
--     OPBOUT pipestage when this stage is present and there is
--     a single address range. This, in turn, allows the optimization
--     of passing ip2bus_data through to ip2bus_data_mx without
--     qualification by a CE Address-Range decode, saving a LUT per
--     data-bus bit for this case.
-- ~~~~~~
--
--      FLO     05/28/2003
-- ^^^^^^
--     Made a correction to the last change that was causing it to
--     drive sln_dbus during a write transaction.
--     Now the sln_dbus_s2 signals are separated from the other _s2 signals
--     for application of the reset when sln_xferack_s1 = '0' and this
--     reset is further qualified by bus2ip_rnw_s1.
-- ~~~~~~
--      FLO     09/10/2003
-- ^^^^^^
--     Fixed the mirror instantiation, which erroneously had the address tied low.
-- ~~~~~~
--
--      ALS     10/22/03
-- ^^^^^^
--  Creation of version v3_00_b to include read and write packet FIFOs.
--  Also modified code for direct entity instantiation.
-- ~~~~~~
--      ALS     11/18/03
-- ^^^^^^
--  Creation of version v3_01_a to modify generics and some ports to align
--  with the PLB IPIF. Added look-ahead address counter for read bursts and write
--  buffer for write bursts.
-- ~~~~~~~
--
--  ALS         04/09/04
-- ^^^^^^
--  Removed vectorization of IP2Bus signals
-- ^^^^^^
--  GAB         04/15/04
-- ^^^^^^
--  - Updated to use libraries proc_common_v2_00_a, wrpfifo_v1_01_b,
--  rdpfifo_v1_01_b, and interrupt_control_v1_00_a.
--  - Fixed issues with wrpfifo for pipeline model 0
--  - Fixed issues with wrpfifo and rdpfifo for cases when write buffer
--  was instantiated.
--  - Fixed issues with master aborts, delayed IP acknowledges.
--  - Fixed double clock wide wrce which caused an interrupt to be generated
--  when an interrupt was cleared.
--  - Improved utilization by allowing the tools to place the read mux
--  - Removed checks on postedwrinh when write buffer was instantiated because
--  the write buffer currently does not support this feature.
--  - Set MAX_USER_ADDR_RANGE minimum to 7 because opb_flex_addr_cntr.vhd expects
--  a minimum of 7 address bits to decode.
--  - Changed reset/mir to be posted write inhibited because of problems with
--  various pipeline models and single beat reads.  CS,CE, etc. to reset_mir
--  would not occur because they where inhibited on the same clock cycle as
--  they were to be generated.
--  - Created abort detection logic for pipeline models 1,3, and 7 to allow the
--  ipif to properly recover from a master abort.
--
-- ~~~~~~~
--  GAB         07/07/04
-- ^^^^^^
--  - Fixed issues with dynamic switching of IP2Bus_PostedWrInh signal
--  - Optimized slave data read mux
--  - Fixed issue with Bus2IP_Burst signal when WriteBuffer was instantiated
--  - Fixed issue with Bus2IP_AddrValid when WriteBuffer was instantiated
-- ~~~~~~~
--  GAB         08/10/04
-- ^^^^^^
--  - Modified port range for IP2RFIFO_Data and WFIFO2IP_Data to be based on
--  the C_ARD_DWIDTH_ARRAY generic and not hard coded.  Fixes CR191551
--  - Added synopsys translate_off/translate_on statements to exclude assert
--  statements from the synthesis process.
--  - Added assert statement to check for match of C_ARD_DWIDTH_ARRAY element
--  and fifo WR_WIDTH_BITS setting, though the mis-match of array sizes should
--  cause the simulation to error out on load.
-- ~~~~~~~
--      GAB         07/06/05
-- ^^^^^^
--  Removed xfer_abort signal from Sln_xferack logic to help improve timing.
-- ~~~~~~~
--      GAB         08/05/05
-- ^^^^^^
--  Fixed issue with IP2Bus_Postedwrinh_s2 getting reset with OPB_Select would
--  negate. IP2Bus_Postedwrinh_s2 should only negat based on UserIP.
-- ~~~~~~~
--
--      GAB         09/21/05
-- ^^^^^^
--  Fixed long timing path issue with Sln_Retry signal and cycle aborts.  Modified
--  logic to suppress sln_xferack_s1 with cycle_abort for models where out-pipe was
--  included.
-- ~~~~~~~
--      GAB         10/12/05
-- ^^^^^^
--  Incorperated rev C mods into rev A to fix slow timing path with the address
--  decode.  The modification simply shifts the input pipe stage for the address
--  to after the address decode.  Therefore the functionality does not change
--  nor does the latency.  This fix only improves pipeline 5 and 7 (i.e. any
--  with a model with a input pipeline stage).
-- ~~~~~~~
--      GAB      5/19/06
-- ^^^^^^
--      Removed unused last_wr_xferack, last_wr_xferack_d1,
--      and last_wr_xferack_d2.
--      Added bus2ip_rnw_s1 signal to SLN_XFERACK_PROC process's sinsitivity list.
--      This fixes CR231744.
-- ~~~~~~~
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
-- -------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x"
--      reset signals:                          "rst", "rst_n"
--      generics:                               "C_*"
--      user defined types:                     "*_TYPE"
--      state machine next state:               "*_ns"
--      state machine current state:            "*_cs"
--      combinatorial signals:                  "*_com"
--      pipelined or register delay signals:    "*_d#"
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce"
--      internal version of output port         "*_i"
--      device pins:                            "*_pin"
--      ports:                                  - Names begin with Uppercase
--      processes:                              "*_PROCESS"
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.or_reduce;

library unisim;
use unisim.vcomponents.all;

library opb_v20_v1_10_d;
use opb_v20_v1_10_d.proc_common_pkg.all;
use opb_v20_v1_10_d.ipif_pkg.all;
use opb_v20_v1_10_d.ipif_steer;
use opb_v20_v1_10_d.family.all;
use opb_v20_v1_10_d.pselect;
use opb_v20_v1_10_d.or_muxcy;
use opb_v20_v1_10_d.reset_mir;
use opb_v20_v1_10_d.brst_addr_cntr;
use opb_v20_v1_10_d.brst_addr_cntr_reg;
use opb_v20_v1_10_d.opb_be_gen;
use opb_v20_v1_10_d.interrupt_control;
use opb_v20_v1_10_d.wrpfifo_top;
use opb_v20_v1_10_d.rdpfifo_top;

entity opb_bam is
  generic
  (
    C_ARD_ID_ARRAY              : INTEGER_ARRAY_TYPE
                                := ( 0 => IPIF_INTR,
                                     1 => IPIF_RST,
                                     2 => USER_00
                                   );
    C_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE
                                := ( x"0000_0000_6000_0000",  -- IPIF_INTR
                                     x"0000_0000_6000_003F",
                                   --
                                     x"0000_0000_6000_0040",  -- IPIF_RST
                                     x"0000_0000_6000_0043",
                                   --
                                     x"0000_0000_6000_0100",  -- USER_00
                                     x"0000_0000_6000_01FF"
                                   );
    C_ARD_DWIDTH_ARRAY          : INTEGER_ARRAY_TYPE
                                := ( 32,                      -- IPIF_INTR
                                     32,                      -- IPIF_INTR
                                     32                       -- USER_00
                                   );
    C_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE
                                := ( 16,                      -- IPIF_INTR
                                      1,                      -- IPIF_RST
                                      8                       -- USER_00
                                    );
    C_ARD_DEPENDENT_PROPS_ARRAY : DEPENDENT_PROPS_ARRAY_TYPE
                           := (
                                0 => (others => 0)
                               ,1 => (others => 0)
                               ,2 => (others => 0)
                              );
    C_PIPELINE_MODEL            : integer                    := 7;
      -- The pipe stages are enumerated and numbered as:
      --   --  ----------
      --    n  Pipe stage
      --   --  ----------
      --    0  OPBIN
      --    1  IPIC
      --    2  OPBOUT
      -- Each pipe stage is either present or absent (i.e. bypassed).
      -- The pipe stage, n, is present if the (2^n)th
      -- bit in C_PIPELINE_MODEL is 1.
      --
    C_DEV_BLK_ID        : INTEGER := 1;
      --  Unique block ID, assigned to the device when the system is built.
    C_DEV_MIR_ENABLE    : INTEGER := 0;
    C_OPB_AWIDTH        : INTEGER := 32;
      -- width of Address Bus (in bits)
    C_OPB_DWIDTH        : INTEGER := 32;
      -- Width of the Data Bus (in bits)
    C_FAMILY            : string := "virtexe";
      --
    C_IP_INTR_MODE_ARRAY   : INTEGER_ARRAY_TYPE := ( 5, 1 );
      --
      -- There will be one interrupt signal for each entry in
      -- C_IP_INTR_MODE_ARRAY. The leftmost entry will be the
      -- mode for input port IP2Bus_Intr(0), the next entry
      -- for IP2Bus_Intr(1), etc.
      --
      -- These modes are supported:
      --
      --  Mode  Description
      --
      --   1    Active-high interrupt condition.
      --        The IP core drives a signal--via the corresponding
      --        IP2Bus_Intr(i) port-- that is an interrupt condition
      --        that is latched and cleared in the IP core and made available
      --        to the system via the Interrupt Source Controller in
      --        the Bus Attachment Module.
      --
      --   2    Active-low interrupt condition.
      --        Like 1, except that the interrupt condition is asserted low.
      --
      --   3    Active-high pulse interrupt event.
      --        The IP core drives a signal--via the corresponding
      --        IP2Bus_Intr(i) port--whose single clock period of active-high
      --        assertion is an interrupt event that is latched,
      --        and cleared as a service of the Interrupt Source
      --        Controller in the Bus Attachment Module.
      --
      --   4    Active-low pulse interrupt event.
      --        Like 3, except the interrupt-event pulse is active low.
      --
      --   5    Positive-edge interrupt event.
      --        The IP core drives a signal--via the corresponding
      --        IP2Bus_Intr(i) port--whose low-to-high transition, synchronous
      --        with the clock, is an interrupt event that is latched,
      --        and cleared as a service of the Interrupt Source
      --        Controller in the Bus Attachment Module.
      --
      --   6    Negative-edge interrupt event.
      --        Like 5, except that the interrupt event is a
      --        high-to-low transition.
      --
      --   Other mode codes are reserved.
      --
    C_DEV_BURST_ENABLE : INTEGER := 0;
      -- Burst Enable for IPIF Interface
    C_INCLUDE_ADDR_CNTR : INTEGER := 0;
        -- ALS added generic for read address counter
        -- inclusion of read address look ahead counter and write address counter
    C_INCLUDE_WR_BUF    : INTEGER := 0
        -- ALS: added generic for write buffer
  );
  port
  (
    -- OPB signals
    OPB_select          : in  std_logic;
    OPB_DBus            : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    OPB_ABus            : in  std_logic_vector(0 to C_OPB_AWIDTH-1);
    OPB_BE              : in  std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    OPB_RNW             : in  std_logic;
    OPB_seqAddr         : in  std_logic;
    Sln_DBus            : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    Sln_xferAck         : out std_logic;
    Sln_errAck          : out std_logic;
    Sln_retry           : out std_logic;
    Sln_toutSup         : out std_logic;

    -- IPIC signals (address, data, acknowledges)
    Bus2IP_CS           : out std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    Bus2IP_CE           : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_RdCE         : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_WrCE         : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_Data         : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    Bus2IP_Addr         : out std_logic_vector(0 to C_OPB_AWIDTH-1);
    Bus2IP_AddrValid    : out std_logic;
    Bus2IP_BE           : out std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    Bus2IP_RNW          : out std_logic;
    Bus2IP_Burst        : out std_logic;
    IP2Bus_Data         : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    IP2Bus_Ack          : in  std_logic;
    IP2Bus_AddrAck      : in  std_logic;
    IP2Bus_Error        : in  std_logic;
    IP2Bus_Retry        : in  std_logic;
    IP2Bus_ToutSup      : in  std_logic;
    IP2Bus_PostedWrInh  : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);

    -- IPIC signals (Read Packet FIFO)
    IP2RFIFO_Data       : in std_logic_vector(0 to C_ARD_DWIDTH_ARRAY(
                                get_id_index_iboe(C_ARD_ID_ARRAY,
                                IPIF_RDFIFO_DATA)) - 1) := (others => '0');
    IP2RFIFO_WrMark     : in std_logic := '0';
    IP2RFIFO_WrRelease  : in std_logic := '0';
    IP2RFIFO_WrReq      : in std_logic := '0';
    IP2RFIFO_WrRestore  : in std_logic := '0';
    RFIFO2IP_AlmostFull : out std_logic;
    RFIFO2IP_Full       : out std_logic;
    RFIFO2IP_Vacancy    : out std_logic_vector(0 to bits_needed_for_vac(
                                find_ard_id(C_ARD_ID_ARRAY, IPIF_RDFIFO_DATA),
                                C_ARD_DEPENDENT_PROPS_ARRAY(get_id_index_iboe
                                (C_ARD_ID_ARRAY, IPIF_RDFIFO_DATA))) - 1);

    RFIFO2IP_WrAck      : out std_logic;

    -- IPIC signals (Write Packet FIFO)
    IP2WFIFO_RdMark     : in std_logic := '0';
    IP2WFIFO_RdRelease  : in std_logic := '0';
    IP2WFIFO_RdReq      : in std_logic := '0';
    IP2WFIFO_RdRestore  : in std_logic := '0';
    WFIFO2IP_AlmostEmpty: out std_logic;
    WFIFO2IP_Data       : out std_logic_vector(0 to C_ARD_DWIDTH_ARRAY(
                                get_id_index_iboe(C_ARD_ID_ARRAY,
                                IPIF_WRFIFO_DATA)) - 1);

    WFIFO2IP_Empty      : out std_logic;
    WFIFO2IP_Occupancy  : out std_logic_vector(0 to bits_needed_for_occ(
                                find_ard_id(C_ARD_ID_ARRAY, IPIF_WRFIFO_DATA),
                                C_ARD_DEPENDENT_PROPS_ARRAY(get_id_index_iboe
                                (C_ARD_ID_ARRAY, IPIF_WRFIFO_DATA))) - 1);

    WFIFO2IP_RdAck      : out std_logic;

    -- interrupts
    IP2Bus_IntrEvent    : in  std_logic_vector(0 to C_IP_INTR_MODE_ARRAY'length-1);
    IP2INTC_Irpt        : out std_logic;

    -- Software test breakpoint signal
    Freeze              : in  std_logic;
    Bus2IP_Freeze       : out std_logic;

    -- clocks and reset
    OPB_Clk             : in  std_logic;
    Bus2IP_Clk          : out std_logic;
    IP2Bus_Clk          : in  std_logic;
    Reset               : in  std_logic;
    Bus2IP_Reset        : out std_logic
  );
end entity opb_bam;



-------------------------------------------------------------------------------
-- Begin architecture
-------------------------------------------------------------------------------
architecture implementation of opb_bam is

-------------------------------------------------------------------------------
-- Function and Constant Declarations
-------------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- MIR fields
    --
    --     4          7           5            8               8          # bits
    --
    --  0-----3 4----------10 11-----15 16-----------23 24------------31
    -- +-------+-------------+---------+---------------+----------------+
    -- |MAJOR  |  MINOR      |REVISION |    BLK_ID     |      TYPE      |  MIR
    -- |VERSION|  VERSION    |(letter) |               |                |
    -- +-------+-------------+---------+---------------+----------------+
    --                        0 = a
    --                        1 = b
    --                        etc.
    --
    --      \        |       /
    --       \       |      /
    --        \      |     /
    --         \     |    /
    --          \    |   /
    --           \   |  /
    --
    --           v1_03_c  (aka V1.3c)
    ----------------------------------------------------------------------------
--    constant MIR_MAJOR_VERSION : INTEGER range 0 to 15 := 1;
--    constant MIR_MINOR_VERSION : INTEGER range 0 to 127:= 0;
--    constant MIR_REVISION : INTEGER := 0;
    -- ALS - modified MIR_MAJOR_VERSION to 3 and MIR_MINOR_VERSION to 1
    constant MIR_MAJOR_VERSION      : INTEGER range 0 to 15 := 3;
    constant MIR_MINOR_VERSION      : INTEGER range 0 to 127:= 1;
    constant MIR_REVISION           : INTEGER range 0 to 25 := 0;

    constant MIR_TYPE               : INTEGER := 1;
              --  Always '1' for OPB ipif interface type
              --  ToDo, stays same for bus_attach?

    constant NUM_ARDS               : integer := C_ARD_ID_ARRAY'length;
    constant NUM_CES                : integer := calc_num_ce(C_ARD_NUM_CE_ARRAY);

    constant WRBUF_DEPTH            : integer   := 16;


    constant INCLUDE_OPBIN_PSTAGE   : boolean := (C_PIPELINE_MODEL/1) mod 2 = 1;
    constant INCLUDE_IPIC_PSTAGE    : boolean := (C_PIPELINE_MODEL/2) mod 2 = 1;
    constant INCLUDE_OPBOUT_PSTAGE  : boolean := (C_PIPELINE_MODEL/4) mod 2 = 1;

    constant INCLUDE_RESET_MIR      : boolean
                                    := find_ard_id(C_ARD_ID_ARRAY, IPIF_RST);
    constant INCLUDE_INTR           : boolean
                                    := find_ard_id(C_ARD_ID_ARRAY, IPIF_INTR);


    constant INCLUDE_ADDR_CNTR      : boolean
                                    := (C_INCLUDE_ADDR_CNTR=1 and C_DEV_BURST_ENABLE=1)
                                    or (C_INCLUDE_ADDR_CNTR=1 and C_INCLUDE_WR_BUF=1);

    -- ALS - added boolean constants for Read and Write Packet FIFOs
    constant INCLUDE_RDFIFO         : boolean
                                    := find_ard_id(C_ARD_ID_ARRAY, IPIF_RDFIFO_DATA);
    constant INCLUDE_WRFIFO         : boolean
                                    := find_ard_id(C_ARD_ID_ARRAY, IPIF_WRFIFO_DATA);

    -- Set SINGLE_CE if the only attached element is a user IP with only 1 CE.
    constant SINGLE_CE              : boolean := C_ARD_ID_ARRAY'length = 1
                                        and C_ARD_NUM_CE_ARRAY(0) = 1
                                        and C_ARD_ID_ARRAY(0) /= IPIF_RST;

--    constant ZERO_SLV               : std_logic_vector(0 to 199) := (others => '0');

    constant VIRTEX_II              : boolean :=   derived(C_FAMILY, virtex2);


    ---------------------------------------------------------------------------
    -- Function bo2sl
    ---------------------------------------------------------------------------
    type     bo2sl_type is array (boolean) of std_logic;
    constant bo2sl_table : bo2sl_type := ('0', '1');
    function bo2sl(b: boolean) return std_logic is
    begin
      return bo2sl_table(b);
    end bo2sl;

    ---------------------------------------------------------------------------
    -- Function num_common_high_order_addr_bits
    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- This function returns the number of high-order address bits
    -- that can be commonly decoded across all address pairs passed in as
    -- the argument ara. Note: only the C_OPB_AWIDTH rightmost bits of an entry
    -- in ara are considered to make up the address.
    ----------------------------------------------------------------------------
    function num_common_high_order_addr_bits(ara: SLV64_ARRAY_TYPE)
                                            return integer is
        variable n : integer := C_OPB_AWIDTH;
            -- Maximum number of common high-order bits for
            -- the ranges starting at an index less than i.
        variable i, j: integer;
        variable old_base: std_logic_vector(0 to C_OPB_AWIDTH-1)
                         := ara(0)(   ara(0)'length-C_OPB_AWIDTH
                                   to ara(0)'length-1
                                  );
        variable new_base, new_high: std_logic_vector(0 to C_OPB_AWIDTH-1);
    begin
      i := 0;
      while i < ara'length loop
          new_base := ara(i  )(ara(0)'length-C_OPB_AWIDTH to ara(0)'length-1);
          new_high := ara(i+1)(ara(0)'length-C_OPB_AWIDTH to ara(0)'length-1);
          j := 0;
          while  j < n                             -- Limited by earlier value.
             and new_base(j) = old_base(j)         -- High-order addr diff found
                                                   -- with a previous range.
             and (new_base(j) xor new_high(j))='0' -- Addr-range boundary found
                                                   -- for current range.
          loop
              j := j+1;
          end loop;
          n := j;
          i := i+2;
      end loop;
      return n;
    end num_common_high_order_addr_bits;

    constant K_DEV_ADDR_DECODE_WIDTH
               : integer
               := num_common_high_order_addr_bits(C_ARD_ADDR_RANGE_ARRAY);


    ---------------------------------------------------------------------------
    -- Function cs_index_or_maxint
    ---------------------------------------------------------------------------
    function cs_index_or_maxint(C_ARD_ID_ARRAY:INTEGER_ARRAY_TYPE; ID:INTEGER)
                                return integer is
    begin
        if find_ard_id(C_ARD_ID_ARRAY, ID) then
            return get_id_index(C_ARD_ID_ARRAY, ID);
        else
            return integer'high;
        end if;
    end cs_index_or_maxint;

    constant RESET_MIR_CS_IDX : natural
                              := cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_RST);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_RESET_MIR is false.

    constant INTR_CS_IDX : integer
                              := cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_INTR);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_INTR is false.

    -- ALS - added read and write packet FIFOs indices
    constant RDFIFO_DATA_CS_IDX : integer
                              := cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_RDFIFO_DATA);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_RDPFIFO is false.
    constant RDFIFO_REG_CS_IDX : integer
                              := cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_RDFIFO_REG);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_RDPFIFO is false.
    constant WRFIFO_DATA_CS_IDX : integer
                              := cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_WRFIFO_DATA);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_WRPFIFO is false.
    constant WRFIFO_REG_CS_IDX : integer
                              := cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_WRFIFO_REG);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_WRPFIFO is false.

    ---------------------------------------------------------------------------
    -- Function ce_index_or_maxint
    ---------------------------------------------------------------------------
    function ce_index_or_maxint(C_ARD_ID_ARRAY: INTEGER_ARRAY_TYPE; IDX: integer)
                                             return integer is
    begin
        if IDX < NUM_ARDS then
            return calc_start_ce_index(C_ARD_NUM_CE_ARRAY, IDX);
        else
            return integer'high;
        end if;
    end ce_index_or_maxint;

    constant RESET_MIR_CE_IDX : natural
                              :=ce_index_or_maxint(C_ARD_ID_ARRAY,
                                                   RESET_MIR_CS_IDX);

    constant INTR_CE_LO       : natural
                              := ce_index_or_maxint(C_ARD_ID_ARRAY,
                                                    INTR_CS_IDX);
    -- ALS - added constants for read and write FIFOS
    constant RFIFO_REG_CE_LO  : natural
                              := ce_index_or_maxint(C_ARD_ID_ARRAY,
                                                    RDFIFO_REG_CS_IDX);
    constant RFIFO_DATA_CE    : natural
                              := ce_index_or_maxint(C_ARD_ID_ARRAY,
                                                    RDFIFO_DATA_CS_IDX);
    constant WFIFO_REG_CE_LO  : natural
                              := ce_index_or_maxint(C_ARD_ID_ARRAY,
                                                    WRFIFO_REG_CS_IDX);
    constant WFIFO_DATA_CE    : natural
                              := ce_index_or_maxint(C_ARD_ID_ARRAY,
                                                    WRFIFO_DATA_CS_IDX);

    ---------------------------------------------------------------------------
    -- Function ce_hi_avoiding_bounds_error (was intr_ce_hi_avoiding_bounds_error)
    -- ALS - modified this function to be usable by the FIFO Register CEs
    ---------------------------------------------------------------------------
    function ce_hi_avoiding_bounds_error(
                 C_ARD_ID_ARRAY: INTEGER_ARRAY_TYPE;
                 CS_IDX: integer
             ) return integer is
    begin
        if CS_IDX < NUM_ARDS then
            return   calc_start_ce_index(C_ARD_NUM_CE_ARRAY, CS_IDX)
                   + C_ARD_NUM_CE_ARRAY(CS_IDX) - 1;
        else
            return integer'high;
        end if;
    end ce_hi_avoiding_bounds_error;

    constant INTR_CE_HI       : natural
                              := ce_hi_avoiding_bounds_error(
                                     C_ARD_ID_ARRAY,
                                     INTR_CS_IDX
                                 );

    -- ALS - added constant for read/write FIFO register CE high
    constant RFIFO_REG_CE_HI  : natural
                              := ce_hi_avoiding_bounds_error(
                                     C_ARD_ID_ARRAY,
                                     RDFIFO_REG_CS_IDX
                                 );

    constant WFIFO_REG_CE_HI  : natural
                              := ce_hi_avoiding_bounds_error(
                                     C_ARD_ID_ARRAY,
                                     WRFIFO_REG_CS_IDX
                                 );



    ---------------------------------------------------------------------------
    -- Function number_CEs_for
    ---------------------------------------------------------------------------
    function number_CEs_for(ard_id: integer) return integer is
        variable id_included: boolean;
    begin
        id_included := find_ard_id(C_ARD_ID_ARRAY, ard_id);
        if id_included then
            return C_ARD_NUM_CE_ARRAY(get_id_index(C_ARD_ID_ARRAY, ard_id));
        else return 0;
        end if;
    end number_CEs_for;



    ----------------------------------------------------------------------------
    -- Constant zero std_logic_vector large enough for any needed use.
    ----------------------------------------------------------------------------
    constant ZSLV  : std_logic_vector(0 to 255) := (others => '0');

    ---------------------------------------------------------------------------
    -- Function num_decode_bits
    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- This function returns the number of address bits that need to be
    -- decoded to find a "hit" in the address range defined by
    -- the idx'th pair of base_address/high_address in c_ard_addr_range_array.
    -- Only the rightmost numbits are considered and the result is the
    -- number of leftmost bits within this field that need to be decoded.
    ----------------------------------------------------------------------------
    function num_decode_bits(ard_addr_range_array : SLV64_ARRAY_TYPE;
                             numbits              : natural;
                             idx                  : natural)
    return integer is
      constant SZ : natural := ard_addr_range_array(0)'length;
      constant ADDR_XOR : std_logic_vector(0 to numbits-1)
          :=     ard_addr_range_array(2*idx  )(SZ-numbits to SZ-1)  -- base
             xor ard_addr_range_array(2*idx+1)(SZ-numbits to SZ-1); -- high
    begin
      for i in 0 to numbits-1 loop
        if ADDR_XOR(i)='1' then return i;
        end if;
      end loop;
      return(numbits);
    end function num_decode_bits;



    ---------------------------------------------------------------------------
    -- Function encoded_size_is_1
    ---------------------------------------------------------------------------
    --------------------------------------------------------------------------
    -- Returns whether bit n of the encoded representation of the data size
    -- for address range ar is a 1
    --
    --  DSIZE     Encoded value
    --      8     001
    --     16     010
    --     32     011
    --     64     100
    --    128     101
    -- Others     not supported
    --------------------------------------------------------------------------
    function encoded_size_is_1(ar, n: natural) return boolean is
    begin
        case n is
                             -- high-order bit
            when 0 => return C_ARD_DWIDTH_ARRAY(ar) = 64 or
                             C_ARD_DWIDTH_ARRAY(ar) =128;
                             -- middle bit
            when 1 => return C_ARD_DWIDTH_ARRAY(ar) = 16 or
                             C_ARD_DWIDTH_ARRAY(ar) = 32;
                             -- low-order bit
            when 2 => return C_ARD_DWIDTH_ARRAY(ar) =  8 or
                             C_ARD_DWIDTH_ARRAY(ar) = 32 or
                             C_ARD_DWIDTH_ARRAY(ar) =128;
                             -- default for unsupported values
            when others =>   return false;
        end case;
    end encoded_size_is_1;


    ---------------------------------------------------------------------------
    -- Function num_cs_for_bit
    ---------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Returns the number of CS signals that need to be or'ed to give
    -- bit n of the encoded size.
    ----------------------------------------------------------------------------
    function num_cs_for_bit(n: natural) return natural is
        variable r: natural;
    begin
        r := 0;
        for k in 0 to NUM_ARDS-1 loop
           if encoded_size_is_1(k, n) then r := r+1; end if;
        end loop;
        return r;
    end num_cs_for_bit;


    ---------------------------------------------------------------------------
    -- Function eff_ip2bus_val
    ---------------------------------------------------------------------------
    -- ALS - modified to include read and write packet fifos
    function eff_ip2bus_val(i       : integer;
                            rst     : std_logic;
                            intr    : std_logic;
                            wrfifo  : std_logic;
                            rdfifo  : std_logic;
                            user    : std_logic
                           ) return std_logic is
    begin
        if    C_ARD_ID_ARRAY(i) = IPIF_RST          then return rst;
        elsif C_ARD_ID_ARRAY(i) = IPIF_INTR         then return intr;
        elsif C_ARD_ID_ARRAY(i) = IPIF_WRFIFO_REG or
              C_ARD_ID_ARRAY(i) = IPIF_WRFIFO_DATA  then return wrfifo;
        elsif C_ARD_ID_ARRAY(i) = IPIF_RDFIFO_REG or
              C_ARD_ID_ARRAY(i) = IPIF_RDFIFO_DATA  then return rdfifo;
        else                                             return user;
        end if;
    end eff_ip2bus_val;

    ---------------------------------------------------------------------------
    -- ALS: added function get_max_addr_range
    -- Function get_max_addr_range
    -- This function parses the ARD_ADDR_RANGE_ARRAY to determine which
    -- baseaddr/highaddr pair spans the greatest address range. This is then
    -- used to size the burst address counter
    ---------------------------------------------------------------------------
    function get_max_user_addr_range(bus_awidth:integer) return integer is
        variable max_range  : integer := 0;
        variable curr_range : integer := 0;
    begin
        for i in 0 to C_ARD_ADDR_RANGE_ARRAY'length/2-1 loop
            if C_ARD_ID_ARRAY(i) = IPIF_RST         or
               C_ARD_ID_ARRAY(i) = IPIF_INTR        or
               C_ARD_ID_ARRAY(i) = IPIF_WRFIFO_REG  or
               C_ARD_ID_ARRAY(i) = IPIF_WRFIFO_DATA or
               C_ARD_ID_ARRAY(i) = IPIF_RDFIFO_REG  or
               C_ARD_ID_ARRAY(i) = IPIF_RDFIFO_DATA then
                max_range := max_range;
            else
                -- addr_bits function returns number of address bits that are equal
                -- between baseaddr and highaddr, so the address range is the
                -- bus width minus the address bits
                curr_range := bus_awidth - num_decode_bits(C_ARD_ADDR_RANGE_ARRAY,
                                                           C_OPB_AWIDTH,
                                                           i);
                if curr_range >= max_range then
                    max_range := curr_range;
                else
                    max_range := max_range;
                end if;
            end if;
        end loop;

        return max_range;
    end get_max_user_addr_range;

-- opb_flex_addr_cntr requires a minimum range of 7 (or 0 to 6)
--    constant MAX_USER_ADDR_RANGE    : integer := get_max_user_addr_range(C_OPB_AWIDTH);       --GB
    constant MAX_USER_ADDR_RANGE    : integer := max2(7,get_max_user_addr_range(C_OPB_AWIDTH)); --GB

 ------------------------------------------------------------------------------
 -- Signal declarations
 ------------------------------------------------------------------------------
    signal bus2ip_clk_i             : std_logic;
    signal bus2ip_reset_i           : std_logic;
    signal opb_select_s0            : std_logic;
    signal opb_select_s0_d1         : std_logic;
    signal opb_rnw_s0               : std_logic;
    signal opb_seqaddr_s0           : std_logic;
    signal opb_seqaddr_s0_d1        : std_logic;
    signal bus2ip_burst_s1          : std_logic;
    signal bus2ip_burst_s1_d1       : std_logic;
    signal opb_seqaddr_d1           : std_logic;
    signal opb_abus_s0              : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal opb_dbus_s0              : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal opb_be_s0                : std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    signal bus2ip_rnw_s1            : std_logic;
    signal bus2ip_be_s0             : std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    signal bus2ip_be_s1             : std_logic_vector(0 to C_OPB_DWIDTH/8-1) := (others => '0');
    signal bus2ip_cs_s0             : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_s0_d1          : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_s1             : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_hit_s0         : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_hit            : std_logic_vector(0 to NUM_ARDS-1); -- GAB 10/12/05
    signal bus2ip_cs_hit_s0_d1      : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_enable_s0      : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_ce_s0             : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_ce_s1             : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_rdce_s0           : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_rdce_s1           : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_wrce_s0           : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_wrce_s1           : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_addr_s0           : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal bus2ip_addr_s1           : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal bus2ip_addrvalid_s1      : std_logic;
    signal bus2ip_data_s0           : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal bus2ip_data_s1           : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal devicesel_s0             : std_logic;
    signal devicesel                : std_logic; -- GAB 10/12/05
-- ALS - added address counter signals
    signal address_load             : std_logic;
    signal opb_addr_cntr_out        : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal next_opb_addr_cntr_out   : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal next_steer_addr_cntr_out : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal steer_addr_cntr_out      : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal opb_be_cntr_out          : std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    signal opb_be_cntr_steer        : std_logic_vector(0 to C_OPB_DWIDTH/8-1);

-- ALS - added bus2ip_rdreq and bus2ip_wrreq and signals to support their
-- generation
    signal rdreq                    : std_logic;
    signal rdreq_hold               : std_logic;
    signal rdreq_hold_rst           : std_logic;
    signal bus2ip_rdreq_s0          : std_logic;
    signal bus2ip_rdreq_s1          : std_logic;
    signal Bus2IP_RdReq             : std_logic; --REMOVE IF THIS BECOMES A PORT

    signal wrreq                    : std_logic;
    signal wrreq_hold               : std_logic;
    signal wrreq_hold_rst           : std_logic;
    signal bus2ip_wrreq_s0          : std_logic;
    signal bus2ip_wrreq_s1          : std_logic;
    signal Bus2IP_WrReq             : std_logic; --REMOVE IF THIS BECOMES A PORT

-- ALS added write buffer signals
    signal wrbuf_data               : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal wrbuf_be                 : std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    signal wrbuf_burst              : std_logic;
    signal wrbuf_xferack            : std_logic;
    signal wrbuf_errack             : std_logic;
    signal wrbuf_retry              : std_logic;
    signal wrbuf_cs                 : std_logic_vector(0 to NUM_ARDS-1);
    signal wrbuf_rnw                : std_logic;
    signal wrbuf_ce                 : std_logic_vector(0 to NUM_CES-1);
    signal wrbuf_wrce               : std_logic_vector(0 to NUM_CES-1);
    signal wrbuf_rdce               : std_logic_vector(0 to NUM_CES-1);
    signal wrbuf_empty              : std_logic;
    signal wrbuf_addrcntr_en        : std_logic;
    signal wrbuf_addrcntr_rst       : std_logic;
    signal wrbuf_addrvalid          : std_logic;
    signal ipic_pstage_ce           : std_logic;
    signal wrdata_ack               : std_logic;
    signal wrbuf_addrack            : std_logic;

-- ALS added transfer start and done signals
    signal opb_xfer_done            : std_logic;
    signal opb_xfer_start           : std_logic;

    constant NUM_ENCODED_SIZE_BITS  : natural := 3;

    type   OR_CSES_PER_BIT_TABLE_TYPE is array(0 to NUM_ENCODED_SIZE_BITS-1) of
                                          std_logic_vector(0 to NUM_ARDS-1);

    signal cs_to_or_for_dsize_bit   : OR_CSES_PER_BIT_TABLE_TYPE;

    signal encoded_dsize_s0         : std_logic_vector(0
                                        to NUM_ENCODED_SIZE_BITS-1);
    signal encoded_dsize_s1         : std_logic_vector(0
                                        to NUM_ENCODED_SIZE_BITS-1);

    signal ip2bus_data_mx           : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal sln_dbus_s1              : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal sln_dbus_s2              : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal ipic_xferack             : std_logic;
    signal sln_xferack_s1           : std_logic;
    signal sln_xferack_s1_d1        : std_logic;
    signal sln_xferack_s1_d2        : std_logic;
    signal sln_xferack_s2           : std_logic;
    signal sln_retry_s1             : std_logic;
    signal sln_retry_s1_d1          : std_logic;
    signal sln_retry_s1_d2          : std_logic;
    signal sln_retry_s2             : std_logic;
    signal sln_errack_s1            : std_logic;
    signal sln_errack_s2            : std_logic;
    signal sln_toutsup_s1           : std_logic;
    signal sln_toutsup_s2           : std_logic;

    signal reset2bus_data           : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal reset2bus_ack            : std_logic;
    signal reset2bus_error          : std_logic;
    signal reset2bus_retry          : std_logic;
    signal reset2bus_toutsup        : std_logic;
    signal reset2bus_postedwrinh    : std_logic;

    -- interrupt signals
    signal intr2bus_data            : std_logic_vector(0 to C_OPB_DWIDTH-1);
    signal intr2bus_rdack           : std_logic;
    signal intr2bus_wrack           : std_logic;
    signal intr2bus_ack             : std_logic;
    signal intr2bus_error           : std_logic;
    signal intr2bus_retry           : std_logic;
    signal intr2bus_toutsup         : std_logic;
    signal intr2bus_postedwrinh     : std_logic;

    -- FIFO signals
    signal rfifo_error              : std_logic;
    signal rfifo_rdack              : std_logic;
    signal rfifo_retry              : std_logic;
    signal rfifo_toutsup            : std_logic;
    signal rfifo_wrack              : std_logic;
    signal rdfifo_ack               : std_logic;
    signal rdfifo2bus_data          : std_logic_vector(0 to C_OPB_DWIDTH - 1 );
    signal rdfifo2intr_deadlock     : std_logic;

    signal wfifo_error              : std_logic;
    signal wfifo_rdack              : std_logic;
    signal wfifo_retry              : std_logic;
    signal wfifo_toutsup            : std_logic;
    signal wfifo_wrack              : std_logic;
    signal wrfifo_ack               : std_logic;
    signal wrfifo2bus_data          : std_logic_vector(0 to C_OPB_DWIDTH - 1 );
    signal wrfifo2intr_deadlock     : std_logic;


    signal new_pw_s0                : std_logic_vector(0 to NUM_ARDS-1);
    signal new_pw_s0_d1             : std_logic_vector(0 to NUM_ARDS-1);
    signal inh_cs_when_pw           : std_logic_vector(0 to NUM_ARDS-1);
    signal inh_cs_wnot_pw           : std_logic;
    signal inh_xferack_when_pw      : std_logic;
    signal inh_xferack_when_burst_rd: std_logic;
    signal last_xferack             : std_logic;
    signal last_xferack_s0          : std_logic;
    signal last_xferack_d1          : std_logic;
    signal last_xferack_d1_s0       : std_logic;
    signal last_xferack_d2          : std_logic;
    signal last_pw_xferack          : std_logic;
    signal last_pw_xferack_d1       : std_logic;
    signal last_pw_xferack_d2       : std_logic;
--    signal last_wr_xferack          : std_logic;
--    signal last_wr_xferack_d1       : std_logic;
--    signal last_wr_xferack_d2       : std_logic;
    signal last_burstrd_xferack     : std_logic;
    signal last_burstrd_xferack_d1  : std_logic;
    signal last_burstrd_xferack_d2  : std_logic;
    signal OPB_seqAddr_eff          : std_logic;

    signal postedwr_s0              : std_logic;
    signal postedwrack_s2           : std_logic;

    signal cycle_abort              : std_logic;
    signal cycle_abort_d1           : std_logic;
    signal xfer_abort               : std_logic;
    signal cycle_active             : std_logic;

    signal ip2bus_postedwrinh_s1    : std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    signal ip2bus_postedwrinh_s2    : std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    signal ip2bus_postedwrinh_s2_d1 : std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    signal ip2bus_postedwrinh_s2_d2 : std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    signal ip2bus_xferack           : std_logic;

-------------------------------------------------------------------------------
begin

    OPB_seqAddr_eff <= OPB_seqAddr and bo2sl(C_DEV_BURST_ENABLE=1);

    bus2ip_clk_i    <= OPB_Clk;
    Bus2IP_Clk      <= OPB_Clk;

    Bus2IP_Freeze   <= Freeze;

    reset2bus_postedwrinh   <= '1'; --GB
    intr2bus_postedwrinh    <= '1';

    ---------------------------------------------------------------------------
    -- Pipeline Stage 0
    ---------------------------------------------------------------------------
    GEN_PSTAGE0: if INCLUDE_OPBIN_PSTAGE generate
    begin
        PROC_PSTAGE0 : process(bus2ip_clk_i)
        begin
            --------------------------------------------------------------------
            -- Sigs that need reset value
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                if Reset = '1' then
                    opb_select_s0 <= '0';
                    bus2ip_cs_hit_s0    <= (others => '0'); -- GAB 10/12/05
                else
                    opb_select_s0 <= OPB_select;
                    bus2ip_cs_hit_s0    <= bus2ip_cs_hit; -- GAB 10/12/05
                end if;
            end if;
            --------------------------------------------------------------------
            -- Sigs that do not need reset value
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                opb_rnw_s0          <= OPB_RNW;
                opb_seqaddr_s0      <= OPB_seqAddr_eff;
                opb_abus_s0         <= OPB_ABus;
                opb_dbus_s0         <= OPB_DBus;
                opb_be_s0           <= OPB_BE;
                last_xferack_s0     <= last_xferack;
                last_xferack_d1_s0  <= last_xferack_d1;
            end if;
        end process;
    end generate;
    --
    GEN_BYPASS0: if not INCLUDE_OPBIN_PSTAGE generate
    begin
        opb_select_s0       <= OPB_select;
        opb_rnw_s0          <= OPB_RNW;
        opb_seqaddr_s0      <= OPB_seqAddr_eff;
        opb_abus_s0         <= OPB_ABus;
        opb_dbus_s0         <= OPB_DBus;
        opb_be_s0           <= OPB_BE;
        last_xferack_s0     <= last_xferack;
        last_xferack_d1_s0  <= last_xferack_d1;
        bus2ip_cs_hit_s0    <= bus2ip_cs_hit; -- GAB 10/12/05
    end generate;


    ---------------------------------------------------------------------------
    -- Pipeline Stage 1
    ---------------------------------------------------------------------------
    GEN_PSTAGE1: if INCLUDE_IPIC_PSTAGE generate
    begin
        -- RdReq and WrReq need to be registered for this stage independent
        -- of write buffer inclusion
        PROC_PSTAGE1_RDWR_REQ : process(bus2ip_clk_i)
        begin
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
              if Reset = '1' then
                  -- ALS - added bus2ip_rdreq and bus2ip_wrreq
                  bus2ip_rdreq_s1   <= '0';
                  bus2ip_wrreq_s1   <= '0';
                  encoded_dsize_s1  <= (others => '0');
              else
                  bus2ip_rdreq_s1   <= bus2ip_rdreq_s0;
                  bus2ip_wrreq_s1   <= bus2ip_wrreq_s0;
                  encoded_dsize_s1  <= encoded_dsize_s0;
              end if;
            end if;
        end process PROC_PSTAGE1_RDWR_REQ;


        -- Write Buffer takes place of IPIC PSTAGE for the remaining signals
        -- register in this stage only if Write Buffer is not included
        WRBUF_IPIC_PSTAGE_GEN: if C_INCLUDE_WR_BUF = 1 generate
            bus2ip_cs_s1        <= wrbuf_cs;
            bus2ip_ce_s1        <= wrbuf_ce;
            bus2ip_wrce_s1      <= wrbuf_wrce;
            bus2ip_rdce_s1      <= wrbuf_rdce;
            bus2ip_data_s1      <= wrbuf_data;
            bus2ip_rnw_s1       <= wrbuf_rnw;
            bus2ip_burst_s1     <= wrbuf_burst;
            bus2ip_addrvalid_s1 <= wrbuf_addrvalid;
            bus2ip_be_s1        <= wrbuf_be;
            bus2ip_addr_s1      <= opb_addr_cntr_out;
        end generate WRBUF_IPIC_PSTAGE_GEN;

        NOWRBUF_IPIC_PSTAGE_GEN: if C_INCLUDE_WR_BUF = 0 generate
        begin
            PROC_PSTAGE1 : process(bus2ip_clk_i)
            begin
                --------------------------------------------------------------------
                -- Sigs that need reset value
                --------------------------------------------------------------------
                if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                    if Reset = '1' then
                        bus2ip_cs_s1        <= (others => '0');
                        bus2ip_ce_s1        <= (others => '0');
                        bus2ip_rdce_s1      <= (others => '0');
                        bus2ip_wrce_s1      <= (others => '0');
                        bus2ip_addrvalid_s1 <= '0';
                    else
                        bus2ip_cs_s1        <= wrbuf_cs;
                        bus2ip_ce_s1        <= wrbuf_ce;
                        bus2ip_wrce_s1      <= wrbuf_wrce;
                        bus2ip_rdce_s1      <= wrbuf_rdce;
                        bus2ip_addrvalid_s1 <= wrbuf_addrvalid;
                    end if;
                end if;
                --------------------------------------------------------------------
                -- Sigs that do not need reset value
                --------------------------------------------------------------------
                if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                    bus2ip_data_s1    <= wrbuf_data;
                    bus2ip_rnw_s1     <= wrbuf_rnw;
                    bus2ip_burst_s1   <= wrbuf_burst;
                end if;
            end process PROC_PSTAGE1;

            -- If the address counter is included, it represents the S1 register stage
            -- It is just necessary to register the BEs
            -- If the address counter is not included, create the register stage for both
            -- the address and the BEs

            ADDRCNT_IPIC_STAGE: if INCLUDE_ADDR_CNTR generate

                bus2ip_addr_s1   <= opb_addr_cntr_out;

                ADDRCNT_IPIC_REG_PROC : process(bus2ip_clk_i)
                begin
                    if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                        bus2ip_be_s1     <= wrbuf_be; -- BEs output from steering logic
                    end if;
                end process ADDRCNT_IPIC_REG_PROC;

            end generate ADDRCNT_IPIC_STAGE;

            NOADDRCNT_IPIC_STAGE: if not(INCLUDE_ADDR_CNTR) generate
                NOADDRCNT_IPIC_REG_PROC : process(bus2ip_clk_i)
                begin
                    if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                        bus2ip_addr_s1   <= opb_addr_cntr_out;
                        bus2ip_be_s1     <= wrbuf_be; -- BEs output from steering logic
                    end if;
                end process NOADDRCNT_IPIC_REG_PROC;

            end generate NOADDRCNT_IPIC_STAGE;

        end generate NOWRBUF_IPIC_PSTAGE_GEN;
    end generate GEN_PSTAGE1;
    --
    GEN_BYPASS1: if not INCLUDE_IPIC_PSTAGE generate
    begin
        bus2ip_cs_s1        <= wrbuf_cs;
        bus2ip_ce_s1        <= wrbuf_ce;
        bus2ip_wrce_s1      <= wrbuf_wrce;
        bus2ip_data_s1      <= wrbuf_data;
        bus2ip_rnw_s1       <= wrbuf_rnw;
        bus2ip_burst_s1     <= wrbuf_burst;
        bus2ip_addrvalid_s1 <= wrbuf_addrvalid;

        encoded_dsize_s1    <= encoded_dsize_s0;

        bus2ip_rdce_s1      <= wrbuf_rdce;

        bus2ip_addr_s1      <= opb_addr_cntr_out;
        bus2ip_be_s1        <= wrbuf_be;

        -- ALS - added bus2ip_rdreq and bus2ip_wrreq
        bus2ip_rdreq_s1     <= bus2ip_rdreq_s0;
        bus2ip_wrreq_s1     <= bus2ip_wrreq_s0;
    end generate GEN_BYPASS1;

    Bus2IP_CS           <= bus2ip_cs_s1;
    Bus2IP_CE           <= bus2ip_ce_s1;
    Bus2IP_RdCE         <= bus2ip_rdce_s1;
    Bus2IP_WrCE         <= bus2ip_wrce_s1;
    Bus2IP_Addr         <= bus2ip_addr_s1;
    Bus2IP_Data         <= bus2ip_data_s1;
    Bus2IP_BE           <= bus2ip_be_s1;
    Bus2IP_RNW          <= bus2ip_rnw_s1;
    Bus2IP_Burst        <= bus2ip_burst_s1 and or_reduce(bus2ip_cs_s1);
    Bus2IP_AddrValid    <= bus2ip_addrvalid_s1;

-- ALS - added Bus2IP_RdReq and Bus2IP_WrReq
-- ToDo - determine if these should be ports
    Bus2IP_RdReq        <= bus2ip_rdreq_s1;
    Bus2IP_WrReq        <= bus2ip_wrreq_s1;


    ip2bus_postedwrinh_s1   <= IP2Bus_PostedWrInh; --GB
    ---------------------------------------------------------------------------
    -- Pipeline Stage 2
    ---------------------------------------------------------------------------
    GEN_PSTAGE2: if INCLUDE_OPBOUT_PSTAGE generate
    begin
        PROC_PSTAGE2 : process(bus2ip_clk_i)
        begin
            --------------------------------------------------------------------
            -- Sigs that need to be reset by OPB_Select
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                if OPB_Select = '0' then
                    sln_xferack_s2  <= '0';
                    sln_errack_s2   <= '0';
                    sln_retry_s2    <= '0';
                    sln_toutsup_s2  <= '0';
                   -- ip2bus_postedwrinh_s2 <= (others => '0');       --GB
                else
                    sln_xferack_s2  <= sln_xferack_s1 and not cycle_abort ;
                    sln_retry_s2    <= sln_retry_s1 ;
                    sln_errack_s2   <= sln_errack_s1 ;
                    sln_toutsup_s2  <= sln_toutsup_s1;

--                    ip2bus_postedwrinh_s2 <= ip2bus_postedwrinh_s1; --GB
                end if;
            end if;
            --------------------------------------------------------------------
            -- Sigs that need reset value
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                if (Reset or not (sln_xferack_s1 and bus2ip_rnw_s1)) = '1' then
                    sln_dbus_s2      <= (others => '0');
                else
                    sln_dbus_s2      <= sln_dbus_s1;
                end if;
            end if;
            --------------------------------------------------------------------
            -- Sigs that do not need reset value
            --------------------------------------------------------------------
              if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                  postedwrack_s2   <= postedwr_s0;
                  ip2bus_postedwrinh_s2 <= ip2bus_postedwrinh_s1; --GB

              end if;
        end process;
    end generate;
    --
    GEN_BYPASS2: if not INCLUDE_OPBOUT_PSTAGE generate
    begin
                  sln_dbus_s2      <= sln_dbus_s1;
                  sln_xferack_s2   <= sln_xferack_s1 and OPB_Select;
                  sln_retry_s2     <= sln_retry_s1 and OPB_Select;
                  sln_errack_s2    <= sln_errack_s1 and OPB_Select;
                  sln_toutsup_s2   <= sln_toutsup_s1 and OPB_Select;
                  postedwrack_s2   <= postedwr_s0;
                  ip2bus_postedwrinh_s2 <= ip2bus_postedwrinh_s1;   --GB
    end generate;

    Sln_Dbus    <= sln_dbus_s2;
    Sln_xferAck <= sln_xferack_s2 and OPB_Select;                     --GB
    Sln_retry   <= sln_retry_s2 and OPB_Select;                         --GB
--    Sln_xferAck <= sln_xferack_s2 and OPB_Select and not(xfer_abort);   --GB
--    Sln_retry   <= (sln_retry_s2 or cycle_abort) and OPB_Select;        --GB
    Sln_errAck  <= sln_errack_s2 and OPB_Select;
    Sln_toutSup <= sln_toutsup_s2;


  -----------------------------------------------------------------------------
  -- Extend burst signal by 1 clock
  -----------------------------------------------------------------------------
      BURST_EXTEND_PROCESS: process (bus2ip_clk_i)
      begin
          if bus2ip_clk_i'event and bus2ip_clk_i = '1' then
              opb_seqaddr_s0_d1 <= opb_seqaddr_s0;
          end if;
      end process;

  ------------------------------------------------------------------------------
  -- Generation of devicesel_s0
  -----------------------------------------------------------------------------
  DEVICESEL_S0_I: entity opb_v20_v1_10_d.pselect
    generic map (
      C_AB     => K_DEV_ADDR_DECODE_WIDTH,
      C_AW     => C_OPB_AWIDTH,
      C_BAR    => C_ARD_ADDR_RANGE_ARRAY(0)
                     (   C_ARD_ADDR_RANGE_ARRAY(0)'length-C_OPB_AWIDTH
                      to C_ARD_ADDR_RANGE_ARRAY(0)'length-1
                     )
    )
    port map (
--      A        => opb_abus_s0,    -- GAB 10/12/05
--      AValid   => opb_select_s0,  -- GAB 10/12/05
--      CS       => devicesel_s0    -- GAB 10/12/05
      A        => OPB_abus,         -- GAB 10/12/05
      AValid   => OPB_select,       -- GAB 10/12/05
      CS       => devicesel         -- GAB 10/12/05
    );

  ------------------------------------------------------------------------------
  -- Determination of clock periods on which IPIC transactions are blocked
  -- from starting, either because
  --   (1) an acknowledged IPIC transaction is finishing and being cleared
  --       from the pipeline, or
  --   (2) the posted-write pipeline is filling.
  -----------------------------------------------------------------------------

  DELAYS_FOR_BLK_PROC : process (OPB_Clk) is
  begin
      if OPB_Clk'event and OPB_Clk='1' then
          sln_xferack_s1_d1         <= sln_xferack_s1;
          sln_xferack_s1_d2         <= sln_xferack_s1_d1;
          sln_retry_s1_d1           <= sln_retry_s1;
          sln_retry_s1_d2           <= sln_retry_s1_d1;
          opb_select_s0_d1          <= opb_select_s0;
          new_pw_s0_d1              <= new_pw_s0;
          opb_seqaddr_d1            <= OPB_seqAddr_eff;
--          last_wr_xferack_d1        <= last_wr_xferack;
--          last_wr_xferack_d2        <= last_wr_xferack_d1;
          last_burstrd_xferack_d1   <= last_burstrd_xferack;
          last_burstrd_xferack_d2   <= last_burstrd_xferack_d1;
          bus2ip_cs_hit_s0_d1       <= bus2ip_cs_hit_s0;

            ip2bus_postedwrinh_s2_d1 <= ip2bus_postedwrinh_s2;
            ip2bus_postedwrinh_s2_d2 <= ip2bus_postedwrinh_s2_d1;
      end if;
  end process;
  --ToDo, can bus2ip_clk_i be used on the above, as below?
  DX_FFS_PROC : process (bus2ip_clk_i) is
  begin
      if bus2ip_clk_i'event and bus2ip_clk_i='1' then
          last_xferack_d1       <= last_xferack;
          last_xferack_d2       <= last_xferack_d1;
          last_pw_xferack_d1    <= last_pw_xferack;
          last_pw_xferack_d2    <= last_pw_xferack_d1;
      end if;
  end process;




  -- Code below works with Write buffer included
--  inh_cs_wnot_pw   <= bo2sl(
--                      not (opb_rnw_s0='1' and OPB_seqAddr_s0='1')
--                                                  -- Do not
--                      and                         -- inhibit when a burst read
--                      (
--                       (sln_xferack_s1_d1='1' and (INCLUDE_OPBIN_PSTAGE or INCLUDE_OPBOUT_PSTAGE))
--
--
--                       or (sln_xferack_s1_d2='1' and (INCLUDE_OPBIN_PSTAGE and INCLUDE_OPBOUT_PSTAGE))
--
--
--                       or (sln_retry_s1_d1='1' and (INCLUDE_OPBIN_PSTAGE or INCLUDE_OPBOUT_PSTAGE))
--
--                       or (sln_retry_s1_d2='1' and (INCLUDE_OPBIN_PSTAGE and INCLUDE_OPBOUT_PSTAGE))
--                      )
--                      );
--
-- -- ABove works when burst enable, pipeline model 2, no writebuffer, doing back to back write/reads
-- -- But causes interrupts/ pfifo tests to fail
--
--
    -- original code
INH_CS_NOWRBUF_GEN : if C_INCLUDE_WR_BUF = 0 generate
    inh_cs_wnot_pw   <= bo2sl
                        (
                            -- Do not inhibit when a burst read
                            not (opb_rnw_s0='1' and opb_seqaddr_s0='1')


                            and
                            (


                                (sln_xferack_s1='1'    and (INCLUDE_IPIC_PSTAGE))

                                or
                                (sln_xferack_s1_d1='1' and (INCLUDE_OPBIN_PSTAGE
                                                         or INCLUDE_OPBOUT_PSTAGE))

                                or
                                (sln_xferack_s1_d2='1' and (INCLUDE_OPBIN_PSTAGE
                                                        and INCLUDE_OPBOUT_PSTAGE))

                                or
                                (sln_retry_s1_d1='1'   and (INCLUDE_OPBIN_PSTAGE
                                                         or INCLUDE_OPBOUT_PSTAGE))

                                or
                                (sln_retry_s1_d2='1'   and (INCLUDE_OPBIN_PSTAGE
                                                        and INCLUDE_OPBOUT_PSTAGE))
                            )
                        );
end generate;

INH_CS_WRBUF_GEN : if C_INCLUDE_WR_BUF = 1 generate
    inh_cs_wnot_pw   <= bo2sl
                        (
                            -- Do not inhibit when a burst read
                            not (opb_rnw_s0='1' and opb_seqaddr_s0_d1='1')


                            and
                            (


                                (sln_xferack_s1='1'    and (INCLUDE_IPIC_PSTAGE))

                                or
                                (sln_xferack_s1_d1='1' and (INCLUDE_OPBIN_PSTAGE
                                                         or INCLUDE_OPBOUT_PSTAGE))

                                or
                                (sln_xferack_s1_d2='1' and (INCLUDE_OPBIN_PSTAGE
                                                        and INCLUDE_OPBOUT_PSTAGE))

                           )
                        );
end generate;

-- GB - Removed check of postedwrinh when write buffer is instantiated.  Write buffer
-- logic does not have postedwrinh implemented yet and this was causing a problem
-- with some of the configurations.  When the write buffer is instantiated the
-- postedwrinh signal is ignored.
GEN_INH_CS_WPW_NO_WRBUF : if C_INCLUDE_WR_BUF = 0 generate
    INH_CS_WHEN_PW_GEN: for i in 0 to NUM_ARDS-1 generate
    begin

        new_pw_s0(i) <= ((bus2ip_cs_hit_s0(i) and not bus2ip_cs_hit_s0_d1(i))
                        or (last_xferack_d1_s0 and opb_select_s0))

                        and not opb_rnw_s0

                        and not eff_ip2bus_val(
                                         i      => i,
                                         rst    => reset2bus_postedwrinh,
                                         intr   => intr2bus_postedwrinh,
                                         wrfifo => '0',
                                         rdfifo => '0',
                                         user   => ip2bus_postedwrinh(i));

  inh_cs_when_pw(i) <= bo2sl(
                          (new_pw_s0(i)='1'    and (INCLUDE_OPBIN_PSTAGE or
                                                      INCLUDE_OPBOUT_PSTAGE))
                      or
                          (new_pw_s0_d1(i)='1' and (INCLUDE_OPBIN_PSTAGE and
                                                      INCLUDE_OPBOUT_PSTAGE))
                         );

    end generate;
end generate GEN_INH_CS_WPW_NO_WRBUF;

GEN_INH_CS_WPW_WRBUF : if C_INCLUDE_WR_BUF = 1 generate     --GB
    INH_CS_WHEN_PW_GEN: for i in 0 to NUM_ARDS-1 generate
    begin

        new_pw_s0(i)        <= ((bus2ip_cs_hit_s0(i) and not bus2ip_cs_hit_s0_d1(i))
                                or (last_xferack_d1_s0 and opb_select_s0))

                                and not opb_rnw_s0;


        inh_cs_when_pw(i)   <= bo2sl(
                               (new_pw_s0(i)='1'    and (INCLUDE_OPBIN_PSTAGE or
                                                         INCLUDE_OPBOUT_PSTAGE))
                            or (new_pw_s0_d1(i)='1' and (INCLUDE_OPBIN_PSTAGE and
                                                         INCLUDE_OPBOUT_PSTAGE))
                            );

    end generate;
end generate GEN_INH_CS_WPW_WRBUF;



-- GB - Removed check of postedwrinh when write buffer is instantiated.  Write buffer
-- logic does not have postedwrinh implemented yet and this was causing a problem
-- with some of the configurations.  When the write buffer is instantiated the
-- postedwrinh signal is ignored.
GEN_PWI_PROC_NO_WRBUF : if C_INCLUDE_WR_BUF = 0 generate
  POSTEDWRINH_PROC: process(reset2bus_postedwrinh, intr2bus_postedwrinh,
                            ip2bus_postedwrinh, bus2ip_cs_hit_s0,
                            opb_rnw_s0)
      variable r : std_logic;
  begin
      r := '0';
      for i in 0 to NUM_ARDS-1 loop
          r := r or (    bus2ip_cs_hit_s0(i)
                     and not eff_ip2bus_val(
                                            i       => i,
                                            rst     => reset2bus_postedwrinh,
                                            intr    => intr2bus_postedwrinh,
                                            wrfifo  => '0',
                                            rdfifo  => '0',
                                            user    => ip2bus_postedwrinh(i)
                                           )
                    );
      end loop;
      postedwr_s0 <= bo2sl(r='1' and not opb_rnw_s0='1'); --and C_DEV_BURST_ENABLE=1);--GB
  end process;
end generate  GEN_PWI_PROC_NO_WRBUF;

GEN_PWI_PROC_WRBUF : if C_INCLUDE_WR_BUF = 1 generate   --GB
  POSTEDWRINH_PROC: process(reset2bus_postedwrinh, intr2bus_postedwrinh,
                            bus2ip_cs_hit_s0, opb_rnw_s0)
      variable r : std_logic;
  begin
      r := '0';
      for i in 0 to NUM_ARDS-1 loop
          r := r or bus2ip_cs_hit_s0(i);
      end loop;
      postedwr_s0 <= bo2sl(r='1' and not opb_rnw_s0='1' and C_DEV_BURST_ENABLE=1);
  end process;
end generate  GEN_PWI_PROC_WRBUF;



    last_xferack            <= sln_xferack_s2
                                and not OPB_seqAddr_eff
                                and not(last_xferack_d1);

    last_burstrd_xferack    <= sln_xferack_s2
                                and (not OPB_seqAddr_eff and opb_seqaddr_d1)  -- falling edge of burst
                                and not(last_xferack_d1);

    inh_xferack_when_burst_rd <= not(or_reduce(new_pw_s0)) and
                ( (last_burstrd_xferack     and bo2sl(INCLUDE_OPBOUT_PSTAGE))
                or (last_burstrd_xferack_d1 and bo2sl(INCLUDE_OPBIN_PSTAGE or
                                                INCLUDE_IPIC_PSTAGE))
                or (last_burstrd_xferack_d2 and bo2sl(INCLUDE_OPBIN_PSTAGE and
                                                INCLUDE_IPIC_PSTAGE)) );

    last_pw_xferack <= sln_xferack_s2 and not OPB_seqAddr_eff and postedwrack_s2;

    inh_xferack_when_pw <=
                bo2sl((last_pw_xferack='1' and (INCLUDE_OPBOUT_PSTAGE))
                or
                 (last_pw_xferack_d1='1' and (INCLUDE_OPBIN_PSTAGE or
                                                    INCLUDE_IPIC_PSTAGE))

                or (last_pw_xferack_d2='1' and (INCLUDE_OPBIN_PSTAGE and
                                                    INCLUDE_IPIC_PSTAGE)) );

  -----------------------------------------------------------------------------
  -- ALS: added register to extend burst signal 1 clock
  -----------------------------------------------------------------------------
    BUS2IP_BURST_EXTEND_PROCESS: process (bus2ip_clk_i)
    begin
        if bus2ip_clk_i'event and bus2ip_clk_i = '1' then
            bus2ip_burst_s1_d1 <= bus2ip_burst_s1;
        end if;
    end process BUS2IP_BURST_EXTEND_PROCESS;

  -----------------------------------------------------------------------------
  -- Start and end of transaction detection
  -----------------------------------------------------------------------------


    opb_xfer_done  <= (last_xferack
                        or sln_retry_s2
                        -- detected master abort (required for some pipe models)
                        or (xfer_abort )
                        -- master abort
                        or (not(opb_select_s0) and (opb_select_s0_d1) ) );

-- Not being used
--    XFER_DONE_REG_I: FDR
--          port map (
--            Q => opb_xfer_done_d1,  --[out]
--            C => bus2ip_clk_i,      --[in]
--            D => opb_xfer_done,     --[in]
--            R => bus2ip_reset_i     --[in]
--          );

    -- New xfer starts when any CS is asserted and on the next clock
    -- after xfer done if select is still asserted, or on the rising edge
    -- of select
    opb_xfer_start <= (or_reduce(bus2ip_cs_hit_s0) and not xfer_abort and --GB
                    (   (opb_select_s0 and last_xferack_d1_s0)

                     or (opb_select_s0 and not(opb_select_s0_d1)) ) );


  ------------------------------------------------------------------------------
  -- ALS: added address counter and BE generator
  -- Generation of address counter and BE generator
  -- When the IPIC pipe stage is included, a registered counter is used. The counter
  -- register acts as the IPIC pipe stage register. The CE
  -- generation logic needs the next address count so that the output CEs are
  -- in alignment with the address
  -- When the IPIC pipe stage is not included, a direct path counter is used.
  -- The next address count is the same as the address count and the output CEs
  -- will align with the address.
  -- Steer address counter generates the addresses on each IP2Bus Ack
  -- for use in generating the byte enables
  ------------------------------------------------------------------------------
  ADDRCNT_BE_GEN: if INCLUDE_ADDR_CNTR  or C_INCLUDE_WR_BUF = 1 generate
    signal byte_xfer        : std_logic;
    signal hw_xfer          : std_logic;
    signal fw_xfer          : std_logic;
    signal addrcntr_en      : std_logic;
    signal steeraddr_cnt_en : std_logic;

    begin

        addrcntr_en         <= IP2Bus_AddrAck
                                and wrbuf_addrcntr_en
                                and bus2ip_burst_s1;

        steeraddr_cnt_en    <= IP2Bus_Ack and bus2ip_burst_s1;

        address_load        <= opb_xfer_start and wrbuf_empty;

        BE_GEN_I: entity opb_v20_v1_10_d.opb_be_gen
            generic map (
                         C_OPB_AWIDTH       => C_OPB_AWIDTH,
                         C_OPB_DWIDTH       => C_OPB_DWIDTH,
                         C_INCLUDE_WR_BUF   => C_INCLUDE_WR_BUF
                         )
            port map (
                        Bus_clk         => bus2ip_clk_i,
                        Address_in      => next_steer_addr_cntr_out,
                        BE_in           => opb_be_s0,
                        Load_BE         => address_load,
                        Rst_BE          => bus2ip_reset_i,
                        BE_out          => opb_be_cntr_out,
                        Byte_xfer       => byte_xfer,
                        Hw_xfer         => hw_xfer,
                        Fw_xfer         => fw_xfer
                      );

        DIRECTPATH_CNTR_GEN: if not(INCLUDE_IPIC_PSTAGE) and C_INCLUDE_WR_BUF=0 generate
        -- since no IPIC pipe stage, use direct path cntr so that there is not
        -- a clock delay for loading the address

            signal addr_cntr_load   : std_logic;
        begin

            addr_cntr_load <= not((or_reduce(bus2ip_cs_hit_s0))) or opb_xfer_done;

            BUS2IPADDR_CNTR_I: entity opb_v20_v1_10_d.brst_addr_cntr
                generic map (
                         C_CNTR_WIDTH   => MAX_USER_ADDR_RANGE,
                         C_OPB_AWIDTH   => C_OPB_AWIDTH,
                         C_OPB_DWIDTH   => C_OPB_DWIDTH )
                port map    (
                        Address_in      => opb_abus_s0,
                        Addr_load       => addr_cntr_load,
                        Addr_CntEn      => addrcntr_en,
                        Byte_xfer       => byte_xfer,
                        Hw_xfer         => hw_xfer,
                        Fw_xfer         => fw_xfer,
                        Address_out     => opb_addr_cntr_out,
                        OPB_Clk         => bus2ip_clk_i);

            -- since directpath cntr, next count value is the same as the count value
            next_opb_addr_cntr_out <= opb_addr_cntr_out;

            STEERADDR_CNTR_I: entity opb_v20_v1_10_d.brst_addr_cntr
                generic map (
                         C_CNTR_WIDTH   => MAX_USER_ADDR_RANGE,
                         C_OPB_AWIDTH   => C_OPB_AWIDTH,
                         C_OPB_DWIDTH   => C_OPB_DWIDTH )
                port map    (
                        Address_in      => opb_abus_s0,
                        Addr_load       => addr_cntr_load,
                        Addr_CntEn      => steeraddr_cnt_en,
                        Byte_xfer       => byte_xfer,
                        Hw_xfer         => hw_xfer,
                        Fw_xfer         => fw_xfer,
                        Address_out     => steer_addr_cntr_out,
                        OPB_Clk         => bus2ip_clk_i);

            -- since directpath cntr, next count value is the same as the count value
            next_steer_addr_cntr_out <= steer_addr_cntr_out;

        end generate DIRECTPATH_CNTR_GEN;

    REG_CNTR_GEN: if INCLUDE_IPIC_PSTAGE or C_INCLUDE_WR_BUF = 1 generate
    -- since IPIC pipe stage, use registered counter. This will act as the pipe stage
    -- for the address. The CEs will use the un-registered counter address so that
    -- they align with the address after going through the pipe stage

            BUS2IPADDR_CNTR_I: entity opb_v20_v1_10_d.brst_addr_cntr_reg
                generic map (
                             C_CNTR_WIDTH       => MAX_USER_ADDR_RANGE,
                             C_OPB_AWIDTH       => C_OPB_AWIDTH,
                             C_OPB_DWIDTH       => C_OPB_DWIDTH)
                port map (
                            Bus_reset           => bus2ip_reset_i,
                            Bus_clk             => bus2ip_clk_i,
                            Xfer_done           => opb_xfer_done,
                            RNW                 => wrbuf_rnw,
                            Addr_Load           => address_load,
                            Addr_Cnt_en         => addrcntr_en,
                            Addr_Cnt_rst        => wrbuf_addrcntr_rst,
                            Address_In          => opb_abus_s0,
                            Byte_xfer           => byte_xfer,
                            Hw_xfer             => hw_xfer,
                            Fw_xfer             => fw_xfer,
                            Next_address_out    => next_opb_addr_cntr_out,
                            Address_Out         => opb_addr_cntr_out
                           );

           STEERADDR_CNTR_I: entity opb_v20_v1_10_d.brst_addr_cntr_reg
                generic map (
                             C_CNTR_WIDTH       => MAX_USER_ADDR_RANGE,
                             C_OPB_AWIDTH       => C_OPB_AWIDTH,
                             C_OPB_DWIDTH       => C_OPB_DWIDTH)
                port map (
                            Bus_reset           => bus2ip_reset_i,
                            Bus_clk             => bus2ip_clk_i,
                            Xfer_done           => opb_xfer_done,
                            RNW                 => wrbuf_rnw,
                            Addr_Load           => address_load,
                            Addr_Cnt_en         => steeraddr_cnt_en,
                            Addr_Cnt_rst        => bus2ip_reset_i,
                            Address_In          => opb_abus_s0,
                            Byte_xfer           => byte_xfer,
                            Hw_xfer             => hw_xfer,
                            Fw_xfer             => fw_xfer,
                            Next_address_out    => next_steer_addr_cntr_out,
                            Address_Out         => steer_addr_cntr_out
                           );

        end generate REG_CNTR_GEN;

  end generate ADDRCNT_BE_GEN;

  NO_ADDRCNT_BE_GEN: if not(INCLUDE_ADDR_CNTR) and C_INCLUDE_WR_BUF = 0 generate
    next_opb_addr_cntr_out  <= opb_abus_s0;
    opb_addr_cntr_out       <= opb_abus_s0;
    next_steer_addr_cntr_out<= opb_abus_s0;
    steer_addr_cntr_out     <= opb_abus_s0;
    opb_be_cntr_out         <= opb_be_s0;
    address_load            <= '1';
  end generate NO_ADDRCNT_BE_GEN;

  -----------------------------------------------------------------------------
  -- Generation of Write Buffer
  -----------------------------------------------------------------------------
  WRITE_BUFFER_GEN: if C_INCLUDE_WR_BUF = 1 generate

  begin

    wrbuf_addrack   <= IP2Bus_AddrAck;
    wrdata_ack      <= '1' when (ipic_xferack='1' and wrbuf_rnw='0')
                        else '0';

    WRITE_BUF: entity opb_v20_v1_10_d.write_buffer
        generic map ( C_INCLUDE_OPBIN_PSTAGE    => INCLUDE_OPBIN_PSTAGE,
                      C_INCLUDE_IPIC_PSTAGE     => INCLUDE_IPIC_PSTAGE,
                      C_INCLUDE_OPBOUT_PSTAGE   => INCLUDE_OPBOUT_PSTAGE,

                      C_OPB_DWIDTH              => C_OPB_DWIDTH,
                      C_WRBUF_DEPTH             => WRBUF_DEPTH,
                      C_NUM_CES                 => NUM_CES,
                      C_NUM_ARDS                => NUM_ARDS
                    )
        port map (
                    Bus_reset               => bus2ip_reset_i,
                    Bus_clk                 => bus2ip_clk_i,
                    Data_in                 => bus2ip_data_s0,
                    CE                      => bus2ip_ce_s0,
                    Wr_CE                   => bus2ip_wrce_s0,
                    Rd_CE                   => bus2ip_rdce_s0,
                    RNW                     => opb_rnw_s0,
                    CS_hit                  => bus2ip_cs_hit_s0,
                    CS                      => bus2ip_cs_s0,
                    CS_enable               => bus2ip_cs_enable_s0,
                    Burst                   => opb_seqaddr_s0,
                    Xfer_start              => opb_xfer_start,
                    Xfer_done               => opb_xfer_done,
                    Addr_ack                => wrbuf_addrack,
                    Wrdata_ack              => wrdata_ack,
                    WrBuf_data              => wrbuf_data,
                    WrBuf_burst             => wrbuf_burst,
                    WrBuf_xferack           => wrbuf_xferack,
                    WrBuf_errack            => wrbuf_errack,
                    WrBuf_retry             => wrbuf_retry,
                    WrBuf_CS                => wrbuf_cs,
                    WrBuf_RNW               => wrbuf_rnw,
                    WrBuf_CE                => wrbuf_ce,
                    WrBuf_WrCE              => wrbuf_wrce,
                    WrBuf_RdCE              => wrbuf_rdce,
                    WrBuf_Empty             => wrbuf_empty,
                    WrBuf_AddrCnt_en        => wrbuf_addrcntr_en,
                    WrBuf_AddrCntr_rst      => wrbuf_addrcntr_rst,
                    WrBuf_AddrValid         => wrbuf_addrvalid,
                    IPIC_Pstage_CE          => ipic_pstage_ce
                 );


    -- inclusion of write buffer requires the BEs to be registered

    BE_REG_PROC : process(bus2ip_clk_i)
    begin
        if bus2ip_clk_i'event and bus2ip_clk_i='1' then
            if bus2ip_reset_i = '1' then
                wrbuf_be    <= (others => '0');
            else
                wrbuf_be    <= opb_be_cntr_steer;
            end if;
        end if;
    end process BE_REG_PROC;



  end generate WRITE_BUFFER_GEN;

  NO_WRITE_BUFFER_GEN: if C_INCLUDE_WR_BUF = 0 generate
  begin
        wrbuf_data          <= bus2ip_data_s0;
        wrbuf_burst         <= opb_seqaddr_s0;
        wrbuf_xferack       <= '0';
        wrbuf_errack        <= '0';
        wrbuf_retry         <= '0';
        wrbuf_cs            <= bus2ip_cs_s0;
        wrbuf_rnw           <= opb_rnw_s0;
        wrbuf_ce            <= bus2ip_ce_s0;
        wrbuf_wrce          <= bus2ip_wrce_s0;
        wrbuf_rdce          <= bus2ip_rdce_s0;
        wrbuf_empty         <= '1';
        wrbuf_addrcntr_en   <= '1';
        wrbuf_addrcntr_rst  <= '0';
        wrbuf_addrvalid     <= or_reduce(bus2ip_ce_s0);
        wrbuf_be            <= opb_be_cntr_steer;
        ipic_pstage_ce      <= '1';
  end generate NO_WRITE_BUFFER_GEN;

  ------------------------------------------------------------------------------
  -- Generation of per-address-range mechanism.
  ------------------------------------------------------------------------------
  PER_AR_GEN: for i in 0 to NUM_ARDS-1 generate
      constant CE_INDEX_START : integer
                                := calc_start_ce_index(C_ARD_NUM_CE_ARRAY,i);
      constant CE_ADDR_SIZE   : Integer range 0 to 15
                                := log2(C_ARD_NUM_CE_ARRAY(i));
      constant OFFSET         : integer
                                := log2(C_ARD_DWIDTH_ARRAY(i)/8);
        -- OFFSET gives the number of address bits corresponding to the
        -- DWIDTH of the address range, e.g. zero for bytes, 1 for
        -- doublets, 2 for quadlets, 3 for octlets, etc.
  begin
      --------------------------------------------------------------------------
      -- CS decoders
      --------------------------------------------------------------------------
      CS_I: entity opb_v20_v1_10_d.pselect
        generic map (
          C_AB     => - K_DEV_ADDR_DECODE_WIDTH
                      + num_decode_bits(C_ARD_ADDR_RANGE_ARRAY,
                                        C_OPB_AWIDTH,
                                        i),
          C_AW     => C_OPB_AWIDTH - K_DEV_ADDR_DECODE_WIDTH,
          C_BAR    => C_ARD_ADDR_RANGE_ARRAY(i*2)
                         (     C_ARD_ADDR_RANGE_ARRAY(0)'length
                             - C_OPB_AWIDTH
                             + K_DEV_ADDR_DECODE_WIDTH
                          to C_ARD_ADDR_RANGE_ARRAY(0)'length-1
                         )
        )
        port map (
--          A        => opb_abus_s0(K_DEV_ADDR_DECODE_WIDTH to C_OPB_AWIDTH-1),
--          AValid   => devicesel_s0, --NEW GB
--          CS       => bus2ip_cs_hit_s0(i)
          A        => opb_abus(K_DEV_ADDR_DECODE_WIDTH to C_OPB_AWIDTH-1),  -- GAB 10/12/05
          AValid   => devicesel,    -- GAB 10/12/05
          CS       => bus2ip_cs_hit(i)      -- GAB 10/12/05
        );
       --
       -- ToDo, pselect above and AND gate below can
       -- be optimized later with a special pselect that
       -- has outputs for both bus2ip_cs_s0 and bus2ip_cs_hit_s0.
       --
-- GB - Removed check of postedwrinh when write buffer is instantiated.  Write buffer
-- logic does not have postedwrinh implemented yet and this was causing a problem
-- with some of the configurations.  When the write buffer is instantiated the
-- postedwrinh signal is ignored.
--      bus2ip_cs_enable_s0(i) <=   not inh_cs_wnot_pw --GB
--
--                                when C_DEV_BURST_ENABLE=0 or
--
--                                    (opb_seqaddr_s0 = '0'and opb_seqaddr_s0_d1 = '0') or
--                                     opb_rnw_s0 = '1'     or
--                                     eff_ip2bus_val(
--                                         i   =>i,
--                                         rst =>reset2bus_postedwrinh,
--                                         intr=>intr2bus_postedwrinh,
--                                         wrfifo=>'0',
--                                         rdfifo=>'0',
--                                         user=> ip2bus_postedwrinh(i)
--                                         --user=>ip2bus_postedwrinh
--                                     )='1'
--                                else
--                                  not inh_cs_when_pw(i);

GEN_CS_ENABLE_NOWRBUF : if C_INCLUDE_WR_BUF = 0 generate --GB
      bus2ip_cs_enable_s0(i) <= not(inh_cs_wnot_pw)

                                when opb_rnw_s0 = '1'
                                  or eff_ip2bus_val(
                                        i       => i,
                                        rst     => reset2bus_postedwrinh,
                                        intr    => intr2bus_postedwrinh,
                                        wrfifo  => '0',
                                        rdfifo  => '0',
--                                        user    => ip2bus_postedwrinh(i)
                                        user    => (ip2bus_postedwrinh_s2_d1(i)
                                                    and bo2sl(INCLUDE_OPBIN_PSTAGE))


                                                or (ip2bus_postedwrinh_s2(i)
                                                    and bo2sl(not INCLUDE_OPBIN_PSTAGE))
                                        )='1'

                                else not(inh_cs_when_pw(i));


end generate GEN_CS_ENABLE_NOWRBUF;

GEN_CS_ENABLE_WRBUF : if C_INCLUDE_WR_BUF = 1 generate --GB
    bus2ip_cs_enable_s0(i) <=   not inh_cs_wnot_pw
                                    when C_DEV_BURST_ENABLE=0
                                    or (opb_seqaddr_s0 = '0'
                                    and opb_seqaddr_s0_d1 = '0')
                                    or opb_rnw_s0 = '1'
                           else not inh_cs_when_pw(i);

end generate GEN_CS_ENABLE_WRBUF;


        bus2ip_cs_s0(i) <=     bus2ip_cs_hit_s0(i) and bus2ip_cs_enable_s0(i);


       -------------------------------------------------------------------------
       -- Now expand the individual CEs for each base address.
       -------------------------------------------------------------------------
        PER_CE_GEN: for j in 0 to C_ARD_NUM_CE_ARRAY(i) - 1 generate
        begin
          ----------------------------------------------------------------------
          -- CE decoders
          ----------------------------------------------------------------------
          MULTIPLE_CES_THIS_CS_GEN : if CE_ADDR_SIZE > 0 generate
              constant BAR :  std_logic_vector(0 to CE_ADDR_SIZE-1)
                           := std_logic_vector(TO_UNSIGNED(j, CE_ADDR_SIZE));
          begin
            CE_I : entity opb_v20_v1_10_d.pselect
            generic map (
              C_AB     => CE_ADDR_SIZE,
              C_AW     => CE_ADDR_SIZE,
              C_BAR    => BAR
            )
            port map (
              A        => next_opb_addr_cntr_out(C_OPB_AWIDTH - OFFSET - CE_ADDR_SIZE to
                                      C_OPB_AWIDTH - OFFSET - 1),
              AValid   => bus2ip_cs_s0(i),
              CS       => bus2ip_ce_s0(CE_INDEX_START+j)
            );
          end generate;
          --
          SINGLE_CE_THIS_CS_GEN : if CE_ADDR_SIZE = 0 generate
            bus2ip_ce_s0(CE_INDEX_START+j) <= bus2ip_cs_s0(i);
          end generate;
          --
          ----------------------------------------------------------------------
          -- RdCE decoders
          ----------------------------------------------------------------------
          bus2ip_rdce_s0(CE_INDEX_START+j) <=
              bus2ip_ce_s0(CE_INDEX_START+j) and opb_rnw_s0;


          ----------------------------------------------------------------------
          -- WrCE decoders
          ----------------------------------------------------------------------
          bus2ip_wrce_s0(CE_INDEX_START+j) <=
              bus2ip_ce_s0(CE_INDEX_START+j) and not opb_rnw_s0;


          ----------------------------------------------------------------------


        end generate PER_CE_GEN;
  end generate PER_AR_GEN;

------------------------------------------------------------------------
-- Master Abort Detection --GB
------------------------------------------------------------------------
-- This process detects when an abort occurs from the master.
-- and is used to gate off sln_xferack and sln_retry from the bus
--
GEN_ABORTS_FOR_1_3_7 : if (INCLUDE_OPBIN_PSTAGE and not (INCLUDE_OPBOUT_PSTAGE))
                       or (INCLUDE_OPBIN_PSTAGE and INCLUDE_IPIC_PSTAGE) generate
        ABORT_DET : process(bus2ip_clk_i)
            begin
                if(bus2ip_clk_i'EVENT and bus2ip_clk_i='1')then
                    if(Reset = '1' or last_xferack_d1 = '1'
                    or or_reduce(bus2ip_cs_hit_s0) = '0' or sln_retry_s2 = '1')then
                        cycle_active <= '0';
                    elsif(or_reduce(bus2ip_cs_hit_s0) = '1' and sln_retry_s2 = '0')then
                        cycle_active <= '1';
                    end if;
                    cycle_abort_d1 <= cycle_abort;
                end if;
            end process ABORT_DET;

        cycle_abort <= '1' when (   cycle_active = '1'
                                and or_reduce(bus2ip_cs_hit_s0) = '0'
                                and last_xferack_d1 = '0')
                  else '0';

        GEN_XFERABORT_FOR_1_3 : if INCLUDE_OPBIN_PSTAGE and not(INCLUDE_OPBOUT_PSTAGE) generate
                xfer_abort <= cycle_abort or cycle_abort_d1;
        end generate;

        GEN_XFERABORT_FOR_REST : if not(INCLUDE_OPBIN_PSTAGE) or INCLUDE_OPBOUT_PSTAGE generate
                xfer_abort <= cycle_abort;
        end generate;
end generate GEN_ABORTS_FOR_1_3_7;

-- Abort logic is not needed for pipeline models 0,2,4,5, and 6
GEN_NOABORTS_FOR_REST : if not(INCLUDE_OPBIN_PSTAGE)
                       or (not(INCLUDE_IPIC_PSTAGE) and INCLUDE_OPBOUT_PSTAGE) generate
begin
    xfer_abort  <= '0';
    cycle_abort <= '0';
end generate GEN_NOABORTS_FOR_REST;


  ------------------------------------------------------------------------------
  -- This process selects the set of CS signals that activate a given bit of the
  -- encoded size.
  ------------------------------------------------------------------------------
  ENCODE_SIZE_BIT_SEL_PROC : process (bus2ip_cs_s0)
      type NAT_ARRAY_TYPE is array(natural range <>) of natural;
      variable next_bit : NAT_ARRAY_TYPE(0 to 2);
  begin
     next_bit := (others => 0);
     for i in 0 to NUM_ARDS-1 loop
         for j in 0 to NUM_ENCODED_SIZE_BITS-1 loop
             if encoded_size_is_1(i,j) then
                 cs_to_or_for_dsize_bit(j)(next_bit(j)) <= bus2ip_cs_s0(i);
                 next_bit(j) := next_bit(j)+1;
             end if;
         end loop;
     end loop;
  end process;


  ------------------------------------------------------------------------------
  -- This generates the encoded data size as a function of the address range
  -- being addressed.
  ------------------------------------------------------------------------------
  ENCODED_SIZE_CS_OR_GEN : for i in 0 to NUM_ENCODED_SIZE_BITS-1 generate
  begin
    ----------------------------------------------------------------------------
    -- If no address range requires the bit high, then fix it low.
    ----------------------------------------------------------------------------
    ALWAYS_LOW_GEN : if num_cs_for_bit(i) = 0 generate
        encoded_dsize_s0(i) <= '0';
    end generate;

    ----------------------------------------------------------------------------
    -- If all address ranges require the bit high, then fix it high.
    ----------------------------------------------------------------------------
    ALWAYS_HIGH_GEN: if num_cs_for_bit(i) = NUM_ARDS generate
        encoded_dsize_s0(i) <= '1';
    end generate;

    ----------------------------------------------------------------------------
    -- If some address ranges require the bit high, and other address ranges
    -- require it low, then OR together the CS signals for the address ranges
    -- that require it high.
    ----------------------------------------------------------------------------
    SOMETIMES_HIGH_GEN: if  num_cs_for_bit(i) /= 0
                        and num_cs_for_bit(i) /= NUM_ARDS generate

        -- instance of carry-chain OR for each bit
        ENCODED_SIZE_OR : entity opb_v20_v1_10_d.or_muxcy
            generic map (
                C_NUM_BITS => num_cs_for_bit(i)
            )
            port map (
                In_bus => cs_to_or_for_dsize_bit(i)(0 to num_cs_for_bit(i)-1),
                Or_out => encoded_dsize_s0(i)
            );
        end generate;
    end generate;


    ------------------------------------------------------------------------------
    -- Steer write data from appropriate data lanes if C_ARD_DWIDTH_ARRAY has
    -- mixed width values.
    -- this steering module is used to steer the write data and BEs before the
    -- write buffer
    ------------------------------------------------------------------------------
    I_STEER_DATA : entity opb_v20_v1_10_d.IPIF_Steer
        generic map(
            C_DWIDTH    => C_OPB_DWIDTH,
            C_SMALLEST  => get_min_dwidth(C_ARD_DWIDTH_ARRAY),
            C_AWIDTH    => C_OPB_AWIDTH
        )
        port map (
            Wr_Data_In  => opb_dbus_s0,
            Addr        => opb_abus_s0,
            BE_In       => opb_be_s0,
            Decode_size => encoded_dsize_s0,
            Wr_Data_Out => bus2ip_data_s0,
            BE_Out      => open,
            --
            -- Rd mirroring tied off, see I_MIRROR
            Rd_Data_In  => ZSLV(0 to C_OPB_DWIDTH-1),
            Rd_Data_Out => open
        );


    ------------------------------------------------------------------------------
    -- Steer byte enables from appropriate data lanes if C_ARD_DWIDTH_ARRAY has
    -- mixed width values.
    -- this steering module is used to steer the byte enables output from
    -- the address counter/be generator during reads
    ------------------------------------------------------------------------------
    I_STEER_BE : entity opb_v20_v1_10_d.IPIF_Steer
        generic map(
            C_DWIDTH    => C_OPB_DWIDTH,
            C_SMALLEST  => get_min_dwidth(C_ARD_DWIDTH_ARRAY),
            C_AWIDTH    => C_OPB_AWIDTH
        )
        port map (
            Wr_Data_In  => ZSLV(0 to C_OPB_DWIDTH-1),
            Addr        => next_steer_addr_cntr_out,
            BE_In       => opb_be_cntr_out,
            Decode_size => encoded_dsize_s0,
            Wr_Data_Out => open,
            BE_Out      => opb_be_cntr_steer,
            --
            -- Rd mirroring tied off, see I_MIRROR
            Rd_Data_In  => ZSLV(0 to C_OPB_DWIDTH-1),
            Rd_Data_Out => open
        );

    ------------------------------------------------------------------------------
    -- Mirror read data to appropriate data lanes if C_ARD_DWIDTH_ARRAY has
    -- mixed width values.
    ------------------------------------------------------------------------------
    I_MIRROR : entity opb_v20_v1_10_d.IPIF_Steer
        generic map(
            C_DWIDTH    => C_OPB_DWIDTH,
            C_SMALLEST  => get_min_dwidth(C_ARD_DWIDTH_ARRAY),
            C_AWIDTH    => C_OPB_AWIDTH
        )
        port map (
            Rd_Data_In  => ip2bus_data_mx,
            Decode_size => encoded_dsize_s1,
            --Addr         => bus2ip_addr_s1,
            Addr        => steer_addr_cntr_out,
            Rd_Data_Out => sln_dbus_s1,
            --
            -- Wr steering tied off, see I_STEER
            Wr_Data_In  => ZSLV(0 to C_OPB_DWIDTH-1),
            BE_In       => ZSLV(0 to C_OPB_DWIDTH/8-1),
            Wr_Data_Out => open,
            BE_Out      => open
        );

-- Generate for pipeline model 0, 2, 4, 6
IP2BUS_XFERACK_0_2_GEN : if not(INCLUDE_OPBIN_PSTAGE) generate
    ------------------------------------------------------------------------------
    -- For inhibiting of posted writes IP2Bus_Ack needs to be gated off for 1
    -- clocks during dynamic changes in the ip2bus_postedwrinh signal.  During
    -- reads and when the write buffer is instantiated simply pass IP2Bus_Ack
    -- without gating it off.
    ------------------------------------------------------------------------------
    -- GB
    IP2BUS_XFERACK_PROC : process(bus2ip_cs_s1,IP2Bus_Ack,opb_rnw_s0,
                                  ip2bus_postedwrinh_s2_d1)
        variable r : std_logic;
        begin
            r := '0';
            for i in bus2ip_cs_s1'range loop
                r := r or (IP2Bus_Ack and bus2ip_cs_s1(i)
                            and
                            (      (ip2bus_postedwrinh_s2_d1(i) and not(opb_rnw_s0))
                                or (opb_rnw_s0)
                                or (bo2sl(C_INCLUDE_WR_BUF=1))
                            ));
            end loop;
            ip2bus_xferack <= r;
        end process IP2BUS_XFERACK_PROC;

end generate;

-- Generate for pipeline model 1,3,5,and 7
IP2BUS_XFERACK_REST_GEN : if INCLUDE_OPBIN_PSTAGE generate
    ------------------------------------------------------------------------------
    -- For inhibiting of posted writes IP2Bus_Ack needs to be gated off for 2
    -- clocks during dynamic changes in the ip2bus_postedwrinh signal.  During
    -- reads and when the write buffer is instantiated simply pass IP2Bus_Ack
    -- without gating it off.
    ------------------------------------------------------------------------------
    -- GB
    IP2BUS_XFERACK_PROC : process(bus2ip_cs_s1,IP2Bus_Ack,opb_rnw_s0,
                                  ip2bus_postedwrinh_s2_d2)
        variable r : std_logic;
        begin
            r := '0';
            for i in bus2ip_cs_s1'range loop
                r := r or (IP2Bus_Ack and bus2ip_cs_s1(i)
                            and
                            (      (ip2bus_postedwrinh_s2_d2(i) and not(opb_rnw_s0))
                                or (opb_rnw_s0)
                                or (bo2sl(C_INCLUDE_WR_BUF=1))
                            ));
            end loop;
            ip2bus_xferack <= r;
        end process IP2BUS_XFERACK_PROC;

end generate;




  ------------------------------------------------------------------------------
  -- Generation of sln_xferack.
  -- ALS - modified to include read and write FIFOs
  -- ALS - modified to include write buffer
  ------------------------------------------------------------------------------
  IPIC_XFERACK_PROC : process (bus2ip_cs_s1, bus2ip_cs_hit_s0,
                              opb_rnw_s0, ip2bus_xferack,
                              reset2bus_ack, intr2bus_ack,
                              reset2bus_postedwrinh, intr2bus_postedwrinh,
                              wrfifo_ack, rdfifo_ack,ip2bus_postedwrinh_s2_d2,
                              IP2Bus_PostedWrInh) is
  variable r : std_logic;
  begin

        r := '0';
        for i in bus2ip_cs_s1'range loop


            if (

-- GB - Removed check of postedwrinh when write buffer is instantiated.  Write buffer
-- logic does not have postedwrinh implemented yet and this was causing a problem
-- with some of the configurations.  When the write buffer is instantiated the
-- postedwrinh signal is ignored.
            (bo2sl(C_INCLUDE_WR_BUF=0)
             and eff_ip2bus_val(i      => i,
                                rst    => reset2bus_postedwrinh,
                                intr   => intr2bus_postedwrinh,
                                wrfifo => '0',
                                rdfifo => '0',
                                user   => IP2Bus_PostedWrInh(i))
            )

            or opb_rnw_s0
            or bo2sl(C_INCLUDE_WR_BUF=1)) = '1' then
                -- This is the case where transactions are reads, or writes
                -- that are not posted or write buffer is included
                r := r or (bus2ip_cs_s1(i)

                        and eff_ip2bus_val(i        => i,
                                           rst      => reset2bus_ack,
                                           intr     => intr2bus_ack,
                                           wrfifo   => wrfifo_ack,
                                           rdfifo   => rdfifo_ack,
                                           user     => ip2bus_xferack --GB
                                           ));
        else
            -- posted writes, but no write buffer is included
            r := r or bus2ip_cs_hit_s0(i);
        end if;
    end loop;
    ipic_xferack <= r ;
  end process ;

  SLN_XFERACK_PROC : process (ipic_xferack, wrbuf_xferack, bus2ip_rnw_s1,
                             inh_xferack_when_pw , inh_xferack_when_burst_rd ) is
  begin

    if bus2ip_rnw_s1 = '0' then
        if C_INCLUDE_WR_BUF = 1 then
             sln_xferack_s1 <= wrbuf_xferack and not(inh_xferack_when_pw);
        else
             sln_xferack_s1 <= ipic_xferack and not (inh_xferack_when_pw);
        end if;
    else
        sln_xferack_s1 <= ipic_xferack and not (inh_xferack_when_burst_rd);
    end if;

  end process SLN_XFERACK_PROC;

  ------------------------------------------------------------------------------
  -- Generation of sln_retry.
  -- ALS - modified to include read and write FIFOs
  -- ALS - modified to include write buffer
  ------------------------------------------------------------------------------
  SLN_RETRY_PROC : process (bus2ip_cs_s1, IP2Bus_Retry, reset2bus_retry,
                            intr2bus_retry,rfifo_retry, wfifo_retry,
                            wrbuf_retry, bus2ip_rnw_s1) is
    variable r : std_logic;
    variable ip2bus_retry_help : std_logic;
  begin
    if C_INCLUDE_WR_BUF = 1 and bus2ip_rnw_s1 = '0' then
        -- write buffer generates Retry during write transfers
        sln_retry_s1 <= wrbuf_retry;
    else
        r := '0';
        for i in bus2ip_cs_s1'range loop
          if    INCLUDE_RESET_MIR and (i = RESET_MIR_CS_IDX) then
              ip2bus_retry_help := reset2bus_retry;
          elsif INCLUDE_INTR      and (i = INTR_CS_IDX) then
              ip2bus_retry_help := intr2bus_retry;
          elsif INCLUDE_RDFIFO    and ((i = RDFIFO_DATA_CS_IDX) or (i = RDFIFO_REG_CS_IDX)) then
              ip2bus_retry_help := rfifo_retry;
          elsif INCLUDE_WRFIFO    and ((i = WRFIFO_DATA_CS_IDX) or (i = WRFIFO_REG_CS_IDX)) then
              ip2bus_retry_help := wfifo_retry;
          else
              ip2bus_retry_help := IP2Bus_Retry;
          end if;
          r :=  r or (bus2ip_cs_s1(i) and ip2bus_retry_help);
        end loop;
        sln_retry_s1 <= r;
    end if;
  end process;

  ------------------------------------------------------------------------------
  -- Generation of sln_error.
  -- ALS - modified to include read and write FIFOs
  -- ALS - modified to include write buffer
  ------------------------------------------------------------------------------
  SLN_ERRACK_PROC : process (bus2ip_cs_s1, IP2Bus_Error, reset2bus_error,
                             intr2bus_error, rfifo_error, wfifo_error,
                             wrbuf_errack, bus2ip_rnw_s1) is
    variable r : std_logic;
    variable ip2bus_error_help : std_logic;
  begin
    if C_INCLUDE_WR_BUF = 1 and bus2ip_rnw_s1 = '0' then
        -- write buffer generates ErrAck during write transfers
        sln_errack_s1 <= wrbuf_errack;
    else
        r := '0';
        for i in bus2ip_cs_s1'range loop
          if    INCLUDE_RESET_MIR and (i = RESET_MIR_CS_IDX) then
              ip2bus_error_help := reset2bus_error;
          elsif INCLUDE_INTR      and (i = INTR_CS_IDX) then
              ip2bus_error_help := intr2bus_error;
          elsif INCLUDE_RDFIFO    and ((i = RDFIFO_DATA_CS_IDX) or (i = RDFIFO_REG_CS_IDX)) then
              ip2bus_error_help := rfifo_error;
          elsif INCLUDE_WRFIFO    and ((i = WRFIFO_DATA_CS_IDX) or (i = WRFIFO_REG_CS_IDX)) then
              ip2bus_error_help := wfifo_error;
          else
              ip2bus_error_help := IP2Bus_Error;
          end if;
          r :=  r or (bus2ip_cs_s1(i) and ip2bus_error_help);
        end loop;
        sln_errack_s1 <= r;
    end if;
  end process;

  ------------------------------------------------------------------------------
  -- Generation of sln_toutsup.
  -- ALS - modified to include read and write FIFOs
  ------------------------------------------------------------------------------
  SLN_TOUTSUP_PROC : process (bus2ip_cs_s1, IP2Bus_ToutSup, reset2bus_toutsup,
                              intr2bus_toutsup, rfifo_toutsup, wfifo_toutsup) is
    variable r : std_logic;
    variable ip2bus_toutsup_help : std_logic;
  begin
    r := '0';
    for i in bus2ip_cs_s1'range loop
      if    INCLUDE_RESET_MIR and (i = RESET_MIR_CS_IDX) then
          ip2bus_toutsup_help := reset2bus_toutsup;
      elsif INCLUDE_INTR      and (i = INTR_CS_IDX) then
          ip2bus_toutsup_help := intr2bus_toutsup;
      elsif INCLUDE_RDFIFO    and ((i = RDFIFO_DATA_CS_IDX) or (i = RDFIFO_REG_CS_IDX)) then
          ip2bus_toutsup_help := rfifo_toutsup;
      elsif INCLUDE_WRFIFO    and ((i = WRFIFO_DATA_CS_IDX) or (i = WRFIFO_REG_CS_IDX)) then
          ip2bus_toutsup_help := wfifo_toutsup;
      else
          ip2bus_toutsup_help := IP2Bus_ToutSup;
      end if;
      r :=  r or (bus2ip_cs_s1(i) and ip2bus_toutsup_help);
    end loop;
    sln_toutsup_s1 <= r;
  end process;

  ------------------------------------------------------------------------------
  -- Generation of ip2bus_data_mx, as a function of IP2Bus_Data
  -- and bus2ip_rdce, using carry chain logic.
  -- Note, internal address ranges such as RESET_MIR or Interrupt Source
  -- controller are multiplexed into the appropriate "slot".
  ------------------------------------------------------------------------------
--  READMUX_GEN : if not SINGLE_CE  generate
--  begin
--   READMUX_PROCESS: process(bus2ip_rdce_s1,
--                            reset2bus_data,
--                            intr2bus_data,
--                            rdfifo2bus_data,
--                            wrfifo2bus_data,
--                            ip2bus_data)
--   begin
--        ip2bus_data_mx <= (others => '0');
--        for i in bus2ip_cs_s1'range loop
--            if bus2ip_cs_s1(i) = '1' then
--                if    INCLUDE_RESET_MIR and (i = RESET_MIR_CS_IDX) then
--                    ip2bus_data_mx <= reset2bus_data;
--                elsif INCLUDE_INTR      and (i = INTR_CS_IDX) then
--                    ip2bus_data_mx <= intr2bus_data;
--                elsif INCLUDE_RDFIFO    and ((i = RDFIFO_DATA_CS_IDX)
--                or (i = RDFIFO_REG_CS_IDX)) then
--                    ip2bus_data_mx <= rdfifo2bus_data;
--                elsif INCLUDE_WRFIFO    and ((i = WRFIFO_DATA_CS_IDX)
--                or (i = WRFIFO_REG_CS_IDX)) then
--                    ip2bus_data_mx <= wrfifo2bus_data;
--                else
--                    ip2bus_data_mx <= ip2bus_data;
--                end if;
--           end if;
--       end loop;
--   end process READMUX_PROCESS;
--  end generate;

  READMUX_GEN : if not SINGLE_CE  generate
  begin
   READMUX_PROCESS: process(reset2bus_data,
                            intr2bus_data,
                            rdfifo2bus_data,
                            wrfifo2bus_data,
                            ip2bus_data)
   begin
        for i in ip2bus_data_mx'range loop
            ip2bus_data_mx(i) <= reset2bus_data(i)
                              or intr2bus_data(i)
                              or rdfifo2bus_data(i)
                              or wrfifo2bus_data(i)
                              or ip2bus_data(i);
       end loop;
   end process READMUX_PROCESS;
  end generate;




  READMUX_SINGLE_CE_GEN : if SINGLE_CE generate
  begin
      ip2bus_data_mx <= ip2bus_data;
  end generate;

--     PER_BIT_GEN : for i in 0 to C_OPB_DWIDTH-1 generate
--       signal cry : std_logic_vector(0 to (Bus2IP_RdCE'length + 1)/2);
--     begin
--       cry(0) <= '0';
--       PER_CE_PAIR_GEN : for j in 0 to (Bus2IP_RdCE'length + 1)/2-1 generate
--         signal ip2bus_data_rmmx0   : std_logic;
--         signal ip2bus_data_rmmx1   : std_logic;
--         signal lut_out             : std_logic;
--         constant nopad             : boolean
--                                    := (j /= (Bus2IP_RdCE'length + 1)/2-1)
--                                    or (Bus2IP_RdCE'length mod 2 = 0);
--       begin
--         -----------------------------------------------------------------------
--         -- ToDo, the read-back mux can be optimized to exclude any data bits
--         -- that are not present in AR with DWIDTH less than C_OPB_DWIDTH...
--         -- possibly also for bits that are known to be not implemented, e.g.
--         -- a register that doesn't use all bit positions or is write-only.
--         -----------------------------------------------------------------------
--         -- LUT  (last LUT may multiplex one data bit instead of two)
--         -----------------------------------------------------------------------
----       WOPAD : if nopad generate
----           signal ip2bus_data_rmmx0 : std_logic_vector(0 to C_OPB_DWIDTH-1);
----           signal ip2bus_data_rmmx1 : std_logic_vector(0 to C_OPB_DWIDTH-1);
----       begin
--         -------------------------------------------------------------------
--         -- Always include the first of two possilble mux channels thru LUT.
--         -------------------------------------------------------------------
--             ip2bus_data_rmmx0 <=
--                                  ----------------------------------------------
--                                  -- RESET_MIR
--                                  ----------------------------------------------
--                                  reset2bus_data(i)
--                                  when INCLUDE_RESET_MIR and
--                                       (2*j   = RESET_MIR_CE_IDX)
--                                  else
--                                  ----------------------------------------------
--                                  -- INTR -- ToDo, this is inefficient because
--                                  --         interrupt_control already multiplexes
--                                  --         the data. Optimize later.
--                                  ----------------------------------------------
--                                  intr2bus_data(i)
--                                  when INCLUDE_INTR and
--                                       (2*j   >= INTR_CE_LO) and
--                                       (2*j   <= INTR_CE_HI)
--                                  else
--                                  ----------------------------------------------
--                                  -- Read FIFO
--                                  ----------------------------------------------
--                                  rdfifo2bus_data(i)
--                                  when INCLUDE_RDFIFO and (
--                                       ((2*j >= RFIFO_REG_CE_LO) and (2*j <= RFIFO_REG_CE_HI))
--                                       or
--                                       (2*j = RFIFO_DATA_CE) )
--                                  else
--                                  ----------------------------------------------
--                                  -- Write FIFO
--                                  ----------------------------------------------
--                                  wrfifo2bus_data(i)
--                                  when INCLUDE_WRFIFO and (
--                                       ((2*j >= WFIFO_REG_CE_LO) and (2*j <= WFIFO_REG_CE_HI))
--                                       or
--                                       (2*j = WFIFO_DATA_CE) )
--                                  else
--                                  ----------------------------------------------
--                                  -- IP Core
--                                  ----------------------------------------------
--                                  --IP2Bus_Data((2*j  )*C_OPB_DWIDTH + i);
--                                  IP2Bus_Data(i);
--         -------------------------------------------------------------------
--         -- Don't include second channel when odd number and on last LUT.
--         -------------------------------------------------------------------
--         WOPAD : if nopad generate
--         begin
--             ip2bus_data_rmmx1 <=
--                                  ----------------------------------------------
--                                  -- RESET_MIR
--                                  ----------------------------------------------
--                                  reset2bus_data(i)
--                                  when INCLUDE_RESET_MIR and
--                                       (2*j+1 = RESET_MIR_CE_IDX)
--                                  else
--                                  ----------------------------------------------
--                                  -- INTR
--                                  ----------------------------------------------
--                                  intr2bus_data(i)
--                                  when INCLUDE_INTR and
--                                       (2*j+1 >= INTR_CE_LO) and
--                                       (2*j+1 <= INTR_CE_HI)
--                                  else
--                                  ----------------------------------------------
--                                  -- Read FIFO
--                                  ----------------------------------------------
--                                  rdfifo2bus_data(i)
--                                  when INCLUDE_RDFIFO and (
--                                       ((2*j+1 >= RFIFO_REG_CE_LO) and (2*j+1 <= RFIFO_REG_CE_HI))
--                                       or
--                                       (2*j+1 = RFIFO_DATA_CE) )
--                                  else
--                                  ----------------------------------------------
--                                  -- Write FIFO
--                                  ----------------------------------------------
--                                  wrfifo2bus_data(i)
--                                  when INCLUDE_WRFIFO and (
--                                       ((2*j+1 >= WFIFO_REG_CE_LO) and (2*j+1 <= WFIFO_REG_CE_HI))
--                                       or
--                                       (2*j+1 = WFIFO_DATA_CE) )
--                                  else
--                                  ----------------------------------------------
--                                  -- IP Core
--                                  ----------------------------------------------
--                                  --IP2Bus_Data((2*j+1)*C_OPB_DWIDTH + i);
--                                  IP2Bus_Data(i);
--             --lut_out <= not (
--             --    (ip2bus_data_rmmx0(i) and bus2ip_rdce_s1(2*j  )) or
--             --    (ip2bus_data_rmmx1(i) and bus2ip_rdce_s1(2*j+1)));
--             lut_out <= not (
--                 (ip2bus_data_rmmx0 and bus2ip_rdce_s1(2*j  )) or
--                 (ip2bus_data_rmmx1 and bus2ip_rdce_s1(2*j+1)));
--         end generate;
--         WIPAD : if not nopad generate
--             lut_out <= not (
--                 (ip2bus_data_rmmx0 and bus2ip_rdce_s1(2*j  )));
--         end generate;
--         -----------------------------------------------------------------------
--         -- MUXCY
--         -----------------------------------------------------------------------
--         I_MUXCY : MUXCY
--             port map (
--               O  => cry(j+1),
--               CI => cry(j),
--               DI => '1',
--               S  => lut_out
--             );
--       end generate;
--       ip2bus_data_mx(i) <= cry((Bus2IP_RdCE'length + 1)/2);
--  end generate;
--  end generate;
  --
  --
--  READMUX_SINGLE_CE_GEN : if SINGLE_CE  and INCLUDE_OPBOUT_PSTAGE generate
--  begin
--      ip2bus_data_mx <= ip2bus_data;
--  end generate;

-------------------------------------------------------------------------------
-- Reset/MIR
-------------------------------------------------------------------------------
  INCLUDE_RESET_MIR_GEN : if INCLUDE_RESET_MIR generate
  begin
      RESET_MIR_I0 : entity opb_v20_v1_10_d.reset_mir
      Generic map (
        C_DWIDTH               => C_OPB_DWIDTH,
        C_INCLUDE_SW_RST       => 1,
        C_INCLUDE_MIR          => C_DEV_MIR_ENABLE,
        C_MIR_MAJOR_VERSION    => MIR_MAJOR_VERSION,
        C_MIR_MINOR_VERSION    => MIR_MINOR_VERSION,
        C_MIR_REVISION         => MIR_REVISION,
        C_MIR_BLK_ID           => C_DEV_BLK_ID,
        C_MIR_TYPE             => MIR_TYPE
      )
      port map (
        Reset                  => Reset,
        Bus2IP_Clk             => bus2ip_clk_i,
        SW_Reset_WrCE          => bus2ip_wrce_s1(RESET_MIR_CE_IDX),
        SW_Reset_RdCE          => bus2ip_rdce_s1(RESET_MIR_CE_IDX),
        Bus2IP_Data            => bus2ip_data_s1,
        Bus2IP_Reset           => bus2ip_reset_i,
        Reset2Bus_Data         => reset2bus_data,
        Reset2Bus_Ack          => reset2bus_ack,
        Reset2Bus_Error        => reset2bus_error,
        Reset2Bus_Retry        => reset2bus_retry,
        Reset2Bus_ToutSup      => reset2bus_toutsup
      );
  end generate;

  EXCLUDE_RESET_MIR_GEN : if not INCLUDE_RESET_MIR generate
  begin
      bus2ip_reset_i    <= Reset;
      reset2bus_data    <= (others => '0');
      reset2bus_ack     <= '0';
      reset2bus_error   <= '0';
      reset2bus_retry   <= '0';
      reset2bus_toutsup <= '0';
  end generate;

  Bus2IP_Reset <= bus2ip_reset_i;

-------------------------------------------------------------------------------
-- Interrupts
-- ALS - added interrupts from Read and Write FIFOs
-- ALS - added code to allow C_INCLUDE_DEV_ISC and C_INCLUDE_DEV_PENCODER to
--       come from dependent props array
-------------------------------------------------------------------------------
  INTR_CTRLR_GEN : if INCLUDE_INTR generate
      constant NUM_IPIF_IRPT_SRC : natural := 4;
      constant INTR_INDEX        : integer :=
                                    get_id_index(C_ARD_ID_ARRAY, IPIF_INTR);
      signal errack_reserved: std_logic_vector(0 to 1);
      signal ipif_lvl_interrupts : std_logic_vector( 0 to NUM_IPIF_IRPT_SRC-1);
  begin
    errack_reserved <= Sln_errack_s2 & '0';


    ipif_lvl_interrupts(0) <= '0';  -- assign to DMA2Intr_Intr(0) when DMA is added
    ipif_lvl_interrupts(1) <= '0';  -- assign to DMA2Intr_Intr(1) when DMA is added
    ipif_lvl_interrupts(2) <= rdfifo2intr_deadlock; -- = '0' if FIFOs not included
    ipif_lvl_interrupts(3) <= wrfifo2intr_deadlock; -- = '0' if FIFOs not included


    INTERRUPT_CONTROL_I : entity opb_v20_v1_10_d.interrupt_control
    generic map (
      C_INTERRUPT_REG_NUM    => number_CEs_for(IPIF_INTR),
      C_NUM_IPIF_IRPT_SRC    => NUM_IPIF_IRPT_SRC,
      C_IP_INTR_MODE_ARRAY   => C_IP_INTR_MODE_ARRAY,
      C_INCLUDE_DEV_PENCODER => C_ARD_DEPENDENT_PROPS_ARRAY
                                        (INTR_INDEX)(INCLUDE_DEV_PENCODER)=1,
      C_INCLUDE_DEV_ISC      => C_ARD_DEPENDENT_PROPS_ARRAY
                                        (INTR_INDEX)(EXCLUDE_DEV_ISC)=0,
      C_IRPT_DBUS_WIDTH      => C_OPB_DWIDTH
    )
    port map (
      Bus2IP_Clk_i        =>  bus2ip_clk_i,
      Bus2IP_Data_sa      =>  bus2ip_data_s1,
      Bus2IP_RdReq_sa     =>  '0',
      Bus2IP_Reset_i      =>  bus2ip_reset_i,
      Bus2IP_WrReq_sa     =>  '0',
      Interrupt_RdCE      =>  bus2ip_rdce_s1(INTR_CE_LO to INTR_CE_HI),
      Interrupt_WrCE      =>  bus2ip_wrce_s1(INTR_CE_LO to INTR_CE_HI),
      IPIF_Reg_Interrupts =>  errack_reserved,
      -- ALS - modified to connect read and write FIFO interrupts
      --IPIF_Lvl_Interrupts =>  ZERO_SLV(0 to NUM_IPIF_IRPT_SRC-1),
      IPIF_Lvl_Interrupts =>  ipif_lvl_interrupts,
      IP2Bus_IntrEvent    =>  IP2Bus_IntrEvent,
      Intr2Bus_DevIntr    =>  IP2INTC_Irpt,
      Intr2Bus_DBus       =>  intr2bus_data,
      Intr2Bus_WrAck      =>  intr2bus_wrack,
      Intr2Bus_RdAck      =>  intr2bus_rdack,
      Intr2Bus_Error      =>  intr2bus_error,   -- These are tied low in block
      Intr2Bus_Retry      =>  intr2bus_retry,   --
      Intr2Bus_ToutSup    =>  intr2bus_toutsup  --
    );
  end generate;

  REMOVE_INTERRUPT : if (not INCLUDE_INTR) generate

      intr2bus_data     <=  (others => '0');
      IP2INTC_Irpt      <=  '0';
      intr2bus_error    <=  '0';
      intr2bus_rdack    <=  '0';
      intr2bus_retry    <=  '0';
      intr2bus_toutsup  <=  '0';
      intr2bus_wrack    <=  '0';

 end generate REMOVE_INTERRUPT;

  intr2bus_ack <= intr2bus_rdack or intr2bus_wrack;


-------------------------------------------------------------------------------
-- RDREQ_WRREQ Generation if FIFOs are included
-------------------------------------------------------------------------------
NO_RDREQ_WRREQ_GEN: if not(INCLUDE_RDFIFO) and not(INCLUDE_WRFIFO) generate
    bus2ip_rdreq_s0 <= '0';
    bus2ip_wrreq_s0 <= '0';
end generate NO_RDREQ_WRREQ_GEN;

GEN_RDREQ_WREQ: if ((INCLUDE_RDFIFO) or (INCLUDE_WRFIFO)) generate
  -- only 4 possible CS for FIFOs, size vector accordingly
    signal fifo_cs          : std_logic_vector(0 to 3);
    signal any_fifo_cs      : std_logic;
begin
-----------------------------------------------------------------------------
-- ALS - added process to generate read and write request
-- Generation of Bus2IP_RdReq and Bus2IP_WrReq stage 0 signals
-- These stage 0 signals will follow the pipeline models and generate statements
-- so that the appropriate stage 1 signal is created.
--
-- MODIFIED: 01/24/04 to be for any CS, not just FIFO CS - also
-- these signals will be qualified with ADDR
-- These signals assert for any FIFO CS. They are 1-clock pulse wide for single
-- transfers and stay asserted for burst transfers.
-----------------------------------------------------------------------------

GEN_PFIFOS_NO_WRBUF : if C_INCLUDE_WR_BUF = 0 generate
    BOTHFIFOS_GEN: if INCLUDE_RDFIFO and INCLUDE_WRFIFO generate
      fifo_cs <= bus2ip_cs_s0(RDFIFO_REG_CS_IDX) & bus2ip_cs_s0(RDFIFO_DATA_CS_IDX)
                 & bus2ip_cs_s0(WRFIFO_REG_CS_IDX) & bus2ip_cs_s0(WRFIFO_DATA_CS_IDX);
    end generate BOTHFIFOS_GEN;

    ONLY_RDFIFO_GEN: if INCLUDE_RDFIFO and not(INCLUDE_WRFIFO) generate
      fifo_cs <= bus2ip_cs_s0(RDFIFO_REG_CS_IDX) & bus2ip_cs_s0(RDFIFO_DATA_CS_IDX)
                  & "00";
    end generate ONLY_RDFIFO_GEN;

    ONLY_WRFIFO_GEN: if INCLUDE_WRFIFO and not(INCLUDE_RDFIFO) generate
      fifo_cs <= bus2ip_cs_s0(WRFIFO_REG_CS_IDX) & bus2ip_cs_s0(WRFIFO_DATA_CS_IDX)
                  & "00";
    end generate ONLY_WRFIFO_GEN;
end generate;

GEN_PFIFOS_WITH_WRBUF : if C_INCLUDE_WR_BUF = 1 generate
    BOTHFIFOS_GEN: if INCLUDE_RDFIFO and INCLUDE_WRFIFO generate
      fifo_cs <= bus2ip_cs_s1(RDFIFO_REG_CS_IDX) & bus2ip_cs_s1(RDFIFO_DATA_CS_IDX)
                 & bus2ip_cs_s1(WRFIFO_REG_CS_IDX) & bus2ip_cs_s1(WRFIFO_DATA_CS_IDX);
    end generate BOTHFIFOS_GEN;

    ONLY_RDFIFO_GEN: if INCLUDE_RDFIFO and not(INCLUDE_WRFIFO) generate
      fifo_cs <= bus2ip_cs_s1(RDFIFO_REG_CS_IDX) & bus2ip_cs_s1(RDFIFO_DATA_CS_IDX)
                  & "00";
    end generate ONLY_RDFIFO_GEN;

    ONLY_WRFIFO_GEN: if INCLUDE_WRFIFO and not(INCLUDE_RDFIFO) generate
      fifo_cs <= bus2ip_cs_s1(WRFIFO_REG_CS_IDX) & bus2ip_cs_s1(WRFIFO_DATA_CS_IDX)
                  & "00";
    end generate ONLY_WRFIFO_GEN;
end generate;



-- ToDo: see if LUT OR would be better here since max of 4 bits
ANYCS_OR_I: entity opb_v20_v1_10_d.or_muxcy
    generic map (
      C_NUM_BITS => 4
    )
    port map (
      In_bus => fifo_cs,
      Or_out => any_fifo_cs
    );

-------------------------------------------------------------------------------
-- RDREQ_WRREQ Generation
-------------------------------------------------------------------------------
  -- read request
  rdreq  <= '1'
             when any_fifo_cs = '1' and opb_rnw_s0 = '1' and rdreq_hold = '0'
             else '0';

  -- hold the value of rdreq by setting a flop when rdreq asserts
  -- this is used to gate off rdreq to keep it a one-clock pulse
  rdreq_hold_rst <= (not(sln_xferack_s1) and (sln_xferack_s1_d1))
                    or sln_retry_s1
                    or not(opb_select_s0);
  RDREQ_HOLD_FF: FDRE
  port map (
    Q => rdreq_hold,    --[out]
    C => bus2ip_clk_i,  --[in]
    CE=> rdreq,         --[in]
    D => '1',           --[in]
    R => rdreq_hold_rst --[in]
  );

 RDREQ_PIPE0_GEN: if C_PIPELINE_MODEL=0 generate
 begin
     -- need to extend read req 1 clock after sequential address
   bus2ip_rdreq_s0 <= rdreq or (opb_seqaddr_s0_d1 and opb_rnw_s0);
end generate RDREQ_PIPE0_GEN;

RDREQ_PIPE_NOT0_GEN: if C_PIPELINE_MODEL /= 0 generate
  -- generate bus2ip_rdreq by OR'ing the single pulse request with the burst
  -- signal
  bus2ip_rdreq_s0 <= rdreq or (opb_seqaddr_s0 and opb_rnw_s0);
end generate RDREQ_PIPE_NOT0_GEN;



WRREQ_GEN_FOR_PIPE_0_1 : if C_PIPELINE_MODEL = 0
                       or C_PIPELINE_MODEL = 1 generate
  wrreq  <= '1'
             when any_fifo_cs = '1' and opb_rnw_s0 = '0'
             else '0';
end generate WRREQ_GEN_FOR_PIPE_0_1;

WRREQ_GEN_FOR_REST : if C_PIPELINE_MODEL /= 0
                    and C_PIPELINE_MODEL /= 1 generate
  -- write request
  wrreq  <= '1'
             when any_fifo_cs = '1' and opb_rnw_s0 = '0' and wrreq_hold='0'
             else '0';

  -- hold the value of wrreq by setting a flop when wrreq asserts
  -- this is used to gate off wrreq to keep it a one-clock pulse
  wrreq_hold_rst <= (not(sln_xferack_s1) and (sln_xferack_s1_d1))
                    or sln_retry_s1
                    or not(opb_select_s0);

  WRREQ_HOLD_FF: FDRE
    port map (
        Q => wrreq_hold,    --[out]
        C => bus2ip_clk_i,  --[in]
        CE=> wrreq,         --[in]
        D => '1',           --[in]
        R => wrreq_hold_rst --[in]
    );
    end generate WRREQ_GEN_FOR_REST;

  -- generate bus2ip_wrreq by OR'ing the single pulse request with the burst
  -- signal extended by 1 clock so that the write request is valid during entire burst
  -- for all pipeline models except 5
  WRREQ_PIPE_NOT5_GEN: if C_PIPELINE_MODEL = 0 or
                          C_PIPELINE_MODEL = 1 or
                          C_PIPELINE_MODEL = 2 or
                          C_PIPELINE_MODEL = 3 or
                          C_PIPELINE_MODEL = 7 generate
    bus2ip_wrreq_s0 <= wrreq or (not(opb_rnw_s0) and bus2ip_burst_s1);
 end generate WRREQ_PIPE_NOT5_GEN;

 -- for pipeline model 5, generate bus2ip_wrreq by OR'ing the single pulse request
 -- with delayed version of the burst_s1 signal
 WRREQ_PIPE5_GEN: if C_PIPELINE_MODEL=4 or
                     C_PIPELINE_MODEL=5 or
                     C_PIPELINE_MODEL=6 generate

 begin

   bus2ip_wrreq_s0 <= wrreq or (not(bus2ip_rnw_s1) and bus2ip_burst_s1_d1);
 end generate WRREQ_PIPE5_GEN;

end generate GEN_RDREQ_WREQ;
-------------------------------------------------------------------------------
-- Bus2IP_RdAddrValid and Bus2IP_WrAddrValid Generation
-- These signals are a single pulse during single transactions and are extended
-- during burst transactions
--bus2ip_rdaddrvalid_s0 <= bus2ip_rdreq_s0 and wrbuf_addrvalid;
--bus2ip_wraddrvalid_s0 <= bus2ip_wrreq_s0 and wrbuf_addrvalid;
 ------------------------------------------------------------------------------
 -- Read FIFO
 ------------------------------------------------------------------------------
  INCLUDE_RDFIFO_GEN : if (INCLUDE_RDFIFO) generate

   constant DATA_INDEX      : integer := get_id_index(C_ARD_ID_ARRAY,
                                            IPIF_RDFIFO_DATA);
   constant DATA_CE_INDEX   : integer := calc_start_ce_index(C_ARD_NUM_CE_ARRAY,
                                            DATA_INDEX);
   constant REG_INDEX       : integer := get_id_index(C_ARD_ID_ARRAY,
                                            IPIF_RDFIFO_REG);
   constant REG_CE_INDEX    : integer := calc_start_ce_index(C_ARD_NUM_CE_ARRAY,
                                            REG_INDEX);
   signal bus2ip_rdreq_rfifo: std_logic;
   signal bus2ip_rdce3_rfifo: std_logic;

  begin

--synopsys translate_off
    assert C_ARD_DEPENDENT_PROPS_ARRAY(DATA_INDEX)(WR_WIDTH_BITS) =
           C_ARD_DEPENDENT_PROPS_ARRAY(DATA_INDEX)(RD_WIDTH_BITS)
    report "This implementation of the OPB IPIF requires the read " &
           " width to be equal to the write width for the RDFIFO."
    severity FAILURE;

    assert C_ARD_DEPENDENT_PROPS_ARRAY(DATA_INDEX)(WR_WIDTH_BITS) =
           C_ARD_DWIDTH_ARRAY(DATA_INDEX)
    report "This implementation of the OPB IPIF requires the write " &
           " width to be equal to the data width specified in " &
           " C_ARD_DWIDTH_ARRAY for RDFIFO."
    severity FAILURE;
--synopsys translate_on

    ----------------------------------------------------------------------------
    -- For RDFIFO, trim Bus2IP_RdReq as needed per pipeline model. The RDFIFO
    -- moves burst data on every cycle and requires that
    -- OPB_seqAddr is low on the next-to-last cycle.
    ----------------------------------------------------------------------------
    RDREQ_RDCE_PIPE0_GEN: if C_PIPELINE_MODEL = 0 generate
        bus2ip_rdreq_rfifo <= bus2ip_rdreq_s1;
        bus2ip_rdce3_rfifo <= bus2ip_rdce_s1(RFIFO_DATA_CE) and
                            not (not opb_seqaddr_d1 and bus2ip_burst_s1);
    end generate RDREQ_RDCE_PIPE0_GEN;

    RDREQ_RDCE_PIPE124_GEN: if C_PIPELINE_MODEL=1 or
                              C_PIPELINE_MODEL=2 or
                              C_PIPELINE_MODEL=4 generate
        bus2ip_rdreq_rfifo <= bus2ip_rdreq_s1;
        bus2ip_rdce3_rfifo <= bus2ip_rdce_s1(RFIFO_DATA_CE);
    end generate RDREQ_RDCE_PIPE124_GEN;

    RDREQ_RDCE_PIPE3_GEN: if C_PIPELINE_MODEL=3  generate
        bus2ip_rdreq_rfifo <= bus2ip_rdreq_s1 and
                          not (not opb_seqaddr_d1 and bus2ip_burst_s1);

        bus2ip_rdce3_rfifo <= bus2ip_rdce_s1(RFIFO_DATA_CE) and
                          not (not opb_seqaddr_d1 and bus2ip_burst_s1);
    end generate RDREQ_RDCE_PIPE3_GEN;

    RDREQ_RDCE_PIPE56_GEN: if C_PIPELINE_MODEL = 5 or
                              C_PIPELINE_MODEL = 6 generate
        bus2ip_rdreq_rfifo <= bus2ip_rdreq_s1 and
                          not (not OPB_seqAddr_eff and opb_seqaddr_d1);

        bus2ip_rdce3_rfifo <= bus2ip_rdce_s1(RFIFO_DATA_CE) and
                          not (not OPB_seqAddr_eff and opb_seqaddr_d1);
    end generate RDREQ_RDCE_PIPE56_GEN;

    RDREQ_RDCE_PIPE7_GEN: if C_PIPELINE_MODEL = 7 generate
        bus2ip_rdreq_rfifo <= bus2ip_rdreq_s1 and
                          not (not OPB_seqAddr_eff and (opb_seqaddr_d1 or bus2ip_burst_s1));
        bus2ip_rdce3_rfifo <= bus2ip_rdce_s1(RFIFO_DATA_CE) and
                          not (not OPB_seqAddr_eff and (opb_seqaddr_d1 or bus2ip_burst_s1));
    end generate RDREQ_RDCE_PIPE7_GEN;



    I_RDFIFO: entity opb_v20_v1_10_d.rdpfifo_top
      Generic map(
        C_MIR_ENABLE          => (C_DEV_MIR_ENABLE /= 0),
        C_BLOCK_ID            => C_DEV_BLK_ID,
        C_FIFO_DEPTH_LOG2X    => log2(
                                     C_ARD_DEPENDENT_PROPS_ARRAY
                                         (DATA_INDEX)
                                             (FIFO_CAPACITY_BITS) /
                                     C_ARD_DEPENDENT_PROPS_ARRAY
                                         (DATA_INDEX)
                                             (WR_WIDTH_BITS)
                                 ),
        C_FIFO_WIDTH          => C_ARD_DEPENDENT_PROPS_ARRAY
                                     (DATA_INDEX)
                                         (WR_WIDTH_BITS),
        C_INCLUDE_PACKET_MODE => C_ARD_DEPENDENT_PROPS_ARRAY
                                     (DATA_INDEX)
                                         (EXCLUDE_PACKET_MODE)=0,
        C_INCLUDE_VACANCY     => C_ARD_DEPENDENT_PROPS_ARRAY
                                     (DATA_INDEX)
                                         (EXCLUDE_VACANCY)=0,
        C_SUPPORT_BURST       => true,
        C_IPIF_DBUS_WIDTH     => C_OPB_DWIDTH,
        C_VIRTEX_II           => VIRTEX_II
              )
      port map(
      -- Inputs From the IPIF Bus
        Bus_rst               =>  bus2ip_reset_i,
        Bus_Clk               =>  bus2ip_clk_i,
        Bus_RdReq             =>  bus2ip_rdreq_rfifo,
        Bus_WrReq             =>  bus2ip_wrreq_s1,
        Bus2FIFO_RdCE1        =>  bus2ip_rdce_s1(RFIFO_REG_CE_LO),
        Bus2FIFO_RdCE2        =>  bus2ip_rdce_s1(RFIFO_REG_CE_LO+1),
        Bus2FIFO_RdCE3        =>  bus2ip_rdce3_rfifo,
        Bus2FIFO_WrCE1        =>  bus2ip_wrce_s1(RFIFO_REG_CE_LO),
        Bus2FIFO_WrCE2        =>  bus2ip_wrce_s1(RFIFO_REG_CE_LO+1),
        Bus2FIFO_WrCE3        =>  bus2ip_wrce_s1(RFIFO_DATA_CE),
        Bus_DBus              =>  bus2ip_data_s1,
      -- Inputs from the IP
        IP2RFIFO_WrReq        =>  IP2RFIFO_WrReq,
        IP2RFIFO_WrMark       =>  IP2RFIFO_WrMark,
        IP2RFIFO_WrRestore    =>  IP2RFIFO_WrRestore,
        IP2RFIFO_WrRelease    =>  IP2RFIFO_WrRelease,
        IP2RFIFO_Data         =>  IP2RFIFO_Data,
      -- Outputs to the IP
        RFIFO2IP_WrAck        =>  RFIFO2IP_WrAck,
        RFIFO2IP_AlmostFull   =>  RFIFO2IP_AlmostFull,
        RFIFO2IP_Full         =>  RFIFO2IP_Full,
        RFIFO2IP_Vacancy      =>  RFIFO2IP_Vacancy,
      -- Outputs to the IPIF DMA/SG function
        RFIFO2DMA_AlmostEmpty =>  open,
        RFIFO2DMA_Empty       =>  open,
        RFIFO2DMA_Occupancy   =>  open,
      -- Interrupt Output to IPIF Interrupt Register
        FIFO2IRPT_DeadLock    =>  rdfifo2intr_deadlock,
      -- Outputs to the IPIF Bus
        FIFO2Bus_DBus         =>  rdfifo2bus_data,
        FIFO2Bus_WrAck        =>  rfifo_wrack,
        FIFO2Bus_RdAck        =>  rfifo_rdack,
        FIFO2Bus_Error        =>  rfifo_error,
        FIFO2Bus_Retry        =>  rfifo_retry,
        FIFO2Bus_ToutSup      =>  rfifo_toutsup
      );

  end generate INCLUDE_RDFIFO_GEN;


  REMOVE_RDFIFO_GEN : if (not INCLUDE_RDFIFO) generate

          rdfifo2bus_data       <=  (others => '0');
          rdfifo2intr_deadlock  <=  '0';
          RFIFO2IP_AlmostFull   <=  '0';
          RFIFO2IP_Full         <=  '0';
          RFIFO2IP_Vacancy      <=  (others => '0');
          RFIFO2IP_WrAck        <=  '0';
          rfifo_error           <=  '0';
          rfifo_rdack           <=  '0';
          rfifo_retry           <=  '0';
          rfifo_toutsup         <=  '0';
          rfifo_wrack           <=  '0';

  end generate REMOVE_RDFIFO_GEN;

  rdfifo_ack <= rfifo_wrack or rfifo_rdack;

--------------------------------------------------------------------------------
-- Write FIFO
--------------------------------------------------------------------------------
  INCLUDE_WRFIFO_GEN : if (INCLUDE_WRFIFO) generate

   constant DATA_INDEX: integer := get_id_index(C_ARD_ID_ARRAY,
                                                IPIF_WRFIFO_DATA);
   constant DATA_CE_INDEX : integer := calc_start_ce_index(C_ARD_NUM_CE_ARRAY,
                                                           DATA_INDEX);
   constant REG_INDEX: integer := get_id_index(C_ARD_ID_ARRAY,
                                               IPIF_WRFIFO_REG);
   constant REG_CE_INDEX : integer := calc_start_ce_index(C_ARD_NUM_CE_ARRAY,
                                                          REG_INDEX);
  begin

--synopsys translate_off
    assert C_ARD_DEPENDENT_PROPS_ARRAY(DATA_INDEX)(WR_WIDTH_BITS) =
           C_ARD_DEPENDENT_PROPS_ARRAY(DATA_INDEX)(RD_WIDTH_BITS)
    report "This implementation of the OPB IPIF requires the read " &
           " width to be equal to the write width for the WRFIFO."
    severity FAILURE;

    assert C_ARD_DEPENDENT_PROPS_ARRAY(DATA_INDEX)(WR_WIDTH_BITS) =
           C_ARD_DWIDTH_ARRAY(DATA_INDEX)
    report "This implementation of the OPB IPIF requires the write " &
           " width to be equal to the data width specified in " &
           " C_ARD_DWIDTH_ARRAY for WRFIFO."
    severity FAILURE;
--synopsys translate_on


    I_WRPFIFO_TOP: entity opb_v20_v1_10_d.wrpfifo_top
      Generic map(
          C_MIR_ENABLE          => (C_DEV_MIR_ENABLE /= 0),
          C_BLOCK_ID            => C_DEV_BLK_ID,
          C_FIFO_DEPTH_LOG2X    => log2(
                                       C_ARD_DEPENDENT_PROPS_ARRAY
                                           (DATA_INDEX)
                                               (FIFO_CAPACITY_BITS) /
                                       C_ARD_DEPENDENT_PROPS_ARRAY
                                           (DATA_INDEX)
                                               (WR_WIDTH_BITS)
                                   ),
          C_FIFO_WIDTH          => C_ARD_DEPENDENT_PROPS_ARRAY
                                       (DATA_INDEX)
                                           (WR_WIDTH_BITS),
          C_INCLUDE_PACKET_MODE => C_ARD_DEPENDENT_PROPS_ARRAY
                                       (DATA_INDEX)
                                           (EXCLUDE_PACKET_MODE)=0,
          C_INCLUDE_VACANCY     => C_ARD_DEPENDENT_PROPS_ARRAY
                                       (DATA_INDEX)
                                           (EXCLUDE_VACANCY)=0,
          C_SUPPORT_BURST       =>  true,
          C_IPIF_DBUS_WIDTH     =>  C_OPB_DWIDTH,
          C_VIRTEX_II           =>  VIRTEX_II
              )
      port map(
      -- Inputs From the IPIF Bus
          Bus_rst               =>  bus2ip_reset_i,
          Bus_clk               =>  bus2ip_clk_i,
          Bus_RdReq             =>  bus2ip_rdreq_s1,
          Bus_WrReq             =>  bus2ip_wrreq_s1,
          Bus2FIFO_RdCE1        =>  bus2ip_rdce_s1(WFIFO_REG_CE_LO),
          Bus2FIFO_RdCE2        =>  bus2ip_rdce_s1(WFIFO_REG_CE_LO+1),
          Bus2FIFO_RdCE3        =>  bus2ip_rdce_s1(WFIFO_DATA_CE),
          Bus2FIFO_WrCE1        =>  bus2ip_wrce_s1(WFIFO_REG_CE_LO),
          Bus2FIFO_WrCE2        =>  bus2ip_wrce_s1(WFIFO_REG_CE_LO+1),
          Bus2FIFO_WrCE3        =>  bus2ip_wrce_s1(WFIFO_DATA_CE),
          Bus_DBus              =>  bus2ip_data_s1,
      -- Inputs from the IP
          IP2WFIFO_RdReq        =>  IP2WFIFO_RdReq,
          IP2WFIFO_RdMark       =>  IP2WFIFO_RdMark,
          IP2WFIFO_RdRestore    =>  IP2WFIFO_RdRestore,
          IP2WFIFO_RdRelease    =>  IP2WFIFO_RdRelease,
      -- Outputs to the IP
          WFIFO2IP_Data         =>  WFIFO2IP_Data,
          WFIFO2IP_RdAck        =>  WFIFO2IP_RdAck,
          WFIFO2IP_AlmostEmpty  =>  WFIFO2IP_AlmostEmpty,
          WFIFO2IP_Empty        =>  WFIFO2IP_Empty,
          WFIFO2IP_Occupancy    =>  WFIFO2IP_Occupancy,
        -- Outputs to the IP
          WFIFO2DMA_AlmostFull  =>  open,
          WFIFO2DMA_Full        =>  open,
          WFIFO2DMA_Vacancy     =>  open,
      -- Interrupt Output to IPIF Interrupt Register
          FIFO2IRPT_DeadLock    =>  wrfifo2intr_deadlock,
      -- Outputs to the IPIF Bus
          FIFO2Bus_DBus         =>  wrfifo2bus_data,
          FIFO2Bus_WrAck        =>  wfifo_wrack,
          FIFO2Bus_RdAck        =>  wfifo_rdack,
          FIFO2Bus_Error        =>  wfifo_error,
          FIFO2Bus_Retry        =>  wfifo_retry,
          FIFO2Bus_ToutSup      =>  wfifo_toutsup
        );

  end generate INCLUDE_WRFIFO_GEN;

  REMOVE_WRFIFO_GEN : if (not INCLUDE_WRFIFO) generate

                WFIFO2IP_AlmostEmpty  <=  '0';
                WFIFO2IP_Data         <=  (others => '0');
                WFIFO2IP_Empty        <=  '0';
                WFIFO2IP_Occupancy    <=  (others => '0');
                WFIFO2IP_RdAck        <=  '0';
                wfifo_error           <=  '0';
                wfifo_rdack           <=  '0';
                wfifo_retry           <=  '0';
                wfifo_toutsup         <=  '0';
                wfifo_wrack           <=  '0';
                wrfifo2bus_data       <=  (others => '0');
                wrfifo2intr_deadlock  <=  '0';


  end generate REMOVE_WRFIFO_GEN;

  wrfifo_ack <= wfifo_wrack or wfifo_rdack;

end implementation;
