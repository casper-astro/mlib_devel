-------------------------------------------------------------------------------
-- $Id: dma_sg_sim.vhd,v 1.3 2003/03/12 01:04:29 ostlerf Exp $
-------------------------------------------------------------------------------
-- dma_sg sim architecture (DMA and scatter gather)
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        dma_sg_sim.vhd
--
-- Description:     See file dma_sg.vhd for a description of this function.
--
-------------------------------------------------------------------------------
-- Structure: 
--
--              dma_sg_sim.vhd
--                |
--                |- dma_sg.vhd
--                |
--                |- dma_sg_pkg.vhd
--                |
--                |- dma_sg_cmp.vhd
--                |
--                |- ctrl_reg.vhd
--                |
--                |- ld_arith_reg.vhd
--                |
--                |- srl_fifo.vhd
--
-------------------------------------------------------------------------------
-- Author:      Farrell Ostler
-- History:
--      FLO     12/19/01        -- Header added
--
--      FLO     07/17/02
-- ^^^^^^
--              Workaround for XST F.23 bug that affects dma_sg,
--              e.g. "XGR_tmp <= dma_cs(cco)"
-- ~~~~~~
--
--      FLO     10/22/02
-- ^^^^^^
--              Put a generate statement around the clock divider so that it
--              is included only if there is a packet channel with interrupt
--              coalescing enabled.
-- ~~~~~~
--
--      FLO     01/10/03
-- ^^^^^^
--              Removed earlier XST workaround restriction that status fifo
--              entries for packet channels had to be on either channel 0 or 1.
--
--  FLO      01/30/03
-- ^^^^^^
--  Added constant DMA_DWIDTH = 32, then made values that depend on the
--  fact that DMASG is a 32-bit device to depend on this constant. Most
--  of these were previously depending on C_OPB_DWIDTH. But, we want to
--  be able to have C_OPB_DWIDTH be 64 bits so that DMA data transfers
--  and bursts work on 64-bit buses such as the PLB.
--
--  Added constant BPBT_BITS and eliminated some places where BPST was
--  assumed to be 4 and BPBT was assumed to be 32.
-- ~~~~~~
--
--  FLO      01/31/03
-- ^^^^^^
--  Changed the Generation of DMA2Bus_MstBE so that it handles both
--  32-bit (DMA_DWIDTH) master operations that it performs relative
--  to its own registers and DMA operations at the full Bus width, i.e.,
--  the width given by C_OPB_AWIDTH.
--
--  Added assertions to check the validity of some of the assumptions
--  upon which the implementation depends.
-- ~~~~~~
--
--  FLO      02/01/03
-- ^^^^^^
--  Fixed generation of dma2bus_addr_sg and dma2ip_addr_sg, which were using
--  BPST_BITS as a way of getting a constant 2. This constant is 2 only if
--  C_OPB_DWIDTH is 32, so the problem appeared with the first attempt
--  to use C_OPB_DWIDTH=64.
-- ~~~~~~
--
--  FLO      02/02/03
-- ^^^^^^
--  Correction to generation of DMA2Bus_MstBE.
--  More corrections of BPST_BITS being used where 2 should have been used.
-- ~~~~~~
--
--  FLO      02/02/03
-- ^^^^^^
--  Added signal DMA2Bus_MstLoc2Loc.
-- ~~~~~~
--
--  FLO      03/03/11
-- ^^^^^^
--  Changed constant DMA_TO_OPB_DWIDTH_FACTOR_BITS from type positive to natural.
--  This was needed to have the C_OPB_DWIDTH = 32 case elaborate properly
--  since the value of this constant is zero for this case.
-- ~~~~~~
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
--ToDo (x = done)
--   x(1) implement the software, per-channel reset.
--   x(2) implement the MIR.
--   x(3) put the right constant in the MIR.
--    (4) Implement the Freeze behavior.
--   x(5) Reverse the ISR bits so that they are on low-order bits.
--   x(6) Implement SGDA and SGEND.
--   x(7) Generate the clear of the bda_written bit when the
--          sgGo=0 condition is interpreted.
--   x(8) Interrupt coalescing, UPC, PCT, PWB and interrupts.
--   x(9) Make SG stop on packet boundaries (including all SR values
--        for started packets being written).
--  x(10) For SG Rx packet, make writing the SR the last activity
--        to complete a packet.
--   (11) Error conditions to detect:
--        (a) SGS=1 but not at end of Tx packet.
--        (b) SGS=1 but not enough buffer space to finish current Rx packet.
--        (c) Underflow or overflow of UPC.
--        (d) Exactly one of SLOCAL, DLOCAL set.
--        (e) Status value becomes available from the IP but there
--            is not a corresponding address saved in the SRAddr FIFO to
--            which to write it.
--  x(12) Implement the PD interrupt.
--   (13) Change pwb_clk so that the first pulse is a period, not
--        a half period, after reset.
--  x(14) num_stages parameterization working with synplify.
--  x(15) Remove the logic that assures that a write to a DMA register is
--        complete before going on after the "LastAck" signal changes to
--        imply this.
--  x(16) Add the SG_BSY status bit to the DMASR at bit 4 and rename
--        BSY (DMASR(0)) to DMA_BSY.
--  x(17) For SG packet tx channels, make DMASR.L a copy of DMACR.L. (Rick
--        Moleres)
--  x(18) Convert PLENGTH to structural.
--  x(19) Convert LENGTH to structural.
--  x(20) Convert SA to structural.
--  x(21) Convert DA to structural.
--   (22) Convert UPC to structural? (appears to be inferring okay)
--   (23) Convert pw_timer to structural?
--  x(24) Handle the case where a Bus2IP_MstRetry is the response to
--        a master operation (DMA and SG not yet covered).
--   (25) Handle the case where a Bus2IP_MstError or Bus2IP_MstTimeout
--        is the response to a master operation (SG not yet covered).
--  x(26) Option to have a synchronous divider for the packet-wait-count
--        time base. (Used to investigate the possibility that the
--        ripple divider was causing clock buffers to be inserted
--        because tools may have been using global buffers for the divider
--        Q-to-Clk signals. The investigation found no such correlation.)
--   (27) Check that UPC, PCT, PWB are excluded when channel is not
--        type 2 or 3 or interrupt coalescing is disabled for the channel.
--
--ToDo. Conditions regarding SG operation.
--  x (a) Go to the next BD if      not SGS and (SGE or (not first and
--                                                       "pkt style"))
--  x (b) sg_active asserts when    not SGS and SGE    and maintains until
--            (SGS or not SGE)
--        and idle
--        and (not "pkt style" or (not SRAddrFIFO_nonempty and first))
--  x (c) Signal SGEND and SGDA interrupts on change from sg_active to
--        not sg_active.
--
--  x (1) Introduce the is_idle signal for when dma_sm is waiting to start
--        processing the next BD or to start a simple DMA operation.
--  x (2) Consider renaming BSY(i) to dma_active(i) and assigning to BSY(i) on
--        register readout.
--  x (3) See if sg_busy can be eliminated as a separate signal.


library ieee;
use ieee.numeric_std.all;
-- VisualHDL gives compile errors when using the explicitly named
-- use clauses, below.
--use ieee.numeric_std.UNSIGNED;
--use ieee.numeric_std.TO_UNSIGNED
--use ieee.numeric_std.TO_INTEGER;
--use ieee.numeric_std."=";
--use ieee.numeric_std."+";
--use ieee.numeric_std."-";
--use ieee.numeric_std."<";
--use ieee.numeric_std.RESIZE;

library ipif_common_v1_00_c;
use ipif_common_v1_00_c.dma_sg_cmp.all;

use ipif_common_v1_00_c.dma_sg_pkg.ceil_log2;
use ipif_common_v1_00_c.dma_sg_pkg.r_RSTMIR;
use ipif_common_v1_00_c.dma_sg_pkg.r_DMACR;
use ipif_common_v1_00_c.dma_sg_pkg.r_SA;
use ipif_common_v1_00_c.dma_sg_pkg.r_DA;
use ipif_common_v1_00_c.dma_sg_pkg.r_LENGTH;
use ipif_common_v1_00_c.dma_sg_pkg.r_DMASR;
use ipif_common_v1_00_c.dma_sg_pkg.r_BDA;
use ipif_common_v1_00_c.dma_sg_pkg.r_SWCR;
use ipif_common_v1_00_c.dma_sg_pkg.r_UPC;
use ipif_common_v1_00_c.dma_sg_pkg.r_PCT;
use ipif_common_v1_00_c.dma_sg_pkg.r_PWB;
use ipif_common_v1_00_c.dma_sg_pkg.r_ISR;
use ipif_common_v1_00_c.dma_sg_pkg.r_IER;
use ipif_common_v1_00_c.dma_sg_pkg.r_PLENGTH;
use ipif_common_v1_00_c.dma_sg_pkg.b_BSY;
use ipif_common_v1_00_c.dma_sg_pkg.b_SINC;
use ipif_common_v1_00_c.dma_sg_pkg.b_DINC;
use ipif_common_v1_00_c.dma_sg_pkg.b_SLOCAL;
use ipif_common_v1_00_c.dma_sg_pkg.b_DLOCAL;
use ipif_common_v1_00_c.dma_sg_pkg.b_SGS;
use ipif_common_v1_00_c.dma_sg_pkg.b_L_dmacr;
use ipif_common_v1_00_c.dma_sg_pkg.b_SGE;
use ipif_common_v1_00_c.dma_sg_pkg.b_DD;
use ipif_common_v1_00_c.dma_sg_pkg.b_DE;
use ipif_common_v1_00_c.dma_sg_pkg.b_PD;
use ipif_common_v1_00_c.dma_sg_pkg.b_PCTR;
use ipif_common_v1_00_c.dma_sg_pkg.b_PWBR;
use ipif_common_v1_00_c.dma_sg_pkg.b_SGDA;
use ipif_common_v1_00_c.dma_sg_pkg.b_SGEND;
use ipif_common_v1_00_c.dma_sg_pkg.bo2sl;
use ipif_common_v1_00_c.dma_sg_pkg.Div_Stages;
use ipif_common_v1_00_c.dma_sg_pkg.UPCB;
use ipif_common_v1_00_c.dma_sg_pkg.PWBB;


library proc_common_v1_00_b;

architecture sim of dma_sg is

    constant RESET_ACTIVE : std_logic := '1';

    constant C_M : natural := C_IPIF_ABUS_WIDTH - 2;
      -- Bus2IP_Addr and DMA2IP_Addr are word addresses;
      -- the low-order two bits of the byte address
      -- are not included.
      -- ToDo, eventually, this should probably change so that
      -- they are byte addresses.

    constant MAJOR_VERSION                : natural := 1;
    constant MINOR_VERSION                : natural := 1;
    constant HW_SW_COMPATIBILITY_REVISION : natural := 0;

    constant LAST_CHAN : natural := C_DMA_CHAN_TYPE'length - 1;
    constant NUM_CHANS : natural := LAST_CHAN+1;
    constant NUM_CHAN_BITS : natural := ceil_log2(NUM_CHANS);
    -- There are NUM_CHANS channels, numbered 0 .. LAST_CHAN.

    constant RPB : natural := 4;    -- Register-pitch bits = the number of bits
                                    -- needed to encode the word addresses
                                    -- of all registers (and reserved register
                                    -- addresses) for a channel. The number
                                    -- of registers and reserved addresses
                                    -- per channel is 2^RPB, so the
                                    -- word address of a register on one channel
                                    -- is separated from the word address of
                                    -- of the same register on the next higher
                                    -- channel by 2^RPB.

    constant BPST : natural := C_OPB_DWIDTH / 8;
                                    -- Bytes per single transfer on the bus.
    constant BPST_BITS : natural := ceil_log2(BPST);
                                    -- Number of bits needed to encode 
                                    -- the range 0 to BPST-1.
    constant TPB  : natural := 8;   -- Transfers per burst (burst length).
                                    -- Make this a power of two or, ToDo,
                                    -- make sure it works for a non p-of-2.
    constant BPBT : natural := BPST * TPB;
                                    -- Bytes per burst transfer on the bus.
    constant BPBT_BITS : natural := ceil_log2(BPBT);

    constant RIPPLE_PW_DIVIDER : boolean := true;

    constant DMA_DWIDTH : natural := 32; -- DMASG is a 32-bit device.

    -- Registers
    type   DMACR_t
             is array (natural range <>) of std_logic_vector(b_SINC to
                                                             b_L_dmacr);

	 signal tmp_C_DMA_BASEADDR  : std_logic_vector(0 to 63);
	   -- XST workaround

    signal DMACR        : DMACR_t(0 to LAST_CHAN);

    type   UNSIGNED_t
             is array (natural range <>) of UNSIGNED(0 to DMA_DWIDTH-1);
    signal SA           : UNSIGNED_t(0 to LAST_CHAN);

    signal DA           : UNSIGNED_t(0 to LAST_CHAN);

    signal LENGTH       : UNSIGNED_t(0 to LAST_CHAN);

    signal BDA          : UNSIGNED_t(0 to LAST_CHAN);

-- XGR_E33    type   SWCR_t
-- XGR_E33             is array (natural range <>) of std_logic_vector(b_SGE to b_SGE);
-- XGR_E33    signal SWCR         : SWCR_t(0 to LAST_CHAN);
    signal SWCR         : std_logic_vector(0 to LAST_CHAN);

    type   UPC_t
             is array (natural range <>) of UNSIGNED(DMA_DWIDTH-UPCB to
                                                     DMA_DWIDTH-1);
    signal UPC          : UPC_t(0 to LAST_CHAN);

    signal PCT          : UPC_t(0 to LAST_CHAN);

    type   PWB_t
             is array (natural range <>) of UNSIGNED(DMA_DWIDTH-PWBB to
                                                     DMA_DWIDTH-1);
    signal PWB          : PWB_t(0 to LAST_CHAN); -- Packet Wait Bound
    signal pw_timer     : PWB_t(0 to LAST_CHAN); -- Timer used in generating
                                                 -- PWBR interrupt.


    signal PLENGTH      : UNSIGNED_t(0 to LAST_CHAN);

    signal  LENGTH_cco   : UNSIGNED(0 to DMA_DWIDTH-1);
    signal PLENGTH_cco   : UNSIGNED(0 to DMA_DWIDTH-1);


    -- Per-channel reset
    signal reset        : std_logic_vector (0 to LAST_CHAN);
    signal prog_reset   : std_logic_vector (0 to LAST_CHAN);

    -- Enables
    signal chan_num     : natural;  -- The channel addressed by Bus2IP_Addr.
    signal chan_sel     : std_logic_vector (0 to LAST_CHAN);
                                    -- Decode of chan_num to one-hot.
    signal cco          : natural range 0 to LAST_CHAN;
                                    -- The channel currently operating. 
    signal cco_onehot   : std_logic_vector (0 to LAST_CHAN);
                                    -- cco decoded to onehot.

    signal RSTMIR_sel   : std_logic;
    signal DMACR_sel    : std_logic;
    signal SA_sel       : std_logic;
    signal DA_sel       : std_logic;
    signal LENGTH_sel   : std_logic;
    signal dmasr_sel    : std_logic;
    signal BDA_sel      : std_logic;
    signal SWCR_sel     : std_logic;
    signal UPC_sel      : std_logic;
    signal PCT_sel      : std_logic;
    signal PWB_sel      : std_logic;
    signal ISR_sel      : std_logic;
    signal IER_sel      : std_logic;
    signal PLENGTH_sel  : std_logic;
    
  -- Read back register muxing
    signal ver_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal dcr_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal  sa_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal  da_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal lnt_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal dsr_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal bda_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal sge_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal upc_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal pct_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal pwb_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal isr_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal ier_i         : std_logic_vector(0 to DMA_DWIDTH-1);
    signal ple_i         : std_logic_vector(0 to DMA_DWIDTH-1);    
  
    

    signal adj : UNSIGNED(0 to BPST_BITS); -- Amt to add or subtr when updating
                                           -- LENGTH and PLENGTH.
    signal  LENGTH_ge_2BPST: std_logic; -- Used in calculating adj.
    signal PLENGTH_ge_2BPST: std_logic; -- Used in calculating adj.
    signal  LENGTH_ge_BPBT : std_logic; -- Used for deciding burst transaction.
    signal PLENGTH_ge_BPBT : std_logic; -- Used for deciding burst transaction.

--ToDo. dec_LENGTH, inc_SA and inc_DA can be combined into a common signal.
    signal dec_LENGTH   : std_logic;
    signal inc_SA       : std_logic;
    signal inc_DA       : std_logic;
    signal dec_PLENGTH  : std_logic;
    signal inc_PLENGTH  : std_logic;
    signal clr_PLENGTH  : std_logic;


    --Register bits and bit fields

    signal SINC         : std_logic_vector(0 to LAST_CHAN);
    signal DINC         : std_logic_vector(0 to LAST_CHAN);
    signal SLOCAL       : std_logic_vector(0 to LAST_CHAN);
    signal DLOCAL       : std_logic_vector(0 to LAST_CHAN);
    signal SGS          : std_logic_vector(0 to LAST_CHAN);
    signal L_tx         : std_logic_vector(0 to LAST_CHAN);

    signal dma_active   : std_logic_vector(0 to LAST_CHAN);
    signal DBE          : std_logic_vector(0 to LAST_CHAN);
    signal DBT          : std_logic_vector(0 to LAST_CHAN);
    signal L_rx         : std_logic_vector(0 to LAST_CHAN);
    signal L            : std_logic_vector(0 to LAST_CHAN);

    signal SGE          : std_logic_vector(0 to LAST_CHAN);

    signal DD           : std_logic_vector(0 to LAST_CHAN);
    signal DE           : std_logic_vector(0 to LAST_CHAN);
    signal PD           : std_logic_vector(0 to LAST_CHAN);
    signal SGDA         : std_logic_vector(0 to LAST_CHAN);
    signal SGEND        : std_logic_vector(0 to LAST_CHAN);
    signal PCTR         : std_logic_vector(0 to LAST_CHAN);
    signal PWBR         : std_logic_vector(0 to LAST_CHAN);

    signal EDD          : std_logic_vector(0 to LAST_CHAN);
    signal EDE          : std_logic_vector(0 to LAST_CHAN);
    signal EPD          : std_logic_vector(0 to LAST_CHAN);
    signal ESGDA        : std_logic_vector(0 to LAST_CHAN);
    signal ESGEND       : std_logic_vector(0 to LAST_CHAN);
    signal EPCTR        : std_logic_vector(0 to LAST_CHAN);
    signal EPWBR        : std_logic_vector(0 to LAST_CHAN);


    -- Other signals.
    signal sgGo         : std_logic_vector(0 to LAST_CHAN);
                          -- SG is enabled and not at end.
    signal dma2bus_wrack_i  : std_logic;
    signal dma2bus_rdack_i  : std_logic;


    -- is_idle: The DMA state machine is waiting to start processing the next
    -- BD or to start a simple DMA operation.
    signal is_idle      : std_logic_vector(0 to LAST_CHAN);

    -- sg_active: SG has been enabled
    -- and started and has not yet reached the point where it is stopped
    -- or disabled and has cleanly finished the work that it started
    -- while active. Cleanly finishing its work includes, for SG packet
    -- Rx and SG packet Tx channels, that all packets that were started
    -- have finished and their status is recorded.
    signal sg_active    : std_logic_vector(0 to LAST_CHAN);
    signal sg_active_d1 : std_logic_vector(0 to LAST_CHAN);
                       
    signal dma_completing : std_logic;
    signal dma_starting : std_logic;
    signal set_DBE, set_DBT, set_L_rx : std_logic;

    signal rx, tx : std_logic_vector(0 to LAST_CHAN);
      -- rx(i) iff channel i is for Rx; tx(i) iff channel i is for Tx
    signal dest_is_a_fifo : std_logic; -- The DMA destination for cco is a fifo.

    signal dma_sel   : std_logic;  -- Master transaction is for dma i/o.
    signal sg_sel    : std_logic;  -- Master transaction is for sg BD i/o.
    signal pl_sel    : std_logic;  -- Master transaction is for PLENGTH i/o.
    signal sr_sel    : std_logic;

    signal dma2bus_addr_dma     : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal dma2ip_addr_dma      : std_logic_vector(0 to C_M-1);
    signal dma2bus_mstwrreq_dma : std_logic;
    signal dma2bus_mstrdreq_dma : std_logic;
    signal dma2bus_mstburst_dma : std_logic;
    signal burst_cond_dma       : std_logic; -- The condition on which the decision
                                         -- to burst is based.

    signal dma2bus_addr_sg      : std_logic_vector(0 to C_OPB_AWIDTH-1);
    signal dma2ip_addr_sg       : std_logic_vector(0 to C_M-1);
    signal dma2bus_mstwrreq_sg  : std_logic;
    signal dma2bus_mstrdreq_sg  : std_logic;
    signal dma2bus_mstburst_sg  : std_logic;

    signal dma2bus_mstwrreq_sr  : std_logic;

    signal dma2bus_mstwrreq_pl  : std_logic;

    signal first            : std_logic_vector(0 to LAST_CHAN);
                                          -- Channel cco is on its first
                                          -- DMA operation of a packet.
    signal update_first     : std_logic;  -- Update first for the cco.

    signal no_bda_link      : std_logic_vector(0 to LAST_CHAN);
      -- The BDA for the corresponding channel has been written while
      -- not sg_active and an operation under the next sg_active tenure has not
      -- started.

    signal load_length     : std_logic_vector(0 to LAST_CHAN);
    signal load_bda        : std_logic_vector(0 to LAST_CHAN);

    signal wr_SRAddrFIFO   : std_logic_vector(0 to LAST_CHAN);
    signal rd_SRAddrFIFO   : std_logic_vector(0 to LAST_CHAN);
    signal SRAddrFIFO_full : std_logic_vector(0 to LAST_CHAN);
    signal SRAddrFIFO_nonempty : std_logic_vector(0 to LAST_CHAN);
    type   SRAddrFIFO_out_t
             is array (natural range <>) of std_logic_vector(
                                                0 to
                                                C_OPB_AWIDTH-1
                                            );
    signal SRAddrFIFO_out  : SRAddrFIFO_out_t(0 to LAST_CHAN);


    type   sg_offset_t
             is array (natural range <>) of UNSIGNED(0 to RPB-1);
    signal sg_offset       : sg_offset_t(0 to LAST_CHAN);
    signal reset_sg_offset : std_logic;
    signal inc_sg_offset   : std_logic_vector(0 to LAST_CHAN);

    signal SRAddrFIFO_cco_hasroom : std_logic;

    signal DMA2Intr_Intr_i : std_logic_vector(0 to LAST_CHAN);

    signal pw_enable_pulse : std_logic;
             -- An enable pulse of one Bus2IP_Clk period at the frequency
             -- of required PWB update.
    signal pwb_eq_0      : std_logic_vector(0 to LAST_CHAN);
    signal pw_timer_eq_0 : std_logic_vector(0 to LAST_CHAN);
    signal upc_eq_0      : std_logic_vector(0 to LAST_CHAN);
    signal pwb_loaded    : std_logic_vector(0 to LAST_CHAN);
    

    
    -- Bitwise "or" of an UNSIGNED value.
    function or_UNSIGNED(s: UNSIGNED) return std_logic is
        variable result: std_logic := '0';
    begin
        if s'ascending then
            for i in s'left to s'right loop
                result := result or s(i);
            end loop;
        else
            for i in s'left downto s'right loop
                result := result or s(i);
            end loop;
        end if;
        return result;
    end or_UNSIGNED;

    -- Find the leftmost bit over the LENGTH registers of all channels.
    function min_length_left(nv: INTEGER_ARRAY_TYPE) return natural is
        variable largest_width : natural := 0;
    begin
        for i in 0 to LAST_CHAN loop
            if nv(i) > largest_width then largest_width := nv(i); end if;
        end loop;
        return C_OPB_AWIDTH - largest_width;
    end min_length_left;

    -- LENGTHS_LEFT gives the minimum left index over all channels.
    -- It corresponds to the widest LENGTH register required.
    constant LENGTHS_LEFT : natural := min_length_left(C_DMA_LENGTH_WIDTH);

    function zero_vector(n: natural) return UNSIGNED is
        variable result : UNSIGNED(0 to n-1) := (others => '0');
    begin
        return result;
    end zero_vector;

    function clock_divider_needed(C_DMA_CHAN_TYPE,
                                  C_INTR_COALESCE: INTEGER_ARRAY_TYPE)
                                 return boolean is
    begin
        for i in C_DMA_CHAN_TYPE'range loop
            if (C_DMA_CHAN_TYPE(i) = 2 or C_DMA_CHAN_TYPE(i) = 3)
               and C_INTR_COALESCE(i) = 1 then
              return true;
            end if;
        end loop;
        return false;
    end clock_divider_needed;

    function to_string(n: natural) return STRING is
        variable s : string(20 downto 1);
        variable j : natural := 1;
        variable m : natural := n;
        type decimal_digit_to_char is array (natural range 0 to 9) of character;
        constant tab : decimal_digit_to_char :=
                       ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
    begin
        loop
            s(j) := tab(m mod 10);
            m := m / 10;
            exit when m = 0;
            j := j+1;
        end loop;
        return s(j downto 1);
    end to_string;

    function is_power_of_2(n: positive) return boolean is
    begin
        if n = 1 then return true;
        elsif n mod 2 = 1 then return false;
        else return is_power_of_2(n/2);
        end if;
    end is_power_of_2;

begin --( architecture

    ----------------------------------------------------------------------------
    -- Checks on parameters and interface signals.
    ----------------------------------------------------------------------------
    assert Bus2IP_Data'length = DMA_DWIDTH
    report "Bus2IP_Data is a vector of size " &
           to_string(Bus2IP_Data'length) &
           ", which is not equal, as required, to " &
           to_string(DMA_DWIDTH) & "."
    severity failure;
    --
    --ToDo, Add checks for C_OPB_DWIDTH and DMA_DWIDTH a power of two in bytes.
    --      When asserts, below, have been proven, remove this ToDo comment.
    assert is_power_of_2(C_OPB_DWIDTH)
    report "C_OPB_DWIDTH is " &
           to_string(C_OPB_DWIDTH) &
           ", which is not a power of two, as required."
    severity failure;
    assert is_power_of_2(DMA_DWIDTH)
    report "DMA_DWIDTH is " &
           to_string(DMA_DWIDTH) &
           ", which is not a power of two, as required."
    severity failure;
    --
    --ToDo, Add check that TPB is a power of two...or study and remove
    --      any implementation features that require TBP and BPBT to be
    --      a power of two.
    --      When assert, below, has been proven, remove this ToDo comment
    --      but leave note that allowing TBP to be non power of two is
    --      possible if the implementation is adjusted.
    assert is_power_of_2(TPB)
    report "TPB is " &
           to_string(TPB) &
           ", which is not a power of two, as required."
    severity failure;
    --
    --ToDo, add check that C_OPB_DWIDTH >= DMA_DWIDTH;

    tmp_C_DMA_BASEADDR <= C_DMA_BASEADDR; -- ToDo, XST workaround

--ToDo, handle byte enable signals (probably return error on non BE=1111)

    -- Assignment of register bits and bit fields

    SINC_GENERATE: for i in 0 to LAST_CHAN generate
        SINC(i) <= DMACR(i)(0);
    end generate;

    DINC_GENERATE: for i in 0 to LAST_CHAN generate
        DINC(i) <= DMACR(i)(1);
    end generate;

    SLOCAL_GENERATE: for i in 0 to LAST_CHAN generate
        SLOCAL(i) <= DMACR(i)(2);
    end generate;

    DLOCAL_GENERATE: for i in 0 to LAST_CHAN generate
        DLOCAL(i) <= DMACR(i)(3);
    end generate;

    SGS_GENERATE: for i in 0 to LAST_CHAN generate
--ToDo. Check that DMACR(i)(4) gets optimized away by synthesis for
--      C_DMA_CHAN_TYPE(i) = 0.
        SGS(i) <= '1' when C_DMA_CHAN_TYPE(i) = 0 else
                  DMACR(i)(4);
    end generate;

    SGE_GENERATE: for i in 0 to LAST_CHAN generate
--ToDo. Check that SWCR(i)(0) gets optimized away by synthesis for
--      C_DMA_CHAN_TYPE(i) = 0.
-- XGR_E33        SGE(i) <= '0' when C_DMA_CHAN_TYPE(i) = 0 else
-- XGR_E33                  SWCR(i)(0);
        SGE(i) <= '0' when C_DMA_CHAN_TYPE(i) = 0 else
                  SWCR(i);
    end generate;

    SGGO_GENERATE: for i in 0 to LAST_CHAN generate
        sgGo(i) <=    (not SGS(i) and SGE(i))
                   or -- If pkt SG, then get to a packet boundary.
                      (    not first(i)
                       and bo2sl(   C_DMA_CHAN_TYPE(i) = 2
                                 or C_DMA_CHAN_TYPE(i) = 3
                                )
                      );
    end generate;

    L_TX_GEN: for i in 0 to LAST_CHAN generate
        L_tx(i) <= '0' when (C_DMA_CHAN_TYPE(i) /= 2) else DMACR(i)(b_L_dmacr);
    end generate;


    --- Address decoding

    -- channel selects
    chan_num <= TO_INTEGER(UNSIGNED(Bus2IP_Addr(   C_M-RPB-NUM_CHAN_BITS
                                                  to C_M-RPB-1             )));
    CHAN_SELECTION: process (chan_num)
    begin
      for i in 0 to LAST_CHAN loop
          chan_sel(i) <= bo2sl(chan_num = i);
      end loop;
    end process;


    CCO_ONEHOT_PROCESS: process (cco)
    begin
      for i in 0 to LAST_CHAN loop
          cco_onehot(i) <= bo2sl(cco = i);
      end loop;
    end process;

    RX_GEN: for i in 0 to LAST_CHAN generate
        rx(i) <= bo2sl(C_DMA_CHAN_TYPE(i) = 3) and (sgGo(i) or sg_active(i));
          -- A sg rx packet channel can be used for simple DMA when it is not
          -- operating under SG.
    end generate;

    dest_is_a_fifo <= bo2sl(    C_DMA_CHAN_TYPE(cco) = 2 -- ToDo. Might want to
                            and sg_active(cco) = '1'); -- consider how this info
                                                       -- is gotten. Perhaps it
                                                       -- should be a dmacr bit
                                                       -- or if not, perhaps the
                                                       -- DA should be
                                                       -- read-only. hmmmn.

    TX_GEN: for i in 0 to LAST_CHAN generate
        tx(i) <= bo2sl(C_DMA_CHAN_TYPE(i) = 2) and (sgGo(i) or sg_active(i));
          -- A sg tx packet channel can be used for simple DMA when it is not
          -- operating under SG.
    end generate;

    -- register selects
    RSTMIR_sel  <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_RSTMIR, RPB)));
    DMACR_sel   <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_DMACR, RPB))); 
    SA_sel      <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_SA, RPB)));
    DA_sel      <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_DA, RPB))); 
    LENGTH_sel  <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_LENGTH, RPB))); 
    DMASR_sel   <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_DMASR, RPB))); 
    BDA_sel     <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_BDA, RPB))); 
    SWCR_sel    <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_SWCR, RPB))); 
    UPC_sel     <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_UPC, RPB))); 
    PCT_sel     <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_PCT, RPB))); 
    PWB_sel     <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_PWB, RPB))); 
    ISR_sel     <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_ISR, RPB))); 
    IER_sel     <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_IER, RPB))); 
    PLENGTH_sel <= bo2sl(Bus2IP_Addr(C_M-RPB to C_M-1) =
                   std_logic_vector(TO_UNSIGNED(r_PLENGTH, RPB))); 

    --= end, Address decoding


    --- Various logic

    ----------------------------------------------------------------------------
    -- These statements calculate adj.
    -- Either LENGTH or PLENGTH is the evaluated value, depending on whether the
    -- channel is rx. If the evaluated value is >= BPST, adj is BPST, which
    -- means that the low-order two bits may need to be masked. Otherwise,
    -- adj is the two low-order bits of the evaluated value.
    ----------------------------------------------------------------------------

     LENGTH_ge_BPBT<= or_UNSIGNED( LENGTH_cco(LENGTHS_LEFT to 
                                              DMA_DWIDTH - BPBT_BITS - 1));
    PLENGTH_ge_BPBT<= or_UNSIGNED(PLENGTH_cco(LENGTHS_LEFT to
                                              DMA_DWIDTH - BPBT_BITS - 1));

     LENGTH_ge_2BPST <=  LENGTH_ge_BPBT or
                         or_UNSIGNED( LENGTH_cco(DMA_DWIDTH - BPBT_BITS to
                                                 DMA_DWIDTH - BPST_BITS - 2));
    PLENGTH_ge_2BPST <= PLENGTH_ge_BPBT or
                         or_UNSIGNED(PLENGTH_cco(DMA_DWIDTH - BPBT_BITS to
                                                 DMA_DWIDTH - BPST_BITS - 2));

    ----------------------------------------------------------------------------
    -- The next process maintains the global adj value with
    -- respect to the cco.
    -- Notes:
    -- (1) Whenever adj is to be used to update channel n, cco=n must hold
    -- for both the previous and current cycles.
    -- (2) adj is sourced from FFs to reduce path time.
    -- (3) When dec_length is true, we are looking ahead by
    -- an extra BPST, which is the reason for the >= 2*BPST check
    -- instead of a >= BPST check.
    -- (4) It is required that BPST be a power of 2.
    ----------------------------------------------------------------------------
    ADJ_PROCESS: process (Bus2IP_Clk)
        variable len : UNSIGNED(0 to LENGTH_cco'length-1);
        variable len_ge_2BPST : std_logic;
    begin
      if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
        if rx(cco)='0' then
            len := LENGTH_cco;
            len_ge_2BPST := LENGTH_ge_2BPST;
        else
            len := PLENGTH_cco;
            len_ge_2BPST := PLENGTH_ge_2BPST;
        end if;
        adj(0) <=    len_ge_2BPST
                  or (not dec_length and len(  DMA_DWIDTH
                                             - BPST_BITS
                                             - 1)
                     );
        for i in 1 to BPST_BITS LOOP
          -- The following expression zeroes non high-order adj bits
          -- when the next transfer will be BPST, otherwise
          -- adj becomes what is left to transfer, i.e. the corresponding
          -- adj bit is taken from the corresponding len bit.
          adj(i) <=     not(   len_ge_2BPST
                            or (not dec_length and len(  DMA_DWIDTH
                                                       - BPST_BITS
                                                       - 1)
                               )
                           )
                    and len(DMA_DWIDTH - BPST_BITS + i - 1);
        end loop;
      end if;
    end process;


    DMA2Bus_Error   <= '0';
    DMA2Bus_Retry   <= '0';

    Bus2IP_DMA_Ack <= '0';

    DMA2Bus_ToutSup <= '0';

    DMA2INTR_GENERATE: for i in 0 to LAST_CHAN generate
        DMA2Intr_Intr_i(i) <=    (DD(i)    and EDD(i))
                              or (DE(i)    and EDE(i))
                              or (PD(i)    and EPD(i))
                              or (PCTR(i)  and EPCTR(i))
                              or (PWBR(i)  and EPWBR(i))
                              or (SGDA(i)  and ESGDA(i))
                              or (SGEND(i) and ESGEND(i));
        DMA2Intr_Intr(i) <= DMA2Intr_Intr_i(i);
    end generate;


    L_GEN: for i in 0 to LAST_CHAN generate
        L(i) <= (   (tx(i) and L_tx(i))
                 or (rx(i) and L_rx(i))
                );
    end generate;

    FIRST_PROCESS: process (Bus2IP_Clk) is
    begin
        if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
            for i in 0 to LAST_CHAN loop
                if reset(i) = '1' then
                    first(i) <= bo2sl(C_DMA_CHAN_TYPE(i) = 2 or
                                      C_DMA_CHAN_TYPE(i) = 3);
                elsif update_first = '1' and cco = i then
                    first(i) <= L(i);
                end if;
            end loop;
        end if;
    end process;

    SG_OFFSET_PROCESS: process (Bus2IP_Clk) is
    begin
        if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
            for i in 0 to LAST_CHAN loop
                if (reset(i) or (reset_sg_offset and cco_onehot(i))) = '1' then
                    sg_offset(i) <= (others => '0');
                elsif inc_sg_offset(i) = '1' then
                    sg_offset(i) <= sg_offset(i) + 1;
                end if;
            end loop;
        end if;
    end process;

    SRAddrFIFO_cco_hasroom <= '1' when     (C_DMA_CHAN_TYPE(cco) = 2 or
                                            C_DMA_CHAN_TYPE(cco) = 3)
                                       and SRAddrFIFO_full(cco) = '0'
                              else '0';

    --= end, Various logic


    --- Clock divider.

    INCLUDE_CLOCK_DIVIDER: if clock_divider_needed(C_DMA_CHAN_TYPE,
                                                   C_INTR_COALESCE) generate
        constant num_stages : natural
                            := Div_Stages(base_period  => C_CLK_PERIOD_PS,
                                          target_period=>  C_PACKET_WAIT_UNIT_NS
                                                         * 1000
                                         );
    begin

      --------------------------------------------------------------------------
      -- This option implements the packet-wait timebase divider using a
      -- Q-to-Clk ripple counter.
      --------------------------------------------------------------------------
      GEN_RIPPLE_PW_DIVIDER: if RIPPLE_PW_DIVIDER generate

        signal divby2to : std_logic_vector(0 to num_stages);
        signal ripout, ripout_d1, ripout_d2, ripout_d3 : std_logic;

      begin
        divby2to(0) <=  Bus2IP_Clk;
        ripout      <=  divby2to(num_stages);
      
        ------------------------------------------------------------------------
        -- Clock division via a ripple counter.
        ------------------------------------------------------------------------
        DIVIDE_CLK: for i in 1 to num_stages generate
           DIV_FF: process(divby2to(i-1), Bus2IP_Reset)
           begin
              if Bus2IP_Reset = RESET_ACTIVE then
                  divby2to(i) <= '0';
              else
                  if divby2to(i-1)'event and divby2to(i-1) = '1' then
                      divby2to(i) <= not divby2to(i);
                  end if;
              end if; 
           end process; 
        end generate;

        ------------------------------------------------------------------------
        -- This process syncronizes the output of the ripple counter into
        -- the Bus2IP_Clk domain and sets up edge detection.
        ------------------------------------------------------------------------
        SYNC_AND_ENABLE: process(Bus2IP_Clk, Bus2IP_Reset)
        begin
            if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
                if Bus2IP_Reset = RESET_ACTIVE then
                    ripout_d1 <= '0';
                    ripout_d2 <= '0';
                    ripout_d3 <= '0';
                else
                    ripout_d1 <= divby2to(num_stages);
                    ripout_d2 <= ripout_d1;
                    ripout_d3 <= ripout_d2;
                end if;
            end if; 
        end process; 

        ------------------------------------------------------------------------
        -- Edge detection gives a one-pulse signal in the Bus2IP_Clk domain.
        ------------------------------------------------------------------------
        pw_enable_pulse <= not ripout_d2 and ripout_d3;

      end generate GEN_RIPPLE_PW_DIVIDER;


      --------------------------------------------------------------------------
      -- This option implements the packet-wait timebase divider using a
      -- synchronous counter.
      --------------------------------------------------------------------------
      GEN_SYNC_PW_DIVIDER: if not RIPPLE_PW_DIVIDER generate
         constant ZERO_NUM_STAGES : std_logic_vector(0 to num_stages-1)
                                  := (others => '0');
        signal sdivby2to : std_logic_vector(num_stages downto 1);
        signal sdivby2to_num_stages_d1 : std_logic;
      begin

        SYNC_PW_DIVIDER : PROCESS(Bus2IP_Clk, Bus2IP_Reset)
        begin
            if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
                if Bus2IP_Reset = RESET_ACTIVE then
                    sdivby2to <= (others => '0');
                else
                    sdivby2to <= std_logic_vector(UNSIGNED(sdivby2to) + 1);
                end if;
            end if; 
        end process;


        OUPUT_D1: process(Bus2IP_Clk, Bus2IP_Reset)
        begin
            if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
                if Bus2IP_Reset = RESET_ACTIVE then
                    sdivby2to_num_stages_d1 <= '0';
                else
                    sdivby2to_num_stages_d1 <= sdivby2to(num_stages);
                end if;
            end if; 
        end process; 

        pw_enable_pulse <=     not sdivby2to(num_stages)
                           and sdivby2to_num_stages_d1;

      end generate GEN_SYNC_PW_DIVIDER;

    end generate INCLUDE_CLOCK_DIVIDER;

    EXCLUDE_CLOCK_DIVIDER: if not clock_divider_needed(C_DMA_CHAN_TYPE,
                                                       C_INTR_COALESCE) generate
        pw_enable_pulse <=  '0';
    end generate EXCLUDE_CLOCK_DIVIDER;

    --= end, Clock divider.


    --- Register implementations

    ---------------------------------------------------------------------  
    -- These processes generate the DMA2Bus_WrAck.
    ---------------------------------------------------------------------  
    DMA2BUS_WRACK_I_PROCESS: process(Bus2IP_Clk)
    begin
        if (Bus2IP_Clk'event and Bus2IP_Clk = '1') then
            if (Bus2IP_Reset = RESET_ACTIVE) then
                dma2bus_wrack_i <= '0';
--ToDo. The last conjunct probably not needed.
            elsif ((DMA_WrCE and Bus2IP_WrReq)='1' and dma2bus_wrack_i='0') then
                dma2bus_wrack_i <= '1';
            else
                dma2bus_wrack_i <= '0';
            end if;
        end if;
    end process;

    DMA2Bus_WrAck <= dma2bus_wrack_i;

    ---------------------------------------------------------------------  
    -- These processes implement the channel reset "register".
    ---------------------------------------------------------------------  
    PERP_CHANNEL_RESET_GEN: for i in 0 to LAST_CHAN generate
        prog_reset(i) <=
                    bo2sl(    (chan_sel(i) and RSTMIR_sel and dma2bus_wrack_i) = '1'
                          and (Bus2IP_Data(DMA_DWIDTH-4 to
                               DMA_DWIDTH-1)) = "1010"
                         );
        reset(i) <=    bo2sl(Bus2IP_Reset = RESET_ACTIVE)
                    or prog_reset(i);

    end generate;


    ---------------------------------------------------------------------  
    -- This process implements a DMACR register for each channel.
    ---------------------------------------------------------------------  
--  DMACR_REG_PROCESS: process (Bus2IP_Clk)
--  begin
--    for i in 0 to LAST_CHAN loop
--      if Bus2IP_Clk'event and Bus2IP_Clk='1' then
--          if (reset(i) = RESET_ACTIVE) then
--              DMACR(i)(0 to 6) <= "1001000"; 
--          elsif (chan_sel(i) and DMACR_sel and dma2bus_wrack_i) = '1' then
--              DMACR(i)(0 to 6) <= Bus2IP_Data(0 to 6);
--          end if;
--      end if;
--    end loop;
--  end process;


    DMACR_GENERATE: for i in 0 to LAST_CHAN generate
        I_DMACR: ctrl_reg_0_to_6
--      I_DMACR: entity ctrl_reg(sim)
            generic map ("1001100")
            port map (
               clk      => Bus2IP_Clk,
               rst      => reset(i),
               chan_sel => chan_sel(i),
               reg_sel  => DMACR_sel,
               wr_ce    => dma2bus_wrack_i,
               d        => Bus2IP_Data(b_SINC to b_L_dmacr),
               q        => DMACR(i)(b_SINC to b_L_dmacr)
            );
    end generate;

    SWCR_GENERATE: for i in 0 to LAST_CHAN generate
        I_SWCR: ctrl_reg_0_to_0
            generic map ("0")
            port map (
               clk      => Bus2IP_Clk,
               rst      => reset(i),
               chan_sel => chan_sel(i),
               reg_sel  => SWCR_sel,
               wr_ce    => dma2bus_wrack_i,
-- XGR_E33               d        => Bus2IP_Data(b_SGE to b_SGE),
-- XGR_E33               q        => SWCR(i)(b_SGE to b_SGE)
               d        => Bus2IP_Data(b_SGE),
               q        => SWCR(i)
            );
    end generate;


--r ---------------------------------------------------------------------  
--r -- This process implements a SA register for each channel.
--r ---------------------------------------------------------------------  
--r SA_REG_PROCESS: process (Bus2IP_Clk)
--r begin
--r   for i in 0 to LAST_CHAN loop
--r      if Bus2IP_Clk'event and Bus2IP_Clk='1' then
--r          if (reset(i) = RESET_ACTIVE) then
--r              SA(i) <= (others => '0'); 
--r          elsif (cco_onehot(i) and SINC(i) and inc_SA) = '1' then
--r              SA(i) <= SA(i) + BPST;
--r          elsif (chan_sel(i) and SA_sel and dma2bus_wrack_i) = '1' then
--r              SA(i) <= UNSIGNED(Bus2IP_Data);
--r          end if;
--r      end if;
--r   end loop;
--r end process;


    ---------------------------------------------------------------------
    -- The below implements a SA for each channel.
    ---------------------------------------------------------------------
    SA_REG_GEN: for i in 0 to LAST_CHAN generate
        T_GEN:  if C_DMA_CHAN_TYPE(i) = 0  or C_DMA_CHAN_TYPE(i) = 1 or
                   C_DMA_CHAN_TYPE(i) = 2  or C_DMA_CHAN_TYPE(i) = 3
        generate
            --------------------------------------------------------------------
            -- XGR WA (OP,    LOAD and    RST    renamed to
            --         OP_EF, LOAD_EF and RST_EF ... t0111.44) [XST workaround]
            --------------------------------------------------------------------
            signal OP_EF, LOAD_EF, RST_EF : std_logic;
            signal qslv          : std_logic_vector(SA(i)'range);
        begin
          --
          RST_EF  <= reset(i);
          LOAD_EF <= (chan_sel(i) and SA_sel and dma2bus_wrack_i);
          OP_EF <= (cco_onehot(i) and SINC(i) and inc_SA);
          --
          I_SA : component ld_arith_reg
            generic map (
              C_ADD_SUB_NOT =>  true,
              C_REG_WIDTH   =>  SA(i)'length,
              C_RESET_VALUE => "00000000000000000000000000000000",
              C_LD_WIDTH    =>  SA(i)'length,
              C_LD_OFFSET   =>  0,
              C_AD_WIDTH    =>  1,
              C_AD_OFFSET   =>  BPST_BITS
            )
            port map (
              CK   => Bus2IP_Clk,
              RST  => RST_EF,
              Q    => qslv(SA(i)'range),
              LD   => Bus2IP_Data(0 to DMA_DWIDTH-1),
              AD   => "1",
              LOAD => LOAD_EF,
              OP   => OP_EF
            );
          --
         SA(i)(SA(i)'range) <=
             UNSIGNED(qslv(SA(i)'range));
        end generate;
    end generate;


    ---------------------------------------------------------------------
    -- The below implements a DA for each channel.
    ---------------------------------------------------------------------
    DA_REG_GEN: for i in 0 to LAST_CHAN generate
        T_GEN:  if C_DMA_CHAN_TYPE(i) = 0  or C_DMA_CHAN_TYPE(i) = 1 or
                   C_DMA_CHAN_TYPE(i) = 2  or C_DMA_CHAN_TYPE(i) = 3
        generate
            --------------------------------------------------------------------
            -- XGR WA (OP,    LOAD and    RST    renamed to
            --         OP_EF, LOAD_EF and RST_EF ... t0111.44) [XST workaround]
            --------------------------------------------------------------------
            signal OP_EF, LOAD_EF, RST_EF : std_logic;
            signal qslv          : std_logic_vector(DA(i)'range);
        begin
          --
          RST_EF  <= reset(i);
          LOAD_EF <= (chan_sel(i) and DA_sel and dma2bus_wrack_i);
          OP_EF <= (cco_onehot(i) and DINC(i) and inc_DA);
          --
          I_DA : component ld_arith_reg
            generic map (
              C_ADD_SUB_NOT =>  true,
              C_REG_WIDTH   =>  DA(i)'length,
              C_RESET_VALUE => "00000000000000000000000000000000",
              C_LD_WIDTH    =>  DA(i)'length,
              C_LD_OFFSET   =>  0,
              C_AD_WIDTH    =>  1,
              C_AD_OFFSET   =>  BPST_BITS
            )
            port map (
              CK   => Bus2IP_Clk,
              RST  => RST_EF,
              Q    => qslv(DA(i)'range),
              LD   => Bus2IP_Data(0 to DMA_DWIDTH-1),
              AD   => "1",
              LOAD => LOAD_EF,
              OP   => OP_EF
            );
          --
         DA(i)(DA(i)'range) <=
             UNSIGNED(qslv(DA(i)'range));
        end generate;
    end generate;


    LOAD_LENGTH_GENERATE: for i in 0 to LAST_CHAN generate
        load_length(i) <= chan_sel(i) and LENGTH_sel and dma2bus_wrack_i;
    end generate;

    LOAD_BDA_GENERATE: for i in 0 to LAST_CHAN generate
        load_bda(i) <= chan_sel(i) and BDA_sel and dma2bus_wrack_i;
    end generate;


    ---------------------------------------------------------------------
    -- The below implements a LENGTH register of the correct size for
    -- each channel.
    ---------------------------------------------------------------------
    LENGTH_REG_GEN: for i in 0 to LAST_CHAN generate
        T_GEN:  if C_DMA_CHAN_TYPE(i) = 0  or C_DMA_CHAN_TYPE(i) = 1 or
                   C_DMA_CHAN_TYPE(i) = 2  or C_DMA_CHAN_TYPE(i) = 3
        generate
            --------------------------------------------------------------------
            -- XGR WA (OP,    LOAD and    RST    renamed to
            --         OP_EF, LOAD_EF and RST_EF ... t0111.44) [XST workaround]
            --------------------------------------------------------------------
            signal OP_EF, LOAD_EF, RST_EF : std_logic;
            signal qslv          : std_logic_vector(0 to DMA_DWIDTH-1);
        begin
          --
          RST_EF  <= reset(i) or ((cco_onehot(i) and clr_PLENGTH));
          LOAD_EF <= (chan_sel(i) and LENGTH_sel and dma2bus_wrack_i);
          OP_EF <= (cco_onehot(i) and dec_LENGTH);
          --
          I_LENGTH : component ld_arith_reg
            generic map (
              C_ADD_SUB_NOT =>  false,
              C_REG_WIDTH   =>  C_DMA_LENGTH_WIDTH(i),
              C_RESET_VALUE => "00000000000000000000000000000000",
              C_LD_WIDTH    =>  C_DMA_LENGTH_WIDTH(i),
              C_LD_OFFSET   =>  0,
--ToDo        C_AD_WIDTH    =>  3,
              C_AD_WIDTH    =>  adj'length,
              C_AD_OFFSET   =>  0
            )
            port map (
              CK   => Bus2IP_Clk,
              RST  => RST_EF,
              Q    => qslv(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                           DMA_DWIDTH-1),
              LD   => Bus2IP_Data(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                                     DMA_DWIDTH-1),
              AD   => std_logic_vector(adj),
              LOAD => LOAD_EF,
              OP   => OP_EF
            );
          --
         LENGTH(i)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                   DMA_DWIDTH-1) <=
             unsigned(qslv(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                           DMA_DWIDTH-1));
         LENGTH(i)(0 to DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i)-1) <=
             (others => '0');
        end generate;
    end generate;


    ---------------------------------------------------------------------
    -- The below implements a PLENGTH register of the correct size for
    -- each channel that requires one.
    ---------------------------------------------------------------------
    PLENGTH_REG_GEN: for i in 0 to LAST_CHAN generate
        T0or1_GEN: if C_DMA_CHAN_TYPE(i) = 0 or C_DMA_CHAN_TYPE(i) = 1 generate
            PLENGTH(i) <= (others => '0');
        end generate;
        T2_GEN: if C_DMA_CHAN_TYPE(i) = 2  or C_DMA_CHAN_TYPE(i) = 3 generate
            --------------------------------------------------------------------
            -- XGR WA (OP,    LOAD and    RST    renamed to
            --         OP_EF, LOAD_EF and RST_EF ... t0111.44) [XST workaround]
            --------------------------------------------------------------------
            signal OP_EF, LOAD_EF, RST_EF : std_logic;
            signal qslv          : std_logic_vector(0 to DMA_DWIDTH-1);
        begin
          --
          RST_EF  <= reset(i) or ((cco_onehot(i) and clr_PLENGTH));
          LOAD_EF <= (chan_sel(i) and PLENGTH_sel and dma2bus_wrack_i);
          OP_ADD_GEN: if C_DMA_CHAN_TYPE(i) = 2 generate
              OP_EF <= (cco_onehot(i) and inc_PLENGTH);
          end generate;
          OP_SUB_GEN: if C_DMA_CHAN_TYPE(i) = 3 generate
              OP_EF <= (cco_onehot(i) and dec_PLENGTH);
          end generate;
          --
          I_PLENGTH : component ld_arith_reg
            generic map (
              C_ADD_SUB_NOT =>  C_DMA_CHAN_TYPE(i) = 2,
              C_REG_WIDTH   =>  C_DMA_LENGTH_WIDTH(i),
              C_RESET_VALUE => "00000000000000000000000000000000",
              C_LD_WIDTH    =>  C_DMA_LENGTH_WIDTH(i),
              C_LD_OFFSET   =>  0,
--ToDo        C_AD_WIDTH    =>  3,
              C_AD_WIDTH    =>  adj'length,
              C_AD_OFFSET   =>  0
            )
            port map (
              CK   => Bus2IP_Clk,
              RST  => RST_EF,
              Q    => qslv(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                           DMA_DWIDTH-1),
              LD   => Bus2IP_Data(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                                     DMA_DWIDTH-1),
              AD   => std_logic_vector(adj),
              LOAD => LOAD_EF,
              OP   => OP_EF
            );
          --
          PLENGTH(i)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                     DMA_DWIDTH-1) <=
              unsigned(qslv(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i) to
                            DMA_DWIDTH-1));
          PLENGTH(i)(0 to DMA_DWIDTH-C_DMA_LENGTH_WIDTH(i)-1)
              <= (others => '0');
        end generate;
    end generate;


    ---------------------------------------------------------------------  
    -- dma_active bit (set when LENGTH loaded, cleared by dma state machine).
    ---------------------------------------------------------------------  
    DMA_ACTIVE_BIT_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 dma_active(i) <= '0';
             elsif load_length(i) = '1' then
                 dma_active(i) <= '1';
             elsif dma_completing = '1' and cco = i then
                 dma_active(i) <= '0';
             end if;
         end if;
      end loop;
    end process;

    ---------------------------------------------------------------------  
    -- This process implements a DMASR register for each channel.
    -- (note: DMA_BSY and SG_BSY implemented separately.)
    ---------------------------------------------------------------------  
    DMASR_REG_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
          if Bus2IP_Clk'event and Bus2IP_Clk='1' then
              if (reset(i) = RESET_ACTIVE) then
                  DBE(i) <= '0';
                  DBT(i) <= '0';
                  L_rx(i)   <= '0';
              elsif cco = i then
                  if dma_starting = '1' then
                      DBE(i) <= '0';
                      DBT(i) <= '0';
                      L_rx(i) <= '0';
                  elsif set_DBE = '1' then
                      DBE(i) <= '1';
                  elsif set_DBT = '1' then
                      DBT(i) <= '1';
                  elsif set_L_rx= '1' then
                      L_rx(i) <= '1';
                  end if;
              end if;
          end if;
      end loop;
    end process;


    ---------------------------------------------------------------------  
    -- This process implements a BDA register for each channel that
    -- supports scatter/gather.
    ---------------------------------------------------------------------  
    BDA_REG_PROCESS: process (Bus2IP_Clk)
    begin
      if Bus2IP_Clk'event and Bus2IP_Clk='1' then
        for i in 0 to LAST_CHAN loop
          if    C_DMA_CHAN_TYPE(i) = 1
             or C_DMA_CHAN_TYPE(i) = 2
             or C_DMA_CHAN_TYPE(i) = 3 then
              if (reset(i) = RESET_ACTIVE) then
                  BDA(i) <= ( others => '0');
                  no_bda_link(i) <= '0';
              elsif load_bda(i) = '1' then
                  BDA(i) <= UNSIGNED(Bus2IP_Data);
                  no_bda_link(i) <= not sg_active(i);
              elsif (cco_onehot(i) and sg_active(i) and not is_idle(i)) = '1' then
                  no_bda_link(i) <= '0';
              end if;
          else
              no_bda_link(i) <= '0';
          end if;
        end loop;
      end if;
    end process;

    ----------------------------------------------------------------------------
    -- The processes below implement the ISR interrupt bits for each channel.
    ----------------------------------------------------------------------------
    DD_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 DD(i) <= '0';
             elsif dma_completing = '1' and cco_onehot(i) = '1' then
                 DD(i) <= '1';
             elsif (chan_sel(i) and ISR_sel and dma2bus_wrack_i) = '1' then
                 DD(i) <= DD(i) xor Bus2IP_Data(b_DD); -- Tog on wr.
             end if;
         end if;
      end loop;
    end process;

    DE_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 DE(i) <= '0';
             elsif (set_DBE or set_DBT) = '1' and cco_onehot(i) = '1' then
                 DE(i) <= '1';
             elsif (chan_sel(i) and ISR_sel and dma2bus_wrack_i) = '1' then
                 DE(i) <= DE(i) xor Bus2IP_Data(b_DE); -- Tog on wr.
             end if;
         end if;
      end loop;
    end process;

    PD_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 PD(i) <= '0';
             elsif rd_SRAddrFIFO(i) = '1' then
                 PD(i) <= '1';
             elsif (chan_sel(i) and ISR_sel and dma2bus_wrack_i) = '1' then
                 PD(i) <= PD(i) xor Bus2IP_Data(b_PD); -- Tog on wr.
             end if;
         end if;
      end loop;
    end process;

    PCTR_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 PCTR(i) <= '0';
             elsif (UPC(i) >= PCT(i)) and (PCT(i) /= 0) then
                 PCTR(i) <= '1';
             elsif (chan_sel(i) and ISR_sel and dma2bus_wrack_i) = '1' then
                 PCTR(i) <= PCTR(i) xor Bus2IP_Data(b_PCTR); -- Tog on wr.
             end if;
         end if;
      end loop;
    end process;

    PWBR_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 PWBR(i) <= '0';
             elsif C_DMA_CHAN_TYPE(i) > 1 and
                   C_INTR_COALESCE(i) = 1 and
                   (pw_timer_eq_0(i)) = '1' then
                 PWBR(i) <= '1';
             elsif (chan_sel(i) and ISR_sel and dma2bus_wrack_i) = '1' then
                 PWBR(i) <= PWBR(i) xor Bus2IP_Data(b_PWBR); -- Tog on wr.
             end if;
         end if;
      end loop;
    end process;


    SGDA_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 SGDA(i) <= '0';
             elsif (not sg_active(i) and sg_active_d1(i) and not SGE(i)) = '1'
                 then
                 SGDA(i) <= '1';
             elsif (chan_sel(i) and ISR_sel and dma2bus_wrack_i) = '1' then
                 SGDA(i) <= SGDA(i) xor Bus2IP_Data(b_SGDA); -- Tog on wr.
             end if;
         end if;
      end loop;
    end process;

    SGDEND_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 SGEND(i) <= '0';
             elsif (not sg_active(i) and sg_active_d1(i) and SGS(i)) = '1' then
                 SGEND(i) <= '1';
             elsif (chan_sel(i) and ISR_sel and dma2bus_wrack_i) = '1' then
                 SGEND(i) <= SGEND(i) xor Bus2IP_Data(b_SGEND); -- Tog on wr.
             end if;
         end if;
      end loop;
    end process;


    ----------------------------------------------------------------------------
    -- This process implements the IER for each channel.
    ----------------------------------------------------------------------------
    IER_REG_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 EDD(i) <= '0';
                 EDE(i) <= '0';
                 EPD(i) <= '0';
                 EPCTR(i) <= '0';
                 EPWBR(i) <= '0';
                 ESGDA(i) <= '0';
                 ESGEND(i) <= '0';
             elsif (chan_sel(i) and IER_sel and dma2bus_wrack_i) = '1' then
                 EDD(i)    <= Bus2IP_Data(b_DD);
                 EDE(i)    <= Bus2IP_Data(b_DE);
                 EPD(i)    <= Bus2IP_Data(b_PD);
                 EPCTR(i)  <= Bus2IP_Data(b_PCTR);
                 EPWBR(i)  <= Bus2IP_Data(b_PWBR);
                 ESGDA(i)  <= Bus2IP_Data(b_SGDA);
                 ESGEND(i)  <= Bus2IP_Data(b_SGEND);
             end if;
         end if;
      end loop;
    end process;

    ----------------------------------------------------------------------------
    -- This process implements the UPC register for each channel.
    ----------------------------------------------------------------------------
    UPC_REG_PROCESS: process (Bus2IP_Clk)
        variable add1 : UNSIGNED(DMA_DWIDTH-UPCB to DMA_DWIDTH-1);
        variable sub1 : natural;
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             add1 := (others => rd_SRAddrFIFO(i)); -- zero or minus 1
             if (chan_sel(i) and UPC_sel and dma2bus_wrack_i and
                 Bus2IP_Data(DMA_DWIDTH-1)) = '1' then
                  sub1 := 1;
             else sub1 := 0;
             end if;
             if (reset(i) = RESET_ACTIVE) then
                 UPC(i) <= (others => '0');
             else
                 UPC(i) <= (UPC(i) - add1) - sub1;
                   -- This will increment if rd_SRAddrFIFO(i), decrement if
                   -- writing a one in LSB, stay unchanged if both or neither.
             end if;
         end if;
      end loop;
    end process;

    ----------------------------------------------------------------------------
    -- This process implements the PCT register for each channel.
    ----------------------------------------------------------------------------
    PCT_REG_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             if (reset(i) = RESET_ACTIVE) then
                 PCT(i) <= (others => '0');
             elsif (chan_sel(i) and PCT_sel and dma2bus_wrack_i) = '1' then
                 PCT(i) <= UNSIGNED(Bus2IP_Data(DMA_DWIDTH - UPCB to
                                                   DMA_DWIDTH - 1)
                                   );
             end if;
         end if;
      end loop;
    end process;

    ----------------------------------------------------------------------------
    -- This process implements the PWB register for each channel.
    ----------------------------------------------------------------------------
    PWB_REG_PROCESS: process (Bus2IP_Clk)
    begin
      for i in 0 to LAST_CHAN loop
         if Bus2IP_Clk'event and Bus2IP_Clk='1' then
             pwb_loaded(i) <= '0';
             if (reset(i) = RESET_ACTIVE) then
                 PWB(i) <= (others => '0');
             elsif (chan_sel(i) and PWB_sel and dma2bus_wrack_i) = '1' then
                 PWB(i) <= UNSIGNED(Bus2IP_Data(DMA_DWIDTH - PWBB to
                                                   DMA_DWIDTH - 1)
                                   );
                 pwb_loaded(i) <= '1';
             end if;
         end if;
      end loop;
    end process;

    PWB_EQ_0_GEN: for i in 0 to LAST_CHAN generate
        pwb_eq_0(i) <= not or_UNSIGNED(PWB(i));
        pw_timer_eq_0(i) <= not or_UNSIGNED(pw_timer(i));
        upc_eq_0(i) <= not or_UNSIGNED(UPC(i));
    end generate;

    ---------------------------------------------------------------------
    -- The below implements a pw_timer register of each channel
    -- that requires one.
    ---------------------------------------------------------------------
-- XGR issue on generic context
      LENGTH_cco <= zero_vector(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(0)) &
                    LENGTH(cco)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(0) to
                                DMA_DWIDTH-1);

      PLENGTH_cco <= zero_vector(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(0)) &
                    PLENGTH(cco)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(0) to
                                 DMA_DWIDTH-1);
-- XGR 

    PW_TIMER_REG_GEN: for i in 0 to LAST_CHAN generate

        T0or1_GEN: if C_DMA_CHAN_TYPE(i) = 0 or C_DMA_CHAN_TYPE(i) = 1 generate
            pw_timer(i) <= (others => '0');
        end generate;

        T2or3_GEN: if C_DMA_CHAN_TYPE(i) = 2  or C_DMA_CHAN_TYPE(i) = 3 generate
            --------------------------------------------------------------------
            -- XGR WA (OP,    LOAD and    RST    renamed to
            --         OP_EF, LOAD_EF and RST_EF ... t0111.44) [XST workaround]
            --------------------------------------------------------------------
            signal OPxx, LOADxx, RSTxx : std_logic;
            signal qslv          : std_logic_vector(pw_timer(i)'range);

        begin
          --
          RSTxx  <= reset(i) or pwb_eq_0(i);
          LOADxx <= upc_eq_0(i) or DMA2Intr_Intr_i(i) or pw_timer_eq_0(i) or pwb_loaded(i);
          OPxx <= pw_enable_pulse;
          --
          i_pw_timer : component ld_arith_reg
            generic map (
              C_ADD_SUB_NOT =>  false,
              C_REG_WIDTH   =>  pw_timer(i)'length,
              C_RESET_VALUE => "11111111111111111111111111111111",
              C_LD_WIDTH    =>  pw_timer(i)'length,
              C_LD_OFFSET   =>  0,
              C_AD_WIDTH    =>  1,
              C_AD_OFFSET   =>  0
            )
            port map (
              CK   => Bus2IP_Clk,
              RST  => RSTxx,
              Q    => qslv(pw_timer(i)'range),
              LD   => std_logic_vector(PWB(i)),
              AD   => "1",
              LOAD => LOADxx,
              OP   => OPxx
            );
          --
          pw_timer(i) <= unsigned(qslv(pw_timer(i)'range));
        end generate;
    end generate;


    --= end, Register implementations

    --- Some register values selected by cco.

-- XGR       LENGTH_cco <= zero_vector(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(cco)) &
-- XGR                     LENGTH(cco)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(cco) to
-- XGR                                 DMA_DWIDTH-1);

-- XGR      PLENGTH_cco <= zero_vector(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(cco)) &
-- XGR                    PLENGTH(cco)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(cco) to
-- XGR                                 DMA_DWIDTH-1);


    --= end, Some register values selected by cco.


    --- Register readback

    ---------------------------------------------------------------------  
    -- This process enables the selected register onto DMA2Bus_Data
    -- on slave reads.
    -- ToDo, this may generate extra "priority encode" logic, so
    -- check this and adjust the implementation, if necessary.
    ---------------------------------------------------------------------  
READ_REGISTER_PROCESS:process (Bus2IP_Clk)
begin
   if Bus2IP_Clk'event and Bus2IP_Clk='1' then
               DMA2Bus_Data(0) <= 
                     (ver_i(0) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(0) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(0) and DMA_RdCE and SA_sel) or
                     ( da_i(0) and DMA_RdCE and DA_sel) or
                     (lnt_i(0) and DMA_RdCE and LENGTH_sel) or
                     (dsr_i(0) and DMA_RdCE and DMASR_sel) or
                     (bda_i(0) and DMA_RdCE and BDA_sel) or
                     (sge_i(0) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(0) and DMA_RdCE and UPC_sel) or
--                     (pct_i(0) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(0) and DMA_RdCE and PWB_sel) or
--                     (isr_i(0) and DMA_RdCE and ISR_sel) or
--                     (ier_i(0) and DMA_RdCE and IER_sel) or
                     (ple_i(0) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(1) <= 
                     (ver_i(1) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(1) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(1) and DMA_RdCE and SA_sel) or
                     ( da_i(1) and DMA_RdCE and DA_sel) or
                     (lnt_i(1) and DMA_RdCE and LENGTH_sel) or
                     (dsr_i(1) and DMA_RdCE and DMASR_sel) or
                     (bda_i(1) and DMA_RdCE and BDA_sel) or
--                     (sge_i(1) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(1) and DMA_RdCE and UPC_sel) or
--                     (pct_i(1) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(1) and DMA_RdCE and PWB_sel) or
--                     (isr_i(1) and DMA_RdCE and ISR_sel) or
--                     (ier_i(1) and DMA_RdCE and IER_sel) or
                     (ple_i(1) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(2) <= 
                     (ver_i(2) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(2) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(2) and DMA_RdCE and SA_sel) or
                     ( da_i(2) and DMA_RdCE and DA_sel) or
                     (lnt_i(2) and DMA_RdCE and LENGTH_sel) or
                     (dsr_i(2) and DMA_RdCE and DMASR_sel) or
                     (bda_i(2) and DMA_RdCE and BDA_sel) or
--                     (sge_i(2) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(2) and DMA_RdCE and UPC_sel) or
--                     (pct_i(2) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(2) and DMA_RdCE and PWB_sel) or
--                     (isr_i(2) and DMA_RdCE and ISR_sel) or
--                     (ier_i(2) and DMA_RdCE and IER_sel) or
                     (ple_i(2) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(3) <= 
                     (ver_i(3) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(3) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(3) and DMA_RdCE and SA_sel) or
                     ( da_i(3) and DMA_RdCE and DA_sel) or
                     (lnt_i(3) and DMA_RdCE and LENGTH_sel) or
                     (dsr_i(3) and DMA_RdCE and DMASR_sel) or
                       (bda_i(3) and DMA_RdCE and BDA_sel) or
--                     (sge_i(3) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(3) and DMA_RdCE and UPC_sel) or
--                     (pct_i(3) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(3) and DMA_RdCE and PWB_sel) or
--                     (isr_i(3) and DMA_RdCE and ISR_sel) or
--                     (ier_i(3) and DMA_RdCE and IER_sel) or
                     (ple_i(3) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(4) <= 
                     (ver_i(4) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(4) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(4) and DMA_RdCE and SA_sel) or
                     ( da_i(4) and DMA_RdCE and DA_sel) or
                     (lnt_i(4) and DMA_RdCE and LENGTH_sel) or
                       (dsr_i(4) and DMA_RdCE and DMASR_sel) or
                       (bda_i(4) and DMA_RdCE and BDA_sel) or
--                     (sge_i(4) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(4) and DMA_RdCE and UPC_sel) or
--                     (pct_i(4) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(4) and DMA_RdCE and PWB_sel) or
--                     (isr_i(4) and DMA_RdCE and ISR_sel) or
--                     (ier_i(4) and DMA_RdCE and IER_sel) or
                     (ple_i(4) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(5) <= 
                     (ver_i(5) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(5) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(5) and DMA_RdCE and SA_sel) or
                     ( da_i(5) and DMA_RdCE and DA_sel) or
                     (lnt_i(5) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(5) and DMA_RdCE and DMASR_sel) or
                       (bda_i(5) and DMA_RdCE and BDA_sel) or
--                     (sge_i(5) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(5) and DMA_RdCE and UPC_sel) or
--                     (pct_i(5) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(5) and DMA_RdCE and PWB_sel) or
--                     (isr_i(5) and DMA_RdCE and ISR_sel) or
--                     (ier_i(5) and DMA_RdCE and IER_sel) or
                     (ple_i(5) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(6) <= 
                     (ver_i(6) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(6) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(6) and DMA_RdCE and SA_sel) or
                     ( da_i(6) and DMA_RdCE and DA_sel) or
                     (lnt_i(6) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(6) and DMA_RdCE and DMASR_sel) or
                       (bda_i(6) and DMA_RdCE and BDA_sel) or
--                     (sge_i(6) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(6) and DMA_RdCE and UPC_sel) or
--                     (pct_i(6) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(6) and DMA_RdCE and PWB_sel) or
--                     (isr_i(6) and DMA_RdCE and ISR_sel) or
--                     (ier_i(6) and DMA_RdCE and IER_sel) or
                     (ple_i(6) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(7) <= 
                     (ver_i(7) and DMA_RdCE and RSTMIR_sel) or
                     (dcr_i(7) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(7) and DMA_RdCE and SA_sel) or
                       ( da_i(7) and DMA_RdCE and DA_sel) or
                       (lnt_i(7) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(7) and DMA_RdCE and DMASR_sel) or
                       (bda_i(7) and DMA_RdCE and BDA_sel) or
--                     (sge_i(7) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(7) and DMA_RdCE and UPC_sel) or
--                     (pct_i(7) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(7) and DMA_RdCE and PWB_sel) or
--                     (isr_i(7) and DMA_RdCE and ISR_sel) or
--                     (ier_i(7) and DMA_RdCE and IER_sel) or
                     (ple_i(7) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(8) <= 
                     (ver_i(8) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(8) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(8) and DMA_RdCE and SA_sel) or
                       ( da_i(8) and DMA_RdCE and DA_sel) or
                       (lnt_i(8) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(8) and DMA_RdCE and DMASR_sel) or
                       (bda_i(8) and DMA_RdCE and BDA_sel) or
--                     (sge_i(8) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(8) and DMA_RdCE and UPC_sel) or
--                     (pct_i(8) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(8) and DMA_RdCE and PWB_sel) or
--                     (isr_i(8) and DMA_RdCE and ISR_sel) or
--                     (ier_i(8) and DMA_RdCE and IER_sel) or
                     (ple_i(8) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(9) <= 
                     (ver_i(9) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(9) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(9) and DMA_RdCE and SA_sel) or
                       ( da_i(9) and DMA_RdCE and DA_sel) or
                       (lnt_i(9) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(9) and DMA_RdCE and DMASR_sel) or
                       (bda_i(9) and DMA_RdCE and BDA_sel) or
--                     (sge_i(9) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(9) and DMA_RdCE and UPC_sel) or
--                     (pct_i(9) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(9) and DMA_RdCE and PWB_sel) or
--                     (isr_i(9) and DMA_RdCE and ISR_sel) or
--                     (ier_i(9) and DMA_RdCE and IER_sel) or
                     (ple_i(9) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(10) <= 
                     (ver_i(10) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(10) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(10) and DMA_RdCE and SA_sel) or
                       ( da_i(10) and DMA_RdCE and DA_sel) or
                       (lnt_i(10) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(10) and DMA_RdCE and DMASR_sel) or
                       (bda_i(10) and DMA_RdCE and BDA_sel) or
--                     (sge_i(10) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(10) and DMA_RdCE and UPC_sel) or
--                     (pct_i(10) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(10) and DMA_RdCE and PWB_sel) or
--                     (isr_i(10) and DMA_RdCE and ISR_sel) or
--                     (ier_i(10) and DMA_RdCE and IER_sel) or
                     (ple_i(10) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(11) <= 
                     (ver_i(11) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(11) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(11) and DMA_RdCE and SA_sel) or
                       ( da_i(11) and DMA_RdCE and DA_sel) or
                       (lnt_i(11) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(11) and DMA_RdCE and DMASR_sel) or
                       (bda_i(11) and DMA_RdCE and BDA_sel) or
--                     (sge_i(11) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(11) and DMA_RdCE and UPC_sel) or
--                     (pct_i(11) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(11) and DMA_RdCE and PWB_sel) or
--                     (isr_i(11) and DMA_RdCE and ISR_sel) or
--                     (ier_i(11) and DMA_RdCE and IER_sel) or
                     (ple_i(11) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(12) <= 
                     (ver_i(12) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(12) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(12) and DMA_RdCE and SA_sel) or
                       ( da_i(12) and DMA_RdCE and DA_sel) or
                       (lnt_i(12) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(12) and DMA_RdCE and DMASR_sel) or
                       (bda_i(12) and DMA_RdCE and BDA_sel) or
--                     (sge_i(12) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(12) and DMA_RdCE and UPC_sel) or
--                     (pct_i(12) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(12) and DMA_RdCE and PWB_sel) or
--                     (isr_i(12) and DMA_RdCE and ISR_sel) or
--                     (ier_i(12) and DMA_RdCE and IER_sel) or
                     (ple_i(12) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(13) <= 
                     (ver_i(13) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(13) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(13) and DMA_RdCE and SA_sel) or
                       ( da_i(13) and DMA_RdCE and DA_sel) or
                       (lnt_i(13) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(13) and DMA_RdCE and DMASR_sel) or
                       (bda_i(13) and DMA_RdCE and BDA_sel) or
--                     (sge_i(13) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(13) and DMA_RdCE and UPC_sel) or
--                     (pct_i(13) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(13) and DMA_RdCE and PWB_sel) or
--                     (isr_i(13) and DMA_RdCE and ISR_sel) or
--                     (ier_i(13) and DMA_RdCE and IER_sel) or
                     (ple_i(13) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(14) <= 
                     (ver_i(14) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(14) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(14) and DMA_RdCE and SA_sel) or
                       ( da_i(14) and DMA_RdCE and DA_sel) or
                       (lnt_i(14) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(14) and DMA_RdCE and DMASR_sel) or
                       (bda_i(14) and DMA_RdCE and BDA_sel) or
--                     (sge_i(14) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(14) and DMA_RdCE and UPC_sel) or
--                     (pct_i(14) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(14) and DMA_RdCE and PWB_sel) or
--                     (isr_i(14) and DMA_RdCE and ISR_sel) or
--                     (ier_i(14) and DMA_RdCE and IER_sel) or
                     (ple_i(14) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(15) <= 
                     (ver_i(15) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(15) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(15) and DMA_RdCE and SA_sel) or
                       ( da_i(15) and DMA_RdCE and DA_sel) or
                       (lnt_i(15) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(15) and DMA_RdCE and DMASR_sel) or
                       (bda_i(15) and DMA_RdCE and BDA_sel) or
--                     (sge_i(15) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(15) and DMA_RdCE and UPC_sel) or
--                     (pct_i(15) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(15) and DMA_RdCE and PWB_sel) or
--                     (isr_i(15) and DMA_RdCE and ISR_sel) or
--                     (ier_i(15) and DMA_RdCE and IER_sel) or
                     (ple_i(15) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(16) <= 
                     (ver_i(16) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(16) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(16) and DMA_RdCE and SA_sel) or
                       ( da_i(16) and DMA_RdCE and DA_sel) or
                       (lnt_i(16) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(16) and DMA_RdCE and DMASR_sel) or
                       (bda_i(16) and DMA_RdCE and BDA_sel) or
--                     (sge_i(16) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(16) and DMA_RdCE and UPC_sel) or
--                     (pct_i(16) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(16) and DMA_RdCE and PWB_sel) or
--                     (isr_i(16) and DMA_RdCE and ISR_sel) or
--                     (ier_i(16) and DMA_RdCE and IER_sel) or
                     (ple_i(16) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(17) <= 
                     (ver_i(17) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(17) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(17) and DMA_RdCE and SA_sel) or
                       ( da_i(17) and DMA_RdCE and DA_sel) or
                       (lnt_i(17) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(17) and DMA_RdCE and DMASR_sel) or
                       (bda_i(17) and DMA_RdCE and BDA_sel) or
--                     (sge_i(17) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(17) and DMA_RdCE and UPC_sel) or
--                     (pct_i(17) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(17) and DMA_RdCE and PWB_sel) or
--                     (isr_i(17) and DMA_RdCE and ISR_sel) or
--                     (ier_i(17) and DMA_RdCE and IER_sel) or
                     (ple_i(17) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(18) <= 
                     (ver_i(18) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(18) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(18) and DMA_RdCE and SA_sel) or
                       ( da_i(18) and DMA_RdCE and DA_sel) or
                       (lnt_i(18) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(18) and DMA_RdCE and DMASR_sel) or
                       (bda_i(18) and DMA_RdCE and BDA_sel) or
--                     (sge_i(18) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(18) and DMA_RdCE and UPC_sel) or
--                     (pct_i(18) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(18) and DMA_RdCE and PWB_sel) or
--                     (isr_i(18) and DMA_RdCE and ISR_sel) or
--                     (ier_i(18) and DMA_RdCE and IER_sel) or
                     (ple_i(18) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(19) <= 
                     (ver_i(19) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(19) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(19) and DMA_RdCE and SA_sel) or
                       ( da_i(19) and DMA_RdCE and DA_sel) or
                       (lnt_i(19) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(19) and DMA_RdCE and DMASR_sel) or
                       (bda_i(19) and DMA_RdCE and BDA_sel) or
--                     (sge_i(19) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(19) and DMA_RdCE and UPC_sel) or
--                     (pct_i(19) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(19) and DMA_RdCE and PWB_sel) or
--                     (isr_i(19) and DMA_RdCE and ISR_sel) or
--                     (ier_i(19) and DMA_RdCE and IER_sel) or
                     (ple_i(19) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(20) <= 
                     (ver_i(20) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(20) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(20) and DMA_RdCE and SA_sel) or
                       ( da_i(20) and DMA_RdCE and DA_sel) or
                       (lnt_i(20) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(20) and DMA_RdCE and DMASR_sel) or
                       (bda_i(20) and DMA_RdCE and BDA_sel) or
--                     (sge_i(20) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(20) and DMA_RdCE and UPC_sel) or
--                     (pct_i(20) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(20) and DMA_RdCE and PWB_sel) or
--                     (isr_i(20) and DMA_RdCE and ISR_sel) or
--                     (ier_i(20) and DMA_RdCE and IER_sel) or
                     (ple_i(20) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(21) <= 
                     (ver_i(21) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(21) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(21) and DMA_RdCE and SA_sel) or
                       ( da_i(21) and DMA_RdCE and DA_sel) or
                       (lnt_i(21) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(21) and DMA_RdCE and DMASR_sel) or
                       (bda_i(21) and DMA_RdCE and BDA_sel) or
--                     (sge_i(21) and DMA_RdCE and SWCR_sel) or
--                     (upc_i(21) and DMA_RdCE and UPC_sel) or
--                     (pct_i(21) and DMA_RdCE and PCT_sel) or
--                     (pwb_i(21) and DMA_RdCE and PWB_sel) or
--                     (isr_i(21) and DMA_RdCE and ISR_sel) or
--                     (ier_i(21) and DMA_RdCE and IER_sel) or
                     (ple_i(21) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(22) <= 
                     (ver_i(22) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(22) and DMA_RdCE and DMACR_sel) or
                       ( sa_i(22) and DMA_RdCE and SA_sel) or
                       ( da_i(22) and DMA_RdCE and DA_sel) or
                       (lnt_i(22) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(22) and DMA_RdCE and DMASR_sel) or
                       (bda_i(22) and DMA_RdCE and BDA_sel) or
--                     (sge_i(22) and DMA_RdCE and SWCR_sel) or
                     (upc_i(22) and DMA_RdCE and UPC_sel) or
                     (pct_i(22) and DMA_RdCE and PCT_sel) or
                     (pwb_i(22) and DMA_RdCE and PWB_sel) or
--                     (isr_i(22) and DMA_RdCE and ISR_sel) or
--                     (ier_i(22) and DMA_RdCE and IER_sel) or
                     (ple_i(22) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(23) <= 
                     (ver_i(23) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(23) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(23) and DMA_RdCE and SA_sel) or
                     ( da_i(23) and DMA_RdCE and DA_sel) or
                     (lnt_i(23) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(23) and DMA_RdCE and DMASR_sel) or
                     (bda_i(23) and DMA_RdCE and BDA_sel) or
--                     (sge_i(23) and DMA_RdCE and SWCR_sel) or
                     (upc_i(23) and DMA_RdCE and UPC_sel) or
                     (pct_i(23) and DMA_RdCE and PCT_sel) or
                     (pwb_i(23) and DMA_RdCE and PWB_sel) or
--                     (isr_i(23) and DMA_RdCE and ISR_sel) or
--                     (ier_i(23) and DMA_RdCE and IER_sel) or
                     (ple_i(23) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(24) <= 
                     (ver_i(24) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(24) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(24) and DMA_RdCE and SA_sel) or
                     ( da_i(24) and DMA_RdCE and DA_sel) or
                     (lnt_i(24) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(24) and DMA_RdCE and DMASR_sel) or
                     (bda_i(24) and DMA_RdCE and BDA_sel) or
--                     (sge_i(24) and DMA_RdCE and SWCR_sel) or
                     (upc_i(24) and DMA_RdCE and UPC_sel) or
                     (pct_i(24) and DMA_RdCE and PCT_sel) or
                     (pwb_i(24) and DMA_RdCE and PWB_sel) or
                     (isr_i(24) and DMA_RdCE and ISR_sel) or
                     (ier_i(24) and DMA_RdCE and IER_sel) or
                     (ple_i(24) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(25) <= 
                     (ver_i(25) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(25) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(25) and DMA_RdCE and SA_sel) or
                     ( da_i(25) and DMA_RdCE and DA_sel) or
                     (lnt_i(25) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(25) and DMA_RdCE and DMASR_sel) or
                     (bda_i(25) and DMA_RdCE and BDA_sel) or
--                     (sge_i(25) and DMA_RdCE and SWCR_sel) or
                     (upc_i(25) and DMA_RdCE and UPC_sel) or
                     (pct_i(25) and DMA_RdCE and PCT_sel) or
                     (pwb_i(25) and DMA_RdCE and PWB_sel) or
                     (isr_i(25) and DMA_RdCE and ISR_sel) or
                     (ier_i(25) and DMA_RdCE and IER_sel) or
                     (ple_i(25) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(26) <= 
                     (ver_i(26) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(26) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(26) and DMA_RdCE and SA_sel) or
                     ( da_i(26) and DMA_RdCE and DA_sel) or
                     (lnt_i(26) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(26) and DMA_RdCE and DMASR_sel) or
                     (bda_i(26) and DMA_RdCE and BDA_sel) or
--                     (sge_i(26) and DMA_RdCE and SWCR_sel) or
                     (upc_i(26) and DMA_RdCE and UPC_sel) or
                     (pct_i(26) and DMA_RdCE and PCT_sel) or
                     (pwb_i(26) and DMA_RdCE and PWB_sel) or
                     (isr_i(26) and DMA_RdCE and ISR_sel) or
                     (ier_i(26) and DMA_RdCE and IER_sel) or
                     (ple_i(26) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(27) <= 
                     (ver_i(27) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(27) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(27) and DMA_RdCE and SA_sel) or
                     ( da_i(27) and DMA_RdCE and DA_sel) or
                     (lnt_i(27) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(27) and DMA_RdCE and DMASR_sel) or
                     (bda_i(27) and DMA_RdCE and BDA_sel) or
--                     (sge_i(27) and DMA_RdCE and SWCR_sel) or
                     (upc_i(27) and DMA_RdCE and UPC_sel) or
                     (pct_i(27) and DMA_RdCE and PCT_sel) or
                     (pwb_i(27) and DMA_RdCE and PWB_sel) or
                     (isr_i(27) and DMA_RdCE and ISR_sel) or
                     (ier_i(27) and DMA_RdCE and IER_sel) or
                     (ple_i(27) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(28) <= 
                     (ver_i(28) and DMA_RdCE and RSTMIR_sel) or
--                     (dcr_i(28) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(28) and DMA_RdCE and SA_sel) or
                     ( da_i(28) and DMA_RdCE and DA_sel) or
                     (lnt_i(28) and DMA_RdCE and LENGTH_sel) or
--                     (dsr_i(28) and DMA_RdCE and DMASR_sel) or
                     (bda_i(28) and DMA_RdCE and BDA_sel) or
--                     (sge_i(28) and DMA_RdCE and SWCR_sel) or
                     (upc_i(28) and DMA_RdCE and UPC_sel) or
                     (pct_i(28) and DMA_RdCE and PCT_sel) or
                     (pwb_i(28) and DMA_RdCE and PWB_sel) or
                     (isr_i(28) and DMA_RdCE and ISR_sel) or
                     (ier_i(28) and DMA_RdCE and IER_sel) or
                     (ple_i(28) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(29) <= 
                     (ver_i(29) and DMA_RdCE and RSTMIR_sel) or
 --                    (dcr_i(29) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(29) and DMA_RdCE and SA_sel) or
                     ( da_i(29) and DMA_RdCE and DA_sel) or
                     (lnt_i(29) and DMA_RdCE and LENGTH_sel) or
 --                    (dsr_i(29) and DMA_RdCE and DMASR_sel) or
                     (bda_i(29) and DMA_RdCE and BDA_sel) or
 --                    (sge_i(29) and DMA_RdCE and SWCR_sel) or
                     (upc_i(29) and DMA_RdCE and UPC_sel) or
                     (pct_i(29) and DMA_RdCE and PCT_sel) or
                     (pwb_i(29) and DMA_RdCE and PWB_sel) or
                     (isr_i(29) and DMA_RdCE and ISR_sel) or
                     (ier_i(29) and DMA_RdCE and IER_sel) or
                     (ple_i(29) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(30) <= 
                     (ver_i(30) and DMA_RdCE and RSTMIR_sel) or
 --                    (dcr_i(30) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(30) and DMA_RdCE and SA_sel) or
                     ( da_i(30) and DMA_RdCE and DA_sel) or
                     (lnt_i(30) and DMA_RdCE and LENGTH_sel) or
 --                    (dsr_i(30) and DMA_RdCE and DMASR_sel) or
                     (bda_i(30) and DMA_RdCE and BDA_sel) or
 --                    (sge_i(30) and DMA_RdCE and SWCR_sel) or
                     (upc_i(30) and DMA_RdCE and UPC_sel) or
                     (pct_i(30) and DMA_RdCE and PCT_sel) or
                     (pwb_i(30) and DMA_RdCE and PWB_sel) or
                     (isr_i(30) and DMA_RdCE and ISR_sel) or
                     (ier_i(30) and DMA_RdCE and IER_sel) or
                     (ple_i(30) and DMA_RdCE and PLENGTH_sel);

               DMA2Bus_Data(31) <= 
                     (ver_i(31) and DMA_RdCE and RSTMIR_sel) or
 --                    (dcr_i(31) and DMA_RdCE and DMACR_sel) or
                     ( sa_i(31) and DMA_RdCE and SA_sel) or
                     ( da_i(31) and DMA_RdCE and DA_sel) or
                     (lnt_i(31) and DMA_RdCE and LENGTH_sel) or
 --                    (dsr_i(31) and DMA_RdCE and DMASR_sel) or
                     (bda_i(31) and DMA_RdCE and BDA_sel) or
 --                    (sge_i(31) and DMA_RdCE and SWCR_sel) or
                     (upc_i(31) and DMA_RdCE and UPC_sel) or
                     (pct_i(31) and DMA_RdCE and PCT_sel) or
                     (pwb_i(31) and DMA_RdCE and PWB_sel) or
                     (isr_i(31) and DMA_RdCE and ISR_sel) or
                     (ier_i(31) and DMA_RdCE and IER_sel) or
                     (ple_i(31) and DMA_RdCE and PLENGTH_sel);

   end if;
end process;




      -- Module Identification Register 0 - 31 used
ver_i <= std_logic_vector(TO_UNSIGNED(MAJOR_VERSION , 4)) &
         std_logic_vector(TO_UNSIGNED(MINOR_VERSION , 7)) &
         std_logic_vector(TO_UNSIGNED(HW_SW_COMPATIBILITY_REVISION, 5)) &
         std_logic_vector(TO_UNSIGNED(C_DEV_BLK_ID, 8)) &
         std_logic_vector(TO_UNSIGNED(C_DMA_CHAN_TYPE(chan_num)+4, 8));
         
      -- DMA Control Register 0 - 7 used   
dcr_i <= DMACR(chan_num) & "0000000000000000000000000";

      -- Source Address 0 - 31 used
sa_i <= std_logic_vector(SA(chan_num));

      -- Destination Address 0 - 31 used
da_i <= std_logic_vector(DA(chan_num));

      -- DMA Length 0 - 31 used
-- lnt_i <= std_logic_vector(RESIZE(LENGTH(chan_num)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(chan_num) to 
--             DMA_DWIDTH-1),DMA_DWIDTH));
lnt_i <= std_logic_vector(RESIZE(LENGTH(chan_num)(LENGTHS_LEFT to 
            DMA_DWIDTH-1),DMA_DWIDTH));

      -- DMA Status Register 0 - 3 used
dsr_i <= dma_active(chan_num) & DBE(chan_num) & DBT(chan_num) & L(chan_num)
          & sg_active(chan_num) & "000000000000000000000000000";    

      -- Buffer Descriptor Address 0 - 31 used
bda_i <= std_logic_vector(BDA(chan_num));

      -- Software Control Register 0 - 0 used
sge_i <= SGE(chan_num) & "0000000000000000000000000000000";

      -- Unserviced Packet Count 22 - 31 used
upc_i <= std_logic_vector(RESIZE(UPC(chan_num)(DMA_DWIDTH - UPCB to 
              DMA_DWIDTH - 1),32));

      -- Packet Count Threshold 22 - 31 used
pct_i <= std_logic_vector(RESIZE(PCT(chan_num)(DMA_DWIDTH - UPCB to 
              DMA_DWIDTH - 1),DMA_DWIDTH));
              
      -- Packet Wait Bound 22 - 31 used        
pwb_i <= std_logic_vector(RESIZE(PWB(chan_num)(DMA_DWIDTH - PWBB to 
              DMA_DWIDTH - 1),DMA_DWIDTH));

      -- Interrupt Status Register 24 - 31 used
isr_i <= "0000000000000000000000000" & SGEND(chan_num) & SGDA(chan_num)
           & PWBR(chan_num) & PCTR(chan_num) & PD(chan_num)
           & DE(chan_num) & DD(chan_num);
           
      -- Interrupt Enable Register 24 - 31 used   
ier_i <= "0000000000000000000000000" & ESGEND(chan_num) & ESGDA(chan_num)  
           & EPWBR(chan_num) & EPCTR(chan_num) & EPD(chan_num)  
           & EDE(chan_num) & EDD(chan_num);  
           
-- ple_i <= std_logic_vector(RESIZE(PLENGTH(chan_num)(DMA_DWIDTH-C_DMA_LENGTH_WIDTH(chan_num) to
--             DMA_DWIDTH-1),DMA_DWIDTH));
ple_i <= std_logic_vector(RESIZE(PLENGTH(chan_num)(LENGTHS_LEFT to
            DMA_DWIDTH-1),DMA_DWIDTH));

           
--p   DMA2Bus_Data <= --p
--p          std_logic_vector(TO_UNSIGNED(MAJOR_VERSION , 4)) & --p
--p          std_logic_vector(TO_UNSIGNED(MINOR_VERSION , 7)) & --p
--p          std_logic_vector(TO_UNSIGNED(HW_SW_COMPATIBILITY_REVISION, 5)) & --p
--p          std_logic_vector(TO_UNSIGNED(C_DEV_BLK_ID, 8)) & --p
--p          std_logic_vector(TO_UNSIGNED(C_DMA_CHAN_TYPE(chan_num)+4, 8)) --p
--p                                               when (RSTMIR_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          DMACR(chan_num) --p
--p            & "0000000000000000000000000"      when ( DMACR_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector(SA(chan_num))       when (    SA_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector(DA(chan_num))       when (    DA_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector( --p
--p          RESIZE( --p
--p            LENGTH(chan_num)( --p
--p               DMA_DWIDTH-C_DMA_LENGTH_WIDTH(chan_num) to
--p               DMA_DWIDTH-1), --p
--p            DMA_DWIDTH --p
--p          ) --p
--p          )                                    when (LENGTH_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p              dma_active(chan_num)  -- DMA_BSY --p
--p     & DBE(chan_num) --p
--p            & DBT(chan_num) --p
--p     & L(chan_num) --p
--p     & sg_active(chan_num)   -- SG_BSY --p
--p            & "000000000000000000000000000"    when ( DMASR_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector(BDA(chan_num))      when (   BDA_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          SGE(chan_num) & --p
--p            "0000000000000000000000000000000"  when (  SWCR_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector( --p
--p          RESIZE( --p
--p            UPC(chan_num)( --p
--p               DMA_DWIDTH - UPCB to  --p
--p               DMA_DWIDTH - 1 --p
--p            ), --p
--p            32 --p
--p          ) --p
--p          )                                    when (   UPC_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector( --p
--p          RESIZE( --p
--p            PCT(chan_num)( --p
--p               DMA_DWIDTH - UPCB to  --p
--p               DMA_DWIDTH - 1 --p
--p            ), --p
--p            DMA_DWIDTH --p
--p          ) --p
--p          )                                    when (   PCT_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector( --p
--p          RESIZE( --p
--p            PWB(chan_num)( --p
--p               DMA_DWIDTH - PWBB to  --p
--p               DMA_DWIDTH - 1 --p
--p            ), --p
--p            DMA_DWIDTH --p
--p          ) --p
--p          )                                    when (   PWB_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          "0000000000000000000000000" --p
--p            & SGEND(chan_num) & SGDA(chan_num) --p
--p            & PWBR(chan_num) & PCTR(chan_num) --p
--p            & PD(chan_num) --p
--p            & DE(chan_num) & DD(chan_num)      when (   ISR_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          "0000000000000000000000000" --p
--p            & ESGEND(chan_num) & ESGDA(chan_num) --p
--p            & EPWBR(chan_num) & EPCTR(chan_num) --p
--p            & EPD(chan_num) --p
--p            & EDE(chan_num) & EDD(chan_num) --p
--p                                               when (   IER_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          std_logic_vector( --p
--p          RESIZE( --p
--p            PLENGTH(chan_num)( --p
--p               DMA_DWIDTH-C_DMA_LENGTH_WIDTH(chan_num) to
--p               DMA_DWIDTH-1), --p
--p            DMA_DWIDTH --p
--p          ) --p
--p          )                                    when (PLENGTH_sel and DMA_RdCE) --p
--p                                                    = '1' --p
--p                                               else --p
--p          "00000000000000000000000000000000"; --p


    DMA2BUS_RDACK_I_PROCESS: process(Bus2IP_Clk)
    begin
        if (Bus2IP_Clk'event and Bus2IP_Clk = '1') then
          if (Bus2IP_Reset = RESET_ACTIVE) then
            dma2bus_rdack_i <= '0';
          else
            dma2bus_rdack_i <= DMA_RdCE and Bus2IP_RdReq and not dma2bus_rdack_i;
          end if;
        end if;
    end process;

    DMA2Bus_RdAck   <= dma2bus_rdack_i;


    --= end, Register readback


    --- Master arbitration and concentration.
    MASTER_CONCENTRATION: block
    begin

        DMA2Bus_MstBusLock <= '0';    -- Bus-lock capability not used.
--ToDo, rmv
--      DMA2Bus_MstBE      <= "1111"; -- Word transfers, only.

        REG_MQ_PROCESS : process (Bus2IP_Clk) is
            variable dma_sg_sr_pl : std_logic_vector(0 to 3);
            variable Debug_TEMP : std_logic_vector(0 to C_OPB_AWIDTH-1);
            variable dma2bus_addr_var : std_logic_vector(DMA2Bus_Addr'range);
            constant DMA_TO_OPB_DWIDTH_FACTOR : positive
                                              := C_OPB_DWIDTH / DMA_DWIDTH;
            constant DMA_TO_OPB_DWIDTH_FACTOR_BITS : natural
                         := ceil_log2(DMA_TO_OPB_DWIDTH_FACTOR);
        begin
          if Bus2IP_Clk'event and Bus2IP_Clk = '1' then

            dma_sg_sr_pl := dma_sel & sg_sel & sr_sel & pl_sel;

            if Bus2IP_MstLastAck = '1' then
              dma2bus_addr_var := (others => '0');
              DMA2IP_Addr  <= (others => '0');
              DMA2Bus_MstWrReq <= '0';
              DMA2Bus_MstRdReq <= '0';
              DMA2Bus_MstBurst <= '0';
              DMA2Bus_MstNum <= (others => '0');
              --ToDo, include DMA2Bus_MstBE here or, alternatively,
              --consider if taking out all but WrReq and RdReq
              --would be adantageous.
            else 
  --ToDo. May want to use encoded select (regular mux) here.
              case dma_sg_sr_pl is
                when "1000" => 
                    dma2bus_addr_var := dma2bus_addr_dma;
                    DMA2IP_Addr  <= dma2ip_addr_dma;
                    DMA2Bus_MstWrReq <= dma2bus_mstwrreq_dma;
                    DMA2Bus_MstRdReq <= dma2bus_mstrdreq_dma;
                    DMA2Bus_MstBurst <= dma2bus_mstburst_dma;
--                  DMA2Bus_MstBurst <= burst_cond_dma;
                    DMA2Bus_MstNum <= (others => '0');
                    -- ToDo, allow bursts other than size 8.
                    DMA2Bus_MstNum(DMA2Bus_MstNum'right-3) <=
                        dma2bus_mstburst_dma;
                    DMA2Bus_MstNum(DMA2Bus_MstNum'right) <=
                        not dma2bus_mstburst_dma;
                    DMA2Bus_MstLoc2Loc <= '0';
                when "0100" => 
                    dma2bus_addr_var := dma2bus_addr_sg;
                    DMA2IP_Addr  <= dma2ip_addr_sg;
                    DMA2Bus_MstWrReq <= dma2bus_mstwrreq_sg;
                    DMA2Bus_MstRdReq <= dma2bus_mstrdreq_sg;
                    DMA2Bus_MstBurst <= dma2bus_mstburst_sg;
                    DMA2Bus_MstNum <= (others => '0');
                    DMA2Bus_MstNum(DMA2Bus_MstNum'right-3) <=
                        dma2bus_mstburst_sg;
                    DMA2Bus_MstNum(DMA2Bus_MstNum'right) <=
                        not dma2bus_mstburst_sg;
                    DMA2Bus_MstLoc2Loc <= '0';
                when "0010" => 
                    dma2bus_addr_var := std_logic_vector(SRAddrFIFO_out(cco));
                    Debug_TEMP  := C_STAT_FIFO_ADDR(cco)(
                                     C_STAT_FIFO_ADDR(0)'length-C_OPB_AWIDTH
                                     to
                                     C_STAT_FIFO_ADDR(0)'length-1
                                   );
--ToDo, rmv         DMA2IP_Addr  <= Debug_TEMP (C_OPB_AWIDTH - BPST_BITS - C_M to
--ToDo, rmv                                     C_OPB_AWIDTH - BPST_BITS - 1);
                    DMA2IP_Addr  <= Debug_TEMP (C_OPB_AWIDTH - 2 - C_M to
                                                C_OPB_AWIDTH - 2 - 1);
                    DMA2Bus_MstWrReq <= dma2bus_mstwrreq_sr;
                    DMA2Bus_MstRdReq <= '0';
                    DMA2Bus_MstBurst <= '0';
                    DMA2Bus_MstNum <= (others => '0');
                    DMA2Bus_MstNum(DMA2Bus_MstNum'right) <= '1';
                    DMA2Bus_MstLoc2Loc <= '0';
                when "0001" => 
                    dma2bus_addr_var := C_LEN_FIFO_ADDR(cco)(
                                      C_LEN_FIFO_ADDR(0)'length-C_OPB_AWIDTH to
                                      C_LEN_FIFO_ADDR(0)'length-1
                                    );
                    DMA2IP_Addr <= tmp_C_DMA_BASEADDR(
                                          tmp_C_DMA_BASEADDR'length - C_M
                                                                    - 2
                                       to tmp_C_DMA_BASEADDR'length - NUM_CHAN_BITS
                                                                    - RPB
                                                                    - 2
                                                                    - 1
                             )
                           & std_logic_vector(TO_UNSIGNED(cco, NUM_CHAN_BITS))
                           & std_logic_vector(TO_UNSIGNED(r_PLENGTH, RPB)); 
                    DMA2Bus_MstWrReq <= dma2bus_mstwrreq_pl;
                    DMA2Bus_MstRdReq <= not dma2bus_mstwrreq_pl;
                    DMA2Bus_MstBurst <= '0';
                    DMA2Bus_MstNum <= (others => '0');
                    DMA2Bus_MstNum(DMA2Bus_MstNum'right) <= '1';
                    DMA2Bus_MstLoc2Loc <= '1';
                when others =>
                    dma2bus_addr_var := (others => '0');
                    DMA2IP_Addr  <= (others => '0');
                    DMA2Bus_MstWrReq <= '0';
                    DMA2Bus_MstRdReq <= '0';
                    DMA2Bus_MstBurst <= '0';
                    DMA2Bus_MstNum <= (others => '0');
                    DMA2Bus_MstNum(DMA2Bus_MstNum'right) <= '1';
                    DMA2Bus_MstLoc2Loc <= '0';
              end case;
              ------------------------------------------------------------------
              -- If DMA_WIDTH = C_OPB_DWIDTH or this master transaction is to
              -- move DMA data, then enable all byte lanes...
              ------------------------------------------------------------------
              DMA2Bus_MstBE <= (others => '1');
              ------------------------------------------------------------------
              -- ... otherwise, enable only the 4 byte lanes
              --  implied by the address.
              ------------------------------------------------------------------
              if DMA_TO_OPB_DWIDTH_FACTOR > 1 and dma_sel = '0' then
                for i in 0 to DMA_TO_OPB_DWIDTH_FACTOR-1 loop
                  if UNSIGNED(dma2bus_addr_var(
                                C_OPB_AWIDTH - 2 - DMA_TO_OPB_DWIDTH_FACTOR_BITS to --ToDo, give the 2 and symbolic name
                                C_OPB_AWIDTH - 2 - 1
                              )
                     ) /= i
                  then
                    DMA2Bus_MstBE(4*i to 4*(i+1)-1) <= "0000";
                  end if;
                end loop;
              end if;
              --
            end if;
            DMA2Bus_Addr <= dma2bus_addr_var;
          end if; -- Bus2IP_Clk'event and Bus2IP_Clk = '1'
        end process;

    end block;
    --= end, Master arbitration and concentration.

    --- SRAddrFIFO for each rx pkt or tx pkt channel.
    SRAddrFIFO_GEN: for i in 0 to LAST_CHAN generate
      SRAddrFIFO_GEN: if C_DMA_CHAN_TYPE(i) = 2 or
                              C_DMA_CHAN_TYPE(i) = 3 generate
        I_SRL_FIFO : SRL_FIFO
          generic map (
            C_DATA_BITS => DMA_DWIDTH, -- ToDo, C_OPB_AWIDTH /= DMA_DWIDTH
                                       -- would need some attention in places
                                       -- where a data value becomes an address.
            C_DEPTH     => 16
          )
          port map (
            Clk         => Bus2IP_Clk,
            Reset       => reset(i),
            FIFO_Write  => wr_SRAddrFIFO(i),
            Data_In     => dma2bus_addr_sg,
            FIFO_Read   => rd_SRAddrFIFO(i),
            Data_Out    => SRAddrFIFO_out(i),
            FIFO_Full   => SRAddrFIFO_full(i),
            Data_Exists => SRAddrFIFO_nonempty(i),
            Addr        => open
          );
      end generate;
      -- Tie off outputs for non-existent instances.
      SRAddrFIFO_TIEOFF_GEN: if C_DMA_CHAN_TYPE(i) = 0 or
                                C_DMA_CHAN_TYPE(i) = 1 generate
          SRAddrFIFO_out(i) <= (others => '0');
          SRAddrFIFO_full(i) <= '0';
          SRAddrFIFO_nonempty(i) <= '0';
      end generate;
    end generate;
    --= end, SRAddrFIFO for each rx pkt or tx pkt channel.


    --- DMA state machine.
    DMA_SM: block 
        type dma_state is (
            IDLE,
            DONECHK,    -- Done check. Test for end of DMA operation.
            XACTION,    -- Perform a bus transaction.
            GET_BDA,
            HANDLE_SRA, -- If required, save the address of where SR will go.
            GET_DMACR,
            GET_SA,
            GET_DA,
            GET_LENGTH,
            GET_PLENGTH,
            PUT_LENGTH, -- Write the completion LENGTH.
            PUT_DMASR,  -- Write the DMA completion status.
            LQCHK,       
            PUT_PLENGTH,
            HALT,
            A_WRITE_SR,
            B_WRITE_SR,
            C_WRITE_SR
        );
        type dma_state_array is array(0 to LAST_CHAN) of dma_state;
        signal dma_cs              : dma_state_array;
        signal dma_ns              : dma_state; 
        signal block_chan_muxing   : std_logic;
        signal dma_sel_ns          : std_logic;
        signal sg_sel_ns           : std_logic;
        signal pl_sel_ns           : std_logic;
        signal sr_sel_ns           : std_logic;
        signal dma2bus_mstburst_dma_ns : std_logic;
        signal mstr_op_done        : std_logic;
        signal mstr_op_done_ns     : std_logic;
        signal wr_cond, rd_cond    : std_logic; -- direction of the mem xfer

        -- XGR wa F.23 bug
        signal XGR_tmp             : dma_state;


    begin

        -- XGR wa F.23 bug
        XGR_tmp <= dma_cs(cco);

        DMA_SM_COM_PROCESS: process(
            dma_cs, dma_active, LENGTH_cco, PLENGTH_cco,
            cco, rx, tx, LENGTH_ge_BPBT, WFIFO2DMA_Vacancy,
            Bus2IP_MstWrAck, Bus2IP_MstRdAck, Mstr_sel_ma,
            Bus2IP_MstError, Bus2IP_MstTimeOut, Bus2IP_MstLastAck,
            burst_cond_dma, dest_is_a_fifo,
            first, no_bda_link, sg_active, sgGo, L_tx,
            IP2DMA_TxLength_Full,  IP2DMA_RxLength_Empty,
            IP2DMA_TxStatus_Empty, SRAddrFIFO_nonempty,
            XGR_tmp, -- XGR wa F.23 bug
            SRAddrFIFO_cco_hasroom, dma2bus_mstburst_dma, dma_completing
        )
            variable incdec            : std_logic;
            variable rx_pkt_complete   : std_logic;
        begin

          -- Default assignments for dma_ns and state machine outputs.
          dma_starting        <= '0';
          dma_completing      <= '0';
          block_chan_muxing   <= '0';
          set_L_rx            <= '0';
	  set_DBE             <= '0';
          set_DBT             <= '0';
          inc_SA              <= '0';
          inc_DA              <= '0';
          dec_LENGTH          <= '0';
          inc_PLENGTH         <= '0';
          dec_PLENGTH         <= '0';
          clr_PLENGTH         <= '0';
          dma_sel_ns          <= '0';
          sg_sel_ns           <= '0';
          pl_sel_ns           <= '0';
          sr_sel_ns           <= '0';
          dma2bus_mstburst_dma_ns <= '0';
          reset_sg_offset     <= '0';
          inc_sg_offset       <= (others => '0');
          dma2bus_mstwrreq_sg <= '0';
          dma2bus_mstwrreq_sr <= '0';
          dma2bus_mstwrreq_pl <= '0';
          mstr_op_done_ns     <= '0';
          update_first        <= '0';
          wr_SRAddrFIFO       <= (others => '0');
          rd_SRAddrFIFO       <= (others => '0');
          is_idle             <= (others => '0');
          rx_pkt_complete     := bo2sl(rx(cco)='1' and (PLENGTH_cco=0));

          -- Next state and output logic.
          --case dma_cs(cco) is
          case XGR_tmp is

--ToDo. There may be only one rx or tx channel because there is just one
--      each of IP2DMA_RxStatus_Empty and IP2DMA_TxStatus_Empty.

            when IDLE =>
              is_idle(cco) <= '1';
              if    (tx(cco) and not IP2DMA_TxStatus_Empty) = '1'
                 or (rx_pkt_complete and SRAddrFIFO_nonempty(cco)) = '1' then
                  sr_sel_ns <= '1';
                  block_chan_muxing <= '1';
                  dma_ns <= A_WRITE_SR;
              else
                if sgGo(cco) = '1' then
                    if (not rx(cco) or not IP2DMA_RxLength_Empty
                                    or not first(cco)
                       ) = '1' then    -- ToDo. IP2DMA_RxLength_Empty being
                                       -- scalar allows for just one Rx chan.
                      if (not no_bda_link(cco)) = '1' then
                        sg_sel_ns <= '1';
                        block_chan_muxing <= '1';
                        dma_ns <= GET_BDA;
                      elsif (rx(cco) and first(cco)) = '1' then
                        pl_sel_ns <= '1';
                        block_chan_muxing <= '1';
                        reset_sg_offset <= '1';
                        dma_ns <= GET_PLENGTH;
                      else 
                        block_chan_muxing <= '1';  -- Optional.
                        reset_sg_offset <= '1';
                        dma_ns <= HANDLE_SRA;
                      end if;
                    else
                        dma_ns <= IDLE;
                    end if;
                else
                    if  dma_active(cco) = '1' then  -- Simple DMA.
                        dma_starting <= '1';
                        dma_ns <= DONECHK;
                    else
                        dma_ns <= IDLE;
                    end if;
                end if;
              end if;

            when GET_BDA =>
                -- This implementation assumes that the Bus2IP_MstLastAck
                -- is concurrent with or follows the IP2Bus_WrAck that actually
                -- writes the PLENGTH register. (An earlier implementation
                -- assumed the opposite order--allowing the MasterAttachment/
                -- SlaveAttachment to do a posted write. When that
                -- implementation actually experienced the opposite during
                -- operation, then state GET_BDA's successor state,
                -- GET_PLENGTH, would respond to the Bus2IP_MstLastAck
                -- that corresponds to state GET_BDA!)
                -- State GET_LENGTH has similar considerations.
                if Bus2IP_MstLastAck = '1' then
                  if (rx(cco) and first(cco)) = '1' then
                    pl_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    reset_sg_offset <= '1';
                    dma_ns <= GET_PLENGTH;
                  else
                    block_chan_muxing <= '1';  -- Optional.
                    reset_sg_offset <= '1';
                    dma_ns <= HANDLE_SRA;
                  end if;
                else
                    block_chan_muxing <= '1';
                    sg_sel_ns <= '1';
                    dma_ns <= GET_BDA;
                end if;

            when GET_PLENGTH =>
                if Bus2IP_MstLastAck = '1' then
                    block_chan_muxing <= '1';  -- Optional.
                    dma_ns <= HANDLE_SRA;
                else
                    block_chan_muxing <= '1';
                    pl_sel_ns <= '1';
                    dma_ns <= GET_PLENGTH;
                end if;

            when HANDLE_SRA =>
              if (tx(cco) and not IP2DMA_TxStatus_Empty) = '1' then
                  sr_sel_ns <= '1';
                  block_chan_muxing <= '1';
                  dma_ns <= C_WRITE_SR;
              elsif ((rx(cco) or tx(cco)) and first(cco)) = '1' then
--ToDo. Does first(cco) imply (rx(cco) or tx(cco))? If so,
--      (rx(cco) or tx(cco)) could be removed here.
                  if (SRAddrFIFO_cco_hasroom = '1') then
                      wr_SRAddrFIFO(cco) <= '1';
                      inc_sg_offset(cco) <= '1';
                      block_chan_muxing <= '1';
                      sg_sel_ns <= '1';
                      dma_ns <= GET_DMACR;
                  else
                      dma_ns <= HANDLE_SRA;
                  end if;
              else
                  inc_sg_offset(cco) <= '1';
                  block_chan_muxing <= '1';
                  sg_sel_ns <= '1';
                  dma_ns <= GET_DMACR;
              end if;

            when GET_DMACR =>
                if Bus2IP_MstLastAck = '1' then
                    sg_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    inc_sg_offset(cco) <= '1';
                    dma_ns <= GET_SA;
                else
                    sg_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= GET_DMACR;
                end if;

            when GET_SA =>
                if Bus2IP_MstLastAck = '1' then
                    sg_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    inc_sg_offset(cco) <= '1';
                    dma_ns <= GET_DA;
                else
                    sg_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= GET_SA;
                end if;

            when GET_DA =>
                if Bus2IP_MstLastAck = '1' then
                    sg_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    inc_sg_offset(cco) <= '1';
                    dma_ns <= GET_LENGTH;
                else
                    sg_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= GET_DA;
                end if;

            when GET_LENGTH =>
                if Bus2IP_MstLastAck = '1' then
                   -- See the comment of state GET_ BDA for considerations
                   -- that also apply to this state. The load of the LENGTH
                   -- register needs be complete before proceeding to the
                   -- next state. (A "MstLastAck" indication ahead of the
                   -- completion of a posted write will not work. An earlier
                   -- version had such posted write behavior. In that version,
                   -- this state was not exited until the LENGTH register
                   -- actually loaded; signal load_length(cco) was used.)
                    dma_starting <= '1';
                    dma_ns <= DONECHK;
                else
                    block_chan_muxing <= '1';
                    sg_sel_ns <= '1';
                    dma_ns <= GET_LENGTH;
                end if;

            when DONECHK =>
                dma_completing <= bo2sl(LENGTH_cco = 0) or rx_pkt_complete;
                if (tx(cco) and not IP2DMA_TxStatus_Empty) = '1' then
                    sr_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= B_WRITE_SR;
                elsif dma_completing = '1' then
                    set_L_rx <= rx_pkt_complete;
                    if sg_active(cco) = '1' then
                        sg_sel_ns <= '1';
                        block_chan_muxing <= '1';
                        dma_ns <= PUT_LENGTH;
                    else
                        dma_ns <= IDLE;
                    end if;
                elsif
                -- We go to do a bus transaction when we are not at the normal
                -- end of a DMA operation and there is not a condition
                -- that keeps us from proceeding.
                -- The condition that could keep us from proceeding is that
                -- we are writing to a FIFO and it doesn't have vacancy
                -- to (1) accomodate a single transfer in the case there isn't
                -- enough left to do a burst or, otherwise, to (2) accomodate
                -- a burst.
                      (    dma_completing = '0'
                       and not (    (dest_is_a_fifo = '1')
                                and (   (    LENGTH_ge_BPBT = '0'
                                         and UNSIGNED(WFIFO2DMA_Vacancy) = 0
                                        )
                                     or (    LENGTH_ge_BPBT = '1'
                                         and UNSIGNED(WFIFO2DMA_Vacancy) < TPB
                                        )
                                    )
                               )
                      ) then
                    dma_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma2bus_mstburst_dma_ns <= burst_cond_dma;
                    dma_ns <= XACTION;
                else
                    dma_ns <= DONECHK;
                end if;

            when XACTION => 
                incdec :=
                  (Bus2IP_MstWrAck or Bus2IP_MstRdAck) and Mstr_sel_ma;
                inc_SA <= incdec;
                inc_DA <= incdec;
                dec_LENGTH <= incdec;
                inc_PLENGTH <= incdec and tx(cco);
                dec_PLENGTH <= incdec and rx(cco);
                if (Bus2IP_MstError or Bus2IP_MstTimeOut) = '1' then
                    set_DBE <= Bus2IP_MstError;
                    set_DBT <= Bus2IP_MstTimeOut;
                    dma_completing <= '1';
                    if sg_active(cco) = '1' then
                        dma_ns <= HALT;
                    else
                        dma_ns <= IDLE;
                    end if;
                elsif (Bus2IP_MstLastAck) = '1' then
                  --block_chan_muxing  <= '1';   -- Optional, no blocking for
                                                 -- find-grain switching
                                                 -- between channels.
                    dma_ns <= DONECHK;
                else
                    dma_sel_ns <= '1';
                    block_chan_muxing  <= '1';
                    dma2bus_mstburst_dma_ns <= dma2bus_mstburst_dma;
                    dma_ns <= XACTION;
                end if;

            when PUT_LENGTH =>
                dma2bus_mstwrreq_sg <= '1';
                if Bus2IP_MstLastAck = '1' then
                    block_chan_muxing <= '1';
                    sg_sel_ns <= '1';
                    inc_sg_offset(cco) <= '1';
                    dma_ns <= PUT_DMASR;
                else
                    block_chan_muxing <= '1';
                    sg_sel_ns <= '1';
                    dma_ns <= PUT_LENGTH;
                end if;

            when PUT_DMASR =>
                dma2bus_mstwrreq_sg <= '1';
                if Bus2IP_MstLastAck = '1' then
                    inc_sg_offset(cco) <= '1';
                    dma_ns <= LQCHK;
                else
                    block_chan_muxing <= '1';
                    sg_sel_ns <= '1';
                    dma_ns <= PUT_DMASR;
                end if;

            when LQCHK =>
                update_first <= '1';
                if (not tx(cco) or not L_tx(cco)) = '1' then
                    dma_ns <= IDLE;
                elsif (not IP2DMA_TXLength_Full) = '1' then
                    block_chan_muxing <= '1';
                    pl_sel_ns <= '1';
                    dma_ns <= PUT_PLENGTH;
                else
                    dma_ns <= LQCHK;
                end if;

            when PUT_PLENGTH =>
                dma2bus_mstwrreq_pl <= '1';
                if Bus2IP_MstLastAck = '1' then
                    clr_PLENGTH <= '1';
                    dma_ns <= IDLE;
                else
                    block_chan_muxing <= '1';
                    pl_sel_ns <= '1';
                    dma_ns <= PUT_PLENGTH;
                end if;

            when HALT =>
                dma_ns <= HALT;

            when A_WRITE_SR =>
                is_idle(cco) <= '1';
--ToDo. Perhaps can eliminate this sig and drive dma2bus_mstwrreq to '1' when sr_sel
                dma2bus_mstwrreq_sr <= '1';
                if Bus2IP_MstLastAck = '1' then
                    rd_SRAddrFIFO(cco) <= '1';
                    dma_ns <= IDLE;
                else
                    sr_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= A_WRITE_SR;
                end if;

            when B_WRITE_SR =>
                dma2bus_mstwrreq_sr <= '1';
                if Bus2IP_MstLastAck = '1' then
                    rd_SRAddrFIFO(cco) <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= DONECHK;
                else
                    sr_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= B_WRITE_SR;
                end if;

            when C_WRITE_SR =>
                dma2bus_mstwrreq_sr <= '1';
                if Bus2IP_MstLastAck = '1' then
                    rd_SRAddrFIFO(cco) <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= HANDLE_SRA;
                else
                    sr_sel_ns <= '1';
                    block_chan_muxing <= '1';
                    dma_ns <= C_WRITE_SR;
                end if;

          end case;
        end process;

        DMA_SM_DMA_CS_REG_PROCESS: process(Bus2IP_Clk)
        begin
          for i in 0 to LAST_CHAN loop
            if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
               if reset(i) = '1' then
                   dma_cs(i) <= IDLE;
               elsif cco = i then
                   dma_cs(i) <= dma_ns;
               end if; 
            end if;
          end loop;
        end process;

        DMA_SM_OTHER_REG_PROCESS: process(Bus2IP_Clk)
        begin
            if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
                if Bus2IP_Reset='1' then
                    dma_sel <= '0';
                    sg_sel <= '0';
                    pl_sel <= '0';
                    sr_sel <= '0';
                    dma2bus_mstburst_dma <= '0';
                    mstr_op_done <= '0';
                    cco <= 0;
                else
                    dma_sel <= dma_sel_ns;
                    sg_sel <= sg_sel_ns;
                    pl_sel <= pl_sel_ns;
                    sr_sel <= sr_sel_ns;
                    dma2bus_mstburst_dma <= dma2bus_mstburst_dma_ns;
                    mstr_op_done <= mstr_op_done_ns;
                    if block_chan_muxing = '0' then
                        if cco = LAST_CHAN then
                            cco <= 0;
                        else
                            cco <= cco+1;
                        end if;
                    end if;
                end if;
            end if;
        end process;

        wr_cond <= SLOCAL(cco) and not DLOCAL(cco);
        rd_cond <= DLOCAL(cco) and not SLOCAL(cco);

        dma2bus_addr_dma <= std_logic_vector(SA(cco)) when rd_cond = '1' else
                            std_logic_vector(DA(cco));

--ToDo. Change 29, below, to symbolic constant.
--      Results from the fact that the low-order two (byte) bits are not
--      passed out on DMA2IP_Addr.
--
--      dma2ip_addr_dma  <= std_logic_vector(DA(cco)(29-C_M+1 to 29))
--                          when rd_cond = '1'
--                          else
--                          std_logic_vector(SA(cco)(29-C_M+1 to 29));
        dma2ip_addr_dma  <= std_logic_vector(DA(cco)(DMA_DWIDTH-2-C_M to 
                                                     DMA_DWIDTH-2-1))
                            when rd_cond = '1'
                            else
                            std_logic_vector(SA(cco)(DMA_DWIDTH-2-C_M to
                                                     DMA_DWIDTH-2-1));

        dma2bus_mstwrreq_dma <= wr_cond;
        dma2bus_mstrdreq_dma <= rd_cond;

        burst_cond_dma <= bo2sl(C_DMA_ALLOW_BURST) and
                          (   (rx(cco) and PLENGTH_ge_BPBT and LENGTH_ge_BPBT)
                           or (not rx(cco) and  LENGTH_ge_BPBT)
                          );
            -- Note for burst_cond_dma: We pass up the opportunity to include
            -- in a burst a last word that has padding and whose padding would
            -- bring the total to exactly BPBT. This allows a simpler test.
            -- For example, with BPBT = 32, we use a "length" >= 32 test, and
            -- we are passing up optimization of the 29, 30 and 31 cases
            -- in order to have a simpler test.

        SG_ACTIVE_PROCESS: process (Bus2IP_Clk) is
        begin
            if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
                for i in 0 to LAST_CHAN loop
                    if reset(i) = '1' then
                        sg_active(i) <= '0';
                        sg_active_d1(i) <= '0';
                    else
                        sg_active_d1(i) <= sg_active(i);
                        if (SGE(i) and not SGS(i)) = '1' then
                            sg_active(i) <= '1';
                        elsif     is_idle(i) = '1'
                              and (   (    C_DMA_CHAN_TYPE(i) /=2
                                       and C_DMA_CHAN_TYPE(i) /=3
                                      )
                                   or (    SRAddrFIFO_nonempty(i) = '0'
                                       and first(i) = '1'
                                      )
                                  ) then
                            sg_active(i) <= '0';
                        end if;
                    end if;
                end loop;
            end if;
        end process;

    end block;
    --= end, DMA state machine.

    --- SG MQ bundle.
    SG_SM: block 
    begin
      dma2bus_addr_sg  <= std_logic_vector(
--ToDo, rmv                   BDA(cco)(0 to BDA(cco)'length - BPST_BITS -1)
                              BDA(cco)(0 to BDA(cco)'length - 2 - 1)
                            + sg_offset(cco)
                          ) & "00";
      dma2ip_addr_sg   <=     tmp_C_DMA_BASEADDR(
--ToDo, rmv                        tmp_C_DMA_BASEADDR'length - BPST_BITS
                                   tmp_C_DMA_BASEADDR'length - 2
                                                             - C_M
--ToDo, rmv                     to tmp_C_DMA_BASEADDR'length - BPST_BITS
                                to tmp_C_DMA_BASEADDR'length - 2
                                                             - NUM_CHAN_BITS 
                                                             - RPB
                                                             - 1
                              )
                            & std_logic_vector(TO_UNSIGNED(cco, NUM_CHAN_BITS))
                            & std_logic_vector(sg_offset(cco)); 

      dma2bus_mstrdreq_sg  <= not dma2bus_mstwrreq_sg;
      dma2bus_mstburst_sg  <= '0';
    end block;
    --= end, SG MQ bundle.

end sim; --)









