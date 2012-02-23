-------------------------------------------------------------------------------
-- $Id: opb_bam.vhd,v 1.10 2004/05/17 20:33:20 gburch Exp $
-------------------------------------------------------------------------------
-- opb_bam.vhd
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        opb_bam.vhd
--
-- Description:     Bus Attachment Module, OPB to IPIC.
--                   
--
-------------------------------------------------------------------------------
-- Structure:       opb_bam
--                      reset_mir
--                      interrupt_controller
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
--
--      FLO     05/27/2003
-- ^^^^^^
--     Use sln_xferack_s1 to enable other than '0' values to the
--     OPBOUT pipestage when this stage is present and there is
--     a single address range. This, in turn, allows the optimization
--     of passing ip2bus_data through to ip2bus_data_mx without
--     qualification by a CE Address-Range decode, saving a LUT per
--     data-bus bit for this case.
--      
-- ~~~~~~
--
--      FLO     05/28/2003
-- ^^^^^^
--     Made a correction to the last change that was causing it to    
--     drive sln_dbus during a write transaction.
--     Now the sln_dbus_s2 signals are separated from the other _s2 signals
--     for application of the reset when sln_xferack_s1 = '0' and this
--     reset is further qualified by bus2ip_rnw_s1.
--     
-- ~~~~~~
--      FLO     09/10/2003
-- ^^^^^^
--     Fixed the mirror instantiation, which erroneously had the address tied low.
-- ~~~~~~
--      GAB     05/05/04
-- ^^^^^^
--     Fixed problem with double clock wrce to interrupt_control.
-- ~~~~~~
--
-------------------------------------------------------------------------------
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
-- ToDo Worklist:
-- [ ] (1) Retain RdCE and WrCE, even though each is generated with LUT2?
--         Discuss with Bert.
--         [021121 These are left in. It might be a good idea to document
--                 that in cases where e.g. WrCE goes into a parially filled
--                 LUT, using CE and RNW instead of WrCE would save a LUT.]
-- [ ] (2) Optimization of decoding as a function of the specific
--         C_ARD_ADDR_RANGE_ARRAY values is a possibility for consideration
--         (e.g. common high-order address bits, common CE offsets, or
--         in general any selection of common address bits that leads to
--         overall resource reduction).
-- [ ] (3) Implement consistency checks for generics, etc.
--         [ ] Booleans passed as integers are either 0 to 1.
--         [ ] At most one address range may be for a reset_mir.
--         [ ] reset_mir address range has exactly one CE
--         [ ] That other "internal" address ranges have consistent # of CEs.
--         [ ] ...
-- [x] (4) Handle retry.
-- [x] (5) Handle timeout. Should require nothing here.
-- [ ] (6) Optimize INTR by implementing and using the OWN_RESP_SIGS,
--         RESP_SIGS_ID concept, or possibly by reworking the interrupt
--         block to have its own response signals, in which case the
--         option to exclude bits should also be implemented.
-- [ ] (7) Slave burst writes.
-- [ ] (8) Slave burst reads.
-- [ ] (9) Master operation.
-- [ ] (10) We could introduce the concept of an address-range span, ARS.
--          An ARS is a set of address ranges. The size of the address
--          space corresponding the ARS is the smallest power of two
--          in units of bytes that is large enough to include all of the
--          address ranges of the span. The base address of the ARS is the
--          smallest of the base addresses of the address ranges of the
--          ARS. The high address of the ARS is the base address plus
--          the size minus one.
--          The default is that there is one ARS including all address
--          ranges in C_ARD_ADDR_RANGE_ARRAY.
--          The motivation for having address-range spans is that it
--          is then possible to place address ranges at widely separated
--          address without "chewing up" all of the unused space between.
--          The reason for not just letting each address range be its
--          own address range span is that some opportunity for optimization
--          of address decoding is lost.
-- [ ] (11) Put Interrupt and Rst/MIR parameters into dependent props.
-- [ ] (12) Put in error detection for IP2Bus_Ack not asserted on a
--          posted write allowed by postedwrinh=0
-- [ ] (13) Handle the case where the master aborts the transaction
--          by deasserting OPB_select before receiving Sln_xferAck
--          or Sln_retry. (See signal OPB_select, Mn_select in the
--          IBM OPB spec.)


library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.or_reduce;

library ipif_common_v1_00_c;
use ipif_common_v1_00_c.ipif_pkg.INTEGER_ARRAY_TYPE;
use ipif_common_v1_00_c.ipif_pkg.SLV64_ARRAY_TYPE;
use ipif_common_v1_00_c.ipif_pkg.calc_num_ce;
use ipif_common_v1_00_c.ipif_pkg.calc_start_ce_index;
use ipif_common_v1_00_c.ipif_pkg.DEPENDENT_PROPS_ARRAY_TYPE;
use ipif_common_v1_00_c.ipif_pkg.get_min_dwidth;
use ipif_common_v1_00_c.ipif_pkg.IPIF_INTR;
use ipif_common_v1_00_c.ipif_pkg.IPIF_RST;
use ipif_common_v1_00_c.ipif_pkg.USER_00;


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
      -- The pipe stage, n, is present iff the (2^n)th
      -- bit in C_PIPELINE_MODEL is 1.
      --
    C_DEV_BLK_ID : INTEGER := 1;   
      --  Unique block ID, assigned to the device when the system is built.
    C_DEV_MIR_ENABLE : INTEGER := 0;   
    C_AWIDTH : INTEGER := 32;   
      -- width of Address Bus (in bits)
    C_DWIDTH : INTEGER := 32;   
      -- Width of the Data Bus (in bits)
    C_FAMILY : string := "virtexe";
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
    C_INCLUDE_DEV_ISC : INTEGER := 1;
      -- 'true' specifies that the full device interrupt
      -- source controller structure will be included;
      -- 'false' specifies that only the global interrupt
      -- enable register of the device interrupt source
      -- controller and that the only source of interrupts
      -- in the device is the IP interrupt source controller
    C_INCLUDE_DEV_IID : integer := 0;
      -- 'true' will include the Device IID register in the device ISC
    C_DEV_BURST_ENABLE : INTEGER := 0
      -- Burst Enable for IPIF Interface
--ToDo, check that C_DEV_BURST_ENABLE is eliminated from places
--      where it is not needed do to using OPB_seqAddr_eff.

  );
  port
  (
    OPB_select         : in  std_logic;
    OPB_DBus           : in  std_logic_vector(0 to C_DWIDTH-1);
    OPB_ABus           : in  std_logic_vector(0 to C_AWIDTH-1);
    OPB_BE             : in  std_logic_vector(0 to C_DWIDTH/8-1);
    OPB_RNW            : in  std_logic;
    OPB_seqAddr        : in  std_logic;
    OPB_xferAck        : in  std_logic; --ToDo, rmv this port
    Sln_DBus           : out std_logic_vector(0 to C_DWIDTH-1);
    Sln_xferAck        : out std_logic;
    Sln_errAck         : out std_logic;
    Sln_retry          : out std_logic;
    Sln_toutSup        : out std_logic;
    Bus2IP_CS          : out std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    Bus2IP_CE          : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_RdCE        : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_WrCE        : out std_logic_vector(0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    Bus2IP_Data        : out std_logic_vector(0 to C_DWIDTH-1);
    Bus2IP_Addr        : out std_logic_vector(0 to C_AWIDTH-1);
    Bus2IP_BE          : out std_logic_vector(0 to C_DWIDTH/8-1);
    Bus2IP_RNW         : out std_logic;
    Bus2IP_Burst       : out std_logic;
    IP2Bus_Data        : in  std_logic_vector(0 to C_DWIDTH*calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
    IP2Bus_Ack         : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_Error       : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_Retry       : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_ToutSup     : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    IP2Bus_PostedWrInh : in  std_logic_vector(0 to C_ARD_ID_ARRAY'length-1);
    OPB_Clk            : in  std_logic;
    Bus2IP_Clk         : out std_logic;
    IP2Bus_Clk         : in  std_logic;
    Reset              : in  std_logic;
    Bus2IP_Reset       : out std_logic;
    IP2Bus_Intr        : in  std_logic_vector(0 to C_IP_INTR_MODE_ARRAY'length-1);
    Device_Intr        : out std_logic
  );
end entity opb_bam;

--ToDo, unisim needed?
library unisim;  
use unisim.all;  

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.log2;

library ieee;
use ieee.numeric_std.TO_UNSIGNED;

library ipif_common_v1_00_c;
use ipif_common_v1_00_c.ipif_pkg.find_ard_id;
use ipif_common_v1_00_c.ipif_pkg.get_id_index;

architecture implementation of opb_bam is

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
    constant MIR_MAJOR_VERSION : INTEGER range 0 to 15 := 1;   

    constant MIR_MINOR_VERSION : INTEGER range 0 to 127:= 0;   

    constant MIR_REVISION : INTEGER := 0;   

    constant MIR_TYPE : INTEGER := 1;   
              --  Always '1' for OPB ipif interface type
              --  ToDo, stays same for bus_attach?

    constant NUM_ARDS  : integer := C_ARD_ID_ARRAY'length;
    constant NUM_CES   : integer := calc_num_ce(C_ARD_NUM_CE_ARRAY);

    constant INCLUDE_OPBIN_PSTAGE  : boolean := (C_PIPELINE_MODEL/1) mod 2 = 1;
    constant INCLUDE_IPIC_PSTAGE   : boolean := (C_PIPELINE_MODEL/2) mod 2 = 1;
    constant INCLUDE_OPBOUT_PSTAGE : boolean := (C_PIPELINE_MODEL/4) mod 2 = 1;

    constant INCLUDE_RESET_MIR : boolean
                               := find_ard_id(C_ARD_ID_ARRAY, IPIF_RST);
    constant INCLUDE_INTR      : boolean
                               := find_ard_id(C_ARD_ID_ARRAY, IPIF_INTR);

    constant SINGLE_CE : boolean := C_ARD_ID_ARRAY'length = 1 and
                                    C_ARD_NUM_CE_ARRAY(0) = 1;

    constant ZERO_SLV : std_logic_vector(0 to 199) := (others => '0');


    type     bo2sl_type is array (boolean) of std_logic;
    constant bo2sl_table : bo2sl_type := ('0', '1');
    function bo2sl(b: boolean) return std_logic is
    begin
      return bo2sl_table(b);
    end bo2sl;

    ----------------------------------------------------------------------------
    -- This function returns the number of high-order address bits
    -- that can be commonly decoded across all address pairs passed in as
    -- the argument ara. Note: only the C_AWIDTH rightmost bits of an entry
    -- in ara are considered to make up the address.
    ----------------------------------------------------------------------------
    function num_common_high_order_addr_bits(ara: SLV64_ARRAY_TYPE)
                                            return integer is
        variable n : integer := C_AWIDTH;
            -- Maximum number of common high-order bits for
            -- the ranges starting at an index less than i.
        variable i, j: integer;
        variable old_base: std_logic_vector(0 to C_AWIDTH-1)
                         := ara(0)(   ara(0)'length-C_AWIDTH
                                   to ara(0)'length-1
                                  );
        variable new_base, new_high: std_logic_vector(0 to C_AWIDTH-1);
    begin
      i := 0;
      while i < ara'length loop
          new_base := ara(i  )(ara(0)'length-C_AWIDTH to ara(0)'length-1);
          new_high := ara(i+1)(ara(0)'length-C_AWIDTH to ara(0)'length-1);
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
                              :=cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_RST);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_RESET_MIR is false.

    constant INTR_CS_IDX : integer
                              :=cs_index_or_maxint(C_ARD_ID_ARRAY, IPIF_INTR);
        -- Must be a value outside the range of valid ARD indices if
        -- INCLUDE_INTR is false.

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
    function intr_ce_hi_avoiding_bounds_error(
                 C_ARD_ID_ARRAY: INTEGER_ARRAY_TYPE;
                 IDX: integer
             ) return integer is
    begin
        if IDX < NUM_ARDS then
            return   calc_start_ce_index(C_ARD_NUM_CE_ARRAY, IDX)
                   + C_ARD_NUM_CE_ARRAY(INTR_CS_IDX) - 1;
        else
            return integer'high;
        end if;
    end intr_ce_hi_avoiding_bounds_error;
    --
    constant INTR_CE_HI       : natural
                              := intr_ce_hi_avoiding_bounds_error(
                                     C_ARD_ID_ARRAY,
                                     INTR_CS_IDX
                                 );


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


    function eff_ip2bus_val(i     : integer;
                            rst   : std_logic;
                            intr  : std_logic;
                            user  : std_logic
                           ) return std_logic is
    begin
        if    C_ARD_ID_ARRAY(i) = IPIF_RST  then return rst;
        elsif C_ARD_ID_ARRAY(i) = IPIF_INTR then return intr;
        else                                     return user;
        end if;
    end eff_ip2bus_val;


    component pselect is
      generic (
        C_AB     : integer := 9;
        C_AW     : integer := 32;
        C_BAR    : std_logic_vector
        );
      port (
        A        : in   std_logic_vector(0 to C_AW-1);
        AValid   : in   std_logic;
        CS       : out  std_logic
        );
    end component;


    component or_muxcy is
      generic (
        C_NUM_BITS : integer   := 8
        );
      port (
        In_bus     : in std_logic_vector(0 to C_NUM_BITS-1);
        Or_out     : out std_logic      
        );
    end component;


    component MUXCY is
      port (
        O  : out std_logic;
        CI : in  std_logic;
        DI : in  std_logic;
        S  : in  std_logic
      );
    end component MUXCY;
    

    component IPIF_Steer is
      generic (
        C_DWIDTH    : integer := 32;    -- 8, 16, 32, 64
        C_SMALLEST  : integer := 32;    -- 8, 16, 32, 64
        C_AWIDTH    : integer := 32
        );    
      port (
        Wr_Data_In         : in  std_logic_vector(0 to C_DWIDTH-1);
        Rd_Data_In         : in  std_logic_vector(0 to C_DWIDTH-1);
        Addr               : in  std_logic_vector(0 to C_AWIDTH-1);
        BE_In              : in  std_logic_vector(0 to C_DWIDTH/8-1);
        Decode_size        : in  std_logic_vector(0 to 2);
        Wr_Data_Out        : out std_logic_vector(0 to C_DWIDTH-1);
        Rd_Data_Out        : out std_logic_vector(0 to C_DWIDTH-1);
        BE_Out             : out std_logic_vector(0 to C_DWIDTH/8-1)
        );
    end component IPIF_Steer;

    component reset_mir is
      Generic (
        C_DWIDTH               : integer  := 32;
        C_INCLUDE_SW_RST       : integer  := 1;   
        C_INCLUDE_MIR          : integer  := 0;
        C_MIR_MAJOR_VERSION    : integer  := 0;
        C_MIR_MINOR_VERSION    : integer  := 0;
        C_MIR_REVISION         : integer  := 1;
        C_MIR_BLK_ID           : integer  := 1;
        C_MIR_TYPE             : integer  := 1
      );  
      port (
        Reset                  : in  std_logic;
        Bus2IP_Clk             : in  std_logic;
        SW_Reset_WrCE          : in  std_logic;
        Bus2IP_Data            : in  std_logic_vector(0 to C_DWIDTH-1);
        Bus2IP_Reset           : out std_logic;
        Reset2Bus_Data         : out std_logic_vector(0 to C_DWIDTH-1);
        Reset2Bus_Ack          : out std_logic;
        Reset2Bus_Error        : out std_logic;
        Reset2Bus_Retry        : out std_logic;
        Reset2Bus_ToutSup      : out std_logic
      );
    end component reset_mir;
 
    component interrupt_control
      Generic(
        C_INTERRUPT_REG_NUM    : INTEGER := 16;
            -- Use 16 to allow for the full set of architectural registers,
            -- many of which are not populated.
            --
        C_NUM_IPIF_IRPT_SRC    : INTEGER := 4;
        C_IP_INTR_MODE_ARRAY   : INTEGER_ARRAY_TYPE;
        C_INCLUDE_DEV_PENCODER : BOOLEAN := true;
            -- Include Interrupt ID register
            --
        C_INCLUDE_DEV_ISC      : Boolean := true;
            -- If false, the device ISC not be included, except for
            -- the GIE register.
            --
        C_IRPT_DBUS_WIDTH      : INTEGER := 32
      ); 
      port(
        Bus2IP_Clk_i        : In  std_logic;
        Bus2IP_Data_sa      : In  std_logic_vector(0 to C_IRPT_DBUS_WIDTH-1);
        Bus2IP_RdReq_sa     : In  std_logic;
        Bus2IP_Reset_i      : In  std_logic;
        Bus2IP_WrReq_sa     : In  std_logic;
        Interrupt_RdCE      : In  std_logic_vector(0 to C_INTERRUPT_REG_NUM-1);
        Interrupt_WrCE      : In  std_logic_vector(0 to C_INTERRUPT_REG_NUM-1);
        IPIF_Reg_Interrupts : In  std_logic_vector(0 to 1);
            -- Interrupt inputs from the IPIF sources that will get
            -- registered in this design
            --
        IPIF_Lvl_Interrupts : In  std_logic_vector(0 to C_NUM_IPIF_IRPT_SRC-1);
            -- Level Interrupt inputs from the IPIF sources
            --
        IP2Bus_IntrEvent    : In  std_logic_vector(
                                      0 to C_IP_INTR_MODE_ARRAY'length-1
                                  );
            -- Interrupt inputs from the IP 
            --
       Intr2Bus_DevIntr     : Out std_logic;
            -- Device interrupt output to the Master Interrupt Controller
            --
       Intr2Bus_DBus        : Out std_logic_vector(0 to C_IRPT_DBUS_WIDTH-1);
       Intr2Bus_WrAck       : Out std_logic;
       Intr2Bus_RdAck       : Out std_logic;
       Intr2Bus_Error       : Out std_logic;
       Intr2Bus_Retry       : Out std_logic;
       Intr2Bus_ToutSup     : Out std_logic
      );
    end component interrupt_control;


    signal bus2ip_clk_i  : std_logic;
    signal bus2ip_reset_i  : std_logic;
    signal opb_select_s0 : std_logic;
    signal opb_select_s0_d1 : std_logic;
    signal opb_rnw_s0    : std_logic;
    signal opb_seqaddr_s0: std_logic;
    signal bus2ip_burst_s1: std_logic;
    signal opb_seqaddr_d1: std_logic;
    signal opb_abus_s0   : std_logic_vector(0 to C_AWIDTH-1);
    signal opb_dbus_s0   : std_logic_vector(0 to C_AWIDTH-1);
    signal opb_be_s0     : std_logic_vector(0 to C_DWIDTH/8-1);
    signal bus2ip_rnw_s1 : std_logic;
    signal bus2ip_be_s0  : std_logic_vector(0 to C_DWIDTH/8-1);
    signal bus2ip_be_s1  : std_logic_vector(0 to C_DWIDTH/8-1);
    signal bus2ip_cs_s0  : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_s1  : std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_hit_s0: std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_hit_s0_d1: std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_cs_enable_s0: std_logic_vector(0 to NUM_ARDS-1);
    signal bus2ip_ce_s0  : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_ce_s1  : std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_rdce_s0: std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_rdce_s1: std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_wrce_s0: std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_wrce_s1: std_logic_vector(0 to NUM_CES-1);
    signal bus2ip_addr_s0: std_logic_vector(0 to C_AWIDTH-1);
    signal bus2ip_addr_s1: std_logic_vector(0 to C_AWIDTH-1);
    signal bus2ip_data_s0: std_logic_vector(0 to C_DWIDTH-1);
    signal bus2ip_data_s1: std_logic_vector(0 to C_DWIDTH-1);
    signal devicesel_s0  : std_logic;

    constant NUM_ENCODED_SIZE_BITS : natural := 3;

    type   OR_CSES_PER_BIT_TABLE_TYPE is array(0 to NUM_ENCODED_SIZE_BITS-1) of
                                          std_logic_vector(0 to NUM_ARDS-1);
    signal cs_to_or_for_dsize_bit : OR_CSES_PER_BIT_TABLE_TYPE;

    signal encoded_dsize_s0: std_logic_vector(0 to NUM_ENCODED_SIZE_BITS-1);
    signal encoded_dsize_s1: std_logic_vector(0 to NUM_ENCODED_SIZE_BITS-1);

    signal ip2bus_data_mx: std_logic_vector(0 to C_DWIDTH-1);
    signal sln_dbus_s1   : std_logic_vector(0 to C_DWIDTH-1);
    signal sln_dbus_s2   : std_logic_vector(0 to C_DWIDTH-1);
    signal sln_xferack_s1: std_logic;
    signal sln_xferack_s1_d1: std_logic;
    signal sln_xferack_s1_d2: std_logic;
    signal sln_xferack_s2: std_logic;
    signal sln_retry_s1  : std_logic;
    signal sln_retry_s2  : std_logic;
    signal sln_errack_s1 : std_logic;
    signal sln_errack_s2 : std_logic;
    signal sln_toutsup_s1: std_logic;
    signal sln_toutsup_s2: std_logic;

    signal reset2bus_data    : std_logic_vector(0 to C_DWIDTH-1);
    signal reset2bus_ack     : std_logic;
    signal reset2bus_error   : std_logic;
    signal reset2bus_retry   : std_logic;
    signal reset2bus_toutsup : std_logic;
    signal reset2bus_postedwrinh : std_logic;

    signal intr2bus_data     : std_logic_vector(0 to C_DWIDTH-1);
    signal intr2bus_rdack    : std_logic;
    signal intr2bus_wrack    : std_logic;
    signal intr2bus_ack      : std_logic;
    signal intr2bus_error    : std_logic;
    signal intr2bus_retry    : std_logic;
    signal intr2bus_toutsup  : std_logic;
    signal intr2bus_postedwrinh : std_logic;

    signal new_select_s0     : std_logic_vector(0 to NUM_ARDS-1); 
    signal new_select_s0_d1  : std_logic_vector(0 to NUM_ARDS-1); 
    
    signal inh_cs_when_pw    : std_logic_vector(0 to NUM_ARDS-1);
    signal inh_cs_wnot_pw    : std_logic;
    signal inh_xferack_when_pw: std_logic;
    signal last_xferack      : std_logic;
    signal last_xferack_d1   : std_logic;
    signal last_xferack_d2   : std_logic;
    signal last_wr_xferack      : std_logic;
    signal last_wr_xferack_d1   : std_logic;
    signal last_wr_xferack_d2   : std_logic;
    signal OPB_seqAddr_eff   : std_logic;

    signal postedwr_s0                  : std_logic;    --GB
    signal postedwrack_s2               : std_logic;    --GB
    signal last_pw_xferack              : std_logic;    --GB
    signal last_pw_xferack_d1           : std_logic;    --GB
    signal last_pw_xferack_d2           : std_logic;    --GB
    

begin

    OPB_seqAddr_eff <= OPB_seqAddr and bo2sl(C_DEV_BURST_ENABLE=1);

    bus2ip_clk_i <= OPB_Clk;
    Bus2IP_Clk   <= OPB_Clk;

--    reset2bus_postedwrinh <= '0'; --Gb
    reset2bus_postedwrinh <= '1';
    intr2bus_postedwrinh  <= '1';

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
              else
                  opb_select_s0 <= OPB_select;
              end if;
            end if;
            --------------------------------------------------------------------
            -- Sigs that do not need reset value
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                  opb_rnw_s0 <= OPB_RNW;
                  opb_seqaddr_s0 <= OPB_seqAddr_eff;
                  opb_abus_s0 <= OPB_ABus;
                  opb_dbus_s0 <= OPB_DBus;
                  opb_be_s0   <= OPB_BE;
            end if;
        end process;
    end generate;
    --
    GEN_BYPASS0: if not INCLUDE_OPBIN_PSTAGE generate
    begin
                  opb_select_s0 <= OPB_select;
                  opb_rnw_s0 <= OPB_RNW;
                  opb_seqaddr_s0 <= OPB_seqAddr_eff;
                  opb_abus_s0 <= OPB_ABus;
                  opb_dbus_s0 <= OPB_DBus;
                  opb_be_s0   <= OPB_BE;
    end generate;


    GEN_PSTAGE1: if INCLUDE_IPIC_PSTAGE generate
    begin
        PROC_PSTAGE1 : process(bus2ip_clk_i)
        begin
            --------------------------------------------------------------------
            -- Sigs that need reset value
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
              if Reset = '1' then
                  bus2ip_cs_s1     <= (others => '0');
                  bus2ip_ce_s1     <= (others => '0');
                  bus2ip_rdce_s1   <= (others => '0');
                  bus2ip_wrce_s1   <= (others => '0');
              else
                  bus2ip_cs_s1     <= bus2ip_cs_s0;
                  bus2ip_ce_s1     <= bus2ip_ce_s0;
                  bus2ip_rdce_s1   <= bus2ip_rdce_s0;
                  bus2ip_wrce_s1   <= bus2ip_wrce_s0;
              end if;
            end if;
            --------------------------------------------------------------------
            -- Sigs that do not need reset value
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
                  bus2ip_addr_s1   <= opb_abus_s0;
                  bus2ip_data_s1   <= bus2ip_data_s0;
                  bus2ip_be_s1     <= bus2ip_be_s0;
                  bus2ip_rnw_s1    <= opb_rnw_s0;
                  encoded_dsize_s1 <= encoded_dsize_s0;
                  bus2ip_burst_s1  <=     opb_seqaddr_s0
                                      and bo2sl(C_DEV_BURST_ENABLE = 1);
            end if;
        end process;
    end generate;
    --
    GEN_BYPASS1: if not INCLUDE_IPIC_PSTAGE generate
    begin
                  bus2ip_cs_s1     <= bus2ip_cs_s0;
                  bus2ip_ce_s1     <= bus2ip_ce_s0;
                  bus2ip_rdce_s1   <= bus2ip_rdce_s0;
                  bus2ip_wrce_s1   <= bus2ip_wrce_s0;
                  bus2ip_addr_s1   <= opb_abus_s0;
                  bus2ip_data_s1   <= bus2ip_data_s0;
                  bus2ip_be_s1     <= bus2ip_be_s0;
                  bus2ip_rnw_s1    <= opb_rnw_s0;
                  encoded_dsize_s1 <= encoded_dsize_s0;
                  bus2ip_burst_s1  <=     opb_seqaddr_s0
                                      and bo2sl(C_DEV_BURST_ENABLE = 1);
    end generate;

    Bus2IP_CS    <= bus2ip_cs_s1;
    Bus2IP_CE    <= bus2ip_ce_s1;
    Bus2IP_RdCE  <= bus2ip_rdce_s1;
    Bus2IP_WrCE  <= bus2ip_wrce_s1;
    Bus2IP_Addr  <= bus2ip_addr_s1;
    Bus2IP_Data  <= bus2ip_data_s1;
    Bus2IP_BE    <= bus2ip_be_s1;
    Bus2IP_RNW   <= bus2ip_rnw_s1;
    Bus2IP_Burst <= bus2ip_burst_s1;


    GEN_PSTAGE2: if INCLUDE_OPBOUT_PSTAGE generate
    begin
        PROC_PSTAGE2 : process(bus2ip_clk_i)
        begin
            --------------------------------------------------------------------
            -- Sigs that need reset value
            --------------------------------------------------------------------
            if bus2ip_clk_i'event and bus2ip_clk_i='1' then
              if Reset = '1' then
                  sln_xferack_s2   <= '0';
                  sln_retry_s2     <= '0';
                  sln_errack_s2    <= '0';
                  sln_toutsup_s2   <= '0';
              else
                  sln_xferack_s2   <= sln_xferack_s1;
                  sln_retry_s2     <= sln_retry_s1;
                  sln_errack_s2    <= sln_errack_s1;
                  sln_toutsup_s2   <= sln_toutsup_s1;
              end if;
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
                  postedwrack_s2   <= postedwr_s0; --GB
              end if;
        end process;
    end generate;
    --
    GEN_BYPASS2: if not INCLUDE_OPBOUT_PSTAGE generate
    begin
                  sln_dbus_s2      <= sln_dbus_s1;
                  sln_xferack_s2   <= sln_xferack_s1;
                  sln_retry_s2     <= sln_retry_s1;
                  sln_errack_s2    <= sln_errack_s1;
                  sln_toutsup_s2   <= sln_toutsup_s1;
                  postedwrack_s2   <= postedwr_s0; --GB
    end generate;

    Sln_Dbus    <= sln_dbus_s2;

--    Sln_xferAck <= sln_xferack_s2;   --GB
--    Sln_retry   <= sln_retry_s2;     --GB
--    Sln_errAck  <= sln_errack_s2;   --GB
    Sln_xferAck <= sln_xferack_s2 and OPB_Select;   --GB
    Sln_retry   <= sln_retry_s2 and OPB_Select;     --GB
    Sln_errAck  <= sln_errack_s2  and OPB_Select;   --GB
    Sln_toutSup <= sln_toutsup_s2;


  ------------------------------------------------------------------------------
  -- Generation of devicesel_s0
  -----------------------------------------------------------------------------
  DEVICESEL_S0_I: pselect
    generic map (
      C_AB     => K_DEV_ADDR_DECODE_WIDTH,
      C_AW     => C_AWIDTH,
      C_BAR    => C_ARD_ADDR_RANGE_ARRAY(0)
                     (   C_ARD_ADDR_RANGE_ARRAY(0)'length-C_AWIDTH
                      to C_ARD_ADDR_RANGE_ARRAY(0)'length-1
                     )  
    )
    port map (
      A        => opb_abus_s0,
      AValid   => opb_select_s0,
      CS       => devicesel_s0
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
          sln_xferack_s1_d1     <= sln_xferack_s1;
          sln_xferack_s1_d2     <= sln_xferack_s1_d1;
          opb_select_s0_d1      <= opb_select_s0;
          new_select_s0_d1      <= new_select_s0;

          opb_seqaddr_d1        <= OPB_seqAddr_eff;
          last_xferack_d1       <= last_xferack;
          last_xferack_d2       <= last_xferack_d1;
          last_wr_xferack_d1    <= last_wr_xferack;
          last_wr_xferack_d2    <= last_wr_xferack_d1;
          bus2ip_cs_hit_s0_d1   <= bus2ip_cs_hit_s0;
          last_pw_xferack_d1    <= last_pw_xferack;     --GB
          last_pw_xferack_d2    <= last_pw_xferack_d1;  --GB
      end if;
  end process;


  inh_cs_wnot_pw   <= not (opb_rnw_s0 and OPB_seqAddr_s0) -- Do not inhibit 
                      and                                 -- when a burst read.
                      (
                          (sln_xferack_s1    and bo2sl(INCLUDE_IPIC_PSTAGE))
                       or   
                        (sln_xferack_s1_d1 and bo2sl(INCLUDE_OPBIN_PSTAGE or
                                                       INCLUDE_OPBOUT_PSTAGE))
                                                       
                       or (sln_xferack_s1_d2 and bo2sl(INCLUDE_OPBIN_PSTAGE and
                                                       INCLUDE_OPBOUT_PSTAGE))
                      );


  INH_CS_WHEN_PW_GEN: for i in 0 to NUM_ARDS-1 generate
  begin


  new_select_s0(i) <=    (bus2ip_cs_hit_s0(i) and not bus2ip_cs_hit_s0_d1(i))
                      or last_xferack_d1;

  inh_cs_when_pw(i) <= (new_select_s0(i)    and bo2sl(INCLUDE_OPBIN_PSTAGE or
                                                      INCLUDE_OPBOUT_PSTAGE))
                    or (new_select_s0_d1(i) and bo2sl(INCLUDE_OPBIN_PSTAGE and
                                                      INCLUDE_OPBOUT_PSTAGE));

  end generate;




  -- Modified to fix interrupt double wrce
--  last_xferack   <= sln_xferack_s2 and not OPB_seqAddr_eff;
--  
--  inh_xferack_when_pw <=
--                       (last_xferack    and bo2sl(INCLUDE_OPBOUT_PSTAGE))
--                    or (last_xferack_d1 and bo2sl(INCLUDE_OPBIN_PSTAGE))
--                    or (last_xferack_d2 and bo2sl(INCLUDE_OPBIN_PSTAGE and
--                                                  INCLUDE_OPBOUT_PSTAGE));


  last_xferack   <= sln_xferack_s2 and not OPB_seqAddr_eff and not last_xferack_d1;  --GB
  
  
  
  
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
                                            user    => ip2bus_postedwrinh(i)
                                           )
                    );
      end loop;
      postedwr_s0 <= bo2sl(r='1' and not opb_rnw_s0='1');-- and C_DEV_BURST_ENABLE=1); 
  end process;
  
  last_pw_xferack <= sln_xferack_s2 and not OPB_seqAddr_eff and postedwrack_s2;
  
  inh_xferack_when_pw <=
                bo2sl((last_pw_xferack='1' and (INCLUDE_OPBOUT_PSTAGE))
                
                or (last_pw_xferack_d1='1' and (INCLUDE_OPBIN_PSTAGE or
                                                    INCLUDE_IPIC_PSTAGE))
                                                    
                or (last_pw_xferack_d2='1' and (INCLUDE_OPBIN_PSTAGE and
                                                    INCLUDE_IPIC_PSTAGE)) );
  
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
      CS_I: pselect
        generic map (
          C_AB     => - K_DEV_ADDR_DECODE_WIDTH
                      + num_decode_bits(C_ARD_ADDR_RANGE_ARRAY,
                                        C_AWIDTH,
                                        i),
          C_AW     => C_AWIDTH - K_DEV_ADDR_DECODE_WIDTH,
          C_BAR    => C_ARD_ADDR_RANGE_ARRAY(i*2)
                         (     C_ARD_ADDR_RANGE_ARRAY(0)'length
                             - C_AWIDTH
                             + K_DEV_ADDR_DECODE_WIDTH
                          to C_ARD_ADDR_RANGE_ARRAY(0)'length-1
                         )  
        )
        port map (
          A        => opb_abus_s0(K_DEV_ADDR_DECODE_WIDTH to C_AWIDTH-1),
          AValid   => devicesel_s0,
          CS       => bus2ip_cs_hit_s0(i)
        );         
       --
       -- ToDo, pselect above and AND gate below can
       -- be optimized later with a special pselect that
       -- has outputs for both bus2ip_cs_s0 and bus2ip_cs_hit_s0.
       --
      bus2ip_cs_enable_s0(i) <=   not inh_cs_wnot_pw
                                when C_DEV_BURST_ENABLE=0 or
                                     opb_rnw_s0 = '1'     or
                                     eff_ip2bus_val(
                                         i   =>i,
                                         rst =>reset2bus_postedwrinh,
                                         intr=>intr2bus_postedwrinh,
                                         user=>ip2bus_postedwrinh(i)
                                     )='1'
                                else
                                  not inh_cs_when_pw(i);

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
            CE_I : pselect
            generic map (
              C_AB     => CE_ADDR_SIZE,
              C_AW     => CE_ADDR_SIZE,
              C_BAR    => BAR
            )
            port map (
              A        => opb_abus_s0(C_AWIDTH - OFFSET - CE_ADDR_SIZE to
                                      C_AWIDTH - OFFSET - 1),
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
    SOMETIMES_HIGH_GEN: if num_cs_for_bit(i) /= 0 and
                           num_cs_for_bit(i) /= NUM_ARDS
    generate
    ENCODED_SIZE_OR : or_muxcy  -- instance of carry-chain OR for each bit
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
  ------------------------------------------------------------------------------
  I_STEER : IPIF_Steer
    generic map(
      C_DWIDTH    => C_DWIDTH,
      C_SMALLEST  => get_min_dwidth(C_ARD_DWIDTH_ARRAY),
      C_AWIDTH    => C_AWIDTH
    )    
    port map (
      Wr_Data_In   => opb_dbus_s0,  
      Addr         => opb_abus_s0,
      BE_In        => opb_be_s0,
      Decode_size  => encoded_dsize_s0,
      Wr_Data_Out  => bus2ip_data_s0,  
      BE_Out       => bus2ip_be_s0,
      --
      -- Rd mirroring tied off, see I_MIRROR
      Rd_Data_In   => ZSLV(0 to C_DWIDTH-1),  
      Rd_Data_Out  => open
    );


  ------------------------------------------------------------------------------
  -- Mirror read data to appropriate data lanes if C_ARD_DWIDTH_ARRAY has
  -- mixed width values.
  ------------------------------------------------------------------------------
  I_MIRROR : IPIF_Steer
    generic map(
      C_DWIDTH    => C_DWIDTH,
      C_SMALLEST  => get_min_dwidth(C_ARD_DWIDTH_ARRAY),
      C_AWIDTH    => C_AWIDTH
    )
    port map (
      Rd_Data_In   => ip2bus_data_mx,
      Decode_size  => encoded_dsize_s1,
      Addr         => bus2ip_addr_s1,
      Rd_Data_Out  => sln_dbus_s1,
      --
      -- Wr steering tied off, see I_MIRROR
      Wr_Data_In   => ZSLV(0 to C_DWIDTH-1),  
      BE_In        => ZSLV(0 to C_DWIDTH/8-1),  
      Wr_Data_Out  => open,  
      BE_Out       => open
    );


  ------------------------------------------------------------------------------
  -- Generation of sln_xferack.
  ------------------------------------------------------------------------------
  SLN_XFERACK_PROC : process (bus2ip_cs_s1, bus2ip_cs_hit_s0,
                              opb_rnw_s0, inh_xferack_when_pw,
                              reset2bus_ack, intr2bus_ack,
                              reset2bus_postedwrinh, intr2bus_postedwrinh,
                              IP2Bus_Ack, IP2Bus_PostedWrInh) is
    variable r : std_logic;
  begin
    r := '0';
    for i in bus2ip_cs_s1'range loop
      if (eff_ip2bus_val(i   =>i,
                         rst =>reset2bus_postedwrinh,
                         intr=>intr2bus_postedwrinh,
                         user=>IP2Bus_PostedWrInh(i)
          ) or opb_rnw_s0
         ) = '1'
      then -- This is the case where transactions are reads, or writes
           -- that are not posted.
          r := r or
               (bus2ip_cs_s1(i) and
                 eff_ip2bus_val(i   =>i,
                               rst =>reset2bus_ack,
                               intr=>intr2bus_ack,
                               user=>IP2Bus_Ack(i)
                              )
                );
      else -- This is the case where writes are posted.
          r := r or
--                  bus2ip_cs_hit_s0(i);
               (bus2ip_cs_hit_s0(i) and bus2ip_cs_enable_s0(i)); --GB
      end if;
    end loop;
    sln_xferack_s1 <=   r and not(inh_xferack_when_pw);
    
    
    
  end process;


  ------------------------------------------------------------------------------
  -- Generation of sln_retry.
  ------------------------------------------------------------------------------
  SLN_RETRY_PROC : process (bus2ip_cs_s1, IP2Bus_Retry, reset2bus_retry,
                            intr2bus_retry) is
    variable r : std_logic;
    variable ip2bus_retry_help : std_logic;
  begin
    r := '0';
    for i in bus2ip_cs_s1'range loop
      if    INCLUDE_RESET_MIR and (i = RESET_MIR_CS_IDX) then
          ip2bus_retry_help := reset2bus_retry;
      elsif INCLUDE_INTR      and (i = INTR_CS_IDX) then
          ip2bus_retry_help := intr2bus_retry;
      else
          ip2bus_retry_help := IP2Bus_Retry(i);
      end if;
      r :=  r or (bus2ip_cs_s1(i) and ip2bus_retry_help);  
    end loop;
    sln_retry_s1 <= r;
  end process;


  ------------------------------------------------------------------------------
  -- Generation of sln_error.
  ------------------------------------------------------------------------------
  SLN_ERRACK_PROC : process (bus2ip_cs_s1, IP2Bus_Error, reset2bus_error,
                             intr2bus_error) is
    variable r : std_logic;
    variable ip2bus_error_help : std_logic;
  begin
    r := '0';
    for i in bus2ip_cs_s1'range loop
      if    INCLUDE_RESET_MIR and (i = RESET_MIR_CS_IDX) then
          ip2bus_error_help := reset2bus_error;
      elsif INCLUDE_INTR      and (i = INTR_CS_IDX) then
          ip2bus_error_help := intr2bus_error;
      else
          ip2bus_error_help := IP2Bus_Error(i);
      end if;
      r :=  r or (bus2ip_cs_s1(i) and ip2bus_error_help);  
    end loop;
    sln_errack_s1 <= r;
  end process;


  ------------------------------------------------------------------------------
  -- Generation of sln_toutsup.
  ------------------------------------------------------------------------------
  SLN_TOUTSUP_PROC : process (bus2ip_cs_s1, IP2Bus_ToutSup, reset2bus_toutsup,
                              intr2bus_toutsup) is
    variable r : std_logic;
    variable ip2bus_toutsup_help : std_logic;
  begin
    r := '0';
    for i in bus2ip_cs_s1'range loop
      if    INCLUDE_RESET_MIR and (i = RESET_MIR_CS_IDX) then
          ip2bus_toutsup_help := reset2bus_toutsup;
      elsif INCLUDE_INTR      and (i = INTR_CS_IDX) then
          ip2bus_toutsup_help := intr2bus_toutsup;
      else
          ip2bus_toutsup_help := IP2Bus_ToutSup(i);
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
  READMUX_GEN : if not SINGLE_CE or not INCLUDE_OPBOUT_PSTAGE generate
  begin
     PER_BIT_GEN : for i in 0 to C_DWIDTH-1 generate
       signal cry : std_logic_vector(0 to (Bus2IP_RdCE'length + 1)/2);
     begin
       cry(0) <= '0';
       PER_CE_PAIR_GEN : for j in 0 to (Bus2IP_RdCE'length + 1)/2-1 generate  
         signal ip2bus_data_rmmx0 : std_logic_vector(0 to C_DWIDTH-1);
         signal ip2bus_data_rmmx1 : std_logic_vector(0 to C_DWIDTH-1);
         signal lut_out : std_logic;
         constant nopad : boolean := (j /= (Bus2IP_RdCE'length + 1)/2-1) or
                                     (Bus2IP_RdCE'length mod 2 = 0);
       begin
         -----------------------------------------------------------------------
         -- ToDo, the read-back mux can be optimized to exclude any data bits
         -- that are not present in AR with DWIDTH less than C_DWIDTH...
         -- possibly also for bits that are known to be not implemented, e.g.
         -- a register that doesn't use all bit positions or is write-only.
         -----------------------------------------------------------------------
         -- LUT  (last LUT may multiplex one data bit instead of two)
         -----------------------------------------------------------------------
--       WOPAD : if nopad generate
--           signal ip2bus_data_rmmx0 : std_logic_vector(0 to C_DWIDTH-1);
--           signal ip2bus_data_rmmx1 : std_logic_vector(0 to C_DWIDTH-1);
--       begin
         -------------------------------------------------------------------
         -- Always include the first of two possilble mux channels thru LUT.
         -------------------------------------------------------------------
             ip2bus_data_rmmx0 <=
                                  ----------------------------------------------
                                  -- RESET_MIR
                                  ----------------------------------------------
                                  reset2bus_data
                                  when INCLUDE_RESET_MIR and
                                       (2*j   = RESET_MIR_CE_IDX)
                                  else
                                  ----------------------------------------------
                                  -- INTR -- ToDo, this is inefficient because
                                  --         interrupt_control already multiplexes
                                  --         the data. Optimize later.
                                  ----------------------------------------------
                                  intr2bus_data
                                  when INCLUDE_INTR and
                                       (2*j   >= INTR_CE_LO) and
                                       (2*j   <= INTR_CE_HI)
                                  else
                                  ----------------------------------------------
                                  -- IP Core
                                  ----------------------------------------------
                                  IP2Bus_Data((2*j  )*C_DWIDTH to
                                              (2*j+1)*C_DWIDTH-1);
         -------------------------------------------------------------------
         -- Don't include second channel when odd number and on last LUT.
         -------------------------------------------------------------------
         WOPAD : if nopad generate
         begin
             ip2bus_data_rmmx1 <=
                                  ----------------------------------------------
                                  -- RESET_MIR
                                  ----------------------------------------------
                                  reset2bus_data
                                  when INCLUDE_RESET_MIR and
                                       (2*j+1 = RESET_MIR_CE_IDX)
                                  else
                                  ----------------------------------------------
                                  -- INTR
                                  ----------------------------------------------
                                  intr2bus_data
                                  when INCLUDE_INTR and
                                       (2*j+1 >= INTR_CE_LO) and
                                       (2*j+1 <= INTR_CE_HI)
                                  else
                                  ----------------------------------------------
                                  -- IP Core
                                  ----------------------------------------------
                                  IP2Bus_Data((2*j+1)*C_DWIDTH to
                                              (2*j+2)*C_DWIDTH-1);
             lut_out <= not (
                 (ip2bus_data_rmmx0(i) and bus2ip_rdce_s1(2*j  )) or
                 (ip2bus_data_rmmx1(i) and bus2ip_rdce_s1(2*j+1)));
         end generate;
         WIPAD : if not nopad generate
             lut_out <= not (
                 (ip2bus_data_rmmx0(i) and bus2ip_rdce_s1(2*j  )));
         end generate;
         -----------------------------------------------------------------------
         -- MUXCY
         -----------------------------------------------------------------------
         I_MUXCY : MUXCY
             port map (
               O  => cry(j+1),
               CI => cry(j),
               DI => '1',
               S  => lut_out
             );
       end generate;  
       ip2bus_data_mx(i) <= cry((Bus2IP_RdCE'length + 1)/2);
     end generate;  
  end generate;
  --
  --
  READMUX_SINGLE_CE_GEN : if SINGLE_CE  and INCLUDE_OPBOUT_PSTAGE generate
  begin
      ip2bus_data_mx <= ip2bus_data;
  end generate;

   
  EXCLUDE_RESET_MIR_GEN : if not INCLUDE_RESET_MIR generate
  begin
      bus2ip_reset_i <= Reset;
  end generate;
  --
  INCLUDE_RESET_MIR_GEN : if INCLUDE_RESET_MIR generate
  begin
      RESET_MIR_I0 : reset_mir
      Generic map (
        C_DWIDTH               => C_DWIDTH,
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
        Bus2IP_Data            => bus2ip_data_s1,
        Bus2IP_Reset           => bus2ip_reset_i,
        Reset2Bus_Data         => reset2bus_data,
        Reset2Bus_Ack          => reset2bus_ack,
        Reset2Bus_Error        => reset2bus_error,
        Reset2Bus_Retry        => reset2bus_retry,
        Reset2Bus_ToutSup      => reset2bus_toutsup
      );
  end generate;

  Bus2IP_Reset <= bus2ip_reset_i;



  INTR_CTRLR_GEN : if INCLUDE_INTR generate
      constant NUM_IPIF_IRPT_SRC : natural := 4;
      signal ERRACK_RESERVED: std_logic_vector(0 to 1);
  begin
    ERRACK_RESERVED <= Sln_errack_s2 & '0';
    INTERRUPT_CONTROL_I : interrupt_control
    generic map (
      C_INTERRUPT_REG_NUM    => number_CEs_for(IPIF_INTR),
      C_NUM_IPIF_IRPT_SRC    => NUM_IPIF_IRPT_SRC,
      C_IP_INTR_MODE_ARRAY   => C_IP_INTR_MODE_ARRAY,
      C_INCLUDE_DEV_PENCODER => C_INCLUDE_DEV_IID = 1,
      C_INCLUDE_DEV_ISC      => C_INCLUDE_DEV_ISC = 1,
      C_IRPT_DBUS_WIDTH      => C_DWIDTH
    ) 
    port map (
      Bus2IP_Clk_i        =>  bus2ip_clk_i,
      Bus2IP_Data_sa      =>  bus2ip_data_s1,
      Bus2IP_RdReq_sa     =>  '0',
      Bus2IP_Reset_i      =>  bus2ip_reset_i,
      Bus2IP_WrReq_sa     =>  '0',
      Interrupt_RdCE      =>  bus2ip_rdce_s1(INTR_CE_LO to INTR_CE_HI),
      Interrupt_WrCE      =>  bus2ip_wrce_s1(INTR_CE_LO to INTR_CE_HI),
      IPIF_Reg_Interrupts =>  ERRACK_RESERVED,
      IPIF_Lvl_Interrupts =>  ZERO_SLV(0 to NUM_IPIF_IRPT_SRC-1),
      IP2Bus_IntrEvent    =>  IP2Bus_Intr,
      Intr2Bus_DevIntr    =>  Device_Intr,
      Intr2Bus_DBus       =>  intr2bus_data,
      Intr2Bus_WrAck      =>  intr2bus_wrack,
      Intr2Bus_RdAck      =>  intr2bus_rdack,
      Intr2Bus_Error      =>  intr2bus_error,   -- These are tied low in block
      Intr2Bus_Retry      =>  intr2bus_retry,   --
      Intr2Bus_ToutSup    =>  intr2bus_toutsup  --
    );
  end generate;

--intr2bus_ack <= '1';  -- interrupt control acknowledges in same cycle as
--                      -- the RdCE or WrCE, so ack can be tied high.
  intr2bus_ack <= intr2bus_rdack or intr2bus_wrack;

end implementation;
