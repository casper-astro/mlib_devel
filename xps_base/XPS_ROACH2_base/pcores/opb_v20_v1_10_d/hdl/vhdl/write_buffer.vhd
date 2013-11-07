-------------------------------------------------------------------------------
-- $Id: write_buffer.vhd,v 1.1.2.1 2009/10/06 21:15:02 gburch Exp $
-------------------------------------------------------------------------------
-- write_buffer.vhd - vhdl design file for the entity and architecture
--                            of the Mauna Loa IPIF Bus to IPIF Bus Address
--                            multiplexer.
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
-- ** Copyright (c) 2004,2009 Xilinx, Inc. All rights reserved.           **
-- **                                                                     **
-- ** This copyright and support notice must be retained as part          **
-- ** of this text at all times.                                          **
-- **                                                                     **
-- *************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        write_buffer.vhd
--
-- Description:     This vhdl design file is for the entity and architecture
--                  of the write buffer design.
--
-------------------------------------------------------------------------------
-- Structure:
--
--
--              write_buffer.vhd
--
-------------------------------------------------------------------------------
-- Author:      ALS
-- History:
--
--
--      GAB       04/14/04
-- ^^^^^^
--      Updated to proc_common_v2_00_a
--      Fixed issues with master aborts, delayed IP acknowledges, and single
--      beat reads (i.e. rdce was 2 clocks wide)
-- ~~~~~~~
--      GAB       07/07/04
-- ^^^^^^
--      Fixed issues with xferack due to changes in opb_bam signal timing
--      Fixed wrbuf_burst signal to negate 1 cycle before cs negates
--      Fixed wrbuf_addrvalid signal to only drive during valid addresses
-- ~~~~~~~
--  GAB         10/05/09
-- ^^^^^^
--  Moved all helper libraries proc_common_v2_00_a, opb_ipif_v3_01_a, and
--  opb_arbiter_v1_02_e locally into opb_v20_v1_10_d
--
--  Updated legal header
-- ~~~~~~
---------------------------------------------------------------------------------
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
--
-- Library definitions

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.or_reduce;


library unisim;
use unisim.vcomponents.all;

library opb_v20_v1_10_d;
use opb_v20_v1_10_d.srl_fifo3;
use opb_v20_v1_10_d.proc_common_pkg.log2;
use opb_v20_v1_10_d.counter;

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
entity write_buffer is
  generic (
           C_INCLUDE_OPBIN_PSTAGE   : boolean := TRUE;
           C_INCLUDE_IPIC_PSTAGE    : boolean := TRUE;
           C_INCLUDE_OPBOUT_PSTAGE  : boolean := TRUE;
           C_OPB_DWIDTH             : integer := 32;
           C_WRBUF_DEPTH            : integer := 16; -- max is 16
           C_NUM_CES                : integer := 4;
           C_NUM_ARDS               : integer := 4
          );
    port (
       -- Clock and Reset
         Bus_reset          : in  std_logic;
         Bus_clk            : in  std_logic;


       -- Inputs
         Data_in            : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
         CE                 : in  std_logic_vector(0 to C_NUM_CES-1);
         Wr_CE              : in  std_logic_vector(0 to C_NUM_CES-1);
         Rd_CE              : in  std_logic_vector(0 to C_NUM_CES-1);
         RNW                : in  std_logic;
         CS_hit             : in  std_logic_vector(0 to C_NUM_ARDS-1);
         CS                 : in  std_logic_vector(0 to C_NUM_ARDS-1);
         CS_enable          : in  std_logic_vector(0 to C_NUM_ARDS-1);
         Burst              : in  std_logic;
         Xfer_start         : in  std_logic;
         Xfer_done          : in  std_logic;
         Addr_ack           : in  std_logic;
         Wrdata_ack         : in  std_logic;

         WrBuf_data         : out std_logic_vector(0 to C_OPB_DWIDTH-1);
         WrBuf_burst        : out std_logic;
         WrBuf_xferack      : out std_logic;
         WrBuf_errack       : out std_logic;
         WrBuf_retry        : out std_logic;
         WrBuf_CS           : out std_logic_vector(0 to C_NUM_ARDS-1);
         WrBuf_RNW          : out std_logic;
         WrBuf_CE           : out std_logic_vector(0 to C_NUM_CES-1);
         WrBuf_WrCE         : out std_logic_vector(0 to C_NUM_CES-1);
         WrBuf_RdCE         : out std_logic_vector(0 to C_NUM_CES-1);
         WrBuf_Empty        : out std_logic;

         WrBuf_AddrCnt_en   : out std_logic;
         WrBuf_AddrCntr_rst : out std_logic;
         WrBuf_AddrValid    : out std_logic;
         IPIC_Pstage_CE     : out std_logic
         );
end write_buffer;

architecture implementation of write_buffer is
-----------------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------------
function "and"  ( l : std_logic_vector; r : std_logic )
return std_logic_vector is
    variable rex : std_logic_vector(l'range);
begin
    rex := (others=>r);
    return( l and rex );
end function "and";

-------------------------------------------------------------------------------
-- Constant Declaration
-------------------------------------------------------------------------------
constant ZERO_LOAD          : std_logic_vector(0 to 4) := (others => '0');
-------------------------------------------------------------------------------
-- Signal Declaration
-------------------------------------------------------------------------------
signal  wrbuf_write         : std_logic;
signal  wrbuf_write_d1      : std_logic;
signal  wrbuf_write_re      : std_logic;
signal  wrbuf_read          : std_logic;
signal  wrbuf_data_i        : std_logic_vector(0 to C_OPB_DWIDTH-1);
signal  wrbuf_full          : std_logic;
signal  wrbuf_empty_i       : std_logic;
signal  wrbuf_empty_d1      : std_logic;
signal  wrbuf_empty_fe      : std_logic;
signal  wrdata_ack_d1       : std_logic;
signal  wrbuf_addr          : std_logic_vector(0 to 3);
signal  wrbuf_going_full    : std_logic;
signal  wrbuf_going_empty   : std_logic;
signal  wrbuf_wrce_i        : std_logic_vector(0 to C_NUM_CES-1);
signal  wrbuf_rdce_i        : std_logic_vector(0 to C_NUM_CES-1);
signal  wrbuf_ce_i          : std_logic_vector(0 to C_NUM_CES-1);
signal  wrbuf_rnw_i         : std_logic;
signal  wrbuf_burst_i       : std_logic;
signal  wrbuf_cs_i          : std_logic_vector(0 to C_NUM_ARDS-1);
signal  wrbuf_addrcnt_en_i  : std_logic;
signal  wrbuf_addrcntr_rst_i: std_logic;
signal  wrbuf_xferack_i     : std_logic;
signal  wrbuf_retry_i       : std_logic;
signal  wrbuf_retry_d1      : std_logic;
signal  wrbuf_retry_d2      : std_logic;

signal  valid_addr_cntr_ce  : std_logic;
signal  valid_addr_cnt      : std_logic_vector(0 to 4);

signal  sample_hold_ce      : std_logic;
signal  xfer_start_reg      : std_logic;

signal  cs_rnw_rst          : std_logic;

signal wrbuf_write_i        : std_logic;
signal burst_d1             : std_logic;

signal wrbuf_full_retry     : std_logic;
signal wrbuf_xferack_cmb    : std_logic;
signal wrbuf_xferack_d1     : std_logic;
signal wr_ce_i              : std_logic;

signal wrbuf2ip_burst       : std_logic;
signal wrbuf_addrvalid_i    : std_logic;

-------------------------------------------------------------------------------
-- Begin
-------------------------------------------------------------------------------
begin

-------------------------------------------------------------------------------
-- Output assignments
-------------------------------------------------------------------------------
WrBuf_data          <= wrbuf_data_i;
WrBuf_RNW           <= wrbuf_rnw_i;
WrBuf_Burst         <= wrbuf2ip_burst;
WrBuf_WrCE          <= wrbuf_wrce_i;
WrBuf_RdCE          <= wrbuf_rdce_i;
WrBuf_CE            <= wrbuf_ce_i;
WrBuf_CS            <= wrbuf_cs_i;
WrBuf_AddrCnt_en    <= wrbuf_addrcnt_en_i;
WrBuf_AddrCntr_Rst  <= wrbuf_addrcntr_rst_i;
WrBuf_Empty         <= wrbuf_empty_i;


-------------------------------------------------------------------------------
-- Transaction acknowledges
-------------------------------------------------------------------------------
-- XferAck--
-- Assert XferAck when at the start of a xfer if wrbuffer is empty, keep
-- asserted until wrbuffer is full or cs_hit = 0
-- Don't need to qualify with CS_Hit because the XferAck logic in OPB_BAM
-- takes care of this
--ToDo: see if wrbuf_going_empty can be used
XFERACK_REG: process(Bus_clk)
begin
    if Bus_clk'event and Bus_clk = '1' then
        if or_reduce(CS_hit) ='0'
        or (wrbuf_xferack_i = '1' and Burst = '0')
        or (wrbuf_rnw_i='0' and wrbuf_going_empty='1' and wrdata_ack='1')then
            wrbuf_xferack_i <= '0';
        elsif xfer_start = '1' and wrbuf_empty_i = '1' and RNW = '0' then
            wrbuf_xferack_i <= '1';
        end if;
    end if;
end process XFERACK_REG;


wrbuf_xferack_cmb   <= (((wrbuf_xferack_i and or_reduce(CS_hit))
                        or  (or_reduce(CS_hit) and wrbuf_empty_i
                        and not(RNW) and xfer_start and Burst))
                        and not wrbuf_going_full);

-- Generate for pipeline models 5 and 7
GEN_PIPE_5_7 : if C_INCLUDE_OPBIN_PSTAGE  = true
              and C_INCLUDE_OPBOUT_PSTAGE = true generate

    WrBuf_xferack   <= wrbuf_xferack_d1 and not wrbuf_going_full
                        and not wrbuf_retry_i and or_reduce(CS_hit);
end generate;


-- Generate for pipeline models 1,2,3,4,and 6
GEN_PIPE_THE_REST : if (C_INCLUDE_OPBIN_PSTAGE = false
                    or C_INCLUDE_OPBOUT_PSTAGE = false)generate

    WrBuf_xferack   <= wrbuf_xferack_d1 and not wrbuf_retry_i
                        and or_reduce(CS_hit);
end generate;

-------------------------------------------------------------------------------
-- Transaction Retry
-------------------------------------------------------------------------------
-- If the write buffer is almost full set the full retry flag
-- keep this flag set until the write buffer empties.  This
-- will prevent further cycles from occuring once the write
-- buffer becomes full.
RETRY_FULL_PROCESS : process(Bus_clk)
    begin
        if(Bus_clk'EVENT and Bus_clk = '1')then
            -- When buffer returns to empty state then reset retry flag
            if(Bus_reset = '1' or wrbuf_empty_i = '1')then
                wrbuf_full_retry <= '0';
            -- When buffer is almost full set retry flag
            elsif(wrbuf_going_full = '1')then
                wrbuf_full_retry <= '1';
            end if;
        end if;
    end process RETRY_FULL_PROCESS;

wrbuf_retry_i <=    (xfer_start and not wrbuf_empty_i)
                or  (RNW and not wrbuf_empty_i)
                or  (wrbuf_full_retry);

WrBuf_retry <= wrbuf_retry_i;


-------------------------------------------------------------------------------
-- Transaction Error
-------------------------------------------------------------------------------
-- This signal is never asserted
WrBuf_errack <= '0';

-------------------------------------------------------------------------------
-- Actual write buffer implemented using SRL_FIFO
-------------------------------------------------------------------------------
WRBUF_DATA_FIFO: entity opb_v20_v1_10_d.srl_fifo3
    generic map ( C_DWIDTH  => C_OPB_DWIDTH,
                  C_DEPTH   => C_WRBUF_DEPTH)

    port map (
                Clk                 =>  Bus_clk,
                Reset               =>  Bus_reset,
                FIFO_Write          =>  wrbuf_write,
                Data_In             =>  Data_in,
                FIFO_Read           =>  wrbuf_read,
                Data_Out            =>  wrbuf_data_i,
                FIFO_Full           =>  wrbuf_full,
                FIFO_Empty          =>  wrbuf_empty_i,
                FIFO_AlmostEmpty    =>  wrbuf_going_empty,
                Data_Exists         =>  open,
                Addr                =>  wrbuf_addr
            );

-------------------------------------------------------------------------------
-- Generation of write buffer control signals
-------------------------------------------------------------------------------
FIFO_WRITE_2_GEN : if   not(C_INCLUDE_OPBIN_PSTAGE)
                    and    (C_INCLUDE_IPIC_PSTAGE)
                    and not(C_INCLUDE_OPBOUT_PSTAGE) generate

    wrbuf_write_i <=  (xfer_start and not RNW and not Burst and not(wrbuf_retry_i))
                   or (wr_ce_i and not(wrbuf_retry_d1) and not(wrbuf_retry_i));
end generate;

FIFO_WRITE_REST_GEN : if     C_INCLUDE_OPBIN_PSTAGE
                      or not(C_INCLUDE_IPIC_PSTAGE)
                      or     C_INCLUDE_OPBOUT_PSTAGE generate

    wrbuf_write_i <=  (xfer_start and not RNW and not Burst and not(wrbuf_retry_i))
                   or (wr_ce_i and not(wrbuf_retry_d1));
end generate;

wrbuf_write <= wrbuf_write_i;

wrbuf_read  <= Wrdata_ack;

-- Write Buffer is almost full
wrbuf_going_full <= '1' when wrbuf_addr >= C_WRBUF_DEPTH-3
                        else '0';


REG_FOR_FMAX_PROCESS : process(Bus_clk)
    begin
        if(Bus_clk'EVENT and Bus_clk = '1')then
            wrbuf_xferack_d1    <= wrbuf_xferack_cmb;
            wrbuf_retry_d1      <= wrbuf_retry_i;
        end if;
    end process REG_FOR_FMAX_PROCESS;


-- Generate register for pipeline models 5 and 7
REGWRCE_GEN_5_7 : if C_INCLUDE_OPBIN_PSTAGE and C_INCLUDE_OPBOUT_PSTAGE generate
    REG_WRCE : process(Bus_clk)
        begin
            if(Bus_clk'EVENT and Bus_clk = '1')then

                wr_ce_i         <= or_reduce(Wr_CE)
                                    and Burst
                                    and not(wrbuf_retry_d2);

                wrbuf_retry_d2  <= wrbuf_retry_d1;
            end if;
        end process REG_WRCE;
end generate;

-- Generate register for pipeline models 1,3,4, and 6
REGWRCE_GEN_1_3_4_6 : if (C_INCLUDE_OPBIN_PSTAGE and not(C_INCLUDE_OPBOUT_PSTAGE))
                    or (not(C_INCLUDE_OPBIN_PSTAGE) and C_INCLUDE_OPBOUT_PSTAGE) generate
    REG_WRCE : process(Bus_clk)
        begin
            if(Bus_clk'EVENT and Bus_clk = '1')then
                wr_ce_i         <= or_reduce(Wr_CE)
                                    and Burst
                                    and not(wrbuf_retry_d1);
            end if;
        end process REG_WRCE;
end generate;

-- Generate register for pipeline models 0 and 2
REGWRCE_GEN_0_2 : if  not(C_INCLUDE_OPBIN_PSTAGE) and not(C_INCLUDE_OPBOUT_PSTAGE) generate
    REG_WRCE : process(Bus_clk)
        begin
            if(Bus_clk'EVENT and Bus_clk = '1')then
                wr_ce_i         <= or_reduce(Wr_CE)
                                    and Burst;
            end if;
        end process REG_WRCE;
end generate;

-------------------------------------------------------------------------------
-- Need to count number of valid addresses to be generated (matches the number
-- of data words written into the write buffer) and allow the
-- address counter to only produce that number of addresses
-- counter only needs to count to the max buffer size (16)
-- count up with each wrbuf_write and count down with each Addr_ack - don't
-- count when wrbuf_write and Addr_ack are both asserted
--------------------------------------------------------------------------------
valid_addr_cntr_ce  <= wrbuf_write xor Addr_ack;

VALID_ADDR_CNTR: entity opb_v20_v1_10_d.counter
    generic map ( C_NUM_BITS    => 5)

    port map (
                Clk             =>  Bus_clk,
                Rst             =>  cs_rnw_rst,
                Load_In         =>  ZERO_LOAD,
                Count_Enable    =>  valid_addr_cntr_ce,
                Count_Load      =>  '0',
                Count_Down      =>  Addr_ack,
                Count_Out       =>  valid_addr_cnt,
                Carry_Out       =>  open
             );

wrbuf_addrcnt_en_i <= '0' when (valid_addr_cnt = "00000" and wrbuf_rnw_i = '0')
                    else '1';

wrbuf_addrcntr_rst_i  <= '1'
                    when ( (valid_addr_cnt = "00001" and Addr_Ack = '1'
                            and valid_addr_cntr_ce ='1')
                            or Bus_reset = '1' )
                    else '0';


WRBUF_ADDRVALID_REG: process (Bus_clk)
begin
    if Bus_clk'event and Bus_clk = '1' then
        if (wrbuf_addrcntr_rst_i = '1'  and wrbuf_rnw_i = '0')
        or (wrbuf_rnw_i = '1' and Addr_ack = '1' and wrbuf_burst_i ='0') then
            wrbuf_addrvalid_i <= '0';
        elsif xfer_start = '1' then
            wrbuf_addrvalid_i <= '1';
        end if;
    end if;
end process WRBUF_ADDRVALID_REG;

WrBuf_AddrValid <= wrbuf_addrvalid_i when or_reduce(wrbuf_cs_i) = '1'
            else    '0';
-------------------------------------------------------------------------------
-- Sample and hold Bus2IP_CS, Bus2IP_Burst and Bus2IP_RNW until write buffer is
-- empty and Ack is received from the IP since the OPB Address, SeqAddr, and RNW
-- signals will be modified for the next transaction
--
-- Delay CEs by 1 clock to account for buffer delay
-------------------------------------------------------------------------------
XFER_START_REG_PROCESS: process(Bus_clk)
begin
    if Bus_clk'event and Bus_clk = '1' then
        if or_reduce(CS_enable) = '1' then
            xfer_start_reg <= '0';
        elsif xfer_start = '1' then
            xfer_start_reg <= '1';
        end if;
    end if;
end process XFER_START_REG_PROCESS;

sample_hold_ce <= ((xfer_start or xfer_start_reg) and wrbuf_empty_i);


DELAY_REG: process (Bus_clk)
begin
    if Bus_clk'event and Bus_clk = '1' then
            wrbuf_empty_d1  <= wrbuf_empty_i;
            wrdata_ack_d1   <= Wrdata_ack;
            wrbuf_write_d1  <= wrbuf_write;
            burst_d1        <= Burst; --GB
    end if;
end process  DELAY_REG;

cs_rnw_rst <= Bus_reset or
              (not(wrbuf_rnw_i) and wrbuf_going_empty and wrdata_ack ) or
              (wrbuf_rnw_i and Xfer_done);

wrbuf_empty_fe <= not(wrbuf_empty_i) and wrbuf_empty_d1;
wrbuf_write_re <= wrbuf_write and not(wrbuf_write_d1);

BURST_RNW_SAMPLE_HOLD: process (Bus_clk)
begin
    if Bus_clk'event and Bus_clk='1' then
        if cs_rnw_rst = '1' then
            wrbuf_rnw_i     <= '0';
            wrbuf_burst_i   <= '0';
        elsif sample_hold_ce = '1' then
            wrbuf_rnw_i     <= RNW;
            wrbuf_burst_i   <= Burst;
        end if;
    end if;
end process BURST_RNW_SAMPLE_HOLD;

-- Logic for negating burst signal 1 clock before end of cycle.
wrbuf2ip_burst <= wrbuf_burst_i when cs_rnw_rst='0' and or_reduce(wrbuf_cs_i) = '1'
            else '0';

----------------------------------------------------------------------
-- Bus2IP Control Signals
----------------------------------------------------------------------
-- Generate for no output pipeline stage
GEN_WITHOUT_OUTPIPE : if C_INCLUDE_OPBOUT_PSTAGE = false generate
    CS_SAMPLE_HOLD: process (Bus_clk)
    begin
        if Bus_clk'event and Bus_clk='1' then
            if cs_rnw_rst = '1' then
                wrbuf_cs_i      <= (others => '0');
                wrbuf_wrce_i    <= (others => '0');
                wrbuf_rdce_i    <= (others => '0');
                wrbuf_ce_i      <= (others => '0');
            elsif wrbuf_write_re = '1' or
                (sample_hold_ce = '1' and RNW = '1') then
                wrbuf_cs_i      <= CS;
                wrbuf_wrce_i    <= Wr_CE;
                wrbuf_rdce_i    <= Rd_CE;
                wrbuf_ce_i      <= CE;
            end if;
        end if;
    end process CS_SAMPLE_HOLD;
end generate GEN_WITHOUT_OUTPIPE;


-- Generate for output pipeline stage
GEN_WITH_OUTPIPE : if C_INCLUDE_OPBOUT_PSTAGE = true generate
signal read_rdce_i          : std_logic_vector(0 to C_NUM_CES-1);
signal read_cs_i            : std_logic_vector(0 to C_NUM_ARDS-1);
signal read_ce_i            : std_logic_vector(0 to C_NUM_CES-1);
signal write_cs_i           : std_logic_vector(0 to C_NUM_ARDS-1);
signal write_ce_i           : std_logic_vector(0 to C_NUM_CES-1);
begin
    WRCS_SAMPLE_HOLD: process (Bus_clk)
    begin
        if Bus_clk'event and Bus_clk='1' then
            if cs_rnw_rst = '1' then
                write_cs_i      <= (others => '0');
                wrbuf_wrce_i    <= (others => '0');
                write_ce_i      <= (others => '0');
            elsif wrbuf_write_re = '1' then
                write_cs_i      <= CS;
                wrbuf_wrce_i    <= Wr_CE;
                write_ce_i      <= CE;
            end if;
        end if;
    end process WRCS_SAMPLE_HOLD;

    RDCS_SAMPLE_HOLD: process (Bus_clk)
    begin
        if Bus_clk'event and Bus_clk='1' then
            if cs_rnw_rst = '1' then
                read_cs_i      <= (others => '0');
                read_rdce_i    <= (others => '0');
                read_ce_i      <= (others => '0');
            elsif sample_hold_ce = '1' and RNW = '1' then
                read_cs_i      <= CS;
                read_rdce_i    <= Rd_CE;
                read_ce_i      <= CE;
            end if;
        end if;
    end process RDCS_SAMPLE_HOLD;

-- Gate off rdce signal to make it a single clock cycle during single beat reads
GEN_RDCE_BUS : process(read_rdce_i, Xfer_done, wrbuf_burst_i)
    begin
        for i in 0 to C_NUM_CES-1 loop
            wrbuf_rdce_i(i) <= (read_rdce_i(i) and wrbuf_burst_i)
                            or (read_rdce_i(i) and not(wrbuf_burst_i) and not Xfer_done);
        end loop;
    end process GEN_RDCE_BUS;

-- Gate off ce signal to make it a single clock cycle during single beat reads
GEN_CE_BUS : process(write_ce_i,read_ce_i, Xfer_done, wrbuf_burst_i)
    begin
        for i in 0 to C_NUM_CES-1 loop
            wrbuf_ce_i(i) <=   (read_ce_i(i) and wrbuf_burst_i)
                            or (read_ce_i(i) and not(wrbuf_burst_i) and not Xfer_done)
                            or write_ce_i(i);
        end loop;
    end process GEN_CE_BUS;

-- Gate off cs signal to make it a single clock cycle during single beat reads
GEN_CS_BUS : process(write_cs_i,read_cs_i, Xfer_done, wrbuf_burst_i)
    begin
        for i in 0 to C_NUM_ARDS-1 loop
            wrbuf_cs_i(i) <=   (read_cs_i(i) and wrbuf_burst_i)
                            or (read_cs_i(i) and not(wrbuf_burst_i) and not Xfer_done)
                            or write_cs_i(i);
        end loop;
    end process GEN_CS_BUS;



end generate GEN_WITH_OUTPIPE;

-------------------------------------------------------------------------------
-- Logic when IPIC_PSTAGE is included
-------------------------------------------------------------------------------
IPIC_PSTAGE_GEN: if C_INCLUDE_IPIC_PSTAGE generate
    IPIC_Pstage_CE <= not(wrbuf_empty_i);
end generate IPIC_PSTAGE_GEN;

NO_IPIC_PSTAGE_GEN: if not(C_INCLUDE_IPIC_PSTAGE) generate
    IPIC_Pstage_CE <= '1';
end generate NO_IPIC_PSTAGE_GEN;


end implementation;

